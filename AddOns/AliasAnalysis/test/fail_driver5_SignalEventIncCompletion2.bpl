procedure corral_nondet() returns (x:int);
procedure boogie_si_record_li2bpl_int(x:int);
var alloc: int;
procedure {:allocator} __HAVOC_malloc(size:int) returns (ret: int);
   modifies alloc;
   free requires size >= 0;
   free ensures ret == old(alloc);
   free ensures alloc >= old(alloc) + size;

procedure {:allocator "full"} __HAVOC_malloc_or_null(size:int) returns (ret: int);
   modifies alloc;
   free requires size >= 0;
   free ensures (ret == old(alloc)) || (ret == 0);
   free ensures alloc >= old(alloc) + size;

function BAND(a:int, b:int) : int;
function BOR(a:int, b:int) : int;
function BNOT(a:int) : int;
function INTDIV(a:int, b:int) : int;
function INTMOD(a:int, b:int) : int;

// ---- Globals -----
var ClfsContainerInactive:int;
var ClsContainerInactive:int;
var ClsContainerPendingArchive:int;
var CLFS_SCAN_INIT:int;
var CLFS_SCAN_BACKWARD:int;
var ClsContainerInitializing:int;
var ClsContainerPendingArchiveAndDelete:int;
var CLFS_SCAN_CLOSE:int;
var ClsContainerActivePendingDelete:int;
var ClfsContainerPendingArchive:int;
var ClfsContainerInitializing:int;
var ClfsDataRecord:int;
var ClsContainerActive:int;
var CLFS_SCAN_INITIALIZED:int;
var CLFS_SCAN_BUFFERED:int;
var ClfsNullRecord:int;
var CLFS_MAX_CONTAINER_INFO:int;
var ClfsContainerActivePendingDelete:int;
var ClfsContainerPendingArchiveAndDelete:int;
var ClfsClientRecord:int;
var CLFS_SCAN_FORWARD:int;
var ClfsRestartRecord:int;
var ClfsContainerActive:int;
var sdv_start_irp_already_issued:int;
var sdv_p_devobj_fdo:int;
var sdv_IoBuildAsynchronousFsdRequest_harnessIrp:int;
var sdv_IoInitializeIrp_irp:int;
var sdv_IoCreateSynchronizationEvent_KEVENT:int;
var sdv_irql_current:int;
var sdv_dpc_io_registered:int;
var sdv_IoBuildAsynchronousFsdRequest_irp:int;
var sdv_devobj_pdo:int;
var sdv_ControllerPirp:int;
var sdv_IoBuildSynchronousFsdRequest_IoStatusBlock:int;
var sdv_start_info:int;
var sdv_harnessDeviceExtension:int;
var sdv_ke_dpc:int;
var sdv_other_harnessStackLocation:int;
var sdv_ControllerIrp:int;
var sdv_other_harnessIrp:int;
var sdv_other_harnessStackLocation_next:int;
var sdv_end_info:int;
var sdv_irql_previous:int;
var sdv_isr_routine:int;
var sdv_PowerIrp:int;
var sdv_kinterrupt_val:int;
var sdv_p_devobj_child_pdo:int;
var sdv_power_irp:int;
var sdv_irp:int;
var igdoe:int;
var sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX:int;
var sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next:int;
var sdv_maskedEflags:int;
var sdv_StartIopirp:int;
var sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT:int;
var sdv_harnessStackLocation:int;
var sdv_devobj_fdo:int;
var sdv_dpc_ke_registered:int;
var sdv_MapRegisterBase:int;
var sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock:int;
var sdv_invoke_on_cancel:int;
var sdv_irql_previous_3:int;
var sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next:int;
var sdv_DpcContext:int;
var sdv_IoCreateController_CONTROLLER_OBJECT:int;
var sdv_StartIoIrp:int;
var sdv_irql_previous_2:int;
var sdv_IoMakeAssociatedIrp_irp:int;
var sdv_IoBuildSynchronousFsdRequest_irp:int;
var sdv_compFset:int;
var sdv_p_devobj_top:int;
var sdv_context:int;
var sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock:int;
var sdv_invoke_on_error:int;
var sdv_IoBuildDeviceIoControlRequest_IoStatusBlock:int;
var sdv_harnessDeviceExtension_two:int;
var sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock:int;
var sdv_other_irp:int;
var sicrni:int;
var sdv_devobj_child_pdo:int;
var sdv_kdpc3:int;
var sdv_kinterrupt:int;
var sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING:int;
var sdv_io_dpc:int;
var sdv_io_create_device_called:int;
var sdv_Io_Removelock_release_wait_returned:int;
var sdv_MmMapIoSpace_int:int;
var sdv_harnessStackLocation_next:int;
var sdv_pDpcContext:int;
var sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next:int;
var sdv_fx_dev_object:int;
var sdv_IoBuildDeviceIoControlRequest_harnessIrp:int;
var sdv_IoBuildSynchronousFsdRequest_harnessIrp:int;
var sdv_p_devobj_pdo:int;
var sdv_alloc_dummy:int;
var sdv_IoInitializeIrp_harnessIrp:int;
var sdv_IoGetDeviceToVerify_DEVICE_OBJECT:int;
var sdv_IoMakeAssociatedIrp_harnessIrp:int;
var sdv_harnessIrp:int;
var p_sdv_fx_dev_object:int;
var sdv_devobj_top:int;
var sdv_invoke_on_success:int;
var WHEA_ERROR_PACKET_SECTION_GUID:int;
var sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT:int;
var sdv_remove_irp_already_issued:int;
var sdv_IoBuildDeviceIoControlRequest_irp:int;
var sdv_IoCreateNotificationEvent_KEVENT:int;
var sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock:int;
var sdv_MapRegisterBase_val:int;
var sdv_kdpc_val3:int;
var sdv_inside_init_entrypoint:int;
var sdv_apc_disabled:int;
var sdv_IoGetDmaAdapter_DMA_ADAPTER:int;
var SignalState:int;
var SLAM_guard_O_0:int;
var yogi_error:int;
var SLAM_guard_O_0_init:int;
var sdv_cancelFptr:int;
var yogi:int;
// ----- Procedures -------
procedure {:origName "sdv_hash_673466734"} sdv_hash_673466734(actual_Memory:int) {
var  Tmp: int;
var  Tmp_1: int;
var  Memory: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Memory := actual_Memory;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 74} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "Memory"} boogie_si_record_li2bpl_int(Memory);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 70} {:print "Atomic Conditional"}  true;
    if(*) { assume (Memory == 0);  goto L1; } else { assume (Memory != 0);  goto L4; }
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 72} {:print "Call \"operator delete[]\" \"sdv_ExFreePool\""}  true;
  call sdv_ExFreePool( 0);   goto L1;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_hash_904910103_sdv_special_CTOR"} sdv_hash_904910103_sdv_special_CTOR(actual_this:int, actual_Size:int) {
var  sdv: int;
var  Tmp_2: int;
var  Tmp_3: int;
var  Tmp_4: int;
var  this: int;
var  Size: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  this := actual_this;
  Size := actual_Size;
  // done with preamble
  goto L11;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "Size"} boogie_si_record_li2bpl_int(Size);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 148} {:print "Atomic Assignment"}  true;
      Tmp_4 := (Size * 4);  goto L13;
L7:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 148} {:print "Atomic Assignment"}  true;
    assume this > 0;
    Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this)] := sdv;  goto L14;
L11:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L13:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_4);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 148} {:print "Call \"BAG<DEVICE_DATA *>::BAG<DEVICE_DATA *>\" \"operator new[]\""}  true;
  call sdv := sdv_hash_445969321( Tmp_4, 1);   goto L7;
L14:
  call {:cexpr "Size"} boogie_si_record_li2bpl_int(Size);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 149} {:print "Atomic Assignment"}  true;
    assume this > 0;
    Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(this)] := Size;  goto L15;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 150} {:print "Atomic Assignment"}  true;
    assume this > 0;
    Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this)] := 0;  goto L16;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 151} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_874085766"} sdv_hash_874085766(actual_Memory_1:int) {
var  Tmp_5: int;
var  Tmp_6: int;
var  Memory_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Memory_1 := actual_Memory_1;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 64} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "Memory"} boogie_si_record_li2bpl_int(Memory_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 60} {:print "Atomic Conditional"}  true;
    if(*) { assume (Memory_1 == 0);  goto L1; } else { assume (Memory_1 != 0);  goto L4; }
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 62} {:print "Call \"operator delete\" \"sdv_ExFreePool\""}  true;
  call sdv_ExFreePool( 0);   goto L1;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_hash_597892090_sdv_special_CTOR"} sdv_hash_597892090_sdv_special_CTOR(actual_this_1:int, actual_Size_1:int) {
var  Tmp_7: int;
var  Tmp_8: int;
var  this_1: int;
var  Size_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  this_1 := actual_this_1;
  Size_1 := actual_Size_1;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 215} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_hash_925174249_DEVICE_DATA_BAG(this_1));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Size_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 215} {:print "Call \"DEVICE_DATA_BAG::DEVICE_DATA_BAG\" \"BAG<DEVICE_DATA *>::BAG<DEVICE_DATA *>\""}  true;
  assume this_1 > 0;
  call sdv_hash_904910103_sdv_special_CTOR( sdv_hash_925174249_DEVICE_DATA_BAG(this_1), Size_1);   goto L1;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_hash_233701977_sdv_special_DTOR"} sdv_hash_233701977_sdv_special_DTOR(actual_this_2:int) {
var  spinLock: int;
var  Tmp_9: int;
var  Tmp_10: int;
var  oldIrql: int;
var  Tmp_11: int;
var  this_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  this_2 := actual_this_2;
  // done with preamble
  goto L24;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 169} {:print "Return"}  true;
    goto LM2;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 156} {:print "Atomic Assignment"}  true;
      spinLock := 0;  goto L26;
L10:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_10 := __HAVOC_malloc(4);  goto L23;
L13:
  call {:cexpr "this->pitems"} boogie_si_record_li2bpl_int(Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 165} {:print "Atomic Conditional"}  true;
    if(*) { assume this_2 > 0;
  assume (Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_2)] == 0);  goto L1; } else { assume this_2 > 0;
  assume (Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_2)] != 0);  goto L14; }
L14:
  call {:cexpr "this->pitems"} boogie_si_record_li2bpl_int(Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 167} {:print "Atomic Assignment"}  true;
    assume this_2 > 0;
    Tmp_11 := Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_2)];  goto L32;
L20:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_10]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_10 > 0;
    spinLock := Mem_T.INT4[Tmp_10];  goto L29;
L21:
  call {:cexpr "spinLock"} boogie_si_record_li2bpl_int(spinLock);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_10 > 0;
    Mem_T.INT4[Tmp_10] := spinLock;  goto L28;
L22:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_10]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_10 > 0;
    oldIrql := Mem_T.INT4[Tmp_10];  goto L31;
L23:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_10 > 0;
    Mem_T.INT4[Tmp_10] := oldIrql;  goto L30;
L24:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L26:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 157} {:print "Atomic Assignment"}  true;
      oldIrql := 0;  goto L27;
L27:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_10 := __HAVOC_malloc(4);  goto L21;
L28:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_10);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 162} {:print "Call \"BAG<DEVICE_DATA *>::~BAG<DEVICE_DATA *>\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_10);   goto L20;
L29:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L10;
L30:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_10);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 163} {:print "Call \"BAG<DEVICE_DATA *>::~BAG<DEVICE_DATA *>\" \"sdv_KeAcquireSpinLock\""}  true;
  call sdv_KeAcquireSpinLock( 0, Tmp_10);   goto L22;
L31:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L13;
L32:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 167} {:print "Call \"BAG<DEVICE_DATA *>::~BAG<DEVICE_DATA *>\" \"operator delete[]\""}  true;
  call sdv_hash_673466734( Tmp_11);   goto L1;
Lfinal: return;
}
procedure {:origName "sdv_hash_290835794"} sdv_hash_290835794(actual_this_3:int, actual_Index:int) returns (Tmp_12:int) {
var  Tmp_13: int;
var  Tmp_14: int;
var  Tmp_15: int;
var  this_3: int;
var  Index: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  this_3 := actual_this_3;
  Index := actual_Index;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 201} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "this->currentsize"} boogie_si_record_li2bpl_int(Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_3)]);
  call {:cexpr "Index"} boogie_si_record_li2bpl_int(Index);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 195} {:print "Atomic Conditional"}  true;
    if(*) { assume this_3 > 0;
  assume ((Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_3)] - 1) >= Index);  goto L4; } else { assume this_3 > 0;
  assume ((Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_3)] - 1) < Index);  goto L5; }
L4:
  call {:cexpr "Index"} boogie_si_record_li2bpl_int(Index);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 200} {:print "Atomic Assignment"}  true;
      Tmp_14 := Index;  goto L10;
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 197} {:print "Atomic Assignment"}  true;
      Tmp_12 := 0;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L10:
  call {:cexpr "this->pitems"} boogie_si_record_li2bpl_int(Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 200} {:print "Atomic Assignment"}  true;
    assume this_3 > 0;
    Tmp_15 := Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_3)];  goto L11;
L11:
  call {:cexpr "*(Tmp + (Tmp * 4))"} boogie_si_record_li2bpl_int(Mem_T.PDEVICE_DATA[(Tmp_15 + (Tmp_14 * 4))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 200} {:print "Atomic Assignment"}  true;
    assume Tmp_15 > 0;
    Tmp_12 := Mem_T.PDEVICE_DATA[(Tmp_15 + (Tmp_14 * 4))];  goto L12;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_hash_309625472"} sdv_hash_309625472(actual_this_4:int, actual_Item:int) returns (Tmp_16:int) {
var  Tmp_17: int;
var  spinLock_1: int;
var  Tmp_18: int;
var  Tmp_19: int;
var  oldIrql_1: int;
var  this_4: int;
var  Item: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  this_4 := actual_this_4;
  Item := actual_Item;
  // done with preamble
  goto L25;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 190} {:print "Return"}  true;
    goto LM2;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 174} {:print "Atomic Assignment"}  true;
      spinLock_1 := 0;  goto L27;
L10:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_17 := __HAVOC_malloc(4);  goto L24;
L13:
  call {:cexpr "this->capacity"} boogie_si_record_li2bpl_int(Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(this_4)]);
  call {:cexpr "this->currentsize"} boogie_si_record_li2bpl_int(Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 180} {:print "Atomic Conditional"}  true;
    if(*) { assume this_4 > 0;
  assume (Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(this_4)] > Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)]);  goto L14; } else { assume this_4 > 0;
  assume (Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(this_4)] <= Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)]);  goto L15; }
L14:
  call {:cexpr "this->currentsize"} boogie_si_record_li2bpl_int(Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 185} {:print "Atomic Assignment"}  true;
    assume this_4 > 0;
    Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)] := (Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)] + 1);  goto L34;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 182} {:print "Atomic Assignment"}  true;
      Tmp_16 := -1073741789;  goto L33;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 189} {:print "Atomic Assignment"}  true;
      Tmp_16 := 0;  goto L38;
L21:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_17]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_17 > 0;
    spinLock_1 := Mem_T.INT4[Tmp_17];  goto L30;
L22:
  call {:cexpr "spinLock"} boogie_si_record_li2bpl_int(spinLock_1);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_17 > 0;
    Mem_T.INT4[Tmp_17] := spinLock_1;  goto L29;
L23:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_17]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_17 > 0;
    oldIrql_1 := Mem_T.INT4[Tmp_17];  goto L32;
L24:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql_1);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_17 > 0;
    Mem_T.INT4[Tmp_17] := oldIrql_1;  goto L31;
L25:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L27:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 175} {:print "Atomic Assignment"}  true;
      oldIrql_1 := 0;  goto L28;
L28:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_17 := __HAVOC_malloc(4);  goto L22;
L29:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_17);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 177} {:print "Call \"BAG<DEVICE_DATA *>::Insert\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_17);   goto L21;
L30:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L10;
L31:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_17);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 178} {:print "Call \"BAG<DEVICE_DATA *>::Insert\" \"sdv_KeAcquireSpinLock\""}  true;
  call sdv_KeAcquireSpinLock( 0, Tmp_17);   goto L23;
L32:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L13;
L33:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L34:
  call {:cexpr "this->currentsize"} boogie_si_record_li2bpl_int(Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 185} {:print "Atomic Assignment"}  true;
    assume this_4 > 0;
    Tmp_19 := Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)];  goto L35;
L35:
  call {:cexpr "this->pitems"} boogie_si_record_li2bpl_int(Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 185} {:print "Atomic Assignment"}  true;
    assume this_4 > 0;
    Tmp_18 := Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_4)];  goto L36;
L36:
  call {:cexpr "Item"} boogie_si_record_li2bpl_int(Item);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 185} {:print "Atomic Assignment"}  true;
    assume Tmp_18 > 0;
    Mem_T.PDEVICE_DATA[(Tmp_18 + (Tmp_19 * 4))] := Item;  goto L37;
L37:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(oldIrql_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 187} {:print "Call \"BAG<DEVICE_DATA *>::Insert\" \"sdv_KeReleaseSpinLock\""}  true;
  call sdv_KeReleaseSpinLock( 0, oldIrql_1);   goto L19;
L38:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_hash_113115260"} sdv_hash_113115260(actual_this_5:int) {
var  sdv_1: int;
var  sdv_2: int;
var  Tmp_20: int;
var  Tmp_21: int;
var  Tmp_22: int;
var  i: int;
var  time: int;
var  newItem: int;
var  Tmp_23: int;
var  this_5: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call time := __HAVOC_malloc(20);
  // initialize local variables to 0
  // copy formal-ins to locals
  this_5 := actual_this_5;
  // done with preamble
  goto L29;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 255} {:print "Return"}  true;
    goto LM2;
L6:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 245} {:print "Atomic Assignment"}  true;
      newItem := 0;  goto L31;
L9:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i);
  call {:cexpr "this->sdv_hash_925174249.capacity"} boogie_si_record_li2bpl_int(Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_5))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 247} {:print "Atomic Conditional"}  true;
    if(*) { assume this_5 > 0;
  assume (i >= Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_5))]);  goto L1; } else { assume this_5 > 0;
  assume (i < Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_5))]);  goto L10; }
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 249} {:print "Atomic Continuation"}  true;
    goto L13;
L13:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(8);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Call \"DEVICE_DATA_BAG::PopulateBag\" \"operator new\""}  true;
  call sdv_2 := sdv_hash_190378497( 8, 1);   goto L16;
L16:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Atomic Assignment"}  true;
      Tmp_23 := sdv_2;  goto L33;
L18:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_23);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Atomic Assignment"}  true;
      newItem := Tmp_23;  goto L36;
L19:
  call {:cexpr "time.QuadPart"} boogie_si_record_li2bpl_int(Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(time)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Atomic Assignment"}  true;
    assume time > 0;
    Tmp_21 := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(time)];  goto L35;
L26:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 247} {:print "Atomic Assignment"}  true;
      i := (i + 1);  goto L37;
L29:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L31:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 247} {:print "Atomic Assignment"}  true;
      i := 0;  goto L32;
L32:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L9;
L33:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Atomic Assignment"}  true;
    assume Tmp_23 > 0;
    Mem_T.sdv_derived_object_DEVICE_DATA[sdv_derived_object_DEVICE_DATA(Tmp_23)] := 0;  goto L34;
L34:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_23);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Atomic Conditional"}  true;
    if(*) { assume (Tmp_23 == 0);  goto L18; } else { assume (Tmp_23 != 0);  goto L19; }
L35:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_23);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_21);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(512);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Call \"DEVICE_DATA_BAG::PopulateBag\" \"DEVICE_DATA::DEVICE_DATA\""}  true;
  call sdv_hash_346367737_sdv_special_CTOR( Tmp_23, Tmp_21, 512);   goto L18;
L36:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_hash_925174249_DEVICE_DATA_BAG(this_5));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(newItem);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 253} {:print "Call \"DEVICE_DATA_BAG::PopulateBag\" \"BAG<DEVICE_DATA *>::Insert\""}  true;
  assume this_5 > 0;
  call sdv_1 := sdv_hash_309625472( sdv_hash_925174249_DEVICE_DATA_BAG(this_5), newItem);   goto L26;
L37:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L9;
Lfinal: return;
}
procedure {:origName "sdv_hash_231029696"} sdv_hash_231029696(actual_Irp:int, actual_Data:int) returns (Tmp_24:int) {
var  Tmp_25: int;
var  Tmp_26: int;
var  Irp: int;
var  Data: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Irp := actual_Irp;
  Data := actual_Data;
  // done with preamble
  goto L6;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 403} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    Tmp_26 := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))];  goto L8;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L8:
  call {:cexpr "*Data"} boogie_si_record_li2bpl_int(Mem_T.INT4[Data]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 403} {:print "Atomic Assignment"}  true;
    assume Tmp_26 > 0;
  assume Data > 0;
    Mem_T.INT4[Tmp_26] := Mem_T.INT4[Data];  goto L9;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 405} {:print "Atomic Assignment"}  true;
      Tmp_24 := 0;  goto L10;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 405} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_89676855"} sdv_hash_89676855(actual_this_6:int) returns (Tmp_27:int) {
var  Tmp_28: int;
var  this_6: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  this_6 := actual_this_6;
  // done with preamble
  goto L5;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "this->Data"} boogie_si_record_li2bpl_int(Mem_T.Data_DEVICE_DATA[Data_DEVICE_DATA(this_6)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 90} {:print "Atomic Assignment"}  true;
    assume this_6 > 0;
    Tmp_27 := Mem_T.Data_DEVICE_DATA[Data_DEVICE_DATA(this_6)];  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 90} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_802080270"} sdv_hash_802080270(actual_DeviceObject:int, actual_Irp_1:int) returns (Tmp_29:int) {
var  sdv_3: int;
var  sdv_4: int;
var  sdv_5: int;
var  sdv_6: int;
var  sdv_7: int;
var  sdv_8: int;
var  {:dopa}  ulongData: int;
var  sdv_9: int;
var  stack: int;
var  sdv_10: int;
var  sdv_11: int;
var  Tmp_30: int;
var  sdv_12: int;
var  status: int;
var  Tmp_31: int;
var  extension: int;
var  deviceDataItem: int;
var  Tmp_32: int;
var  waitEvent: int;
var  {:dopa}  longData: int;
var  sdv_13: int;
var  sdv_14: int;
var  resource: int;
var  timeout: int;
var  DeviceObject: int;
var  Irp_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call ulongData := __HAVOC_malloc(4);
  call waitEvent := __HAVOC_malloc(108);
  call longData := __HAVOC_malloc(4);
  call resource := __HAVOC_malloc(8);
  call timeout := __HAVOC_malloc(20);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject := actual_DeviceObject;
  Irp_1 := actual_Irp_1;
  // done with preamble
  goto L125;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 214} {:print "Return"}  true;
    goto LM2;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 121} {:print "Atomic Assignment"}  true;
      status := 0;  goto L127;
L25:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 133} {:print "Atomic Assignment"}  true;
    assume DeviceObject > 0;
    extension := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject)];  goto L137;
L30:
  call {:cexpr "stack->Parameters.Read.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(stack)))]);
  call {:cexpr "extension->DataSize"} boogie_si_record_li2bpl_int(Mem_T.DataSize__DRIVER_DEVICE_EXTENSION[DataSize__DRIVER_DEVICE_EXTENSION(extension)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 137} {:print "Atomic Conditional"}  true;
    if(*) { assume stack > 0;
  assume extension > 0;
  assume (Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(stack)))] >= Mem_T.DataSize__DRIVER_DEVICE_EXTENSION[DataSize__DRIVER_DEVICE_EXTENSION(extension)]);  goto L31; } else { assume stack > 0;
  assume extension > 0;
  assume (Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(stack)))] < Mem_T.DataSize__DRIVER_DEVICE_EXTENSION[DataSize__DRIVER_DEVICE_EXTENSION(extension)]);  goto L34; }
L31:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(12);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Call \"DispatchRead\" \"operator new\""}  true;
  call sdv_8 := sdv_hash_190378497( 12, 1);   goto L41;
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 139} {:print "Atomic Assignment"}  true;
      status := -1073741789;  goto L138;
L40:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 142} {:print "Atomic Assignment"}  true;
      Tmp_29 := status;  goto L141;
L41:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Assignment"}  true;
      Tmp_32 := sdv_8;  goto L142;
L43:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_32);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Assignment"}  true;
    assume extension > 0;
    Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)] := Tmp_32;  goto L145;
L44:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_32);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Call \"DispatchRead\" \"DEVICE_DATA_BAG::DEVICE_DATA_BAG\""}  true;
  call sdv_hash_597892090_sdv_special_CTOR( Tmp_32, 1);   goto L43;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 151} {:print "Atomic Assignment"}  true;
      status := -1073741670;  goto L154;
L49:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 159} {:print "Call \"DispatchRead\" \"DEVICE_DATA_BAG::PopulateBag\""}  true;
  assume extension > 0;
  call sdv_hash_113115260( Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)]);   goto L52;
L52:
  call {:cexpr "extension->deviceData"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 160} {:print "Atomic Assignment"}  true;
    assume extension > 0;
    Tmp_30 := Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)];  goto L146;
L56:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(deviceDataItem);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 161} {:print "Call \"DispatchRead\" \"DEVICE_DATA::GetData\""}  true;
  assume longData > 0;
  call boogieTmp := sdv_hash_89676855( deviceDataItem); Mem_T.INT4[longData] := boogieTmp;  goto L60;
L60:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(deviceDataItem);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 162} {:print "Call \"DispatchRead\" \"DEVICE_DATA::GetData\""}  true;
  call sdv_5 := sdv_hash_89676855( deviceDataItem);   goto L63;
L63:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 162} {:print "Atomic Assignment"}  true;
    assume ulongData > 0;
    Mem_T.INT4[ulongData] := sdv_5;  goto L147;
L68:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 166} {:print "Atomic Assignment"}  true;
    assume resource > 0;
    Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(resource)] := sdv_4;  goto L148;
L72:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 170} {:print "Call \"DispatchRead\" \"KeEnterCriticalRegion\""}  true;
  call KeEnterCriticalRegion();   goto L75;
L75:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 172} {:print "Call \"DispatchRead\" \"ExAcquireResourceExclusiveLite\""}  true;
  assume resource > 0;
  call boogieTmp := ExAcquireResourceExclusiveLite( 0, 0); Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(resource)] := boogieTmp;  goto L79;
L79:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 174} {:print "Call \"DispatchRead\" \"KeLeaveCriticalRegion\""}  true;
  call KeLeaveCriticalRegion();   goto L82;
L82:
  call {:cexpr "resource.Acquired"} boogie_si_record_li2bpl_int(Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(resource)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 176} {:print "Atomic Conditional"}  true;
    if(*) { assume resource > 0;
  assume (Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(resource)] == 0);  goto L83; } else { assume resource > 0;
  assume (Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(resource)] != 0);  goto L86; }
L83:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(longData);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(resource)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 182} {:print "Call \"DispatchRead\" \"ReadFromDevice\""}  true;
  assume resource > 0;
  call sdv_13 := sdv_hash_232712213( Irp_1, longData, Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(resource)]);   goto L89;
L86:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(ulongData);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 178} {:print "Call \"DispatchRead\" \"ReadFromDevice\""}  true;
  call sdv_12 := sdv_hash_231029696( Irp_1, ulongData);   goto L89;
L89:
  call {:cexpr "&waitEvent"} boogie_si_record_li2bpl_int(waitEvent);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      SLAM_guard_O_0 := waitEvent;  goto L149;
L92:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 187} {:print "Call \"DispatchRead\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_1);   goto L95;
L95:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(208);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(waitEvent);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 188} {:print "Call \"DispatchRead\" \"sdv_IoSetCompletionRoutine\""}  true;
  call sdv_IoSetCompletionRoutine( Irp_1, 208, waitEvent, 1, 1, 1);   goto L151;
L98:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 190} {:print "Call \"DispatchRead\" \"sdv_IoCallDriver\""}  true;
  assume extension > 0;
  call status := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension)], Irp_1);   goto L102;
L102:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 192} {:print "Atomic Conditional"}  true;
    if(*) { assume (status != 259);  goto L103; } else { assume (status == 259);  goto L104; }
L103:
  call {:cexpr "resource.Resource"} boogie_si_record_li2bpl_int(Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(resource)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 208} {:print "Atomic Conditional"}  true;
    if(*) { assume resource > 0;
  assume (Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(resource)] == 0);  goto L108; } else { assume resource > 0;
  assume (Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(resource)] != 0);  goto L109; }
L104:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(timeout);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 194} {:print "Call \"DispatchRead\" \"KeWaitForSingleObject\""}  true;
  call sdv_10 := KeWaitForSingleObject( 0, 0, 0, 0, timeout);   goto L107;
L107:
  call {:cexpr "Irp->IoStatus.Status"} boogie_si_record_li2bpl_int(Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 205} {:print "Atomic Assignment"}  true;
    assume Irp_1 > 0;
    status := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))];  goto L152;
L108:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 213} {:print "Atomic Assignment"}  true;
      Tmp_29 := status;  goto L153;
L109:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(-731814095);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 210} {:print "Call \"DispatchRead\" \"ExFreePoolWithTag\""}  true;
  call ExFreePoolWithTag( 0, -731814095);   goto L108;
L117:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 154} {:print "Atomic Assignment"}  true;
      Tmp_29 := status;  goto L157;
L122:
  call {:cexpr "&waitEvent"} boogie_si_record_li2bpl_int(waitEvent);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias1(SLAM_guard_O_0, waitEvent);
    if(*) { assume (!((waitEvent == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init)));  goto L92; } else { assume ((waitEvent == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init));  goto L123; }
L123:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 185} {:print "Call \"DispatchRead\" \"SLIC_KeInitializeEvent_exit\""}  true;
  call SLIC_KeInitializeEvent_exit( 0, 0);   goto L92;
L125:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L127:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 122} {:print "Atomic Assignment"}  true;
      stack := 0;  goto L128;
L128:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 123} {:print "Atomic Assignment"}  true;
      extension := 0;  goto L129;
L129:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 124} {:print "Atomic Assignment"}  true;
    assume waitEvent > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(waitEvent))] := 0;  goto L130;
L130:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 124} {:print "Atomic Assignment"}  true;
    assume waitEvent > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent)))] := 0;  goto L131;
L131:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 124} {:print "Atomic Assignment"}  true;
    assume waitEvent > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent)))] := 0;  goto L132;
L132:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 125} {:print "Atomic Assignment"}  true;
    assume ulongData > 0;
    Mem_T.INT4[ulongData] := 0;  goto L133;
L133:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 126} {:print "Atomic Assignment"}  true;
    assume longData > 0;
    Mem_T.INT4[longData] := 0;  goto L134;
L134:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 127} {:print "Atomic Assignment"}  true;
      deviceDataItem := 0;  goto L135;
L135:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 129} {:print "Atomic Assignment"}  true;
    assume timeout > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(timeout)] := 0;  goto L136;
L136:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 131} {:print "Call \"DispatchRead\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L25;
L137:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 135} {:print "Call \"DispatchRead\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call stack := sdv_IoGetCurrentIrpStackLocation( Irp_1);   goto L30;
L138:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 139} {:print "Atomic Assignment"}  true;
    assume Irp_1 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := status;  goto L139;
L139:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 140} {:print "Atomic Assignment"}  true;
    assume Irp_1 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := 0;  goto L140;
L140:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 141} {:print "Call \"DispatchRead\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L40;
L141:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L142:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Assignment"}  true;
    assume Tmp_32 > 0;
    Mem_T.sdv_derived_object_DEVICE_DATA_BAG[sdv_derived_object_DEVICE_DATA_BAG(Tmp_32)] := 0;  goto L143;
L143:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_32);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Assignment"}  true;
    assume Tmp_32 > 0;
    Mem_T.sdv_derived_object_sdv_hash_925174249[sdv_derived_object_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(Tmp_32))] := Tmp_32;  goto L144;
L144:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_32);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Conditional"}  true;
    if(*) { assume (Tmp_32 == 0);  goto L43; } else { assume (Tmp_32 != 0);  goto L44; }
L145:
  call {:cexpr "extension->deviceData"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 149} {:print "Atomic Conditional"}  true;
    if(*) { assume extension > 0;
  assume (Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)] == 0);  goto L48; } else { assume extension > 0;
  assume (Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)] != 0);  goto L49; }
L146:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_hash_925174249_DEVICE_DATA_BAG(Tmp_30));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 160} {:print "Call \"DispatchRead\" \"BAG<DEVICE_DATA *>::Retrieve\""}  true;
  assume Tmp_30 > 0;
  call deviceDataItem := sdv_hash_290835794( sdv_hash_925174249_DEVICE_DATA_BAG(Tmp_30), 0);   goto L56;
L147:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(512);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(4);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(-731814095);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 166} {:print "Call \"DispatchRead\" \"ExAllocatePoolWithTag\""}  true;
  call sdv_4 := ExAllocatePoolWithTag( 512, 4, -731814095);   goto L68;
L148:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 168} {:print "Call \"DispatchRead\" \"ExInitializeResourceLite\""}  true;
  call sdv_3 := ExInitializeResourceLite( 0);   goto L72;
L149:
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
  assume(SLAM_guard_O_0 != SLAM_guard_O_0_init);   goto L150;
L150:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(waitEvent);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 185} {:print "Call \"DispatchRead\" \"KeInitializeEvent\""}  true;
  call KeInitializeEvent( waitEvent, 0, 0);   goto L122;
L151:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L98; }
L152:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L103;
L153:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L154:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 151} {:print "Atomic Assignment"}  true;
    assume Irp_1 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := status;  goto L155;
L155:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 152} {:print "Atomic Assignment"}  true;
    assume Irp_1 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := 0;  goto L156;
L156:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 153} {:print "Call \"DispatchRead\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L117;
L157:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_hash_346367737_sdv_special_CTOR"} sdv_hash_346367737_sdv_special_CTOR(actual_this_7:int, actual_Data_1:int, actual_Size_2:int) {
var  Tmp_33: int;
var  Tmp_34: int;
var  this_7: int;
var  Data_1: int;
var  Size_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  this_7 := actual_this_7;
  Data_1 := actual_Data_1;
  Size_2 := actual_Size_2;
  // done with preamble
  goto L6;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "Data"} boogie_si_record_li2bpl_int(Data_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 106} {:print "Atomic Assignment"}  true;
    assume this_7 > 0;
    Mem_T.Data_DEVICE_DATA[Data_DEVICE_DATA(this_7)] := Data_1;  goto L8;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L8:
  call {:cexpr "Size"} boogie_si_record_li2bpl_int(Size_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 107} {:print "Atomic Assignment"}  true;
    assume this_7 > 0;
    Mem_T.RequiredBufferLength_DEVICE_DATA[RequiredBufferLength_DEVICE_DATA(this_7)] := Size_2;  goto L9;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 108} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_445969321"} sdv_hash_445969321(actual_Size_3:int, actual_PoolType:int) returns (Tmp_35:int) {
var  sdv_15: int;
var  Tmp_36: int;
var  Size_3: int;
var  PoolType: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Size_3 := actual_Size_3;
  PoolType := actual_PoolType;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 54} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(PoolType);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Size_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 53} {:print "Call \"operator new[]\" \"ExAllocatePool\""}  true;
  call Tmp_35 := ExAllocatePool( PoolType, Size_3);   goto L1;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_hash_211340521"} sdv_hash_211340521(actual_DeviceObject_1:int, actual_Irp_2:int, actual_EventIn:int) returns (Tmp_37:int) {
var  Tmp_38: int;
var  sdv_16: int;
var  Tmp_39: int;
var  extension_1: int;
var  Tmp_40: int;
var  DeviceObject_1: int;
var  Irp_2: int;
var  EventIn: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_1 := actual_DeviceObject_1;
  Irp_2 := actual_Irp_2;
  EventIn := actual_EventIn;
  // done with preamble
  goto L17;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 336} {:print "Atomic Assignment"}  true;
      extension_1 := 0;  goto L19;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 347} {:print "Atomic Assignment"}  true;
      Tmp_37 := 0;  goto L23;
L8:
  call {:cexpr "extension->deviceData"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 344} {:print "Atomic Assignment"}  true;
    assume extension_1 > 0;
    Tmp_38 := Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)];  goto L21;
L11:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_40);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 344} {:print "Call \"CompletionRoutineRead\" \"DEVICE_DATA_BAG::`scalar deleting destructor'\""}  true;
  call sdv_16 := sdv_hash_324714501( Tmp_40, 1);   goto L7;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L19:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 338} {:print "Atomic Assignment"}  true;
    assume DeviceObject_1 > 0;
    extension_1 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_1)];  goto L20;
L20:
  call {:cexpr "extension->deviceData"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 342} {:print "Atomic Conditional"}  true;
    if(*) { assume extension_1 > 0;
  assume (Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)] == 0);  goto L7; } else { assume extension_1 > 0;
  assume (Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)] != 0);  goto L8; }
L21:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_38);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 344} {:print "Atomic Assignment"}  true;
      Tmp_40 := Tmp_38;  goto L22;
L22:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_40);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 344} {:print "Atomic Conditional"}  true;
    if(*) { assume (Tmp_40 == 0);  goto L7; } else { assume (Tmp_40 != 0);  goto L11; }
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 347} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_701990220"} sdv_hash_701990220(actual_DeviceObject_2:int, actual_Irp_3:int) returns (Tmp_41:int) {
var  sdv_17: int;
var  Tmp_42: int;
var  status_1: int;
var  extension_2: int;
var  DeviceObject_2: int;
var  Irp_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_2 := actual_DeviceObject_2;
  Irp_3 := actual_Irp_3;
  // done with preamble
  goto L19;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 103} {:print "Atomic Assignment"}  true;
      status_1 := 0;  goto L21;
L10:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 108} {:print "Call \"DispatchCreate\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_3);   goto L13;
L13:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_2)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 110} {:print "Call \"DispatchCreate\" \"sdv_IoCallDriver\""}  true;
  assume extension_2 > 0;
  call status_1 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_2)], Irp_3);   goto L17;
L17:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 112} {:print "Atomic Assignment"}  true;
      Tmp_41 := status_1;  goto L23;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L21:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 104} {:print "Atomic Assignment"}  true;
    assume DeviceObject_2 > 0;
    extension_2 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_2)];  goto L22;
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 106} {:print "Call \"DispatchCreate\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L10;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 112} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_190378497"} sdv_hash_190378497(actual_Size_4:int, actual_PoolType_1:int) returns (Tmp_43:int) {
var  Tmp_44: int;
var  sdv_18: int;
var  Size_4: int;
var  PoolType_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Size_4 := actual_Size_4;
  PoolType_1 := actual_PoolType_1;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 47} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(PoolType_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Size_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 46} {:print "Call \"operator new\" \"ExAllocatePool\""}  true;
  call Tmp_43 := ExAllocatePool( PoolType_1, Size_4);   goto L1;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_hash_86802341"} sdv_hash_86802341(actual_DeviceObject_3:int, actual_Irp_4:int) returns (Tmp_45:int) {
var  sdv_19: int;
var  sdv_20: int;
var  Tmp_46: int;
var  status_2: int;
var  extension_3: int;
var  waitEvent_1: int;
var  DeviceObject_3: int;
var  Irp_4: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call waitEvent_1 := __HAVOC_malloc(108);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_3 := actual_DeviceObject_3;
  Irp_4 := actual_Irp_4;
  // done with preamble
  goto L42;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 222} {:print "Atomic Assignment"}  true;
      status_2 := 0;  goto L44;
L15:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(waitEvent_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 228} {:print "Call \"DispatchPower\" \"KeInitializeEvent\""}  true;
  call KeInitializeEvent( waitEvent_1, 0, 0);   goto L39;
L18:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 230} {:print "Call \"DispatchPower\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_4);   goto L21;
L21:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_4);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(209);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(waitEvent_1);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 231} {:print "Call \"DispatchPower\" \"sdv_IoSetCompletionRoutine\""}  true;
  call sdv_IoSetCompletionRoutine( Irp_4, 209, waitEvent_1, 1, 1, 1);   goto L49;
L24:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_3)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 233} {:print "Call \"DispatchPower\" \"sdv_IoCallDriver\""}  true;
  assume extension_3 > 0;
  call status_2 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_3)], Irp_4);   goto L28;
L28:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 235} {:print "Atomic Conditional"}  true;
    if(*) { assume (status_2 != 259);  goto L29; } else { assume (status_2 == 259);  goto L32; }
L29:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 247} {:print "Call \"DispatchPower\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L36;
L32:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 237} {:print "Call \"DispatchPower\" \"KeWaitForSingleObject\""}  true;
  call sdv_19 := KeWaitForSingleObject( 0, 0, 0, 0, 0);   goto L35;
L35:
  call {:cexpr "Irp->IoStatus.Status"} boogie_si_record_li2bpl_int(Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_4))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 244} {:print "Atomic Assignment"}  true;
    assume Irp_4 > 0;
    status_2 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_4))];  goto L50;
L36:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 248} {:print "Atomic Assignment"}  true;
      Tmp_45 := status_2;  goto L51;
L39:
  call {:cexpr "&waitEvent"} boogie_si_record_li2bpl_int(waitEvent_1);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
   assume alias2(waitEvent_1, SLAM_guard_O_0);
    if(*) { assume (!((waitEvent_1 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init)));  goto L18; } else { assume ((waitEvent_1 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init));  goto L40; }
L40:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 228} {:print "Call \"DispatchPower\" \"SLIC_KeInitializeEvent_exit\""}  true;
  call SLIC_KeInitializeEvent_exit( 0, 0);   goto L18;
L42:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 223} {:print "Atomic Assignment"}  true;
    assume waitEvent_1 > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(waitEvent_1))] := 0;  goto L45;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 223} {:print "Atomic Assignment"}  true;
    assume waitEvent_1 > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent_1)))] := 0;  goto L46;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 223} {:print "Atomic Assignment"}  true;
    assume waitEvent_1 > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent_1)))] := 0;  goto L47;
L47:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 224} {:print "Atomic Assignment"}  true;
    assume DeviceObject_3 > 0;
    extension_3 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_3)];  goto L48;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 226} {:print "Call \"DispatchPower\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L15;
L49:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L24; }
L50:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L29;
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 248} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_1073447526"} sdv_hash_1073447526(actual_DeviceObject_4:int, actual_Irp_5:int, actual_EventIn_1:int) returns (Tmp_47:int) {
var  Tmp_48: int;
var  sdv_21: int;
var  waitEvent_2: int;
var  DeviceObject_4: int;
var  Irp_5: int;
var  EventIn_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_4 := actual_DeviceObject_4;
  Irp_5 := actual_Irp_5;
  EventIn_1 := actual_EventIn_1;
  // done with preamble
  goto L12;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  call {:cexpr "EventIn"} boogie_si_record_li2bpl_int(EventIn_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 359} {:print "Atomic Assignment"}  true;
      waitEvent_2 := EventIn_1;  goto L14;
L6:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 366} {:print "Atomic Assignment"}  true;
      Tmp_47 := -1073741802;  goto L15;
L7:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(waitEvent_2);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 363} {:print "Call \"CompletionRoutinePower\" \"KeSetEvent\""}  true;
  call sdv_21 := KeSetEvent( waitEvent_2, 0, 0);   goto L6;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L14:
  call {:cexpr "Irp->PendingReturned"} boogie_si_record_li2bpl_int(Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_5)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 361} {:print "Atomic Conditional"}  true;
    if(*) { assume Irp_5 > 0;
  assume (Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_5)] != 1);  goto L6; } else { assume Irp_5 > 0;
  assume (Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_5)] == 1);  goto L7; }
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 366} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_590764100"} sdv_hash_590764100(actual_DeviceObject_5:int, actual_Irp_6:int) returns (Tmp_49:int) {
var  sdv_22: int;
var  sdv_23: int;
var  stack_1: int;
var  ProcessorMask: int;
var  sdv_24: int;
var  Tmp_50: int;
var  status_3: int;
var  extension_4: int;
var  DeviceObject_5: int;
var  Irp_6: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_5 := actual_DeviceObject_5;
  Irp_6 := actual_Irp_6;
  // done with preamble
  goto L36;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 275} {:print "Atomic Assignment"}  true;
      extension_4 := 0;  goto L38;
L14:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 282} {:print "Call \"DispatchPnp\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call stack_1 := sdv_IoGetCurrentIrpStackLocation( Irp_6);   goto L18;
L18:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_5)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 284} {:print "Atomic Assignment"}  true;
    assume DeviceObject_5 > 0;
    extension_4 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_5)];  goto L42;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 308} {:print "Atomic Assignment"}  true;
      status_3 := -1073741822;  goto L45;
L21:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 289} {:print "Atomic Assignment"}  true;
      ProcessorMask := 1;  goto L43;
L25:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 303} {:print "Call \"DispatchPnp\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_6);   goto L28;
L28:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_4)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 305} {:print "Call \"DispatchPnp\" \"sdv_IoCallDriver\""}  true;
  assume extension_4 > 0;
  call status_3 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_4)], Irp_6);   goto L33;
L33:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 311} {:print "Atomic Assignment"}  true;
      Tmp_49 := status_3;  goto L44;
L36:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 276} {:print "Atomic Assignment"}  true;
      stack_1 := 0;  goto L39;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 277} {:print "Atomic Assignment"}  true;
      status_3 := 0;  goto L40;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 278} {:print "Atomic Assignment"}  true;
      ProcessorMask := 0;  goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 280} {:print "Call \"DispatchPnp\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L14;
L42:
  call {:cexpr "stack->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(stack_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 286} {:print "Atomic Conditional"}  true;
    if(*) { assume stack_1 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(stack_1)] != 0);  goto L20; } else { assume stack_1 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(stack_1)] == 0);  goto L21; }
L43:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(210);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(extension_4);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(Mem_T.ControllerVector__DRIVER_DEVICE_EXTENSION[ControllerVector__DRIVER_DEVICE_EXTENSION(extension_4)]);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg7"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg8"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg9"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg10"} boogie_si_record_li2bpl_int(ProcessorMask);
  call {:cexpr "arg11"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 291} {:print "Call \"DispatchPnp\" \"IoConnectInterrupt\""}  true;
  assume extension_4 > 0;
  call sdv_23 := IoConnectInterrupt( 0, 210, extension_4, 0, Mem_T.ControllerVector__DRIVER_DEVICE_EXTENSION[ControllerVector__DRIVER_DEVICE_EXTENSION(extension_4)], 0, 0, 0, 1, ProcessorMask, 1);   goto L25;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 311} {:print "Return"}  true;
    goto LM2;
L45:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L33;
Lfinal: return;
}
procedure {:origName "sdv_hash_1044063384"} sdv_hash_1044063384(actual_DeviceObject_6:int, actual_Irp_7:int) returns (Tmp_51:int) {
var  sdv_25: int;
var  status_4: int;
var  extension_5: int;
var  Tmp_52: int;
var  DeviceObject_6: int;
var  Irp_7: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_6 := actual_DeviceObject_6;
  Irp_7 := actual_Irp_7;
  // done with preamble
  goto L19;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 257} {:print "Atomic Assignment"}  true;
      status_4 := 0;  goto L21;
L10:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 262} {:print "Call \"DispatchSystemControl\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_7);   goto L13;
L13:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_5)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 264} {:print "Call \"DispatchSystemControl\" \"sdv_IoCallDriver\""}  true;
  assume extension_5 > 0;
  call status_4 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_5)], Irp_7);   goto L17;
L17:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 266} {:print "Atomic Assignment"}  true;
      Tmp_51 := status_4;  goto L23;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L21:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_6)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 258} {:print "Atomic Assignment"}  true;
    assume DeviceObject_6 > 0;
    extension_5 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_6)];  goto L22;
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 260} {:print "Call \"DispatchSystemControl\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L10;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 266} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_232712213"} sdv_hash_232712213(actual_Irp_8:int, actual_Data_2:int, actual_Resource:int) returns (Tmp_53:int) {
var  Tmp_54: int;
var  Tmp_55: int;
var  Irp_8: int;
var  Data_2: int;
var  Resource: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Irp_8 := actual_Irp_8;
  Data_2 := actual_Data_2;
  Resource := actual_Resource;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 413} {:print "Atomic Assignment"}  true;
    assume Irp_8 > 0;
    Tmp_55 := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_8))];  goto L11;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 420} {:print "Atomic Assignment"}  true;
      Tmp_53 := 0;  goto L13;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L11:
  call {:cexpr "*Data"} boogie_si_record_li2bpl_int(Mem_T.INT4[Data_2]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 413} {:print "Atomic Assignment"}  true;
    assume Tmp_55 > 0;
  assume Data_2 > 0;
    Mem_T.INT4[Tmp_55] := Mem_T.INT4[Data_2];  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 418} {:print "Call \"ReadFromDevice\" \"ExReleaseResourceLite\""}  true;
  call ExReleaseResourceLite( 0);   goto L7;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 420} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_924667436_sdv_special_DTOR"} sdv_hash_924667436_sdv_special_DTOR(actual_this_8:int) {
var  Tmp_56: int;
var  spinLock_2: int;
var  Tmp_57: int;
var  Tmp_58: int;
var  i_1: int;
var  Tmp_59: int;
var  Tmp_60: int;
var  oldIrql_2: int;
var  Tmp_61: int;
var  Tmp_62: int;
var  this_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  this_8 := actual_this_8;
  // done with preamble
  goto L37;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 238} {:print "Return"}  true;
    goto LM2;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 223} {:print "Atomic Assignment"}  true;
      spinLock_2 := 0;  goto L39;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_60 := __HAVOC_malloc(4);  goto L36;
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 229} {:print "Atomic Assignment"}  true;
      i_1 := 0;  goto L45;
L18:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  call {:cexpr "this->sdv_hash_925174249.capacity"} boogie_si_record_li2bpl_int(Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 229} {:print "Atomic Conditional"}  true;
    if(*) { assume this_8 > 0;
  assume (i_1 >= Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);  goto L19; } else { assume this_8 > 0;
  assume (i_1 < Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);  goto L22; }
L19:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(oldIrql_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 237} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"sdv_KeReleaseSpinLock\""}  true;
  call sdv_KeReleaseSpinLock( 0, oldIrql_2);   goto L28;
L22:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 231} {:print "Atomic Assignment"}  true;
      Tmp_62 := i_1;  goto L46;
L23:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 229} {:print "Atomic Assignment"}  true;
      i_1 := (i_1 + 1);  goto L51;
L24:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 233} {:print "Atomic Assignment"}  true;
      Tmp_57 := i_1;  goto L48;
L28:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_hash_925174249_DEVICE_DATA_BAG(this_8));
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 212} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"BAG<DEVICE_DATA *>::~BAG<DEVICE_DATA *>\""}  true;
  assume this_8 > 0;
  call sdv_hash_233701977_sdv_special_DTOR( sdv_hash_925174249_DEVICE_DATA_BAG(this_8));   goto L1;
L33:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_60]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_60 > 0;
    spinLock_2 := Mem_T.INT4[Tmp_60];  goto L42;
L34:
  call {:cexpr "spinLock"} boogie_si_record_li2bpl_int(spinLock_2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_60 > 0;
    Mem_T.INT4[Tmp_60] := spinLock_2;  goto L41;
L35:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_60]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_60 > 0;
    oldIrql_2 := Mem_T.INT4[Tmp_60];  goto L44;
L36:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql_2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_60 > 0;
    Mem_T.INT4[Tmp_60] := oldIrql_2;  goto L43;
L37:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 224} {:print "Atomic Assignment"}  true;
      oldIrql_2 := 0;  goto L40;
L40:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_60 := __HAVOC_malloc(4);  goto L34;
L41:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_60);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 226} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_60);   goto L33;
L42:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L13;
L43:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_60);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 227} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"sdv_KeAcquireSpinLock\""}  true;
  call sdv_KeAcquireSpinLock( 0, Tmp_60);   goto L35;
L44:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L17;
L45:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L18;
L46:
  call {:cexpr "this->sdv_hash_925174249.pitems"} boogie_si_record_li2bpl_int(Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 231} {:print "Atomic Assignment"}  true;
    assume this_8 > 0;
    Tmp_58 := Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))];  goto L47;
L47:
  call {:cexpr "*(Tmp + (Tmp * 4))"} boogie_si_record_li2bpl_int(Mem_T.PDEVICE_DATA[(Tmp_58 + (Tmp_62 * 4))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 231} {:print "Atomic Conditional"}  true;
    if(*) { assume Tmp_58 > 0;
  assume (Mem_T.PDEVICE_DATA[(Tmp_58 + (Tmp_62 * 4))] == 0);  goto L23; } else { assume Tmp_58 > 0;
  assume (Mem_T.PDEVICE_DATA[(Tmp_58 + (Tmp_62 * 4))] != 0);  goto L24; }
L48:
  call {:cexpr "this->sdv_hash_925174249.pitems"} boogie_si_record_li2bpl_int(Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 233} {:print "Atomic Assignment"}  true;
    assume this_8 > 0;
    Tmp_59 := Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))];  goto L49;
L49:
  call {:cexpr "*(Tmp + (Tmp * 4))"} boogie_si_record_li2bpl_int(Mem_T.PDEVICE_DATA[(Tmp_59 + (Tmp_57 * 4))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 233} {:print "Atomic Assignment"}  true;
    assume Tmp_59 > 0;
    Tmp_56 := Mem_T.PDEVICE_DATA[(Tmp_59 + (Tmp_57 * 4))];  goto L50;
L50:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_56);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 233} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"operator delete\""}  true;
  call sdv_hash_874085766( Tmp_56);   goto L23;
L51:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L18;
Lfinal: return;
}
procedure {:origName "sdv_hash_324714501"} sdv_hash_324714501(actual_this_9:int, actual_s_p_e_c_i_a_l_1:int) returns (Tmp_63:int) {
var  Tmp_64: int;
var  this_9: int;
var  s_p_e_c_i_a_l_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  this_9 := actual_this_9;
  s_p_e_c_i_a_l_1 := actual_s_p_e_c_i_a_l_1;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(this_9);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"DEVICE_DATA_BAG::`scalar deleting destructor'\" \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\""}  true;
  call sdv_hash_924667436_sdv_special_DTOR( this_9);   goto L6;
L6:
  call {:cexpr "s_p_e_c_i_a_l"} boogie_si_record_li2bpl_int(s_p_e_c_i_a_l_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 257} {:print "Atomic Conditional"}  true;
    if(*) { assume (BAND(s_p_e_c_i_a_l_1, 1) == 0);  goto L7; } else { assume (BAND(s_p_e_c_i_a_l_1, 1) != 0);  goto L8; }
L7:
  call {:cexpr "this"} boogie_si_record_li2bpl_int(this_9);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_63 := this_9;  goto L15;
L8:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(this_9);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"DEVICE_DATA_BAG::`scalar deleting destructor'\" \"operator delete\""}  true;
  call sdv_hash_874085766( this_9);   goto L7;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "_sdv_init1"} _sdv_init1() {
var  Tmp_65: int;
var  Tmp_66: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L4:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35320} {:print "Atomic Assignment"}  true;
      ClfsNullRecord := 0;  goto L10;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L10:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35321} {:print "Atomic Assignment"}  true;
      ClfsDataRecord := 1;  goto L11;
L11:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35322} {:print "Atomic Assignment"}  true;
      ClfsRestartRecord := 2;  goto L12;
L12:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35327} {:print "Atomic Assignment"}  true;
      ClfsClientRecord := 3;  goto L13;
L13:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35608} {:print "Atomic Assignment"}  true;
      ClsContainerInitializing := 1;  goto L14;
L14:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35609} {:print "Atomic Assignment"}  true;
      ClsContainerInactive := 2;  goto L15;
L15:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35610} {:print "Atomic Assignment"}  true;
      ClsContainerActive := 4;  goto L16;
L16:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35611} {:print "Atomic Assignment"}  true;
      ClsContainerActivePendingDelete := 8;  goto L17;
L17:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35612} {:print "Atomic Assignment"}  true;
      ClsContainerPendingArchive := 16;  goto L18;
L18:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35613} {:print "Atomic Assignment"}  true;
      ClsContainerPendingArchiveAndDelete := 32;  goto L19;
L19:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35615} {:print "Atomic Assignment"}  true;
      ClfsContainerInitializing := 1;  goto L20;
L20:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35616} {:print "Atomic Assignment"}  true;
      ClfsContainerInactive := 2;  goto L21;
L21:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35617} {:print "Atomic Assignment"}  true;
      ClfsContainerActive := 4;  goto L22;
L22:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35618} {:print "Atomic Assignment"}  true;
      ClfsContainerActivePendingDelete := 8;  goto L23;
L23:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35619} {:print "Atomic Assignment"}  true;
      ClfsContainerPendingArchive := 16;  goto L24;
L24:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35620} {:print "Atomic Assignment"}  true;
      ClfsContainerPendingArchiveAndDelete := 32;  goto L25;
L25:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35653} {:print "Atomic Assignment"}  true;
      CLFS_MAX_CONTAINER_INFO := 256;  goto L26;
L26:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35816} {:print "Atomic Assignment"}  true;
      CLFS_SCAN_INIT := 1;  goto L27;
L27:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35817} {:print "Atomic Assignment"}  true;
      CLFS_SCAN_FORWARD := 2;  goto L28;
L28:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35818} {:print "Atomic Assignment"}  true;
      CLFS_SCAN_BACKWARD := 4;  goto L29;
L29:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35819} {:print "Atomic Assignment"}  true;
      CLFS_SCAN_CLOSE := 8;  goto L30;
L30:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35820} {:print "Atomic Assignment"}  true;
      CLFS_SCAN_INITIALIZED := 16;  goto L31;
L31:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 35821} {:print "Atomic Assignment"}  true;
      CLFS_SCAN_BUFFERED := 32;  goto L32;
L32:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_IoCallDriver"} sdv_IoCallDriver(actual_DeviceObject_7:int, actual_Irp_9:int) returns (Tmp_67:int) {
var  sdv_26: int;
var  Tmp_68: int;
var  DeviceObject_7: int;
var  Irp_9: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_7 := actual_DeviceObject_7;
  Irp_9 := actual_Irp_9;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10057} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_9);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10056} {:print "Call \"sdv_IoCallDriver\" \"IofCallDriver\""}  true;
  call Tmp_67 := IofCallDriver( 0, Irp_9);   goto L1;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_IoGetNextIrpStackLocation"} sdv_IoGetNextIrpStackLocation(actual_pirp:int) returns (Tmp_69:int) {
var  Tmp_70: int;
var  pirp: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp := actual_pirp;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10901} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp);
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10894} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp != sdv_harnessIrp);  goto L4; } else { assume (pirp == sdv_harnessIrp);  goto L5; }
L4:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp);
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10896} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp != sdv_other_harnessIrp);  goto L6; } else { assume (pirp == sdv_other_harnessIrp);  goto L7; }
L5:
  call {:cexpr "&sdv_harnessStackLocation_next"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation_next);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10895} {:print "Atomic Assignment"}  true;
      Tmp_69 := sdv_harnessStackLocation_next;  goto L11;
L6:
  call {:cexpr "&sdv_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10899} {:print "Atomic Assignment"}  true;
      Tmp_69 := sdv_harnessStackLocation;  goto L13;
L7:
  call {:cexpr "&sdv_other_harnessStackLocation_next"} boogie_si_record_li2bpl_int(sdv_other_harnessStackLocation_next);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10897} {:print "Atomic Assignment"}  true;
      Tmp_69 := sdv_other_harnessStackLocation_next;  goto L12;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L11:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_KeAcquireSpinLock"} sdv_KeAcquireSpinLock(actual_SpinLock:int, actual_p:int) {
var  Tmp_71: int;
var  Tmp_72: int;
var  SpinLock: int;
var  p: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SpinLock := actual_SpinLock;
  p := actual_p;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12652} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L11;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L11:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12652} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L12;
L12:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12652} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12652} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L14;
L14:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12653} {:print "Atomic Assignment"}  true;
    assume p > 0;
    Mem_T.INT4[p] := sdv_irql_previous;  goto L15;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12654} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeInitializeEvent"} KeInitializeEvent(actual_Event:int, actual_Type:int, actual_State:int) {
var  Tmp_73: int;
var  Tmp_74: int;
var  Event: int;
var  Type: int;
var  State: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Event := actual_Event;
  Type := actual_Type;
  State := actual_State;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "Type"} boogie_si_record_li2bpl_int(Type);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12791} {:print "Atomic Assignment"}  true;
    assume Event > 0;
    Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(Header__KEVENT(Event))] := Type;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12792} {:print "Atomic Assignment"}  true;
    assume Event > 0;
    Mem_T.Signalling__DISPATCHER_HEADER[Signalling__DISPATCHER_HEADER(Header__KEVENT(Event))] := 0;  goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12793} {:print "Atomic Assignment"}  true;
    assume Event > 0;
    Mem_T.Size__DISPATCHER_HEADER[Size__DISPATCHER_HEADER(Header__KEVENT(Event))] := 4;  goto L12;
L12:
  call {:cexpr "State"} boogie_si_record_li2bpl_int(State);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12794} {:print "Atomic Assignment"}  true;
    assume Event > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event))] := State;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12795} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeSetEvent"} KeSetEvent(actual_Event_1:int, actual_Increment:int, actual_Wait:int) returns (Tmp_75:int) {
var  Tmp_76: int;
var  OldState: int;
var  Event_1: int;
var  Increment: int;
var  Wait: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Event_1 := actual_Event_1;
  Increment := actual_Increment;
  Wait := actual_Wait;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  call {:cexpr "Event->Header.SignalState"} boogie_si_record_li2bpl_int(Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_1))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13050} {:print "Atomic Assignment"}  true;
    assume Event_1 > 0;
    OldState := Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_1))];  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13051} {:print "Atomic Assignment"}  true;
    assume Event_1 > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_1))] := 1;  goto L11;
L11:
  call {:cexpr "OldState"} boogie_si_record_li2bpl_int(OldState);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13052} {:print "Atomic Assignment"}  true;
      Tmp_75 := OldState;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13052} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "ExAcquireResourceExclusiveLite"} ExAcquireResourceExclusiveLite(actual_Resource_1:int, actual_Wait_1:int) returns (Tmp_77:int) {
var  sdv_27: int;
var  Tmp_78: int;
var  choice: int;
var  Resource_1: int;
var  Wait_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Resource_1 := actual_Resource_1;
  Wait_1 := actual_Wait_1;
  // done with preamble
  goto L15;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7218} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "Wait"} boogie_si_record_li2bpl_int(Wait_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7204} {:print "Atomic Conditional"}  true;
    if(*) { assume (Wait_1 != 0);  goto L5; } else { assume (Wait_1 == 0);  goto L10; }
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7204} {:print "Atomic Assignment"}  true;
      Tmp_77 := 1;  goto L17;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7207} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L12; }
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7213} {:print "Atomic Assignment"}  true;
      Tmp_77 := 1;  goto L19;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7210} {:print "Atomic Assignment"}  true;
      Tmp_77 := 0;  goto L18;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "main"} main() returns (Tmp_79:int) {
var  Tmp_80: int;
var  Tmp_81: int;
var  Tmp_82: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  assume alloc > 0;
  // allocate globals moved-out-of-stack
  call sdv_IoBuildAsynchronousFsdRequest_harnessIrp := __HAVOC_malloc(240);
  call sdv_IoCreateSynchronizationEvent_KEVENT := __HAVOC_malloc(108);
  call sdv_devobj_pdo := __HAVOC_malloc(328);
  call sdv_other_harnessStackLocation := __HAVOC_malloc(536);
  call sdv_ControllerIrp := __HAVOC_malloc(240);
  call sdv_other_harnessIrp := __HAVOC_malloc(240);
  call sdv_other_harnessStackLocation_next := __HAVOC_malloc(536);
  call sdv_PowerIrp := __HAVOC_malloc(240);
  call sdv_kinterrupt_val := __HAVOC_malloc(0);
  call sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX := __HAVOC_malloc(76);
  call sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next := __HAVOC_malloc(536);
  call sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT := __HAVOC_malloc(328);
  call sdv_harnessStackLocation := __HAVOC_malloc(536);
  call sdv_devobj_fdo := __HAVOC_malloc(328);
  call sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock := __HAVOC_malloc(12);
  call sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next := __HAVOC_malloc(536);
  call sdv_IoCreateController_CONTROLLER_OBJECT := __HAVOC_malloc(60);
  call sdv_StartIoIrp := __HAVOC_malloc(240);
  call sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock := __HAVOC_malloc(12);
  call sdv_devobj_child_pdo := __HAVOC_malloc(328);
  call sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING := __HAVOC_malloc(16);
  call sdv_harnessStackLocation_next := __HAVOC_malloc(536);
  call sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next := __HAVOC_malloc(536);
  call sdv_fx_dev_object := __HAVOC_malloc(40);
  call sdv_IoBuildDeviceIoControlRequest_harnessIrp := __HAVOC_malloc(240);
  call sdv_IoBuildSynchronousFsdRequest_harnessIrp := __HAVOC_malloc(240);
  call sdv_IoInitializeIrp_harnessIrp := __HAVOC_malloc(240);
  call sdv_IoGetDeviceToVerify_DEVICE_OBJECT := __HAVOC_malloc(328);
  call sdv_IoMakeAssociatedIrp_harnessIrp := __HAVOC_malloc(240);
  call sdv_harnessIrp := __HAVOC_malloc(240);
  call sdv_devobj_top := __HAVOC_malloc(328);
  call WHEA_ERROR_PACKET_SECTION_GUID := __HAVOC_malloc(16);
  call sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT := __HAVOC_malloc(328);
  call sdv_IoCreateNotificationEvent_KEVENT := __HAVOC_malloc(108);
  call sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock := __HAVOC_malloc(12);
  call sdv_MapRegisterBase_val := __HAVOC_malloc(4);
  call sdv_kdpc_val3 := __HAVOC_malloc(40);
  call sdv_IoGetDmaAdapter_DMA_ADAPTER := __HAVOC_malloc(12);
  call SLAM_guard_O_0_init := __HAVOC_malloc(108);
  // Global distinctness: initialize globals
  call  boogieTmp :=  __HAVOC_malloc_or_null(4);
  sdv_harnessDeviceExtension := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(4);
  igdoe := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(4);
  sdv_context := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(4);
  sdv_harnessDeviceExtension_two := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(240);
  sicrni := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(4);
  sdv_pDpcContext := boogieTmp;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L24;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6695} {:print "Atomic Continuation"}  true;
    goto L25;
L3:
  call {:cexpr "sdv_harnessDeviceExtension"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_harnessDeviceExtension != 0);  goto L28; } else { assume (sdv_harnessDeviceExtension == 0);  goto L29; }
L7:
  call {:cexpr "sdv_harnessDeviceExtension_two"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension_two);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_harnessDeviceExtension_two != 0);  goto L32; } else { assume (sdv_harnessDeviceExtension_two == 0);  goto L33; }
L11:
  call {:cexpr "sdv_harnessDeviceExtension"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
      Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(sdv_devobj_pdo)] := sdv_harnessDeviceExtension;  goto L35;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"main\" \"_sdv_init1\""}  true;
  call _sdv_init1();   goto L3;
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"main\" \"_sdv_init2\""}  true;
  call _sdv_init2();   goto L19;
L21:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_81);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Continuation"}  true;
  assume(Tmp_81 != 0);   goto L30;
L22:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_80);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Continuation"}  true;
  assume(Tmp_80 != 0);   goto L34;
L23:
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"main\" \"_sdv_init4\""}  true;
    assume {:mainInitDone} true;
  call corralExtraInit();
call _sdv_init4();   goto L20;
L24:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L23;
L25:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 0);  goto LM2; } else { assume (yogi_error == 1);  goto L40; }
L27:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L21;
L28:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_81 := 1;  goto L27;
L29:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_81 := 0;  goto L27;
L30:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L31:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L22;
L32:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_80 := 1;  goto L31;
L33:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_80 := 0;  goto L31;
L34:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L35:
  call {:cexpr "sdv_harnessDeviceExtension_two"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension_two);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
      Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(sdv_devobj_fdo)] := sdv_harnessDeviceExtension_two;  goto L36;
L36:
  call {:cexpr "&sdv_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
    assume sdv_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_irp)))] := sdv_harnessStackLocation;  goto L37;
L37:
  call {:cexpr "&sdv_other_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_other_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
    assume sdv_other_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_other_irp)))] := sdv_other_harnessStackLocation;  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6694} {:print "Call \"main\" \"sdv_main\""}  true;
  call sdv_main();   goto L39;
L39:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error != 1);  goto L1; } else { assume (yogi_error == 1);  goto L25; }
L40:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    assert false;  goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_main"} sdv_main() {
var  Tmp_83: int;
var  sdv_28: int;
var  Tmp_84: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L10;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 660} {:print "Return"}  true;
    goto LM2;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 657} {:print "Call \"sdv_main\" \"sdv_stub_driver_init\""}  true;
  call sdv_stub_driver_init();   goto L6;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 658} {:print "Call \"sdv_main\" \"sdv_RunDispatchFunction\""}  true;
  call sdv_28 := sdv_RunDispatchFunction( sdv_p_devobj_fdo, sdv_irp);   goto L12;
L10:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L12:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
Lfinal: return;
}
procedure {:origName "sdv_stub_dispatch_begin"} sdv_stub_dispatch_begin() {
var  Tmp_85: int;
var  Tmp_86: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L11;
L11:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6745} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_do_paged_code_check"} sdv_do_paged_code_check() {
var  Tmp_87: int;
var  Tmp_88: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6698} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "KeEnterCriticalRegion"} KeEnterCriticalRegion() {
var  Tmp_89: int;
var  Tmp_90: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12739} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_SetPowerIrpMinorFunction"} sdv_SetPowerIrpMinorFunction(actual_pirp_1:int) {
var  sdv_29: int;
var  sdv_30: int;
var  y: int;
var  x: int;
var  r: int;
var  Tmp_91: int;
var  Tmp_92: int;
var  pirp_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_1 := actual_pirp_1;
  // done with preamble
  goto L43;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1382} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_1)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1337} {:print "Atomic Assignment"}  true;
    assume pirp_1 > 0;
    r := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_1)))];  goto L45;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1341} {:print "Atomic Continuation"}  true;
    if(*) {  goto L17; } else {  goto L37; }
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1343} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 2;  goto L46;
L18:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1357} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 3;  goto L49;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1373} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 1;  goto L52;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1361} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 0;  goto L50;
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1346} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 0;  goto L47;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1379} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 0;  goto L53;
L36:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L19; } else {  goto L35; }
L37:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L18; } else {  goto L36; }
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1351} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 1;  goto L48;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1366} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 1;  goto L51;
L43:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L45:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L15;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1344} {:print "Atomic Continuation"}  true;
    if(*) {  goto L29; } else {  goto L39; }
L47:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L48:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1358} {:print "Atomic Continuation"}  true;
    if(*) {  goto L23; } else {  goto L41; }
L50:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L51:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L52:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L53:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_IoCompleteRequest"} sdv_IoCompleteRequest(actual_pirp_2:int, actual_PriorityBoost:int) {
var  Tmp_93: int;
var  Tmp_94: int;
var  pirp_2: int;
var  PriorityBoost: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_2 := actual_pirp_2;
  PriorityBoost := actual_PriorityBoost;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10106} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "ExReleaseResourceLite"} ExReleaseResourceLite(actual_Resource_2:int) {
var  Tmp_95: int;
var  Tmp_96: int;
var  Resource_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Resource_2 := actual_Resource_2;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7658} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "KeWaitForSingleObject"} KeWaitForSingleObject(actual_Object:int, actual_WaitReason:int, actual_WaitMode:int, actual_Alertable:int, actual_Timeout:int) returns (Tmp_97:int) {
var  sdv_31: int;
var  x_1: int;
var  Tmp_98: int;
var  Object: int;
var  WaitReason: int;
var  WaitMode: int;
var  Alertable: int;
var  Timeout: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Object := actual_Object;
  WaitReason := actual_WaitReason;
  WaitMode := actual_WaitMode;
  Alertable := actual_Alertable;
  Timeout := actual_Timeout;
  // done with preamble
  goto L15;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13132} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "Timeout"} boogie_si_record_li2bpl_int(Timeout);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13118} {:print "Atomic Conditional"}  true;
    if(*) { assume (Timeout == 0);  goto L9; } else { assume (Timeout != 0);  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13120} {:print "Atomic Assignment"}  true;
      Tmp_97 := 0;  goto L19;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13122} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L12; }
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13129} {:print "Atomic Assignment"}  true;
      Tmp_97 := 0;  goto L18;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13124} {:print "Atomic Assignment"}  true;
      Tmp_97 := 258;  goto L17;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_IoSetCompletionRoutine"} sdv_IoSetCompletionRoutine(actual_pirp_3:int, actual_CompletionRoutine:int, actual_Context:int, actual_InvokeOnSuccess:int, actual_InvokeOnError:int, actual_InvokeOnCancel:int) {
var  sdv_32: int;
var  irpSp: int;
var  Tmp_99: int;
var  Tmp_100: int;
var  pirp_3: int;
var  CompletionRoutine: int;
var  Context: int;
var  InvokeOnSuccess: int;
var  InvokeOnError: int;
var  InvokeOnCancel: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_3 := actual_pirp_3;
  CompletionRoutine := actual_CompletionRoutine;
  Context := actual_Context;
  InvokeOnSuccess := actual_InvokeOnSuccess;
  InvokeOnError := actual_InvokeOnError;
  InvokeOnCancel := actual_InvokeOnCancel;
  // done with preamble
  goto L16;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11508} {:print "Call \"sdv_IoSetCompletionRoutine\" \"sdv_IoGetNextIrpStackLocation\""}  true;
  call irpSp := sdv_IoGetNextIrpStackLocation( pirp_3);   goto L8;
L8:
  call {:cexpr "CompletionRoutine"} boogie_si_record_li2bpl_int(CompletionRoutine);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11509} {:print "Atomic Assignment"}  true;
    assume irpSp > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpSp)] := CompletionRoutine;  goto L19;
L15:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_3);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(InvokeOnSuccess);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(InvokeOnError);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(InvokeOnCancel);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11498} {:print "Call \"sdv_IoSetCompletionRoutine\" \"SLIC_sdv_IoSetCompletionRoutine_entry\""}  true;
  call SLIC_sdv_IoSetCompletionRoutine_entry( strConst__li2bpl0, pirp_3, InvokeOnSuccess, InvokeOnError, InvokeOnCancel);   goto L18;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L15;
L18:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L4; }
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11510} {:print "Atomic Assignment"}  true;
      sdv_compFset := 1;  goto L20;
L20:
  call {:cexpr "Context"} boogie_si_record_li2bpl_int(Context);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11511} {:print "Atomic Assignment"}  true;
      sdv_context := Context;  goto L21;
L21:
  call {:cexpr "InvokeOnSuccess"} boogie_si_record_li2bpl_int(InvokeOnSuccess);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11512} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_success := InvokeOnSuccess;  goto L22;
L22:
  call {:cexpr "InvokeOnError"} boogie_si_record_li2bpl_int(InvokeOnError);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11513} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_error := InvokeOnError;  goto L23;
L23:
  call {:cexpr "InvokeOnCancel"} boogie_si_record_li2bpl_int(InvokeOnCancel);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11514} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_cancel := InvokeOnCancel;  goto L24;
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11516} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "ExFreePoolWithTag"} ExFreePoolWithTag(actual_P:int, actual_Tag:int) {
var  Tmp_101: int;
var  Tmp_102: int;
var  P: int;
var  Tag: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  P := actual_P;
  Tag := actual_Tag;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 8446} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_Trap"} sdv_Trap() {
var  Tmp_103: int;
var  Tmp_104: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1294} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "ExAllocatePoolWithTag"} ExAllocatePoolWithTag(actual_PoolType_2:int, actual_NumberOfBytes:int, actual_Tag_1:int) returns (Tmp_105:int) {
var  Tmp_106: int;
var  sdv_33: int;
var  sdv_34: int;
var  x_2: int;
var  PoolType_2: int;
var  NumberOfBytes: int;
var  Tag_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  PoolType_2 := actual_PoolType_2;
  NumberOfBytes := actual_NumberOfBytes;
  Tag_1 := actual_Tag_1;
  // done with preamble
  goto L16;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7348} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7343} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7346} {:print "Atomic Assignment"}  true;
      Tmp_105 := 0;  goto L19;
L10:
  call {:cexpr "NumberOfBytes"} boogie_si_record_li2bpl_int(NumberOfBytes);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7345} {:print "Atomic Assignment"}  true;
      call sdv_33 := __HAVOC_malloc(NumberOfBytes);  goto L13;
L13:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_33);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7345} {:print "Atomic Assignment"}  true;
      Tmp_105 := sdv_33;  goto L18;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_IoCopyCurrentIrpStackLocationToNext"} sdv_IoCopyCurrentIrpStackLocationToNext(actual_pirp_4:int) {
var  Tmp_107: int;
var  Tmp_108: int;
var  pirp_4: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_4 := actual_pirp_4;
  // done with preamble
  goto L12;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10188} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_4);
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_4 != sdv_harnessIrp);  goto L4; } else { assume (pirp_4 == sdv_harnessIrp);  goto L5; }
L4:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_4);
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_4 != sdv_other_harnessIrp);  goto L1; } else { assume (pirp_4 == sdv_other_harnessIrp);  goto L7; }
L5:
  call {:cexpr "sdv_harnessStackLocation.MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];  goto L14;
L7:
  call {:cexpr "sdv_other_harnessStackLocation.MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];  goto L16;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L14:
  call {:cexpr "sdv_harnessStackLocation.MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];  goto L15;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L16:
  call {:cexpr "sdv_other_harnessStackLocation.MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];  goto L17;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_KeReleaseSpinLock"} sdv_KeReleaseSpinLock(actual_SpinLock_1:int, actual_new:int) {
var  Tmp_109: int;
var  Tmp_110: int;
var  SpinLock_1: int;
var  new: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SpinLock_1 := actual_SpinLock_1;
  new := actual_new;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "new"} boogie_si_record_li2bpl_int(new);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13010} {:print "Atomic Assignment"}  true;
      sdv_irql_current := new;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13010} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L10;
L10:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13010} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13011} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_SetStatus"} sdv_SetStatus(actual_pirp_5:int) {
var  sdv_35: int;
var  Tmp_111: int;
var  choice_1: int;
var  Tmp_112: int;
var  pirp_5: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_5 := actual_pirp_5;
  // done with preamble
  goto L16;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1506} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1497} {:print "Atomic Continuation"}  true;
    if(*) {  goto L10; } else {  goto L14; }
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1499} {:print "Atomic Assignment"}  true;
    assume pirp_5 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_5))] := -1073741637;  goto L18;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1503} {:print "Atomic Assignment"}  true;
    assume pirp_5 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_5))] := 0;  goto L19;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_stub_driver_init"} sdv_stub_driver_init() {
var  Tmp_113: int;
var  Tmp_114: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6708} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "_sdv_init2"} _sdv_init2() {
var  Tmp_115: int;
var  Tmp_116: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 75} {:print "Atomic Assignment"}  true;
      sdv_dpc_io_registered := 0;  goto L10;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 77} {:print "Atomic Assignment"}  true;
      sdv_apc_disabled := 0;  goto L11;
L11:
  call {:cexpr "&sdv_ControllerIrp"} boogie_si_record_li2bpl_int(sdv_ControllerIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 82} {:print "Atomic Assignment"}  true;
      sdv_ControllerPirp := sdv_ControllerIrp;  goto L12;
L12:
  call {:cexpr "&sdv_StartIoIrp"} boogie_si_record_li2bpl_int(sdv_StartIoIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 85} {:print "Atomic Assignment"}  true;
      sdv_StartIopirp := sdv_StartIoIrp;  goto L13;
L13:
  call {:cexpr "&sdv_PowerIrp"} boogie_si_record_li2bpl_int(sdv_PowerIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 89} {:print "Atomic Assignment"}  true;
      sdv_power_irp := sdv_PowerIrp;  goto L14;
L14:
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 93} {:print "Atomic Assignment"}  true;
      sdv_irp := sdv_harnessIrp;  goto L15;
L15:
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 100} {:print "Atomic Assignment"}  true;
      sdv_other_irp := sdv_other_harnessIrp;  goto L16;
L16:
  call {:cexpr "&sdv_IoMakeAssociatedIrp_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoMakeAssociatedIrp_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 105} {:print "Atomic Assignment"}  true;
      sdv_IoMakeAssociatedIrp_irp := sdv_IoMakeAssociatedIrp_harnessIrp;  goto L17;
L17:
  call {:cexpr "&sdv_IoBuildDeviceIoControlRequest_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 110} {:print "Atomic Assignment"}  true;
      sdv_IoBuildDeviceIoControlRequest_irp := sdv_IoBuildDeviceIoControlRequest_harnessIrp;  goto L18;
L18:
  call {:cexpr "&sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock"} boogie_si_record_li2bpl_int(sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 114} {:print "Atomic Assignment"}  true;
      sdv_IoBuildDeviceIoControlRequest_IoStatusBlock := sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock;  goto L19;
L19:
  call {:cexpr "&sdv_IoBuildSynchronousFsdRequest_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 121} {:print "Atomic Assignment"}  true;
      sdv_IoBuildSynchronousFsdRequest_irp := sdv_IoBuildSynchronousFsdRequest_harnessIrp;  goto L20;
L20:
  call {:cexpr "&sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock"} boogie_si_record_li2bpl_int(sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 125} {:print "Atomic Assignment"}  true;
      sdv_IoBuildSynchronousFsdRequest_IoStatusBlock := sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;  goto L21;
L21:
  call {:cexpr "&sdv_IoBuildAsynchronousFsdRequest_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 129} {:print "Atomic Assignment"}  true;
      sdv_IoBuildAsynchronousFsdRequest_irp := sdv_IoBuildAsynchronousFsdRequest_harnessIrp;  goto L22;
L22:
  call {:cexpr "&sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock"} boogie_si_record_li2bpl_int(sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 133} {:print "Atomic Assignment"}  true;
      sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock := sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;  goto L23;
L23:
  call {:cexpr "&sdv_IoInitializeIrp_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoInitializeIrp_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 138} {:print "Atomic Assignment"}  true;
      sdv_IoInitializeIrp_irp := sdv_IoInitializeIrp_harnessIrp;  goto L24;
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 153} {:print "Atomic Assignment"}  true;
      sdv_io_create_device_called := 0;  goto L25;
L25:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 196} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L26;
L26:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 197} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := 0;  goto L27;
L27:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 198} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := 0;  goto L28;
L28:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 199} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := 0;  goto L29;
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 201} {:print "Atomic Assignment"}  true;
      sdv_maskedEflags := 0;  goto L30;
L30:
  call {:cexpr "&sdv_kdpc_val3"} boogie_si_record_li2bpl_int(sdv_kdpc_val3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 209} {:print "Atomic Assignment"}  true;
      sdv_kdpc3 := sdv_kdpc_val3;  goto L31;
L31:
  call {:cexpr "&sdv_devobj_fdo"} boogie_si_record_li2bpl_int(sdv_devobj_fdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 229} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_fdo := sdv_devobj_fdo;  goto L32;
L32:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 232} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 0;  goto L33;
L33:
  call {:cexpr "&sdv_devobj_pdo"} boogie_si_record_li2bpl_int(sdv_devobj_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 237} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_pdo := sdv_devobj_pdo;  goto L34;
L34:
  call {:cexpr "&sdv_devobj_child_pdo"} boogie_si_record_li2bpl_int(sdv_devobj_child_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 241} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_child_pdo := sdv_devobj_child_pdo;  goto L35;
L35:
  call {:cexpr "&sdv_kinterrupt_val"} boogie_si_record_li2bpl_int(sdv_kinterrupt_val);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 245} {:print "Atomic Assignment"}  true;
      sdv_kinterrupt := sdv_kinterrupt_val;  goto L36;
L36:
  call {:cexpr "&sdv_MapRegisterBase_val"} boogie_si_record_li2bpl_int(sdv_MapRegisterBase_val);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 248} {:print "Atomic Assignment"}  true;
      sdv_MapRegisterBase := sdv_MapRegisterBase_val;  goto L37;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 252} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_success := 0;  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 255} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_error := 0;  goto L39;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 258} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_cancel := 0;  goto L40;
L40:
  call {:cexpr "&sdv_fx_dev_object"} boogie_si_record_li2bpl_int(sdv_fx_dev_object);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 264} {:print "Atomic Assignment"}  true;
      p_sdv_fx_dev_object := sdv_fx_dev_object;  goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1211} {:print "Atomic Assignment"}  true;
      sdv_start_irp_already_issued := 0;  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1212} {:print "Atomic Assignment"}  true;
      sdv_remove_irp_already_issued := 0;  goto L43;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1213} {:print "Atomic Assignment"}  true;
      sdv_Io_Removelock_release_wait_returned := 0;  goto L44;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1216} {:print "Atomic Assignment"}  true;
      sdv_compFset := 0;  goto L45;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1227} {:print "Atomic Assignment"}  true;
      sdv_isr_routine := 294;  goto L46;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1242} {:print "Atomic Assignment"}  true;
      sdv_ke_dpc := 296;  goto L47;
L47:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1244} {:print "Atomic Assignment"}  true;
      sdv_dpc_ke_registered := 0;  goto L48;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1258} {:print "Atomic Assignment"}  true;
      sdv_io_dpc := 299;  goto L49;
L49:
  call {:cexpr "&sdv_devobj_top"} boogie_si_record_li2bpl_int(sdv_devobj_top);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9504} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_top := sdv_devobj_top;  goto L50;
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13869} {:print "Atomic Assignment"}  true;
      sdv_MmMapIoSpace_int := 0;  goto L51;
L51:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_stub_dispatch_end"} sdv_stub_dispatch_end(actual_s:int, actual_pirp_6:int) {
var  Tmp_117: int;
var  Tmp_118: int;
var  s: int;
var  pirp_6: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  s := actual_s;
  pirp_6 := actual_pirp_6;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6749} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_NullDereferenceTrap"} sdv_NullDereferenceTrap(actual_p_1:int) {
var  Tmp_119: int;
var  Tmp_120: int;
var  p_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  p_1 := actual_p_1;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1303} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "p"} boogie_si_record_li2bpl_int(p_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1302} {:print "Atomic Conditional"}  true;
    if(*) { assume (p_1 != 0);  goto L1; } else { assume (p_1 == 0);  goto L4; }
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1302} {:print "Call \"sdv_NullDereferenceTrap\" \"sdv_Trap\""}  true;
  call sdv_Trap();   goto L1;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_RunIoCompletionRoutines"} sdv_RunIoCompletionRoutines(actual_DeviceObject_8:int, actual_Irp_10:int, actual_Context_1:int, actual_Completion:int) returns (Tmp_121:int) {
var  sdv_36: int;
var  sdv_37: int;
var  sdv_38: int;
var  irpsp: int;
var  Tmp_122: int;
var  Status: int;
var  DeviceObject_8: int;
var  Irp_10: int;
var  Context_1: int;
var  Completion: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_8 := actual_DeviceObject_8;
  Irp_10 := actual_Irp_10;
  Context_1 := actual_Context_1;
  Completion := actual_Completion;
  // done with preamble
  goto L40;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_10);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3202} {:print "Call \"sdv_RunIoCompletionRoutines\" \"sdv_IoGetNextIrpStackLocation\""}  true;
  call irpsp := sdv_IoGetNextIrpStackLocation( Irp_10);   goto L9;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3203} {:print "Atomic Assignment"}  true;
      Status := 0;  goto L42;
L11:
  call {:cexpr "irpsp->CompletionRoutine"} boogie_si_record_li2bpl_int(Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3214} {:print "Atomic Conditional"}  true;
    if(*) { assume irpsp > 0;
  assume (Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)] != 208);  goto L24; } else { assume irpsp > 0;
  assume (Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)] == 208);  goto L25; }
L12:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L43;
L20:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3209} {:print "Atomic Assignment"}  true;
      sdv_irql_current := sdv_irql_previous;  goto L47;
L24:
  call {:cexpr "Status"} boogie_si_record_li2bpl_int(Status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3312} {:print "Atomic Assignment"}  true;
      Tmp_121 := Status;  goto L59;
L25:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3216} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L51;
L33:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3218} {:print "Atomic Assignment"}  true;
      sdv_irql_current := sdv_irql_previous;  goto L55;
L40:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L42:
  call {:cexpr "irpsp->CompletionRoutine"} boogie_si_record_li2bpl_int(Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3205} {:print "Atomic Conditional"}  true;
    if(*) { assume irpsp > 0;
  assume (Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)] != 209);  goto L11; } else { assume irpsp > 0;
  assume (Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)] == 209);  goto L12; }
L43:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L44;
L44:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L45;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L46;
L46:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(DeviceObject_8);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_10);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Context_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3208} {:print "Call \"sdv_RunIoCompletionRoutines\" \"CompletionRoutinePower\""}  true;
  call Status := sdv_hash_1073447526( DeviceObject_8, Irp_10, Context_1);   goto L20;
L47:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3209} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L48;
L48:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3209} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L49;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3210} {:print "Atomic Assignment"}  true;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;  goto L50;
L50:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L51:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3216} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L52;
L52:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3216} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L53;
L53:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3216} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L54;
L54:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(DeviceObject_8);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_10);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Context_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3217} {:print "Call \"sdv_RunIoCompletionRoutines\" \"CompletionRoutineRead\""}  true;
  call Status := sdv_hash_211340521( DeviceObject_8, Irp_10, Context_1);   goto L33;
L55:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3218} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L56;
L56:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3218} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L57;
L57:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3219} {:print "Atomic Assignment"}  true;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;  goto L58;
L58:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L24;
L59:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 3312} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_IoGetCurrentIrpStackLocation"} sdv_IoGetCurrentIrpStackLocation(actual_pirp_7:int) returns (Tmp_123:int) {
var  Tmp_124: int;
var  pirp_7: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_7 := actual_pirp_7;
  // done with preamble
  goto L5;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_7)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10707} {:print "Atomic Assignment"}  true;
    assume pirp_7 > 0;
    Tmp_123 := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_7)))];  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10707} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "ExInitializeResourceLite"} ExInitializeResourceLite(actual_Resource_3:int) returns (Tmp_125:int) {
var  Tmp_126: int;
var  sdv_39: int;
var  x_3: int;
var  Resource_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Resource_3 := actual_Resource_3;
  // done with preamble
  goto L12;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7428} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "x"} boogie_si_record_li2bpl_int(x_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7423} {:print "Atomic Conditional"}  true;
    if(*) { assume (x_3 == 0);  goto L9; } else { assume (x_3 != 0);  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7426} {:print "Atomic Assignment"}  true;
      Tmp_125 := -1073741823;  goto L15;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7424} {:print "Atomic Assignment"}  true;
      Tmp_125 := 0;  goto L14;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L14:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "ExAllocatePool"} ExAllocatePool(actual_PoolType_3:int, actual_NumberOfBytes_1:int) returns (Tmp_127:int) {
var  sdv_40: int;
var  sdv_41: int;
var  x_4: int;
var  Tmp_128: int;
var  PoolType_3: int;
var  NumberOfBytes_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  PoolType_3 := actual_PoolType_3;
  NumberOfBytes_1 := actual_NumberOfBytes_1;
  // done with preamble
  goto L16;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7300} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7294} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7297} {:print "Atomic Assignment"}  true;
      Tmp_127 := 0;  goto L19;
L10:
  call {:cexpr "NumberOfBytes"} boogie_si_record_li2bpl_int(NumberOfBytes_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7296} {:print "Atomic Assignment"}  true;
      call sdv_40 := __HAVOC_malloc(NumberOfBytes_1);  goto L13;
L13:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_40);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7296} {:print "Atomic Assignment"}  true;
      Tmp_127 := sdv_40;  goto L18;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "IofCallDriver"} IofCallDriver(actual_DeviceObject_9:int, actual_Irp_11:int) returns (Tmp_129:int) {
var  {:dopa}  completion: int;
var  sdv_42: int;
var  sdv_43: int;
var  sdv_44: int;
var  sdv_45: int;
var  sdv_46: int;
var  status_5: int;
var  Tmp_130: int;
var  choice_2: int;
var  DeviceObject_9: int;
var  Irp_11: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call completion := __HAVOC_malloc(4);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_9 := actual_DeviceObject_9;
  Irp_11 := actual_Irp_11;
  // done with preamble
  goto L92;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9950} {:print "Atomic Assignment"}  true;
    assume completion > 0;
    Mem_T.INT4[completion] := 0;  goto L94;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9953} {:print "Atomic Assignment"}  true;
      status_5 := 259;  goto L95;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10023} {:print "Atomic Assignment"}  true;
    assume Irp_11 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_11))] := -1073741823;  goto L112;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9957} {:print "Atomic Assignment"}  true;
    assume Irp_11 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_11))] := 0;  goto L96;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9979} {:print "Atomic Assignment"}  true;
    assume Irp_11 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_11))] := -1073741536;  goto L102;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10001} {:print "Atomic Assignment"}  true;
    assume Irp_11 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_11))] := 259;  goto L107;
L19:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10007} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_11);  goto L21; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_11);  goto L22; }
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10005} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 259;  goto L109;
L21:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10011} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_11);  goto L23; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_11);  goto L24; }
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10009} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 259;  goto L110;
L23:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10016} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset != 0);  goto L26; } else { assume (sdv_compFset == 0);  goto L29; }
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10013} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 259;  goto L111;
L26:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_11);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10018} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_45 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_11, sdv_context, completion);   goto L29;
L29:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10045} {:print "Atomic Assignment"}  true;
      Tmp_129 := status_5;  goto L101;
L32:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9985} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_11);  goto L34; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_11);  goto L35; }
L33:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9983} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741536;  goto L104;
L34:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9989} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_11);  goto L36; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_11);  goto L37; }
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9987} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741536;  goto L105;
L36:
  call {:cexpr "sdv_invoke_on_cancel"} boogie_si_record_li2bpl_int(sdv_invoke_on_cancel);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9994} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_invoke_on_cancel == 0);  goto L29; } else { assume (sdv_invoke_on_cancel != 0);  goto L39; }
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9991} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741536;  goto L106;
L39:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9994} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset == 0);  goto L29; } else { assume (sdv_compFset != 0);  goto L40; }
L40:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_11);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9996} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_44 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_11, sdv_context, completion);   goto L29;
L45:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9963} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_11);  goto L47; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_11);  goto L48; }
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9961} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 0;  goto L98;
L47:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9967} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_11);  goto L49; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_11);  goto L50; }
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9965} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 0;  goto L99;
L49:
  call {:cexpr "sdv_invoke_on_success"} boogie_si_record_li2bpl_int(sdv_invoke_on_success);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9972} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_invoke_on_success == 0);  goto L29; } else { assume (sdv_invoke_on_success != 0);  goto L52; }
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9969} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 0;  goto L100;
L52:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9972} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset == 0);  goto L29; } else { assume (sdv_compFset != 0);  goto L53; }
L53:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_11);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9974} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_43 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_11, sdv_context, completion);   goto L29;
L58:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10029} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_11);  goto L60; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_11);  goto L61; }
L59:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10027} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741823;  goto L114;
L60:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10033} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_11);  goto L62; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_11);  goto L63; }
L61:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10031} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741823;  goto L115;
L62:
  call {:cexpr "sdv_invoke_on_error"} boogie_si_record_li2bpl_int(sdv_invoke_on_error);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10038} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_invoke_on_error == 0);  goto L29; } else { assume (sdv_invoke_on_error != 0);  goto L65; }
L63:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10035} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741823;  goto L116;
L65:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10038} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset == 0);  goto L29; } else { assume (sdv_compFset != 0);  goto L66; }
L66:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_11);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10040} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_42 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_11, sdv_context, completion);   goto L29;
L70:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L13; } else {  goto L16; }
L71:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L15; } else {  goto L70; }
L92:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L94:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L95:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9954} {:print "Atomic Continuation"}  true;
    if(*) {  goto L14; } else {  goto L71; }
L96:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9958} {:print "Atomic Assignment"}  true;
    assume Irp_11 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_11)] := 0;  goto L97;
L97:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9959} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_11);  goto L45; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_11);  goto L46; }
L98:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L45;
L99:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L47;
L100:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L49;
L101:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10045} {:print "Return"}  true;
    goto LM2;
L102:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9980} {:print "Atomic Assignment"}  true;
    assume Irp_11 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_11)] := 0;  goto L103;
L103:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9981} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_11);  goto L32; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_11);  goto L33; }
L104:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L32;
L105:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L34;
L106:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L36;
L107:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10002} {:print "Atomic Assignment"}  true;
    assume Irp_11 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_11)] := 1;  goto L108;
L108:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10003} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_11);  goto L19; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_11);  goto L20; }
L109:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L19;
L110:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L21;
L111:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L23;
L112:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10024} {:print "Atomic Assignment"}  true;
    assume Irp_11 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_11)] := 0;  goto L113;
L113:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10025} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_11);  goto L58; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_11);  goto L59; }
L114:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L58;
L115:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L60;
L116:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L62;
Lfinal: return;
}
procedure {:origName "KeLeaveCriticalRegion"} KeLeaveCriticalRegion() {
var  Tmp_131: int;
var  Tmp_132: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 12866} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_KeInitializeSpinLock"} sdv_KeInitializeSpinLock(actual_SpinLock_2:int) {
var  Tmp_133: int;
var  Tmp_134: int;
var  SpinLock_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SpinLock_2 := actual_SpinLock_2;
  // done with preamble
  goto L6;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13264} {:print "Atomic Assignment"}  true;
    assume SpinLock_2 > 0;
    Mem_T.INT4[SpinLock_2] := 0;  goto L8;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13266} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoConnectInterrupt"} IoConnectInterrupt(actual_InterruptObject:int, actual_ServiceRoutine:int, actual_ServiceContext:int, actual_SpinLock_3:int, actual_Vector:int, actual_Irql:int, actual_SynchronizeIrql:int, actual_InterruptMode:int, actual_ShareVector:int, actual_ProcessorEnableMask:int, actual_FloatingSave:int) returns (Tmp_135:int) {
var  Tmp_136: int;
var  sdv_47: int;
var  choice_3: int;
var  InterruptObject: int;
var  ServiceRoutine: int;
var  ServiceContext: int;
var  SpinLock_3: int;
var  Vector: int;
var  Irql: int;
var  SynchronizeIrql: int;
var  InterruptMode: int;
var  ShareVector: int;
var  ProcessorEnableMask: int;
var  FloatingSave: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  InterruptObject := actual_InterruptObject;
  ServiceRoutine := actual_ServiceRoutine;
  ServiceContext := actual_ServiceContext;
  SpinLock_3 := actual_SpinLock_3;
  Vector := actual_Vector;
  Irql := actual_Irql;
  SynchronizeIrql := actual_SynchronizeIrql;
  InterruptMode := actual_InterruptMode;
  ShareVector := actual_ShareVector;
  ProcessorEnableMask := actual_ProcessorEnableMask;
  FloatingSave := actual_FloatingSave;
  // done with preamble
  goto L17;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10149} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "ServiceRoutine"} boogie_si_record_li2bpl_int(ServiceRoutine);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10136} {:print "Atomic Assignment"}  true;
      sdv_isr_routine := ServiceRoutine;  goto L19;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10147} {:print "Atomic Assignment"}  true;
      Tmp_135 := -1073741670;  goto L23;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10144} {:print "Atomic Assignment"}  true;
      Tmp_135 := 0;  goto L21;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10146} {:print "Atomic Assignment"}  true;
      Tmp_135 := -1073741811;  goto L22;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L13; }
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L19:
  call {:cexpr "ServiceContext"} boogie_si_record_li2bpl_int(ServiceContext);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10137} {:print "Atomic Assignment"}  true;
      sdv_pDpcContext := ServiceContext;  goto L20;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10138} {:print "Atomic Continuation"}  true;
    if(*) {  goto L12; } else {  goto L15; }
L21:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L22:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L23:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_DoNothing"} sdv_DoNothing() returns (Tmp_137:int) {
var  Tmp_138: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L5;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1515} {:print "Atomic Assignment"}  true;
      Tmp_137 := -1073741823;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1515} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_RunDispatchFunction"} sdv_RunDispatchFunction(actual_po:int, actual_pirp_8:int) returns (Tmp_139:int) {
var  sdv_48: int;
var  sdv_49: int;
var  sdv_50: int;
var  sdv_51: int;
var  sdv_52: int;
var  sdv_53: int;
var  sdv_54: int;
var  sdv_55: int;
var  sdv_56: int;
var  sdv_57: int;
var  sdv_58: int;
var  sdv_59: int;
var  sdv_60: int;
var  sdv_61: int;
var  x_5: int;
var  sdv_62: int;
var  sdv_63: int;
var  Tmp_140: int;
var  status_6: int;
var  sdv_64: int;
var  Tmp_141: int;
var  Tmp_142: int;
var  ps: int;
var  minor: int;
var  sdv_65: int;
var  sdv_66: int;
var  po: int;
var  pirp_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  po := actual_po;
  pirp_8 := actual_pirp_8;
  // done with preamble
  goto L176;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1617} {:print "Atomic Assignment"}  true;
      status_6 := 0;  goto L178;
L14:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_57);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1620} {:print "Atomic Assignment"}  true;
      minor := sdv_57;  goto L179;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1628} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_8)] := 0;  goto L184;
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1641} {:print "Atomic Continuation"}  true;
    if(*) {  goto L38; } else {  goto L169; }
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1998} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1683} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 0;  goto L192;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1664} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 2;  goto L195;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1815} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 3;  goto L196;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1872} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 4;  goto L198;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1796} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 5;  goto L199;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1834} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 6;  goto L200;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1739} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 9;  goto L201;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1732} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1702} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 14;  goto L202;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1758} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 15;  goto L203;
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1979} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 16;  goto L204;
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1789} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L54:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1645} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 18;  goto L205;
L55:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1951} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 22;  goto L206;
L56:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1853} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 23;  goto L208;
L57:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1891} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 27;  goto L209;
L59:
  call {:cexpr "sdv_start_irp_already_issued"} boogie_si_record_li2bpl_int(sdv_start_irp_already_issued);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1897} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_start_irp_already_issued == 0);  goto L216; } else { assume (sdv_start_irp_already_issued != 0);  goto L217; }
L60:
  call {:cexpr "ps->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1900} {:print "Atomic Conditional"}  true;
    if(*) { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] != 3);  goto L61; } else { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] == 3);  goto L62; }
L61:
  call {:cexpr "ps->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1904} {:print "Atomic Conditional"}  true;
    if(*) { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] != 2);  goto L66; } else { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] == 2);  goto L69; }
L62:
  call {:cexpr "sdv_remove_irp_already_issued"} boogie_si_record_li2bpl_int(sdv_remove_irp_already_issued);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1902} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_remove_irp_already_issued == 0);  goto L211; } else { assume (sdv_remove_irp_already_issued != 0);  goto L212; }
L66:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1934} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchPnp\""}  true;
  call status_6 := sdv_hash_590764100( po, pirp_8);   goto L72;
L69:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1906} {:print "Atomic Assignment"}  true;
      sdv_remove_irp_already_issued := 1;  goto L214;
L72:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(status_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 2002} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_stub_dispatch_end\""}  true;
  call sdv_stub_dispatch_end( status_6, 0);   goto L75;
L75:
  call {:cexpr "pirp->IoStatus.Information"} boogie_si_record_li2bpl_int(Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 2004} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    sdv_end_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_8))];  goto L193;
L88:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1961} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchPower\""}  true;
  call status_6 := sdv_hash_86802341( po, pirp_8);   goto L207;
L155:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L35; } else {  goto L57; }
L156:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L56; } else {  goto L155; }
L157:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L55; } else {  goto L156; }
L158:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L54; } else {  goto L157; }
L159:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L51; } else {  goto L158; }
L160:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L50; } else {  goto L159; }
L161:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L49; } else {  goto L160; }
L162:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L48; } else {  goto L161; }
L163:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L45; } else {  goto L162; }
L164:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L44; } else {  goto L163; }
L165:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L43; } else {  goto L164; }
L166:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L42; } else {  goto L165; }
L167:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L41; } else {  goto L166; }
L168:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L40; } else {  goto L167; }
L169:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L39; } else {  goto L168; }
L174:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_140);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1902} {:print "Atomic Continuation"}  true;
  assume(Tmp_140 != 0);   goto L213;
L175:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_141);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1897} {:print "Atomic Continuation"}  true;
  assume(Tmp_141 != 0);   goto L218;
L176:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L178:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L14;
L179:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_8)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1622} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    ps := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_8)))];  goto L180;
L180:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1623} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(pirp_8)] := 0;  goto L181;
L181:
  call {:cexpr "pirp->IoStatus.Information"} boogie_si_record_li2bpl_int(Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1624} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    sdv_start_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_8))];  goto L182;
L182:
  call {:cexpr "sdv_start_info"} boogie_si_record_li2bpl_int(sdv_start_info);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1624} {:print "Atomic Assignment"}  true;
      sdv_end_info := sdv_start_info;  goto L183;
L183:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1626} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_SetStatus\""}  true;
  call sdv_SetStatus( pirp_8);   goto L23;
L184:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1629} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    Mem_T.Cancel__IRP[Cancel__IRP(pirp_8)] := 0;  goto L185;
L185:
  call {:cexpr "minor"} boogie_si_record_li2bpl_int(minor);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1633} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] := minor;  goto L186;
L186:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1634} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(ps)] := 0;  goto L187;
L187:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1635} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := 0;  goto L188;
L188:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1635} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := 0;  goto L189;
L189:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1635} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation)] := 0;  goto L190;
L190:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1637} {:print "Atomic Assignment"}  true;
      sdv_dpc_io_registered := 0;  goto L191;
L191:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1639} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_stub_dispatch_begin\""}  true;
  call sdv_stub_dispatch_begin();   goto L34;
L192:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1685} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchCreate\""}  true;
  call status_6 := sdv_hash_701990220( po, pirp_8);   goto L72;
L193:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 2005} {:print "Atomic Assignment"}  true;
      Tmp_139 := status_6;  goto L194;
L194:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 2005} {:print "Return"}  true;
    goto LM2;
L195:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1676} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L196:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1817} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchRead\""}  true;
  call status_6 := sdv_hash_802080270( po, pirp_8);   goto L197;
L197:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L198:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1884} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L199:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1808} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L200:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1846} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L201:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1751} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L202:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1714} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L203:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1770} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L204:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1991} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L205:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1657} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L206:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1955} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_SetPowerIrpMinorFunction\""}  true;
  call sdv_SetPowerIrpMinorFunction( pirp_8);   goto L88;
L207:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L208:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1855} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchSystemControl\""}  true;
  call status_6 := sdv_hash_1044063384( po, pirp_8);   goto L72;
L209:
  call {:cexpr "ps->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1895} {:print "Atomic Conditional"}  true;
    if(*) { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] == 0);  goto L59; } else { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] != 0);  goto L60; }
L210:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L174;
L211:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_140 := 1;  goto L210;
L212:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_140 := 0;  goto L210;
L213:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L61;
L214:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L215:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L175;
L216:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_141 := 1;  goto L215;
L217:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_141 := 0;  goto L215;
L218:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L60;
Lfinal: return;
}
procedure {:origName "sdv_ExFreePool"} sdv_ExFreePool(actual_P_1:int) {
var  Tmp_143: int;
var  Tmp_144: int;
var  P_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  P_1 := actual_P_1;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7389} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "KeQuerySystemTime"} KeQuerySystemTime(actual_sdv_67:int) returns (Tmp_145:int) {
var  Tmp_146: int;
var  sdv_68: int;
var  sdv_67: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  sdv_67 := actual_sdv_67;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_68);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_145 := sdv_68;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_2_0"} SLIC_ABORT_2_0(actual_caller:int, actual_IoSetCompletionRoutineEx:int, actual_IoSetCompletionRoutineEx_1:int, actual_IoSetCompletionRoutineEx_2:int, actual_IoSetCompletionRoutineEx_3:int) {
var  caller: int;
var  IoSetCompletionRoutineEx: int;
var  IoSetCompletionRoutineEx_1: int;
var  IoSetCompletionRoutineEx_2: int;
var  IoSetCompletionRoutineEx_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller := actual_caller;
  IoSetCompletionRoutineEx := actual_IoSetCompletionRoutineEx;
  IoSetCompletionRoutineEx_1 := actual_IoSetCompletionRoutineEx_1;
  IoSetCompletionRoutineEx_2 := actual_IoSetCompletionRoutineEx_2;
  IoSetCompletionRoutineEx_3 := actual_IoSetCompletionRoutineEx_3;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller := caller;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "IoSetCompletionRoutineEx"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      IoSetCompletionRoutineEx := IoSetCompletionRoutineEx;  goto L6;
L6:
  call {:cexpr "IoSetCompletionRoutineEx"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_1);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      IoSetCompletionRoutineEx_1 := IoSetCompletionRoutineEx_1;  goto L7;
L7:
  call {:cexpr "IoSetCompletionRoutineEx"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      IoSetCompletionRoutineEx_2 := IoSetCompletionRoutineEx_2;  goto L8;
L8:
  call {:cexpr "IoSetCompletionRoutineEx"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      IoSetCompletionRoutineEx_3 := IoSetCompletionRoutineEx_3;  goto L9;
L9:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_2_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "KeSetEvent needs to be called in the completion routine when Irp->PendingReturned is TRUE and processing a async. irp. In this case the completion routine will not be called."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl1);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_IoSetCompletionRoutine_entry"} SLIC_sdv_IoSetCompletionRoutine_entry(actual_caller_1:int, actual_sdv_69:int, actual_sdv_70:int, actual_sdv_71:int, actual_sdv_72:int) {
var  caller_1: int;
var  sdv_69: int;
var  sdv_70: int;
var  sdv_71: int;
var  sdv_72: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_1 := actual_caller_1;
  sdv_69 := actual_sdv_69;
  sdv_70 := actual_sdv_70;
  sdv_71 := actual_sdv_71;
  sdv_72 := actual_sdv_72;
  // done with preamble
  goto L17;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_69);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_70);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(sdv_71);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(sdv_72);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 49} {:print "Call \"SLIC_sdv_IoSetCompletionRoutine_entry\" \"SLIC_ABORT_4_0\""}  true;
  call SLIC_ABORT_4_0( caller_1, sdv_69, sdv_70, sdv_71, sdv_72);   goto L19;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_IoSetCompletionRoutine_entry\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl2);   goto L2;
L7:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_70);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 47} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_70 != 0);  goto L6; } else { assume (sdv_70 == 0);  goto L11; }
L8:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_69);
  call {:cexpr "sdv_irp"} boogie_si_record_li2bpl_int(sdv_irp);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 47} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_69 == sdv_irp);  goto L4; } else { assume (sdv_69 != sdv_irp);  goto L6; }
L9:
  call {:cexpr "SignalState"} boogie_si_record_li2bpl_int(SignalState);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 47} {:print "Atomic Conditional"}  true;
    if(*) { assume (SignalState != 0);  goto L6; } else { assume (SignalState == 0);  goto L8; }
L10:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_72);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 47} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_72 != 0);  goto L6; } else { assume (sdv_72 == 0);  goto L9; }
L11:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_71);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 47} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_71 != 0);  goto L6; } else { assume (sdv_71 == 0);  goto L10; }
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L19:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_KeInitializeEvent_exit"} SLIC_KeInitializeEvent_exit(actual_caller_2:int, actual_KeInitializeEvent_1:int) {
var  caller_2: int;
var  KeInitializeEvent_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_2 := actual_caller_2;
  KeInitializeEvent_1 := actual_KeInitializeEvent_1;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_KeInitializeEvent_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl2);   goto L2;
L5:
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 29} {:print "Atomic Assignment"}  true;
      SignalState := 0;  goto L9;
L6:
  call {:cexpr "KeInitializeEvent"} boogie_si_record_li2bpl_int(KeInitializeEvent_1);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 22} {:print "Atomic Conditional"}  true;
    if(*) { assume (KeInitializeEvent_1 != 0);  goto L4; } else { assume (KeInitializeEvent_1 == 0);  goto L5; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ERROR_ROUTINE"} SLIC_ERROR_ROUTINE(actual_msg:int) {
var  msg: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  msg := actual_msg;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      yogi_error := 1;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "_sdv_init4"} _sdv_init4() {
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      SLAM_guard_O_0 := SLAM_guard_O_0_init;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 15} {:print "Atomic Assignment"}  true;
      SignalState := 2;  goto L6;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      yogi_error := 0;  goto L7;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_cancelFptr := 0;  goto L8;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_EXIT_ROUTINE"} SLIC_EXIT_ROUTINE(actual_msg_1:int) {
var  msg_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  msg_1 := actual_msg_1;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
  assume(false);   goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_IoSetCompletionRoutineEx_entry"} SLIC_IoSetCompletionRoutineEx_entry(actual_caller_3:int, actual_IoSetCompletionRoutineEx_4:int, actual_IoSetCompletionRoutineEx_5:int, actual_IoSetCompletionRoutineEx_6:int, actual_IoSetCompletionRoutineEx_7:int) {
var  caller_3: int;
var  IoSetCompletionRoutineEx_4: int;
var  IoSetCompletionRoutineEx_5: int;
var  IoSetCompletionRoutineEx_6: int;
var  IoSetCompletionRoutineEx_7: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_3 := actual_caller_3;
  IoSetCompletionRoutineEx_4 := actual_IoSetCompletionRoutineEx_4;
  IoSetCompletionRoutineEx_5 := actual_IoSetCompletionRoutineEx_5;
  IoSetCompletionRoutineEx_6 := actual_IoSetCompletionRoutineEx_6;
  IoSetCompletionRoutineEx_7 := actual_IoSetCompletionRoutineEx_7;
  // done with preamble
  goto L17;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_4);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_5);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_6);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_7);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 37} {:print "Call \"SLIC_IoSetCompletionRoutineEx_entry\" \"SLIC_ABORT_2_0\""}  true;
  call SLIC_ABORT_2_0( caller_3, IoSetCompletionRoutineEx_4, IoSetCompletionRoutineEx_5, IoSetCompletionRoutineEx_6, IoSetCompletionRoutineEx_7);   goto L19;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_IoSetCompletionRoutineEx_entry\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl2);   goto L2;
L7:
  call {:cexpr "IoSetCompletionRoutineEx"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_5);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 35} {:print "Atomic Conditional"}  true;
    if(*) { assume (IoSetCompletionRoutineEx_5 != 0);  goto L6; } else { assume (IoSetCompletionRoutineEx_5 == 0);  goto L11; }
L8:
  call {:cexpr "IoSetCompletionRoutineEx"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_4);
  call {:cexpr "sdv_irp"} boogie_si_record_li2bpl_int(sdv_irp);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 35} {:print "Atomic Conditional"}  true;
    if(*) { assume (IoSetCompletionRoutineEx_4 == sdv_irp);  goto L4; } else { assume (IoSetCompletionRoutineEx_4 != sdv_irp);  goto L6; }
L9:
  call {:cexpr "SignalState"} boogie_si_record_li2bpl_int(SignalState);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 35} {:print "Atomic Conditional"}  true;
    if(*) { assume (SignalState != 0);  goto L6; } else { assume (SignalState == 0);  goto L8; }
L10:
  call {:cexpr "IoSetCompletionRoutineEx"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_7);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 35} {:print "Atomic Conditional"}  true;
    if(*) { assume (IoSetCompletionRoutineEx_7 != 0);  goto L6; } else { assume (IoSetCompletionRoutineEx_7 == 0);  goto L9; }
L11:
  call {:cexpr "IoSetCompletionRoutineEx"} boogie_si_record_li2bpl_int(IoSetCompletionRoutineEx_6);
  assert {:sourcefile "..\..\..\rules\WDM\SignalEventInCompletion2.slic"} {:sourceline 35} {:print "Atomic Conditional"}  true;
    if(*) { assume (IoSetCompletionRoutineEx_6 != 0);  goto L6; } else { assume (IoSetCompletionRoutineEx_6 == 0);  goto L10; }
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L19:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_4_0"} SLIC_ABORT_4_0(actual_caller_4:int, actual_sdv_73:int, actual_sdv_74:int, actual_sdv_75:int, actual_sdv_76:int) {
var  caller_4: int;
var  sdv_73: int;
var  sdv_74: int;
var  sdv_75: int;
var  sdv_76: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_4 := actual_caller_4;
  sdv_73 := actual_sdv_73;
  sdv_74 := actual_sdv_74;
  sdv_75 := actual_sdv_75;
  sdv_76 := actual_sdv_76;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_4);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_4 := caller_4;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_73);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_73 := sdv_73;  goto L6;
L6:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_74);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_74 := sdv_74;  goto L7;
L7:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_75);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_75 := sdv_75;  goto L8;
L8:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_76);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_76 := sdv_76;  goto L9;
L9:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_4_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "KeSetEvent needs to be called in the completion routine when Irp->PendingReturned is TRUE and processing a async. irp.In this case the completion routine will not be called."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl3);   goto L2;
Lfinal: return;
}
// ----- Decls -------
var Mem_T.Acquired_DRIVER_RESOURCE: [int] int;
var Mem_T.Blink__LIST_ENTRY: [int] int;
var Mem_T.CancelRoutine__IRP: [int] int;
var Mem_T.Cancel__IRP: [int] int;
var Mem_T.CompletionRoutine__IO_STACK_LOCATION: [int] int;
var Mem_T.ControllerVector__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.CurrentStackLocation_unnamed_tag_7: [int] int;
var Mem_T.DataSize__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.Data_DEVICE_DATA: [int] int;
var Mem_T.DeviceExtension__DEVICE_OBJECT: [int] int;
var Mem_T.Flink__LIST_ENTRY: [int] int;
var Mem_T.INT4: [int] int;
var Mem_T.Information__IO_STATUS_BLOCK: [int] int;
var Mem_T.Length_unnamed_tag_18: [int] int;
var Mem_T.MajorFunction__IO_STACK_LOCATION: [int] int;
var Mem_T.MinorFunction__IO_STACK_LOCATION: [int] int;
var Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.PDEVICE_DATA: [int] int;
var Mem_T.PendingReturned__IRP: [int] int;
var Mem_T.QuadPart__LARGE_INTEGER: [int] int;
var Mem_T.RequiredBufferLength_DEVICE_DATA: [int] int;
var Mem_T.Resource_DRIVER_RESOURCE: [int] int;
var Mem_T.SignalState__DISPATCHER_HEADER: [int] int;
var Mem_T.Signalling__DISPATCHER_HEADER: [int] int;
var Mem_T.Size__DISPATCHER_HEADER: [int] int;
var Mem_T.Status__IO_STATUS_BLOCK: [int] int;
var Mem_T.SystemBuffer_unnamed_tag_2: [int] int;
var Mem_T.Type_unnamed_tag_28: [int] int;
var Mem_T.Type_unnamed_tag_39: [int] int;
var Mem_T.VOID: [int] int;
var Mem_T._KEVENT: [int] int;
var Mem_T.capacity_sdv_hash_925174249: [int] int;
var Mem_T.currentsize_sdv_hash_925174249: [int] int;
var Mem_T.deviceData__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.pitems_sdv_hash_925174249: [int] int;
var Mem_T.sdv_derived_object_DEVICE_DATA: [int] int;
var Mem_T.sdv_derived_object_DEVICE_DATA_BAG: [int] int;
var Mem_T.sdv_derived_object_sdv_hash_925174249: [int] int;
var Mem_T.sdv_hash_925174249: [int] int;
procedure {:dopa "Mem_T.INT4"} dummy_for_pa();
procedure corralExtraInit() {
   assume (forall x : int :: {Mem_T.CancelRoutine__IRP[x]} (Mem_T.CancelRoutine__IRP[x] <= 0 || Mem_T.CancelRoutine__IRP[x] > 299));
   assume (forall x : int :: {Mem_T.CompletionRoutine__IO_STACK_LOCATION[x]} (Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] <= 0 || Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] > 299));
}
function {:inline true} {:fieldmap "Mem_T.Acquired_DRIVER_RESOURCE"}  {:fieldname "Acquired"}  Acquired_DRIVER_RESOURCE(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.AssociatedIrp__IRP"}  {:fieldname "AssociatedIrp"}  AssociatedIrp__IRP(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.Blink__LIST_ENTRY"}  {:fieldname "Blink"}  Blink__LIST_ENTRY(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.CancelRoutine__IRP"}  {:fieldname "CancelRoutine"}  CancelRoutine__IRP(x:int) returns (int) {x + 120}
function {:inline true} {:fieldmap "Mem_T.Cancel__IRP"}  {:fieldname "Cancel"}  Cancel__IRP(x:int) returns (int) {x + 64}
function {:inline true} {:fieldmap "Mem_T.CompletionRoutine__IO_STACK_LOCATION"}  {:fieldname "CompletionRoutine"}  CompletionRoutine__IO_STACK_LOCATION(x:int) returns (int) {x + 536}
function {:inline true} {:fieldmap "Mem_T.ControllerVector__DRIVER_DEVICE_EXTENSION"}  {:fieldname "ControllerVector"}  ControllerVector__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.CurrentStackLocation_unnamed_tag_7"}  {:fieldname "CurrentStackLocation"}  CurrentStackLocation_unnamed_tag_7(x:int) returns (int) {x + 48}
function {:inline true} {:fieldmap "Mem_T.DataSize__DRIVER_DEVICE_EXTENSION"}  {:fieldname "DataSize"}  DataSize__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 32}
function {:inline true} {:fieldmap "Mem_T.Data_DEVICE_DATA"}  {:fieldname "Data"}  Data_DEVICE_DATA(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.DeviceExtension__DEVICE_OBJECT"}  {:fieldname "DeviceExtension"}  DeviceExtension__DEVICE_OBJECT(x:int) returns (int) {x + 44}
function {:inline true} {:fieldmap "Mem_T.Flink__LIST_ENTRY"}  {:fieldname "Flink"}  Flink__LIST_ENTRY(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Header__KEVENT"}  {:fieldname "Header"}  Header__KEVENT(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Information__IO_STATUS_BLOCK"}  {:fieldname "Information"}  Information__IO_STATUS_BLOCK(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.IoStatus__IRP"}  {:fieldname "IoStatus"}  IoStatus__IRP(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.Length_unnamed_tag_18"}  {:fieldname "Length"}  Length_unnamed_tag_18(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.MajorFunction__IO_STACK_LOCATION"}  {:fieldname "MajorFunction"}  MajorFunction__IO_STACK_LOCATION(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.MinorFunction__IO_STACK_LOCATION"}  {:fieldname "MinorFunction"}  MinorFunction__IO_STACK_LOCATION(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION"}  {:fieldname "NextLowerDriver"}  NextLowerDriver__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 20}
function {:inline true} {:fieldmap "Mem_T.Overlay_unnamed_tag_6"}  {:fieldname "Overlay"}  Overlay_unnamed_tag_6(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Parameters__IO_STACK_LOCATION"}  {:fieldname "Parameters"}  Parameters__IO_STACK_LOCATION(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.PendingReturned__IRP"}  {:fieldname "PendingReturned"}  PendingReturned__IRP(x:int) returns (int) {x + 52}
function {:inline true} {:fieldmap "Mem_T.Power_unnamed_tag_8"}  {:fieldname "Power"}  Power_unnamed_tag_8(x:int) returns (int) {x + 420}
function {:inline true} {:fieldmap "Mem_T.QuadPart__LARGE_INTEGER"}  {:fieldname "QuadPart"}  QuadPart__LARGE_INTEGER(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.Read_unnamed_tag_8"}  {:fieldname "Read"}  Read_unnamed_tag_8(x:int) returns (int) {x + 60}
function {:inline true} {:fieldmap "Mem_T.RequiredBufferLength_DEVICE_DATA"}  {:fieldname "RequiredBufferLength"}  RequiredBufferLength_DEVICE_DATA(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.Resource_DRIVER_RESOURCE"}  {:fieldname "Resource"}  Resource_DRIVER_RESOURCE(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.SignalState__DISPATCHER_HEADER"}  {:fieldname "SignalState"}  SignalState__DISPATCHER_HEADER(x:int) returns (int) {x + 96}
function {:inline true} {:fieldmap "Mem_T.Signalling__DISPATCHER_HEADER"}  {:fieldname "Signalling"}  Signalling__DISPATCHER_HEADER(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.Size__DISPATCHER_HEADER"}  {:fieldname "Size"}  Size__DISPATCHER_HEADER(x:int) returns (int) {x + 56}
function {:inline true} {:fieldmap "Mem_T.Status__IO_STATUS_BLOCK"}  {:fieldname "Status"}  Status__IO_STATUS_BLOCK(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.SystemBuffer_unnamed_tag_2"}  {:fieldname "SystemBuffer"}  SystemBuffer_unnamed_tag_2(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.Tail__IRP"}  {:fieldname "Tail"}  Tail__IRP(x:int) returns (int) {x + 128}
function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_28"}  {:fieldname "Type"}  Type_unnamed_tag_28(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_39"}  {:fieldname "Type"}  Type_unnamed_tag_39(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.WaitListHead__DISPATCHER_HEADER"}  {:fieldname "WaitListHead"}  WaitListHead__DISPATCHER_HEADER(x:int) returns (int) {x + 100}
function {:inline true} {:fieldmap "Mem_T.capacity_sdv_hash_925174249"}  {:fieldname "capacity"}  capacity_sdv_hash_925174249(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.currentsize_sdv_hash_925174249"}  {:fieldname "currentsize"}  currentsize_sdv_hash_925174249(x:int) returns (int) {x + 12}
function {:inline true} {:fieldmap "Mem_T.deviceData__DRIVER_DEVICE_EXTENSION"}  {:fieldname "deviceData"}  deviceData__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.pitems_sdv_hash_925174249"}  {:fieldname "pitems"}  pitems_sdv_hash_925174249(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.sdv_derived_object_DEVICE_DATA"}  {:fieldname "sdv_derived_object"}  sdv_derived_object_DEVICE_DATA(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.sdv_derived_object_DEVICE_DATA_BAG"}  {:fieldname "sdv_derived_object"}  sdv_derived_object_DEVICE_DATA_BAG(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.sdv_derived_object_sdv_hash_925174249"}  {:fieldname "sdv_derived_object"}  sdv_derived_object_sdv_hash_925174249(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.sdv_hash_925174249"}  {:fieldname "sdv_hash_925174249"}  sdv_hash_925174249_DEVICE_DATA_BAG(x:int) returns (int) {x + 4}
const {:string "KeSetEvent needs to be called in the completion routine when Irp->PendingReturned is TRUE and processing a async. irp. In this case the completion routine will not be called."} unique strConst__li2bpl1: int;
const {:string "KeSetEvent needs to be called in the completion routine when Irp->PendingReturned is TRUE and processing a async. irp.In this case the completion routine will not be called."} unique strConst__li2bpl3: int;
const {:string "callee"} unique strConst__li2bpl0: int;
const {:string "halt"} unique strConst__li2bpl2: int;

function {:aliasingQuery} alias1(x:int,y:int):bool;
function {:aliasingQuery} alias2(x:int,y:int):bool;
