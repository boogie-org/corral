procedure corral_nondet() returns (x:int);
procedure boogie_si_record_li2bpl_int(x:int);
var alloc: int;
procedure {:allocator} __HAVOC_malloc(size:int) returns (ret: int);
   modifies alloc;
   free requires size >= 0;
   free ensures ret == old(alloc);
   free ensures alloc >= old(alloc) + size;

procedure {:allocator} __HAVOC_malloc_or_null(size:int) returns (ret: int);
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
var sdv_kdpc:int;
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
var sdv_driver_object:int;
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
var sdv_pv3:int;
var sdv_MapRegisterBase_val:int;
var sdv_kdpc_val3:int;
var sdv_inside_init_entrypoint:int;
var sdv_pv2:int;
var sdv_apc_disabled:int;
var sdv_pv1:int;
var sdv_IoGetDmaAdapter_DMA_ADAPTER:int;
var s:int;
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
var  {:dopa}  spinLock: int;
var  Tmp_9: int;
var  Tmp_10: int;
var  oldIrql: int;
var  Tmp_11: int;
var  this_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call spinLock := __HAVOC_malloc(4);
  // initialize local variables to 0
  // copy formal-ins to locals
  this_2 := actual_this_2;
  // done with preamble
  goto L28;
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
    assume spinLock > 0;
    Mem_T.INT4[spinLock] := 0;  goto L30;
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
    Tmp_11 := Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_2)];  goto L39;
L20:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_10]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume spinLock > 0;
  assume Tmp_10 > 0;
    Mem_T.INT4[spinLock] := Mem_T.INT4[Tmp_10];  goto L33;
L21:
  call {:cexpr "spinLock"} boogie_si_record_li2bpl_int(Mem_T.INT4[spinLock]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume spinLock > 0;
  assume Tmp_10 > 0;
    Mem_T.INT4[Tmp_10] := Mem_T.INT4[spinLock];  goto L32;
L22:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_10]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_10 > 0;
    oldIrql := Mem_T.INT4[Tmp_10];  goto L38;
L23:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_10 > 0;
    Mem_T.INT4[Tmp_10] := oldIrql;  goto L34;
L24:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_10);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 163} {:print "Call \"BAG<DEVICE_DATA *>::~BAG<DEVICE_DATA *>\" \"sdv_KeAcquireSpinLock\""}  true;
  call sdv_KeAcquireSpinLock( 0, Tmp_10);   goto L25;
L25:
  call {:cexpr "&spinLock"} boogie_si_record_li2bpl_int(spinLock);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias1(SLAM_guard_O_0, spinLock);
    if(*) { assume (!((spinLock == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init)));  goto L22; } else { assume ((spinLock == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init));  goto L26; }
L26:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 163} {:print "Call \"BAG<DEVICE_DATA *>::~BAG<DEVICE_DATA *>\" \"SLIC_sdv_KeAcquireSpinLock_exit\""}  true;
  call SLIC_sdv_KeAcquireSpinLock_exit( 0);   goto L22;
L28:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L30:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 157} {:print "Atomic Assignment"}  true;
      oldIrql := 0;  goto L31;
L31:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_10 := __HAVOC_malloc(4);  goto L21;
L32:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_10);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 162} {:print "Call \"BAG<DEVICE_DATA *>::~BAG<DEVICE_DATA *>\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_10);   goto L20;
L33:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L10;
L34:
  call {:cexpr "&spinLock"} boogie_si_record_li2bpl_int(spinLock);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      SLAM_guard_O_0 := spinLock;  goto L35;
L35:
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
  assume(SLAM_guard_O_0 != SLAM_guard_O_0_init);   goto L36;
L36:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 163} {:print "Call \"BAG<DEVICE_DATA *>::~BAG<DEVICE_DATA *>\" \"SLIC_sdv_KeAcquireSpinLock_entry\""}  true;
  call SLIC_sdv_KeAcquireSpinLock_entry( strConst__li2bpl0);   goto L37;
L37:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L24; }
L38:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L13;
L39:
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
procedure {:origName "sdv_hash_945836574"} sdv_hash_945836574(actual_Dpc:int, actual_DeviceObject:int, actual_Irp:int, actual_Context:int) {
var  Tmp_16: int;
var  Tmp_17: int;
var  Dpc: int;
var  DeviceObject: int;
var  Irp: int;
var  Context: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Dpc := actual_Dpc;
  DeviceObject := actual_DeviceObject;
  Irp := actual_Irp;
  Context := actual_Context;
  // done with preamble
  goto L5;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 397} {:print "Call \"DpcForIsrRoutine\" \"SLIC_sdv_hash_945836574_exit\""}  true;
  call SLIC_sdv_hash_945836574_exit( strConst__li2bpl1);   goto L7;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 397} {:print "Return"}  true;
    goto LM2;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L4; }
Lfinal: return;
}
procedure {:origName "DriverEntry"} DriverEntry(actual_DriverObject:int, actual_RegistryPath:int) returns (Tmp_18:int) {
var  Tmp_19: int;
var  Tmp_20: int;
var  Tmp_21: int;
var  Tmp_22: int;
var  Tmp_23: int;
var  Tmp_24: int;
var  Tmp_25: int;
var  DriverObject: int;
var  RegistryPath: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DriverObject := actual_DriverObject;
  RegistryPath := actual_RegistryPath;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 35} {:print "Atomic Assignment"}  true;
    assume DriverObject > 0;
    Tmp_20 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)];  goto L15;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 43} {:print "Return"}  true;
    goto LM2;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_20 := __HAVOC_malloc(112);
    call Tmp_21 := __HAVOC_malloc(112);
    call Tmp_22 := __HAVOC_malloc(112);
    call Tmp_24 := __HAVOC_malloc(112);
    call Tmp_25 := __HAVOC_malloc(112);  goto L0;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 35} {:print "Atomic Assignment"}  true;
    assume Tmp_20 > 0;
    Mem_T.INT4[Tmp_20] := 200;  goto L16;
L16:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 36} {:print "Atomic Assignment"}  true;
    assume DriverObject > 0;
    Tmp_24 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)];  goto L17;
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 36} {:print "Atomic Assignment"}  true;
    assume Tmp_24 > 0;
    Mem_T.INT4[(Tmp_24 + (3 * 4))] := 201;  goto L18;
L18:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 37} {:print "Atomic Assignment"}  true;
    assume DriverObject > 0;
    Tmp_21 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)];  goto L19;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 37} {:print "Atomic Assignment"}  true;
    assume Tmp_21 > 0;
    Mem_T.INT4[(Tmp_21 + (22 * 4))] := 202;  goto L20;
L20:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 38} {:print "Atomic Assignment"}  true;
    assume DriverObject > 0;
    Tmp_25 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)];  goto L21;
L21:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 38} {:print "Atomic Assignment"}  true;
    assume Tmp_25 > 0;
    Mem_T.INT4[(Tmp_25 + (23 * 4))] := 203;  goto L22;
L22:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 39} {:print "Atomic Assignment"}  true;
    assume DriverObject > 0;
    Tmp_22 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject)];  goto L23;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 39} {:print "Atomic Assignment"}  true;
    assume Tmp_22 > 0;
    Mem_T.INT4[(Tmp_22 + (27 * 4))] := 204;  goto L24;
L24:
  call {:cexpr "DriverObject->DriverExtension"} boogie_si_record_li2bpl_int(Mem_T.DriverExtension__DRIVER_OBJECT[DriverExtension__DRIVER_OBJECT(DriverObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 40} {:print "Atomic Assignment"}  true;
    assume DriverObject > 0;
    Tmp_19 := Mem_T.DriverExtension__DRIVER_OBJECT[DriverExtension__DRIVER_OBJECT(DriverObject)];  goto L25;
L25:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 40} {:print "Atomic Assignment"}  true;
    assume Tmp_19 > 0;
    Mem_T.AddDevice__DRIVER_EXTENSION[AddDevice__DRIVER_EXTENSION(Tmp_19)] := 205;  goto L26;
L26:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 41} {:print "Atomic Assignment"}  true;
    assume DriverObject > 0;
    Mem_T.DriverUnload__DRIVER_OBJECT[DriverUnload__DRIVER_OBJECT(DriverObject)] := 206;  goto L27;
L27:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 43} {:print "Atomic Assignment"}  true;
      Tmp_18 := 0;  goto L28;
L28:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 43} {:print "Call \"DriverEntry\" \"SLIC_DriverEntry_exit\""}  true;
  call SLIC_DriverEntry_exit( strConst__li2bpl1);   goto L29;
L29:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L12; }
Lfinal: return;
}
procedure {:origName "sdv_hash_817957157"} sdv_hash_817957157(actual_DriverObject_1:int) {
var  Tmp_26: int;
var  Tmp_27: int;
var  DriverObject_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DriverObject_1 := actual_DriverObject_1;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 322} {:print "Call \"DriverUnload\" \"SLIC_sdv_hash_817957157_exit\""}  true;
  call SLIC_sdv_hash_817957157_exit( strConst__li2bpl1);   goto L10;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 321} {:print "Call \"DriverUnload\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L1;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 322} {:print "Return"}  true;
    goto LM2;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L7; }
Lfinal: return;
}
procedure {:origName "sdv_hash_309625472"} sdv_hash_309625472(actual_this_4:int, actual_Item:int) returns (Tmp_28:int) {
var  Tmp_29: int;
var  {:dopa}  spinLock_1: int;
var  Tmp_30: int;
var  Tmp_31: int;
var  oldIrql_1: int;
var  this_4: int;
var  Item: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call spinLock_1 := __HAVOC_malloc(4);
  // initialize local variables to 0
  // copy formal-ins to locals
  this_4 := actual_this_4;
  Item := actual_Item;
  // done with preamble
  goto L34;
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
    assume spinLock_1 > 0;
    Mem_T.INT4[spinLock_1] := 0;  goto L36;
L10:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_29 := __HAVOC_malloc(4);  goto L24;
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
    Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)] := (Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)] + 1);  goto L44;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 182} {:print "Atomic Assignment"}  true;
      Tmp_28 := -1073741789;  goto L43;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 189} {:print "Atomic Assignment"}  true;
      Tmp_28 := 0;  goto L49;
L21:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_29]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume spinLock_1 > 0;
  assume Tmp_29 > 0;
    Mem_T.INT4[spinLock_1] := Mem_T.INT4[Tmp_29];  goto L39;
L22:
  call {:cexpr "spinLock"} boogie_si_record_li2bpl_int(Mem_T.INT4[spinLock_1]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume spinLock_1 > 0;
  assume Tmp_29 > 0;
    Mem_T.INT4[Tmp_29] := Mem_T.INT4[spinLock_1];  goto L38;
L23:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_29]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_29 > 0;
    oldIrql_1 := Mem_T.INT4[Tmp_29];  goto L42;
L24:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql_1);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_29 > 0;
    Mem_T.INT4[Tmp_29] := oldIrql_1;  goto L40;
L25:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_29);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 178} {:print "Call \"BAG<DEVICE_DATA *>::Insert\" \"sdv_KeAcquireSpinLock\""}  true;
  call sdv_KeAcquireSpinLock( 0, Tmp_29);   goto L28;
L26:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 178} {:print "Call \"BAG<DEVICE_DATA *>::Insert\" \"SLIC_sdv_KeAcquireSpinLock_entry\""}  true;
  call SLIC_sdv_KeAcquireSpinLock_entry( strConst__li2bpl0);   goto L41;
L28:
  call {:cexpr "&spinLock"} boogie_si_record_li2bpl_int(spinLock_1);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias2(SLAM_guard_O_0, spinLock_1);
    if(*) { assume (!((spinLock_1 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init)));  goto L23; } else { assume ((spinLock_1 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init));  goto L29; }
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 178} {:print "Call \"BAG<DEVICE_DATA *>::Insert\" \"SLIC_sdv_KeAcquireSpinLock_exit\""}  true;
  call SLIC_sdv_KeAcquireSpinLock_exit( 0);   goto L23;
L31:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(oldIrql_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 187} {:print "Call \"BAG<DEVICE_DATA *>::Insert\" \"sdv_KeReleaseSpinLock\""}  true;
  call sdv_KeReleaseSpinLock( 0, oldIrql_1);   goto L19;
L32:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 187} {:print "Call \"BAG<DEVICE_DATA *>::Insert\" \"SLIC_sdv_KeReleaseSpinLock_entry\""}  true;
  call SLIC_sdv_KeReleaseSpinLock_entry( strConst__li2bpl0);   goto L48;
L34:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L36:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 175} {:print "Atomic Assignment"}  true;
      oldIrql_1 := 0;  goto L37;
L37:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_29 := __HAVOC_malloc(4);  goto L22;
L38:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_29);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 177} {:print "Call \"BAG<DEVICE_DATA *>::Insert\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_29);   goto L21;
L39:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L10;
L40:
  call {:cexpr "&spinLock"} boogie_si_record_li2bpl_int(spinLock_1);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias3(SLAM_guard_O_0, spinLock_1);
    if(*) { assume (!((spinLock_1 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init)));  goto L25; } else { assume ((spinLock_1 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init));  goto L26; }
L41:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L25; }
L42:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L13;
L43:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L44:
  call {:cexpr "this->currentsize"} boogie_si_record_li2bpl_int(Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 185} {:print "Atomic Assignment"}  true;
    assume this_4 > 0;
    Tmp_31 := Mem_T.currentsize_sdv_hash_925174249[currentsize_sdv_hash_925174249(this_4)];  goto L45;
L45:
  call {:cexpr "this->pitems"} boogie_si_record_li2bpl_int(Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 185} {:print "Atomic Assignment"}  true;
    assume this_4 > 0;
    Tmp_30 := Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(this_4)];  goto L46;
L46:
  call {:cexpr "Item"} boogie_si_record_li2bpl_int(Item);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 185} {:print "Atomic Assignment"}  true;
    assume Tmp_30 > 0;
    Mem_T.PDEVICE_DATA[(Tmp_30 + (Tmp_31 * 4))] := Item;  goto L47;
L47:
  call {:cexpr "&spinLock"} boogie_si_record_li2bpl_int(spinLock_1);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias4(SLAM_guard_O_0, spinLock_1);
    if(*) { assume (!((spinLock_1 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init)));  goto L31; } else { assume ((spinLock_1 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init));  goto L32; }
L48:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L31; }
L49:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_hash_113115260"} sdv_hash_113115260(actual_this_5:int) {
var  sdv_1: int;
var  sdv_2: int;
var  Tmp_32: int;
var  Tmp_33: int;
var  Tmp_34: int;
var  i: int;
var  time: int;
var  newItem: int;
var  Tmp_35: int;
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
      Tmp_35 := sdv_2;  goto L33;
L18:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_35);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Atomic Assignment"}  true;
      newItem := Tmp_35;  goto L36;
L19:
  call {:cexpr "time.QuadPart"} boogie_si_record_li2bpl_int(Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(time)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Atomic Assignment"}  true;
    assume time > 0;
    Tmp_33 := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(time)];  goto L35;
L26:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 247} {:print "Atomic Assignment"}  true;
      i := (i + 1);  goto L38;
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
    assume Tmp_35 > 0;
    Mem_T.sdv_derived_object_DEVICE_DATA[sdv_derived_object_DEVICE_DATA(Tmp_35)] := 0;  goto L34;
L34:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_35);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Atomic Conditional"}  true;
    if(*) { assume (Tmp_35 == 0);  goto L18; } else { assume (Tmp_35 != 0);  goto L19; }
L35:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_35);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_33);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(512);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 251} {:print "Call \"DEVICE_DATA_BAG::PopulateBag\" \"DEVICE_DATA::DEVICE_DATA\""}  true;
  call sdv_hash_346367737_sdv_special_CTOR( Tmp_35, Tmp_33, 512);   goto L18;
L36:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_hash_925174249_DEVICE_DATA_BAG(this_5));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(newItem);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 253} {:print "Call \"DEVICE_DATA_BAG::PopulateBag\" \"BAG<DEVICE_DATA *>::Insert\""}  true;
  assume this_5 > 0;
  call sdv_1 := sdv_hash_309625472( sdv_hash_925174249_DEVICE_DATA_BAG(this_5), newItem);   goto L37;
L37:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L26; }
L38:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L9;
Lfinal: return;
}
procedure {:origName "sdv_hash_231029696"} sdv_hash_231029696(actual_Irp_1:int, actual_Data:int) returns (Tmp_36:int) {
var  Tmp_37: int;
var  Tmp_38: int;
var  Irp_1: int;
var  Data: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Irp_1 := actual_Irp_1;
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
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_1))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 403} {:print "Atomic Assignment"}  true;
    assume Irp_1 > 0;
    Tmp_38 := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_1))];  goto L8;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L8:
  call {:cexpr "*Data"} boogie_si_record_li2bpl_int(Mem_T.INT4[Data]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 403} {:print "Atomic Assignment"}  true;
    assume Tmp_38 > 0;
  assume Data > 0;
    Mem_T.INT4[Tmp_38] := Mem_T.INT4[Data];  goto L9;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 405} {:print "Atomic Assignment"}  true;
      Tmp_36 := 0;  goto L10;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 405} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_89676855"} sdv_hash_89676855(actual_this_6:int) returns (Tmp_39:int) {
var  Tmp_40: int;
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
    Tmp_39 := Mem_T.Data_DEVICE_DATA[Data_DEVICE_DATA(this_6)];  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 90} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_802080270"} sdv_hash_802080270(actual_DeviceObject_1:int, actual_Irp_2:int) returns (Tmp_41:int) {
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
var  Tmp_42: int;
var  sdv_12: int;
var  status: int;
var  Tmp_43: int;
var  extension: int;
var  deviceDataItem: int;
var  Tmp_44: int;
var  waitEvent: int;
var  {:dopa}  longData: int;
var  sdv_13: int;
var  sdv_14: int;
var  resource: int;
var  timeout: int;
var  DeviceObject_1: int;
var  Irp_2: int;
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
  DeviceObject_1 := actual_DeviceObject_1;
  Irp_2 := actual_Irp_2;
  // done with preamble
  goto L123;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 214} {:print "Call \"DispatchRead\" \"SLIC_sdv_hash_802080270_exit\""}  true;
  call SLIC_sdv_hash_802080270_exit( strConst__li2bpl1);   goto L140;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 121} {:print "Atomic Assignment"}  true;
      status := 0;  goto L125;
L25:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 133} {:print "Atomic Assignment"}  true;
    assume DeviceObject_1 > 0;
    extension := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_1)];  goto L135;
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
      status := -1073741789;  goto L136;
L40:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 142} {:print "Atomic Assignment"}  true;
      Tmp_41 := status;  goto L139;
L41:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Assignment"}  true;
      Tmp_44 := sdv_8;  goto L141;
L43:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_44);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Assignment"}  true;
    assume extension > 0;
    Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)] := Tmp_44;  goto L144;
L44:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_44);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Call \"DispatchRead\" \"DEVICE_DATA_BAG::DEVICE_DATA_BAG\""}  true;
  call sdv_hash_597892090_sdv_special_CTOR( Tmp_44, 1);   goto L43;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 151} {:print "Atomic Assignment"}  true;
      status := -1073741670;  goto L151;
L49:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 159} {:print "Call \"DispatchRead\" \"DEVICE_DATA_BAG::PopulateBag\""}  true;
  assume extension > 0;
  call sdv_hash_113115260( Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)]);   goto L145;
L52:
  call {:cexpr "extension->deviceData"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 160} {:print "Atomic Assignment"}  true;
    assume extension > 0;
    Tmp_42 := Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)];  goto L146;
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_2);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(longData);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(resource)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 182} {:print "Call \"DispatchRead\" \"ReadFromDevice\""}  true;
  assume resource > 0;
  call sdv_13 := sdv_hash_232712213( Irp_2, longData, Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(resource)]);   goto L89;
L86:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_2);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(ulongData);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 178} {:print "Call \"DispatchRead\" \"ReadFromDevice\""}  true;
  call sdv_12 := sdv_hash_231029696( Irp_2, ulongData);   goto L89;
L89:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(waitEvent);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 185} {:print "Call \"DispatchRead\" \"KeInitializeEvent\""}  true;
  call KeInitializeEvent( waitEvent, 0, 0);   goto L92;
L92:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 187} {:print "Call \"DispatchRead\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_2);   goto L95;
L95:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_2);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(208);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(waitEvent);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 188} {:print "Call \"DispatchRead\" \"sdv_IoSetCompletionRoutine\""}  true;
  call sdv_IoSetCompletionRoutine( Irp_2, 208, waitEvent, 1, 1, 1);   goto L98;
L98:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 190} {:print "Call \"DispatchRead\" \"sdv_IoCallDriver\""}  true;
  assume extension > 0;
  call status := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension)], Irp_2);   goto L102;
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
  call {:cexpr "Irp->IoStatus.Status"} boogie_si_record_li2bpl_int(Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 205} {:print "Atomic Assignment"}  true;
    assume Irp_2 > 0;
    status := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))];  goto L149;
L108:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 213} {:print "Atomic Assignment"}  true;
      Tmp_41 := status;  goto L150;
L109:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(-731814095);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 210} {:print "Call \"DispatchRead\" \"ExFreePoolWithTag\""}  true;
  call ExFreePoolWithTag( 0, -731814095);   goto L108;
L117:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 154} {:print "Atomic Assignment"}  true;
      Tmp_41 := status;  goto L154;
L122:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 214} {:print "Return"}  true;
    goto LM2;
L123:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L125:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 122} {:print "Atomic Assignment"}  true;
      stack := 0;  goto L126;
L126:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 123} {:print "Atomic Assignment"}  true;
      extension := 0;  goto L127;
L127:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 124} {:print "Atomic Assignment"}  true;
    assume waitEvent > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(waitEvent))] := 0;  goto L128;
L128:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 124} {:print "Atomic Assignment"}  true;
    assume waitEvent > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent)))] := 0;  goto L129;
L129:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 124} {:print "Atomic Assignment"}  true;
    assume waitEvent > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent)))] := 0;  goto L130;
L130:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 125} {:print "Atomic Assignment"}  true;
    assume ulongData > 0;
    Mem_T.INT4[ulongData] := 0;  goto L131;
L131:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 126} {:print "Atomic Assignment"}  true;
    assume longData > 0;
    Mem_T.INT4[longData] := 0;  goto L132;
L132:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 127} {:print "Atomic Assignment"}  true;
      deviceDataItem := 0;  goto L133;
L133:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 129} {:print "Atomic Assignment"}  true;
    assume timeout > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(timeout)] := 0;  goto L134;
L134:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 131} {:print "Call \"DispatchRead\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L25;
L135:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 135} {:print "Call \"DispatchRead\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call stack := sdv_IoGetCurrentIrpStackLocation( Irp_2);   goto L30;
L136:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 139} {:print "Atomic Assignment"}  true;
    assume Irp_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := status;  goto L137;
L137:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 140} {:print "Atomic Assignment"}  true;
    assume Irp_2 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := 0;  goto L138;
L138:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 141} {:print "Call \"DispatchRead\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L40;
L139:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L140:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L122; }
L141:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Assignment"}  true;
    assume Tmp_44 > 0;
    Mem_T.sdv_derived_object_DEVICE_DATA_BAG[sdv_derived_object_DEVICE_DATA_BAG(Tmp_44)] := 0;  goto L142;
L142:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_44);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Assignment"}  true;
    assume Tmp_44 > 0;
    Mem_T.sdv_derived_object_sdv_hash_925174249[sdv_derived_object_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(Tmp_44))] := Tmp_44;  goto L143;
L143:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_44);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 147} {:print "Atomic Conditional"}  true;
    if(*) { assume (Tmp_44 == 0);  goto L43; } else { assume (Tmp_44 != 0);  goto L44; }
L144:
  call {:cexpr "extension->deviceData"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 149} {:print "Atomic Conditional"}  true;
    if(*) { assume extension > 0;
  assume (Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)] == 0);  goto L48; } else { assume extension > 0;
  assume (Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension)] != 0);  goto L49; }
L145:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L52; }
L146:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_hash_925174249_DEVICE_DATA_BAG(Tmp_42));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 160} {:print "Call \"DispatchRead\" \"BAG<DEVICE_DATA *>::Retrieve\""}  true;
  assume Tmp_42 > 0;
  call deviceDataItem := sdv_hash_290835794( sdv_hash_925174249_DEVICE_DATA_BAG(Tmp_42), 0);   goto L56;
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
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L103;
L150:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L151:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 151} {:print "Atomic Assignment"}  true;
    assume Irp_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := status;  goto L152;
L152:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 152} {:print "Atomic Assignment"}  true;
    assume Irp_2 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := 0;  goto L153;
L153:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 153} {:print "Call \"DispatchRead\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L117;
L154:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_hash_346367737_sdv_special_CTOR"} sdv_hash_346367737_sdv_special_CTOR(actual_this_7:int, actual_Data_1:int, actual_Size_2:int) {
var  Tmp_45: int;
var  Tmp_46: int;
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
procedure {:origName "sdv_hash_445969321"} sdv_hash_445969321(actual_Size_3:int, actual_PoolType:int) returns (Tmp_47:int) {
var  sdv_15: int;
var  Tmp_48: int;
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
  call Tmp_47 := ExAllocatePool( PoolType, Size_3);   goto L1;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_hash_456398748"} sdv_hash_456398748(actual_DriverObject_2:int, actual_PhysicalDeviceObject:int) returns (Tmp_49:int) {
var  sdv_16: int;
var  sdv_17: int;
var  status_1: int;
var  deviceObject: int;
var  Tmp_50: int;
var  fdoData: int;
var  DriverObject_2: int;
var  PhysicalDeviceObject: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call deviceObject := __HAVOC_malloc(4);
  // initialize local variables to 0
  // copy formal-ins to locals
  DriverObject_2 := actual_DriverObject_2;
  PhysicalDeviceObject := actual_PhysicalDeviceObject;
  // done with preamble
  goto L39;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 53} {:print "Atomic Assignment"}  true;
    assume deviceObject > 0;
    Mem_T.P_DEVICE_OBJECT[deviceObject] := 0;  goto L41;
L12:
  call {:cexpr "PhysicalDeviceObject->Flags"} boogie_si_record_li2bpl_int(Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(PhysicalDeviceObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 59} {:print "Atomic Assignment"}  true;
    assume PhysicalDeviceObject > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(PhysicalDeviceObject)] := BOR(Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(PhysicalDeviceObject)], 4);  goto L44;
L17:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 70} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 <= status_1);  goto L19; } else { assume (0 > status_1);  goto L33; }
L19:
  call {:cexpr "deviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 75} {:print "Atomic Assignment"}  true;
    assume deviceObject > 0;
  assume Mem_T.P_DEVICE_OBJECT[deviceObject] > 0;
    fdoData := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])];  goto L45;
L26:
  call {:cexpr "fdoData->NextLowerDriver"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__FDO_DATA[NextLowerDriver__FDO_DATA(fdoData)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 83} {:print "Atomic Conditional"}  true;
    if(*) { assume fdoData > 0;
  assume (Mem_T.NextLowerDriver__FDO_DATA[NextLowerDriver__FDO_DATA(fdoData)] == 0);  goto L27; } else { assume fdoData > 0;
  assume (Mem_T.NextLowerDriver__FDO_DATA[NextLowerDriver__FDO_DATA(fdoData)] != 0);  goto L30; }
L27:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 85} {:print "Call \"DriverAddDevice\" \"IoDeleteDevice\""}  true;
  call IoDeleteDevice( 0);   goto L34;
L30:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(207);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 90} {:print "Call \"DriverAddDevice\" \"sdv_IoInitializeDpcRequest\""}  true;
  call sdv_IoInitializeDpcRequest( 0, 207);   goto L33;
L33:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 94} {:print "Atomic Assignment"}  true;
      Tmp_49 := status_1;  goto L48;
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 86} {:print "Atomic Assignment"}  true;
      status_1 := -1073741810;  goto L50;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 94} {:print "Return"}  true;
    goto LM2;
L39:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 54} {:print "Atomic Assignment"}  true;
      fdoData := 0;  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 55} {:print "Atomic Assignment"}  true;
      status_1 := 0;  goto L43;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 57} {:print "Call \"DriverAddDevice\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L12;
L44:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(40);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(7);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg7"} boogie_si_record_li2bpl_int(deviceObject);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 61} {:print "Call \"DriverAddDevice\" \"IoCreateDevice\""}  true;
  call status_1 := IoCreateDevice( 0, 40, 0, 7, 0, 0, deviceObject);   goto L17;
L45:
  call {:cexpr "PhysicalDeviceObject"} boogie_si_record_li2bpl_int(PhysicalDeviceObject);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 77} {:print "Atomic Assignment"}  true;
    assume fdoData > 0;
    Mem_T.UnderlyingPDO__FDO_DATA[UnderlyingPDO__FDO_DATA(fdoData)] := PhysicalDeviceObject;  goto L46;
L46:
  call {:cexpr "deviceObject"} boogie_si_record_li2bpl_int(Mem_T.P_DEVICE_OBJECT[deviceObject]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 79} {:print "Atomic Assignment"}  true;
    assume fdoData > 0;
  assume deviceObject > 0;
    Mem_T.Self__FDO_DATA[Self__FDO_DATA(fdoData)] := Mem_T.P_DEVICE_OBJECT[deviceObject];  goto L47;
L47:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Mem_T.UnderlyingPDO__FDO_DATA[UnderlyingPDO__FDO_DATA(fdoData)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 81} {:print "Call \"DriverAddDevice\" \"IoAttachDeviceToDeviceStack\""}  true;
  assume fdoData > 0;
  call boogieTmp := IoAttachDeviceToDeviceStack( 0, Mem_T.UnderlyingPDO__FDO_DATA[UnderlyingPDO__FDO_DATA(fdoData)]); Mem_T.NextLowerDriver__FDO_DATA[NextLowerDriver__FDO_DATA(fdoData)] := boogieTmp;  goto L26;
L48:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 94} {:print "Call \"DriverAddDevice\" \"SLIC_sdv_hash_456398748_exit\""}  true;
  call SLIC_sdv_hash_456398748_exit( strConst__li2bpl1);   goto L49;
L49:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L38; }
L50:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L33;
Lfinal: return;
}
procedure {:origName "sdv_hash_373344998"} sdv_hash_373344998(actual_Interrupt:int, actual_DeviceExtensionIn:int) returns (Tmp_51:int) {
var  Context_1: int;
var  DeviceExtension: int;
var  Tmp_52: int;
var  Interrupt: int;
var  DeviceExtensionIn: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Interrupt := actual_Interrupt;
  DeviceExtensionIn := actual_DeviceExtensionIn;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 377} {:print "Atomic Assignment"}  true;
      Context_1 := 0;  goto L15;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 382} {:print "Atomic Assignment"}  true;
      Tmp_51 := 1;  goto L17;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 382} {:print "Return"}  true;
    goto LM2;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L15:
  call {:cexpr "DeviceExtensionIn"} boogie_si_record_li2bpl_int(DeviceExtensionIn);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 378} {:print "Atomic Assignment"}  true;
      DeviceExtension := DeviceExtensionIn;  goto L16;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 380} {:print "Call \"InterruptServiceRoutine\" \"sdv_IoRequestDpc\""}  true;
  call sdv_IoRequestDpc( 0, 0, 0);   goto L10;
L17:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 382} {:print "Call \"InterruptServiceRoutine\" \"SLIC_sdv_hash_373344998_exit\""}  true;
  call SLIC_sdv_hash_373344998_exit( strConst__li2bpl1);   goto L18;
L18:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L12; }
Lfinal: return;
}
procedure {:origName "sdv_hash_211340521"} sdv_hash_211340521(actual_DeviceObject_2:int, actual_Irp_3:int, actual_EventIn:int) returns (Tmp_53:int) {
var  Tmp_54: int;
var  sdv_18: int;
var  Tmp_55: int;
var  extension_1: int;
var  Tmp_56: int;
var  DeviceObject_2: int;
var  Irp_3: int;
var  EventIn: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_2 := actual_DeviceObject_2;
  Irp_3 := actual_Irp_3;
  EventIn := actual_EventIn;
  // done with preamble
  goto L18;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 336} {:print "Atomic Assignment"}  true;
      extension_1 := 0;  goto L20;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 347} {:print "Atomic Assignment"}  true;
      Tmp_53 := 0;  goto L25;
L8:
  call {:cexpr "extension->deviceData"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 344} {:print "Atomic Assignment"}  true;
    assume extension_1 > 0;
    Tmp_54 := Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)];  goto L22;
L11:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_56);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 344} {:print "Call \"CompletionRoutineRead\" \"DEVICE_DATA_BAG::`scalar deleting destructor'\""}  true;
  call sdv_18 := sdv_hash_324714501( Tmp_56, 1);   goto L24;
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 347} {:print "Return"}  true;
    goto LM2;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L20:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 338} {:print "Atomic Assignment"}  true;
    assume DeviceObject_2 > 0;
    extension_1 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_2)];  goto L21;
L21:
  call {:cexpr "extension->deviceData"} boogie_si_record_li2bpl_int(Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 342} {:print "Atomic Conditional"}  true;
    if(*) { assume extension_1 > 0;
  assume (Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)] == 0);  goto L7; } else { assume extension_1 > 0;
  assume (Mem_T.deviceData__DRIVER_DEVICE_EXTENSION[deviceData__DRIVER_DEVICE_EXTENSION(extension_1)] != 0);  goto L8; }
L22:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_54);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 344} {:print "Atomic Assignment"}  true;
      Tmp_56 := Tmp_54;  goto L23;
L23:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_56);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 344} {:print "Atomic Conditional"}  true;
    if(*) { assume (Tmp_56 == 0);  goto L7; } else { assume (Tmp_56 != 0);  goto L11; }
L24:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L7; }
L25:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 347} {:print "Call \"CompletionRoutineRead\" \"SLIC_sdv_hash_211340521_exit\""}  true;
  call SLIC_sdv_hash_211340521_exit( strConst__li2bpl1);   goto L26;
L26:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L17; }
Lfinal: return;
}
procedure {:origName "sdv_hash_701990220"} sdv_hash_701990220(actual_DeviceObject_3:int, actual_Irp_4:int) returns (Tmp_57:int) {
var  sdv_19: int;
var  Tmp_58: int;
var  status_2: int;
var  extension_2: int;
var  DeviceObject_3: int;
var  Irp_4: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_3 := actual_DeviceObject_3;
  Irp_4 := actual_Irp_4;
  // done with preamble
  goto L20;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 103} {:print "Atomic Assignment"}  true;
      status_2 := 0;  goto L22;
L10:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 108} {:print "Call \"DispatchCreate\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_4);   goto L13;
L13:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_2)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 110} {:print "Call \"DispatchCreate\" \"sdv_IoCallDriver\""}  true;
  assume extension_2 > 0;
  call status_2 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_2)], Irp_4);   goto L17;
L17:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 112} {:print "Atomic Assignment"}  true;
      Tmp_57 := status_2;  goto L24;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 112} {:print "Return"}  true;
    goto LM2;
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L22:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 104} {:print "Atomic Assignment"}  true;
    assume DeviceObject_3 > 0;
    extension_2 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_3)];  goto L23;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 106} {:print "Call \"DispatchCreate\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L10;
L24:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 112} {:print "Call \"DispatchCreate\" \"SLIC_sdv_hash_701990220_exit\""}  true;
  call SLIC_sdv_hash_701990220_exit( strConst__li2bpl1);   goto L25;
L25:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L19; }
Lfinal: return;
}
procedure {:origName "sdv_hash_190378497"} sdv_hash_190378497(actual_Size_4:int, actual_PoolType_1:int) returns (Tmp_59:int) {
var  Tmp_60: int;
var  sdv_20: int;
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
  call Tmp_59 := ExAllocatePool( PoolType_1, Size_4);   goto L1;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_hash_86802341"} sdv_hash_86802341(actual_DeviceObject_4:int, actual_Irp_5:int) returns (Tmp_61:int) {
var  sdv_21: int;
var  sdv_22: int;
var  Tmp_62: int;
var  status_3: int;
var  extension_3: int;
var  waitEvent_1: int;
var  DeviceObject_4: int;
var  Irp_5: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call waitEvent_1 := __HAVOC_malloc(108);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_4 := actual_DeviceObject_4;
  Irp_5 := actual_Irp_5;
  // done with preamble
  goto L40;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 222} {:print "Atomic Assignment"}  true;
      status_3 := 0;  goto L42;
L15:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(waitEvent_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 228} {:print "Call \"DispatchPower\" \"KeInitializeEvent\""}  true;
  call KeInitializeEvent( waitEvent_1, 0, 0);   goto L18;
L18:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 230} {:print "Call \"DispatchPower\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_5);   goto L21;
L21:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_5);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(209);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(waitEvent_1);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 231} {:print "Call \"DispatchPower\" \"sdv_IoSetCompletionRoutine\""}  true;
  call sdv_IoSetCompletionRoutine( Irp_5, 209, waitEvent_1, 1, 1, 1);   goto L24;
L24:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_3)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 233} {:print "Call \"DispatchPower\" \"sdv_IoCallDriver\""}  true;
  assume extension_3 > 0;
  call status_3 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_3)], Irp_5);   goto L28;
L28:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 235} {:print "Atomic Conditional"}  true;
    if(*) { assume (status_3 != 259);  goto L29; } else { assume (status_3 == 259);  goto L32; }
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
  call sdv_21 := KeWaitForSingleObject( 0, 0, 0, 0, 0);   goto L35;
L35:
  call {:cexpr "Irp->IoStatus.Status"} boogie_si_record_li2bpl_int(Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_5))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 244} {:print "Atomic Assignment"}  true;
    assume Irp_5 > 0;
    status_3 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_5))];  goto L47;
L36:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 248} {:print "Atomic Assignment"}  true;
      Tmp_61 := status_3;  goto L48;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 248} {:print "Return"}  true;
    goto LM2;
L40:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 223} {:print "Atomic Assignment"}  true;
    assume waitEvent_1 > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(waitEvent_1))] := 0;  goto L43;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 223} {:print "Atomic Assignment"}  true;
    assume waitEvent_1 > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent_1)))] := 0;  goto L44;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 223} {:print "Atomic Assignment"}  true;
    assume waitEvent_1 > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent_1)))] := 0;  goto L45;
L45:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 224} {:print "Atomic Assignment"}  true;
    assume DeviceObject_4 > 0;
    extension_3 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_4)];  goto L46;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 226} {:print "Call \"DispatchPower\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L15;
L47:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L29;
L48:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 248} {:print "Call \"DispatchPower\" \"SLIC_sdv_hash_86802341_exit\""}  true;
  call SLIC_sdv_hash_86802341_exit( strConst__li2bpl1);   goto L49;
L49:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L39; }
Lfinal: return;
}
procedure {:origName "sdv_hash_1073447526"} sdv_hash_1073447526(actual_DeviceObject_5:int, actual_Irp_6:int, actual_EventIn_1:int) returns (Tmp_63:int) {
var  Tmp_64: int;
var  sdv_23: int;
var  waitEvent_2: int;
var  DeviceObject_5: int;
var  Irp_6: int;
var  EventIn_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_5 := actual_DeviceObject_5;
  Irp_6 := actual_Irp_6;
  EventIn_1 := actual_EventIn_1;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  call {:cexpr "EventIn"} boogie_si_record_li2bpl_int(EventIn_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 359} {:print "Atomic Assignment"}  true;
      waitEvent_2 := EventIn_1;  goto L15;
L6:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 366} {:print "Atomic Assignment"}  true;
      Tmp_63 := -1073741802;  goto L16;
L7:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(waitEvent_2);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 363} {:print "Call \"CompletionRoutinePower\" \"KeSetEvent\""}  true;
  call sdv_23 := KeSetEvent( waitEvent_2, 0, 0);   goto L6;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 366} {:print "Return"}  true;
    goto LM2;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L15:
  call {:cexpr "Irp->PendingReturned"} boogie_si_record_li2bpl_int(Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_6)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 361} {:print "Atomic Conditional"}  true;
    if(*) { assume Irp_6 > 0;
  assume (Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_6)] != 1);  goto L6; } else { assume Irp_6 > 0;
  assume (Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_6)] == 1);  goto L7; }
L16:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 366} {:print "Call \"CompletionRoutinePower\" \"SLIC_sdv_hash_1073447526_exit\""}  true;
  call SLIC_sdv_hash_1073447526_exit( strConst__li2bpl1);   goto L17;
L17:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L12; }
Lfinal: return;
}
procedure {:origName "sdv_hash_590764100"} sdv_hash_590764100(actual_DeviceObject_6:int, actual_Irp_7:int) returns (Tmp_65:int) {
var  sdv_24: int;
var  sdv_25: int;
var  stack_1: int;
var  ProcessorMask: int;
var  sdv_26: int;
var  Tmp_66: int;
var  status_4: int;
var  extension_4: int;
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
  goto L37;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 275} {:print "Atomic Assignment"}  true;
      extension_4 := 0;  goto L39;
L14:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 282} {:print "Call \"DispatchPnp\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call stack_1 := sdv_IoGetCurrentIrpStackLocation( Irp_7);   goto L18;
L18:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_6)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 284} {:print "Atomic Assignment"}  true;
    assume DeviceObject_6 > 0;
    extension_4 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_6)];  goto L43;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 308} {:print "Atomic Assignment"}  true;
      status_4 := -1073741822;  goto L47;
L21:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 289} {:print "Atomic Assignment"}  true;
      ProcessorMask := 1;  goto L44;
L25:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 303} {:print "Call \"DispatchPnp\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_7);   goto L28;
L28:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_4)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 305} {:print "Call \"DispatchPnp\" \"sdv_IoCallDriver\""}  true;
  assume extension_4 > 0;
  call status_4 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_4)], Irp_7);   goto L33;
L33:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 311} {:print "Atomic Assignment"}  true;
      Tmp_65 := status_4;  goto L45;
L36:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 311} {:print "Return"}  true;
    goto LM2;
L37:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 276} {:print "Atomic Assignment"}  true;
      stack_1 := 0;  goto L40;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 277} {:print "Atomic Assignment"}  true;
      status_4 := 0;  goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 278} {:print "Atomic Assignment"}  true;
      ProcessorMask := 0;  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 280} {:print "Call \"DispatchPnp\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L14;
L43:
  call {:cexpr "stack->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(stack_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 286} {:print "Atomic Conditional"}  true;
    if(*) { assume stack_1 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(stack_1)] != 0);  goto L20; } else { assume stack_1 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(stack_1)] == 0);  goto L21; }
L44:
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
  call sdv_25 := IoConnectInterrupt( 0, 210, extension_4, 0, Mem_T.ControllerVector__DRIVER_DEVICE_EXTENSION[ControllerVector__DRIVER_DEVICE_EXTENSION(extension_4)], 0, 0, 0, 1, ProcessorMask, 1);   goto L25;
L45:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 311} {:print "Call \"DispatchPnp\" \"SLIC_sdv_hash_590764100_exit\""}  true;
  call SLIC_sdv_hash_590764100_exit( strConst__li2bpl1);   goto L46;
L46:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L36; }
L47:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L33;
Lfinal: return;
}
procedure {:origName "sdv_hash_1044063384"} sdv_hash_1044063384(actual_DeviceObject_7:int, actual_Irp_8:int) returns (Tmp_67:int) {
var  sdv_27: int;
var  status_5: int;
var  extension_5: int;
var  Tmp_68: int;
var  DeviceObject_7: int;
var  Irp_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_7 := actual_DeviceObject_7;
  Irp_8 := actual_Irp_8;
  // done with preamble
  goto L20;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 257} {:print "Atomic Assignment"}  true;
      status_5 := 0;  goto L22;
L10:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 262} {:print "Call \"DispatchSystemControl\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_8);   goto L13;
L13:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_5)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 264} {:print "Call \"DispatchSystemControl\" \"sdv_IoCallDriver\""}  true;
  assume extension_5 > 0;
  call status_5 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_5)], Irp_8);   goto L17;
L17:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 266} {:print "Atomic Assignment"}  true;
      Tmp_67 := status_5;  goto L24;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 266} {:print "Return"}  true;
    goto LM2;
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L22:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_7)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 258} {:print "Atomic Assignment"}  true;
    assume DeviceObject_7 > 0;
    extension_5 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_7)];  goto L23;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 260} {:print "Call \"DispatchSystemControl\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L10;
L24:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 266} {:print "Call \"DispatchSystemControl\" \"SLIC_sdv_hash_1044063384_exit\""}  true;
  call SLIC_sdv_hash_1044063384_exit( strConst__li2bpl1);   goto L25;
L25:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L19; }
Lfinal: return;
}
procedure {:origName "sdv_hash_232712213"} sdv_hash_232712213(actual_Irp_9:int, actual_Data_2:int, actual_Resource:int) returns (Tmp_69:int) {
var  Tmp_70: int;
var  Tmp_71: int;
var  Irp_9: int;
var  Data_2: int;
var  Resource: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Irp_9 := actual_Irp_9;
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
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_9))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 413} {:print "Atomic Assignment"}  true;
    assume Irp_9 > 0;
    Tmp_71 := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_9))];  goto L11;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 420} {:print "Atomic Assignment"}  true;
      Tmp_69 := 0;  goto L13;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L11:
  call {:cexpr "*Data"} boogie_si_record_li2bpl_int(Mem_T.INT4[Data_2]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 413} {:print "Atomic Assignment"}  true;
    assume Tmp_71 > 0;
  assume Data_2 > 0;
    Mem_T.INT4[Tmp_71] := Mem_T.INT4[Data_2];  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 418} {:print "Call \"ReadFromDevice\" \"ExReleaseResourceLite\""}  true;
  call ExReleaseResourceLite( 0);   goto L7;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.cpp"} {:sourceline 420} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_924667436_sdv_special_DTOR"} sdv_hash_924667436_sdv_special_DTOR(actual_this_8:int) {
var  Tmp_72: int;
var  {:dopa}  spinLock_2: int;
var  Tmp_73: int;
var  Tmp_74: int;
var  i_1: int;
var  Tmp_75: int;
var  Tmp_76: int;
var  oldIrql_2: int;
var  Tmp_77: int;
var  Tmp_78: int;
var  this_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call spinLock_2 := __HAVOC_malloc(4);
  // initialize local variables to 0
  // copy formal-ins to locals
  this_8 := actual_this_8;
  // done with preamble
  goto L46;
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
    assume spinLock_2 > 0;
    Mem_T.INT4[spinLock_2] := 0;  goto L48;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_76 := __HAVOC_malloc(4);  goto L36;
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 229} {:print "Atomic Assignment"}  true;
      i_1 := 0;  goto L55;
L18:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  call {:cexpr "this->sdv_hash_925174249.capacity"} boogie_si_record_li2bpl_int(Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 229} {:print "Atomic Conditional"}  true;
    if(*) { assume this_8 > 0;
  assume (i_1 >= Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);  goto L19; } else { assume this_8 > 0;
  assume (i_1 < Mem_T.capacity_sdv_hash_925174249[capacity_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);  goto L22; }
L19:
  call {:cexpr "&spinLock"} boogie_si_record_li2bpl_int(spinLock_2);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias5(SLAM_guard_O_0, spinLock_2);
  
    if(*) { assume (!((spinLock_2 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init)));  goto L43; } else { assume ((spinLock_2 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init));  goto L44; }
L22:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 231} {:print "Atomic Assignment"}  true;
      Tmp_78 := i_1;  goto L56;
L23:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 229} {:print "Atomic Assignment"}  true;
      i_1 := (i_1 + 1);  goto L61;
L24:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 233} {:print "Atomic Assignment"}  true;
      Tmp_73 := i_1;  goto L58;
L28:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_hash_925174249_DEVICE_DATA_BAG(this_8));
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 212} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"BAG<DEVICE_DATA *>::~BAG<DEVICE_DATA *>\""}  true;
  assume this_8 > 0;
  call sdv_hash_233701977_sdv_special_DTOR( sdv_hash_925174249_DEVICE_DATA_BAG(this_8));   goto L63;
L33:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_76]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume spinLock_2 > 0;
  assume Tmp_76 > 0;
    Mem_T.INT4[spinLock_2] := Mem_T.INT4[Tmp_76];  goto L51;
L34:
  call {:cexpr "spinLock"} boogie_si_record_li2bpl_int(Mem_T.INT4[spinLock_2]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume spinLock_2 > 0;
  assume Tmp_76 > 0;
    Mem_T.INT4[Tmp_76] := Mem_T.INT4[spinLock_2];  goto L50;
L35:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_76]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_76 > 0;
    oldIrql_2 := Mem_T.INT4[Tmp_76];  goto L54;
L36:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql_2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_76 > 0;
    Mem_T.INT4[Tmp_76] := oldIrql_2;  goto L52;
L37:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_76);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 227} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"sdv_KeAcquireSpinLock\""}  true;
  call sdv_KeAcquireSpinLock( 0, Tmp_76);   goto L40;
L38:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 227} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"SLIC_sdv_KeAcquireSpinLock_entry\""}  true;
  call SLIC_sdv_KeAcquireSpinLock_entry( strConst__li2bpl0);   goto L53;
L40:
  call {:cexpr "&spinLock"} boogie_si_record_li2bpl_int(spinLock_2);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias6(SLAM_guard_O_0, spinLock_2);
    if(*) { assume (!((spinLock_2 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init)));  goto L35; } else { assume ((spinLock_2 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init));  goto L41; }
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 227} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"SLIC_sdv_KeAcquireSpinLock_exit\""}  true;
  call SLIC_sdv_KeAcquireSpinLock_exit( 0);   goto L35;
L43:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(oldIrql_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 237} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"sdv_KeReleaseSpinLock\""}  true;
  call sdv_KeReleaseSpinLock( 0, oldIrql_2);   goto L28;
L44:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 237} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"SLIC_sdv_KeReleaseSpinLock_entry\""}  true;
  call SLIC_sdv_KeReleaseSpinLock_entry( strConst__li2bpl0);   goto L62;
L46:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 224} {:print "Atomic Assignment"}  true;
      oldIrql_2 := 0;  goto L49;
L49:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_76 := __HAVOC_malloc(4);  goto L34;
L50:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_76);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 226} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_76);   goto L33;
L51:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L13;
L52:
  call {:cexpr "&spinLock"} boogie_si_record_li2bpl_int(spinLock_2);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "SLAM_guard_O_0"} boogie_si_record_li2bpl_int(SLAM_guard_O_0);
  call {:cexpr "&SLAM_guard_O_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_O_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias7(SLAM_guard_O_0, spinLock_2);
    if(*) { assume (!((spinLock_2 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init)));  goto L37; } else { assume ((spinLock_2 == SLAM_guard_O_0 && SLAM_guard_O_0 != SLAM_guard_O_0_init));  goto L38; }
L53:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L37; }
L54:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L17;
L55:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L18;
L56:
  call {:cexpr "this->sdv_hash_925174249.pitems"} boogie_si_record_li2bpl_int(Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 231} {:print "Atomic Assignment"}  true;
    assume this_8 > 0;
    Tmp_74 := Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))];  goto L57;
L57:
  call {:cexpr "*(Tmp + (Tmp * 4))"} boogie_si_record_li2bpl_int(Mem_T.PDEVICE_DATA[(Tmp_74 + (Tmp_78 * 4))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 231} {:print "Atomic Conditional"}  true;
    if(*) { assume Tmp_74 > 0;
  assume (Mem_T.PDEVICE_DATA[(Tmp_74 + (Tmp_78 * 4))] == 0);  goto L23; } else { assume Tmp_74 > 0;
  assume (Mem_T.PDEVICE_DATA[(Tmp_74 + (Tmp_78 * 4))] != 0);  goto L24; }
L58:
  call {:cexpr "this->sdv_hash_925174249.pitems"} boogie_si_record_li2bpl_int(Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 233} {:print "Atomic Assignment"}  true;
    assume this_8 > 0;
    Tmp_75 := Mem_T.pitems_sdv_hash_925174249[pitems_sdv_hash_925174249(sdv_hash_925174249_DEVICE_DATA_BAG(this_8))];  goto L59;
L59:
  call {:cexpr "*(Tmp + (Tmp * 4))"} boogie_si_record_li2bpl_int(Mem_T.PDEVICE_DATA[(Tmp_75 + (Tmp_73 * 4))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 233} {:print "Atomic Assignment"}  true;
    assume Tmp_75 > 0;
    Tmp_72 := Mem_T.PDEVICE_DATA[(Tmp_75 + (Tmp_73 * 4))];  goto L60;
L60:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_72);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 233} {:print "Call \"DEVICE_DATA_BAG::~DEVICE_DATA_BAG\" \"operator delete\""}  true;
  call sdv_hash_874085766( Tmp_72);   goto L23;
L61:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L18;
L62:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L43; }
L63:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
Lfinal: return;
}
procedure {:origName "sdv_hash_324714501"} sdv_hash_324714501(actual_this_9:int, actual_s_p_e_c_i_a_l_1:int) returns (Tmp_79:int) {
var  Tmp_80: int;
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
  call sdv_hash_924667436_sdv_special_DTOR( this_9);   goto L15;
L6:
  call {:cexpr "s_p_e_c_i_a_l"} boogie_si_record_li2bpl_int(s_p_e_c_i_a_l_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\fail_driver5.h"} {:sourceline 257} {:print "Atomic Conditional"}  true;
    if(*) { assume (BAND(s_p_e_c_i_a_l_1, 1) == 0);  goto L7; } else { assume (BAND(s_p_e_c_i_a_l_1, 1) != 0);  goto L8; }
L7:
  call {:cexpr "this"} boogie_si_record_li2bpl_int(this_9);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_79 := this_9;  goto L16;
L8:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(this_9);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"DEVICE_DATA_BAG::`scalar deleting destructor'\" \"operator delete\""}  true;
  call sdv_hash_874085766( this_9);   goto L7;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L15:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L6; }
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "_sdv_init1"} _sdv_init1() {
var  Tmp_81: int;
var  Tmp_82: int;
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
procedure {:origName "sdv_CheckDispatchRoutines"} sdv_CheckDispatchRoutines() returns (Tmp_83:int) {
var  Tmp_84: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4793} {:print "Atomic Assignment"}  true;
      Tmp_83 := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4793} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_IoCallDriver"} sdv_IoCallDriver(actual_DeviceObject_8:int, actual_Irp_10:int) returns (Tmp_85:int) {
var  sdv_28: int;
var  Tmp_86: int;
var  DeviceObject_8: int;
var  Irp_10: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_8 := actual_DeviceObject_8;
  Irp_10 := actual_Irp_10;
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
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_10);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10056} {:print "Call \"sdv_IoCallDriver\" \"IofCallDriver\""}  true;
  call Tmp_85 := IofCallDriver( 0, Irp_10);   goto L1;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_IoGetNextIrpStackLocation"} sdv_IoGetNextIrpStackLocation(actual_pirp:int) returns (Tmp_87:int) {
var  Tmp_88: int;
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
      Tmp_87 := sdv_harnessStackLocation_next;  goto L11;
L6:
  call {:cexpr "&sdv_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10899} {:print "Atomic Assignment"}  true;
      Tmp_87 := sdv_harnessStackLocation;  goto L13;
L7:
  call {:cexpr "&sdv_other_harnessStackLocation_next"} boogie_si_record_li2bpl_int(sdv_other_harnessStackLocation_next);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10897} {:print "Atomic Assignment"}  true;
      Tmp_87 := sdv_other_harnessStackLocation_next;  goto L12;
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
var  Tmp_89: int;
var  Tmp_90: int;
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
procedure {:origName "sdv_CheckIsrRoutines"} sdv_CheckIsrRoutines() returns (Tmp_91:int) {
var  Tmp_92: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4840} {:print "Atomic Assignment"}  true;
      Tmp_91 := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4840} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_stub_startio_end"} sdv_stub_startio_end() {
var  Tmp_93: int;
var  Tmp_94: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6730} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6730} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L10;
L10:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6730} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6731} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_stub_startio_begin"} sdv_stub_startio_begin() {
var  Tmp_95: int;
var  Tmp_96: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6725} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6725} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L11;
L11:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6725} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6725} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6726} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeInitializeEvent"} KeInitializeEvent(actual_Event:int, actual_Type:int, actual_State:int) {
var  Tmp_97: int;
var  Tmp_98: int;
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
procedure {:origName "KeSetEvent"} KeSetEvent(actual_Event_1:int, actual_Increment:int, actual_Wait:int) returns (Tmp_99:int) {
var  Tmp_100: int;
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
      Tmp_99 := OldState;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13052} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_RunAddDevice"} sdv_RunAddDevice(actual_p1:int, actual_p2:int) returns (Tmp_101:int) {
var  Tmp_102: int;
var  sdv_29: int;
var  status_6: int;
var  p1: int;
var  p2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  p1 := actual_p1;
  p2 := actual_p2;
  // done with preamble
  goto L17;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4986} {:print "Atomic Assignment"}  true;
      status_6 := 0;  goto L19;
L8:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(p1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(p2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4989} {:print "Call \"sdv_RunAddDevice\" \"DriverAddDevice\""}  true;
  call status_6 := sdv_hash_456398748( p1, p2);   goto L20;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4991} {:print "Call \"sdv_RunAddDevice\" \"sdv_stub_add_end\""}  true;
  call sdv_stub_add_end();   goto L15;
L15:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4992} {:print "Atomic Assignment"}  true;
      Tmp_101 := status_6;  goto L21;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4987} {:print "Call \"sdv_RunAddDevice\" \"sdv_stub_add_begin\""}  true;
  call sdv_stub_add_begin();   goto L8;
L20:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L12; }
L21:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4992} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoAttachDeviceToDeviceStack"} IoAttachDeviceToDeviceStack(actual_SourceDevice:int, actual_TargetDevice:int) returns (Tmp_103:int) {
var  Tmp_104: int;
var  SourceDevice: int;
var  TargetDevice: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SourceDevice := actual_SourceDevice;
  TargetDevice := actual_TargetDevice;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9800} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "TargetDevice"} boogie_si_record_li2bpl_int(TargetDevice);
  call {:cexpr "sdv_p_devobj_pdo"} boogie_si_record_li2bpl_int(sdv_p_devobj_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9795} {:print "Atomic Conditional"}  true;
    if(*) { assume (TargetDevice != sdv_p_devobj_pdo);  goto L4; } else { assume (TargetDevice == sdv_p_devobj_pdo);  goto L5; }
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9798} {:print "Atomic Assignment"}  true;
      Tmp_103 := 0;  goto L10;
L5:
  call {:cexpr "TargetDevice"} boogie_si_record_li2bpl_int(TargetDevice);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9796} {:print "Atomic Assignment"}  true;
      Tmp_103 := TargetDevice;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L10:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "ExAcquireResourceExclusiveLite"} ExAcquireResourceExclusiveLite(actual_Resource_1:int, actual_Wait_1:int) returns (Tmp_105:int) {
var  sdv_30: int;
var  Tmp_106: int;
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
      Tmp_105 := 1;  goto L17;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7207} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L12; }
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7213} {:print "Atomic Assignment"}  true;
      Tmp_105 := 1;  goto L19;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7210} {:print "Atomic Assignment"}  true;
      Tmp_105 := 0;  goto L18;
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
procedure {:origName "sdv_CheckDriverUnload"} sdv_CheckDriverUnload() returns (Tmp_107:int) {
var  Tmp_108: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4972} {:print "Atomic Assignment"}  true;
      Tmp_107 := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4972} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "main"} main() returns (Tmp_109:int) {
var  Tmp_110: int;
var  Tmp_111: int;
var  Tmp_112: int;
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
  call sdv_driver_object := __HAVOC_malloc(68);
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
  call SLAM_guard_O_0_init := __HAVOC_malloc(4);
  // Global distinctness: initialize globals
  call  boogieTmp :=  __HAVOC_malloc_or_null(40);
  sdv_kdpc := boogieTmp;
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
  call  boogieTmp :=  __HAVOC_malloc_or_null(4);
  sdv_pv3 := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(4);
  sdv_pv2 := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(4);
  sdv_pv1 := boogieTmp;
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
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_111);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Continuation"}  true;
  assume(Tmp_111 != 0);   goto L30;
L22:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_110);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Continuation"}  true;
  assume(Tmp_110 != 0);   goto L34;
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
      Tmp_111 := 1;  goto L27;
L29:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_111 := 0;  goto L27;
L30:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L31:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L22;
L32:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_110 := 1;  goto L31;
L33:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_110 := 0;  goto L31;
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
var  sdv_31: int;
var  sdv_32: int;
var  sdv_33: int;
var  sdv_34: int;
var  sdv_35: int;
var  sdv_36: int;
var  sdv_37: int;
var  sdv_38: int;
var  sdv_39: int;
var  sdv_40: int;
var  sdv_41: int;
var  sdv_42: int;
var  sdv_43: int;
var  sdv_44: int;
var  sdv_45: int;
var  sdv_46: int;
var  sdv_47: int;
var  sdv_48: int;
var  sdv_49: int;
var  sdv_50: int;
var  u: int;
var  sdv_51: int;
var  status_7: int;
var  sdv_52: int;
var  Tmp_113: int;
var  sdv_53: int;
var  sdv_54: int;
var  choice_1: int;
var  sdv_55: int;
var  sdv_56: int;
var  sdv_57: int;
var  sdv_58: int;
var  sdv_59: int;
var  Tmp_114: int;
var  sdv_60: int;
var  sdv_61: int;
var  sdv_62: int;
var  sdv_63: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call u := __HAVOC_malloc(12);
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L418;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L24;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6073} {:print "Return"}  true;
    goto LM2;
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5333} {:print "Call \"sdv_main\" \"sdv_CheckDispatchRoutines\""}  true;
  call sdv_55 := sdv_CheckDispatchRoutines();   goto L28;
L28:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5334} {:print "Call \"sdv_main\" \"sdv_CheckStartIoRoutines\""}  true;
  call sdv_46 := sdv_CheckStartIoRoutines();   goto L32;
L32:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5335} {:print "Call \"sdv_main\" \"sdv_CheckDpcRoutines\""}  true;
  call sdv_53 := sdv_CheckDpcRoutines();   goto L36;
L36:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5336} {:print "Call \"sdv_main\" \"sdv_CheckIsrRoutines\""}  true;
  call sdv_50 := sdv_CheckIsrRoutines();   goto L40;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5337} {:print "Call \"sdv_main\" \"sdv_CheckCancelRoutines\""}  true;
  call sdv_54 := sdv_CheckCancelRoutines();   goto L44;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5339} {:print "Call \"sdv_main\" \"sdv_CheckIoDpcRoutines\""}  true;
  call sdv_56 := sdv_CheckIoDpcRoutines();   goto L48;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5340} {:print "Call \"sdv_main\" \"sdv_IoCompletionRoutines\""}  true;
  call sdv_57 := sdv_IoCompletionRoutines();   goto L52;
L52:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5341} {:print "Call \"sdv_main\" \"sdv_CheckWorkerRoutines\""}  true;
  call sdv_48 := sdv_CheckWorkerRoutines();   goto L56;
L56:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5342} {:print "Call \"sdv_main\" \"sdv_CheckAddDevice\""}  true;
  call sdv_60 := sdv_CheckAddDevice();   goto L60;
L60:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5343} {:print "Call \"sdv_main\" \"sdv_CheckIrpMjPnp\""}  true;
  call sdv_61 := sdv_CheckIrpMjPnp();   goto L64;
L64:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5344} {:print "Call \"sdv_main\" \"sdv_CheckIrpMjPower\""}  true;
  call sdv_32 := sdv_CheckIrpMjPower();   goto L68;
L68:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5345} {:print "Call \"sdv_main\" \"sdv_CheckDriverUnload\""}  true;
  call sdv_52 := sdv_CheckDriverUnload();   goto L76;
L76:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5350} {:print "Atomic Continuation"}  true;
    if(*) {  goto L77; } else {  goto L334; }
L77:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_55);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5363} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_55 == 0);  goto L1; } else { assume (sdv_55 != 0);  goto L239; }
L78:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_46);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5384} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_46 == 0);  goto L1; } else { assume (sdv_46 != 0);  goto L232; }
L88:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5476} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L421;
L100:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5557} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L429;
L113:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5653} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L437;
L114:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5660} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L445;
L162:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6031} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 1;  goto L453;
L163:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_driver_object);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_p_devobj_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6039} {:print "Call \"sdv_main\" \"sdv_RunAddDevice\""}  true;
  call status_7 := sdv_RunAddDevice( sdv_driver_object, sdv_p_devobj_pdo);   goto L456;
L166:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6047} {:print "Call \"sdv_main\" \"sdv_stub_driver_init\""}  true;
  call sdv_stub_driver_init();   goto L178;
L169:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6055} {:print "Call \"sdv_main\" \"sdv_RunRemoveDevice\""}  true;
  call status_7 := sdv_RunRemoveDevice( sdv_p_devobj_fdo, sdv_irp);   goto L458;
L172:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_driver_object);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6063} {:print "Call \"sdv_main\" \"sdv_RunUnload\""}  true;
  call sdv_RunUnload( sdv_driver_object);   goto L459;
L178:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6048} {:print "Call \"sdv_main\" \"sdv_RunStartDevice\""}  true;
  call status_7 := sdv_RunStartDevice( sdv_p_devobj_fdo, sdv_irp);   goto L457;
L189:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6033} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 0;  goto L455;
L197:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5662} {:print "Atomic Assignment"}  true;
      sdv_irql_current := sdv_irql_previous;  goto L450;
L207:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5655} {:print "Atomic Assignment"}  true;
      sdv_irql_current := sdv_irql_previous;  goto L442;
L217:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5559} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L434;
L227:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5478} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L426;
L232:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5386} {:print "Call \"sdv_main\" \"sdv_stub_driver_init\""}  true;
  call sdv_stub_driver_init();   goto L235;
L235:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5387} {:print "Call \"sdv_main\" \"sdv_RunStartIo\""}  true;
  call sdv_RunStartIo( 0, 0);   goto L1;
L239:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5365} {:print "Call \"sdv_main\" \"sdv_stub_driver_init\""}  true;
  call sdv_stub_driver_init();   goto L242;
L242:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5366} {:print "Call \"sdv_main\" \"sdv_RunDispatchFunction\""}  true;
  call sdv_58 := sdv_RunDispatchFunction( sdv_p_devobj_fdo, sdv_irp);   goto L420;
L246:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L172; }
L247:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L169; } else {  goto L246; }
L248:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L166; } else {  goto L247; }
L249:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L163; } else {  goto L248; }
L250:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L162; } else {  goto L249; }
L251:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L250; }
L252:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L251; }
L253:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L252; }
L254:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L253; }
L255:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L254; }
L256:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L255; }
L257:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L256; }
L258:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L257; }
L259:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L258; }
L260:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L259; }
L261:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L260; }
L262:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L261; }
L263:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L262; }
L264:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L263; }
L265:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L264; }
L266:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L265; }
L267:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L266; }
L268:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L267; }
L269:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L268; }
L270:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L269; }
L271:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L270; }
L272:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L271; }
L273:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L272; }
L274:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L273; }
L275:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L274; }
L276:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L275; }
L277:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L276; }
L278:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L277; }
L279:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L278; }
L280:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L279; }
L281:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L280; }
L282:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L281; }
L283:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L282; }
L284:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L283; }
L285:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L284; }
L286:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L285; }
L287:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L286; }
L288:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L287; }
L289:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L288; }
L290:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L289; }
L291:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L290; }
L292:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L291; }
L293:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L292; }
L294:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L293; }
L295:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L294; }
L296:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L295; }
L297:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L296; }
L298:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L114; } else {  goto L297; }
L299:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L113; } else {  goto L298; }
L300:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L299; }
L301:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L300; }
L302:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L301; }
L303:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L302; }
L304:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L303; }
L305:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L304; }
L306:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L305; }
L307:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L306; }
L308:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L307; }
L309:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L308; }
L310:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L309; }
L311:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L310; }
L312:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L100; } else {  goto L311; }
L313:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L312; }
L314:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L313; }
L315:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L314; }
L316:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L315; }
L317:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L316; }
L318:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L317; }
L319:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L318; }
L320:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L319; }
L321:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L320; }
L322:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L321; }
L323:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L322; }
L324:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L88; } else {  goto L323; }
L325:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L324; }
L326:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L325; }
L327:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L326; }
L328:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L327; }
L329:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L328; }
L330:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L329; }
L331:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L330; }
L332:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L331; }
L333:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L332; }
L334:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L78; } else {  goto L333; }
L418:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L420:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
L421:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5476} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L422;
L422:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5476} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L423;
L423:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5476} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 4;  goto L424;
L424:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_kinterrupt);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_pv1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5477} {:print "Call \"sdv_main\" \"InterruptServiceRoutine\""}  true;
  call sdv_59 := sdv_hash_373344998( sdv_kinterrupt, sdv_pv1);   goto L425;
L425:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L227; }
L426:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5478} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L427;
L427:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5478} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L428;
L428:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L429:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5557} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L430;
L430:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5557} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L431;
L431:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5557} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L432;
L432:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_kdpc);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_pDpcContext);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_pv2);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(sdv_pv3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5558} {:print "Call \"sdv_main\" \"DpcForIsrRoutine\""}  true;
  call sdv_hash_945836574( sdv_kdpc, sdv_pDpcContext, sdv_pv2, sdv_pv3);   goto L433;
L433:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L217; }
L434:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5559} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L435;
L435:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5559} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L436;
L436:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L437:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5653} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L438;
L438:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5653} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L439;
L439:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5653} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L440;
L440:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_irp);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_pv2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5654} {:print "Call \"sdv_main\" \"CompletionRoutinePower\""}  true;
  call sdv_35 := sdv_hash_1073447526( sdv_p_devobj_fdo, sdv_irp, sdv_pv2);   goto L441;
L441:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L207; }
L442:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5655} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L443;
L443:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5655} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L444;
L444:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L445:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5660} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L446;
L446:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5660} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L447;
L447:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5660} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L448;
L448:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_irp);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_pv2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5661} {:print "Call \"sdv_main\" \"CompletionRoutineRead\""}  true;
  call sdv_36 := sdv_hash_211340521( sdv_p_devobj_fdo, sdv_irp, sdv_pv2);   goto L449;
L449:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L197; }
L450:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5662} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L451;
L451:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 5662} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L452;
L452:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L453:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_driver_object);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(u);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6032} {:print "Call \"sdv_main\" \"DriverEntry\""}  true;
  call status_7 := DriverEntry( sdv_driver_object, u);   goto L454;
L454:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L189; }
L455:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L456:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
L457:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
L458:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
L459:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
Lfinal: return;
}
procedure {:origName "sdv_RunUnload"} sdv_RunUnload(actual_pdrivo:int) {
var  Tmp_115: int;
var  Tmp_116: int;
var  pdrivo: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pdrivo := actual_pdrivo;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4770} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pdrivo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4766} {:print "Call \"sdv_RunUnload\" \"DriverUnload\""}  true;
  call sdv_hash_817957157( pdrivo);   goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
Lfinal: return;
}
procedure {:origName "sdv_IoCompletionRoutines"} sdv_IoCompletionRoutines() returns (Tmp_117:int) {
var  Tmp_118: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4911} {:print "Atomic Assignment"}  true;
      Tmp_117 := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4911} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_CheckIrpMjPower"} sdv_CheckIrpMjPower() returns (Tmp_119:int) {
var  Tmp_120: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4961} {:print "Atomic Assignment"}  true;
      Tmp_119 := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4961} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_stub_dispatch_begin"} sdv_stub_dispatch_begin() {
var  Tmp_121: int;
var  Tmp_122: int;
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
var  Tmp_123: int;
var  Tmp_124: int;
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
var  Tmp_125: int;
var  Tmp_126: int;
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
procedure {:origName "sdv_CheckWorkerRoutines"} sdv_CheckWorkerRoutines() returns (Tmp_127:int) {
var  Tmp_128: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4929} {:print "Atomic Assignment"}  true;
      Tmp_127 := 0;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4929} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_SetPowerIrpMinorFunction"} sdv_SetPowerIrpMinorFunction(actual_pirp_1:int) {
var  sdv_64: int;
var  sdv_65: int;
var  y: int;
var  x: int;
var  r: int;
var  Tmp_129: int;
var  Tmp_130: int;
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
var  Tmp_131: int;
var  Tmp_132: int;
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
var  Tmp_133: int;
var  Tmp_134: int;
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
procedure {:origName "sdv_IoInitializeDpcRequest"} sdv_IoInitializeDpcRequest(actual_DeviceObject_9:int, actual_DpcRoutine:int) {
var  Tmp_135: int;
var  Tmp_136: int;
var  DeviceObject_9: int;
var  DpcRoutine: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_9 := actual_DeviceObject_9;
  DpcRoutine := actual_DpcRoutine;
  // done with preamble
  goto L5;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "DpcRoutine"} boogie_si_record_li2bpl_int(DpcRoutine);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10937} {:print "Atomic Assignment"}  true;
      sdv_io_dpc := DpcRoutine;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10938} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeWaitForSingleObject"} KeWaitForSingleObject(actual_Object:int, actual_WaitReason:int, actual_WaitMode:int, actual_Alertable:int, actual_Timeout:int) returns (Tmp_137:int) {
var  sdv_66: int;
var  x_1: int;
var  Tmp_138: int;
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
      Tmp_137 := 0;  goto L19;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13122} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L12; }
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13129} {:print "Atomic Assignment"}  true;
      Tmp_137 := 0;  goto L18;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 13124} {:print "Atomic Assignment"}  true;
      Tmp_137 := 258;  goto L17;
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
procedure {:origName "sdv_IoSetCompletionRoutine"} sdv_IoSetCompletionRoutine(actual_pirp_3:int, actual_CompletionRoutine:int, actual_Context_2:int, actual_InvokeOnSuccess:int, actual_InvokeOnError:int, actual_InvokeOnCancel:int) {
var  sdv_67: int;
var  irpSp: int;
var  Tmp_139: int;
var  Tmp_140: int;
var  pirp_3: int;
var  CompletionRoutine: int;
var  Context_2: int;
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
  Context_2 := actual_Context_2;
  InvokeOnSuccess := actual_InvokeOnSuccess;
  InvokeOnError := actual_InvokeOnError;
  InvokeOnCancel := actual_InvokeOnCancel;
  // done with preamble
  goto L15;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11508} {:print "Call \"sdv_IoSetCompletionRoutine\" \"sdv_IoGetNextIrpStackLocation\""}  true;
  call irpSp := sdv_IoGetNextIrpStackLocation( pirp_3);   goto L8;
L8:
  call {:cexpr "CompletionRoutine"} boogie_si_record_li2bpl_int(CompletionRoutine);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11509} {:print "Atomic Assignment"}  true;
    assume irpSp > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpSp)] := CompletionRoutine;  goto L17;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11510} {:print "Atomic Assignment"}  true;
      sdv_compFset := 1;  goto L18;
L18:
  call {:cexpr "Context"} boogie_si_record_li2bpl_int(Context_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11511} {:print "Atomic Assignment"}  true;
      sdv_context := Context_2;  goto L19;
L19:
  call {:cexpr "InvokeOnSuccess"} boogie_si_record_li2bpl_int(InvokeOnSuccess);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11512} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_success := InvokeOnSuccess;  goto L20;
L20:
  call {:cexpr "InvokeOnError"} boogie_si_record_li2bpl_int(InvokeOnError);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11513} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_error := InvokeOnError;  goto L21;
L21:
  call {:cexpr "InvokeOnCancel"} boogie_si_record_li2bpl_int(InvokeOnCancel);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11514} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_cancel := InvokeOnCancel;  goto L22;
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11516} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "ExFreePoolWithTag"} ExFreePoolWithTag(actual_P:int, actual_Tag:int) {
var  Tmp_141: int;
var  Tmp_142: int;
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
var  Tmp_143: int;
var  Tmp_144: int;
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
procedure {:origName "ExAllocatePoolWithTag"} ExAllocatePoolWithTag(actual_PoolType_2:int, actual_NumberOfBytes:int, actual_Tag_1:int) returns (Tmp_145:int) {
var  Tmp_146: int;
var  sdv_68: int;
var  sdv_69: int;
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
      Tmp_145 := 0;  goto L19;
L10:
  call {:cexpr "NumberOfBytes"} boogie_si_record_li2bpl_int(NumberOfBytes);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7345} {:print "Atomic Assignment"}  true;
      call sdv_68 := __HAVOC_malloc(NumberOfBytes);  goto L13;
L13:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_68);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7345} {:print "Atomic Assignment"}  true;
      Tmp_145 := sdv_68;  goto L18;
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
procedure {:origName "sdv_CheckCancelRoutines"} sdv_CheckCancelRoutines() returns (Tmp_147:int) {
var  Tmp_148: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4860} {:print "Atomic Assignment"}  true;
      Tmp_147 := 0;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4860} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_stub_add_end"} sdv_stub_add_end() {
var  Tmp_149: int;
var  Tmp_150: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6757} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 0;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6758} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_IoCopyCurrentIrpStackLocationToNext"} sdv_IoCopyCurrentIrpStackLocationToNext(actual_pirp_4:int) {
var  Tmp_151: int;
var  Tmp_152: int;
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
procedure {:origName "sdv_CheckIoDpcRoutines"} sdv_CheckIoDpcRoutines() returns (Tmp_153:int) {
var  Tmp_154: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4895} {:print "Atomic Assignment"}  true;
      Tmp_153 := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4895} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_KeReleaseSpinLock"} sdv_KeReleaseSpinLock(actual_SpinLock_1:int, actual_new:int) {
var  Tmp_155: int;
var  Tmp_156: int;
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
procedure {:origName "sdv_IoRequestDpc"} sdv_IoRequestDpc(actual_DeviceObject_10:int, actual_Irp_11:int, actual_Context_3:int) {
var  Tmp_157: int;
var  Tmp_158: int;
var  DeviceObject_10: int;
var  Irp_11: int;
var  Context_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_10 := actual_DeviceObject_10;
  Irp_11 := actual_Irp_11;
  Context_3 := actual_Context_3;
  // done with preamble
  goto L5;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11466} {:print "Atomic Assignment"}  true;
      sdv_dpc_io_registered := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 11471} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_SetStatus"} sdv_SetStatus(actual_pirp_5:int) {
var  sdv_70: int;
var  Tmp_159: int;
var  choice_2: int;
var  Tmp_160: int;
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
var  Tmp_161: int;
var  Tmp_162: int;
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
var  Tmp_163: int;
var  Tmp_164: int;
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
      sdv_isr_routine := 293;  goto L46;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1242} {:print "Atomic Assignment"}  true;
      sdv_ke_dpc := 295;  goto L47;
L47:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1244} {:print "Atomic Assignment"}  true;
      sdv_dpc_ke_registered := 0;  goto L48;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1258} {:print "Atomic Assignment"}  true;
      sdv_io_dpc := 298;  goto L49;
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
procedure {:origName "sdv_stub_dispatch_end"} sdv_stub_dispatch_end(actual_s_1:int, actual_pirp_6:int) {
var  Tmp_165: int;
var  Tmp_166: int;
var  s_1: int;
var  pirp_6: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  s_1 := actual_s_1;
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
procedure {:origName "sdv_RunRemoveDevice"} sdv_RunRemoveDevice(actual_po:int, actual_pirp_7:int) returns (Tmp_167:int) {
var  Tmp_168: int;
var  sdv_71: int;
var  status_8: int;
var  ps: int;
var  po: int;
var  pirp_7: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  po := actual_po;
  pirp_7 := actual_pirp_7;
  // done with preamble
  goto L30;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4184} {:print "Atomic Assignment"}  true;
      status_8 := 0;  goto L32;
L18:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4197} {:print "Call \"sdv_RunRemoveDevice\" \"sdv_SetStatus\""}  true;
  call sdv_SetStatus( pirp_7);   goto L21;
L21:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4202} {:print "Call \"sdv_RunRemoveDevice\" \"DispatchPnp\""}  true;
  call status_8 := sdv_hash_590764100( po, pirp_7);   goto L42;
L25:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(status_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4204} {:print "Call \"sdv_RunRemoveDevice\" \"sdv_stub_dispatch_end\""}  true;
  call sdv_stub_dispatch_end( status_8, 0);   goto L28;
L28:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4206} {:print "Atomic Assignment"}  true;
      Tmp_167 := status_8;  goto L43;
L30:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L32:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_7)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4186} {:print "Atomic Assignment"}  true;
    assume pirp_7 > 0;
    ps := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_7)))];  goto L33;
L33:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4187} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 27;  goto L34;
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4188} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] := 2;  goto L35;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4189} {:print "Atomic Assignment"}  true;
    assume pirp_7 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_7)] := 0;  goto L36;
L36:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4190} {:print "Atomic Assignment"}  true;
    assume pirp_7 > 0;
    Mem_T.Cancel__IRP[Cancel__IRP(pirp_7)] := 0;  goto L37;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4191} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(ps)] := 0;  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4192} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := 0;  goto L39;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4192} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := 0;  goto L40;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4192} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation)] := 0;  goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4194} {:print "Call \"sdv_RunRemoveDevice\" \"sdv_stub_dispatch_begin\""}  true;
  call sdv_stub_dispatch_begin();   goto L18;
L42:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L25; }
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4206} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_RunStartDevice"} sdv_RunStartDevice(actual_po_1:int, actual_pirp_8:int) returns (Tmp_169:int) {
var  sdv_72: int;
var  status_9: int;
var  Tmp_170: int;
var  ps_1: int;
var  po_1: int;
var  pirp_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  po_1 := actual_po_1;
  pirp_8 := actual_pirp_8;
  // done with preamble
  goto L32;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4136} {:print "Atomic Assignment"}  true;
      status_9 := 0;  goto L34;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4146} {:print "Atomic Assignment"}  true;
      sdv_start_irp_already_issued := 1;  goto L41;
L23:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4153} {:print "Call \"sdv_RunStartDevice\" \"DispatchPnp\""}  true;
  call status_9 := sdv_hash_590764100( po_1, pirp_8);   goto L46;
L27:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(status_9);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4155} {:print "Call \"sdv_RunStartDevice\" \"sdv_stub_dispatch_end\""}  true;
  call sdv_stub_dispatch_end( status_9, 0);   goto L30;
L30:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_9);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4157} {:print "Atomic Assignment"}  true;
      Tmp_169 := status_9;  goto L47;
L32:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L34:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_8)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4138} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    ps_1 := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_8)))];  goto L35;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4139} {:print "Atomic Assignment"}  true;
    assume ps_1 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_1)] := 27;  goto L36;
L36:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4140} {:print "Atomic Assignment"}  true;
    assume ps_1 > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_1)] := 0;  goto L37;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4141} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_8))] := 0;  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4142} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_8)] := 0;  goto L39;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4143} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    Mem_T.Cancel__IRP[Cancel__IRP(pirp_8)] := 0;  goto L40;
L40:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4145} {:print "Call \"sdv_RunStartDevice\" \"sdv_SetStatus\""}  true;
  call sdv_SetStatus( pirp_8);   goto L15;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4147} {:print "Atomic Assignment"}  true;
    assume ps_1 > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(ps_1)] := 0;  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4148} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := 0;  goto L43;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4148} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := 0;  goto L44;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4148} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation)] := 0;  goto L45;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4150} {:print "Call \"sdv_RunStartDevice\" \"sdv_stub_dispatch_begin\""}  true;
  call sdv_stub_dispatch_begin();   goto L23;
L46:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L27; }
L47:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4157} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_CheckDpcRoutines"} sdv_CheckDpcRoutines() returns (Tmp_171:int) {
var  Tmp_172: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4825} {:print "Atomic Assignment"}  true;
      Tmp_171 := 0;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4825} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_CheckAddDevice"} sdv_CheckAddDevice() returns (Tmp_173:int) {
var  Tmp_174: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4938} {:print "Atomic Assignment"}  true;
      Tmp_173 := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4938} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_stub_add_begin"} sdv_stub_add_begin() {
var  Tmp_175: int;
var  Tmp_176: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6753} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 6754} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoCreateDevice"} IoCreateDevice(actual_DriverObject_3:int, actual_DeviceExtensionSize:int, actual_DeviceName:int, actual_DeviceType:int, actual_DeviceCharacteristics:int, actual_Exclusive:int, actual_DeviceObject_11:int) returns (Tmp_177:int) {
var  Tmp_178: int;
var  sdv_73: int;
var  choice_3: int;
var  DriverObject_3: int;
var  DeviceExtensionSize: int;
var  DeviceName: int;
var  DeviceType: int;
var  DeviceCharacteristics: int;
var  Exclusive: int;
var  DeviceObject_11: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DriverObject_3 := actual_DriverObject_3;
  DeviceExtensionSize := actual_DeviceExtensionSize;
  DeviceName := actual_DeviceName;
  DeviceType := actual_DeviceType;
  DeviceCharacteristics := actual_DeviceCharacteristics;
  Exclusive := actual_Exclusive;
  DeviceObject_11 := actual_DeviceObject_11;
  // done with preamble
  goto L29;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10240} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "sdv_io_create_device_called"} boogie_si_record_li2bpl_int(sdv_io_create_device_called);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10219} {:print "Atomic Assignment"}  true;
      sdv_io_create_device_called := (sdv_io_create_device_called + 1);  goto L31;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10238} {:print "Atomic Assignment"}  true;
    assume DeviceObject_11 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_11] := 0;  goto L43;
L11:
  call {:cexpr "sdv_inside_init_entrypoint"} boogie_si_record_li2bpl_int(sdv_inside_init_entrypoint);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10224} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_inside_init_entrypoint == 0);  goto L18; } else { assume (sdv_inside_init_entrypoint != 0);  goto L19; }
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10235} {:print "Atomic Assignment"}  true;
    assume DeviceObject_11 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_11] := 0;  goto L37;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10236} {:print "Atomic Assignment"}  true;
    assume DeviceObject_11 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_11] := 0;  goto L39;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10237} {:print "Atomic Assignment"}  true;
    assume DeviceObject_11 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_11] := 0;  goto L41;
L18:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10231} {:print "Atomic Assignment"}  true;
    assume sdv_p_devobj_child_pdo > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(sdv_p_devobj_child_pdo)] := 128;  goto L35;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10226} {:print "Atomic Assignment"}  true;
    assume sdv_p_devobj_fdo > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(sdv_p_devobj_fdo)] := 128;  goto L32;
L21:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10234} {:print "Atomic Assignment"}  true;
      Tmp_177 := 0;  goto L34;
L25:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L10; } else {  goto L14; }
L26:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L13; } else {  goto L25; }
L27:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L12; } else {  goto L26; }
L29:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L31:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10221} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L27; }
L32:
  call {:cexpr "sdv_p_devobj_fdo"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10227} {:print "Atomic Assignment"}  true;
    assume DeviceObject_11 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_11] := sdv_p_devobj_fdo;  goto L33;
L33:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L21;
L34:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L35:
  call {:cexpr "sdv_p_devobj_child_pdo"} boogie_si_record_li2bpl_int(sdv_p_devobj_child_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10232} {:print "Atomic Assignment"}  true;
    assume DeviceObject_11 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_11] := sdv_p_devobj_child_pdo;  goto L36;
L36:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L21;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10235} {:print "Atomic Assignment"}  true;
      Tmp_177 := -1073741823;  goto L38;
L38:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10236} {:print "Atomic Assignment"}  true;
      Tmp_177 := -1073741670;  goto L40;
L40:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10237} {:print "Atomic Assignment"}  true;
      Tmp_177 := -1073741824;  goto L42;
L42:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10238} {:print "Atomic Assignment"}  true;
      Tmp_177 := -1073741771;  goto L44;
L44:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "IoDeleteDevice"} IoDeleteDevice(actual_DeviceObject_12:int) {
var  Tmp_179: int;
var  Tmp_180: int;
var  DeviceObject_12: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_12 := actual_DeviceObject_12;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10529} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_NullDereferenceTrap"} sdv_NullDereferenceTrap(actual_p_1:int) {
var  Tmp_181: int;
var  Tmp_182: int;
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
procedure {:origName "sdv_CheckStartIoRoutines"} sdv_CheckStartIoRoutines() returns (Tmp_183:int) {
var  Tmp_184: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4805} {:print "Atomic Assignment"}  true;
      Tmp_183 := 0;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4805} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_RunStartIo"} sdv_RunStartIo(actual_po_2:int, actual_pirp_9:int) {
var  sdv_74: int;
var  Tmp_185: int;
var  Tmp_186: int;
var  po_2: int;
var  pirp_9: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  po_2 := actual_po_2;
  pirp_9 := actual_pirp_9;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4757} {:print "Return"}  true;
    goto LM2;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4748} {:print "Call \"sdv_RunStartIo\" \"sdv_stub_startio_begin\""}  true;
  call sdv_stub_startio_begin();   goto L6;
L6:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4754} {:print "Call \"sdv_RunStartIo\" \"sdv_DoNothing\""}  true;
  call sdv_74 := sdv_DoNothing();   goto L9;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4756} {:print "Call \"sdv_RunStartIo\" \"sdv_stub_startio_end\""}  true;
  call sdv_stub_startio_end();   goto L1;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_IoGetCurrentIrpStackLocation"} sdv_IoGetCurrentIrpStackLocation(actual_pirp_10:int) returns (Tmp_187:int) {
var  Tmp_188: int;
var  pirp_10: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_10 := actual_pirp_10;
  // done with preamble
  goto L5;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_10)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10707} {:print "Atomic Assignment"}  true;
    assume pirp_10 > 0;
    Tmp_187 := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_10)))];  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10707} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_CheckIrpMjPnp"} sdv_CheckIrpMjPnp() returns (Tmp_189:int) {
var  Tmp_190: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4949} {:print "Atomic Assignment"}  true;
      Tmp_189 := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 4949} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "ExInitializeResourceLite"} ExInitializeResourceLite(actual_Resource_3:int) returns (Tmp_191:int) {
var  Tmp_192: int;
var  sdv_75: int;
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
      Tmp_191 := -1073741823;  goto L15;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7424} {:print "Atomic Assignment"}  true;
      Tmp_191 := 0;  goto L14;
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
procedure {:origName "ExAllocatePool"} ExAllocatePool(actual_PoolType_3:int, actual_NumberOfBytes_1:int) returns (Tmp_193:int) {
var  sdv_76: int;
var  sdv_77: int;
var  x_4: int;
var  Tmp_194: int;
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
      Tmp_193 := 0;  goto L19;
L10:
  call {:cexpr "NumberOfBytes"} boogie_si_record_li2bpl_int(NumberOfBytes_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7296} {:print "Atomic Assignment"}  true;
      call sdv_76 := __HAVOC_malloc(NumberOfBytes_1);  goto L13;
L13:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_76);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 7296} {:print "Atomic Assignment"}  true;
      Tmp_193 := sdv_76;  goto L18;
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
procedure {:origName "IofCallDriver"} IofCallDriver(actual_DeviceObject_13:int, actual_Irp_12:int) returns (Tmp_195:int) {
var  completion: int;
var  sdv_78: int;
var  status_10: int;
var  Tmp_196: int;
var  choice_4: int;
var  DeviceObject_13: int;
var  Irp_12: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_13 := actual_DeviceObject_13;
  Irp_12 := actual_Irp_12;
  // done with preamble
  goto L66;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9950} {:print "Atomic Assignment"}  true;
      completion := 0;  goto L68;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9953} {:print "Atomic Assignment"}  true;
      status_10 := 259;  goto L69;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10023} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := -1073741823;  goto L86;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9957} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := 0;  goto L70;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9979} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := -1073741536;  goto L76;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10001} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := 259;  goto L81;
L19:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10007} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_12);  goto L21; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_12);  goto L22; }
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10005} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 259;  goto L83;
L21:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10011} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_12);  goto L24; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_12);  goto L25; }
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10009} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 259;  goto L84;
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10013} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 259;  goto L85;
L25:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_10);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10045} {:print "Atomic Assignment"}  true;
      Tmp_195 := status_10;  goto L75;
L28:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9985} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_12);  goto L30; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_12);  goto L31; }
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9983} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741536;  goto L78;
L30:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9989} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_12);  goto L25; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_12);  goto L33; }
L31:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9987} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741536;  goto L79;
L33:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9991} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741536;  goto L80;
L36:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9963} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_12);  goto L38; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_12);  goto L39; }
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9961} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 0;  goto L72;
L38:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9967} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_12);  goto L25; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_12);  goto L41; }
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9965} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 0;  goto L73;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9969} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 0;  goto L74;
L44:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10029} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_12);  goto L46; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_12);  goto L47; }
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10027} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741823;  goto L88;
L46:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10033} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_12);  goto L25; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_12);  goto L49; }
L47:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10031} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741823;  goto L89;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10035} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741823;  goto L90;
L51:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L13; } else {  goto L16; }
L52:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L15; } else {  goto L51; }
L66:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L68:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L69:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9954} {:print "Atomic Continuation"}  true;
    if(*) {  goto L14; } else {  goto L52; }
L70:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9958} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_12)] := 0;  goto L71;
L71:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9959} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_12);  goto L36; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_12);  goto L37; }
L72:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L36;
L73:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L38;
L74:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L25;
L75:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10045} {:print "Return"}  true;
    goto LM2;
L76:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9980} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_12)] := 0;  goto L77;
L77:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 9981} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_12);  goto L28; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_12);  goto L29; }
L78:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L28;
L79:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L30;
L80:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L25;
L81:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10002} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_12)] := 1;  goto L82;
L82:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10003} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_12);  goto L19; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_12);  goto L20; }
L83:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L19;
L84:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L21;
L85:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L25;
L86:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10024} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_12)] := 0;  goto L87;
L87:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10025} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_12);  goto L44; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_12);  goto L45; }
L88:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L44;
L89:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L46;
L90:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L25;
Lfinal: return;
}
procedure {:origName "KeLeaveCriticalRegion"} KeLeaveCriticalRegion() {
var  Tmp_197: int;
var  Tmp_198: int;
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
var  Tmp_199: int;
var  Tmp_200: int;
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
procedure {:origName "IoConnectInterrupt"} IoConnectInterrupt(actual_InterruptObject:int, actual_ServiceRoutine:int, actual_ServiceContext:int, actual_SpinLock_3:int, actual_Vector:int, actual_Irql:int, actual_SynchronizeIrql:int, actual_InterruptMode:int, actual_ShareVector:int, actual_ProcessorEnableMask:int, actual_FloatingSave:int) returns (Tmp_201:int) {
var  Tmp_202: int;
var  sdv_79: int;
var  choice_5: int;
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
      Tmp_201 := -1073741670;  goto L23;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10144} {:print "Atomic Assignment"}  true;
      Tmp_201 := 0;  goto L21;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 10146} {:print "Atomic Assignment"}  true;
      Tmp_201 := -1073741811;  goto L22;
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
procedure {:origName "sdv_DoNothing"} sdv_DoNothing() returns (Tmp_203:int) {
var  Tmp_204: int;
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
      Tmp_203 := -1073741823;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1515} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_RunDispatchFunction"} sdv_RunDispatchFunction(actual_po_3:int, actual_pirp_11:int) returns (Tmp_205:int) {
var  sdv_80: int;
var  sdv_81: int;
var  sdv_82: int;
var  sdv_83: int;
var  sdv_84: int;
var  sdv_85: int;
var  sdv_86: int;
var  sdv_87: int;
var  sdv_88: int;
var  sdv_89: int;
var  sdv_90: int;
var  sdv_91: int;
var  sdv_92: int;
var  x_5: int;
var  sdv_93: int;
var  Tmp_206: int;
var  sdv_94: int;
var  sdv_95: int;
var  status_11: int;
var  sdv_96: int;
var  Tmp_207: int;
var  Tmp_208: int;
var  ps_2: int;
var  minor: int;
var  sdv_97: int;
var  sdv_98: int;
var  po_3: int;
var  pirp_11: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  po_3 := actual_po_3;
  pirp_11 := actual_pirp_11;
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
      status_11 := 0;  goto L178;
L14:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_89);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1620} {:print "Atomic Assignment"}  true;
      minor := sdv_89;  goto L179;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1628} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_11)] := 0;  goto L184;
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1641} {:print "Atomic Continuation"}  true;
    if(*) {  goto L38; } else {  goto L169; }
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1998} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1683} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 0;  goto L192;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1664} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 2;  goto L196;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1815} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 3;  goto L197;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1872} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 4;  goto L199;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1796} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 5;  goto L200;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1834} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 6;  goto L201;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1739} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 9;  goto L202;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1732} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1702} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 14;  goto L203;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1758} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 15;  goto L204;
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1979} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 16;  goto L205;
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1789} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L54:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1645} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 18;  goto L206;
L55:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1951} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 22;  goto L207;
L56:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1853} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 23;  goto L209;
L57:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1891} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_2)] := 27;  goto L211;
L59:
  call {:cexpr "sdv_start_irp_already_issued"} boogie_si_record_li2bpl_int(sdv_start_irp_already_issued);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1897} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_start_irp_already_issued == 0);  goto L219; } else { assume (sdv_start_irp_already_issued != 0);  goto L220; }
L60:
  call {:cexpr "ps->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1900} {:print "Atomic Conditional"}  true;
    if(*) { assume ps_2 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)] != 3);  goto L61; } else { assume ps_2 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)] == 3);  goto L62; }
L61:
  call {:cexpr "ps->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1904} {:print "Atomic Conditional"}  true;
    if(*) { assume ps_2 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)] != 2);  goto L66; } else { assume ps_2 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)] == 2);  goto L69; }
L62:
  call {:cexpr "sdv_remove_irp_already_issued"} boogie_si_record_li2bpl_int(sdv_remove_irp_already_issued);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1902} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_remove_irp_already_issued == 0);  goto L213; } else { assume (sdv_remove_irp_already_issued != 0);  goto L214; }
L66:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1934} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchPnp\""}  true;
  call status_11 := sdv_hash_590764100( po_3, pirp_11);   goto L217;
L69:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1906} {:print "Atomic Assignment"}  true;
      sdv_remove_irp_already_issued := 1;  goto L216;
L72:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(status_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 2002} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_stub_dispatch_end\""}  true;
  call sdv_stub_dispatch_end( status_11, 0);   goto L75;
L75:
  call {:cexpr "pirp->IoStatus.Information"} boogie_si_record_li2bpl_int(Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_11))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 2004} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    sdv_end_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_11))];  goto L194;
L88:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1961} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchPower\""}  true;
  call status_11 := sdv_hash_86802341( po_3, pirp_11);   goto L208;
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
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_208);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1902} {:print "Atomic Continuation"}  true;
  assume(Tmp_208 != 0);   goto L215;
L175:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_206);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1897} {:print "Atomic Continuation"}  true;
  assume(Tmp_206 != 0);   goto L221;
L176:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L178:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L14;
L179:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_11)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1622} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    ps_2 := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_11)))];  goto L180;
L180:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1623} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(pirp_11)] := 0;  goto L181;
L181:
  call {:cexpr "pirp->IoStatus.Information"} boogie_si_record_li2bpl_int(Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_11))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1624} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    sdv_start_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_11))];  goto L182;
L182:
  call {:cexpr "sdv_start_info"} boogie_si_record_li2bpl_int(sdv_start_info);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1624} {:print "Atomic Assignment"}  true;
      sdv_end_info := sdv_start_info;  goto L183;
L183:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1626} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_SetStatus\""}  true;
  call sdv_SetStatus( pirp_11);   goto L23;
L184:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1629} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    Mem_T.Cancel__IRP[Cancel__IRP(pirp_11)] := 0;  goto L185;
L185:
  call {:cexpr "minor"} boogie_si_record_li2bpl_int(minor);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1633} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)] := minor;  goto L186;
L186:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1634} {:print "Atomic Assignment"}  true;
    assume ps_2 > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(ps_2)] := 0;  goto L187;
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1685} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchCreate\""}  true;
  call status_11 := sdv_hash_701990220( po_3, pirp_11);   goto L193;
L193:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L194:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 2005} {:print "Atomic Assignment"}  true;
      Tmp_205 := status_11;  goto L195;
L195:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 2005} {:print "Return"}  true;
    goto LM2;
L196:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1676} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L197:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1817} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchRead\""}  true;
  call status_11 := sdv_hash_802080270( po_3, pirp_11);   goto L198;
L198:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L199:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1884} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L200:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1808} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L201:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1846} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L202:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1751} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L203:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1714} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L204:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1770} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L205:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1991} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L206:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1657} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_11 := sdv_DoNothing();   goto L72;
L207:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1955} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_SetPowerIrpMinorFunction\""}  true;
  call sdv_SetPowerIrpMinorFunction( pirp_11);   goto L88;
L208:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L209:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1855} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchSystemControl\""}  true;
  call status_11 := sdv_hash_1044063384( po_3, pirp_11);   goto L210;
L210:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L211:
  call {:cexpr "ps->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver5\sdv\sdv-harness.c"} {:sourceline 1895} {:print "Atomic Conditional"}  true;
    if(*) { assume ps_2 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)] == 0);  goto L59; } else { assume ps_2 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_2)] != 0);  goto L60; }
L212:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L174;
L213:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_208 := 1;  goto L212;
L214:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_208 := 0;  goto L212;
L215:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L61;
L216:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L217:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L218:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L175;
L219:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_206 := 1;  goto L218;
L220:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_206 := 0;  goto L218;
L221:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L60;
Lfinal: return;
}
procedure {:origName "sdv_ExFreePool"} sdv_ExFreePool(actual_P_1:int) {
var  Tmp_209: int;
var  Tmp_210: int;
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
procedure {:origName "KeQuerySystemTime"} KeQuerySystemTime(actual_sdv_99:int) returns (Tmp_211:int) {
var  Tmp_212: int;
var  sdv_100: int;
var  sdv_99: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  sdv_99 := actual_sdv_99;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_100);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_211 := sdv_100;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_31_0"} SLIC_ABORT_31_0(actual_caller:int) {
var  caller: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller := actual_caller;
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_31_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_KfAcquireSpinLock_exit"} SLIC_KfAcquireSpinLock_exit(actual_caller_1:int) {
var  caller_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_1 := actual_caller_1;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 63} {:print "Atomic Assignment"}  true;
      s := 1;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_43_0"} SLIC_ABORT_43_0(actual_caller_2:int) {
var  caller_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_2 := actual_caller_2;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_2 := caller_2;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_43_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_17_0"} SLIC_ABORT_17_0(actual_caller_3:int) {
var  caller_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_3 := actual_caller_3;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_3 := caller_3;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_17_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling KfReleaseSpinLock without first acquiring the spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl3);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_KeAcquireSpinLock_exit"} SLIC_sdv_KeAcquireSpinLock_exit(actual_caller_4:int) {
var  caller_4: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_4 := actual_caller_4;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 63} {:print "Atomic Assignment"}  true;
      s := 1;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_29_0"} SLIC_ABORT_29_0(actual_caller_5:int) {
var  caller_5: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_5 := actual_caller_5;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_5 := caller_5;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_29_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_KefAcquireSpinLockAtDpcLevel_exit"} SLIC_KefAcquireSpinLockAtDpcLevel_exit(actual_caller_6:int) {
var  caller_6: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_6 := actual_caller_6;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 63} {:print "Atomic Assignment"}  true;
      s := 1;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_7_0"} SLIC_ABORT_7_0(actual_caller_7:int) {
var  caller_7: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_7 := actual_caller_7;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_7);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_7 := caller_7;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl4);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_7_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling sdv_KeAcquireSpinLockAtDpcLevel after already acquiring the spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl4);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_456398748_exit"} SLIC_sdv_hash_456398748_exit(actual_caller_8:int) {
var  caller_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_8 := actual_caller_8;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_8);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_sdv_hash_456398748_exit\" \"SLIC_ABORT_31_0\""}  true;
  call SLIC_ABORT_31_0( caller_8);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_456398748_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_23_0"} SLIC_ABORT_23_0(actual_caller_9:int) {
var  caller_9: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_9 := actual_caller_9;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_9);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_9 := caller_9;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl6);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_23_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling sdv_KeReleaseSpinLock without first acquiring the spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl6);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_1_0"} SLIC_ABORT_1_0(actual_caller_10:int) {
var  caller_10: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_10 := actual_caller_10;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_10);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_10 := caller_10;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl7);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_1_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling KfAcquireSpinLock after already acquiring the spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl7);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_35_0"} SLIC_ABORT_35_0(actual_caller_11:int) {
var  caller_11: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_11 := actual_caller_11;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_11);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_11 := caller_11;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_35_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_KeAcquireSpinLock_entry"} SLIC_sdv_KeAcquireSpinLock_entry(actual_caller_12:int) {
var  caller_12: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_12 := actual_caller_12;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_12);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 51} {:print "Call \"SLIC_sdv_KeAcquireSpinLock_entry\" \"SLIC_ABORT_9_0\""}  true;
  call SLIC_ABORT_9_0( caller_12);   goto L9;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 50} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 1);  goto L2; } else { assume (s == 1);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_KeTryToAcquireSpinLockAtDpcLevel_exit"} SLIC_KeTryToAcquireSpinLockAtDpcLevel_exit(actual_caller_13:int, actual_KeTryToAcquireSpinLockAtDpcLevel:int) {
var  caller_13: int;
var  KeTryToAcquireSpinLockAtDpcLevel: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_13 := actual_caller_13;
  KeTryToAcquireSpinLockAtDpcLevel := actual_KeTryToAcquireSpinLockAtDpcLevel;
  // done with preamble
  goto L6;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 70} {:print "Atomic Assignment"}  true;
      s := 1;  goto L8;
L4:
  call {:cexpr "KeTryToAcquireSpinLockAtDpcLevel"} boogie_si_record_li2bpl_int(KeTryToAcquireSpinLockAtDpcLevel);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 68} {:print "Atomic Conditional"}  true;
    if(*) { assume (KeTryToAcquireSpinLockAtDpcLevel == 0);  goto L2; } else { assume (KeTryToAcquireSpinLockAtDpcLevel != 0);  goto L3; }
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_47_0"} SLIC_ABORT_47_0(actual_caller_14:int) {
var  caller_14: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_14 := actual_caller_14;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_14);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_14 := caller_14;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_47_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_945836574_exit"} SLIC_sdv_hash_945836574_exit(actual_caller_15:int) {
var  caller_15: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_15 := actual_caller_15;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_15);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 103} {:print "Call \"SLIC_sdv_hash_945836574_exit\" \"SLIC_ABORT_45_0\""}  true;
  call SLIC_ABORT_45_0( caller_15);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_945836574_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 102} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_817957157_exit"} SLIC_sdv_hash_817957157_exit(actual_caller_16:int) {
var  caller_16: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_16 := actual_caller_16;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_16);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_sdv_hash_817957157_exit\" \"SLIC_ABORT_29_0\""}  true;
  call SLIC_ABORT_29_0( caller_16);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_817957157_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
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
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 34} {:print "Atomic Assignment"}  true;
      s := 0;  goto L6;
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
procedure {:origName "SLIC_sdv_hash_373344998_exit"} SLIC_sdv_hash_373344998_exit(actual_caller_17:int) {
var  caller_17: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_17 := actual_caller_17;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_17);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 103} {:print "Call \"SLIC_sdv_hash_373344998_exit\" \"SLIC_ABORT_47_0\""}  true;
  call SLIC_ABORT_47_0( caller_17);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_373344998_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 102} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_41_0"} SLIC_ABORT_41_0(actual_caller_18:int) {
var  caller_18: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_18 := actual_caller_18;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_18);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_18 := caller_18;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_41_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_KeAcquireSpinLockRaiseToDpc_exit"} SLIC_KeAcquireSpinLockRaiseToDpc_exit(actual_caller_19:int) {
var  caller_19: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_19 := actual_caller_19;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 63} {:print "Atomic Assignment"}  true;
      s := 1;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L5:
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
procedure {:origName "SLIC_ABORT_27_0"} SLIC_ABORT_27_0(actual_caller_20:int) {
var  caller_20: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_20 := actual_caller_20;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_20);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_20 := caller_20;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_27_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_5_0"} SLIC_ABORT_5_0(actual_caller_21:int) {
var  caller_21: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_21 := actual_caller_21;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_21);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_21 := caller_21;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl8);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_5_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling KeAcquireSpinLockRaiseToDpc after already acquiring the spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl8);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_701990220_exit"} SLIC_sdv_hash_701990220_exit(actual_caller_22:int) {
var  caller_22: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_22 := actual_caller_22;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_22);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_sdv_hash_701990220_exit\" \"SLIC_ABORT_43_0\""}  true;
  call SLIC_ABORT_43_0( caller_22);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_701990220_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_KeReleaseSpinLock_entry"} SLIC_sdv_KeReleaseSpinLock_entry(actual_caller_23:int) {
var  caller_23: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_23 := actual_caller_23;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_23);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 83} {:print "Call \"SLIC_sdv_KeReleaseSpinLock_entry\" \"SLIC_ABORT_23_0\""}  true;
  call SLIC_ABORT_23_0( caller_23);   goto L10;
L6:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 85} {:print "Atomic Assignment"}  true;
      s := 0;  goto L11;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 82} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 1);  goto L4; } else { assume (s == 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
L11:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_KeReleaseSpinLock_entry\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_KeReleaseSpinLockFromDpcLevel_entry"} SLIC_sdv_KeReleaseSpinLockFromDpcLevel_entry(actual_caller_24:int) {
var  caller_24: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_24 := actual_caller_24;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_24);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 83} {:print "Call \"SLIC_sdv_KeReleaseSpinLockFromDpcLevel_entry\" \"SLIC_ABORT_21_0\""}  true;
  call SLIC_ABORT_21_0( caller_24);   goto L10;
L6:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 85} {:print "Atomic Assignment"}  true;
      s := 0;  goto L11;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 82} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 1);  goto L4; } else { assume (s == 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
L11:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_KeReleaseSpinLockFromDpcLevel_entry\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_39_0"} SLIC_ABORT_39_0(actual_caller_25:int) {
var  caller_25: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_25 := actual_caller_25;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_25);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_25 := caller_25;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_39_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_KefReleaseSpinLockFromDpcLevel_entry"} SLIC_KefReleaseSpinLockFromDpcLevel_entry(actual_caller_26:int) {
var  caller_26: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_26 := actual_caller_26;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_26);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 83} {:print "Call \"SLIC_KefReleaseSpinLockFromDpcLevel_entry\" \"SLIC_ABORT_19_0\""}  true;
  call SLIC_ABORT_19_0( caller_26);   goto L10;
L6:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 85} {:print "Atomic Assignment"}  true;
      s := 0;  goto L11;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 82} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 1);  goto L4; } else { assume (s == 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
L11:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_KefReleaseSpinLockFromDpcLevel_entry\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_DriverEntry_exit"} SLIC_DriverEntry_exit(actual_caller_27:int) {
var  caller_27: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_27 := actual_caller_27;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_27);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_DriverEntry_exit\" \"SLIC_ABORT_33_0\""}  true;
  call SLIC_ABORT_33_0( caller_27);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_DriverEntry_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_21_0"} SLIC_ABORT_21_0(actual_caller_28:int) {
var  caller_28: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_28 := actual_caller_28;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_28);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_28 := caller_28;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl9);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_21_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling sdv_KeReleaseSpinLockFromDpcLevel without first acquiring the spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl9);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_33_0"} SLIC_ABORT_33_0(actual_caller_29:int) {
var  caller_29: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_29 := actual_caller_29;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_29);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_29 := caller_29;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_33_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_211340521_exit"} SLIC_sdv_hash_211340521_exit(actual_caller_30:int) {
var  caller_30: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_30 := actual_caller_30;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_30);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_sdv_hash_211340521_exit\" \"SLIC_ABORT_25_0\""}  true;
  call SLIC_ABORT_25_0( caller_30);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_211340521_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_45_0"} SLIC_ABORT_45_0(actual_caller_31:int) {
var  caller_31: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_31 := actual_caller_31;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_31);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_31 := caller_31;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_45_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_802080270_exit"} SLIC_sdv_hash_802080270_exit(actual_caller_32:int) {
var  caller_32: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_32 := actual_caller_32;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_32);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_sdv_hash_802080270_exit\" \"SLIC_ABORT_41_0\""}  true;
  call SLIC_ABORT_41_0( caller_32);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_802080270_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_19_0"} SLIC_ABORT_19_0(actual_caller_33:int) {
var  caller_33: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_33 := actual_caller_33;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_33);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_33 := caller_33;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl10);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_19_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling KefReleaseSpinLockFromDpcLevel without first acquiring the spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl10);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_KeAcquireSpinLockAtDpcLevel_exit"} SLIC_sdv_KeAcquireSpinLockAtDpcLevel_exit(actual_caller_34:int) {
var  caller_34: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_34 := actual_caller_34;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 63} {:print "Atomic Assignment"}  true;
      s := 1;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_9_0"} SLIC_ABORT_9_0(actual_caller_35:int) {
var  caller_35: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_35 := actual_caller_35;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_35);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_35 := caller_35;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl11);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_9_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling sdv_KeAcquireSpinLock after already acquiring the spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl11);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_KeAcquireSpinLockRaiseToDpc_entry"} SLIC_KeAcquireSpinLockRaiseToDpc_entry(actual_caller_36:int) {
var  caller_36: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_36 := actual_caller_36;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_36);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 51} {:print "Call \"SLIC_KeAcquireSpinLockRaiseToDpc_entry\" \"SLIC_ABORT_5_0\""}  true;
  call SLIC_ABORT_5_0( caller_36);   goto L9;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 50} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 1);  goto L2; } else { assume (s == 1);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_KfReleaseSpinLock_entry"} SLIC_KfReleaseSpinLock_entry(actual_caller_37:int) {
var  caller_37: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_37 := actual_caller_37;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_37);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 83} {:print "Call \"SLIC_KfReleaseSpinLock_entry\" \"SLIC_ABORT_17_0\""}  true;
  call SLIC_ABORT_17_0( caller_37);   goto L10;
L6:
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 85} {:print "Atomic Assignment"}  true;
      s := 0;  goto L11;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 82} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 1);  goto L4; } else { assume (s == 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
L11:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_KfReleaseSpinLock_entry\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_KefAcquireSpinLockAtDpcLevel_entry"} SLIC_KefAcquireSpinLockAtDpcLevel_entry(actual_caller_38:int) {
var  caller_38: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_38 := actual_caller_38;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_38);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 51} {:print "Call \"SLIC_KefAcquireSpinLockAtDpcLevel_entry\" \"SLIC_ABORT_3_0\""}  true;
  call SLIC_ABORT_3_0( caller_38);   goto L9;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 50} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 1);  goto L2; } else { assume (s == 1);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_1073447526_exit"} SLIC_sdv_hash_1073447526_exit(actual_caller_39:int) {
var  caller_39: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_39 := actual_caller_39;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_39);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_sdv_hash_1073447526_exit\" \"SLIC_ABORT_27_0\""}  true;
  call SLIC_ABORT_27_0( caller_39);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_1073447526_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_KeAcquireSpinLockAtDpcLevel_entry"} SLIC_sdv_KeAcquireSpinLockAtDpcLevel_entry(actual_caller_40:int) {
var  caller_40: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_40 := actual_caller_40;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_40);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 51} {:print "Call \"SLIC_sdv_KeAcquireSpinLockAtDpcLevel_entry\" \"SLIC_ABORT_7_0\""}  true;
  call SLIC_ABORT_7_0( caller_40);   goto L9;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 50} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 1);  goto L2; } else { assume (s == 1);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_KfAcquireSpinLock_entry"} SLIC_KfAcquireSpinLock_entry(actual_caller_41:int) {
var  caller_41: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_41 := actual_caller_41;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_41);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 51} {:print "Call \"SLIC_KfAcquireSpinLock_entry\" \"SLIC_ABORT_1_0\""}  true;
  call SLIC_ABORT_1_0( caller_41);   goto L9;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 50} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 1);  goto L2; } else { assume (s == 1);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_590764100_exit"} SLIC_sdv_hash_590764100_exit(actual_caller_42:int) {
var  caller_42: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_42 := actual_caller_42;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_42);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_sdv_hash_590764100_exit\" \"SLIC_ABORT_35_0\""}  true;
  call SLIC_ABORT_35_0( caller_42);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_590764100_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_25_0"} SLIC_ABORT_25_0(actual_caller_43:int) {
var  caller_43: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_43 := actual_caller_43;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_43);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_43 := caller_43;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_25_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_3_0"} SLIC_ABORT_3_0(actual_caller_44:int) {
var  caller_44: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_44 := actual_caller_44;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_44);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_44 := caller_44;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl12);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_3_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling KefAcquireSpinLockAtDpcLevel after already acquiring the spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl12);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_37_0"} SLIC_ABORT_37_0(actual_caller_45:int) {
var  caller_45: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_45 := actual_caller_45;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_45);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_45 := caller_45;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_37_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has returned without releasing a spinlock."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_86802341_exit"} SLIC_sdv_hash_86802341_exit(actual_caller_46:int) {
var  caller_46: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_46 := actual_caller_46;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_46);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_sdv_hash_86802341_exit\" \"SLIC_ABORT_39_0\""}  true;
  call SLIC_ABORT_39_0( caller_46);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_86802341_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_1044063384_exit"} SLIC_sdv_hash_1044063384_exit(actual_caller_47:int) {
var  caller_47: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_47 := actual_caller_47;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_47);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 94} {:print "Call \"SLIC_sdv_hash_1044063384_exit\" \"SLIC_ABORT_37_0\""}  true;
  call SLIC_ABORT_37_0( caller_47);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_hash_1044063384_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\SpinLock.slic"} {:sourceline 93} {:print "Atomic Conditional"}  true;
    if(*) { assume (s == 1);  goto L4; } else { assume (s != 1);  goto L6; }
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L10:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
// ----- Decls -------
var Mem_T.Acquired_DRIVER_RESOURCE: [int] int;
var Mem_T.AddDevice__DRIVER_EXTENSION: [int] int;
var Mem_T.Blink__LIST_ENTRY: [int] int;
var Mem_T.CancelRoutine__IRP: [int] int;
var Mem_T.Cancel__IRP: [int] int;
var Mem_T.CompletionRoutine__IO_STACK_LOCATION: [int] int;
var Mem_T.ControllerVector__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.CurrentStackLocation_unnamed_tag_7: [int] int;
var Mem_T.DataSize__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.Data_DEVICE_DATA: [int] int;
var Mem_T.DeviceExtension__DEVICE_OBJECT: [int] int;
var Mem_T.DriverExtension__DRIVER_OBJECT: [int] int;
var Mem_T.DriverUnload__DRIVER_OBJECT: [int] int;
var Mem_T.Flags__DEVICE_OBJECT: [int] int;
var Mem_T.Flink__LIST_ENTRY: [int] int;
var Mem_T.INT4: [int] int;
var Mem_T.Information__IO_STATUS_BLOCK: [int] int;
var Mem_T.Length_unnamed_tag_18: [int] int;
var Mem_T.MajorFunction__DRIVER_OBJECT: [int] int;
var Mem_T.MajorFunction__IO_STACK_LOCATION: [int] int;
var Mem_T.MinorFunction__IO_STACK_LOCATION: [int] int;
var Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.NextLowerDriver__FDO_DATA: [int] int;
var Mem_T.PDEVICE_DATA: [int] int;
var Mem_T.P_DEVICE_OBJECT: [int] int;
var Mem_T.PendingReturned__IRP: [int] int;
var Mem_T.QuadPart__LARGE_INTEGER: [int] int;
var Mem_T.RequiredBufferLength_DEVICE_DATA: [int] int;
var Mem_T.Resource_DRIVER_RESOURCE: [int] int;
var Mem_T.Self__FDO_DATA: [int] int;
var Mem_T.SignalState__DISPATCHER_HEADER: [int] int;
var Mem_T.Signalling__DISPATCHER_HEADER: [int] int;
var Mem_T.Size__DISPATCHER_HEADER: [int] int;
var Mem_T.Status__IO_STATUS_BLOCK: [int] int;
var Mem_T.SystemBuffer_unnamed_tag_2: [int] int;
var Mem_T.Type_unnamed_tag_28: [int] int;
var Mem_T.Type_unnamed_tag_39: [int] int;
var Mem_T.UnderlyingPDO__FDO_DATA: [int] int;
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
   assume (forall x : int :: {Mem_T.AddDevice__DRIVER_EXTENSION[x]} (Mem_T.AddDevice__DRIVER_EXTENSION[x] <= 0 || Mem_T.AddDevice__DRIVER_EXTENSION[x] > 298));
   assume (forall x : int :: {Mem_T.CancelRoutine__IRP[x]} (Mem_T.CancelRoutine__IRP[x] <= 0 || Mem_T.CancelRoutine__IRP[x] > 298));
   assume (forall x : int :: {Mem_T.CompletionRoutine__IO_STACK_LOCATION[x]} (Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] <= 0 || Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] > 298));
   assume (forall x : int :: {Mem_T.DriverUnload__DRIVER_OBJECT[x]} (Mem_T.DriverUnload__DRIVER_OBJECT[x] <= 0 || Mem_T.DriverUnload__DRIVER_OBJECT[x] > 298));
   assume (forall x : int :: {Mem_T.MajorFunction__DRIVER_OBJECT[x]} (Mem_T.MajorFunction__DRIVER_OBJECT[x] <= 0 || Mem_T.MajorFunction__DRIVER_OBJECT[x] > 298));
}
function {:inline true} {:fieldmap "Mem_T.Acquired_DRIVER_RESOURCE"}  {:fieldname "Acquired"}  Acquired_DRIVER_RESOURCE(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.AddDevice__DRIVER_EXTENSION"}  {:fieldname "AddDevice"}  AddDevice__DRIVER_EXTENSION(x:int) returns (int) {x + 4}
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
function {:inline true} {:fieldmap "Mem_T.DriverExtension__DRIVER_OBJECT"}  {:fieldname "DriverExtension"}  DriverExtension__DRIVER_OBJECT(x:int) returns (int) {x + 28}
function {:inline true} {:fieldmap "Mem_T.DriverUnload__DRIVER_OBJECT"}  {:fieldname "DriverUnload"}  DriverUnload__DRIVER_OBJECT(x:int) returns (int) {x + 60}
function {:inline true} {:fieldmap "Mem_T.Flags__DEVICE_OBJECT"}  {:fieldname "Flags"}  Flags__DEVICE_OBJECT(x:int) returns (int) {x + 32}
function {:inline true} {:fieldmap "Mem_T.Flink__LIST_ENTRY"}  {:fieldname "Flink"}  Flink__LIST_ENTRY(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Header__KEVENT"}  {:fieldname "Header"}  Header__KEVENT(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Information__IO_STATUS_BLOCK"}  {:fieldname "Information"}  Information__IO_STATUS_BLOCK(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.IoStatus__IRP"}  {:fieldname "IoStatus"}  IoStatus__IRP(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.Length_unnamed_tag_18"}  {:fieldname "Length"}  Length_unnamed_tag_18(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.MajorFunction__DRIVER_OBJECT"}  {:fieldname "MajorFunction"}  MajorFunction__DRIVER_OBJECT(x:int) returns (int) {x + 64}
function {:inline true} {:fieldmap "Mem_T.MajorFunction__IO_STACK_LOCATION"}  {:fieldname "MajorFunction"}  MajorFunction__IO_STACK_LOCATION(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.MinorFunction__IO_STACK_LOCATION"}  {:fieldname "MinorFunction"}  MinorFunction__IO_STACK_LOCATION(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION"}  {:fieldname "NextLowerDriver"}  NextLowerDriver__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 20}
function {:inline true} {:fieldmap "Mem_T.NextLowerDriver__FDO_DATA"}  {:fieldname "NextLowerDriver"}  NextLowerDriver__FDO_DATA(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.Overlay_unnamed_tag_6"}  {:fieldname "Overlay"}  Overlay_unnamed_tag_6(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Parameters__IO_STACK_LOCATION"}  {:fieldname "Parameters"}  Parameters__IO_STACK_LOCATION(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.PendingReturned__IRP"}  {:fieldname "PendingReturned"}  PendingReturned__IRP(x:int) returns (int) {x + 52}
function {:inline true} {:fieldmap "Mem_T.Power_unnamed_tag_8"}  {:fieldname "Power"}  Power_unnamed_tag_8(x:int) returns (int) {x + 420}
function {:inline true} {:fieldmap "Mem_T.QuadPart__LARGE_INTEGER"}  {:fieldname "QuadPart"}  QuadPart__LARGE_INTEGER(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.Read_unnamed_tag_8"}  {:fieldname "Read"}  Read_unnamed_tag_8(x:int) returns (int) {x + 60}
function {:inline true} {:fieldmap "Mem_T.RequiredBufferLength_DEVICE_DATA"}  {:fieldname "RequiredBufferLength"}  RequiredBufferLength_DEVICE_DATA(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.Resource_DRIVER_RESOURCE"}  {:fieldname "Resource"}  Resource_DRIVER_RESOURCE(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Self__FDO_DATA"}  {:fieldname "Self"}  Self__FDO_DATA(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.SignalState__DISPATCHER_HEADER"}  {:fieldname "SignalState"}  SignalState__DISPATCHER_HEADER(x:int) returns (int) {x + 96}
function {:inline true} {:fieldmap "Mem_T.Signalling__DISPATCHER_HEADER"}  {:fieldname "Signalling"}  Signalling__DISPATCHER_HEADER(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.Size__DISPATCHER_HEADER"}  {:fieldname "Size"}  Size__DISPATCHER_HEADER(x:int) returns (int) {x + 56}
function {:inline true} {:fieldmap "Mem_T.Status__IO_STATUS_BLOCK"}  {:fieldname "Status"}  Status__IO_STATUS_BLOCK(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.SystemBuffer_unnamed_tag_2"}  {:fieldname "SystemBuffer"}  SystemBuffer_unnamed_tag_2(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.Tail__IRP"}  {:fieldname "Tail"}  Tail__IRP(x:int) returns (int) {x + 128}
function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_28"}  {:fieldname "Type"}  Type_unnamed_tag_28(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_39"}  {:fieldname "Type"}  Type_unnamed_tag_39(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.UnderlyingPDO__FDO_DATA"}  {:fieldname "UnderlyingPDO"}  UnderlyingPDO__FDO_DATA(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.WaitListHead__DISPATCHER_HEADER"}  {:fieldname "WaitListHead"}  WaitListHead__DISPATCHER_HEADER(x:int) returns (int) {x + 100}
function {:inline true} {:fieldmap "Mem_T.capacity_sdv_hash_925174249"}  {:fieldname "capacity"}  capacity_sdv_hash_925174249(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.currentsize_sdv_hash_925174249"}  {:fieldname "currentsize"}  currentsize_sdv_hash_925174249(x:int) returns (int) {x + 12}
function {:inline true} {:fieldmap "Mem_T.deviceData__DRIVER_DEVICE_EXTENSION"}  {:fieldname "deviceData"}  deviceData__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.pitems_sdv_hash_925174249"}  {:fieldname "pitems"}  pitems_sdv_hash_925174249(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.sdv_derived_object_DEVICE_DATA"}  {:fieldname "sdv_derived_object"}  sdv_derived_object_DEVICE_DATA(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.sdv_derived_object_DEVICE_DATA_BAG"}  {:fieldname "sdv_derived_object"}  sdv_derived_object_DEVICE_DATA_BAG(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.sdv_derived_object_sdv_hash_925174249"}  {:fieldname "sdv_derived_object"}  sdv_derived_object_sdv_hash_925174249(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.sdv_hash_925174249"}  {:fieldname "sdv_hash_925174249"}  sdv_hash_925174249_DEVICE_DATA_BAG(x:int) returns (int) {x + 4}
const {:string "The dispatch routine has returned without releasing a spinlock."} unique strConst__li2bpl2: int;
const {:string "The driver is calling KeAcquireSpinLockRaiseToDpc after already acquiring the spinlock."} unique strConst__li2bpl8: int;
const {:string "The driver is calling KefAcquireSpinLockAtDpcLevel after already acquiring the spinlock."} unique strConst__li2bpl12: int;
const {:string "The driver is calling KefReleaseSpinLockFromDpcLevel without first acquiring the spinlock."} unique strConst__li2bpl10: int;
const {:string "The driver is calling KfAcquireSpinLock after already acquiring the spinlock."} unique strConst__li2bpl7: int;
const {:string "The driver is calling KfReleaseSpinLock without first acquiring the spinlock."} unique strConst__li2bpl3: int;
const {:string "The driver is calling sdv_KeAcquireSpinLock after already acquiring the spinlock."} unique strConst__li2bpl11: int;
const {:string "The driver is calling sdv_KeAcquireSpinLockAtDpcLevel after already acquiring the spinlock."} unique strConst__li2bpl4: int;
const {:string "The driver is calling sdv_KeReleaseSpinLock without first acquiring the spinlock."} unique strConst__li2bpl6: int;
const {:string "The driver is calling sdv_KeReleaseSpinLockFromDpcLevel without first acquiring the spinlock."} unique strConst__li2bpl9: int;
const {:string "callee"} unique strConst__li2bpl1: int;
const {:string "caller"} unique strConst__li2bpl0: int;
const {:string "halt"} unique strConst__li2bpl5: int;

function {:aliasingQuery} alias1(x:int,y:int):bool;
function {:aliasingQuery} alias2(x:int,y:int):bool;
function {:aliasingQuery} alias3(x:int,y:int):bool;
function {:aliasingQuery} alias4(x:int,y:int):bool;
function {:aliasingQuery} alias5(x:int,y:int):bool;
function {:aliasingQuery} alias6(x:int,y:int):bool;
function {:aliasingQuery} alias7(x:int,y:int):bool;
function {:aliasingQuery} alias8(x:int,y:int):bool;
