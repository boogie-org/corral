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
var SLAM_guard_S_0_init:int;
var forward_state:int;
var s:int;
var yogi_error:int;
var SLAM_guard_S_0:int;
var sdv_cancelFptr:int;
var yogi:int;
// ----- Procedures -------
procedure {:origName "sdv_hash_1044063384"} sdv_hash_1044063384(actual_DeviceObject:int, actual_Irp:int) returns (Tmp:int) {
var  sdv: int;
var  status: int;
var  extension: int;
var  Tmp_1: int;
var  DeviceObject: int;
var  Irp: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject := actual_DeviceObject;
  Irp := actual_Irp;
  // done with preamble
  goto L20;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 230} {:print "Atomic Assignment"}  true;
      status := 0;  goto L22;
L10:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 235} {:print "Call \"DispatchSystemControl\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp);   goto L13;
L13:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 237} {:print "Call \"DispatchSystemControl\" \"sdv_IoCallDriver\""}  true;
  assume extension > 0;
  call status := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension)], Irp);   goto L17;
L17:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 239} {:print "Atomic Assignment"}  true;
      Tmp := status;  goto L24;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 239} {:print "Return"}  true;
    goto LM2;
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L22:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 231} {:print "Atomic Assignment"}  true;
    assume DeviceObject > 0;
    extension := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject)];  goto L23;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 233} {:print "Call \"DispatchSystemControl\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L10;
L24:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 239} {:print "Call \"DispatchSystemControl\" \"SLIC_sdv_hash_1044063384_exit\""}  true;
  call SLIC_sdv_hash_1044063384_exit( strConst__li2bpl0, Tmp);   goto L25;
L25:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L19; }
Lfinal: return;
}
procedure {:origName "_sdv_init1"} _sdv_init1() {
var  Tmp_2: int;
var  Tmp_3: int;
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
procedure {:origName "sdv_hash_802080270"} sdv_hash_802080270(actual_DeviceObject_1:int, actual_Irp_1:int) returns (Tmp_4:int) {
var  sdv_1: int;
var  sdv_2: int;
var  Tmp_5: int;
var  sdv_3: int;
var  sdv_4: int;
var  sdv_5: int;
var  spinLock: int;
var  sdv_6: int;
var  stack: int;
var  sdv_7: int;
var  {:dopa}  UlongData: int;
var  status_1: int;
var  resources: int;
var  extension_1: int;
var  lockHandle: int;
var  Tmp_6: int;
var  Tmp_7: int;
var  sdv_8: int;
var  Tmp_8: int;
var  driverResource: int;
var  sdv_9: int;
var  tag: int;
var  {:dopa}  LongData: int;
var  Tmp_9: int;
var  DeviceObject_1: int;
var  Irp_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call UlongData := __HAVOC_malloc(4);
  call lockHandle := __HAVOC_malloc(12);
  call driverResource := __HAVOC_malloc(8);
  call LongData := __HAVOC_malloc(4);
  call Tmp_9 := __HAVOC_malloc(8);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_1 := actual_DeviceObject_1;
  Irp_1 := actual_Irp_1;
  // done with preamble
  goto L92;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 184} {:print "Call \"DispatchRead\" \"SLIC_sdv_hash_802080270_exit\""}  true;
  call SLIC_sdv_hash_802080270_exit( strConst__li2bpl0, Tmp_4);   goto L109;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 121} {:print "Atomic Assignment"}  true;
      status_1 := 0;  goto L94;
L22:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 131} {:print "Atomic Assignment"}  true;
    assume DeviceObject_1 > 0;
    extension_1 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_1)];  goto L103;
L27:
  call {:cexpr "stack->Parameters.Read.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(stack)))]);
  call {:cexpr "extension->DataSize"} boogie_si_record_li2bpl_int(Mem_T.DataSize__DRIVER_DEVICE_EXTENSION[DataSize__DRIVER_DEVICE_EXTENSION(extension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 135} {:print "Atomic Conditional"}  true;
    if(*) { assume stack > 0;
  assume extension_1 > 0;
  assume (Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(stack)))] >= Mem_T.DataSize__DRIVER_DEVICE_EXTENSION[DataSize__DRIVER_DEVICE_EXTENSION(extension_1)]);  goto L28; } else { assume stack > 0;
  assume extension_1 > 0;
  assume (Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(stack)))] < Mem_T.DataSize__DRIVER_DEVICE_EXTENSION[DataSize__DRIVER_DEVICE_EXTENSION(extension_1)]);  goto L31; }
L28:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_8 := __HAVOC_malloc(4);  goto L87;
L31:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 137} {:print "Atomic Assignment"}  true;
      status_1 := -1073741789;  goto L104;
L37:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 140} {:print "Atomic Assignment"}  true;
      Tmp_4 := status_1;  goto L108;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 148} {:print "Call \"DispatchRead\" \"KeAcquireInStackQueuedSpinLock\""}  true;
  call KeAcquireInStackQueuedSpinLock( 0, 0);   goto L44;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 151} {:print "Atomic Assignment"}  true;
      tag := 65;  goto L112;
L49:
  assume {:CounterLoop 3} {:Counter "sdv_8"} true;
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 153} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_8 >= 3);  goto L50; } else { assume (sdv_8 < 3);  goto L54; }
L50:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 176} {:print "Call \"DispatchRead\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_1);   goto L80;
L54:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 153} {:print "Atomic Assignment"}  true;
      Tmp_5 := sdv_8;  goto L115;
L60:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 155} {:print "Atomic Assignment"}  true;
    assume driverResource > 0;
    Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(driverResource)] := sdv_6;  goto L120;
L64:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 161} {:print "Call \"DispatchRead\" \"ExAcquireResourceExclusiveLite\""}  true;
  assume driverResource > 0;
  call boogieTmp := ExAcquireResourceExclusiveLite( 0, 0); Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(driverResource)] := boogieTmp;  goto L68;
L68:
  call {:cexpr "driverResource.Acquired"} boogie_si_record_li2bpl_int(Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(driverResource)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 163} {:print "Atomic Conditional"}  true;
    if(*) { assume driverResource > 0;
  assume (Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(driverResource)] == 0);  goto L69; } else { assume driverResource > 0;
  assume (Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(driverResource)] != 0);  goto L72; }
L69:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(LongData);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(lockHandle);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 170} {:print "Call \"DispatchRead\" \"ReadFromDevice\""}  true;
  call sdv_3 := sdv_hash_104079245( Irp_1, LongData, lockHandle);   goto L78;
L72:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(UlongData);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(lockHandle);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 165} {:print "Call \"DispatchRead\" \"ReadFromDevice\""}  true;
  call sdv_2 := sdv_hash_860032342( Irp_1, UlongData, lockHandle);   goto L75;
L75:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 166} {:print "Call \"DispatchRead\" \"ExReleaseResourceLite\""}  true;
  call ExReleaseResourceLite( 0);   goto L78;
L78:
  call {:cexpr "tag"} boogie_si_record_li2bpl_int(tag);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 173} {:print "Atomic Assignment"}  true;
      tag := (tag + 1);  goto L121;
L80:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_1)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 178} {:print "Call \"DispatchRead\" \"sdv_IoCallDriver\""}  true;
  assume extension_1 > 0;
  call status_1 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_1)], Irp_1);   goto L84;
L84:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 183} {:print "Atomic Assignment"}  true;
      Tmp_4 := status_1;  goto L123;
L86:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_8]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_8 > 0;
    spinLock := Mem_T.INT4[Tmp_8];  goto L111;
L87:
  call {:cexpr "spinLock"} boogie_si_record_li2bpl_int(spinLock);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_8 > 0;
    Mem_T.INT4[Tmp_8] := spinLock;  goto L110;
L88:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 184} {:print "Return"}  true;
    goto LM2;
L89:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 139} {:print "Call \"DispatchRead\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L37;
L90:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 139} {:print "Call \"DispatchRead\" \"SLIC_sdv_IoCompleteRequest_entry\""}  true;
  call SLIC_sdv_IoCompleteRequest_entry( strConst__li2bpl1);   goto L107;
L92:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call resources := __HAVOC_malloc(24);
    call Tmp_6 := __HAVOC_malloc(24);  goto L0;
L94:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 122} {:print "Atomic Assignment"}  true;
      spinLock := 0;  goto L95;
L95:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 123} {:print "Atomic Assignment"}  true;
    assume lockHandle > 0;
    Mem_T.Next__KSPIN_LOCK_QUEUE[Next__KSPIN_LOCK_QUEUE(LockQueue__KLOCK_QUEUE_HANDLE(lockHandle))] := 0;  goto L96;
L96:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 123} {:print "Atomic Assignment"}  true;
    assume lockHandle > 0;
    Mem_T.Lock__KSPIN_LOCK_QUEUE[Lock__KSPIN_LOCK_QUEUE(LockQueue__KLOCK_QUEUE_HANDLE(lockHandle))] := 0;  goto L97;
L97:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 123} {:print "Atomic Assignment"}  true;
    assume lockHandle > 0;
    Mem_T.OldIrql__KLOCK_QUEUE_HANDLE[OldIrql__KLOCK_QUEUE_HANDLE(lockHandle)] := 0;  goto L98;
L98:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 124} {:print "Atomic Assignment"}  true;
      stack := 0;  goto L99;
L99:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 125} {:print "Atomic Assignment"}  true;
      extension_1 := 0;  goto L100;
L100:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 126} {:print "Atomic Assignment"}  true;
    assume UlongData > 0;
    Mem_T.INT4[UlongData] := 10;  goto L101;
L101:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 127} {:print "Atomic Assignment"}  true;
    assume LongData > 0;
    Mem_T.INT4[LongData] := -10;  goto L102;
L102:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 129} {:print "Call \"DispatchRead\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L22;
L103:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 133} {:print "Call \"DispatchRead\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call stack := sdv_IoGetCurrentIrpStackLocation( Irp_1);   goto L27;
L104:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 137} {:print "Atomic Assignment"}  true;
    assume Irp_1 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := status_1;  goto L105;
L105:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 138} {:print "Atomic Assignment"}  true;
    assume Irp_1 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := 0;  goto L106;
L106:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_1);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
  assume alias1(SLAM_guard_S_0, Irp_1);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_1 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L89; } else { assume ((Irp_1 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L90; }
L107:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L89; }
L108:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L109:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L88; }
L110:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 146} {:print "Call \"DispatchRead\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_8);   goto L86;
L111:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L38;
L112:
  call {:cexpr "resources"} boogie_si_record_li2bpl_int(resources);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 153} {:print "Atomic Assignment"}  true;
      sdv_9 := resources;  goto L113;
L113:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_8 := 0;  goto L114;
L114:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L49;
L115:
  call {:cexpr "*sdv"} boogie_si_record_li2bpl_int(Mem_T.PDRIVER_RESOURCE[sdv_9]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 153} {:print "Atomic Assignment"}  true;
    assume sdv_9 > 0;
    Tmp_6 := Mem_T.PDRIVER_RESOURCE[sdv_9];  goto L116;
L116:
  call {:cexpr "(Tmp + (Tmp * 8))->Acquired"} boogie_si_record_li2bpl_int(Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE((Tmp_6 + (Tmp_5 * 8)))]);
  call {:cexpr "(Tmp + (Tmp * 8))->Resource"} boogie_si_record_li2bpl_int(Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE((Tmp_6 + (Tmp_5 * 8)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 153} {:print "Atomic Assignment"}  true;
    assume Tmp_9 > 0;
  assume Tmp_6 > 0;
    Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(Tmp_9)] := Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE((Tmp_6 + (Tmp_5 * 8)))];
  assume Tmp_9 > 0;
  assume Tmp_6 > 0;
    Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(Tmp_9)] := Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE((Tmp_6 + (Tmp_5 * 8)))];  goto L117;
L117:
  call {:cexpr "Tmp.Acquired"} boogie_si_record_li2bpl_int(Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(Tmp_9)]);
  call {:cexpr "Tmp.Resource"} boogie_si_record_li2bpl_int(Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(Tmp_9)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 153} {:print "Atomic Assignment"}  true;
    assume driverResource > 0;
  assume Tmp_9 > 0;
    Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(driverResource)] := Mem_T.Resource_DRIVER_RESOURCE[Resource_DRIVER_RESOURCE(Tmp_9)];
  assume driverResource > 0;
  assume Tmp_9 > 0;
    Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(driverResource)] := Mem_T.Acquired_DRIVER_RESOURCE[Acquired_DRIVER_RESOURCE(Tmp_9)];  goto L118;
L118:
  call {:cexpr "tag"} boogie_si_record_li2bpl_int(tag);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 155} {:print "Atomic Assignment"}  true;
      Tmp_7 := tag;  goto L119;
L119:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(512);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(4);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Tmp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 155} {:print "Call \"DispatchRead\" \"ExAllocatePoolWithTag\""}  true;
  call sdv_6 := ExAllocatePoolWithTag( 512, 4, Tmp_7);   goto L60;
L120:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 156} {:print "Call \"DispatchRead\" \"ExInitializeResourceLite\""}  true;
  call sdv_5 := ExInitializeResourceLite( 0);   goto L64;
L121:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 153} {:print "Atomic Assignment"}  true;
      sdv_8 := (sdv_8 + 1);  goto L122;
L122:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L49;
L123:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_hash_113240927"} sdv_hash_113240927(actual_DeviceObject_2:int, actual_Irp_2:int, actual_EventIn:int) returns (Tmp_10:int) {
var  Tmp_11: int;
var  myEvent: int;
var  {:dopa}  checkIfDisabled: int;
var  DeviceObject_2: int;
var  Irp_2: int;
var  EventIn: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call checkIfDisabled := __HAVOC_malloc(4);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_2 := actual_DeviceObject_2;
  Irp_2 := actual_Irp_2;
  EventIn := actual_EventIn;
  // done with preamble
  goto L14;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  call {:cexpr "EventIn"} boogie_si_record_li2bpl_int(EventIn);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 307} {:print "Atomic Assignment"}  true;
      myEvent := EventIn;  goto L16;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 318} {:print "Atomic Assignment"}  true;
      Tmp_10 := -1073741802;  goto L18;
L9:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(myEvent);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(checkIfDisabled);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 315} {:print "Call \"CompletionRoutine\" \"SetTheEvent\""}  true;
  call sdv_hash_426701529( myEvent, checkIfDisabled);   goto L8;
L14:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 308} {:print "Atomic Assignment"}  true;
    assume checkIfDisabled > 0;
    Mem_T.INT4[checkIfDisabled] := 1;  goto L17;
L17:
  call {:cexpr "Irp->PendingReturned"} boogie_si_record_li2bpl_int(Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 313} {:print "Atomic Conditional"}  true;
    if(*) { assume Irp_2 > 0;
  assume (Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_2)] == 0);  goto L8; } else { assume Irp_2 > 0;
  assume (Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_2)] != 0);  goto L9; }
L18:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 318} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_86802341"} sdv_hash_86802341(actual_DeviceObject_3:int, actual_Irp_3:int) returns (Tmp_12:int) {
var  sdv_10: int;
var  sdv_11: int;
var  status_2: int;
var  Tmp_13: int;
var  extension_2: int;
var  waitEvent: int;
var  DeviceObject_3: int;
var  Irp_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call waitEvent := __HAVOC_malloc(108);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_3 := actual_DeviceObject_3;
  Irp_3 := actual_Irp_3;
  // done with preamble
  goto L48;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 192} {:print "Atomic Assignment"}  true;
      status_2 := 0;  goto L50;
L15:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(waitEvent);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 198} {:print "Call \"DispatchPower\" \"KeInitializeEvent\""}  true;
  call KeInitializeEvent( waitEvent, 0, 0);   goto L18;
L18:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 200} {:print "Call \"DispatchPower\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_3);   goto L21;
L21:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(196);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(waitEvent);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 201} {:print "Call \"DispatchPower\" \"sdv_IoSetCompletionRoutine\""}  true;
  call sdv_IoSetCompletionRoutine( Irp_3, 196, waitEvent, 1, 1, 1);   goto L42;
L24:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_2)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 203} {:print "Call \"DispatchPower\" \"sdv_IoCallDriver\""}  true;
  assume extension_2 > 0;
  call status_2 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_2)], Irp_3);   goto L28;
L28:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 205} {:print "Atomic Conditional"}  true;
    if(*) { assume (status_2 != 259);  goto L29; } else { assume (status_2 == 259);  goto L30; }
L29:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 217} {:print "Atomic Assignment"}  true;
    assume Irp_3 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))] := status_2;  goto L56;
L30:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 207} {:print "Call \"DispatchPower\" \"KeWaitForSingleObject\""}  true;
  call sdv_10 := KeWaitForSingleObject( 0, 0, 0, 0, 0);   goto L33;
L33:
  call {:cexpr "Irp->IoStatus.Status"} boogie_si_record_li2bpl_int(Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 214} {:print "Atomic Assignment"}  true;
    assume Irp_3 > 0;
    status_2 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))];  goto L55;
L38:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 221} {:print "Atomic Assignment"}  true;
      Tmp_12 := status_2;  goto L59;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 221} {:print "Return"}  true;
    goto LM2;
L42:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_3);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
  assume alias2(SLAM_guard_S_0, Irp_3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_3 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L24; } else { assume ((Irp_3 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L43; }
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 201} {:print "Call \"DispatchPower\" \"SLIC_sdv_IoSetCompletionRoutine_exit\""}  true;
  call SLIC_sdv_IoSetCompletionRoutine_exit( 0);   goto L24;
L45:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 219} {:print "Call \"DispatchPower\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L38;
L46:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 219} {:print "Call \"DispatchPower\" \"SLIC_sdv_IoCompleteRequest_entry\""}  true;
  call SLIC_sdv_IoCompleteRequest_entry( strConst__li2bpl1);   goto L58;
L48:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 193} {:print "Atomic Assignment"}  true;
    assume waitEvent > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(waitEvent))] := 0;  goto L51;
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 193} {:print "Atomic Assignment"}  true;
    assume waitEvent > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent)))] := 0;  goto L52;
L52:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 193} {:print "Atomic Assignment"}  true;
    assume waitEvent > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(waitEvent)))] := 0;  goto L53;
L53:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 194} {:print "Atomic Assignment"}  true;
    assume DeviceObject_3 > 0;
    extension_2 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_3)];  goto L54;
L54:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 196} {:print "Call \"DispatchPower\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L15;
L55:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L29;
L56:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 218} {:print "Atomic Assignment"}  true;
    assume Irp_3 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))] := 0;  goto L57;
L57:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_3);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
  assume alias3(SLAM_guard_S_0, Irp_3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_3 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L45; } else { assume ((Irp_3 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L46; }
L58:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L45; }
L59:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 221} {:print "Call \"DispatchPower\" \"SLIC_sdv_hash_86802341_exit\""}  true;
  call SLIC_sdv_hash_86802341_exit( strConst__li2bpl0, Tmp_12);   goto L60;
L60:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L41; }
Lfinal: return;
}
procedure {:origName "sdv_hash_860032342"} sdv_hash_860032342(actual_Irp_4:int, actual_Data:int, actual_LockHandle:int) returns (Tmp_14:int) {
var  Tmp_15: int;
var  Tmp_16: int;
var  Irp_4: int;
var  Data: int;
var  LockHandle: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Irp_4 := actual_Irp_4;
  Data := actual_Data;
  LockHandle := actual_LockHandle;
  // done with preamble
  goto L6;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_4))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 358} {:print "Atomic Assignment"}  true;
    assume Irp_4 > 0;
    Tmp_16 := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_4))];  goto L8;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L8:
  call {:cexpr "*Data"} boogie_si_record_li2bpl_int(Mem_T.INT4[Data]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 358} {:print "Atomic Assignment"}  true;
    assume Tmp_16 > 0;
  assume Data > 0;
    Mem_T.INT4[Tmp_16] := Mem_T.INT4[Data];  goto L9;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 360} {:print "Atomic Assignment"}  true;
      Tmp_14 := 0;  goto L10;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 360} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_104079245"} sdv_hash_104079245(actual_Irp_5:int, actual_Data_1:int, actual_LockHandle_1:int) returns (Tmp_17:int) {
var  Tmp_18: int;
var  Tmp_19: int;
var  Irp_5: int;
var  Data_1: int;
var  LockHandle_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Irp_5 := actual_Irp_5;
  Data_1 := actual_Data_1;
  LockHandle_1 := actual_LockHandle_1;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_5))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 368} {:print "Atomic Assignment"}  true;
    assume Irp_5 > 0;
    Tmp_18 := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp_5))];  goto L11;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 372} {:print "Atomic Assignment"}  true;
      Tmp_17 := 0;  goto L13;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L11:
  call {:cexpr "*Data"} boogie_si_record_li2bpl_int(Mem_T.INT4[Data_1]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 368} {:print "Atomic Assignment"}  true;
    assume Tmp_18 > 0;
  assume Data_1 > 0;
    Mem_T.INT4[Tmp_18] := Mem_T.INT4[Data_1];  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 370} {:print "Call \"ReadFromDevice\" \"KeReleaseInStackQueuedSpinLock\""}  true;
  call KeReleaseInStackQueuedSpinLock( 0);   goto L7;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 372} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_945836574"} sdv_hash_945836574(actual_Dpc:int, actual_DeviceObject_4:int, actual_Irp_6:int, actual_Context:int) {
var  Tmp_20: int;
var  Tmp_21: int;
var  Dpc: int;
var  DeviceObject_4: int;
var  Irp_6: int;
var  Context: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Dpc := actual_Dpc;
  DeviceObject_4 := actual_DeviceObject_4;
  Irp_6 := actual_Irp_6;
  Context := actual_Context;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 349} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_hash_426701529"} sdv_hash_426701529(actual_Event:int, actual_CheckIfDisabled:int) {
var  sdv_12: int;
var  sdv_13: int;
var  Tmp_22: int;
var  disabled: int;
var  Tmp_23: int;
var  Event: int;
var  CheckIfDisabled: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Event := actual_Event;
  CheckIfDisabled := actual_CheckIfDisabled;
  // done with preamble
  goto L17;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 390} {:print "Return"}  true;
    goto LM2;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 379} {:print "Atomic Assignment"}  true;
      disabled := 1;  goto L19;
L6:
  call {:cexpr "disabled"} boogie_si_record_li2bpl_int(disabled);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 386} {:print "Atomic Conditional"}  true;
    if(*) { assume (disabled == 0);  goto L1; } else { assume (disabled != 0);  goto L11; }
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 383} {:print "Call \"SetTheEvent\" \"KeAreApcsDisabled\""}  true;
  call disabled := KeAreApcsDisabled();   goto L6;
L11:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Event);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 388} {:print "Call \"SetTheEvent\" \"KeSetEvent\""}  true;
  call sdv_12 := KeSetEvent( Event, 0, 0);   goto L1;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L19:
  call {:cexpr "*CheckIfDisabled"} boogie_si_record_li2bpl_int(Mem_T.INT4[CheckIfDisabled]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 381} {:print "Atomic Conditional"}  true;
    if(*) { assume CheckIfDisabled > 0;
  assume (Mem_T.INT4[CheckIfDisabled] == 0);  goto L6; } else { assume CheckIfDisabled > 0;
  assume (Mem_T.INT4[CheckIfDisabled] != 0);  goto L7; }
Lfinal: return;
}
procedure {:origName "sdv_hash_373344998"} sdv_hash_373344998(actual_Interrupt:int, actual_DeviceExtensionIn:int) returns (Tmp_24:int) {
var  Context_1: int;
var  DeviceExtension: int;
var  Tmp_25: int;
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
  goto L12;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 329} {:print "Atomic Assignment"}  true;
      Context_1 := 0;  goto L14;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 334} {:print "Atomic Assignment"}  true;
      Tmp_24 := 1;  goto L16;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L14:
  call {:cexpr "DeviceExtensionIn"} boogie_si_record_li2bpl_int(DeviceExtensionIn);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 330} {:print "Atomic Assignment"}  true;
      DeviceExtension := DeviceExtensionIn;  goto L15;
L15:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.DeviceObject__DRIVER_DEVICE_EXTENSION[DeviceObject__DRIVER_DEVICE_EXTENSION(DeviceExtension)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Mem_T.Irp__DRIVER_DEVICE_EXTENSION[Irp__DRIVER_DEVICE_EXTENSION(DeviceExtension)]);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Context_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 332} {:print "Call \"InterruptServiceRoutine\" \"sdv_IoRequestDpc\""}  true;
  assume DeviceExtension > 0;
  call sdv_IoRequestDpc( Mem_T.DeviceObject__DRIVER_DEVICE_EXTENSION[DeviceObject__DRIVER_DEVICE_EXTENSION(DeviceExtension)], Mem_T.Irp__DRIVER_DEVICE_EXTENSION[Irp__DRIVER_DEVICE_EXTENSION(DeviceExtension)], Context_1);   goto L10;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 334} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_hash_590764100"} sdv_hash_590764100(actual_DeviceObject_5:int, actual_Irp_7:int) returns (Tmp_26:int) {
var  sdv_14: int;
var  sdv_15: int;
var  ProcessorMask: int;
var  stack_1: int;
var  sdv_16: int;
var  status_3: int;
var  Tmp_27: int;
var  extension_3: int;
var  DeviceObject_5: int;
var  Irp_7: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_5 := actual_DeviceObject_5;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 248} {:print "Atomic Assignment"}  true;
      extension_3 := 0;  goto L39;
L14:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 255} {:print "Call \"DispatchPnp\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call stack_1 := sdv_IoGetCurrentIrpStackLocation( Irp_7);   goto L18;
L18:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_5)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 257} {:print "Atomic Assignment"}  true;
    assume DeviceObject_5 > 0;
    extension_3 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_5)];  goto L43;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 281} {:print "Atomic Assignment"}  true;
      status_3 := -1073741822;  goto L47;
L21:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 262} {:print "Atomic Assignment"}  true;
      ProcessorMask := 1;  goto L44;
L25:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 276} {:print "Call \"DispatchPnp\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_7);   goto L28;
L28:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_3)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 278} {:print "Call \"DispatchPnp\" \"sdv_IoCallDriver\""}  true;
  assume extension_3 > 0;
  call status_3 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_3)], Irp_7);   goto L33;
L33:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 284} {:print "Atomic Assignment"}  true;
      Tmp_26 := status_3;  goto L45;
L36:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 284} {:print "Return"}  true;
    goto LM2;
L37:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 249} {:print "Atomic Assignment"}  true;
      stack_1 := 0;  goto L40;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 250} {:print "Atomic Assignment"}  true;
      status_3 := 0;  goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 251} {:print "Atomic Assignment"}  true;
      ProcessorMask := 0;  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 253} {:print "Call \"DispatchPnp\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L14;
L43:
  call {:cexpr "stack->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(stack_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 259} {:print "Atomic Conditional"}  true;
    if(*) { assume stack_1 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(stack_1)] != 0);  goto L20; } else { assume stack_1 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(stack_1)] == 0);  goto L21; }
L44:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(InterruptObject__DRIVER_DEVICE_EXTENSION(extension_3));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(197);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(extension_3);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(Mem_T.ControllerVector__DRIVER_DEVICE_EXTENSION[ControllerVector__DRIVER_DEVICE_EXTENSION(extension_3)]);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg7"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg8"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg9"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg10"} boogie_si_record_li2bpl_int(ProcessorMask);
  call {:cexpr "arg11"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 264} {:print "Call \"DispatchPnp\" \"IoConnectInterrupt\""}  true;
  assume extension_3 > 0;
  call sdv_15 := IoConnectInterrupt( InterruptObject__DRIVER_DEVICE_EXTENSION(extension_3), 197, extension_3, 0, Mem_T.ControllerVector__DRIVER_DEVICE_EXTENSION[ControllerVector__DRIVER_DEVICE_EXTENSION(extension_3)], 0, 0, 0, 1, ProcessorMask, 1);   goto L25;
L45:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_26);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 284} {:print "Call \"DispatchPnp\" \"SLIC_sdv_hash_590764100_exit\""}  true;
  call SLIC_sdv_hash_590764100_exit( strConst__li2bpl0, Tmp_26);   goto L46;
L46:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L36; }
L47:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L33;
Lfinal: return;
}
procedure {:origName "sdv_hash_701990220"} sdv_hash_701990220(actual_DeviceObject_6:int, actual_Irp_8:int) returns (Tmp_28:int) {
var  Tmp_29: int;
var  sdv_17: int;
var  status_4: int;
var  extension_4: int;
var  DeviceObject_6: int;
var  Irp_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_6 := actual_DeviceObject_6;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 103} {:print "Atomic Assignment"}  true;
      status_4 := 0;  goto L22;
L10:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 108} {:print "Call \"DispatchCreate\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_8);   goto L13;
L13:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_4)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 110} {:print "Call \"DispatchCreate\" \"sdv_IoCallDriver\""}  true;
  assume extension_4 > 0;
  call status_4 := sdv_IoCallDriver( Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION[NextLowerDriver__DRIVER_DEVICE_EXTENSION(extension_4)], Irp_8);   goto L17;
L17:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 112} {:print "Atomic Assignment"}  true;
      Tmp_28 := status_4;  goto L24;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 112} {:print "Return"}  true;
    goto LM2;
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L22:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_6)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 104} {:print "Atomic Assignment"}  true;
    assume DeviceObject_6 > 0;
    extension_4 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_6)];  goto L23;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 106} {:print "Call \"DispatchCreate\" \"sdv_do_paged_code_check\""}  true;
  call sdv_do_paged_code_check();   goto L10;
L24:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl0);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_28);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\fail_driver4.cpp"} {:sourceline 112} {:print "Call \"DispatchCreate\" \"SLIC_sdv_hash_701990220_exit\""}  true;
  call SLIC_sdv_hash_701990220_exit( strConst__li2bpl0, Tmp_28);   goto L25;
L25:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L19; }
Lfinal: return;
}
procedure {:origName "sdv_IoCallDriver"} sdv_IoCallDriver(actual_DeviceObject_7:int, actual_Irp_9:int) returns (Tmp_30:int) {
var  sdv_18: int;
var  Tmp_31: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10057} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_9);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10056} {:print "Call \"sdv_IoCallDriver\" \"IofCallDriver\""}  true;
  call Tmp_30 := IofCallDriver( 0, Irp_9);   goto L1;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_IoGetNextIrpStackLocation"} sdv_IoGetNextIrpStackLocation(actual_pirp:int) returns (Tmp_32:int) {
var  Tmp_33: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10901} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp);
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10894} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp != sdv_harnessIrp);  goto L4; } else { assume (pirp == sdv_harnessIrp);  goto L5; }
L4:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp);
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10896} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp != sdv_other_harnessIrp);  goto L6; } else { assume (pirp == sdv_other_harnessIrp);  goto L7; }
L5:
  call {:cexpr "&sdv_harnessStackLocation_next"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation_next);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10895} {:print "Atomic Assignment"}  true;
      Tmp_32 := sdv_harnessStackLocation_next;  goto L11;
L6:
  call {:cexpr "&sdv_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10899} {:print "Atomic Assignment"}  true;
      Tmp_32 := sdv_harnessStackLocation;  goto L13;
L7:
  call {:cexpr "&sdv_other_harnessStackLocation_next"} boogie_si_record_li2bpl_int(sdv_other_harnessStackLocation_next);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10897} {:print "Atomic Assignment"}  true;
      Tmp_32 := sdv_other_harnessStackLocation_next;  goto L12;
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
procedure {:origName "KeInitializeEvent"} KeInitializeEvent(actual_Event_1:int, actual_Type:int, actual_State:int) {
var  Tmp_34: int;
var  Tmp_35: int;
var  Event_1: int;
var  Type: int;
var  State: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Event_1 := actual_Event_1;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12791} {:print "Atomic Assignment"}  true;
    assume Event_1 > 0;
    Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(Header__KEVENT(Event_1))] := Type;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12792} {:print "Atomic Assignment"}  true;
    assume Event_1 > 0;
    Mem_T.Signalling__DISPATCHER_HEADER[Signalling__DISPATCHER_HEADER(Header__KEVENT(Event_1))] := 0;  goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12793} {:print "Atomic Assignment"}  true;
    assume Event_1 > 0;
    Mem_T.Size__DISPATCHER_HEADER[Size__DISPATCHER_HEADER(Header__KEVENT(Event_1))] := 4;  goto L12;
L12:
  call {:cexpr "State"} boogie_si_record_li2bpl_int(State);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12794} {:print "Atomic Assignment"}  true;
    assume Event_1 > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_1))] := State;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12795} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeSetEvent"} KeSetEvent(actual_Event_2:int, actual_Increment:int, actual_Wait:int) returns (Tmp_36:int) {
var  Tmp_37: int;
var  OldState: int;
var  Event_2: int;
var  Increment: int;
var  Wait: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Event_2 := actual_Event_2;
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
  call {:cexpr "Event->Header.SignalState"} boogie_si_record_li2bpl_int(Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_2))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13050} {:print "Atomic Assignment"}  true;
    assume Event_2 > 0;
    OldState := Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_2))];  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13051} {:print "Atomic Assignment"}  true;
    assume Event_2 > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_2))] := 1;  goto L11;
L11:
  call {:cexpr "OldState"} boogie_si_record_li2bpl_int(OldState);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13052} {:print "Atomic Assignment"}  true;
      Tmp_36 := OldState;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13052} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "ExAcquireResourceExclusiveLite"} ExAcquireResourceExclusiveLite(actual_Resource:int, actual_Wait_1:int) returns (Tmp_38:int) {
var  sdv_19: int;
var  Tmp_39: int;
var  choice: int;
var  Resource: int;
var  Wait_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Resource := actual_Resource;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7218} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "Wait"} boogie_si_record_li2bpl_int(Wait_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7204} {:print "Atomic Conditional"}  true;
    if(*) { assume (Wait_1 != 0);  goto L5; } else { assume (Wait_1 == 0);  goto L10; }
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7204} {:print "Atomic Assignment"}  true;
      Tmp_38 := 1;  goto L17;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7207} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L12; }
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7213} {:print "Atomic Assignment"}  true;
      Tmp_38 := 1;  goto L19;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7210} {:print "Atomic Assignment"}  true;
      Tmp_38 := 0;  goto L18;
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
procedure {:origName "main"} main() returns (Tmp_40:int) {
var  Tmp_41: int;
var  Tmp_42: int;
var  Tmp_43: int;
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
  call SLAM_guard_S_0_init := __HAVOC_malloc(240);
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6695} {:print "Atomic Continuation"}  true;
    goto L25;
L3:
  call {:cexpr "sdv_harnessDeviceExtension"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_harnessDeviceExtension != 0);  goto L28; } else { assume (sdv_harnessDeviceExtension == 0);  goto L29; }
L7:
  call {:cexpr "sdv_harnessDeviceExtension_two"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension_two);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_harnessDeviceExtension_two != 0);  goto L32; } else { assume (sdv_harnessDeviceExtension_two == 0);  goto L33; }
L11:
  call {:cexpr "sdv_harnessDeviceExtension"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
      Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(sdv_devobj_pdo)] := sdv_harnessDeviceExtension;  goto L35;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"main\" \"_sdv_init1\""}  true;
  call _sdv_init1();   goto L3;
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"main\" \"_sdv_init2\""}  true;
  call _sdv_init2();   goto L19;
L21:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_42);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Continuation"}  true;
  assume(Tmp_42 != 0);   goto L30;
L22:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_41);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Continuation"}  true;
  assume(Tmp_41 != 0);   goto L34;
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
      Tmp_42 := 1;  goto L27;
L29:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_42 := 0;  goto L27;
L30:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L31:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L22;
L32:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_41 := 1;  goto L31;
L33:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_41 := 0;  goto L31;
L34:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L35:
  call {:cexpr "sdv_harnessDeviceExtension_two"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension_two);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
      Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(sdv_devobj_fdo)] := sdv_harnessDeviceExtension_two;  goto L36;
L36:
  call {:cexpr "&sdv_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
    assume sdv_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_irp)))] := sdv_harnessStackLocation;  goto L37;
L37:
  call {:cexpr "&sdv_other_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_other_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
    assume sdv_other_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_other_irp)))] := sdv_other_harnessStackLocation;  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6694} {:print "Call \"main\" \"sdv_main\""}  true;
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
var  Tmp_44: int;
var  sdv_20: int;
var  Tmp_45: int;
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
  call {:cexpr "sdv_irp"} boogie_si_record_li2bpl_int(sdv_irp);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      SLAM_guard_S_0 := sdv_irp;  goto L12;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 319} {:print "Return"}  true;
    goto LM2;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 316} {:print "Call \"sdv_main\" \"sdv_stub_driver_init\""}  true;
  call sdv_stub_driver_init();   goto L6;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 317} {:print "Call \"sdv_main\" \"sdv_RunDispatchFunction\""}  true;
  call sdv_20 := sdv_RunDispatchFunction( sdv_p_devobj_fdo, sdv_irp);   goto L15;
L10:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L12:
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
  assume(SLAM_guard_S_0 != 0);   goto L13;
L13:
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
  assume(SLAM_guard_S_0 != SLAM_guard_S_0_init);   goto L14;
L14:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L15:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
Lfinal: return;
}
procedure {:origName "sdv_stub_dispatch_begin"} sdv_stub_dispatch_begin() {
var  Tmp_46: int;
var  Tmp_47: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L11;
L11:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6745} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_do_paged_code_check"} sdv_do_paged_code_check() {
var  Tmp_48: int;
var  Tmp_49: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6698} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_SetPowerIrpMinorFunction"} sdv_SetPowerIrpMinorFunction(actual_pirp_1:int) {
var  sdv_21: int;
var  sdv_22: int;
var  y: int;
var  x: int;
var  r: int;
var  Tmp_50: int;
var  Tmp_51: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1382} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_1)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1337} {:print "Atomic Assignment"}  true;
    assume pirp_1 > 0;
    r := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_1)))];  goto L45;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1341} {:print "Atomic Continuation"}  true;
    if(*) {  goto L17; } else {  goto L37; }
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1343} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 2;  goto L46;
L18:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1357} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 3;  goto L49;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1373} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 1;  goto L52;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1361} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 0;  goto L50;
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1346} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 0;  goto L47;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1379} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 0;  goto L53;
L36:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L19; } else {  goto L35; }
L37:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L18; } else {  goto L36; }
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1351} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 1;  goto L48;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1366} {:print "Atomic Assignment"}  true;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 1;  goto L51;
L43:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L45:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L15;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1344} {:print "Atomic Continuation"}  true;
    if(*) {  goto L29; } else {  goto L39; }
L47:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L48:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1358} {:print "Atomic Continuation"}  true;
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
var  Tmp_52: int;
var  Tmp_53: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10106} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "ExReleaseResourceLite"} ExReleaseResourceLite(actual_Resource_1:int) {
var  Tmp_54: int;
var  Tmp_55: int;
var  Resource_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Resource_1 := actual_Resource_1;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7658} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "KeReleaseInStackQueuedSpinLock"} KeReleaseInStackQueuedSpinLock(actual_LockHandle_2:int) {
var  Tmp_56: int;
var  Tmp_57: int;
var  LockHandle_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  LockHandle_2 := actual_LockHandle_2;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12954} {:print "Atomic Assignment"}  true;
      sdv_irql_current := sdv_irql_previous;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12954} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L10;
L10:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12954} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12955} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_RunIoDpcRoutines"} sdv_RunIoDpcRoutines(actual_Dpc_1:int, actual_DeviceObject_8:int, actual_Irp_10:int, actual_Context_2:int) {
var  Tmp_58: int;
var  Tmp_59: int;
var  Dpc_1: int;
var  DeviceObject_8: int;
var  Irp_10: int;
var  Context_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Dpc_1 := actual_Dpc_1;
  DeviceObject_8 := actual_DeviceObject_8;
  Irp_10 := actual_Irp_10;
  Context_2 := actual_Context_2;
  // done with preamble
  goto L18;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3710} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "sdv_io_dpc"} boogie_si_record_li2bpl_int(sdv_io_dpc);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3663} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_io_dpc != 195);  goto L1; } else { assume (sdv_io_dpc == 195);  goto L4; }
L4:
  call {:cexpr "sdv_dpc_io_registered"} boogie_si_record_li2bpl_int(sdv_dpc_io_registered);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3663} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_dpc_io_registered == 0);  goto L1; } else { assume (sdv_dpc_io_registered != 0);  goto L5; }
L5:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3665} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L20;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3667} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L24;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L20:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3665} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L21;
L21:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3665} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L22;
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3665} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L23;
L23:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Dpc_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(DeviceObject_8);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Irp_10);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(Context_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3666} {:print "Call \"sdv_RunIoDpcRoutines\" \"DpcForIsrRoutine\""}  true;
  call sdv_hash_945836574( Dpc_1, DeviceObject_8, Irp_10, Context_2);   goto L12;
L24:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3667} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L25;
L25:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3667} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L26;
L26:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "KeWaitForSingleObject"} KeWaitForSingleObject(actual_Object:int, actual_WaitReason:int, actual_WaitMode:int, actual_Alertable:int, actual_Timeout:int) returns (Tmp_60:int) {
var  sdv_23: int;
var  x_1: int;
var  Tmp_61: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13132} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "Timeout"} boogie_si_record_li2bpl_int(Timeout);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13118} {:print "Atomic Conditional"}  true;
    if(*) { assume (Timeout == 0);  goto L9; } else { assume (Timeout != 0);  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13120} {:print "Atomic Assignment"}  true;
      Tmp_60 := 0;  goto L19;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13122} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L12; }
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13129} {:print "Atomic Assignment"}  true;
      Tmp_60 := 0;  goto L18;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13124} {:print "Atomic Assignment"}  true;
      Tmp_60 := 258;  goto L17;
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
procedure {:origName "sdv_IoSetCompletionRoutine"} sdv_IoSetCompletionRoutine(actual_pirp_3:int, actual_CompletionRoutine:int, actual_Context_3:int, actual_InvokeOnSuccess:int, actual_InvokeOnError:int, actual_InvokeOnCancel:int) {
var  sdv_24: int;
var  irpSp: int;
var  Tmp_62: int;
var  Tmp_63: int;
var  pirp_3: int;
var  CompletionRoutine: int;
var  Context_3: int;
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
  Context_3 := actual_Context_3;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11508} {:print "Call \"sdv_IoSetCompletionRoutine\" \"sdv_IoGetNextIrpStackLocation\""}  true;
  call irpSp := sdv_IoGetNextIrpStackLocation( pirp_3);   goto L8;
L8:
  call {:cexpr "CompletionRoutine"} boogie_si_record_li2bpl_int(CompletionRoutine);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11509} {:print "Atomic Assignment"}  true;
    assume irpSp > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpSp)] := CompletionRoutine;  goto L17;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11510} {:print "Atomic Assignment"}  true;
      sdv_compFset := 1;  goto L18;
L18:
  call {:cexpr "Context"} boogie_si_record_li2bpl_int(Context_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11511} {:print "Atomic Assignment"}  true;
      sdv_context := Context_3;  goto L19;
L19:
  call {:cexpr "InvokeOnSuccess"} boogie_si_record_li2bpl_int(InvokeOnSuccess);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11512} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_success := InvokeOnSuccess;  goto L20;
L20:
  call {:cexpr "InvokeOnError"} boogie_si_record_li2bpl_int(InvokeOnError);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11513} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_error := InvokeOnError;  goto L21;
L21:
  call {:cexpr "InvokeOnCancel"} boogie_si_record_li2bpl_int(InvokeOnCancel);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11514} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_cancel := InvokeOnCancel;  goto L22;
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11516} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_Trap"} sdv_Trap() {
var  Tmp_64: int;
var  Tmp_65: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1294} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "ExAllocatePoolWithTag"} ExAllocatePoolWithTag(actual_PoolType:int, actual_NumberOfBytes:int, actual_Tag:int) returns (Tmp_66:int) {
var  Tmp_67: int;
var  sdv_25: int;
var  sdv_26: int;
var  x_2: int;
var  PoolType: int;
var  NumberOfBytes: int;
var  Tag: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  PoolType := actual_PoolType;
  NumberOfBytes := actual_NumberOfBytes;
  Tag := actual_Tag;
  // done with preamble
  goto L16;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7348} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7343} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7346} {:print "Atomic Assignment"}  true;
      Tmp_66 := 0;  goto L19;
L10:
  call {:cexpr "NumberOfBytes"} boogie_si_record_li2bpl_int(NumberOfBytes);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7345} {:print "Atomic Assignment"}  true;
      call sdv_25 := __HAVOC_malloc(NumberOfBytes);  goto L13;
L13:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_25);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7345} {:print "Atomic Assignment"}  true;
      Tmp_66 := sdv_25;  goto L18;
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
var  Tmp_68: int;
var  Tmp_69: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10188} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_4);
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_4 != sdv_harnessIrp);  goto L4; } else { assume (pirp_4 == sdv_harnessIrp);  goto L5; }
L4:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_4);
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_4 != sdv_other_harnessIrp);  goto L1; } else { assume (pirp_4 == sdv_other_harnessIrp);  goto L7; }
L5:
  call {:cexpr "sdv_harnessStackLocation.MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];  goto L14;
L7:
  call {:cexpr "sdv_other_harnessStackLocation.MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];  goto L16;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L14:
  call {:cexpr "sdv_harnessStackLocation.MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];  goto L15;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L16:
  call {:cexpr "sdv_other_harnessStackLocation.MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];  goto L17;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_IoRequestDpc"} sdv_IoRequestDpc(actual_DeviceObject_9:int, actual_Irp_11:int, actual_Context_4:int) {
var  Tmp_70: int;
var  Tmp_71: int;
var  DeviceObject_9: int;
var  Irp_11: int;
var  Context_4: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_9 := actual_DeviceObject_9;
  Irp_11 := actual_Irp_11;
  Context_4 := actual_Context_4;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11471} {:print "Return"}  true;
    goto LM2;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11466} {:print "Atomic Assignment"}  true;
      sdv_dpc_io_registered := 1;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Context_4);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(DeviceObject_9);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Irp_11);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(Context_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 11468} {:print "Call \"sdv_IoRequestDpc\" \"sdv_RunIoDpcRoutines\""}  true;
  call sdv_RunIoDpcRoutines( Context_4, DeviceObject_9, Irp_11, Context_4);   goto L1;
Lfinal: return;
}
procedure {:origName "sdv_SetStatus"} sdv_SetStatus(actual_pirp_5:int) {
var  sdv_27: int;
var  Tmp_72: int;
var  choice_1: int;
var  Tmp_73: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1506} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1497} {:print "Atomic Continuation"}  true;
    if(*) {  goto L10; } else {  goto L14; }
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1499} {:print "Atomic Assignment"}  true;
    assume pirp_5 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_5))] := -1073741637;  goto L18;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1503} {:print "Atomic Assignment"}  true;
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
var  Tmp_74: int;
var  Tmp_75: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6708} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "_sdv_init2"} _sdv_init2() {
var  Tmp_76: int;
var  Tmp_77: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 75} {:print "Atomic Assignment"}  true;
      sdv_dpc_io_registered := 0;  goto L10;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 77} {:print "Atomic Assignment"}  true;
      sdv_apc_disabled := 0;  goto L11;
L11:
  call {:cexpr "&sdv_ControllerIrp"} boogie_si_record_li2bpl_int(sdv_ControllerIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 82} {:print "Atomic Assignment"}  true;
      sdv_ControllerPirp := sdv_ControllerIrp;  goto L12;
L12:
  call {:cexpr "&sdv_StartIoIrp"} boogie_si_record_li2bpl_int(sdv_StartIoIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 85} {:print "Atomic Assignment"}  true;
      sdv_StartIopirp := sdv_StartIoIrp;  goto L13;
L13:
  call {:cexpr "&sdv_PowerIrp"} boogie_si_record_li2bpl_int(sdv_PowerIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 89} {:print "Atomic Assignment"}  true;
      sdv_power_irp := sdv_PowerIrp;  goto L14;
L14:
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 93} {:print "Atomic Assignment"}  true;
      sdv_irp := sdv_harnessIrp;  goto L15;
L15:
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 100} {:print "Atomic Assignment"}  true;
      sdv_other_irp := sdv_other_harnessIrp;  goto L16;
L16:
  call {:cexpr "&sdv_IoMakeAssociatedIrp_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoMakeAssociatedIrp_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 105} {:print "Atomic Assignment"}  true;
      sdv_IoMakeAssociatedIrp_irp := sdv_IoMakeAssociatedIrp_harnessIrp;  goto L17;
L17:
  call {:cexpr "&sdv_IoBuildDeviceIoControlRequest_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 110} {:print "Atomic Assignment"}  true;
      sdv_IoBuildDeviceIoControlRequest_irp := sdv_IoBuildDeviceIoControlRequest_harnessIrp;  goto L18;
L18:
  call {:cexpr "&sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock"} boogie_si_record_li2bpl_int(sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 114} {:print "Atomic Assignment"}  true;
      sdv_IoBuildDeviceIoControlRequest_IoStatusBlock := sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock;  goto L19;
L19:
  call {:cexpr "&sdv_IoBuildSynchronousFsdRequest_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 121} {:print "Atomic Assignment"}  true;
      sdv_IoBuildSynchronousFsdRequest_irp := sdv_IoBuildSynchronousFsdRequest_harnessIrp;  goto L20;
L20:
  call {:cexpr "&sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock"} boogie_si_record_li2bpl_int(sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 125} {:print "Atomic Assignment"}  true;
      sdv_IoBuildSynchronousFsdRequest_IoStatusBlock := sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;  goto L21;
L21:
  call {:cexpr "&sdv_IoBuildAsynchronousFsdRequest_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 129} {:print "Atomic Assignment"}  true;
      sdv_IoBuildAsynchronousFsdRequest_irp := sdv_IoBuildAsynchronousFsdRequest_harnessIrp;  goto L22;
L22:
  call {:cexpr "&sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock"} boogie_si_record_li2bpl_int(sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 133} {:print "Atomic Assignment"}  true;
      sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock := sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;  goto L23;
L23:
  call {:cexpr "&sdv_IoInitializeIrp_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoInitializeIrp_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 138} {:print "Atomic Assignment"}  true;
      sdv_IoInitializeIrp_irp := sdv_IoInitializeIrp_harnessIrp;  goto L24;
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 153} {:print "Atomic Assignment"}  true;
      sdv_io_create_device_called := 0;  goto L25;
L25:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 196} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L26;
L26:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 197} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := 0;  goto L27;
L27:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 198} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := 0;  goto L28;
L28:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 199} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := 0;  goto L29;
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 201} {:print "Atomic Assignment"}  true;
      sdv_maskedEflags := 0;  goto L30;
L30:
  call {:cexpr "&sdv_kdpc_val3"} boogie_si_record_li2bpl_int(sdv_kdpc_val3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 209} {:print "Atomic Assignment"}  true;
      sdv_kdpc3 := sdv_kdpc_val3;  goto L31;
L31:
  call {:cexpr "&sdv_devobj_fdo"} boogie_si_record_li2bpl_int(sdv_devobj_fdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 229} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_fdo := sdv_devobj_fdo;  goto L32;
L32:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 232} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 0;  goto L33;
L33:
  call {:cexpr "&sdv_devobj_pdo"} boogie_si_record_li2bpl_int(sdv_devobj_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 237} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_pdo := sdv_devobj_pdo;  goto L34;
L34:
  call {:cexpr "&sdv_devobj_child_pdo"} boogie_si_record_li2bpl_int(sdv_devobj_child_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 241} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_child_pdo := sdv_devobj_child_pdo;  goto L35;
L35:
  call {:cexpr "&sdv_kinterrupt_val"} boogie_si_record_li2bpl_int(sdv_kinterrupt_val);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 245} {:print "Atomic Assignment"}  true;
      sdv_kinterrupt := sdv_kinterrupt_val;  goto L36;
L36:
  call {:cexpr "&sdv_MapRegisterBase_val"} boogie_si_record_li2bpl_int(sdv_MapRegisterBase_val);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 248} {:print "Atomic Assignment"}  true;
      sdv_MapRegisterBase := sdv_MapRegisterBase_val;  goto L37;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 252} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_success := 0;  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 255} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_error := 0;  goto L39;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 258} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_cancel := 0;  goto L40;
L40:
  call {:cexpr "&sdv_fx_dev_object"} boogie_si_record_li2bpl_int(sdv_fx_dev_object);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 264} {:print "Atomic Assignment"}  true;
      p_sdv_fx_dev_object := sdv_fx_dev_object;  goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1211} {:print "Atomic Assignment"}  true;
      sdv_start_irp_already_issued := 0;  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1212} {:print "Atomic Assignment"}  true;
      sdv_remove_irp_already_issued := 0;  goto L43;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1213} {:print "Atomic Assignment"}  true;
      sdv_Io_Removelock_release_wait_returned := 0;  goto L44;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1216} {:print "Atomic Assignment"}  true;
      sdv_compFset := 0;  goto L45;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1227} {:print "Atomic Assignment"}  true;
      sdv_isr_routine := 276;  goto L46;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1242} {:print "Atomic Assignment"}  true;
      sdv_ke_dpc := 278;  goto L47;
L47:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1244} {:print "Atomic Assignment"}  true;
      sdv_dpc_ke_registered := 0;  goto L48;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1258} {:print "Atomic Assignment"}  true;
      sdv_io_dpc := 281;  goto L49;
L49:
  call {:cexpr "&sdv_devobj_top"} boogie_si_record_li2bpl_int(sdv_devobj_top);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9504} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_top := sdv_devobj_top;  goto L50;
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13869} {:print "Atomic Assignment"}  true;
      sdv_MmMapIoSpace_int := 0;  goto L51;
L51:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeAcquireInStackQueuedSpinLock"} KeAcquireInStackQueuedSpinLock(actual_SpinLock:int, actual_LockHandle_3:int) {
var  Tmp_78: int;
var  Tmp_79: int;
var  SpinLock: int;
var  LockHandle_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SpinLock := actual_SpinLock;
  LockHandle_3 := actual_LockHandle_3;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12608} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12608} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L11;
L11:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12608} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12608} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 12609} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_stub_dispatch_end"} sdv_stub_dispatch_end(actual_s_1:int, actual_pirp_6:int) {
var  Tmp_80: int;
var  Tmp_81: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 6749} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_RunISRRoutines"} sdv_RunISRRoutines(actual_ki:int, actual_pv1:int) {
var  sdv_28: int;
var  Tmp_82: int;
var  Tmp_83: int;
var  ki: int;
var  pv1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  ki := actual_ki;
  pv1 := actual_pv1;
  // done with preamble
  goto L16;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3520} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "sdv_isr_routine"} boogie_si_record_li2bpl_int(sdv_isr_routine);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3472} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_isr_routine != 197);  goto L1; } else { assume (sdv_isr_routine == 197);  goto L4; }
L4:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3474} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L18;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3476} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L22;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L18:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3474} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L19;
L19:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3474} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L20;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3474} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 4;  goto L21;
L21:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(ki);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pv1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3475} {:print "Call \"sdv_RunISRRoutines\" \"InterruptServiceRoutine\""}  true;
  call sdv_28 := sdv_hash_373344998( ki, pv1);   goto L11;
L22:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3476} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L23;
L23:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3476} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L24;
L24:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_NullDereferenceTrap"} sdv_NullDereferenceTrap(actual_p:int) {
var  Tmp_84: int;
var  Tmp_85: int;
var  p: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  p := actual_p;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1303} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "p"} boogie_si_record_li2bpl_int(p);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1302} {:print "Atomic Conditional"}  true;
    if(*) { assume (p != 0);  goto L1; } else { assume (p == 0);  goto L4; }
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1302} {:print "Call \"sdv_NullDereferenceTrap\" \"sdv_Trap\""}  true;
  call sdv_Trap();   goto L1;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_RunIoCompletionRoutines"} sdv_RunIoCompletionRoutines(actual_DeviceObject_10:int, actual_Irp_12:int, actual_Context_5:int, actual_Completion:int) returns (Tmp_86:int) {
var  sdv_29: int;
var  sdv_30: int;
var  irpsp: int;
var  Tmp_87: int;
var  Status: int;
var  DeviceObject_10: int;
var  Irp_12: int;
var  Context_5: int;
var  Completion: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_10 := actual_DeviceObject_10;
  Irp_12 := actual_Irp_12;
  Context_5 := actual_Context_5;
  Completion := actual_Completion;
  // done with preamble
  goto L26;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L5:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3202} {:print "Call \"sdv_RunIoCompletionRoutines\" \"sdv_IoGetNextIrpStackLocation\""}  true;
  call irpsp := sdv_IoGetNextIrpStackLocation( Irp_12);   goto L9;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3203} {:print "Atomic Assignment"}  true;
      Status := 0;  goto L28;
L11:
  call {:cexpr "Status"} boogie_si_record_li2bpl_int(Status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3312} {:print "Atomic Assignment"}  true;
      Tmp_86 := Status;  goto L37;
L12:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L29;
L20:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3209} {:print "Atomic Assignment"}  true;
      sdv_irql_current := sdv_irql_previous;  goto L33;
L26:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L28:
  call {:cexpr "irpsp->CompletionRoutine"} boogie_si_record_li2bpl_int(Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3205} {:print "Atomic Conditional"}  true;
    if(*) { assume irpsp > 0;
  assume (Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)] != 196);  goto L11; } else { assume irpsp > 0;
  assume (Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)] == 196);  goto L12; }
L29:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L30;
L30:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L31;
L31:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L32;
L32:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(DeviceObject_10);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_12);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Context_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3208} {:print "Call \"sdv_RunIoCompletionRoutines\" \"CompletionRoutine\""}  true;
  call Status := sdv_hash_113240927( DeviceObject_10, Irp_12, Context_5);   goto L20;
L33:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3209} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L34;
L34:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3209} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L35;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3210} {:print "Atomic Assignment"}  true;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;  goto L36;
L36:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 3312} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_IoGetCurrentIrpStackLocation"} sdv_IoGetCurrentIrpStackLocation(actual_pirp_7:int) returns (Tmp_88:int) {
var  Tmp_89: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10707} {:print "Atomic Assignment"}  true;
    assume pirp_7 > 0;
    Tmp_88 := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_7)))];  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10707} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "ExInitializeResourceLite"} ExInitializeResourceLite(actual_Resource_2:int) returns (Tmp_90:int) {
var  Tmp_91: int;
var  sdv_31: int;
var  x_3: int;
var  Resource_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Resource_2 := actual_Resource_2;
  // done with preamble
  goto L12;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7428} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "x"} boogie_si_record_li2bpl_int(x_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7423} {:print "Atomic Conditional"}  true;
    if(*) { assume (x_3 == 0);  goto L9; } else { assume (x_3 != 0);  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7426} {:print "Atomic Assignment"}  true;
      Tmp_90 := -1073741823;  goto L15;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 7424} {:print "Atomic Assignment"}  true;
      Tmp_90 := 0;  goto L14;
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
procedure {:origName "KeAreApcsDisabled"} KeAreApcsDisabled() returns (Tmp_92:int) {
var  Tmp_93: int;
var  sdv_32: int;
var  choice_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13453} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13443} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13449} {:print "Atomic Assignment"}  true;
      Tmp_92 := 0;  goto L16;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13446} {:print "Atomic Assignment"}  true;
      Tmp_92 := 1;  goto L15;
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "IofCallDriver"} IofCallDriver(actual_DeviceObject_11:int, actual_Irp_13:int) returns (Tmp_94:int) {
var  {:dopa}  completion: int;
var  sdv_33: int;
var  sdv_34: int;
var  sdv_35: int;
var  sdv_36: int;
var  sdv_37: int;
var  status_5: int;
var  Tmp_95: int;
var  choice_3: int;
var  DeviceObject_11: int;
var  Irp_13: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call completion := __HAVOC_malloc(4);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_11 := actual_DeviceObject_11;
  Irp_13 := actual_Irp_13;
  // done with preamble
  goto L104;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9950} {:print "Atomic Assignment"}  true;
    assume completion > 0;
    Mem_T.INT4[completion] := 0;  goto L106;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9953} {:print "Atomic Assignment"}  true;
      status_5 := 259;  goto L107;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10023} {:print "Atomic Assignment"}  true;
    assume Irp_13 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))] := -1073741823;  goto L124;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9957} {:print "Atomic Assignment"}  true;
    assume Irp_13 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))] := 0;  goto L108;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9979} {:print "Atomic Assignment"}  true;
    assume Irp_13 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))] := -1073741536;  goto L114;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10001} {:print "Atomic Assignment"}  true;
    assume Irp_13 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))] := 259;  goto L119;
L19:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10007} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_13);  goto L21; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_13);  goto L22; }
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10005} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 259;  goto L121;
L21:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10011} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_13);  goto L23; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_13);  goto L24; }
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10009} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 259;  goto L122;
L23:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10016} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset != 0);  goto L26; } else { assume (sdv_compFset == 0);  goto L29; }
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10013} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 259;  goto L123;
L26:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_13);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10018} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_36 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_13, sdv_context, completion);   goto L98;
L29:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10045} {:print "Atomic Assignment"}  true;
      Tmp_94 := status_5;  goto L113;
L32:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9985} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_13);  goto L34; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_13);  goto L35; }
L33:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9983} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741536;  goto L116;
L34:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9989} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_13);  goto L36; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_13);  goto L37; }
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9987} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741536;  goto L117;
L36:
  call {:cexpr "sdv_invoke_on_cancel"} boogie_si_record_li2bpl_int(sdv_invoke_on_cancel);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9994} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_invoke_on_cancel == 0);  goto L29; } else { assume (sdv_invoke_on_cancel != 0);  goto L39; }
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9991} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741536;  goto L118;
L39:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9994} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset == 0);  goto L29; } else { assume (sdv_compFset != 0);  goto L40; }
L40:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_13);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9996} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_35 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_13, sdv_context, completion);   goto L95;
L45:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9963} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_13);  goto L47; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_13);  goto L48; }
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9961} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 0;  goto L110;
L47:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9967} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_13);  goto L49; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_13);  goto L50; }
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9965} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 0;  goto L111;
L49:
  call {:cexpr "sdv_invoke_on_success"} boogie_si_record_li2bpl_int(sdv_invoke_on_success);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9972} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_invoke_on_success == 0);  goto L29; } else { assume (sdv_invoke_on_success != 0);  goto L52; }
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9969} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 0;  goto L112;
L52:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9972} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset == 0);  goto L29; } else { assume (sdv_compFset != 0);  goto L53; }
L53:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_13);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9974} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_34 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_13, sdv_context, completion);   goto L92;
L58:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10029} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_13);  goto L60; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_13);  goto L61; }
L59:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10027} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741823;  goto L126;
L60:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10033} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_13);  goto L62; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_13);  goto L63; }
L61:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10031} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741823;  goto L127;
L62:
  call {:cexpr "sdv_invoke_on_error"} boogie_si_record_li2bpl_int(sdv_invoke_on_error);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10038} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_invoke_on_error == 0);  goto L29; } else { assume (sdv_invoke_on_error != 0);  goto L65; }
L63:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10035} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741823;  goto L128;
L65:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10038} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset == 0);  goto L29; } else { assume (sdv_compFset != 0);  goto L66; }
L66:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_13);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10040} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_33 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_13, sdv_context, completion);   goto L101;
L70:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L13; } else {  goto L16; }
L71:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L15; } else {  goto L70; }
L92:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias4(SLAM_guard_S_0, Irp_13);
    if(*) { assume (!((Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L29; } else { assume ((Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L93; }
L93:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(completion);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_34);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9974} {:print "Call \"IofCallDriver\" \"SLIC_sdv_RunIoCompletionRoutines_exit\""}  true;
  call SLIC_sdv_RunIoCompletionRoutines_exit( 0, completion, sdv_34);   goto L29;
L95:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias5(SLAM_guard_S_0, Irp_13);
    if(*) { assume (!((Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L29; } else { assume ((Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L96; }
L96:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(completion);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_35);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9996} {:print "Call \"IofCallDriver\" \"SLIC_sdv_RunIoCompletionRoutines_exit\""}  true;
  call SLIC_sdv_RunIoCompletionRoutines_exit( 0, completion, sdv_35);   goto L29;
L98:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias6(SLAM_guard_S_0, Irp_13);
    if(*) { assume (!((Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L29; } else { assume ((Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L99; }
L99:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(completion);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_36);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10018} {:print "Call \"IofCallDriver\" \"SLIC_sdv_RunIoCompletionRoutines_exit\""}  true;
  call SLIC_sdv_RunIoCompletionRoutines_exit( 0, completion, sdv_36);   goto L29;
L101:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
  assume alias7(SLAM_guard_S_0, Irp_13);
    if(*) { assume (!((Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L29; } else { assume ((Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L102; }
L102:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(completion);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_33);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10040} {:print "Call \"IofCallDriver\" \"SLIC_sdv_RunIoCompletionRoutines_exit\""}  true;
  call SLIC_sdv_RunIoCompletionRoutines_exit( 0, completion, sdv_33);   goto L29;
L104:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L106:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L107:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9954} {:print "Atomic Continuation"}  true;
    if(*) {  goto L14; } else {  goto L71; }
L108:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9958} {:print "Atomic Assignment"}  true;
    assume Irp_13 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_13)] := 0;  goto L109;
L109:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9959} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_13);  goto L45; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_13);  goto L46; }
L110:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L45;
L111:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L47;
L112:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L49;
L113:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10045} {:print "Return"}  true;
    goto LM2;
L114:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9980} {:print "Atomic Assignment"}  true;
    assume Irp_13 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_13)] := 0;  goto L115;
L115:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 9981} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_13);  goto L32; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_13);  goto L33; }
L116:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L32;
L117:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L34;
L118:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L36;
L119:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10002} {:print "Atomic Assignment"}  true;
    assume Irp_13 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_13)] := 1;  goto L120;
L120:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10003} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_13);  goto L19; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_13);  goto L20; }
L121:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L19;
L122:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L21;
L123:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L23;
L124:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10024} {:print "Atomic Assignment"}  true;
    assume Irp_13 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_13)] := 0;  goto L125;
L125:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_13);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10025} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_13);  goto L58; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_13);  goto L59; }
L126:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L58;
L127:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L60;
L128:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L62;
Lfinal: return;
}
procedure {:origName "sdv_KeInitializeSpinLock"} sdv_KeInitializeSpinLock(actual_SpinLock_1:int) {
var  Tmp_96: int;
var  Tmp_97: int;
var  SpinLock_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SpinLock_1 := actual_SpinLock_1;
  // done with preamble
  goto L6;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13264} {:print "Atomic Assignment"}  true;
    assume SpinLock_1 > 0;
    Mem_T.INT4[SpinLock_1] := 0;  goto L8;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 13266} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoConnectInterrupt"} IoConnectInterrupt(actual_InterruptObject:int, actual_ServiceRoutine:int, actual_ServiceContext:int, actual_SpinLock_2:int, actual_Vector:int, actual_Irql:int, actual_SynchronizeIrql:int, actual_InterruptMode:int, actual_ShareVector:int, actual_ProcessorEnableMask:int, actual_FloatingSave:int) returns (Tmp_98:int) {
var  Tmp_99: int;
var  sdv_38: int;
var  choice_4: int;
var  InterruptObject: int;
var  ServiceRoutine: int;
var  ServiceContext: int;
var  SpinLock_2: int;
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
  SpinLock_2 := actual_SpinLock_2;
  Vector := actual_Vector;
  Irql := actual_Irql;
  SynchronizeIrql := actual_SynchronizeIrql;
  InterruptMode := actual_InterruptMode;
  ShareVector := actual_ShareVector;
  ProcessorEnableMask := actual_ProcessorEnableMask;
  FloatingSave := actual_FloatingSave;
  // done with preamble
  goto L20;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10149} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "ServiceRoutine"} boogie_si_record_li2bpl_int(ServiceRoutine);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10136} {:print "Atomic Assignment"}  true;
      sdv_isr_routine := ServiceRoutine;  goto L22;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10147} {:print "Atomic Assignment"}  true;
      Tmp_98 := -1073741670;  goto L26;
L12:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(InterruptObject);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(ServiceContext);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10142} {:print "Call \"IoConnectInterrupt\" \"sdv_RunISRRoutines\""}  true;
  call sdv_RunISRRoutines( InterruptObject, ServiceContext);   goto L16;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10146} {:print "Atomic Assignment"}  true;
      Tmp_98 := -1073741811;  goto L25;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10144} {:print "Atomic Assignment"}  true;
      Tmp_98 := 0;  goto L24;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L15; }
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L22:
  call {:cexpr "ServiceContext"} boogie_si_record_li2bpl_int(ServiceContext);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10137} {:print "Atomic Assignment"}  true;
      sdv_pDpcContext := ServiceContext;  goto L23;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 10138} {:print "Atomic Continuation"}  true;
    if(*) {  goto L12; } else {  goto L18; }
L24:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L25:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L26:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_DoNothing"} sdv_DoNothing() returns (Tmp_100:int) {
var  Tmp_101: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1515} {:print "Atomic Assignment"}  true;
      Tmp_100 := -1073741823;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1515} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_RunDispatchFunction"} sdv_RunDispatchFunction(actual_po:int, actual_pirp_8:int) returns (Tmp_102:int) {
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
var  sdv_51: int;
var  sdv_52: int;
var  x_4: int;
var  sdv_53: int;
var  sdv_54: int;
var  Tmp_103: int;
var  sdv_55: int;
var  status_6: int;
var  Tmp_104: int;
var  Tmp_105: int;
var  ps: int;
var  minor: int;
var  sdv_56: int;
var  sdv_57: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1617} {:print "Atomic Assignment"}  true;
      status_6 := 0;  goto L178;
L14:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_47);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1620} {:print "Atomic Assignment"}  true;
      minor := sdv_47;  goto L179;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1628} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_8)] := 0;  goto L184;
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1641} {:print "Atomic Continuation"}  true;
    if(*) {  goto L38; } else {  goto L169; }
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1998} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1683} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 0;  goto L192;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1664} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 2;  goto L196;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1815} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 3;  goto L197;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1872} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 4;  goto L199;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1796} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 5;  goto L200;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1834} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 6;  goto L201;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1739} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 9;  goto L202;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1732} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1702} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 14;  goto L203;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1758} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 15;  goto L204;
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1979} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 16;  goto L205;
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1789} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L54:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1645} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 18;  goto L206;
L55:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1951} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 22;  goto L207;
L56:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1853} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 23;  goto L209;
L57:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1891} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 27;  goto L211;
L59:
  call {:cexpr "sdv_start_irp_already_issued"} boogie_si_record_li2bpl_int(sdv_start_irp_already_issued);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1897} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_start_irp_already_issued == 0);  goto L219; } else { assume (sdv_start_irp_already_issued != 0);  goto L220; }
L60:
  call {:cexpr "ps->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1900} {:print "Atomic Conditional"}  true;
    if(*) { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] != 3);  goto L61; } else { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] == 3);  goto L62; }
L61:
  call {:cexpr "ps->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1904} {:print "Atomic Conditional"}  true;
    if(*) { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] != 2);  goto L66; } else { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] == 2);  goto L69; }
L62:
  call {:cexpr "sdv_remove_irp_already_issued"} boogie_si_record_li2bpl_int(sdv_remove_irp_already_issued);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1902} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_remove_irp_already_issued == 0);  goto L213; } else { assume (sdv_remove_irp_already_issued != 0);  goto L214; }
L66:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1934} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchPnp\""}  true;
  call status_6 := sdv_hash_590764100( po, pirp_8);   goto L217;
L69:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1906} {:print "Atomic Assignment"}  true;
      sdv_remove_irp_already_issued := 1;  goto L216;
L72:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(status_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 2002} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_stub_dispatch_end\""}  true;
  call sdv_stub_dispatch_end( status_6, 0);   goto L75;
L75:
  call {:cexpr "pirp->IoStatus.Information"} boogie_si_record_li2bpl_int(Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 2004} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    sdv_end_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_8))];  goto L194;
L88:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1961} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchPower\""}  true;
  call status_6 := sdv_hash_86802341( po, pirp_8);   goto L208;
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
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_103);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1902} {:print "Atomic Continuation"}  true;
  assume(Tmp_103 != 0);   goto L215;
L175:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_104);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1897} {:print "Atomic Continuation"}  true;
  assume(Tmp_104 != 0);   goto L221;
L176:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L178:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L14;
L179:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_8)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1622} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    ps := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_8)))];  goto L180;
L180:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1623} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(pirp_8)] := 0;  goto L181;
L181:
  call {:cexpr "pirp->IoStatus.Information"} boogie_si_record_li2bpl_int(Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_8))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1624} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    sdv_start_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_8))];  goto L182;
L182:
  call {:cexpr "sdv_start_info"} boogie_si_record_li2bpl_int(sdv_start_info);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1624} {:print "Atomic Assignment"}  true;
      sdv_end_info := sdv_start_info;  goto L183;
L183:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1626} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_SetStatus\""}  true;
  call sdv_SetStatus( pirp_8);   goto L23;
L184:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1629} {:print "Atomic Assignment"}  true;
    assume pirp_8 > 0;
    Mem_T.Cancel__IRP[Cancel__IRP(pirp_8)] := 0;  goto L185;
L185:
  call {:cexpr "minor"} boogie_si_record_li2bpl_int(minor);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1633} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] := minor;  goto L186;
L186:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1634} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(ps)] := 0;  goto L187;
L187:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1635} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := 0;  goto L188;
L188:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1635} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := 0;  goto L189;
L189:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1635} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation)] := 0;  goto L190;
L190:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1637} {:print "Atomic Assignment"}  true;
      sdv_dpc_io_registered := 0;  goto L191;
L191:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1639} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_stub_dispatch_begin\""}  true;
  call sdv_stub_dispatch_begin();   goto L34;
L192:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1685} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchCreate\""}  true;
  call status_6 := sdv_hash_701990220( po, pirp_8);   goto L193;
L193:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L194:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 2005} {:print "Atomic Assignment"}  true;
      Tmp_102 := status_6;  goto L195;
L195:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 2005} {:print "Return"}  true;
    goto LM2;
L196:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1676} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L197:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1817} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchRead\""}  true;
  call status_6 := sdv_hash_802080270( po, pirp_8);   goto L198;
L198:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L199:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1884} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L200:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1808} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L201:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1846} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L202:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1751} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L203:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1714} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L204:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1770} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L205:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1991} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L206:
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1657} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_6 := sdv_DoNothing();   goto L72;
L207:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1955} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_SetPowerIrpMinorFunction\""}  true;
  call sdv_SetPowerIrpMinorFunction( pirp_8);   goto L88;
L208:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L209:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1855} {:print "Call \"sdv_RunDispatchFunction\" \"DispatchSystemControl\""}  true;
  call status_6 := sdv_hash_1044063384( po, pirp_8);   goto L210;
L210:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L72; }
L211:
  call {:cexpr "ps->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\fail_drivers\wdm\fail_driver4\sdv\sdv-harness.c"} {:sourceline 1895} {:print "Atomic Conditional"}  true;
    if(*) { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] == 0);  goto L59; } else { assume ps > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] != 0);  goto L60; }
L212:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L174;
L213:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_103 := 1;  goto L212;
L214:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_103 := 0;  goto L212;
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
      Tmp_104 := 1;  goto L218;
L220:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_104 := 0;  goto L218;
L221:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L60;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_RunRemoveDevice_exit"} SLIC_sdv_RunRemoveDevice_exit(actual_caller:int, actual_sdv_58:int) {
var  caller: int;
var  sdv_58: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller := actual_caller;
  sdv_58 := actual_sdv_58;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_58);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 89} {:print "Call \"SLIC_sdv_RunRemoveDevice_exit\" \"SLIC_ABORT_9_0\""}  true;
  call SLIC_ABORT_9_0( caller, sdv_58);   goto L11;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 2);  goto L2; } else { assume (s == 2);  goto L6; }
L6:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_58);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_58 == 259);  goto L2; } else { assume (sdv_58 != 259);  goto L4; }
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L11:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_17_0"} SLIC_ABORT_17_0(actual_caller_1:int, actual_sdv_59:int) {
var  caller_1: int;
var  sdv_59: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_1 := actual_caller_1;
  sdv_59 := actual_sdv_59;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_1);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_1 := caller_1;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_59);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_59 := sdv_59;  goto L6;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_17_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver needs to call IoCompleteRequest in this case."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_IoCompleteRequest_entry"} SLIC_sdv_IoCompleteRequest_entry(actual_caller_2:int) {
var  caller_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_2 := actual_caller_2;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_2);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 56} {:print "Call \"SLIC_sdv_IoCompleteRequest_entry\" \"SLIC_ABORT_6_0\""}  true;
  call SLIC_ABORT_6_0( caller_2);   goto L10;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_IoCompleteRequest_entry\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl3);   goto L2;
L7:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 54} {:print "Atomic Conditional"}  true;
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
procedure {:origName "SLIC_ABORT_11_0"} SLIC_ABORT_11_0(actual_caller_3:int, actual_sdv_60:int) {
var  caller_3: int;
var  sdv_60: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_3 := actual_caller_3;
  sdv_60 := actual_sdv_60;
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
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_60);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_60 := sdv_60;  goto L6;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_11_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver needs to call IoCompleteRequest in this case."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_23_0"} SLIC_ABORT_23_0(actual_caller_4:int) {
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_23_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver needs to call IoCompleteRequest in this case."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_6_0"} SLIC_ABORT_6_0(actual_caller_5:int) {
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl4);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_6_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver is calling IoCompleteRequest when it does not own the request."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl4);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_817957157_exit"} SLIC_sdv_hash_817957157_exit(actual_caller_6:int) {
var  caller_6: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_6 := actual_caller_6;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_6);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 100} {:print "Call \"SLIC_sdv_hash_817957157_exit\" \"SLIC_ABORT_23_0\""}  true;
  call SLIC_ABORT_23_0( caller_6);   goto L9;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 98} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 2);  goto L2; } else { assume (s == 2);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_RunIoCompletionRoutines_exit"} SLIC_sdv_RunIoCompletionRoutines_exit(actual_caller_7:int, actual_sdv_61:int, actual_sdv_62:int) {
var  caller_7: int;
var  sdv_61: int;
var  sdv_62: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_7 := actual_caller_7;
  sdv_61 := actual_sdv_61;
  sdv_62 := actual_sdv_62;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_RunIoCompletionRoutines_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl3);   goto L2;
L6:
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 43} {:print "Atomic Assignment"}  true;
      s := 2;  goto L15;
L7:
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 47} {:print "Atomic Assignment"}  true;
      s := 1;  goto L16;
L8:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_62);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 41} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_62 == -1073741802);  goto L6; } else { assume (sdv_62 != -1073741802);  goto L7; }
L9:
  call {:cexpr "forward_state"} boogie_si_record_li2bpl_int(forward_state);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 37} {:print "Atomic Conditional"}  true;
    if(*) { assume (forward_state != 1);  goto L8; } else { assume (forward_state == 1);  goto L10; }
L10:
  call {:cexpr "*sdv"} boogie_si_record_li2bpl_int(Mem_T.INT4[sdv_61]);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 37} {:print "Atomic Conditional"}  true;
    if(*) { assume sdv_61 > 0;
  assume (Mem_T.INT4[sdv_61] == 0);  goto L4; } else { assume sdv_61 > 0;
  assume (Mem_T.INT4[sdv_61] != 0);  goto L8; }
L13:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L9;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_IoSetCompletionRoutine_exit"} SLIC_sdv_IoSetCompletionRoutine_exit(actual_caller_8:int) {
var  caller_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_8 := actual_caller_8;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 32} {:print "Atomic Assignment"}  true;
      forward_state := 1;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
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
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      SLAM_guard_S_0 := SLAM_guard_S_0_init;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 15} {:print "Atomic Assignment"}  true;
      forward_state := 0;  goto L6;
L6:
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 14} {:print "Atomic Assignment"}  true;
      s := 0;  goto L7;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      yogi_error := 0;  goto L8;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_cancelFptr := 0;  goto L9;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_15_0"} SLIC_ABORT_15_0(actual_caller_9:int, actual_sdv_63:int) {
var  caller_9: int;
var  sdv_63: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_9 := actual_caller_9;
  sdv_63 := actual_sdv_63;
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
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_63);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_63 := sdv_63;  goto L6;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_15_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver needs to call IoCompleteRequest in this case."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
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
procedure {:origName "SLIC_sdv_hash_701990220_exit"} SLIC_sdv_hash_701990220_exit(actual_caller_10:int, actual_sdv_64:int) {
var  caller_10: int;
var  sdv_64: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_10 := actual_caller_10;
  sdv_64 := actual_sdv_64;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_10);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_64);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 89} {:print "Call \"SLIC_sdv_hash_701990220_exit\" \"SLIC_ABORT_19_0\""}  true;
  call SLIC_ABORT_19_0( caller_10, sdv_64);   goto L11;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 2);  goto L2; } else { assume (s == 2);  goto L6; }
L6:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_64);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_64 == 259);  goto L2; } else { assume (sdv_64 != 259);  goto L4; }
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L11:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_RunStartDevice_exit"} SLIC_sdv_RunStartDevice_exit(actual_caller_11:int, actual_sdv_65:int) {
var  caller_11: int;
var  sdv_65: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_11 := actual_caller_11;
  sdv_65 := actual_sdv_65;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_11);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_65);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 89} {:print "Call \"SLIC_sdv_RunStartDevice_exit\" \"SLIC_ABORT_21_0\""}  true;
  call SLIC_ABORT_21_0( caller_11, sdv_65);   goto L11;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 2);  goto L2; } else { assume (s == 2);  goto L6; }
L6:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_65);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_65 == 259);  goto L2; } else { assume (sdv_65 != 259);  goto L4; }
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L11:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_RemoveHeadList_entry"} SLIC_RemoveHeadList_entry(actual_caller_12:int) {
var  caller_12: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_12 := actual_caller_12;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_RemoveHeadList_entry\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl3);   goto L2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_21_0"} SLIC_ABORT_21_0(actual_caller_13:int, actual_sdv_66:int) {
var  caller_13: int;
var  sdv_66: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_13 := actual_caller_13;
  sdv_66 := actual_sdv_66;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_13);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_13 := caller_13;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_66);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_66 := sdv_66;  goto L6;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_21_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver needs to call IoCompleteRequest in this case."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_19_0"} SLIC_ABORT_19_0(actual_caller_14:int, actual_sdv_67:int) {
var  caller_14: int;
var  sdv_67: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_14 := actual_caller_14;
  sdv_67 := actual_sdv_67;
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
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_67);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_67 := sdv_67;  goto L6;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_19_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver needs to call IoCompleteRequest in this case."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_802080270_exit"} SLIC_sdv_hash_802080270_exit(actual_caller_15:int, actual_sdv_68:int) {
var  caller_15: int;
var  sdv_68: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_15 := actual_caller_15;
  sdv_68 := actual_sdv_68;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_15);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_68);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 89} {:print "Call \"SLIC_sdv_hash_802080270_exit\" \"SLIC_ABORT_17_0\""}  true;
  call SLIC_ABORT_17_0( caller_15, sdv_68);   goto L11;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 2);  goto L2; } else { assume (s == 2);  goto L6; }
L6:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_68);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_68 == 259);  goto L2; } else { assume (sdv_68 != 259);  goto L4; }
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L11:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_IoSetCompletionRoutineEx_exit"} SLIC_IoSetCompletionRoutineEx_exit(actual_caller_16:int) {
var  caller_16: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_16 := actual_caller_16;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 27} {:print "Atomic Assignment"}  true;
      forward_state := 1;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_9_0"} SLIC_ABORT_9_0(actual_caller_17:int, actual_sdv_69:int) {
var  caller_17: int;
var  sdv_69: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_17 := actual_caller_17;
  sdv_69 := actual_sdv_69;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_17);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_17 := caller_17;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_69);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_69 := sdv_69;  goto L6;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_9_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver needs to call IoCompleteRequest in this case."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_containing_record_entry"} SLIC_sdv_containing_record_entry(actual_caller_18:int) {
var  caller_18: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_18 := actual_caller_18;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_containing_record_entry\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl3);   goto L2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_13_0"} SLIC_ABORT_13_0(actual_caller_19:int, actual_sdv_70:int) {
var  caller_19: int;
var  sdv_70: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_19 := actual_caller_19;
  sdv_70 := actual_sdv_70;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "caller"} boogie_si_record_li2bpl_int(caller_19);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      caller_19 := caller_19;  goto L5;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_70);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      sdv_70 := sdv_70;  goto L6;
L6:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_13_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The driver needs to call IoCompleteRequest in this case."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl2);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_590764100_exit"} SLIC_sdv_hash_590764100_exit(actual_caller_20:int, actual_sdv_71:int) {
var  caller_20: int;
var  sdv_71: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_20 := actual_caller_20;
  sdv_71 := actual_sdv_71;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_20);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_71);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 89} {:print "Call \"SLIC_sdv_hash_590764100_exit\" \"SLIC_ABORT_13_0\""}  true;
  call SLIC_ABORT_13_0( caller_20, sdv_71);   goto L11;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 2);  goto L2; } else { assume (s == 2);  goto L6; }
L6:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_71);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_71 == 259);  goto L2; } else { assume (sdv_71 != 259);  goto L4; }
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L11:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_86802341_exit"} SLIC_sdv_hash_86802341_exit(actual_caller_21:int, actual_sdv_72:int) {
var  caller_21: int;
var  sdv_72: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_21 := actual_caller_21;
  sdv_72 := actual_sdv_72;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_21);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_72);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 89} {:print "Call \"SLIC_sdv_hash_86802341_exit\" \"SLIC_ABORT_11_0\""}  true;
  call SLIC_ABORT_11_0( caller_21, sdv_72);   goto L11;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 2);  goto L2; } else { assume (s == 2);  goto L6; }
L6:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_72);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_72 == 259);  goto L2; } else { assume (sdv_72 != 259);  goto L4; }
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L11:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_hash_1044063384_exit"} SLIC_sdv_hash_1044063384_exit(actual_caller_22:int, actual_sdv_73:int) {
var  caller_22: int;
var  sdv_73: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_22 := actual_caller_22;
  sdv_73 := actual_sdv_73;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_22);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_73);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 89} {:print "Call \"SLIC_sdv_hash_1044063384_exit\" \"SLIC_ABORT_15_0\""}  true;
  call SLIC_ABORT_15_0( caller_22, sdv_73);   goto L11;
L5:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (s != 2);  goto L2; } else { assume (s == 2);  goto L6; }
L6:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_73);
  assert {:sourcefile "..\..\..\rules\WDM\CompleteRequest.slic"} {:sourceline 87} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_73 == 259);  goto L2; } else { assume (sdv_73 != 259);  goto L4; }
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L11:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
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
var Mem_T.DeviceExtension__DEVICE_OBJECT: [int] int;
var Mem_T.DeviceObject__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.Flink__LIST_ENTRY: [int] int;
var Mem_T.INT4: [int] int;
var Mem_T.Information__IO_STATUS_BLOCK: [int] int;
var Mem_T.Irp__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.Length_unnamed_tag_18: [int] int;
var Mem_T.Lock__KSPIN_LOCK_QUEUE: [int] int;
var Mem_T.MajorFunction__IO_STACK_LOCATION: [int] int;
var Mem_T.MinorFunction__IO_STACK_LOCATION: [int] int;
var Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION: [int] int;
var Mem_T.Next__KSPIN_LOCK_QUEUE: [int] int;
var Mem_T.OldIrql__KLOCK_QUEUE_HANDLE: [int] int;
var Mem_T.PDRIVER_RESOURCE: [int] int;
var Mem_T.P_KINTERRUPT: [int] int;
var Mem_T.PendingReturned__IRP: [int] int;
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
procedure {:dopa "Mem_T.INT4"} dummy_for_pa();
procedure corralExtraInit() {
   assume (forall x : int :: {Mem_T.CancelRoutine__IRP[x]} (Mem_T.CancelRoutine__IRP[x] <= 0 || Mem_T.CancelRoutine__IRP[x] > 281));
   assume (forall x : int :: {Mem_T.CompletionRoutine__IO_STACK_LOCATION[x]} (Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] <= 0 || Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] > 281));
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
function {:inline true} {:fieldmap "Mem_T.DeviceExtension__DEVICE_OBJECT"}  {:fieldname "DeviceExtension"}  DeviceExtension__DEVICE_OBJECT(x:int) returns (int) {x + 44}
function {:inline true} {:fieldmap "Mem_T.DeviceObject__DRIVER_DEVICE_EXTENSION"}  {:fieldname "DeviceObject"}  DeviceObject__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.Flink__LIST_ENTRY"}  {:fieldname "Flink"}  Flink__LIST_ENTRY(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Header__KEVENT"}  {:fieldname "Header"}  Header__KEVENT(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Information__IO_STATUS_BLOCK"}  {:fieldname "Information"}  Information__IO_STATUS_BLOCK(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.P_KINTERRUPT"}  {:fieldname "InterruptObject"}  InterruptObject__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 28}
function {:inline true} {:fieldmap "Mem_T.IoStatus__IRP"}  {:fieldname "IoStatus"}  IoStatus__IRP(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.Irp__DRIVER_DEVICE_EXTENSION"}  {:fieldname "Irp"}  Irp__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 12}
function {:inline true} {:fieldmap "Mem_T.Length_unnamed_tag_18"}  {:fieldname "Length"}  Length_unnamed_tag_18(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.LockQueue__KLOCK_QUEUE_HANDLE"}  {:fieldname "LockQueue"}  LockQueue__KLOCK_QUEUE_HANDLE(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Lock__KSPIN_LOCK_QUEUE"}  {:fieldname "Lock"}  Lock__KSPIN_LOCK_QUEUE(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.MajorFunction__IO_STACK_LOCATION"}  {:fieldname "MajorFunction"}  MajorFunction__IO_STACK_LOCATION(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.MinorFunction__IO_STACK_LOCATION"}  {:fieldname "MinorFunction"}  MinorFunction__IO_STACK_LOCATION(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.NextLowerDriver__DRIVER_DEVICE_EXTENSION"}  {:fieldname "NextLowerDriver"}  NextLowerDriver__DRIVER_DEVICE_EXTENSION(x:int) returns (int) {x + 20}
function {:inline true} {:fieldmap "Mem_T.Next__KSPIN_LOCK_QUEUE"}  {:fieldname "Next"}  Next__KSPIN_LOCK_QUEUE(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.OldIrql__KLOCK_QUEUE_HANDLE"}  {:fieldname "OldIrql"}  OldIrql__KLOCK_QUEUE_HANDLE(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.Overlay_unnamed_tag_6"}  {:fieldname "Overlay"}  Overlay_unnamed_tag_6(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Parameters__IO_STACK_LOCATION"}  {:fieldname "Parameters"}  Parameters__IO_STACK_LOCATION(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.PendingReturned__IRP"}  {:fieldname "PendingReturned"}  PendingReturned__IRP(x:int) returns (int) {x + 52}
function {:inline true} {:fieldmap "Mem_T.Power_unnamed_tag_8"}  {:fieldname "Power"}  Power_unnamed_tag_8(x:int) returns (int) {x + 420}
function {:inline true} {:fieldmap "Mem_T.Read_unnamed_tag_8"}  {:fieldname "Read"}  Read_unnamed_tag_8(x:int) returns (int) {x + 60}
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
const {:string "The driver is calling IoCompleteRequest when it does not own the request."} unique strConst__li2bpl4: int;
const {:string "The driver needs to call IoCompleteRequest in this case."} unique strConst__li2bpl2: int;
const {:string "callee"} unique strConst__li2bpl0: int;
const {:string "caller"} unique strConst__li2bpl1: int;
const {:string "halt"} unique strConst__li2bpl3: int;

function {:aliasingQuery} alias1(x:int, y:int):bool;
function {:aliasingQuery} alias2(x:int, y:int):bool;
function {:aliasingQuery} alias3(x:int, y:int):bool;
function {:aliasingQuery} alias4(x:int, y:int):bool;
function {:aliasingQuery} alias5(x:int, y:int):bool;
function {:aliasingQuery} alias6(x:int, y:int):bool;
function {:aliasingQuery} alias7(x:int, y:int):bool;
