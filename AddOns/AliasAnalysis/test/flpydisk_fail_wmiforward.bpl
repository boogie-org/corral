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
var WHEA_ERROR_PACKET_SECTION_GUID:int;
var PagingMutex:int;
var GUID_DEVINTERFACE_VOLUME:int;
var GUID_DEVINTERFACE_MEDIUMCHANGER:int;
var _DriveMediaConstants:int;
var GUID_DEVINTERFACE_STORAGEPORT:int;
var GUID_DEVINTERFACE_PARTITION:int;
var DriveMediaLimits:int;
var GUID_DEVINTERFACE_VMLUN:int;
var GUID_DEVINTERFACE_FLOPPY:int;
var GUID_DEVICEDUMP_DRIVER_STORAGE_PORT:int;
var MOUNTDEV_MOUNTED_DEVICE_GUID:int;
var GUID_DEVICEDUMP_STORAGE_DEVICE:int;
var GUID_DEVINTERFACE_HIDDEN_VOLUME:int;
var GUID_DEVINTERFACE_CDROM:int;
var GUID_DEVINTERFACE_WRITEONCEDISK:int;
var GUID_DEVINTERFACE_CDCHANGER:int;
var GUID_DEVINTERFACE_DISK:int;
var DriveMediaConstants:int;
var GUID_DEVINTERFACE_TAPE:int;
var _DriveMediaLimits:int;
var PagingReferenceCount:int;
var GUID_DEVINTERFACE_SES:int;
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
var sdv_driver_object:int;
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
var yogi_error:int;
var not_forwarded:int;
var SLAM_guard_S_0:int;
var sdv_cancelFptr:int;
var yogi:int;
// ----- Procedures -------
procedure {:origName "SdvBuggyFunctionOnInitPageThatShouldNotBeCalledOutSideDriverEntry"} SdvBuggyFunctionOnInitPageThatShouldNotBeCalledOutSideDriverEntry() {
var  Tmp: int;
var  Tmp_1: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 110} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "FlTerminateFloppyThread"} FlTerminateFloppyThread(actual_DisketteExtension:int) {
var  sdv: int;
var  sdv_1: int;
var  Tmp_2: int;
var  Tmp_3: int;
var  DisketteExtension: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DisketteExtension := actual_DisketteExtension;
  // done with preamble
  goto L15;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2022} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "DisketteExtension->FloppyThread"} boogie_si_record_li2bpl_int(Mem_T.FloppyThread__DISKETTE_EXTENSION[FloppyThread__DISKETTE_EXTENSION(DisketteExtension)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2005} {:print "Atomic Conditional"}  true;
    if(*) { assume DisketteExtension > 0;
  assume (Mem_T.FloppyThread__DISKETTE_EXTENSION[FloppyThread__DISKETTE_EXTENSION(DisketteExtension)] == 0);  goto L1; } else { assume DisketteExtension > 0;
  assume (Mem_T.FloppyThread__DISKETTE_EXTENSION[FloppyThread__DISKETTE_EXTENSION(DisketteExtension)] != 0);  goto L4; }
L4:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2007} {:print "Call \"FlTerminateFloppyThread\" \"KeWaitForSingleObject\""}  true;
  call sdv_1 := KeWaitForSingleObject( 0, 0, 0, 0, 0);   goto L7;
L7:
  call {:cexpr "DisketteExtension->FloppyThread"} boogie_si_record_li2bpl_int(Mem_T.FloppyThread__DISKETTE_EXTENSION[FloppyThread__DISKETTE_EXTENSION(DisketteExtension)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2016} {:print "Atomic Conditional"}  true;
    if(*) { assume DisketteExtension > 0;
  assume (Mem_T.FloppyThread__DISKETTE_EXTENSION[FloppyThread__DISKETTE_EXTENSION(DisketteExtension)] == 0);  goto L8; } else { assume DisketteExtension > 0;
  assume (Mem_T.FloppyThread__DISKETTE_EXTENSION[FloppyThread__DISKETTE_EXTENSION(DisketteExtension)] != 0);  goto L9; }
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2020} {:print "Atomic Assignment"}  true;
    assume DisketteExtension > 0;
    Mem_T.FloppyThread__DISKETTE_EXTENSION[FloppyThread__DISKETTE_EXTENSION(DisketteExtension)] := 0;  goto L17;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2017} {:print "Call \"FlTerminateFloppyThread\" \"sdv_ObDereferenceObject\""}  true;
  call sdv := sdv_ObDereferenceObject( 0);   goto L8;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "FloppyAddDevice"} FloppyAddDevice(actual_DriverObject:int, actual_PhysicalDeviceObject:int) returns (Tmp_4:int) {
var  sdv_2: int;
var  sdv_3: int;
var  Tmp_5: int;
var  sdv_4: int;
var  sdv_5: int;
var  sdv_6: int;
var  sdv_7: int;
var  sdv_8: int;
var  arcNameBuffer: int;
var  ntStatus: int;
var  Tmp_6: int;
var  Tmp_7: int;
var  disketteExtension: int;
var  deviceNameBuffer: int;
var  Tmp_8: int;
var  i: int;
var  Tmp_9: int;
var  deviceObject: int;
var  fdcInfo: int;
var  deviceName: int;
var  Tmp_10: int;
var  Tmp_11: int;
var  arcNameString: int;
var  sdv_9: int;
var  DriverObject: int;
var  PhysicalDeviceObject: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call deviceObject := __HAVOC_malloc(4);
  call fdcInfo := __HAVOC_malloc(120);
  call deviceName := __HAVOC_malloc(12);
  call arcNameString := __HAVOC_malloc(12);
  // initialize local variables to 0
  // copy formal-ins to locals
  DriverObject := actual_DriverObject;
  PhysicalDeviceObject := actual_PhysicalDeviceObject;
  // done with preamble
  goto L135;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 494} {:print "Return"}  true;
    goto LM2;
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 326} {:print "Atomic Assignment"}  true;
    assume deviceObject > 0;
    Mem_T.P_DEVICE_OBJECT[deviceObject] := 0;  goto L137;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 339} {:print "Atomic Assignment"}  true;
      ntStatus := 0;  goto L138;
L22:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 353} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > ntStatus);  goto L23; } else { assume (0 <= ntStatus);  goto L25; }
L23:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 493} {:print "Atomic Assignment"}  true;
      Tmp_4 := ntStatus;  goto L175;
L25:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 355} {:print "Atomic Assignment"}  true;
      i := 0;  goto L141;
L26:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 363} {:print "Atomic Assignment"}  true;
      Tmp_6 := i;  goto L142;
L30:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(deviceName);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(deviceNameBuffer);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 364} {:print "Call \"FloppyAddDevice\" \"RtlInitUnicodeString\""}  true;
  call RtlInitUnicodeString( deviceName, deviceNameBuffer);   goto L33;
L33:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(348);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(7);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(261);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg7"} boogie_si_record_li2bpl_int(deviceObject);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 368} {:print "Call \"FloppyAddDevice\" \"IoCreateDevice\""}  true;
  call ntStatus := IoCreateDevice( 0, 348, 0, 7, 261, 0, deviceObject);   goto L37;
L37:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 379} {:print "Atomic Conditional"}  true;
    if(*) { assume (ntStatus == -1073741771);  goto L26; } else { assume (ntStatus != -1073741771);  goto L38; }
L38:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 381} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > ntStatus);  goto L23; } else { assume (0 <= ntStatus);  goto L39; }
L39:
  call {:cexpr "deviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 383} {:print "Atomic Assignment"}  true;
    assume deviceObject > 0;
  assume Mem_T.P_DEVICE_OBJECT[deviceObject] > 0;
    disketteExtension := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])];  goto L146;
L44:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 391} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.Buffer__STRING[Buffer__STRING(DeviceName__DISKETTE_EXTENSION(disketteExtension))] := sdv_5;  goto L148;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 394} {:print "Call \"FloppyAddDevice\" \"IoDeleteDevice\""}  true;
  call IoDeleteDevice( 0);   goto L122;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 397} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(DeviceName__DISKETTE_EXTENSION(disketteExtension))] := 0;  goto L149;
L54:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 401} {:print "Call \"FloppyAddDevice\" \"IoGetConfigurationInformation\""}  true;
  call sdv_4 := IoGetConfigurationInformation();   goto L57;
L57:
  call {:cexpr "sdv->FloppyCount"} boogie_si_record_li2bpl_int(Mem_T.FloppyCount__CONFIGURATION_INFORMATION[FloppyCount__CONFIGURATION_INFORMATION(sdv_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 401} {:print "Atomic Assignment"}  true;
    assume sdv_4 > 0;
    Mem_T.FloppyCount__CONFIGURATION_INFORMATION[FloppyCount__CONFIGURATION_INFORMATION(sdv_4)] := (Mem_T.FloppyCount__CONFIGURATION_INFORMATION[FloppyCount__CONFIGURATION_INFORMATION(sdv_4)] + 1);  goto L151;
L61:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 416} {:print "Call \"FloppyAddDevice\" \"RtlInitString\""}  true;
  call RtlInitString( 0, 0);   goto L64;
L64:
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 418} {:print "Call \"FloppyAddDevice\" \"RtlAnsiStringToUnicodeString\""}  true;
  call ntStatus := RtlAnsiStringToUnicodeString( 0, 0, 1);   goto L68;
L68:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 422} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > ntStatus);  goto L69; } else { assume (0 <= ntStatus);  goto L70; }
L69:
  call {:cexpr "deviceObject->Flags"} boogie_si_record_li2bpl_int(Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 427} {:print "Atomic Assignment"}  true;
    assume deviceObject > 0;
  assume Mem_T.P_DEVICE_OBJECT[deviceObject] > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])] := BOR(Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])], 8208);  goto L154;
L70:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 424} {:print "Call \"FloppyAddDevice\" \"sdv_IoAssignArcName\""}  true;
  call sdv_IoAssignArcName( 0, 0);   goto L69;
L74:
  call {:cexpr "deviceObject->Flags"} boogie_si_record_li2bpl_int(Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 434} {:print "Atomic Assignment"}  true;
    assume deviceObject > 0;
  assume Mem_T.P_DEVICE_OBJECT[deviceObject] > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])] := BAND(Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])], -129);  goto L156;
L75:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 431} {:print "Atomic Assignment"}  true;
    assume deviceObject > 0;
  assume Mem_T.P_DEVICE_OBJECT[deviceObject] > 0;
    Mem_T.AlignmentRequirement__DEVICE_OBJECT[AlignmentRequirement__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])] := 1;  goto L155;
L82:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(-1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 456} {:print "Call \"FloppyAddDevice\" \"KeInitializeSemaphore\""}  true;
  call KeInitializeSemaphore( 0, 0, -1);   goto L85;
L85:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 460} {:print "Call \"FloppyAddDevice\" \"sdv_ExInitializeFastMutex\""}  true;
  call sdv_ExInitializeFastMutex( 0);   goto L88;
L88:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_9 := __HAVOC_malloc(4);  goto L130;
L91:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 464} {:print "Call \"FloppyAddDevice\" \"sdv_ExInitializeFastMutex\""}  true;
  call sdv_ExInitializeFastMutex( 0);   goto L94;
L94:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 466} {:print "Call \"FloppyAddDevice\" \"sdv_ExInitializeFastMutex\""}  true;
  call sdv_ExInitializeFastMutex( 0);   goto L97;
L97:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(ListEntry__DISKETTE_EXTENSION(disketteExtension));
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 468} {:print "Call \"FloppyAddDevice\" \"InitializeListHead\""}  true;
  assume disketteExtension > 0;
  call InitializeListHead( ListEntry__DISKETTE_EXTENSION(disketteExtension));   goto L100;
L100:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 470} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(disketteExtension)] := -1;  goto L161;
L107:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_9 := __HAVOC_malloc(4);  goto L132;
L110:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_9 := __HAVOC_malloc(4);  goto L134;
L113:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(QueryPowerEvent__DISKETTE_EXTENSION(disketteExtension));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 478} {:print "Call \"FloppyAddDevice\" \"KeInitializeEvent\""}  true;
  assume disketteExtension > 0;
  call KeInitializeEvent( QueryPowerEvent__DISKETTE_EXTENSION(disketteExtension), 1, 0);   goto L116;
L116:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 481} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.FloppyControllerAllocated__DISKETTE_EXTENSION[FloppyControllerAllocated__DISKETTE_EXTENSION(disketteExtension)] := 0;  goto L169;
L122:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 395} {:print "Atomic Assignment"}  true;
      Tmp_4 := -1073741670;  goto L176;
L129:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_9]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
  assume Tmp_9 > 0;
    Mem_T.ListSpinLock__DISKETTE_EXTENSION[ListSpinLock__DISKETTE_EXTENSION(disketteExtension)] := Mem_T.INT4[Tmp_9];  goto L160;
L130:
  call {:cexpr "disketteExtension->ListSpinLock"} boogie_si_record_li2bpl_int(Mem_T.ListSpinLock__DISKETTE_EXTENSION[ListSpinLock__DISKETTE_EXTENSION(disketteExtension)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
  assume Tmp_9 > 0;
    Mem_T.INT4[Tmp_9] := Mem_T.ListSpinLock__DISKETTE_EXTENSION[ListSpinLock__DISKETTE_EXTENSION(disketteExtension)];  goto L159;
L131:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_9]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
  assume Tmp_9 > 0;
    Mem_T.NewRequestQueueSpinLock__DISKETTE_EXTENSION[NewRequestQueueSpinLock__DISKETTE_EXTENSION(disketteExtension)] := Mem_T.INT4[Tmp_9];  goto L166;
L132:
  call {:cexpr "disketteExtension->NewRequestQueueSpinLock"} boogie_si_record_li2bpl_int(Mem_T.NewRequestQueueSpinLock__DISKETTE_EXTENSION[NewRequestQueueSpinLock__DISKETTE_EXTENSION(disketteExtension)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
  assume Tmp_9 > 0;
    Mem_T.INT4[Tmp_9] := Mem_T.NewRequestQueueSpinLock__DISKETTE_EXTENSION[NewRequestQueueSpinLock__DISKETTE_EXTENSION(disketteExtension)];  goto L165;
L133:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_9]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
  assume Tmp_9 > 0;
    Mem_T.FlCancelSpinLock__DISKETTE_EXTENSION[FlCancelSpinLock__DISKETTE_EXTENSION(disketteExtension)] := Mem_T.INT4[Tmp_9];  goto L168;
L134:
  call {:cexpr "disketteExtension->FlCancelSpinLock"} boogie_si_record_li2bpl_int(Mem_T.FlCancelSpinLock__DISKETTE_EXTENSION[FlCancelSpinLock__DISKETTE_EXTENSION(disketteExtension)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
  assume Tmp_9 > 0;
    Mem_T.INT4[Tmp_9] := Mem_T.FlCancelSpinLock__DISKETTE_EXTENSION[FlCancelSpinLock__DISKETTE_EXTENSION(disketteExtension)];  goto L167;
L135:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_5 := __HAVOC_malloc(60);
    call arcNameBuffer := __HAVOC_malloc(1024);
    call deviceNameBuffer := __HAVOC_malloc(80);
    call Tmp_8 := __HAVOC_malloc(96);
    call Tmp_11 := __HAVOC_malloc(68);  goto L0;
L137:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 336} {:print "Call \"FloppyAddDevice\" \"SdvBuggyFunctionOnInitPageThatShouldNotBeCalledOutSideDriverEntry\""}  true;
  call SdvBuggyFunctionOnInitPageThatShouldNotBeCalledOutSideDriverEntry();   goto L15;
L138:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 346} {:print "Atomic Assignment"}  true;
    assume fdcInfo > 0;
    Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo)] := 0;  goto L139;
L139:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 347} {:print "Atomic Assignment"}  true;
    assume fdcInfo > 0;
    Mem_T.BufferSize__FDC_INFO[BufferSize__FDC_INFO(fdcInfo)] := 0;  goto L140;
L140:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(PhysicalDeviceObject);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(461835);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(fdcInfo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 349} {:print "Call \"FloppyAddDevice\" \"FlFdcDeviceIo\""}  true;
  call ntStatus := FlFdcDeviceIo( PhysicalDeviceObject, 461835, fdcInfo);   goto L22;
L141:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L26;
L142:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 363} {:print "Atomic Assignment"}  true;
      i := (i + 1);  goto L143;
L143:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 363} {:print "Atomic Assignment"}  true;
      Tmp_10 := Tmp_6;  goto L144;
L144:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 363} {:print "Atomic Assignment"}  true;
      Tmp_11 := strConst__li2bpl0;  goto L145;
L145:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 363} {:print "Atomic Assignment"}  true;
      call sdv_7 := corral_nondet();  goto L30;
L146:
  call {:cexpr "deviceName.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(deviceName)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 391} {:print "Atomic Assignment"}  true;
    assume deviceName > 0;
    Tmp_7 := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(deviceName)];  goto L147;
L147:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(257);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_7);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(-261133242);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 391} {:print "Call \"FloppyAddDevice\" \"ExAllocatePoolWithTag\""}  true;
  call sdv_5 := ExAllocatePoolWithTag( 257, Tmp_7, -261133242);   goto L44;
L148:
  call {:cexpr "disketteExtension->DeviceName.Buffer"} boogie_si_record_li2bpl_int(Mem_T.Buffer__STRING[Buffer__STRING(DeviceName__DISKETTE_EXTENSION(disketteExtension))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 392} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(DeviceName__DISKETTE_EXTENSION(disketteExtension))] == 0);  goto L46; } else { assume disketteExtension > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(DeviceName__DISKETTE_EXTENSION(disketteExtension))] != 0);  goto L49; }
L149:
  call {:cexpr "deviceName.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(deviceName)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 398} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
  assume deviceName > 0;
    Mem_T.MaximumLength__STRING[MaximumLength__STRING(DeviceName__DISKETTE_EXTENSION(disketteExtension))] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(deviceName)];  goto L150;
L150:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 399} {:print "Atomic Continuation"}  true;
    goto L54;
L151:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 409} {:print "Atomic Assignment"}  true;
      Tmp_8 := strConst__li2bpl1;  goto L152;
L152:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 409} {:print "Atomic Assignment"}  true;
      Tmp_5 := strConst__li2bpl2;  goto L153;
L153:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 409} {:print "Atomic Assignment"}  true;
      call sdv_3 := corral_nondet();  goto L61;
L154:
  call {:cexpr "deviceObject->AlignmentRequirement"} boogie_si_record_li2bpl_int(Mem_T.AlignmentRequirement__DEVICE_OBJECT[AlignmentRequirement__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 429} {:print "Atomic Conditional"}  true;
    if(*) { assume deviceObject > 0;
  assume Mem_T.P_DEVICE_OBJECT[deviceObject] > 0;
  assume (Mem_T.AlignmentRequirement__DEVICE_OBJECT[AlignmentRequirement__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])] >= 1);  goto L74; } else { assume deviceObject > 0;
  assume Mem_T.P_DEVICE_OBJECT[deviceObject] > 0;
  assume (Mem_T.AlignmentRequirement__DEVICE_OBJECT[AlignmentRequirement__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[deviceObject])] < 1);  goto L75; }
L155:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L74;
L156:
  call {:cexpr "DriverObject"} boogie_si_record_li2bpl_int(DriverObject);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 436} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.DriverObject__DISKETTE_EXTENSION[DriverObject__DISKETTE_EXTENSION(disketteExtension)] := DriverObject;  goto L157;
L157:
  call {:cexpr "PhysicalDeviceObject"} boogie_si_record_li2bpl_int(PhysicalDeviceObject);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 439} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.UnderlyingPDO__DISKETTE_EXTENSION[UnderlyingPDO__DISKETTE_EXTENSION(disketteExtension)] := PhysicalDeviceObject;  goto L158;
L158:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 449} {:print "Call \"FloppyAddDevice\" \"IoAttachDeviceToDeviceStack\""}  true;
  assume disketteExtension > 0;
  call boogieTmp := IoAttachDeviceToDeviceStack( 0, 1); Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension)] := boogieTmp;  goto L82;
L159:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_9);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 462} {:print "Call \"FloppyAddDevice\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_9);   goto L129;
L160:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L91;
L161:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 472} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension)] := 0;  goto L162;
L162:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 473} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension)] := 0;  goto L163;
L163:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 474} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension)] := 0;  goto L164;
L164:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(NewRequestQueue__DISKETTE_EXTENSION(disketteExtension));
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 475} {:print "Call \"FloppyAddDevice\" \"InitializeListHead\""}  true;
  assume disketteExtension > 0;
  call InitializeListHead( NewRequestQueue__DISKETTE_EXTENSION(disketteExtension));   goto L107;
L165:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_9);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 476} {:print "Call \"FloppyAddDevice\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_9);   goto L131;
L166:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L110;
L167:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Tmp_9);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 477} {:print "Call \"FloppyAddDevice\" \"sdv_KeInitializeSpinLock\""}  true;
  call sdv_KeInitializeSpinLock( Tmp_9);   goto L133;
L168:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L113;
L169:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 482} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.ReleaseFdcWithMotorRunning__DISKETTE_EXTENSION[ReleaseFdcWithMotorRunning__DISKETTE_EXTENSION(disketteExtension)] := 0;  goto L170;
L170:
  call {:cexpr "deviceObject"} boogie_si_record_li2bpl_int(Mem_T.P_DEVICE_OBJECT[deviceObject]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 483} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
  assume deviceObject > 0;
    Mem_T.DeviceObject__DISKETTE_EXTENSION[DeviceObject__DISKETTE_EXTENSION(disketteExtension)] := Mem_T.P_DEVICE_OBJECT[deviceObject];  goto L171;
L171:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 485} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.IsReadOnly__DISKETTE_EXTENSION[IsReadOnly__DISKETTE_EXTENSION(disketteExtension)] := 0;  goto L172;
L172:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 487} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.MediaType__DISKETTE_EXTENSION[MediaType__DISKETTE_EXTENSION(disketteExtension)] := -1;  goto L173;
L173:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 489} {:print "Atomic Assignment"}  true;
    assume disketteExtension > 0;
    Mem_T.ControllerConfigurable__DISKETTE_EXTENSION[ControllerConfigurable__DISKETTE_EXTENSION(disketteExtension)] := 1;  goto L174;
L174:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L23;
L175:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L176:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "FlAcpiConfigureFloppy"} FlAcpiConfigureFloppy(actual_DisketteExtension_1:int, actual_FdcInfo:int) returns (Tmp_12:int) {
var  Tmp_13: int;
var  Tmp_14: int;
var  biosDriveMediaConstants: int;
var  Tmp_15: int;
var  driveType: int;
var  DisketteExtension_1: int;
var  FdcInfo: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DisketteExtension_1 := actual_DisketteExtension_1;
  FdcInfo := actual_FdcInfo;
  // done with preamble
  goto L43;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 853} {:print "Return"}  true;
    goto LM2;
L5:
  call {:cexpr "&DisketteExtension->BiosDriveMediaConstants"} boogie_si_record_li2bpl_int(BiosDriveMediaConstants__DISKETTE_EXTENSION(DisketteExtension_1));
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 804} {:print "Atomic Assignment"}  true;
    assume DisketteExtension_1 > 0;
    biosDriveMediaConstants := BiosDriveMediaConstants__DISKETTE_EXTENSION(DisketteExtension_1);  goto L45;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 808} {:print "Atomic Assignment"}  true;
      Tmp_12 := -1073741823;  goto L70;
L8:
  call {:cexpr "FdcInfo->AcpiFdiData.DeviceType"} boogie_si_record_li2bpl_int(Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 816} {:print "Atomic Conditional"}  true;
    if(*) { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] == 1);  goto L10; } else { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] != 1);  goto L41; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 824} {:print "Atomic Assignment"}  true;
      driveType := 1;  goto L69;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 818} {:print "Atomic Assignment"}  true;
      driveType := 0;  goto L46;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 819} {:print "Atomic Assignment"}  true;
      driveType := 1;  goto L65;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 820} {:print "Atomic Assignment"}  true;
      driveType := 2;  goto L66;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 821} {:print "Atomic Assignment"}  true;
      driveType := 3;  goto L67;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 822} {:print "Atomic Assignment"}  true;
      driveType := 4;  goto L68;
L16:
  call {:cexpr "driveType"} boogie_si_record_li2bpl_int(driveType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 828} {:print "Atomic Assignment"}  true;
    assume DisketteExtension_1 > 0;
    Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(DisketteExtension_1)] := driveType;  goto L47;
L38:
  call {:cexpr "FdcInfo->AcpiFdiData.DeviceType"} boogie_si_record_li2bpl_int(Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] != 5);  goto L9; } else { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] == 5);  goto L14; }
L39:
  call {:cexpr "FdcInfo->AcpiFdiData.DeviceType"} boogie_si_record_li2bpl_int(Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] == 4);  goto L13; } else { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] != 4);  goto L38; }
L40:
  call {:cexpr "FdcInfo->AcpiFdiData.DeviceType"} boogie_si_record_li2bpl_int(Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] == 3);  goto L12; } else { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] != 3);  goto L39; }
L41:
  call {:cexpr "FdcInfo->AcpiFdiData.DeviceType"} boogie_si_record_li2bpl_int(Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] == 2);  goto L11; } else { assume FdcInfo > 0;
  assume (Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] != 2);  goto L40; }
L43:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L45:
  call {:cexpr "FdcInfo->AcpiFdiSupported"} boogie_si_record_li2bpl_int(Mem_T.AcpiFdiSupported__FDC_INFO[AcpiFdiSupported__FDC_INFO(FdcInfo)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 806} {:print "Atomic Conditional"}  true;
    if(*) { assume FdcInfo > 0;
  assume (Mem_T.AcpiFdiSupported__FDC_INFO[AcpiFdiSupported__FDC_INFO(FdcInfo)] == 0);  goto L7; } else { assume FdcInfo > 0;
  assume (Mem_T.AcpiFdiSupported__FDC_INFO[AcpiFdiSupported__FDC_INFO(FdcInfo)] != 0);  goto L8; }
L46:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L16;
L47:
  call {:cexpr "driveType"} boogie_si_record_li2bpl_int(driveType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 835} {:print "Atomic Assignment"}  true;
      Tmp_13 := driveType;  goto L48;
L48:
  call {:cexpr "(DriveMediaLimits + (Tmp * 8))->HighestDriveMediaType"} boogie_si_record_li2bpl_int(Mem_T.HighestDriveMediaType__DRIVE_MEDIA_LIMITS[HighestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_13 * 8)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 835} {:print "Atomic Assignment"}  true;
    assume DriveMediaLimits > 0;
    Tmp_15 := Mem_T.HighestDriveMediaType__DRIVE_MEDIA_LIMITS[HighestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_13 * 8)))];  goto L49;
L49:
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->SkewDelta"} boogie_si_record_li2bpl_int(Mem_T.SkewDelta__DRIVE_MEDIA_CONSTANTS[SkewDelta__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MediaByte"} boogie_si_record_li2bpl_int(Mem_T.MediaByte__DRIVE_MEDIA_CONSTANTS[MediaByte__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->DataLength"} boogie_si_record_li2bpl_int(Mem_T.DataLength__DRIVE_MEDIA_CONSTANTS[DataLength__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->NumberOfHeads"} boogie_si_record_li2bpl_int(Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->DataTransferRate"} boogie_si_record_li2bpl_int(Mem_T.DataTransferRate__DRIVE_MEDIA_CONSTANTS[DataTransferRate__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->CylinderShift"} boogie_si_record_li2bpl_int(Mem_T.CylinderShift__DRIVE_MEDIA_CONSTANTS[CylinderShift__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MaximumTrack"} boogie_si_record_li2bpl_int(Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MotorSettleTimeWrite"} boogie_si_record_li2bpl_int(Mem_T.MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS[MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MotorSettleTimeRead"} boogie_si_record_li2bpl_int(Mem_T.MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS[MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->HeadSettleTime"} boogie_si_record_li2bpl_int(Mem_T.HeadSettleTime__DRIVE_MEDIA_CONSTANTS[HeadSettleTime__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->FormatFillCharacter"} boogie_si_record_li2bpl_int(Mem_T.FormatFillCharacter__DRIVE_MEDIA_CONSTANTS[FormatFillCharacter__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->FormatGapLength"} boogie_si_record_li2bpl_int(Mem_T.FormatGapLength__DRIVE_MEDIA_CONSTANTS[FormatGapLength__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->ReadWriteGapLength"} boogie_si_record_li2bpl_int(Mem_T.ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS[ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->SectorsPerTrack"} boogie_si_record_li2bpl_int(Mem_T.SectorsPerTrack__DRIVE_MEDIA_CONSTANTS[SectorsPerTrack__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->BytesPerSector"} boogie_si_record_li2bpl_int(Mem_T.BytesPerSector__DRIVE_MEDIA_CONSTANTS[BytesPerSector__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->SectorLengthCode"} boogie_si_record_li2bpl_int(Mem_T.SectorLengthCode__DRIVE_MEDIA_CONSTANTS[SectorLengthCode__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MotorOffTime"} boogie_si_record_li2bpl_int(Mem_T.MotorOffTime__DRIVE_MEDIA_CONSTANTS[MotorOffTime__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->HeadLoadTime"} boogie_si_record_li2bpl_int(Mem_T.HeadLoadTime__DRIVE_MEDIA_CONSTANTS[HeadLoadTime__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->StepRateHeadUnloadTime"} boogie_si_record_li2bpl_int(Mem_T.StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS[StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MediaType"} boogie_si_record_li2bpl_int(Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 835} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS[StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS[StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.HeadLoadTime__DRIVE_MEDIA_CONSTANTS[HeadLoadTime__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.HeadLoadTime__DRIVE_MEDIA_CONSTANTS[HeadLoadTime__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.MotorOffTime__DRIVE_MEDIA_CONSTANTS[MotorOffTime__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.MotorOffTime__DRIVE_MEDIA_CONSTANTS[MotorOffTime__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.SectorLengthCode__DRIVE_MEDIA_CONSTANTS[SectorLengthCode__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.SectorLengthCode__DRIVE_MEDIA_CONSTANTS[SectorLengthCode__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.BytesPerSector__DRIVE_MEDIA_CONSTANTS[BytesPerSector__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.BytesPerSector__DRIVE_MEDIA_CONSTANTS[BytesPerSector__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.SectorsPerTrack__DRIVE_MEDIA_CONSTANTS[SectorsPerTrack__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.SectorsPerTrack__DRIVE_MEDIA_CONSTANTS[SectorsPerTrack__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS[ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS[ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.FormatGapLength__DRIVE_MEDIA_CONSTANTS[FormatGapLength__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.FormatGapLength__DRIVE_MEDIA_CONSTANTS[FormatGapLength__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.FormatFillCharacter__DRIVE_MEDIA_CONSTANTS[FormatFillCharacter__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.FormatFillCharacter__DRIVE_MEDIA_CONSTANTS[FormatFillCharacter__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.HeadSettleTime__DRIVE_MEDIA_CONSTANTS[HeadSettleTime__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.HeadSettleTime__DRIVE_MEDIA_CONSTANTS[HeadSettleTime__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS[MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS[MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS[MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS[MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.CylinderShift__DRIVE_MEDIA_CONSTANTS[CylinderShift__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.CylinderShift__DRIVE_MEDIA_CONSTANTS[CylinderShift__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.DataTransferRate__DRIVE_MEDIA_CONSTANTS[DataTransferRate__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.DataTransferRate__DRIVE_MEDIA_CONSTANTS[DataTransferRate__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.DataLength__DRIVE_MEDIA_CONSTANTS[DataLength__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.DataLength__DRIVE_MEDIA_CONSTANTS[DataLength__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.MediaByte__DRIVE_MEDIA_CONSTANTS[MediaByte__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.MediaByte__DRIVE_MEDIA_CONSTANTS[MediaByte__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];
  assume biosDriveMediaConstants > 0;
  assume DriveMediaConstants > 0;
    Mem_T.SkewDelta__DRIVE_MEDIA_CONSTANTS[SkewDelta__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.SkewDelta__DRIVE_MEDIA_CONSTANTS[SkewDelta__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_15 * 80)))];  goto L50;
L50:
  call {:cexpr "FdcInfo->AcpiFdiData.StepRateHeadUnloadTime"} boogie_si_record_li2bpl_int(Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA[StepRateHeadUnloadTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 838} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS[StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA[StepRateHeadUnloadTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L51;
L51:
  call {:cexpr "FdcInfo->AcpiFdiData.HeadLoadTime"} boogie_si_record_li2bpl_int(Mem_T.HeadLoadTime__ACPI_FDI_DATA[HeadLoadTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 839} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.HeadLoadTime__DRIVE_MEDIA_CONSTANTS[HeadLoadTime__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.HeadLoadTime__ACPI_FDI_DATA[HeadLoadTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L52;
L52:
  call {:cexpr "FdcInfo->AcpiFdiData.MotorOffTime"} boogie_si_record_li2bpl_int(Mem_T.MotorOffTime__ACPI_FDI_DATA[MotorOffTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 840} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.MotorOffTime__DRIVE_MEDIA_CONSTANTS[MotorOffTime__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.MotorOffTime__ACPI_FDI_DATA[MotorOffTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L53;
L53:
  call {:cexpr "FdcInfo->AcpiFdiData.SectorLengthCode"} boogie_si_record_li2bpl_int(Mem_T.SectorLengthCode__ACPI_FDI_DATA[SectorLengthCode__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 841} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.SectorLengthCode__DRIVE_MEDIA_CONSTANTS[SectorLengthCode__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.SectorLengthCode__ACPI_FDI_DATA[SectorLengthCode__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L54;
L54:
  call {:cexpr "FdcInfo->AcpiFdiData.SectorPerTrack"} boogie_si_record_li2bpl_int(Mem_T.SectorPerTrack__ACPI_FDI_DATA[SectorPerTrack__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 842} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.SectorsPerTrack__DRIVE_MEDIA_CONSTANTS[SectorsPerTrack__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.SectorPerTrack__ACPI_FDI_DATA[SectorPerTrack__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L55;
L55:
  call {:cexpr "FdcInfo->AcpiFdiData.ReadWriteGapLength"} boogie_si_record_li2bpl_int(Mem_T.ReadWriteGapLength__ACPI_FDI_DATA[ReadWriteGapLength__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 843} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS[ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.ReadWriteGapLength__ACPI_FDI_DATA[ReadWriteGapLength__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L56;
L56:
  call {:cexpr "FdcInfo->AcpiFdiData.FormatGapLength"} boogie_si_record_li2bpl_int(Mem_T.FormatGapLength__ACPI_FDI_DATA[FormatGapLength__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 844} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.FormatGapLength__DRIVE_MEDIA_CONSTANTS[FormatGapLength__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.FormatGapLength__ACPI_FDI_DATA[FormatGapLength__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L57;
L57:
  call {:cexpr "FdcInfo->AcpiFdiData.FormatFillCharacter"} boogie_si_record_li2bpl_int(Mem_T.FormatFillCharacter__ACPI_FDI_DATA[FormatFillCharacter__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 845} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.FormatFillCharacter__DRIVE_MEDIA_CONSTANTS[FormatFillCharacter__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.FormatFillCharacter__ACPI_FDI_DATA[FormatFillCharacter__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L58;
L58:
  call {:cexpr "FdcInfo->AcpiFdiData.HeadSettleTime"} boogie_si_record_li2bpl_int(Mem_T.HeadSettleTime__ACPI_FDI_DATA[HeadSettleTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 846} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.HeadSettleTime__DRIVE_MEDIA_CONSTANTS[HeadSettleTime__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.HeadSettleTime__ACPI_FDI_DATA[HeadSettleTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L59;
L59:
  call {:cexpr "FdcInfo->AcpiFdiData.MotorSettleTime"} boogie_si_record_li2bpl_int(Mem_T.MotorSettleTime__ACPI_FDI_DATA[MotorSettleTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 847} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS[MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := INTDIV((Mem_T.MotorSettleTime__ACPI_FDI_DATA[MotorSettleTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] * 1000), 8);  goto L60;
L60:
  call {:cexpr "FdcInfo->AcpiFdiData.MotorSettleTime"} boogie_si_record_li2bpl_int(Mem_T.MotorSettleTime__ACPI_FDI_DATA[MotorSettleTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 848} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS[MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := INTDIV((Mem_T.MotorSettleTime__ACPI_FDI_DATA[MotorSettleTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))] * 1000), 8);  goto L61;
L61:
  call {:cexpr "FdcInfo->AcpiFdiData.MaxCylinderNumber"} boogie_si_record_li2bpl_int(Mem_T.MaxCylinderNumber__ACPI_FDI_DATA[MaxCylinderNumber__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 849} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.MaxCylinderNumber__ACPI_FDI_DATA[MaxCylinderNumber__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L62;
L62:
  call {:cexpr "FdcInfo->AcpiFdiData.DataTransferLength"} boogie_si_record_li2bpl_int(Mem_T.DataTransferLength__ACPI_FDI_DATA[DataTransferLength__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 850} {:print "Atomic Assignment"}  true;
    assume biosDriveMediaConstants > 0;
  assume FdcInfo > 0;
    Mem_T.DataLength__DRIVE_MEDIA_CONSTANTS[DataLength__DRIVE_MEDIA_CONSTANTS(biosDriveMediaConstants)] := Mem_T.DataTransferLength__ACPI_FDI_DATA[DataTransferLength__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(FdcInfo))];  goto L63;
L63:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 852} {:print "Atomic Assignment"}  true;
      Tmp_12 := 0;  goto L64;
L64:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L65:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L16;
L66:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L16;
L67:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L16;
L68:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L16;
L69:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L16;
L70:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "FloppyDeviceControl"} FloppyDeviceControl(actual_DeviceObject:int, actual_Irp:int) returns (Tmp_16:int) {
var  sdv_10: int;
var  sdv_11: int;
var  sdv_12: int;
var  sdv_13: int;
var  Tmp_17: int;
var  sdv_14: int;
var  targetDeviceObject: int;
var  formatExParameters: int;
var  sdv_15: int;
var  sdv_16: int;
var  Tmp_18: int;
var  Tmp_19: int;
var  ntStatus_1: int;
var  lowestDriveMediaType: int;
var  highestDriveMediaType: int;
var  Tmp_20: int;
var  Tmp_21: int;
var  formatExParametersSize: int;
var  disketteExtension_1: int;
var  irpSp: int;
var  Tmp_22: int;
var  outputBuffer: int;
var  Tmp_23: int;
var  i_1: int;
var  uniqueId: int;
var  Tmp_24: int;
var  Tmp_25: int;
var  mountName: int;
var  Tmp_26: int;
var  outputBufferLength: int;
var  Tmp_27: int;
var  sdv_17: int;
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
  goto L212;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L14;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1437} {:print "Return"}  true;
    goto LM2;
L14:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1086} {:print "Atomic Assignment"}  true;
    assume DeviceObject > 0;
    disketteExtension_1 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject)];  goto L214;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1089} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := 0;  goto L215;
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1101} {:print "Call \"FloppyDeviceControl\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L27;
L27:
  call {:cexpr "disketteExtension->HoldNewRequests"} boogie_si_record_li2bpl_int(Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1102} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_1 > 0;
  assume (Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_1)] == 0);  goto L28; } else { assume disketteExtension_1 > 0;
  assume (Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_1)] != 0);  goto L29; }
L28:
  call {:cexpr "disketteExtension->IsRemoved"} boogie_si_record_li2bpl_int(Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1121} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_1 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_1)] == 0);  goto L38; } else { assume disketteExtension_1 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_1)] != 0);  goto L39; }
L29:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1109} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 3325952);  goto L28; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 3325952);  goto L30; }
L30:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(disketteExtension_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1111} {:print "Call \"FloppyDeviceControl\" \"FloppyQueueRequest\""}  true;
  call ntStatus_1 := FloppyQueueRequest( disketteExtension_1, Irp);   goto L34;
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1113} {:print "Call \"FloppyDeviceControl\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L37;
L37:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1114} {:print "Atomic Assignment"}  true;
      Tmp_16 := ntStatus_1;  goto L216;
L38:
  call {:cexpr "disketteExtension->IsStarted"} boogie_si_record_li2bpl_int(Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1135} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_1 > 0;
  assume (Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_1)] == 0);  goto L48; } else { assume disketteExtension_1 > 0;
  assume (Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_1)] != 0);  goto L51; }
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1123} {:print "Call \"FloppyDeviceControl\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1125} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := 0;  goto L217;
L47:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1128} {:print "Atomic Assignment"}  true;
      Tmp_16 := -1073741738;  goto L219;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1137} {:print "Call \"FloppyDeviceControl\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L166;
L51:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1142} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 458752);  goto L55; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 458752);  goto L182; }
L52:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1406} {:print "Call \"FloppyDeviceControl\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L155;
L55:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(disketteExtension_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1302} {:print "Call \"FloppyDeviceControl\" \"FlQueueIrpToThread\""}  true;
  call ntStatus_1 := FlQueueIrpToThread( Irp, disketteExtension_1);   goto L66;
L58:
  call {:cexpr "disketteExtension->DriveType"} boogie_si_record_li2bpl_int(Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1311} {:print "Atomic Assignment"}  true;
    assume disketteExtension_1 > 0;
    Tmp_24 := Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_1)];  goto L222;
L59:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.InputBufferLength"} boogie_si_record_li2bpl_int(Mem_T.InputBufferLength_unnamed_tag_22[InputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1220} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.InputBufferLength_unnamed_tag_22[InputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] >= 20);  goto L112; } else { assume irpSp > 0;
  assume (Mem_T.InputBufferLength_unnamed_tag_22[InputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] < 20);  goto L115; }
L62:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.OutputBufferLength"} boogie_si_record_li2bpl_int(Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1151} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] >= 4);  goto L63; } else { assume irpSp > 0;
  assume (Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] < 4);  goto L64; }
L63:
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1158} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    mountName := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))];  goto L263;
L64:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1154} {:print "Atomic Assignment"}  true;
      ntStatus_1 := -1073741811;  goto L262;
L66:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1422} {:print "Call \"FloppyDeviceControl\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L69;
L69:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1424} {:print "Atomic Conditional"}  true;
    if(*) { assume (ntStatus_1 == 259);  goto L70; } else { assume (ntStatus_1 != 259);  goto L71; }
L70:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1436} {:print "Atomic Assignment"}  true;
      Tmp_16 := ntStatus_1;  goto L221;
L71:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1426} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := ntStatus_1;  goto L220;
L73:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(ntStatus_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1428} {:print "Call \"FloppyDeviceControl\" \"sdv_IoIsErrorUserInduced\""}  true;
  call sdv_12 := sdv_IoIsErrorUserInduced( ntStatus_1);   goto L79;
L76:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1433} {:print "Call \"FloppyDeviceControl\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L70;
L79:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1428} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_12 == 0);  goto L76; } else { assume (sdv_12 != 0);  goto L80; }
L80:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1430} {:print "Call \"FloppyDeviceControl\" \"IoSetHardErrorOrVerifyDevice\""}  true;
  call IoSetHardErrorOrVerifyDevice( 0, 0);   goto L76;
L85:
  call {:cexpr "mountName->NameLength"} boogie_si_record_li2bpl_int(Mem_T.NameLength__MOUNTDEV_NAME[NameLength__MOUNTDEV_NAME(mountName)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1170} {:print "Atomic Assignment"}  true;
    assume mountName > 0;
    Tmp_19 := Mem_T.NameLength__MOUNTDEV_NAME[NameLength__MOUNTDEV_NAME(mountName)];  goto L267;
L86:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1164} {:print "Atomic Assignment"}  true;
      ntStatus_1 := 5;  goto L265;
L92:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1172} {:print "Atomic Assignment"}  true;
      ntStatus_1 := 0;  goto L268;
L95:
  call {:cexpr "disketteExtension->InterfaceString.Buffer"} boogie_si_record_li2bpl_int(Mem_T.Buffer__STRING[Buffer__STRING(InterfaceString__DISKETTE_EXTENSION(disketteExtension_1))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1183} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_1 > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(InterfaceString__DISKETTE_EXTENSION(disketteExtension_1))] == 0);  goto L96; } else { assume disketteExtension_1 > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(InterfaceString__DISKETTE_EXTENSION(disketteExtension_1))] != 0);  goto L97; }
L96:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1187} {:print "Atomic Assignment"}  true;
      ntStatus_1 := -1073741811;  goto L254;
L97:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.OutputBufferLength"} boogie_si_record_li2bpl_int(Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1184} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] < 4);  goto L96; } else { assume irpSp > 0;
  assume (Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] >= 4);  goto L98; }
L98:
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1191} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    uniqueId := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))];  goto L255;
L101:
  call {:cexpr "uniqueId->UniqueIdLength"} boogie_si_record_li2bpl_int(Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID[UniqueIdLength__MOUNTDEV_UNIQUE_ID(uniqueId)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1205} {:print "Atomic Assignment"}  true;
    assume uniqueId > 0;
    Tmp_25 := Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID[UniqueIdLength__MOUNTDEV_UNIQUE_ID(uniqueId)];  goto L259;
L102:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1198} {:print "Atomic Assignment"}  true;
      ntStatus_1 := 5;  goto L257;
L108:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1207} {:print "Atomic Assignment"}  true;
      ntStatus_1 := 0;  goto L260;
L112:
  call {:cexpr "&Irp->AssociatedIrp"} boogie_si_record_li2bpl_int(AssociatedIrp__IRP(Irp));
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1233} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    Tmp_21 := AssociatedIrp__IRP(Irp);  goto L248;
L115:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1225} {:print "Atomic Assignment"}  true;
      ntStatus_1 := -1073741811;  goto L247;
L117:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1233} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_11 == 0);  goto L118; } else { assume (sdv_11 != 0);  goto L119; }
L118:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1239} {:print "Atomic Assignment"}  true;
      ntStatus_1 := -1073741811;  goto L253;
L119:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1247} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 507948);  goto L55; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 507948);  goto L120; }
L120:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.InputBufferLength"} boogie_si_record_li2bpl_int(Mem_T.InputBufferLength_unnamed_tag_22[InputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1250} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.InputBufferLength_unnamed_tag_22[InputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] >= 28);  goto L121; } else { assume irpSp > 0;
  assume (Mem_T.InputBufferLength_unnamed_tag_22[InputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] < 28);  goto L122; }
L121:
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1257} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    formatExParameters := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))];  goto L250;
L122:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1253} {:print "Atomic Assignment"}  true;
      ntStatus_1 := -1073741811;  goto L249;
L126:
  call {:cexpr "formatExParameters->FormatGapLength"} boogie_si_record_li2bpl_int(Mem_T.FormatGapLength__FORMAT_EX_PARAMETERS[FormatGapLength__FORMAT_EX_PARAMETERS(formatExParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1265} {:print "Atomic Conditional"}  true;
    if(*) { assume formatExParameters > 0;
  assume (256 <= Mem_T.FormatGapLength__FORMAT_EX_PARAMETERS[FormatGapLength__FORMAT_EX_PARAMETERS(formatExParameters)]);  goto L127; } else { assume formatExParameters > 0;
  assume (256 > Mem_T.FormatGapLength__FORMAT_EX_PARAMETERS[FormatGapLength__FORMAT_EX_PARAMETERS(formatExParameters)]);  goto L129; }
L127:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1268} {:print "Atomic Assignment"}  true;
      ntStatus_1 := -1073741811;  goto L252;
L129:
  call {:cexpr "formatExParameters->SectorsPerTrack"} boogie_si_record_li2bpl_int(Mem_T.SectorsPerTrack__FORMAT_EX_PARAMETERS[SectorsPerTrack__FORMAT_EX_PARAMETERS(formatExParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1266} {:print "Atomic Conditional"}  true;
    if(*) { assume formatExParameters > 0;
  assume (256 > Mem_T.SectorsPerTrack__FORMAT_EX_PARAMETERS[SectorsPerTrack__FORMAT_EX_PARAMETERS(formatExParameters)]);  goto L55; } else { assume formatExParameters > 0;
  assume (256 <= Mem_T.SectorsPerTrack__FORMAT_EX_PARAMETERS[SectorsPerTrack__FORMAT_EX_PARAMETERS(formatExParameters)]);  goto L127; }
L134:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1338} {:print "Atomic Assignment"}  true;
      ntStatus_1 := 0;  goto L228;
L135:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1328} {:print "Atomic Assignment"}  true;
      ntStatus_1 := -1073741789;  goto L227;
L138:
  call {:cexpr "Irp->AssociatedIrp.SystemBuffer"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1358} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    outputBuffer := Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(AssociatedIrp__IRP(Irp))];  goto L231;
L139:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1350} {:print "Atomic Assignment"}  true;
      ntStatus_1 := 5;  goto L229;
L142:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  call {:cexpr "highestDriveMediaType"} boogie_si_record_li2bpl_int(highestDriveMediaType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1361} {:print "Atomic Conditional"}  true;
    if(*) { assume (i_1 > highestDriveMediaType);  goto L66; } else { assume (i_1 <= highestDriveMediaType);  goto L144; }
L144:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1364} {:print "Atomic Assignment"}  true;
      Tmp_22 := i_1;  goto L233;
L155:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1407} {:print "Call \"FloppyDeviceControl\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp);   goto L158;
L158:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((alias1(Irp, SLAM_guard_S_0) && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L206; } else { assume ((alias1(Irp, SLAM_guard_S_0) && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L207; }
L162:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1411} {:print "Call \"FloppyDeviceControl\" \"sdv_IoSetCompletionRoutine\""}  true;
  call sdv_IoSetCompletionRoutine( Irp, 0, 0, 0, 0, 0);   goto L165;
L165:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1415} {:print "Atomic Assignment"}  true;
      Tmp_16 := 0;  goto L270;
L166:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1138} {:print "Call \"FloppyDeviceControl\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp);   goto L169;
L169:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L209; } else { assume ((Irp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L210; }
L174:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 5046280);  goto L52; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 5046280);  goto L62; }
L175:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 5046272);  goto L95; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 5046272);  goto L174; }
L176:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 2967552);  goto L55; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 2967552);  goto L175; }
L177:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 2952192);  goto L58; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 2952192);  goto L176; }
L178:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 507948);  goto L59; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 507948);  goto L177; }
L179:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 507928);  goto L59; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 507928);  goto L178; }
L180:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 477184);  goto L55; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 477184);  goto L179; }
L181:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 461824);  goto L58; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 461824);  goto L180; }
L182:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.IoControlCode"} boogie_si_record_li2bpl_int(Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] == 458788);  goto L55; } else { assume irpSp > 0;
  assume (Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] != 458788);  goto L181; }
L206:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_1)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1408} {:print "Call \"FloppyDeviceControl\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_1 > 0;
  call ntStatus_1 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_1)], Irp);   goto L162;
L207:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1408} {:print "Call \"FloppyDeviceControl\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L206;
L209:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_1)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1139} {:print "Call \"FloppyDeviceControl\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_1 > 0;
  call Tmp_16 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_1)], Irp);   goto L1;
L210:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1139} {:print "Call \"FloppyDeviceControl\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L209;
L212:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L214:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1087} {:print "Call \"FloppyDeviceControl\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call irpSp := sdv_IoGetCurrentIrpStackLocation( Irp);   goto L19;
L215:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(DeviceObject);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1092} {:print "Call \"FloppyDeviceControl\" \"IoGetAttachedDeviceReference\""}  true;
  call targetDeviceObject := IoGetAttachedDeviceReference( DeviceObject);   goto L24;
L216:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L217:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1126} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := -1073741738;  goto L218;
L218:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1127} {:print "Call \"FloppyDeviceControl\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L47;
L219:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L220:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1427} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > ntStatus_1);  goto L73; } else { assume (0 <= ntStatus_1);  goto L76; }
L221:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L222:
  call {:cexpr "(DriveMediaLimits + (Tmp * 8))->LowestDriveMediaType"} boogie_si_record_li2bpl_int(Mem_T.LowestDriveMediaType__DRIVE_MEDIA_LIMITS[LowestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_24 * 8)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1311} {:print "Atomic Assignment"}  true;
    assume DriveMediaLimits > 0;
    lowestDriveMediaType := Mem_T.LowestDriveMediaType__DRIVE_MEDIA_LIMITS[LowestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_24 * 8)))];  goto L223;
L223:
  call {:cexpr "disketteExtension->DriveType"} boogie_si_record_li2bpl_int(Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1313} {:print "Atomic Assignment"}  true;
    assume disketteExtension_1 > 0;
    Tmp_26 := Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_1)];  goto L224;
L224:
  call {:cexpr "(DriveMediaLimits + (Tmp * 8))->HighestDriveMediaType"} boogie_si_record_li2bpl_int(Mem_T.HighestDriveMediaType__DRIVE_MEDIA_LIMITS[HighestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_26 * 8)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1313} {:print "Atomic Assignment"}  true;
    assume DriveMediaLimits > 0;
    highestDriveMediaType := Mem_T.HighestDriveMediaType__DRIVE_MEDIA_LIMITS[HighestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_26 * 8)))];  goto L225;
L225:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.OutputBufferLength"} boogie_si_record_li2bpl_int(Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1316} {:print "Atomic Assignment"}  true;
    assume irpSp > 0;
    outputBufferLength := Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))];  goto L226;
L226:
  call {:cexpr "outputBufferLength"} boogie_si_record_li2bpl_int(outputBufferLength);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1324} {:print "Atomic Conditional"}  true;
    if(*) { assume (outputBufferLength >= 24);  goto L134; } else { assume (outputBufferLength < 24);  goto L135; }
L227:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L228:
  call {:cexpr "outputBufferLength"} boogie_si_record_li2bpl_int(outputBufferLength);
  call {:cexpr "highestDriveMediaType"} boogie_si_record_li2bpl_int(highestDriveMediaType);
  call {:cexpr "lowestDriveMediaType"} boogie_si_record_li2bpl_int(lowestDriveMediaType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1340} {:print "Atomic Conditional"}  true;
    if(*) { assume (outputBufferLength >= (24 * ((highestDriveMediaType - lowestDriveMediaType) + 1)));  goto L138; } else { assume (outputBufferLength < (24 * ((highestDriveMediaType - lowestDriveMediaType) + 1)));  goto L139; }
L229:
  call {:cexpr "lowestDriveMediaType"} boogie_si_record_li2bpl_int(lowestDriveMediaType);
  call {:cexpr "outputBufferLength"} boogie_si_record_li2bpl_int(outputBufferLength);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1352} {:print "Atomic Assignment"}  true;
      highestDriveMediaType := ((lowestDriveMediaType - 1) + INTDIV(outputBufferLength, 24));  goto L230;
L230:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L138;
L231:
  call {:cexpr "lowestDriveMediaType"} boogie_si_record_li2bpl_int(lowestDriveMediaType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1360} {:print "Atomic Assignment"}  true;
      i_1 := lowestDriveMediaType;  goto L232;
L232:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L142;
L233:
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MediaType"} boogie_si_record_li2bpl_int(Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_22 * 80)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1364} {:print "Atomic Assignment"}  true;
    assume outputBuffer > 0;
  assume DriveMediaConstants > 0;
    Mem_T.MediaType__DISK_GEOMETRY[MediaType__DISK_GEOMETRY(outputBuffer)] := Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_22 * 80)))];  goto L234;
L234:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1365} {:print "Atomic Assignment"}  true;
      Tmp_27 := i_1;  goto L235;
L235:
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MaximumTrack"} boogie_si_record_li2bpl_int(Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_27 * 80)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1365} {:print "Atomic Assignment"}  true;
    assume outputBuffer > 0;
  assume DriveMediaConstants > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(Cylinders__DISK_GEOMETRY(outputBuffer))] := (Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_27 * 80)))] + 1);  goto L236;
L236:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1367} {:print "Atomic Assignment"}  true;
    assume outputBuffer > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(Cylinders__DISK_GEOMETRY(outputBuffer))] := 0;  goto L237;
L237:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1368} {:print "Atomic Assignment"}  true;
      Tmp_23 := i_1;  goto L238;
L238:
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->NumberOfHeads"} boogie_si_record_li2bpl_int(Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_23 * 80)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1368} {:print "Atomic Assignment"}  true;
    assume outputBuffer > 0;
  assume DriveMediaConstants > 0;
    Mem_T.TracksPerCylinder__DISK_GEOMETRY[TracksPerCylinder__DISK_GEOMETRY(outputBuffer)] := Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_23 * 80)))];  goto L239;
L239:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1370} {:print "Atomic Assignment"}  true;
      Tmp_17 := i_1;  goto L240;
L240:
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->SectorsPerTrack"} boogie_si_record_li2bpl_int(Mem_T.SectorsPerTrack__DRIVE_MEDIA_CONSTANTS[SectorsPerTrack__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_17 * 80)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1370} {:print "Atomic Assignment"}  true;
    assume outputBuffer > 0;
  assume DriveMediaConstants > 0;
    Mem_T.SectorsPerTrack__DISK_GEOMETRY[SectorsPerTrack__DISK_GEOMETRY(outputBuffer)] := Mem_T.SectorsPerTrack__DRIVE_MEDIA_CONSTANTS[SectorsPerTrack__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_17 * 80)))];  goto L241;
L241:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1372} {:print "Atomic Assignment"}  true;
      Tmp_18 := i_1;  goto L242;
L242:
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->BytesPerSector"} boogie_si_record_li2bpl_int(Mem_T.BytesPerSector__DRIVE_MEDIA_CONSTANTS[BytesPerSector__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_18 * 80)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1372} {:print "Atomic Assignment"}  true;
    assume outputBuffer > 0;
  assume DriveMediaConstants > 0;
    Mem_T.BytesPerSector__DISK_GEOMETRY[BytesPerSector__DISK_GEOMETRY(outputBuffer)] := Mem_T.BytesPerSector__DRIVE_MEDIA_CONSTANTS[BytesPerSector__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_18 * 80)))];  goto L243;
L243:
  call {:cexpr "outputBuffer"} boogie_si_record_li2bpl_int(outputBuffer);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1391} {:print "Atomic Assignment"}  true;
      outputBuffer := outputBuffer;  goto L244;
L244:
  call {:cexpr "Irp->IoStatus.Information"} boogie_si_record_li2bpl_int(Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1393} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := (Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] + 24);  goto L245;
L245:
  call {:cexpr "i"} boogie_si_record_li2bpl_int(i_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1362} {:print "Atomic Assignment"}  true;
      i_1 := (i_1 + 1);  goto L246;
L246:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L142;
L247:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L248:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(disketteExtension_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(Tmp_21)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1233} {:print "Call \"FloppyDeviceControl\" \"FlCheckFormatParameters\""}  true;
  assume Tmp_21 > 0;
  call sdv_11 := FlCheckFormatParameters( disketteExtension_1, Mem_T.SystemBuffer_unnamed_tag_2[SystemBuffer_unnamed_tag_2(Tmp_21)]);   goto L117;
L249:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L250:
  call {:cexpr "formatExParameters->SectorsPerTrack"} boogie_si_record_li2bpl_int(Mem_T.SectorsPerTrack__FORMAT_EX_PARAMETERS[SectorsPerTrack__FORMAT_EX_PARAMETERS(formatExParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1259} {:print "Atomic Assignment"}  true;
    assume formatExParameters > 0;
    formatExParametersSize := (24 + (Mem_T.SectorsPerTrack__FORMAT_EX_PARAMETERS[SectorsPerTrack__FORMAT_EX_PARAMETERS(formatExParameters)] * 2));  goto L251;
L251:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.InputBufferLength"} boogie_si_record_li2bpl_int(Mem_T.InputBufferLength_unnamed_tag_22[InputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  call {:cexpr "formatExParametersSize"} boogie_si_record_li2bpl_int(formatExParametersSize);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1263} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp > 0;
  assume (Mem_T.InputBufferLength_unnamed_tag_22[InputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] >= formatExParametersSize);  goto L126; } else { assume irpSp > 0;
  assume (Mem_T.InputBufferLength_unnamed_tag_22[InputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] < formatExParametersSize);  goto L127; }
L252:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L253:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L254:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L255:
  call {:cexpr "disketteExtension->InterfaceString.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(InterfaceString__DISKETTE_EXTENSION(disketteExtension_1))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1192} {:print "Atomic Assignment"}  true;
    assume uniqueId > 0;
  assume disketteExtension_1 > 0;
    Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID[UniqueIdLength__MOUNTDEV_UNIQUE_ID(uniqueId)] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(InterfaceString__DISKETTE_EXTENSION(disketteExtension_1))];  goto L256;
L256:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.OutputBufferLength"} boogie_si_record_li2bpl_int(Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  call {:cexpr "uniqueId->UniqueIdLength"} boogie_si_record_li2bpl_int(Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID[UniqueIdLength__MOUNTDEV_UNIQUE_ID(uniqueId)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1195} {:print "Atomic Conditional"}  true;
    if(*) { assume uniqueId > 0;
  assume irpSp > 0;
  assume (Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] >= (2 + Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID[UniqueIdLength__MOUNTDEV_UNIQUE_ID(uniqueId)]));  goto L101; } else { assume uniqueId > 0;
  assume irpSp > 0;
  assume (Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] < (2 + Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID[UniqueIdLength__MOUNTDEV_UNIQUE_ID(uniqueId)]));  goto L102; }
L257:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1199} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := 4;  goto L258;
L258:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L259:
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Tmp_25);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1203} {:print "Call \"FloppyDeviceControl\" \"sdv_RtlCopyMemory\""}  true;
  call sdv_RtlCopyMemory( 0, 0, Tmp_25);   goto L108;
L260:
  call {:cexpr "uniqueId->UniqueIdLength"} boogie_si_record_li2bpl_int(Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID[UniqueIdLength__MOUNTDEV_UNIQUE_ID(uniqueId)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1208} {:print "Atomic Assignment"}  true;
    assume uniqueId > 0;
  assume Irp > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := (2 + Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID[UniqueIdLength__MOUNTDEV_UNIQUE_ID(uniqueId)]);  goto L261;
L261:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L262:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L263:
  call {:cexpr "disketteExtension->DeviceName.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(DeviceName__DISKETTE_EXTENSION(disketteExtension_1))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1159} {:print "Atomic Assignment"}  true;
    assume mountName > 0;
  assume disketteExtension_1 > 0;
    Mem_T.NameLength__MOUNTDEV_NAME[NameLength__MOUNTDEV_NAME(mountName)] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(DeviceName__DISKETTE_EXTENSION(disketteExtension_1))];  goto L264;
L264:
  call {:cexpr "irpSp->Parameters.DeviceIoControl.OutputBufferLength"} boogie_si_record_li2bpl_int(Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))]);
  call {:cexpr "mountName->NameLength"} boogie_si_record_li2bpl_int(Mem_T.NameLength__MOUNTDEV_NAME[NameLength__MOUNTDEV_NAME(mountName)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1161} {:print "Atomic Conditional"}  true;
    if(*) { assume mountName > 0;
  assume irpSp > 0;
  assume (Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] >= (2 + Mem_T.NameLength__MOUNTDEV_NAME[NameLength__MOUNTDEV_NAME(mountName)]));  goto L85; } else { assume mountName > 0;
  assume irpSp > 0;
  assume (Mem_T.OutputBufferLength_unnamed_tag_22[OutputBufferLength_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] < (2 + Mem_T.NameLength__MOUNTDEV_NAME[NameLength__MOUNTDEV_NAME(mountName)]));  goto L86; }
L265:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1165} {:print "Atomic Assignment"}  true;
    assume Irp > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := 4;  goto L266;
L266:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L267:
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Tmp_19);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1169} {:print "Call \"FloppyDeviceControl\" \"sdv_RtlCopyMemory\""}  true;
  call sdv_RtlCopyMemory( 0, 0, Tmp_19);   goto L92;
L268:
  call {:cexpr "mountName->NameLength"} boogie_si_record_li2bpl_int(Mem_T.NameLength__MOUNTDEV_NAME[NameLength__MOUNTDEV_NAME(mountName)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1173} {:print "Atomic Assignment"}  true;
    assume mountName > 0;
  assume Irp > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := (2 + Mem_T.NameLength__MOUNTDEV_NAME[NameLength__MOUNTDEV_NAME(mountName)]);  goto L269;
L269:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L66;
L270:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "FloppySystemControl"} FloppySystemControl(actual_DeviceObject_1:int, actual_Irp_1:int) returns (Tmp_28:int) {
var  sdv_18: int;
var  Tmp_29: int;
var  disketteExtension_2: int;
var  DeviceObject_1: int;
var  Irp_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_1 := actual_DeviceObject_1;
  Irp_1 := actual_Irp_1;
  // done with preamble
  goto L16;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 526} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 521} {:print "Atomic Assignment"}  true;
    assume DeviceObject_1 > 0;
    disketteExtension_2 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_1)];  goto L18;
L8:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_1);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
   assume alias2(SLAM_guard_S_0, Irp_1);
    if(*) { assume (!((Irp_1 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L13; } else { assume ((Irp_1 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L14; }
L13:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_2)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 525} {:print "Call \"FloppySystemControl\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_2 > 0;
  call Tmp_28 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_2)], Irp_1);   goto L1;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 525} {:print "Call \"FloppySystemControl\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L13;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L18:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 523} {:print "Call \"FloppySystemControl\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp_1);   goto L8;
Lfinal: return;
}
procedure {:origName "FloppyQueueRequest"} FloppyQueueRequest(actual_DisketteExtension_2:int, actual_Irp_2:int) returns (Tmp_30:int) {
var  Tmp_31: int;
var  sdv_19: int;
var  sdv_20: int;
var  sdv_21: int;
var  sdv_22: int;
var  sdv_23: int;
var  ntStatus_2: int;
var  oldIrql: int;
var  DisketteExtension_2: int;
var  Irp_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DisketteExtension_2 := actual_DisketteExtension_2;
  Irp_2 := actual_Irp_2;
  // done with preamble
  goto L71;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5783} {:print "Call \"FloppyQueueRequest\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L8;
L8:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5783} {:print "Atomic Assignment"}  true;
      PagingReferenceCount := (PagingReferenceCount + 1);  goto L73;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5783} {:print "Call \"FloppyQueueRequest\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L15;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5783} {:print "Call \"FloppyQueueRequest\" \"MmResetDriverPaging\""}  true;
  call MmResetDriverPaging( 0);   goto L9;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_31 := __HAVOC_malloc(4);  goto L70;
L18:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5800} {:print "Call \"FloppyQueueRequest\" \"IoSetStartIoAttributes\""}  true;
  call IoSetStartIoAttributes( 0, 0, 0);   goto L21;
L21:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_2);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(234);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5803} {:print "Call \"FloppyQueueRequest\" \"sdv_IoSetCancelRoutine\""}  true;
  call sdv_23 := sdv_IoSetCancelRoutine( Irp_2, 234);   goto L24;
L24:
  call {:cexpr "Irp->Cancel"} boogie_si_record_li2bpl_int(Mem_T.Cancel__IRP[Cancel__IRP(Irp_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5808} {:print "Atomic Conditional"}  true;
    if(*) { assume Irp_2 > 0;
  assume (Mem_T.Cancel__IRP[Cancel__IRP(Irp_2)] == 0);  goto L25; } else { assume Irp_2 > 0;
  assume (Mem_T.Cancel__IRP[Cancel__IRP(Irp_2)] != 0);  goto L26; }
L25:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5831} {:print "Atomic Assignment"}  true;
    assume Irp_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := 259;  goto L81;
L26:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_2);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5808} {:print "Call \"FloppyQueueRequest\" \"sdv_IoSetCancelRoutine\""}  true;
  call sdv_22 := sdv_IoSetCancelRoutine( Irp_2, 0);   goto L29;
L29:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_22);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5808} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_22 == 0);  goto L25; } else { assume (sdv_22 != 0);  goto L30; }
L30:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5813} {:print "Atomic Assignment"}  true;
    assume Irp_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := -1073741536;  goto L76;
L35:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5817} {:print "Call \"FloppyQueueRequest\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L38;
L38:
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Irp_2);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5820} {:print "Call \"FloppyQueueRequest\" \"WmiSystemControl\""}  true;
  call sdv_21 := WmiSystemControl( 0, 0, Irp_2, 0);   goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5823} {:print "Call \"FloppyQueueRequest\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L44;
L44:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5823} {:print "Atomic Assignment"}  true;
      PagingReferenceCount := (PagingReferenceCount - 1);  goto L78;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5823} {:print "Call \"FloppyQueueRequest\" \"MmPageEntireDriver\""}  true;
  call sdv_20 := MmPageEntireDriver( 0);   goto L48;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5823} {:print "Call \"FloppyQueueRequest\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L51;
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5825} {:print "Atomic Assignment"}  true;
      ntStatus_2 := -1073741536;  goto L79;
L52:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5849} {:print "Atomic Assignment"}  true;
      Tmp_30 := ntStatus_2;  goto L80;
L56:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5835} {:print "Call \"FloppyQueueRequest\" \"sdv_ExInterlockedInsertTailList\""}  true;
  call sdv_19 := sdv_ExInterlockedInsertTailList( 0, 0, 0);   goto L59;
L59:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(oldIrql);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5839} {:print "Call \"FloppyQueueRequest\" \"sdv_KeReleaseSpinLock\""}  true;
  call sdv_KeReleaseSpinLock( 0, oldIrql);   goto L62;
L62:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5842} {:print "Atomic Assignment"}  true;
      ntStatus_2 := 259;  goto L82;
L69:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_31]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_31 > 0;
    oldIrql := Mem_T.INT4[Tmp_31];  goto L75;
L70:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_31 > 0;
    Mem_T.INT4[Tmp_31] := oldIrql;  goto L74;
L71:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L73:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5783} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingReferenceCount != 1);  goto L9; } else { assume (PagingReferenceCount == 1);  goto L12; }
L74:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_31);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5797} {:print "Call \"FloppyQueueRequest\" \"sdv_KeAcquireSpinLock\""}  true;
  call sdv_KeAcquireSpinLock( 0, Tmp_31);   goto L69;
L75:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L18;
L76:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5814} {:print "Atomic Assignment"}  true;
    assume Irp_2 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := 0;  goto L77;
L77:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(oldIrql);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5816} {:print "Call \"FloppyQueueRequest\" \"sdv_KeReleaseSpinLock\""}  true;
  call sdv_KeReleaseSpinLock( 0, oldIrql);   goto L35;
L78:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5823} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingReferenceCount == 0);  goto L45; } else { assume (PagingReferenceCount != 0);  goto L48; }
L79:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L52;
L80:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5849} {:print "Return"}  true;
    goto LM2;
L81:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5833} {:print "Call \"FloppyQueueRequest\" \"sdv_IoMarkIrpPending\""}  true;
  call sdv_IoMarkIrpPending( 0);   goto L56;
L82:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5845} {:print "Atomic Assignment"}  true;
      ntStatus_2 := 0;  goto L83;
L83:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L52;
Lfinal: return;
}
procedure {:origName "DriverEntry"} DriverEntry(actual_DriverObject_1:int, actual_RegistryPath:int) returns (Tmp_32:int) {
var  Tmp_33: int;
var  sdv_24: int;
var  sdv_25: int;
var  Tmp_34: int;
var  ntStatus_3: int;
var  Tmp_35: int;
var  Tmp_36: int;
var  Tmp_37: int;
var  Tmp_38: int;
var  Tmp_39: int;
var  Tmp_40: int;
var  Tmp_41: int;
var  Tmp_42: int;
var  DriverObject_1: int;
var  RegistryPath: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DriverObject_1 := actual_DriverObject_1;
  RegistryPath := actual_RegistryPath;
  // done with preamble
  goto L31;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 258} {:print "Return"}  true;
    goto LM2;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 145} {:print "Atomic Assignment"}  true;
      ntStatus_3 := 0;  goto L33;
L18:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_25);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 239} {:print "Atomic Assignment"}  true;
      PagingMutex := sdv_25;  goto L53;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 243} {:print "Atomic Assignment"}  true;
      Tmp_32 := -1073741670;  goto L57;
L21:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 246} {:print "Call \"DriverEntry\" \"sdv_ExInitializeFastMutex\""}  true;
  call sdv_ExInitializeFastMutex( 0);   goto L24;
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 251} {:print "Call \"DriverEntry\" \"MmPageEntireDriver\""}  true;
  call sdv_24 := MmPageEntireDriver( 0);   goto L27;
L27:
  call {:cexpr "&*_DriveMediaLimits"} boogie_si_record_li2bpl_int(_DriveMediaLimits);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 253} {:print "Atomic Assignment"}  true;
      DriveMediaLimits := _DriveMediaLimits;  goto L54;
L31:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_33 := __HAVOC_malloc(112);
    call Tmp_35 := __HAVOC_malloc(112);
    call Tmp_36 := __HAVOC_malloc(112);
    call Tmp_37 := __HAVOC_malloc(112);
    call Tmp_38 := __HAVOC_malloc(112);
    call Tmp_39 := __HAVOC_malloc(112);
    call Tmp_40 := __HAVOC_malloc(112);
    call Tmp_42 := __HAVOC_malloc(112);  goto L0;
L33:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 222} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Tmp_39 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)];  goto L34;
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 222} {:print "Atomic Assignment"}  true;
    assume Tmp_39 > 0;
    Mem_T.INT4[Tmp_39] := 201;  goto L35;
L35:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 223} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Tmp_35 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)];  goto L36;
L36:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 223} {:print "Atomic Assignment"}  true;
    assume Tmp_35 > 0;
    Mem_T.INT4[(Tmp_35 + (2 * 4))] := 201;  goto L37;
L37:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 224} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Tmp_40 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)];  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 224} {:print "Atomic Assignment"}  true;
    assume Tmp_40 > 0;
    Mem_T.INT4[(Tmp_40 + (3 * 4))] := 202;  goto L39;
L39:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 225} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Tmp_36 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)];  goto L40;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 225} {:print "Atomic Assignment"}  true;
    assume Tmp_36 > 0;
    Mem_T.INT4[(Tmp_36 + (4 * 4))] := 202;  goto L41;
L41:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 226} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Tmp_42 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)];  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 226} {:print "Atomic Assignment"}  true;
    assume Tmp_42 > 0;
    Mem_T.INT4[(Tmp_42 + (14 * 4))] := 203;  goto L43;
L43:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 227} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Tmp_37 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)];  goto L44;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 227} {:print "Atomic Assignment"}  true;
    assume Tmp_37 > 0;
    Mem_T.INT4[(Tmp_37 + (27 * 4))] := 204;  goto L45;
L45:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 228} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Tmp_33 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)];  goto L46;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 228} {:print "Atomic Assignment"}  true;
    assume Tmp_33 > 0;
    Mem_T.INT4[(Tmp_33 + (22 * 4))] := 205;  goto L47;
L47:
  call {:cexpr "DriverObject->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 229} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Tmp_38 := Mem_T.MajorFunction__DRIVER_OBJECT[MajorFunction__DRIVER_OBJECT(DriverObject_1)];  goto L48;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 229} {:print "Atomic Assignment"}  true;
    assume Tmp_38 > 0;
    Mem_T.INT4[(Tmp_38 + (23 * 4))] := 206;  goto L49;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 231} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Mem_T.DriverUnload__DRIVER_OBJECT[DriverUnload__DRIVER_OBJECT(DriverObject_1)] := 207;  goto L50;
L50:
  call {:cexpr "DriverObject->DriverExtension"} boogie_si_record_li2bpl_int(Mem_T.DriverExtension__DRIVER_OBJECT[DriverExtension__DRIVER_OBJECT(DriverObject_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 233} {:print "Atomic Assignment"}  true;
    assume DriverObject_1 > 0;
    Tmp_34 := Mem_T.DriverExtension__DRIVER_OBJECT[DriverExtension__DRIVER_OBJECT(DriverObject_1)];  goto L51;
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 233} {:print "Atomic Assignment"}  true;
    assume Tmp_34 > 0;
    Mem_T.AddDevice__DRIVER_EXTENSION[AddDevice__DRIVER_EXTENSION(Tmp_34)] := 208;  goto L52;
L52:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(512);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(32);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(-261133242);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 239} {:print "Call \"DriverEntry\" \"ExAllocatePoolWithTag\""}  true;
  call sdv_25 := ExAllocatePoolWithTag( 512, 32, -261133242);   goto L18;
L53:
  call {:cexpr "PagingMutex"} boogie_si_record_li2bpl_int(PagingMutex);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 241} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingMutex == 0);  goto L20; } else { assume (PagingMutex != 0);  goto L21; }
L54:
  call {:cexpr "&*_DriveMediaConstants"} boogie_si_record_li2bpl_int(_DriveMediaConstants);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 255} {:print "Atomic Assignment"}  true;
      DriveMediaConstants := _DriveMediaConstants;  goto L55;
L55:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 257} {:print "Atomic Assignment"}  true;
      Tmp_32 := ntStatus_3;  goto L56;
L56:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L57:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "FloppyReadWrite"} FloppyReadWrite(actual_DeviceObject_2:int, actual_Irp_3:int) returns (Tmp_43:int) {
var  sdv_26: int;
var  sdv_27: int;
var  sdv_28: int;
var  ntStatus_4: int;
var  disketteExtension_3: int;
var  irpSp_1: int;
var  Tmp_44: int;
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
  goto L66;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2306} {:print "Return"}  true;
    goto LM2;
L6:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_2)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2208} {:print "Atomic Assignment"}  true;
    assume DeviceObject_2 > 0;
    disketteExtension_3 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_2)];  goto L68;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2216} {:print "Call \"FloppyReadWrite\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L14;
L14:
  call {:cexpr "disketteExtension->HoldNewRequests"} boogie_si_record_li2bpl_int(Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2217} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_3 > 0;
  assume (Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_3)] == 0);  goto L15; } else { assume disketteExtension_3 > 0;
  assume (Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_3)] != 0);  goto L16; }
L15:
  call {:cexpr "disketteExtension->IsRemoved"} boogie_si_record_li2bpl_int(Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2229} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_3 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_3)] == 0);  goto L24; } else { assume disketteExtension_3 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_3)] != 0);  goto L25; }
L16:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(disketteExtension_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2219} {:print "Call \"FloppyReadWrite\" \"FloppyQueueRequest\""}  true;
  call ntStatus_4 := FloppyQueueRequest( disketteExtension_3, Irp_3);   goto L20;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2221} {:print "Call \"FloppyReadWrite\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L23;
L23:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2222} {:print "Atomic Assignment"}  true;
      Tmp_43 := ntStatus_4;  goto L69;
L24:
  call {:cexpr "disketteExtension->IsStarted"} boogie_si_record_li2bpl_int(Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2229} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_3 > 0;
  assume (Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_3)] == 0);  goto L25; } else { assume disketteExtension_3 > 0;
  assume (Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_3)] != 0);  goto L37; }
L25:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2231} {:print "Call \"FloppyReadWrite\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L28;
L28:
  call {:cexpr "disketteExtension->IsRemoved"} boogie_si_record_li2bpl_int(Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2233} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_3 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_3)] == 0);  goto L29; } else { assume disketteExtension_3 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_3)] != 0);  goto L30; }
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2236} {:print "Atomic Assignment"}  true;
      ntStatus_4 := -1073741823;  goto L74;
L30:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2234} {:print "Atomic Assignment"}  true;
      ntStatus_4 := -1073741738;  goto L70;
L31:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2238} {:print "Atomic Assignment"}  true;
    assume Irp_3 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))] := 0;  goto L71;
L36:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2241} {:print "Atomic Assignment"}  true;
      Tmp_43 := ntStatus_4;  goto L73;
L37:
  call {:cexpr "disketteExtension->MediaType"} boogie_si_record_li2bpl_int(Mem_T.MediaType__DISKETTE_EXTENSION[MediaType__DISKETTE_EXTENSION(disketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2244} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_3 > 0;
  assume (0 >= Mem_T.MediaType__DISKETTE_EXTENSION[MediaType__DISKETTE_EXTENSION(disketteExtension_3)]);  goto L38; } else { assume disketteExtension_3 > 0;
  assume (0 < Mem_T.MediaType__DISKETTE_EXTENSION[MediaType__DISKETTE_EXTENSION(disketteExtension_3)]);  goto L39; }
L38:
  call {:cexpr "irpSp->Parameters.Read.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2271} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_1 > 0;
  assume (Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1)))] == 0);  goto L51; } else { assume irpSp_1 > 0;
  assume (Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1)))] != 0);  goto L52; }
L39:
  call {:cexpr "disketteExtension->ByteCapacity"} boogie_si_record_li2bpl_int(Mem_T.ByteCapacity__DISKETTE_EXTENSION[ByteCapacity__DISKETTE_EXTENSION(disketteExtension_3)]);
  call {:cexpr "irpSp->Parameters.Read.ByteOffset.LowPart"} boogie_si_record_li2bpl_int(Mem_T.LowPart__LUID[LowPart__LUID(ByteOffset_unnamed_tag_12(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1))))]);
  call {:cexpr "irpSp->Parameters.Read.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2246} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_1 > 0;
  assume disketteExtension_3 > 0;
  assume (Mem_T.ByteCapacity__DISKETTE_EXTENSION[ByteCapacity__DISKETTE_EXTENSION(disketteExtension_3)] >= (Mem_T.LowPart__LUID[LowPart__LUID(ByteOffset_unnamed_tag_12(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1))))] + Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1)))]));  goto L40; } else { assume irpSp_1 > 0;
  assume disketteExtension_3 > 0;
  assume (Mem_T.ByteCapacity__DISKETTE_EXTENSION[ByteCapacity__DISKETTE_EXTENSION(disketteExtension_3)] < (Mem_T.LowPart__LUID[LowPart__LUID(ByteOffset_unnamed_tag_12(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1))))] + Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1)))]));  goto L41; }
L40:
  call {:cexpr "irpSp->Parameters.Read.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1)))]);
  call {:cexpr "disketteExtension->BytesPerSector"} boogie_si_record_li2bpl_int(Mem_T.BytesPerSector__DISKETTE_EXTENSION[BytesPerSector__DISKETTE_EXTENSION(disketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2247} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_1 > 0;
  assume disketteExtension_3 > 0;
  assume (BAND(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1)))], (Mem_T.BytesPerSector__DISKETTE_EXTENSION[BytesPerSector__DISKETTE_EXTENSION(disketteExtension_3)] - 1)) == 0);  goto L38; } else { assume irpSp_1 > 0;
  assume disketteExtension_3 > 0;
  assume (BAND(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Read_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_1)))], (Mem_T.BytesPerSector__DISKETTE_EXTENSION[BytesPerSector__DISKETTE_EXTENSION(disketteExtension_3)] - 1)) != 0);  goto L41; }
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2262} {:print "Atomic Assignment"}  true;
      ntStatus_4 := -1073741811;  goto L75;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2295} {:print "Call \"FloppyReadWrite\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L45;
L45:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2297} {:print "Atomic Conditional"}  true;
    if(*) { assume (ntStatus_4 == 259);  goto L46; } else { assume (ntStatus_4 != 259);  goto L47; }
L46:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2305} {:print "Atomic Assignment"}  true;
      Tmp_43 := ntStatus_4;  goto L77;
L47:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2298} {:print "Atomic Assignment"}  true;
    assume Irp_3 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))] := ntStatus_4;  goto L76;
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2287} {:print "Atomic Assignment"}  true;
    assume Irp_3 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))] := 0;  goto L78;
L52:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(disketteExtension_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2280} {:print "Call \"FloppyReadWrite\" \"FlQueueIrpToThread\""}  true;
  call ntStatus_4 := FlQueueIrpToThread( Irp_3, disketteExtension_3);   goto L42;
L66:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L68:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2210} {:print "Call \"FloppyReadWrite\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call irpSp_1 := sdv_IoGetCurrentIrpStackLocation( Irp_3);   goto L11;
L69:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L70:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L31;
L71:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2239} {:print "Atomic Assignment"}  true;
    assume Irp_3 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))] := ntStatus_4;  goto L72;
L72:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2240} {:print "Call \"FloppyReadWrite\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L36;
L73:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L74:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L31;
L75:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L42;
L76:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2302} {:print "Call \"FloppyReadWrite\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L46;
L77:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L78:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2288} {:print "Atomic Assignment"}  true;
    assume Irp_3 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))] := 0;  goto L79;
L79:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 2291} {:print "Atomic Assignment"}  true;
      ntStatus_4 := 0;  goto L80;
L80:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L42;
Lfinal: return;
}
procedure {:origName "FlFdcDeviceIo"} FlFdcDeviceIo(actual_DeviceObject_3:int, actual_Ioctl:int, actual_Data:int) returns (Tmp_45:int) {
var  sdv_29: int;
var  sdv_30: int;
var  irpStack: int;
var  sdv_31: int;
var  sdv_32: int;
var  ntStatus_5: int;
var  ioStatus: int;
var  irp: int;
var  Tmp_46: int;
var  doneEvent: int;
var  DeviceObject_3: int;
var  Ioctl: int;
var  Data: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call ioStatus := __HAVOC_malloc(12);
  call doneEvent := __HAVOC_malloc(108);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_3 := actual_DeviceObject_3;
  Ioctl := actual_Ioctl;
  Data := actual_Data;
  // done with preamble
  goto L37;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5749} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(doneEvent);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5697} {:print "Call \"FlFdcDeviceIo\" \"KeInitializeEvent\""}  true;
  call KeInitializeEvent( doneEvent, 0, 0);   goto L11;
L11:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Ioctl);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg7"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg9"} boogie_si_record_li2bpl_int(ioStatus);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5704} {:print "Call \"FlFdcDeviceIo\" \"IoBuildDeviceIoControlRequest\""}  true;
  call irp := IoBuildDeviceIoControlRequest( Ioctl, 0, 0, 0, 0, 0, 1, 0, ioStatus);   goto L15;
L15:
  call {:cexpr "irp"} boogie_si_record_li2bpl_int(irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5714} {:print "Atomic Conditional"}  true;
    if(*) { assume (irp == 0);  goto L16; } else { assume (irp != 0);  goto L17; }
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5722} {:print "Atomic Assignment"}  true;
      Tmp_45 := -1073741670;  goto L42;
L17:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5725} {:print "Call \"FlFdcDeviceIo\" \"sdv_IoGetNextIrpStackLocation\""}  true;
  call irpStack := sdv_IoGetNextIrpStackLocation( irp);   goto L21;
L21:
  call {:cexpr "Data"} boogie_si_record_li2bpl_int(Data);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5726} {:print "Atomic Assignment"}  true;
    assume irpStack > 0;
    Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpStack)))] := Data;  goto L39;
L26:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5733} {:print "Atomic Conditional"}  true;
    if(*) { assume (ntStatus_5 != 259);  goto L27; } else { assume (ntStatus_5 == 259);  goto L28; }
L27:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5748} {:print "Atomic Assignment"}  true;
      Tmp_45 := ntStatus_5;  goto L41;
L28:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5739} {:print "Call \"FlFdcDeviceIo\" \"KeWaitForSingleObject\""}  true;
  call sdv_29 := KeWaitForSingleObject( 0, 0, 0, 0, 0);   goto L31;
L31:
  call {:cexpr "ioStatus.Status"} boogie_si_record_li2bpl_int(Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(ioStatus)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5745} {:print "Atomic Assignment"}  true;
    assume ioStatus > 0;
    ntStatus_5 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(ioStatus)];  goto L40;
L34:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(DeviceObject_3);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5731} {:print "Call \"FlFdcDeviceIo\" \"sdv_IoCallDriver\""}  true;
  call ntStatus_5 := sdv_IoCallDriver( DeviceObject_3, irp);   goto L26;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5731} {:print "Call \"FlFdcDeviceIo\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L34;
L37:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L39:
  call {:cexpr "irp"} boogie_si_record_li2bpl_int(irp);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
   assume alias3(SLAM_guard_S_0, irp);
    if(*) { assume (!((irp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L34; } else { assume ((irp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L35; }
L40:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L27;
L41:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L42:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "FloppyStartDevice"} FloppyStartDevice(actual_DeviceObject_4:int, actual_Irp_4:int) returns (Tmp_47:int) {
var  sdv_33: int;
var  sdv_34: int;
var  sdv_35: int;
var  sdv_36: int;
var  sdv_37: int;
var  sdv_38: int;
var  sdv_39: int;
var  ntStatus_6: int;
var  sdv_40: int;
var  irpSp_2: int;
var  disketteExtension_4: int;
var  Fp: int;
var  Tmp_48: int;
var  fdcInfo_1: int;
var  Dc: int;
var  Tmp_49: int;
var  doneEvent_1: int;
var  sdv_41: int;
var  InterfaceType: int;
var  sdv_42: int;
var  pnpStatus: int;
var  Tmp_50: int;
var  DeviceObject_4: int;
var  Irp_4: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call fdcInfo_1 := __HAVOC_malloc(120);
  call doneEvent_1 := __HAVOC_malloc(108);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_4 := actual_DeviceObject_4;
  Irp_4 := actual_Irp_4;
  // done with preamble
  goto L123;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1827} {:print "Atomic Assignment"}  true;
      Dc := 13;  goto L125;
L18:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(doneEvent_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1840} {:print "Call \"FloppyStartDevice\" \"KeInitializeEvent\""}  true;
  call KeInitializeEvent( doneEvent_1, 0, 0);   goto L21;
L21:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1842} {:print "Call \"FloppyStartDevice\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_4);   goto L24;
L24:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_4);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(213);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(doneEvent_1);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1844} {:print "Call \"FloppyStartDevice\" \"sdv_IoSetCompletionRoutine\""}  true;
  call sdv_IoSetCompletionRoutine( Irp_4, 213, doneEvent_1, 1, 1, 1);   goto L27;
L27:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_4);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
   assume alias4(SLAM_guard_S_0, Irp_4);
    if(*) { assume (!((Irp_4 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L117; } else { assume ((Irp_4 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L118; }
L31:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_4);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_4 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L120; } else { assume ((Irp_4 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L121; }
L35:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1854} {:print "Atomic Conditional"}  true;
    if(*) { assume (ntStatus_6 != 259);  goto L36; } else { assume (ntStatus_6 == 259);  goto L37; }
L36:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1870} {:print "Atomic Assignment"}  true;
    assume fdcInfo_1 > 0;
    Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo_1)] := 0;  goto L129;
L37:
  call {:cexpr "Irp->IoStatus.Status"} boogie_si_record_li2bpl_int(Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_4))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1867} {:print "Atomic Assignment"}  true;
    assume Irp_4 > 0;
    ntStatus_6 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_4))];  goto L128;
L43:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1877} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > ntStatus_6);  goto L44; } else { assume (0 <= ntStatus_6);  goto L45; }
L44:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1971} {:print "Atomic Assignment"}  true;
    assume Irp_4 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_4))] := ntStatus_6;  goto L140;
L45:
  call {:cexpr "fdcInfo.MaxTransferSize"} boogie_si_record_li2bpl_int(Mem_T.MaxTransferSize__FDC_INFO[MaxTransferSize__FDC_INFO(fdcInfo_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1879} {:print "Atomic Assignment"}  true;
    assume fdcInfo_1 > 0;
  assume disketteExtension_4 > 0;
    Mem_T.MaxTransferSize__DISKETTE_EXTENSION[MaxTransferSize__DISKETTE_EXTENSION(disketteExtension_4)] := Mem_T.MaxTransferSize__FDC_INFO[MaxTransferSize__FDC_INFO(fdcInfo_1)];  goto L131;
L48:
  call {:cexpr "fdcInfo.AcpiFdiSupported"} boogie_si_record_li2bpl_int(Mem_T.AcpiFdiSupported__FDC_INFO[AcpiFdiSupported__FDC_INFO(fdcInfo_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1882} {:print "Atomic Conditional"}  true;
    if(*) { assume fdcInfo_1 > 0;
  assume (Mem_T.AcpiFdiSupported__FDC_INFO[AcpiFdiSupported__FDC_INFO(fdcInfo_1)] != 0);  goto L49; } else { assume fdcInfo_1 > 0;
  assume (Mem_T.AcpiFdiSupported__FDC_INFO[AcpiFdiSupported__FDC_INFO(fdcInfo_1)] == 0);  goto L89; }
L49:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(disketteExtension_4);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(fdcInfo_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1884} {:print "Call \"FloppyStartDevice\" \"FlAcpiConfigureFloppy\""}  true;
  call ntStatus_6 := FlAcpiConfigureFloppy( disketteExtension_4, fdcInfo_1);   goto L53;
L53:
  call {:cexpr "disketteExtension->DriveType"} boogie_si_record_li2bpl_int(Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1886} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_4 > 0;
  assume (Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_4)] != 4);  goto L54; } else { assume disketteExtension_4 > 0;
  assume (Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_4)] == 4);  goto L55; }
L54:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1929} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > ntStatus_6);  goto L44; } else { assume (0 <= ntStatus_6);  goto L56; }
L55:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1888} {:print "Atomic Assignment"}  true;
    assume disketteExtension_4 > 0;
    call boogieTmp := corral_nondet(); Mem_T.PerpendicularMode__DISKETTE_EXTENSION[PerpendicularMode__DISKETTE_EXTENSION(disketteExtension_4)] := boogieTmp;  goto L132;
L56:
  call {:cexpr "fdcInfo.PeripheralNumber"} boogie_si_record_li2bpl_int(Mem_T.PeripheralNumber__FDC_INFO[PeripheralNumber__FDC_INFO(fdcInfo_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1930} {:print "Atomic Assignment"}  true;
    assume fdcInfo_1 > 0;
  assume disketteExtension_4 > 0;
    Mem_T.DeviceUnit__DISKETTE_EXTENSION[DeviceUnit__DISKETTE_EXTENSION(disketteExtension_4)] := Mem_T.PeripheralNumber__FDC_INFO[PeripheralNumber__FDC_INFO(fdcInfo_1)];  goto L133;
L63:
  call {:cexpr "pnpStatus"} boogie_si_record_li2bpl_int(pnpStatus);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1939} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > pnpStatus);  goto L64; } else { assume (0 <= pnpStatus);  goto L65; }
L64:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1961} {:print "Atomic Assignment"}  true;
    assume disketteExtension_4 > 0;
    Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_4)] := 1;  goto L137;
L65:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1941} {:print "Call \"FloppyStartDevice\" \"IoSetDeviceInterfaceState\""}  true;
  call pnpStatus := IoSetDeviceInterfaceState( 0, 1);   goto L69;
L69:
  call {:cexpr "&GUID_DEVINTERFACE_FLOPPY"} boogie_si_record_li2bpl_int(GUID_DEVINTERFACE_FLOPPY);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1949} {:print "Atomic Assignment"}  true;
      Tmp_48 := GUID_DEVINTERFACE_FLOPPY;  goto L136;
L74:
  call {:cexpr "pnpStatus"} boogie_si_record_li2bpl_int(pnpStatus);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1953} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > pnpStatus);  goto L64; } else { assume (0 <= pnpStatus);  goto L75; }
L75:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1955} {:print "Call \"FloppyStartDevice\" \"IoSetDeviceInterfaceState\""}  true;
  call pnpStatus := IoSetDeviceInterfaceState( 0, 1);   goto L64;
L82:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1964} {:print "Atomic Assignment"}  true;
    assume disketteExtension_4 > 0;
    Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_4)] := 0;  goto L138;
L86:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(disketteExtension_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1967} {:print "Call \"FloppyStartDevice\" \"FloppyProcessQueuedRequests\""}  true;
  call FloppyProcessQueuedRequests( disketteExtension_4);   goto L139;
L89:
  call {:cexpr "disketteExtension->DriveType"} boogie_si_record_li2bpl_int(Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1895} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_4 > 0;
  assume (Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_4)] != 4);  goto L90; } else { assume disketteExtension_4 > 0;
  assume (Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(disketteExtension_4)] == 4);  goto L91; }
L90:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1904} {:print "Atomic Assignment"}  true;
      InterfaceType := 0;  goto L143;
L91:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1897} {:print "Atomic Assignment"}  true;
    assume disketteExtension_4 > 0;
    call boogieTmp := corral_nondet(); Mem_T.PerpendicularMode__DISKETTE_EXTENSION[PerpendicularMode__DISKETTE_EXTENSION(disketteExtension_4)] := boogieTmp;  goto L142;
L92:
  assume {:CounterLoop 18} {:Counter "InterfaceType"} true;
  call {:cexpr "InterfaceType"} boogie_si_record_li2bpl_int(InterfaceType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1905} {:print "Atomic Conditional"}  true;
    if(*) { assume (InterfaceType >= 18);  goto L54; } else { assume (InterfaceType < 18);  goto L93; }
L93:
  call {:cexpr "InterfaceType"} boogie_si_record_li2bpl_int(InterfaceType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1908} {:print "Atomic Assignment"}  true;
    assume fdcInfo_1 > 0;
    Mem_T.BusType__FDC_INFO[BusType__FDC_INFO(fdcInfo_1)] := InterfaceType;  goto L144;
L98:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1918} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 <= ntStatus_6);  goto L54; } else { assume (0 > ntStatus_6);  goto L99; }
L99:
  call {:cexpr "InterfaceType"} boogie_si_record_li2bpl_int(InterfaceType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1906} {:print "Atomic Assignment"}  true;
      InterfaceType := (InterfaceType + 1);  goto L145;
L104:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1974} {:print "Atomic Assignment"}  true;
      Tmp_47 := ntStatus_6;  goto L141;
L117:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_4)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1850} {:print "Call \"FloppyStartDevice\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_4 > 0;
  call ntStatus_6 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_4)], Irp_4);   goto L31;
L118:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1850} {:print "Call \"FloppyStartDevice\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L117;
L120:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_4)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1852} {:print "Call \"FloppyStartDevice\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_4 > 0;
  call ntStatus_6 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_4)], Irp_4);   goto L35;
L121:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1852} {:print "Call \"FloppyStartDevice\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L120;
L123:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L125:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1828} {:print "Atomic Assignment"}  true;
      Fp := 26;  goto L126;
L126:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1830} {:print "Atomic Assignment"}  true;
    assume DeviceObject_4 > 0;
    disketteExtension_4 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_4)];  goto L127;
L127:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1831} {:print "Call \"FloppyStartDevice\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call irpSp_2 := sdv_IoGetCurrentIrpStackLocation( Irp_4);   goto L18;
L128:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L36;
L129:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1871} {:print "Atomic Assignment"}  true;
    assume fdcInfo_1 > 0;
    Mem_T.BufferSize__FDC_INFO[BufferSize__FDC_INFO(fdcInfo_1)] := 0;  goto L130;
L130:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_4)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(461835);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(fdcInfo_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1873} {:print "Call \"FloppyStartDevice\" \"FlFdcDeviceIo\""}  true;
  assume disketteExtension_4 > 0;
  call ntStatus_6 := FlFdcDeviceIo( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_4)], 461835, fdcInfo_1);   goto L43;
L131:
  call {:cexpr "fdcInfo.AcpiBios"} boogie_si_record_li2bpl_int(Mem_T.AcpiBios__FDC_INFO[AcpiBios__FDC_INFO(fdcInfo_1)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1881} {:print "Atomic Conditional"}  true;
    if(*) { assume fdcInfo_1 > 0;
  assume (Mem_T.AcpiBios__FDC_INFO[AcpiBios__FDC_INFO(fdcInfo_1)] != 0);  goto L48; } else { assume fdcInfo_1 > 0;
  assume (Mem_T.AcpiBios__FDC_INFO[AcpiBios__FDC_INFO(fdcInfo_1)] == 0);  goto L89; }
L132:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L54;
L133:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1931} {:print "Atomic Assignment"}  true;
    assume disketteExtension_4 > 0;
    call boogieTmp := corral_nondet(); Mem_T.DriveOnValue__DISKETTE_EXTENSION[DriveOnValue__DISKETTE_EXTENSION(disketteExtension_4)] := boogieTmp;  goto L134;
L134:
  call {:cexpr "&MOUNTDEV_MOUNTED_DEVICE_GUID"} boogie_si_record_li2bpl_int(MOUNTDEV_MOUNTED_DEVICE_GUID);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1935} {:print "Atomic Assignment"}  true;
      Tmp_50 := MOUNTDEV_MOUNTED_DEVICE_GUID;  goto L135;
L135:
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(InterfaceString__DISKETTE_EXTENSION(disketteExtension_4));
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1934} {:print "Call \"FloppyStartDevice\" \"IoRegisterDeviceInterface\""}  true;
  assume disketteExtension_4 > 0;
  call pnpStatus := IoRegisterDeviceInterface( 0, 0, 0, InterfaceString__DISKETTE_EXTENSION(disketteExtension_4));   goto L63;
L136:
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(FloppyInterfaceString__DISKETTE_EXTENSION(disketteExtension_4));
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1948} {:print "Call \"FloppyStartDevice\" \"IoRegisterDeviceInterface\""}  true;
  assume disketteExtension_4 > 0;
  call pnpStatus := IoRegisterDeviceInterface( 0, 0, 0, FloppyInterfaceString__DISKETTE_EXTENSION(disketteExtension_4));   goto L74;
L137:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1963} {:print "Call \"FloppyStartDevice\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L82;
L138:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1965} {:print "Call \"FloppyStartDevice\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L86;
L139:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L44; }
L140:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1972} {:print "Call \"FloppyStartDevice\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L104;
L141:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1974} {:print "Return"}  true;
    goto LM2;
L142:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L90;
L143:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L92;
L144:
  call {:cexpr "arg7"} boogie_si_record_li2bpl_int(209);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1909} {:print "Call \"FloppyStartDevice\" \"IoQueryDeviceDescription\""}  true;
  call ntStatus_6 := IoQueryDeviceDescription( 0, 0, 0, 0, 0, 0, 209, 0);   goto L98;
L145:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L92;
Lfinal: return;
}
procedure {:origName "FloppyPnpComplete"} FloppyPnpComplete(actual_DeviceObject_5:int, actual_Irp_5:int, actual_Context:int) returns (Tmp_51:int) {
var  sdv_43: int;
var  Tmp_52: int;
var  DeviceObject_5: int;
var  Irp_5: int;
var  Context: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_5 := actual_DeviceObject_5;
  Irp_5 := actual_Irp_5;
  Context := actual_Context;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Context);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1991} {:print "Call \"FloppyPnpComplete\" \"KeSetEvent\""}  true;
  call sdv_43 := KeSetEvent( Context, 1, 0);   goto L6;
L6:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1995} {:print "Atomic Assignment"}  true;
      Tmp_51 := -1073741802;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1995} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "InitializeListHead"} InitializeListHead(actual_ListHead:int) {
var  Tmp_53: int;
var  Tmp_54: int;
var  ListHead: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  ListHead := actual_ListHead;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "ListHead"} boogie_si_record_li2bpl_int(ListHead);
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 9955} {:print "Atomic Assignment"}  true;
    assume ListHead > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(ListHead)] := ListHead;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
  call {:cexpr "ListHead->Blink"} boogie_si_record_li2bpl_int(Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(ListHead)]);
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 9955} {:print "Atomic Assignment"}  true;
    assume ListHead > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(ListHead)] := Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(ListHead)];  goto L10;
L10:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\wdm.h"} {:sourceline 9957} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "FloppyCreateClose"} FloppyCreateClose(actual_DeviceObject_6:int, actual_Irp_6:int) returns (Tmp_55:int) {
var  Tmp_56: int;
var  sdv_44: int;
var  DeviceObject_6: int;
var  Irp_6: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_6 := actual_DeviceObject_6;
  Irp_6 := actual_Irp_6;
  // done with preamble
  goto L18;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1014} {:print "Call \"FloppyCreateClose\" \"KeRaiseIrqlToDpcLevel\""}  true;
  call sdv_44 := KeRaiseIrqlToDpcLevel();   goto L6;
L6:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1025} {:print "Atomic Assignment"}  true;
    assume Irp_6 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_6))] := 0;  goto L20;
L9:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1036} {:print "Call \"FloppyCreateClose\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L15;
L12:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1031} {:print "Call \"FloppyCreateClose\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L9;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1039} {:print "Atomic Assignment"}  true;
      Tmp_55 := 0;  goto L22;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1026} {:print "Atomic Assignment"}  true;
    assume Irp_6 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_6))] := 1;  goto L21;
L21:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1030} {:print "Atomic Conditional"}  true;
    if(*) { assume (Irp_6 == 0);  goto L9; } else { assume (Irp_6 != 0);  goto L12; }
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1039} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "FloppyUnload"} FloppyUnload(actual_DriverObject_2:int) {
var  foo: int;
var  Tmp_57: int;
var  Tmp_58: int;
var  DriverObject_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DriverObject_2 := actual_DriverObject_2;
  // done with preamble
  goto L16;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 293} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "PagingMutex"} boogie_si_record_li2bpl_int(PagingMutex);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 275} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingMutex != 0);  goto L5; } else { assume (PagingMutex == 0);  goto L9; }
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 276} {:print "Call \"FloppyUnload\" \"sdv_ExFreePool\""}  true;
  call sdv_ExFreePool( 0);   goto L8;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 277} {:print "Atomic Assignment"}  true;
      PagingMutex := 0;  goto L18;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 285} {:print "Atomic Assignment"}  true;
      foo := 0;  goto L19;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L9;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 286} {:print "Call \"FloppyUnload\" \"sdv_ExFreePool\""}  true;
  call sdv_ExFreePool( 0);   goto L1;
Lfinal: return;
}
procedure {:origName "FloppyPnp"} FloppyPnp(actual_DeviceObject_7:int, actual_Irp_7:int) returns (Tmp_59:int) {
var  sdv_45: int;
var  sdv_46: int;
var  sdv_47: int;
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
var  ntStatus_7: int;
var  sdv_58: int;
var  sdv_59: int;
var  sdv_60: int;
var  sdv_61: int;
var  p: int;
var  irpSp_3: int;
var  disketteExtension_5: int;
var  event: int;
var  Tmp_60: int;
var  oldIrql_1: int;
var  sdv_62: int;
var  doneEvent_2: int;
var  sdv_63: int;
var  sdv_64: int;
var  DeviceObject_7: int;
var  Irp_7: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call p := __HAVOC_malloc(8);
  call event := __HAVOC_malloc(108);
  call doneEvent_2 := __HAVOC_malloc(108);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_7 := actual_DeviceObject_7;
  Irp_7 := actual_Irp_7;
  // done with preamble
  goto L302;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1814} {:print "Return"}  true;
    goto LM2;
L6:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1463} {:print "Atomic Assignment"}  true;
      ntStatus_7 := 0;  goto L304;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1477} {:print "Call \"FloppyPnp\" \"sdv_KeGetCurrentIrql\""}  true;
  call sdv_54 := sdv_KeGetCurrentIrql();   goto L17;
L17:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_54);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1477} {:print "Call \"FloppyPnp\" \"IoReleaseCancelSpinLock\""}  true;
  call IoReleaseCancelSpinLock( sdv_54);   goto L20;
L20:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1482} {:print "Call \"FloppyPnp\" \"ExAcquireResourceSharedLite\""}  true;
  call sdv_51 := ExAcquireResourceSharedLite( 0, 0);   goto L23;
L23:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(event);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1486} {:print "Call \"FloppyPnp\" \"KeInitializeEvent\""}  true;
  call KeInitializeEvent( event, 0, 0);   goto L26;
L26:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1495} {:print "Call \"FloppyPnp\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L29;
L29:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1495} {:print "Atomic Assignment"}  true;
      PagingReferenceCount := (PagingReferenceCount + 1);  goto L306;
L30:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1495} {:print "Call \"FloppyPnp\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L36;
L33:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1495} {:print "Call \"FloppyPnp\" \"MmResetDriverPaging\""}  true;
  call MmResetDriverPaging( 0);   goto L30;
L36:
  call {:cexpr "DeviceObject->DeviceExtension"} boogie_si_record_li2bpl_int(Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_7)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1498} {:print "Atomic Assignment"}  true;
    assume DeviceObject_7 > 0;
    disketteExtension_5 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_7)];  goto L307;
L41:
  call {:cexpr "disketteExtension->IsRemoved"} boogie_si_record_li2bpl_int(Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_5)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1502} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_5 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_5)] == 0);  goto L42; } else { assume disketteExtension_5 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_5)] != 0);  goto L43; }
L42:
  call {:cexpr "irpSp->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1514} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] == 0);  goto L52; } else { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] != 0);  goto L265; }
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1508} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := 0;  goto L308;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1511} {:print "Atomic Assignment"}  true;
      Tmp_59 := -1073741738;  goto L310;
L49:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1804} {:print "Call \"FloppyPnp\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp_7);   goto L253;
L52:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(DeviceObject_7);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1518} {:print "Call \"FloppyPnp\" \"FloppyStartDevice\""}  true;
  call ntStatus_7 := FloppyStartDevice( DeviceObject_7, Irp_7);   goto L311;
L56:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(disketteExtension_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1716} {:print "Call \"FloppyPnp\" \"FlTerminateFloppyThread\""}  true;
  call FlTerminateFloppyThread( disketteExtension_5);   goto L133;
L60:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1693} {:print "Atomic Assignment"}  true;
    assume disketteExtension_5 > 0;
    Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_5)] := 0;  goto L336;
L61:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1798} {:print "Atomic Assignment"}  true;
      ntStatus_7 := -1073741637;  goto L340;
L63:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1811} {:print "Call \"FloppyPnp\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L66;
L66:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1811} {:print "Atomic Assignment"}  true;
      PagingReferenceCount := (PagingReferenceCount - 1);  goto L312;
L67:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1811} {:print "Call \"FloppyPnp\" \"MmPageEntireDriver\""}  true;
  call sdv_46 := MmPageEntireDriver( 0);   goto L70;
L70:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1811} {:print "Call \"FloppyPnp\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L73;
L73:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1813} {:print "Atomic Assignment"}  true;
      Tmp_59 := ntStatus_7;  goto L313;
L79:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_60 := __HAVOC_malloc(4);  goto L280;
L82:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_7);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
   assume alias5(SLAM_guard_S_0, Irp_7);
    if(*) { assume (!((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L296; } else { assume ((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L297; }
L87:
  call {:cexpr "disketteExtension->IsStarted"} boogie_si_record_li2bpl_int(Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_5)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1612} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_5 > 0;
  assume (Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_5)] == 0);  goto L88; } else { assume disketteExtension_5 > 0;
  assume (Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_5)] != 0);  goto L90; }
L88:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1620} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := 0;  goto L335;
L90:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1631} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := 0;  goto L329;
L94:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(doneEvent_2);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1642} {:print "Call \"FloppyPnp\" \"KeInitializeEvent\""}  true;
  call KeInitializeEvent( doneEvent_2, 1, 0);   goto L97;
L97:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(213);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(doneEvent_2);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1646} {:print "Call \"FloppyPnp\" \"sdv_IoSetCompletionRoutine\""}  true;
  call sdv_IoSetCompletionRoutine( Irp_7, 213, doneEvent_2, 1, 1, 1);   goto L100;
L100:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1655} {:print "Atomic Conditional"}  true;
    if(*) { assume (1000 >= Irp_7);  goto L101; } else { assume (1000 < Irp_7);  goto L102; }
L101:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1659} {:print "Atomic Conditional"}  true;
    if(*) { assume (ntStatus_7 != 259);  goto L106; } else { assume (ntStatus_7 == 259);  goto L109; }
L102:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_7);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L290; } else { assume ((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L291; }
L106:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1670} {:print "Call \"FloppyPnp\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L113;
L109:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg5"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1661} {:print "Call \"FloppyPnp\" \"KeWaitForSingleObject\""}  true;
  call sdv_63 := KeWaitForSingleObject( 0, 0, 0, 0, 0);   goto L112;
L112:
  call {:cexpr "Irp->IoStatus.Status"} boogie_si_record_li2bpl_int(Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1667} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    ntStatus_7 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))];  goto L330;
L113:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1671} {:print "Atomic Assignment"}  true;
    assume disketteExtension_5 > 0;
    Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_5)] := 0;  goto L331;
L117:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(disketteExtension_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1677} {:print "Call \"FloppyPnp\" \"FloppyProcessQueuedRequests\""}  true;
  call FloppyProcessQueuedRequests( disketteExtension_5);   goto L332;
L120:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1683} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := ntStatus_7;  goto L333;
L129:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_7);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L293; } else { assume ((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L294; }
L133:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1723} {:print "Call \"FloppyPnp\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L136;
L136:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1724} {:print "Atomic Assignment"}  true;
    assume disketteExtension_5 > 0;
    Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_5)] := 0;  goto L323;
L140:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1727} {:print "Atomic Assignment"}  true;
    assume disketteExtension_5 > 0;
    Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_5)] := 0;  goto L324;
L145:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1743} {:print "Call \"FloppyPnp\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp_7);   goto L148;
L148:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1744} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := 0;  goto L327;
L153:
  call {:cexpr "disketteExtension->InterfaceString.Buffer"} boogie_si_record_li2bpl_int(Mem_T.Buffer__STRING[Buffer__STRING(InterfaceString__DISKETTE_EXTENSION(disketteExtension_5))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1751} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_5 > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(InterfaceString__DISKETTE_EXTENSION(disketteExtension_5))] == 0);  goto L154; } else { assume disketteExtension_5 > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(InterfaceString__DISKETTE_EXTENSION(disketteExtension_5))] != 0);  goto L155; }
L154:
  call {:cexpr "disketteExtension->FloppyInterfaceString.Buffer"} boogie_si_record_li2bpl_int(Mem_T.Buffer__STRING[Buffer__STRING(FloppyInterfaceString__DISKETTE_EXTENSION(disketteExtension_5))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1760} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_5 > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(FloppyInterfaceString__DISKETTE_EXTENSION(disketteExtension_5))] == 0);  goto L164; } else { assume disketteExtension_5 > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(FloppyInterfaceString__DISKETTE_EXTENSION(disketteExtension_5))] != 0);  goto L167; }
L155:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1753} {:print "Call \"FloppyPnp\" \"IoSetDeviceInterfaceState\""}  true;
  call sdv_59 := IoSetDeviceInterfaceState( 0, 0);   goto L158;
L158:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1756} {:print "Call \"FloppyPnp\" \"RtlFreeUnicodeString\""}  true;
  call RtlFreeUnicodeString( 0);   goto L161;
L161:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(InterfaceString__DISKETTE_EXTENSION(disketteExtension_5));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1757} {:print "Call \"FloppyPnp\" \"RtlInitUnicodeString\""}  true;
  assume disketteExtension_5 > 0;
  call RtlInitUnicodeString( InterfaceString__DISKETTE_EXTENSION(disketteExtension_5), 0);   goto L154;
L164:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1769} {:print "Call \"FloppyPnp\" \"RtlFreeUnicodeString\""}  true;
  call RtlFreeUnicodeString( 0);   goto L176;
L167:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1762} {:print "Call \"FloppyPnp\" \"IoSetDeviceInterfaceState\""}  true;
  call sdv_58 := IoSetDeviceInterfaceState( 0, 0);   goto L170;
L170:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1765} {:print "Call \"FloppyPnp\" \"RtlFreeUnicodeString\""}  true;
  call RtlFreeUnicodeString( 0);   goto L173;
L173:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(FloppyInterfaceString__DISKETTE_EXTENSION(disketteExtension_5));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1766} {:print "Call \"FloppyPnp\" \"RtlInitUnicodeString\""}  true;
  assume disketteExtension_5 > 0;
  call RtlInitUnicodeString( FloppyInterfaceString__DISKETTE_EXTENSION(disketteExtension_5), 0);   goto L164;
L176:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(DeviceName__DISKETTE_EXTENSION(disketteExtension_5));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1770} {:print "Call \"FloppyPnp\" \"RtlInitUnicodeString\""}  true;
  assume disketteExtension_5 > 0;
  call RtlInitUnicodeString( DeviceName__DISKETTE_EXTENSION(disketteExtension_5), 0);   goto L179;
L179:
  call {:cexpr "disketteExtension->ArcName.Length"} boogie_si_record_li2bpl_int(Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(ArcName__DISKETTE_EXTENSION(disketteExtension_5))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1772} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_5 > 0;
  assume (Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(ArcName__DISKETTE_EXTENSION(disketteExtension_5))] == 0);  goto L180; } else { assume disketteExtension_5 > 0;
  assume (Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(ArcName__DISKETTE_EXTENSION(disketteExtension_5))] != 0);  goto L183; }
L180:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1789} {:print "Call \"FloppyPnp\" \"IoDeleteDevice\""}  true;
  call IoDeleteDevice( 0);   goto L192;
L183:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1774} {:print "Call \"FloppyPnp\" \"sdv_IoDeassignArcName\""}  true;
  call sdv_IoDeassignArcName( 0);   goto L186;
L186:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1775} {:print "Call \"FloppyPnp\" \"RtlFreeUnicodeString\""}  true;
  call RtlFreeUnicodeString( 0);   goto L189;
L189:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(ArcName__DISKETTE_EXTENSION(disketteExtension_5));
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1776} {:print "Call \"FloppyPnp\" \"RtlInitUnicodeString\""}  true;
  assume disketteExtension_5 > 0;
  call RtlInitUnicodeString( ArcName__DISKETTE_EXTENSION(disketteExtension_5), 0);   goto L180;
L192:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1791} {:print "Call \"FloppyPnp\" \"IoGetConfigurationInformation\""}  true;
  call sdv_57 := IoGetConfigurationInformation();   goto L195;
L195:
  call {:cexpr "sdv->FloppyCount"} boogie_si_record_li2bpl_int(Mem_T.FloppyCount__CONFIGURATION_INFORMATION[FloppyCount__CONFIGURATION_INFORMATION(sdv_57)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1791} {:print "Atomic Assignment"}  true;
    assume sdv_57 > 0;
    Mem_T.FloppyCount__CONFIGURATION_INFORMATION[FloppyCount__CONFIGURATION_INFORMATION(sdv_57)] := (Mem_T.FloppyCount__CONFIGURATION_INFORMATION[FloppyCount__CONFIGURATION_INFORMATION(sdv_57)] - 1);  goto L328;
L197:
  call {:cexpr "disketteExtension->IsStarted"} boogie_si_record_li2bpl_int(Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_5)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1537} {:print "Atomic Conditional"}  true;
    if(*) { assume disketteExtension_5 > 0;
  assume (Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_5)] == 0);  goto L198; } else { assume disketteExtension_5 > 0;
  assume (Mem_T.IsStarted__DISKETTE_EXTENSION[IsStarted__DISKETTE_EXTENSION(disketteExtension_5)] != 0);  goto L199; }
L198:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1541} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := 0;  goto L321;
L199:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1558} {:print "Call \"FloppyPnp\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L202;
L202:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1559} {:print "Atomic Assignment"}  true;
    assume disketteExtension_5 > 0;
    Mem_T.HoldNewRequests__DISKETTE_EXTENSION[HoldNewRequests__DISKETTE_EXTENSION(disketteExtension_5)] := 1;  goto L314;
L207:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1568} {:print "Call \"FloppyPnp\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L210;
L210:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1574} {:print "Atomic Conditional"}  true;
    if(*) { assume (ntStatus_7 != 259);  goto L211; } else { assume (ntStatus_7 == 259);  goto L212; }
L211:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1590} {:print "Atomic Assignment"}  true;
      ntStatus_7 := -1073741823;  goto L317;
L212:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(disketteExtension_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1578} {:print "Call \"FloppyPnp\" \"FlTerminateFloppyThread\""}  true;
  call FlTerminateFloppyThread( disketteExtension_5);   goto L215;
L215:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1580} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := 0;  goto L315;
L219:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_7);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L281; } else { assume ((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L282; }
L222:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1583} {:print "Atomic Assignment"}  true;
      ntStatus_7 := 259;  goto L316;
L233:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1547} {:print "Call \"FloppyPnp\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp_7);   goto L236;
L236:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_7);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L284; } else { assume ((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L285; }
L240:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1550} {:print "Call \"FloppyPnp\" \"PsTerminateSystemThread\""}  true;
  call sdv_49 := PsTerminateSystemThread( 0);   goto L243;
L243:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1552} {:print "Atomic Assignment"}  true;
      Tmp_59 := ntStatus_7;  goto L322;
L245:
  call {:cexpr "disketteExtension"} boogie_si_record_li2bpl_int(disketteExtension_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1521} {:print "Atomic Conditional"}  true;
    if(*) { assume (disketteExtension_5 >= 300);  goto L63; } else { assume (disketteExtension_5 < 300);  goto L247; }
L247:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1522} {:print "Call \"FloppyPnp\" \"IoDetachDevice\""}  true;
  call IoDetachDevice( 0);   goto L250;
L250:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1523} {:print "Call \"FloppyPnp\" \"PsTerminateSystemThread\""}  true;
  call sdv_48 := PsTerminateSystemThread( 0);   goto L63;
L253:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_7);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L299; } else { assume ((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L300; }
L258:
  call {:cexpr "irpSp->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] != 23);  goto L49; } else { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] == 23);  goto L56; }
L259:
  call {:cexpr "irpSp->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] == 7);  goto L61; } else { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] != 7);  goto L258; }
L260:
  call {:cexpr "irpSp->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] == 6);  goto L87; } else { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] != 6);  goto L259; }
L261:
  call {:cexpr "irpSp->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] == 5);  goto L197; } else { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] != 5);  goto L260; }
L262:
  call {:cexpr "irpSp->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] == 4);  goto L60; } else { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] != 4);  goto L261; }
L263:
  call {:cexpr "irpSp->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] == 3);  goto L87; } else { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] != 3);  goto L262; }
L264:
  call {:cexpr "irpSp->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] == 2);  goto L56; } else { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] != 2);  goto L263; }
L265:
  call {:cexpr "irpSp->MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] == 1);  goto L197; } else { assume irpSp_3 > 0;
  assume (Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_3)] != 1);  goto L264; }
L279:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_60]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_60 > 0;
    oldIrql_1 := Mem_T.INT4[Tmp_60];  goto L339;
L280:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql_1);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_60 > 0;
    Mem_T.INT4[Tmp_60] := oldIrql_1;  goto L338;
L281:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1582} {:print "Call \"FloppyPnp\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_5 > 0;
  call sdv_53 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)], Irp_7);   goto L222;
L282:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1582} {:print "Call \"FloppyPnp\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L281;
L284:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1549} {:print "Call \"FloppyPnp\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_5 > 0;
  call ntStatus_7 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)], Irp_7);   goto L240;
L285:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1549} {:print "Call \"FloppyPnp\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L284;
L287:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1745} {:print "Call \"FloppyPnp\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_5 > 0;
  call ntStatus_7 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)], Irp_7);   goto L153;
L288:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1745} {:print "Call \"FloppyPnp\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L287;
L290:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1657} {:print "Call \"FloppyPnp\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_5 > 0;
  call ntStatus_7 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)], Irp_7);   goto L101;
L291:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1657} {:print "Call \"FloppyPnp\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L290;
L293:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1622} {:print "Call \"FloppyPnp\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_5 > 0;
  call ntStatus_7 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)], Irp_7);   goto L63;
L294:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1622} {:print "Call \"FloppyPnp\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L293;
L296:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1705} {:print "Call \"FloppyPnp\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_5 > 0;
  call ntStatus_7 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)], Irp_7);   goto L63;
L297:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1705} {:print "Call \"FloppyPnp\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L296;
L299:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1805} {:print "Call \"FloppyPnp\" \"sdv_IoCallDriver\""}  true;
  assume disketteExtension_5 > 0;
  call ntStatus_7 := sdv_IoCallDriver( Mem_T.TargetObject__DISKETTE_EXTENSION[TargetObject__DISKETTE_EXTENSION(disketteExtension_5)], Irp_7);   goto L63;
L300:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1805} {:print "Call \"FloppyPnp\" \"SLIC_sdv_IoCallDriver_entry\""}  true;
  call SLIC_sdv_IoCallDriver_entry( 0);   goto L299;
L302:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L304:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1470} {:print "Atomic Assignment"}  true;
    assume p > 0;
    Mem_T.SystemState__POWER_STATE[SystemState__POWER_STATE(p)] := 0;  goto L305;
L305:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(p);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1471} {:print "Call \"FloppyPnp\" \"PoRequestPowerIrp\""}  true;
  call sdv_55 := PoRequestPowerIrp( 0, 0, p, 0, 0, 0);   goto L14;
L306:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1495} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingReferenceCount != 1);  goto L30; } else { assume (PagingReferenceCount == 1);  goto L33; }
L307:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1500} {:print "Call \"FloppyPnp\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call irpSp_3 := sdv_IoGetCurrentIrpStackLocation( Irp_7);   goto L41;
L308:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1509} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := -1073741738;  goto L309;
L309:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1510} {:print "Call \"FloppyPnp\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L48;
L310:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L311:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L245; }
L312:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1811} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingReferenceCount == 0);  goto L67; } else { assume (PagingReferenceCount != 0);  goto L70; }
L313:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L314:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(disketteExtension_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1566} {:print "Call \"FloppyPnp\" \"FlQueueIrpToThread\""}  true;
  call ntStatus_7 := FlQueueIrpToThread( Irp_7, disketteExtension_5);   goto L207;
L315:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1581} {:print "Call \"FloppyPnp\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp_7);   goto L219;
L316:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L63;
L317:
  call {:cexpr "ntStatus"} boogie_si_record_li2bpl_int(ntStatus_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1591} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := ntStatus_7;  goto L318;
L318:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1592} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := 0;  goto L319;
L319:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1595} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(Irp_7)] := 1;  goto L320;
L320:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1599} {:print "Call \"FloppyPnp\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L63;
L321:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1542} {:print "Call \"FloppyPnp\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp_7);   goto L233;
L322:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L323:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1725} {:print "Call \"FloppyPnp\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L140;
L324:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1728} {:print "Atomic Assignment"}  true;
    assume disketteExtension_5 > 0;
    Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(disketteExtension_5)] := 1;  goto L325;
L325:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(disketteExtension_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1738} {:print "Call \"FloppyPnp\" \"FloppyProcessQueuedRequests\""}  true;
  call FloppyProcessQueuedRequests( disketteExtension_5);   goto L326;
L326:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L145; }
L327:
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_7);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L287; } else { assume ((Irp_7 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L288; }
L328:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L63;
L329:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1636} {:print "Call \"FloppyPnp\" \"sdv_IoCopyCurrentIrpStackLocationToNext\""}  true;
  call sdv_IoCopyCurrentIrpStackLocationToNext( Irp_7);   goto L94;
L330:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L106;
L331:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1672} {:print "Call \"FloppyPnp\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L117;
L332:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L120; }
L333:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1684} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := 0;  goto L334;
L334:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1685} {:print "Call \"FloppyPnp\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L63;
L335:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1621} {:print "Call \"FloppyPnp\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp_7);   goto L129;
L336:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1695} {:print "Atomic Assignment"}  true;
    assume Irp_7 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_7))] := 0;  goto L337;
L337:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1696} {:print "Call \"FloppyPnp\" \"sdv_IoSkipCurrentIrpStackLocation\""}  true;
  call sdv_IoSkipCurrentIrpStackLocation( Irp_7);   goto L79;
L338:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(2);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_60);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 1701} {:print "Call \"FloppyPnp\" \"sdv_KeRaiseIrql\""}  true;
  call sdv_KeRaiseIrql( 2, Tmp_60);   goto L279;
L339:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L82;
L340:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L63;
Lfinal: return;
}
procedure {:origName "FlQueueIrpToThread"} FlQueueIrpToThread(actual_Irp_8:int, actual_DisketteExtension_3:int) returns (Tmp_61:int) {
var  sdv_65: int;
var  sdv_66: int;
var  sdv_67: int;
var  sdv_68: int;
var  sdv_69: int;
var  sdv_70: int;
var  sdv_71: int;
var  Tmp_62: int;
var  ObjAttributes: int;
var  status: int;
var  threadHandle: int;
var  irpSp_4: int;
var  sdv_72: int;
var  Irp_8: int;
var  DisketteExtension_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call ObjAttributes := __HAVOC_malloc(24);
  // initialize local variables to 0
  // copy formal-ins to locals
  Irp_8 := actual_Irp_8;
  DisketteExtension_3 := actual_DisketteExtension_3;
  // done with preamble
  goto L107;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 981} {:print "Return"}  true;
    goto LM2;
L7:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 885} {:print "Call \"FlQueueIrpToThread\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call irpSp_4 := sdv_IoGetCurrentIrpStackLocation( Irp_8);   goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 892} {:print "Call \"FlQueueIrpToThread\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L14;
L14:
  call {:cexpr "DisketteExtension->PoweringDown"} boogie_si_record_li2bpl_int(Mem_T.PoweringDown__DISKETTE_EXTENSION[PoweringDown__DISKETTE_EXTENSION(DisketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 893} {:print "Atomic Conditional"}  true;
    if(*) { assume DisketteExtension_3 > 0;
  assume (Mem_T.PoweringDown__DISKETTE_EXTENSION[PoweringDown__DISKETTE_EXTENSION(DisketteExtension_3)] != 1);  goto L15; } else { assume DisketteExtension_3 > 0;
  assume (Mem_T.PoweringDown__DISKETTE_EXTENSION[PoweringDown__DISKETTE_EXTENSION(DisketteExtension_3)] == 1);  goto L18; }
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 902} {:print "Call \"FlQueueIrpToThread\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L24;
L18:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 894} {:print "Call \"FlQueueIrpToThread\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L21;
L21:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 898} {:print "Atomic Assignment"}  true;
    assume Irp_8 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_8))] := -1073741101;  goto L109;
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 905} {:print "Call \"FlQueueIrpToThread\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L27;
L27:
  call {:cexpr "DisketteExtension->ThreadReferenceCount"} boogie_si_record_li2bpl_int(Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 907} {:print "Atomic Assignment"}  true;
    assume DisketteExtension_3 > 0;
    Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)] := (Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)] + 1);  goto L112;
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 964} {:print "Call \"FlQueueIrpToThread\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L32;
L32:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 967} {:print "Call \"FlQueueIrpToThread\" \"sdv_IoMarkIrpPending\""}  true;
  call sdv_IoMarkIrpPending( 0);   goto L35;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 969} {:print "Call \"FlQueueIrpToThread\" \"sdv_ExInterlockedInsertTailList\""}  true;
  call sdv_70 := sdv_ExInterlockedInsertTailList( 0, 0, 0);   goto L38;
L38:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(1);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 974} {:print "Call \"FlQueueIrpToThread\" \"KeReleaseSemaphore\""}  true;
  call sdv_69 := KeReleaseSemaphore( 0, 0, 1, 0);   goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 980} {:print "Atomic Assignment"}  true;
      Tmp_61 := 259;  goto L113;
L42:
  call {:cexpr "DisketteExtension->ThreadReferenceCount"} boogie_si_record_li2bpl_int(Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 910} {:print "Atomic Assignment"}  true;
    assume DisketteExtension_3 > 0;
    Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)] := (Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)] + 1);  goto L114;
L46:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 912} {:print "Atomic Assignment"}  true;
      PagingReferenceCount := (PagingReferenceCount + 1);  goto L115;
L47:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 912} {:print "Call \"FlQueueIrpToThread\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L53;
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 912} {:print "Call \"FlQueueIrpToThread\" \"MmResetDriverPaging\""}  true;
  call MmResetDriverPaging( 0);   goto L47;
L53:
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(512);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 918} {:print "Call \"FlQueueIrpToThread\" \"sdv_InitializeObjectAttributes\""}  true;
  call sdv_InitializeObjectAttributes( 0, 0, 512, 0, 0);   goto L56;
L56:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  call {:cexpr "arg6"} boogie_si_record_li2bpl_int(212);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 923} {:print "Call \"FlQueueIrpToThread\" \"PsCreateSystemThread\""}  true;
  call status := PsCreateSystemThread( 0, 0, 0, 0, 0, 212, 0);   goto L60;
L60:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 931} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > status);  goto L61; } else { assume (0 <= status);  goto L62; }
L61:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 932} {:print "Atomic Assignment"}  true;
    assume DisketteExtension_3 > 0;
    Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)] := -1;  goto L120;
L62:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(1048576);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 940} {:print "Call \"FlQueueIrpToThread\" \"ObReferenceObjectByHandle\""}  true;
  call status := ObReferenceObjectByHandle( 0, 1048576, 0, 0, 0, 0);   goto L66;
L66:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 947} {:print "Call \"FlQueueIrpToThread\" \"ZwClose\""}  true;
  call sdv_66 := ZwClose( 0);   goto L69;
L69:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 949} {:print "Atomic Conditional"}  true;
    if(*) { assume (0 > status);  goto L70; } else { assume (0 <= status);  goto L71; }
L70:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 950} {:print "Atomic Assignment"}  true;
    assume DisketteExtension_3 > 0;
    Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)] := -1;  goto L116;
L71:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 961} {:print "Call \"FlQueueIrpToThread\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L32;
L78:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 954} {:print "Atomic Assignment"}  true;
      PagingReferenceCount := (PagingReferenceCount - 1);  goto L118;
L79:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 954} {:print "Call \"FlQueueIrpToThread\" \"MmPageEntireDriver\""}  true;
  call sdv_65 := MmPageEntireDriver( 0);   goto L82;
L82:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 954} {:print "Call \"FlQueueIrpToThread\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L85;
L85:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 956} {:print "Call \"FlQueueIrpToThread\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L88;
L88:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 958} {:print "Atomic Assignment"}  true;
      Tmp_61 := status;  goto L119;
L92:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 934} {:print "Atomic Assignment"}  true;
      PagingReferenceCount := (PagingReferenceCount - 1);  goto L121;
L93:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 934} {:print "Call \"FlQueueIrpToThread\" \"MmPageEntireDriver\""}  true;
  call sdv_72 := MmPageEntireDriver( 0);   goto L96;
L96:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 934} {:print "Call \"FlQueueIrpToThread\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L99;
L99:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 936} {:print "Call \"FlQueueIrpToThread\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L102;
L102:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 937} {:print "Atomic Assignment"}  true;
      Tmp_61 := status;  goto L122;
L107:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L109:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 899} {:print "Atomic Assignment"}  true;
    assume Irp_8 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_8))] := 0;  goto L110;
L110:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 900} {:print "Atomic Assignment"}  true;
      Tmp_61 := -1073741101;  goto L111;
L111:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L112:
  call {:cexpr "DisketteExtension->ThreadReferenceCount"} boogie_si_record_li2bpl_int(Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 907} {:print "Atomic Conditional"}  true;
    if(*) { assume DisketteExtension_3 > 0;
  assume (Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)] != 0);  goto L29; } else { assume DisketteExtension_3 > 0;
  assume (Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION[ThreadReferenceCount__DISKETTE_EXTENSION(DisketteExtension_3)] == 0);  goto L42; }
L113:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L114:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 912} {:print "Call \"FlQueueIrpToThread\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L46;
L115:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 912} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingReferenceCount != 1);  goto L47; } else { assume (PagingReferenceCount == 1);  goto L50; }
L116:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 952} {:print "Atomic Assignment"}  true;
    assume DisketteExtension_3 > 0;
    Mem_T.FloppyThread__DISKETTE_EXTENSION[FloppyThread__DISKETTE_EXTENSION(DisketteExtension_3)] := 0;  goto L117;
L117:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 954} {:print "Call \"FlQueueIrpToThread\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L78;
L118:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 954} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingReferenceCount == 0);  goto L79; } else { assume (PagingReferenceCount != 0);  goto L82; }
L119:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L120:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 934} {:print "Call \"FlQueueIrpToThread\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L92;
L121:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 934} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingReferenceCount == 0);  goto L93; } else { assume (PagingReferenceCount != 0);  goto L96; }
L122:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "FloppyProcessQueuedRequests"} FloppyProcessQueuedRequests(actual_DisketteExtension_4:int) {
var  sdv_73: int;
var  sdv_74: int;
var  sdv_75: int;
var  sdv_76: int;
var  sdv_77: int;
var  sdv_78: int;
var  sdv_79: int;
var  irpSp_5: int;
var  Tmp_63: int;
var  oldIrql_2: int;
var  headOfList: int;
var  currentIrp: int;
var  Tmp_64: int;
var  DisketteExtension_4: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DisketteExtension_4 := actual_DisketteExtension_4;
  // done with preamble
  goto L91;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 6016} {:print "Return"}  true;
    goto LM2;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5933} {:print "Atomic Assignment"}  true;
      irpSp_5 := 0;  goto L93;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5944} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_ExInterlockedRemoveHeadList\""}  true;
  call headOfList := sdv_ExInterlockedRemoveHeadList( 0, 0);   goto L15;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5944} {:print "Atomic Continuation"}  true;
    if(*) {  goto L16; } else {  goto L19; }
L16:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(oldIrql_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 6012} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_KeReleaseSpinLock\""}  true;
  call sdv_KeReleaseSpinLock( 0, oldIrql_2);   goto L1;
L19:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(headOfList);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(88);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5948} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_containing_record\""}  true;
  call sdv_78 := sdv_containing_record( headOfList, 88);   goto L22;
L22:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_78);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5948} {:print "Atomic Assignment"}  true;
      currentIrp := sdv_78;  goto L96;
L26:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_77);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5952} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_77 == 0);  goto L27; } else { assume (sdv_77 != 0);  goto L28; }
L27:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5960} {:print "Atomic Assignment"}  true;
    assume currentIrp > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(ListEntry_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(currentIrp))))] := 0;  goto L106;
L28:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(currentIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5953} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_IoGetCurrentIrpStackLocation\""}  true;
  call irpSp_5 := sdv_IoGetCurrentIrpStackLocation( currentIrp);   goto L32;
L32:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(oldIrql_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5964} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_KeReleaseSpinLock\""}  true;
  call sdv_KeReleaseSpinLock( 0, oldIrql_2);   goto L35;
L35:
  call {:cexpr "currentIrp"} boogie_si_record_li2bpl_int(currentIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5967} {:print "Atomic Conditional"}  true;
    if(*) { assume (currentIrp == 0);  goto L36; } else { assume (currentIrp != 0);  goto L37; }
L36:
  call {:cexpr "currentIrp"} boogie_si_record_li2bpl_int(currentIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 6000} {:print "Atomic Conditional"}  true;
    if(*) { assume (currentIrp == 0);  goto L57; } else { assume (currentIrp != 0);  goto L60; }
L37:
  call {:cexpr "DisketteExtension->IsRemoved"} boogie_si_record_li2bpl_int(Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(DisketteExtension_4)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5968} {:print "Atomic Conditional"}  true;
    if(*) { assume DisketteExtension_4 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(DisketteExtension_4)] == 0);  goto L38; } else { assume DisketteExtension_4 > 0;
  assume (Mem_T.IsRemoved__DISKETTE_EXTENSION[IsRemoved__DISKETTE_EXTENSION(DisketteExtension_4)] != 0);  goto L39; }
L38:
  call {:cexpr "irpSp->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp_5)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5978} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_5 > 0;
  assume (Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp_5)] == 3);  goto L45; } else { assume irpSp_5 > 0;
  assume (Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp_5)] != 3);  goto L74; }
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5972} {:print "Atomic Assignment"}  true;
    assume currentIrp > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(currentIrp))] := 0;  goto L97;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5993} {:print "Atomic Assignment"}  true;
    assume currentIrp > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(currentIrp))] := 0;  goto L104;
L45:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.DeviceObject__DISKETTE_EXTENSION[DeviceObject__DISKETTE_EXTENSION(DisketteExtension_4)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(currentIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5983} {:print "Call \"FloppyProcessQueuedRequests\" \"FloppyReadWrite\""}  true;
  assume DisketteExtension_4 > 0;
  call sdv_75 := FloppyReadWrite( Mem_T.DeviceObject__DISKETTE_EXTENSION[DeviceObject__DISKETTE_EXTENSION(DisketteExtension_4)], currentIrp);   goto L85;
L48:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Mem_T.DeviceObject__DISKETTE_EXTENSION[DeviceObject__DISKETTE_EXTENSION(DisketteExtension_4)]);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(currentIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5988} {:print "Call \"FloppyProcessQueuedRequests\" \"FloppyDeviceControl\""}  true;
  assume DisketteExtension_4 > 0;
  call sdv_74 := FloppyDeviceControl( Mem_T.DeviceObject__DISKETTE_EXTENSION[DeviceObject__DISKETTE_EXTENSION(DisketteExtension_4)], currentIrp);   goto L88;
L57:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_64 := __HAVOC_malloc(4);  goto L84;
L60:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 6004} {:print "Call \"FloppyProcessQueuedRequests\" \"ExAcquireFastMutex\""}  true;
  call ExAcquireFastMutex( 0);   goto L63;
L63:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 6004} {:print "Atomic Assignment"}  true;
      PagingReferenceCount := (PagingReferenceCount - 1);  goto L99;
L64:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 6004} {:print "Call \"FloppyProcessQueuedRequests\" \"MmPageEntireDriver\""}  true;
  call sdv_73 := MmPageEntireDriver( 0);   goto L67;
L67:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 6004} {:print "Call \"FloppyProcessQueuedRequests\" \"ExReleaseFastMutex\""}  true;
  call ExReleaseFastMutex( 0);   goto L57;
L73:
  call {:cexpr "irpSp->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp_5)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_5 > 0;
  assume (Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp_5)] != 14);  goto L44; } else { assume irpSp_5 > 0;
  assume (Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp_5)] == 14);  goto L48; }
L74:
  call {:cexpr "irpSp->MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp_5)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume irpSp_5 > 0;
  assume (Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp_5)] == 4);  goto L45; } else { assume irpSp_5 > 0;
  assume (Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp_5)] != 4);  goto L73; }
L81:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_64]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_64 > 0;
    oldIrql_2 := Mem_T.INT4[Tmp_64];  goto L95;
L82:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql_2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_64 > 0;
    Mem_T.INT4[Tmp_64] := oldIrql_2;  goto L94;
L83:
  call {:cexpr "*Tmp"} boogie_si_record_li2bpl_int(Mem_T.INT4[Tmp_64]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_64 > 0;
    oldIrql_2 := Mem_T.INT4[Tmp_64];  goto L101;
L84:
  call {:cexpr "oldIrql"} boogie_si_record_li2bpl_int(oldIrql_2);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume Tmp_64 > 0;
    Mem_T.INT4[Tmp_64] := oldIrql_2;  goto L100;
L85:
  call {:cexpr "currentIrp"} boogie_si_record_li2bpl_int(currentIrp);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
   assume alias6(SLAM_guard_S_0, currentIrp);
    if(*) { assume (!((currentIrp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L36; } else { assume ((currentIrp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L86; }
L86:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5983} {:print "Call \"FloppyProcessQueuedRequests\" \"SLIC_FloppyReadWrite_exit\""}  true;
  call SLIC_FloppyReadWrite_exit( strConst__li2bpl3);   goto L102;
L88:
  call {:cexpr "currentIrp"} boogie_si_record_li2bpl_int(currentIrp);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((currentIrp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L36; } else { assume ((currentIrp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L89; }
L89:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5988} {:print "Call \"FloppyProcessQueuedRequests\" \"SLIC_FloppyDeviceControl_exit\""}  true;
  call SLIC_FloppyDeviceControl_exit( strConst__li2bpl3);   goto L103;
L91:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L93:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call Tmp_64 := __HAVOC_malloc(4);  goto L82;
L94:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_64);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5942} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_KeAcquireSpinLock\""}  true;
  call sdv_KeAcquireSpinLock( 0, Tmp_64);   goto L81;
L95:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L96:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(currentIrp);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5952} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_IoSetCancelRoutine\""}  true;
  call sdv_77 := sdv_IoSetCancelRoutine( currentIrp, 0);   goto L26;
L97:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5973} {:print "Atomic Assignment"}  true;
    assume currentIrp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(currentIrp))] := -1073741738;  goto L98;
L98:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5974} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L36;
L99:
  call {:cexpr "PagingReferenceCount"} boogie_si_record_li2bpl_int(PagingReferenceCount);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 6004} {:print "Atomic Conditional"}  true;
    if(*) { assume (PagingReferenceCount == 0);  goto L64; } else { assume (PagingReferenceCount != 0);  goto L67; }
L100:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Tmp_64);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 6007} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_KeAcquireSpinLock\""}  true;
  call sdv_KeAcquireSpinLock( 0, Tmp_64);   goto L83;
L101:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L102:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L36; }
L103:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L36; }
L104:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5994} {:print "Atomic Assignment"}  true;
    assume currentIrp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(currentIrp))] := -1073741823;  goto L105;
L105:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(0);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5995} {:print "Call \"FloppyProcessQueuedRequests\" \"sdv_IoCompleteRequest\""}  true;
  call sdv_IoCompleteRequest( 0, 0);   goto L36;
L106:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5961} {:print "Atomic Assignment"}  true;
      currentIrp := 0;  goto L107;
L107:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L32;
Lfinal: return;
}
procedure {:origName "FlCheckFormatParameters"} FlCheckFormatParameters(actual_DisketteExtension_5:int, actual_FormatParameters:int) returns (Tmp_65:int) {
var  Tmp_66: int;
var  driveMediaType: int;
var  driveMediaConstants: int;
var  Tmp_67: int;
var  Tmp_68: int;
var  Tmp_69: int;
var  Tmp_70: int;
var  Tmp_71: int;
var  DisketteExtension_5: int;
var  FormatParameters: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DisketteExtension_5 := actual_DisketteExtension_5;
  FormatParameters := actual_FormatParameters;
  // done with preamble
  goto L27;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5548} {:print "Return"}  true;
    goto LM2;
L5:
  call {:cexpr "DisketteExtension->DriveType"} boogie_si_record_li2bpl_int(Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(DisketteExtension_5)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5511} {:print "Atomic Assignment"}  true;
    assume DisketteExtension_5 > 0;
    Tmp_70 := Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(DisketteExtension_5)];  goto L29;
L6:
  call {:cexpr "driveMediaType"} boogie_si_record_li2bpl_int(driveMediaType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5514} {:print "Atomic Assignment"}  true;
      Tmp_67 := driveMediaType;  goto L31;
L7:
  call {:cexpr "driveMediaType"} boogie_si_record_li2bpl_int(driveMediaType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5522} {:print "Atomic Assignment"}  true;
      Tmp_71 := driveMediaType;  goto L34;
L8:
  call {:cexpr "DisketteExtension->DriveType"} boogie_si_record_li2bpl_int(Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(DisketteExtension_5)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5516} {:print "Atomic Assignment"}  true;
    assume DisketteExtension_5 > 0;
    Tmp_68 := Mem_T.DriveType__DISKETTE_EXTENSION[DriveType__DISKETTE_EXTENSION(DisketteExtension_5)];  goto L32;
L9:
  call {:cexpr "driveMediaType"} boogie_si_record_li2bpl_int(driveMediaType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5519} {:print "Atomic Assignment"}  true;
      driveMediaType := (driveMediaType - 1);  goto L33;
L10:
  call {:cexpr "driveMediaType"} boogie_si_record_li2bpl_int(driveMediaType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5529} {:print "Atomic Assignment"}  true;
      Tmp_69 := driveMediaType;  goto L36;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5525} {:print "Atomic Assignment"}  true;
      Tmp_65 := 0;  goto L35;
L13:
  call {:cexpr "driveMediaConstants->NumberOfHeads"} boogie_si_record_li2bpl_int(Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)]);
  call {:cexpr "FormatParameters->EndHeadNumber"} boogie_si_record_li2bpl_int(Mem_T.EndHeadNumber__FORMAT_PARAMETERS[EndHeadNumber__FORMAT_PARAMETERS(FormatParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5533} {:print "Atomic Conditional"}  true;
    if(*) { assume driveMediaConstants > 0;
  assume FormatParameters > 0;
  assume ((Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)] - 1) < Mem_T.EndHeadNumber__FORMAT_PARAMETERS[EndHeadNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L14; } else { assume driveMediaConstants > 0;
  assume FormatParameters > 0;
  assume ((Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)] - 1) >= Mem_T.EndHeadNumber__FORMAT_PARAMETERS[EndHeadNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L15; }
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5542} {:print "Atomic Assignment"}  true;
      Tmp_65 := 0;  goto L38;
L15:
  call {:cexpr "driveMediaConstants->MaximumTrack"} boogie_si_record_li2bpl_int(Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)]);
  call {:cexpr "FormatParameters->StartCylinderNumber"} boogie_si_record_li2bpl_int(Mem_T.StartCylinderNumber__FORMAT_PARAMETERS[StartCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5535} {:print "Atomic Conditional"}  true;
    if(*) { assume driveMediaConstants > 0;
  assume FormatParameters > 0;
  assume (Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)] < Mem_T.StartCylinderNumber__FORMAT_PARAMETERS[StartCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L14; } else { assume driveMediaConstants > 0;
  assume FormatParameters > 0;
  assume (Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)] >= Mem_T.StartCylinderNumber__FORMAT_PARAMETERS[StartCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L16; }
L16:
  call {:cexpr "driveMediaConstants->MaximumTrack"} boogie_si_record_li2bpl_int(Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)]);
  call {:cexpr "FormatParameters->EndCylinderNumber"} boogie_si_record_li2bpl_int(Mem_T.EndCylinderNumber__FORMAT_PARAMETERS[EndCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5537} {:print "Atomic Conditional"}  true;
    if(*) { assume driveMediaConstants > 0;
  assume FormatParameters > 0;
  assume (Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)] < Mem_T.EndCylinderNumber__FORMAT_PARAMETERS[EndCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L14; } else { assume driveMediaConstants > 0;
  assume FormatParameters > 0;
  assume (Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS[MaximumTrack__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)] >= Mem_T.EndCylinderNumber__FORMAT_PARAMETERS[EndCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L17; }
L17:
  call {:cexpr "FormatParameters->EndCylinderNumber"} boogie_si_record_li2bpl_int(Mem_T.EndCylinderNumber__FORMAT_PARAMETERS[EndCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);
  call {:cexpr "FormatParameters->StartCylinderNumber"} boogie_si_record_li2bpl_int(Mem_T.StartCylinderNumber__FORMAT_PARAMETERS[StartCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5539} {:print "Atomic Conditional"}  true;
    if(*) { assume FormatParameters > 0;
  assume (Mem_T.EndCylinderNumber__FORMAT_PARAMETERS[EndCylinderNumber__FORMAT_PARAMETERS(FormatParameters)] < Mem_T.StartCylinderNumber__FORMAT_PARAMETERS[StartCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L14; } else { assume FormatParameters > 0;
  assume (Mem_T.EndCylinderNumber__FORMAT_PARAMETERS[EndCylinderNumber__FORMAT_PARAMETERS(FormatParameters)] >= Mem_T.StartCylinderNumber__FORMAT_PARAMETERS[StartCylinderNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L18; }
L18:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5547} {:print "Atomic Assignment"}  true;
      Tmp_65 := 1;  goto L39;
L27:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L29:
  call {:cexpr "(DriveMediaLimits + (Tmp * 8))->HighestDriveMediaType"} boogie_si_record_li2bpl_int(Mem_T.HighestDriveMediaType__DRIVE_MEDIA_LIMITS[HighestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_70 * 8)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5511} {:print "Atomic Assignment"}  true;
    assume DriveMediaLimits > 0;
    driveMediaType := Mem_T.HighestDriveMediaType__DRIVE_MEDIA_LIMITS[HighestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_70 * 8)))];  goto L30;
L30:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L31:
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MediaType"} boogie_si_record_li2bpl_int(Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_67 * 80)))]);
  call {:cexpr "FormatParameters->MediaType"} boogie_si_record_li2bpl_int(Mem_T.MediaType__FORMAT_PARAMETERS[MediaType__FORMAT_PARAMETERS(FormatParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5514} {:print "Atomic Conditional"}  true;
    if(*) { assume FormatParameters > 0;
  assume DriveMediaConstants > 0;
  assume (Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_67 * 80)))] == Mem_T.MediaType__FORMAT_PARAMETERS[MediaType__FORMAT_PARAMETERS(FormatParameters)]);  goto L7; } else { assume FormatParameters > 0;
  assume DriveMediaConstants > 0;
  assume (Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_67 * 80)))] != Mem_T.MediaType__FORMAT_PARAMETERS[MediaType__FORMAT_PARAMETERS(FormatParameters)]);  goto L8; }
L32:
  call {:cexpr "(DriveMediaLimits + (Tmp * 8))->LowestDriveMediaType"} boogie_si_record_li2bpl_int(Mem_T.LowestDriveMediaType__DRIVE_MEDIA_LIMITS[LowestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_68 * 8)))]);
  call {:cexpr "driveMediaType"} boogie_si_record_li2bpl_int(driveMediaType);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5516} {:print "Atomic Conditional"}  true;
    if(*) { assume DriveMediaLimits > 0;
  assume (Mem_T.LowestDriveMediaType__DRIVE_MEDIA_LIMITS[LowestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_68 * 8)))] >= driveMediaType);  goto L7; } else { assume DriveMediaLimits > 0;
  assume (Mem_T.LowestDriveMediaType__DRIVE_MEDIA_LIMITS[LowestDriveMediaType__DRIVE_MEDIA_LIMITS((DriveMediaLimits + (Tmp_68 * 8)))] < driveMediaType);  goto L9; }
L33:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L34:
  call {:cexpr "(DriveMediaConstants + (Tmp * 80))->MediaType"} boogie_si_record_li2bpl_int(Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_71 * 80)))]);
  call {:cexpr "FormatParameters->MediaType"} boogie_si_record_li2bpl_int(Mem_T.MediaType__FORMAT_PARAMETERS[MediaType__FORMAT_PARAMETERS(FormatParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5522} {:print "Atomic Conditional"}  true;
    if(*) { assume FormatParameters > 0;
  assume DriveMediaConstants > 0;
  assume (Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_71 * 80)))] == Mem_T.MediaType__FORMAT_PARAMETERS[MediaType__FORMAT_PARAMETERS(FormatParameters)]);  goto L10; } else { assume FormatParameters > 0;
  assume DriveMediaConstants > 0;
  assume (Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS[MediaType__DRIVE_MEDIA_CONSTANTS((DriveMediaConstants + (Tmp_71 * 80)))] != Mem_T.MediaType__FORMAT_PARAMETERS[MediaType__FORMAT_PARAMETERS(FormatParameters)]);  goto L11; }
L35:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L36:
  call {:cexpr "&*(DriveMediaConstants + (Tmp * 80))"} boogie_si_record_li2bpl_int((DriveMediaConstants + (Tmp_69 * 80)));
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5529} {:print "Atomic Assignment"}  true;
      driveMediaConstants := (DriveMediaConstants + (Tmp_69 * 80));  goto L37;
L37:
  call {:cexpr "driveMediaConstants->NumberOfHeads"} boogie_si_record_li2bpl_int(Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)]);
  call {:cexpr "FormatParameters->StartHeadNumber"} boogie_si_record_li2bpl_int(Mem_T.StartHeadNumber__FORMAT_PARAMETERS[StartHeadNumber__FORMAT_PARAMETERS(FormatParameters)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 5531} {:print "Atomic Conditional"}  true;
    if(*) { assume driveMediaConstants > 0;
  assume FormatParameters > 0;
  assume ((Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)] - 1) >= Mem_T.StartHeadNumber__FORMAT_PARAMETERS[StartHeadNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L13; } else { assume driveMediaConstants > 0;
  assume FormatParameters > 0;
  assume ((Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS[NumberOfHeads__DRIVE_MEDIA_CONSTANTS(driveMediaConstants)] - 1) < Mem_T.StartHeadNumber__FORMAT_PARAMETERS[StartHeadNumber__FORMAT_PARAMETERS(FormatParameters)]);  goto L14; }
L38:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L39:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "_sdv_init1"} _sdv_init1() {
var  Tmp_72: int;
var  Tmp_73: int;
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
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 43} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_DISK)] := -738893049;  goto L10;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L10:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 43} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_DISK)] := 46783;  goto L11;
L11:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 43} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_DISK)] := 4560;  goto L12;
L12:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 43} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_DISK)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_DISK)]] := 148;  goto L13;
L13:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 44} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_CDROM)] := -738893048;  goto L14;
L14:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 44} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_CDROM)] := 46783;  goto L15;
L15:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 44} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_CDROM)] := 4560;  goto L16;
L16:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 44} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_CDROM)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_CDROM)]] := 148;  goto L17;
L17:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 45} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_PARTITION)] := -738893046;  goto L18;
L18:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 45} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_PARTITION)] := 46783;  goto L19;
L19:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 45} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_PARTITION)] := 4560;  goto L20;
L20:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 45} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_PARTITION)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_PARTITION)]] := 148;  goto L21;
L21:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 46} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_TAPE)] := -738893045;  goto L22;
L22:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 46} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_TAPE)] := 46783;  goto L23;
L23:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 46} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_TAPE)] := 4560;  goto L24;
L24:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 46} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_TAPE)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_TAPE)]] := 148;  goto L25;
L25:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 47} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_WRITEONCEDISK)] := -738893044;  goto L26;
L26:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 47} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_WRITEONCEDISK)] := 46783;  goto L27;
L27:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 47} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_WRITEONCEDISK)] := 4560;  goto L28;
L28:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 47} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_WRITEONCEDISK)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_WRITEONCEDISK)]] := 148;  goto L29;
L29:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 48} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_VOLUME)] := -738893043;  goto L30;
L30:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 48} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_VOLUME)] := 46783;  goto L31;
L31:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 48} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_VOLUME)] := 4560;  goto L32;
L32:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 48} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_VOLUME)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_VOLUME)]] := 148;  goto L33;
L33:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 49} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_MEDIUMCHANGER)] := -738893040;  goto L34;
L34:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 49} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_MEDIUMCHANGER)] := 46783;  goto L35;
L35:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 49} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_MEDIUMCHANGER)] := 4560;  goto L36;
L36:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 49} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_MEDIUMCHANGER)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_MEDIUMCHANGER)]] := 148;  goto L37;
L37:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 50} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_FLOPPY)] := -738893039;  goto L38;
L38:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 50} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_FLOPPY)] := 46783;  goto L39;
L39:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 50} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_FLOPPY)] := 4560;  goto L40;
L40:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 50} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_FLOPPY)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_FLOPPY)]] := 148;  goto L41;
L41:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 51} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_CDCHANGER)] := -738893038;  goto L42;
L42:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 51} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_CDCHANGER)] := 46783;  goto L43;
L43:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 51} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_CDCHANGER)] := 4560;  goto L44;
L44:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 51} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_CDCHANGER)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_CDCHANGER)]] := 148;  goto L45;
L45:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 52} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_STORAGEPORT)] := 718077536;  goto L46;
L46:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 52} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_STORAGEPORT)] := 49456;  goto L47;
L47:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 52} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_STORAGEPORT)] := 4562;  goto L48;
L48:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 52} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_STORAGEPORT)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_STORAGEPORT)]] := 176;  goto L49;
L49:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 53} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_VMLUN)] := -280926695;  goto L50;
L50:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 53} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_VMLUN)] := 40745;  goto L51;
L51:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 53} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_VMLUN)] := 17061;  goto L52;
L52:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 53} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_VMLUN)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_VMLUN)]] := 178;  goto L53;
L53:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 54} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_SES)] := 395364844;  goto L54;
L54:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 54} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_SES)] := 18389;  goto L55;
L55:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 54} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_SES)] := 19955;  goto L56;
L56:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 54} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_SES)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_SES)]] := 181;  goto L57;
L57:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 63} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVINTERFACE_HIDDEN_VOLUME)] := -15693272;  goto L58;
L58:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 63} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVINTERFACE_HIDDEN_VOLUME)] := 38963;  goto L59;
L59:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 63} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVINTERFACE_HIDDEN_VOLUME)] := 19259;  goto L60;
L60:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 63} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_HIDDEN_VOLUME)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVINTERFACE_HIDDEN_VOLUME)]] := 183;  goto L61;
L61:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 91} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVICEDUMP_STORAGE_DEVICE)] := -656254673;  goto L62;
L62:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 91} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVICEDUMP_STORAGE_DEVICE)] := 6827;  goto L63;
L63:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 91} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVICEDUMP_STORAGE_DEVICE)] := 19798;  goto L64;
L64:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 91} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVICEDUMP_STORAGE_DEVICE)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVICEDUMP_STORAGE_DEVICE)]] := 167;  goto L65;
L65:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 94} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(GUID_DEVICEDUMP_DRIVER_STORAGE_PORT)] := -628997091;  goto L66;
L66:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 94} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(GUID_DEVICEDUMP_DRIVER_STORAGE_PORT)] := 28994;  goto L67;
L67:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 94} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(GUID_DEVICEDUMP_DRIVER_STORAGE_PORT)] := 19393;  goto L68;
L68:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\shared\ntddstor.h"} {:sourceline 94} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(GUID_DEVICEDUMP_DRIVER_STORAGE_PORT)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(GUID_DEVICEDUMP_DRIVER_STORAGE_PORT)]] := 184;  goto L69;
L69:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\mountmgr.h"} {:sourceline 215} {:print "Atomic Assignment"}  true;
      Mem_T.Data1__GUID[Data1__GUID(MOUNTDEV_MOUNTED_DEVICE_GUID)] := -738893043;  goto L70;
L70:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\mountmgr.h"} {:sourceline 215} {:print "Atomic Assignment"}  true;
      Mem_T.Data2__GUID[Data2__GUID(MOUNTDEV_MOUNTED_DEVICE_GUID)] := 46783;  goto L71;
L71:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\mountmgr.h"} {:sourceline 215} {:print "Atomic Assignment"}  true;
      Mem_T.Data3__GUID[Data3__GUID(MOUNTDEV_MOUNTED_DEVICE_GUID)] := 4560;  goto L72;
L72:
  assert {:sourcefile "c:\program files (x86)\windows kits\8.0\include\km\mountmgr.h"} {:sourceline 215} {:print "Atomic Assignment"}  true;
    assume Mem_T.Data4__GUID[Data4__GUID(MOUNTDEV_MOUNTED_DEVICE_GUID)] > 0;
    Mem_T.INT4[Mem_T.Data4__GUID[Data4__GUID(MOUNTDEV_MOUNTED_DEVICE_GUID)]] := 148;  goto L73;
L73:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 103} {:print "Atomic Assignment"}  true;
      PagingReferenceCount := 0;  goto L74;
L74:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\floppy.c"} {:sourceline 104} {:print "Atomic Assignment"}  true;
      PagingMutex := 0;  goto L75;
L75:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_containing_record"} sdv_containing_record(actual_Address:int, actual_FieldOffset:int) returns (Tmp_74:int) {
var  Tmp_75: int;
var  record: int;
var  Address: int;
var  FieldOffset: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Address := actual_Address;
  FieldOffset := actual_FieldOffset;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  call {:cexpr "Address"} boogie_si_record_li2bpl_int(Address);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 18441} {:print "Atomic Assignment"}  true;
      record := Address;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
  call {:cexpr "record"} boogie_si_record_li2bpl_int(record);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 18442} {:print "Atomic Assignment"}  true;
      Tmp_74 := record;  goto L10;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 18442} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "RtlFreeUnicodeString"} RtlFreeUnicodeString(actual_UnicodeString:int) {
var  Tmp_76: int;
var  Tmp_77: int;
var  UnicodeString: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  UnicodeString := actual_UnicodeString;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15466} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "WmiSystemControl"} WmiSystemControl(actual_WmiLibInfo:int, actual_DeviceObject_8:int, actual_pirp:int, actual_IrpDisposition:int) returns (Tmp_78:int) {
var  sdv_80: int;
var  sdv_81: int;
var  y: int;
var  x: int;
var  s: int;
var  Tmp_79: int;
var  WmiLibInfo: int;
var  DeviceObject_8: int;
var  pirp: int;
var  IrpDisposition: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  WmiLibInfo := actual_WmiLibInfo;
  DeviceObject_8 := actual_DeviceObject_8;
  pirp := actual_pirp;
  IrpDisposition := actual_IrpDisposition;
  // done with preamble
  goto L54;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L14;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19145} {:print "Atomic Continuation"}  true;
    if(*) {  goto L16; } else {  goto L45; }
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19162} {:print "Atomic Assignment"}  true;
    assume IrpDisposition > 0;
    Mem_T.INT4[IrpDisposition] := 2;  goto L63;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19147} {:print "Atomic Assignment"}  true;
    assume IrpDisposition > 0;
    Mem_T.INT4[IrpDisposition] := 0;  goto L56;
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19152} {:print "Atomic Assignment"}  true;
    assume IrpDisposition > 0;
    Mem_T.INT4[IrpDisposition] := 1;  goto L59;
L18:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19157} {:print "Atomic Assignment"}  true;
    assume IrpDisposition > 0;
    Mem_T.INT4[IrpDisposition] := 3;  goto L61;
L24:
  call {:cexpr "s"} boogie_si_record_li2bpl_int(s);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19173} {:print "Atomic Assignment"}  true;
      Tmp_78 := s;  goto L58;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19164} {:print "Atomic Continuation"}  true;
    if(*) {  goto L39; } else {  goto L40; }
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19169} {:print "Atomic Assignment"}  true;
      s := -1073741808;  goto L65;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19166} {:print "Atomic Assignment"}  true;
      s := 0;  goto L64;
L44:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L15; } else {  goto L18; }
L45:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L17; } else {  goto L44; }
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19159} {:print "Call \"WmiSystemControl\" \"sdv_stub_WmiIrpForward\""}  true;
  call sdv_stub_WmiIrpForward( 0);   goto L24;
L49:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19159} {:print "Call \"WmiSystemControl\" \"SLIC_sdv_stub_WmiIrpForward_entry\""}  true;
  call SLIC_sdv_stub_WmiIrpForward_entry( 0);   goto L48;
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19163} {:print "Call \"WmiSystemControl\" \"sdv_stub_WmiIrpForward\""}  true;
  call sdv_stub_WmiIrpForward( 0);   goto L38;
L52:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19163} {:print "Call \"WmiSystemControl\" \"SLIC_sdv_stub_WmiIrpForward_entry\""}  true;
  call SLIC_sdv_stub_WmiIrpForward_entry( 0);   goto L51;
L54:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L56:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19148} {:print "Atomic Assignment"}  true;
      s := 0;  goto L57;
L57:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19149} {:print "Call \"WmiSystemControl\" \"sdv_stub_WmiIrpProcessed\""}  true;
  call sdv_stub_WmiIrpProcessed( 0);   goto L24;
L58:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19173} {:print "Return"}  true;
    goto LM2;
L59:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19153} {:print "Atomic Assignment"}  true;
      s := 0;  goto L60;
L60:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19154} {:print "Call \"WmiSystemControl\" \"sdv_stub_WmiIrpNotCompleted\""}  true;
  call sdv_stub_WmiIrpNotCompleted( 0);   goto L24;
L61:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 19158} {:print "Atomic Assignment"}  true;
      s := 0;  goto L62;
L62:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
   assume alias7(SLAM_guard_S_0, pirp);
    if(*) { assume (!((pirp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L48; } else { assume ((pirp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L49; }
L63:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((pirp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L51; } else { assume ((pirp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L52; }
L64:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L24;
L65:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L24;
Lfinal: return;
}
procedure {:origName "sdv_IoAssignArcName"} sdv_IoAssignArcName(actual_ArcName:int, actual_DeviceName:int) {
var  Tmp_80: int;
var  Tmp_81: int;
var  ArcName: int;
var  DeviceName: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  ArcName := actual_ArcName;
  DeviceName := actual_DeviceName;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9736} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "IoGetAttachedDeviceReference"} IoGetAttachedDeviceReference(actual_DeviceObject_9:int) returns (Tmp_82:int) {
var  sdv_82: int;
var  choice: int;
var  Tmp_83: int;
var  DeviceObject_9: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_9 := actual_DeviceObject_9;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10673} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10667} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  call {:cexpr "DeviceObject"} boogie_si_record_li2bpl_int(DeviceObject_9);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10670} {:print "Atomic Assignment"}  true;
      Tmp_82 := DeviceObject_9;  goto L16;
L10:
  call {:cexpr "sdv_p_devobj_top"} boogie_si_record_li2bpl_int(sdv_p_devobj_top);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10669} {:print "Atomic Assignment"}  true;
      Tmp_82 := sdv_p_devobj_top;  goto L15;
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
procedure {:origName "sdv_IoCallDriver"} sdv_IoCallDriver(actual_DeviceObject_10:int, actual_Irp_9:int) returns (Tmp_84:int) {
var  sdv_83: int;
var  Tmp_85: int;
var  DeviceObject_10: int;
var  Irp_9: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_10 := actual_DeviceObject_10;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10057} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_9);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10056} {:print "Call \"sdv_IoCallDriver\" \"IofCallDriver\""}  true;
  call Tmp_84 := IofCallDriver( 0, Irp_9);   goto L1;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_IoGetNextIrpStackLocation"} sdv_IoGetNextIrpStackLocation(actual_pirp_1:int) returns (Tmp_86:int) {
var  Tmp_87: int;
var  pirp_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_1 := actual_pirp_1;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10901} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_1);
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10894} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_1 != sdv_harnessIrp);  goto L4; } else { assume (pirp_1 == sdv_harnessIrp);  goto L5; }
L4:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_1);
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10896} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_1 != sdv_other_harnessIrp);  goto L6; } else { assume (pirp_1 == sdv_other_harnessIrp);  goto L7; }
L5:
  call {:cexpr "&sdv_harnessStackLocation_next"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation_next);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10895} {:print "Atomic Assignment"}  true;
      Tmp_86 := sdv_harnessStackLocation_next;  goto L11;
L6:
  call {:cexpr "&sdv_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10899} {:print "Atomic Assignment"}  true;
      Tmp_86 := sdv_harnessStackLocation;  goto L13;
L7:
  call {:cexpr "&sdv_other_harnessStackLocation_next"} boogie_si_record_li2bpl_int(sdv_other_harnessStackLocation_next);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10897} {:print "Atomic Assignment"}  true;
      Tmp_86 := sdv_other_harnessStackLocation_next;  goto L12;
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
procedure {:origName "ZwClose"} ZwClose(actual_Handle:int) returns (Tmp_88:int) {
var  Tmp_89: int;
var  Handle: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Handle := actual_Handle;
  // done with preamble
  goto L5;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 16181} {:print "Atomic Assignment"}  true;
      Tmp_88 := 0;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 16181} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_KeAcquireSpinLock"} sdv_KeAcquireSpinLock(actual_SpinLock:int, actual_p_1:int) {
var  Tmp_90: int;
var  Tmp_91: int;
var  SpinLock: int;
var  p_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SpinLock := actual_SpinLock;
  p_1 := actual_p_1;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12652} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L11;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L11:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12652} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L12;
L12:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12652} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12652} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L14;
L14:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12653} {:print "Atomic Assignment"}  true;
    assume p_1 > 0;
    Mem_T.INT4[p_1] := sdv_irql_previous;  goto L15;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12654} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoDetachDevice"} IoDetachDevice(actual_TargetDevice:int) {
var  Tmp_92: int;
var  Tmp_93: int;
var  TargetDevice: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  TargetDevice := actual_TargetDevice;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10550} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_stub_WmiIrpForward"} sdv_stub_WmiIrpForward(actual_pirp_2:int) {
var  Tmp_94: int;
var  Tmp_95: int;
var  pirp_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_2 := actual_pirp_2;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6804} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "ExReleaseFastMutex"} ExReleaseFastMutex(actual_FastMutex:int) {
var  Tmp_96: int;
var  Tmp_97: int;
var  FastMutex: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  FastMutex := actual_FastMutex;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7638} {:print "Atomic Assignment"}  true;
      sdv_irql_current := sdv_irql_previous;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7638} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L10;
L10:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7638} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7639} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "RtlAnsiStringToUnicodeString"} RtlAnsiStringToUnicodeString(actual_DestinationString:int, actual_SourceString:int, actual_AllocateDestinationString:int) returns (Tmp_98:int) {
var  sdv_84: int;
var  x_1: int;
var  Tmp_99: int;
var  DestinationString: int;
var  SourceString: int;
var  AllocateDestinationString: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DestinationString := actual_DestinationString;
  SourceString := actual_SourceString;
  AllocateDestinationString := actual_AllocateDestinationString;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15285} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15281} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15283} {:print "Atomic Assignment"}  true;
      Tmp_98 := -1073741823;  goto L16;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15282} {:print "Atomic Assignment"}  true;
      Tmp_98 := 0;  goto L15;
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
procedure {:origName "KeInitializeEvent"} KeInitializeEvent(actual_Event:int, actual_Type:int, actual_State:int) {
var  Tmp_100: int;
var  Tmp_101: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12791} {:print "Atomic Assignment"}  true;
    assume Event > 0;
    Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(Header__KEVENT(Event))] := Type;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12792} {:print "Atomic Assignment"}  true;
    assume Event > 0;
    Mem_T.Signalling__DISPATCHER_HEADER[Signalling__DISPATCHER_HEADER(Header__KEVENT(Event))] := 0;  goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12793} {:print "Atomic Assignment"}  true;
    assume Event > 0;
    Mem_T.Size__DISPATCHER_HEADER[Size__DISPATCHER_HEADER(Header__KEVENT(Event))] := 4;  goto L12;
L12:
  call {:cexpr "State"} boogie_si_record_li2bpl_int(State);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12794} {:print "Atomic Assignment"}  true;
    assume Event > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event))] := State;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12795} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeSetEvent"} KeSetEvent(actual_Event_1:int, actual_Increment:int, actual_Wait:int) returns (Tmp_102:int) {
var  Tmp_103: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13050} {:print "Atomic Assignment"}  true;
    assume Event_1 > 0;
    OldState := Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_1))];  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13051} {:print "Atomic Assignment"}  true;
    assume Event_1 > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_1))] := 1;  goto L11;
L11:
  call {:cexpr "OldState"} boogie_si_record_li2bpl_int(OldState);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13052} {:print "Atomic Assignment"}  true;
      Tmp_102 := OldState;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13052} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_ExInterlockedRemoveHeadList"} sdv_ExInterlockedRemoveHeadList(actual_ListHead_1:int, actual_Lock:int) returns (Tmp_104:int) {
var  sdv_85: int;
var  sdv_86: int;
var  x_2: int;
var  p_2: int;
var  Tmp_105: int;
var  ListHead_1: int;
var  Lock: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  ListHead_1 := actual_ListHead_1;
  Lock := actual_Lock;
  // done with preamble
  goto L19;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L9;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7476} {:print "Return"}  true;
    goto LM2;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7470} {:print "Atomic Continuation"}  true;
    if(*) {  goto L10; } else {  goto L11; }
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7473} {:print "Atomic Assignment"}  true;
      p_2 := 0;  goto L23;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7472} {:print "Atomic Assignment"}  true;
      call sdv_85 := __HAVOC_malloc(1);  goto L14;
L14:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_85);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7472} {:print "Atomic Assignment"}  true;
      p_2 := sdv_85;  goto L21;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L21:
  call {:cexpr "p"} boogie_si_record_li2bpl_int(p_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7472} {:print "Atomic Assignment"}  true;
      Tmp_104 := p_2;  goto L22;
L22:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L23:
  call {:cexpr "p"} boogie_si_record_li2bpl_int(p_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7473} {:print "Atomic Assignment"}  true;
      Tmp_104 := p_2;  goto L24;
L24:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_RunAddDevice"} sdv_RunAddDevice(actual_p1:int, actual_p2:int) returns (Tmp_106:int) {
var  Tmp_107: int;
var  sdv_87: int;
var  status_1: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4986} {:print "Atomic Assignment"}  true;
      status_1 := 0;  goto L19;
L8:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(p1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(p2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4989} {:print "Call \"sdv_RunAddDevice\" \"FloppyAddDevice\""}  true;
  call status_1 := FloppyAddDevice( p1, p2);   goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4991} {:print "Call \"sdv_RunAddDevice\" \"sdv_stub_add_end\""}  true;
  call sdv_stub_add_end();   goto L15;
L15:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4992} {:print "Atomic Assignment"}  true;
      Tmp_106 := status_1;  goto L20;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4987} {:print "Call \"sdv_RunAddDevice\" \"sdv_stub_add_begin\""}  true;
  call sdv_stub_add_begin();   goto L8;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4992} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoAttachDeviceToDeviceStack"} IoAttachDeviceToDeviceStack(actual_SourceDevice:int, actual_TargetDevice_1:int) returns (Tmp_108:int) {
var  Tmp_109: int;
var  SourceDevice: int;
var  TargetDevice_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SourceDevice := actual_SourceDevice;
  TargetDevice_1 := actual_TargetDevice_1;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9800} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "TargetDevice"} boogie_si_record_li2bpl_int(TargetDevice_1);
  call {:cexpr "sdv_p_devobj_pdo"} boogie_si_record_li2bpl_int(sdv_p_devobj_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9795} {:print "Atomic Conditional"}  true;
    if(*) { assume (TargetDevice_1 != sdv_p_devobj_pdo);  goto L4; } else { assume (TargetDevice_1 == sdv_p_devobj_pdo);  goto L5; }
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9798} {:print "Atomic Assignment"}  true;
      Tmp_108 := 0;  goto L10;
L5:
  call {:cexpr "TargetDevice"} boogie_si_record_li2bpl_int(TargetDevice_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9796} {:print "Atomic Assignment"}  true;
      Tmp_108 := TargetDevice_1;  goto L9;
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
procedure {:origName "sdv_KeRaiseIrql"} sdv_KeRaiseIrql(actual_new:int, actual_p_3:int) {
var  Tmp_110: int;
var  Tmp_111: int;
var  new: int;
var  p_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  new := actual_new;
  p_3 := actual_p_3;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12913} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L11;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L11:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12913} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L12;
L12:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12913} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L13;
L13:
  call {:cexpr "new"} boogie_si_record_li2bpl_int(new);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12913} {:print "Atomic Assignment"}  true;
      sdv_irql_current := new;  goto L14;
L14:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12914} {:print "Atomic Assignment"}  true;
    assume p_3 > 0;
    Mem_T.INT4[p_3] := sdv_irql_previous;  goto L15;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12915} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_IoSkipCurrentIrpStackLocation"} sdv_IoSkipCurrentIrpStackLocation(actual_pirp_3:int) {
var  Tmp_112: int;
var  Tmp_113: int;
var  pirp_3: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_3 := actual_pirp_3;
  // done with preamble
  goto L12;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11656} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_3);
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11655} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_3 != sdv_harnessIrp);  goto L4; } else { assume (pirp_3 == sdv_harnessIrp);  goto L5; }
L4:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_3);
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11655} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_3 != sdv_other_harnessIrp);  goto L1; } else { assume (pirp_3 == sdv_other_harnessIrp);  goto L7; }
L5:
  call {:cexpr "sdv_harnessStackLocation.MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11655} {:print "Atomic Assignment"}  true;
      Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];  goto L14;
L7:
  call {:cexpr "sdv_other_harnessStackLocation.MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11655} {:print "Atomic Assignment"}  true;
      Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];  goto L16;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L14:
  call {:cexpr "sdv_harnessStackLocation.MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11655} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];  goto L15;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L16:
  call {:cexpr "sdv_other_harnessStackLocation.MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11655} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];  goto L17;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "IoGetConfigurationInformation"} IoGetConfigurationInformation() returns (Tmp_114:int) {
var  sdv_88: int;
var  Tmp_115: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10698} {:print "Atomic Assignment"}  true;
      call sdv_88 := __HAVOC_malloc(1);  goto L6;
L6:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_88);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10698} {:print "Atomic Assignment"}  true;
      Tmp_114 := sdv_88;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10698} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "main"} main() returns (Tmp_116:int) {
var  Tmp_117: int;
var  Tmp_118: int;
var  Tmp_119: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  assume alloc > 0;
  // allocate globals moved-out-of-stack
  call WHEA_ERROR_PACKET_SECTION_GUID := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_VOLUME := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_MEDIUMCHANGER := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_STORAGEPORT := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_PARTITION := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_VMLUN := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_FLOPPY := __HAVOC_malloc(16);
  call GUID_DEVICEDUMP_DRIVER_STORAGE_PORT := __HAVOC_malloc(16);
  call MOUNTDEV_MOUNTED_DEVICE_GUID := __HAVOC_malloc(16);
  call GUID_DEVICEDUMP_STORAGE_DEVICE := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_HIDDEN_VOLUME := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_CDROM := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_WRITEONCEDISK := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_CDCHANGER := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_DISK := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_TAPE := __HAVOC_malloc(16);
  call GUID_DEVINTERFACE_SES := __HAVOC_malloc(16);
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
  call sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT := __HAVOC_malloc(328);
  call sdv_IoCreateNotificationEvent_KEVENT := __HAVOC_malloc(108);
  call sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock := __HAVOC_malloc(12);
  call sdv_MapRegisterBase_val := __HAVOC_malloc(4);
  call sdv_kdpc_val3 := __HAVOC_malloc(40);
  call sdv_IoGetDmaAdapter_DMA_ADAPTER := __HAVOC_malloc(12);
  call SLAM_guard_S_0_init := __HAVOC_malloc(240);
  // Global distinctness: initialize globals
  call  boogieTmp :=  __HAVOC_malloc_or_null(80);
  _DriveMediaConstants := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(8);
  DriveMediaLimits := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(80);
  DriveMediaConstants := boogieTmp;
  call  boogieTmp :=  __HAVOC_malloc_or_null(8);
  _DriveMediaLimits := boogieTmp;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6695} {:print "Atomic Continuation"}  true;
    goto L25;
L3:
  call {:cexpr "sdv_harnessDeviceExtension"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_harnessDeviceExtension != 0);  goto L28; } else { assume (sdv_harnessDeviceExtension == 0);  goto L29; }
L7:
  call {:cexpr "sdv_harnessDeviceExtension_two"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension_two);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_harnessDeviceExtension_two != 0);  goto L32; } else { assume (sdv_harnessDeviceExtension_two == 0);  goto L33; }
L11:
  call {:cexpr "sdv_harnessDeviceExtension"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
      Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(sdv_devobj_pdo)] := sdv_harnessDeviceExtension;  goto L35;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"main\" \"_sdv_init1\""}  true;
  call _sdv_init1();   goto L3;
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"main\" \"_sdv_init2\""}  true;
  call _sdv_init2();   goto L19;
L21:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_118);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Continuation"}  true;
  assume(Tmp_118 != 0);   goto L30;
L22:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_117);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Continuation"}  true;
  assume(Tmp_117 != 0);   goto L34;
L23:
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"main\" \"_sdv_init4\""}  true;
    assume {:mainInitDone} true;
  call corralExtraInit();
call _sdv_init4();   goto L20;
L24:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      call _DriveMediaConstants := __HAVOC_malloc(1360);
    call _DriveMediaLimits := __HAVOC_malloc(40);  goto L23;
L25:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 0);  goto LM2; } else { assume (yogi_error == 1);  goto L40; }
L27:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L21;
L28:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_118 := 1;  goto L27;
L29:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_118 := 0;  goto L27;
L30:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L7;
L31:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L22;
L32:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_117 := 1;  goto L31;
L33:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_117 := 0;  goto L31;
L34:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L35:
  call {:cexpr "sdv_harnessDeviceExtension_two"} boogie_si_record_li2bpl_int(sdv_harnessDeviceExtension_two);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
      Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(sdv_devobj_fdo)] := sdv_harnessDeviceExtension_two;  goto L36;
L36:
  call {:cexpr "&sdv_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
    assume sdv_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_irp)))] := sdv_harnessStackLocation;  goto L37;
L37:
  call {:cexpr "&sdv_other_harnessStackLocation"} boogie_si_record_li2bpl_int(sdv_other_harnessStackLocation);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6693} {:print "Atomic Assignment"}  true;
    assume sdv_other_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_other_irp)))] := sdv_other_harnessStackLocation;  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6694} {:print "Call \"main\" \"sdv_main\""}  true;
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
var  sdv_89: int;
var  sdv_90: int;
var  sdv_91: int;
var  sdv_92: int;
var  sdv_93: int;
var  status_2: int;
var  u: int;
var  Tmp_120: int;
var  choice_1: int;
var  Tmp_121: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call u := __HAVOC_malloc(12);
  // initialize local variables to 0
  // copy formal-ins to locals
  // done with preamble
  goto L68;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
  call {:cexpr "sdv_irp"} boogie_si_record_li2bpl_int(sdv_irp);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      SLAM_guard_S_0 := sdv_irp;  goto L70;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6210} {:print "Return"}  true;
    goto LM2;
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6180} {:print "Atomic Continuation"}  true;
    if(*) {  goto L30; } else {  goto L65; }
L30:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6183} {:print "Call \"sdv_main\" \"sdv_stub_driver_init\""}  true;
  call sdv_stub_driver_init();   goto L57;
L33:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6188} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 1;  goto L74;
L34:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_driver_object);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_p_devobj_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6195} {:print "Call \"sdv_main\" \"sdv_RunAddDevice\""}  true;
  call status_2 := sdv_RunAddDevice( sdv_driver_object, sdv_p_devobj_pdo);   goto L1;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6200} {:print "Call \"sdv_main\" \"sdv_stub_driver_init\""}  true;
  call sdv_stub_driver_init();   goto L44;
L40:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_driver_object);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6206} {:print "Call \"sdv_main\" \"sdv_RunUnload\""}  true;
  call sdv_RunUnload( sdv_driver_object);   goto L1;
L44:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6201} {:print "Call \"sdv_main\" \"sdv_RunStartDevice\""}  true;
  call status_2 := sdv_RunStartDevice( sdv_p_devobj_fdo, sdv_irp);   goto L76;
L55:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6190} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 0;  goto L75;
L57:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(sdv_irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6184} {:print "Call \"sdv_main\" \"sdv_RunDispatchFunction\""}  true;
  call sdv_89 := sdv_RunDispatchFunction( sdv_p_devobj_fdo, sdv_irp);   goto L73;
L62:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L1; } else {  goto L40; }
L63:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L37; } else {  goto L62; }
L64:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L34; } else {  goto L63; }
L65:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L33; } else {  goto L64; }
L68:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L70:
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
  assume(SLAM_guard_S_0 != 0);   goto L71;
L71:
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
  assume(SLAM_guard_S_0 != SLAM_guard_S_0_init);   goto L72;
L72:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L29;
L73:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
L74:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_driver_object);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(u);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6189} {:print "Call \"sdv_main\" \"DriverEntry\""}  true;
  call status_2 := DriverEntry( sdv_driver_object, u);   goto L55;
L75:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L76:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L1; }
Lfinal: return;
}
procedure {:origName "sdv_RunUnload"} sdv_RunUnload(actual_pdrivo:int) {
var  Tmp_122: int;
var  Tmp_123: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4770} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pdrivo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4766} {:print "Call \"sdv_RunUnload\" \"FloppyUnload\""}  true;
  call FloppyUnload( pdrivo);   goto L1;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_stub_dispatch_begin"} sdv_stub_dispatch_begin() {
var  Tmp_124: int;
var  Tmp_125: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L11;
L11:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6744} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6745} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoSetStartIoAttributes"} IoSetStartIoAttributes(actual_DeviceObject_11:int, actual_DeferredStartIo:int, actual_NonCancelable:int) {
var  Tmp_126: int;
var  Tmp_127: int;
var  DeviceObject_11: int;
var  DeferredStartIo: int;
var  NonCancelable: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_11 := actual_DeviceObject_11;
  DeferredStartIo := actual_DeferredStartIo;
  NonCancelable := actual_NonCancelable;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11601} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "ExAcquireFastMutex"} ExAcquireFastMutex(actual_FastMutex_1:int) {
var  Tmp_128: int;
var  Tmp_129: int;
var  FastMutex_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  FastMutex_1 := actual_FastMutex_1;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7177} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7177} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L11;
L11:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7177} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7177} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 1;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7178} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeReleaseSemaphore"} KeReleaseSemaphore(actual_Semaphore:int, actual_Increment_1:int, actual_Adjustment:int, actual_Wait_1:int) returns (Tmp_130:int) {
var  sdv_94: int;
var  r: int;
var  Tmp_131: int;
var  Semaphore: int;
var  Increment_1: int;
var  Adjustment: int;
var  Wait_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Semaphore := actual_Semaphore;
  Increment_1 := actual_Increment_1;
  Adjustment := actual_Adjustment;
  Wait_1 := actual_Wait_1;
  // done with preamble
  goto L10;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L8:
  call {:cexpr "r"} boogie_si_record_li2bpl_int(r);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13000} {:print "Atomic Assignment"}  true;
      Tmp_130 := r;  goto L12;
L10:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13000} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "MmPageEntireDriver"} MmPageEntireDriver(actual_AddressWithinSection:int) returns (Tmp_132:int) {
var  sdv_95: int;
var  p_4: int;
var  Tmp_133: int;
var  AddressWithinSection: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  AddressWithinSection := actual_AddressWithinSection;
  // done with preamble
  goto L10;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13915} {:print "Atomic Assignment"}  true;
      call sdv_95 := __HAVOC_malloc(1);  goto L7;
L7:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_95);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13915} {:print "Atomic Assignment"}  true;
      p_4 := sdv_95;  goto L12;
L10:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L12:
  call {:cexpr "p"} boogie_si_record_li2bpl_int(p_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13916} {:print "Atomic Assignment"}  true;
      Tmp_132 := p_4;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13916} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_stub_WmiIrpNotCompleted"} sdv_stub_WmiIrpNotCompleted(actual_pirp_4:int) {
var  Tmp_134: int;
var  Tmp_135: int;
var  pirp_4: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_4 := actual_pirp_4;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6803} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "KeRaiseIrqlToDpcLevel"} KeRaiseIrqlToDpcLevel() returns (Tmp_136:int) {
var  Tmp_137: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12923} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L11;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L11:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12923} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L12;
L12:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12923} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L13;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12923} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L14;
L14:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12924} {:print "Atomic Assignment"}  true;
      Tmp_136 := sdv_irql_previous;  goto L15;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12924} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "RtlInitUnicodeString"} RtlInitUnicodeString(actual_DestinationString_1:int, actual_SourceString_1:int) {
var  Tmp_138: int;
var  Tmp_139: int;
var  DestinationString_1: int;
var  SourceString_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DestinationString_1 := actual_DestinationString_1;
  SourceString_1 := actual_SourceString_1;
  // done with preamble
  goto L12;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15548} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "DestinationString"} boogie_si_record_li2bpl_int(DestinationString_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15535} {:print "Atomic Conditional"}  true;
    if(*) { assume (DestinationString_1 == 0);  goto L4; } else { assume (DestinationString_1 != 0);  goto L5; }
L4:
  call {:cexpr "SourceString"} boogie_si_record_li2bpl_int(SourceString_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15541} {:print "Atomic Conditional"}  true;
    if(*) { assume (SourceString_1 != 0);  goto L1; } else { assume (SourceString_1 == 0);  goto L7; }
L5:
  call {:cexpr "SourceString"} boogie_si_record_li2bpl_int(SourceString_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15537} {:print "Atomic Assignment"}  true;
    assume DestinationString_1 > 0;
    Mem_T.Buffer__STRING[Buffer__STRING(DestinationString_1)] := SourceString_1;  goto L14;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15543} {:print "Atomic Assignment"}  true;
    assume DestinationString_1 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(DestinationString_1)] := 0;  goto L16;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15538} {:print "Atomic Assignment"}  true;
    assume DestinationString_1 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(DestinationString_1)] := 100;  goto L15;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15544} {:print "Atomic Assignment"}  true;
    assume DestinationString_1 > 0;
    Mem_T.MaximumLength__STRING[MaximumLength__STRING(DestinationString_1)] := 0;  goto L17;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "RtlInitString"} RtlInitString(actual_DestinationString_2:int, actual_SourceString_2:int) {
var  Tmp_140: int;
var  Tmp_141: int;
var  DestinationString_2: int;
var  SourceString_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DestinationString_2 := actual_DestinationString_2;
  SourceString_2 := actual_SourceString_2;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15513} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "ExAcquireResourceSharedLite"} ExAcquireResourceSharedLite(actual_Resource:int, actual_Wait_2:int) returns (Tmp_142:int) {
var  sdv_96: int;
var  choice_2: int;
var  Tmp_143: int;
var  Resource: int;
var  Wait_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Resource := actual_Resource;
  Wait_2 := actual_Wait_2;
  // done with preamble
  goto L15;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7240} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "Wait"} boogie_si_record_li2bpl_int(Wait_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7227} {:print "Atomic Conditional"}  true;
    if(*) { assume (Wait_2 != 0);  goto L5; } else { assume (Wait_2 == 0);  goto L10; }
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7227} {:print "Atomic Assignment"}  true;
      Tmp_142 := 1;  goto L17;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7230} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L12; }
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7236} {:print "Atomic Assignment"}  true;
      Tmp_142 := 1;  goto L19;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7233} {:print "Atomic Assignment"}  true;
      Tmp_142 := 0;  goto L18;
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
procedure {:origName "sdv_IoCompleteRequest"} sdv_IoCompleteRequest(actual_pirp_5:int, actual_PriorityBoost:int) {
var  Tmp_144: int;
var  Tmp_145: int;
var  pirp_5: int;
var  PriorityBoost: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_5 := actual_pirp_5;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10106} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "IoQueryDeviceDescription"} IoQueryDeviceDescription(actual_BusType:int, actual_BusNumber:int, actual_ControllerType:int, actual_ControllerNumber:int, actual_PeripheralType:int, actual_PeripheralNumber:int, actual_CalloutRoutine:int, actual_Context_1:int) returns (Tmp_146:int) {
var  sdv_97: int;
var  choice_3: int;
var  Tmp_147: int;
var  BusType: int;
var  BusNumber: int;
var  ControllerType: int;
var  ControllerNumber: int;
var  PeripheralType: int;
var  PeripheralNumber: int;
var  CalloutRoutine: int;
var  Context_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  BusType := actual_BusType;
  BusNumber := actual_BusNumber;
  ControllerType := actual_ControllerType;
  ControllerNumber := actual_ControllerNumber;
  PeripheralType := actual_PeripheralType;
  PeripheralNumber := actual_PeripheralNumber;
  CalloutRoutine := actual_CalloutRoutine;
  Context_1 := actual_Context_1;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11142} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11138} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11140} {:print "Atomic Assignment"}  true;
      Tmp_146 := -1073741823;  goto L16;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11139} {:print "Atomic Assignment"}  true;
      Tmp_146 := 0;  goto L15;
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
procedure {:origName "sdv_IoSetCancelRoutine"} sdv_IoSetCancelRoutine(actual_pirp_6:int, actual_CancelRoutine:int) returns (Tmp_148:int) {
var  r_1: int;
var  Tmp_149: int;
var  pirp_6: int;
var  CancelRoutine: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_6 := actual_pirp_6;
  CancelRoutine := actual_CancelRoutine;
  // done with preamble
  goto L8;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  call {:cexpr "pirp->CancelRoutine"} boogie_si_record_li2bpl_int(Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_6)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11491} {:print "Atomic Assignment"}  true;
    assume pirp_6 > 0;
    r_1 := Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_6)];  goto L10;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L10:
  call {:cexpr "CancelRoutine"} boogie_si_record_li2bpl_int(CancelRoutine);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11492} {:print "Atomic Assignment"}  true;
    assume pirp_6 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_6)] := CancelRoutine;  goto L11;
L11:
  call {:cexpr "r"} boogie_si_record_li2bpl_int(r_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11493} {:print "Atomic Assignment"}  true;
      Tmp_148 := r_1;  goto L12;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11493} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeWaitForSingleObject"} KeWaitForSingleObject(actual_Object:int, actual_WaitReason:int, actual_WaitMode:int, actual_Alertable:int, actual_Timeout:int) returns (Tmp_150:int) {
var  sdv_98: int;
var  x_3: int;
var  Tmp_151: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13132} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "Timeout"} boogie_si_record_li2bpl_int(Timeout);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13118} {:print "Atomic Conditional"}  true;
    if(*) { assume (Timeout == 0);  goto L9; } else { assume (Timeout != 0);  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13120} {:print "Atomic Assignment"}  true;
      Tmp_150 := 0;  goto L19;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13122} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L12; }
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13129} {:print "Atomic Assignment"}  true;
      Tmp_150 := 0;  goto L18;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13124} {:print "Atomic Assignment"}  true;
      Tmp_150 := 258;  goto L17;
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
procedure {:origName "sdv_IoSetCompletionRoutine"} sdv_IoSetCompletionRoutine(actual_pirp_7:int, actual_CompletionRoutine:int, actual_Context_2:int, actual_InvokeOnSuccess:int, actual_InvokeOnError:int, actual_InvokeOnCancel:int) {
var  sdv_99: int;
var  irpSp_6: int;
var  Tmp_152: int;
var  Tmp_153: int;
var  pirp_7: int;
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
  pirp_7 := actual_pirp_7;
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_7);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11508} {:print "Call \"sdv_IoSetCompletionRoutine\" \"sdv_IoGetNextIrpStackLocation\""}  true;
  call irpSp_6 := sdv_IoGetNextIrpStackLocation( pirp_7);   goto L8;
L8:
  call {:cexpr "CompletionRoutine"} boogie_si_record_li2bpl_int(CompletionRoutine);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11509} {:print "Atomic Assignment"}  true;
    assume irpSp_6 > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpSp_6)] := CompletionRoutine;  goto L17;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L17:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11510} {:print "Atomic Assignment"}  true;
      sdv_compFset := 1;  goto L18;
L18:
  call {:cexpr "Context"} boogie_si_record_li2bpl_int(Context_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11511} {:print "Atomic Assignment"}  true;
      sdv_context := Context_2;  goto L19;
L19:
  call {:cexpr "InvokeOnSuccess"} boogie_si_record_li2bpl_int(InvokeOnSuccess);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11512} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_success := InvokeOnSuccess;  goto L20;
L20:
  call {:cexpr "InvokeOnError"} boogie_si_record_li2bpl_int(InvokeOnError);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11513} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_error := InvokeOnError;  goto L21;
L21:
  call {:cexpr "InvokeOnCancel"} boogie_si_record_li2bpl_int(InvokeOnCancel);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11514} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_cancel := InvokeOnCancel;  goto L22;
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11516} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoRegisterDeviceInterface"} IoRegisterDeviceInterface(actual_PhysicalDeviceObject_1:int, actual_InterfaceClassGuid:int, actual_ReferenceString:int, actual_SymbolicLinkName:int) returns (Tmp_154:int) {
var  Tmp_155: int;
var  sdv_100: int;
var  Tmp_156: int;
var  choice_4: int;
var  PhysicalDeviceObject_1: int;
var  InterfaceClassGuid: int;
var  ReferenceString: int;
var  SymbolicLinkName: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  PhysicalDeviceObject_1 := actual_PhysicalDeviceObject_1;
  InterfaceClassGuid := actual_InterfaceClassGuid;
  ReferenceString := actual_ReferenceString;
  SymbolicLinkName := actual_SymbolicLinkName;
  // done with preamble
  goto L20;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11229} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11223} {:print "Atomic Continuation"}  true;
    if(*) {  goto L10; } else {  goto L17; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11227} {:print "Atomic Assignment"}  true;
      Tmp_154 := -1073741808;  goto L28;
L10:
  call {:cexpr "SymbolicLinkName->Buffer"} boogie_si_record_li2bpl_int(Mem_T.Buffer__STRING[Buffer__STRING(SymbolicLinkName)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11224} {:print "Atomic Conditional"}  true;
    if(*) { assume SymbolicLinkName > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(SymbolicLinkName)] != 0);  goto L23; } else { assume SymbolicLinkName > 0;
  assume (Mem_T.Buffer__STRING[Buffer__STRING(SymbolicLinkName)] == 0);  goto L24; }
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11226} {:print "Atomic Assignment"}  true;
      Tmp_154 := -1073741823;  goto L27;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11225} {:print "Atomic Assignment"}  true;
      Tmp_154 := 0;  goto L26;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L11; }
L19:
  call {:cexpr "Tmp"} boogie_si_record_li2bpl_int(Tmp_156);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11224} {:print "Atomic Continuation"}  true;
  assume(Tmp_156 != 0);   goto L25;
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L22:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L19;
L23:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_156 := 1;  goto L22;
L24:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_156 := 0;  goto L22;
L25:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L15;
L26:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L27:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L28:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_ExInterlockedInsertTailList"} sdv_ExInterlockedInsertTailList(actual_ListHead_2:int, actual_ListEntry:int, actual_Lock_1:int) returns (Tmp_157:int) {
var  sdv_101: int;
var  sdv_102: int;
var  x_4: int;
var  Tmp_158: int;
var  p_5: int;
var  ListHead_2: int;
var  ListEntry: int;
var  Lock_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  ListHead_2 := actual_ListHead_2;
  ListEntry := actual_ListEntry;
  Lock_1 := actual_Lock_1;
  // done with preamble
  goto L19;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L9;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7563} {:print "Return"}  true;
    goto LM2;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7558} {:print "Atomic Continuation"}  true;
    if(*) {  goto L10; } else {  goto L11; }
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7561} {:print "Atomic Assignment"}  true;
      p_5 := 0;  goto L23;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7560} {:print "Atomic Assignment"}  true;
      call sdv_101 := __HAVOC_malloc(1);  goto L14;
L14:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_101);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7560} {:print "Atomic Assignment"}  true;
      p_5 := sdv_101;  goto L21;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L21:
  call {:cexpr "p"} boogie_si_record_li2bpl_int(p_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7560} {:print "Atomic Assignment"}  true;
      Tmp_157 := p_5;  goto L22;
L22:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L23:
  call {:cexpr "p"} boogie_si_record_li2bpl_int(p_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7561} {:print "Atomic Assignment"}  true;
      Tmp_157 := p_5;  goto L24;
L24:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_Trap"} sdv_Trap() {
var  Tmp_159: int;
var  Tmp_160: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1294} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_RtlCopyMemory"} sdv_RtlCopyMemory(actual_Destination:int, actual_Source:int, actual_Length:int) {
var  Tmp_161: int;
var  Tmp_162: int;
var  Destination: int;
var  Source: int;
var  Length: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Destination := actual_Destination;
  Source := actual_Source;
  Length := actual_Length;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 15363} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "ExAllocatePoolWithTag"} ExAllocatePoolWithTag(actual_PoolType:int, actual_NumberOfBytes:int, actual_Tag:int) returns (Tmp_163:int) {
var  Tmp_164: int;
var  sdv_103: int;
var  sdv_104: int;
var  x_5: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7348} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7343} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7346} {:print "Atomic Assignment"}  true;
      Tmp_163 := 0;  goto L19;
L10:
  call {:cexpr "NumberOfBytes"} boogie_si_record_li2bpl_int(NumberOfBytes);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7345} {:print "Atomic Assignment"}  true;
      call sdv_103 := __HAVOC_malloc(NumberOfBytes);  goto L13;
L13:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_103);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7345} {:print "Atomic Assignment"}  true;
      Tmp_163 := sdv_103;  goto L18;
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
procedure {:origName "IoSetHardErrorOrVerifyDevice"} IoSetHardErrorOrVerifyDevice(actual_Irp_10:int, actual_DeviceObject_12:int) {
var  Tmp_165: int;
var  Tmp_166: int;
var  Irp_10: int;
var  DeviceObject_12: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Irp_10 := actual_Irp_10;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11573} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_stub_add_end"} sdv_stub_add_end() {
var  Tmp_167: int;
var  Tmp_168: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6757} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 0;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6758} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "ObReferenceObjectByHandle"} ObReferenceObjectByHandle(actual_Handle_1:int, actual_DesiredAccess:int, actual_ObjectType:int, actual_AccessMode:int, actual_Object_1:int, actual_HandleInformation:int) returns (Tmp_169:int) {
var  sdv_105: int;
var  x_6: int;
var  Tmp_170: int;
var  Handle_1: int;
var  DesiredAccess: int;
var  ObjectType: int;
var  AccessMode: int;
var  Object_1: int;
var  HandleInformation: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Handle_1 := actual_Handle_1;
  DesiredAccess := actual_DesiredAccess;
  ObjectType := actual_ObjectType;
  AccessMode := actual_AccessMode;
  Object_1 := actual_Object_1;
  HandleInformation := actual_HandleInformation;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14320} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14310} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14317} {:print "Atomic Assignment"}  true;
      Tmp_169 := -1073741823;  goto L16;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14311} {:print "Atomic Assignment"}  true;
      Tmp_169 := 0;  goto L15;
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
procedure {:origName "sdv_IoCopyCurrentIrpStackLocationToNext"} sdv_IoCopyCurrentIrpStackLocationToNext(actual_pirp_8:int) {
var  Tmp_171: int;
var  Tmp_172: int;
var  pirp_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_8 := actual_pirp_8;
  // done with preamble
  goto L12;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10188} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_8);
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_8 != sdv_harnessIrp);  goto L4; } else { assume (pirp_8 == sdv_harnessIrp);  goto L5; }
L4:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_8);
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Conditional"}  true;
    if(*) { assume (pirp_8 != sdv_other_harnessIrp);  goto L1; } else { assume (pirp_8 == sdv_other_harnessIrp);  goto L7; }
L5:
  call {:cexpr "sdv_harnessStackLocation.MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];  goto L14;
L7:
  call {:cexpr "sdv_other_harnessStackLocation.MinorFunction"} boogie_si_record_li2bpl_int(Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];  goto L16;
L12:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L14:
  call {:cexpr "sdv_harnessStackLocation.MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];  goto L15;
L15:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L16:
  call {:cexpr "sdv_other_harnessStackLocation.MajorFunction"} boogie_si_record_li2bpl_int(Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10187} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];  goto L17;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_KeReleaseSpinLock"} sdv_KeReleaseSpinLock(actual_SpinLock_1:int, actual_new_1:int) {
var  Tmp_173: int;
var  Tmp_174: int;
var  SpinLock_1: int;
var  new_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SpinLock_1 := actual_SpinLock_1;
  new_1 := actual_new_1;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "new"} boogie_si_record_li2bpl_int(new_1);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13010} {:print "Atomic Assignment"}  true;
      sdv_irql_current := new_1;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13010} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L10;
L10:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13010} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13011} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_SetStatus"} sdv_SetStatus(actual_pirp_9:int) {
var  sdv_106: int;
var  Tmp_175: int;
var  choice_5: int;
var  Tmp_176: int;
var  pirp_9: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_9 := actual_pirp_9;
  // done with preamble
  goto L16;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1506} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1497} {:print "Atomic Continuation"}  true;
    if(*) {  goto L10; } else {  goto L14; }
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1499} {:print "Atomic Assignment"}  true;
    assume pirp_9 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_9))] := -1073741637;  goto L18;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1503} {:print "Atomic Assignment"}  true;
    assume pirp_9 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_9))] := 0;  goto L19;
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
var  Tmp_177: int;
var  Tmp_178: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6708} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "_sdv_init2"} _sdv_init2() {
var  Tmp_179: int;
var  Tmp_180: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 75} {:print "Atomic Assignment"}  true;
      sdv_dpc_io_registered := 0;  goto L10;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L8:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L6;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 77} {:print "Atomic Assignment"}  true;
      sdv_apc_disabled := 0;  goto L11;
L11:
  call {:cexpr "&sdv_ControllerIrp"} boogie_si_record_li2bpl_int(sdv_ControllerIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 82} {:print "Atomic Assignment"}  true;
      sdv_ControllerPirp := sdv_ControllerIrp;  goto L12;
L12:
  call {:cexpr "&sdv_StartIoIrp"} boogie_si_record_li2bpl_int(sdv_StartIoIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 85} {:print "Atomic Assignment"}  true;
      sdv_StartIopirp := sdv_StartIoIrp;  goto L13;
L13:
  call {:cexpr "&sdv_PowerIrp"} boogie_si_record_li2bpl_int(sdv_PowerIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 89} {:print "Atomic Assignment"}  true;
      sdv_power_irp := sdv_PowerIrp;  goto L14;
L14:
  call {:cexpr "&sdv_harnessIrp"} boogie_si_record_li2bpl_int(sdv_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 93} {:print "Atomic Assignment"}  true;
      sdv_irp := sdv_harnessIrp;  goto L15;
L15:
  call {:cexpr "&sdv_other_harnessIrp"} boogie_si_record_li2bpl_int(sdv_other_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 100} {:print "Atomic Assignment"}  true;
      sdv_other_irp := sdv_other_harnessIrp;  goto L16;
L16:
  call {:cexpr "&sdv_IoMakeAssociatedIrp_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoMakeAssociatedIrp_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 105} {:print "Atomic Assignment"}  true;
      sdv_IoMakeAssociatedIrp_irp := sdv_IoMakeAssociatedIrp_harnessIrp;  goto L17;
L17:
  call {:cexpr "&sdv_IoBuildDeviceIoControlRequest_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 110} {:print "Atomic Assignment"}  true;
      sdv_IoBuildDeviceIoControlRequest_irp := sdv_IoBuildDeviceIoControlRequest_harnessIrp;  goto L18;
L18:
  call {:cexpr "&sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock"} boogie_si_record_li2bpl_int(sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 114} {:print "Atomic Assignment"}  true;
      sdv_IoBuildDeviceIoControlRequest_IoStatusBlock := sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock;  goto L19;
L19:
  call {:cexpr "&sdv_IoBuildSynchronousFsdRequest_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 121} {:print "Atomic Assignment"}  true;
      sdv_IoBuildSynchronousFsdRequest_irp := sdv_IoBuildSynchronousFsdRequest_harnessIrp;  goto L20;
L20:
  call {:cexpr "&sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock"} boogie_si_record_li2bpl_int(sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 125} {:print "Atomic Assignment"}  true;
      sdv_IoBuildSynchronousFsdRequest_IoStatusBlock := sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;  goto L21;
L21:
  call {:cexpr "&sdv_IoBuildAsynchronousFsdRequest_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 129} {:print "Atomic Assignment"}  true;
      sdv_IoBuildAsynchronousFsdRequest_irp := sdv_IoBuildAsynchronousFsdRequest_harnessIrp;  goto L22;
L22:
  call {:cexpr "&sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock"} boogie_si_record_li2bpl_int(sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 133} {:print "Atomic Assignment"}  true;
      sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock := sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;  goto L23;
L23:
  call {:cexpr "&sdv_IoInitializeIrp_harnessIrp"} boogie_si_record_li2bpl_int(sdv_IoInitializeIrp_harnessIrp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 138} {:print "Atomic Assignment"}  true;
      sdv_IoInitializeIrp_irp := sdv_IoInitializeIrp_harnessIrp;  goto L24;
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 153} {:print "Atomic Assignment"}  true;
      sdv_io_create_device_called := 0;  goto L25;
L25:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 196} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 0;  goto L26;
L26:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 197} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := 0;  goto L27;
L27:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 198} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := 0;  goto L28;
L28:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 199} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := 0;  goto L29;
L29:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 201} {:print "Atomic Assignment"}  true;
      sdv_maskedEflags := 0;  goto L30;
L30:
  call {:cexpr "&sdv_kdpc_val3"} boogie_si_record_li2bpl_int(sdv_kdpc_val3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 209} {:print "Atomic Assignment"}  true;
      sdv_kdpc3 := sdv_kdpc_val3;  goto L31;
L31:
  call {:cexpr "&sdv_devobj_fdo"} boogie_si_record_li2bpl_int(sdv_devobj_fdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 229} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_fdo := sdv_devobj_fdo;  goto L32;
L32:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 232} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 0;  goto L33;
L33:
  call {:cexpr "&sdv_devobj_pdo"} boogie_si_record_li2bpl_int(sdv_devobj_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 237} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_pdo := sdv_devobj_pdo;  goto L34;
L34:
  call {:cexpr "&sdv_devobj_child_pdo"} boogie_si_record_li2bpl_int(sdv_devobj_child_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 241} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_child_pdo := sdv_devobj_child_pdo;  goto L35;
L35:
  call {:cexpr "&sdv_kinterrupt_val"} boogie_si_record_li2bpl_int(sdv_kinterrupt_val);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 245} {:print "Atomic Assignment"}  true;
      sdv_kinterrupt := sdv_kinterrupt_val;  goto L36;
L36:
  call {:cexpr "&sdv_MapRegisterBase_val"} boogie_si_record_li2bpl_int(sdv_MapRegisterBase_val);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 248} {:print "Atomic Assignment"}  true;
      sdv_MapRegisterBase := sdv_MapRegisterBase_val;  goto L37;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 252} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_success := 0;  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 255} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_error := 0;  goto L39;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 258} {:print "Atomic Assignment"}  true;
      sdv_invoke_on_cancel := 0;  goto L40;
L40:
  call {:cexpr "&sdv_fx_dev_object"} boogie_si_record_li2bpl_int(sdv_fx_dev_object);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 264} {:print "Atomic Assignment"}  true;
      p_sdv_fx_dev_object := sdv_fx_dev_object;  goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1211} {:print "Atomic Assignment"}  true;
      sdv_start_irp_already_issued := 0;  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1212} {:print "Atomic Assignment"}  true;
      sdv_remove_irp_already_issued := 0;  goto L43;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1213} {:print "Atomic Assignment"}  true;
      sdv_Io_Removelock_release_wait_returned := 0;  goto L44;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1216} {:print "Atomic Assignment"}  true;
      sdv_compFset := 0;  goto L45;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1227} {:print "Atomic Assignment"}  true;
      sdv_isr_routine := 281;  goto L46;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1242} {:print "Atomic Assignment"}  true;
      sdv_ke_dpc := 283;  goto L47;
L47:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1244} {:print "Atomic Assignment"}  true;
      sdv_dpc_ke_registered := 0;  goto L48;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1258} {:print "Atomic Assignment"}  true;
      sdv_io_dpc := 286;  goto L49;
L49:
  call {:cexpr "&sdv_devobj_top"} boogie_si_record_li2bpl_int(sdv_devobj_top);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9504} {:print "Atomic Assignment"}  true;
      sdv_p_devobj_top := sdv_devobj_top;  goto L50;
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13869} {:print "Atomic Assignment"}  true;
      sdv_MmMapIoSpace_int := 0;  goto L51;
L51:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "PsCreateSystemThread"} PsCreateSystemThread(actual_ThreadHandle:int, actual_DesiredAccess_1:int, actual_ObjectAttributes:int, actual_ProcessHandle:int, actual_ClientId:int, actual_StartRoutine:int, actual_StartContext:int) returns (Tmp_181:int) {
var  Tmp_182: int;
var  sdv_107: int;
var  x_7: int;
var  ThreadHandle: int;
var  DesiredAccess_1: int;
var  ObjectAttributes: int;
var  ProcessHandle: int;
var  ClientId: int;
var  StartRoutine: int;
var  StartContext: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  ThreadHandle := actual_ThreadHandle;
  DesiredAccess_1 := actual_DesiredAccess_1;
  ObjectAttributes := actual_ObjectAttributes;
  ProcessHandle := actual_ProcessHandle;
  ClientId := actual_ClientId;
  StartRoutine := actual_StartRoutine;
  StartContext := actual_StartContext;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14911} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14899} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14909} {:print "Atomic Assignment"}  true;
      Tmp_181 := -1073741823;  goto L16;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14908} {:print "Atomic Assignment"}  true;
      Tmp_181 := 0;  goto L15;
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
procedure {:origName "sdv_stub_dispatch_end"} sdv_stub_dispatch_end(actual_s_1:int, actual_pirp_10:int) {
var  Tmp_183: int;
var  Tmp_184: int;
var  s_1: int;
var  pirp_10: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  s_1 := actual_s_1;
  pirp_10 := actual_pirp_10;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6749} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_RunStartDevice"} sdv_RunStartDevice(actual_po:int, actual_pirp_11:int) returns (Tmp_185:int) {
var  sdv_108: int;
var  status_3: int;
var  Tmp_186: int;
var  ps: int;
var  po: int;
var  pirp_11: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  po := actual_po;
  pirp_11 := actual_pirp_11;
  // done with preamble
  goto L35;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4136} {:print "Atomic Assignment"}  true;
      status_3 := 0;  goto L37;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4146} {:print "Atomic Assignment"}  true;
      sdv_start_irp_already_issued := 1;  goto L44;
L23:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4153} {:print "Call \"sdv_RunStartDevice\" \"FloppyPnp\""}  true;
  call status_3 := FloppyPnp( po, pirp_11);   goto L49;
L27:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(status_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4155} {:print "Call \"sdv_RunStartDevice\" \"sdv_stub_dispatch_end\""}  true;
  call sdv_stub_dispatch_end( status_3, 0);   goto L30;
L30:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4157} {:print "Atomic Assignment"}  true;
      Tmp_185 := status_3;  goto L51;
L32:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_11);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
   assume alias8(SLAM_guard_S_0, pirp_11);
    if(*) { assume (!((pirp_11 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L27; } else { assume ((pirp_11 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L33; }
L33:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4153} {:print "Call \"sdv_RunStartDevice\" \"SLIC_FloppyPnp_exit\""}  true;
  call SLIC_FloppyPnp_exit( strConst__li2bpl3);   goto L50;
L35:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L37:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_11)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4138} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    ps := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_11)))];  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4139} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 27;  goto L39;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4140} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] := 0;  goto L40;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4141} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_11))] := 0;  goto L41;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4142} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_11)] := 0;  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4143} {:print "Atomic Assignment"}  true;
    assume pirp_11 > 0;
    Mem_T.Cancel__IRP[Cancel__IRP(pirp_11)] := 0;  goto L43;
L43:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4145} {:print "Call \"sdv_RunStartDevice\" \"sdv_SetStatus\""}  true;
  call sdv_SetStatus( pirp_11);   goto L15;
L44:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4147} {:print "Atomic Assignment"}  true;
    assume ps > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(ps)] := 0;  goto L45;
L45:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4148} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := 0;  goto L46;
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4148} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := 0;  goto L47;
L47:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4148} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation)] := 0;  goto L48;
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4150} {:print "Call \"sdv_RunStartDevice\" \"sdv_stub_dispatch_begin\""}  true;
  call sdv_stub_dispatch_begin();   goto L23;
L49:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L32; }
L50:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L27; }
L51:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 4157} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_stub_add_begin"} sdv_stub_add_begin() {
var  Tmp_187: int;
var  Tmp_188: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6753} {:print "Atomic Assignment"}  true;
      sdv_inside_init_entrypoint := 1;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6754} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoCreateDevice"} IoCreateDevice(actual_DriverObject_3:int, actual_DeviceExtensionSize:int, actual_DeviceName_1:int, actual_DeviceType:int, actual_DeviceCharacteristics:int, actual_Exclusive:int, actual_DeviceObject_13:int) returns (Tmp_189:int) {
var  Tmp_190: int;
var  sdv_109: int;
var  choice_6: int;
var  DriverObject_3: int;
var  DeviceExtensionSize: int;
var  DeviceName_1: int;
var  DeviceType: int;
var  DeviceCharacteristics: int;
var  Exclusive: int;
var  DeviceObject_13: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DriverObject_3 := actual_DriverObject_3;
  DeviceExtensionSize := actual_DeviceExtensionSize;
  DeviceName_1 := actual_DeviceName_1;
  DeviceType := actual_DeviceType;
  DeviceCharacteristics := actual_DeviceCharacteristics;
  Exclusive := actual_Exclusive;
  DeviceObject_13 := actual_DeviceObject_13;
  // done with preamble
  goto L29;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10240} {:print "Return"}  true;
    goto LM2;
L8:
  call {:cexpr "sdv_io_create_device_called"} boogie_si_record_li2bpl_int(sdv_io_create_device_called);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10219} {:print "Atomic Assignment"}  true;
      sdv_io_create_device_called := (sdv_io_create_device_called + 1);  goto L31;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10238} {:print "Atomic Assignment"}  true;
    assume DeviceObject_13 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_13] := 0;  goto L43;
L11:
  call {:cexpr "sdv_inside_init_entrypoint"} boogie_si_record_li2bpl_int(sdv_inside_init_entrypoint);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10224} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_inside_init_entrypoint == 0);  goto L18; } else { assume (sdv_inside_init_entrypoint != 0);  goto L19; }
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10235} {:print "Atomic Assignment"}  true;
    assume DeviceObject_13 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_13] := 0;  goto L37;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10236} {:print "Atomic Assignment"}  true;
    assume DeviceObject_13 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_13] := 0;  goto L39;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10237} {:print "Atomic Assignment"}  true;
    assume DeviceObject_13 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_13] := 0;  goto L41;
L18:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10231} {:print "Atomic Assignment"}  true;
    assume sdv_p_devobj_child_pdo > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(sdv_p_devobj_child_pdo)] := 128;  goto L35;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10226} {:print "Atomic Assignment"}  true;
    assume sdv_p_devobj_fdo > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(sdv_p_devobj_fdo)] := 128;  goto L32;
L21:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10234} {:print "Atomic Assignment"}  true;
      Tmp_189 := 0;  goto L34;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10221} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L27; }
L32:
  call {:cexpr "sdv_p_devobj_fdo"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10227} {:print "Atomic Assignment"}  true;
    assume DeviceObject_13 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_13] := sdv_p_devobj_fdo;  goto L33;
L33:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L21;
L34:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L35:
  call {:cexpr "sdv_p_devobj_child_pdo"} boogie_si_record_li2bpl_int(sdv_p_devobj_child_pdo);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10232} {:print "Atomic Assignment"}  true;
    assume DeviceObject_13 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_13] := sdv_p_devobj_child_pdo;  goto L36;
L36:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L21;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10235} {:print "Atomic Assignment"}  true;
      Tmp_189 := -1073741823;  goto L38;
L38:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10236} {:print "Atomic Assignment"}  true;
      Tmp_189 := -1073741670;  goto L40;
L40:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10237} {:print "Atomic Assignment"}  true;
      Tmp_189 := -1073741824;  goto L42;
L42:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L43:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10238} {:print "Atomic Assignment"}  true;
      Tmp_189 := -1073741771;  goto L44;
L44:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "MmResetDriverPaging"} MmResetDriverPaging(actual_AddressWithinSection_1:int) {
var  Tmp_191: int;
var  Tmp_192: int;
var  AddressWithinSection_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  AddressWithinSection_1 := actual_AddressWithinSection_1;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13932} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "IoDeleteDevice"} IoDeleteDevice(actual_DeviceObject_14:int) {
var  Tmp_193: int;
var  Tmp_194: int;
var  DeviceObject_14: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_14 := actual_DeviceObject_14;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10529} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_NullDereferenceTrap"} sdv_NullDereferenceTrap(actual_p_6:int) {
var  Tmp_195: int;
var  Tmp_196: int;
var  p_6: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  p_6 := actual_p_6;
  // done with preamble
  goto L9;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1303} {:print "Return"}  true;
    goto LM2;
L3:
  call {:cexpr "p"} boogie_si_record_li2bpl_int(p_6);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1302} {:print "Atomic Conditional"}  true;
    if(*) { assume (p_6 != 0);  goto L1; } else { assume (p_6 == 0);  goto L4; }
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1302} {:print "Call \"sdv_NullDereferenceTrap\" \"sdv_Trap\""}  true;
  call sdv_Trap();   goto L1;
L9:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "IoSetDeviceInterfaceState"} IoSetDeviceInterfaceState(actual_SymbolicLinkName_1:int, actual_Enable:int) returns (Tmp_197:int) {
var  sdv_110: int;
var  Tmp_198: int;
var  choice_7: int;
var  SymbolicLinkName_1: int;
var  Enable: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  SymbolicLinkName_1 := actual_SymbolicLinkName_1;
  Enable := actual_Enable;
  // done with preamble
  goto L21;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11564} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11555} {:print "Atomic Continuation"}  true;
    if(*) {  goto L10; } else {  goto L19; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11562} {:print "Atomic Assignment"}  true;
      Tmp_197 := -1073741824;  goto L28;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11557} {:print "Atomic Assignment"}  true;
      Tmp_197 := 0;  goto L23;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11558} {:print "Atomic Assignment"}  true;
      Tmp_197 := -1073741808;  goto L24;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11559} {:print "Atomic Assignment"}  true;
      Tmp_197 := -1073741670;  goto L25;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11560} {:print "Atomic Assignment"}  true;
      Tmp_197 := -1073741789;  goto L26;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11561} {:print "Atomic Assignment"}  true;
      Tmp_197 := -1073741772;  goto L27;
L16:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L14; }
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L13; } else {  goto L16; }
L18:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L12; } else {  goto L17; }
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L11; } else {  goto L18; }
L21:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L23:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L24:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L25:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L26:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L27:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L28:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "PsTerminateSystemThread"} PsTerminateSystemThread(actual_ExitStatus:int) returns (Tmp_199:int) {
var  sdv_111: int;
var  x_8: int;
var  Tmp_200: int;
var  ExitStatus: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  ExitStatus := actual_ExitStatus;
  // done with preamble
  goto L17;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14978} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14972} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L16; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14976} {:print "Atomic Assignment"}  true;
      Tmp_199 := -1073741823;  goto L21;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14975} {:print "Atomic Assignment"}  true;
      Tmp_199 := 0;  goto L20;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14974} {:print "Atomic Continuation"}  true;
  assume(false);   goto L19;
L17:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L19:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L13;
L20:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L21:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_RunIoCompletionRoutines"} sdv_RunIoCompletionRoutines(actual_DeviceObject_15:int, actual_Irp_11:int, actual_Context_3:int, actual_Completion:int) returns (Tmp_201:int) {
var  sdv_112: int;
var  sdv_113: int;
var  irpsp: int;
var  Status: int;
var  Tmp_202: int;
var  DeviceObject_15: int;
var  Irp_11: int;
var  Context_3: int;
var  Completion: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_15 := actual_DeviceObject_15;
  Irp_11 := actual_Irp_11;
  Context_3 := actual_Context_3;
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(Irp_11);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3202} {:print "Call \"sdv_RunIoCompletionRoutines\" \"sdv_IoGetNextIrpStackLocation\""}  true;
  call irpsp := sdv_IoGetNextIrpStackLocation( Irp_11);   goto L9;
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3203} {:print "Atomic Assignment"}  true;
      Status := 0;  goto L28;
L11:
  call {:cexpr "Status"} boogie_si_record_li2bpl_int(Status);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3312} {:print "Atomic Assignment"}  true;
      Tmp_201 := Status;  goto L37;
L12:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_3 := sdv_irql_previous_2;  goto L29;
L20:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3209} {:print "Atomic Assignment"}  true;
      sdv_irql_current := sdv_irql_previous;  goto L33;
L26:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L28:
  call {:cexpr "irpsp->CompletionRoutine"} boogie_si_record_li2bpl_int(Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3205} {:print "Atomic Conditional"}  true;
    if(*) { assume irpsp > 0;
  assume (Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)] != 213);  goto L11; } else { assume irpsp > 0;
  assume (Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpsp)] == 213);  goto L12; }
L29:
  call {:cexpr "sdv_irql_previous"} boogie_si_record_li2bpl_int(sdv_irql_previous);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous;  goto L30;
L30:
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_current;  goto L31;
L31:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3207} {:print "Atomic Assignment"}  true;
      sdv_irql_current := 2;  goto L32;
L32:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(DeviceObject_15);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_11);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(Context_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3208} {:print "Call \"sdv_RunIoCompletionRoutines\" \"FloppyPnpComplete\""}  true;
  call Status := FloppyPnpComplete( DeviceObject_15, Irp_11, Context_3);   goto L20;
L33:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3209} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L34;
L34:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3209} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L35;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3210} {:print "Atomic Assignment"}  true;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;  goto L36;
L36:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L11;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 3312} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "IoReleaseCancelSpinLock"} IoReleaseCancelSpinLock(actual_new_2:int) {
var  Tmp_203: int;
var  Tmp_204: int;
var  new_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  new_2 := actual_new_2;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "new"} boogie_si_record_li2bpl_int(new_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11293} {:print "Atomic Assignment"}  true;
      sdv_irql_current := new_2;  goto L9;
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L9:
  call {:cexpr "sdv_irql_previous_2"} boogie_si_record_li2bpl_int(sdv_irql_previous_2);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11293} {:print "Atomic Assignment"}  true;
      sdv_irql_previous := sdv_irql_previous_2;  goto L10;
L10:
  call {:cexpr "sdv_irql_previous_3"} boogie_si_record_li2bpl_int(sdv_irql_previous_3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11293} {:print "Atomic Assignment"}  true;
      sdv_irql_previous_2 := sdv_irql_previous_3;  goto L11;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11294} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_IoIsErrorUserInduced"} sdv_IoIsErrorUserInduced(actual_Status_1:int) returns (Tmp_205:int) {
var  sdv_114: int;
var  choice_8: int;
var  Tmp_206: int;
var  Status_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Status_1 := actual_Status_1;
  // done with preamble
  goto L13;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11027} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11023} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11025} {:print "Atomic Assignment"}  true;
      Tmp_205 := 1;  goto L16;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11024} {:print "Atomic Assignment"}  true;
      Tmp_205 := 0;  goto L15;
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
procedure {:origName "sdv_KeGetCurrentIrql"} sdv_KeGetCurrentIrql() returns (Tmp_207:int) {
var  Tmp_208: int;
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
  call {:cexpr "sdv_irql_current"} boogie_si_record_li2bpl_int(sdv_irql_current);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12756} {:print "Atomic Assignment"}  true;
      Tmp_207 := sdv_irql_current;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 12756} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_InitializeObjectAttributes"} sdv_InitializeObjectAttributes(actual_p_7:int, actual_n:int, actual_a:int, actual_r_2:int, actual_s_2:int) {
var  Tmp_209: int;
var  Tmp_210: int;
var  p_7: int;
var  n: int;
var  a: int;
var  r_2: int;
var  s_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  p_7 := actual_p_7;
  n := actual_n;
  a := actual_a;
  r_2 := actual_r_2;
  s_2 := actual_s_2;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 18471} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_IoGetCurrentIrpStackLocation"} sdv_IoGetCurrentIrpStackLocation(actual_pirp_12:int) returns (Tmp_211:int) {
var  Tmp_212: int;
var  pirp_12: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_12 := actual_pirp_12;
  // done with preamble
  goto L5;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L3;
L3:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_12)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10707} {:print "Atomic Assignment"}  true;
    assume pirp_12 > 0;
    Tmp_211 := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_12)))];  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10707} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_ExInitializeFastMutex"} sdv_ExInitializeFastMutex(actual_FastMutex_2:int) {
var  Tmp_213: int;
var  Tmp_214: int;
var  FastMutex_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  FastMutex_2 := actual_FastMutex_2;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7414} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "IofCallDriver"} IofCallDriver(actual_DeviceObject_16:int, actual_Irp_12:int) returns (Tmp_215:int) {
var  {:dopa}  completion: int;
var  sdv_115: int;
var  sdv_116: int;
var  sdv_117: int;
var  sdv_118: int;
var  sdv_119: int;
var  status_4: int;
var  Tmp_216: int;
var  choice_9: int;
var  DeviceObject_16: int;
var  Irp_12: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call completion := __HAVOC_malloc(4);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_16 := actual_DeviceObject_16;
  Irp_12 := actual_Irp_12;
  // done with preamble
  goto L92;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L5:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9950} {:print "Atomic Assignment"}  true;
    assume completion > 0;
    Mem_T.INT4[completion] := 0;  goto L94;
L11:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9953} {:print "Atomic Assignment"}  true;
      status_4 := 259;  goto L95;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10023} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := -1073741823;  goto L112;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9957} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := 0;  goto L96;
L15:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9979} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := -1073741536;  goto L102;
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10001} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := 259;  goto L107;
L19:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10007} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_12);  goto L21; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_12);  goto L22; }
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10005} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 259;  goto L109;
L21:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10011} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_12);  goto L23; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_12);  goto L24; }
L22:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10009} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 259;  goto L110;
L23:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10016} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset != 0);  goto L26; } else { assume (sdv_compFset == 0);  goto L29; }
L24:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10013} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 259;  goto L111;
L26:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_12);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10018} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_118 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_12, sdv_context, completion);   goto L29;
L29:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_4);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10045} {:print "Atomic Assignment"}  true;
      Tmp_215 := status_4;  goto L101;
L32:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9985} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_12);  goto L34; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_12);  goto L35; }
L33:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9983} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741536;  goto L104;
L34:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9989} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_12);  goto L36; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_12);  goto L37; }
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9987} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741536;  goto L105;
L36:
  call {:cexpr "sdv_invoke_on_cancel"} boogie_si_record_li2bpl_int(sdv_invoke_on_cancel);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9994} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_invoke_on_cancel == 0);  goto L29; } else { assume (sdv_invoke_on_cancel != 0);  goto L39; }
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9991} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741536;  goto L106;
L39:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9994} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset == 0);  goto L29; } else { assume (sdv_compFset != 0);  goto L40; }
L40:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_12);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9996} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_117 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_12, sdv_context, completion);   goto L29;
L45:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9963} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_12);  goto L47; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_12);  goto L48; }
L46:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9961} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 0;  goto L98;
L47:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9967} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_12);  goto L49; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_12);  goto L50; }
L48:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9965} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 0;  goto L99;
L49:
  call {:cexpr "sdv_invoke_on_success"} boogie_si_record_li2bpl_int(sdv_invoke_on_success);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9972} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_invoke_on_success == 0);  goto L29; } else { assume (sdv_invoke_on_success != 0);  goto L52; }
L50:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9969} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 0;  goto L100;
L52:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9972} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset == 0);  goto L29; } else { assume (sdv_compFset != 0);  goto L53; }
L53:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_12);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9974} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_116 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_12, sdv_context, completion);   goto L29;
L58:
  call {:cexpr "sdv_IoBuildSynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildSynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10029} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildSynchronousFsdRequest_irp != Irp_12);  goto L60; } else { assume (sdv_IoBuildSynchronousFsdRequest_irp == Irp_12);  goto L61; }
L59:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10027} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741823;  goto L114;
L60:
  call {:cexpr "sdv_IoBuildAsynchronousFsdRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildAsynchronousFsdRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10033} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildAsynchronousFsdRequest_irp != Irp_12);  goto L62; } else { assume (sdv_IoBuildAsynchronousFsdRequest_irp == Irp_12);  goto L63; }
L61:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10031} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741823;  goto L115;
L62:
  call {:cexpr "sdv_invoke_on_error"} boogie_si_record_li2bpl_int(sdv_invoke_on_error);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10038} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_invoke_on_error == 0);  goto L29; } else { assume (sdv_invoke_on_error != 0);  goto L65; }
L63:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10035} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741823;  goto L116;
L65:
  call {:cexpr "sdv_compFset"} boogie_si_record_li2bpl_int(sdv_compFset);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10038} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_compFset == 0);  goto L29; } else { assume (sdv_compFset != 0);  goto L66; }
L66:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(sdv_p_devobj_fdo);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(Irp_12);
  call {:cexpr "arg3"} boogie_si_record_li2bpl_int(sdv_context);
  call {:cexpr "arg4"} boogie_si_record_li2bpl_int(completion);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10040} {:print "Call \"IofCallDriver\" \"sdv_RunIoCompletionRoutines\""}  true;
  call sdv_115 := sdv_RunIoCompletionRoutines( sdv_p_devobj_fdo, Irp_12, sdv_context, completion);   goto L29;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9954} {:print "Atomic Continuation"}  true;
    if(*) {  goto L14; } else {  goto L71; }
L96:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9958} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_12)] := 0;  goto L97;
L97:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9959} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_12);  goto L45; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_12);  goto L46; }
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10045} {:print "Return"}  true;
    goto LM2;
L102:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9980} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_12)] := 0;  goto L103;
L103:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9981} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_12);  goto L32; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_12);  goto L33; }
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10002} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_12)] := 1;  goto L108;
L108:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10003} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_12);  goto L19; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_12);  goto L20; }
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10024} {:print "Atomic Assignment"}  true;
    assume Irp_12 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(Irp_12)] := 0;  goto L113;
L113:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  call {:cexpr "Irp"} boogie_si_record_li2bpl_int(Irp_12);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10025} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_IoBuildDeviceIoControlRequest_irp != Irp_12);  goto L58; } else { assume (sdv_IoBuildDeviceIoControlRequest_irp == Irp_12);  goto L59; }
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
procedure {:origName "sdv_stub_WmiIrpProcessed"} sdv_stub_WmiIrpProcessed(actual_pirp_13:int) {
var  Tmp_217: int;
var  Tmp_218: int;
var  pirp_13: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_13 := actual_pirp_13;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 6802} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_KeInitializeSpinLock"} sdv_KeInitializeSpinLock(actual_SpinLock_2:int) {
var  Tmp_219: int;
var  Tmp_220: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13264} {:print "Atomic Assignment"}  true;
    assume SpinLock_2 > 0;
    Mem_T.INT4[SpinLock_2] := 0;  goto L8;
L6:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13266} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_DoNothing"} sdv_DoNothing() returns (Tmp_221:int) {
var  Tmp_222: int;
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
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1515} {:print "Atomic Assignment"}  true;
      Tmp_221 := -1073741823;  goto L7;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L7:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1515} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sdv_IoMarkIrpPending"} sdv_IoMarkIrpPending(actual_pirp_14:int) {
var  Tmp_223: int;
var  Tmp_224: int;
var  pirp_14: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  pirp_14 := actual_pirp_14;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 11085} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "sdv_RunDispatchFunction"} sdv_RunDispatchFunction(actual_po_1:int, actual_pirp_15:int) returns (Tmp_225:int) {
var  sdv_120: int;
var  sdv_121: int;
var  sdv_122: int;
var  sdv_123: int;
var  sdv_124: int;
var  sdv_125: int;
var  x_9: int;
var  Tmp_226: int;
var  status_5: int;
var  ps_1: int;
var  minor: int;
var  po_1: int;
var  pirp_15: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  po_1 := actual_po_1;
  pirp_15 := actual_pirp_15;
  // done with preamble
  goto L72;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L4;
L4:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1617} {:print "Atomic Assignment"}  true;
      status_5 := 0;  goto L74;
L14:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_124);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1620} {:print "Atomic Assignment"}  true;
      minor := sdv_124;  goto L75;
L23:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1628} {:print "Atomic Assignment"}  true;
    assume pirp_15 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_15)] := 0;  goto L80;
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1641} {:print "Atomic Continuation"}  true;
    if(*) {  goto L38; } else {  goto L64; }
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1998} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_5 := sdv_DoNothing();   goto L48;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1664} {:print "Atomic Assignment"}  true;
    assume ps_1 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_1)] := 2;  goto L88;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1732} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_DoNothing\""}  true;
  call status_5 := sdv_DoNothing();   goto L48;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1853} {:print "Atomic Assignment"}  true;
    assume ps_1 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps_1)] := 23;  goto L92;
L48:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(status_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 2002} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_stub_dispatch_end\""}  true;
  call sdv_stub_dispatch_end( status_5, 0);   goto L51;
L51:
  call {:cexpr "pirp->IoStatus.Information"} boogie_si_record_li2bpl_int(Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_15))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 2004} {:print "Atomic Assignment"}  true;
    assume pirp_15 > 0;
    sdv_end_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_15))];  goto L90;
L63:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L35; } else {  goto L42; }
L64:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    if(*) {  goto L39; } else {  goto L63; }
L66:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_15);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
   assume alias9(SLAM_guard_S_0, pirp_15);
    if(*) { assume (!((pirp_15 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L48; } else { assume ((pirp_15 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L67; }
L67:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1666} {:print "Call \"sdv_RunDispatchFunction\" \"SLIC_FloppyCreateClose_exit\""}  true;
  call SLIC_FloppyCreateClose_exit( strConst__li2bpl3);   goto L89;
L69:
  call {:cexpr "pirp"} boogie_si_record_li2bpl_int(pirp_15);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "SLAM_guard_S_0"} boogie_si_record_li2bpl_int(SLAM_guard_S_0);
  call {:cexpr "&SLAM_guard_S_0_init"} boogie_si_record_li2bpl_int(SLAM_guard_S_0_init);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (!((pirp_15 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init)));  goto L48; } else { assume ((pirp_15 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init));  goto L70; }
L70:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl3);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1855} {:print "Call \"sdv_RunDispatchFunction\" \"SLIC_FloppySystemControl_exit\""}  true;
  call SLIC_FloppySystemControl_exit( strConst__li2bpl3);   goto L93;
L72:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L74:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L14;
L75:
  call {:cexpr "pirp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_15)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1622} {:print "Atomic Assignment"}  true;
    assume pirp_15 > 0;
    ps_1 := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(pirp_15)))];  goto L76;
L76:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1623} {:print "Atomic Assignment"}  true;
    assume pirp_15 > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(pirp_15)] := 0;  goto L77;
L77:
  call {:cexpr "pirp->IoStatus.Information"} boogie_si_record_li2bpl_int(Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_15))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1624} {:print "Atomic Assignment"}  true;
    assume pirp_15 > 0;
    sdv_start_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_15))];  goto L78;
L78:
  call {:cexpr "sdv_start_info"} boogie_si_record_li2bpl_int(sdv_start_info);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1624} {:print "Atomic Assignment"}  true;
      sdv_end_info := sdv_start_info;  goto L79;
L79:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(pirp_15);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1626} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_SetStatus\""}  true;
  call sdv_SetStatus( pirp_15);   goto L23;
L80:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1629} {:print "Atomic Assignment"}  true;
    assume pirp_15 > 0;
    Mem_T.Cancel__IRP[Cancel__IRP(pirp_15)] := 0;  goto L81;
L81:
  call {:cexpr "minor"} boogie_si_record_li2bpl_int(minor);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1633} {:print "Atomic Assignment"}  true;
    assume ps_1 > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_1)] := minor;  goto L82;
L82:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1634} {:print "Atomic Assignment"}  true;
    assume ps_1 > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(ps_1)] := 0;  goto L83;
L83:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1635} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := 0;  goto L84;
L84:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1635} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := 0;  goto L85;
L85:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1635} {:print "Atomic Assignment"}  true;
      Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation)] := 0;  goto L86;
L86:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1637} {:print "Atomic Assignment"}  true;
      sdv_dpc_io_registered := 0;  goto L87;
L87:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1639} {:print "Call \"sdv_RunDispatchFunction\" \"sdv_stub_dispatch_begin\""}  true;
  call sdv_stub_dispatch_begin();   goto L34;
L88:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_15);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1666} {:print "Call \"sdv_RunDispatchFunction\" \"FloppyCreateClose\""}  true;
  call status_5 := FloppyCreateClose( po_1, pirp_15);   goto L66;
L89:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L48; }
L90:
  call {:cexpr "status"} boogie_si_record_li2bpl_int(status_5);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 2005} {:print "Atomic Assignment"}  true;
      Tmp_225 := status_5;  goto L91;
L91:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 2005} {:print "Return"}  true;
    goto LM2;
L92:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(po_1);
  call {:cexpr "arg2"} boogie_si_record_li2bpl_int(pirp_15);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 1855} {:print "Call \"sdv_RunDispatchFunction\" \"FloppySystemControl\""}  true;
  call status_5 := FloppySystemControl( po_1, pirp_15);   goto L69;
L93:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L48; }
Lfinal: return;
}
procedure {:origName "sdv_ExFreePool"} sdv_ExFreePool(actual_P:int) {
var  Tmp_227: int;
var  Tmp_228: int;
var  P: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  P := actual_P;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 7389} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "IoBuildDeviceIoControlRequest"} IoBuildDeviceIoControlRequest(actual_IoControlCode:int, actual_DeviceObject_17:int, actual_InputBuffer:int, actual_InputBufferLength:int, actual_OutputBuffer:int, actual_OutputBufferLength:int, actual_InternalDeviceIoControl:int, actual_Event_2:int, actual_IoStatusBlock:int) returns (Tmp_229:int) {
var  sdv_126: int;
var  Tmp_230: int;
var  choice_10: int;
var  Tmp_231: int;
var  Tmp_232: int;
var  IoControlCode: int;
var  DeviceObject_17: int;
var  InputBuffer: int;
var  InputBufferLength: int;
var  OutputBuffer: int;
var  OutputBufferLength: int;
var  InternalDeviceIoControl: int;
var  Event_2: int;
var  IoStatusBlock: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  IoControlCode := actual_IoControlCode;
  DeviceObject_17 := actual_DeviceObject_17;
  InputBuffer := actual_InputBuffer;
  InputBufferLength := actual_InputBufferLength;
  OutputBuffer := actual_OutputBuffer;
  OutputBufferLength := actual_OutputBufferLength;
  InternalDeviceIoControl := actual_InternalDeviceIoControl;
  Event_2 := actual_Event_2;
  IoStatusBlock := actual_IoStatusBlock;
  // done with preamble
  goto L25;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9890} {:print "Return"}  true;
    goto LM2;
L8:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9862} {:print "Atomic Continuation"}  true;
    if(*) {  goto L9; } else {  goto L10; }
L9:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9883} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741823;  goto L38;
L10:
  call {:cexpr "InternalDeviceIoControl"} boogie_si_record_li2bpl_int(InternalDeviceIoControl);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9866} {:print "Atomic Conditional"}  true;
    if(*) { assume (InternalDeviceIoControl == 0);  goto L11; } else { assume (InternalDeviceIoControl != 0);  goto L12; }
L11:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_IoBuildDeviceIoControlRequest_irp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9873} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    Tmp_231 := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_IoBuildDeviceIoControlRequest_irp)))];  goto L35;
L12:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp->Tail.Overlay.CurrentStackLocation"} boogie_si_record_li2bpl_int(Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_IoBuildDeviceIoControlRequest_irp)))]);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9868} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    Tmp_230 := Mem_T.CurrentStackLocation_unnamed_tag_7[CurrentStackLocation_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(sdv_IoBuildDeviceIoControlRequest_irp)))];  goto L27;
L14:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9876} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(sdv_IoBuildDeviceIoControlRequest_irp)] := 1;  goto L30;
L25:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L27:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9868} {:print "Atomic Assignment"}  true;
    assume Tmp_230 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(Tmp_230)] := 15;  goto L28;
L28:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9869} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next)] := 15;  goto L29;
L29:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L14;
L30:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9877} {:print "Atomic Assignment"}  true;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 0;  goto L31;
L31:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9878} {:print "Atomic Assignment"}  true;
    assume IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatusBlock)] := 0;  goto L32;
L32:
  call {:cexpr "IoStatusBlock"} boogie_si_record_li2bpl_int(IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9879} {:print "Atomic Assignment"}  true;
      sdv_IoBuildDeviceIoControlRequest_IoStatusBlock := IoStatusBlock;  goto L33;
L33:
  call {:cexpr "sdv_IoBuildDeviceIoControlRequest_irp"} boogie_si_record_li2bpl_int(sdv_IoBuildDeviceIoControlRequest_irp);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9880} {:print "Atomic Assignment"}  true;
      Tmp_229 := sdv_IoBuildDeviceIoControlRequest_irp;  goto L34;
L34:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9873} {:print "Atomic Assignment"}  true;
    assume Tmp_231 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(Tmp_231)] := 14;  goto L36;
L36:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9874} {:print "Atomic Assignment"}  true;
      Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next)] := 14;  goto L37;
L37:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L14;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9884} {:print "Atomic Assignment"}  true;
    assume IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatusBlock)] := -1073741823;  goto L39;
L39:
  call {:cexpr "IoStatusBlock"} boogie_si_record_li2bpl_int(IoStatusBlock);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9885} {:print "Atomic Assignment"}  true;
      sdv_IoBuildDeviceIoControlRequest_IoStatusBlock := IoStatusBlock;  goto L40;
L40:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 9886} {:print "Atomic Assignment"}  true;
      Tmp_229 := 0;  goto L41;
L41:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
Lfinal: return;
}
procedure {:origName "sdv_ObDereferenceObject"} sdv_ObDereferenceObject(actual_Object_2:int) returns (Tmp_233:int) {
var  sdv_127: int;
var  p_8: int;
var  Tmp_234: int;
var  Object_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Object_2 := actual_Object_2;
  // done with preamble
  goto L10;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L8;
L8:
  call {:cexpr "p"} boogie_si_record_li2bpl_int(p_8);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14269} {:print "Atomic Assignment"}  true;
      Tmp_233 := p_8;  goto L12;
L10:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L12:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14269} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "KeInitializeSemaphore"} KeInitializeSemaphore(actual_Semaphore_1:int, actual_Count:int, actual_Limit:int) {
var  Tmp_235: int;
var  Tmp_236: int;
var  Semaphore_1: int;
var  Count: int;
var  Limit: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  Semaphore_1 := actual_Semaphore_1;
  Count := actual_Count;
  Limit := actual_Limit;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 13255} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "PoRequestPowerIrp"} PoRequestPowerIrp(actual_DeviceObject_18:int, actual_MinorFunction:int, actual_structPtr888PowerState:int, actual_CompletionFunction:int, actual_Context_4:int, actual_Irp_13:int) returns (Tmp_237:int) {
var  PowerState: int;
var  Tmp_238: int;
var  powercompletionrun: int;
var  sdv_128: int;
var  x_10: int;
var  status_6: int;
var  DeviceObject_18: int;
var  MinorFunction: int;
var  structPtr888PowerState: int;
var  CompletionFunction: int;
var  Context_4: int;
var  Irp_13: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  call PowerState := __HAVOC_malloc(8);
  // initialize local variables to 0
  // copy formal-ins to locals
  DeviceObject_18 := actual_DeviceObject_18;
  MinorFunction := actual_MinorFunction;
  structPtr888PowerState := actual_structPtr888PowerState;
  CompletionFunction := actual_CompletionFunction;
  Context_4 := actual_Context_4;
  Irp_13 := actual_Irp_13;
  // done with preamble
  goto L44;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L10;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14642} {:print "Return"}  true;
    goto LM2;
L10:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14605} {:print "Atomic Assignment"}  true;
      powercompletionrun := 0;  goto L33;
L13:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14615} {:print "Atomic Continuation"}  true;
    if(*) {  goto L19; } else {  goto L20; }
L14:
  call {:cexpr "MinorFunction"} boogie_si_record_li2bpl_int(MinorFunction);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14607} {:print "Atomic Conditional"}  true;
    if(*) { assume (MinorFunction == 2);  goto L13; } else { assume (MinorFunction != 2);  goto L15; }
L15:
  call {:cexpr "MinorFunction"} boogie_si_record_li2bpl_int(MinorFunction);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14607} {:print "Atomic Conditional"}  true;
    if(*) { assume (MinorFunction == 0);  goto L13; } else { assume (MinorFunction != 0);  goto L16; }
L16:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14609} {:print "Atomic Assignment"}  true;
    assume sdv_power_irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(sdv_power_irp))] := -1073741584;  goto L34;
L19:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14637} {:print "Atomic Assignment"}  true;
    assume sdv_power_irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(sdv_power_irp))] := -1073741670;  goto L41;
L20:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14618} {:print "Atomic Assignment"}  true;
    assume sdv_power_irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(sdv_power_irp))] := 259;  goto L37;
L31:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
L33:
  call {:cexpr "MinorFunction"} boogie_si_record_li2bpl_int(MinorFunction);
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14607} {:print "Atomic Conditional"}  true;
    if(*) { assume (MinorFunction == 3);  goto L13; } else { assume (MinorFunction != 3);  goto L14; }
L34:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14610} {:print "Atomic Assignment"}  true;
    assume sdv_power_irp > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(sdv_power_irp)] := 0;  goto L35;
L35:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14611} {:print "Atomic Assignment"}  true;
      Tmp_237 := -1073741584;  goto L36;
L36:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L37:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14619} {:print "Atomic Assignment"}  true;
      status_6 := 259;  goto L38;
L38:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14620} {:print "Atomic Assignment"}  true;
    assume sdv_power_irp > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(sdv_power_irp)] := 1;  goto L39;
L39:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14635} {:print "Atomic Assignment"}  true;
      Tmp_237 := 259;  goto L40;
L40:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L41:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14638} {:print "Atomic Assignment"}  true;
    assume sdv_power_irp > 0;
    Mem_T.PendingReturned__IRP[PendingReturned__IRP(sdv_power_irp)] := 0;  goto L42;
L42:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 14639} {:print "Atomic Assignment"}  true;
      Tmp_237 := -1073741670;  goto L43;
L43:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L44:
  call {:cexpr "structPtr888PowerState->DeviceState"} boogie_si_record_li2bpl_int(Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(structPtr888PowerState)]);
  call {:cexpr "structPtr888PowerState->SystemState"} boogie_si_record_li2bpl_int(Mem_T.SystemState__POWER_STATE[SystemState__POWER_STATE(structPtr888PowerState)]);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
    assume structPtr888PowerState > 0;
  assume PowerState > 0;
    Mem_T.SystemState__POWER_STATE[SystemState__POWER_STATE(PowerState)] := Mem_T.SystemState__POWER_STATE[SystemState__POWER_STATE(structPtr888PowerState)];
  assume structPtr888PowerState > 0;
  assume PowerState > 0;
    Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(PowerState)] := Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(structPtr888PowerState)];  goto L31;
Lfinal: return;
}
procedure {:origName "sdv_IoDeassignArcName"} sdv_IoDeassignArcName(actual_ArcName_1:int) {
var  Tmp_239: int;
var  Tmp_240: int;
var  ArcName_1: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  ArcName_1 := actual_ArcName_1;
  // done with preamble
  goto L4;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L0:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L1:
  assert {:sourcefile "f:\slam1\wdk\src_5043\storage\fdc\flpydisk_fail\sdv\sdv-harness.c"} {:sourceline 10511} {:print "Return"}  true;
    goto LM2;
L4:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L0;
Lfinal: return;
}
procedure {:origName "RtlCopyUnicodeString"} RtlCopyUnicodeString(actual_sdv_129:int, actual_sdv_130:int) returns (Tmp_241:int) {
var  Tmp_242: int;
var  sdv_131: int;
var  sdv_129: int;
var  sdv_130: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  sdv_129 := actual_sdv_129;
  sdv_130 := actual_sdv_130;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_131);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_241 := sdv_131;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "sprintf"} sprintf(actual_sdv_132:int, actual_sdv_133:int) returns (Tmp_243:int) {
var  Tmp_244: int;
var  sdv_134: int;
var  sdv_132: int;
var  sdv_133: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  sdv_132 := actual_sdv_132;
  sdv_133 := actual_sdv_133;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_134);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_243 := sdv_134;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "swprintf"} swprintf(actual_sdv_135:int, actual_sdv_136:int) returns (Tmp_245:int) {
var  Tmp_246: int;
var  sdv_137: int;
var  sdv_135: int;
var  sdv_136: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  sdv_135 := actual_sdv_135;
  sdv_136 := actual_sdv_136;
  // done with preamble
  goto L3;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L1:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_137);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Assignment"}  true;
      Tmp_245 := sdv_137;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L1;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_7_0"} SLIC_ABORT_7_0(actual_caller:int) {
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl4);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_7_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has not finished its WMI processing."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl4);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_11_0"} SLIC_ABORT_11_0(actual_caller_1:int) {
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl4);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_11_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has not finished its WMI processing."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl4);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_FloppySystemControl_exit"} SLIC_FloppySystemControl_exit(actual_caller_2:int) {
var  caller_2: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_2 := actual_caller_2;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_2);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 43} {:print "Call \"SLIC_FloppySystemControl_exit\" \"SLIC_ABORT_7_0\""}  true;
  call SLIC_ABORT_7_0( caller_2);   goto L9;
L5:
  call {:cexpr "not_forwarded"} boogie_si_record_li2bpl_int(not_forwarded);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 42} {:print "Atomic Conditional"}  true;
    if(*) { assume (not_forwarded == 0);  goto L2; } else { assume (not_forwarded != 0);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_sdv_IoCallDriver_entry"} SLIC_sdv_IoCallDriver_entry(actual_caller_3:int) {
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
L2:
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 37} {:print "Atomic Assignment"}  true;
      not_forwarded := 0;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_stub_WmiIrpForward_entry"} SLIC_sdv_stub_WmiIrpForward_entry(actual_caller_4:int) {
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
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 22} {:print "Atomic Assignment"}  true;
      not_forwarded := 1;  goto L5;
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
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 16} {:print "Atomic Assignment"}  true;
      not_forwarded := 0;  goto L6;
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
procedure {:origName "SLIC_ABORT_15_0"} SLIC_ABORT_15_0(actual_caller_5:int) {
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
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_15_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has not finished its WMI processing."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl4);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_FloppyReadWrite_exit"} SLIC_FloppyReadWrite_exit(actual_caller_6:int) {
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
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 43} {:print "Call \"SLIC_FloppyReadWrite_exit\" \"SLIC_ABORT_13_0\""}  true;
  call SLIC_ABORT_13_0( caller_6);   goto L9;
L5:
  call {:cexpr "not_forwarded"} boogie_si_record_li2bpl_int(not_forwarded);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 42} {:print "Atomic Conditional"}  true;
    if(*) { assume (not_forwarded == 0);  goto L2; } else { assume (not_forwarded != 0);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
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
procedure {:origName "SLIC_ABORT_5_0"} SLIC_ABORT_5_0(actual_caller_7:int) {
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
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_5_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has not finished its WMI processing."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl4);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_FloppyPnp_exit"} SLIC_FloppyPnp_exit(actual_caller_8:int) {
var  caller_8: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_8 := actual_caller_8;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_8);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 43} {:print "Call \"SLIC_FloppyPnp_exit\" \"SLIC_ABORT_5_0\""}  true;
  call SLIC_ABORT_5_0( caller_8);   goto L9;
L5:
  call {:cexpr "not_forwarded"} boogie_si_record_li2bpl_int(not_forwarded);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 42} {:print "Atomic Conditional"}  true;
    if(*) { assume (not_forwarded == 0);  goto L2; } else { assume (not_forwarded != 0);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_FloppyPower_exit"} SLIC_FloppyPower_exit(actual_caller_9:int) {
var  caller_9: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_9 := actual_caller_9;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_9);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 43} {:print "Call \"SLIC_FloppyPower_exit\" \"SLIC_ABORT_9_0\""}  true;
  call SLIC_ABORT_9_0( caller_9);   goto L9;
L5:
  call {:cexpr "not_forwarded"} boogie_si_record_li2bpl_int(not_forwarded);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 42} {:print "Atomic Conditional"}  true;
    if(*) { assume (not_forwarded == 0);  goto L2; } else { assume (not_forwarded != 0);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_PoCallDriver_entry"} SLIC_PoCallDriver_entry(actual_caller_10:int) {
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
L2:
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 37} {:print "Atomic Assignment"}  true;
      not_forwarded := 0;  goto L5;
L3:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L2;
L5:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_9_0"} SLIC_ABORT_9_0(actual_caller_11:int) {
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl4);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_9_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has not finished its WMI processing."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl4);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_sdv_IoAcquireRemoveLock_exit"} SLIC_sdv_IoAcquireRemoveLock_exit(actual_caller_12:int, actual_sdv_138:int) {
var  caller_12: int;
var  sdv_138: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_12 := actual_caller_12;
  sdv_138 := actual_sdv_138;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl5);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_sdv_IoAcquireRemoveLock_exit\" \"SLIC_EXIT_ROUTINE\""}  true;
  call SLIC_EXIT_ROUTINE( strConst__li2bpl5);   goto L2;
L5:
  call {:cexpr "sdv"} boogie_si_record_li2bpl_int(sdv_138);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 27} {:print "Atomic Conditional"}  true;
    if(*) { assume (sdv_138 == 0);  goto L2; } else { assume (sdv_138 != 0);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
Lfinal: return;
}
procedure {:origName "SLIC_ABORT_13_0"} SLIC_ABORT_13_0(actual_caller_13:int) {
var  caller_13: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_13 := actual_caller_13;
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
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(strConst__li2bpl4);
assert {:sourcefile "?"} {:sourceline 0} {:print "Call \"SLIC_ABORT_13_0\" \"SLIC_ERROR_ROUTINE\""} {:abortM "The dispatch routine has not finished its WMI processing."} true;
  call SLIC_ERROR_ROUTINE( strConst__li2bpl4);   goto L2;
Lfinal: return;
}
procedure {:origName "SLIC_FloppyDeviceControl_exit"} SLIC_FloppyDeviceControl_exit(actual_caller_14:int) {
var  caller_14: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_14 := actual_caller_14;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_14);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 43} {:print "Call \"SLIC_FloppyDeviceControl_exit\" \"SLIC_ABORT_11_0\""}  true;
  call SLIC_ABORT_11_0( caller_14);   goto L9;
L5:
  call {:cexpr "not_forwarded"} boogie_si_record_li2bpl_int(not_forwarded);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 42} {:print "Atomic Conditional"}  true;
    if(*) { assume (not_forwarded == 0);  goto L2; } else { assume (not_forwarded != 0);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
procedure {:origName "SLIC_FloppyCreateClose_exit"} SLIC_FloppyCreateClose_exit(actual_caller_15:int) {
var  caller_15: int;
var li2bplRetTmp: int;
var boogieTmp: int;
  // allocate locals moved-out-of-stack
  // initialize local variables to 0
  // copy formal-ins to locals
  caller_15 := actual_caller_15;
  // done with preamble
  goto L7;
LM2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto Lfinal;
L2:
assert {:sourcefile "?"} {:sourceline 0} {:print "Return"}  true;
    goto LM2;
L4:
  call {:cexpr "arg1"} boogie_si_record_li2bpl_int(caller_15);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 43} {:print "Call \"SLIC_FloppyCreateClose_exit\" \"SLIC_ABORT_15_0\""}  true;
  call SLIC_ABORT_15_0( caller_15);   goto L9;
L5:
  call {:cexpr "not_forwarded"} boogie_si_record_li2bpl_int(not_forwarded);
  assert {:sourcefile "..\..\..\rules\WDM\WmiForward.slic"} {:sourceline 42} {:print "Atomic Conditional"}  true;
    if(*) { assume (not_forwarded == 0);  goto L2; } else { assume (not_forwarded != 0);  goto L4; }
L7:
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Continuation"}  true;
    goto L5;
L9:
  call {:cexpr "yogi_error"} boogie_si_record_li2bpl_int(yogi_error);
assert {:sourcefile "?"} {:sourceline 0} {:print "Atomic Conditional"}  true;
    if(*) { assume (yogi_error == 1);  goto LM2; } else { assume (yogi_error != 1);  goto L2; }
Lfinal: return;
}
// ----- Decls -------
var Mem_T.AcpiBios__FDC_INFO: [int] int;
var Mem_T.AcpiFdiSupported__FDC_INFO: [int] int;
var Mem_T.AddDevice__DRIVER_EXTENSION: [int] int;
var Mem_T.AlignmentRequirement__DEVICE_OBJECT: [int] int;
var Mem_T.Blink__LIST_ENTRY: [int] int;
var Mem_T.BufferCount__FDC_INFO: [int] int;
var Mem_T.BufferSize__FDC_INFO: [int] int;
var Mem_T.Buffer__STRING: [int] int;
var Mem_T.BusType__FDC_INFO: [int] int;
var Mem_T.ByteCapacity__DISKETTE_EXTENSION: [int] int;
var Mem_T.BytesPerSector__DISKETTE_EXTENSION: [int] int;
var Mem_T.BytesPerSector__DISK_GEOMETRY: [int] int;
var Mem_T.BytesPerSector__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.CancelRoutine__IRP: [int] int;
var Mem_T.Cancel__IRP: [int] int;
var Mem_T.CompletionRoutine__IO_STACK_LOCATION: [int] int;
var Mem_T.ControllerConfigurable__DISKETTE_EXTENSION: [int] int;
var Mem_T.CurrentStackLocation_unnamed_tag_7: [int] int;
var Mem_T.CylinderShift__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.Data1__GUID: [int] int;
var Mem_T.Data2__GUID: [int] int;
var Mem_T.Data3__GUID: [int] int;
var Mem_T.Data4__GUID: [int] int;
var Mem_T.DataLength__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.DataTransferLength__ACPI_FDI_DATA: [int] int;
var Mem_T.DataTransferRate__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.DeviceExtension__DEVICE_OBJECT: [int] int;
var Mem_T.DeviceObject__DISKETTE_EXTENSION: [int] int;
var Mem_T.DeviceState__POWER_STATE: [int] int;
var Mem_T.DeviceType__ACPI_FDI_DATA: [int] int;
var Mem_T.DeviceUnit__DISKETTE_EXTENSION: [int] int;
var Mem_T.DriveOnValue__DISKETTE_EXTENSION: [int] int;
var Mem_T.DriveType__DISKETTE_EXTENSION: [int] int;
var Mem_T.DriverExtension__DRIVER_OBJECT: [int] int;
var Mem_T.DriverObject__DISKETTE_EXTENSION: [int] int;
var Mem_T.DriverUnload__DRIVER_OBJECT: [int] int;
var Mem_T.EndCylinderNumber__FORMAT_PARAMETERS: [int] int;
var Mem_T.EndHeadNumber__FORMAT_PARAMETERS: [int] int;
var Mem_T.FlCancelSpinLock__DISKETTE_EXTENSION: [int] int;
var Mem_T.Flags__DEVICE_OBJECT: [int] int;
var Mem_T.Flink__LIST_ENTRY: [int] int;
var Mem_T.FloppyControllerAllocated__DISKETTE_EXTENSION: [int] int;
var Mem_T.FloppyCount__CONFIGURATION_INFORMATION: [int] int;
var Mem_T.FloppyThread__DISKETTE_EXTENSION: [int] int;
var Mem_T.FormatFillCharacter__ACPI_FDI_DATA: [int] int;
var Mem_T.FormatFillCharacter__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.FormatGapLength__ACPI_FDI_DATA: [int] int;
var Mem_T.FormatGapLength__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.FormatGapLength__FORMAT_EX_PARAMETERS: [int] int;
var Mem_T.HeadLoadTime__ACPI_FDI_DATA: [int] int;
var Mem_T.HeadLoadTime__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.HeadSettleTime__ACPI_FDI_DATA: [int] int;
var Mem_T.HeadSettleTime__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.HighPart__LUID: [int] int;
var Mem_T.HighestDriveMediaType__DRIVE_MEDIA_LIMITS: [int] int;
var Mem_T.HoldNewRequests__DISKETTE_EXTENSION: [int] int;
var Mem_T.INT4: [int] int;
var Mem_T.Information__IO_STATUS_BLOCK: [int] int;
var Mem_T.InputBufferLength_unnamed_tag_22: [int] int;
var Mem_T.IoControlCode_unnamed_tag_22: [int] int;
var Mem_T.IsReadOnly__DISKETTE_EXTENSION: [int] int;
var Mem_T.IsRemoved__DISKETTE_EXTENSION: [int] int;
var Mem_T.IsStarted__DISKETTE_EXTENSION: [int] int;
var Mem_T.Length_unnamed_tag_18: [int] int;
var Mem_T.ListSpinLock__DISKETTE_EXTENSION: [int] int;
var Mem_T.LowPart__LUID: [int] int;
var Mem_T.LowestDriveMediaType__DRIVE_MEDIA_LIMITS: [int] int;
var Mem_T.MajorFunction__DRIVER_OBJECT: [int] int;
var Mem_T.MajorFunction__IO_STACK_LOCATION: [int] int;
var Mem_T.MaxCylinderNumber__ACPI_FDI_DATA: [int] int;
var Mem_T.MaxTransferSize__DISKETTE_EXTENSION: [int] int;
var Mem_T.MaxTransferSize__FDC_INFO: [int] int;
var Mem_T.MaximumLength__STRING: [int] int;
var Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.MediaByte__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.MediaType__DISKETTE_EXTENSION: [int] int;
var Mem_T.MediaType__DISK_GEOMETRY: [int] int;
var Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.MediaType__FORMAT_PARAMETERS: [int] int;
var Mem_T.MinorFunction__IO_STACK_LOCATION: [int] int;
var Mem_T.MotorOffTime__ACPI_FDI_DATA: [int] int;
var Mem_T.MotorOffTime__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.MotorSettleTime__ACPI_FDI_DATA: [int] int;
var Mem_T.NameLength__MOUNTDEV_NAME: [int] int;
var Mem_T.NewRequestQueueSpinLock__DISKETTE_EXTENSION: [int] int;
var Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.OutputBufferLength_unnamed_tag_22: [int] int;
var Mem_T.P_DEVICE_OBJECT: [int] int;
var Mem_T.PendingReturned__IRP: [int] int;
var Mem_T.PeripheralNumber__FDC_INFO: [int] int;
var Mem_T.PerpendicularMode__DISKETTE_EXTENSION: [int] int;
var Mem_T.PoweringDown__DISKETTE_EXTENSION: [int] int;
var Mem_T.ReadWriteGapLength__ACPI_FDI_DATA: [int] int;
var Mem_T.ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.ReleaseFdcWithMotorRunning__DISKETTE_EXTENSION: [int] int;
var Mem_T.SectorLengthCode__ACPI_FDI_DATA: [int] int;
var Mem_T.SectorLengthCode__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.SectorPerTrack__ACPI_FDI_DATA: [int] int;
var Mem_T.SectorsPerTrack__DISK_GEOMETRY: [int] int;
var Mem_T.SectorsPerTrack__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.SectorsPerTrack__FORMAT_EX_PARAMETERS: [int] int;
var Mem_T.SignalState__DISPATCHER_HEADER: [int] int;
var Mem_T.Signalling__DISPATCHER_HEADER: [int] int;
var Mem_T.Size__DISPATCHER_HEADER: [int] int;
var Mem_T.SkewDelta__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.StartCylinderNumber__FORMAT_PARAMETERS: [int] int;
var Mem_T.StartHeadNumber__FORMAT_PARAMETERS: [int] int;
var Mem_T.Status__IO_STATUS_BLOCK: [int] int;
var Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA: [int] int;
var Mem_T.StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T.SystemBuffer_unnamed_tag_2: [int] int;
var Mem_T.SystemState__POWER_STATE: [int] int;
var Mem_T.TargetObject__DISKETTE_EXTENSION: [int] int;
var Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION: [int] int;
var Mem_T.TracksPerCylinder__DISK_GEOMETRY: [int] int;
var Mem_T.Type3InputBuffer_unnamed_tag_22: [int] int;
var Mem_T.Type_unnamed_tag_28: [int] int;
var Mem_T.UnderlyingPDO__DISKETTE_EXTENSION: [int] int;
var Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID: [int] int;
var Mem_T.VOID: [int] int;
var Mem_T._DRIVE_MEDIA_CONSTANTS: [int] int;
var Mem_T._KEVENT: [int] int;
var Mem_T._LIST_ENTRY: [int] int;
var Mem_T._UNICODE_STRING: [int] int;
var Mem_T.unnamed_tag_2: [int] int;
procedure {:dopa "Mem_T.INT4"} dummy_for_pa();
procedure corralExtraInit() {
   assume (forall x : int :: {Mem_T.AddDevice__DRIVER_EXTENSION[x]} (Mem_T.AddDevice__DRIVER_EXTENSION[x] <= 0 || Mem_T.AddDevice__DRIVER_EXTENSION[x] > 286));
   assume (forall x : int :: {Mem_T.CancelRoutine__IRP[x]} (Mem_T.CancelRoutine__IRP[x] <= 0 || Mem_T.CancelRoutine__IRP[x] > 286));
   assume (forall x : int :: {Mem_T.CompletionRoutine__IO_STACK_LOCATION[x]} (Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] <= 0 || Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] > 286));
   assume (forall x : int :: {Mem_T.DriverUnload__DRIVER_OBJECT[x]} (Mem_T.DriverUnload__DRIVER_OBJECT[x] <= 0 || Mem_T.DriverUnload__DRIVER_OBJECT[x] > 286));
   assume (forall x : int :: {Mem_T.MajorFunction__DRIVER_OBJECT[x]} (Mem_T.MajorFunction__DRIVER_OBJECT[x] <= 0 || Mem_T.MajorFunction__DRIVER_OBJECT[x] > 286));
}
function {:inline true} {:fieldmap "Mem_T.AcpiBios__FDC_INFO"}  {:fieldname "AcpiBios"}  AcpiBios__FDC_INFO(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.AcpiFdiData__FDC_INFO"}  {:fieldname "AcpiFdiData"}  AcpiFdiData__FDC_INFO(x:int) returns (int) {x + 44}
function {:inline true} {:fieldmap "Mem_T.AcpiFdiSupported__FDC_INFO"}  {:fieldname "AcpiFdiSupported"}  AcpiFdiSupported__FDC_INFO(x:int) returns (int) {x + 40}
function {:inline true} {:fieldmap "Mem_T.AddDevice__DRIVER_EXTENSION"}  {:fieldname "AddDevice"}  AddDevice__DRIVER_EXTENSION(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.AlignmentRequirement__DEVICE_OBJECT"}  {:fieldname "AlignmentRequirement"}  AlignmentRequirement__DEVICE_OBJECT(x:int) returns (int) {x + 128}
function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"}  {:fieldname "ArcName"}  ArcName__DISKETTE_EXTENSION(x:int) returns (int) {x + 612}
function {:inline true} {:fieldmap "Mem_T.unnamed_tag_2"}  {:fieldname "AssociatedIrp"}  AssociatedIrp__IRP(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T._DRIVE_MEDIA_CONSTANTS"}  {:fieldname "BiosDriveMediaConstants"}  BiosDriveMediaConstants__DISKETTE_EXTENSION(x:int) returns (int) {x + 408}
function {:inline true} {:fieldmap "Mem_T.Blink__LIST_ENTRY"}  {:fieldname "Blink"}  Blink__LIST_ENTRY(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.BufferCount__FDC_INFO"}  {:fieldname "BufferCount"}  BufferCount__FDC_INFO(x:int) returns (int) {x + 108}
function {:inline true} {:fieldmap "Mem_T.BufferSize__FDC_INFO"}  {:fieldname "BufferSize"}  BufferSize__FDC_INFO(x:int) returns (int) {x + 112}
function {:inline true} {:fieldmap "Mem_T.Buffer__STRING"}  {:fieldname "Buffer"}  Buffer__STRING(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.BusType__FDC_INFO"}  {:fieldname "BusType"}  BusType__FDC_INFO(x:int) returns (int) {x + 12}
function {:inline true} {:fieldmap "Mem_T.ByteCapacity__DISKETTE_EXTENSION"}  {:fieldname "ByteCapacity"}  ByteCapacity__DISKETTE_EXTENSION(x:int) returns (int) {x + 384}
function {:inline true} {:fieldmap "Mem_T.ByteOffset_unnamed_tag_12"}  {:fieldname "ByteOffset"}  ByteOffset_unnamed_tag_12(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.BytesPerSector__DISKETTE_EXTENSION"}  {:fieldname "BytesPerSector"}  BytesPerSector__DISKETTE_EXTENSION(x:int) returns (int) {x + 380}
function {:inline true} {:fieldmap "Mem_T.BytesPerSector__DISK_GEOMETRY"}  {:fieldname "BytesPerSector"}  BytesPerSector__DISK_GEOMETRY(x:int) returns (int) {x + 32}
function {:inline true} {:fieldmap "Mem_T.BytesPerSector__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "BytesPerSector"}  BytesPerSector__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 20}
function {:inline true} {:fieldmap "Mem_T.CancelRoutine__IRP"}  {:fieldname "CancelRoutine"}  CancelRoutine__IRP(x:int) returns (int) {x + 120}
function {:inline true} {:fieldmap "Mem_T.Cancel__IRP"}  {:fieldname "Cancel"}  Cancel__IRP(x:int) returns (int) {x + 64}
function {:inline true} {:fieldmap "Mem_T.CompletionRoutine__IO_STACK_LOCATION"}  {:fieldname "CompletionRoutine"}  CompletionRoutine__IO_STACK_LOCATION(x:int) returns (int) {x + 536}
function {:inline true} {:fieldmap "Mem_T.ControllerConfigurable__DISKETTE_EXTENSION"}  {:fieldname "ControllerConfigurable"}  ControllerConfigurable__DISKETTE_EXTENSION(x:int) returns (int) {x + 572}
function {:inline true} {:fieldmap "Mem_T.CurrentStackLocation_unnamed_tag_7"}  {:fieldname "CurrentStackLocation"}  CurrentStackLocation_unnamed_tag_7(x:int) returns (int) {x + 48}
function {:inline true} {:fieldmap "Mem_T.CylinderShift__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "CylinderShift"}  CylinderShift__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 56}
function {:inline true} {:fieldmap "Mem_T.Cylinders__DISK_GEOMETRY"}  {:fieldname "Cylinders"}  Cylinders__DISK_GEOMETRY(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Data1__GUID"}  {:fieldname "Data1"}  Data1__GUID(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Data2__GUID"}  {:fieldname "Data2"}  Data2__GUID(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.Data3__GUID"}  {:fieldname "Data3"}  Data3__GUID(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.Data4__GUID"}  {:fieldname "Data4"}  Data4__GUID(x:int) returns (int) {x + 12}
function {:inline true} {:fieldmap "Mem_T.DataLength__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "DataLength"}  DataLength__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 68}
function {:inline true} {:fieldmap "Mem_T.DataTransferLength__ACPI_FDI_DATA"}  {:fieldname "DataTransferLength"}  DataTransferLength__ACPI_FDI_DATA(x:int) returns (int) {x + 44}
function {:inline true} {:fieldmap "Mem_T.DataTransferRate__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "DataTransferRate"}  DataTransferRate__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 60}
function {:inline true} {:fieldmap "Mem_T.DeviceExtension__DEVICE_OBJECT"}  {:fieldname "DeviceExtension"}  DeviceExtension__DEVICE_OBJECT(x:int) returns (int) {x + 44}
function {:inline true} {:fieldmap "Mem_T.DeviceIoControl_unnamed_tag_8"}  {:fieldname "DeviceIoControl"}  DeviceIoControl_unnamed_tag_8(x:int) returns (int) {x + 256}
function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"}  {:fieldname "DeviceName"}  DeviceName__DISKETTE_EXTENSION(x:int) returns (int) {x + 576}
function {:inline true} {:fieldmap "Mem_T.DeviceObject__DISKETTE_EXTENSION"}  {:fieldname "DeviceObject"}  DeviceObject__DISKETTE_EXTENSION(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.DeviceState__POWER_STATE"}  {:fieldname "DeviceState"}  DeviceState__POWER_STATE(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.DeviceType__ACPI_FDI_DATA"}  {:fieldname "DeviceType"}  DeviceType__ACPI_FDI_DATA(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.DeviceUnit__DISKETTE_EXTENSION"}  {:fieldname "DeviceUnit"}  DeviceUnit__DISKETTE_EXTENSION(x:int) returns (int) {x + 396}
function {:inline true} {:fieldmap "Mem_T.DriveOnValue__DISKETTE_EXTENSION"}  {:fieldname "DriveOnValue"}  DriveOnValue__DISKETTE_EXTENSION(x:int) returns (int) {x + 400}
function {:inline true} {:fieldmap "Mem_T.DriveType__DISKETTE_EXTENSION"}  {:fieldname "DriveType"}  DriveType__DISKETTE_EXTENSION(x:int) returns (int) {x + 376}
function {:inline true} {:fieldmap "Mem_T.DriverExtension__DRIVER_OBJECT"}  {:fieldname "DriverExtension"}  DriverExtension__DRIVER_OBJECT(x:int) returns (int) {x + 28}
function {:inline true} {:fieldmap "Mem_T.DriverObject__DISKETTE_EXTENSION"}  {:fieldname "DriverObject"}  DriverObject__DISKETTE_EXTENSION(x:int) returns (int) {x + 360}
function {:inline true} {:fieldmap "Mem_T.DriverUnload__DRIVER_OBJECT"}  {:fieldname "DriverUnload"}  DriverUnload__DRIVER_OBJECT(x:int) returns (int) {x + 60}
function {:inline true} {:fieldmap "Mem_T.EndCylinderNumber__FORMAT_PARAMETERS"}  {:fieldname "EndCylinderNumber"}  EndCylinderNumber__FORMAT_PARAMETERS(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.EndHeadNumber__FORMAT_PARAMETERS"}  {:fieldname "EndHeadNumber"}  EndHeadNumber__FORMAT_PARAMETERS(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.FlCancelSpinLock__DISKETTE_EXTENSION"}  {:fieldname "FlCancelSpinLock"}  FlCancelSpinLock__DISKETTE_EXTENSION(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Flags__DEVICE_OBJECT"}  {:fieldname "Flags"}  Flags__DEVICE_OBJECT(x:int) returns (int) {x + 32}
function {:inline true} {:fieldmap "Mem_T.Flink__LIST_ENTRY"}  {:fieldname "Flink"}  Flink__LIST_ENTRY(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.FloppyControllerAllocated__DISKETTE_EXTENSION"}  {:fieldname "FloppyControllerAllocated"}  FloppyControllerAllocated__DISKETTE_EXTENSION(x:int) returns (int) {x + 368}
function {:inline true} {:fieldmap "Mem_T.FloppyCount__CONFIGURATION_INFORMATION"}  {:fieldname "FloppyCount"}  FloppyCount__CONFIGURATION_INFORMATION(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"}  {:fieldname "FloppyInterfaceString"}  FloppyInterfaceString__DISKETTE_EXTENSION(x:int) returns (int) {x + 600}
function {:inline true} {:fieldmap "Mem_T.FloppyThread__DISKETTE_EXTENSION"}  {:fieldname "FloppyThread"}  FloppyThread__DISKETTE_EXTENSION(x:int) returns (int) {x + 284}
function {:inline true} {:fieldmap "Mem_T.FormatFillCharacter__ACPI_FDI_DATA"}  {:fieldname "FormatFillCharacter"}  FormatFillCharacter__ACPI_FDI_DATA(x:int) returns (int) {x + 52}
function {:inline true} {:fieldmap "Mem_T.FormatFillCharacter__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "FormatFillCharacter"}  FormatFillCharacter__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.FormatGapLength__ACPI_FDI_DATA"}  {:fieldname "FormatGapLength"}  FormatGapLength__ACPI_FDI_DATA(x:int) returns (int) {x + 48}
function {:inline true} {:fieldmap "Mem_T.FormatGapLength__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "FormatGapLength"}  FormatGapLength__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 32}
function {:inline true} {:fieldmap "Mem_T.FormatGapLength__FORMAT_EX_PARAMETERS"}  {:fieldname "FormatGapLength"}  FormatGapLength__FORMAT_EX_PARAMETERS(x:int) returns (int) {x + 20}
function {:inline true} {:fieldmap "Mem_T.HeadLoadTime__ACPI_FDI_DATA"}  {:fieldname "HeadLoadTime"}  HeadLoadTime__ACPI_FDI_DATA(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.HeadLoadTime__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "HeadLoadTime"}  HeadLoadTime__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.HeadSettleTime__ACPI_FDI_DATA"}  {:fieldname "HeadSettleTime"}  HeadSettleTime__ACPI_FDI_DATA(x:int) returns (int) {x + 56}
function {:inline true} {:fieldmap "Mem_T.HeadSettleTime__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "HeadSettleTime"}  HeadSettleTime__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 40}
function {:inline true} {:fieldmap "Mem_T.Header__KEVENT"}  {:fieldname "Header"}  Header__KEVENT(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.HighPart__LUID"}  {:fieldname "HighPart"}  HighPart__LUID(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.HighestDriveMediaType__DRIVE_MEDIA_LIMITS"}  {:fieldname "HighestDriveMediaType"}  HighestDriveMediaType__DRIVE_MEDIA_LIMITS(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.HoldNewRequests__DISKETTE_EXTENSION"}  {:fieldname "HoldNewRequests"}  HoldNewRequests__DISKETTE_EXTENSION(x:int) returns (int) {x + 20}
function {:inline true} {:fieldmap "Mem_T.Information__IO_STATUS_BLOCK"}  {:fieldname "Information"}  Information__IO_STATUS_BLOCK(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.InputBufferLength_unnamed_tag_22"}  {:fieldname "InputBufferLength"}  InputBufferLength_unnamed_tag_22(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"}  {:fieldname "InterfaceString"}  InterfaceString__DISKETTE_EXTENSION(x:int) returns (int) {x + 588}
function {:inline true} {:fieldmap "Mem_T.IoControlCode_unnamed_tag_22"}  {:fieldname "IoControlCode"}  IoControlCode_unnamed_tag_22(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.IoStatus__IRP"}  {:fieldname "IoStatus"}  IoStatus__IRP(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.IsReadOnly__DISKETTE_EXTENSION"}  {:fieldname "IsReadOnly"}  IsReadOnly__DISKETTE_EXTENSION(x:int) returns (int) {x + 404}
function {:inline true} {:fieldmap "Mem_T.IsRemoved__DISKETTE_EXTENSION"}  {:fieldname "IsRemoved"}  IsRemoved__DISKETTE_EXTENSION(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.IsStarted__DISKETTE_EXTENSION"}  {:fieldname "IsStarted"}  IsStarted__DISKETTE_EXTENSION(x:int) returns (int) {x + 12}
function {:inline true} {:fieldmap "Mem_T.Length_unnamed_tag_18"}  {:fieldname "Length"}  Length_unnamed_tag_18(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"}  {:fieldname "ListEntry"}  ListEntry__DISKETTE_EXTENSION(x:int) returns (int) {x + 288}
function {:inline true} {:fieldmap "Mem_T.ListEntry_unnamed_tag_7"}  {:fieldname "ListEntry"}  ListEntry_unnamed_tag_7(x:int) returns (int) {x + 40}
function {:inline true} {:fieldmap "Mem_T.ListSpinLock__DISKETTE_EXTENSION"}  {:fieldname "ListSpinLock"}  ListSpinLock__DISKETTE_EXTENSION(x:int) returns (int) {x + 152}
function {:inline true} {:fieldmap "Mem_T.LowPart__LUID"}  {:fieldname "LowPart"}  LowPart__LUID(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.LowestDriveMediaType__DRIVE_MEDIA_LIMITS"}  {:fieldname "LowestDriveMediaType"}  LowestDriveMediaType__DRIVE_MEDIA_LIMITS(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.MajorFunction__DRIVER_OBJECT"}  {:fieldname "MajorFunction"}  MajorFunction__DRIVER_OBJECT(x:int) returns (int) {x + 64}
function {:inline true} {:fieldmap "Mem_T.MajorFunction__IO_STACK_LOCATION"}  {:fieldname "MajorFunction"}  MajorFunction__IO_STACK_LOCATION(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.MaxCylinderNumber__ACPI_FDI_DATA"}  {:fieldname "MaxCylinderNumber"}  MaxCylinderNumber__ACPI_FDI_DATA(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.MaxTransferSize__DISKETTE_EXTENSION"}  {:fieldname "MaxTransferSize"}  MaxTransferSize__DISKETTE_EXTENSION(x:int) returns (int) {x + 304}
function {:inline true} {:fieldmap "Mem_T.MaxTransferSize__FDC_INFO"}  {:fieldname "MaxTransferSize"}  MaxTransferSize__FDC_INFO(x:int) returns (int) {x + 32}
function {:inline true} {:fieldmap "Mem_T.MaximumLength__STRING"}  {:fieldname "MaximumLength"}  MaximumLength__STRING(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.MaximumTrack__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "MaximumTrack"}  MaximumTrack__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 52}
function {:inline true} {:fieldmap "Mem_T.MediaByte__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "MediaByte"}  MediaByte__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 72}
function {:inline true} {:fieldmap "Mem_T.MediaType__DISKETTE_EXTENSION"}  {:fieldname "MediaType"}  MediaType__DISKETTE_EXTENSION(x:int) returns (int) {x + 388}
function {:inline true} {:fieldmap "Mem_T.MediaType__DISK_GEOMETRY"}  {:fieldname "MediaType"}  MediaType__DISK_GEOMETRY(x:int) returns (int) {x + 20}
function {:inline true} {:fieldmap "Mem_T.MediaType__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "MediaType"}  MediaType__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.MediaType__FORMAT_PARAMETERS"}  {:fieldname "MediaType"}  MediaType__FORMAT_PARAMETERS(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.MinorFunction__IO_STACK_LOCATION"}  {:fieldname "MinorFunction"}  MinorFunction__IO_STACK_LOCATION(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.MotorOffTime__ACPI_FDI_DATA"}  {:fieldname "MotorOffTime"}  MotorOffTime__ACPI_FDI_DATA(x:int) returns (int) {x + 28}
function {:inline true} {:fieldmap "Mem_T.MotorOffTime__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "MotorOffTime"}  MotorOffTime__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 12}
function {:inline true} {:fieldmap "Mem_T.MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "MotorSettleTimeRead"}  MotorSettleTimeRead__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 44}
function {:inline true} {:fieldmap "Mem_T.MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "MotorSettleTimeWrite"}  MotorSettleTimeWrite__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 48}
function {:inline true} {:fieldmap "Mem_T.MotorSettleTime__ACPI_FDI_DATA"}  {:fieldname "MotorSettleTime"}  MotorSettleTime__ACPI_FDI_DATA(x:int) returns (int) {x + 60}
function {:inline true} {:fieldmap "Mem_T.NameLength__MOUNTDEV_NAME"}  {:fieldname "NameLength"}  NameLength__MOUNTDEV_NAME(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.NewRequestQueueSpinLock__DISKETTE_EXTENSION"}  {:fieldname "NewRequestQueueSpinLock"}  NewRequestQueueSpinLock__DISKETTE_EXTENSION(x:int) returns (int) {x + 32}
function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"}  {:fieldname "NewRequestQueue"}  NewRequestQueue__DISKETTE_EXTENSION(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.NumberOfHeads__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "NumberOfHeads"}  NumberOfHeads__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 64}
function {:inline true} {:fieldmap "Mem_T.OutputBufferLength_unnamed_tag_22"}  {:fieldname "OutputBufferLength"}  OutputBufferLength_unnamed_tag_22(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Overlay_unnamed_tag_6"}  {:fieldname "Overlay"}  Overlay_unnamed_tag_6(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Parameters__IO_STACK_LOCATION"}  {:fieldname "Parameters"}  Parameters__IO_STACK_LOCATION(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.PendingReturned__IRP"}  {:fieldname "PendingReturned"}  PendingReturned__IRP(x:int) returns (int) {x + 52}
function {:inline true} {:fieldmap "Mem_T.PeripheralNumber__FDC_INFO"}  {:fieldname "PeripheralNumber"}  PeripheralNumber__FDC_INFO(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.PerpendicularMode__DISKETTE_EXTENSION"}  {:fieldname "PerpendicularMode"}  PerpendicularMode__DISKETTE_EXTENSION(x:int) returns (int) {x + 568}
function {:inline true} {:fieldmap "Mem_T.PoweringDown__DISKETTE_EXTENSION"}  {:fieldname "PoweringDown"}  PoweringDown__DISKETTE_EXTENSION(x:int) returns (int) {x + 736}
function {:inline true} {:fieldmap "Mem_T.VOID"}  {:fieldname "QueryPowerEvent"}  QueryPowerEvent__DISKETTE_EXTENSION(x:int) returns (int) {x + 628}
function {:inline true} {:fieldmap "Mem_T.ReadWriteGapLength__ACPI_FDI_DATA"}  {:fieldname "ReadWriteGapLength"}  ReadWriteGapLength__ACPI_FDI_DATA(x:int) returns (int) {x + 40}
function {:inline true} {:fieldmap "Mem_T.ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "ReadWriteGapLength"}  ReadWriteGapLength__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 28}
function {:inline true} {:fieldmap "Mem_T.Read_unnamed_tag_8"}  {:fieldname "Read"}  Read_unnamed_tag_8(x:int) returns (int) {x + 60}
function {:inline true} {:fieldmap "Mem_T.ReleaseFdcWithMotorRunning__DISKETTE_EXTENSION"}  {:fieldname "ReleaseFdcWithMotorRunning"}  ReleaseFdcWithMotorRunning__DISKETTE_EXTENSION(x:int) returns (int) {x + 624}
function {:inline true} {:fieldmap "Mem_T.SectorLengthCode__ACPI_FDI_DATA"}  {:fieldname "SectorLengthCode"}  SectorLengthCode__ACPI_FDI_DATA(x:int) returns (int) {x + 32}
function {:inline true} {:fieldmap "Mem_T.SectorLengthCode__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "SectorLengthCode"}  SectorLengthCode__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 16}
function {:inline true} {:fieldmap "Mem_T.SectorPerTrack__ACPI_FDI_DATA"}  {:fieldname "SectorPerTrack"}  SectorPerTrack__ACPI_FDI_DATA(x:int) returns (int) {x + 36}
function {:inline true} {:fieldmap "Mem_T.SectorsPerTrack__DISK_GEOMETRY"}  {:fieldname "SectorsPerTrack"}  SectorsPerTrack__DISK_GEOMETRY(x:int) returns (int) {x + 28}
function {:inline true} {:fieldmap "Mem_T.SectorsPerTrack__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "SectorsPerTrack"}  SectorsPerTrack__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.SectorsPerTrack__FORMAT_EX_PARAMETERS"}  {:fieldname "SectorsPerTrack"}  SectorsPerTrack__FORMAT_EX_PARAMETERS(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.SignalState__DISPATCHER_HEADER"}  {:fieldname "SignalState"}  SignalState__DISPATCHER_HEADER(x:int) returns (int) {x + 96}
function {:inline true} {:fieldmap "Mem_T.Signalling__DISPATCHER_HEADER"}  {:fieldname "Signalling"}  Signalling__DISPATCHER_HEADER(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.Size__DISPATCHER_HEADER"}  {:fieldname "Size"}  Size__DISPATCHER_HEADER(x:int) returns (int) {x + 56}
function {:inline true} {:fieldmap "Mem_T.SkewDelta__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "SkewDelta"}  SkewDelta__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 76}
function {:inline true} {:fieldmap "Mem_T.StartCylinderNumber__FORMAT_PARAMETERS"}  {:fieldname "StartCylinderNumber"}  StartCylinderNumber__FORMAT_PARAMETERS(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.StartHeadNumber__FORMAT_PARAMETERS"}  {:fieldname "StartHeadNumber"}  StartHeadNumber__FORMAT_PARAMETERS(x:int) returns (int) {x + 12}
function {:inline true} {:fieldmap "Mem_T.Status__IO_STATUS_BLOCK"}  {:fieldname "Status"}  Status__IO_STATUS_BLOCK(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA"}  {:fieldname "StepRateHeadUnloadTime"}  StepRateHeadUnloadTime__ACPI_FDI_DATA(x:int) returns (int) {x + 20}
function {:inline true} {:fieldmap "Mem_T.StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS"}  {:fieldname "StepRateHeadUnloadTime"}  StepRateHeadUnloadTime__DRIVE_MEDIA_CONSTANTS(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.SystemBuffer_unnamed_tag_2"}  {:fieldname "SystemBuffer"}  SystemBuffer_unnamed_tag_2(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.SystemState__POWER_STATE"}  {:fieldname "SystemState"}  SystemState__POWER_STATE(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.Tail__IRP"}  {:fieldname "Tail"}  Tail__IRP(x:int) returns (int) {x + 128}
function {:inline true} {:fieldmap "Mem_T.TargetObject__DISKETTE_EXTENSION"}  {:fieldname "TargetObject"}  TargetObject__DISKETTE_EXTENSION(x:int) returns (int) {x + 8}
function {:inline true} {:fieldmap "Mem_T.ThreadReferenceCount__DISKETTE_EXTENSION"}  {:fieldname "ThreadReferenceCount"}  ThreadReferenceCount__DISKETTE_EXTENSION(x:int) returns (int) {x + 280}
function {:inline true} {:fieldmap "Mem_T.TracksPerCylinder__DISK_GEOMETRY"}  {:fieldname "TracksPerCylinder"}  TracksPerCylinder__DISK_GEOMETRY(x:int) returns (int) {x + 24}
function {:inline true} {:fieldmap "Mem_T.Type3InputBuffer_unnamed_tag_22"}  {:fieldname "Type3InputBuffer"}  Type3InputBuffer_unnamed_tag_22(x:int) returns (int) {x + 12}
function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_28"}  {:fieldname "Type"}  Type_unnamed_tag_28(x:int) returns (int) {x + 0}
function {:inline true} {:fieldmap "Mem_T.UnderlyingPDO__DISKETTE_EXTENSION"}  {:fieldname "UnderlyingPDO"}  UnderlyingPDO__DISKETTE_EXTENSION(x:int) returns (int) {x + 4}
function {:inline true} {:fieldmap "Mem_T.UniqueIdLength__MOUNTDEV_UNIQUE_ID"}  {:fieldname "UniqueIdLength"}  UniqueIdLength__MOUNTDEV_UNIQUE_ID(x:int) returns (int) {x + 0}
const {:string "%s(%d)disk(%d)fdisk(%d)"} unique strConst__li2bpl1: int;
const {:string "The dispatch routine has not finished its WMI processing."} unique strConst__li2bpl4: int;
const {:string "\\ArcName\\multi"} unique strConst__li2bpl2: int;
const {:string "\\Device\\Floppy%d"} unique strConst__li2bpl0: int;
const {:string "caller"} unique strConst__li2bpl3: int;
const {:string "halt"} unique strConst__li2bpl5: int;

function {:aliasingQuery} alias1(x:int, y:int): bool;
function {:aliasingQuery} alias2(x:int, y:int): bool;
function {:aliasingQuery} alias3(x:int, y:int): bool;
function {:aliasingQuery} alias4(x:int, y:int): bool;
function {:aliasingQuery} alias5(x:int, y:int): bool;
function {:aliasingQuery} alias6(x:int, y:int): bool;
function {:aliasingQuery} alias7(x:int, y:int): bool;
function {:aliasingQuery} alias8(x:int, y:int): bool;
function {:aliasingQuery} alias9(x:int, y:int): bool;
