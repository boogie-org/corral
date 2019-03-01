var {:scalar} alloc: int;

var {:scalar} yogi_error: int;

var {:pointer} SLAM_guard_S_0: int;

var {:scalar} sdv_irql_previous_5: int;

var {:scalar} sdv_irql_previous_2: int;

var {:scalar} sdv_irql_current: int;

var {:scalar} sdv_irql_previous: int;

var {:scalar} sdv_irql_previous_4: int;

var {:scalar} sdv_irql_previous_3: int;

var {:scalar} Mem_T.INT4: [int]int;

procedure corral_nondet() returns ({:scalar} x: int);



procedure boogie_si_record_li2bpl_int(x: int);



const alloc_init: int;

procedure {:allocator} __HAVOC_malloc(size: int) returns (ret: int);
  free requires size >= 0;
  modifies alloc;
  free ensures ret == old(alloc);
  free ensures alloc >= old(alloc) + size;



procedure {:allocator "full"} __HAVOC_malloc_or_null(size: int) returns (ret: int);
  free requires size >= 0;
  modifies alloc;
  free ensures ret == old(alloc) || ret == 0;
  free ensures alloc >= old(alloc) + size;



const {:allocated} NULL: int;

axiom NULL == 0;

function BAND(a: int, b: int) : int;

function BOR(a: int, b: int) : int;

function BNOT(a: int) : int;

function INTDIV(a: int, b: int) : int;

function INTMOD(a: int, b: int) : int;

const ClfsContainerInitializing: int;

const ClfsContainerPendingArchiveAndDelete: int;

const KsDstPinDescriptor: int;

const CLFS_SCAN_FORWARD: int;

const CLFS_SCAN_INIT: int;

const ClsContainerPendingArchive: int;

const BUS1394_CLASS_GUID: int;

const CLFS_SCAN_INITIALIZED: int;

const ClsContainerInactive: int;

const ClfsNullRecord: int;

const ClfsContainerActivePendingDelete: int;

const ClfsContainerActive: int;

const GUID_61883_CLASS: int;

const UnitAddr: int;

const ClsContainerActive: int;

const ClfsClientRecord: int;

const ClsContainerPendingArchiveAndDelete: int;

const CLFS_SCAN_BUFFERED: int;

const ClfsDataRecord: int;

const KsSrcPinDescriptor: int;

const ClsContainerInitializing: int;

const ClfsContainerInactive: int;

const CLFS_MAX_CONTAINER_INFO: int;

const GUID_VIRTUAL_AVC_CLASS: int;

const GUID_AVC_CLASS: int;

const ClfsRestartRecord: int;

const ClsContainerActivePendingDelete: int;

const CLFS_SCAN_BACKWARD: int;

const ClfsContainerPendingArchive: int;

const CLFS_SCAN_CLOSE: int;

const GUID_PCMCIA_BUS_INTERFACE_STANDARD: int;

const GUID_BUS_TYPE_PCMCIA: int;

const GUID_TRANSLATOR_INTERFACE_STANDARD: int;

const GUID_PCI_VIRTUALIZATION_INTERFACE: int;

const GUID_ARBITER_INTERFACE_STANDARD: int;

const GUID_QUERY_CRASHDUMP_FUNCTIONS: int;

const GUID_ACPI_CMOS_INTERFACE_STANDARD: int;

const AvcPeerInstanceList: int;

const GUID_BUS_TYPE_1394: int;

const GUID_AGP_TARGET_BUS_INTERFACE_STANDARD: int;

const GUID_TARGET_DEVICE_REMOVE_CANCELLED: int;

const GUID_BUS_TYPE_ISAPNP: int;

const AvcAlternateOpcodePool: int;

const GUID_MF_ENUMERATION_INTERFACE: int;

const GUID_LEGACY_DEVICE_DETECTION_STANDARD: int;

const GUID_PCC_INTERFACE_STANDARD: int;

const GUID_BUS_INTERFACE_STANDARD: int;

const GUID_PNP_POWER_SETTING_CHANGE: int;

const GUID_BUS_TYPE_ACPI: int;

const GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE: int;

const GUID_BUS_TYPE_DOT4PRT: int;

const GUID_BUS_TYPE_EISA: int;

const AvcQueryTablePool: int;

const GUID_ACPI_REGS_INTERFACE_STANDARD: int;

const GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED: int;

const GUID_ACPI_INTERFACE_STANDARD2: int;

const GUID_PARTITION_UNIT_INTERFACE_STANDARD: int;

const GUID_BUS_TYPE_IRDA: int;

const AvcVirtualInstanceList: int;

const GUID_PCI_BUS_INTERFACE_STANDARD2: int;

const GUID_WUDF_DEVICE_HOST_PROBLEM: int;

const GUID_DEVICE_INTERFACE_REMOVAL: int;

const GUID_BUS_TYPE_SERENUM: int;

const GUID_PCI_DEVICE_PRESENT_INTERFACE: int;

const GUID_BUS_TYPE_MCA: int;

const GUID_POWER_DEVICE_TIMEOUTS: int;

const GUID_THERMAL_COOLING_INTERFACE: int;

const AvcFcpPool: int;

const GUID_HWPROFILE_CHANGE_CANCELLED: int;

const GUID_PNP_LOCATION_INTERFACE: int;

const GUID_MSIX_TABLE_CONFIG_INTERFACE: int;

const GUID_BUS_TYPE_INTERNAL: int;

const GUID_BUS_TYPE_LPTENUM: int;

const GUID_HWPROFILE_CHANGE_COMPLETE: int;

const GUID_DEVICE_INTERFACE_ARRIVAL: int;

const GUID_BUS_TYPE_AVC: int;

const GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD: int;

const GUID_BUS_TYPE_USB: int;

const AvcCommandContextPool: int;

const GUID_INT_ROUTE_INTERFACE_STANDARD: int;

const GUID_PROCESSOR_PCC_INTERFACE_STANDARD: int;

const GUID_BUS_TYPE_USBPRINT: int;

const GUID_BUS_TYPE_PCI: int;

const GUID_TARGET_DEVICE_QUERY_REMOVE: int;

const GUID_PCI_BUS_INTERFACE_STANDARD: int;

const GUID_HWPROFILE_QUERY_CHANGE: int;

const GUID_BUS_TYPE_SW_DEVICE: int;

const AvcCommandLinkPool: int;

const GUID_POWER_DEVICE_ENABLE: int;

const GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE: int;

const GUID_PNP_CUSTOM_NOTIFICATION: int;

const GUID_BUS_TYPE_SD: int;

const GUID_PNP_POWER_NOTIFICATION: int;

const GUID_PCC_INTERFACE_INTERNAL: int;

const GUID_D3COLD_SUPPORT_INTERFACE: int;

const GUID_REENUMERATE_SELF_INTERFACE_STANDARD: int;

const GUID_BUS_TYPE_HID: int;

const GUID_TARGET_DEVICE_REMOVE_COMPLETE: int;

const GUID_ACPI_INTERFACE_STANDARD: int;

const GUID_POWER_DEVICE_WAKE_ENABLE: int;

const sdv_cancelFptr: int;

const SLAM_guard_S_0_init: int;

const sdv_IoBuildSynchronousFsdRequest_irp: int;

const sdv_harnessStackLocation_next: int;

const sdv_other_irp: int;

const sdv_IoBuildDeviceIoControlRequest_irp: int;

const sdv_harnessDeviceExtension_two: int;

const sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock: int;

const sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX: int;

const WHEA_ERROR_PACKET_SECTION_GUID: int;

const p_sdv_fx_dev_object: int;

const sdv_IoBuildAsynchronousFsdRequest_harnessIrp: int;

const sdv_kdpc3: int;

const sdv_p_devobj_pdo: int;

const sdv_kinterrupt: int;

const sdv_IoGetDeviceToVerify_DEVICE_OBJECT: int;

const sdv_IoBuildDeviceIoControlRequest_IoStatusBlock: int;

const sdv_p_devobj_child_pdo: int;

const sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next: int;

const sdv_IoBuildAsynchronousFsdRequest_irp: int;

const sdv_dpc_ke_registered: int;

const sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock: int;

const sdv_ControllerIrp: int;

const sdv_devobj_pdo: int;

const sdv_Io_Removelock_release_wait_returned: int;

const sdv_IoGetDmaAdapter_DMA_ADAPTER: int;

const sdv_IoInitializeIrp_harnessIrp: int;

const sdv_ke_dpc: int;

const sdv_isr_routine: int;

const sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT: int;

const sdv_irp: int;

const sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next: int;

const sdv_IoCreateSynchronizationEvent_KEVENT: int;

const sdv_ControllerPirp: int;

const sdv_harnessStackLocation: int;

const sdv_other_harnessStackLocation_next: int;

const sdv_IoCreateController_CONTROLLER_OBJECT: int;

const sdv_devobj_top: int;

const sdv_kdpc_val3: int;

const sdv_IoBuildSynchronousFsdRequest_harnessIrp: int;

const sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT: int;

const sdv_driver_object: int;

const sdv_MapRegisterBase_val: int;

const sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING: int;

const sdv_IoMakeAssociatedIrp_harnessIrp: int;

const sdv_power_irp: int;

const sdv_devobj_child_pdo: int;

const sdv_harnessIrp: int;

const sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next: int;

const sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock: int;

const sdv_io_dpc: int;

const sdv_kinterrupt_val: int;

const sdv_StartIopirp: int;

const sdv_fx_dev_object: int;

const sdv_devobj_fdo: int;

const sdv_pDpcContext: int;

const sdv_harnessDeviceExtension: int;

const sdv_StartIoIrp: int;

const igdoe: int;

const sdv_p_devobj_fdo: int;

const sdv_MapRegisterBase: int;

const sdv_apc_disabled: int;

const sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock: int;

const sdv_p_devobj_top: int;

const sicrni: int;

const sdv_PowerIrp: int;

const sdv_IoBuildDeviceIoControlRequest_harnessIrp: int;

const sdv_IoMakeAssociatedIrp_irp: int;

const sdv_other_harnessIrp: int;

const sdv_IoBuildSynchronousFsdRequest_IoStatusBlock: int;

const sdv_IoInitializeIrp_irp: int;

const sdv_IoCreateNotificationEvent_KEVENT: int;

const sdv_other_harnessStackLocation: int;

const sdv_maskedEflags: int;

const sdv_MmMapIoSpace_int: int;

const ClfsContainerInitializing_1: int;

const ClfsContainerPendingArchiveAndDelete_1: int;

const CLFS_SCAN_FORWARD_1: int;

const CLFS_SCAN_INIT_1: int;

const ClsContainerPendingArchive_1: int;

const CLFS_SCAN_INITIALIZED_1: int;

const ClsContainerInactive_1: int;

const ClfsNullRecord_1: int;

const ClfsContainerActivePendingDelete_1: int;

const ClfsContainerActive_1: int;

const ClsContainerActive_1: int;

const ClfsClientRecord_1: int;

const ClsContainerPendingArchiveAndDelete_1: int;

const CLFS_SCAN_BUFFERED_1: int;

const ClfsDataRecord_1: int;

const ClsContainerInitializing_1: int;

const ClfsContainerInactive_1: int;

const CLFS_MAX_CONTAINER_INFO_1: int;

const ClfsRestartRecord_1: int;

const ClsContainerActivePendingDelete_1: int;

const CLFS_SCAN_BACKWARD_1: int;

const ClfsContainerPendingArchive_1: int;

const CLFS_SCAN_CLOSE_1: int;

const ClfsContainerInitializing_2: int;

const ClfsContainerPendingArchiveAndDelete_2: int;

const CLFS_SCAN_FORWARD_2: int;

const CLFS_SCAN_INIT_2: int;

const ClsContainerPendingArchive_2: int;

const CLFS_SCAN_INITIALIZED_2: int;

const ClsContainerInactive_2: int;

const ClfsNullRecord_2: int;

const ClfsContainerActivePendingDelete_2: int;

const ClfsContainerActive_2: int;

const UnitAddr_1: int;

const ClsContainerActive_2: int;

const ClfsClientRecord_2: int;

const ClsContainerPendingArchiveAndDelete_2: int;

const CLFS_SCAN_BUFFERED_2: int;

const ClfsDataRecord_2: int;

const ClsContainerInitializing_2: int;

const ClfsContainerInactive_2: int;

const CLFS_MAX_CONTAINER_INFO_2: int;

const ClfsRestartRecord_2: int;

const ClsContainerActivePendingDelete_2: int;

const CLFS_SCAN_BACKWARD_2: int;

const ClfsContainerPendingArchive_2: int;

const CLFS_SCAN_CLOSE_2: int;

procedure {:origName "_sdv_init2"} _sdv_init2();
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init2"} _sdv_init2()
{
  var {:scalar} Tmp_2: int;
  var {:scalar} Tmp_4: int;
  var vslice_dummy_var_0: int;

  anon0:
    call {:si_unique_call 0} Tmp_2 := __HAVOC_malloc(4);
    call {:si_unique_call 1} vslice_dummy_var_0 := __HAVOC_malloc(4);
    call {:si_unique_call 2} Tmp_4 := __HAVOC_malloc(4);
    assume ClfsNullRecord == 0;
    assume ClfsDataRecord == 1;
    assume ClfsRestartRecord == 2;
    assume ClfsClientRecord == 3;
    assume ClsContainerInitializing == 1;
    assume ClsContainerInactive == 2;
    assume ClsContainerActive == 4;
    assume ClsContainerActivePendingDelete == 8;
    assume ClsContainerPendingArchive == 16;
    assume ClsContainerPendingArchiveAndDelete == 32;
    assume ClfsContainerInitializing == 1;
    assume ClfsContainerInactive == 2;
    assume ClfsContainerActive == 4;
    assume ClfsContainerActivePendingDelete == 8;
    assume ClfsContainerPendingArchive == 16;
    assume ClfsContainerPendingArchiveAndDelete == 32;
    assume CLFS_MAX_CONTAINER_INFO == 256;
    assume CLFS_SCAN_INIT == 1;
    assume CLFS_SCAN_FORWARD == 2;
    assume CLFS_SCAN_BACKWARD == 4;
    assume CLFS_SCAN_CLOSE == 8;
    assume CLFS_SCAN_INITIALIZED == 16;
    assume CLFS_SCAN_BUFFERED == 32;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    assume UnitAddr == 255;
    assume {:nonnull} Tmp_4 != 0;
    assume Tmp_4 > 0;
    assume {:nonnull} Tmp_2 != 0;
    assume Tmp_2 > 0;
    return;
}



procedure {:origName "sdv_hash_330311584_sdv_special_DTOR"} sdv_hash_330311584_sdv_special_DTOR(actual_this: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_330311584_sdv_special_DTOR"} sdv_hash_330311584_sdv_special_DTOR(actual_this: int)
{
  var {:pointer} this: int;
  var vslice_dummy_var_1: int;
  var vslice_dummy_var_2: int;
  var vslice_dummy_var_3: int;

  anon0:
    call {:si_unique_call 3} vslice_dummy_var_1 := __HAVOC_malloc(4);
    this := actual_this;
    call {:si_unique_call 4} sdv_do_paged_code_check();
    call {:si_unique_call 5} vslice_dummy_var_2 := sdv_hash_145490435(this, 0, 0);
    call {:si_unique_call 6} vslice_dummy_var_3 := sdv_hash_174130848(this, 0, 0);
    assume {:nonnull} this != 0;
    assume this > 0;
    call {:si_unique_call 7} sdv_hash_648551832_sdv_special_DTOR(m_DstAddr_CKsPinDescriptor(this));
    assume {:nonnull} this != 0;
    assume this > 0;
    call {:si_unique_call 8} sdv_hash_648551832_sdv_special_DTOR(m_SrcAddr_CKsPinDescriptor(this));
    return;
}



procedure {:origName "sdv_hash_174130848"} sdv_hash_174130848(actual_this_1: int, actual_MediumsCount: int, actual_Mediums: int) returns (Tmp_7: int);
  modifies alloc;
  free ensures Tmp_7 == actual_this_1;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_174130848"} sdv_hash_174130848(actual_this_1: int, actual_MediumsCount: int, actual_Mediums: int) returns (Tmp_7: int)
{
  var {:scalar} cbMediums: int;
  var {:pointer} sdv_3: int;
  var {:pointer} this_1: int;
  var {:scalar} MediumsCount: int;
  var {:pointer} Mediums: int;

  anon0:
    this_1 := actual_this_1;
    MediumsCount := actual_MediumsCount;
    Mediums := actual_Mediums;
    call {:si_unique_call 9} sdv_do_paged_code_check();
    assume {:nonnull} this_1 != 0;
    assume this_1 > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    call {:si_unique_call 10} sdv_ExFreePool(0);
    assume {:nonnull} this_1 != 0;
    assume this_1 > 0;
    assume {:nonnull} this_1 != 0;
    assume this_1 > 0;
    goto L7;

  L7:
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} MediumsCount != 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} Mediums != 0;
    cbMediums := MediumsCount * 24;
    call {:si_unique_call 11} sdv_3 := ExAllocatePoolWithTag(1, cbMediums, 541283905);
    assume {:nonnull} this_1 != 0;
    assume this_1 > 0;
    assume {:nonnull} this_1 != 0;
    assume this_1 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:nonnull} this_1 != 0;
    assume this_1 > 0;
    call {:si_unique_call 12} sdv_RtlCopyMemory(0, 0, cbMediums);
    goto L13;

  L13:
    Tmp_7 := this_1;
    return;

  anon12_Then:
    goto L13;

  anon11_Then:
    assume {:partition} Mediums == 0;
    goto L13;

  anon10_Then:
    assume {:partition} MediumsCount == 0;
    goto L13;

  anon9_Then:
    goto L7;
}



procedure {:origName "sdv_hash_145490435"} sdv_hash_145490435(actual_this_2: int, actual_InterfacesCount: int, actual_Interfaces: int) returns (Tmp_9: int);
  modifies alloc;
  free ensures Tmp_9 == actual_this_2;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_145490435"} sdv_hash_145490435(actual_this_2: int, actual_InterfacesCount: int, actual_Interfaces: int) returns (Tmp_9: int)
{
  var {:pointer} sdv_4: int;
  var {:scalar} cbInterfaces: int;
  var {:pointer} this_2: int;
  var {:scalar} InterfacesCount: int;
  var {:pointer} Interfaces: int;

  anon0:
    this_2 := actual_this_2;
    InterfacesCount := actual_InterfacesCount;
    Interfaces := actual_Interfaces;
    call {:si_unique_call 13} sdv_do_paged_code_check();
    assume {:nonnull} this_2 != 0;
    assume this_2 > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    call {:si_unique_call 14} sdv_ExFreePool(0);
    assume {:nonnull} this_2 != 0;
    assume this_2 > 0;
    assume {:nonnull} this_2 != 0;
    assume this_2 > 0;
    goto L7;

  L7:
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} InterfacesCount != 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} Interfaces != 0;
    cbInterfaces := InterfacesCount * 24;
    call {:si_unique_call 15} sdv_4 := ExAllocatePoolWithTag(1, cbInterfaces, 541283905);
    assume {:nonnull} this_2 != 0;
    assume this_2 > 0;
    assume {:nonnull} this_2 != 0;
    assume this_2 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:nonnull} this_2 != 0;
    assume this_2 > 0;
    call {:si_unique_call 16} sdv_RtlCopyMemory(0, 0, cbInterfaces);
    goto L13;

  L13:
    Tmp_9 := this_2;
    return;

  anon12_Then:
    goto L13;

  anon11_Then:
    assume {:partition} Interfaces == 0;
    goto L13;

  anon10_Then:
    assume {:partition} InterfacesCount == 0;
    goto L13;

  anon9_Then:
    goto L7;
}



procedure {:origName "Avc_Close"} Avc_Close(actual_DeviceObject: int, actual_Irp: int) returns (Tmp_11: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_11 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_Close"} Avc_Close(actual_DeviceObject: int, actual_Irp: int) returns (Tmp_11: int)
{
  var {:scalar} ntStatus: int;
  var {:pointer} CommonExtension: int;
  var {:pointer} DeviceObject: int;
  var {:pointer} Irp: int;
  var vslice_dummy_var_4: int;

  anon0:
    DeviceObject := actual_DeviceObject;
    Irp := actual_Irp;
    assume {:nonnull} DeviceObject != 0;
    assume DeviceObject > 0;
    havoc CommonExtension;
    call {:si_unique_call 17} vslice_dummy_var_4 := sdv_IoGetCurrentIrpStackLocation(Irp);
    ntStatus := 0;
    call {:si_unique_call 18} sdv_do_paged_code_check();
    assume {:nonnull} CommonExtension != 0;
    assume CommonExtension > 0;
    call {:si_unique_call 19} AvcReleaseRemoveLock(RemoveLock__COMMON_DEVICE_EXTENSION(CommonExtension));
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    call {:si_unique_call 20} sdv_IoCompleteRequest(0, 0);
    Tmp_11 := ntStatus;
    return;
}



procedure {:origName "AvcInitializeRemoveLock"} AvcInitializeRemoveLock(actual_Lock: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcInitializeRemoveLock"} AvcInitializeRemoveLock(actual_Lock: int)
{
  var {:pointer} Lock: int;
  var vslice_dummy_var_5: int;

  anon0:
    call {:si_unique_call 21} vslice_dummy_var_5 := __HAVOC_malloc(4);
    Lock := actual_Lock;
    call {:si_unique_call 22} sdv_do_paged_code_check();
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} Lock != 0;
    assume {:nonnull} Lock != 0;
    assume Lock > 0;
    assume {:nonnull} Lock != 0;
    assume Lock > 0;
    assume {:nonnull} Lock != 0;
    assume Lock > 0;
    call {:si_unique_call 23} KeInitializeEvent(RemoveEvent__AVC_REMOVE_LOCK(Lock), 1, 0);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} Lock == 0;
    goto L1;
}



procedure {:origName "AvcReleaseRemoveLock"} AvcReleaseRemoveLock(actual_Lock_1: int);
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcReleaseRemoveLock"} AvcReleaseRemoveLock(actual_Lock_1: int)
{
  var {:pointer} Tmp_15: int;
  var {:scalar} lockValue: int;
  var {:pointer} Lock_1: int;
  var vslice_dummy_var_6: int;
  var vslice_dummy_var_7: int;
  var vslice_dummy_var_0: int;

  anon0:
    call {:si_unique_call 24} vslice_dummy_var_6 := __HAVOC_malloc(4);
    Lock_1 := actual_Lock_1;
    call {:si_unique_call 25} Tmp_15 := __HAVOC_malloc(4);
    assume {:nonnull} Lock_1 != 0;
    assume Lock_1 > 0;
    assume {:nonnull} Tmp_15 != 0;
    assume Tmp_15 > 0;
    havoc vslice_dummy_var_0;
    Mem_T.INT4[Tmp_15] := vslice_dummy_var_0;
    call {:si_unique_call 26} lockValue := sdv_InterlockedDecrement(Tmp_15);
    assume {:nonnull} Lock_1 != 0;
    assume Lock_1 > 0;
    assume {:nonnull} Tmp_15 != 0;
    assume Tmp_15 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} lockValue == 0;
    assume {:nonnull} Lock_1 != 0;
    assume Lock_1 > 0;
    call {:si_unique_call 27} vslice_dummy_var_7 := KeSetEvent(RemoveEvent__AVC_REMOVE_LOCK(Lock_1), 0, 0);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} lockValue != 0;
    goto L1;
}



procedure {:origName "Avc_Create"} Avc_Create(actual_DeviceObject_1: int, actual_Irp_1: int) returns (Tmp_17: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_17 == -1073741738 || Tmp_17 == 0 || Tmp_17 == -1073741811;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_Create"} Avc_Create(actual_DeviceObject_1: int, actual_Irp_1: int) returns (Tmp_17: int)
{
  var {:pointer} Tmp_18: int;
  var {:pointer} IrpStack_1: int;
  var {:scalar} ntStatus_1: int;
  var {:pointer} CommonExtension_1: int;
  var {:pointer} DeviceObject_1: int;
  var {:pointer} Irp_1: int;

  anon0:
    DeviceObject_1 := actual_DeviceObject_1;
    Irp_1 := actual_Irp_1;
    assume {:nonnull} DeviceObject_1 != 0;
    assume DeviceObject_1 > 0;
    havoc CommonExtension_1;
    call {:si_unique_call 28} IrpStack_1 := sdv_IoGetCurrentIrpStackLocation(Irp_1);
    ntStatus_1 := 0;
    call {:si_unique_call 29} sdv_do_paged_code_check();
    assume {:nonnull} CommonExtension_1 != 0;
    assume CommonExtension_1 > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    goto L17;

  L17:
    ntStatus_1 := -1073741811;
    goto L18;

  L18:
    assume {:nonnull} CommonExtension_1 != 0;
    assume CommonExtension_1 > 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    ntStatus_1 := -1073741738;
    goto L19;

  L19:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} ntStatus_1 != 0;
    goto L24;

  L24:
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    call {:si_unique_call 30} sdv_IoCompleteRequest(0, 0);
    Tmp_17 := ntStatus_1;
    return;

  anon11_Then:
    assume {:partition} ntStatus_1 == 0;
    assume {:nonnull} CommonExtension_1 != 0;
    assume CommonExtension_1 > 0;
    call {:si_unique_call 31} ntStatus_1 := AvcAcquireRemoveLock(RemoveLock__COMMON_DEVICE_EXTENSION(CommonExtension_1));
    goto L24;

  anon10_Then:
    goto L19;

  anon9_Then:
    assume {:nonnull} IrpStack_1 != 0;
    assume IrpStack_1 > 0;
    havoc Tmp_18;
    assume {:nonnull} Tmp_18 != 0;
    assume Tmp_18 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    goto L18;

  anon12_Then:
    goto L17;
}



procedure {:origName "Avc_SynchCompletionRoutine"} Avc_SynchCompletionRoutine(actual_DeviceObject_2: int, actual_Irp_2: int, actual_EventIn: int) returns (Tmp_20: int);
  free ensures Tmp_20 == -1073741802;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_SynchCompletionRoutine"} Avc_SynchCompletionRoutine(actual_DeviceObject_2: int, actual_Irp_2: int, actual_EventIn: int) returns (Tmp_20: int)
{
  var {:pointer} Event: int;
  var {:pointer} EventIn: int;
  var vslice_dummy_var_8: int;

  anon0:
    EventIn := actual_EventIn;
    Event := EventIn;
    call {:si_unique_call 32} vslice_dummy_var_8 := KeSetEvent(Event, 0, 0);
    Tmp_20 := -1073741802;
    return;
}



procedure {:origName "AvcGetDescriptionMessage"} AvcGetDescriptionMessage(actual_MessageNumber: int, actual_description: int) returns (Tmp_22: int);
  modifies alloc;
  free ensures Tmp_22 == -1073741559 || Tmp_22 == 0 || Tmp_22 == -1073741670;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcGetDescriptionMessage"} AvcGetDescriptionMessage(actual_MessageNumber: int, actual_description: int) returns (Tmp_22: int)
{
  var {:scalar} sdv_11: int;
  var {:pointer} sdv_12: int;
  var {:scalar} cBytes: int;
  var {:scalar} MessageNumber: int;
  var {:pointer} description: int;

  anon0:
    MessageNumber := actual_MessageNumber;
    description := actual_description;
    call {:si_unique_call 33} sdv_do_paged_code_check();
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} MessageNumber != 0;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} MessageNumber != 8;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} MessageNumber != 16;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} MessageNumber != 24;
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} MessageNumber != 32;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} MessageNumber != 40;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} MessageNumber != 48;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} MessageNumber != 56;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} MessageNumber != 72;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} MessageNumber != 80;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} MessageNumber != 88;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} MessageNumber != 65536;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} MessageNumber == 65537;
    goto L27;

  L27:
    cBytes := sdv_11 * 2 + 2;
    call {:si_unique_call 34} sdv_12 := ExAllocatePoolWithTag(1, cBytes, 541283905);
    assume {:nonnull} description != 0;
    assume description > 0;
    assume {:nonnull} description != 0;
    assume description > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    call {:si_unique_call 35} sdv_RtlCopyMemory(0, 0, cBytes);
    Tmp_22 := 0;
    goto L1;

  L1:
    return;

  anon42_Then:
    Tmp_22 := -1073741670;
    goto L1;

  anon30_Then:
    assume {:partition} MessageNumber != 65537;
    assume {:nonnull} description != 0;
    assume description > 0;
    Tmp_22 := -1073741559;
    goto L1;

  anon31_Then:
    assume {:partition} MessageNumber == 65536;
    goto L27;

  anon32_Then:
    assume {:partition} MessageNumber == 88;
    goto L27;

  anon33_Then:
    assume {:partition} MessageNumber == 80;
    goto L27;

  anon34_Then:
    assume {:partition} MessageNumber == 72;
    goto L27;

  anon35_Then:
    assume {:partition} MessageNumber == 56;
    goto L27;

  anon36_Then:
    assume {:partition} MessageNumber == 48;
    goto L27;

  anon37_Then:
    assume {:partition} MessageNumber == 40;
    goto L27;

  anon38_Then:
    assume {:partition} MessageNumber == 32;
    goto L27;

  anon39_Then:
    assume {:partition} MessageNumber == 24;
    goto L27;

  anon40_Then:
    assume {:partition} MessageNumber == 16;
    goto L27;

  anon41_Then:
    assume {:partition} MessageNumber == 8;
    goto L27;

  anon29_Then:
    assume {:partition} MessageNumber == 0;
    goto L27;
}



procedure {:origName "Avc_SubmitIrpSynch"} Avc_SubmitIrpSynch(actual_DeviceObject_3: int, actual_Irp_3: int) returns (Tmp_24: int);
  modifies alloc, Mem_T.INT4, yogi_error, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_SubmitIrpSynch"} Avc_SubmitIrpSynch(actual_DeviceObject_3: int, actual_Irp_3: int) returns (Tmp_24: int)
{
  var {:scalar} Event_1: int;
  var {:scalar} ntStatus_2: int;
  var {:pointer} DeviceObject_3: int;
  var {:pointer} Irp_3: int;
  var vslice_dummy_var_9: int;

  anon0:
    call {:si_unique_call 36} Event_1 := __HAVOC_malloc(156);
    DeviceObject_3 := actual_DeviceObject_3;
    Irp_3 := actual_Irp_3;
    call {:si_unique_call 37} sdv_do_paged_code_check();
    call {:si_unique_call 38} KeInitializeEvent(Event_1, 1, 0);
    call {:si_unique_call 39} sdv_IoSetCompletionRoutine(Irp_3, li2bplFunctionConstant942, Event_1, 1, 1, 1);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume Irp_3 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 40} SLIC_sdv_IoCallDriver_entry(strConst__li2bpl13, Irp_3);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} yogi_error != 1;
    goto L26;

  L26:
    call {:si_unique_call 41} ntStatus_2 := sdv_IoCallDriver#1(DeviceObject_3, Irp_3);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} yogi_error != 1;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} ntStatus_2 == 259;
    call {:si_unique_call 42} vslice_dummy_var_9 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    havoc ntStatus_2;
    goto L19;

  L19:
    Tmp_24 := ntStatus_2;
    goto LM2;

  LM2:
    return;

  anon10_Then:
    assume {:partition} ntStatus_2 != 259;
    goto L19;

  anon12_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon11_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon9_Then:
    assume !(Irp_3 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L26;
}



procedure {:origName "AvcAcquireRemoveLock"} AvcAcquireRemoveLock(actual_Lock_2: int) returns (Tmp_26: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_26 == -1073741738 || Tmp_26 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcAcquireRemoveLock"} AvcAcquireRemoveLock(actual_Lock_2: int) returns (Tmp_26: int)
{
  var {:scalar} sdv_16: int;
  var {:scalar} ntStatus_3: int;
  var {:pointer} Tmp_27: int;
  var {:pointer} Lock_2: int;
  var vslice_dummy_var_10: int;
  var vslice_dummy_var_11: int;
  var vslice_dummy_var_1: int;
  var vslice_dummy_var_2: int;

  anon0:
    Lock_2 := actual_Lock_2;
    ntStatus_3 := 0;
    call {:si_unique_call 43} Tmp_27 := __HAVOC_malloc(4);
    assume {:nonnull} Lock_2 != 0;
    assume Lock_2 > 0;
    assume {:nonnull} Tmp_27 != 0;
    assume Tmp_27 > 0;
    havoc vslice_dummy_var_1;
    Mem_T.INT4[Tmp_27] := vslice_dummy_var_1;
    call {:si_unique_call 44} vslice_dummy_var_11 := sdv_InterlockedIncrement(Tmp_27);
    assume {:nonnull} Lock_2 != 0;
    assume Lock_2 > 0;
    assume {:nonnull} Tmp_27 != 0;
    assume Tmp_27 > 0;
    assume {:nonnull} Lock_2 != 0;
    assume Lock_2 > 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    call {:si_unique_call 45} Tmp_27 := __HAVOC_malloc(4);
    assume {:nonnull} Lock_2 != 0;
    assume Lock_2 > 0;
    assume {:nonnull} Tmp_27 != 0;
    assume Tmp_27 > 0;
    havoc vslice_dummy_var_2;
    Mem_T.INT4[Tmp_27] := vslice_dummy_var_2;
    call {:si_unique_call 46} sdv_16 := sdv_InterlockedDecrement(Tmp_27);
    assume {:nonnull} Lock_2 != 0;
    assume Lock_2 > 0;
    assume {:nonnull} Tmp_27 != 0;
    assume Tmp_27 > 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} sdv_16 != 0;
    goto L19;

  L19:
    ntStatus_3 := -1073741738;
    goto L11;

  L11:
    Tmp_26 := ntStatus_3;
    return;

  anon6_Then:
    assume {:partition} sdv_16 == 0;
    assume {:nonnull} Lock_2 != 0;
    assume Lock_2 > 0;
    call {:si_unique_call 47} vslice_dummy_var_10 := KeSetEvent(RemoveEvent__AVC_REMOVE_LOCK(Lock_2), 0, 0);
    goto L19;

  anon5_Then:
    goto L11;
}



procedure {:origName "AvcGetDeviceDescriptionMessage"} AvcGetDeviceDescriptionMessage(actual_SubunitAddr: int, actual_deviceDescription: int) returns (Tmp_28: int);
  modifies alloc;
  free ensures Tmp_28 == -1073741559 || Tmp_28 == 0 || Tmp_28 == -1073741670;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcGetDeviceDescriptionMessage"} AvcGetDeviceDescriptionMessage(actual_SubunitAddr: int, actual_deviceDescription: int) returns (Tmp_28: int)
{
  var {:scalar} messageNumber: int;
  var {:scalar} ntStatus_4: int;
  var {:pointer} SubunitAddr: int;
  var {:pointer} deviceDescription: int;

  anon0:
    SubunitAddr := actual_SubunitAddr;
    deviceDescription := actual_deviceDescription;
    ntStatus_4 := -1073741559;
    call {:si_unique_call 48} sdv_do_paged_code_check();
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} SubunitAddr != 0;
    assume {:nonnull} SubunitAddr != 0;
    assume SubunitAddr > 0;
    messageNumber := BAND(Mem_T.INT4[SubunitAddr], BNOT(BOR(BOR(1, 2), 4)));
    call {:si_unique_call 49} ntStatus_4 := AvcGetDescriptionMessage(messageNumber, deviceDescription);
    goto L9;

  L9:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} -1073741559 == ntStatus_4;
    call {:si_unique_call 50} ntStatus_4 := AvcGetDescriptionMessage(65537, deviceDescription);
    goto L16;

  L16:
    Tmp_28 := ntStatus_4;
    return;

  anon6_Then:
    assume {:partition} -1073741559 != ntStatus_4;
    goto L16;

  anon5_Then:
    assume {:partition} SubunitAddr == 0;
    goto L9;
}



procedure {:origName "Avc_Cleanup"} Avc_Cleanup(actual_DeviceObject_4: int, actual_Irp_4: int) returns (Tmp_30: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures Tmp_30 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_Cleanup"} Avc_Cleanup(actual_DeviceObject_4: int, actual_Irp_4: int) returns (Tmp_30: int)
{
  var {:pointer} IrpStack_2: int;
  var {:scalar} ntStatus_5: int;
  var {:pointer} CommonExtension_2: int;
  var {:pointer} DeviceObject_4: int;
  var {:pointer} Irp_4: int;
  var vslice_dummy_var_3: int;

  anon0:
    DeviceObject_4 := actual_DeviceObject_4;
    Irp_4 := actual_Irp_4;
    assume {:nonnull} DeviceObject_4 != 0;
    assume DeviceObject_4 > 0;
    havoc CommonExtension_2;
    call {:si_unique_call 51} IrpStack_2 := sdv_IoGetCurrentIrpStackLocation(Irp_4);
    ntStatus_5 := 0;
    call {:si_unique_call 52} sdv_do_paged_code_check();
    assume {:nonnull} CommonExtension_2 != 0;
    assume CommonExtension_2 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} IrpStack_2 != 0;
    assume IrpStack_2 > 0;
    havoc vslice_dummy_var_3;
    call {:si_unique_call 53} AvcStopSelectedFCPProcessing(CommonExtension_2, vslice_dummy_var_3);
    goto L16;

  L16:
    assume {:nonnull} Irp_4 != 0;
    assume Irp_4 > 0;
    assume {:nonnull} Irp_4 != 0;
    assume Irp_4 > 0;
    call {:si_unique_call 54} sdv_IoCompleteRequest(0, 0);
    Tmp_30 := ntStatus_5;
    return;

  anon3_Then:
    goto L16;
}



procedure {:origName "_sdv_init8"} _sdv_init8();
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init8"} _sdv_init8()
{
  var vslice_dummy_var_12: int;

  anon0:
    call {:si_unique_call 55} vslice_dummy_var_12 := __HAVOC_malloc(4);
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    return;
}



procedure {:origName "DriverEntry"} DriverEntry(actual_DriverObject: int, actual_RegistryPath: int) returns (Tmp_34: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_34 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "DriverEntry"} DriverEntry(actual_DriverObject: int, actual_RegistryPath: int) returns (Tmp_34: int)
{
  var {:pointer} Tmp_35: int;
  var {:pointer} Tmp_36: int;
  var {:pointer} Tmp_37: int;
  var {:pointer} Tmp_38: int;
  var {:pointer} Tmp_39: int;
  var {:pointer} Tmp_40: int;
  var {:pointer} Tmp_41: int;
  var {:pointer} Tmp_42: int;
  var {:pointer} Tmp_43: int;
  var {:scalar} ntStatus_6: int;
  var {:pointer} Tmp_44: int;
  var {:pointer} DriverObject: int;
  var vslice_dummy_var_4: int;

  anon0:
    DriverObject := actual_DriverObject;
    call {:si_unique_call 56} Tmp_35 := __HAVOC_malloc(112);
    call {:si_unique_call 57} Tmp_37 := __HAVOC_malloc(112);
    call {:si_unique_call 58} Tmp_38 := __HAVOC_malloc(112);
    call {:si_unique_call 59} Tmp_39 := __HAVOC_malloc(112);
    call {:si_unique_call 60} Tmp_40 := __HAVOC_malloc(112);
    call {:si_unique_call 61} Tmp_41 := __HAVOC_malloc(112);
    call {:si_unique_call 62} Tmp_42 := __HAVOC_malloc(112);
    call {:si_unique_call 63} Tmp_43 := __HAVOC_malloc(112);
    ntStatus_6 := 0;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    havoc Tmp_40;
    assume {:nonnull} Tmp_40 != 0;
    assume Tmp_40 > 0;
    Mem_T.INT4[Tmp_40] := li2bplFunctionConstant938;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    havoc Tmp_39;
    assume {:nonnull} Tmp_39 != 0;
    assume Tmp_39 > 0;
    Mem_T.INT4[Tmp_39 + 2 * 4] := li2bplFunctionConstant939;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    havoc Tmp_41;
    assume {:nonnull} Tmp_41 != 0;
    assume Tmp_41 > 0;
    Mem_T.INT4[Tmp_41 + 18 * 4] := li2bplFunctionConstant940;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    havoc Tmp_35;
    assume {:nonnull} Tmp_35 != 0;
    assume Tmp_35 > 0;
    Mem_T.INT4[Tmp_35 + 27 * 4] := li2bplFunctionConstant798;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    havoc Tmp_38;
    assume {:nonnull} Tmp_38 != 0;
    assume Tmp_38 > 0;
    Mem_T.INT4[Tmp_38 + 22 * 4] := li2bplFunctionConstant519;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    havoc Tmp_43;
    assume {:nonnull} Tmp_43 != 0;
    assume Tmp_43 > 0;
    Mem_T.INT4[Tmp_43 + 14 * 4] := li2bplFunctionConstant811;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    havoc Tmp_42;
    assume {:nonnull} Tmp_42 != 0;
    assume Tmp_42 > 0;
    Mem_T.INT4[Tmp_42 + 15 * 4] := li2bplFunctionConstant811;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    havoc Tmp_37;
    assume {:nonnull} Tmp_37 != 0;
    assume Tmp_37 > 0;
    Mem_T.INT4[Tmp_37 + 23 * 4] := li2bplFunctionConstant813;
    assume {:nonnull} DriverObject != 0;
    assume DriverObject > 0;
    havoc Tmp_44;
    assume {:nonnull} Tmp_44 != 0;
    assume Tmp_44 > 0;
    call {:si_unique_call 64} Tmp_36 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_36 != 0;
    assume Tmp_36 > 0;
    havoc vslice_dummy_var_4;
    Mem_T.INT4[Tmp_36] := vslice_dummy_var_4;
    call {:si_unique_call 65} sdv_KeInitializeSpinLock(Tmp_36);
    assume {:nonnull} Tmp_36 != 0;
    assume Tmp_36 > 0;
    call {:si_unique_call 66} InitializeListHead(AvcVirtualInstanceList);
    call {:si_unique_call 67} InitializeListHead(AvcPeerInstanceList);
    call {:si_unique_call 68} sdv_ExInitializeNPagedLookasideList_NXPoolOptIn(0, 0, 0, 0, 672, 543389281, 0);
    call {:si_unique_call 69} sdv_ExInitializeNPagedLookasideList_NXPoolOptIn(0, 0, 0, 0, 256, 543389281, 0);
    call {:si_unique_call 70} sdv_ExInitializeNPagedLookasideList_NXPoolOptIn(0, 0, 0, 0, 16, 543389281, 0);
    call {:si_unique_call 71} sdv_ExInitializeNPagedLookasideList_NXPoolOptIn(0, 0, 0, 0, 560, 543389281, 0);
    call {:si_unique_call 72} sdv_ExInitializeNPagedLookasideList_NXPoolOptIn(0, 0, 0, 0, 56, 543389281, 0);
    Tmp_34 := ntStatus_6;
    return;
}



procedure {:origName "Avc_Unload"} Avc_Unload(actual_DriverObject_1: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_Unload"} Avc_Unload(actual_DriverObject_1: int)
{
  var vslice_dummy_var_13: int;

  anon0:
    call {:si_unique_call 73} vslice_dummy_var_13 := __HAVOC_malloc(4);
    call {:si_unique_call 74} sdv_do_paged_code_check();
    call {:si_unique_call 75} ExDeleteNPagedLookasideList(0);
    call {:si_unique_call 76} ExDeleteNPagedLookasideList(0);
    call {:si_unique_call 77} ExDeleteNPagedLookasideList(0);
    call {:si_unique_call 78} ExDeleteNPagedLookasideList(0);
    call {:si_unique_call 79} ExDeleteNPagedLookasideList(0);
    return;
}



procedure {:origName "AvcReleaseRemoveLockAndWait"} AvcReleaseRemoveLockAndWait(actual_Lock_3: int);
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcReleaseRemoveLockAndWait"} AvcReleaseRemoveLockAndWait(actual_Lock_3: int)
{
  var {:scalar} sdv_22: int;
  var {:pointer} Tmp_48: int;
  var {:pointer} Lock_3: int;
  var vslice_dummy_var_14: int;
  var vslice_dummy_var_15: int;
  var vslice_dummy_var_16: int;
  var vslice_dummy_var_5: int;
  var vslice_dummy_var_6: int;

  anon0:
    call {:si_unique_call 80} vslice_dummy_var_14 := __HAVOC_malloc(4);
    Lock_3 := actual_Lock_3;
    call {:si_unique_call 81} sdv_do_paged_code_check();
    assume {:nonnull} Lock_3 != 0;
    assume Lock_3 > 0;
    call {:si_unique_call 82} Tmp_48 := __HAVOC_malloc(4);
    assume {:nonnull} Lock_3 != 0;
    assume Lock_3 > 0;
    assume {:nonnull} Tmp_48 != 0;
    assume Tmp_48 > 0;
    havoc vslice_dummy_var_5;
    Mem_T.INT4[Tmp_48] := vslice_dummy_var_5;
    call {:si_unique_call 83} vslice_dummy_var_16 := sdv_InterlockedDecrement(Tmp_48);
    assume {:nonnull} Lock_3 != 0;
    assume Lock_3 > 0;
    assume {:nonnull} Tmp_48 != 0;
    assume Tmp_48 > 0;
    call {:si_unique_call 84} Tmp_48 := __HAVOC_malloc(4);
    assume {:nonnull} Lock_3 != 0;
    assume Lock_3 > 0;
    assume {:nonnull} Tmp_48 != 0;
    assume Tmp_48 > 0;
    havoc vslice_dummy_var_6;
    Mem_T.INT4[Tmp_48] := vslice_dummy_var_6;
    call {:si_unique_call 85} sdv_22 := sdv_InterlockedDecrement(Tmp_48);
    assume {:nonnull} Lock_3 != 0;
    assume Lock_3 > 0;
    assume {:nonnull} Tmp_48 != 0;
    assume Tmp_48 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} sdv_22 > 0;
    call {:si_unique_call 86} vslice_dummy_var_15 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} 0 >= sdv_22;
    goto L1;
}



procedure {:origName "AvcPrepareForResponseCallback"} AvcPrepareForResponseCallback(actual_DevExt: int, actual_Command: int) returns (Tmp_49: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcPrepareForResponseCallback"} AvcPrepareForResponseCallback(actual_DevExt: int, actual_Command: int) returns (Tmp_49: int)
{
  var {:scalar} Status: int;
  var {:pointer} Tmp_50: int;
  var {:scalar} OldIrql: int;
  var {:pointer} NextIrpStack: int;
  var {:pointer} Tmp_51: int;
  var {:scalar} NeedIrp: int;
  var {:pointer} Tmp_52: int;
  var {:pointer} DevExt: int;
  var {:pointer} Command: int;
  var boogieTmp: int;
  var vslice_dummy_var_17: int;
  var vslice_dummy_var_18: int;
  var vslice_dummy_var_19: int;
  var vslice_dummy_var_7: int;
  var vslice_dummy_var_8: int;
  var vslice_dummy_var_9: int;
  var vslice_dummy_var_10: int;
  var vslice_dummy_var_11: int;

  anon0:
    DevExt := actual_DevExt;
    Command := actual_Command;
    Status := 0;
    NeedIrp := 0;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    Tmp_49 := Status;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon20_Then:
    call {:si_unique_call 87} Tmp_52 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_52 != 0;
    assume Tmp_52 > 0;
    Mem_T.INT4[Tmp_52] := OldIrql;
    call {:si_unique_call 88} sdv_KeAcquireSpinLock(0, Tmp_52);
    assume {:nonnull} Tmp_52 != 0;
    assume Tmp_52 > 0;
    OldIrql := Mem_T.INT4[Tmp_52];
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} Command != 0;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    call {:si_unique_call 89} vslice_dummy_var_17 := sdv_InsertTailList(PendingResponseList__BUS_DEVICE_EXTENSION(DevExt), Command);
    goto L14;

  L14:
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    goto L21;

  L21:
    call {:si_unique_call 90} sdv_KeReleaseSpinLock(0, OldIrql);
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} NeedIrp != 0;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    havoc vslice_dummy_var_7;
    call {:si_unique_call 91} NextIrpStack := sdv_IoGetNextIrpStackLocation(vslice_dummy_var_7);
    assume {:nonnull} NextIrpStack != 0;
    assume NextIrpStack > 0;
    assume {:nonnull} NextIrpStack != 0;
    assume NextIrpStack > 0;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    assume {:nonnull} NextIrpStack != 0;
    assume NextIrpStack > 0;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    havoc Tmp_50;
    assume {:nonnull} Tmp_50 != 0;
    assume Tmp_50 > 0;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    havoc vslice_dummy_var_8;
    call {:si_unique_call 92} sdv_IoSetCompletionRoutine(vslice_dummy_var_8, li2bplFunctionConstant842, DevExt, 1, 1, 1);
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    havoc vslice_dummy_var_9;
    havoc vslice_dummy_var_10;
    call {:si_unique_call 93} vslice_dummy_var_18 := sdv_IoCallDriver#1(vslice_dummy_var_9, vslice_dummy_var_10);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} yogi_error != 1;
    goto L25;

  L25:
    Tmp_49 := Status;
    goto L1;

  anon21_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon18_Then:
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} Command != 0;
    call {:si_unique_call 94} Tmp_52 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_52 != 0;
    assume Tmp_52 > 0;
    Mem_T.INT4[Tmp_52] := OldIrql;
    call {:si_unique_call 95} sdv_KeAcquireSpinLock(0, Tmp_52);
    assume {:nonnull} Tmp_52 != 0;
    assume Tmp_52 > 0;
    OldIrql := Mem_T.INT4[Tmp_52];
    call {:si_unique_call 96} vslice_dummy_var_19 := sdv_RemoveEntryList(0);
    call {:si_unique_call 97} InitializeListHead(Command);
    call {:si_unique_call 98} sdv_KeReleaseSpinLock(0, OldIrql);
    goto L46;

  L46:
    Status := -1073741670;
    goto L25;

  anon19_Then:
    assume {:partition} Command == 0;
    goto L46;

  anon17_Then:
    assume {:partition} NeedIrp == 0;
    goto L25;

  anon16_Then:
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    havoc Tmp_51;
    assume {:nonnull} DevExt != 0;
    assume DevExt > 0;
    assume {:nonnull} Tmp_51 != 0;
    assume Tmp_51 > 0;
    havoc vslice_dummy_var_11;
    call {:si_unique_call 99} boogieTmp := IoAllocateIrp(vslice_dummy_var_11, 0);
    NeedIrp := 1;
    goto L21;

  anon15_Then:
    assume {:partition} Command == 0;
    goto L14;
}



procedure {:origName "AvcSubunitPackedTypesEqual"} AvcSubunitPackedTypesEqual(actual_SubunitType1: int, actual_SubunitType2: int) returns (Tmp_53: int);
  free ensures Tmp_53 == 1 || Tmp_53 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcSubunitPackedTypesEqual"} AvcSubunitPackedTypesEqual(actual_SubunitType1: int, actual_SubunitType2: int) returns (Tmp_53: int)
{
  var {:scalar} Tmp_54: int;
  var {:scalar} Tmp_55: int;
  var {:scalar} Tmp_57: int;
  var {:scalar} Tmp_58: int;
  var {:scalar} idx: int;
  var {:scalar} Tmp_59: int;
  var {:scalar} Tmp_60: int;
  var {:pointer} SubunitType1: int;
  var {:pointer} SubunitType2: int;

  anon0:
    SubunitType1 := actual_SubunitType1;
    SubunitType2 := actual_SubunitType2;
    idx := 1;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} SubunitType1 == SubunitType2;
    Tmp_53 := 1;
    goto L1;

  L1:
    return;

  anon20_Then:
    assume {:partition} SubunitType1 != SubunitType2;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} SubunitType1 != 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} SubunitType2 != 0;
    assume {:nonnull} SubunitType1 != 0;
    assume SubunitType1 > 0;
    Tmp_59 := BAND(Mem_T.INT4[SubunitType1], BNOT(BOR(BOR(1, 2), 4)));
    assume {:nonnull} SubunitType2 != 0;
    assume SubunitType2 > 0;
    Tmp_57 := BAND(Mem_T.INT4[SubunitType2], BNOT(BOR(BOR(1, 2), 4)));
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} Tmp_59 != Tmp_57;
    Tmp_53 := 0;
    goto L1;

  anon21_Then:
    assume {:partition} Tmp_59 == Tmp_57;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    goto L16;

  L16:
    call {:si_unique_call 100} Tmp_55, Tmp_58, idx := AvcSubunitPackedTypesEqual_loop_L16(Tmp_55, Tmp_58, idx, SubunitType1, SubunitType2);
    goto L16_last;

  L16_last:
    Tmp_55 := idx;
    assume {:nonnull} SubunitType1 != 0;
    assume SubunitType1 > 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} Mem_T.INT4[SubunitType1 + Tmp_55 * 4] == 255;
    Tmp_58 := idx;
    assume {:nonnull} SubunitType2 != 0;
    assume SubunitType2 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} Mem_T.INT4[SubunitType2 + Tmp_58 * 4] != 255;
    Tmp_53 := 0;
    goto L1;

  anon23_Then:
    assume {:partition} Mem_T.INT4[SubunitType2 + Tmp_58 * 4] == 255;
    idx := idx + 1;
    goto anon23_Then_dummy;

  anon23_Then_dummy:
    assume false;
    return;

  anon22_Then:
    assume {:partition} Mem_T.INT4[SubunitType1 + Tmp_55 * 4] != 255;
    Tmp_60 := idx;
    Tmp_54 := idx;
    assume {:nonnull} SubunitType1 != 0;
    assume SubunitType1 > 0;
    assume {:nonnull} SubunitType2 != 0;
    assume SubunitType2 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} Mem_T.INT4[SubunitType1 + Tmp_60 * 4] != Mem_T.INT4[SubunitType2 + Tmp_54 * 4];
    Tmp_53 := 0;
    goto L1;

  anon24_Then:
    assume {:partition} Mem_T.INT4[SubunitType1 + Tmp_60 * 4] == Mem_T.INT4[SubunitType2 + Tmp_54 * 4];
    goto L15;

  L15:
    Tmp_53 := 1;
    goto L1;

  anon19_Then:
    goto L15;

  anon18_Then:
    assume {:partition} SubunitType2 == 0;
    goto L8;

  L8:
    Tmp_53 := 0;
    goto L1;

  anon17_Then:
    assume {:partition} SubunitType1 == 0;
    goto L8;
}



procedure {:origName "AvcStopAllFCPProcessing"} AvcStopAllFCPProcessing(actual_DevExt_1: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcStopAllFCPProcessing"} AvcStopAllFCPProcessing(actual_DevExt_1: int)
{
  var {:scalar} sdv_28: int;
  var {:pointer} sdv_29: int;
  var {:scalar} sdv_30: int;
  var {:scalar} OldIrql_1: int;
  var {:pointer} sdv_32: int;
  var {:scalar} sdv_33: int;
  var {:pointer} sdv_34: int;
  var {:scalar} sdv_35: int;
  var {:pointer} Tmp_62: int;
  var {:pointer} Command_1: int;
  var {:pointer} CallbackLink: int;
  var {:pointer} sdv_37: int;
  var {:pointer} DevExt_1: int;
  var vslice_dummy_var_20: int;
  var vslice_dummy_var_21: int;
  var vslice_dummy_var_22: int;
  var vslice_dummy_var_12: int;

  anon0:
    call {:si_unique_call 101} vslice_dummy_var_20 := __HAVOC_malloc(4);
    DevExt_1 := actual_DevExt_1;
    call {:si_unique_call 102} Tmp_62 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_62 != 0;
    assume Tmp_62 > 0;
    Mem_T.INT4[Tmp_62] := OldIrql_1;
    call {:si_unique_call 103} sdv_KeAcquireSpinLock(0, Tmp_62);
    assume {:nonnull} Tmp_62 != 0;
    assume Tmp_62 > 0;
    OldIrql_1 := Mem_T.INT4[Tmp_62];
    goto L8;

  L8:
    call {:si_unique_call 104} sdv_28, sdv_30, OldIrql_1, sdv_32, Tmp_62, Command_1, CallbackLink, sdv_37 := AvcStopAllFCPProcessing_loop_L8(sdv_28, sdv_30, OldIrql_1, sdv_32, Tmp_62, Command_1, CallbackLink, sdv_37, DevExt_1);
    goto L8_last;

  L8_last:
    call {:si_unique_call 137} sdv_28 := sdv_IsListEmpty(0);
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} sdv_28 != 0;
    goto L15;

  L15:
    call {:si_unique_call 105} OldIrql_1, sdv_33, sdv_34, Tmp_62, Command_1 := AvcStopAllFCPProcessing_loop_L15(OldIrql_1, sdv_33, sdv_34, Tmp_62, Command_1, DevExt_1);
    goto L15_last;

  L15_last:
    call {:si_unique_call 136} sdv_33 := sdv_IsListEmpty(0);
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} sdv_33 != 0;
    goto L22;

  L22:
    call {:si_unique_call 106} sdv_29, OldIrql_1, sdv_35, Tmp_62, Command_1 := AvcStopAllFCPProcessing_loop_L22(sdv_29, OldIrql_1, sdv_35, Tmp_62, Command_1, DevExt_1);
    goto L22_last;

  L22_last:
    call {:si_unique_call 135} sdv_35 := sdv_IsListEmpty(0);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} sdv_35 != 0;
    assume {:nonnull} DevExt_1 != 0;
    assume DevExt_1 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    call {:si_unique_call 107} vslice_dummy_var_21 := IoCancelIrp(0);
    assume {:nonnull} DevExt_1 != 0;
    assume DevExt_1 > 0;
    goto L30;

  L30:
    assume {:nonnull} DevExt_1 != 0;
    assume DevExt_1 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    call {:si_unique_call 108} vslice_dummy_var_22 := IoCancelIrp(0);
    assume {:nonnull} DevExt_1 != 0;
    assume DevExt_1 > 0;
    goto L35;

  L35:
    call {:si_unique_call 109} sdv_KeReleaseSpinLock(0, OldIrql_1);
    return;

  anon17_Then:
    goto L35;

  anon16_Then:
    goto L30;

  anon15_Then:
    assume {:partition} sdv_35 == 0;
    assume {:nonnull} DevExt_1 != 0;
    assume DevExt_1 > 0;
    call {:si_unique_call 110} sdv_29 := RemoveHeadList(CleanupList__BUS_DEVICE_EXTENSION(DevExt_1));
    Command_1 := sdv_29;
    call {:si_unique_call 111} InitializeListHead(Command_1);
    call {:si_unique_call 112} sdv_KeReleaseSpinLock(0, OldIrql_1);
    call {:si_unique_call 113} AvcPendingIrpCompletion(Command_1);
    call {:si_unique_call 114} AvcFreeCommandContext(Command_1);
    call {:si_unique_call 115} Tmp_62 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_62 != 0;
    assume Tmp_62 > 0;
    Mem_T.INT4[Tmp_62] := OldIrql_1;
    call {:si_unique_call 116} sdv_KeAcquireSpinLock(0, Tmp_62);
    assume {:nonnull} Tmp_62 != 0;
    assume Tmp_62 > 0;
    OldIrql_1 := Mem_T.INT4[Tmp_62];
    goto anon15_Then_dummy;

  anon15_Then_dummy:
    assume false;
    return;

  anon14_Then:
    assume {:partition} sdv_33 == 0;
    assume {:nonnull} DevExt_1 != 0;
    assume DevExt_1 > 0;
    call {:si_unique_call 117} sdv_34 := RemoveHeadList(PendingRequestList__BUS_DEVICE_EXTENSION(DevExt_1));
    Command_1 := sdv_34;
    call {:si_unique_call 118} InitializeListHead(Command_1);
    call {:si_unique_call 119} sdv_KeReleaseSpinLock(0, OldIrql_1);
    assume {:nonnull} Command_1 != 0;
    assume Command_1 > 0;
    call {:si_unique_call 120} AvcPendingIrpCompletion(Command_1);
    call {:si_unique_call 121} AvcFreeCommandContext(Command_1);
    Command_1 := 0;
    call {:si_unique_call 122} Tmp_62 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_62 != 0;
    assume Tmp_62 > 0;
    Mem_T.INT4[Tmp_62] := OldIrql_1;
    call {:si_unique_call 123} sdv_KeAcquireSpinLock(0, Tmp_62);
    assume {:nonnull} Tmp_62 != 0;
    assume Tmp_62 > 0;
    OldIrql_1 := Mem_T.INT4[Tmp_62];
    goto anon14_Then_dummy;

  anon14_Then_dummy:
    assume false;
    return;

  anon13_Then:
    assume {:partition} sdv_28 == 0;
    assume {:nonnull} DevExt_1 != 0;
    assume DevExt_1 > 0;
    call {:si_unique_call 124} sdv_32 := RemoveHeadList(PendingResponseList__BUS_DEVICE_EXTENSION(DevExt_1));
    Command_1 := sdv_32;
    call {:si_unique_call 125} InitializeListHead(Command_1);
    call {:si_unique_call 126} sdv_KeReleaseSpinLock(0, OldIrql_1);
    assume {:nonnull} Command_1 != 0;
    assume Command_1 > 0;
    call {:si_unique_call 127} sdv_30 := sdv_IsListEmpty(0);
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} sdv_30 == 0;
    assume {:nonnull} Command_1 != 0;
    assume Command_1 > 0;
    call {:si_unique_call 128} sdv_37 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(Command_1));
    CallbackLink := sdv_37;
    assume {:IndirectCall} true;
    assume {:nonnull} CallbackLink != 0;
    assume CallbackLink > 0;
    assume {:nonnull} CallbackLink != 0;
    assume CallbackLink > 0;
    havoc vslice_dummy_var_12;
    call {:si_unique_call 129} AvcCommandCallback_sdv_static_function_7(Command_1, vslice_dummy_var_12);
    call {:si_unique_call 130} ExFreeToNPagedLookasideList(AvcCommandLinkPool, CallbackLink);
    goto L97;

  L97:
    call {:si_unique_call 131} Tmp_62 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_62 != 0;
    assume Tmp_62 > 0;
    Mem_T.INT4[Tmp_62] := OldIrql_1;
    call {:si_unique_call 132} sdv_KeAcquireSpinLock(0, Tmp_62);
    assume {:nonnull} Tmp_62 != 0;
    assume Tmp_62 > 0;
    OldIrql_1 := Mem_T.INT4[Tmp_62];
    goto L97_dummy;

  L97_dummy:
    assume false;
    return;

  anon18_Then:
    assume {:partition} sdv_30 != 0;
    call {:si_unique_call 133} AvcPendingIrpCompletion(Command_1);
    call {:si_unique_call 134} AvcFreeCommandContext(Command_1);
    Command_1 := 0;
    goto L97;
}



procedure {:origName "AvcCommandCallback_sdv_static_function_7"} AvcCommandCallback_sdv_static_function_7(actual_CommandContext: int, actual_Event_2: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcCommandCallback_sdv_static_function_7"} AvcCommandCallback_sdv_static_function_7(actual_CommandContext: int, actual_Event_2: int)
{
  var {:pointer} Event_2: int;
  var vslice_dummy_var_23: int;
  var vslice_dummy_var_24: int;

  anon0:
    call {:si_unique_call 138} vslice_dummy_var_23 := __HAVOC_malloc(4);
    Event_2 := actual_Event_2;
    call {:si_unique_call 139} vslice_dummy_var_24 := KeSetEvent(Event_2, 0, 0);
    return;
}



procedure {:origName "AvcLocalResponseCompletion_sdv_static_function_7"} AvcLocalResponseCompletion_sdv_static_function_7(actual_DeviceObject_5: int, actual_Irp_5: int, actual_Context: int) returns (Tmp_65: int);
  modifies alloc;
  free ensures Tmp_65 == -1073741802;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcLocalResponseCompletion_sdv_static_function_7"} AvcLocalResponseCompletion_sdv_static_function_7(actual_DeviceObject_5: int, actual_Irp_5: int, actual_Context: int) returns (Tmp_65: int)
{
  var {:pointer} Response: int;
  var {:pointer} Context: int;

  anon0:
    Context := actual_Context;
    Response := Context;
    call {:si_unique_call 140} ExFreeToNPagedLookasideList(AvcFcpPool, Response);
    call {:si_unique_call 141} IoFreeIrp(0);
    Tmp_65 := -1073741802;
    return;
}



procedure {:origName "AvcProcessSendResponseCR_sdv_static_function_7"} AvcProcessSendResponseCR_sdv_static_function_7(actual_DeviceObject_6: int, actual_Irp_6: int, actual_Context_1: int) returns (Tmp_67: int);
  modifies alloc;
  free ensures Tmp_67 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcProcessSendResponseCR_sdv_static_function_7"} AvcProcessSendResponseCR_sdv_static_function_7(actual_DeviceObject_6: int, actual_Irp_6: int, actual_Context_1: int) returns (Tmp_67: int)
{
  var {:pointer} Response_1: int;
  var {:pointer} Irp_6: int;
  var {:pointer} Context_1: int;

  anon0:
    Irp_6 := actual_Irp_6;
    Context_1 := actual_Context_1;
    Response_1 := Context_1;
    assume {:nonnull} Irp_6 != 0;
    assume Irp_6 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 142} sdv_IoMarkIrpPending(0);
    goto L6;

  L6:
    call {:si_unique_call 143} ExFreeToNPagedLookasideList(AvcFcpPool, Response_1);
    Tmp_67 := 0;
    return;

  anon3_Then:
    goto L6;
}



procedure {:origName "AvcStatus"} AvcStatus(actual_Command_2: int) returns (Tmp_69: int);
  modifies alloc, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcStatus"} AvcStatus(actual_Command_2: int) returns (Tmp_69: int)
{
  var {:scalar} Status_1: int;
  var {:pointer} DevExt_2: int;
  var {:pointer} Command_2: int;

  anon0:
    Command_2 := actual_Command_2;
    assume {:nonnull} Command_2 != 0;
    assume Command_2 > 0;
    havoc DevExt_2;
    assume {:nonnull} Command_2 != 0;
    assume Command_2 > 0;
    assume {:nonnull} Command_2 != 0;
    assume Command_2 > 0;
    call {:si_unique_call 144} Status_1 := AvcCommand_sdv_static_function_7(DevExt_2, Command_2);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} yogi_error != 1;
    Tmp_69 := Status_1;
    goto LM2;

  LM2:
    return;

  anon3_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "_sdv_init7"} _sdv_init7();
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init7"} _sdv_init7()
{
  var vslice_dummy_var_25: int;

  anon0:
    call {:si_unique_call 145} vslice_dummy_var_25 := __HAVOC_malloc(4);
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    return;
}



procedure {:origName "AvcPackSubunitInfo"} AvcPackSubunitInfo(actual_BusExtension: int, actual_Length: int, actual_Buffer: int, actual_BytesUsed: int);
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcPackSubunitInfo"} AvcPackSubunitInfo(actual_BusExtension: int, actual_Length: int, actual_Buffer: int, actual_BytesUsed: int)
{
  var {:pointer} PdoData: int;
  var {:dopa} {:scalar} LocalBytesUsed: int;
  var {:scalar} Offset: int;
  var {:pointer} InnerPdoData: int;
  var {:scalar} Tmp_74: int;
  var {:scalar} Tmp_75: int;
  var {:pointer} Tmp_76: int;
  var {:dopa} {:scalar} SubunitId: int;
  var {:scalar} Tmp_77: int;
  var {:scalar} sdv_41: int;
  var {:scalar} ntStatus_7: int;
  var {:scalar} Tmp_78: int;
  var {:pointer} SubunitType: int;
  var {:scalar} Tmp_80: int;
  var {:scalar} Tmp_81: int;
  var {:pointer} Tmp_82: int;
  var {:pointer} Tmp_83: int;
  var {:pointer} BusExtension: int;
  var {:scalar} Length: int;
  var {:pointer} Buffer: int;
  var {:pointer} BytesUsed: int;
  var vslice_dummy_var_26: int;
  var vslice_dummy_var_13: int;
  var vslice_dummy_var_14: int;
  var vslice_dummy_var_15: int;

  anon0:
    call {:si_unique_call 146} LocalBytesUsed := __HAVOC_malloc(4);
    call {:si_unique_call 147} SubunitId := __HAVOC_malloc(4);
    call {:si_unique_call 148} vslice_dummy_var_26 := __HAVOC_malloc(4);
    BusExtension := actual_BusExtension;
    Length := actual_Length;
    Buffer := actual_Buffer;
    BytesUsed := actual_BytesUsed;
    call {:si_unique_call 149} SubunitType := __HAVOC_malloc(128);
    Offset := 0;
    assume {:nonnull} BusExtension != 0;
    assume BusExtension > 0;
    havoc PdoData;
    goto L7;

  L7:
    call {:si_unique_call 150} PdoData, Offset, InnerPdoData, Tmp_74, Tmp_75, Tmp_76, Tmp_77, sdv_41, ntStatus_7, Tmp_78, Tmp_80, Tmp_81, Tmp_82, Tmp_83 := AvcPackSubunitInfo_loop_L7(PdoData, LocalBytesUsed, Offset, InnerPdoData, Tmp_74, Tmp_75, Tmp_76, SubunitId, Tmp_77, sdv_41, ntStatus_7, Tmp_78, SubunitType, Tmp_80, Tmp_81, Tmp_82, Tmp_83, Length, Buffer);
    goto L7_last;

  L7_last:
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:nonnull} PdoData != 0;
    assume PdoData > 0;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:nonnull} PdoData != 0;
    assume PdoData > 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:nonnull} PdoData != 0;
    assume PdoData > 0;
    havoc vslice_dummy_var_13;
    call {:si_unique_call 151} ntStatus_7 := AvcUnpackSubunitAddress(vslice_dummy_var_13, SubunitType, SubunitId, LocalBytesUsed);
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} ntStatus_7 == 0;
    assume {:nonnull} SubunitId != 0;
    assume SubunitId > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} Mem_T.INT4[SubunitId] == 0;
    assume {:nonnull} PdoData != 0;
    assume PdoData > 0;
    havoc InnerPdoData;
    goto L25;

  L25:
    call {:si_unique_call 152} InnerPdoData, sdv_41 := AvcPackSubunitInfo_loop_L25(PdoData, InnerPdoData, SubunitId, sdv_41);
    goto L25_last;

  L25_last:
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:nonnull} InnerPdoData != 0;
    assume InnerPdoData > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:nonnull} InnerPdoData != 0;
    assume InnerPdoData > 0;
    assume {:nonnull} PdoData != 0;
    assume PdoData > 0;
    havoc vslice_dummy_var_14;
    havoc vslice_dummy_var_15;
    call {:si_unique_call 153} sdv_41 := AvcSubunitPackedTypesEqual(vslice_dummy_var_14, vslice_dummy_var_15);
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} sdv_41 != 0;
    assume {:nonnull} SubunitId != 0;
    assume SubunitId > 0;
    Mem_T.INT4[SubunitId] := Mem_T.INT4[SubunitId] + 1;
    goto L28;

  L28:
    assume {:nonnull} InnerPdoData != 0;
    assume InnerPdoData > 0;
    havoc InnerPdoData;
    goto L28_dummy;

  L28_dummy:
    assume false;
    return;

  anon38_Then:
    assume {:partition} sdv_41 == 0;
    goto L28;

  anon37_Then:
    goto L28;

  anon36_Then:
    Tmp_74 := Offset;
    Tmp_83 := Buffer + Tmp_74 * 4;
    Tmp_80 := Length - Offset;
    assume {:nonnull} SubunitId != 0;
    assume SubunitId > 0;
    call {:si_unique_call 154} ntStatus_7 := AvcPackSubunitAddress(SubunitType, Mem_T.INT4[SubunitId], Tmp_80, Tmp_83, LocalBytesUsed);
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} ntStatus_7 == 0;
    assume {:nonnull} LocalBytesUsed != 0;
    assume LocalBytesUsed > 0;
    Offset := Offset + Mem_T.INT4[LocalBytesUsed];
    goto L10;

  L10:
    assume {:nonnull} PdoData != 0;
    assume PdoData > 0;
    havoc PdoData;
    goto L10_dummy;

  L10_dummy:
    assume false;
    return;

  anon39_Then:
    assume {:partition} ntStatus_7 != 0;
    goto L10;

  anon35_Then:
    assume {:partition} Mem_T.INT4[SubunitId] != 0;
    goto L10;

  anon34_Then:
    assume {:partition} ntStatus_7 != 0;
    goto L10;

  anon32_Then:
    assume {:nonnull} PdoData != 0;
    assume PdoData > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    goto L42;

  L42:
    assume {:nonnull} SubunitType != 0;
    assume SubunitType > 0;
    Mem_T.INT4[SubunitType] := 4;
    Tmp_75 := Offset;
    Tmp_76 := Buffer + Tmp_75 * 4;
    Tmp_77 := Length - Offset;
    call {:si_unique_call 155} ntStatus_7 := AvcPackSubunitAddress(SubunitType, 0, Tmp_77, Tmp_76, LocalBytesUsed);
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} ntStatus_7 != 0;
    goto L51;

  L51:
    assume {:nonnull} SubunitType != 0;
    assume SubunitType > 0;
    Mem_T.INT4[SubunitType] := 7;
    Tmp_78 := Offset;
    Tmp_82 := Buffer + Tmp_78 * 4;
    Tmp_81 := Length - Offset;
    call {:si_unique_call 156} ntStatus_7 := AvcPackSubunitAddress(SubunitType, 0, Tmp_81, Tmp_82, LocalBytesUsed);
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} ntStatus_7 == 0;
    assume {:nonnull} LocalBytesUsed != 0;
    assume LocalBytesUsed > 0;
    Offset := Offset + Mem_T.INT4[LocalBytesUsed];
    goto L10;

  anon42_Then:
    assume {:partition} ntStatus_7 != 0;
    goto L10;

  anon41_Then:
    assume {:partition} ntStatus_7 == 0;
    assume {:nonnull} LocalBytesUsed != 0;
    assume LocalBytesUsed > 0;
    Offset := Offset + Mem_T.INT4[LocalBytesUsed];
    goto L51;

  anon33_Then:
    assume {:nonnull} PdoData != 0;
    assume PdoData > 0;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    goto L42;

  anon40_Then:
    goto L10;

  anon31_Then:
    goto L10;

  anon29_Then:
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} BytesUsed != 0;
    assume {:nonnull} BytesUsed != 0;
    assume BytesUsed > 0;
    Mem_T.INT4[BytesUsed] := Offset;
    goto L1;

  L1:
    return;

  anon30_Then:
    assume {:partition} BytesUsed == 0;
    goto L1;
}



procedure {:origName "AvcUnpackFCPFrame"} AvcUnpackFCPFrame(actual_Command_3: int, actual_Opcode: int, actual_OperandByteCount: int, actual_Operands: int) returns (Tmp_84: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_84 == -1073741811 || Tmp_84 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcUnpackFCPFrame"} AvcUnpackFCPFrame(actual_Command_3: int, actual_Opcode: int, actual_OperandByteCount: int, actual_Operands: int) returns (Tmp_84: int)
{
  var {:pointer} Tmp_85: int;
  var {:scalar} Tmp_86: int;
  var {:scalar} Tmp_88: int;
  var {:pointer} Tmp_90: int;
  var {:pointer} Command_3: int;
  var {:pointer} Opcode: int;
  var {:scalar} OperandByteCount: int;
  var {:pointer} Operands: int;

  anon0:
    Command_3 := actual_Command_3;
    Opcode := actual_Opcode;
    OperandByteCount := actual_OperandByteCount;
    Operands := actual_Operands;
    call {:si_unique_call 157} Tmp_85 := __HAVOC_malloc(2048);
    call {:si_unique_call 158} Tmp_90 := __HAVOC_malloc(2048);
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    goto L8;

  L8:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} Opcode != 0;
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    havoc Tmp_88;
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    havoc Tmp_90;
    assume {:nonnull} Opcode != 0;
    assume Opcode > 0;
    assume {:nonnull} Tmp_90 != 0;
    assume Tmp_90 > 0;
    Mem_T.INT4[Opcode] := Mem_T.INT4[Tmp_90 + Tmp_88 * 4];
    goto L9;

  L9:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} Operands != 0;
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    havoc OperandByteCount;
    goto L13;

  L13:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    havoc Tmp_86;
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    havoc Tmp_85;
    call {:si_unique_call 159} sdv_RtlCopyMemory(0, 0, OperandByteCount);
    goto L11;

  L11:
    Tmp_84 := 0;
    goto L1;

  L1:
    return;

  anon40_Then:
    goto L13;

  anon39_Then:
    assume {:partition} Operands == 0;
    goto L11;

  anon38_Then:
    assume {:partition} Opcode == 0;
    goto L9;

  anon42_Then:
    Tmp_84 := -1073741811;
    goto L1;

  anon43_Then:
    goto L8;

  anon44_Then:
    goto L8;

  anon45_Then:
    goto L8;

  anon37_Then:
    goto L8;

  anon35_Then:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:nonnull} Command_3 != 0;
    assume Command_3 > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    Tmp_84 := -1073741811;
    goto L1;

  anon46_Then:
    goto L8;

  anon47_Then:
    goto L8;

  anon48_Then:
    goto L8;

  anon49_Then:
    goto L8;

  anon50_Then:
    goto L8;

  anon51_Then:
    goto L8;

  anon41_Then:
    goto L8;

  anon36_Then:
    Tmp_84 := -1073741811;
    goto L1;
}



procedure {:origName "AvcStopSelectedFCPProcessing"} AvcStopSelectedFCPProcessing(actual_DevExt_3: int, actual_FileObject: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcStopSelectedFCPProcessing"} AvcStopSelectedFCPProcessing(actual_DevExt_3: int, actual_FileObject: int)
{
  var {:pointer} Irp_7: int;
  var {:scalar} sdv_45: int;
  var {:scalar} OldIrql_2: int;
  var {:pointer} sdv_47: int;
  var {:pointer} IrpEntry: int;
  var {:pointer} Tmp_91: int;
  var {:scalar} PendingIrpList: int;
  var {:pointer} DevExt_3: int;
  var {:pointer} FileObject: int;
  var vslice_dummy_var_27: int;

  anon0:
    call {:si_unique_call 160} PendingIrpList := __HAVOC_malloc(8);
    call {:si_unique_call 161} vslice_dummy_var_27 := __HAVOC_malloc(4);
    DevExt_3 := actual_DevExt_3;
    FileObject := actual_FileObject;
    call {:si_unique_call 162} InitializeListHead(PendingIrpList);
    call {:si_unique_call 163} Tmp_91 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_91 != 0;
    assume Tmp_91 > 0;
    Mem_T.INT4[Tmp_91] := OldIrql_2;
    call {:si_unique_call 164} sdv_KeAcquireSpinLock(0, Tmp_91);
    assume {:nonnull} Tmp_91 != 0;
    assume Tmp_91 > 0;
    OldIrql_2 := Mem_T.INT4[Tmp_91];
    assume {:nonnull} DevExt_3 != 0;
    assume DevExt_3 > 0;
    call {:si_unique_call 165} AvcExtractMatchingIrps_sdv_static_function_7(FileObject, PendingResponseList__BUS_DEVICE_EXTENSION(DevExt_3), PendingIrpList);
    assume {:nonnull} DevExt_3 != 0;
    assume DevExt_3 > 0;
    call {:si_unique_call 166} AvcExtractMatchingIrps_sdv_static_function_7(FileObject, PendingRequestList__BUS_DEVICE_EXTENSION(DevExt_3), PendingIrpList);
    assume {:nonnull} DevExt_3 != 0;
    assume DevExt_3 > 0;
    call {:si_unique_call 167} AvcExtractMatchingIrps_sdv_static_function_7(FileObject, CleanupList__BUS_DEVICE_EXTENSION(DevExt_3), PendingIrpList);
    call {:si_unique_call 168} sdv_KeReleaseSpinLock(0, OldIrql_2);
    goto L23;

  L23:
    call {:si_unique_call 169} Irp_7, sdv_45, sdv_47, IrpEntry := AvcStopSelectedFCPProcessing_loop_L23(Irp_7, sdv_45, sdv_47, IrpEntry, PendingIrpList);
    goto L23_last;

  L23_last:
    call {:si_unique_call 173} sdv_45 := sdv_IsListEmpty(0);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} sdv_45 == 0;
    call {:si_unique_call 170} IrpEntry := RemoveHeadList(PendingIrpList);
    call {:si_unique_call 171} sdv_47 := sdv_containing_record(IrpEntry, 88);
    Irp_7 := sdv_47;
    assume {:nonnull} Irp_7 != 0;
    assume Irp_7 > 0;
    assume {:nonnull} Irp_7 != 0;
    assume Irp_7 > 0;
    call {:si_unique_call 172} sdv_IoCompleteRequest(0, 0);
    goto anon3_Else_dummy;

  anon3_Else_dummy:
    assume false;
    return;

  anon3_Then:
    assume {:partition} sdv_45 != 0;
    return;
}



procedure {:origName "AvcSubunitAddrsEqual"} AvcSubunitAddrsEqual(actual_SubunitAddr1: int, actual_SubunitAddr2: int) returns (Tmp_93: int);
  free ensures Tmp_93 == 1 || Tmp_93 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcSubunitAddrsEqual"} AvcSubunitAddrsEqual(actual_SubunitAddr1: int, actual_SubunitAddr2: int) returns (Tmp_93: int)
{
  var {:scalar} Tmp_94: int;
  var {:scalar} Tmp_95: int;
  var {:scalar} Tmp_96: int;
  var {:scalar} Tmp_97: int;
  var {:scalar} Tmp_98: int;
  var {:scalar} Tmp_99: int;
  var {:scalar} Tmp_100: int;
  var {:scalar} Tmp_101: int;
  var {:scalar} Tmp_102: int;
  var {:scalar} idx_1: int;
  var {:pointer} SubunitAddr1: int;
  var {:pointer} SubunitAddr2: int;

  anon0:
    SubunitAddr1 := actual_SubunitAddr1;
    SubunitAddr2 := actual_SubunitAddr2;
    idx_1 := 1;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} SubunitAddr1 == SubunitAddr2;
    Tmp_93 := 1;
    goto L1;

  L1:
    return;

  anon29_Then:
    assume {:partition} SubunitAddr1 != SubunitAddr2;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} SubunitAddr1 != 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} SubunitAddr2 != 0;
    assume {:nonnull} SubunitAddr1 != 0;
    assume SubunitAddr1 > 0;
    assume {:nonnull} SubunitAddr2 != 0;
    assume SubunitAddr2 > 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} Mem_T.INT4[SubunitAddr1] != Mem_T.INT4[SubunitAddr2];
    Tmp_93 := 0;
    goto L1;

  anon27_Then:
    assume {:partition} Mem_T.INT4[SubunitAddr1] == Mem_T.INT4[SubunitAddr2];
    goto anon28_Then, anon28_Else;

  anon28_Else:
    goto L14;

  L14:
    call {:si_unique_call 174} Tmp_101, Tmp_102, idx_1 := AvcSubunitAddrsEqual_loop_L14(Tmp_101, Tmp_102, idx_1, SubunitAddr1, SubunitAddr2);
    goto L14_last;

  L14_last:
    Tmp_102 := idx_1;
    assume {:nonnull} SubunitAddr1 != 0;
    assume SubunitAddr1 > 0;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} Mem_T.INT4[SubunitAddr1 + Tmp_102 * 4] == 255;
    Tmp_101 := idx_1;
    assume {:nonnull} SubunitAddr2 != 0;
    assume SubunitAddr2 > 0;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} Mem_T.INT4[SubunitAddr2 + Tmp_101 * 4] != 255;
    Tmp_93 := 0;
    goto L1;

  anon31_Then:
    assume {:partition} Mem_T.INT4[SubunitAddr2 + Tmp_101 * 4] == 255;
    idx_1 := idx_1 + 1;
    goto anon31_Then_dummy;

  anon31_Then_dummy:
    assume false;
    return;

  anon30_Then:
    assume {:partition} Mem_T.INT4[SubunitAddr1 + Tmp_102 * 4] != 255;
    Tmp_94 := idx_1;
    Tmp_100 := idx_1;
    assume {:nonnull} SubunitAddr1 != 0;
    assume SubunitAddr1 > 0;
    assume {:nonnull} SubunitAddr2 != 0;
    assume SubunitAddr2 > 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} Mem_T.INT4[SubunitAddr1 + Tmp_94 * 4] != Mem_T.INT4[SubunitAddr2 + Tmp_100 * 4];
    Tmp_93 := 0;
    goto L1;

  anon32_Then:
    assume {:partition} Mem_T.INT4[SubunitAddr1 + Tmp_94 * 4] == Mem_T.INT4[SubunitAddr2 + Tmp_100 * 4];
    idx_1 := idx_1 + 1;
    goto L13;

  L13:
    assume {:nonnull} SubunitAddr1 != 0;
    assume SubunitAddr1 > 0;
    Tmp_96 := BAND(Mem_T.INT4[SubunitAddr1], BOR(BOR(1, 2), 4));
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} Tmp_96 == 5;
    goto L23;

  L23:
    call {:si_unique_call 175} Tmp_95, Tmp_97, idx_1 := AvcSubunitAddrsEqual_loop_L23(Tmp_95, Tmp_97, idx_1, SubunitAddr1, SubunitAddr2);
    goto L23_last;

  L23_last:
    Tmp_97 := idx_1;
    assume {:nonnull} SubunitAddr1 != 0;
    assume SubunitAddr1 > 0;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} Mem_T.INT4[SubunitAddr1 + Tmp_97 * 4] == 255;
    Tmp_95 := idx_1;
    assume {:nonnull} SubunitAddr2 != 0;
    assume SubunitAddr2 > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} Mem_T.INT4[SubunitAddr2 + Tmp_95 * 4] != 255;
    Tmp_93 := 0;
    goto L1;

  anon35_Then:
    assume {:partition} Mem_T.INT4[SubunitAddr2 + Tmp_95 * 4] == 255;
    idx_1 := idx_1 + 1;
    goto anon35_Then_dummy;

  anon35_Then_dummy:
    assume false;
    return;

  anon34_Then:
    assume {:partition} Mem_T.INT4[SubunitAddr1 + Tmp_97 * 4] != 255;
    Tmp_99 := idx_1;
    Tmp_98 := idx_1;
    assume {:nonnull} SubunitAddr1 != 0;
    assume SubunitAddr1 > 0;
    assume {:nonnull} SubunitAddr2 != 0;
    assume SubunitAddr2 > 0;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} Mem_T.INT4[SubunitAddr1 + Tmp_99 * 4] != Mem_T.INT4[SubunitAddr2 + Tmp_98 * 4];
    Tmp_93 := 0;
    goto L1;

  anon36_Then:
    assume {:partition} Mem_T.INT4[SubunitAddr1 + Tmp_99 * 4] == Mem_T.INT4[SubunitAddr2 + Tmp_98 * 4];
    goto L22;

  L22:
    Tmp_93 := 1;
    goto L1;

  anon33_Then:
    assume {:partition} Tmp_96 != 5;
    goto L22;

  anon28_Then:
    goto L13;

  anon26_Then:
    assume {:partition} SubunitAddr2 == 0;
    goto L8;

  L8:
    Tmp_93 := 0;
    goto L1;

  anon25_Then:
    assume {:partition} SubunitAddr1 == 0;
    goto L8;
}



procedure {:origName "AvcPrepareForRequestCallback"} AvcPrepareForRequestCallback(actual_DevExt_4: int, actual_Command_4: int) returns (Tmp_104: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcPrepareForRequestCallback"} AvcPrepareForRequestCallback(actual_DevExt_4: int, actual_Command_4: int) returns (Tmp_104: int)
{
  var {:pointer} Tmp_105: int;
  var {:pointer} Tmp_106: int;
  var {:scalar} Status_2: int;
  var {:scalar} OldIrql_3: int;
  var {:pointer} NextIrpStack_1: int;
  var {:scalar} NeedIrp_1: int;
  var {:pointer} Tmp_107: int;
  var {:pointer} DevExt_4: int;
  var {:pointer} Command_4: int;
  var boogieTmp: int;
  var vslice_dummy_var_28: int;
  var vslice_dummy_var_29: int;
  var vslice_dummy_var_30: int;
  var vslice_dummy_var_16: int;
  var vslice_dummy_var_17: int;
  var vslice_dummy_var_18: int;
  var vslice_dummy_var_19: int;
  var vslice_dummy_var_20: int;

  anon0:
    DevExt_4 := actual_DevExt_4;
    Command_4 := actual_Command_4;
    Status_2 := 0;
    NeedIrp_1 := 0;
    call {:si_unique_call 176} Tmp_105 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_105 != 0;
    assume Tmp_105 > 0;
    Mem_T.INT4[Tmp_105] := OldIrql_3;
    call {:si_unique_call 177} sdv_KeAcquireSpinLock(0, Tmp_105);
    assume {:nonnull} Tmp_105 != 0;
    assume Tmp_105 > 0;
    OldIrql_3 := Mem_T.INT4[Tmp_105];
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} Command_4 != 0;
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    call {:si_unique_call 178} vslice_dummy_var_28 := sdv_InsertTailList(PendingRequestList__BUS_DEVICE_EXTENSION(DevExt_4), Command_4);
    goto L12;

  L12:
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    goto L19;

  L19:
    call {:si_unique_call 179} sdv_KeReleaseSpinLock(0, OldIrql_3);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} NeedIrp_1 != 0;
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    havoc vslice_dummy_var_16;
    call {:si_unique_call 180} NextIrpStack_1 := sdv_IoGetNextIrpStackLocation(vslice_dummy_var_16);
    assume {:nonnull} NextIrpStack_1 != 0;
    assume NextIrpStack_1 > 0;
    assume {:nonnull} NextIrpStack_1 != 0;
    assume NextIrpStack_1 > 0;
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    assume {:nonnull} NextIrpStack_1 != 0;
    assume NextIrpStack_1 > 0;
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    havoc Tmp_106;
    assume {:nonnull} Tmp_106 != 0;
    assume Tmp_106 > 0;
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    havoc vslice_dummy_var_17;
    call {:si_unique_call 181} sdv_IoSetCompletionRoutine(vslice_dummy_var_17, li2bplFunctionConstant847, DevExt_4, 1, 1, 1);
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    havoc vslice_dummy_var_18;
    havoc vslice_dummy_var_19;
    call {:si_unique_call 182} vslice_dummy_var_29 := sdv_IoCallDriver#1(vslice_dummy_var_18, vslice_dummy_var_19);
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} yogi_error != 1;
    goto L23;

  L23:
    Tmp_104 := Status_2;
    goto LM2;

  LM2:
    return;

  anon18_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon16_Then:
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} Command_4 != 0;
    call {:si_unique_call 183} Tmp_105 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_105 != 0;
    assume Tmp_105 > 0;
    Mem_T.INT4[Tmp_105] := OldIrql_3;
    call {:si_unique_call 184} sdv_KeAcquireSpinLock(0, Tmp_105);
    assume {:nonnull} Tmp_105 != 0;
    assume Tmp_105 > 0;
    OldIrql_3 := Mem_T.INT4[Tmp_105];
    call {:si_unique_call 185} vslice_dummy_var_30 := sdv_RemoveEntryList(0);
    call {:si_unique_call 186} InitializeListHead(Command_4);
    call {:si_unique_call 187} sdv_KeReleaseSpinLock(0, OldIrql_3);
    goto L44;

  L44:
    Status_2 := -1073741670;
    goto L23;

  anon17_Then:
    assume {:partition} Command_4 == 0;
    goto L44;

  anon15_Then:
    assume {:partition} NeedIrp_1 == 0;
    goto L23;

  anon14_Then:
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    havoc Tmp_107;
    assume {:nonnull} DevExt_4 != 0;
    assume DevExt_4 > 0;
    assume {:nonnull} Tmp_107 != 0;
    assume Tmp_107 > 0;
    havoc vslice_dummy_var_20;
    call {:si_unique_call 188} boogieTmp := IoAllocateIrp(vslice_dummy_var_20, 0);
    NeedIrp_1 := 1;
    goto L19;

  anon13_Then:
    assume {:partition} Command_4 == 0;
    goto L12;
}



procedure {:origName "AvcPendingIrpCompletion"} AvcPendingIrpCompletion(actual_Command_5: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcPendingIrpCompletion"} AvcPendingIrpCompletion(actual_Command_5: int)
{
  var {:pointer} Irp_8: int;
  var {:scalar} Status_3: int;
  var {:pointer} IrpStack_3: int;
  var {:pointer} CmdIrb: int;
  var {:pointer} Command_5: int;
  var vslice_dummy_var_31: int;
  var vslice_dummy_var_21: int;

  anon0:
    call {:si_unique_call 189} vslice_dummy_var_31 := __HAVOC_malloc(4);
    Command_5 := actual_Command_5;
    call {:si_unique_call 190} Irp_8 := AvcDequeueFCPIrp(Command_5);
    goto L8;

  L8:
    call {:si_unique_call 191} Irp_8, Status_3, IrpStack_3, CmdIrb := AvcPendingIrpCompletion_loop_L8(Irp_8, Status_3, IrpStack_3, CmdIrb, Command_5);
    goto L8_last;

  L8_last:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} Irp_8 != 0;
    call {:si_unique_call 192} IrpStack_3 := sdv_IoGetCurrentIrpStackLocation(Irp_8);
    assume {:nonnull} IrpStack_3 != 0;
    assume IrpStack_3 > 0;
    havoc CmdIrb;
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    havoc Status_3;
    goto L23;

  L23:
    assume {:nonnull} Irp_8 != 0;
    assume Irp_8 > 0;
    assume {:nonnull} Irp_8 != 0;
    assume Irp_8 > 0;
    call {:si_unique_call 193} sdv_IoCompleteRequest(0, 0);
    call {:si_unique_call 194} Irp_8 := AvcDequeueFCPIrp(Command_5);
    goto L23_dummy;

  L23_dummy:
    assume false;
    return;

  anon15_Then:
    assume {:nonnull} CmdIrb != 0;
    assume CmdIrb > 0;
    havoc vslice_dummy_var_21;
    call {:si_unique_call 195} Status_3 := AvcUnpackFCPFrame(Command_5, Opcode__AVC_COMMAND_IRB(CmdIrb), 509, vslice_dummy_var_21);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} Status_3 == 0;
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} CmdIrb != 0;
    assume CmdIrb > 0;
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    goto L35;

  L35:
    assume {:nonnull} CmdIrb != 0;
    assume CmdIrb > 0;
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    assume {:nonnull} CmdIrb != 0;
    assume CmdIrb > 0;
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    assume {:nonnull} CmdIrb != 0;
    assume CmdIrb > 0;
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    assume {:nonnull} CmdIrb != 0;
    assume CmdIrb > 0;
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    goto L23;

  anon14_Then:
    goto L35;

  anon13_Then:
    assume {:nonnull} CmdIrb != 0;
    assume CmdIrb > 0;
    assume {:nonnull} Command_5 != 0;
    assume Command_5 > 0;
    goto L35;

  anon12_Then:
    assume {:partition} Status_3 != 0;
    goto L23;

  anon11_Then:
    assume {:partition} Irp_8 == 0;
    return;
}



procedure {:origName "AvcFreeCommandContext"} AvcFreeCommandContext(actual_Command_6: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcFreeCommandContext"} AvcFreeCommandContext(actual_Command_6: int)
{
  var {:scalar} sdv_56: int;
  var {:pointer} sdv_57: int;
  var {:pointer} CallbackLink_1: int;
  var {:pointer} Command_6: int;
  var vslice_dummy_var_32: int;
  var vslice_dummy_var_22: int;

  anon0:
    call {:si_unique_call 196} vslice_dummy_var_32 := __HAVOC_malloc(4);
    Command_6 := actual_Command_6;
    goto L3;

  L3:
    call {:si_unique_call 197} sdv_56, sdv_57, CallbackLink_1 := AvcFreeCommandContext_loop_L3(sdv_56, sdv_57, CallbackLink_1, Command_6);
    goto L3_last;

  L3_last:
    call {:si_unique_call 202} sdv_56 := sdv_IsListEmpty(0);
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} sdv_56 == 0;
    assume {:nonnull} Command_6 != 0;
    assume Command_6 > 0;
    call {:si_unique_call 198} sdv_57 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(Command_6));
    CallbackLink_1 := sdv_57;
    call {:si_unique_call 199} ExFreeToNPagedLookasideList(AvcCommandLinkPool, CallbackLink_1);
    goto anon5_Else_dummy;

  anon5_Else_dummy:
    assume false;
    return;

  anon5_Then:
    assume {:partition} sdv_56 != 0;
    assume {:nonnull} Command_6 != 0;
    assume Command_6 > 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:nonnull} Command_6 != 0;
    assume Command_6 > 0;
    havoc vslice_dummy_var_22;
    call {:si_unique_call 200} ExFreeToNPagedLookasideList(AvcAlternateOpcodePool, vslice_dummy_var_22);
    goto L9;

  L9:
    call {:si_unique_call 201} ExFreeToNPagedLookasideList(AvcCommandContextPool, Command_6);
    return;

  anon6_Then:
    goto L9;
}



procedure {:origName "AvcPackSubunitAddress"} AvcPackSubunitAddress(actual_SubunitType_1: int, actual_SubunitID: int, actual_Length_1: int, actual_Buffer_1: int, actual_BytesUsed_1: int) returns (Tmp_112: int);
  modifies Mem_T.INT4;
  free ensures Tmp_112 == 0 || Tmp_112 == -1073741811;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcPackSubunitAddress"} AvcPackSubunitAddress(actual_SubunitType_1: int, actual_SubunitID: int, actual_Length_1: int, actual_Buffer_1: int, actual_BytesUsed_1: int) returns (Tmp_112: int)
{
  var {:scalar} Tmp_114: int;
  var {:scalar} Tmp_115: int;
  var {:scalar} Tmp_116: int;
  var {:scalar} Status_4: int;
  var {:scalar} Tmp_117: int;
  var {:scalar} Tmp_118: int;
  var {:scalar} Tmp_119: int;
  var {:scalar} idx_2: int;
  var {:scalar} Tmp_120: int;
  var {:pointer} SubunitType_1: int;
  var {:scalar} SubunitID: int;
  var {:scalar} Length_1: int;
  var {:pointer} Buffer_1: int;
  var {:pointer} BytesUsed_1: int;
  var boogieTmp: int;

  anon0:
    SubunitType_1 := actual_SubunitType_1;
    SubunitID := actual_SubunitID;
    Length_1 := actual_Length_1;
    Buffer_1 := actual_Buffer_1;
    BytesUsed_1 := actual_BytesUsed_1;
    Status_4 := 0;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} SubunitType_1 != 0;
    assume {:nonnull} SubunitType_1 != 0;
    assume SubunitType_1 > 0;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} BAND(Mem_T.INT4[SubunitType_1], 224) == 0;
    assume {:nonnull} SubunitType_1 != 0;
    assume SubunitType_1 > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} 31 == Mem_T.INT4[SubunitType_1];
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} Length_1 >= 1;
    assume {:nonnull} Buffer_1 != 0;
    assume Buffer_1 > 0;
    Mem_T.INT4[Buffer_1] := 255;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} BytesUsed_1 != 0;
    assume {:nonnull} BytesUsed_1 != 0;
    assume BytesUsed_1 > 0;
    Mem_T.INT4[BytesUsed_1] := 1;
    goto L15;

  L15:
    Tmp_112 := 0;
    goto L1;

  L1:
    return;

  anon59_Then:
    assume {:partition} BytesUsed_1 == 0;
    goto L15;

  anon44_Then:
    assume {:partition} 1 > Length_1;
    Tmp_112 := -1073741811;
    goto L1;

  anon42_Then:
    assume {:partition} 31 != Mem_T.INT4[SubunitType_1];
    assume {:nonnull} SubunitType_1 != 0;
    assume SubunitType_1 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} 29 == Mem_T.INT4[SubunitType_1];
    Tmp_112 := -1073741811;
    goto L1;

  anon43_Then:
    assume {:partition} 29 != Mem_T.INT4[SubunitType_1];
    idx_2 := 0;
    goto L19;

  L19:
    call {:si_unique_call 203} Tmp_114, Tmp_117, Tmp_118, idx_2, boogieTmp := AvcPackSubunitAddress_loop_L19(Tmp_114, Tmp_117, Tmp_118, idx_2, SubunitType_1, Length_1, Buffer_1, boogieTmp);
    goto L19_last;

  L19_last:
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} Length_1 > idx_2;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} idx_2 != 0;
    Tmp_114 := idx_2;
    Tmp_117 := idx_2;
    assume {:nonnull} Buffer_1 != 0;
    assume Buffer_1 > 0;
    assume {:nonnull} SubunitType_1 != 0;
    assume SubunitType_1 > 0;
    Mem_T.INT4[Buffer_1 + Tmp_114 * 4] := Mem_T.INT4[SubunitType_1 + Tmp_117 * 4];
    goto L24;

  L24:
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} idx_2 != 0;
    goto L26;

  L26:
    Tmp_118 := idx_2;
    assume {:nonnull} SubunitType_1 != 0;
    assume SubunitType_1 > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} Mem_T.INT4[SubunitType_1 + Tmp_118 * 4] == 255;
    goto L27;

  L27:
    idx_2 := idx_2 + 1;
    goto L27_dummy;

  L27_dummy:
    assume false;
    return;

  anon60_Then:
    assume {:partition} Mem_T.INT4[SubunitType_1 + Tmp_118 * 4] != 255;
    goto L20;

  L20:
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} Length_1 > idx_2;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} 5 > SubunitID;
    assume {:nonnull} Buffer_1 != 0;
    assume Buffer_1 > 0;
    Mem_T.INT4[Buffer_1] := BOR(Mem_T.INT4[Buffer_1], SubunitID);
    goto L33;

  L33:
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} SubunitID > 4;
    Tmp_119 := SubunitID - 4;
    goto L36;

  L36:
    SubunitID := Tmp_119;
    idx_2 := idx_2 + 1;
    goto L38;

  L38:
    call {:si_unique_call 204} Tmp_115, Tmp_116, idx_2, Tmp_120, SubunitID := AvcPackSubunitAddress_loop_L38(Tmp_115, Tmp_116, idx_2, Tmp_120, SubunitID, Length_1, Buffer_1);
    goto L38_last;

  L38_last:
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} Length_1 > idx_2;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} SubunitID != 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} 255 > SubunitID;
    Tmp_115 := idx_2;
    assume {:nonnull} Buffer_1 != 0;
    assume Buffer_1 > 0;
    Mem_T.INT4[Buffer_1 + Tmp_115 * 4] := SubunitID;
    goto L44;

  L44:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} SubunitID > 254;
    Tmp_116 := SubunitID - 254;
    goto L47;

  L47:
    SubunitID := Tmp_116;
    idx_2 := idx_2 + 1;
    goto L47_dummy;

  L47_dummy:
    assume false;
    return;

  anon56_Then:
    assume {:partition} 254 >= SubunitID;
    Tmp_116 := 0;
    goto L47;

  anon55_Then:
    assume {:partition} SubunitID >= 255;
    Tmp_120 := idx_2;
    assume {:nonnull} Buffer_1 != 0;
    assume Buffer_1 > 0;
    Mem_T.INT4[Buffer_1 + Tmp_120 * 4] := 255;
    goto L44;

  anon54_Then:
    assume {:partition} SubunitID == 0;
    goto L39;

  L39:
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} SubunitID != 0;
    Status_4 := -1073741811;
    goto L51;

  L51:
    Tmp_112 := Status_4;
    goto L1;

  anon53_Then:
    assume {:partition} SubunitID == 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} BytesUsed_1 != 0;
    assume {:nonnull} BytesUsed_1 != 0;
    assume BytesUsed_1 > 0;
    Mem_T.INT4[BytesUsed_1] := idx_2;
    goto L51;

  anon57_Then:
    assume {:partition} BytesUsed_1 == 0;
    goto L51;

  anon52_Then:
    assume {:partition} idx_2 >= Length_1;
    goto L39;

  anon51_Then:
    assume {:partition} 4 >= SubunitID;
    Tmp_119 := 0;
    goto L36;

  anon50_Then:
    assume {:partition} SubunitID >= 5;
    assume {:nonnull} Buffer_1 != 0;
    assume Buffer_1 > 0;
    Mem_T.INT4[Buffer_1] := BOR(Mem_T.INT4[Buffer_1], BOR(1, 4));
    goto L33;

  anon46_Then:
    assume {:partition} idx_2 >= Length_1;
    Status_4 := -1073741811;
    goto L51;

  anon48_Then:
    assume {:partition} idx_2 == 0;
    assume {:nonnull} SubunitType_1 != 0;
    assume SubunitType_1 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} Mem_T.INT4[SubunitType_1] == 30;
    goto L27;

  anon49_Then:
    assume {:partition} Mem_T.INT4[SubunitType_1] != 30;
    goto L26;

  anon47_Then:
    assume {:partition} idx_2 == 0;
    assume {:nonnull} Buffer_1 != 0;
    assume Buffer_1 > 0;
    call {:si_unique_call 205} boogieTmp := corral_nondet();
    Mem_T.INT4[Buffer_1] := boogieTmp;
    goto L24;

  anon45_Then:
    assume {:partition} idx_2 >= Length_1;
    goto L20;

  anon41_Then:
    assume {:partition} BAND(Mem_T.INT4[SubunitType_1], 224) != 0;
    goto L7;

  L7:
    Tmp_112 := -1073741811;
    goto L1;

  anon58_Then:
    assume {:partition} SubunitType_1 == 0;
    goto L7;
}



procedure {:origName "AvcAllocateSubunitCommandContext"} AvcAllocateSubunitCommandContext(actual_DevExt_5: int, actual_SubunitAddr_1: int, actual_CommandRetval: int) returns (Tmp_121: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_121 == -1073741811 || Tmp_121 == 0 || Tmp_121 == -1073741670;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcAllocateSubunitCommandContext"} AvcAllocateSubunitCommandContext(actual_DevExt_5: int, actual_SubunitAddr_1: int, actual_CommandRetval: int) returns (Tmp_121: int)
{
  var {:dopa} {:scalar} SubunitAddrLen: int;
  var {:pointer} Tmp_123: int;
  var {:scalar} Status_5: int;
  var {:pointer} Tmp_124: int;
  var {:pointer} sdv_59: int;
  var {:pointer} Command_7: int;
  var {:pointer} DevExt_5: int;
  var {:pointer} SubunitAddr_1: int;
  var {:pointer} CommandRetval: int;

  anon0:
    call {:si_unique_call 206} SubunitAddrLen := __HAVOC_malloc(4);
    DevExt_5 := actual_DevExt_5;
    SubunitAddr_1 := actual_SubunitAddr_1;
    CommandRetval := actual_CommandRetval;
    call {:si_unique_call 207} Tmp_123 := __HAVOC_malloc(2048);
    call {:si_unique_call 208} Tmp_124 := __HAVOC_malloc(2048);
    assume {:nonnull} SubunitAddrLen != 0;
    assume SubunitAddrLen > 0;
    Mem_T.INT4[SubunitAddrLen] := 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} DevExt_5 != 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} SubunitAddr_1 != 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} CommandRetval != 0;
    call {:si_unique_call 209} Status_5 := AvcValidateSubunitAddress(SubunitAddr_1, 32, SubunitAddrLen);
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} Status_5 != 0;
    Tmp_121 := -1073741811;
    goto L1;

  L1:
    return;

  anon14_Then:
    assume {:partition} Status_5 == 0;
    call {:si_unique_call 210} sdv_59 := sdv_ExAllocateFromNPagedLookasideList(0);
    Command_7 := sdv_59;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} Command_7 != 0;
    call {:si_unique_call 211} sdv_RtlZeroMemory(0, 672);
    call {:si_unique_call 212} InitializeListHead(Command_7);
    assume {:nonnull} Command_7 != 0;
    assume Command_7 > 0;
    call {:si_unique_call 213} InitializeListHead(PendingIrpList__AVC_COMMAND_CONTEXT(Command_7));
    assume {:nonnull} Command_7 != 0;
    assume Command_7 > 0;
    call {:si_unique_call 214} InitializeListHead(CallbackChain__AVC_COMMAND_CONTEXT(Command_7));
    assume {:nonnull} Command_7 != 0;
    assume Command_7 > 0;
    assume {:nonnull} Command_7 != 0;
    assume Command_7 > 0;
    assume {:nonnull} SubunitAddrLen != 0;
    assume SubunitAddrLen > 0;
    call {:si_unique_call 215} sdv_RtlCopyMemory(0, 0, Mem_T.INT4[SubunitAddrLen]);
    assume {:nonnull} Command_7 != 0;
    assume Command_7 > 0;
    havoc Tmp_123;
    assume {:nonnull} SubunitAddrLen != 0;
    assume SubunitAddrLen > 0;
    call {:si_unique_call 216} sdv_RtlCopyMemory(0, 0, Mem_T.INT4[SubunitAddrLen]);
    assume {:nonnull} Command_7 != 0;
    assume Command_7 > 0;
    assume {:nonnull} SubunitAddrLen != 0;
    assume SubunitAddrLen > 0;
    assume {:nonnull} Command_7 != 0;
    assume Command_7 > 0;
    assume {:nonnull} Command_7 != 0;
    assume Command_7 > 0;
    havoc Tmp_124;
    assume {:nonnull} Tmp_124 != 0;
    assume Tmp_124 > 0;
    Mem_T.INT4[Tmp_124] := 0;
    assume {:nonnull} Command_7 != 0;
    assume Command_7 > 0;
    assume {:nonnull} CommandRetval != 0;
    assume CommandRetval > 0;
    Tmp_121 := 0;
    goto L1;

  anon15_Then:
    assume {:partition} Command_7 == 0;
    Tmp_121 := -1073741670;
    goto L1;

  anon13_Then:
    assume {:partition} CommandRetval == 0;
    goto L11;

  L11:
    Tmp_121 := -1073741811;
    goto L1;

  anon12_Then:
    assume {:partition} SubunitAddr_1 == 0;
    goto L11;

  anon11_Then:
    assume {:partition} DevExt_5 == 0;
    goto L11;
}



procedure {:origName "AvcValidateSubunitAddress"} AvcValidateSubunitAddress(actual_Buffer_2: int, actual_cbIn: int, actual_BytesUsed_2: int) returns (Tmp_126: int);
  modifies Mem_T.INT4;
  free ensures Tmp_126 == 0 || Tmp_126 == -1073741811;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcValidateSubunitAddress"} AvcValidateSubunitAddress(actual_Buffer_2: int, actual_cbIn: int, actual_BytesUsed_2: int) returns (Tmp_126: int)
{
  var {:scalar} Tmp_127: int;
  var {:scalar} ntStatus_8: int;
  var {:scalar} Tmp_129: int;
  var {:scalar} Tmp_130: int;
  var {:scalar} idx_3: int;
  var {:scalar} Tmp_131: int;
  var {:scalar} Tmp_132: int;
  var {:pointer} Buffer_2: int;
  var {:scalar} cbIn: int;
  var {:pointer} BytesUsed_2: int;

  anon0:
    Buffer_2 := actual_Buffer_2;
    cbIn := actual_cbIn;
    BytesUsed_2 := actual_BytesUsed_2;
    idx_3 := 1;
    ntStatus_8 := 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} BytesUsed_2 != 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} cbIn != 0;
    goto anon38_Then, anon38_Else;

  anon38_Else:
    goto anon46_Then, anon46_Else;

  anon46_Else:
    goto anon45_Then, anon45_Else;

  anon45_Else:
    goto L19;

  L19:
    assume {:nonnull} Buffer_2 != 0;
    assume Buffer_2 > 0;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} BAND(Mem_T.INT4[Buffer_2], 7) != 5;
    assume {:nonnull} Buffer_2 != 0;
    assume Buffer_2 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} BAND(Mem_T.INT4[Buffer_2], 7) != 6;
    assume {:nonnull} Buffer_2 != 0;
    assume Buffer_2 > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} BAND(Mem_T.INT4[Buffer_2], 7) != 7;
    goto L26;

  L26:
    assume {:nonnull} BytesUsed_2 != 0;
    assume BytesUsed_2 > 0;
    Mem_T.INT4[BytesUsed_2] := idx_3;
    Tmp_126 := ntStatus_8;
    goto L1;

  L1:
    return;

  anon47_Then:
    assume {:partition} BAND(Mem_T.INT4[Buffer_2], 7) == 7;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    goto L26;

  anon42_Then:
    ntStatus_8 := -1073741811;
    goto L26;

  anon48_Then:
    assume {:partition} BAND(Mem_T.INT4[Buffer_2], 7) == 6;
    ntStatus_8 := -1073741811;
    goto L26;

  anon40_Then:
    assume {:partition} BAND(Mem_T.INT4[Buffer_2], 7) == 5;
    goto L21;

  L21:
    call {:si_unique_call 217} idx_3, Tmp_132 := AvcValidateSubunitAddress_loop_L21(idx_3, Tmp_132, Buffer_2, cbIn);
    goto L21_last;

  L21_last:
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} cbIn > idx_3;
    Tmp_132 := idx_3;
    assume {:nonnull} Buffer_2 != 0;
    assume Buffer_2 > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} Mem_T.INT4[Buffer_2 + Tmp_132 * 4] == 255;
    idx_3 := idx_3 + 1;
    goto anon50_Else_dummy;

  anon50_Else_dummy:
    assume false;
    return;

  anon50_Then:
    assume {:partition} Mem_T.INT4[Buffer_2 + Tmp_132 * 4] != 255;
    goto L29;

  L29:
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} cbIn > idx_3;
    Tmp_127 := idx_3;
    assume {:nonnull} Buffer_2 != 0;
    assume Buffer_2 > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} Mem_T.INT4[Buffer_2 + Tmp_127 * 4] != 0;
    idx_3 := idx_3 + 1;
    goto L26;

  anon51_Then:
    assume {:partition} Mem_T.INT4[Buffer_2 + Tmp_127 * 4] == 0;
    goto L32;

  L32:
    ntStatus_8 := -1073741811;
    goto L26;

  anon43_Then:
    assume {:partition} idx_3 >= cbIn;
    goto L32;

  anon41_Then:
    assume {:partition} idx_3 >= cbIn;
    goto L29;

  anon45_Then:
    assume {:nonnull} Buffer_2 != 0;
    assume Buffer_2 > 0;
    Tmp_131 := BAND(Mem_T.INT4[Buffer_2], BOR(BOR(1, 2), 4));
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} Tmp_131 == 7;
    goto L19;

  anon54_Then:
    assume {:partition} Tmp_131 != 7;
    ntStatus_8 := -1073741811;
    goto L19;

  anon46_Then:
    goto L14;

  L14:
    call {:si_unique_call 218} Tmp_130, idx_3 := AvcValidateSubunitAddress_loop_L14(Tmp_130, idx_3, Buffer_2, cbIn);
    goto L14_last;

  L14_last:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} cbIn > idx_3;
    Tmp_130 := idx_3;
    assume {:nonnull} Buffer_2 != 0;
    assume Buffer_2 > 0;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} Mem_T.INT4[Buffer_2 + Tmp_130 * 4] == 255;
    idx_3 := idx_3 + 1;
    goto anon52_Else_dummy;

  anon52_Else_dummy:
    assume false;
    return;

  anon52_Then:
    assume {:partition} Mem_T.INT4[Buffer_2 + Tmp_130 * 4] != 255;
    goto L36;

  L36:
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} cbIn > idx_3;
    Tmp_129 := idx_3;
    assume {:nonnull} Buffer_2 != 0;
    assume Buffer_2 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} Mem_T.INT4[Buffer_2 + Tmp_129 * 4] != 0;
    idx_3 := idx_3 + 1;
    goto L19;

  anon53_Then:
    assume {:partition} Mem_T.INT4[Buffer_2 + Tmp_129 * 4] == 0;
    goto L39;

  L39:
    ntStatus_8 := -1073741811;
    goto L19;

  anon44_Then:
    assume {:partition} idx_3 >= cbIn;
    goto L39;

  anon39_Then:
    assume {:partition} idx_3 >= cbIn;
    goto L36;

  anon38_Then:
    ntStatus_8 := -1073741811;
    goto L19;

  anon37_Then:
    assume {:partition} cbIn == 0;
    assume {:nonnull} BytesUsed_2 != 0;
    assume BytesUsed_2 > 0;
    Mem_T.INT4[BytesUsed_2] := 0;
    Tmp_126 := -1073741811;
    goto L1;

  anon49_Then:
    assume {:partition} BytesUsed_2 == 0;
    Tmp_126 := -1073741811;
    goto L1;
}



procedure {:origName "AvcAllocateUnitCommandContext"} AvcAllocateUnitCommandContext(actual_DevExt_7: int, actual_CommandRetval_1: int) returns (Tmp_139: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_139 == -1073741811 || Tmp_139 == 0 || Tmp_139 == -1073741670;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcAllocateUnitCommandContext"} AvcAllocateUnitCommandContext(actual_DevExt_7: int, actual_CommandRetval_1: int) returns (Tmp_139: int)
{
  var {:scalar} Status_7: int;
  var {:pointer} DevExt_7: int;
  var {:pointer} CommandRetval_1: int;

  anon0:
    DevExt_7 := actual_DevExt_7;
    CommandRetval_1 := actual_CommandRetval_1;
    call {:si_unique_call 219} sdv_do_paged_code_check();
    assume {:nonnull} DevExt_7 != 0;
    assume DevExt_7 > 0;
    call {:si_unique_call 220} Status_7 := AvcAllocateSubunitCommandContext(DevExt_7, UnitAddr__BUS_DEVICE_EXTENSION(DevExt_7), CommandRetval_1);
    Tmp_139 := Status_7;
    return;
}



procedure {:origName "AvcCommand_sdv_static_function_7"} AvcCommand_sdv_static_function_7(actual_DevExt_8: int, actual_Command_9: int) returns (Tmp_141: int);
  modifies alloc, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcCommand_sdv_static_function_7"} AvcCommand_sdv_static_function_7(actual_DevExt_8: int, actual_Command_9: int) returns (Tmp_141: int)
{
  var {:scalar} CommandType_1: int;
  var {:scalar} Retries: int;
  var {:pointer} Tmp_142: int;
  var {:scalar} OldIrql_5: int;
  var {:pointer} Irp_10: int;
  var {:scalar} WaitForEvent: int;
  var {:pointer} sdv_75: int;
  var {:scalar} Status_8: int;
  var {:pointer} Tmp_143: int;
  var {:scalar} Tmp_144: int;
  var {:pointer} Tmp_145: int;
  var {:pointer} Tmp_146: int;
  var {:scalar} Padding: int;
  var {:scalar} Event_3: int;
  var {:pointer} sdv_77: int;
  var {:scalar} sdv_78: int;
  var {:scalar} OldIrql_6: int;
  var {:scalar} sdv_80: int;
  var {:pointer} NextIrpStack_3: int;
  var {:scalar} sdv_85: int;
  var {:pointer} CallbackLink_2: int;
  var {:pointer} Tmp_147: int;
  var {:scalar} WaitForAbort: int;
  var {:scalar} InvalidGenLimit: int;
  var {:scalar} tmDelay: int;
  var {:scalar} Tmp_148: int;
  var {:scalar} Tmp_149: int;
  var {:pointer} DevExt_8: int;
  var {:pointer} Command_9: int;
  var vslice_dummy_var_33: int;
  var vslice_dummy_var_34: int;
  var vslice_dummy_var_35: int;
  var vslice_dummy_var_36: int;
  var vslice_dummy_var_37: int;
  var vslice_dummy_var_38: int;
  var vslice_dummy_var_39: int;
  var vslice_dummy_var_23: int;
  var vslice_dummy_var_24: int;
  var vslice_dummy_var_25: int;
  var vslice_dummy_var_26: int;

  anon0:
    call {:si_unique_call 221} Event_3 := __HAVOC_malloc(156);
    call {:si_unique_call 222} tmDelay := __HAVOC_malloc(20);
    DevExt_8 := actual_DevExt_8;
    Command_9 := actual_Command_9;
    call {:si_unique_call 223} Tmp_142 := __HAVOC_malloc(2048);
    call {:si_unique_call 224} Tmp_145 := __HAVOC_malloc(2048);
    call {:si_unique_call 225} Tmp_147 := __HAVOC_malloc(2048);
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc CommandType_1;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    call {:si_unique_call 226} sdv_75 := sdv_ExAllocateFromNPagedLookasideList(0);
    CallbackLink_2 := sdv_75;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} CallbackLink_2 != 0;
    assume {:nonnull} CallbackLink_2 != 0;
    assume CallbackLink_2 > 0;
    call {:si_unique_call 227} KeInitializeEvent(Event_3, 1, 0);
    assume {:nonnull} CallbackLink_2 != 0;
    assume CallbackLink_2 > 0;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    call {:si_unique_call 228} InsertHeadList(CallbackChain__AVC_COMMAND_CONTEXT(Command_9), CallbackLink_2);
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc Tmp_145;
    assume {:nonnull} Tmp_145 != 0;
    assume Tmp_145 > 0;
    Mem_T.INT4[Tmp_145] := BOR(0, CommandType_1);
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc Tmp_149;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc Tmp_142;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    assume {:nonnull} Tmp_142 != 0;
    assume Tmp_142 > 0;
    havoc vslice_dummy_var_23;
    Mem_T.INT4[Tmp_142 + Tmp_149 * 4] := vslice_dummy_var_23;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    Mem_T.INT4[Function__AVC_COMMAND_CONTEXT(Command_9)] := 12;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc Padding;
    goto L32;

  L32:
    call {:si_unique_call 229} Tmp_144, Padding, Tmp_147, Tmp_148 := AvcCommand_sdv_static_function_7_loop_L32(Tmp_144, Padding, Tmp_147, Tmp_148, Command_9);
    goto L32_last;

  L32_last:
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} INTMOD(Padding, 4) != 0;
    Tmp_148 := Padding;
    Padding := Padding + 1;
    Tmp_144 := Tmp_148;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc Tmp_147;
    assume {:nonnull} Tmp_147 != 0;
    assume Tmp_147 > 0;
    Mem_T.INT4[Tmp_147 + Tmp_144 * 4] := 0;
    goto anon45_Else_dummy;

  anon45_Else_dummy:
    assume false;
    return;

  anon45_Then:
    assume {:partition} INTMOD(Padding, 4) == 0;
    assume {:nonnull} DevExt_8 != 0;
    assume DevExt_8 > 0;
    havoc Tmp_143;
    assume {:nonnull} Tmp_143 != 0;
    assume Tmp_143 > 0;
    havoc vslice_dummy_var_24;
    call {:si_unique_call 230} Irp_10 := IoAllocateIrp(vslice_dummy_var_24, 0);
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} Irp_10 != 0;
    InvalidGenLimit := 200;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc Retries;
    assume {:nonnull} Irp_10 != 0;
    assume Irp_10 > 0;
    call {:si_unique_call 231} vslice_dummy_var_38 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto L50;

  L50:
    call {:si_unique_call 232} Retries, OldIrql_5, WaitForEvent, Status_8, Tmp_146, OldIrql_6, sdv_80, NextIrpStack_3, sdv_85, WaitForAbort, InvalidGenLimit, vslice_dummy_var_34, vslice_dummy_var_35, vslice_dummy_var_36, vslice_dummy_var_37, vslice_dummy_var_39 := AvcCommand_sdv_static_function_7_loop_L50(Retries, OldIrql_5, Irp_10, WaitForEvent, Status_8, Tmp_146, OldIrql_6, sdv_80, NextIrpStack_3, sdv_85, WaitForAbort, InvalidGenLimit, tmDelay, DevExt_8, Command_9, vslice_dummy_var_34, vslice_dummy_var_35, vslice_dummy_var_36, vslice_dummy_var_37, vslice_dummy_var_39);
    goto L50_last;

  L50_last:
    call {:si_unique_call 257} NextIrpStack_3 := sdv_IoGetNextIrpStackLocation(Irp_10);
    assume {:nonnull} NextIrpStack_3 != 0;
    assume NextIrpStack_3 > 0;
    assume {:nonnull} NextIrpStack_3 != 0;
    assume NextIrpStack_3 > 0;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    assume {:nonnull} NextIrpStack_3 != 0;
    assume NextIrpStack_3 > 0;
    call {:si_unique_call 258} Status_8 := AvcPrepareForResponseCallback(DevExt_8, Command_9);
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} yogi_error != 1;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} Status_8 != 0;
    goto L66;

  L66:
    assume {:nonnull} DevExt_8 != 0;
    assume DevExt_8 > 0;
    havoc vslice_dummy_var_25;
    call {:si_unique_call 233} vslice_dummy_var_33 := KeSetTimer(0, vslice_dummy_var_25, 0);
    call {:si_unique_call 234} IoFreeIrp(0);
    goto L72;

  L72:
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} Status_8 != 0;
    goto L74;

  L74:
    call {:si_unique_call 235} sdv_77, sdv_78, CallbackLink_2 := AvcCommand_sdv_static_function_7_loop_L74(sdv_77, sdv_78, CallbackLink_2, Command_9);
    goto L74_last;

  L74_last:
    call {:si_unique_call 256} sdv_78 := sdv_IsListEmpty(0);
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} sdv_78 == 0;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    call {:si_unique_call 236} sdv_77 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(Command_9));
    CallbackLink_2 := sdv_77;
    call {:si_unique_call 237} ExFreeToNPagedLookasideList(AvcCommandLinkPool, CallbackLink_2);
    goto anon49_Else_dummy;

  anon49_Else_dummy:
    assume false;
    return;

  anon49_Then:
    assume {:partition} sdv_78 != 0;
    goto L73;

  L73:
    Tmp_141 := Status_8;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon48_Then:
    assume {:partition} Status_8 == 0;
    goto L73;

  anon47_Then:
    assume {:partition} Status_8 == 0;
    assume {:nonnull} DevExt_8 != 0;
    assume DevExt_8 > 0;
    havoc vslice_dummy_var_26;
    call {:si_unique_call 238} Status_8 := Avc_SubmitIrpSynch(vslice_dummy_var_26, Irp_10);
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} yogi_error != 1;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} Status_8 != 0;
    WaitForAbort := 0;
    call {:si_unique_call 239} Tmp_146 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_146 != 0;
    assume Tmp_146 > 0;
    Mem_T.INT4[Tmp_146] := OldIrql_6;
    call {:si_unique_call 240} sdv_KeAcquireSpinLock(0, Tmp_146);
    assume {:nonnull} Tmp_146 != 0;
    assume Tmp_146 > 0;
    OldIrql_6 := Mem_T.INT4[Tmp_146];
    call {:si_unique_call 241} sdv_80 := sdv_IsListEmpty(0);
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} sdv_80 != 0;
    WaitForAbort := 1;
    goto L104;

  L104:
    call {:si_unique_call 242} sdv_KeReleaseSpinLock(0, OldIrql_6);
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} WaitForAbort != 0;
    call {:si_unique_call 243} vslice_dummy_var_35 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc Status_8;
    goto L108;

  L108:
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} 258 == Status_8;
    Status_8 := -1073741248;
    goto L113;

  L113:
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} Status_8 != 0;
    assume {:nonnull} DevExt_8 != 0;
    assume DevExt_8 > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} -1072562032 == Status_8;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} InvalidGenLimit != 0;
    assume {:nonnull} tmDelay != 0;
    assume tmDelay > 0;
    assume {:nonnull} tmDelay != 0;
    assume tmDelay > 0;
    call {:si_unique_call 244} vslice_dummy_var_39 := KeDelayExecutionThread(0, 0, 0);
    InvalidGenLimit := InvalidGenLimit - 1;
    goto anon58_Else_dummy;

  anon58_Else_dummy:
    assume false;
    return;

  anon58_Then:
    assume {:partition} InvalidGenLimit == 0;
    goto L66;

  anon56_Then:
    assume {:partition} -1072562032 != Status_8;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} 258 == Status_8;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} Retries != 0;
    Retries := Retries - 1;
    goto anon59_Else_dummy;

  anon59_Else_dummy:
    assume false;
    return;

  anon59_Then:
    assume {:partition} Retries == 0;
    goto L66;

  anon57_Then:
    assume {:partition} 258 != Status_8;
    goto L66;

  anon55_Then:
    goto L66;

  anon54_Then:
    assume {:partition} Status_8 == 0;
    goto L66;

  anon53_Then:
    assume {:partition} 258 != Status_8;
    goto L113;

  anon52_Then:
    assume {:partition} WaitForAbort == 0;
    goto L108;

  anon51_Then:
    assume {:partition} sdv_80 == 0;
    call {:si_unique_call 245} vslice_dummy_var_34 := sdv_RemoveEntryList(0);
    call {:si_unique_call 246} InitializeListHead(Command_9);
    goto L104;

  anon50_Then:
    assume {:partition} Status_8 == 0;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    call {:si_unique_call 247} Status_8 := KeWaitForSingleObject(0, 0, 0, 0, Timeout__AVC_COMMAND_CONTEXT(Command_9));
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} 258 == Status_8;
    WaitForEvent := 0;
    call {:si_unique_call 248} Tmp_146 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_146 != 0;
    assume Tmp_146 > 0;
    Mem_T.INT4[Tmp_146] := OldIrql_5;
    call {:si_unique_call 249} sdv_KeAcquireSpinLock(0, Tmp_146);
    assume {:nonnull} Tmp_146 != 0;
    assume Tmp_146 > 0;
    OldIrql_5 := Mem_T.INT4[Tmp_146];
    call {:si_unique_call 250} sdv_85 := sdv_IsListEmpty(0);
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} sdv_85 != 0;
    WaitForEvent := 1;
    goto L150;

  L150:
    call {:si_unique_call 251} sdv_KeReleaseSpinLock(0, OldIrql_5);
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} WaitForEvent != 0;
    call {:si_unique_call 252} vslice_dummy_var_37 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc Status_8;
    goto L154;

  L154:
    call {:si_unique_call 253} IoReuseIrp(Irp_10, -1073741637);
    goto L113;

  anon63_Then:
    assume {:partition} WaitForEvent == 0;
    goto L154;

  anon62_Then:
    assume {:partition} sdv_85 == 0;
    call {:si_unique_call 254} vslice_dummy_var_36 := sdv_RemoveEntryList(0);
    call {:si_unique_call 255} InitializeListHead(Command_9);
    goto L150;

  anon60_Then:
    assume {:partition} 258 != Status_8;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} Status_8 == 0;
    assume {:nonnull} Command_9 != 0;
    assume Command_9 > 0;
    havoc Status_8;
    goto L113;

  anon61_Then:
    assume {:partition} Status_8 != 0;
    goto L113;

  anon66_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon65_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon46_Then:
    assume {:partition} Irp_10 == 0;
    Status_8 := -1073741670;
    goto L72;

  anon64_Then:
    assume {:partition} CallbackLink_2 == 0;
    Tmp_141 := -1073741670;
    goto L1;
}



procedure {:origName "AvcSearchForUnitCommandHandler_sdv_static_function_7"} AvcSearchForUnitCommandHandler_sdv_static_function_7(actual_DevExt_9: int, actual_Opcode_2: int, actual_ppCommand: int) returns (Tmp_150: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures Tmp_150 == 1 || Tmp_150 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcSearchForUnitCommandHandler_sdv_static_function_7"} AvcSearchForUnitCommandHandler_sdv_static_function_7(actual_DevExt_9: int, actual_Opcode_2: int, actual_ppCommand: int) returns (Tmp_150: int)
{
  var {:pointer} Tmp_151: int;
  var {:pointer} Tmp_152: int;
  var {:pointer} Tmp_153: int;
  var {:scalar} OldIrql_7: int;
  var {:scalar} max: int;
  var {:pointer} Tmp_154: int;
  var {:pointer} Command_10: int;
  var {:scalar} Tmp_155: int;
  var {:pointer} Entry_2: int;
  var {:scalar} idx_4: int;
  var {:scalar} OpcodesMatch: int;
  var {:scalar} Tmp_156: int;
  var {:pointer} DevExt_9: int;
  var {:scalar} Opcode_2: int;
  var {:pointer} ppCommand: int;
  var vslice_dummy_var_40: int;

  anon0:
    DevExt_9 := actual_DevExt_9;
    Opcode_2 := actual_Opcode_2;
    ppCommand := actual_ppCommand;
    call {:si_unique_call 259} Tmp_154 := __HAVOC_malloc(128);
    assume {:nonnull} ppCommand != 0;
    assume ppCommand > 0;
    call {:si_unique_call 260} Tmp_151 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_151 != 0;
    assume Tmp_151 > 0;
    Mem_T.INT4[Tmp_151] := OldIrql_7;
    call {:si_unique_call 261} sdv_KeAcquireSpinLock(0, Tmp_151);
    assume {:nonnull} Tmp_151 != 0;
    assume Tmp_151 > 0;
    OldIrql_7 := Mem_T.INT4[Tmp_151];
    assume {:nonnull} DevExt_9 != 0;
    assume DevExt_9 > 0;
    havoc Entry_2;
    goto L11;

  L11:
    call {:si_unique_call 262} Tmp_152, Tmp_153, max, Tmp_154, Command_10, Entry_2, idx_4, OpcodesMatch, Tmp_156 := AvcSearchForUnitCommandHandler_sdv_static_function_7_loop_L11(Tmp_152, Tmp_153, max, Tmp_154, Command_10, Entry_2, idx_4, OpcodesMatch, Tmp_156, Opcode_2);
    goto L11_last;

  L11_last:
    goto anon19_Then, anon19_Else;

  anon19_Else:
    Command_10 := Entry_2;
    assume {:nonnull} Command_10 != 0;
    assume Command_10 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    goto L18;

  L18:
    assume {:nonnull} Entry_2 != 0;
    assume Entry_2 > 0;
    havoc Entry_2;
    goto L18_dummy;

  L18_dummy:
    assume false;
    return;

  anon24_Then:
    assume {:nonnull} Command_10 != 0;
    assume Command_10 > 0;
    havoc Tmp_154;
    assume {:nonnull} Tmp_154 != 0;
    assume Tmp_154 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} 255 == Mem_T.INT4[Tmp_154];
    OpcodesMatch := 0;
    assume {:nonnull} Command_10 != 0;
    assume Command_10 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:nonnull} Command_10 != 0;
    assume Command_10 > 0;
    havoc Tmp_152;
    assume {:nonnull} Tmp_152 != 0;
    assume Tmp_152 > 0;
    max := Mem_T.INT4[Tmp_152];
    idx_4 := 1;
    goto L27;

  L27:
    call {:si_unique_call 263} Tmp_153, idx_4, Tmp_156 := AvcSearchForUnitCommandHandler_sdv_static_function_7_loop_L27(Tmp_153, max, Command_10, idx_4, Tmp_156, Opcode_2);
    goto L27_last;

  L27_last:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} max >= idx_4;
    Tmp_156 := idx_4;
    assume {:nonnull} Command_10 != 0;
    assume Command_10 > 0;
    havoc Tmp_153;
    assume {:nonnull} Tmp_153 != 0;
    assume Tmp_153 > 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} Opcode_2 == Mem_T.INT4[Tmp_153 + Tmp_156 * 4];
    OpcodesMatch := 1;
    goto L28;

  L28:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} OpcodesMatch != 0;
    call {:si_unique_call 264} vslice_dummy_var_40 := sdv_RemoveEntryList(0);
    call {:si_unique_call 265} InitializeListHead(Command_10);
    assume {:nonnull} ppCommand != 0;
    assume ppCommand > 0;
    goto L12;

  L12:
    call {:si_unique_call 266} sdv_KeReleaseSpinLock(0, OldIrql_7);
    assume {:nonnull} ppCommand != 0;
    assume ppCommand > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    Tmp_155 := 1;
    goto L44;

  L44:
    Tmp_150 := Tmp_155;
    return;

  anon23_Then:
    Tmp_155 := 0;
    goto L44;

  anon22_Then:
    assume {:partition} OpcodesMatch == 0;
    goto L18;

  anon27_Then:
    assume {:partition} Opcode_2 != Mem_T.INT4[Tmp_153 + Tmp_156 * 4];
    idx_4 := idx_4 + 1;
    goto anon27_Then_dummy;

  anon27_Then_dummy:
    assume false;
    return;

  anon21_Then:
    assume {:partition} idx_4 > max;
    goto L28;

  anon26_Then:
    assume {:nonnull} Command_10 != 0;
    assume Command_10 > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    OpcodesMatch := 0;
    goto L74;

  L74:
    goto L28;

  anon20_Then:
    OpcodesMatch := 1;
    goto L74;

  anon25_Then:
    assume {:partition} 255 != Mem_T.INT4[Tmp_154];
    goto L18;

  anon19_Then:
    goto L12;
}



procedure {:origName "AvcDuplicateCommandContext_sdv_static_function_7"} AvcDuplicateCommandContext_sdv_static_function_7(actual_OrigCommand: int) returns (Tmp_157: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_157 == 0 || Tmp_157 == -1073741670;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcDuplicateCommandContext_sdv_static_function_7"} AvcDuplicateCommandContext_sdv_static_function_7(actual_OrigCommand: int) returns (Tmp_157: int)
{
  var {:pointer} sdv_90: int;
  var {:pointer} Entry_3: int;
  var {:pointer} DevExt_10: int;
  var {:scalar} sdv_92: int;
  var {:scalar} sdv_93: int;
  var {:scalar} sdv_95: int;
  var {:pointer} Command_11: int;
  var {:pointer} Entry_4: int;
  var {:pointer} OrigCommand: int;
  var vslice_dummy_var_41: int;
  var vslice_dummy_var_42: int;
  var vslice_dummy_var_43: int;

  anon0:
    OrigCommand := actual_OrigCommand;
    assume {:nonnull} OrigCommand != 0;
    assume OrigCommand > 0;
    havoc DevExt_10;
    call {:si_unique_call 267} sdv_90 := sdv_ExAllocateFromNPagedLookasideList(0);
    Command_11 := sdv_90;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} Command_11 != 0;
    call {:si_unique_call 268} sdv_RtlCopyMemory(0, 0, 672);
    assume {:nonnull} OrigCommand != 0;
    assume OrigCommand > 0;
    assume {:nonnull} DevExt_10 != 0;
    assume DevExt_10 > 0;
    call {:si_unique_call 269} vslice_dummy_var_43 := sdv_InsertTailList(PendingResponseList__BUS_DEVICE_EXTENSION(DevExt_10), Command_11);
    assume {:nonnull} Command_11 != 0;
    assume Command_11 > 0;
    call {:si_unique_call 270} InitializeListHead(PendingIrpList__AVC_COMMAND_CONTEXT(Command_11));
    goto L23;

  L23:
    call {:si_unique_call 271} Entry_3, sdv_92, vslice_dummy_var_42 := AvcDuplicateCommandContext_sdv_static_function_7_loop_L23(Entry_3, sdv_92, Command_11, OrigCommand, vslice_dummy_var_42);
    goto L23_last;

  L23_last:
    call {:si_unique_call 282} sdv_92 := sdv_IsListEmpty(0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} sdv_92 == 0;
    assume {:nonnull} OrigCommand != 0;
    assume OrigCommand > 0;
    call {:si_unique_call 272} Entry_3 := RemoveHeadList(PendingIrpList__AVC_COMMAND_CONTEXT(OrigCommand));
    assume {:nonnull} Command_11 != 0;
    assume Command_11 > 0;
    call {:si_unique_call 273} vslice_dummy_var_42 := sdv_InsertTailList(PendingIrpList__AVC_COMMAND_CONTEXT(Command_11), Entry_3);
    goto anon9_Else_dummy;

  anon9_Else_dummy:
    assume false;
    return;

  anon9_Then:
    assume {:partition} sdv_92 != 0;
    assume {:nonnull} Command_11 != 0;
    assume Command_11 > 0;
    call {:si_unique_call 274} InitializeListHead(CallbackChain__AVC_COMMAND_CONTEXT(Command_11));
    call {:si_unique_call 275} sdv_93 := sdv_IsListEmpty(0);
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} sdv_93 == 0;
    goto L38;

  L38:
    call {:si_unique_call 276} sdv_95, Entry_4, vslice_dummy_var_41 := AvcDuplicateCommandContext_sdv_static_function_7_loop_L38(sdv_95, Command_11, Entry_4, OrigCommand, vslice_dummy_var_41);
    goto L38_last;

  L38_last:
    assume {:nonnull} OrigCommand != 0;
    assume OrigCommand > 0;
    call {:si_unique_call 279} Entry_4 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(OrigCommand));
    assume {:nonnull} Command_11 != 0;
    assume Command_11 > 0;
    call {:si_unique_call 280} vslice_dummy_var_41 := sdv_InsertTailList(CallbackChain__AVC_COMMAND_CONTEXT(Command_11), Entry_4);
    call {:si_unique_call 281} sdv_95 := sdv_IsListEmpty(0);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} sdv_95 != 0;
    assume {:nonnull} Command_11 != 0;
    assume Command_11 > 0;
    call {:si_unique_call 277} Entry_4 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(Command_11));
    assume {:nonnull} OrigCommand != 0;
    assume OrigCommand > 0;
    call {:si_unique_call 278} InsertHeadList(CallbackChain__AVC_COMMAND_CONTEXT(OrigCommand), Entry_4);
    goto L36;

  L36:
    assume {:nonnull} Command_11 != 0;
    assume Command_11 > 0;
    Tmp_157 := 0;
    goto L1;

  L1:
    return;

  anon11_Then:
    assume {:partition} sdv_95 == 0;
    goto anon11_Then_dummy;

  anon11_Then_dummy:
    assume false;
    return;

  anon10_Then:
    assume {:partition} sdv_93 != 0;
    goto L36;

  anon12_Then:
    assume {:partition} Command_11 == 0;
    Tmp_157 := -1073741670;
    goto L1;
}



procedure {:origName "AvcDequeueFCPIrp"} AvcDequeueFCPIrp(actual_Command_13: int) returns (Tmp_181: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcDequeueFCPIrp"} AvcDequeueFCPIrp(actual_Command_13: int) returns (Tmp_181: int)
{
  var {:pointer} listEntry: int;
  var {:scalar} sdv_109: int;
  var {:scalar} oldCancelRoutine: int;
  var {:scalar} oldIrql: int;
  var {:pointer} sdv_111: int;
  var {:pointer} nextIrp: int;
  var {:pointer} Tmp_182: int;
  var {:pointer} Command_13: int;

  anon0:
    Command_13 := actual_Command_13;
    assume {:nonnull} Command_13 != 0;
    assume Command_13 > 0;
    nextIrp := 0;
    call {:si_unique_call 283} Tmp_182 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_182 != 0;
    assume Tmp_182 > 0;
    Mem_T.INT4[Tmp_182] := oldIrql;
    call {:si_unique_call 284} sdv_KeAcquireSpinLock(0, Tmp_182);
    assume {:nonnull} Tmp_182 != 0;
    assume Tmp_182 > 0;
    oldIrql := Mem_T.INT4[Tmp_182];
    goto L11;

  L11:
    call {:si_unique_call 285} listEntry, sdv_109, oldCancelRoutine, sdv_111, nextIrp := AvcDequeueFCPIrp_loop_L11(listEntry, sdv_109, oldCancelRoutine, sdv_111, nextIrp, Command_13);
    goto L11_last;

  L11_last:
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} nextIrp != 0;
    goto L15;

  L15:
    call {:si_unique_call 286} sdv_KeReleaseSpinLock(0, oldIrql);
    Tmp_181 := nextIrp;
    return;

  anon7_Then:
    assume {:partition} nextIrp == 0;
    call {:si_unique_call 287} sdv_109 := sdv_IsListEmpty(0);
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} sdv_109 == 0;
    assume {:nonnull} Command_13 != 0;
    assume Command_13 > 0;
    call {:si_unique_call 288} listEntry := RemoveHeadList(PendingIrpList__AVC_COMMAND_CONTEXT(Command_13));
    call {:si_unique_call 289} sdv_111 := sdv_containing_record(listEntry, 88);
    nextIrp := sdv_111;
    call {:si_unique_call 290} oldCancelRoutine := sdv_IoSetCancelRoutine(nextIrp, 0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} oldCancelRoutine == 0;
    assume {:nonnull} nextIrp != 0;
    assume nextIrp > 0;
    call {:si_unique_call 291} InitializeListHead(ListEntry_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(nextIrp))));
    nextIrp := 0;
    goto anon9_Else_dummy;

  anon9_Else_dummy:
    assume false;
    return;

  anon9_Then:
    assume {:partition} oldCancelRoutine != 0;
    goto anon9_Then_dummy;

  anon9_Then_dummy:
    assume false;
    return;

  anon8_Then:
    assume {:partition} sdv_109 != 0;
    goto L15;
}



procedure {:origName "AvcUnpackSubunitAddress"} AvcUnpackSubunitAddress(actual_Buffer_3: int, actual_SubunitType_2: int, actual_SubunitID_1: int, actual_BytesUsed_3: int) returns (Tmp_183: int);
  modifies Mem_T.INT4;
  free ensures Tmp_183 == 0 || Tmp_183 == -1073741811;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcUnpackSubunitAddress"} AvcUnpackSubunitAddress(actual_Buffer_3: int, actual_SubunitType_2: int, actual_SubunitID_1: int, actual_BytesUsed_3: int) returns (Tmp_183: int)
{
  var {:scalar} Tmp_184: int;
  var {:scalar} Temp: int;
  var {:scalar} Tmp_185: int;
  var {:scalar} Tmp_186: int;
  var {:scalar} Tmp_187: int;
  var {:scalar} Tmp_188: int;
  var {:scalar} Tmp_189: int;
  var {:scalar} Tmp_190: int;
  var {:scalar} Tmp_191: int;
  var {:scalar} ntStatus_9: int;
  var {:scalar} Tmp_192: int;
  var {:scalar} Tmp_193: int;
  var {:scalar} Tmp_194: int;
  var {:scalar} idx_8: int;
  var {:scalar} Tmp_195: int;
  var {:scalar} Tmp_196: int;
  var {:scalar} Tmp_197: int;
  var {:scalar} Tmp_199: int;
  var {:pointer} Buffer_3: int;
  var {:pointer} SubunitType_2: int;
  var {:pointer} SubunitID_1: int;
  var {:pointer} BytesUsed_3: int;
  var boogieTmp: int;

  anon0:
    Buffer_3 := actual_Buffer_3;
    SubunitType_2 := actual_SubunitType_2;
    SubunitID_1 := actual_SubunitID_1;
    BytesUsed_3 := actual_BytesUsed_3;
    idx_8 := 1;
    ntStatus_9 := 0;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} BytesUsed_3 != 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} SubunitType_2 != 0;
    assume {:nonnull} SubunitType_2 != 0;
    assume SubunitType_2 > 0;
    call {:si_unique_call 292} boogieTmp := corral_nondet();
    Mem_T.INT4[SubunitType_2] := boogieTmp;
    assume {:nonnull} SubunitType_2 != 0;
    assume SubunitType_2 > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} Mem_T.INT4[SubunitType_2] == 30;
    goto L15;

  L15:
    call {:si_unique_call 293} Tmp_188, idx_8, Tmp_197, Tmp_199 := AvcUnpackSubunitAddress_loop_L15(Tmp_188, idx_8, Tmp_197, Tmp_199, Buffer_3, SubunitType_2);
    goto L15_last;

  L15_last:
    Tmp_199 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_199 * 4] == 255;
    Tmp_188 := idx_8;
    Tmp_197 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    assume {:nonnull} SubunitType_2 != 0;
    assume SubunitType_2 > 0;
    Mem_T.INT4[SubunitType_2 + Tmp_188 * 4] := Mem_T.INT4[Buffer_3 + Tmp_197 * 4];
    idx_8 := idx_8 + 1;
    goto anon38_Else_dummy;

  anon38_Else_dummy:
    assume false;
    return;

  anon38_Then:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_199 * 4] != 255;
    Tmp_194 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_194 * 4] != 0;
    Tmp_186 := idx_8;
    Tmp_189 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    assume {:nonnull} SubunitType_2 != 0;
    assume SubunitType_2 > 0;
    Mem_T.INT4[SubunitType_2 + Tmp_186 * 4] := Mem_T.INT4[Buffer_3 + Tmp_189 * 4];
    idx_8 := idx_8 + 1;
    goto L14;

  L14:
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} SubunitID_1 != 0;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    Temp := BAND(Mem_T.INT4[Buffer_3], BOR(BOR(1, 2), 4));
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} 5 >= Temp;
    assume {:nonnull} SubunitID_1 != 0;
    assume SubunitID_1 > 0;
    Mem_T.INT4[SubunitID_1] := Temp;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} Temp == 5;
    goto L29;

  L29:
    call {:si_unique_call 294} Tmp_185, Tmp_192, idx_8 := AvcUnpackSubunitAddress_loop_L29(Tmp_185, Tmp_192, idx_8, Buffer_3, SubunitID_1);
    goto L29_last;

  L29_last:
    Tmp_192 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_192 * 4] == 255;
    Tmp_185 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    assume {:nonnull} SubunitID_1 != 0;
    assume SubunitID_1 > 0;
    Mem_T.INT4[SubunitID_1] := Mem_T.INT4[SubunitID_1] + Mem_T.INT4[Buffer_3 + Tmp_185 * 4] - 1;
    idx_8 := idx_8 + 1;
    goto anon42_Else_dummy;

  anon42_Else_dummy:
    assume false;
    return;

  anon42_Then:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_192 * 4] != 255;
    Tmp_190 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_190 * 4] != 0;
    Tmp_196 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    assume {:nonnull} SubunitID_1 != 0;
    assume SubunitID_1 > 0;
    Mem_T.INT4[SubunitID_1] := Mem_T.INT4[SubunitID_1] + Mem_T.INT4[Buffer_3 + Tmp_196 * 4] - 1;
    idx_8 := idx_8 + 1;
    goto L28;

  L28:
    assume {:nonnull} BytesUsed_3 != 0;
    assume BytesUsed_3 > 0;
    Mem_T.INT4[BytesUsed_3] := idx_8;
    Tmp_183 := ntStatus_9;
    goto L1;

  L1:
    return;

  anon43_Then:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_190 * 4] == 0;
    ntStatus_9 := -1073741811;
    goto L28;

  anon41_Then:
    assume {:partition} Temp != 5;
    goto L28;

  anon40_Then:
    assume {:partition} Temp > 5;
    assume {:nonnull} SubunitID_1 != 0;
    assume SubunitID_1 > 0;
    Mem_T.INT4[SubunitID_1] := 0;
    goto L28;

  anon35_Then:
    assume {:partition} SubunitID_1 == 0;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    Tmp_193 := BAND(Mem_T.INT4[Buffer_3], BOR(BOR(1, 2), 4));
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} Tmp_193 == 5;
    goto L38;

  L38:
    call {:si_unique_call 295} Tmp_191, idx_8 := AvcUnpackSubunitAddress_loop_L38(Tmp_191, idx_8, Buffer_3);
    goto L38_last;

  L38_last:
    Tmp_191 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_191 * 4] == 255;
    idx_8 := idx_8 + 1;
    goto anon45_Else_dummy;

  anon45_Else_dummy:
    assume false;
    return;

  anon45_Then:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_191 * 4] != 255;
    Tmp_184 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_184 * 4] != 0;
    idx_8 := idx_8 + 1;
    goto L28;

  anon46_Then:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_184 * 4] == 0;
    ntStatus_9 := -1073741811;
    goto L28;

  anon44_Then:
    assume {:partition} Tmp_193 != 5;
    goto L28;

  anon39_Then:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_194 * 4] == 0;
    ntStatus_9 := -1073741811;
    goto L14;

  anon37_Then:
    assume {:partition} Mem_T.INT4[SubunitType_2] != 30;
    goto L14;

  anon33_Then:
    assume {:partition} SubunitType_2 == 0;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    goto L43;

  L43:
    call {:si_unique_call 296} Tmp_187, idx_8 := AvcUnpackSubunitAddress_loop_L43(Tmp_187, idx_8, Buffer_3);
    goto L43_last;

  L43_last:
    Tmp_187 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_187 * 4] == 255;
    idx_8 := idx_8 + 1;
    goto anon47_Else_dummy;

  anon47_Else_dummy:
    assume false;
    return;

  anon47_Then:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_187 * 4] != 255;
    Tmp_195 := idx_8;
    assume {:nonnull} Buffer_3 != 0;
    assume Buffer_3 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_195 * 4] != 0;
    idx_8 := idx_8 + 1;
    goto L14;

  anon48_Then:
    assume {:partition} Mem_T.INT4[Buffer_3 + Tmp_195 * 4] == 0;
    ntStatus_9 := -1073741811;
    goto L14;

  anon34_Then:
    goto L14;

  anon36_Then:
    assume {:partition} BytesUsed_3 == 0;
    Tmp_183 := -1073741811;
    goto L1;
}



procedure {:origName "AvcExtractMatchingIrps_sdv_static_function_7"} AvcExtractMatchingIrps_sdv_static_function_7(actual_FileObject_1: int, actual_CommandList: int, actual_IrpList: int);
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcExtractMatchingIrps_sdv_static_function_7"} AvcExtractMatchingIrps_sdv_static_function_7(actual_FileObject_1: int, actual_CommandList: int, actual_IrpList: int)
{
  var {:pointer} Irp_13: int;
  var {:pointer} CommandEntry: int;
  var {:pointer} sdv_113: int;
  var {:pointer} IrpStack_4: int;
  var {:scalar} oldCancelRoutine_1: int;
  var {:pointer} nextIrpEntry: int;
  var {:pointer} Command_14: int;
  var {:pointer} IrpEntry_1: int;
  var {:pointer} FileObject_1: int;
  var {:pointer} CommandList: int;
  var {:pointer} IrpList: int;
  var vslice_dummy_var_44: int;
  var vslice_dummy_var_45: int;
  var vslice_dummy_var_46: int;

  anon0:
    call {:si_unique_call 297} vslice_dummy_var_44 := __HAVOC_malloc(4);
    FileObject_1 := actual_FileObject_1;
    CommandList := actual_CommandList;
    IrpList := actual_IrpList;
    assume {:nonnull} CommandList != 0;
    assume CommandList > 0;
    havoc CommandEntry;
    goto L5;

  L5:
    call {:si_unique_call 298} Irp_13, CommandEntry, sdv_113, IrpStack_4, oldCancelRoutine_1, nextIrpEntry, Command_14, IrpEntry_1, vslice_dummy_var_45, vslice_dummy_var_46 := AvcExtractMatchingIrps_sdv_static_function_7_loop_L5(Irp_13, CommandEntry, sdv_113, IrpStack_4, oldCancelRoutine_1, nextIrpEntry, Command_14, IrpEntry_1, FileObject_1, IrpList, vslice_dummy_var_45, vslice_dummy_var_46);
    goto L5_last;

  L5_last:
    goto anon9_Then, anon9_Else;

  anon9_Else:
    Command_14 := CommandEntry;
    assume {:nonnull} Command_14 != 0;
    assume Command_14 > 0;
    havoc IrpEntry_1;
    goto L11;

  L11:
    call {:si_unique_call 299} Irp_13, sdv_113, IrpStack_4, oldCancelRoutine_1, nextIrpEntry, IrpEntry_1, vslice_dummy_var_45, vslice_dummy_var_46 := AvcExtractMatchingIrps_sdv_static_function_7_loop_L11(Irp_13, sdv_113, IrpStack_4, oldCancelRoutine_1, nextIrpEntry, IrpEntry_1, FileObject_1, IrpList, vslice_dummy_var_45, vslice_dummy_var_46);
    goto L11_last;

  L11_last:
    goto anon10_Then, anon10_Else;

  anon10_Else:
    call {:si_unique_call 300} sdv_113 := sdv_containing_record(IrpEntry_1, 88);
    Irp_13 := sdv_113;
    call {:si_unique_call 301} IrpStack_4 := sdv_IoGetCurrentIrpStackLocation(Irp_13);
    assume {:nonnull} IrpEntry_1 != 0;
    assume IrpEntry_1 > 0;
    havoc nextIrpEntry;
    assume {:nonnull} IrpStack_4 != 0;
    assume IrpStack_4 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    call {:si_unique_call 302} oldCancelRoutine_1 := sdv_IoSetCancelRoutine(Irp_13, 0);
    call {:si_unique_call 303} vslice_dummy_var_45 := sdv_RemoveEntryList(0);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} oldCancelRoutine_1 != 0;
    call {:si_unique_call 304} vslice_dummy_var_46 := sdv_InsertTailList(IrpList, IrpEntry_1);
    goto L26;

  L26:
    IrpEntry_1 := nextIrpEntry;
    goto L26_dummy;

  L26_dummy:
    assume false;
    return;

  anon11_Then:
    assume {:partition} oldCancelRoutine_1 == 0;
    call {:si_unique_call 305} InitializeListHead(IrpEntry_1);
    goto L26;

  anon12_Then:
    goto L26;

  anon10_Then:
    assume {:nonnull} CommandEntry != 0;
    assume CommandEntry > 0;
    havoc CommandEntry;
    goto anon10_Then_dummy;

  anon10_Then_dummy:
    assume false;
    return;

  anon9_Then:
    return;
}



procedure {:origName "SLIC_sdv_IoCallDriver_entry"} {:osmodel} SLIC_sdv_IoCallDriver_entry(actual_caller: int, actual_sdv_119: int);
  modifies yogi_error;
  free ensures old(sdv_irql_current) == 0 ==> yogi_error == 0;
  free ensures old(sdv_irql_current) == 1 ==> yogi_error == 0;
  free ensures yogi_error == 1;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "SLIC_sdv_IoCallDriver_entry"} {:osmodel} SLIC_sdv_IoCallDriver_entry(actual_caller: int, actual_sdv_119: int)
{
  var {:pointer} Tmp_213: int;
  var {:pointer} Tmp_214: int;
  var {:pointer} Tmp_215: int;
  var {:pointer} Tmp_216: int;
  var {:pointer} Tmp_217: int;
  var {:pointer} caller: int;
  var {:pointer} sdv_119: int;

  anon0:
    caller := actual_caller;
    sdv_119 := actual_sdv_119;
    assume {:nonnull} sdv_119 != 0;
    assume sdv_119 > 0;
    havoc Tmp_213;
    assume {:nonnull} sdv_119 != 0;
    assume sdv_119 > 0;
    havoc Tmp_214;
    assume {:nonnull} sdv_119 != 0;
    assume sdv_119 > 0;
    havoc Tmp_217;
    assume {:nonnull} sdv_119 != 0;
    assume sdv_119 > 0;
    havoc Tmp_216;
    assume {:nonnull} sdv_119 != 0;
    assume sdv_119 > 0;
    havoc Tmp_215;
    assume {:nonnull} Tmp_215 != 0;
    assume Tmp_215 > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:nonnull} Tmp_216 != 0;
    assume Tmp_216 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:nonnull} Tmp_217 != 0;
    assume Tmp_217 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:nonnull} Tmp_214 != 0;
    assume Tmp_214 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:nonnull} Tmp_213 != 0;
    assume Tmp_213 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} 2 > sdv_irql_current;
    call {:si_unique_call 306} SLIC_EXIT_ROUTINE(strConst__li2bpl14);
    goto L2;

  L2:
    goto LM2;

  LM2:
    return;

  anon15_Then:
    assume {:partition} sdv_irql_current >= 2;
    call {:si_unique_call 307} SLIC_ABORT_3_0(caller, sdv_119);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} yogi_error != 1;
    goto L2;

  anon21_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon16_Then:
    goto L4;

  L4:
    call {:si_unique_call 308} SLIC_EXIT_ROUTINE(strConst__li2bpl14);
    goto L2;

  anon17_Then:
    goto L4;

  anon18_Then:
    goto L4;

  anon19_Then:
    goto L4;

  anon20_Then:
    goto L4;
}



procedure {:origName "SLIC_ABORT_3_0"} SLIC_ABORT_3_0(actual_caller_2: int, actual_sdv_120: int);
  modifies yogi_error;
  free ensures yogi_error == 1;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "SLIC_ABORT_3_0"} SLIC_ABORT_3_0(actual_caller_2: int, actual_sdv_120: int)
{
  var {:pointer} caller_2: int;
  var {:pointer} sdv_120: int;

  anon0:
    caller_2 := actual_caller_2;
    sdv_120 := actual_sdv_120;
    call {:si_unique_call 309} SLIC_ERROR_ROUTINE(strConst__li2bpl15);
    return;
}



procedure {:origName "_sdv_init12"} _sdv_init12();
  modifies SLAM_guard_S_0, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures yogi_error == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init12"} _sdv_init12()
{

  anon0:
    SLAM_guard_S_0 := SLAM_guard_S_0_init;
    yogi_error := 0;
    assume sdv_cancelFptr == 0;
    return;
}



procedure {:origName "SLIC_ERROR_ROUTINE"} SLIC_ERROR_ROUTINE(actual_msg: int);
  modifies yogi_error;
  free ensures yogi_error == 1;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "SLIC_ERROR_ROUTINE"} SLIC_ERROR_ROUTINE(actual_msg: int)
{

  anon0:
    yogi_error := 1;
    return;
}



procedure {:origName "SLIC_EXIT_ROUTINE"} SLIC_EXIT_ROUTINE(actual_msg_1: int);
  free ensures false;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "SLIC_EXIT_ROUTINE"} SLIC_EXIT_ROUTINE(actual_msg_1: int)
{

  anon0:
    assume false;
    return;
}



procedure {:origName "_sdv_init9"} _sdv_init9();
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init9"} _sdv_init9()
{
  var vslice_dummy_var_47: int;

  anon0:
    call {:si_unique_call 310} vslice_dummy_var_47 := __HAVOC_malloc(4);
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    return;
}



procedure {:origName "sdv_InsertTailList"} sdv_InsertTailList(actual_sdv_127: int, actual_sdv_128: int) returns (Tmp_229: int);
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_InsertTailList"} sdv_InsertTailList(actual_sdv_127: int, actual_sdv_128: int) returns (Tmp_229: int)
{
  var {:scalar} sdv_129: int;

  anon0:
    call {:si_unique_call 311} sdv_129 := __HAVOC_malloc(4);
    call {:si_unique_call 312} Tmp_229 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_229 != 0;
    assume Tmp_229 > 0;
    assume {:nonnull} sdv_129 != 0;
    assume sdv_129 > 0;
    Mem_T.INT4[Tmp_229] := Mem_T.INT4[sdv_129];
    return;
}



procedure {:origName "sdv_ExInitializeFastMutex"} {:osmodel} sdv_ExInitializeFastMutex(actual_FastMutex: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_ExInitializeFastMutex"} {:osmodel} sdv_ExInitializeFastMutex(actual_FastMutex: int)
{
  var vslice_dummy_var_48: int;

  anon0:
    call {:si_unique_call 313} vslice_dummy_var_48 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_KeAcquireSpinLockAtDpcLevel"} {:osmodel} sdv_KeAcquireSpinLockAtDpcLevel(actual_SpinLock: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous);
  free ensures sdv_irql_current == 2;
  free ensures sdv_irql_previous == old(sdv_irql_current);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_KeAcquireSpinLockAtDpcLevel"} {:osmodel} sdv_KeAcquireSpinLockAtDpcLevel(actual_SpinLock: int)
{
  var vslice_dummy_var_49: int;

  anon0:
    call {:si_unique_call 314} vslice_dummy_var_49 := __HAVOC_malloc(4);
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    return;
}



procedure {:origName "sdv_IoCopyCurrentIrpStackLocationToNext"} {:osmodel} sdv_IoCopyCurrentIrpStackLocationToNext(actual_pirp: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoCopyCurrentIrpStackLocationToNext"} {:osmodel} sdv_IoCopyCurrentIrpStackLocationToNext(actual_pirp: int)
{
  var {:pointer} pirp: int;
  var vslice_dummy_var_50: int;

  anon0:
    call {:si_unique_call 315} vslice_dummy_var_50 := __HAVOC_malloc(4);
    pirp := actual_pirp;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} pirp == sdv_harnessIrp;
    goto L4;

  L4:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} pirp == sdv_other_harnessIrp;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} pirp != sdv_other_harnessIrp;
    goto L1;

  anon5_Then:
    assume {:partition} pirp != sdv_harnessIrp;
    goto L4;
}



procedure {:origName "sdv_containing_record"} {:osmodel} sdv_containing_record(actual_Address: int, actual_FieldOffset: int) returns (Tmp_239: int);
  free ensures Tmp_239 == actual_Address;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_containing_record"} {:osmodel} sdv_containing_record(actual_Address: int, actual_FieldOffset: int) returns (Tmp_239: int)
{
  var {:pointer} record: int;
  var {:pointer} Address: int;

  anon0:
    Address := actual_Address;
    record := Address;
    Tmp_239 := record;
    return;
}



procedure {:origName "sdv_KeAcquireSpinLock"} {:osmodel} sdv_KeAcquireSpinLock(actual_SpinLock_1: int, actual_p: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4;
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous);
  free ensures sdv_irql_current == 2;
  free ensures sdv_irql_previous == old(sdv_irql_current);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_KeAcquireSpinLock"} {:osmodel} sdv_KeAcquireSpinLock(actual_SpinLock_1: int, actual_p: int)
{
  var {:pointer} p: int;
  var vslice_dummy_var_51: int;

  anon0:
    call {:si_unique_call 316} vslice_dummy_var_51 := __HAVOC_malloc(4);
    p := actual_p;
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    assume {:nonnull} p != 0;
    assume p > 0;
    Mem_T.INT4[p] := sdv_irql_previous;
    return;
}



procedure {:origName "sdv_RunAddDevice"} {:osmodel} sdv_RunAddDevice(actual_p1: int, actual_p2: int) returns (Tmp_243: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures Tmp_243 == -1073741824 || Tmp_243 == -1073741771 || Tmp_243 == -1073741670 || Tmp_243 == -1073741823 || Tmp_243 == 0 || Tmp_243 == -1073741808 || Tmp_243 == -1073741810 || Tmp_243 == -1073741811;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RunAddDevice"} {:osmodel} sdv_RunAddDevice(actual_p1: int, actual_p2: int) returns (Tmp_243: int)
{
  var {:scalar} status: int;
  var {:pointer} p1: int;
  var {:pointer} p2: int;

  anon0:
    p1 := actual_p1;
    p2 := actual_p2;
    status := 0;
    call {:si_unique_call 317} sdv_stub_add_begin();
    call {:si_unique_call 318} status := Avc_PnpAddDevice(p1, p2);
    call {:si_unique_call 319} sdv_stub_add_end();
    Tmp_243 := status;
    return;
}



procedure {:origName "KeSetTimer"} {:osmodel} KeSetTimer(actual_Timer: int, actual_structPtr888DueTime: int, actual_Dpc: int) returns (Tmp_245: int);
  modifies alloc;
  free ensures Tmp_245 == 1 || Tmp_245 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "KeSetTimer"} {:osmodel} KeSetTimer(actual_Timer: int, actual_structPtr888DueTime: int, actual_Dpc: int) returns (Tmp_245: int)
{
  var {:scalar} DueTime: int;
  var {:pointer} structPtr888DueTime: int;

  anon0:
    call {:si_unique_call 320} DueTime := __HAVOC_malloc(20);
    structPtr888DueTime := actual_structPtr888DueTime;
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_245 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_245 := 0;
    goto L1;
}



procedure {:origName "sdv_KeReleaseSpinLockFromDpcLevel"} {:osmodel} sdv_KeReleaseSpinLockFromDpcLevel(actual_SpinLock_2: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4;
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_3);
  free ensures sdv_irql_current == old(sdv_irql_previous);
  free ensures sdv_irql_previous == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_4);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_KeReleaseSpinLockFromDpcLevel"} {:osmodel} sdv_KeReleaseSpinLockFromDpcLevel(actual_SpinLock_2: int)
{
  var vslice_dummy_var_52: int;

  anon0:
    call {:si_unique_call 321} vslice_dummy_var_52 := __HAVOC_malloc(4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    return;
}



procedure {:origName "sdv_IoGetNextIrpStackLocation"} {:osmodel} sdv_IoGetNextIrpStackLocation(actual_pirp_1: int) returns (Tmp_249: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoGetNextIrpStackLocation"} {:osmodel} sdv_IoGetNextIrpStackLocation(actual_pirp_1: int) returns (Tmp_249: int)
{
  var {:pointer} pirp_1: int;

  anon0:
    pirp_1 := actual_pirp_1;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} pirp_1 == sdv_harnessIrp;
    Tmp_249 := sdv_harnessStackLocation_next;
    goto L1;

  L1:
    return;

  anon5_Then:
    assume {:partition} pirp_1 != sdv_harnessIrp;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} pirp_1 == sdv_other_harnessIrp;
    Tmp_249 := sdv_other_harnessStackLocation_next;
    goto L1;

  anon6_Then:
    assume {:partition} pirp_1 != sdv_other_harnessIrp;
    Tmp_249 := sdv_harnessStackLocation;
    goto L1;
}



procedure {:origName "IoCreateDevice"} {:osmodel} IoCreateDevice(actual_DriverObject_2: int, actual_DeviceExtensionSize: int, actual_DeviceName: int, actual_DeviceType: int, actual_DeviceCharacteristics: int, actual_Exclusive: int, actual_DeviceObject_11: int) returns (Tmp_251: int);
  free ensures Tmp_251 == -1073741824 || Tmp_251 == -1073741771 || Tmp_251 == -1073741670 || Tmp_251 == -1073741823 || Tmp_251 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoCreateDevice"} {:osmodel} IoCreateDevice(actual_DriverObject_2: int, actual_DeviceExtensionSize: int, actual_DeviceName: int, actual_DeviceType: int, actual_DeviceCharacteristics: int, actual_Exclusive: int, actual_DeviceObject_11: int) returns (Tmp_251: int)
{
  var {:pointer} DeviceObject_11: int;

  anon0:
    DeviceObject_11 := actual_DeviceObject_11;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    goto anon14_Then, anon14_Else;

  anon14_Else:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:nonnull} DeviceObject_11 != 0;
    assume DeviceObject_11 > 0;
    Tmp_251 := -1073741824;
    goto L1;

  L1:
    return;

  anon12_Then:
    assume {:nonnull} DeviceObject_11 != 0;
    assume DeviceObject_11 > 0;
    Tmp_251 := -1073741771;
    goto L1;

  anon13_Then:
    assume {:nonnull} DeviceObject_11 != 0;
    assume DeviceObject_11 > 0;
    Tmp_251 := -1073741670;
    goto L1;

  anon14_Then:
    assume {:nonnull} DeviceObject_11 != 0;
    assume DeviceObject_11 > 0;
    Tmp_251 := -1073741823;
    goto L1;

  anon15_Then:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:nonnull} sdv_p_devobj_fdo != 0;
    assume sdv_p_devobj_fdo > 0;
    assume {:nonnull} DeviceObject_11 != 0;
    assume DeviceObject_11 > 0;
    goto L21;

  L21:
    Tmp_251 := 0;
    goto L1;

  anon11_Then:
    assume {:nonnull} sdv_p_devobj_child_pdo != 0;
    assume sdv_p_devobj_child_pdo > 0;
    assume {:nonnull} DeviceObject_11 != 0;
    assume DeviceObject_11 > 0;
    goto L21;
}



procedure {:origName "IoDetachDevice"} {:osmodel} IoDetachDevice(actual_TargetDevice: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoDetachDevice"} {:osmodel} IoDetachDevice(actual_TargetDevice: int)
{
  var vslice_dummy_var_53: int;

  anon0:
    call {:si_unique_call 322} vslice_dummy_var_53 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_ExInitializeNPagedLookasideList_NXPoolOptIn"} {:osmodel} sdv_ExInitializeNPagedLookasideList_NXPoolOptIn(actual_Lookaside: int, actual_Allocate: int, actual_Free: int, actual_Flags: int, actual_Size: int, actual_Tag: int, actual_Depth: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_ExInitializeNPagedLookasideList_NXPoolOptIn"} {:osmodel} sdv_ExInitializeNPagedLookasideList_NXPoolOptIn(actual_Lookaside: int, actual_Allocate: int, actual_Free: int, actual_Flags: int, actual_Size: int, actual_Tag: int, actual_Depth: int)
{
  var vslice_dummy_var_54: int;

  anon0:
    call {:si_unique_call 323} vslice_dummy_var_54 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_IoSetCancelRoutine"} {:osmodel} sdv_IoSetCancelRoutine(actual_pirp_2: int, actual_CancelRoutine: int) returns (Tmp_257: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoSetCancelRoutine"} {:osmodel} sdv_IoSetCancelRoutine(actual_pirp_2: int, actual_CancelRoutine: int) returns (Tmp_257: int)
{
  var {:scalar} r: int;
  var {:pointer} pirp_2: int;
  var {:scalar} CancelRoutine: int;

  anon0:
    pirp_2 := actual_pirp_2;
    CancelRoutine := actual_CancelRoutine;
    assume {:nonnull} pirp_2 != 0;
    assume pirp_2 > 0;
    havoc r;
    assume {:nonnull} pirp_2 != 0;
    assume pirp_2 > 0;
    Tmp_257 := r;
    return;
}



procedure {:origName "sdv_stub_dispatch_end"} {:osmodel} sdv_stub_dispatch_end(actual_s: int, actual_pirp_3: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_stub_dispatch_end"} {:osmodel} sdv_stub_dispatch_end(actual_s: int, actual_pirp_3: int)
{
  var vslice_dummy_var_55: int;

  anon0:
    call {:si_unique_call 324} vslice_dummy_var_55 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_RtlQueryRegistryValues"} {:osmodel} sdv_RtlQueryRegistryValues(actual_RelativeTo: int, actual_Path: int, actual_QueryTable: int, actual_Context_2: int, actual_Environment: int) returns (Tmp_261: int);
  free ensures Tmp_261 == 0 || Tmp_261 == -1073741823;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RtlQueryRegistryValues"} {:osmodel} sdv_RtlQueryRegistryValues(actual_RelativeTo: int, actual_Path: int, actual_QueryTable: int, actual_Context_2: int, actual_Environment: int) returns (Tmp_261: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_261 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_261 := -1073741823;
    goto L1;
}



procedure {:origName "sdv_SetStatus"} {:osmodel} sdv_SetStatus(actual_pirp_4: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_SetStatus"} {:osmodel} sdv_SetStatus(actual_pirp_4: int)
{
  var {:pointer} pirp_4: int;
  var vslice_dummy_var_56: int;

  anon0:
    call {:si_unique_call 325} vslice_dummy_var_56 := __HAVOC_malloc(4);
    pirp_4 := actual_pirp_4;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} pirp_4 != 0;
    assume pirp_4 > 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} pirp_4 != 0;
    assume pirp_4 > 0;
    goto L1;
}



procedure {:origName "KeDelayExecutionThread"} {:osmodel} KeDelayExecutionThread(actual_WaitMode: int, actual_Alertable: int, actual_Interval: int) returns (Tmp_265: int);
  free ensures Tmp_265 == 0 || Tmp_265 == -1073741823;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "KeDelayExecutionThread"} {:osmodel} KeDelayExecutionThread(actual_WaitMode: int, actual_Alertable: int, actual_Interval: int) returns (Tmp_265: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_265 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_265 := -1073741823;
    goto L1;
}



procedure {:nohoudini} {:origName "sdv_main"} {:osmodel} sdv_main();
  modifies alloc, SLAM_guard_S_0, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_main"} {:osmodel} sdv_main()
{
  var {:scalar} u: int;
  var vslice_dummy_var_57: int;
  var vslice_dummy_var_58: int;
  var vslice_dummy_var_59: int;
  var vslice_dummy_var_60: int;
  var vslice_dummy_var_61: int;

  anon0:
    call {:si_unique_call 326} u := __HAVOC_malloc(12);
    call {:si_unique_call 327} vslice_dummy_var_57 := __HAVOC_malloc(4);
    SLAM_guard_S_0 := sdv_irp;
    assume SLAM_guard_S_0 != 0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    goto anon19_Then, anon19_Else;

  anon19_Else:
    goto anon18_Then, anon18_Else;

  anon18_Else:
    goto anon17_Then, anon17_Else;

  anon17_Else:
    goto anon16_Then, anon16_Else;

  anon16_Else:
    call {:si_unique_call 328} sdv_RunUnload(sdv_driver_object);
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon16_Then:
    goto L1;

  anon17_Then:
    call {:si_unique_call 329} sdv_stub_driver_init();
    call {:si_unique_call 330} vslice_dummy_var_59 := sdv_RunStartDevice(sdv_p_devobj_fdo, sdv_irp);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} yogi_error != 1;
    goto L1;

  anon21_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon18_Then:
    call {:si_unique_call 331} vslice_dummy_var_58 := sdv_RunAddDevice(sdv_driver_object, sdv_p_devobj_pdo);
    goto L1;

  anon19_Then:
    call {:si_unique_call 332} vslice_dummy_var_61 := DriverEntry(sdv_driver_object, u);
    goto L1;

  anon15_Then:
    call {:si_unique_call 333} sdv_stub_driver_init();
    call {:si_unique_call 334} vslice_dummy_var_60 := sdv_RunDispatchFunction(sdv_p_devobj_fdo, sdv_irp);
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} yogi_error != 1;
    goto L1;

  anon20_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "PoSetPowerState"} {:osmodel} PoSetPowerState(actual_DeviceObject_12: int, actual_Type: int, actual_structPtr888State: int) returns (structPtr888Tmp: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "PoSetPowerState"} {:osmodel} PoSetPowerState(actual_DeviceObject_12: int, actual_Type: int, actual_structPtr888State: int) returns (structPtr888Tmp: int)
{
  var {:scalar} State: int;
  var {:scalar} r_1: int;
  var {:scalar} Tmp: int;
  var {:pointer} structPtr888State: int;

  anon0:
    call {:si_unique_call 335} State := __HAVOC_malloc(8);
    call {:si_unique_call 336} r_1 := __HAVOC_malloc(8);
    call {:si_unique_call 337} Tmp := __HAVOC_malloc(8);
    structPtr888State := actual_structPtr888State;
    assume {:nonnull} State != 0;
    assume State > 0;
    assume {:nonnull} structPtr888State != 0;
    assume structPtr888State > 0;
    assume {:nonnull} State != 0;
    assume State > 0;
    assume {:nonnull} structPtr888State != 0;
    assume structPtr888State > 0;
    assume {:nonnull} Tmp != 0;
    assume Tmp > 0;
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    assume {:nonnull} Tmp != 0;
    assume Tmp > 0;
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    structPtr888Tmp := Tmp;
    return;
}



procedure {:origName "KeCancelTimer"} {:osmodel} KeCancelTimer(actual_Timer_1: int) returns (Tmp_270: int);
  free ensures Tmp_270 == 1 || Tmp_270 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "KeCancelTimer"} {:osmodel} KeCancelTimer(actual_Timer_1: int) returns (Tmp_270: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_270 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_270 := 0;
    goto L1;
}



procedure {:origName "sdv_IoSetCompletionRoutine"} {:osmodel} sdv_IoSetCompletionRoutine(actual_pirp_5: int, actual_CompletionRoutine: int, actual_Context_3: int, actual_InvokeOnSuccess: int, actual_InvokeOnError: int, actual_InvokeOnCancel: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoSetCompletionRoutine"} {:osmodel} sdv_IoSetCompletionRoutine(actual_pirp_5: int, actual_CompletionRoutine: int, actual_Context_3: int, actual_InvokeOnSuccess: int, actual_InvokeOnError: int, actual_InvokeOnCancel: int)
{
  var {:pointer} irpSp: int;
  var {:pointer} pirp_5: int;
  var {:scalar} CompletionRoutine: int;
  var {:pointer} Context_3: int;
  var {:scalar} InvokeOnSuccess: int;
  var {:scalar} InvokeOnError: int;
  var {:scalar} InvokeOnCancel: int;
  var vslice_dummy_var_62: int;

  anon0:
    call {:si_unique_call 338} vslice_dummy_var_62 := __HAVOC_malloc(4);
    pirp_5 := actual_pirp_5;
    CompletionRoutine := actual_CompletionRoutine;
    Context_3 := actual_Context_3;
    InvokeOnSuccess := actual_InvokeOnSuccess;
    InvokeOnError := actual_InvokeOnError;
    InvokeOnCancel := actual_InvokeOnCancel;
    call {:si_unique_call 339} irpSp := sdv_IoGetNextIrpStackLocation(pirp_5);
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    return;
}



procedure {:origName "ExAcquireFastMutex"} {:osmodel} ExAcquireFastMutex(actual_FastMutex_1: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous);
  free ensures sdv_irql_current == 1;
  free ensures sdv_irql_previous == old(sdv_irql_current);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "ExAcquireFastMutex"} {:osmodel} ExAcquireFastMutex(actual_FastMutex_1: int)
{
  var vslice_dummy_var_63: int;

  anon0:
    call {:si_unique_call 340} vslice_dummy_var_63 := __HAVOC_malloc(4);
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 1;
    return;
}



procedure {:origName "sdv_stub_add_begin"} {:osmodel} sdv_stub_add_begin();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_stub_add_begin"} {:osmodel} sdv_stub_add_begin()
{
  var vslice_dummy_var_64: int;

  anon0:
    call {:si_unique_call 341} vslice_dummy_var_64 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_RemoveEntryList"} {:osmodel} sdv_RemoveEntryList(actual_Entry_7: int) returns (Tmp_278: int);
  free ensures Tmp_278 == 1 || Tmp_278 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RemoveEntryList"} {:osmodel} sdv_RemoveEntryList(actual_Entry_7: int) returns (Tmp_278: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_278 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_278 := 0;
    goto L1;
}



procedure {:origName "PoStartNextPowerIrp"} {:osmodel} PoStartNextPowerIrp(actual_Irp_14: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "PoStartNextPowerIrp"} {:osmodel} PoStartNextPowerIrp(actual_Irp_14: int)
{
  var vslice_dummy_var_65: int;

  anon0:
    call {:si_unique_call 342} vslice_dummy_var_65 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KeWaitForSingleObject"} {:osmodel} KeWaitForSingleObject(actual_Object: int, actual_WaitReason: int, actual_WaitMode_1: int, actual_Alertable_1: int, actual_Timeout: int) returns (Tmp_282: int);
  free ensures Tmp_282 == 258 || Tmp_282 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "KeWaitForSingleObject"} {:osmodel} KeWaitForSingleObject(actual_Object: int, actual_WaitReason: int, actual_WaitMode_1: int, actual_Alertable_1: int, actual_Timeout: int) returns (Tmp_282: int)
{
  var {:pointer} Timeout: int;

  anon0:
    Timeout := actual_Timeout;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} Timeout != 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    Tmp_282 := 258;
    goto L1;

  L1:
    return;

  anon6_Then:
    Tmp_282 := 0;
    goto L1;

  anon5_Then:
    assume {:partition} Timeout == 0;
    Tmp_282 := 0;
    goto L1;
}



procedure {:origName "IoDeleteDevice"} {:osmodel} IoDeleteDevice(actual_DeviceObject_13: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoDeleteDevice"} {:osmodel} IoDeleteDevice(actual_DeviceObject_13: int)
{
  var vslice_dummy_var_66: int;

  anon0:
    call {:si_unique_call 343} vslice_dummy_var_66 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KeSetEvent"} {:osmodel} KeSetEvent(actual_Event_4: int, actual_Increment: int, actual_Wait: int) returns (Tmp_286: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "KeSetEvent"} {:osmodel} KeSetEvent(actual_Event_4: int, actual_Increment: int, actual_Wait: int) returns (Tmp_286: int)
{
  var {:scalar} OldState: int;
  var {:pointer} Event_4: int;

  anon0:
    Event_4 := actual_Event_4;
    assume {:nonnull} Event_4 != 0;
    assume Event_4 > 0;
    havoc OldState;
    assume {:nonnull} Event_4 != 0;
    assume Event_4 > 0;
    Tmp_286 := OldState;
    return;
}



procedure {:origName "sdv_IoGetCurrentIrpStackLocation"} {:osmodel} sdv_IoGetCurrentIrpStackLocation(actual_pirp_6: int) returns (Tmp_290: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoGetCurrentIrpStackLocation"} {:osmodel} sdv_IoGetCurrentIrpStackLocation(actual_pirp_6: int) returns (Tmp_290: int)
{
  var {:pointer} pirp_6: int;

  anon0:
    pirp_6 := actual_pirp_6;
    assume {:nonnull} pirp_6 != 0;
    assume pirp_6 > 0;
    havoc Tmp_290;
    return;
}



procedure {:origName "sdv_InitializeObjectAttributes"} {:osmodel} sdv_InitializeObjectAttributes(actual_p_1: int, actual_n: int, actual_a: int, actual_r_2: int, actual_s_1: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_InitializeObjectAttributes"} {:osmodel} sdv_InitializeObjectAttributes(actual_p_1: int, actual_n: int, actual_a: int, actual_r_2: int, actual_s_1: int)
{
  var vslice_dummy_var_67: int;

  anon0:
    call {:si_unique_call 344} vslice_dummy_var_67 := __HAVOC_malloc(4);
    return;
}



procedure {:nohoudini} {:origName "main"} {:osmodel} {:entrypoint} main() returns (Tmp_294: int, dup_assertVar: bool);
  modifies alloc, SLAM_guard_S_0, yogi_error, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5;
  free ensures yogi_error == 1 || yogi_error == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "main"} {:osmodel} main() returns (Tmp_294: int, dup_assertVar: bool)
{
  var {:scalar} Tmp_296: int;
  var {:scalar} Tmp_297: int;
  var boogieTmp: int;
  var KsDstPinDescriptor__Loc: int;
  var BUS1394_CLASS_GUID__Loc: int;
  var GUID_61883_CLASS__Loc: int;
  var KsSrcPinDescriptor__Loc: int;
  var GUID_VIRTUAL_AVC_CLASS__Loc: int;
  var GUID_AVC_CLASS__Loc: int;
  var GUID_PCMCIA_BUS_INTERFACE_STANDARD__Loc: int;
  var GUID_BUS_TYPE_PCMCIA__Loc: int;
  var GUID_TRANSLATOR_INTERFACE_STANDARD__Loc: int;
  var GUID_PCI_VIRTUALIZATION_INTERFACE__Loc: int;
  var GUID_ARBITER_INTERFACE_STANDARD__Loc: int;
  var GUID_QUERY_CRASHDUMP_FUNCTIONS__Loc: int;
  var GUID_ACPI_CMOS_INTERFACE_STANDARD__Loc: int;
  var AvcPeerInstanceList__Loc: int;
  var GUID_BUS_TYPE_1394__Loc: int;
  var GUID_AGP_TARGET_BUS_INTERFACE_STANDARD__Loc: int;
  var GUID_TARGET_DEVICE_REMOVE_CANCELLED__Loc: int;
  var GUID_BUS_TYPE_ISAPNP__Loc: int;
  var AvcAlternateOpcodePool__Loc: int;
  var GUID_MF_ENUMERATION_INTERFACE__Loc: int;
  var GUID_LEGACY_DEVICE_DETECTION_STANDARD__Loc: int;
  var GUID_PCC_INTERFACE_STANDARD__Loc: int;
  var GUID_BUS_INTERFACE_STANDARD__Loc: int;
  var GUID_PNP_POWER_SETTING_CHANGE__Loc: int;
  var GUID_BUS_TYPE_ACPI__Loc: int;
  var GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE__Loc: int;
  var GUID_BUS_TYPE_DOT4PRT__Loc: int;
  var GUID_BUS_TYPE_EISA__Loc: int;
  var AvcQueryTablePool__Loc: int;
  var GUID_ACPI_REGS_INTERFACE_STANDARD__Loc: int;
  var GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED__Loc: int;
  var GUID_ACPI_INTERFACE_STANDARD2__Loc: int;
  var GUID_PARTITION_UNIT_INTERFACE_STANDARD__Loc: int;
  var GUID_BUS_TYPE_IRDA__Loc: int;
  var AvcVirtualInstanceList__Loc: int;
  var GUID_PCI_BUS_INTERFACE_STANDARD2__Loc: int;
  var GUID_WUDF_DEVICE_HOST_PROBLEM__Loc: int;
  var GUID_DEVICE_INTERFACE_REMOVAL__Loc: int;
  var GUID_BUS_TYPE_SERENUM__Loc: int;
  var GUID_PCI_DEVICE_PRESENT_INTERFACE__Loc: int;
  var GUID_BUS_TYPE_MCA__Loc: int;
  var GUID_POWER_DEVICE_TIMEOUTS__Loc: int;
  var GUID_THERMAL_COOLING_INTERFACE__Loc: int;
  var AvcFcpPool__Loc: int;
  var GUID_HWPROFILE_CHANGE_CANCELLED__Loc: int;
  var GUID_PNP_LOCATION_INTERFACE__Loc: int;
  var GUID_MSIX_TABLE_CONFIG_INTERFACE__Loc: int;
  var GUID_BUS_TYPE_INTERNAL__Loc: int;
  var GUID_BUS_TYPE_LPTENUM__Loc: int;
  var GUID_HWPROFILE_CHANGE_COMPLETE__Loc: int;
  var GUID_DEVICE_INTERFACE_ARRIVAL__Loc: int;
  var GUID_BUS_TYPE_AVC__Loc: int;
  var GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD__Loc: int;
  var GUID_BUS_TYPE_USB__Loc: int;
  var AvcCommandContextPool__Loc: int;
  var GUID_INT_ROUTE_INTERFACE_STANDARD__Loc: int;
  var GUID_PROCESSOR_PCC_INTERFACE_STANDARD__Loc: int;
  var GUID_BUS_TYPE_USBPRINT__Loc: int;
  var GUID_BUS_TYPE_PCI__Loc: int;
  var GUID_TARGET_DEVICE_QUERY_REMOVE__Loc: int;
  var GUID_PCI_BUS_INTERFACE_STANDARD__Loc: int;
  var GUID_HWPROFILE_QUERY_CHANGE__Loc: int;
  var GUID_BUS_TYPE_SW_DEVICE__Loc: int;
  var AvcCommandLinkPool__Loc: int;
  var GUID_POWER_DEVICE_ENABLE__Loc: int;
  var GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE__Loc: int;
  var GUID_PNP_CUSTOM_NOTIFICATION__Loc: int;
  var GUID_BUS_TYPE_SD__Loc: int;
  var GUID_PNP_POWER_NOTIFICATION__Loc: int;
  var GUID_PCC_INTERFACE_INTERNAL__Loc: int;
  var GUID_D3COLD_SUPPORT_INTERFACE__Loc: int;
  var GUID_REENUMERATE_SELF_INTERFACE_STANDARD__Loc: int;
  var GUID_BUS_TYPE_HID__Loc: int;
  var GUID_TARGET_DEVICE_REMOVE_COMPLETE__Loc: int;
  var GUID_ACPI_INTERFACE_STANDARD__Loc: int;
  var GUID_POWER_DEVICE_WAKE_ENABLE__Loc: int;
  var SLAM_guard_S_0_init__Loc: int;
  var sdv_harnessStackLocation_next__Loc: int;
  var sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc: int;
  var WHEA_ERROR_PACKET_SECTION_GUID__Loc: int;
  var sdv_IoBuildAsynchronousFsdRequest_harnessIrp__Loc: int;
  var sdv_IoGetDeviceToVerify_DEVICE_OBJECT__Loc: int;
  var sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next__Loc: int;
  var sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock__Loc: int;
  var sdv_ControllerIrp__Loc: int;
  var sdv_devobj_pdo__Loc: int;
  var sdv_IoGetDmaAdapter_DMA_ADAPTER__Loc: int;
  var sdv_IoInitializeIrp_harnessIrp__Loc: int;
  var sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT__Loc: int;
  var sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next__Loc: int;
  var sdv_IoCreateSynchronizationEvent_KEVENT__Loc: int;
  var sdv_harnessStackLocation__Loc: int;
  var sdv_other_harnessStackLocation_next__Loc: int;
  var sdv_IoCreateController_CONTROLLER_OBJECT__Loc: int;
  var sdv_devobj_top__Loc: int;
  var sdv_kdpc_val3__Loc: int;
  var sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc: int;
  var sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc: int;
  var sdv_driver_object__Loc: int;
  var sdv_MapRegisterBase_val__Loc: int;
  var sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING__Loc: int;
  var sdv_IoMakeAssociatedIrp_harnessIrp__Loc: int;
  var sdv_devobj_child_pdo__Loc: int;
  var sdv_harnessIrp__Loc: int;
  var sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next__Loc: int;
  var sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock__Loc: int;
  var sdv_kinterrupt_val__Loc: int;
  var sdv_fx_dev_object__Loc: int;
  var sdv_devobj_fdo__Loc: int;
  var sdv_StartIoIrp__Loc: int;
  var sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc: int;
  var sdv_PowerIrp__Loc: int;
  var sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc: int;
  var sdv_other_harnessIrp__Loc: int;
  var sdv_IoCreateNotificationEvent_KEVENT__Loc: int;
  var sdv_other_harnessStackLocation__Loc: int;
  var vslice_dummy_var_281: int;
  var vslice_dummy_var_282: int;
  var vslice_dummy_var_283: int;
  var vslice_dummy_var_284: int;
  var vslice_dummy_var_27: int;

  anon0:
    dup_assertVar := true;
    assume alloc > 0;
    call {:si_unique_call 345} KsDstPinDescriptor__Loc := __HAVOC_malloc_or_null(52);
    assume KsDstPinDescriptor__Loc == KsDstPinDescriptor;
    assume KsDstPinDescriptor != 0;
    call {:si_unique_call 346} BUS1394_CLASS_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume BUS1394_CLASS_GUID__Loc == BUS1394_CLASS_GUID;
    assume BUS1394_CLASS_GUID != 0;
    call {:si_unique_call 347} GUID_61883_CLASS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_61883_CLASS__Loc == GUID_61883_CLASS;
    assume GUID_61883_CLASS != 0;
    call {:si_unique_call 348} KsSrcPinDescriptor__Loc := __HAVOC_malloc_or_null(52);
    assume KsSrcPinDescriptor__Loc == KsSrcPinDescriptor;
    assume KsSrcPinDescriptor != 0;
    call {:si_unique_call 349} GUID_VIRTUAL_AVC_CLASS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIRTUAL_AVC_CLASS__Loc == GUID_VIRTUAL_AVC_CLASS;
    assume GUID_VIRTUAL_AVC_CLASS != 0;
    call {:si_unique_call 350} GUID_AVC_CLASS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_AVC_CLASS__Loc == GUID_AVC_CLASS;
    assume GUID_AVC_CLASS != 0;
    call {:si_unique_call 351} GUID_PCMCIA_BUS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCMCIA_BUS_INTERFACE_STANDARD__Loc == GUID_PCMCIA_BUS_INTERFACE_STANDARD;
    assume GUID_PCMCIA_BUS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 352} GUID_BUS_TYPE_PCMCIA__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_PCMCIA__Loc == GUID_BUS_TYPE_PCMCIA;
    assume GUID_BUS_TYPE_PCMCIA != 0;
    call {:si_unique_call 353} GUID_TRANSLATOR_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TRANSLATOR_INTERFACE_STANDARD__Loc == GUID_TRANSLATOR_INTERFACE_STANDARD;
    assume GUID_TRANSLATOR_INTERFACE_STANDARD != 0;
    call {:si_unique_call 354} GUID_PCI_VIRTUALIZATION_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_VIRTUALIZATION_INTERFACE__Loc == GUID_PCI_VIRTUALIZATION_INTERFACE;
    assume GUID_PCI_VIRTUALIZATION_INTERFACE != 0;
    call {:si_unique_call 355} GUID_ARBITER_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ARBITER_INTERFACE_STANDARD__Loc == GUID_ARBITER_INTERFACE_STANDARD;
    assume GUID_ARBITER_INTERFACE_STANDARD != 0;
    call {:si_unique_call 356} GUID_QUERY_CRASHDUMP_FUNCTIONS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_QUERY_CRASHDUMP_FUNCTIONS__Loc == GUID_QUERY_CRASHDUMP_FUNCTIONS;
    assume GUID_QUERY_CRASHDUMP_FUNCTIONS != 0;
    call {:si_unique_call 357} GUID_ACPI_CMOS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_CMOS_INTERFACE_STANDARD__Loc == GUID_ACPI_CMOS_INTERFACE_STANDARD;
    assume GUID_ACPI_CMOS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 358} AvcPeerInstanceList__Loc := __HAVOC_malloc_or_null(8);
    assume AvcPeerInstanceList__Loc == AvcPeerInstanceList;
    assume AvcPeerInstanceList != 0;
    call {:si_unique_call 359} GUID_BUS_TYPE_1394__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_1394__Loc == GUID_BUS_TYPE_1394;
    assume GUID_BUS_TYPE_1394 != 0;
    call {:si_unique_call 360} GUID_AGP_TARGET_BUS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_AGP_TARGET_BUS_INTERFACE_STANDARD__Loc == GUID_AGP_TARGET_BUS_INTERFACE_STANDARD;
    assume GUID_AGP_TARGET_BUS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 361} GUID_TARGET_DEVICE_REMOVE_CANCELLED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TARGET_DEVICE_REMOVE_CANCELLED__Loc == GUID_TARGET_DEVICE_REMOVE_CANCELLED;
    assume GUID_TARGET_DEVICE_REMOVE_CANCELLED != 0;
    call {:si_unique_call 362} GUID_BUS_TYPE_ISAPNP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_ISAPNP__Loc == GUID_BUS_TYPE_ISAPNP;
    assume GUID_BUS_TYPE_ISAPNP != 0;
    call {:si_unique_call 363} AvcAlternateOpcodePool__Loc := __HAVOC_malloc_or_null(108);
    assume AvcAlternateOpcodePool__Loc == AvcAlternateOpcodePool;
    assume AvcAlternateOpcodePool != 0;
    call {:si_unique_call 364} GUID_MF_ENUMERATION_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MF_ENUMERATION_INTERFACE__Loc == GUID_MF_ENUMERATION_INTERFACE;
    assume GUID_MF_ENUMERATION_INTERFACE != 0;
    call {:si_unique_call 365} GUID_LEGACY_DEVICE_DETECTION_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LEGACY_DEVICE_DETECTION_STANDARD__Loc == GUID_LEGACY_DEVICE_DETECTION_STANDARD;
    assume GUID_LEGACY_DEVICE_DETECTION_STANDARD != 0;
    call {:si_unique_call 366} GUID_PCC_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCC_INTERFACE_STANDARD__Loc == GUID_PCC_INTERFACE_STANDARD;
    assume GUID_PCC_INTERFACE_STANDARD != 0;
    call {:si_unique_call 367} GUID_BUS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_INTERFACE_STANDARD__Loc == GUID_BUS_INTERFACE_STANDARD;
    assume GUID_BUS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 368} GUID_PNP_POWER_SETTING_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PNP_POWER_SETTING_CHANGE__Loc == GUID_PNP_POWER_SETTING_CHANGE;
    assume GUID_PNP_POWER_SETTING_CHANGE != 0;
    call {:si_unique_call 369} GUID_BUS_TYPE_ACPI__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_ACPI__Loc == GUID_BUS_TYPE_ACPI;
    assume GUID_BUS_TYPE_ACPI != 0;
    call {:si_unique_call 370} GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE__Loc == GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE;
    assume GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE != 0;
    call {:si_unique_call 371} GUID_BUS_TYPE_DOT4PRT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_DOT4PRT__Loc == GUID_BUS_TYPE_DOT4PRT;
    assume GUID_BUS_TYPE_DOT4PRT != 0;
    call {:si_unique_call 372} GUID_BUS_TYPE_EISA__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_EISA__Loc == GUID_BUS_TYPE_EISA;
    assume GUID_BUS_TYPE_EISA != 0;
    call {:si_unique_call 373} AvcQueryTablePool__Loc := __HAVOC_malloc_or_null(108);
    assume AvcQueryTablePool__Loc == AvcQueryTablePool;
    assume AvcQueryTablePool != 0;
    call {:si_unique_call 374} GUID_ACPI_REGS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_REGS_INTERFACE_STANDARD__Loc == GUID_ACPI_REGS_INTERFACE_STANDARD;
    assume GUID_ACPI_REGS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 375} GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED__Loc == GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED;
    assume GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED != 0;
    call {:si_unique_call 376} GUID_ACPI_INTERFACE_STANDARD2__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_INTERFACE_STANDARD2__Loc == GUID_ACPI_INTERFACE_STANDARD2;
    assume GUID_ACPI_INTERFACE_STANDARD2 != 0;
    call {:si_unique_call 377} GUID_PARTITION_UNIT_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PARTITION_UNIT_INTERFACE_STANDARD__Loc == GUID_PARTITION_UNIT_INTERFACE_STANDARD;
    assume GUID_PARTITION_UNIT_INTERFACE_STANDARD != 0;
    call {:si_unique_call 378} GUID_BUS_TYPE_IRDA__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_IRDA__Loc == GUID_BUS_TYPE_IRDA;
    assume GUID_BUS_TYPE_IRDA != 0;
    call {:si_unique_call 379} AvcVirtualInstanceList__Loc := __HAVOC_malloc_or_null(8);
    assume AvcVirtualInstanceList__Loc == AvcVirtualInstanceList;
    assume AvcVirtualInstanceList != 0;
    call {:si_unique_call 380} GUID_PCI_BUS_INTERFACE_STANDARD2__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_BUS_INTERFACE_STANDARD2__Loc == GUID_PCI_BUS_INTERFACE_STANDARD2;
    assume GUID_PCI_BUS_INTERFACE_STANDARD2 != 0;
    call {:si_unique_call 381} GUID_WUDF_DEVICE_HOST_PROBLEM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_WUDF_DEVICE_HOST_PROBLEM__Loc == GUID_WUDF_DEVICE_HOST_PROBLEM;
    assume GUID_WUDF_DEVICE_HOST_PROBLEM != 0;
    call {:si_unique_call 382} GUID_DEVICE_INTERFACE_REMOVAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_INTERFACE_REMOVAL__Loc == GUID_DEVICE_INTERFACE_REMOVAL;
    assume GUID_DEVICE_INTERFACE_REMOVAL != 0;
    call {:si_unique_call 383} GUID_BUS_TYPE_SERENUM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_SERENUM__Loc == GUID_BUS_TYPE_SERENUM;
    assume GUID_BUS_TYPE_SERENUM != 0;
    call {:si_unique_call 384} GUID_PCI_DEVICE_PRESENT_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_DEVICE_PRESENT_INTERFACE__Loc == GUID_PCI_DEVICE_PRESENT_INTERFACE;
    assume GUID_PCI_DEVICE_PRESENT_INTERFACE != 0;
    call {:si_unique_call 385} GUID_BUS_TYPE_MCA__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_MCA__Loc == GUID_BUS_TYPE_MCA;
    assume GUID_BUS_TYPE_MCA != 0;
    call {:si_unique_call 386} GUID_POWER_DEVICE_TIMEOUTS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWER_DEVICE_TIMEOUTS__Loc == GUID_POWER_DEVICE_TIMEOUTS;
    assume GUID_POWER_DEVICE_TIMEOUTS != 0;
    call {:si_unique_call 387} GUID_THERMAL_COOLING_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_THERMAL_COOLING_INTERFACE__Loc == GUID_THERMAL_COOLING_INTERFACE;
    assume GUID_THERMAL_COOLING_INTERFACE != 0;
    call {:si_unique_call 388} AvcFcpPool__Loc := __HAVOC_malloc_or_null(108);
    assume AvcFcpPool__Loc == AvcFcpPool;
    assume AvcFcpPool != 0;
    call {:si_unique_call 389} GUID_HWPROFILE_CHANGE_CANCELLED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HWPROFILE_CHANGE_CANCELLED__Loc == GUID_HWPROFILE_CHANGE_CANCELLED;
    assume GUID_HWPROFILE_CHANGE_CANCELLED != 0;
    call {:si_unique_call 390} GUID_PNP_LOCATION_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PNP_LOCATION_INTERFACE__Loc == GUID_PNP_LOCATION_INTERFACE;
    assume GUID_PNP_LOCATION_INTERFACE != 0;
    call {:si_unique_call 391} GUID_MSIX_TABLE_CONFIG_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MSIX_TABLE_CONFIG_INTERFACE__Loc == GUID_MSIX_TABLE_CONFIG_INTERFACE;
    assume GUID_MSIX_TABLE_CONFIG_INTERFACE != 0;
    call {:si_unique_call 392} GUID_BUS_TYPE_INTERNAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_INTERNAL__Loc == GUID_BUS_TYPE_INTERNAL;
    assume GUID_BUS_TYPE_INTERNAL != 0;
    call {:si_unique_call 393} GUID_BUS_TYPE_LPTENUM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_LPTENUM__Loc == GUID_BUS_TYPE_LPTENUM;
    assume GUID_BUS_TYPE_LPTENUM != 0;
    call {:si_unique_call 394} GUID_HWPROFILE_CHANGE_COMPLETE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HWPROFILE_CHANGE_COMPLETE__Loc == GUID_HWPROFILE_CHANGE_COMPLETE;
    assume GUID_HWPROFILE_CHANGE_COMPLETE != 0;
    call {:si_unique_call 395} GUID_DEVICE_INTERFACE_ARRIVAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_INTERFACE_ARRIVAL__Loc == GUID_DEVICE_INTERFACE_ARRIVAL;
    assume GUID_DEVICE_INTERFACE_ARRIVAL != 0;
    call {:si_unique_call 396} GUID_BUS_TYPE_AVC__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_AVC__Loc == GUID_BUS_TYPE_AVC;
    assume GUID_BUS_TYPE_AVC != 0;
    call {:si_unique_call 397} GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD__Loc == GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD;
    assume GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD != 0;
    call {:si_unique_call 398} GUID_BUS_TYPE_USB__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_USB__Loc == GUID_BUS_TYPE_USB;
    assume GUID_BUS_TYPE_USB != 0;
    call {:si_unique_call 399} AvcCommandContextPool__Loc := __HAVOC_malloc_or_null(108);
    assume AvcCommandContextPool__Loc == AvcCommandContextPool;
    assume AvcCommandContextPool != 0;
    call {:si_unique_call 400} GUID_INT_ROUTE_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_INT_ROUTE_INTERFACE_STANDARD__Loc == GUID_INT_ROUTE_INTERFACE_STANDARD;
    assume GUID_INT_ROUTE_INTERFACE_STANDARD != 0;
    call {:si_unique_call 401} GUID_PROCESSOR_PCC_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PCC_INTERFACE_STANDARD__Loc == GUID_PROCESSOR_PCC_INTERFACE_STANDARD;
    assume GUID_PROCESSOR_PCC_INTERFACE_STANDARD != 0;
    call {:si_unique_call 402} GUID_BUS_TYPE_USBPRINT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_USBPRINT__Loc == GUID_BUS_TYPE_USBPRINT;
    assume GUID_BUS_TYPE_USBPRINT != 0;
    call {:si_unique_call 403} GUID_BUS_TYPE_PCI__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_PCI__Loc == GUID_BUS_TYPE_PCI;
    assume GUID_BUS_TYPE_PCI != 0;
    call {:si_unique_call 404} GUID_TARGET_DEVICE_QUERY_REMOVE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TARGET_DEVICE_QUERY_REMOVE__Loc == GUID_TARGET_DEVICE_QUERY_REMOVE;
    assume GUID_TARGET_DEVICE_QUERY_REMOVE != 0;
    call {:si_unique_call 405} GUID_PCI_BUS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_BUS_INTERFACE_STANDARD__Loc == GUID_PCI_BUS_INTERFACE_STANDARD;
    assume GUID_PCI_BUS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 406} GUID_HWPROFILE_QUERY_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HWPROFILE_QUERY_CHANGE__Loc == GUID_HWPROFILE_QUERY_CHANGE;
    assume GUID_HWPROFILE_QUERY_CHANGE != 0;
    call {:si_unique_call 407} GUID_BUS_TYPE_SW_DEVICE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_SW_DEVICE__Loc == GUID_BUS_TYPE_SW_DEVICE;
    assume GUID_BUS_TYPE_SW_DEVICE != 0;
    call {:si_unique_call 408} AvcCommandLinkPool__Loc := __HAVOC_malloc_or_null(108);
    assume AvcCommandLinkPool__Loc == AvcCommandLinkPool;
    assume AvcCommandLinkPool != 0;
    call {:si_unique_call 409} GUID_POWER_DEVICE_ENABLE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWER_DEVICE_ENABLE__Loc == GUID_POWER_DEVICE_ENABLE;
    assume GUID_POWER_DEVICE_ENABLE != 0;
    call {:si_unique_call 410} GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE__Loc == GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE;
    assume GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE != 0;
    call {:si_unique_call 411} GUID_PNP_CUSTOM_NOTIFICATION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PNP_CUSTOM_NOTIFICATION__Loc == GUID_PNP_CUSTOM_NOTIFICATION;
    assume GUID_PNP_CUSTOM_NOTIFICATION != 0;
    call {:si_unique_call 412} GUID_BUS_TYPE_SD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_SD__Loc == GUID_BUS_TYPE_SD;
    assume GUID_BUS_TYPE_SD != 0;
    call {:si_unique_call 413} GUID_PNP_POWER_NOTIFICATION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PNP_POWER_NOTIFICATION__Loc == GUID_PNP_POWER_NOTIFICATION;
    assume GUID_PNP_POWER_NOTIFICATION != 0;
    call {:si_unique_call 414} GUID_PCC_INTERFACE_INTERNAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCC_INTERFACE_INTERNAL__Loc == GUID_PCC_INTERFACE_INTERNAL;
    assume GUID_PCC_INTERFACE_INTERNAL != 0;
    call {:si_unique_call 415} GUID_D3COLD_SUPPORT_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_D3COLD_SUPPORT_INTERFACE__Loc == GUID_D3COLD_SUPPORT_INTERFACE;
    assume GUID_D3COLD_SUPPORT_INTERFACE != 0;
    call {:si_unique_call 416} GUID_REENUMERATE_SELF_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_REENUMERATE_SELF_INTERFACE_STANDARD__Loc == GUID_REENUMERATE_SELF_INTERFACE_STANDARD;
    assume GUID_REENUMERATE_SELF_INTERFACE_STANDARD != 0;
    call {:si_unique_call 417} GUID_BUS_TYPE_HID__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_HID__Loc == GUID_BUS_TYPE_HID;
    assume GUID_BUS_TYPE_HID != 0;
    call {:si_unique_call 418} GUID_TARGET_DEVICE_REMOVE_COMPLETE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TARGET_DEVICE_REMOVE_COMPLETE__Loc == GUID_TARGET_DEVICE_REMOVE_COMPLETE;
    assume GUID_TARGET_DEVICE_REMOVE_COMPLETE != 0;
    call {:si_unique_call 419} GUID_ACPI_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_INTERFACE_STANDARD__Loc == GUID_ACPI_INTERFACE_STANDARD;
    assume GUID_ACPI_INTERFACE_STANDARD != 0;
    call {:si_unique_call 420} GUID_POWER_DEVICE_WAKE_ENABLE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWER_DEVICE_WAKE_ENABLE__Loc == GUID_POWER_DEVICE_WAKE_ENABLE;
    assume GUID_POWER_DEVICE_WAKE_ENABLE != 0;
    call {:si_unique_call 421} SLAM_guard_S_0_init__Loc := __HAVOC_malloc_or_null(240);
    assume SLAM_guard_S_0_init__Loc == SLAM_guard_S_0_init;
    assume SLAM_guard_S_0_init != 0;
    call {:si_unique_call 422} sdv_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_harnessStackLocation_next__Loc == sdv_harnessStackLocation_next;
    assume sdv_harnessStackLocation_next != 0;
    call {:si_unique_call 423} sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc := __HAVOC_malloc_or_null(76);
    assume sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc == sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX;
    assume sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX != 0;
    call {:si_unique_call 424} WHEA_ERROR_PACKET_SECTION_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume WHEA_ERROR_PACKET_SECTION_GUID__Loc == WHEA_ERROR_PACKET_SECTION_GUID;
    assume WHEA_ERROR_PACKET_SECTION_GUID != 0;
    call {:si_unique_call 425} sdv_IoBuildAsynchronousFsdRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoBuildAsynchronousFsdRequest_harnessIrp__Loc == sdv_IoBuildAsynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildAsynchronousFsdRequest_harnessIrp != 0;
    call {:si_unique_call 426} sdv_IoGetDeviceToVerify_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_IoGetDeviceToVerify_DEVICE_OBJECT__Loc == sdv_IoGetDeviceToVerify_DEVICE_OBJECT;
    assume sdv_IoGetDeviceToVerify_DEVICE_OBJECT != 0;
    call {:si_unique_call 427} sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next__Loc == sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next;
    assume sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next != 0;
    call {:si_unique_call 428} sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock__Loc == sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;
    assume sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    call {:si_unique_call 429} sdv_ControllerIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_ControllerIrp__Loc == sdv_ControllerIrp;
    assume sdv_ControllerIrp != 0;
    call {:si_unique_call 430} sdv_devobj_pdo__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_pdo__Loc == sdv_devobj_pdo;
    assume sdv_devobj_pdo != 0;
    call {:si_unique_call 431} sdv_IoGetDmaAdapter_DMA_ADAPTER__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_IoGetDmaAdapter_DMA_ADAPTER__Loc == sdv_IoGetDmaAdapter_DMA_ADAPTER;
    assume sdv_IoGetDmaAdapter_DMA_ADAPTER != 0;
    call {:si_unique_call 432} sdv_IoInitializeIrp_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoInitializeIrp_harnessIrp__Loc == sdv_IoInitializeIrp_harnessIrp;
    assume sdv_IoInitializeIrp_harnessIrp != 0;
    call {:si_unique_call 433} sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT__Loc == sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT;
    assume sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT != 0;
    call {:si_unique_call 434} sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next__Loc == sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next;
    assume sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next != 0;
    call {:si_unique_call 435} sdv_IoCreateSynchronizationEvent_KEVENT__Loc := __HAVOC_malloc_or_null(156);
    assume sdv_IoCreateSynchronizationEvent_KEVENT__Loc == sdv_IoCreateSynchronizationEvent_KEVENT;
    assume sdv_IoCreateSynchronizationEvent_KEVENT != 0;
    call {:si_unique_call 436} sdv_harnessStackLocation__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_harnessStackLocation__Loc == sdv_harnessStackLocation;
    assume sdv_harnessStackLocation != 0;
    call {:si_unique_call 437} sdv_other_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_other_harnessStackLocation_next__Loc == sdv_other_harnessStackLocation_next;
    assume sdv_other_harnessStackLocation_next != 0;
    call {:si_unique_call 438} sdv_IoCreateController_CONTROLLER_OBJECT__Loc := __HAVOC_malloc_or_null(60);
    assume sdv_IoCreateController_CONTROLLER_OBJECT__Loc == sdv_IoCreateController_CONTROLLER_OBJECT;
    assume sdv_IoCreateController_CONTROLLER_OBJECT != 0;
    call {:si_unique_call 439} sdv_devobj_top__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_top__Loc == sdv_devobj_top;
    assume sdv_devobj_top != 0;
    call {:si_unique_call 440} sdv_kdpc_val3__Loc := __HAVOC_malloc_or_null(44);
    assume sdv_kdpc_val3__Loc == sdv_kdpc_val3;
    assume sdv_kdpc_val3 != 0;
    call {:si_unique_call 441} sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc == sdv_IoBuildSynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildSynchronousFsdRequest_harnessIrp != 0;
    call {:si_unique_call 442} sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc == sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT;
    assume sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT != 0;
    call {:si_unique_call 443} sdv_driver_object__Loc := __HAVOC_malloc_or_null(68);
    assume sdv_driver_object__Loc == sdv_driver_object;
    assume sdv_driver_object != 0;
    call {:si_unique_call 444} sdv_MapRegisterBase_val__Loc := __HAVOC_malloc_or_null(4);
    assume sdv_MapRegisterBase_val__Loc == sdv_MapRegisterBase_val;
    assume sdv_MapRegisterBase_val != 0;
    call {:si_unique_call 445} sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING__Loc := __HAVOC_malloc_or_null(16);
    assume sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING__Loc == sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING;
    assume sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING != 0;
    call {:si_unique_call 446} sdv_IoMakeAssociatedIrp_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoMakeAssociatedIrp_harnessIrp__Loc == sdv_IoMakeAssociatedIrp_harnessIrp;
    assume sdv_IoMakeAssociatedIrp_harnessIrp != 0;
    call {:si_unique_call 447} sdv_devobj_child_pdo__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_child_pdo__Loc == sdv_devobj_child_pdo;
    assume sdv_devobj_child_pdo != 0;
    call {:si_unique_call 448} sdv_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_harnessIrp__Loc == sdv_harnessIrp;
    assume sdv_harnessIrp != 0;
    call {:si_unique_call 449} sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next__Loc == sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next;
    assume sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next != 0;
    call {:si_unique_call 450} sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock__Loc == sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock;
    assume sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    call {:si_unique_call 451} sdv_kinterrupt_val__Loc := __HAVOC_malloc_or_null(0);
    assume sdv_kinterrupt_val__Loc == sdv_kinterrupt_val;
    assume sdv_kinterrupt_val != 0;
    call {:si_unique_call 452} sdv_fx_dev_object__Loc := __HAVOC_malloc_or_null(40);
    assume sdv_fx_dev_object__Loc == sdv_fx_dev_object;
    assume sdv_fx_dev_object != 0;
    call {:si_unique_call 453} sdv_devobj_fdo__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_fdo__Loc == sdv_devobj_fdo;
    assume sdv_devobj_fdo != 0;
    call {:si_unique_call 454} sdv_StartIoIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_StartIoIrp__Loc == sdv_StartIoIrp;
    assume sdv_StartIoIrp != 0;
    call {:si_unique_call 455} sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc == sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;
    assume sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    call {:si_unique_call 456} sdv_PowerIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_PowerIrp__Loc == sdv_PowerIrp;
    assume sdv_PowerIrp != 0;
    call {:si_unique_call 457} sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc == sdv_IoBuildDeviceIoControlRequest_harnessIrp;
    assume sdv_IoBuildDeviceIoControlRequest_harnessIrp != 0;
    call {:si_unique_call 458} sdv_other_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_other_harnessIrp__Loc == sdv_other_harnessIrp;
    assume sdv_other_harnessIrp != 0;
    call {:si_unique_call 459} sdv_IoCreateNotificationEvent_KEVENT__Loc := __HAVOC_malloc_or_null(156);
    assume sdv_IoCreateNotificationEvent_KEVENT__Loc == sdv_IoCreateNotificationEvent_KEVENT;
    assume sdv_IoCreateNotificationEvent_KEVENT != 0;
    call {:si_unique_call 460} sdv_other_harnessStackLocation__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_other_harnessStackLocation__Loc == sdv_other_harnessStackLocation;
    assume sdv_other_harnessStackLocation != 0;
    call {:si_unique_call 461} boogieTmp := __HAVOC_malloc_or_null(4);
    call {:si_unique_call 462} boogieTmp := __HAVOC_malloc_or_null(28);
    call {:si_unique_call 463} boogieTmp := __HAVOC_malloc_or_null(68);
    call {:si_unique_call 464} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_harnessDeviceExtension_two == boogieTmp;
    call {:si_unique_call 465} boogieTmp := __HAVOC_malloc_or_null(4);
    call {:si_unique_call 466} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_pDpcContext == boogieTmp;
    call {:si_unique_call 467} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_harnessDeviceExtension == boogieTmp;
    call {:si_unique_call 468} boogieTmp := __HAVOC_malloc_or_null(4);
    assume igdoe == boogieTmp;
    call {:si_unique_call 469} boogieTmp := __HAVOC_malloc_or_null(240);
    assume sicrni == boogieTmp;
    call {:si_unique_call 470} boogieTmp := __HAVOC_malloc_or_null(4);
    call {:si_unique_call 471} vslice_dummy_var_281 := __HAVOC_malloc(4);
    call {:si_unique_call 472} vslice_dummy_var_282 := __HAVOC_malloc(112);
    call {:si_unique_call 473} vslice_dummy_var_283 := __HAVOC_malloc(4);
    call {:si_unique_call 474} vslice_dummy_var_27 := __HAVOC_malloc(64);
    call {:si_unique_call 475} vslice_dummy_var_284 := __HAVOC_malloc(4);
    assume {:mainInitDone} true;
    call {:si_unique_call 476} corralExtraInit();
    call {:si_unique_call 477} corralExplainErrorInit();
    call {:si_unique_call 478} _sdv_init12();
    call {:si_unique_call 479} _sdv_init1();
    call {:si_unique_call 480} _sdv_init4();
    call {:si_unique_call 481} _sdv_init5();
    call {:si_unique_call 482} _sdv_init3();
    call {:si_unique_call 483} _sdv_init6();
    call {:si_unique_call 484} _sdv_init10();
    call {:si_unique_call 485} _sdv_init9();
    call {:si_unique_call 486} _sdv_init7();
    call {:si_unique_call 487} _sdv_init8();
    call {:si_unique_call 488} _sdv_init2();
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} sdv_harnessDeviceExtension == 0;
    Tmp_297 := 0;
    goto L35;

  L35:
    assume Tmp_297 != 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} sdv_harnessDeviceExtension_two == 0;
    Tmp_296 := 0;
    goto L39;

  L39:
    assume Tmp_296 != 0;
    assume {:nonnull} sdv_irp != 0;
    assume sdv_irp > 0;
    assume {:nonnull} sdv_other_irp != 0;
    assume sdv_other_irp > 0;
    call {:si_unique_call 489} sdv_main();
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} yogi_error == 1;
    goto L33;

  L33:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume yogi_error == 1;
    dup_assertVar := false;
    goto L_BAF_0, L_BAF_1;

  L_BAF_1:
    assume dup_assertVar;
    goto L_BAF_2;

  L_BAF_2:
    return;

  L_BAF_0:
    assume !dup_assertVar;
    return;

  anon11_Then:
    assume yogi_error == 0;
    goto LM2;

  LM2:
    return;

  anon12_Then:
    assume {:partition} yogi_error != 1;
    goto L33;

  anon10_Then:
    assume {:partition} sdv_harnessDeviceExtension_two != 0;
    Tmp_296 := 1;
    goto L39;

  anon9_Then:
    assume {:partition} sdv_harnessDeviceExtension != 0;
    Tmp_297 := 1;
    goto L35;
}



procedure {:origName "sdv_IoSkipCurrentIrpStackLocation"} {:osmodel} sdv_IoSkipCurrentIrpStackLocation(actual_pirp_7: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoSkipCurrentIrpStackLocation"} {:osmodel} sdv_IoSkipCurrentIrpStackLocation(actual_pirp_7: int)
{
  var {:pointer} pirp_7: int;
  var vslice_dummy_var_68: int;

  anon0:
    call {:si_unique_call 490} vslice_dummy_var_68 := __HAVOC_malloc(4);
    pirp_7 := actual_pirp_7;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} pirp_7 == sdv_harnessIrp;
    goto L4;

  L4:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} pirp_7 == sdv_other_harnessIrp;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} pirp_7 != sdv_other_harnessIrp;
    goto L1;

  anon5_Then:
    assume {:partition} pirp_7 != sdv_harnessIrp;
    goto L4;
}



procedure {:origName "IoCancelIrp"} {:osmodel} IoCancelIrp(actual_Irp_15: int) returns (Tmp_300: int);
  free ensures Tmp_300 == 0 || Tmp_300 == 1;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoCancelIrp"} {:osmodel} IoCancelIrp(actual_Irp_15: int) returns (Tmp_300: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_300 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_300 := 1;
    goto L1;
}



procedure {:origName "sdv_InterlockedDecrement"} {:osmodel} sdv_InterlockedDecrement(actual_Addend: int) returns (Tmp_302: int);
  modifies Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_InterlockedDecrement"} {:osmodel} sdv_InterlockedDecrement(actual_Addend: int) returns (Tmp_302: int)
{
  var {:pointer} Addend: int;

  anon0:
    Addend := actual_Addend;
    assume {:nonnull} Addend != 0;
    assume Addend > 0;
    Mem_T.INT4[Addend] := Mem_T.INT4[Addend] - 1;
    assume {:nonnull} Addend != 0;
    assume Addend > 0;
    Tmp_302 := Mem_T.INT4[Addend];
    return;
}



procedure {:origName "sdv_stub_add_end"} {:osmodel} sdv_stub_add_end();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_stub_add_end"} {:osmodel} sdv_stub_add_end()
{
  var vslice_dummy_var_69: int;

  anon0:
    call {:si_unique_call 491} vslice_dummy_var_69 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "RtlInitUnicodeString"} {:osmodel} RtlInitUnicodeString(actual_DestinationString: int, actual_SourceString: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RtlInitUnicodeString"} {:osmodel} RtlInitUnicodeString(actual_DestinationString: int, actual_SourceString: int)
{
  var {:pointer} DestinationString: int;
  var {:pointer} SourceString: int;
  var vslice_dummy_var_70: int;

  anon0:
    call {:si_unique_call 492} vslice_dummy_var_70 := __HAVOC_malloc(4);
    DestinationString := actual_DestinationString;
    SourceString := actual_SourceString;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} DestinationString != 0;
    assume {:nonnull} DestinationString != 0;
    assume DestinationString > 0;
    assume {:nonnull} DestinationString != 0;
    assume DestinationString > 0;
    goto L4;

  L4:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} SourceString == 0;
    assume {:nonnull} DestinationString != 0;
    assume DestinationString > 0;
    assume {:nonnull} DestinationString != 0;
    assume DestinationString > 0;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} SourceString != 0;
    goto L1;

  anon5_Then:
    assume {:partition} DestinationString == 0;
    goto L4;
}



procedure {:origName "IoGetAttachedDeviceReference"} {:osmodel} IoGetAttachedDeviceReference(actual_DeviceObject_14: int) returns (Tmp_308: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoGetAttachedDeviceReference"} {:osmodel} IoGetAttachedDeviceReference(actual_DeviceObject_14: int) returns (Tmp_308: int)
{
  var {:pointer} DeviceObject_14: int;

  anon0:
    DeviceObject_14 := actual_DeviceObject_14;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_308 := sdv_p_devobj_top;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_308 := DeviceObject_14;
    goto L1;
}



procedure {:origName "IoAttachDeviceToDeviceStack"} {:osmodel} IoAttachDeviceToDeviceStack(actual_SourceDevice: int, actual_TargetDevice_1: int) returns (Tmp_310: int);
  free ensures Tmp_310 == 0 || Tmp_310 == actual_TargetDevice_1;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoAttachDeviceToDeviceStack"} {:osmodel} IoAttachDeviceToDeviceStack(actual_SourceDevice: int, actual_TargetDevice_1: int) returns (Tmp_310: int)
{
  var {:pointer} TargetDevice_1: int;

  anon0:
    TargetDevice_1 := actual_TargetDevice_1;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} TargetDevice_1 == sdv_p_devobj_pdo;
    Tmp_310 := TargetDevice_1;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} TargetDevice_1 != sdv_p_devobj_pdo;
    Tmp_310 := 0;
    goto L1;
}



procedure {:origName "sdv_RtlZeroMemory"} {:osmodel} sdv_RtlZeroMemory(actual_Destination: int, actual_Length_2: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RtlZeroMemory"} {:osmodel} sdv_RtlZeroMemory(actual_Destination: int, actual_Length_2: int)
{
  var vslice_dummy_var_71: int;

  anon0:
    call {:si_unique_call 493} vslice_dummy_var_71 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_RunStartDevice"} {:osmodel} sdv_RunStartDevice(actual_po: int, actual_pirp_8: int) returns (Tmp_314: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RunStartDevice"} {:osmodel} sdv_RunStartDevice(actual_po: int, actual_pirp_8: int) returns (Tmp_314: int)
{
  var {:pointer} ps: int;
  var {:scalar} status_2: int;
  var {:pointer} po: int;
  var {:pointer} pirp_8: int;

  anon0:
    po := actual_po;
    pirp_8 := actual_pirp_8;
    status_2 := 0;
    assume {:nonnull} pirp_8 != 0;
    assume pirp_8 > 0;
    havoc ps;
    assume {:nonnull} ps != 0;
    assume ps > 0;
    assume {:nonnull} ps != 0;
    assume ps > 0;
    assume {:nonnull} pirp_8 != 0;
    assume pirp_8 > 0;
    assume {:nonnull} pirp_8 != 0;
    assume pirp_8 > 0;
    assume {:nonnull} pirp_8 != 0;
    assume pirp_8 > 0;
    call {:si_unique_call 494} sdv_SetStatus(pirp_8);
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 495} sdv_stub_dispatch_begin();
    call {:si_unique_call 496} status_2 := Avc_Pnp(po, pirp_8);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 497} sdv_stub_dispatch_end(status_2, 0);
    Tmp_314 := status_2;
    goto LM2;

  LM2:
    return;

  anon3_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "RtlIntegerToUnicodeString"} {:osmodel} RtlIntegerToUnicodeString(actual_Value: int, actual_Base: int, actual_String: int) returns (Tmp_316: int);
  free ensures Tmp_316 == 0 || Tmp_316 == -1073741823;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RtlIntegerToUnicodeString"} {:osmodel} RtlIntegerToUnicodeString(actual_Value: int, actual_Base: int, actual_String: int) returns (Tmp_316: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_316 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_316 := -1073741823;
    goto L1;
}



procedure {:origName "sdv_do_paged_code_check"} {:osmodel} sdv_do_paged_code_check();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_do_paged_code_check"} {:osmodel} sdv_do_paged_code_check()
{
  var vslice_dummy_var_72: int;

  anon0:
    call {:si_unique_call 498} vslice_dummy_var_72 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_IoMarkIrpPending"} {:osmodel} sdv_IoMarkIrpPending(actual_pirp_9: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoMarkIrpPending"} {:osmodel} sdv_IoMarkIrpPending(actual_pirp_9: int)
{
  var vslice_dummy_var_73: int;

  anon0:
    call {:si_unique_call 499} vslice_dummy_var_73 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_RunDispatchFunction"} {:osmodel} sdv_RunDispatchFunction(actual_po_1: int, actual_pirp_10: int) returns (Tmp_322: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RunDispatchFunction"} {:osmodel} sdv_RunDispatchFunction(actual_po_1: int, actual_pirp_10: int) returns (Tmp_322: int)
{
  var {:pointer} ps_1: int;
  var {:scalar} minor: int;
  var {:scalar} Tmp_323: int;
  var {:scalar} sdv_158: int;
  var {:scalar} Tmp_324: int;
  var {:scalar} status_3: int;
  var {:pointer} po_1: int;
  var {:pointer} pirp_10: int;

  anon0:
    po_1 := actual_po_1;
    pirp_10 := actual_pirp_10;
    status_3 := 0;
    minor := sdv_158;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    havoc ps_1;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    call {:si_unique_call 500} sdv_SetStatus(pirp_10);
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 501} sdv_stub_dispatch_begin();
    goto anon37_Then, anon37_Else;

  anon37_Else:
    goto anon51_Then, anon51_Else;

  anon51_Else:
    goto anon50_Then, anon50_Else;

  anon50_Else:
    goto anon49_Then, anon49_Else;

  anon49_Else:
    goto anon48_Then, anon48_Else;

  anon48_Else:
    goto anon47_Then, anon47_Else;

  anon47_Else:
    goto anon46_Then, anon46_Else;

  anon46_Else:
    goto anon45_Then, anon45_Else;

  anon45_Else:
    goto anon44_Then, anon44_Else;

  anon44_Else:
    goto anon43_Then, anon43_Else;

  anon43_Else:
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    goto L55;

  L55:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    goto anon41_Then, anon41_Else;

  anon41_Else:
    Tmp_323 := 0;
    goto L166;

  L166:
    assume Tmp_323 != 0;
    goto L56;

  L56:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    goto L61;

  L61:
    call {:si_unique_call 502} status_3 := Avc_Pnp(po_1, pirp_10);
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} yogi_error != 1;
    goto L67;

  L67:
    call {:si_unique_call 503} sdv_stub_dispatch_end(status_3, 0);
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    Tmp_322 := status_3;
    goto LM2;

  LM2:
    return;

  anon54_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon40_Then:
    goto L61;

  anon41_Then:
    Tmp_323 := 1;
    goto L166;

  anon39_Then:
    goto L56;

  anon53_Then:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    Tmp_324 := 0;
    goto L172;

  L172:
    assume Tmp_324 != 0;
    goto L55;

  anon38_Then:
    Tmp_324 := 1;
    goto L172;

  anon42_Then:
    call {:si_unique_call 504} status_3 := sdv_DoNothing();
    goto L67;

  anon43_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 505} status_3 := Avc_SystemControl(po_1, pirp_10);
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} yogi_error != 1;
    goto L67;

  anon52_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon44_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 506} status_3 := Avc_Cleanup(po_1, pirp_10);
    goto L67;

  anon45_Then:
    call {:si_unique_call 507} status_3 := sdv_DoNothing();
    goto L67;

  anon46_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 508} status_3 := sdv_DoNothing();
    goto L67;

  anon47_Then:
    call {:si_unique_call 509} status_3 := sdv_DoNothing();
    goto L67;

  anon48_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 510} status_3 := sdv_DoNothing();
    goto L67;

  anon49_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 511} status_3 := sdv_DoNothing();
    goto L67;

  anon50_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 512} status_3 := sdv_DoNothing();
    goto L67;

  anon51_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 513} status_3 := Avc_Close(po_1, pirp_10);
    goto L67;

  anon37_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 514} status_3 := Avc_Create(po_1, pirp_10);
    goto L67;
}



procedure {:origName "RtlFreeUnicodeString"} {:osmodel} RtlFreeUnicodeString(actual_UnicodeString: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RtlFreeUnicodeString"} {:osmodel} RtlFreeUnicodeString(actual_UnicodeString: int)
{
  var vslice_dummy_var_74: int;

  anon0:
    call {:si_unique_call 515} vslice_dummy_var_74 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoRegisterDeviceInterface"} {:osmodel} IoRegisterDeviceInterface(actual_PhysicalDeviceObject: int, actual_InterfaceClassGuid: int, actual_ReferenceString: int, actual_SymbolicLinkName: int) returns (Tmp_328: int);
  free ensures Tmp_328 == -1073741823 || Tmp_328 == -1073741808 || Tmp_328 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoRegisterDeviceInterface"} {:osmodel} IoRegisterDeviceInterface(actual_PhysicalDeviceObject: int, actual_InterfaceClassGuid: int, actual_ReferenceString: int, actual_SymbolicLinkName: int) returns (Tmp_328: int)
{
  var {:scalar} Tmp_329: int;
  var {:pointer} SymbolicLinkName: int;

  anon0:
    SymbolicLinkName := actual_SymbolicLinkName;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    goto anon9_Then, anon9_Else;

  anon9_Else:
    Tmp_328 := -1073741823;
    goto L1;

  L1:
    return;

  anon9_Then:
    Tmp_328 := -1073741808;
    goto L1;

  anon7_Then:
    assume {:nonnull} SymbolicLinkName != 0;
    assume SymbolicLinkName > 0;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    Tmp_329 := 0;
    goto L22;

  L22:
    assume Tmp_329 != 0;
    Tmp_328 := 0;
    goto L1;

  anon8_Then:
    Tmp_329 := 1;
    goto L22;
}



procedure {:origName "sdv_KeReleaseSpinLock"} {:osmodel} sdv_KeReleaseSpinLock(actual_SpinLock_3: int, actual_new: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4;
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_3);
  free ensures sdv_irql_current == actual_new;
  free ensures sdv_irql_previous == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_4);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_KeReleaseSpinLock"} {:osmodel} sdv_KeReleaseSpinLock(actual_SpinLock_3: int, actual_new: int)
{
  var {:scalar} new: int;
  var vslice_dummy_var_75: int;

  anon0:
    call {:si_unique_call 516} vslice_dummy_var_75 := __HAVOC_malloc(4);
    new := actual_new;
    sdv_irql_current := new;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    return;
}



procedure {:origName "IoReuseIrp"} {:osmodel} IoReuseIrp(actual_Irp_16: int, actual_Status_10: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoReuseIrp"} {:osmodel} IoReuseIrp(actual_Irp_16: int, actual_Status_10: int)
{
  var {:pointer} Irp_16: int;
  var {:scalar} Status_10: int;
  var vslice_dummy_var_76: int;

  anon0:
    call {:si_unique_call 517} vslice_dummy_var_76 := __HAVOC_malloc(4);
    Irp_16 := actual_Irp_16;
    Status_10 := actual_Status_10;
    assume {:nonnull} Irp_16 != 0;
    assume Irp_16 > 0;
    return;
}



procedure {:origName "sdv_IoCompleteRequest"} {:osmodel} sdv_IoCompleteRequest(actual_pirp_11: int, actual_PriorityBoost: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoCompleteRequest"} {:osmodel} sdv_IoCompleteRequest(actual_pirp_11: int, actual_PriorityBoost: int)
{
  var vslice_dummy_var_77: int;

  anon0:
    call {:si_unique_call 518} vslice_dummy_var_77 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_RtlCopyMemory"} {:osmodel} sdv_RtlCopyMemory(actual_Destination_1: int, actual_Source: int, actual_Length_3: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RtlCopyMemory"} {:osmodel} sdv_RtlCopyMemory(actual_Destination_1: int, actual_Source: int, actual_Length_3: int)
{
  var vslice_dummy_var_78: int;

  anon0:
    call {:si_unique_call 519} vslice_dummy_var_78 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "ZwQueryValueKey"} {:osmodel} ZwQueryValueKey(actual_KeyHandle: int, actual_ValueName: int, actual_KeyValueInformationClass: int, actual_KeyValueInformation: int, actual_Length_4: int, actual_ResultLength: int) returns (Tmp_339: int);
  modifies Mem_T.INT4;
  free ensures Tmp_339 == -1073741811 || Tmp_339 == -1073741823 || Tmp_339 == 0 || Tmp_339 == 5 || Tmp_339 == -1073741789;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "ZwQueryValueKey"} {:osmodel} ZwQueryValueKey(actual_KeyHandle: int, actual_ValueName: int, actual_KeyValueInformationClass: int, actual_KeyValueInformation: int, actual_Length_4: int, actual_ResultLength: int) returns (Tmp_339: int)
{
  var {:scalar} L: int;
  var {:scalar} sdv_167: int;
  var {:scalar} Length_4: int;
  var {:pointer} ResultLength: int;

  anon0:
    Length_4 := actual_Length_4;
    ResultLength := actual_ResultLength;
    L := sdv_167;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} 0 >= L;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} L == 0;
    Tmp_339 := -1073741811;
    goto L1;

  L1:
    return;

  anon12_Then:
    assume {:partition} L != 0;
    Tmp_339 := -1073741823;
    goto L1;

  anon15_Then:
    assume {:partition} L > 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} L == Length_4;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} Length_4 != 0;
    assume {:nonnull} ResultLength != 0;
    assume ResultLength > 0;
    Mem_T.INT4[ResultLength] := L;
    Tmp_339 := 0;
    goto L1;

  anon14_Then:
    assume {:partition} Length_4 == 0;
    goto L13;

  L13:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} L > Length_4;
    assume {:nonnull} ResultLength != 0;
    assume ResultLength > 0;
    Mem_T.INT4[ResultLength] := L;
    Tmp_339 := 5;
    goto L1;

  anon13_Then:
    assume {:partition} Length_4 >= L;
    assume {:nonnull} ResultLength != 0;
    assume ResultLength > 0;
    Mem_T.INT4[ResultLength] := L;
    Tmp_339 := -1073741789;
    goto L1;

  anon11_Then:
    assume {:partition} L != Length_4;
    goto L13;
}



procedure {:origName "sdv_ExFreePool"} {:osmodel} sdv_ExFreePool(actual_P: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_ExFreePool"} {:osmodel} sdv_ExFreePool(actual_P: int)
{
  var vslice_dummy_var_79: int;

  anon0:
    call {:si_unique_call 520} vslice_dummy_var_79 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_InterlockedIncrement"} {:osmodel} sdv_InterlockedIncrement(actual_Addend_1: int) returns (Tmp_345: int);
  modifies Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_InterlockedIncrement"} {:osmodel} sdv_InterlockedIncrement(actual_Addend_1: int) returns (Tmp_345: int)
{
  var {:pointer} Addend_1: int;

  anon0:
    Addend_1 := actual_Addend_1;
    assume {:nonnull} Addend_1 != 0;
    assume Addend_1 > 0;
    Mem_T.INT4[Addend_1] := Mem_T.INT4[Addend_1] + 1;
    assume {:nonnull} Addend_1 != 0;
    assume Addend_1 > 0;
    Tmp_345 := Mem_T.INT4[Addend_1];
    return;
}



procedure {:origName "ExDeleteNPagedLookasideList"} {:osmodel} ExDeleteNPagedLookasideList(actual_Lookaside_1: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "ExDeleteNPagedLookasideList"} {:osmodel} ExDeleteNPagedLookasideList(actual_Lookaside_1: int)
{
  var vslice_dummy_var_80: int;

  anon0:
    call {:si_unique_call 521} vslice_dummy_var_80 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "ExReleaseFastMutex"} {:osmodel} ExReleaseFastMutex(actual_FastMutex_2: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4;
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_3);
  free ensures sdv_irql_current == old(sdv_irql_previous);
  free ensures sdv_irql_previous == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_4);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "ExReleaseFastMutex"} {:osmodel} ExReleaseFastMutex(actual_FastMutex_2: int)
{
  var vslice_dummy_var_81: int;

  anon0:
    call {:si_unique_call 522} vslice_dummy_var_81 := __HAVOC_malloc(4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    return;
}



procedure {:origName "sdv_IsListEmpty"} {:osmodel} sdv_IsListEmpty(actual_ListHead: int) returns (Tmp_351: int);
  free ensures Tmp_351 == 1 || Tmp_351 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IsListEmpty"} {:osmodel} sdv_IsListEmpty(actual_ListHead: int) returns (Tmp_351: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_351 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_351 := 0;
    goto L1;
}



procedure {:origName "IoAllocateIrp"} {:osmodel} IoAllocateIrp(actual_StackSize: int, actual_ChargeQuota: int) returns (Tmp_353: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoAllocateIrp"} {:osmodel} IoAllocateIrp(actual_StackSize: int, actual_ChargeQuota: int) returns (Tmp_353: int)
{
  var {:pointer} irpSp_1: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} sdv_other_irp != 0;
    assume sdv_other_irp > 0;
    call {:si_unique_call 523} irpSp_1 := sdv_IoGetNextIrpStackLocation(sdv_other_irp);
    assume {:nonnull} irpSp_1 != 0;
    assume irpSp_1 > 0;
    Tmp_353 := sdv_other_irp;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_353 := 0;
    goto L1;
}



procedure {:origName "KeInitializeTimerEx"} {:osmodel} KeInitializeTimerEx(actual_Timer_2: int, actual_Type_1: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "KeInitializeTimerEx"} {:osmodel} KeInitializeTimerEx(actual_Timer_2: int, actual_Type_1: int)
{
  var vslice_dummy_var_82: int;

  anon0:
    call {:si_unique_call 524} vslice_dummy_var_82 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_ObReferenceObject"} {:osmodel} sdv_ObReferenceObject(actual_Object_1: int) returns (Tmp_359: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_ObReferenceObject"} {:osmodel} sdv_ObReferenceObject(actual_Object_1: int) returns (Tmp_359: int)
{
  var {:scalar} p_3: int;

  anon0:
    Tmp_359 := p_3;
    return;
}



procedure {:origName "ZwOpenKey"} {:osmodel} ZwOpenKey(actual_KeyHandle_1: int, actual_DesiredAccess: int, actual_ObjectAttributes: int) returns (Tmp_361: int);
  modifies alloc;
  free ensures Tmp_361 == 0 || Tmp_361 == -1073741727;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "ZwOpenKey"} {:osmodel} ZwOpenKey(actual_KeyHandle_1: int, actual_DesiredAccess: int, actual_ObjectAttributes: int) returns (Tmp_361: int)
{
  var {:pointer} sdv_178: int;
  var {:pointer} KeyHandle_1: int;

  anon0:
    KeyHandle_1 := actual_KeyHandle_1;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 525} sdv_178 := __HAVOC_malloc(4);
    assume {:nonnull} KeyHandle_1 != 0;
    assume KeyHandle_1 > 0;
    Tmp_361 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} KeyHandle_1 != 0;
    assume KeyHandle_1 > 0;
    Tmp_361 := -1073741727;
    goto L1;
}



procedure {:origName "KeInitializeEvent"} {:osmodel} KeInitializeEvent(actual_Event_5: int, actual_Type_2: int, actual_State_1: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "KeInitializeEvent"} {:osmodel} KeInitializeEvent(actual_Event_5: int, actual_Type_2: int, actual_State_1: int)
{
  var {:pointer} Event_5: int;
  var {:scalar} Type_2: int;
  var {:scalar} State_1: int;
  var vslice_dummy_var_83: int;

  anon0:
    call {:si_unique_call 526} vslice_dummy_var_83 := __HAVOC_malloc(4);
    Event_5 := actual_Event_5;
    Type_2 := actual_Type_2;
    State_1 := actual_State_1;
    assume {:nonnull} Event_5 != 0;
    assume Event_5 > 0;
    assume {:nonnull} Event_5 != 0;
    assume Event_5 > 0;
    assume {:nonnull} Event_5 != 0;
    assume Event_5 > 0;
    assume {:nonnull} Event_5 != 0;
    assume Event_5 > 0;
    return;
}



procedure {:origName "IoFreeIrp"} {:osmodel} IoFreeIrp(actual_pirp_12: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoFreeIrp"} {:osmodel} IoFreeIrp(actual_pirp_12: int)
{
  var vslice_dummy_var_84: int;

  anon0:
    call {:si_unique_call 527} vslice_dummy_var_84 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_KeInitializeSpinLock"} {:osmodel} sdv_KeInitializeSpinLock(actual_SpinLock_4: int);
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_KeInitializeSpinLock"} {:osmodel} sdv_KeInitializeSpinLock(actual_SpinLock_4: int)
{
  var {:pointer} SpinLock_4: int;
  var vslice_dummy_var_85: int;

  anon0:
    call {:si_unique_call 528} vslice_dummy_var_85 := __HAVOC_malloc(4);
    SpinLock_4 := actual_SpinLock_4;
    assume {:nonnull} SpinLock_4 != 0;
    assume SpinLock_4 > 0;
    Mem_T.INT4[SpinLock_4] := 0;
    return;
}



procedure {:origName "_sdv_init10"} {:osmodel} _sdv_init10();
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5;
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures sdv_irql_previous_5 == 0;
  free ensures sdv_irql_previous_2 == 0;
  free ensures sdv_irql_current == 0;
  free ensures sdv_irql_previous == 0;
  free ensures sdv_irql_previous_4 == 0;
  free ensures sdv_irql_previous_3 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init10"} {:osmodel} _sdv_init10()
{
  var vslice_dummy_var_86: int;

  anon0:
    call {:si_unique_call 529} vslice_dummy_var_86 := __HAVOC_malloc(4);
    assume sdv_apc_disabled == 0;
    assume sdv_ControllerPirp == sdv_ControllerIrp;
    assume sdv_StartIopirp == sdv_StartIoIrp;
    assume sdv_power_irp == sdv_PowerIrp;
    assume sdv_irp == sdv_harnessIrp;
    assume sdv_other_irp == sdv_other_harnessIrp;
    assume sdv_IoMakeAssociatedIrp_irp == sdv_IoMakeAssociatedIrp_harnessIrp;
    assume sdv_IoBuildDeviceIoControlRequest_irp == sdv_IoBuildDeviceIoControlRequest_harnessIrp;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock == sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock;
    assume sdv_IoBuildSynchronousFsdRequest_irp == sdv_IoBuildSynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock == sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;
    assume sdv_IoBuildAsynchronousFsdRequest_irp == sdv_IoBuildAsynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock == sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;
    assume sdv_IoInitializeIrp_irp == sdv_IoInitializeIrp_harnessIrp;
    sdv_irql_current := 0;
    sdv_irql_previous := 0;
    sdv_irql_previous_2 := 0;
    sdv_irql_previous_3 := 0;
    sdv_irql_previous_4 := 0;
    sdv_irql_previous_5 := 0;
    assume sdv_maskedEflags == 0;
    assume sdv_kdpc3 == sdv_kdpc_val3;
    assume sdv_p_devobj_fdo == sdv_devobj_fdo;
    assume sdv_p_devobj_pdo == sdv_devobj_pdo;
    assume sdv_p_devobj_child_pdo == sdv_devobj_child_pdo;
    assume sdv_kinterrupt == sdv_kinterrupt_val;
    assume sdv_MapRegisterBase == sdv_MapRegisterBase_val;
    assume p_sdv_fx_dev_object == sdv_fx_dev_object;
    assume sdv_Io_Removelock_release_wait_returned == 0;
    assume sdv_isr_routine == li2bplFunctionConstant1025;
    assume sdv_ke_dpc == li2bplFunctionConstant1027;
    assume sdv_dpc_ke_registered == 0;
    assume sdv_io_dpc == li2bplFunctionConstant1030;
    assume sdv_p_devobj_top == sdv_devobj_top;
    assume sdv_MmMapIoSpace_int == 0;
    return;
}



procedure {:origName "ExAllocatePoolWithTag"} {:osmodel} ExAllocatePoolWithTag(actual_PoolType: int, actual_NumberOfBytes: int, actual_Tag_1: int) returns (Tmp_375: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "ExAllocatePoolWithTag"} {:osmodel} ExAllocatePoolWithTag(actual_PoolType: int, actual_NumberOfBytes: int, actual_Tag_1: int) returns (Tmp_375: int)
{
  var {:pointer} sdv_189: int;
  var {:scalar} NumberOfBytes: int;

  anon0:
    NumberOfBytes := actual_NumberOfBytes;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 530} sdv_189 := __HAVOC_malloc(NumberOfBytes);
    Tmp_375 := sdv_189;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_375 := 0;
    goto L1;
}



procedure {:origName "sdv_RunUnload"} {:osmodel} sdv_RunUnload(actual_pdrivo: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RunUnload"} {:osmodel} sdv_RunUnload(actual_pdrivo: int)
{
  var {:pointer} pdrivo: int;
  var vslice_dummy_var_87: int;

  anon0:
    call {:si_unique_call 531} vslice_dummy_var_87 := __HAVOC_malloc(4);
    pdrivo := actual_pdrivo;
    call {:si_unique_call 532} Avc_Unload(pdrivo);
    return;
}



procedure {:origName "IoSetDeviceInterfaceState"} {:osmodel} IoSetDeviceInterfaceState(actual_SymbolicLinkName_1: int, actual_Enable: int) returns (Tmp_379: int);
  free ensures Tmp_379 == -1073741772 || Tmp_379 == -1073741824 || Tmp_379 == -1073741789 || Tmp_379 == -1073741670 || Tmp_379 == -1073741808 || Tmp_379 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoSetDeviceInterfaceState"} {:osmodel} IoSetDeviceInterfaceState(actual_SymbolicLinkName_1: int, actual_Enable: int) returns (Tmp_379: int)
{

  anon0:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    goto anon15_Then, anon15_Else;

  anon15_Else:
    goto anon14_Then, anon14_Else;

  anon14_Else:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    goto anon12_Then, anon12_Else;

  anon12_Else:
    Tmp_379 := -1073741772;
    goto L1;

  L1:
    return;

  anon12_Then:
    Tmp_379 := -1073741824;
    goto L1;

  anon13_Then:
    Tmp_379 := -1073741789;
    goto L1;

  anon14_Then:
    Tmp_379 := -1073741670;
    goto L1;

  anon15_Then:
    Tmp_379 := -1073741808;
    goto L1;

  anon11_Then:
    Tmp_379 := 0;
    goto L1;
}



procedure {:origName "sdv_stub_driver_init"} {:osmodel} sdv_stub_driver_init();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_stub_driver_init"} {:osmodel} sdv_stub_driver_init()
{
  var vslice_dummy_var_88: int;

  anon0:
    call {:si_unique_call 533} vslice_dummy_var_88 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_stub_dispatch_begin"} {:osmodel} sdv_stub_dispatch_begin();
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous);
  free ensures sdv_irql_current == 0;
  free ensures sdv_irql_previous == old(sdv_irql_current);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_stub_dispatch_begin"} {:osmodel} sdv_stub_dispatch_begin()
{
  var vslice_dummy_var_89: int;

  anon0:
    call {:si_unique_call 534} vslice_dummy_var_89 := __HAVOC_malloc(4);
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 0;
    return;
}



procedure {:origName "IoOpenDeviceRegistryKey"} {:osmodel} IoOpenDeviceRegistryKey(actual_DeviceObject_18: int, actual_DevInstKeyType: int, actual_DesiredAccess_1: int, actual_DevInstRegKey: int) returns (Tmp_385: int);
  free ensures Tmp_385 == -1073741811 || Tmp_385 == -1073741808 || Tmp_385 == -1073741823 || Tmp_385 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IoOpenDeviceRegistryKey"} {:osmodel} IoOpenDeviceRegistryKey(actual_DeviceObject_18: int, actual_DevInstKeyType: int, actual_DesiredAccess_1: int, actual_DevInstRegKey: int) returns (Tmp_385: int)
{

  anon0:
    goto anon7_Then, anon7_Else;

  anon7_Else:
    goto anon9_Then, anon9_Else;

  anon9_Else:
    goto anon8_Then, anon8_Else;

  anon8_Else:
    Tmp_385 := -1073741811;
    goto L1;

  L1:
    return;

  anon8_Then:
    Tmp_385 := -1073741808;
    goto L1;

  anon9_Then:
    Tmp_385 := -1073741823;
    goto L1;

  anon7_Then:
    Tmp_385 := 0;
    goto L1;
}



procedure {:origName "sdv_ObDereferenceObject"} {:osmodel} sdv_ObDereferenceObject(actual_Object_2: int) returns (Tmp_387: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_ObDereferenceObject"} {:osmodel} sdv_ObDereferenceObject(actual_Object_2: int) returns (Tmp_387: int)
{
  var {:scalar} p_4: int;

  anon0:
    Tmp_387 := p_4;
    return;
}



procedure {:origName "ZwClose"} {:osmodel} ZwClose(actual_Handle: int) returns (Tmp_389: int);
  free ensures Tmp_389 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "ZwClose"} {:osmodel} ZwClose(actual_Handle: int) returns (Tmp_389: int)
{

  anon0:
    Tmp_389 := 0;
    return;
}



procedure {:origName "sdv_DoNothing"} {:osmodel} sdv_DoNothing() returns (Tmp_391: int);
  free ensures Tmp_391 == -1073741823;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_DoNothing"} {:osmodel} sdv_DoNothing() returns (Tmp_391: int)
{

  anon0:
    Tmp_391 := -1073741823;
    return;
}



procedure {:origName "sdv_ExAllocateFromNPagedLookasideList"} {:osmodel} sdv_ExAllocateFromNPagedLookasideList(actual_Lookaside_2: int) returns (Tmp_393: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_ExAllocateFromNPagedLookasideList"} {:osmodel} sdv_ExAllocateFromNPagedLookasideList(actual_Lookaside_2: int) returns (Tmp_393: int)
{
  var {:pointer} sdv_194: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 535} sdv_194 := __HAVOC_malloc(1);
    Tmp_393 := sdv_194;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_393 := 0;
    goto L1;
}



procedure {:origName "_sdv_init6"} _sdv_init6();
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init6"} _sdv_init6()
{
  var vslice_dummy_var_90: int;

  anon0:
    call {:si_unique_call 536} vslice_dummy_var_90 := __HAVOC_malloc(4);
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    return;
}



procedure {:origName "Avc_SystemControl"} Avc_SystemControl(actual_DeviceObject_19: int, actual_Irp_20: int) returns (Tmp_397: int);
  modifies alloc, Mem_T.INT4, yogi_error, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_SystemControl"} Avc_SystemControl(actual_DeviceObject_19: int, actual_Irp_20: int) returns (Tmp_397: int)
{
  var {:scalar} ntStatus_10: int;
  var {:pointer} CommonExtension_3: int;
  var {:pointer} DeviceObject_19: int;
  var {:pointer} Irp_20: int;
  var vslice_dummy_var_28: int;

  anon0:
    DeviceObject_19 := actual_DeviceObject_19;
    Irp_20 := actual_Irp_20;
    assume {:nonnull} DeviceObject_19 != 0;
    assume DeviceObject_19 > 0;
    havoc CommonExtension_3;
    call {:si_unique_call 537} sdv_do_paged_code_check();
    assume {:nonnull} CommonExtension_3 != 0;
    assume CommonExtension_3 > 0;
    call {:si_unique_call 538} ntStatus_10 := AvcAcquireRemoveLock(RemoveLock__COMMON_DEVICE_EXTENSION(CommonExtension_3));
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} ntStatus_10 != 0;
    ntStatus_10 := -1073741810;
    assume {:nonnull} Irp_20 != 0;
    assume Irp_20 > 0;
    call {:si_unique_call 539} sdv_IoCompleteRequest(0, 0);
    goto L20;

  L20:
    Tmp_397 := ntStatus_10;
    goto LM2;

  LM2:
    return;

  anon13_Then:
    assume {:partition} ntStatus_10 == 0;
    assume {:nonnull} CommonExtension_3 != 0;
    assume CommonExtension_3 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} Irp_20 != 0;
    assume Irp_20 > 0;
    havoc ntStatus_10;
    call {:si_unique_call 540} sdv_IoCompleteRequest(0, 0);
    goto L26;

  L26:
    assume {:nonnull} CommonExtension_3 != 0;
    assume CommonExtension_3 > 0;
    call {:si_unique_call 541} AvcReleaseRemoveLock(RemoveLock__COMMON_DEVICE_EXTENSION(CommonExtension_3));
    goto L20;

  anon14_Then:
    assume {:nonnull} CommonExtension_3 != 0;
    assume CommonExtension_3 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    call {:si_unique_call 542} sdv_IoSkipCurrentIrpStackLocation(Irp_20);
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume Irp_20 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 543} SLIC_sdv_IoCallDriver_entry(strConst__li2bpl13, Irp_20);
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} yogi_error != 1;
    goto L41;

  L41:
    assume {:nonnull} CommonExtension_3 != 0;
    assume CommonExtension_3 > 0;
    havoc vslice_dummy_var_28;
    call {:si_unique_call 544} ntStatus_10 := sdv_IoCallDriver#1(vslice_dummy_var_28, Irp_20);
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} yogi_error != 1;
    goto L26;

  anon18_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon17_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon16_Then:
    assume !(Irp_20 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L41;

  anon15_Then:
    assume {:nonnull} Irp_20 != 0;
    assume Irp_20 > 0;
    havoc ntStatus_10;
    call {:si_unique_call 545} sdv_IoCompleteRequest(0, 0);
    goto L26;
}



procedure {:origName "_sdv_init3"} _sdv_init3();
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init3"} _sdv_init3()
{
  var vslice_dummy_var_91: int;

  anon0:
    call {:si_unique_call 546} vslice_dummy_var_91 := __HAVOC_malloc(4);
    assume ClfsNullRecord_1 == 0;
    assume ClfsDataRecord_1 == 1;
    assume ClfsRestartRecord_1 == 2;
    assume ClfsClientRecord_1 == 3;
    assume ClsContainerInitializing_1 == 1;
    assume ClsContainerInactive_1 == 2;
    assume ClsContainerActive_1 == 4;
    assume ClsContainerActivePendingDelete_1 == 8;
    assume ClsContainerPendingArchive_1 == 16;
    assume ClsContainerPendingArchiveAndDelete_1 == 32;
    assume ClfsContainerInitializing_1 == 1;
    assume ClfsContainerInactive_1 == 2;
    assume ClfsContainerActive_1 == 4;
    assume ClfsContainerActivePendingDelete_1 == 8;
    assume ClfsContainerPendingArchive_1 == 16;
    assume ClfsContainerPendingArchiveAndDelete_1 == 32;
    assume CLFS_MAX_CONTAINER_INFO_1 == 256;
    assume CLFS_SCAN_INIT_1 == 1;
    assume CLFS_SCAN_FORWARD_1 == 2;
    assume CLFS_SCAN_BACKWARD_1 == 4;
    assume CLFS_SCAN_CLOSE_1 == 8;
    assume CLFS_SCAN_INITIALIZED_1 == 16;
    assume CLFS_SCAN_BUFFERED_1 == 32;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    return;
}



procedure {:origName "sdv_hash_664127497"} sdv_hash_664127497(actual_s_p_e_c_i_a_l_1: int, actual_s_p_e_c_i_a_l_2: int, actual_Event_6: int) returns (Tmp_401: int);
  free ensures Tmp_401 == -1073741802;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_664127497"} sdv_hash_664127497(actual_s_p_e_c_i_a_l_1: int, actual_s_p_e_c_i_a_l_2: int, actual_Event_6: int) returns (Tmp_401: int)
{
  var {:pointer} Event_6: int;
  var vslice_dummy_var_92: int;

  anon0:
    Event_6 := actual_Event_6;
    call {:si_unique_call 547} vslice_dummy_var_92 := KeSetEvent(Event_6, 0, 0);
    Tmp_401 := -1073741802;
    return;
}



procedure {:origName "Avc_PnpAddDevice"} Avc_PnpAddDevice(actual_DriverObject_3: int, actual_PhysicalDeviceObject_1: int) returns (Tmp_403: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures Tmp_403 == -1073741824 || Tmp_403 == -1073741771 || Tmp_403 == -1073741670 || Tmp_403 == -1073741823 || Tmp_403 == 0 || Tmp_403 == -1073741808 || Tmp_403 == -1073741810 || Tmp_403 == -1073741811;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_PnpAddDevice"} Avc_PnpAddDevice(actual_DriverObject_3: int, actual_PhysicalDeviceObject_1: int) returns (Tmp_403: int)
{
  var {:pointer} Tmp_404: int;
  var {:pointer} Tmp_405: int;
  var {:scalar} ResultLength_1: int;
  var {:pointer} DeviceObject_20: int;
  var {:pointer} sdv_201: int;
  var {:scalar} ntStatus_11: int;
  var {:pointer} PartialInfo: int;
  var {:pointer} Tmp_406: int;
  var {:pointer} Tmp_407: int;
  var {:pointer} BusExtension_1: int;
  var {:scalar} uniName: int;
  var {:pointer} ListHandle: int;
  var {:pointer} PhysicalDeviceObject_1: int;
  var boogieTmp: int;
  var vslice_dummy_var_93: int;
  var vslice_dummy_var_94: int;
  var vslice_dummy_var_95: int;
  var vslice_dummy_var_96: int;
  var vslice_dummy_var_29: int;
  var vslice_dummy_var_30: int;
  var vslice_dummy_var_31: int;

  anon0:
    call {:si_unique_call 548} vslice_dummy_var_93 := __HAVOC_malloc(24);
    call {:si_unique_call 549} DeviceObject_20 := __HAVOC_malloc(4);
    call {:si_unique_call 550} uniName := __HAVOC_malloc(12);
    call {:si_unique_call 551} ListHandle := __HAVOC_malloc(4);
    PhysicalDeviceObject_1 := actual_PhysicalDeviceObject_1;
    call {:si_unique_call 552} Tmp_404 := __HAVOC_malloc(36);
    call {:si_unique_call 553} Tmp_407 := __HAVOC_malloc(80);
    ntStatus_11 := 0;
    call {:si_unique_call 554} sdv_do_paged_code_check();
    call {:si_unique_call 555} ntStatus_11 := IoCreateDevice(0, 1424, 0, 42, 256, 0, DeviceObject_20);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} ntStatus_11 < 0;
    goto L151;

  L151:
    Tmp_403 := ntStatus_11;
    return;

  anon21_Then:
    assume {:partition} 0 <= ntStatus_11;
    assume {:nonnull} DeviceObject_20 != 0;
    assume DeviceObject_20 > 0;
    havoc BusExtension_1;
    call {:si_unique_call 556} sdv_RtlZeroMemory(0, 1424);
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} DeviceObject_20 != 0;
    assume DeviceObject_20 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 557} ntStatus_11 := IoOpenDeviceRegistryKey(0, 2, 983103, 0);
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} ntStatus_11 >= 0;
    Tmp_407 := strConst__li2bpl16;
    call {:si_unique_call 558} RtlInitUnicodeString(uniName, Tmp_407);
    call {:si_unique_call 559} sdv_InitializeObjectAttributes(0, 0, 576, 0, 0);
    call {:si_unique_call 560} ntStatus_11 := ZwOpenKey(ListHandle, 983103, 0);
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} ntStatus_11 >= 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 561} ntStatus_11 := IoRegisterDeviceInterface(0, 0, 0, SymbolicLinkName__BUS_DEVICE_EXTENSION(BusExtension_1));
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 562} vslice_dummy_var_95 := ZwClose(0);
    goto L57;

  L57:
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} ntStatus_11 >= 0;
    ResultLength_1 := 0;
    Tmp_404 := strConst__li2bpl17;
    call {:si_unique_call 563} RtlInitUnicodeString(uniName, Tmp_404);
    call {:si_unique_call 564} Tmp_406 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    Mem_T.INT4[Tmp_406] := ResultLength_1;
    call {:si_unique_call 565} ntStatus_11 := ZwQueryValueKey(0, 0, 2, 0, 0, Tmp_406);
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    ResultLength_1 := Mem_T.INT4[Tmp_406];
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} -1073741772 != ntStatus_11;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} ResultLength_1 != 0;
    call {:si_unique_call 566} sdv_201 := ExAllocatePoolWithTag(1, ResultLength_1, 541283905);
    PartialInfo := sdv_201;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} PartialInfo != 0;
    call {:si_unique_call 567} Tmp_406 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    Mem_T.INT4[Tmp_406] := ResultLength_1;
    call {:si_unique_call 568} ntStatus_11 := ZwQueryValueKey(0, 0, 2, 0, ResultLength_1, Tmp_406);
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    ResultLength_1 := Mem_T.INT4[Tmp_406];
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} ntStatus_11 >= 0;
    assume {:nonnull} PartialInfo != 0;
    assume PartialInfo > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:nonnull} PartialInfo != 0;
    assume PartialInfo > 0;
    havoc Tmp_405;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} Tmp_405 != 0;
    assume Tmp_405 > 0;
    goto L84;

  L84:
    call {:si_unique_call 569} sdv_ExFreePool(0);
    goto L71;

  L71:
    ntStatus_11 := 0;
    goto L58;

  L58:
    call {:si_unique_call 570} vslice_dummy_var_94 := ZwClose(0);
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 571} AvcInitializeRemoveLock(RemoveLock__BUS_DEVICE_EXTENSION(BusExtension_1));
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 572} InitializeListHead(PdoList__BUS_DEVICE_EXTENSION(BusExtension_1));
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    Mem_T.INT4[UnitAddr__BUS_DEVICE_EXTENSION(BusExtension_1)] := 255;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 573} InitializeListHead(PendingResponseList__BUS_DEVICE_EXTENSION(BusExtension_1));
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 574} InitializeListHead(PendingRequestList__BUS_DEVICE_EXTENSION(BusExtension_1));
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 575} InitializeListHead(CleanupList__BUS_DEVICE_EXTENSION(BusExtension_1));
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 576} sdv_ExInitializeFastMutex(0);
    call {:si_unique_call 577} Tmp_406 := __HAVOC_malloc(4);
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    havoc vslice_dummy_var_29;
    Mem_T.INT4[Tmp_406] := vslice_dummy_var_29;
    call {:si_unique_call 578} sdv_KeInitializeSpinLock(Tmp_406);
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    call {:si_unique_call 579} Tmp_406 := __HAVOC_malloc(4);
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    havoc vslice_dummy_var_30;
    Mem_T.INT4[Tmp_406] := vslice_dummy_var_30;
    call {:si_unique_call 580} sdv_KeInitializeSpinLock(Tmp_406);
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    call {:si_unique_call 581} KeInitializeTimerEx(0, 1);
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    havoc vslice_dummy_var_31;
    call {:si_unique_call 582} vslice_dummy_var_96 := KeSetTimer(0, vslice_dummy_var_31, 0);
    assume {:nonnull} DeviceObject_20 != 0;
    assume DeviceObject_20 > 0;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 583} boogieTmp := IoAttachDeviceToDeviceStack(0, PhysicalDeviceObject_1);
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    call {:si_unique_call 584} AvcAddInstanceToGlobalList(BusExtension_1);
    assume {:nonnull} DeviceObject_20 != 0;
    assume DeviceObject_20 > 0;
    goto L151;

  anon29_Then:
    call {:si_unique_call 585} IoDeleteDevice(0);
    ntStatus_11 := -1073741810;
    goto L151;

  anon28_Then:
    goto L84;

  anon27_Then:
    assume {:partition} 0 > ntStatus_11;
    goto L84;

  anon30_Then:
    assume {:partition} PartialInfo == 0;
    goto L71;

  anon26_Then:
    assume {:partition} ResultLength_1 == 0;
    goto L71;

  anon25_Then:
    assume {:partition} -1073741772 == ntStatus_11;
    goto L71;

  anon24_Then:
    assume {:partition} 0 > ntStatus_11;
    goto L58;

  anon23_Then:
    assume {:partition} 0 > ntStatus_11;
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    call {:si_unique_call 586} ntStatus_11 := IoRegisterDeviceInterface(0, 0, 0, SymbolicLinkName__BUS_DEVICE_EXTENSION(BusExtension_1));
    assume {:nonnull} BusExtension_1 != 0;
    assume BusExtension_1 > 0;
    goto L57;

  anon22_Then:
    assume {:partition} 0 > ntStatus_11;
    call {:si_unique_call 587} IoDeleteDevice(0);
    goto L151;
}



procedure {:origName "AvcReq_OutputPlugSignalFormat"} AvcReq_OutputPlugSignalFormat(actual_Command_15: int, actual_Plug: int) returns (Tmp_408: int);
  modifies alloc, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcReq_OutputPlugSignalFormat"} AvcReq_OutputPlugSignalFormat(actual_Command_15: int, actual_Plug: int) returns (Tmp_408: int)
{
  var {:scalar} ntStatus_12: int;
  var {:scalar} Tmp_409: int;
  var {:pointer} Operands_2: int;
  var {:pointer} Tmp_411: int;
  var {:pointer} Command_15: int;
  var {:scalar} Plug: int;

  anon0:
    Command_15 := actual_Command_15;
    Plug := actual_Plug;
    call {:si_unique_call 588} Tmp_411 := __HAVOC_malloc(2048);
    ntStatus_12 := 0;
    call {:si_unique_call 589} sdv_do_paged_code_check();
    assume {:nonnull} Command_15 != 0;
    assume Command_15 > 0;
    assume {:nonnull} Command_15 != 0;
    assume Command_15 > 0;
    assume {:nonnull} Command_15 != 0;
    assume Command_15 > 0;
    havoc Tmp_409;
    assume {:nonnull} Command_15 != 0;
    assume Command_15 > 0;
    havoc Tmp_411;
    Operands_2 := Tmp_411 + Tmp_409 * 4;
    assume {:nonnull} Operands_2 != 0;
    assume Operands_2 > 0;
    Mem_T.INT4[Operands_2] := Plug;
    assume {:nonnull} Operands_2 != 0;
    assume Operands_2 > 0;
    Mem_T.INT4[Operands_2 + 1 * 4] := 255;
    assume {:nonnull} Operands_2 != 0;
    assume Operands_2 > 0;
    Mem_T.INT4[Operands_2 + 2 * 4] := 255;
    assume {:nonnull} Operands_2 != 0;
    assume Operands_2 > 0;
    Mem_T.INT4[Operands_2 + 3 * 4] := 255;
    assume {:nonnull} Operands_2 != 0;
    assume Operands_2 > 0;
    Mem_T.INT4[Operands_2 + 4 * 4] := 255;
    call {:si_unique_call 590} ntStatus_12 := AvcRobustStatusRequest(Command_15);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} yogi_error != 1;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} ntStatus_12 != 0;
    goto L23;

  L23:
    Tmp_408 := ntStatus_12;
    goto LM2;

  LM2:
    return;

  anon9_Then:
    assume {:partition} ntStatus_12 == 0;
    assume {:nonnull} Command_15 != 0;
    assume Command_15 > 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    ntStatus_12 := -1073741822;
    goto L24;

  L24:
    assume {:nonnull} Command_15 != 0;
    assume Command_15 > 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    ntStatus_12 := -1073741811;
    goto L23;

  anon11_Then:
    goto L23;

  anon10_Then:
    goto L24;

  anon12_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "AvcRemoveFromPdoList"} AvcRemoveFromPdoList(actual_BusExtension_2: int, actual_PdoData_2: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcRemoveFromPdoList"} AvcRemoveFromPdoList(actual_BusExtension_2: int, actual_PdoData_2: int)
{
  var {:pointer} Tmp_412: int;
  var {:scalar} oldIrql_2: int;
  var {:pointer} PdoData_2: int;
  var vslice_dummy_var_97: int;
  var vslice_dummy_var_98: int;

  anon0:
    call {:si_unique_call 591} vslice_dummy_var_97 := __HAVOC_malloc(4);
    PdoData_2 := actual_PdoData_2;
    call {:si_unique_call 592} Tmp_412 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_412 != 0;
    assume Tmp_412 > 0;
    Mem_T.INT4[Tmp_412] := oldIrql_2;
    call {:si_unique_call 593} sdv_KeAcquireSpinLock(0, Tmp_412);
    assume {:nonnull} Tmp_412 != 0;
    assume Tmp_412 > 0;
    oldIrql_2 := Mem_T.INT4[Tmp_412];
    call {:si_unique_call 594} vslice_dummy_var_98 := sdv_RemoveEntryList(0);
    call {:si_unique_call 595} sdv_KeReleaseSpinLock(0, oldIrql_2);
    assume {:nonnull} PdoData_2 != 0;
    assume PdoData_2 > 0;
    call {:si_unique_call 596} InitializeListHead(PdoList__PDO_DATA(PdoData_2));
    return;
}



procedure {:origName "Avc_SetFcpNotify"} Avc_SetFcpNotify(actual_BusExtension_3: int, actual_bEnable: int) returns (Tmp_414: int);
  modifies alloc, Mem_T.INT4, yogi_error, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_SetFcpNotify"} Avc_SetFcpNotify(actual_BusExtension_3: int, actual_bEnable: int) returns (Tmp_414: int)
{
  var {:pointer} Irp_21: int;
  var {:scalar} ntStatus_13: int;
  var {:pointer} NextIrpStack_6: int;
  var {:pointer} Tmp_416: int;
  var {:scalar} AvRequest: int;
  var {:pointer} BusExtension_3: int;
  var {:scalar} bEnable: int;
  var vslice_dummy_var_32: int;
  var vslice_dummy_var_33: int;

  anon0:
    call {:si_unique_call 597} AvRequest := __HAVOC_malloc(460);
    BusExtension_3 := actual_BusExtension_3;
    bEnable := actual_bEnable;
    ntStatus_13 := 0;
    call {:si_unique_call 598} sdv_do_paged_code_check();
    assume {:nonnull} BusExtension_3 != 0;
    assume BusExtension_3 > 0;
    havoc Tmp_416;
    assume {:nonnull} Tmp_416 != 0;
    assume Tmp_416 > 0;
    havoc vslice_dummy_var_32;
    call {:si_unique_call 599} Irp_21 := IoAllocateIrp(vslice_dummy_var_32, 0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} Irp_21 != 0;
    call {:si_unique_call 600} NextIrpStack_6 := sdv_IoGetNextIrpStackLocation(Irp_21);
    assume {:nonnull} AvRequest != 0;
    assume AvRequest > 0;
    assume {:nonnull} AvRequest != 0;
    assume AvRequest > 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} bEnable != 0;
    assume {:nonnull} AvRequest != 0;
    assume AvRequest > 0;
    assume {:nonnull} BusExtension_3 != 0;
    assume BusExtension_3 > 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    goto L28;

  L28:
    assume {:nonnull} NextIrpStack_6 != 0;
    assume NextIrpStack_6 > 0;
    assume {:nonnull} NextIrpStack_6 != 0;
    assume NextIrpStack_6 > 0;
    assume {:nonnull} NextIrpStack_6 != 0;
    assume NextIrpStack_6 > 0;
    assume {:nonnull} BusExtension_3 != 0;
    assume BusExtension_3 > 0;
    havoc vslice_dummy_var_33;
    call {:si_unique_call 601} ntStatus_13 := Avc_SubmitIrpSynch(vslice_dummy_var_33, Irp_21);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 602} IoFreeIrp(0);
    goto L38;

  L38:
    Tmp_414 := ntStatus_13;
    goto LM2;

  LM2:
    return;

  anon12_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon11_Then:
    assume {:nonnull} AvRequest != 0;
    assume AvRequest > 0;
    goto L28;

  anon10_Then:
    assume {:partition} bEnable == 0;
    assume {:nonnull} AvRequest != 0;
    assume AvRequest > 0;
    goto L28;

  anon9_Then:
    assume {:partition} Irp_21 == 0;
    ntStatus_13 := -1073741670;
    goto L38;
}



procedure {:origName "Avc_SetUnitDirectory"} Avc_SetUnitDirectory(actual_BusExtension_4: int, actual_bEnable_1: int);
  modifies alloc, Mem_T.INT4, yogi_error, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_SetUnitDirectory"} Avc_SetUnitDirectory(actual_BusExtension_4: int, actual_bEnable_1: int)
{
  var {:pointer} Irp_22: int;
  var {:scalar} ntStatus_14: int;
  var {:pointer} NextIrpStack_7: int;
  var {:pointer} Tmp_417: int;
  var {:scalar} AvRequest_1: int;
  var {:pointer} Tmp_420: int;
  var {:pointer} BusExtension_4: int;
  var {:scalar} bEnable_1: int;
  var vslice_dummy_var_99: int;
  var vslice_dummy_var_34: int;
  var vslice_dummy_var_35: int;

  anon0:
    call {:si_unique_call 603} vslice_dummy_var_99 := __HAVOC_malloc(4);
    call {:si_unique_call 604} AvRequest_1 := __HAVOC_malloc(460);
    BusExtension_4 := actual_BusExtension_4;
    bEnable_1 := actual_bEnable_1;
    call {:si_unique_call 605} sdv_do_paged_code_check();
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} bEnable_1 != 0;
    assume {:nonnull} BusExtension_4 != 0;
    assume BusExtension_4 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    goto L8;

  L8:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} bEnable_1 != 0;
    goto L12;

  L12:
    assume {:nonnull} BusExtension_4 != 0;
    assume BusExtension_4 > 0;
    havoc Tmp_420;
    assume {:nonnull} Tmp_420 != 0;
    assume Tmp_420 > 0;
    havoc vslice_dummy_var_34;
    call {:si_unique_call 606} Irp_22 := IoAllocateIrp(vslice_dummy_var_34, 0);
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} Irp_22 != 0;
    call {:si_unique_call 607} NextIrpStack_7 := sdv_IoGetNextIrpStackLocation(Irp_22);
    assume {:nonnull} AvRequest_1 != 0;
    assume AvRequest_1 > 0;
    assume {:nonnull} AvRequest_1 != 0;
    assume AvRequest_1 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} bEnable_1 != 0;
    assume {:nonnull} AvRequest_1 != 0;
    assume AvRequest_1 > 0;
    assume {:nonnull} BusExtension_4 != 0;
    assume BusExtension_4 > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    goto L32;

  L32:
    assume {:nonnull} AvRequest_1 != 0;
    assume AvRequest_1 > 0;
    assume {:nonnull} AvRequest_1 != 0;
    assume AvRequest_1 > 0;
    assume {:nonnull} AvRequest_1 != 0;
    assume AvRequest_1 > 0;
    assume {:nonnull} BusExtension_4 != 0;
    assume BusExtension_4 > 0;
    assume {:nonnull} NextIrpStack_7 != 0;
    assume NextIrpStack_7 > 0;
    assume {:nonnull} NextIrpStack_7 != 0;
    assume NextIrpStack_7 > 0;
    assume {:nonnull} NextIrpStack_7 != 0;
    assume NextIrpStack_7 > 0;
    assume {:nonnull} BusExtension_4 != 0;
    assume BusExtension_4 > 0;
    havoc vslice_dummy_var_35;
    call {:si_unique_call 608} ntStatus_14 := Avc_SubmitIrpSynch(vslice_dummy_var_35, Irp_22);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} ntStatus_14 >= 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} bEnable_1 != 0;
    assume {:nonnull} AvRequest_1 != 0;
    assume AvRequest_1 > 0;
    havoc Tmp_417;
    goto L49;

  L49:
    assume {:nonnull} BusExtension_4 != 0;
    assume BusExtension_4 > 0;
    goto L43;

  L43:
    call {:si_unique_call 609} IoFreeIrp(0);
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon27_Then:
    assume {:partition} bEnable_1 == 0;
    Tmp_417 := 0;
    goto L49;

  anon26_Then:
    assume {:partition} 0 > ntStatus_14;
    goto L43;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon29_Then:
    assume {:nonnull} AvRequest_1 != 0;
    assume AvRequest_1 > 0;
    goto L32;

  anon28_Then:
    assume {:partition} bEnable_1 == 0;
    assume {:nonnull} AvRequest_1 != 0;
    assume AvRequest_1 > 0;
    goto L32;

  anon25_Then:
    assume {:partition} Irp_22 == 0;
    goto L1;

  anon22_Then:
    assume {:partition} bEnable_1 == 0;
    assume {:nonnull} BusExtension_4 != 0;
    assume BusExtension_4 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    goto L12;

  anon24_Then:
    goto L1;

  anon23_Then:
    goto L1;

  anon21_Then:
    assume {:partition} bEnable_1 == 0;
    goto L8;
}



procedure {:origName "RtlULongAdd"} RtlULongAdd(actual_ulAugend: int, actual_ulAddend: int, actual_pulResult: int) returns (Tmp_421: int);
  modifies Mem_T.INT4;
  free ensures Tmp_421 == 0 || Tmp_421 == -1073741675;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RtlULongAdd"} RtlULongAdd(actual_ulAugend: int, actual_ulAddend: int, actual_pulResult: int) returns (Tmp_421: int)
{
  var {:scalar} status_5: int;
  var {:scalar} ulAugend: int;
  var {:scalar} ulAddend: int;
  var {:pointer} pulResult: int;

  anon0:
    ulAugend := actual_ulAugend;
    ulAddend := actual_ulAddend;
    pulResult := actual_pulResult;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} ulAugend + ulAddend >= ulAugend;
    assume {:nonnull} pulResult != 0;
    assume pulResult > 0;
    Mem_T.INT4[pulResult] := ulAugend + ulAddend;
    status_5 := 0;
    goto L8;

  L8:
    Tmp_421 := status_5;
    return;

  anon3_Then:
    assume {:partition} ulAugend > ulAugend + ulAddend;
    assume {:nonnull} pulResult != 0;
    assume pulResult > 0;
    Mem_T.INT4[pulResult] := -1;
    status_5 := -1073741675;
    goto L8;
}



procedure {:origName "RtlULongMult"} RtlULongMult(actual_ulMultiplicand: int, actual_ulMultiplier: int, actual_pulResult_1: int) returns (Tmp_423: int);
  modifies Mem_T.INT4;
  free ensures Tmp_423 == 0 || Tmp_423 == -1073741675;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RtlULongMult"} RtlULongMult(actual_ulMultiplicand: int, actual_ulMultiplier: int, actual_pulResult_1: int) returns (Tmp_423: int)
{
  var {:scalar} ull64Result: int;
  var {:scalar} ulMultiplicand: int;
  var {:scalar} ulMultiplier: int;
  var {:pointer} pulResult_1: int;

  anon0:
    ulMultiplicand := actual_ulMultiplicand;
    ulMultiplier := actual_ulMultiplier;
    pulResult_1 := actual_pulResult_1;
    ull64Result := ulMultiplicand * ulMultiplier;
    call {:si_unique_call 610} Tmp_423 := RtlULongLongToULong(ull64Result, pulResult_1);
    return;
}



procedure {:origName "Avc_EnumerateChildren"} Avc_EnumerateChildren(actual_BusExtension_5: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_EnumerateChildren"} Avc_EnumerateChildren(actual_BusExtension_5: int)
{
  var {:pointer} PdoData_3: int;
  var {:pointer} BusExtension_5: int;
  var vslice_dummy_var_100: int;

  anon0:
    call {:si_unique_call 611} vslice_dummy_var_100 := __HAVOC_malloc(4);
    BusExtension_5 := actual_BusExtension_5;
    call {:si_unique_call 612} sdv_do_paged_code_check();
    assume {:nonnull} BusExtension_5 != 0;
    assume BusExtension_5 > 0;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    call {:si_unique_call 613} ExAcquireFastMutex(0);
    assume {:nonnull} BusExtension_5 != 0;
    assume BusExtension_5 > 0;
    havoc PdoData_3;
    goto L15;

  L15:
    call {:si_unique_call 614} PdoData_3 := Avc_EnumerateChildren_loop_L15(PdoData_3);
    goto L15_last;

  L15_last:
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:nonnull} PdoData_3 != 0;
    assume PdoData_3 > 0;
    assume {:nonnull} PdoData_3 != 0;
    assume PdoData_3 > 0;
    havoc PdoData_3;
    goto anon8_Else_dummy;

  anon8_Else_dummy:
    assume false;
    return;

  anon8_Then:
    call {:si_unique_call 615} ExReleaseFastMutex(0);
    call {:si_unique_call 616} Avc_EnumerateExtrnalChildren(BusExtension_5);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} yogi_error != 1;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon9_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon7_Then:
    goto L1;
}



procedure {:origName "AvcRemoveInstanceFromGlobalList"} AvcRemoveInstanceFromGlobalList(actual_BusExtension_6: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcRemoveInstanceFromGlobalList"} AvcRemoveInstanceFromGlobalList(actual_BusExtension_6: int)
{
  var {:scalar} sdv_219: int;
  var {:scalar} OldIrql_9: int;
  var {:pointer} Tmp_428: int;
  var {:pointer} BusExtension_6: int;
  var vslice_dummy_var_101: int;
  var vslice_dummy_var_102: int;

  anon0:
    call {:si_unique_call 617} vslice_dummy_var_101 := __HAVOC_malloc(4);
    BusExtension_6 := actual_BusExtension_6;
    call {:si_unique_call 618} sdv_219 := sdv_IsListEmpty(0);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} sdv_219 == 0;
    call {:si_unique_call 619} Tmp_428 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_428 != 0;
    assume Tmp_428 > 0;
    Mem_T.INT4[Tmp_428] := OldIrql_9;
    call {:si_unique_call 620} sdv_KeAcquireSpinLock(0, Tmp_428);
    assume {:nonnull} Tmp_428 != 0;
    assume Tmp_428 > 0;
    OldIrql_9 := Mem_T.INT4[Tmp_428];
    call {:si_unique_call 621} vslice_dummy_var_102 := sdv_RemoveEntryList(0);
    assume {:nonnull} BusExtension_6 != 0;
    assume BusExtension_6 > 0;
    call {:si_unique_call 622} InitializeListHead(FdoEntry__BUS_DEVICE_EXTENSION(BusExtension_6));
    call {:si_unique_call 623} sdv_KeReleaseSpinLock(0, OldIrql_9);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} sdv_219 != 0;
    goto L1;
}



procedure {:origName "Avc_IsLegacyDV"} Avc_IsLegacyDV(actual_BusExtension_7: int) returns (Tmp_429: int);
  modifies alloc, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_IsLegacyDV"} Avc_IsLegacyDV(actual_BusExtension_7: int) returns (Tmp_429: int)
{
  var {:dopa} {:scalar} SubunitAddr_4: int;
  var {:scalar} rc: int;
  var {:pointer} Operands_3: int;
  var {:pointer} Tmp_430: int;
  var {:scalar} ntStatus_16: int;
  var {:pointer} Tmp_431: int;
  var {:pointer} Command_16: int;
  var {:scalar} Tmp_433: int;
  var {:pointer} Operands_4: int;
  var {:scalar} Tmp_434: int;
  var {:pointer} BusExtension_7: int;
  var vslice_dummy_var_36: int;
  var vslice_dummy_var_37: int;
  var vslice_dummy_var_38: int;

  anon0:
    call {:si_unique_call 624} SubunitAddr_4 := __HAVOC_malloc(4);
    call {:si_unique_call 625} Command_16 := __HAVOC_malloc(4);
    BusExtension_7 := actual_BusExtension_7;
    call {:si_unique_call 626} Tmp_430 := __HAVOC_malloc(2048);
    call {:si_unique_call 627} Tmp_431 := __HAVOC_malloc(2048);
    rc := 0;
    assume {:nonnull} Command_16 != 0;
    assume Command_16 > 0;
    call {:si_unique_call 628} sdv_do_paged_code_check();
    call {:si_unique_call 629} ntStatus_16 := AvcAllocateUnitCommandContext(BusExtension_7, Command_16);
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} ntStatus_16 != 0;
    goto L19;

  L19:
    Tmp_429 := rc;
    goto LM2;

  LM2:
    return;

  anon51_Then:
    assume {:partition} ntStatus_16 == 0;
    assume {:nonnull} Command_16 != 0;
    assume Command_16 > 0;
    havoc vslice_dummy_var_36;
    call {:si_unique_call 630} ntStatus_16 := AvcReq_OutputPlugSignalFormat(vslice_dummy_var_36, 0);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} yogi_error != 1;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} ntStatus_16 == 0;
    assume {:nonnull} Command_16 != 0;
    assume Command_16 > 0;
    havoc Tmp_433;
    assume {:nonnull} Command_16 != 0;
    assume Command_16 > 0;
    havoc Tmp_431;
    Operands_3 := Tmp_431 + Tmp_433 * 4;
    assume {:nonnull} Operands_3 != 0;
    assume Operands_3 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} Mem_T.INT4[Operands_3 + 1 * 4] != 32;
    assume {:nonnull} Operands_3 != 0;
    assume Operands_3 > 0;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} Mem_T.INT4[Operands_3 + 1 * 4] != 128;
    assume {:nonnull} Operands_3 != 0;
    assume Operands_3 > 0;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} Mem_T.INT4[Operands_3 + 1 * 4] != 160;
    ntStatus_16 := -1073741823;
    goto L23;

  L23:
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} ntStatus_16 != 0;
    assume {:nonnull} SubunitAddr_4 != 0;
    assume SubunitAddr_4 > 0;
    Mem_T.INT4[SubunitAddr_4] := 32;
    assume {:nonnull} Command_16 != 0;
    assume Command_16 > 0;
    havoc vslice_dummy_var_37;
    call {:si_unique_call 631} ntStatus_16 := AvcReq_OutputPlugSignalMode(vslice_dummy_var_37, SubunitAddr_4);
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} yogi_error != 1;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} ntStatus_16 == 0;
    assume {:nonnull} Command_16 != 0;
    assume Command_16 > 0;
    havoc Tmp_434;
    assume {:nonnull} Command_16 != 0;
    assume Command_16 > 0;
    havoc Tmp_430;
    Operands_4 := Tmp_430 + Tmp_434 * 4;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} Mem_T.INT4[Operands_4] != 0;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} Mem_T.INT4[Operands_4] != 4;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} Mem_T.INT4[Operands_4] != 6;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} Mem_T.INT4[Operands_4] != 8;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} Mem_T.INT4[Operands_4] != 14;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} Mem_T.INT4[Operands_4] != 128;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} Mem_T.INT4[Operands_4] != 132;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} Mem_T.INT4[Operands_4] != 134;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} Mem_T.INT4[Operands_4] != 136;
    assume {:nonnull} Operands_4 != 0;
    assume Operands_4 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} Mem_T.INT4[Operands_4] == 142;
    goto L37;

  L37:
    rc := 1;
    goto L24;

  L24:
    assume {:nonnull} Command_16 != 0;
    assume Command_16 > 0;
    havoc vslice_dummy_var_38;
    call {:si_unique_call 632} AvcFreeCommandContext(vslice_dummy_var_38);
    goto L19;

  anon56_Then:
    assume {:partition} Mem_T.INT4[Operands_4] != 142;
    goto L24;

  anon57_Then:
    assume {:partition} Mem_T.INT4[Operands_4] == 136;
    goto L37;

  anon58_Then:
    assume {:partition} Mem_T.INT4[Operands_4] == 134;
    goto L37;

  anon59_Then:
    assume {:partition} Mem_T.INT4[Operands_4] == 132;
    goto L37;

  anon60_Then:
    assume {:partition} Mem_T.INT4[Operands_4] == 128;
    goto L37;

  anon61_Then:
    assume {:partition} Mem_T.INT4[Operands_4] == 14;
    goto L37;

  anon62_Then:
    assume {:partition} Mem_T.INT4[Operands_4] == 8;
    goto L37;

  anon63_Then:
    assume {:partition} Mem_T.INT4[Operands_4] == 6;
    goto L37;

  anon64_Then:
    assume {:partition} Mem_T.INT4[Operands_4] == 4;
    goto L37;

  anon74_Then:
    assume {:partition} Mem_T.INT4[Operands_4] == 0;
    goto L37;

  anon54_Then:
    assume {:partition} ntStatus_16 != 0;
    goto L24;

  anon73_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon53_Then:
    assume {:partition} ntStatus_16 == 0;
    goto L24;

  anon65_Then:
    assume {:partition} Mem_T.INT4[Operands_3 + 1 * 4] == 160;
    goto L23;

  anon66_Then:
    assume {:partition} Mem_T.INT4[Operands_3 + 1 * 4] == 128;
    goto L42;

  L42:
    assume {:nonnull} Operands_3 != 0;
    assume Operands_3 > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) != 0;
    assume {:nonnull} Operands_3 != 0;
    assume Operands_3 > 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) != 4;
    assume {:nonnull} Operands_3 != 0;
    assume Operands_3 > 0;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) != 8;
    assume {:nonnull} Operands_3 != 0;
    assume Operands_3 > 0;
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) != 112;
    assume {:nonnull} Operands_3 != 0;
    assume Operands_3 > 0;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) != 116;
    assume {:nonnull} Operands_3 != 0;
    assume Operands_3 > 0;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) == 120;
    goto L45;

  L45:
    rc := 1;
    goto L23;

  anon67_Then:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) != 120;
    ntStatus_16 := -1073741823;
    goto L23;

  anon68_Then:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) == 116;
    goto L45;

  anon69_Then:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) == 112;
    goto L45;

  anon70_Then:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) == 8;
    goto L45;

  anon71_Then:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) == 4;
    goto L45;

  anon55_Then:
    assume {:partition} BAND(Mem_T.INT4[Operands_3 + 2 * 4], 124) == 0;
    goto L45;

  anon75_Then:
    assume {:partition} Mem_T.INT4[Operands_3 + 1 * 4] == 32;
    goto L42;

  anon52_Then:
    assume {:partition} ntStatus_16 != 0;
    goto L23;

  anon72_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "AvcReq_UnitInfo"} AvcReq_UnitInfo(actual_BusExtension_8: int) returns (Tmp_435: int);
  modifies alloc, Mem_T.INT4, yogi_error, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcReq_UnitInfo"} AvcReq_UnitInfo(actual_BusExtension_8: int) returns (Tmp_435: int)
{
  var {:pointer} Irp_23: int;
  var {:scalar} ulUnitModelLength: int;
  var {:pointer} sdv_225: int;
  var {:scalar} ulModelLength: int;
  var {:scalar} ntStatus_17: int;
  var {:scalar} ulVendorLength: int;
  var {:pointer} NextIrpStack_8: int;
  var {:pointer} sdv_229: int;
  var {:pointer} sdv_230: int;
  var {:pointer} Tmp_439: int;
  var {:scalar} AvRequest_2: int;
  var {:pointer} BusExtension_8: int;
  var vslice_dummy_var_39: int;
  var vslice_dummy_var_40: int;
  var vslice_dummy_var_41: int;
  var vslice_dummy_var_42: int;
  var vslice_dummy_var_43: int;
  var vslice_dummy_var_44: int;
  var vslice_dummy_var_45: int;

  anon0:
    call {:si_unique_call 633} AvRequest_2 := __HAVOC_malloc(460);
    BusExtension_8 := actual_BusExtension_8;
    ntStatus_17 := 0;
    call {:si_unique_call 634} sdv_do_paged_code_check();
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc Tmp_439;
    assume {:nonnull} Tmp_439 != 0;
    assume Tmp_439 > 0;
    havoc vslice_dummy_var_39;
    call {:si_unique_call 635} Irp_23 := IoAllocateIrp(vslice_dummy_var_39, 0);
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} Irp_23 != 0;
    call {:si_unique_call 636} NextIrpStack_8 := sdv_IoGetNextIrpStackLocation(Irp_23);
    assume {:nonnull} AvRequest_2 != 0;
    assume AvRequest_2 > 0;
    assume {:nonnull} AvRequest_2 != 0;
    assume AvRequest_2 > 0;
    assume {:nonnull} AvRequest_2 != 0;
    assume AvRequest_2 > 0;
    assume {:nonnull} AvRequest_2 != 0;
    assume AvRequest_2 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    assume {:nonnull} NextIrpStack_8 != 0;
    assume NextIrpStack_8 > 0;
    assume {:nonnull} NextIrpStack_8 != 0;
    assume NextIrpStack_8 > 0;
    assume {:nonnull} NextIrpStack_8 != 0;
    assume NextIrpStack_8 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc vslice_dummy_var_40;
    call {:si_unique_call 637} ntStatus_17 := Avc_SubmitIrpSynch(vslice_dummy_var_40, Irp_23);
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} yogi_error != 1;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} ntStatus_17 != 0;
    goto L56;

  L56:
    call {:si_unique_call 638} IoFreeIrp(0);
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} ntStatus_17 < 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    call {:si_unique_call 639} sdv_ExFreePool(0);
    goto L61;

  L61:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    call {:si_unique_call 640} sdv_ExFreePool(0);
    goto L65;

  L65:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    call {:si_unique_call 641} sdv_ExFreePool(0);
    goto L69;

  L69:
    call {:si_unique_call 642} sdv_RtlZeroMemory(0, 48);
    goto L10;

  L10:
    Tmp_435 := ntStatus_17;
    goto LM2;

  LM2:
    return;

  anon50_Then:
    goto L69;

  anon49_Then:
    goto L65;

  anon48_Then:
    goto L61;

  anon47_Then:
    assume {:partition} 0 <= ntStatus_17;
    goto L10;

  anon45_Then:
    assume {:partition} ntStatus_17 == 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    goto L77;

  L77:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc ulVendorLength;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc ulModelLength;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc ulUnitModelLength;
    call {:si_unique_call 643} sdv_RtlZeroMemory(0, 48);
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc vslice_dummy_var_41;
    call {:si_unique_call 644} sdv_230 := ExAllocatePoolWithTag(1, vslice_dummy_var_41, 541283905);
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    ntStatus_17 := -1073741670;
    goto L56;

  anon59_Then:
    goto L89;

  L89:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc vslice_dummy_var_42;
    call {:si_unique_call 645} sdv_229 := ExAllocatePoolWithTag(1, vslice_dummy_var_42, 541283905);
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    ntStatus_17 := -1073741670;
    goto L56;

  anon60_Then:
    goto L97;

  L97:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc vslice_dummy_var_43;
    call {:si_unique_call 646} sdv_225 := ExAllocatePoolWithTag(1, vslice_dummy_var_43, 541283905);
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    ntStatus_17 := -1073741670;
    goto L56;

  anon61_Then:
    goto L105;

  L105:
    assume {:nonnull} NextIrpStack_8 != 0;
    assume NextIrpStack_8 > 0;
    assume {:nonnull} NextIrpStack_8 != 0;
    assume NextIrpStack_8 > 0;
    assume {:nonnull} NextIrpStack_8 != 0;
    assume NextIrpStack_8 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc vslice_dummy_var_44;
    call {:si_unique_call 647} ntStatus_17 := Avc_SubmitIrpSynch(vslice_dummy_var_44, Irp_23);
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} yogi_error != 1;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} ntStatus_17 == 0;
    goto L120;

  L120:
    assume {:nonnull} AvRequest_2 != 0;
    assume AvRequest_2 > 0;
    assume {:nonnull} AvRequest_2 != 0;
    assume AvRequest_2 > 0;
    assume {:nonnull} AvRequest_2 != 0;
    assume AvRequest_2 > 0;
    assume {:nonnull} AvRequest_2 != 0;
    assume AvRequest_2 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    assume {:nonnull} NextIrpStack_8 != 0;
    assume NextIrpStack_8 > 0;
    assume {:nonnull} NextIrpStack_8 != 0;
    assume NextIrpStack_8 > 0;
    assume {:nonnull} NextIrpStack_8 != 0;
    assume NextIrpStack_8 > 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    havoc vslice_dummy_var_45;
    call {:si_unique_call 648} ntStatus_17 := Avc_SubmitIrpSynch(vslice_dummy_var_45, Irp_23);
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} yogi_error != 1;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} ntStatus_17 == 0;
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto L56;

  anon55_Then:
    assume {:partition} ntStatus_17 != 0;
    goto L56;

  anon63_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon54_Then:
    assume {:partition} ntStatus_17 != 0;
    goto L56;

  anon62_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon53_Then:
    goto L105;

  anon52_Then:
    goto L97;

  anon58_Then:
    goto L89;

  anon46_Then:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:nonnull} BusExtension_8 != 0;
    assume BusExtension_8 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    goto L120;

  anon56_Then:
    goto L77;

  anon51_Then:
    goto L77;

  anon57_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon44_Then:
    assume {:partition} Irp_23 == 0;
    ntStatus_17 := -1073741670;
    goto L10;

  anon43_Then:
    goto L10;
}



procedure {:origName "Avc_EnumerateExtrnalChildren"} Avc_EnumerateExtrnalChildren(actual_BusExtension_9: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_EnumerateExtrnalChildren"} Avc_EnumerateExtrnalChildren(actual_BusExtension_9: int)
{
  var {:pointer} PdoData_4: int;
  var {:scalar} SubunitID_2: int;
  var {:pointer} SubunitAddr_5: int;
  var {:scalar} Tmp_441: int;
  var {:scalar} MorePages: int;
  var {:dopa} {:scalar} BytesUsed_5: int;
  var {:scalar} SubunitAddrs: int;
  var {:pointer} SubunitInfoBytes_1: int;
  var {:scalar} Tmp_442: int;
  var {:pointer} Tmp_443: int;
  var {:scalar} Tmp_444: int;
  var {:dopa} {:scalar} SubunitAddr_6: int;
  var {:pointer} Tmp_445: int;
  var {:scalar} Tmp_446: int;
  var {:scalar} ntStatus_18: int;
  var {:scalar} Tmp_447: int;
  var {:dopa} {:scalar} SubunitAddr_7: int;
  var {:pointer} Command_17: int;
  var {:pointer} Tmp_449: int;
  var {:dopa} {:scalar} MaxSubunitID: int;
  var {:pointer} SubunitType_3: int;
  var {:dopa} {:scalar} BytesUsed_6: int;
  var {:scalar} HasSingleCameraSubunit: int;
  var {:scalar} HasSingleTapeSubunit: int;
  var {:scalar} StartOffset: int;
  var {:scalar} Tmp_451: int;
  var {:scalar} page: int;
  var {:pointer} BusExtension_9: int;
  var vslice_dummy_var_103: int;
  var vslice_dummy_var_46: int;
  var vslice_dummy_var_47: int;

  anon0:
    call {:si_unique_call 649} BytesUsed_5 := __HAVOC_malloc(4);
    call {:si_unique_call 650} SubunitAddr_6 := __HAVOC_malloc(4);
    call {:si_unique_call 651} vslice_dummy_var_103 := __HAVOC_malloc(4);
    call {:si_unique_call 652} SubunitAddr_7 := __HAVOC_malloc(4);
    call {:si_unique_call 653} Command_17 := __HAVOC_malloc(4);
    call {:si_unique_call 654} MaxSubunitID := __HAVOC_malloc(4);
    call {:si_unique_call 655} BytesUsed_6 := __HAVOC_malloc(4);
    BusExtension_9 := actual_BusExtension_9;
    call {:si_unique_call 656} SubunitAddr_5 := __HAVOC_malloc(128);
    call {:si_unique_call 657} SubunitInfoBytes_1 := __HAVOC_malloc(128);
    call {:si_unique_call 658} Tmp_449 := __HAVOC_malloc(2048);
    call {:si_unique_call 659} SubunitType_3 := __HAVOC_malloc(128);
    assume {:nonnull} Command_17 != 0;
    assume Command_17 > 0;
    ntStatus_18 := 0;
    call {:si_unique_call 660} sdv_do_paged_code_check();
    call {:si_unique_call 661} ntStatus_18 := AvcAllocateUnitCommandContext(BusExtension_9, Command_17);
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} ntStatus_18 == 0;
    SubunitAddrs := 0;
    StartOffset := 0;
    assume {:nonnull} BusExtension_9 != 0;
    assume BusExtension_9 > 0;
    goto anon94_Then, anon94_Else;

  anon94_Else:
    MorePages := 1;
    page := 0;
    call {:si_unique_call 662} sdv_RtlZeroMemory(0, 32);
    goto L107;

  L107:
    call {:si_unique_call 663} Tmp_441, MorePages, SubunitAddrs, Tmp_442, Tmp_444, Tmp_445, Tmp_446, ntStatus_18, Tmp_449, StartOffset, Tmp_451, page := Avc_EnumerateExtrnalChildren_loop_L107(Tmp_441, MorePages, BytesUsed_5, SubunitAddrs, SubunitInfoBytes_1, Tmp_442, Tmp_444, Tmp_445, Tmp_446, ntStatus_18, Command_17, Tmp_449, StartOffset, Tmp_451, page);
    goto L107_last;

  L107_last:
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} MorePages != 0;
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} 8 > page;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    assume {:partition} 32 > StartOffset;
    assume {:nonnull} Command_17 != 0;
    assume Command_17 > 0;
    havoc vslice_dummy_var_46;
    call {:si_unique_call 664} ntStatus_18 := AvcReq_SubUnitInfo(vslice_dummy_var_46, page);
    goto anon100_Then, anon100_Else;

  anon100_Else:
    assume {:partition} yogi_error != 1;
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} ntStatus_18 != 0;
    MorePages := 0;
    goto L117;

  L117:
    page := page + 1;
    goto L117_dummy;

  L117_dummy:
    assume false;
    return;

  anon91_Then:
    assume {:partition} ntStatus_18 == 0;
    assume {:nonnull} Command_17 != 0;
    assume Command_17 > 0;
    havoc Tmp_451;
    assume {:nonnull} Command_17 != 0;
    assume Command_17 > 0;
    havoc Tmp_449;
    Tmp_446 := page * 4;
    call {:si_unique_call 665} sdv_RtlCopyMemory(0, 0, 4);
    goto L123;

  L123:
    call {:si_unique_call 666} Tmp_441, SubunitAddrs, Tmp_442, Tmp_444, Tmp_445, ntStatus_18, StartOffset := Avc_EnumerateExtrnalChildren_loop_L123(Tmp_441, BytesUsed_5, SubunitAddrs, SubunitInfoBytes_1, Tmp_442, Tmp_444, Tmp_445, ntStatus_18, StartOffset);
    goto L123_last;

  L123_last:
    assume {:nonnull} BytesUsed_5 != 0;
    assume BytesUsed_5 > 0;
    Mem_T.INT4[BytesUsed_5] := 0;
    Tmp_441 := StartOffset;
    assume {:nonnull} SubunitInfoBytes_1 != 0;
    assume SubunitInfoBytes_1 > 0;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume {:partition} Mem_T.INT4[SubunitInfoBytes_1 + Tmp_441 * 4] == 255;
    MorePages := 0;
    goto L117;

  anon101_Then:
    assume {:partition} Mem_T.INT4[SubunitInfoBytes_1 + Tmp_441 * 4] != 255;
    Tmp_442 := 32 - StartOffset;
    Tmp_444 := StartOffset;
    Tmp_445 := SubunitInfoBytes_1 + Tmp_444 * 4;
    call {:si_unique_call 667} ntStatus_18 := AvcValidateSubunitAddress(Tmp_445, Tmp_442, BytesUsed_5);
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} ntStatus_18 != 0;
    assume {:nonnull} BytesUsed_5 != 0;
    assume BytesUsed_5 > 0;
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} INTMOD(StartOffset + Mem_T.INT4[BytesUsed_5], 4) != 0;
    MorePages := 0;
    goto L117;

  anon93_Then:
    assume {:partition} INTMOD(StartOffset + Mem_T.INT4[BytesUsed_5], 4) == 0;
    goto L117;

  anon92_Then:
    assume {:partition} ntStatus_18 == 0;
    assume {:nonnull} BytesUsed_5 != 0;
    assume BytesUsed_5 > 0;
    StartOffset := StartOffset + Mem_T.INT4[BytesUsed_5];
    SubunitAddrs := SubunitAddrs + 1;
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume {:partition} INTMOD(StartOffset, 4) != 0;
    goto anon102_Else_dummy;

  anon102_Else_dummy:
    assume false;
    return;

  anon102_Then:
    assume {:partition} INTMOD(StartOffset, 4) == 0;
    goto L117;

  anon100_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  LM2:
    return;

  anon90_Then:
    assume {:partition} StartOffset >= 32;
    goto L23;

  L23:
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} SubunitAddrs != 0;
    HasSingleTapeSubunit := 0;
    HasSingleCameraSubunit := 0;
    StartOffset := 0;
    goto L30;

  L30:
    call {:si_unique_call 668} SubunitID_2, SubunitAddrs, Tmp_443, ntStatus_18, Tmp_447, HasSingleCameraSubunit, HasSingleTapeSubunit, StartOffset := Avc_EnumerateExtrnalChildren_loop_L30(SubunitID_2, SubunitAddr_5, SubunitAddrs, SubunitInfoBytes_1, Tmp_443, ntStatus_18, Tmp_447, MaxSubunitID, SubunitType_3, BytesUsed_6, HasSingleCameraSubunit, HasSingleTapeSubunit, StartOffset, BusExtension_9);
    goto L30_last;

  L30_last:
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} SubunitAddrs != 0;
    Tmp_447 := StartOffset;
    Tmp_443 := SubunitInfoBytes_1 + Tmp_447 * 4;
    call {:si_unique_call 669} ntStatus_18 := AvcUnpackSubunitAddress(Tmp_443, SubunitType_3, MaxSubunitID, BytesUsed_6);
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} ntStatus_18 == 0;
    assume {:nonnull} SubunitType_3 != 0;
    assume SubunitType_3 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} Mem_T.INT4[SubunitType_3] == 4;
    assume {:nonnull} MaxSubunitID != 0;
    assume MaxSubunitID > 0;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} Mem_T.INT4[MaxSubunitID] == 0;
    HasSingleTapeSubunit := 1;
    goto L46;

  L46:
    assume {:nonnull} BytesUsed_6 != 0;
    assume BytesUsed_6 > 0;
    StartOffset := StartOffset + Mem_T.INT4[BytesUsed_6];
    SubunitAddrs := SubunitAddrs - 1;
    goto L46_dummy;

  L46_dummy:
    assume false;
    return;

  anon77_Then:
    assume {:partition} Mem_T.INT4[MaxSubunitID] != 0;
    goto L43;

  L43:
    assume {:nonnull} SubunitType_3 != 0;
    assume SubunitType_3 > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} Mem_T.INT4[SubunitType_3] != 7;
    goto L51;

  L51:
    SubunitID_2 := 0;
    goto L52;

  L52:
    call {:si_unique_call 670} SubunitID_2, ntStatus_18 := Avc_EnumerateExtrnalChildren_loop_L52(SubunitID_2, SubunitAddr_5, ntStatus_18, MaxSubunitID, SubunitType_3, BusExtension_9);
    goto L52_last;

  L52_last:
    assume {:nonnull} MaxSubunitID != 0;
    assume MaxSubunitID > 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} Mem_T.INT4[MaxSubunitID] >= SubunitID_2;
    call {:si_unique_call 671} ntStatus_18 := AvcPackSubunitAddress(SubunitType_3, SubunitID_2, 32, SubunitAddr_5, 0);
    call {:si_unique_call 672} Avc_FindOrCreatePDO(BusExtension_9, SubunitAddr_5, 3);
    goto anon98_Then, anon98_Else;

  anon98_Else:
    assume {:partition} yogi_error != 1;
    SubunitID_2 := SubunitID_2 + 1;
    goto anon98_Else_dummy;

  anon98_Else_dummy:
    assume false;
    return;

  anon98_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon79_Then:
    assume {:partition} SubunitID_2 > Mem_T.INT4[MaxSubunitID];
    goto L46;

  anon76_Then:
    assume {:partition} Mem_T.INT4[SubunitType_3] == 7;
    assume {:nonnull} MaxSubunitID != 0;
    assume MaxSubunitID > 0;
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} Mem_T.INT4[MaxSubunitID] != 0;
    goto L51;

  anon78_Then:
    assume {:partition} Mem_T.INT4[MaxSubunitID] == 0;
    HasSingleCameraSubunit := 1;
    goto L46;

  anon75_Then:
    assume {:partition} Mem_T.INT4[SubunitType_3] != 4;
    goto L43;

  anon74_Then:
    assume {:partition} ntStatus_18 != 0;
    goto L31;

  L31:
    assume {:nonnull} BusExtension_9 != 0;
    assume BusExtension_9 > 0;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    goto L63;

  L63:
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} HasSingleTapeSubunit != 0;
    assume {:nonnull} SubunitAddr_6 != 0;
    assume SubunitAddr_6 > 0;
    Mem_T.INT4[SubunitAddr_6] := 32;
    call {:si_unique_call 673} Avc_FindOrCreatePDO(BusExtension_9, SubunitAddr_6, 3);
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} yogi_error != 1;
    goto L64;

  L64:
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:partition} HasSingleCameraSubunit != 0;
    assume {:nonnull} SubunitAddr_7 != 0;
    assume SubunitAddr_7 > 0;
    Mem_T.INT4[SubunitAddr_7] := 56;
    call {:si_unique_call 674} Avc_FindOrCreatePDO(BusExtension_9, SubunitAddr_7, 3);
    goto anon96_Then, anon96_Else;

  anon96_Else:
    assume {:partition} yogi_error != 1;
    goto L70;

  L70:
    assume {:nonnull} Command_17 != 0;
    assume Command_17 > 0;
    havoc vslice_dummy_var_47;
    call {:si_unique_call 675} AvcFreeCommandContext(vslice_dummy_var_47);
    goto L1;

  L1:
    goto LM2;

  anon96_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon82_Then:
    assume {:partition} HasSingleCameraSubunit == 0;
    goto L70;

  anon95_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon81_Then:
    assume {:partition} HasSingleTapeSubunit == 0;
    goto L64;

  anon73_Then:
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} HasSingleTapeSubunit != 0;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} HasSingleCameraSubunit != 0;
    call {:si_unique_call 676} Avc_FindOrCreatePDO(BusExtension_9, 0, 0);
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} yogi_error != 1;
    HasSingleCameraSubunit := 0;
    HasSingleTapeSubunit := HasSingleCameraSubunit;
    goto L63;

  anon97_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon83_Then:
    assume {:partition} HasSingleCameraSubunit == 0;
    goto L63;

  anon80_Then:
    assume {:partition} HasSingleTapeSubunit == 0;
    goto L63;

  anon72_Then:
    assume {:partition} SubunitAddrs == 0;
    goto L31;

  anon70_Then:
    assume {:partition} SubunitAddrs == 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} ntStatus_18 != 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} -1073741822 != ntStatus_18;
    call {:si_unique_call 677} ExAcquireFastMutex(0);
    assume {:nonnull} BusExtension_9 != 0;
    assume BusExtension_9 > 0;
    havoc PdoData_4;
    goto L91;

  L91:
    call {:si_unique_call 678} PdoData_4 := Avc_EnumerateExtrnalChildren_loop_L91(PdoData_4);
    goto L91_last;

  L91_last:
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:nonnull} PdoData_4 != 0;
    assume PdoData_4 > 0;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:nonnull} PdoData_4 != 0;
    assume PdoData_4 > 0;
    goto L96;

  L96:
    assume {:nonnull} PdoData_4 != 0;
    assume PdoData_4 > 0;
    havoc PdoData_4;
    goto L96_dummy;

  L96_dummy:
    assume false;
    return;

  anon87_Then:
    goto L96;

  anon86_Then:
    call {:si_unique_call 679} ExReleaseFastMutex(0);
    goto L70;

  anon85_Then:
    assume {:partition} -1073741822 == ntStatus_18;
    goto L84;

  L84:
    assume {:nonnull} BusExtension_9 != 0;
    assume BusExtension_9 > 0;
    goto anon84_Then, anon84_Else;

  anon84_Else:
    call {:si_unique_call 680} Avc_FindOrCreatePDO(BusExtension_9, 0, 4);
    goto anon99_Then, anon99_Else;

  anon99_Else:
    assume {:partition} yogi_error != 1;
    goto L70;

  anon99_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon84_Then:
    goto L70;

  anon71_Then:
    assume {:partition} ntStatus_18 == 0;
    goto L84;

  anon89_Then:
    assume {:partition} page >= 8;
    goto L23;

  anon88_Then:
    assume {:partition} MorePages == 0;
    goto L23;

  anon94_Then:
    goto L23;

  anon69_Then:
    assume {:partition} ntStatus_18 != 0;
    goto L1;
}



procedure {:origName "Avc_EnumerateVirtualChildren"} Avc_EnumerateVirtualChildren(actual_BusExtension_10: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_EnumerateVirtualChildren"} Avc_EnumerateVirtualChildren(actual_BusExtension_10: int)
{
  var {:scalar} sdv_237: int;
  var {:pointer} Tmp_454: int;
  var {:pointer} QueryTable_1: int;
  var {:scalar} ntStatus_19: int;
  var {:pointer} sdv_241: int;
  var {:scalar} uniName_1: int;
  var {:pointer} ListHandle_1: int;
  var vslice_dummy_var_104: int;
  var vslice_dummy_var_105: int;
  var vslice_dummy_var_106: int;
  var vslice_dummy_var_107: int;
  var vslice_dummy_var_108: int;

  anon0:
    call {:si_unique_call 681} vslice_dummy_var_104 := __HAVOC_malloc(24);
    call {:si_unique_call 682} uniName_1 := __HAVOC_malloc(12);
    call {:si_unique_call 683} ListHandle_1 := __HAVOC_malloc(4);
    call {:si_unique_call 684} vslice_dummy_var_105 := __HAVOC_malloc(4);
    call {:si_unique_call 685} Tmp_454 := __HAVOC_malloc(80);
    call {:si_unique_call 686} sdv_do_paged_code_check();
    call {:si_unique_call 687} sdv_237 := sdv_IsListEmpty(0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} sdv_237 != 0;
    call {:si_unique_call 688} ntStatus_19 := IoOpenDeviceRegistryKey(0, 2, 983103, 0);
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} ntStatus_19 >= 0;
    Tmp_454 := strConst__li2bpl16;
    call {:si_unique_call 689} RtlInitUnicodeString(uniName_1, Tmp_454);
    call {:si_unique_call 690} sdv_InitializeObjectAttributes(0, 0, 576, 0, 0);
    call {:si_unique_call 691} ntStatus_19 := ZwOpenKey(ListHandle_1, 983103, 0);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} ntStatus_19 >= 0;
    call {:si_unique_call 692} sdv_241 := sdv_ExAllocateFromNPagedLookasideList(0);
    QueryTable_1 := sdv_241;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} QueryTable_1 != 0;
    call {:si_unique_call 693} sdv_RtlZeroMemory(0, 56);
    assume {:nonnull} QueryTable_1 != 0;
    assume QueryTable_1 > 0;
    assume {:nonnull} QueryTable_1 != 0;
    assume QueryTable_1 > 0;
    call {:si_unique_call 694} vslice_dummy_var_108 := sdv_RtlQueryRegistryValues(-1073741824, 0, 0, 0, 0);
    call {:si_unique_call 695} ExFreeToNPagedLookasideList(AvcQueryTablePool, QueryTable_1);
    goto L42;

  L42:
    call {:si_unique_call 696} vslice_dummy_var_107 := ZwClose(0);
    goto L33;

  L33:
    call {:si_unique_call 697} vslice_dummy_var_106 := ZwClose(0);
    goto L1;

  L1:
    return;

  anon12_Then:
    assume {:partition} QueryTable_1 == 0;
    goto L42;

  anon11_Then:
    assume {:partition} 0 > ntStatus_19;
    goto L33;

  anon10_Then:
    assume {:partition} 0 > ntStatus_19;
    goto L1;

  anon9_Then:
    assume {:partition} sdv_237 == 0;
    goto L1;
}



procedure {:origName "Avc_Pnp"} Avc_Pnp(actual_DeviceObject_21: int, actual_Irp_24: int) returns (Tmp_457: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_Pnp"} Avc_Pnp(actual_DeviceObject_21: int, actual_Irp_24: int) returns (Tmp_457: int)
{
  var {:pointer} IrpStack_5: int;
  var {:scalar} ntStatus_20: int;
  var {:pointer} CommonExtension_4: int;
  var {:scalar} MinorFunction: int;
  var {:pointer} DeviceObject_21: int;
  var {:pointer} Irp_24: int;

  anon0:
    DeviceObject_21 := actual_DeviceObject_21;
    Irp_24 := actual_Irp_24;
    assume {:nonnull} DeviceObject_21 != 0;
    assume DeviceObject_21 > 0;
    havoc CommonExtension_4;
    call {:si_unique_call 698} sdv_do_paged_code_check();
    call {:si_unique_call 699} IrpStack_5 := sdv_IoGetCurrentIrpStackLocation(Irp_24);
    assume {:nonnull} IrpStack_5 != 0;
    assume IrpStack_5 > 0;
    havoc MinorFunction;
    assume {:nonnull} CommonExtension_4 != 0;
    assume CommonExtension_4 > 0;
    call {:si_unique_call 700} ntStatus_20 := AvcAcquireRemoveLock(RemoveLock__COMMON_DEVICE_EXTENSION(CommonExtension_4));
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} ntStatus_20 != 0;
    ntStatus_20 := -1073741810;
    assume {:nonnull} Irp_24 != 0;
    assume Irp_24 > 0;
    call {:si_unique_call 701} sdv_IoCompleteRequest(0, 0);
    goto L27;

  L27:
    Tmp_457 := ntStatus_20;
    goto LM2;

  LM2:
    return;

  anon13_Then:
    assume {:partition} ntStatus_20 == 0;
    assume {:nonnull} CommonExtension_4 != 0;
    assume CommonExtension_4 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    call {:si_unique_call 702} ntStatus_20 := Avc_PDO_Pnp(DeviceObject_21, Irp_24);
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} yogi_error != 1;
    goto L33;

  L33:
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} 2 != MinorFunction;
    assume {:nonnull} CommonExtension_4 != 0;
    assume CommonExtension_4 > 0;
    call {:si_unique_call 703} AvcReleaseRemoveLock(RemoveLock__COMMON_DEVICE_EXTENSION(CommonExtension_4));
    goto L27;

  anon16_Then:
    assume {:partition} 2 == MinorFunction;
    goto L27;

  anon17_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon14_Then:
    assume {:nonnull} CommonExtension_4 != 0;
    assume CommonExtension_4 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    call {:si_unique_call 704} ntStatus_20 := Avc_FDO_Pnp(DeviceObject_21, Irp_24);
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} yogi_error != 1;
    goto L33;

  anon18_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon15_Then:
    goto L33;
}



procedure {:origName "Avc_BuildIds"} Avc_BuildIds(actual_BusExtension_11: int, actual_PdoData_5: int, actual_SubunitAddr_8: int, actual_bidFlag: int) returns (Tmp_459: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_459 == -1073741670 || Tmp_459 == -1073741811 || Tmp_459 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_BuildIds"} Avc_BuildIds(actual_BusExtension_11: int, actual_PdoData_5: int, actual_SubunitAddr_8: int, actual_bidFlag: int) returns (Tmp_459: int)
{
  var {:scalar} Tmp_460: int;
  var {:scalar} Tmp_465: int;
  var {:pointer} SubunitJunk: int;
  var {:scalar} Tmp_469: int;
  var {:scalar} Tmp_472: int;
  var {:dopa} {:scalar} SubunitId_1: int;
  var {:pointer} sdv_267: int;
  var {:scalar} Tmp_473: int;
  var {:scalar} Tmp_474: int;
  var {:pointer} sdv_270: int;
  var {:pointer} UnitInfo: int;
  var {:pointer} sdv_275: int;
  var {:scalar} uniTemp: int;
  var {:pointer} sdv_283: int;
  var {:scalar} Tmp_484: int;
  var {:scalar} Tmp_485: int;
  var {:scalar} Tmp_488: int;
  var {:scalar} uniModelName: int;
  var {:scalar} Tmp_491: int;
  var {:dopa} {:scalar} SubunitAddrLen_1: int;
  var {:scalar} uniVendorName: int;
  var {:scalar} Tmp_494: int;
  var {:pointer} sdv_301: int;
  var {:scalar} Tmp_497: int;
  var {:scalar} Tmp_498: int;
  var {:scalar} Tmp_500: int;
  var {:scalar} Tmp_502: int;
  var {:pointer} sdv_309: int;
  var {:scalar} NumberHardwareIds: int;
  var {:scalar} ntStatus_21: int;
  var {:pointer} szTemp: int;
  var {:scalar} Tmp_506: int;
  var {:pointer} sdv_314: int;
  var {:scalar} uniSubunitId: int;
  var {:scalar} Tmp_508: int;
  var {:scalar} uniSubunitType: int;
  var {:scalar} idx_9: int;
  var {:pointer} SubunitType_4: int;
  var {:scalar} NumberCompatIds: int;
  var {:scalar} Tmp_511: int;
  var {:pointer} sdv_327: int;
  var {:pointer} BusExtension_11: int;
  var {:pointer} PdoData_5: int;
  var {:pointer} SubunitAddr_8: int;
  var {:scalar} bidFlag: int;
  var vslice_dummy_var_109: int;
  var vslice_dummy_var_110: int;
  var vslice_dummy_var_111: int;
  var vslice_dummy_var_112: int;
  var vslice_dummy_var_113: int;
  var vslice_dummy_var_114: int;
  var vslice_dummy_var_115: int;
  var vslice_dummy_var_116: int;
  var vslice_dummy_var_117: int;
  var vslice_dummy_var_118: int;
  var vslice_dummy_var_119: int;
  var vslice_dummy_var_120: int;
  var vslice_dummy_var_121: int;
  var vslice_dummy_var_122: int;
  var vslice_dummy_var_123: int;
  var vslice_dummy_var_124: int;
  var vslice_dummy_var_125: int;
  var vslice_dummy_var_126: int;
  var vslice_dummy_var_127: int;
  var vslice_dummy_var_128: int;
  var vslice_dummy_var_129: int;
  var vslice_dummy_var_130: int;
  var vslice_dummy_var_131: int;
  var vslice_dummy_var_132: int;
  var vslice_dummy_var_133: int;
  var vslice_dummy_var_134: int;
  var vslice_dummy_var_135: int;
  var vslice_dummy_var_136: int;
  var vslice_dummy_var_137: int;
  var vslice_dummy_var_138: int;
  var vslice_dummy_var_139: int;
  var vslice_dummy_var_140: int;
  var vslice_dummy_var_141: int;
  var vslice_dummy_var_142: int;
  var vslice_dummy_var_143: int;
  var vslice_dummy_var_144: int;
  var vslice_dummy_var_145: int;
  var vslice_dummy_var_146: int;
  var vslice_dummy_var_147: int;
  var vslice_dummy_var_148: int;
  var vslice_dummy_var_149: int;
  var vslice_dummy_var_150: int;
  var vslice_dummy_var_151: int;
  var vslice_dummy_var_152: int;
  var vslice_dummy_var_153: int;
  var vslice_dummy_var_154: int;
  var vslice_dummy_var_155: int;
  var vslice_dummy_var_156: int;
  var vslice_dummy_var_157: int;
  var vslice_dummy_var_158: int;
  var vslice_dummy_var_159: int;
  var vslice_dummy_var_160: int;
  var vslice_dummy_var_161: int;
  var vslice_dummy_var_162: int;
  var vslice_dummy_var_163: int;
  var vslice_dummy_var_164: int;
  var vslice_dummy_var_165: int;
  var vslice_dummy_var_166: int;
  var vslice_dummy_var_167: int;
  var vslice_dummy_var_168: int;
  var vslice_dummy_var_169: int;
  var vslice_dummy_var_170: int;
  var vslice_dummy_var_171: int;
  var vslice_dummy_var_172: int;
  var vslice_dummy_var_173: int;
  var vslice_dummy_var_174: int;
  var vslice_dummy_var_175: int;
  var vslice_dummy_var_176: int;
  var vslice_dummy_var_177: int;
  var vslice_dummy_var_178: int;
  var vslice_dummy_var_179: int;
  var vslice_dummy_var_180: int;
  var vslice_dummy_var_181: int;
  var vslice_dummy_var_182: int;
  var vslice_dummy_var_183: int;
  var vslice_dummy_var_184: int;
  var vslice_dummy_var_185: int;
  var vslice_dummy_var_186: int;
  var vslice_dummy_var_187: int;
  var vslice_dummy_var_188: int;
  var vslice_dummy_var_189: int;
  var vslice_dummy_var_190: int;
  var vslice_dummy_var_191: int;
  var vslice_dummy_var_192: int;
  var vslice_dummy_var_193: int;
  var vslice_dummy_var_194: int;
  var vslice_dummy_var_195: int;
  var vslice_dummy_var_196: int;
  var vslice_dummy_var_197: int;
  var vslice_dummy_var_198: int;
  var vslice_dummy_var_199: int;
  var vslice_dummy_var_200: int;
  var vslice_dummy_var_201: int;
  var vslice_dummy_var_202: int;
  var vslice_dummy_var_203: int;
  var vslice_dummy_var_204: int;
  var vslice_dummy_var_205: int;
  var vslice_dummy_var_206: int;
  var vslice_dummy_var_207: int;
  var vslice_dummy_var_208: int;
  var vslice_dummy_var_209: int;
  var vslice_dummy_var_210: int;
  var vslice_dummy_var_211: int;
  var vslice_dummy_var_212: int;
  var vslice_dummy_var_48: int;
  var vslice_dummy_var_49: int;
  var vslice_dummy_var_50: int;

  anon0:
    call {:si_unique_call 705} SubunitId_1 := __HAVOC_malloc(4);
    call {:si_unique_call 706} uniTemp := __HAVOC_malloc(12);
    call {:si_unique_call 707} uniModelName := __HAVOC_malloc(12);
    call {:si_unique_call 708} SubunitAddrLen_1 := __HAVOC_malloc(4);
    call {:si_unique_call 709} uniVendorName := __HAVOC_malloc(12);
    call {:si_unique_call 710} uniSubunitId := __HAVOC_malloc(12);
    call {:si_unique_call 711} uniSubunitType := __HAVOC_malloc(12);
    BusExtension_11 := actual_BusExtension_11;
    PdoData_5 := actual_PdoData_5;
    SubunitAddr_8 := actual_SubunitAddr_8;
    bidFlag := actual_bidFlag;
    call {:si_unique_call 712} vslice_dummy_var_144 := __HAVOC_malloc(8);
    call {:si_unique_call 713} vslice_dummy_var_145 := __HAVOC_malloc(16);
    call {:si_unique_call 714} vslice_dummy_var_146 := __HAVOC_malloc(20);
    call {:si_unique_call 715} vslice_dummy_var_147 := __HAVOC_malloc(8);
    call {:si_unique_call 716} vslice_dummy_var_148 := __HAVOC_malloc(20);
    call {:si_unique_call 717} SubunitJunk := __HAVOC_malloc(128);
    call {:si_unique_call 718} vslice_dummy_var_149 := __HAVOC_malloc(20);
    call {:si_unique_call 719} vslice_dummy_var_150 := __HAVOC_malloc(40);
    call {:si_unique_call 720} vslice_dummy_var_151 := __HAVOC_malloc(20);
    call {:si_unique_call 721} vslice_dummy_var_152 := __HAVOC_malloc(20);
    call {:si_unique_call 722} vslice_dummy_var_153 := __HAVOC_malloc(8);
    call {:si_unique_call 723} vslice_dummy_var_154 := __HAVOC_malloc(20);
    call {:si_unique_call 724} vslice_dummy_var_155 := __HAVOC_malloc(20);
    call {:si_unique_call 725} vslice_dummy_var_156 := __HAVOC_malloc(16);
    call {:si_unique_call 726} vslice_dummy_var_157 := __HAVOC_malloc(8);
    call {:si_unique_call 727} vslice_dummy_var_158 := __HAVOC_malloc(32);
    call {:si_unique_call 728} vslice_dummy_var_159 := __HAVOC_malloc(20);
    call {:si_unique_call 729} vslice_dummy_var_160 := __HAVOC_malloc(24);
    call {:si_unique_call 730} vslice_dummy_var_161 := __HAVOC_malloc(20);
    call {:si_unique_call 731} vslice_dummy_var_162 := __HAVOC_malloc(24);
    call {:si_unique_call 732} vslice_dummy_var_163 := __HAVOC_malloc(20);
    call {:si_unique_call 733} vslice_dummy_var_164 := __HAVOC_malloc(16);
    call {:si_unique_call 734} vslice_dummy_var_165 := __HAVOC_malloc(16);
    call {:si_unique_call 735} vslice_dummy_var_166 := __HAVOC_malloc(20);
    call {:si_unique_call 736} vslice_dummy_var_167 := __HAVOC_malloc(20);
    call {:si_unique_call 737} vslice_dummy_var_168 := __HAVOC_malloc(8);
    call {:si_unique_call 738} vslice_dummy_var_169 := __HAVOC_malloc(24);
    call {:si_unique_call 739} szTemp := __HAVOC_malloc(8);
    call {:si_unique_call 740} vslice_dummy_var_170 := __HAVOC_malloc(20);
    call {:si_unique_call 741} vslice_dummy_var_171 := __HAVOC_malloc(8);
    call {:si_unique_call 742} SubunitType_4 := __HAVOC_malloc(128);
    call {:si_unique_call 743} vslice_dummy_var_172 := __HAVOC_malloc(16);
    call {:si_unique_call 744} vslice_dummy_var_173 := __HAVOC_malloc(16);
    call {:si_unique_call 745} vslice_dummy_var_174 := __HAVOC_malloc(16);
    ntStatus_21 := 0;
    NumberCompatIds := 0;
    NumberHardwareIds := 0;
    assume {:nonnull} BusExtension_11 != 0;
    assume BusExtension_11 > 0;
    UnitInfo := UnitIDs__BUS_DEVICE_EXTENSION(BusExtension_11);
    call {:si_unique_call 746} sdv_do_paged_code_check();
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto anon208_Then, anon208_Else;

  anon208_Else:
    assume {:partition} 5 == bidFlag;
    goto L23;

  L23:
    call {:si_unique_call 747} RtlInitUnicodeString(uniVendorName, 0);
    call {:si_unique_call 748} RtlInitUnicodeString(uniModelName, 0);
    call {:si_unique_call 749} RtlInitUnicodeString(uniSubunitType, 0);
    call {:si_unique_call 750} RtlInitUnicodeString(uniSubunitId, 0);
    assume {:nonnull} uniVendorName != 0;
    assume uniVendorName > 0;
    assume {:nonnull} uniVendorName != 0;
    assume uniVendorName > 0;
    havoc Tmp_469;
    call {:si_unique_call 751} sdv_301 := ExAllocatePoolWithTag(1, Tmp_469, 541283905);
    assume {:nonnull} uniVendorName != 0;
    assume uniVendorName > 0;
    assume {:nonnull} uniVendorName != 0;
    assume uniVendorName > 0;
    goto anon209_Then, anon209_Else;

  anon209_Else:
    assume {:nonnull} uniVendorName != 0;
    assume uniVendorName > 0;
    havoc Tmp_491;
    call {:si_unique_call 752} sdv_RtlZeroMemory(0, Tmp_491);
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon145_Then, anon145_Else;

  anon145_Else:
    call {:si_unique_call 753} vslice_dummy_var_110 := corral_nondet();
    goto L54;

  L54:
    assume {:nonnull} uniModelName != 0;
    assume uniModelName > 0;
    assume {:nonnull} uniModelName != 0;
    assume uniModelName > 0;
    havoc Tmp_494;
    call {:si_unique_call 754} sdv_275 := ExAllocatePoolWithTag(1, Tmp_494, 541283905);
    assume {:nonnull} uniModelName != 0;
    assume uniModelName > 0;
    assume {:nonnull} uniModelName != 0;
    assume uniModelName > 0;
    goto anon210_Then, anon210_Else;

  anon210_Else:
    assume {:nonnull} uniModelName != 0;
    assume uniModelName > 0;
    havoc Tmp_485;
    call {:si_unique_call 755} sdv_RtlZeroMemory(0, Tmp_485);
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon146_Then, anon146_Else;

  anon146_Else:
    call {:si_unique_call 756} vslice_dummy_var_111 := corral_nondet();
    goto L71;

  L71:
    goto anon148_Then, anon148_Else;

  anon148_Else:
    assume {:partition} bidFlag != 4;
    assume {:nonnull} uniSubunitType != 0;
    assume uniSubunitType > 0;
    assume {:nonnull} uniSubunitType != 0;
    assume uniSubunitType > 0;
    havoc Tmp_508;
    call {:si_unique_call 757} sdv_267 := ExAllocatePoolWithTag(1, Tmp_508, 541283905);
    assume {:nonnull} uniSubunitType != 0;
    assume uniSubunitType > 0;
    assume {:nonnull} uniSubunitType != 0;
    assume uniSubunitType > 0;
    goto anon211_Then, anon211_Else;

  anon211_Else:
    assume {:nonnull} uniSubunitType != 0;
    assume uniSubunitType > 0;
    havoc Tmp_460;
    call {:si_unique_call 758} sdv_RtlZeroMemory(0, Tmp_460);
    goto anon150_Then, anon150_Else;

  anon150_Else:
    assume {:partition} bidFlag != 1;
    goto anon151_Then, anon151_Else;

  anon151_Else:
    assume {:partition} bidFlag != 0;
    assume {:nonnull} uniSubunitId != 0;
    assume uniSubunitId > 0;
    assume {:nonnull} uniSubunitId != 0;
    assume uniSubunitId > 0;
    havoc Tmp_488;
    call {:si_unique_call 759} sdv_283 := ExAllocatePoolWithTag(1, Tmp_488, 541283905);
    assume {:nonnull} uniSubunitId != 0;
    assume uniSubunitId > 0;
    assume {:nonnull} uniSubunitId != 0;
    assume uniSubunitId > 0;
    goto anon212_Then, anon212_Else;

  anon212_Else:
    assume {:nonnull} uniSubunitId != 0;
    assume uniSubunitId > 0;
    havoc Tmp_474;
    call {:si_unique_call 760} sdv_RtlZeroMemory(0, Tmp_474);
    goto L72;

  L72:
    goto anon149_Then, anon149_Else;

  anon149_Else:
    assume {:partition} bidFlag != 0;
    goto anon197_Then, anon197_Else;

  anon197_Else:
    assume {:partition} bidFlag != 1;
    goto anon196_Then, anon196_Else;

  anon196_Else:
    assume {:partition} bidFlag != 2;
    goto anon195_Then, anon195_Else;

  anon195_Else:
    assume {:partition} bidFlag != 3;
    goto anon194_Then, anon194_Else;

  anon194_Else:
    assume {:partition} bidFlag != 4;
    goto anon193_Then, anon193_Else;

  anon193_Else:
    assume {:partition} bidFlag == 5;
    goto L414;

  L414:
    assume {:nonnull} SubunitAddrLen_1 != 0;
    assume SubunitAddrLen_1 > 0;
    Mem_T.INT4[SubunitAddrLen_1] := 0;
    call {:si_unique_call 761} ntStatus_21 := AvcUnpackSubunitAddress(SubunitAddr_8, SubunitType_4, SubunitId_1, SubunitAddrLen_1);
    assume {:nonnull} SubunitAddrLen_1 != 0;
    assume SubunitAddrLen_1 > 0;
    call {:si_unique_call 762} sdv_314 := ExAllocatePoolWithTag(512, Mem_T.INT4[SubunitAddrLen_1], 541283905);
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto anon216_Then, anon216_Else;

  anon216_Else:
    szTemp := strConst__li2bpl29;
    assume {:nonnull} SubunitAddrLen_1 != 0;
    assume SubunitAddrLen_1 > 0;
    call {:si_unique_call 763} sdv_RtlCopyMemory(0, 0, Mem_T.INT4[SubunitAddrLen_1]);
    call {:si_unique_call 764} RtlInitUnicodeString(uniTemp, szTemp);
    call {:si_unique_call 765} ntStatus_21 := AvcPackSubunitAddress(SubunitType_4, 0, 32, SubunitJunk, SubunitAddrLen_1);
    idx_9 := 0;
    goto L441;

  L441:
    call {:si_unique_call 766} Tmp_484, Tmp_500, Tmp_502, idx_9, Tmp_511, vslice_dummy_var_139, vslice_dummy_var_140, vslice_dummy_var_210, vslice_dummy_var_211, vslice_dummy_var_212 := Avc_BuildIds_loop_L441(Tmp_484, SubunitAddrLen_1, Tmp_500, Tmp_502, idx_9, SubunitType_4, Tmp_511, vslice_dummy_var_139, vslice_dummy_var_140, vslice_dummy_var_210, vslice_dummy_var_211, vslice_dummy_var_212);
    goto L441_last;

  L441_last:
    assume {:nonnull} SubunitAddrLen_1 != 0;
    assume SubunitAddrLen_1 > 0;
    goto anon190_Then, anon190_Else;

  anon190_Else:
    assume {:partition} Mem_T.INT4[SubunitAddrLen_1] > idx_9;
    goto anon191_Then, anon191_Else;

  anon191_Else:
    assume {:partition} idx_9 != 0;
    call {:si_unique_call 767} Tmp_484 := corral_nondet();
    call {:si_unique_call 768} vslice_dummy_var_210 := RtlIntegerToUnicodeString(Tmp_484, 16, 0);
    call {:si_unique_call 769} vslice_dummy_var_139 := corral_nondet();
    Tmp_502 := idx_9;
    assume {:nonnull} SubunitType_4 != 0;
    assume SubunitType_4 > 0;
    Tmp_511 := BAND(Mem_T.INT4[SubunitType_4 + Tmp_502 * 4], BOR(BOR(BOR(1, 2), 4), 8));
    call {:si_unique_call 770} vslice_dummy_var_211 := RtlIntegerToUnicodeString(Tmp_511, 16, 0);
    call {:si_unique_call 771} vslice_dummy_var_140 := corral_nondet();
    goto L461;

  L461:
    idx_9 := idx_9 + 1;
    goto L461_dummy;

  L461_dummy:
    assume false;
    return;

  anon191_Then:
    assume {:partition} idx_9 == 0;
    assume {:nonnull} SubunitType_4 != 0;
    assume SubunitType_4 > 0;
    Tmp_500 := Mem_T.INT4[SubunitType_4];
    call {:si_unique_call 772} vslice_dummy_var_212 := RtlIntegerToUnicodeString(Tmp_500, 16, 0);
    goto L461;

  anon190_Then:
    assume {:partition} idx_9 >= Mem_T.INT4[SubunitAddrLen_1];
    assume {:nonnull} SubunitId_1 != 0;
    assume SubunitId_1 > 0;
    call {:si_unique_call 773} vslice_dummy_var_138 := RtlIntegerToUnicodeString(Mem_T.INT4[SubunitId_1], 16, 0);
    NumberHardwareIds := 2;
    NumberCompatIds := 2;
    goto L153;

  L153:
    goto anon161_Then, anon161_Else;

  anon161_Else:
    assume {:partition} ntStatus_21 == 0;
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    havoc Tmp_473;
    call {:si_unique_call 774} sdv_270 := ExAllocatePoolWithTag(512, Tmp_473, 541283905);
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto anon213_Then, anon213_Else;

  anon213_Else:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    havoc Tmp_497;
    call {:si_unique_call 775} sdv_RtlZeroMemory(0, Tmp_497);
    goto anon162_Then, anon162_Else;

  anon162_Else:
    assume {:partition} bidFlag != 0;
    goto anon202_Then, anon202_Else;

  anon202_Else:
    assume {:partition} bidFlag != 1;
    goto anon201_Then, anon201_Else;

  anon201_Else:
    assume {:partition} bidFlag != 2;
    goto anon200_Then, anon200_Else;

  anon200_Else:
    assume {:partition} bidFlag != 3;
    goto anon199_Then, anon199_Else;

  anon199_Else:
    assume {:partition} bidFlag != 4;
    goto anon198_Then, anon198_Else;

  anon198_Else:
    assume {:partition} bidFlag == 5;
    goto L172;

  L172:
    call {:si_unique_call 776} vslice_dummy_var_113 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon167_Then, anon167_Else;

  anon167_Else:
    goto L202;

  L202:
    call {:si_unique_call 777} vslice_dummy_var_117 := corral_nondet();
    call {:si_unique_call 778} vslice_dummy_var_195 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon168_Then, anon168_Else;

  anon168_Else:
    goto L210;

  L210:
    call {:si_unique_call 779} vslice_dummy_var_118 := corral_nondet();
    call {:si_unique_call 780} vslice_dummy_var_196 := corral_nondet();
    call {:si_unique_call 781} vslice_dummy_var_119 := corral_nondet();
    call {:si_unique_call 782} vslice_dummy_var_197 := corral_nondet();
    call {:si_unique_call 783} vslice_dummy_var_120 := corral_nondet();
    goto anon170_Then, anon170_Else;

  anon170_Else:
    assume {:partition} 2 == bidFlag;
    call {:si_unique_call 784} vslice_dummy_var_198 := corral_nondet();
    goto L226;

  L226:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 785} vslice_dummy_var_199 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon171_Then, anon171_Else;

  anon171_Else:
    goto L237;

  L237:
    call {:si_unique_call 786} vslice_dummy_var_121 := corral_nondet();
    call {:si_unique_call 787} vslice_dummy_var_200 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon172_Then, anon172_Else;

  anon172_Else:
    goto L245;

  L245:
    call {:si_unique_call 788} vslice_dummy_var_122 := corral_nondet();
    call {:si_unique_call 789} vslice_dummy_var_201 := corral_nondet();
    call {:si_unique_call 790} vslice_dummy_var_123 := corral_nondet();
    goto anon174_Then, anon174_Else;

  anon174_Else:
    assume {:partition} 2 == bidFlag;
    call {:si_unique_call 791} vslice_dummy_var_202 := corral_nondet();
    goto L168;

  L168:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    havoc Tmp_498;
    call {:si_unique_call 792} sdv_309 := ExAllocatePoolWithTag(512, Tmp_498, 541283905);
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto anon214_Then, anon214_Else;

  anon214_Else:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    havoc Tmp_506;
    call {:si_unique_call 793} sdv_RtlZeroMemory(0, Tmp_506);
    goto anon182_Then, anon182_Else;

  anon182_Else:
    assume {:partition} bidFlag != 0;
    goto anon207_Then, anon207_Else;

  anon207_Else:
    assume {:partition} bidFlag != 1;
    goto anon206_Then, anon206_Else;

  anon206_Else:
    assume {:partition} bidFlag != 2;
    goto anon205_Then, anon205_Else;

  anon205_Else:
    assume {:partition} bidFlag != 3;
    goto anon204_Then, anon204_Else;

  anon204_Else:
    assume {:partition} bidFlag != 4;
    goto anon203_Then, anon203_Else;

  anon203_Else:
    assume {:partition} bidFlag == 5;
    goto L313;

  L313:
    call {:si_unique_call 794} vslice_dummy_var_128 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon184_Then, anon184_Else;

  anon184_Else:
    goto L338;

  L338:
    call {:si_unique_call 795} vslice_dummy_var_131 := corral_nondet();
    call {:si_unique_call 796} vslice_dummy_var_184 := corral_nondet();
    call {:si_unique_call 797} vslice_dummy_var_132 := corral_nondet();
    goto anon185_Then, anon185_Else;

  anon185_Else:
    assume {:partition} 2 == bidFlag;
    call {:si_unique_call 798} vslice_dummy_var_185 := corral_nondet();
    goto L348;

  L348:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 799} vslice_dummy_var_186 := corral_nondet();
    call {:si_unique_call 800} vslice_dummy_var_187 := corral_nondet();
    call {:si_unique_call 801} vslice_dummy_var_133 := corral_nondet();
    goto anon186_Then, anon186_Else;

  anon186_Else:
    assume {:partition} 2 == bidFlag;
    call {:si_unique_call 802} vslice_dummy_var_188 := corral_nondet();
    goto L309;

  L309:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    havoc Tmp_465;
    call {:si_unique_call 803} sdv_327 := ExAllocatePoolWithTag(512, Tmp_465, 541283905);
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto anon215_Then, anon215_Else;

  anon215_Else:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    havoc Tmp_472;
    call {:si_unique_call 804} sdv_RtlZeroMemory(0, Tmp_472);
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    call {:si_unique_call 805} vslice_dummy_var_137 := RtlLargeIntegerToUnicodeString(UniqueID__GET_UNIT_IDS(UnitInfo), 16, UniqueId__PDO_DATA(PdoData_5));
    goto L100;

  L100:
    assume {:nonnull} uniVendorName != 0;
    assume uniVendorName > 0;
    goto anon152_Then, anon152_Else;

  anon152_Else:
    call {:si_unique_call 806} sdv_ExFreePool(0);
    goto L101;

  L101:
    assume {:nonnull} uniModelName != 0;
    assume uniModelName > 0;
    goto anon153_Then, anon153_Else;

  anon153_Else:
    call {:si_unique_call 807} sdv_ExFreePool(0);
    goto L105;

  L105:
    assume {:nonnull} uniSubunitType != 0;
    assume uniSubunitType > 0;
    goto anon154_Then, anon154_Else;

  anon154_Else:
    call {:si_unique_call 808} sdv_ExFreePool(0);
    goto L109;

  L109:
    assume {:nonnull} uniSubunitId != 0;
    assume uniSubunitId > 0;
    goto anon155_Then, anon155_Else;

  anon155_Else:
    call {:si_unique_call 809} sdv_ExFreePool(0);
    goto L113;

  L113:
    goto anon156_Then, anon156_Else;

  anon156_Else:
    assume {:partition} ntStatus_21 != 0;
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto anon157_Then, anon157_Else;

  anon157_Else:
    call {:si_unique_call 810} sdv_ExFreePool(0);
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto L119;

  L119:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto anon158_Then, anon158_Else;

  anon158_Else:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 811} sdv_ExFreePool(0);
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 812} RtlInitUnicodeString(HardwareIds__PDO_DATA(PdoData_5), 0);
    goto L124;

  L124:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto anon159_Then, anon159_Else;

  anon159_Else:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 813} sdv_ExFreePool(0);
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 814} RtlInitUnicodeString(CompatIds__PDO_DATA(PdoData_5), 0);
    goto L131;

  L131:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    goto anon160_Then, anon160_Else;

  anon160_Else:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 815} sdv_ExFreePool(0);
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 816} RtlInitUnicodeString(UniqueId__PDO_DATA(PdoData_5), 0);
    goto L117;

  L117:
    Tmp_459 := ntStatus_21;
    return;

  anon160_Then:
    goto L117;

  anon159_Then:
    goto L131;

  anon158_Then:
    goto L124;

  anon157_Then:
    goto L119;

  anon156_Then:
    assume {:partition} ntStatus_21 == 0;
    goto L117;

  anon155_Then:
    goto L113;

  anon154_Then:
    goto L109;

  anon153_Then:
    goto L105;

  anon152_Then:
    goto L101;

  anon215_Then:
    ntStatus_21 := -1073741670;
    goto L100;

  anon186_Then:
    assume {:partition} 2 != bidFlag;
    goto L309;

  anon185_Then:
    assume {:partition} 2 != bidFlag;
    goto L348;

  anon184_Then:
    call {:si_unique_call 817} vslice_dummy_var_189 := corral_nondet();
    goto L338;

  anon203_Then:
    assume {:partition} bidFlag != 5;
    goto L309;

  anon204_Then:
    assume {:partition} bidFlag == 4;
    call {:si_unique_call 818} vslice_dummy_var_129 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon183_Then, anon183_Else;

  anon183_Else:
    goto L323;

  L323:
    call {:si_unique_call 819} vslice_dummy_var_130 := corral_nondet();
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 820} vslice_dummy_var_190 := corral_nondet();
    call {:si_unique_call 821} vslice_dummy_var_191 := corral_nondet();
    goto L309;

  anon183_Then:
    call {:si_unique_call 822} vslice_dummy_var_192 := corral_nondet();
    goto L323;

  anon205_Then:
    assume {:partition} bidFlag == 3;
    goto L313;

  anon206_Then:
    assume {:partition} bidFlag == 2;
    goto L313;

  anon207_Then:
    assume {:partition} bidFlag == 1;
    goto L310;

  L310:
    call {:si_unique_call 823} vslice_dummy_var_127 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon187_Then, anon187_Else;

  anon187_Else:
    goto L370;

  L370:
    call {:si_unique_call 824} vslice_dummy_var_134 := corral_nondet();
    call {:si_unique_call 825} vslice_dummy_var_179 := corral_nondet();
    call {:si_unique_call 826} vslice_dummy_var_135 := corral_nondet();
    goto anon188_Then, anon188_Else;

  anon188_Else:
    assume {:partition} 1 == bidFlag;
    call {:si_unique_call 827} vslice_dummy_var_180 := corral_nondet();
    goto L380;

  L380:
    assume {:nonnull} PdoData_5 != 0;
    assume PdoData_5 > 0;
    call {:si_unique_call 828} vslice_dummy_var_181 := corral_nondet();
    call {:si_unique_call 829} vslice_dummy_var_136 := corral_nondet();
    goto anon189_Then, anon189_Else;

  anon189_Else:
    assume {:partition} 1 == bidFlag;
    call {:si_unique_call 830} vslice_dummy_var_182 := corral_nondet();
    goto L309;

  anon189_Then:
    assume {:partition} 1 != bidFlag;
    goto L309;

  anon188_Then:
    assume {:partition} 1 != bidFlag;
    goto L380;

  anon187_Then:
    call {:si_unique_call 831} vslice_dummy_var_183 := corral_nondet();
    goto L370;

  anon182_Then:
    assume {:partition} bidFlag == 0;
    goto L310;

  anon214_Then:
    ntStatus_21 := -1073741670;
    goto L100;

  anon174_Then:
    assume {:partition} 2 != bidFlag;
    goto L168;

  anon172_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon173_Then, anon173_Else;

  anon173_Else:
    goto L260;

  L260:
    call {:si_unique_call 832} vslice_dummy_var_203 := corral_nondet();
    goto L245;

  anon173_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon175_Then, anon175_Else;

  anon175_Else:
    goto L260;

  anon175_Then:
    goto L245;

  anon171_Then:
    call {:si_unique_call 833} vslice_dummy_var_204 := corral_nondet();
    goto L237;

  anon170_Then:
    assume {:partition} 2 != bidFlag;
    goto L226;

  anon168_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon169_Then, anon169_Else;

  anon169_Else:
    goto L264;

  L264:
    call {:si_unique_call 834} vslice_dummy_var_205 := corral_nondet();
    goto L210;

  anon169_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon176_Then, anon176_Else;

  anon176_Else:
    goto L264;

  anon176_Then:
    goto L210;

  anon167_Then:
    call {:si_unique_call 835} vslice_dummy_var_206 := corral_nondet();
    goto L202;

  anon198_Then:
    assume {:partition} bidFlag != 5;
    goto L168;

  anon199_Then:
    assume {:partition} bidFlag == 4;
    call {:si_unique_call 836} vslice_dummy_var_114 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon163_Then, anon163_Else;

  anon163_Else:
    goto L182;

  L182:
    call {:si_unique_call 837} vslice_dummy_var_115 := corral_nondet();
    call {:si_unique_call 838} vslice_dummy_var_207 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon164_Then, anon164_Else;

  anon164_Else:
    goto L190;

  L190:
    call {:si_unique_call 839} vslice_dummy_var_116 := corral_nondet();
    goto L168;

  anon164_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon165_Then, anon165_Else;

  anon165_Else:
    goto L195;

  L195:
    call {:si_unique_call 840} vslice_dummy_var_208 := corral_nondet();
    goto L190;

  anon165_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon166_Then, anon166_Else;

  anon166_Else:
    goto L195;

  anon166_Then:
    goto L190;

  anon163_Then:
    call {:si_unique_call 841} vslice_dummy_var_209 := corral_nondet();
    goto L182;

  anon200_Then:
    assume {:partition} bidFlag == 3;
    goto L172;

  anon201_Then:
    assume {:partition} bidFlag == 2;
    goto L172;

  anon202_Then:
    assume {:partition} bidFlag == 1;
    goto L169;

  L169:
    call {:si_unique_call 842} vslice_dummy_var_112 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon177_Then, anon177_Else;

  anon177_Else:
    goto L271;

  L271:
    call {:si_unique_call 843} vslice_dummy_var_124 := corral_nondet();
    call {:si_unique_call 844} vslice_dummy_var_176 := corral_nondet();
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon178_Then, anon178_Else;

  anon178_Else:
    goto L279;

  L279:
    call {:si_unique_call 845} vslice_dummy_var_125 := corral_nondet();
    call {:si_unique_call 846} vslice_dummy_var_177 := corral_nondet();
    call {:si_unique_call 847} vslice_dummy_var_126 := corral_nondet();
    goto anon180_Then, anon180_Else;

  anon180_Else:
    assume {:partition} 1 == bidFlag;
    call {:si_unique_call 848} vslice_dummy_var_178 := corral_nondet();
    goto L168;

  anon180_Then:
    assume {:partition} 1 != bidFlag;
    goto L168;

  anon178_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon179_Then, anon179_Else;

  anon179_Else:
    goto L294;

  L294:
    call {:si_unique_call 849} vslice_dummy_var_193 := corral_nondet();
    goto L279;

  anon179_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon181_Then, anon181_Else;

  anon181_Else:
    goto L294;

  anon181_Then:
    goto L279;

  anon177_Then:
    call {:si_unique_call 850} vslice_dummy_var_194 := corral_nondet();
    goto L271;

  anon162_Then:
    assume {:partition} bidFlag == 0;
    goto L169;

  anon213_Then:
    ntStatus_21 := -1073741670;
    goto L100;

  anon161_Then:
    assume {:partition} ntStatus_21 != 0;
    goto L100;

  anon216_Then:
    ntStatus_21 := -1073741670;
    goto L153;

  anon193_Then:
    assume {:partition} bidFlag != 5;
    ntStatus_21 := -1073741811;
    goto L153;

  anon194_Then:
    assume {:partition} bidFlag == 4;
    NumberHardwareIds := 1;
    NumberCompatIds := 2;
    goto L153;

  anon195_Then:
    assume {:partition} bidFlag == 3;
    goto L414;

  anon196_Then:
    assume {:partition} bidFlag == 2;
    goto L414;

  anon197_Then:
    assume {:partition} bidFlag == 1;
    goto L146;

  L146:
    call {:si_unique_call 851} vslice_dummy_var_175 := corral_nondet();
    NumberHardwareIds := 1;
    NumberCompatIds := 2;
    goto L153;

  anon149_Then:
    assume {:partition} bidFlag == 0;
    goto L146;

  anon212_Then:
    ntStatus_21 := -1073741670;
    goto L100;

  anon151_Then:
    assume {:partition} bidFlag == 0;
    goto L72;

  anon150_Then:
    assume {:partition} bidFlag == 1;
    goto L72;

  anon211_Then:
    ntStatus_21 := -1073741670;
    goto L100;

  anon148_Then:
    assume {:partition} bidFlag == 4;
    goto L72;

  anon146_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon147_Then, anon147_Else;

  anon147_Else:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    havoc vslice_dummy_var_48;
    call {:si_unique_call 852} vslice_dummy_var_141 := RtlIntegerToUnicodeString(vslice_dummy_var_48, 16, 0);
    goto L71;

  anon147_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    goto anon192_Then, anon192_Else;

  anon192_Else:
    call {:si_unique_call 853} vslice_dummy_var_143 := corral_nondet();
    goto L71;

  anon192_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    havoc vslice_dummy_var_49;
    call {:si_unique_call 854} vslice_dummy_var_142 := RtlIntegerToUnicodeString(vslice_dummy_var_49, 16, 0);
    goto L71;

  anon210_Then:
    ntStatus_21 := -1073741670;
    goto L100;

  anon145_Then:
    assume {:nonnull} UnitInfo != 0;
    assume UnitInfo > 0;
    havoc vslice_dummy_var_50;
    call {:si_unique_call 855} vslice_dummy_var_109 := RtlIntegerToUnicodeString(vslice_dummy_var_50, 16, 0);
    goto L54;

  anon209_Then:
    ntStatus_21 := -1073741670;
    goto L100;

  anon208_Then:
    assume {:partition} 5 != bidFlag;
    goto L23;
}



procedure {:origName "AvcReq_SubUnitInfo"} AvcReq_SubUnitInfo(actual_Command_18: int, actual_Page_1: int) returns (Tmp_514: int);
  modifies alloc, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcReq_SubUnitInfo"} AvcReq_SubUnitInfo(actual_Command_18: int, actual_Page_1: int) returns (Tmp_514: int)
{
  var {:pointer} Tmp_515: int;
  var {:pointer} Tmp_516: int;
  var {:pointer} Tmp_517: int;
  var {:scalar} ntStatus_22: int;
  var {:pointer} SubUnitInfo: int;
  var {:pointer} Tmp_518: int;
  var {:pointer} Tmp_519: int;
  var {:scalar} Tmp_521: int;
  var {:pointer} Command_18: int;
  var {:scalar} Page_1: int;

  anon0:
    Command_18 := actual_Command_18;
    Page_1 := actual_Page_1;
    call {:si_unique_call 856} Tmp_515 := __HAVOC_malloc(16);
    call {:si_unique_call 857} Tmp_516 := __HAVOC_malloc(16);
    call {:si_unique_call 858} Tmp_517 := __HAVOC_malloc(16);
    call {:si_unique_call 859} Tmp_518 := __HAVOC_malloc(16);
    call {:si_unique_call 860} Tmp_519 := __HAVOC_malloc(2048);
    ntStatus_22 := 0;
    call {:si_unique_call 861} sdv_do_paged_code_check();
    assume {:nonnull} Command_18 != 0;
    assume Command_18 > 0;
    assume {:nonnull} Command_18 != 0;
    assume Command_18 > 0;
    assume {:nonnull} Command_18 != 0;
    assume Command_18 > 0;
    havoc Tmp_521;
    assume {:nonnull} Command_18 != 0;
    assume Command_18 > 0;
    havoc Tmp_519;
    SubUnitInfo := Tmp_519 + Tmp_521 * 4;
    assume {:nonnull} SubUnitInfo != 0;
    assume SubUnitInfo > 0;
    assume {:nonnull} SubUnitInfo != 0;
    assume SubUnitInfo > 0;
    assume {:nonnull} SubUnitInfo != 0;
    assume SubUnitInfo > 0;
    havoc Tmp_515;
    assume {:nonnull} Tmp_515 != 0;
    assume Tmp_515 > 0;
    Mem_T.INT4[Tmp_515] := 255;
    assume {:nonnull} SubUnitInfo != 0;
    assume SubUnitInfo > 0;
    havoc Tmp_518;
    assume {:nonnull} Tmp_518 != 0;
    assume Tmp_518 > 0;
    Mem_T.INT4[Tmp_518 + 1 * 4] := 255;
    assume {:nonnull} SubUnitInfo != 0;
    assume SubUnitInfo > 0;
    havoc Tmp_517;
    assume {:nonnull} Tmp_517 != 0;
    assume Tmp_517 > 0;
    Mem_T.INT4[Tmp_517 + 2 * 4] := 255;
    assume {:nonnull} SubUnitInfo != 0;
    assume SubUnitInfo > 0;
    havoc Tmp_516;
    assume {:nonnull} Tmp_516 != 0;
    assume Tmp_516 > 0;
    Mem_T.INT4[Tmp_516 + 3 * 4] := 255;
    call {:si_unique_call 862} ntStatus_22 := AvcRobustStatusRequest(Command_18);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} yogi_error != 1;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} ntStatus_22 != 0;
    goto L24;

  L24:
    Tmp_514 := ntStatus_22;
    goto LM2;

  LM2:
    return;

  anon7_Then:
    assume {:partition} ntStatus_22 == 0;
    assume {:nonnull} Command_18 != 0;
    assume Command_18 > 0;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    ntStatus_22 := -1073741822;
    goto L24;

  anon8_Then:
    goto L24;

  anon9_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "RtlULongLongToULong"} RtlULongLongToULong(actual_ullOperand: int, actual_pulResult_2: int) returns (Tmp_522: int);
  modifies Mem_T.INT4;
  free ensures Tmp_522 == 0 || Tmp_522 == -1073741675;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RtlULongLongToULong"} RtlULongLongToULong(actual_ullOperand: int, actual_pulResult_2: int) returns (Tmp_522: int)
{
  var {:scalar} status_6: int;
  var {:scalar} ullOperand: int;
  var {:pointer} pulResult_2: int;

  anon0:
    ullOperand := actual_ullOperand;
    pulResult_2 := actual_pulResult_2;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} -1 >= ullOperand;
    assume {:nonnull} pulResult_2 != 0;
    assume pulResult_2 > 0;
    Mem_T.INT4[pulResult_2] := ullOperand;
    status_6 := 0;
    goto L8;

  L8:
    Tmp_522 := status_6;
    return;

  anon3_Then:
    assume {:partition} ullOperand > -1;
    assume {:nonnull} pulResult_2 != 0;
    assume pulResult_2 > 0;
    Mem_T.INT4[pulResult_2] := -1;
    status_6 := -1073741675;
    goto L8;
}



procedure {:origName "_sdv_init5"} _sdv_init5();
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init5"} _sdv_init5()
{
  var vslice_dummy_var_213: int;

  anon0:
    call {:si_unique_call 863} vslice_dummy_var_213 := __HAVOC_malloc(4);
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    return;
}



procedure {:origName "AvcAddInstanceToGlobalList"} AvcAddInstanceToGlobalList(actual_BusExtension_12: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcAddInstanceToGlobalList"} AvcAddInstanceToGlobalList(actual_BusExtension_12: int)
{
  var {:pointer} Tmp_526: int;
  var {:scalar} OldIrql_10: int;
  var {:pointer} BusExtension_12: int;
  var vslice_dummy_var_214: int;
  var vslice_dummy_var_215: int;
  var vslice_dummy_var_216: int;

  anon0:
    call {:si_unique_call 864} vslice_dummy_var_214 := __HAVOC_malloc(4);
    BusExtension_12 := actual_BusExtension_12;
    call {:si_unique_call 865} Tmp_526 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_526 != 0;
    assume Tmp_526 > 0;
    Mem_T.INT4[Tmp_526] := OldIrql_10;
    call {:si_unique_call 866} sdv_KeAcquireSpinLock(0, Tmp_526);
    assume {:nonnull} Tmp_526 != 0;
    assume Tmp_526 > 0;
    OldIrql_10 := Mem_T.INT4[Tmp_526];
    assume {:nonnull} BusExtension_12 != 0;
    assume BusExtension_12 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} BusExtension_12 != 0;
    assume BusExtension_12 > 0;
    call {:si_unique_call 867} vslice_dummy_var_216 := sdv_InsertTailList(AvcVirtualInstanceList, FdoEntry__BUS_DEVICE_EXTENSION(BusExtension_12));
    goto L14;

  L14:
    call {:si_unique_call 868} sdv_KeReleaseSpinLock(0, OldIrql_10);
    return;

  anon3_Then:
    assume {:nonnull} BusExtension_12 != 0;
    assume BusExtension_12 > 0;
    call {:si_unique_call 869} vslice_dummy_var_215 := sdv_InsertTailList(AvcPeerInstanceList, FdoEntry__BUS_DEVICE_EXTENSION(BusExtension_12));
    goto L14;
}



procedure {:origName "Avc_TriggerBusReset"} Avc_TriggerBusReset(actual_BusExtension_13: int) returns (Tmp_528: int);
  modifies alloc, Mem_T.INT4, yogi_error, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_TriggerBusReset"} Avc_TriggerBusReset(actual_BusExtension_13: int) returns (Tmp_528: int)
{
  var {:pointer} Irp_25: int;
  var {:scalar} Irb: int;
  var {:pointer} Tmp_529: int;
  var {:scalar} ntStatus_23: int;
  var {:pointer} NextIrpStack_9: int;
  var {:pointer} BusExtension_13: int;
  var vslice_dummy_var_51: int;
  var vslice_dummy_var_52: int;

  anon0:
    call {:si_unique_call 870} Irb := __HAVOC_malloc(860);
    BusExtension_13 := actual_BusExtension_13;
    ntStatus_23 := 0;
    call {:si_unique_call 871} sdv_do_paged_code_check();
    assume {:nonnull} BusExtension_13 != 0;
    assume BusExtension_13 > 0;
    havoc Tmp_529;
    assume {:nonnull} Tmp_529 != 0;
    assume Tmp_529 > 0;
    havoc vslice_dummy_var_51;
    call {:si_unique_call 872} Irp_25 := IoAllocateIrp(vslice_dummy_var_51, 0);
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} Irp_25 != 0;
    call {:si_unique_call 873} NextIrpStack_9 := sdv_IoGetNextIrpStackLocation(Irp_25);
    assume {:nonnull} Irb != 0;
    assume Irb > 0;
    assume {:nonnull} Irb != 0;
    assume Irb > 0;
    assume {:nonnull} Irb != 0;
    assume Irb > 0;
    assume {:nonnull} NextIrpStack_9 != 0;
    assume NextIrpStack_9 > 0;
    assume {:nonnull} NextIrpStack_9 != 0;
    assume NextIrpStack_9 > 0;
    assume {:nonnull} NextIrpStack_9 != 0;
    assume NextIrpStack_9 > 0;
    assume {:nonnull} BusExtension_13 != 0;
    assume BusExtension_13 > 0;
    havoc vslice_dummy_var_52;
    call {:si_unique_call 874} ntStatus_23 := Avc_SubmitIrpSynch(vslice_dummy_var_52, Irp_25);
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 875} IoFreeIrp(0);
    goto L34;

  L34:
    Tmp_528 := ntStatus_23;
    goto LM2;

  LM2:
    return;

  anon6_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon5_Then:
    assume {:partition} Irp_25 == 0;
    ntStatus_23 := -1073741670;
    goto L34;
}



procedure {:origName "Avc_FindOrCreatePDO"} Avc_FindOrCreatePDO(actual_BusExtension_14: int, actual_SubunitAddr_9: int, actual_bidFlag_1: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_FindOrCreatePDO"} Avc_FindOrCreatePDO(actual_BusExtension_14: int, actual_SubunitAddr_9: int, actual_bidFlag_1: int)
{
  var {:pointer} PdoData_6: int;
  var {:pointer} Tmp_531: int;
  var {:scalar} Tmp_532: int;
  var {:pointer} Tmp_533: int;
  var {:scalar} sdv_335: int;
  var {:pointer} Tmp_534: int;
  var {:scalar} sdv_336: int;
  var {:dopa} {:scalar} TapeSubunitAddr: int;
  var {:scalar} sdv_337: int;
  var {:pointer} sdv_338: int;
  var {:scalar} ntStatus_24: int;
  var {:pointer} PdoExtension: int;
  var {:pointer} Tmp_536: int;
  var {:pointer} PdoDeviceObject: int;
  var {:scalar} ntStatus_25: int;
  var {:pointer} Entry_8: int;
  var {:scalar} sdv_342: int;
  var {:pointer} BusExtension_14: int;
  var {:pointer} SubunitAddr_9: int;
  var {:scalar} bidFlag_1: int;
  var boogieTmp: int;
  var vslice_dummy_var_217: int;
  var vslice_dummy_var_53: int;
  var vslice_dummy_var_54: int;
  var vslice_dummy_var_55: int;

  anon0:
    call {:si_unique_call 876} TapeSubunitAddr := __HAVOC_malloc(4);
    call {:si_unique_call 877} vslice_dummy_var_217 := __HAVOC_malloc(4);
    call {:si_unique_call 878} PdoDeviceObject := __HAVOC_malloc(4);
    BusExtension_14 := actual_BusExtension_14;
    SubunitAddr_9 := actual_SubunitAddr_9;
    bidFlag_1 := actual_bidFlag_1;
    PdoData_6 := 0;
    call {:si_unique_call 879} sdv_do_paged_code_check();
    call {:si_unique_call 880} ExAcquireFastMutex(0);
    assume {:nonnull} BusExtension_14 != 0;
    assume BusExtension_14 > 0;
    havoc Entry_8;
    goto L13;

  L13:
    call {:si_unique_call 881} PdoData_6, sdv_335, Entry_8 := Avc_FindOrCreatePDO_loop_L13(PdoData_6, sdv_335, Entry_8, SubunitAddr_9);
    goto L13_last;

  L13_last:
    goto anon45_Then, anon45_Else;

  anon45_Else:
    PdoData_6 := Entry_8;
    assume {:nonnull} PdoData_6 != 0;
    assume PdoData_6 > 0;
    havoc vslice_dummy_var_53;
    call {:si_unique_call 882} sdv_335 := AvcSubunitAddrsEqual(SubunitAddr_9, vslice_dummy_var_53);
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} sdv_335 == 0;
    PdoData_6 := 0;
    assume {:nonnull} Entry_8 != 0;
    assume Entry_8 > 0;
    havoc Entry_8;
    goto anon47_Else_dummy;

  anon47_Else_dummy:
    assume false;
    return;

  anon47_Then:
    assume {:partition} sdv_335 != 0;
    goto L14;

  L14:
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} PdoData_6 != 0;
    goto L26;

  L26:
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} PdoData_6 != 0;
    assume {:nonnull} PdoData_6 != 0;
    assume PdoData_6 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:nonnull} BusExtension_14 != 0;
    assume BusExtension_14 > 0;
    call {:si_unique_call 883} ntStatus_24 := IoCreateDevice(0, 76, 0, 34, 128, 0, PdoDeviceObject);
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} ntStatus_24 == 0;
    assume {:nonnull} PdoDeviceObject != 0;
    assume PdoDeviceObject > 0;
    havoc PdoExtension;
    call {:si_unique_call 884} sdv_RtlZeroMemory(0, 76);
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} bidFlag_1 == 5;
    Tmp_532 := 1;
    goto L51;

  L51:
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    assume {:nonnull} PdoDeviceObject != 0;
    assume PdoDeviceObject > 0;
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    assume {:nonnull} BusExtension_14 != 0;
    assume BusExtension_14 > 0;
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    havoc vslice_dummy_var_54;
    call {:si_unique_call 885} boogieTmp := IoGetAttachedDeviceReference(vslice_dummy_var_54);
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    call {:si_unique_call 886} AvcInitializeRemoveLock(RemoveLock__PDO_DEVICE_EXTENSION(PdoExtension));
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    call {:si_unique_call 887} Tmp_536 := __HAVOC_malloc(4);
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    assume {:nonnull} Tmp_536 != 0;
    assume Tmp_536 > 0;
    havoc vslice_dummy_var_55;
    Mem_T.INT4[Tmp_536] := vslice_dummy_var_55;
    call {:si_unique_call 888} sdv_KeInitializeSpinLock(Tmp_536);
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    assume {:nonnull} Tmp_536 != 0;
    assume Tmp_536 > 0;
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    assume {:nonnull} PdoData_6 != 0;
    assume PdoData_6 > 0;
    assume {:nonnull} PdoDeviceObject != 0;
    assume PdoDeviceObject > 0;
    assume {:nonnull} PdoData_6 != 0;
    assume PdoData_6 > 0;
    assume {:nonnull} PdoData_6 != 0;
    assume PdoData_6 > 0;
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    havoc Tmp_533;
    assume {:nonnull} PdoDeviceObject != 0;
    assume PdoDeviceObject > 0;
    assume {:nonnull} Tmp_533 != 0;
    assume Tmp_533 > 0;
    assume {:nonnull} BusExtension_14 != 0;
    assume BusExtension_14 > 0;
    havoc Tmp_531;
    assume {:nonnull} Tmp_531 != 0;
    assume Tmp_531 > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:nonnull} PdoDeviceObject != 0;
    assume PdoDeviceObject > 0;
    goto L75;

  L75:
    assume {:nonnull} PdoDeviceObject != 0;
    assume PdoDeviceObject > 0;
    assume {:nonnull} PdoDeviceObject != 0;
    assume PdoDeviceObject > 0;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} 5 == bidFlag_1;
    assume {:nonnull} BusExtension_14 != 0;
    assume BusExtension_14 > 0;
    goto L27;

  L27:
    call {:si_unique_call 889} ExReleaseFastMutex(0);
    goto LM2;

  LM2:
    return;

  anon61_Then:
    assume {:partition} 5 != bidFlag_1;
    goto L27;

  anon60_Then:
    assume {:nonnull} BusExtension_14 != 0;
    assume BusExtension_14 > 0;
    havoc Tmp_534;
    assume {:nonnull} Tmp_534 != 0;
    assume Tmp_534 > 0;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:nonnull} PdoDeviceObject != 0;
    assume PdoDeviceObject > 0;
    goto L75;

  anon62_Then:
    goto L75;

  anon59_Then:
    assume {:partition} bidFlag_1 != 5;
    Tmp_532 := 0;
    goto L51;

  anon52_Then:
    assume {:partition} ntStatus_24 != 0;
    goto L27;

  anon49_Then:
    assume {:nonnull} PdoData_6 != 0;
    assume PdoData_6 > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} 5 == bidFlag_1;
    assume {:nonnull} BusExtension_14 != 0;
    assume BusExtension_14 > 0;
    goto L34;

  L34:
    assume {:nonnull} PdoData_6 != 0;
    assume PdoData_6 > 0;
    goto L27;

  anon51_Then:
    assume {:partition} 5 != bidFlag_1;
    goto L34;

  anon50_Then:
    goto L27;

  anon48_Then:
    assume {:partition} PdoData_6 == 0;
    goto L27;

  anon46_Then:
    assume {:partition} PdoData_6 == 0;
    call {:si_unique_call 890} sdv_338 := ExAllocatePoolWithTag(512, 56, 541283905);
    PdoData_6 := sdv_338;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} PdoData_6 != 0;
    call {:si_unique_call 891} sdv_RtlZeroMemory(0, 56);
    assume {:nonnull} BusExtension_14 != 0;
    assume BusExtension_14 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:nonnull} TapeSubunitAddr != 0;
    assume TapeSubunitAddr > 0;
    Mem_T.INT4[TapeSubunitAddr] := 32;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} bidFlag_1 != 0;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} bidFlag_1 == 3;
    call {:si_unique_call 892} sdv_342 := AvcSubunitAddrsEqual(TapeSubunitAddr, SubunitAddr_9);
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} sdv_342 != 0;
    call {:si_unique_call 893} sdv_337 := Avc_IsLegacyDV(BusExtension_14);
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} yogi_error != 1;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} sdv_337 != 0;
    bidFlag_1 := 2;
    goto L88;

  L88:
    call {:si_unique_call 894} ntStatus_25 := Avc_BuildIds(BusExtension_14, PdoData_6, SubunitAddr_9, bidFlag_1);
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} ntStatus_25 != 0;
    call {:si_unique_call 895} sdv_ExFreePool(0);
    PdoData_6 := 0;
    goto L26;

  anon57_Then:
    assume {:partition} ntStatus_25 == 0;
    assume {:nonnull} PdoData_6 != 0;
    assume PdoData_6 > 0;
    call {:si_unique_call 896} AvcAddToPdoList(BusExtension_14, PdoData_6);
    goto L26;

  anon55_Then:
    assume {:partition} sdv_337 == 0;
    goto L88;

  anon66_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon54_Then:
    assume {:partition} sdv_342 == 0;
    goto L88;

  anon58_Then:
    assume {:partition} bidFlag_1 != 3;
    goto L88;

  anon64_Then:
    assume {:partition} bidFlag_1 == 0;
    call {:si_unique_call 897} sdv_336 := Avc_IsLegacyDV(BusExtension_14);
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} yogi_error != 1;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} sdv_336 != 0;
    bidFlag_1 := 1;
    goto L88;

  anon56_Then:
    assume {:partition} sdv_336 == 0;
    goto L88;

  anon65_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon53_Then:
    goto L88;

  anon63_Then:
    assume {:partition} PdoData_6 == 0;
    goto L26;

  anon45_Then:
    goto L14;
}



procedure {:origName "AvcReq_OutputPlugSignalMode"} AvcReq_OutputPlugSignalMode(actual_Command_19: int, actual_SubunitAddr_10: int) returns (Tmp_538: int);
  modifies alloc, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcReq_OutputPlugSignalMode"} AvcReq_OutputPlugSignalMode(actual_Command_19: int, actual_SubunitAddr_10: int) returns (Tmp_538: int)
{
  var {:dopa} {:scalar} SubunitAddrLen_2: int;
  var {:pointer} Tmp_539: int;
  var {:scalar} Tmp_542: int;
  var {:scalar} ntStatus_26: int;
  var {:pointer} Operands_5: int;
  var {:pointer} Tmp_543: int;
  var {:pointer} Command_19: int;
  var {:pointer} SubunitAddr_10: int;

  anon0:
    call {:si_unique_call 898} SubunitAddrLen_2 := __HAVOC_malloc(4);
    Command_19 := actual_Command_19;
    SubunitAddr_10 := actual_SubunitAddr_10;
    call {:si_unique_call 899} Tmp_539 := __HAVOC_malloc(2048);
    call {:si_unique_call 900} Tmp_543 := __HAVOC_malloc(2048);
    ntStatus_26 := 0;
    assume {:nonnull} SubunitAddrLen_2 != 0;
    assume SubunitAddrLen_2 > 0;
    Mem_T.INT4[SubunitAddrLen_2] := 0;
    call {:si_unique_call 901} sdv_do_paged_code_check();
    call {:si_unique_call 902} ntStatus_26 := AvcValidateSubunitAddress(SubunitAddr_10, 32, SubunitAddrLen_2);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} ntStatus_26 != 0;
    Tmp_538 := -1073741811;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon11_Then:
    assume {:partition} ntStatus_26 == 0;
    assume {:nonnull} SubunitAddrLen_2 != 0;
    assume SubunitAddrLen_2 > 0;
    call {:si_unique_call 903} sdv_RtlCopyMemory(0, 0, Mem_T.INT4[SubunitAddrLen_2]);
    assume {:nonnull} Command_19 != 0;
    assume Command_19 > 0;
    havoc Tmp_543;
    assume {:nonnull} SubunitAddrLen_2 != 0;
    assume SubunitAddrLen_2 > 0;
    call {:si_unique_call 904} sdv_RtlCopyMemory(0, 0, Mem_T.INT4[SubunitAddrLen_2]);
    assume {:nonnull} Command_19 != 0;
    assume Command_19 > 0;
    assume {:nonnull} Command_19 != 0;
    assume Command_19 > 0;
    assume {:nonnull} SubunitAddrLen_2 != 0;
    assume SubunitAddrLen_2 > 0;
    assume {:nonnull} Command_19 != 0;
    assume Command_19 > 0;
    assume {:nonnull} Command_19 != 0;
    assume Command_19 > 0;
    havoc Tmp_542;
    assume {:nonnull} Command_19 != 0;
    assume Command_19 > 0;
    havoc Tmp_539;
    Operands_5 := Tmp_539 + Tmp_542 * 4;
    assume {:nonnull} Operands_5 != 0;
    assume Operands_5 > 0;
    Mem_T.INT4[Operands_5] := 255;
    call {:si_unique_call 905} ntStatus_26 := AvcRobustStatusRequest(Command_19);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} yogi_error != 1;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} ntStatus_26 != 0;
    goto L35;

  L35:
    Tmp_538 := ntStatus_26;
    goto L1;

  anon12_Then:
    assume {:partition} ntStatus_26 == 0;
    assume {:nonnull} Command_19 != 0;
    assume Command_19 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    ntStatus_26 := -1073741822;
    goto L36;

  L36:
    assume {:nonnull} Command_19 != 0;
    assume Command_19 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    ntStatus_26 := -1073741811;
    goto L35;

  anon14_Then:
    goto L35;

  anon13_Then:
    goto L36;

  anon15_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "Avc_FDO_Pnp"} Avc_FDO_Pnp(actual_DeviceObject_22: int, actual_Irp_26: int) returns (Tmp_544: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_FDO_Pnp"} Avc_FDO_Pnp(actual_DeviceObject_22: int, actual_Irp_26: int) returns (Tmp_544: int)
{
  var {:pointer} Relations: int;
  var {:pointer} PdoData_7: int;
  var {:pointer} PdoData_8: int;
  var {:scalar} Tmp_545: int;
  var {:scalar} cObjects: int;
  var {:pointer} Tmp_548: int;
  var {:scalar} cIncomingObjects: int;
  var {:scalar} Tmp_551: int;
  var {:pointer} IrpStack_6: int;
  var {:scalar} ulLength: int;
  var {:pointer} Tmp_552: int;
  var {:pointer} DeviceCapabilities: int;
  var {:pointer} sdv_355: int;
  var {:scalar} sdv_357: int;
  var {:scalar} ntStatus_27: int;
  var {:pointer} PdoExtension_1: int;
  var {:scalar} Tmp_555: int;
  var {:scalar} MinorFunction_1: int;
  var {:pointer} sdv_363: int;
  var {:pointer} Tmp_557: int;
  var {:scalar} Tmp_558: int;
  var {:pointer} BusExtension_15: int;
  var {:pointer} Tmp_559: int;
  var {:pointer} Next: int;
  var {:pointer} PdoData_9: int;
  var {:pointer} OldRelations: int;
  var {:pointer} Tmp_560: int;
  var {:scalar} irpStatus: int;
  var {:pointer} DeviceObject_22: int;
  var {:pointer} Irp_26: int;
  var vslice_dummy_var_218: int;
  var vslice_dummy_var_219: int;
  var vslice_dummy_var_220: int;
  var vslice_dummy_var_221: int;
  var vslice_dummy_var_222: int;
  var vslice_dummy_var_223: int;
  var vslice_dummy_var_224: int;
  var vslice_dummy_var_225: int;
  var vslice_dummy_var_226: int;
  var vslice_dummy_var_227: int;
  var vslice_dummy_var_228: int;
  var vslice_dummy_var_56: int;
  var vslice_dummy_var_57: int;

  anon0:
    DeviceObject_22 := actual_DeviceObject_22;
    Irp_26 := actual_Irp_26;
    call {:si_unique_call 906} Tmp_548 := __HAVOC_malloc(4);
    call {:si_unique_call 907} Tmp_552 := __HAVOC_malloc(4);
    call {:si_unique_call 908} Tmp_557 := __HAVOC_malloc(4);
    call {:si_unique_call 909} Tmp_559 := __HAVOC_malloc(4);
    ntStatus_27 := 0;
    assume {:nonnull} DeviceObject_22 != 0;
    assume DeviceObject_22 > 0;
    havoc BusExtension_15;
    call {:si_unique_call 910} sdv_do_paged_code_check();
    call {:si_unique_call 911} IrpStack_6 := sdv_IoGetCurrentIrpStackLocation(Irp_26);
    assume {:nonnull} IrpStack_6 != 0;
    assume IrpStack_6 > 0;
    havoc MinorFunction_1;
    goto anon162_Then, anon162_Else;

  anon162_Else:
    assume {:partition} MinorFunction_1 != 0;
    goto anon161_Then, anon161_Else;

  anon161_Else:
    assume {:partition} MinorFunction_1 != 1;
    goto anon160_Then, anon160_Else;

  anon160_Else:
    assume {:partition} MinorFunction_1 != 2;
    goto anon159_Then, anon159_Else;

  anon159_Else:
    assume {:partition} MinorFunction_1 != 3;
    goto anon158_Then, anon158_Else;

  anon158_Else:
    assume {:partition} MinorFunction_1 != 4;
    goto anon157_Then, anon157_Else;

  anon157_Else:
    assume {:partition} MinorFunction_1 != 5;
    goto anon156_Then, anon156_Else;

  anon156_Else:
    assume {:partition} MinorFunction_1 != 6;
    goto anon155_Then, anon155_Else;

  anon155_Else:
    assume {:partition} MinorFunction_1 != 7;
    goto anon154_Then, anon154_Else;

  anon154_Else:
    assume {:partition} MinorFunction_1 != 9;
    goto anon153_Then, anon153_Else;

  anon153_Else:
    assume {:partition} MinorFunction_1 != 20;
    goto anon152_Then, anon152_Else;

  anon152_Else:
    assume {:partition} MinorFunction_1 == 23;
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    call {:si_unique_call 912} vslice_dummy_var_228 := Avc_SetBusResetNotify(BusExtension_15, 0);
    goto anon184_Then, anon184_Else;

  anon184_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 913} AvcStopAllFCPProcessing(BusExtension_15);
    call {:si_unique_call 914} vslice_dummy_var_219 := Avc_SetFcpNotify(BusExtension_15, 0);
    goto anon185_Then, anon185_Else;

  anon185_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 915} Avc_SetUnitDirectory(BusExtension_15, 0);
    goto anon186_Then, anon186_Else;

  anon186_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 916} vslice_dummy_var_220 := IoSetDeviceInterfaceState(0, 0);
    call {:si_unique_call 917} ExAcquireFastMutex(0);
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    havoc Next;
    goto L52;

  L52:
    call {:si_unique_call 918} PdoData_7, Next := Avc_FDO_Pnp_loop_L52(PdoData_7, BusExtension_15, Next);
    goto L52_last;

  L52_last:
    goto anon126_Then, anon126_Else;

  anon126_Else:
    PdoData_7 := Next;
    assume {:nonnull} Next != 0;
    assume Next > 0;
    havoc Next;
    call {:si_unique_call 919} AvcRemoveFromPdoList(BusExtension_15, PdoData_7);
    assume {:nonnull} PdoData_7 != 0;
    assume PdoData_7 > 0;
    assume {:nonnull} PdoData_7 != 0;
    assume PdoData_7 > 0;
    goto anon126_Else_dummy;

  anon126_Else_dummy:
    assume false;
    return;

  anon126_Then:
    call {:si_unique_call 920} ExReleaseFastMutex(0);
    goto L65;

  L65:
    goto anon127_Then, anon127_Else;

  anon127_Else:
    assume {:partition} 2 == MinorFunction_1;
    call {:si_unique_call 921} IoDetachDevice(0);
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    goto anon128_Then, anon128_Else;

  anon128_Else:
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    call {:si_unique_call 922} sdv_ExFreePool(0);
    goto L71;

  L71:
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    goto anon129_Then, anon129_Else;

  anon129_Else:
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    call {:si_unique_call 923} sdv_ExFreePool(0);
    goto L75;

  L75:
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    goto anon130_Then, anon130_Else;

  anon130_Else:
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    call {:si_unique_call 924} sdv_ExFreePool(0);
    goto L79;

  L79:
    call {:si_unique_call 925} RtlFreeUnicodeString(0);
    call {:si_unique_call 926} vslice_dummy_var_221 := KeCancelTimer(0);
    call {:si_unique_call 927} IoDeleteDevice(0);
    goto L66;

  L66:
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    call {:si_unique_call 928} sdv_IoSkipCurrentIrpStackLocation(Irp_26);
    goto anon131_Then, anon131_Else;

  anon131_Else:
    assume Irp_26 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 929} SLIC_sdv_IoCallDriver_entry(strConst__li2bpl13, Irp_26);
    goto anon170_Then, anon170_Else;

  anon170_Else:
    assume {:partition} yogi_error != 1;
    goto L341;

  L341:
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    havoc vslice_dummy_var_56;
    call {:si_unique_call 930} ntStatus_27 := sdv_IoCallDriver#1(vslice_dummy_var_56, Irp_26);
    goto anon171_Then, anon171_Else;

  anon171_Else:
    assume {:partition} yogi_error != 1;
    Tmp_544 := ntStatus_27;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon171_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon170_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon131_Then:
    assume !(Irp_26 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L341;

  anon130_Then:
    goto L79;

  anon129_Then:
    goto L75;

  anon128_Then:
    goto L71;

  anon127_Then:
    assume {:partition} 2 != MinorFunction_1;
    goto L66;

  anon186_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon185_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon184_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon152_Then:
    assume {:partition} MinorFunction_1 != 23;
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    havoc ntStatus_27;
    goto L65;

  anon153_Then:
    assume {:partition} MinorFunction_1 == 20;
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    goto L65;

  anon154_Then:
    assume {:partition} MinorFunction_1 == 9;
    assume {:nonnull} IrpStack_6 != 0;
    assume IrpStack_6 > 0;
    havoc DeviceCapabilities;
    assume {:nonnull} DeviceCapabilities != 0;
    assume DeviceCapabilities > 0;
    goto anon183_Then, anon183_Else;

  anon183_Else:
    assume {:nonnull} DeviceCapabilities != 0;
    assume DeviceCapabilities > 0;
    goto anon132_Then, anon132_Else;

  anon132_Else:
    assume {:nonnull} DeviceCapabilities != 0;
    assume DeviceCapabilities > 0;
    goto L65;

  anon132_Then:
    goto L65;

  anon183_Then:
    goto L65;

  anon155_Then:
    assume {:partition} MinorFunction_1 == 7;
    assume {:nonnull} IrpStack_6 != 0;
    assume IrpStack_6 > 0;
    goto anon125_Then, anon125_Else;

  anon125_Else:
    cObjects := 0;
    call {:si_unique_call 931} Avc_EnumerateChildren(BusExtension_15);
    goto anon179_Then, anon179_Else;

  anon179_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 932} ExAcquireFastMutex(0);
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    havoc PdoData_9;
    goto L121;

  L121:
    call {:si_unique_call 933} cObjects, PdoData_9 := Avc_FDO_Pnp_loop_L121(cObjects, PdoData_9);
    goto L121_last;

  L121_last:
    goto anon133_Then, anon133_Else;

  anon133_Else:
    assume {:nonnull} PdoData_9 != 0;
    assume PdoData_9 > 0;
    goto anon134_Then, anon134_Else;

  anon134_Else:
    cObjects := cObjects + 1;
    goto L124;

  L124:
    assume {:nonnull} PdoData_9 != 0;
    assume PdoData_9 > 0;
    havoc PdoData_9;
    goto L124_dummy;

  L124_dummy:
    assume false;
    return;

  anon134_Then:
    goto L124;

  anon133_Then:
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    havoc OldRelations;
    goto anon180_Then, anon180_Else;

  anon180_Else:
    assume {:partition} OldRelations != 0;
    assume {:nonnull} OldRelations != 0;
    assume OldRelations > 0;
    havoc cIncomingObjects;
    goto L129;

  L129:
    cObjects := cObjects + cIncomingObjects;
    ulLength := 8 + cObjects * 4;
    call {:si_unique_call 934} sdv_355 := ExAllocatePoolWithTag(1, ulLength, 541283905);
    Relations := sdv_355;
    goto anon181_Then, anon181_Else;

  anon181_Else:
    assume {:partition} Relations != 0;
    cObjects := 0;
    goto L140;

  L140:
    call {:si_unique_call 935} Tmp_545, cObjects, Tmp_552, Tmp_555, Tmp_557 := Avc_FDO_Pnp_loop_L140(Relations, Tmp_545, cObjects, cIncomingObjects, Tmp_552, Tmp_555, Tmp_557, OldRelations);
    goto L140_last;

  L140_last:
    goto anon135_Then, anon135_Else;

  anon135_Else:
    assume {:partition} cIncomingObjects > cObjects;
    Tmp_555 := cObjects;
    assume {:nonnull} Relations != 0;
    assume Relations > 0;
    havoc Tmp_557;
    Tmp_545 := cObjects;
    assume {:nonnull} OldRelations != 0;
    assume OldRelations > 0;
    havoc Tmp_552;
    assume {:nonnull} Tmp_552 != 0;
    assume Tmp_552 > 0;
    assume {:nonnull} Tmp_557 != 0;
    assume Tmp_557 > 0;
    cObjects := cObjects + 1;
    goto anon135_Else_dummy;

  anon135_Else_dummy:
    assume false;
    return;

  anon135_Then:
    assume {:partition} cObjects >= cIncomingObjects;
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    havoc PdoData_9;
    goto L144;

  L144:
    call {:si_unique_call 936} cObjects, Tmp_548, Tmp_551, Tmp_558, Tmp_559, PdoData_9, vslice_dummy_var_227 := Avc_FDO_Pnp_loop_L144(Relations, cObjects, Tmp_548, Tmp_551, Tmp_558, Tmp_559, PdoData_9, vslice_dummy_var_227);
    goto L144_last;

  L144_last:
    goto anon136_Then, anon136_Else;

  anon136_Else:
    assume {:nonnull} PdoData_9 != 0;
    assume PdoData_9 > 0;
    goto anon137_Then, anon137_Else;

  anon137_Else:
    assume {:nonnull} PdoData_9 != 0;
    assume PdoData_9 > 0;
    goto anon138_Then, anon138_Else;

  anon138_Else:
    Tmp_551 := cObjects;
    assume {:nonnull} Relations != 0;
    assume Relations > 0;
    havoc Tmp_548;
    assume {:nonnull} PdoData_9 != 0;
    assume PdoData_9 > 0;
    assume {:nonnull} Tmp_548 != 0;
    assume Tmp_548 > 0;
    Tmp_558 := cObjects;
    assume {:nonnull} Relations != 0;
    assume Relations > 0;
    havoc Tmp_559;
    assume {:nonnull} Tmp_559 != 0;
    assume Tmp_559 > 0;
    call {:si_unique_call 937} vslice_dummy_var_227 := sdv_ObReferenceObject(0);
    cObjects := cObjects + 1;
    goto L147;

  L147:
    assume {:nonnull} PdoData_9 != 0;
    assume PdoData_9 > 0;
    havoc PdoData_9;
    goto L147_dummy;

  L147_dummy:
    assume false;
    return;

  anon138_Then:
    goto L147;

  anon137_Then:
    goto L147;

  anon136_Then:
    assume {:nonnull} Relations != 0;
    assume Relations > 0;
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    goto anon182_Then, anon182_Else;

  anon182_Else:
    call {:si_unique_call 938} sdv_ExFreePool(0);
    goto L156;

  L156:
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    call {:si_unique_call 939} ExReleaseFastMutex(0);
    goto L65;

  anon182_Then:
    goto L156;

  anon181_Then:
    assume {:partition} Relations == 0;
    call {:si_unique_call 940} ExReleaseFastMutex(0);
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    call {:si_unique_call 941} sdv_IoCompleteRequest(0, 0);
    Tmp_544 := -1073741670;
    goto L1;

  anon180_Then:
    assume {:partition} OldRelations == 0;
    cIncomingObjects := 0;
    goto L129;

  anon179_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon125_Then:
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    havoc ntStatus_27;
    goto L65;

  anon156_Then:
    assume {:partition} MinorFunction_1 == 6;
    goto L65;

  anon157_Then:
    assume {:partition} MinorFunction_1 == 5;
    goto L65;

  anon158_Then:
    assume {:partition} MinorFunction_1 == 4;
    call {:si_unique_call 942} vslice_dummy_var_218 := Avc_SetBusResetNotify(BusExtension_15, 0);
    goto anon176_Then, anon176_Else;

  anon176_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 943} AvcStopAllFCPProcessing(BusExtension_15);
    call {:si_unique_call 944} vslice_dummy_var_222 := Avc_SetFcpNotify(BusExtension_15, 0);
    goto anon177_Then, anon177_Else;

  anon177_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 945} Avc_SetUnitDirectory(BusExtension_15, 0);
    goto anon178_Then, anon178_Else;

  anon178_Else:
    assume {:partition} yogi_error != 1;
    goto L65;

  anon178_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon177_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon176_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon159_Then:
    assume {:partition} MinorFunction_1 == 3;
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    goto L65;

  anon160_Then:
    assume {:partition} MinorFunction_1 == 2;
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    call {:si_unique_call 946} ExAcquireFastMutex(0);
    goto L182;

  L182:
    call {:si_unique_call 947} PdoData_8, sdv_357, PdoExtension_1, sdv_363, Tmp_560 := Avc_FDO_Pnp_loop_L182(PdoData_8, sdv_357, PdoExtension_1, sdv_363, BusExtension_15, Tmp_560);
    goto L182_last;

  L182_last:
    call {:si_unique_call 976} sdv_357 := sdv_IsListEmpty(0);
    goto anon139_Then, anon139_Else;

  anon139_Else:
    assume {:partition} sdv_357 == 0;
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    call {:si_unique_call 948} sdv_363 := RemoveHeadList(PdoList__BUS_DEVICE_EXTENSION(BusExtension_15));
    PdoData_8 := sdv_363;
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    havoc Tmp_560;
    assume {:nonnull} Tmp_560 != 0;
    assume Tmp_560 > 0;
    havoc PdoExtension_1;
    assume {:nonnull} PdoExtension_1 != 0;
    assume PdoExtension_1 > 0;
    goto anon175_Then, anon175_Else;

  anon175_Else:
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    call {:si_unique_call 949} RemoveConnectionMgr(PdoData_8);
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    goto anon141_Then, anon141_Else;

  anon141_Else:
    call {:si_unique_call 950} sdv_ExFreePool(0);
    goto L229;

  L229:
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    goto anon142_Then, anon142_Else;

  anon142_Else:
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    call {:si_unique_call 951} sdv_ExFreePool(0);
    goto L233;

  L233:
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    goto anon143_Then, anon143_Else;

  anon143_Else:
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    call {:si_unique_call 952} sdv_ExFreePool(0);
    goto L237;

  L237:
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    goto anon144_Then, anon144_Else;

  anon144_Else:
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    call {:si_unique_call 953} sdv_ExFreePool(0);
    goto L241;

  L241:
    call {:si_unique_call 954} sdv_ExFreePool(0);
    assume {:nonnull} PdoExtension_1 != 0;
    assume PdoExtension_1 > 0;
    call {:si_unique_call 955} IoDeleteDevice(0);
    goto L241_dummy;

  L241_dummy:
    assume false;
    return;

  anon144_Then:
    goto L241;

  anon143_Then:
    goto L237;

  anon142_Then:
    goto L233;

  anon141_Then:
    goto L229;

  anon175_Then:
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    call {:si_unique_call 956} InitializeListHead(PdoList__PDO_DATA(PdoData_8));
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    assume {:nonnull} PdoData_8 != 0;
    assume PdoData_8 > 0;
    goto anon175_Then_dummy;

  anon175_Then_dummy:
    assume false;
    return;

  anon139_Then:
    assume {:partition} sdv_357 != 0;
    call {:si_unique_call 957} ExReleaseFastMutex(0);
    call {:si_unique_call 958} AvcRemoveInstanceFromGlobalList(BusExtension_15);
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    goto anon140_Then, anon140_Else;

  anon140_Else:
    goto L197;

  L197:
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    call {:si_unique_call 959} AvcReleaseRemoveLockAndWait(RemoveLock__BUS_DEVICE_EXTENSION(BusExtension_15));
    goto L65;

  anon140_Then:
    call {:si_unique_call 960} vslice_dummy_var_223 := Avc_SetBusResetNotify(BusExtension_15, 0);
    goto anon172_Then, anon172_Else;

  anon172_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 961} AvcStopAllFCPProcessing(BusExtension_15);
    call {:si_unique_call 962} vslice_dummy_var_224 := Avc_SetFcpNotify(BusExtension_15, 0);
    goto anon173_Then, anon173_Else;

  anon173_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 963} Avc_SetUnitDirectory(BusExtension_15, 0);
    goto anon174_Then, anon174_Else;

  anon174_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 964} vslice_dummy_var_225 := IoSetDeviceInterfaceState(0, 0);
    goto L197;

  anon174_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon173_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon172_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon161_Then:
    assume {:partition} MinorFunction_1 == 1;
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    goto L65;

  anon162_Then:
    assume {:partition} MinorFunction_1 == 0;
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    call {:si_unique_call 965} sdv_IoCopyCurrentIrpStackLocationToNext(Irp_26);
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    havoc vslice_dummy_var_57;
    call {:si_unique_call 966} ntStatus_27 := Avc_SubmitIrpSynch(vslice_dummy_var_57, Irp_26);
    goto anon163_Then, anon163_Else;

  anon163_Else:
    assume {:partition} yogi_error != 1;
    goto anon145_Then, anon145_Else;

  anon145_Else:
    assume {:partition} ntStatus_27 >= 0;
    irpStatus := ntStatus_27;
    call {:si_unique_call 967} vslice_dummy_var_226 := IoSetDeviceInterfaceState(0, 1);
    call {:si_unique_call 968} ntStatus_27 := AvcReq_UnitInfo(BusExtension_15);
    goto anon164_Then, anon164_Else;

  anon164_Else:
    assume {:partition} yogi_error != 1;
    goto anon146_Then, anon146_Else;

  anon146_Else:
    assume {:partition} ntStatus_27 >= 0;
    call {:si_unique_call 969} ntStatus_27 := Avc_SetBusResetNotify(BusExtension_15, 1);
    goto anon165_Then, anon165_Else;

  anon165_Else:
    assume {:partition} yogi_error != 1;
    goto anon148_Then, anon148_Else;

  anon148_Else:
    assume {:partition} ntStatus_27 >= 0;
    call {:si_unique_call 970} ntStatus_27 := Avc_SetFcpNotify(BusExtension_15, 1);
    goto anon166_Then, anon166_Else;

  anon166_Else:
    assume {:partition} yogi_error != 1;
    goto anon149_Then, anon149_Else;

  anon149_Else:
    assume {:partition} ntStatus_27 >= 0;
    assume {:nonnull} BusExtension_15 != 0;
    assume BusExtension_15 > 0;
    goto anon150_Then, anon150_Else;

  anon150_Else:
    call {:si_unique_call 971} Avc_EnumerateVirtualChildren(BusExtension_15);
    call {:si_unique_call 972} ntStatus_27 := AvcPrepareForRequestCallback(BusExtension_15, 0);
    goto anon167_Then, anon167_Else;

  anon167_Else:
    assume {:partition} yogi_error != 1;
    goto L275;

  L275:
    goto anon147_Then, anon147_Else;

  anon147_Else:
    assume {:partition} ntStatus_27 >= 0;
    ntStatus_27 := irpStatus;
    goto L262;

  L262:
    call {:si_unique_call 973} sdv_IoCompleteRequest(0, 0);
    Tmp_544 := ntStatus_27;
    goto L1;

  anon147_Then:
    assume {:partition} 0 > ntStatus_27;
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    goto L262;

  anon167_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon150_Then:
    call {:si_unique_call 974} ntStatus_27 := AvcPrepareForResponseCallback(BusExtension_15, 0);
    goto anon168_Then, anon168_Else;

  anon168_Else:
    assume {:partition} yogi_error != 1;
    goto anon151_Then, anon151_Else;

  anon151_Else:
    assume {:partition} ntStatus_27 >= 0;
    call {:si_unique_call 975} ntStatus_27 := AvcPrepareForRequestCallback(BusExtension_15, 0);
    goto anon169_Then, anon169_Else;

  anon169_Else:
    assume {:partition} yogi_error != 1;
    goto L275;

  anon169_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon151_Then:
    assume {:partition} 0 > ntStatus_27;
    goto L275;

  anon168_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon149_Then:
    assume {:partition} 0 > ntStatus_27;
    goto L275;

  anon166_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon148_Then:
    assume {:partition} 0 > ntStatus_27;
    goto L275;

  anon165_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon146_Then:
    assume {:partition} 0 > ntStatus_27;
    goto L275;

  anon164_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon145_Then:
    assume {:partition} 0 > ntStatus_27;
    goto L262;

  anon163_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "RtlLargeIntegerToUnicodeString"} RtlLargeIntegerToUnicodeString(actual_Input: int, actual_Base_1: int, actual_String_1: int) returns (Tmp_562: int);
  modifies alloc, Mem_T.INT4;
  free ensures Tmp_562 == -1073741811 || Tmp_562 == 0 || Tmp_562 == 5;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RtlLargeIntegerToUnicodeString"} RtlLargeIntegerToUnicodeString(actual_Input: int, actual_Base_1: int, actual_String_1: int) returns (Tmp_562: int)
{
  var {:scalar} Tmp_563: int;
  var {:scalar} Value_1: int;
  var {:scalar} Mask: int;
  var {:scalar} Negate: int;
  var {:scalar} ntStatus_28: int;
  var {:scalar} Tmp_564: int;
  var {:scalar} Length_5: int;
  var {:scalar} Tmp_566: int;
  var {:scalar} Shift: int;
  var {:pointer} ptr: int;
  var {:scalar} Tmp_567: int;
  var {:pointer} Result: int;
  var {:scalar} Tmp_568: int;
  var {:pointer} Input: int;
  var {:scalar} Base_1: int;
  var {:pointer} String_1: int;
  var vslice_dummy_var_58: int;
  var vslice_dummy_var_59: int;

  anon0:
    Input := actual_Input;
    Base_1 := actual_Base_1;
    String_1 := actual_String_1;
    call {:si_unique_call 977} Result := __HAVOC_malloc(260);
    ptr := Result + 64 * 4;
    Shift := 0;
    Negate := 0;
    Length_5 := 0;
    ntStatus_28 := 0;
    call {:si_unique_call 978} sdv_do_paged_code_check();
    assume {:nonnull} ptr != 0;
    assume ptr > 0;
    Mem_T.INT4[ptr] := 0;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} Base_1 != 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} Base_1 != 2;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} Base_1 != 8;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} Base_1 != 10;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} Base_1 == 16;
    Shift := Shift + 1;
    goto L24;

  L24:
    Shift := Shift + 1;
    Shift := Shift + 1;
    goto L23;

  L23:
    Shift := Shift + 1;
    assume {:nonnull} Input != 0;
    assume Input > 0;
    havoc Value_1;
    call {:si_unique_call 979} Mask := corral_nondet();
    goto L29;

  L29:
    call {:si_unique_call 980} Value_1, Tmp_564, Tmp_567 := RtlLargeIntegerToUnicodeString_loop_L29(Value_1, Mask, Tmp_564, ptr, Tmp_567);
    goto L29_last;

  L29_last:
    Tmp_564 := BAND(Value_1, Mask);
    Tmp_567 := Tmp_564;
    assume {:nonnull} ptr != 0;
    assume ptr > 0;
    havoc vslice_dummy_var_58;
    Mem_T.INT4[ptr] := vslice_dummy_var_58;
    call {:si_unique_call 983} Value_1 := corral_nondet();
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} Value_1 == 0;
    goto L34;

  L34:
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} ntStatus_28 >= 0;
    Length_5 := (Result + 64 * 4) * 2 + 2;
    assume {:nonnull} String_1 != 0;
    assume String_1 > 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    Tmp_568 := Length_5;
    call {:si_unique_call 981} sdv_RtlCopyMemory(0, 0, Tmp_568);
    assume {:nonnull} String_1 != 0;
    assume String_1 > 0;
    goto L35;

  L35:
    Tmp_562 := ntStatus_28;
    return;

  anon32_Then:
    ntStatus_28 := 5;
    goto L35;

  anon24_Then:
    assume {:partition} 0 > ntStatus_28;
    goto L35;

  anon33_Then:
    assume {:partition} Value_1 != 0;
    goto anon33_Then_dummy;

  anon33_Then_dummy:
    assume false;
    return;

  anon26_Then:
    assume {:partition} Base_1 != 16;
    ntStatus_28 := -1073741811;
    goto L34;

  anon27_Then:
    assume {:partition} Base_1 == 10;
    goto L22;

  L22:
    assume {:nonnull} Input != 0;
    assume Input > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:nonnull} Input != 0;
    assume Input > 0;
    havoc Value_1;
    Negate := 1;
    goto L47;

  L47:
    call {:si_unique_call 982} Tmp_563, Value_1, Tmp_566 := RtlLargeIntegerToUnicodeString_loop_L47(Tmp_563, Value_1, Tmp_566, ptr);
    goto L47_last;

  L47_last:
    Tmp_563 := INTMOD(Value_1, 10);
    Tmp_566 := Tmp_563;
    assume {:nonnull} ptr != 0;
    assume ptr > 0;
    havoc vslice_dummy_var_59;
    Mem_T.INT4[ptr] := vslice_dummy_var_59;
    Value_1 := INTDIV(Value_1, 10);
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} Value_1 == 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} Negate != 0;
    assume {:nonnull} ptr != 0;
    assume ptr > 0;
    Mem_T.INT4[ptr] := 45;
    goto L34;

  anon25_Then:
    assume {:partition} Negate == 0;
    goto L34;

  anon31_Then:
    assume {:partition} Value_1 != 0;
    goto anon31_Then_dummy;

  anon31_Then_dummy:
    assume false;
    return;

  anon23_Then:
    assume {:nonnull} Input != 0;
    assume Input > 0;
    havoc Value_1;
    goto L47;

  anon28_Then:
    assume {:partition} Base_1 == 8;
    goto L24;

  anon29_Then:
    assume {:partition} Base_1 == 2;
    goto L23;

  anon30_Then:
    assume {:partition} Base_1 == 0;
    goto L22;
}



procedure {:origName "Avc_SetBusResetNotify"} Avc_SetBusResetNotify(actual_BusExtension_16: int, actual_bEnable_2: int) returns (Tmp_569: int);
  modifies alloc, Mem_T.INT4, yogi_error, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_SetBusResetNotify"} Avc_SetBusResetNotify(actual_BusExtension_16: int, actual_bEnable_2: int) returns (Tmp_569: int)
{
  var {:pointer} Irp_27: int;
  var {:pointer} Tmp_570: int;
  var {:scalar} ntStatus_29: int;
  var {:pointer} NextIrpStack_10: int;
  var {:scalar} AvRequest_3: int;
  var {:pointer} BusExtension_16: int;
  var {:scalar} bEnable_2: int;
  var vslice_dummy_var_60: int;
  var vslice_dummy_var_61: int;
  var vslice_dummy_var_62: int;

  anon0:
    call {:si_unique_call 984} AvRequest_3 := __HAVOC_malloc(460);
    BusExtension_16 := actual_BusExtension_16;
    bEnable_2 := actual_bEnable_2;
    ntStatus_29 := 0;
    call {:si_unique_call 985} sdv_do_paged_code_check();
    assume {:nonnull} BusExtension_16 != 0;
    assume BusExtension_16 > 0;
    havoc Tmp_570;
    assume {:nonnull} Tmp_570 != 0;
    assume Tmp_570 > 0;
    havoc vslice_dummy_var_60;
    call {:si_unique_call 986} Irp_27 := IoAllocateIrp(vslice_dummy_var_60, 0);
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} Irp_27 != 0;
    call {:si_unique_call 987} NextIrpStack_10 := sdv_IoGetNextIrpStackLocation(Irp_27);
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} bEnable_2 != 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    assume {:nonnull} BusExtension_16 != 0;
    assume BusExtension_16 > 0;
    assume {:nonnull} NextIrpStack_10 != 0;
    assume NextIrpStack_10 > 0;
    assume {:nonnull} NextIrpStack_10 != 0;
    assume NextIrpStack_10 > 0;
    assume {:nonnull} NextIrpStack_10 != 0;
    assume NextIrpStack_10 > 0;
    assume {:nonnull} BusExtension_16 != 0;
    assume BusExtension_16 > 0;
    havoc vslice_dummy_var_61;
    call {:si_unique_call 988} ntStatus_29 := Avc_SubmitIrpSynch(vslice_dummy_var_61, Irp_27);
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} yogi_error != 1;
    goto L22;

  L22:
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} ntStatus_29 >= 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} bEnable_2 != 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    goto L44;

  L44:
    assume {:nonnull} NextIrpStack_10 != 0;
    assume NextIrpStack_10 > 0;
    assume {:nonnull} NextIrpStack_10 != 0;
    assume NextIrpStack_10 > 0;
    assume {:nonnull} NextIrpStack_10 != 0;
    assume NextIrpStack_10 > 0;
    assume {:nonnull} BusExtension_16 != 0;
    assume BusExtension_16 > 0;
    havoc vslice_dummy_var_62;
    call {:si_unique_call 989} ntStatus_29 := Avc_SubmitIrpSynch(vslice_dummy_var_62, Irp_27);
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} yogi_error != 1;
    goto L34;

  L34:
    call {:si_unique_call 990} IoFreeIrp(0);
    goto L51;

  L51:
    Tmp_569 := ntStatus_29;
    goto LM2;

  LM2:
    return;

  anon18_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon17_Then:
    assume {:partition} bEnable_2 == 0;
    assume {:nonnull} AvRequest_3 != 0;
    assume AvRequest_3 > 0;
    goto L44;

  anon15_Then:
    assume {:partition} 0 > ntStatus_29;
    goto L34;

  anon16_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon14_Then:
    assume {:partition} bEnable_2 == 0;
    goto L22;

  anon13_Then:
    assume {:partition} Irp_27 == 0;
    ntStatus_29 := -1073741670;
    goto L51;
}



procedure {:origName "AvcRobustStatusRequest"} AvcRobustStatusRequest(actual_Command_20: int) returns (Tmp_572: int);
  modifies alloc, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcRobustStatusRequest"} AvcRobustStatusRequest(actual_Command_20: int) returns (Tmp_572: int)
{
  var {:scalar} Retries_1: int;
  var {:scalar} ntStatus_30: int;
  var {:scalar} tmDelay_1: int;
  var {:pointer} Command_20: int;
  var vslice_dummy_var_229: int;

  anon0:
    call {:si_unique_call 991} tmDelay_1 := __HAVOC_malloc(20);
    Command_20 := actual_Command_20;
    ntStatus_30 := 0;
    call {:si_unique_call 992} sdv_do_paged_code_check();
    assume {:nonnull} tmDelay_1 != 0;
    assume tmDelay_1 > 0;
    assume {:nonnull} tmDelay_1 != 0;
    assume tmDelay_1 > 0;
    Retries_1 := 0;
    goto L13;

  L13:
    call {:si_unique_call 993} Retries_1, ntStatus_30, vslice_dummy_var_229 := AvcRobustStatusRequest_loop_L13(Retries_1, ntStatus_30, tmDelay_1, Command_20, vslice_dummy_var_229);
    goto L13_last;

  L13_last:
    assume {:CounterLoop 10} {:Counter "Retries_1"} true;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} 10 > Retries_1;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} Retries_1 != 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} ntStatus_30 != 258;
    call {:si_unique_call 994} vslice_dummy_var_229 := KeDelayExecutionThread(0, 0, 0);
    goto L16;

  L16:
    call {:si_unique_call 995} ntStatus_30 := AvcStatus(Command_20);
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} yogi_error != 1;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} ntStatus_30 != 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} ntStatus_30 != -1073741435;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} ntStatus_30 != -1073741668;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} ntStatus_30 != -1073741643;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} ntStatus_30 != -1073741248;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} ntStatus_30 == 258;
    goto L27;

  L27:
    assume {:nonnull} tmDelay_1 != 0;
    assume tmDelay_1 > 0;
    goto L33;

  L33:
    Retries_1 := Retries_1 + 1;
    goto L33_dummy;

  L33_dummy:
    assume false;
    return;

  anon32_Then:
    assume {:partition} ntStatus_30 != 258;
    goto L14;

  L14:
    Tmp_572 := ntStatus_30;
    goto LM2;

  LM2:
    return;

  anon31_Then:
    assume {:partition} ntStatus_30 == -1073741248;
    goto L27;

  anon30_Then:
    assume {:partition} ntStatus_30 == -1073741643;
    goto L27;

  anon29_Then:
    assume {:partition} ntStatus_30 == -1073741668;
    goto L27;

  anon28_Then:
    assume {:partition} ntStatus_30 == -1073741435;
    goto L27;

  anon26_Then:
    assume {:partition} ntStatus_30 == 0;
    assume {:nonnull} Command_20 != 0;
    assume Command_20 > 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:nonnull} tmDelay_1 != 0;
    assume tmDelay_1 > 0;
    goto L33;

  anon27_Then:
    goto L14;

  anon33_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} ntStatus_30 == 258;
    goto L16;

  anon24_Then:
    assume {:partition} Retries_1 == 0;
    goto L16;

  anon23_Then:
    assume {:partition} Retries_1 >= 10;
    goto L14;
}



procedure {:origName "Avc_PDO_Pnp"} Avc_PDO_Pnp(actual_DeviceObject_23: int, actual_Irp_28: int) returns (Tmp_574: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_PDO_Pnp"} Avc_PDO_Pnp(actual_DeviceObject_23: int, actual_Irp_28: int) returns (Tmp_574: int)
{
  var {:pointer} PdoData_10: int;
  var {:pointer} PdoData_11: int;
  var {:pointer} Tmp_576: int;
  var {:pointer} sdv_375: int;
  var {:dopa} {:scalar} cbTemp: int;
  var {:pointer} idString: int;
  var {:pointer} Tmp_578: int;
  var {:scalar} sdv_377: int;
  var {:pointer} Tmp_579: int;
  var {:pointer} wszTemp_1: int;
  var {:pointer} sdv_379: int;
  var {:pointer} Tmp_580: int;
  var {:pointer} IrpStack_7: int;
  var {:pointer} Tmp_582: int;
  var {:pointer} sdv_382: int;
  var {:pointer} Tmp_583: int;
  var {:pointer} Tmp_584: int;
  var {:pointer} Tmp_585: int;
  var {:pointer} Tmp_586: int;
  var {:pointer} Tmp_587: int;
  var {:pointer} DeviceCapabilities_1: int;
  var {:scalar} ntStatus_31: int;
  var {:pointer} PdoExtension_2: int;
  var {:pointer} Relation: int;
  var {:pointer} Tmp_589: int;
  var {:scalar} StartState: int;
  var {:pointer} UnitInfo_1: int;
  var {:pointer} Tmp_590: int;
  var {:pointer} sdv_390: int;
  var {:pointer} sdv_391: int;
  var {:pointer} Tmp_591: int;
  var {:pointer} Tmp_592: int;
  var {:pointer} pwszSubunit: int;
  var {:scalar} MinorFunction_2: int;
  var {:scalar} Length_6: int;
  var {:dopa} {:scalar} ulStrLen: int;
  var {:pointer} BusInfo: int;
  var {:pointer} Tmp_594: int;
  var {:pointer} sdv_395: int;
  var {:pointer} BusExtension_17: int;
  var {:pointer} PdoData_12: int;
  var {:scalar} uniDeviceText: int;
  var {:pointer} Tmp_595: int;
  var {:pointer} Tmp_596: int;
  var {:pointer} DeviceObject_23: int;
  var {:pointer} Irp_28: int;
  var boogieTmp: int;
  var vslice_dummy_var_230: int;
  var vslice_dummy_var_231: int;
  var vslice_dummy_var_232: int;
  var vslice_dummy_var_233: int;
  var vslice_dummy_var_234: int;
  var vslice_dummy_var_235: int;
  var vslice_dummy_var_236: int;
  var vslice_dummy_var_237: int;
  var vslice_dummy_var_238: int;
  var vslice_dummy_var_239: int;
  var vslice_dummy_var_240: int;
  var vslice_dummy_var_63: int;
  var vslice_dummy_var_64: int;
  var vslice_dummy_var_65: int;
  var vslice_dummy_var_66: int;
  var vslice_dummy_var_67: int;
  var vslice_dummy_var_68: int;
  var vslice_dummy_var_69: int;
  var vslice_dummy_var_70: int;

  anon0:
    call {:si_unique_call 996} cbTemp := __HAVOC_malloc(4);
    call {:si_unique_call 997} wszTemp_1 := __HAVOC_malloc(4);
    call {:si_unique_call 998} pwszSubunit := __HAVOC_malloc(4);
    call {:si_unique_call 999} ulStrLen := __HAVOC_malloc(4);
    call {:si_unique_call 1000} uniDeviceText := __HAVOC_malloc(12);
    DeviceObject_23 := actual_DeviceObject_23;
    Irp_28 := actual_Irp_28;
    call {:si_unique_call 1001} Tmp_578 := __HAVOC_malloc(4);
    call {:si_unique_call 1002} Tmp_579 := __HAVOC_malloc(28);
    call {:si_unique_call 1003} Tmp_582 := __HAVOC_malloc(28);
    call {:si_unique_call 1004} vslice_dummy_var_235 := __HAVOC_malloc(8);
    call {:si_unique_call 1005} Tmp_589 := __HAVOC_malloc(28);
    call {:si_unique_call 1006} Tmp_592 := __HAVOC_malloc(28);
    call {:si_unique_call 1007} Tmp_595 := __HAVOC_malloc(28);
    call {:si_unique_call 1008} Tmp_596 := __HAVOC_malloc(28);
    call {:si_unique_call 1009} vslice_dummy_var_236 := __HAVOC_malloc(8);
    assume {:nonnull} DeviceObject_23 != 0;
    assume DeviceObject_23 > 0;
    havoc PdoExtension_2;
    ntStatus_31 := 0;
    call {:si_unique_call 1010} sdv_do_paged_code_check();
    call {:si_unique_call 1011} IrpStack_7 := sdv_IoGetCurrentIrpStackLocation(Irp_28);
    assume {:nonnull} IrpStack_7 != 0;
    assume IrpStack_7 > 0;
    havoc MinorFunction_2;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc Tmp_587;
    assume {:nonnull} Tmp_587 != 0;
    assume Tmp_587 > 0;
    havoc StartState;
    goto anon175_Then, anon175_Else;

  anon175_Else:
    assume {:partition} MinorFunction_2 != 0;
    goto anon170_Then, anon170_Else;

  anon170_Else:
    assume {:partition} MinorFunction_2 != 1;
    goto anon169_Then, anon169_Else;

  anon169_Else:
    assume {:partition} MinorFunction_2 != 2;
    goto anon168_Then, anon168_Else;

  anon168_Else:
    assume {:partition} MinorFunction_2 != 3;
    goto anon167_Then, anon167_Else;

  anon167_Else:
    assume {:partition} MinorFunction_2 != 4;
    goto anon166_Then, anon166_Else;

  anon166_Else:
    assume {:partition} MinorFunction_2 != 5;
    goto anon165_Then, anon165_Else;

  anon165_Else:
    assume {:partition} MinorFunction_2 != 6;
    goto anon164_Then, anon164_Else;

  anon164_Else:
    assume {:partition} MinorFunction_2 != 7;
    goto anon163_Then, anon163_Else;

  anon163_Else:
    assume {:partition} MinorFunction_2 != 9;
    goto anon162_Then, anon162_Else;

  anon162_Else:
    assume {:partition} MinorFunction_2 != 10;
    goto anon161_Then, anon161_Else;

  anon161_Else:
    assume {:partition} MinorFunction_2 != 11;
    goto anon160_Then, anon160_Else;

  anon160_Else:
    assume {:partition} MinorFunction_2 != 12;
    goto anon159_Then, anon159_Else;

  anon159_Else:
    assume {:partition} MinorFunction_2 != 19;
    goto anon158_Then, anon158_Else;

  anon158_Else:
    assume {:partition} MinorFunction_2 != 21;
    goto anon157_Then, anon157_Else;

  anon157_Else:
    assume {:partition} MinorFunction_2 == 23;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    goto anon192_Then, anon192_Else;

  anon192_Else:
    call {:si_unique_call 1012} vslice_dummy_var_230 := sdv_ObDereferenceObject(0);
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    goto L37;

  L37:
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc Tmp_594;
    assume {:nonnull} Tmp_594 != 0;
    assume Tmp_594 > 0;
    goto L43;

  L43:
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    goto anon130_Then, anon130_Else;

  anon130_Else:
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    goto anon132_Then, anon132_Else;

  anon132_Else:
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc Tmp_585;
    assume {:nonnull} Tmp_585 != 0;
    assume Tmp_585 > 0;
    goto anon177_Then, anon177_Else;

  anon177_Else:
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc Tmp_583;
    assume {:nonnull} Tmp_583 != 0;
    assume Tmp_583 > 0;
    havoc vslice_dummy_var_63;
    call {:si_unique_call 1013} vslice_dummy_var_237 := Avc_TriggerBusReset(vslice_dummy_var_63);
    goto anon178_Then, anon178_Else;

  anon178_Else:
    assume {:partition} yogi_error != 1;
    goto L44;

  L44:
    goto anon131_Then, anon131_Else;

  anon131_Else:
    assume {:partition} 2 == MinorFunction_2;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc PdoData_10;
    goto anon179_Then, anon179_Else;

  anon179_Else:
    assume {:partition} PdoData_10 != 0;
    assume {:nonnull} PdoData_10 != 0;
    assume PdoData_10 > 0;
    goto anon133_Then, anon133_Else;

  anon133_Else:
    assume {:nonnull} PdoData_10 != 0;
    assume PdoData_10 > 0;
    havoc BusExtension_17;
    goto anon180_Then, anon180_Else;

  anon180_Else:
    assume {:partition} BusExtension_17 != 0;
    call {:si_unique_call 1014} ExAcquireFastMutex(0);
    call {:si_unique_call 1015} AvcRemoveFromPdoList(BusExtension_17, PdoData_10);
    call {:si_unique_call 1016} ExReleaseFastMutex(0);
    goto L61;

  L61:
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    call {:si_unique_call 1017} AvcReleaseRemoveLockAndWait(RemoveLock__PDO_DEVICE_EXTENSION(PdoExtension_2));
    call {:si_unique_call 1018} RemoveConnectionMgr(PdoData_10);
    assume {:nonnull} PdoData_10 != 0;
    assume PdoData_10 > 0;
    goto anon134_Then, anon134_Else;

  anon134_Else:
    call {:si_unique_call 1019} sdv_ExFreePool(0);
    goto L77;

  L77:
    assume {:nonnull} PdoData_10 != 0;
    assume PdoData_10 > 0;
    goto anon135_Then, anon135_Else;

  anon135_Else:
    assume {:nonnull} PdoData_10 != 0;
    assume PdoData_10 > 0;
    call {:si_unique_call 1020} sdv_ExFreePool(0);
    goto L81;

  L81:
    assume {:nonnull} PdoData_10 != 0;
    assume PdoData_10 > 0;
    goto anon136_Then, anon136_Else;

  anon136_Else:
    assume {:nonnull} PdoData_10 != 0;
    assume PdoData_10 > 0;
    call {:si_unique_call 1021} sdv_ExFreePool(0);
    goto L85;

  L85:
    assume {:nonnull} PdoData_10 != 0;
    assume PdoData_10 > 0;
    goto anon137_Then, anon137_Else;

  anon137_Else:
    assume {:nonnull} PdoData_10 != 0;
    assume PdoData_10 > 0;
    call {:si_unique_call 1022} sdv_ExFreePool(0);
    goto L89;

  L89:
    call {:si_unique_call 1023} sdv_ExFreePool(0);
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    call {:si_unique_call 1024} IoDeleteDevice(0);
    goto L50;

  L50:
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    call {:si_unique_call 1025} sdv_IoCompleteRequest(0, 0);
    Tmp_574 := ntStatus_31;
    goto LM2;

  LM2:
    return;

  anon137_Then:
    goto L89;

  anon136_Then:
    goto L85;

  anon135_Then:
    goto L81;

  anon134_Then:
    goto L77;

  anon180_Then:
    assume {:partition} BusExtension_17 == 0;
    goto L61;

  anon133_Then:
    goto L54;

  L54:
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    call {:si_unique_call 1026} AvcReleaseRemoveLock(RemoveLock__PDO_DEVICE_EXTENSION(PdoExtension_2));
    goto L50;

  anon179_Then:
    assume {:partition} PdoData_10 == 0;
    goto L54;

  anon131_Then:
    assume {:partition} 2 != MinorFunction_2;
    goto L50;

  anon178_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon177_Then:
    goto L44;

  anon132_Then:
    goto L44;

  anon130_Then:
    goto L44;

  anon192_Then:
    goto L37;

  anon157_Then:
    assume {:partition} MinorFunction_2 != 23;
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    havoc ntStatus_31;
    goto L43;

  anon158_Then:
    assume {:partition} MinorFunction_2 == 21;
    call {:si_unique_call 1027} sdv_390 := ExAllocatePoolWithTag(1, 24, 541283905);
    BusInfo := sdv_390;
    goto anon191_Then, anon191_Else;

  anon191_Else:
    assume {:partition} BusInfo != 0;
    assume {:nonnull} BusInfo != 0;
    assume BusInfo > 0;
    assume {:nonnull} BusInfo != 0;
    assume BusInfo > 0;
    assume {:nonnull} BusInfo != 0;
    assume BusInfo > 0;
    assume {:nonnull} BusInfo != 0;
    assume BusInfo > 0;
    assume {:nonnull} BusInfo != 0;
    assume BusInfo > 0;
    assume {:nonnull} BusInfo != 0;
    assume BusInfo > 0;
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    goto L43;

  anon191_Then:
    assume {:partition} BusInfo == 0;
    ntStatus_31 := -1073741670;
    goto L43;

  anon159_Then:
    assume {:partition} MinorFunction_2 == 19;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc PdoData_12;
    assume {:nonnull} IrpStack_7 != 0;
    assume IrpStack_7 > 0;
    goto anon187_Then, anon187_Else;

  anon187_Else:
    assume {:nonnull} IrpStack_7 != 0;
    assume IrpStack_7 > 0;
    goto anon174_Then, anon174_Else;

  anon174_Else:
    assume {:nonnull} IrpStack_7 != 0;
    assume IrpStack_7 > 0;
    goto anon173_Then, anon173_Else;

  anon173_Else:
    assume {:nonnull} IrpStack_7 != 0;
    assume IrpStack_7 > 0;
    goto anon172_Then, anon172_Else;

  anon172_Else:
    assume {:nonnull} PdoData_12 != 0;
    assume PdoData_12 > 0;
    goto anon140_Then, anon140_Else;

  anon140_Else:
    assume {:nonnull} PdoData_12 != 0;
    assume PdoData_12 > 0;
    havoc Length_6;
    call {:si_unique_call 1028} sdv_391 := ExAllocatePoolWithTag(1, Length_6, 541283905);
    idString := sdv_391;
    goto anon190_Then, anon190_Else;

  anon190_Else:
    assume {:partition} idString != 0;
    call {:si_unique_call 1029} sdv_RtlCopyMemory(0, 0, Length_6);
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    goto L43;

  anon190_Then:
    assume {:partition} idString == 0;
    ntStatus_31 := -1073741670;
    goto L43;

  anon140_Then:
    ntStatus_31 := -1073741823;
    goto L43;

  anon172_Then:
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    havoc ntStatus_31;
    goto L43;

  anon173_Then:
    assume {:nonnull} PdoData_12 != 0;
    assume PdoData_12 > 0;
    goto anon139_Then, anon139_Else;

  anon139_Else:
    assume {:nonnull} PdoData_12 != 0;
    assume PdoData_12 > 0;
    havoc Length_6;
    call {:si_unique_call 1030} sdv_382 := ExAllocatePoolWithTag(1, Length_6, 541283905);
    idString := sdv_382;
    goto anon189_Then, anon189_Else;

  anon189_Else:
    assume {:partition} idString != 0;
    call {:si_unique_call 1031} sdv_RtlCopyMemory(0, 0, Length_6);
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    goto L43;

  anon189_Then:
    assume {:partition} idString == 0;
    ntStatus_31 := -1073741670;
    goto L43;

  anon139_Then:
    ntStatus_31 := -1073741823;
    goto L43;

  anon174_Then:
    goto L119;

  L119:
    assume {:nonnull} PdoData_12 != 0;
    assume PdoData_12 > 0;
    goto anon138_Then, anon138_Else;

  anon138_Else:
    assume {:nonnull} PdoData_12 != 0;
    assume PdoData_12 > 0;
    havoc Length_6;
    call {:si_unique_call 1032} sdv_395 := ExAllocatePoolWithTag(1, Length_6, 541283905);
    idString := sdv_395;
    goto anon188_Then, anon188_Else;

  anon188_Else:
    assume {:partition} idString != 0;
    call {:si_unique_call 1033} sdv_RtlCopyMemory(0, 0, Length_6);
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    goto L43;

  anon188_Then:
    assume {:partition} idString == 0;
    ntStatus_31 := -1073741670;
    goto L43;

  anon138_Then:
    ntStatus_31 := -1073741823;
    goto L43;

  anon187_Then:
    goto L119;

  anon160_Then:
    assume {:partition} MinorFunction_2 == 12;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc PdoData_11;
    assume {:nonnull} PdoData_11 != 0;
    assume PdoData_11 > 0;
    havoc Tmp_586;
    assume {:nonnull} Tmp_586 != 0;
    assume Tmp_586 > 0;
    UnitInfo_1 := UnitIDs__BUS_DEVICE_EXTENSION(Tmp_586);
    assume {:nonnull} wszTemp_1 != 0;
    assume wszTemp_1 > 0;
    assume {:nonnull} IrpStack_7 != 0;
    assume IrpStack_7 > 0;
    goto anon184_Then, anon184_Else;

  anon184_Else:
    assume {:nonnull} IrpStack_7 != 0;
    assume IrpStack_7 > 0;
    goto anon171_Then, anon171_Else;

  anon171_Else:
    call {:si_unique_call 1034} ntStatus_31 := AvcGetDescriptionMessage(65536, wszTemp_1);
    goto anon142_Then, anon142_Else;

  anon142_Else:
    assume {:partition} ntStatus_31 == 0;
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    assume {:nonnull} wszTemp_1 != 0;
    assume wszTemp_1 > 0;
    goto L43;

  anon142_Then:
    assume {:partition} ntStatus_31 != 0;
    goto L43;

  anon171_Then:
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    havoc ntStatus_31;
    goto L43;

  anon184_Then:
    assume {:nonnull} UnitInfo_1 != 0;
    assume UnitInfo_1 > 0;
    goto anon141_Then, anon141_Else;

  anon141_Else:
    assume {:nonnull} UnitInfo_1 != 0;
    assume UnitInfo_1 > 0;
    goto anon143_Then, anon143_Else;

  anon143_Else:
    goto L184;

  L184:
    assume {:nonnull} pwszSubunit != 0;
    assume pwszSubunit > 0;
    assume {:nonnull} cbTemp != 0;
    assume cbTemp > 0;
    Mem_T.INT4[cbTemp] := 0;
    assume {:nonnull} UnitInfo_1 != 0;
    assume UnitInfo_1 > 0;
    goto anon185_Then, anon185_Else;

  anon185_Else:
    assume {:nonnull} UnitInfo_1 != 0;
    assume UnitInfo_1 > 0;
    havoc vslice_dummy_var_64;
    havoc vslice_dummy_var_65;
    call {:si_unique_call 1035} ntStatus_31 := RtlULongAdd(vslice_dummy_var_64, vslice_dummy_var_65, cbTemp);
    goto anon145_Then, anon145_Else;

  anon145_Else:
    assume {:partition} ntStatus_31 >= 0;
    assume {:nonnull} UnitInfo_1 != 0;
    assume UnitInfo_1 > 0;
    goto L200;

  L200:
    assume {:nonnull} PdoData_11 != 0;
    assume PdoData_11 > 0;
    goto anon146_Then, anon146_Else;

  anon146_Else:
    assume {:nonnull} PdoData_11 != 0;
    assume PdoData_11 > 0;
    havoc vslice_dummy_var_66;
    call {:si_unique_call 1036} ntStatus_31 := AvcGetDeviceDescriptionMessage(vslice_dummy_var_66, pwszSubunit);
    goto anon148_Then, anon148_Else;

  anon148_Else:
    assume {:partition} ntStatus_31 == 0;
    assume {:nonnull} ulStrLen != 0;
    assume ulStrLen > 0;
    Mem_T.INT4[ulStrLen] := 0;
    call {:si_unique_call 1037} ntStatus_31 := RtlULongMult(sdv_377, 2, ulStrLen);
    goto anon149_Then, anon149_Else;

  anon149_Else:
    assume {:partition} ntStatus_31 >= 0;
    assume {:nonnull} ulStrLen != 0;
    assume ulStrLen > 0;
    call {:si_unique_call 1038} ntStatus_31 := RtlULongAdd(Mem_T.INT4[ulStrLen], 2, ulStrLen);
    goto anon150_Then, anon150_Else;

  anon150_Else:
    assume {:partition} ntStatus_31 >= 0;
    assume {:nonnull} cbTemp != 0;
    assume cbTemp > 0;
    assume {:nonnull} ulStrLen != 0;
    assume ulStrLen > 0;
    call {:si_unique_call 1039} ntStatus_31 := RtlULongAdd(Mem_T.INT4[ulStrLen], Mem_T.INT4[cbTemp], cbTemp);
    goto anon151_Then, anon151_Else;

  anon151_Else:
    assume {:partition} ntStatus_31 >= 0;
    goto L201;

  L201:
    assume {:nonnull} cbTemp != 0;
    assume cbTemp > 0;
    goto anon147_Then, anon147_Else;

  anon147_Else:
    assume {:partition} 65535 > Mem_T.INT4[cbTemp];
    assume {:nonnull} cbTemp != 0;
    assume cbTemp > 0;
    call {:si_unique_call 1040} sdv_375 := ExAllocatePoolWithTag(1, Mem_T.INT4[cbTemp], 541283905);
    assume {:nonnull} wszTemp_1 != 0;
    assume wszTemp_1 > 0;
    assume {:nonnull} wszTemp_1 != 0;
    assume wszTemp_1 > 0;
    goto anon186_Then, anon186_Else;

  anon186_Else:
    call {:si_unique_call 1041} RtlInitUnicodeString(uniDeviceText, 0);
    assume {:nonnull} cbTemp != 0;
    assume cbTemp > 0;
    assume {:nonnull} uniDeviceText != 0;
    assume uniDeviceText > 0;
    assume {:nonnull} uniDeviceText != 0;
    assume uniDeviceText > 0;
    assume {:nonnull} wszTemp_1 != 0;
    assume wszTemp_1 > 0;
    call {:si_unique_call 1042} vslice_dummy_var_238 := corral_nondet();
    call {:si_unique_call 1043} vslice_dummy_var_239 := corral_nondet();
    call {:si_unique_call 1044} vslice_dummy_var_231 := corral_nondet();
    assume {:nonnull} pwszSubunit != 0;
    assume pwszSubunit > 0;
    goto anon152_Then, anon152_Else;

  anon152_Else:
    call {:si_unique_call 1045} vslice_dummy_var_240 := corral_nondet();
    call {:si_unique_call 1046} vslice_dummy_var_232 := corral_nondet();
    goto L253;

  L253:
    ntStatus_31 := 0;
    goto L260;

  L260:
    assume {:nonnull} pwszSubunit != 0;
    assume pwszSubunit > 0;
    goto anon153_Then, anon153_Else;

  anon153_Else:
    call {:si_unique_call 1047} sdv_ExFreePool(0);
    goto L261;

  L261:
    goto anon154_Then, anon154_Else;

  anon154_Else:
    assume {:partition} ntStatus_31 == 0;
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    assume {:nonnull} wszTemp_1 != 0;
    assume wszTemp_1 > 0;
    goto L43;

  anon154_Then:
    assume {:partition} ntStatus_31 != 0;
    goto L43;

  anon153_Then:
    goto L261;

  anon152_Then:
    goto L253;

  anon186_Then:
    ntStatus_31 := -1073741670;
    goto L260;

  anon147_Then:
    assume {:partition} Mem_T.INT4[cbTemp] >= 65535;
    ntStatus_31 := -1073741670;
    goto L260;

  anon151_Then:
    assume {:partition} 0 > ntStatus_31;
    goto L43;

  anon150_Then:
    assume {:partition} 0 > ntStatus_31;
    goto L43;

  anon149_Then:
    assume {:partition} 0 > ntStatus_31;
    goto L43;

  anon148_Then:
    assume {:partition} ntStatus_31 != 0;
    goto L201;

  anon146_Then:
    goto L201;

  anon145_Then:
    assume {:partition} 0 > ntStatus_31;
    goto L43;

  anon185_Then:
    assume {:nonnull} UnitInfo_1 != 0;
    assume UnitInfo_1 > 0;
    havoc vslice_dummy_var_67;
    havoc vslice_dummy_var_68;
    call {:si_unique_call 1048} ntStatus_31 := RtlULongAdd(vslice_dummy_var_67, vslice_dummy_var_68, cbTemp);
    goto anon155_Then, anon155_Else;

  anon155_Else:
    assume {:partition} ntStatus_31 >= 0;
    assume {:nonnull} UnitInfo_1 != 0;
    assume UnitInfo_1 > 0;
    goto L200;

  anon155_Then:
    assume {:partition} 0 > ntStatus_31;
    goto L43;

  anon143_Then:
    assume {:nonnull} UnitInfo_1 != 0;
    assume UnitInfo_1 > 0;
    goto anon144_Then, anon144_Else;

  anon144_Else:
    goto L184;

  anon144_Then:
    goto L178;

  L178:
    assume {:nonnull} PdoData_11 != 0;
    assume PdoData_11 > 0;
    havoc vslice_dummy_var_69;
    call {:si_unique_call 1049} ntStatus_31 := AvcGetDeviceDescriptionMessage(vslice_dummy_var_69, wszTemp_1);
    goto L261;

  anon141_Then:
    goto L178;

  anon161_Then:
    assume {:partition} MinorFunction_2 == 11;
    goto L43;

  anon162_Then:
    assume {:partition} MinorFunction_2 == 10;
    goto L43;

  anon163_Then:
    assume {:partition} MinorFunction_2 == 9;
    assume {:nonnull} IrpStack_7 != 0;
    assume IrpStack_7 > 0;
    havoc DeviceCapabilities_1;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    goto anon183_Then, anon183_Else;

  anon183_Else:
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    goto anon156_Then, anon156_Else;

  anon156_Else:
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    havoc Tmp_582;
    assume {:nonnull} Tmp_582 != 0;
    assume Tmp_582 > 0;
    Mem_T.INT4[Tmp_582 + 1 * 4] := 1;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    havoc Tmp_595;
    assume {:nonnull} Tmp_595 != 0;
    assume Tmp_595 > 0;
    Mem_T.INT4[Tmp_595 + 2 * 4] := 4;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    havoc Tmp_596;
    assume {:nonnull} Tmp_596 != 0;
    assume Tmp_596 > 0;
    Mem_T.INT4[Tmp_596 + 3 * 4] := 4;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    havoc Tmp_592;
    assume {:nonnull} Tmp_592 != 0;
    assume Tmp_592 > 0;
    Mem_T.INT4[Tmp_592 + 4 * 4] := 4;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    havoc Tmp_579;
    assume {:nonnull} Tmp_579 != 0;
    assume Tmp_579 > 0;
    Mem_T.INT4[Tmp_579 + 5 * 4] := 4;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    havoc Tmp_589;
    assume {:nonnull} Tmp_589 != 0;
    assume Tmp_589 > 0;
    Mem_T.INT4[Tmp_589 + 6 * 4] := 4;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    assume {:nonnull} DeviceCapabilities_1 != 0;
    assume DeviceCapabilities_1 > 0;
    goto L43;

  anon156_Then:
    goto L274;

  L274:
    ntStatus_31 := -1073741823;
    goto L43;

  anon183_Then:
    goto L274;

  anon164_Then:
    assume {:partition} MinorFunction_2 == 7;
    assume {:nonnull} IrpStack_7 != 0;
    assume IrpStack_7 > 0;
    goto anon129_Then, anon129_Else;

  anon129_Else:
    call {:si_unique_call 1050} sdv_379 := ExAllocatePoolWithTag(1, 8, 541283905);
    Relation := sdv_379;
    goto anon182_Then, anon182_Else;

  anon182_Else:
    assume {:partition} Relation != 0;
    call {:si_unique_call 1051} vslice_dummy_var_233 := sdv_ObReferenceObject(0);
    assume {:nonnull} Relation != 0;
    assume Relation > 0;
    assume {:nonnull} Relation != 0;
    assume Relation > 0;
    havoc Tmp_578;
    assume {:nonnull} Tmp_578 != 0;
    assume Tmp_578 > 0;
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    goto L43;

  anon182_Then:
    assume {:partition} Relation == 0;
    ntStatus_31 := -1073741670;
    goto L43;

  anon129_Then:
    assume {:nonnull} Irp_28 != 0;
    assume Irp_28 > 0;
    havoc ntStatus_31;
    goto L43;

  anon165_Then:
    assume {:partition} MinorFunction_2 == 6;
    goto L43;

  anon166_Then:
    assume {:partition} MinorFunction_2 == 5;
    goto L43;

  anon167_Then:
    assume {:partition} MinorFunction_2 == 4;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc Tmp_584;
    assume {:nonnull} Tmp_584 != 0;
    assume Tmp_584 > 0;
    goto L43;

  anon168_Then:
    assume {:partition} MinorFunction_2 == 3;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    goto L43;

  anon169_Then:
    assume {:partition} MinorFunction_2 == 2;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    goto anon181_Then, anon181_Else;

  anon181_Else:
    call {:si_unique_call 1052} vslice_dummy_var_234 := sdv_ObDereferenceObject(0);
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    goto L311;

  L311:
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc Tmp_591;
    assume {:nonnull} Tmp_591 != 0;
    assume Tmp_591 > 0;
    goto L43;

  anon181_Then:
    goto L311;

  anon170_Then:
    assume {:partition} MinorFunction_2 == 1;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    goto L43;

  anon175_Then:
    assume {:partition} MinorFunction_2 == 0;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc Tmp_580;
    assume {:nonnull} Tmp_580 != 0;
    assume Tmp_580 > 0;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    goto anon176_Then, anon176_Else;

  anon176_Else:
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    havoc Tmp_576;
    assume {:nonnull} Tmp_576 != 0;
    assume Tmp_576 > 0;
    havoc Tmp_590;
    assume {:nonnull} PdoExtension_2 != 0;
    assume PdoExtension_2 > 0;
    assume {:nonnull} Tmp_590 != 0;
    assume Tmp_590 > 0;
    havoc vslice_dummy_var_70;
    call {:si_unique_call 1053} boogieTmp := IoGetAttachedDeviceReference(vslice_dummy_var_70);
    goto L43;

  anon176_Then:
    goto L43;
}



procedure {:origName "AvcAddToPdoList"} AvcAddToPdoList(actual_BusExtension_18: int, actual_PdoData_13: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcAddToPdoList"} AvcAddToPdoList(actual_BusExtension_18: int, actual_PdoData_13: int)
{
  var {:scalar} oldIrql_3: int;
  var {:pointer} Tmp_598: int;
  var {:pointer} BusExtension_18: int;
  var {:pointer} PdoData_13: int;
  var vslice_dummy_var_241: int;
  var vslice_dummy_var_242: int;

  anon0:
    call {:si_unique_call 1054} vslice_dummy_var_241 := __HAVOC_malloc(4);
    BusExtension_18 := actual_BusExtension_18;
    PdoData_13 := actual_PdoData_13;
    call {:si_unique_call 1055} Tmp_598 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_598 != 0;
    assume Tmp_598 > 0;
    Mem_T.INT4[Tmp_598] := oldIrql_3;
    call {:si_unique_call 1056} sdv_KeAcquireSpinLock(0, Tmp_598);
    assume {:nonnull} Tmp_598 != 0;
    assume Tmp_598 > 0;
    oldIrql_3 := Mem_T.INT4[Tmp_598];
    assume {:nonnull} BusExtension_18 != 0;
    assume BusExtension_18 > 0;
    assume {:nonnull} PdoData_13 != 0;
    assume PdoData_13 > 0;
    call {:si_unique_call 1057} vslice_dummy_var_242 := sdv_InsertTailList(PdoList__BUS_DEVICE_EXTENSION(BusExtension_18), PdoList__PDO_DATA(PdoData_13));
    call {:si_unique_call 1058} sdv_KeReleaseSpinLock(0, oldIrql_3);
    return;
}



procedure {:origName "Avc_FDO_PowerComplete"} Avc_FDO_PowerComplete(actual_DeviceObject_24: int, actual_Irp_29: int, actual_BusExtensionIn: int) returns (Tmp_600: int);
  modifies alloc;
  free ensures Tmp_600 == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "Avc_FDO_PowerComplete"} Avc_FDO_PowerComplete(actual_DeviceObject_24: int, actual_Irp_29: int, actual_BusExtensionIn: int) returns (Tmp_600: int)
{
  var {:pointer} structPtr888sdv: int;
  var {:scalar} State_2: int;
  var {:pointer} IrpStack_8: int;
  var {:scalar} sdv: int;
  var {:scalar} StateType: int;
  var {:pointer} BusExtension_19: int;
  var {:pointer} Irp_29: int;
  var {:pointer} BusExtensionIn: int;

  anon0:
    call {:si_unique_call 1059} State_2 := __HAVOC_malloc(8);
    call {:si_unique_call 1060} sdv := __HAVOC_malloc(8);
    Irp_29 := actual_Irp_29;
    BusExtensionIn := actual_BusExtensionIn;
    BusExtension_19 := BusExtensionIn;
    assume {:nonnull} Irp_29 != 0;
    assume Irp_29 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 1061} sdv_IoMarkIrpPending(0);
    goto L9;

  L9:
    call {:si_unique_call 1062} IrpStack_8 := sdv_IoGetCurrentIrpStackLocation(Irp_29);
    assume {:nonnull} IrpStack_8 != 0;
    assume IrpStack_8 > 0;
    assume {:nonnull} State_2 != 0;
    assume State_2 > 0;
    assume {:nonnull} IrpStack_8 != 0;
    assume IrpStack_8 > 0;
    assume {:nonnull} State_2 != 0;
    assume State_2 > 0;
    assume {:nonnull} IrpStack_8 != 0;
    assume IrpStack_8 > 0;
    havoc StateType;
    assume {:nonnull} BusExtension_19 != 0;
    assume BusExtension_19 > 0;
    assume {:nonnull} State_2 != 0;
    assume State_2 > 0;
    call {:si_unique_call 1063} structPtr888sdv := PoSetPowerState(0, StateType, State_2);
    assume {:nonnull} sdv != 0;
    assume sdv > 0;
    assume {:nonnull} structPtr888sdv != 0;
    assume structPtr888sdv > 0;
    assume {:nonnull} sdv != 0;
    assume sdv > 0;
    assume {:nonnull} structPtr888sdv != 0;
    assume structPtr888sdv > 0;
    call {:si_unique_call 1064} PoStartNextPowerIrp(0);
    Tmp_600 := 0;
    return;

  anon3_Then:
    goto L9;
}



procedure {:origName "_sdv_init4"} _sdv_init4();
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init4"} _sdv_init4()
{
  var vslice_dummy_var_243: int;

  anon0:
    call {:si_unique_call 1065} vslice_dummy_var_243 := __HAVOC_malloc(4);
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    return;
}



procedure {:origName "sdv_hash_114568688"} sdv_hash_114568688(actual_this_3: int, actual_s_p_e_c_i_a_l_3: int) returns (Tmp_604: int);
  modifies alloc;
  free ensures Tmp_604 == actual_this_3;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_114568688"} sdv_hash_114568688(actual_this_3: int, actual_s_p_e_c_i_a_l_3: int) returns (Tmp_604: int)
{
  var {:pointer} this_3: int;
  var {:scalar} s_p_e_c_i_a_l_3: int;

  anon0:
    this_3 := actual_this_3;
    s_p_e_c_i_a_l_3 := actual_s_p_e_c_i_a_l_3;
    call {:si_unique_call 1066} sdv_hash_757443034_sdv_special_DTOR(this_3);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} BAND(s_p_e_c_i_a_l_3, 1) != 0;
    call {:si_unique_call 1067} sdv_hash_648063079(this_3);
    goto L7;

  L7:
    Tmp_604 := this_3;
    return;

  anon3_Then:
    assume {:partition} BAND(s_p_e_c_i_a_l_3, 1) == 0;
    goto L7;
}



procedure {:origName "sdv_hash_648063079"} sdv_hash_648063079(actual_p_5: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_648063079"} sdv_hash_648063079(actual_p_5: int)
{
  var vslice_dummy_var_244: int;

  anon0:
    call {:si_unique_call 1068} vslice_dummy_var_244 := __HAVOC_malloc(4);
    call {:si_unique_call 1069} sdv_ExFreePool(0);
    return;
}



procedure {:origName "_sdv_init1"} _sdv_init1();
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "_sdv_init1"} _sdv_init1()
{
  var vslice_dummy_var_245: int;

  anon0:
    call {:si_unique_call 1070} vslice_dummy_var_245 := __HAVOC_malloc(4);
    assume ClfsNullRecord_2 == 0;
    assume ClfsDataRecord_2 == 1;
    assume ClfsRestartRecord_2 == 2;
    assume ClfsClientRecord_2 == 3;
    assume ClsContainerInitializing_2 == 1;
    assume ClsContainerInactive_2 == 2;
    assume ClsContainerActive_2 == 4;
    assume ClsContainerActivePendingDelete_2 == 8;
    assume ClsContainerPendingArchive_2 == 16;
    assume ClsContainerPendingArchiveAndDelete_2 == 32;
    assume ClfsContainerInitializing_2 == 1;
    assume ClfsContainerInactive_2 == 2;
    assume ClfsContainerActive_2 == 4;
    assume ClfsContainerActivePendingDelete_2 == 8;
    assume ClfsContainerPendingArchive_2 == 16;
    assume ClfsContainerPendingArchiveAndDelete_2 == 32;
    assume CLFS_MAX_CONTAINER_INFO_2 == 256;
    assume CLFS_SCAN_INIT_2 == 1;
    assume CLFS_SCAN_FORWARD_2 == 2;
    assume CLFS_SCAN_BACKWARD_2 == 4;
    assume CLFS_SCAN_CLOSE_2 == 8;
    assume CLFS_SCAN_INITIALIZED_2 == 16;
    assume CLFS_SCAN_BUFFERED_2 == 32;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    havoc Mem_T.INT4;
    assume UnitAddr_1 == 255;
    return;
}



procedure {:origName "InsertHeadList"} InsertHeadList(actual_ListHead_1: int, actual_Entry_9: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "InsertHeadList"} InsertHeadList(actual_ListHead_1: int, actual_Entry_9: int)
{
  var {:pointer} NextEntry: int;
  var {:pointer} ListHead_1: int;
  var {:pointer} Entry_9: int;
  var vslice_dummy_var_246: int;
  var vslice_dummy_var_71: int;

  anon0:
    call {:si_unique_call 1071} vslice_dummy_var_246 := __HAVOC_malloc(4);
    ListHead_1 := actual_ListHead_1;
    Entry_9 := actual_Entry_9;
    assume {:nonnull} ListHead_1 != 0;
    assume ListHead_1 > 0;
    havoc NextEntry;
    assume {:nonnull} Entry_9 != 0;
    assume Entry_9 > 0;
    assume {:nonnull} Entry_9 != 0;
    assume Entry_9 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} NextEntry != 0;
    assume NextEntry > 0;
    havoc vslice_dummy_var_71;
    call {:si_unique_call 1072} FatalListEntryError(ListHead_1, NextEntry, vslice_dummy_var_71);
    goto L8;

  L8:
    assume {:nonnull} NextEntry != 0;
    assume NextEntry > 0;
    assume {:nonnull} ListHead_1 != 0;
    assume ListHead_1 > 0;
    return;

  anon3_Then:
    goto L8;
}



procedure {:origName "sdv_hash_771437190"} sdv_hash_771437190(actual_p_6: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_771437190"} sdv_hash_771437190(actual_p_6: int)
{
  var vslice_dummy_var_247: int;

  anon0:
    call {:si_unique_call 1073} vslice_dummy_var_247 := __HAVOC_malloc(4);
    call {:si_unique_call 1074} sdv_ExFreePool(0);
    return;
}



procedure {:origName "InitializeListHead"} InitializeListHead(actual_ListHead_2: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "InitializeListHead"} InitializeListHead(actual_ListHead_2: int)
{
  var {:pointer} ListHead_2: int;
  var vslice_dummy_var_248: int;

  anon0:
    call {:si_unique_call 1075} vslice_dummy_var_248 := __HAVOC_malloc(4);
    ListHead_2 := actual_ListHead_2;
    assume {:nonnull} ListHead_2 != 0;
    assume ListHead_2 > 0;
    assume {:nonnull} ListHead_2 != 0;
    assume ListHead_2 > 0;
    return;
}



procedure {:origName "sdv_hash_672547288"} sdv_hash_672547288(actual_s_p_e_c_i_a_l_4: int, actual_s_p_e_c_i_a_l_5: int, actual_s_p_e_c_i_a_l_6: int, actual_s_p_e_c_i_a_l_7: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_672547288"} sdv_hash_672547288(actual_s_p_e_c_i_a_l_4: int, actual_s_p_e_c_i_a_l_5: int, actual_s_p_e_c_i_a_l_6: int, actual_s_p_e_c_i_a_l_7: int)
{
  var {:pointer} s_p_e_c_i_a_l_4: int;
  var {:scalar} s_p_e_c_i_a_l_6: int;
  var {:scalar} s_p_e_c_i_a_l_7: int;
  var vslice_dummy_var_249: int;

  anon0:
    call {:si_unique_call 1076} vslice_dummy_var_249 := __HAVOC_malloc(4);
    s_p_e_c_i_a_l_4 := actual_s_p_e_c_i_a_l_4;
    s_p_e_c_i_a_l_6 := actual_s_p_e_c_i_a_l_6;
    s_p_e_c_i_a_l_7 := actual_s_p_e_c_i_a_l_7;
    goto L4;

  L4:
    call {:si_unique_call 1077} s_p_e_c_i_a_l_6 := sdv_hash_672547288_loop_L4(s_p_e_c_i_a_l_4, s_p_e_c_i_a_l_6, s_p_e_c_i_a_l_7);
    goto L4_last;

  L4_last:
    s_p_e_c_i_a_l_6 := s_p_e_c_i_a_l_6 - 1;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} s_p_e_c_i_a_l_6 >= 0;
    assume {:IndirectCall} true;
    assume s_p_e_c_i_a_l_7 == li2bplFunctionConstant374;
    call {:si_unique_call 1078} sdv_hash_330311584_sdv_special_DTOR(s_p_e_c_i_a_l_4);
    goto anon3_Else_dummy;

  anon3_Else_dummy:
    assume false;
    return;

  anon3_Then:
    assume {:partition} 0 > s_p_e_c_i_a_l_6;
    return;
}



procedure {:origName "RemoveHeadList"} RemoveHeadList(actual_ListHead_3: int) returns (Tmp_618: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RemoveHeadList"} RemoveHeadList(actual_ListHead_3: int) returns (Tmp_618: int)
{
  var {:pointer} NextEntry_1: int;
  var {:pointer} Entry_10: int;
  var {:pointer} ListHead_3: int;

  anon0:
    ListHead_3 := actual_ListHead_3;
    assume {:nonnull} ListHead_3 != 0;
    assume ListHead_3 > 0;
    havoc Entry_10;
    assume {:nonnull} Entry_10 != 0;
    assume Entry_10 > 0;
    havoc NextEntry_1;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    goto L9;

  L9:
    call {:si_unique_call 1079} FatalListEntryError(ListHead_3, Entry_10, NextEntry_1);
    goto L12;

  L12:
    assume {:nonnull} ListHead_3 != 0;
    assume ListHead_3 > 0;
    assume {:nonnull} NextEntry_1 != 0;
    assume NextEntry_1 > 0;
    Tmp_618 := Entry_10;
    return;

  anon6_Then:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto L12;

  anon5_Then:
    goto L9;
}



procedure {:origName "sdv_hash_648551832_sdv_special_DTOR"} sdv_hash_648551832_sdv_special_DTOR(actual_this_4: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_648551832_sdv_special_DTOR"} sdv_hash_648551832_sdv_special_DTOR(actual_this_4: int)
{
  var vslice_dummy_var_250: int;

  anon0:
    call {:si_unique_call 1080} vslice_dummy_var_250 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "FatalListEntryError"} FatalListEntryError(actual_p1_1: int, actual_p2_1: int, actual_p3: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "FatalListEntryError"} FatalListEntryError(actual_p1_1: int, actual_p2_1: int, actual_p3: int)
{
  var vslice_dummy_var_251: int;

  anon0:
    call {:si_unique_call 1081} vslice_dummy_var_251 := __HAVOC_malloc(4);
    call {:si_unique_call 1082} RtlFailFast(3);
    return;
}



procedure {:origName "sdv_hash_290170512"} sdv_hash_290170512(actual_p_7: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_290170512"} sdv_hash_290170512(actual_p_7: int)
{
  var vslice_dummy_var_252: int;

  anon0:
    call {:si_unique_call 1083} vslice_dummy_var_252 := __HAVOC_malloc(4);
    call {:si_unique_call 1084} sdv_ExFreePool(0);
    return;
}



procedure {:origName "sdv_hash_385729890"} sdv_hash_385729890(actual_this_5: int, actual_s_p_e_c_i_a_l_8: int) returns (Tmp_626: int);
  modifies alloc;
  free ensures Tmp_626 == 0 || Tmp_626 == actual_this_5;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_385729890"} sdv_hash_385729890(actual_this_5: int, actual_s_p_e_c_i_a_l_8: int) returns (Tmp_626: int)
{
  var {:scalar} Tmp_627: int;
  var {:pointer} Tmp_629: int;
  var {:pointer} Tmp_630: int;
  var {:pointer} this_5: int;
  var {:scalar} s_p_e_c_i_a_l_8: int;

  anon0:
    this_5 := actual_this_5;
    s_p_e_c_i_a_l_8 := actual_s_p_e_c_i_a_l_8;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} BAND(s_p_e_c_i_a_l_8, 2) != 0;
    Tmp_629 := 0;
    assume {:nonnull} Tmp_629 != 0;
    assume Tmp_629 > 0;
    havoc Tmp_627;
    call {:si_unique_call 1085} sdv_hash_672547288(this_5, 96, Tmp_627, li2bplFunctionConstant374);
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} BAND(s_p_e_c_i_a_l_8, 1) != 0;
    Tmp_630 := 0;
    call {:si_unique_call 1086} sdv_hash_771437190(Tmp_630);
    goto L12;

  L12:
    Tmp_626 := 0;
    goto L1;

  L1:
    return;

  anon8_Then:
    assume {:partition} BAND(s_p_e_c_i_a_l_8, 1) == 0;
    goto L12;

  anon7_Then:
    assume {:partition} BAND(s_p_e_c_i_a_l_8, 2) == 0;
    call {:si_unique_call 1087} sdv_hash_330311584_sdv_special_DTOR(this_5);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} BAND(s_p_e_c_i_a_l_8, 1) != 0;
    call {:si_unique_call 1088} sdv_hash_290170512(this_5);
    goto L18;

  L18:
    Tmp_626 := this_5;
    goto L1;

  anon9_Then:
    assume {:partition} BAND(s_p_e_c_i_a_l_8, 1) == 0;
    goto L18;
}



procedure {:origName "sdv_hash_757443034_sdv_special_DTOR"} sdv_hash_757443034_sdv_special_DTOR(actual_this_6: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_hash_757443034_sdv_special_DTOR"} sdv_hash_757443034_sdv_special_DTOR(actual_this_6: int)
{
  var {:pointer} Tmp_631: int;
  var {:pointer} Tmp_632: int;
  var {:pointer} this_6: int;
  var vslice_dummy_var_253: int;
  var vslice_dummy_var_254: int;

  anon0:
    call {:si_unique_call 1089} vslice_dummy_var_253 := __HAVOC_malloc(4);
    this_6 := actual_this_6;
    assume {:nonnull} this_6 != 0;
    assume this_6 > 0;
    havoc Tmp_632;
    Tmp_631 := Tmp_632;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} Tmp_631 != 0;
    call {:si_unique_call 1090} vslice_dummy_var_254 := sdv_hash_385729890(Tmp_631, 3);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} Tmp_631 == 0;
    goto L1;
}



procedure {:origName "ExFreeToNPagedLookasideList"} ExFreeToNPagedLookasideList(actual_Lookaside_3: int, actual_Entry_11: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "ExFreeToNPagedLookasideList"} ExFreeToNPagedLookasideList(actual_Lookaside_3: int, actual_Entry_11: int)
{
  var {:pointer} Tmp_637: int;
  var {:pointer} Lookaside_3: int;
  var vslice_dummy_var_255: int;
  var vslice_dummy_var_256: int;

  anon0:
    call {:si_unique_call 1091} vslice_dummy_var_255 := __HAVOC_malloc(4);
    Lookaside_3 := actual_Lookaside_3;
    assume {:nonnull} Lookaside_3 != 0;
    assume Lookaside_3 > 0;
    assume {:nonnull} Lookaside_3 != 0;
    assume Lookaside_3 > 0;
    Tmp_637 := ListHead__GENERAL_LOOKASIDE(L__NPAGED_LOOKASIDE_LIST(Lookaside_3));
    assume {:nonnull} Lookaside_3 != 0;
    assume Lookaside_3 > 0;
    assume {:nonnull} Tmp_637 != 0;
    assume Tmp_637 > 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:nonnull} Lookaside_3 != 0;
    assume Lookaside_3 > 0;
    assume {:nonnull} Lookaside_3 != 0;
    assume Lookaside_3 > 0;
    goto L1;

  L1:
    return;

  anon6_Then:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto L1;

  anon5_Then:
    call {:si_unique_call 1092} vslice_dummy_var_256 := __HAVOC_malloc(1);
    goto L1;
}



procedure {:origName "RtlFailFast"} RtlFailFast(actual_Code: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RtlFailFast"} RtlFailFast(actual_Code: int)
{
  var vslice_dummy_var_257: int;

  anon0:
    call {:si_unique_call 1093} vslice_dummy_var_257 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "RemoveConnectionMgr"} RemoveConnectionMgr(actual_PdoData_14: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "RemoveConnectionMgr"} RemoveConnectionMgr(actual_PdoData_14: int)
{
  var {:pointer} Tmp_640: int;
  var {:pointer} MgrInstance: int;
  var {:pointer} Tmp_643: int;
  var {:pointer} PdoData_14: int;
  var vslice_dummy_var_258: int;
  var vslice_dummy_var_259: int;

  anon0:
    call {:si_unique_call 1094} vslice_dummy_var_258 := __HAVOC_malloc(4);
    PdoData_14 := actual_PdoData_14;
    call {:si_unique_call 1095} sdv_do_paged_code_check();
    assume {:nonnull} PdoData_14 != 0;
    assume PdoData_14 > 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:nonnull} PdoData_14 != 0;
    assume PdoData_14 > 0;
    havoc MgrInstance;
    assume {:nonnull} PdoData_14 != 0;
    assume PdoData_14 > 0;
    Tmp_643 := MgrInstance;
    Tmp_640 := Tmp_643;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} Tmp_640 != 0;
    call {:si_unique_call 1096} vslice_dummy_var_259 := sdv_hash_114568688(Tmp_640, 1);
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} Tmp_640 == 0;
    goto L1;

  anon5_Then:
    goto L1;
}



procedure {:dopa "Mem_T.INT4"} dummy_for_pa();



procedure corralExplainErrorInit();



procedure corralExtraInit();
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation corralExtraInit()
{

  anon0:
    assume 0 < alloc_init;
    assume alloc_init < alloc;
    return;
}



function {:inline true} {:fieldmap "Mem_T.AddDevice__DRIVER_EXTENSION"} {:fieldname "AddDevice"} AddDevice__DRIVER_EXTENSION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.AlternateOpcodes__AVC_COMMAND_CONTEXT"} {:fieldname "AlternateOpcodes"} AlternateOpcodes__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 196
}

function {:inline true} {:fieldmap "Mem_T.Argument1_unnamed_tag_42"} {:fieldname "Argument1"} Argument1_unnamed_tag_42(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.BidFlag__PDO_DATA"} {:fieldname "BidFlag"} BidFlag__PDO_DATA(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.Blink__LIST_ENTRY"} {:fieldname "Blink"} Blink__LIST_ENTRY(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Buffer__UNICODE_STRING"} {:fieldname "Buffer"} Buffer__UNICODE_STRING(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.BusExtension__PDO_DATA"} {:fieldname "BusExtension"} BusExtension__PDO_DATA(x: int) : int
{
  x + 64
}

function {:inline true} {:fieldmap "Mem_T.BusNumber__PNP_BUS_INFORMATION"} {:fieldname "BusNumber"} BusNumber__PNP_BUS_INFORMATION(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.BusResetNotify__AV_61883_REQUEST"} {:fieldname "BusResetNotify"} BusResetNotify__AV_61883_REQUEST(x: int) : int
{
  x + 420
}

function {:inline true} {:fieldmap "Mem_T.BusReset_unnamed_tag_68"} {:fieldname "BusReset"} BusReset_unnamed_tag_68(x: int) : int
{
  x + 972
}

function {:inline true} {:fieldmap "Mem_T.BusTypeGuid__PNP_BUS_INFORMATION"} {:fieldname "BusTypeGuid"} BusTypeGuid__PNP_BUS_INFORMATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "CallbackChain"} CallbackChain__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.Callback__AVC_CALLBACK_LINK"} {:fieldname "Callback"} Callback__AVC_CALLBACK_LINK(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.CancelRoutine__IRP"} {:fieldname "CancelRoutine"} CancelRoutine__IRP(x: int) : int
{
  x + 120
}

function {:inline true} {:fieldmap "Mem_T.Cancel__IRP"} {:fieldname "Cancel"} Cancel__IRP(x: int) : int
{
  x + 64
}

function {:inline true} {:fieldmap "Mem_T.Capabilities_unnamed_tag_30"} {:fieldname "Capabilities"} Capabilities_unnamed_tag_30(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "CleanupList"} CleanupList__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 392
}

function {:inline true} {:fieldmap "Mem_T.CmdDelay__BUS_DEVICE_EXTENSION"} {:fieldname "CmdDelay"} CmdDelay__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 5792
}

function {:inline true} {:fieldmap "Mem_T.CmdResourceLock__BUS_DEVICE_EXTENSION"} {:fieldname "CmdResourceLock"} CmdResourceLock__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 5596
}

function {:inline true} {:fieldmap "Mem_T.CommandType__AVC_COMMAND_CONTEXT"} {:fieldname "CommandType"} CommandType__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.CommandType__AVC_COMMAND_IRB"} {:fieldname "CommandType"} CommandType__AVC_COMMAND_IRB(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"} {:fieldname "CompatIds"} CompatIds__PDO_DATA(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.CompletionRoutine__IO_STACK_LOCATION"} {:fieldname "CompletionRoutine"} CompletionRoutine__IO_STACK_LOCATION(x: int) : int
{
  x + 536
}

function {:inline true} {:fieldmap "Mem_T.Context__AVC_CALLBACK_LINK"} {:fieldname "Context"} Context__AVC_CALLBACK_LINK(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Context__BUS_RESET_NOTIFY"} {:fieldname "Context"} Context__BUS_RESET_NOTIFY(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Context__PDO_DATA"} {:fieldname "Context"} Context__PDO_DATA(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T.Count__DEVICE_RELATIONS"} {:fieldname "Count"} Count__DEVICE_RELATIONS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.CurrentStackLocation_unnamed_tag_7"} {:fieldname "CurrentStackLocation"} CurrentStackLocation_unnamed_tag_7(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.D1Latency__DEVICE_CAPABILITIES"} {:fieldname "D1Latency"} D1Latency__DEVICE_CAPABILITIES(x: int) : int
{
  x + 136
}

function {:inline true} {:fieldmap "Mem_T.D2Latency__DEVICE_CAPABILITIES"} {:fieldname "D2Latency"} D2Latency__DEVICE_CAPABILITIES(x: int) : int
{
  x + 140
}

function {:inline true} {:fieldmap "Mem_T.D3Latency__DEVICE_CAPABILITIES"} {:fieldname "D3Latency"} D3Latency__DEVICE_CAPABILITIES(x: int) : int
{
  x + 144
}

function {:inline true} {:fieldmap "Mem_T.Data1__GUID"} {:fieldname "Data1"} Data1__GUID(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Data2__GUID"} {:fieldname "Data2"} Data2__GUID(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Data3__GUID"} {:fieldname "Data3"} Data3__GUID(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Data4__GUID"} {:fieldname "Data4"} Data4__GUID(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.DataLength__KEY_VALUE_PARTIAL_INFORMATION"} {:fieldname "DataLength"} DataLength__KEY_VALUE_PARTIAL_INFORMATION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Data__KEY_VALUE_PARTIAL_INFORMATION"} {:fieldname "Data"} Data__KEY_VALUE_PARTIAL_INFORMATION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Depth__GENERAL_LOOKASIDE"} {:fieldname "Depth"} Depth__GENERAL_LOOKASIDE(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Depth__SLIST_HEADER"} {:fieldname "Depth"} Depth__SLIST_HEADER(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Designation__AVC_COMMAND_CONTEXT"} {:fieldname "Designation"} Designation__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.DevExt__AVC_COMMAND_CONTEXT"} {:fieldname "DevExt"} DevExt__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DeviceCapabilities_unnamed_tag_8"} {:fieldname "DeviceCapabilities"} DeviceCapabilities_unnamed_tag_8(x: int) : int
{
  x + 352
}

function {:inline true} {:fieldmap "Mem_T.DeviceExtension__DEVICE_OBJECT"} {:fieldname "DeviceExtension"} DeviceExtension__DEVICE_OBJECT(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.DeviceIoControl_unnamed_tag_8"} {:fieldname "DeviceIoControl"} DeviceIoControl_unnamed_tag_8(x: int) : int
{
  x + 256
}

function {:inline true} {:fieldmap "Mem_T.DeviceObject__BUS_DEVICE_EXTENSION"} {:fieldname "DeviceObject"} DeviceObject__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DeviceObject__PDO_DATA"} {:fieldname "DeviceObject"} DeviceObject__PDO_DATA(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.DeviceObject__PDO_DEVICE_EXTENSION"} {:fieldname "DeviceObject"} DeviceObject__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DeviceState__BUS_DEVICE_EXTENSION"} {:fieldname "DeviceState"} DeviceState__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 200
}

function {:inline true} {:fieldmap "Mem_T.DeviceState__DEVICE_CAPABILITIES"} {:fieldname "DeviceState"} DeviceState__DEVICE_CAPABILITIES(x: int) : int
{
  x + 100
}

function {:inline true} {:fieldmap "Mem_T.DeviceState__PDO_DEVICE_EXTENSION"} {:fieldname "DeviceState"} DeviceState__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 200
}

function {:inline true} {:fieldmap "Mem_T.DeviceState__POWER_STATE"} {:fieldname "DeviceState"} DeviceState__POWER_STATE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.DeviceTextType_unnamed_tag_35"} {:fieldname "DeviceTextType"} DeviceTextType_unnamed_tag_35(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DeviceWake__DEVICE_CAPABILITIES"} {:fieldname "DeviceWake"} DeviceWake__DEVICE_CAPABILITIES(x: int) : int
{
  x + 132
}

function {:inline true} {:fieldmap "Mem_T.DriverExtension__DRIVER_OBJECT"} {:fieldname "DriverExtension"} DriverExtension__DRIVER_OBJECT(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.DriverUnload__DRIVER_OBJECT"} {:fieldname "DriverUnload"} DriverUnload__DRIVER_OBJECT(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.Enumerated__PDO_DATA"} {:fieldname "Enumerated"} Enumerated__PDO_DATA(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.ExtensionCode__AVC_SUBUNIT_INFO"} {:fieldname "ExtensionCode"} ExtensionCode__AVC_SUBUNIT_INFO(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "FdoEntry"} FdoEntry__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 228
}

function {:inline true} {:fieldmap "Mem_T.FileName__FILE_OBJECT"} {:fieldname "FileName"} FileName__FILE_OBJECT(x: int) : int
{
  x + 76
}

function {:inline true} {:fieldmap "Mem_T.FileObject__IO_STACK_LOCATION"} {:fieldname "FileObject"} FileObject__IO_STACK_LOCATION(x: int) : int
{
  x + 532
}

function {:inline true} {:fieldmap "Mem_T.Flags__BUS_RESET_NOTIFY"} {:fieldname "Flags"} Flags__BUS_RESET_NOTIFY(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Flags__DEVICE_OBJECT"} {:fieldname "Flags"} Flags__DEVICE_OBJECT(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Flags__IRB"} {:fieldname "Flags"} Flags__IRB(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Flags__RTL_QUERY_REGISTRY_TABLE"} {:fieldname "Flags"} Flags__RTL_QUERY_REGISTRY_TABLE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Flags__SET_FCP_NOTIFY"} {:fieldname "Flags"} Flags__SET_FCP_NOTIFY(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Flags__SET_UNIT_DIRECTORY"} {:fieldname "Flags"} Flags__SET_UNIT_DIRECTORY(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Flink__LIST_ENTRY"} {:fieldname "Flink"} Flink__LIST_ENTRY(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Frame"} Frame__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 672
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Frame"} Frame__AVC_FCP_REQUEST(x: int) : int
{
  x + 460
}

function {:inline true} {:fieldmap "Mem_T.Frame__FCP_GET_REQUEST"} {:fieldname "Frame"} Frame__FCP_GET_REQUEST(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.FreeMisses__GENERAL_LOOKASIDE"} {:fieldname "FreeMisses"} FreeMisses__GENERAL_LOOKASIDE(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.Free__GENERAL_LOOKASIDE"} {:fieldname "Free"} Free__GENERAL_LOOKASIDE(x: int) : int
{
  x + 76
}

function {:inline true} {:fieldmap "Mem_T.FunctionNumber__IRB"} {:fieldname "FunctionNumber"} FunctionNumber__IRB(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "Function"} Function__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 212
}

function {:inline true} {:fieldmap "Mem_T.Function__AVC_FCP_REQUEST"} {:fieldname "Function"} Function__AVC_FCP_REQUEST(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Function__AV_61883_REQUEST"} {:fieldname "Function"} Function__AV_61883_REQUEST(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.GenerationCount__IRB_REQ_GET_GENERATION_COUNT"} {:fieldname "GenerationCount"} GenerationCount__IRB_REQ_GET_GENERATION_COUNT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Generation__AVC_COMMAND_CONTEXT"} {:fieldname "Generation"} Generation__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 2728
}

function {:inline true} {:fieldmap "Mem_T.Generation__AVC_COMMAND_IRB"} {:fieldname "Generation"} Generation__AVC_COMMAND_IRB(x: int) : int
{
  x + 2112
}

function {:inline true} {:fieldmap "Mem_T.GetRequest__AVC_FCP_REQUEST"} {:fieldname "GetRequest"} GetRequest__AVC_FCP_REQUEST(x: int) : int
{
  x + 228
}

function {:inline true} {:fieldmap "Mem_T.GetUnitInfo__AV_61883_REQUEST"} {:fieldname "GetUnitInfo"} GetUnitInfo__AV_61883_REQUEST(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"} {:fieldname "HardwareIds"} HardwareIds__PDO_DATA(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.Header__KEVENT"} {:fieldname "Header"} Header__KEVENT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.HighPart__LUID"} {:fieldname "HighPart"} HighPart__LUID(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.IdType_unnamed_tag_34"} {:fieldname "IdType"} IdType_unnamed_tag_34(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Information__GET_UNIT_INFO"} {:fieldname "Information"} Information__GET_UNIT_INFO(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Information__IO_STATUS_BLOCK"} {:fieldname "Information"} Information__IO_STATUS_BLOCK(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.IoControlCode_unnamed_tag_22"} {:fieldname "IoControlCode"} IoControlCode_unnamed_tag_22(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.IoCount__AVC_REMOVE_LOCK"} {:fieldname "IoCount"} IoCount__AVC_REMOVE_LOCK(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.IoStatus__IRP"} {:fieldname "IoStatus"} IoStatus__IRP(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.IsVirtual__BUS_DEVICE_EXTENSION"} {:fieldname "IsVirtual"} IsVirtual__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.IsVirtual__PDO_DEVICE_EXTENSION"} {:fieldname "IsVirtual"} IsVirtual__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.L__NPAGED_LOOKASIDE_LIST"} {:fieldname "L"} L__NPAGED_LOOKASIDE_LIST(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.LegacyBusType__PNP_BUS_INFORMATION"} {:fieldname "LegacyBusType"} LegacyBusType__PNP_BUS_INFORMATION(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.Length__FCP_GET_REQUEST"} {:fieldname "Length"} Length__FCP_GET_REQUEST(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Length_unnamed_tag_18"} {:fieldname "Length"} Length_unnamed_tag_18(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "ListEntry"} ListEntry_unnamed_tag_7(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T._SLIST_HEADER"} {:fieldname "ListHead"} ListHead__GENERAL_LOOKASIDE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.LowPart__LUID"} {:fieldname "LowPart"} LowPart__LUID(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.MajorFunction__DRIVER_OBJECT"} {:fieldname "MajorFunction"} MajorFunction__DRIVER_OBJECT(x: int) : int
{
  x + 64
}

function {:inline true} {:fieldmap "Mem_T.MajorFunction__IO_STACK_LOCATION"} {:fieldname "MajorFunction"} MajorFunction__IO_STACK_LOCATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.MaximumLength__UNICODE_STRING"} {:fieldname "MaximumLength"} MaximumLength__UNICODE_STRING(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.MinorFunction__IO_STACK_LOCATION"} {:fieldname "MinorFunction"} MinorFunction__IO_STACK_LOCATION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.ModelID__GET_UNIT_IDS"} {:fieldname "ModelID"} ModelID__GET_UNIT_IDS(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.ModelText__GET_UNIT_IDS"} {:fieldname "ModelText"} ModelText__GET_UNIT_IDS(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.NA_Bus_Number__NODE_ADDRESS"} {:fieldname "NA_Bus_Number"} NA_Bus_Number__NODE_ADDRESS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.NA_Node_Number__NODE_ADDRESS"} {:fieldname "NA_Node_Number"} NA_Node_Number__NODE_ADDRESS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.NodeAddress__AVC_COMMAND_CONTEXT"} {:fieldname "NodeAddress"} NodeAddress__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 2720
}

function {:inline true} {:fieldmap "Mem_T.NodeAddress__AVC_COMMAND_IRB"} {:fieldname "NodeAddress"} NodeAddress__AVC_COMMAND_IRB(x: int) : int
{
  x + 2104
}

function {:inline true} {:fieldmap "Mem_T.NodeAddress__FCP_GET_REQUEST"} {:fieldname "NodeAddress"} NodeAddress__FCP_GET_REQUEST(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._BUS_GENERATION_NODE"} {:fieldname "NodeInfo"} NodeInfo__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 268
}

function {:inline true} {:fieldmap "Mem_T.NtStatus__AVC_COMMAND_CONTEXT"} {:fieldname "NtStatus"} NtStatus__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Objects__DEVICE_RELATIONS"} {:fieldname "Objects"} Objects__DEVICE_RELATIONS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Opcode__AVC_COMMAND_CONTEXT"} {:fieldname "Opcode"} Opcode__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 200
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "Opcode"} Opcode__AVC_COMMAND_IRB(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.OperandLength__AVC_COMMAND_CONTEXT"} {:fieldname "OperandLength"} OperandLength__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 208
}

function {:inline true} {:fieldmap "Mem_T.OperandLength__AVC_COMMAND_IRB"} {:fieldname "OperandLength"} OperandLength__AVC_COMMAND_IRB(x: int) : int
{
  x + 64
}

function {:inline true} {:fieldmap "Mem_T.OperandOffset__AVC_COMMAND_CONTEXT"} {:fieldname "OperandOffset"} OperandOffset__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 204
}

function {:inline true} {:fieldmap "Mem_T.Operands__AVC_COMMAND_IRB"} {:fieldname "Operands"} Operands__AVC_COMMAND_IRB(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T.Others_unnamed_tag_8"} {:fieldname "Others"} Others_unnamed_tag_8(x: int) : int
{
  x + 496
}

function {:inline true} {:fieldmap "Mem_T.Overlay_unnamed_tag_6"} {:fieldname "Overlay"} Overlay_unnamed_tag_6(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Page__AVC_SUBUNIT_INFO"} {:fieldname "Page"} Page__AVC_SUBUNIT_INFO(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Parameters__IO_STACK_LOCATION"} {:fieldname "Parameters"} Parameters__IO_STACK_LOCATION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.ParentDeviceObject__BUS_DEVICE_EXTENSION"} {:fieldname "ParentDeviceObject"} ParentDeviceObject__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.ParentDeviceObject__COMMON_DEVICE_EXTENSION"} {:fieldname "ParentDeviceObject"} ParentDeviceObject__COMMON_DEVICE_EXTENSION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.ParentDeviceObject__PDO_DEVICE_EXTENSION"} {:fieldname "ParentDeviceObject"} ParentDeviceObject__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.PdoData__PDO_DEVICE_EXTENSION"} {:fieldname "PdoData"} PdoData__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 228
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "PdoList"} PdoList__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 252
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "PdoList"} PdoList__PDO_DATA(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "PendingIrpList"} PendingIrpList__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.PendingRequestIrp__BUS_DEVICE_EXTENSION"} {:fieldname "PendingRequestIrp"} PendingRequestIrp__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 404
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "PendingRequestList"} PendingRequestList__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 384
}

function {:inline true} {:fieldmap "Mem_T._AVC_FCP_REQUEST"} {:fieldname "PendingRequest"} PendingRequest__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 2916
}

function {:inline true} {:fieldmap "Mem_T.PendingResponseIrp__BUS_DEVICE_EXTENSION"} {:fieldname "PendingResponseIrp"} PendingResponseIrp__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 400
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "PendingResponseList"} PendingResponseList__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 376
}

function {:inline true} {:fieldmap "Mem_T._AVC_FCP_REQUEST"} {:fieldname "PendingResponse"} PendingResponse__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 408
}

function {:inline true} {:fieldmap "Mem_T.PendingReturned__IRP"} {:fieldname "PendingReturned"} PendingReturned__IRP(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.PhysicalDeviceObject__BUS_DEVICE_EXTENSION"} {:fieldname "PhysicalDeviceObject"} PhysicalDeviceObject__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 236
}

function {:inline true} {:fieldmap "Mem_T.Power_unnamed_tag_8"} {:fieldname "Power"} Power_unnamed_tag_8(x: int) : int
{
  x + 420
}

function {:inline true} {:fieldmap "Mem_T.QuadPart__LARGE_INTEGER"} {:fieldname "QuadPart"} QuadPart__LARGE_INTEGER(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.QueryDeviceRelations_unnamed_tag_8"} {:fieldname "QueryDeviceRelations"} QueryDeviceRelations_unnamed_tag_8(x: int) : int
{
  x + 328
}

function {:inline true} {:fieldmap "Mem_T.QueryDeviceText_unnamed_tag_8"} {:fieldname "QueryDeviceText"} QueryDeviceText_unnamed_tag_8(x: int) : int
{
  x + 384
}

function {:inline true} {:fieldmap "Mem_T.QueryId_unnamed_tag_8"} {:fieldname "QueryId"} QueryId_unnamed_tag_8(x: int) : int
{
  x + 380
}

function {:inline true} {:fieldmap "Mem_T.QueryRoutine__RTL_QUERY_REGISTRY_TABLE"} {:fieldname "QueryRoutine"} QueryRoutine__RTL_QUERY_REGISTRY_TABLE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.RawData__AVC_SUBUNIT_INFO"} {:fieldname "RawData"} RawData__AVC_SUBUNIT_INFO(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.Removable__DEVICE_CAPABILITIES"} {:fieldname "Removable"} Removable__DEVICE_CAPABILITIES(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.RemovalPending__BUS_DEVICE_EXTENSION"} {:fieldname "RemovalPending"} RemovalPending__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 196
}

function {:inline true} {:fieldmap "Mem_T.RemovalPending__COMMON_DEVICE_EXTENSION"} {:fieldname "RemovalPending"} RemovalPending__COMMON_DEVICE_EXTENSION(x: int) : int
{
  x + 196
}

function {:inline true} {:fieldmap "Mem_T.RemovalPending__PDO_DEVICE_EXTENSION"} {:fieldname "RemovalPending"} RemovalPending__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 196
}

function {:inline true} {:fieldmap "Mem_T.VOID"} {:fieldname "RemoveEvent"} RemoveEvent__AVC_REMOVE_LOCK(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T._AVC_REMOVE_LOCK"} {:fieldname "RemoveLock"} RemoveLock__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T._AVC_REMOVE_LOCK"} {:fieldname "RemoveLock"} RemoveLock__COMMON_DEVICE_EXTENSION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T._AVC_REMOVE_LOCK"} {:fieldname "RemoveLock"} RemoveLock__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.Removed__AVC_REMOVE_LOCK"} {:fieldname "Removed"} Removed__AVC_REMOVE_LOCK(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Removed__BUS_DEVICE_EXTENSION"} {:fieldname "Removed"} Removed__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 192
}

function {:inline true} {:fieldmap "Mem_T.Removed__PDO_DEVICE_EXTENSION"} {:fieldname "Removed"} Removed__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 192
}

function {:inline true} {:fieldmap "Mem_T.Request__AVC_COMMAND_CONTEXT"} {:fieldname "Request"} Request__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 376
}

function {:inline true} {:fieldmap "Mem_T.ResetLock__BUS_DEVICE_EXTENSION"} {:fieldname "ResetLock"} ResetLock__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 208
}

function {:inline true} {:fieldmap "Mem_T.ResetLock__PDO_DEVICE_EXTENSION"} {:fieldname "ResetLock"} ResetLock__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 208
}

function {:inline true} {:fieldmap "Mem_T.ResponseCode__AVC_COMMAND_CONTEXT"} {:fieldname "ResponseCode"} ResponseCode__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 64
}

function {:inline true} {:fieldmap "Mem_T.ResponseCode__AVC_COMMAND_IRB"} {:fieldname "ResponseCode"} ResponseCode__AVC_COMMAND_IRB(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.Response__AVC_FCP_REQUEST"} {:fieldname "Response"} Response__AVC_FCP_REQUEST(x: int) : int
{
  x + 180
}

function {:inline true} {:fieldmap "Mem_T.Retries__AVC_COMMAND_CONTEXT"} {:fieldname "Retries"} Retries__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.SendResponse__AVC_FCP_REQUEST"} {:fieldname "SendResponse"} SendResponse__AVC_FCP_REQUEST(x: int) : int
{
  x + 244
}

function {:inline true} {:fieldmap "Mem_T.SetFcpNotify__AV_61883_REQUEST"} {:fieldname "SetFcpNotify"} SetFcpNotify__AV_61883_REQUEST(x: int) : int
{
  x + 260
}

function {:inline true} {:fieldmap "Mem_T.SetUnitDirectory__AV_61883_REQUEST"} {:fieldname "SetUnitDirectory"} SetUnitDirectory__AV_61883_REQUEST(x: int) : int
{
  x + 432
}

function {:inline true} {:fieldmap "Mem_T.SignalState__DISPATCHER_HEADER"} {:fieldname "SignalState"} SignalState__DISPATCHER_HEADER(x: int) : int
{
  x + 144
}

function {:inline true} {:fieldmap "Mem_T.Signalling__DISPATCHER_HEADER"} {:fieldname "Signalling"} Signalling__DISPATCHER_HEADER(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.SilentInstall__DEVICE_CAPABILITIES"} {:fieldname "SilentInstall"} SilentInstall__DEVICE_CAPABILITIES(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.Size__DEVICE_CAPABILITIES"} {:fieldname "Size"} Size__DEVICE_CAPABILITIES(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Size__DISPATCHER_HEADER"} {:fieldname "Size"} Size__DISPATCHER_HEADER(x: int) : int
{
  x + 100
}

function {:inline true} {:fieldmap "Mem_T.StackSize__DEVICE_OBJECT"} {:fieldname "StackSize"} StackSize__DEVICE_OBJECT(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.Started__PDO_DATA"} {:fieldname "Started"} Started__PDO_DATA(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.State_unnamed_tag_39"} {:fieldname "State"} State_unnamed_tag_39(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.Status__IO_STATUS_BLOCK"} {:fieldname "Status"} Status__IO_STATUS_BLOCK(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.SubunitAddr__AVC_COMMAND_CONTEXT"} {:fieldname "SubunitAddr"} SubunitAddr__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T.SubunitAddr__PDO_DATA"} {:fieldname "SubunitAddr"} SubunitAddr__PDO_DATA(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.SurpriseRemovalOK__DEVICE_CAPABILITIES"} {:fieldname "SurpriseRemovalOK"} SurpriseRemovalOK__DEVICE_CAPABILITIES(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"} {:fieldname "SymbolicLinkName"} SymbolicLinkName__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 240
}

function {:inline true} {:fieldmap "Mem_T.SystemState__BUS_DEVICE_EXTENSION"} {:fieldname "SystemState"} SystemState__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 204
}

function {:inline true} {:fieldmap "Mem_T.SystemState__PDO_DEVICE_EXTENSION"} {:fieldname "SystemState"} SystemState__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 204
}

function {:inline true} {:fieldmap "Mem_T.SystemState__POWER_STATE"} {:fieldname "SystemState"} SystemState__POWER_STATE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.SystemWake__DEVICE_CAPABILITIES"} {:fieldname "SystemWake"} SystemWake__DEVICE_CAPABILITIES(x: int) : int
{
  x + 128
}

function {:inline true} {:fieldmap "Mem_T.Tag__BUS_DEVICE_EXTENSION"} {:fieldname "Tag"} Tag__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Tag__COMMON_DEVICE_EXTENSION"} {:fieldname "Tag"} Tag__COMMON_DEVICE_EXTENSION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Tag__PDO_DEVICE_EXTENSION"} {:fieldname "Tag"} Tag__PDO_DEVICE_EXTENSION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Tail__IRP"} {:fieldname "Tail"} Tail__IRP(x: int) : int
{
  x + 128
}

function {:inline true} {:fieldmap "Mem_T._LARGE_INTEGER"} {:fieldname "Timeout"} Timeout__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.TotalFrees__GENERAL_LOOKASIDE"} {:fieldname "TotalFrees"} TotalFrees__GENERAL_LOOKASIDE(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.TriggerBusReset__BUS_DEVICE_EXTENSION"} {:fieldname "TriggerBusReset"} TriggerBusReset__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 368
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_28"} {:fieldname "Type"} Type_unnamed_tag_28(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_39"} {:fieldname "Type"} Type_unnamed_tag_39(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.UniqueID__DEVICE_CAPABILITIES"} {:fieldname "UniqueID"} UniqueID__DEVICE_CAPABILITIES(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T._LARGE_INTEGER"} {:fieldname "UniqueID"} UniqueID__GET_UNIT_IDS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"} {:fieldname "UniqueId"} UniqueId__PDO_DATA(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "UnitAddr"} UnitAddr__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 372
}

function {:inline true} {:fieldmap "Mem_T._GET_UNIT_CAPABILITIES"} {:fieldname "UnitCaps"} UnitCaps__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 288
}

function {:inline true} {:fieldmap "Mem_T._GET_UNIT_IDS"} {:fieldname "UnitIDs"} UnitIDs__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 308
}

function {:inline true} {:fieldmap "Mem_T.UnitInfoRetrieved__BUS_DEVICE_EXTENSION"} {:fieldname "UnitInfoRetrieved"} UnitInfoRetrieved__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 364
}

function {:inline true} {:fieldmap "Mem_T.UnitModelID__GET_UNIT_IDS"} {:fieldname "UnitModelID"} UnitModelID__GET_UNIT_IDS(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.UnitModelText__GET_UNIT_IDS"} {:fieldname "UnitModelText"} UnitModelText__GET_UNIT_IDS(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.UnitSpecId__SET_UNIT_DIRECTORY"} {:fieldname "UnitSpecId"} UnitSpecId__SET_UNIT_DIRECTORY(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.UnitSwVersion__SET_UNIT_DIRECTORY"} {:fieldname "UnitSwVersion"} UnitSwVersion__SET_UNIT_DIRECTORY(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.VendorID__GET_UNIT_IDS"} {:fieldname "VendorID"} VendorID__GET_UNIT_IDS(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.VendorText__GET_UNIT_IDS"} {:fieldname "VendorText"} VendorText__GET_UNIT_IDS(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Version__AVC_COMMAND_CONTEXT"} {:fieldname "Version"} Version__AVC_COMMAND_CONTEXT(x: int) : int
{
  x + 216
}

function {:inline true} {:fieldmap "Mem_T.Version__AVC_FCP_REQUEST"} {:fieldname "Version"} Version__AVC_FCP_REQUEST(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Version__AV_61883_REQUEST"} {:fieldname "Version"} Version__AV_61883_REQUEST(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Version__DEVICE_CAPABILITIES"} {:fieldname "Version"} Version__DEVICE_CAPABILITIES(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__IRB_REQ_BUS_RESET"} {:fieldname "fulFlags"} fulFlags__IRB_REQ_BUS_RESET(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.hCromEntry__BUS_DEVICE_EXTENSION"} {:fieldname "hCromEntry"} hCromEntry__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 264
}

function {:inline true} {:fieldmap "Mem_T.hCromEntry__SET_UNIT_DIRECTORY"} {:fieldname "hCromEntry"} hCromEntry__SET_UNIT_DIRECTORY(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.CAvcSubunitAddress"} {:fieldname "m_DstAddr"} m_DstAddr_CKsPinDescriptor(x: int) : int
{
  x + 176
}

function {:inline true} {:fieldmap "Mem_T.m_InterfacesCount_CKsPinDescriptor"} {:fieldname "m_InterfacesCount"} m_InterfacesCount_CKsPinDescriptor(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.m_Interfaces_CKsPinDescriptor"} {:fieldname "m_Interfaces"} m_Interfaces_CKsPinDescriptor(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.m_MediumsCount_CKsPinDescriptor"} {:fieldname "m_MediumsCount"} m_MediumsCount_CKsPinDescriptor(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.m_Mediums_CKsPinDescriptor"} {:fieldname "m_Mediums"} m_Mediums_CKsPinDescriptor(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.m_PinDescriptors_CConnectionMgr"} {:fieldname "m_PinDescriptors"} m_PinDescriptors_CConnectionMgr(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.CAvcSubunitAddress"} {:fieldname "m_SrcAddr"} m_SrcAddr_CKsPinDescriptor(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.nLevel__GET_UNIT_INFO"} {:fieldname "nLevel"} nLevel__GET_UNIT_INFO(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.pfnNotify__BUS_RESET_NOTIFY"} {:fieldname "pfnNotify"} pfnNotify__BUS_RESET_NOTIFY(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.u__IRB"} {:fieldname "u"} u__IRB(x: int) : int
{
  x + 72
}

function {:inline true} {:fieldmap "Mem_T.u__LARGE_INTEGER"} {:fieldname "u"} u__LARGE_INTEGER(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.ulModelLength__GET_UNIT_IDS"} {:fieldname "ulModelLength"} ulModelLength__GET_UNIT_IDS(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.ulUnitModelLength__GET_UNIT_IDS"} {:fieldname "ulUnitModelLength"} ulUnitModelLength__GET_UNIT_IDS(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.ulVendorLength__GET_UNIT_IDS"} {:fieldname "ulVendorLength"} ulVendorLength__GET_UNIT_IDS(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.ulWorkAround__BUS_DEVICE_EXTENSION"} {:fieldname "ulWorkAround"} ulWorkAround__BUS_DEVICE_EXTENSION(x: int) : int
{
  x + 260
}

const {:string " "} unique strConst__li2bpl30: int;

const {:string "&"} unique strConst__li2bpl22: int;

const {:string "&DV"} unique strConst__li2bpl26: int;

const {:string "&ID_"} unique strConst__li2bpl25: int;

const {:string "&TYP_"} unique strConst__li2bpl24: int;

const {:string "AV/C Audio"} unique strConst__li2bpl1: int;

const {:string "AV/C Bulletin Board"} unique strConst__li2bpl9: int;

const {:string "AV/C Camera"} unique strConst__li2bpl7: int;

const {:string "AV/C Camera Storage"} unique strConst__li2bpl10: int;

const {:string "AV/C Conditional Access"} unique strConst__li2bpl6: int;

const {:string "AV/C Disc Recorder/Player"} unique strConst__li2bpl3: int;

const {:string "AV/C Monitor"} unique strConst__li2bpl0: int;

const {:string "AV/C Multifunction Device"} unique strConst__li2bpl11: int;

const {:string "AV/C Panel"} unique strConst__li2bpl8: int;

const {:string "AV/C Printer"} unique strConst__li2bpl2: int;

const {:string "AV/C Subunit"} unique strConst__li2bpl12: int;

const {:string "AV/C Tape Recorder/Player"} unique strConst__li2bpl4: int;

const {:string "AV/C Tuner"} unique strConst__li2bpl5: int;

const {:string "AVC\\"} unique strConst__li2bpl18: int;

const {:string "AvcFlags"} unique strConst__li2bpl17: int;

const {:string "CAMCORDER"} unique strConst__li2bpl20: int;

const {:string "GENERIC"} unique strConst__li2bpl27: int;

const {:string "MOD_"} unique strConst__li2bpl23: int;

const {:string "TYP_"} unique strConst__li2bpl28: int;

const {:string "The driver is forwarding an IRP at an IRQL that is illegal for the IRP's major code"} unique strConst__li2bpl15: int;

const {:string "VAVC\\"} unique strConst__li2bpl19: int;

const {:string "VEN_"} unique strConst__li2bpl21: int;

const {:string "Virtual Device List"} unique strConst__li2bpl16: int;

const {:string "X"} unique strConst__li2bpl29: int;

const {:string "caller"} unique strConst__li2bpl13: int;

const {:string "halt"} unique strConst__li2bpl14: int;

const {:allocated} li2bplFunctionConstant1025: int;

axiom li2bplFunctionConstant1025 == 1025;

const {:allocated} li2bplFunctionConstant1027: int;

axiom li2bplFunctionConstant1027 == 1027;

const {:allocated} li2bplFunctionConstant1030: int;

axiom li2bplFunctionConstant1030 == 1030;

const {:allocated} li2bplFunctionConstant374: int;

axiom li2bplFunctionConstant374 == 374;

const {:allocated} li2bplFunctionConstant485: int;

axiom li2bplFunctionConstant485 == 485;

const {:allocated} li2bplFunctionConstant517: int;

axiom li2bplFunctionConstant517 == 517;

const {:allocated} li2bplFunctionConstant519: int;

axiom li2bplFunctionConstant519 == 519;

const {:allocated} li2bplFunctionConstant783: int;

axiom li2bplFunctionConstant783 == 783;

const {:allocated} li2bplFunctionConstant791: int;

axiom li2bplFunctionConstant791 == 791;

const {:allocated} li2bplFunctionConstant797: int;

axiom li2bplFunctionConstant797 == 797;

const {:allocated} li2bplFunctionConstant798: int;

axiom li2bplFunctionConstant798 == 798;

const {:allocated} li2bplFunctionConstant811: int;

axiom li2bplFunctionConstant811 == 811;

const {:allocated} li2bplFunctionConstant813: int;

axiom li2bplFunctionConstant813 == 813;

const {:allocated} li2bplFunctionConstant842: int;

axiom li2bplFunctionConstant842 == 842;

const {:allocated} li2bplFunctionConstant843: int;

axiom li2bplFunctionConstant843 == 843;

const {:allocated} li2bplFunctionConstant847: int;

axiom li2bplFunctionConstant847 == 847;

const {:allocated} li2bplFunctionConstant850: int;

axiom li2bplFunctionConstant850 == 850;

const {:allocated} li2bplFunctionConstant859: int;

axiom li2bplFunctionConstant859 == 859;

const {:allocated} li2bplFunctionConstant937: int;

axiom li2bplFunctionConstant937 == 937;

const {:allocated} li2bplFunctionConstant938: int;

axiom li2bplFunctionConstant938 == 938;

const {:allocated} li2bplFunctionConstant939: int;

axiom li2bplFunctionConstant939 == 939;

const {:allocated} li2bplFunctionConstant940: int;

axiom li2bplFunctionConstant940 == 940;

const {:allocated} li2bplFunctionConstant942: int;

axiom li2bplFunctionConstant942 == 942;

implementation {:origName "AvcRequestCompletion_sdv_static_function_7"} AvcRequestCompletion_sdv_static_function_7#0(actual_DeviceObject_7: int, actual_Irp_9: int, actual_DevExtIn: int) returns (Tmp_133: int)
{
  var {:pointer} PdoData_1: int;
  var {:pointer} Tmp_134: int;
  var {:pointer} SubunitAddr_2: int;
  var {:scalar} CommandType: int;
  var {:dopa} {:scalar} Offset_1: int;
  var {:pointer} TargetExt: int;
  var {:pointer} Tmp_135: int;
  var {:pointer} FdoEntry: int;
  var {:scalar} sdv_60: int;
  var {:pointer} Entry: int;
  var {:scalar} Status_6: int;
  var {:pointer} DevExt_6: int;
  var {:pointer} Tmp_136: int;
  var {:scalar} sdv_61: int;
  var {:scalar} HandlerFound: int;
  var {:scalar} OldIrql_4: int;
  var {:pointer} TargetExt_1: int;
  var {:pointer} NextIrpStack_2: int;
  var {:scalar} GenerationCount: int;
  var {:pointer} Tmp_137: int;
  var {:pointer} sdv_68: int;
  var {:scalar} Tmp_138: int;
  var {:pointer} Command_8: int;
  var {:pointer} Entry_1: int;
  var {:scalar} sdv_69: int;
  var {:scalar} SubunitFound: int;
  var {:pointer} sdv_70: int;
  var {:scalar} Opcode_1: int;
  var {:pointer} DeviceObject_7: int;
  var {:pointer} Irp_9: int;
  var {:pointer} DevExtIn: int;
  var vslice_dummy_var_260: int;
  var vslice_dummy_var_72: int;
  var vslice_dummy_var_73: int;
  var vslice_dummy_var_74: int;
  var vslice_dummy_var_75: int;
  var vslice_dummy_var_76: int;
  var vslice_dummy_var_77: int;

  anon0:
    call {:si_unique_call 1097} Offset_1 := __HAVOC_malloc(4);
    call {:si_unique_call 1098} Command_8 := __HAVOC_malloc(4);
    DeviceObject_7 := actual_DeviceObject_7;
    Irp_9 := actual_Irp_9;
    DevExtIn := actual_DevExtIn;
    call {:si_unique_call 1099} Tmp_134 := __HAVOC_malloc(2048);
    call {:si_unique_call 1100} Tmp_135 := __HAVOC_malloc(2048);
    call {:si_unique_call 1101} Tmp_136 := __HAVOC_malloc(2048);
    DevExt_6 := DevExtIn;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc GenerationCount;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    goto L17;

  L17:
    call {:si_unique_call 1102} Tmp_137 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    Mem_T.INT4[Tmp_137] := OldIrql_4;
    call {:si_unique_call 1103} sdv_KeAcquireSpinLock(0, Tmp_137);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    OldIrql_4 := Mem_T.INT4[Tmp_137];
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    goto L21;

  L21:
    call {:si_unique_call 1104} IoFreeIrp(0);
    call {:si_unique_call 1105} sdv_KeReleaseSpinLock(0, OldIrql_4);
    call {:si_unique_call 1106} AvcStopAllFCPProcessing(DevExt_6);
    goto L12;

  L12:
    Tmp_133 := -1073741802;
    goto LM2;

  LM2:
    return;

  anon60_Then:
    goto L21;

  anon59_Then:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    call {:si_unique_call 1107} sdv_60 := AvcAcquireRemoveLock(RemoveLock__BUS_DEVICE_EXTENSION(DevExt_6));
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} sdv_60 >= 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc Tmp_136;
    SubunitAddr_2 := Tmp_136 + 1 * 4;
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    Mem_T.INT4[Offset_1] := 0;
    call {:si_unique_call 1108} Status_6 := AvcValidateSubunitAddress(SubunitAddr_2, 32, Offset_1);
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} Status_6 == 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc Tmp_135;
    assume {:nonnull} Tmp_135 != 0;
    assume Tmp_135 > 0;
    CommandType := BAND(Mem_T.INT4[Tmp_135], BOR(BOR(BOR(1, 2), 4), 8));
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    Mem_T.INT4[Offset_1] := Mem_T.INT4[Offset_1] + 1;
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    Tmp_138 := Mem_T.INT4[Offset_1];
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc Tmp_134;
    assume {:nonnull} Tmp_134 != 0;
    assume Tmp_134 > 0;
    Opcode_1 := Mem_T.INT4[Tmp_134 + Tmp_138 * 4];
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    Mem_T.INT4[Offset_1] := Mem_T.INT4[Offset_1] + 1;
    assume {:nonnull} SubunitAddr_2 != 0;
    assume SubunitAddr_2 > 0;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} Mem_T.INT4[SubunitAddr_2] == 255;
    call {:si_unique_call 1109} HandlerFound := AvcSearchForUnitCommandHandler_sdv_static_function_7(DevExt_6, Opcode_1, Command_8);
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} HandlerFound == 0;
    call {:si_unique_call 1110} Tmp_137 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    Mem_T.INT4[Tmp_137] := OldIrql_4;
    call {:si_unique_call 1111} sdv_KeAcquireSpinLock(0, Tmp_137);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    OldIrql_4 := Mem_T.INT4[Tmp_137];
    havoc Entry;
    goto L183;

  L183:
    call {:si_unique_call 1112} TargetExt, Entry, HandlerFound, sdv_70 := AvcRequestCompletion_sdv_static_function_7#0_loop_L183(TargetExt, Entry, DevExt_6, HandlerFound, Command_8, sdv_70, Opcode_1);
    goto L183_last;

  L183_last:
    goto anon77_Then, anon77_Else;

  anon77_Else:
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} HandlerFound == 0;
    call {:si_unique_call 1113} sdv_70 := sdv_containing_record(Entry, 72);
    TargetExt := sdv_70;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} TargetExt != DevExt_6;
    call {:si_unique_call 1114} HandlerFound := AvcSearchForUnitCommandHandler_sdv_static_function_7(TargetExt, Opcode_1, Command_8);
    goto L194;

  L194:
    assume {:nonnull} Entry != 0;
    assume Entry > 0;
    havoc Entry;
    goto L194_dummy;

  L194_dummy:
    assume false;
    return;

  anon87_Then:
    assume {:partition} TargetExt == DevExt_6;
    goto L194;

  anon78_Then:
    assume {:partition} HandlerFound != 0;
    goto L184;

  L184:
    call {:si_unique_call 1115} sdv_KeReleaseSpinLock(0, OldIrql_4);
    goto L175;

  L175:
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    call {:si_unique_call 1116} AvcHandleUnitCommand_sdv_static_function_7#0(DeviceObject_7, DevExt_6);
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} yogi_error != 1;
    goto L150;

  L150:
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc vslice_dummy_var_72;
    call {:si_unique_call 1117} sdv_RtlCopyMemory(0, 0, vslice_dummy_var_72);
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    havoc vslice_dummy_var_73;
    call {:si_unique_call 1118} AvcPendingIrpCompletion(vslice_dummy_var_73);
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    havoc vslice_dummy_var_74;
    call {:si_unique_call 1119} AvcFreeCommandContext(vslice_dummy_var_74);
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto L46;

  L46:
    call {:si_unique_call 1120} Tmp_137 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    Mem_T.INT4[Tmp_137] := OldIrql_4;
    call {:si_unique_call 1121} sdv_KeAcquireSpinLock(0, Tmp_137);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    OldIrql_4 := Mem_T.INT4[Tmp_137];
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    call {:si_unique_call 1122} IoFreeIrp(0);
    Irp_9 := 0;
    goto L57;

  L57:
    call {:si_unique_call 1123} sdv_KeReleaseSpinLock(0, OldIrql_4);
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} Irp_9 != 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    call {:si_unique_call 1124} NextIrpStack_2 := sdv_IoGetNextIrpStackLocation(Irp_9);
    assume {:nonnull} NextIrpStack_2 != 0;
    assume NextIrpStack_2 > 0;
    assume {:nonnull} NextIrpStack_2 != 0;
    assume NextIrpStack_2 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} NextIrpStack_2 != 0;
    assume NextIrpStack_2 > 0;
    call {:si_unique_call 1125} sdv_IoSetCompletionRoutine(Irp_9, li2bplFunctionConstant847, DevExt_6, 1, 1, 1);
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume Irp_9 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 1126} SLIC_sdv_IoCallDriver_entry(strConst__li2bpl13, Irp_9);
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} yogi_error != 1;
    goto L227;

  L227:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume false;
    return;

  anon81_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon65_Then:
    assume !(Irp_9 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L227;

  anon64_Then:
    assume {:partition} Irp_9 == 0;
    goto L61;

  L61:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    call {:si_unique_call 1127} AvcReleaseRemoveLock(RemoveLock__BUS_DEVICE_EXTENSION(DevExt_6));
    goto L12;

  anon63_Then:
    call {:si_unique_call 1128} IoReuseIrp(Irp_9, -1073741637);
    goto L57;

  anon74_Then:
    goto L46;

  anon86_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon76_Then:
    goto L150;

  anon77_Then:
    goto L184;

  anon75_Then:
    assume {:partition} HandlerFound != 0;
    goto L175;

  anon83_Then:
    assume {:partition} Mem_T.INT4[SubunitAddr_2] != 255;
    SubunitFound := 0;
    call {:si_unique_call 1129} Tmp_137 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    Mem_T.INT4[Tmp_137] := OldIrql_4;
    call {:si_unique_call 1130} sdv_KeAcquireSpinLock(0, Tmp_137);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    OldIrql_4 := Mem_T.INT4[Tmp_137];
    havoc FdoEntry;
    goto L97;

  L97:
    call {:si_unique_call 1131} PdoData_1, FdoEntry, sdv_61, TargetExt_1, sdv_68, Entry_1, sdv_69, SubunitFound, vslice_dummy_var_260 := AvcRequestCompletion_sdv_static_function_7#0_loop_L97(PdoData_1, SubunitAddr_2, FdoEntry, sdv_61, TargetExt_1, sdv_68, Command_8, Entry_1, sdv_69, SubunitFound, vslice_dummy_var_260);
    goto L97_last;

  L97_last:
    goto anon66_Then, anon66_Else;

  anon66_Else:
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} SubunitFound == 0;
    call {:si_unique_call 1132} sdv_68 := sdv_containing_record(FdoEntry, 72);
    TargetExt_1 := sdv_68;
    PdoData_1 := 0;
    call {:si_unique_call 1133} sdv_KeAcquireSpinLockAtDpcLevel(0);
    assume {:nonnull} TargetExt_1 != 0;
    assume TargetExt_1 > 0;
    havoc Entry_1;
    goto L114;

  L114:
    call {:si_unique_call 1134} PdoData_1, sdv_61, Entry_1 := AvcRequestCompletion_sdv_static_function_7#0_loop_L114(PdoData_1, SubunitAddr_2, sdv_61, Entry_1);
    goto L114_last;

  L114_last:
    goto anon68_Then, anon68_Else;

  anon68_Else:
    PdoData_1 := Entry_1;
    assume {:nonnull} PdoData_1 != 0;
    assume PdoData_1 > 0;
    havoc vslice_dummy_var_75;
    call {:si_unique_call 1135} sdv_61 := AvcSubunitAddrsEqual(SubunitAddr_2, vslice_dummy_var_75);
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} sdv_61 == 0;
    PdoData_1 := 0;
    assume {:nonnull} Entry_1 != 0;
    assume Entry_1 > 0;
    havoc Entry_1;
    goto anon70_Else_dummy;

  anon70_Else_dummy:
    assume false;
    return;

  anon70_Then:
    assume {:partition} sdv_61 != 0;
    goto L115;

  L115:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} PdoData_1 != 0;
    SubunitFound := 1;
    assume {:nonnull} TargetExt_1 != 0;
    assume TargetExt_1 > 0;
    havoc Entry_1;
    goto L129;

  L129:
    call {:si_unique_call 1136} Entry_1, sdv_69 := AvcRequestCompletion_sdv_static_function_7#0_loop_L129(SubunitAddr_2, Command_8, Entry_1, sdv_69);
    goto L129_last;

  L129_last:
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    goto L135;

  L135:
    assume {:nonnull} Entry_1 != 0;
    assume Entry_1 > 0;
    havoc Entry_1;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto L135_dummy;

  L135_dummy:
    assume false;
    return;

  anon85_Then:
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    havoc vslice_dummy_var_76;
    call {:si_unique_call 1137} sdv_69 := AvcSubunitAddrsEqual(SubunitAddr_2, vslice_dummy_var_76);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} sdv_69 != 0;
    call {:si_unique_call 1138} vslice_dummy_var_260 := sdv_RemoveEntryList(0);
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    havoc vslice_dummy_var_77;
    call {:si_unique_call 1139} InitializeListHead(vslice_dummy_var_77);
    goto L124;

  L124:
    call {:si_unique_call 1140} sdv_KeReleaseSpinLockFromDpcLevel(0);
    assume {:nonnull} FdoEntry != 0;
    assume FdoEntry > 0;
    havoc FdoEntry;
    goto L124_dummy;

  L124_dummy:
    assume false;
    return;

  anon72_Then:
    assume {:partition} sdv_69 == 0;
    goto L135;

  anon71_Then:
    goto L124;

  anon69_Then:
    assume {:partition} PdoData_1 == 0;
    goto L124;

  anon68_Then:
    goto L115;

  anon67_Then:
    assume {:partition} SubunitFound != 0;
    goto L98;

  L98:
    call {:si_unique_call 1141} sdv_KeReleaseSpinLock(0, OldIrql_4);
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} SubunitFound != 0;
    goto L150;

  anon73_Then:
    assume {:partition} SubunitFound == 0;
    call {:si_unique_call 1142} AvcLocalResponse_sdv_static_function_7#0(DeviceObject_7, DevExt_6, 8);
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:partition} yogi_error != 1;
    goto L150;

  anon84_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon66_Then:
    goto L98;

  anon62_Then:
    assume {:partition} Status_6 != 0;
    call {:si_unique_call 1143} AvcLocalResponse_sdv_static_function_7#0(DeviceObject_7, DevExt_6, 8);
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} yogi_error != 1;
    goto L46;

  anon80_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon61_Then:
    assume {:partition} 0 > sdv_60;
    goto L17;

  anon79_Then:
    call {:si_unique_call 1144} IoFreeIrp(0);
    goto L12;
}



procedure {:origName "AvcRequestCompletion_sdv_static_function_7"} AvcRequestCompletion_sdv_static_function_7#0(actual_DeviceObject_7: int, actual_Irp_9: int, actual_DevExtIn: int) returns (Tmp_133: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures old(sdv_irql_current) == 0 ==> yogi_error == 0;
  free ensures old(sdv_irql_current) == 1 ==> yogi_error == 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_3) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4) || sdv_irql_previous_4 == old(sdv_irql_previous_3);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcRequestCompletion_sdv_static_function_7"} AvcRequestCompletion_sdv_static_function_7#1(actual_DeviceObject_7: int, actual_Irp_9: int, actual_DevExtIn: int) returns (Tmp_133: int)
{
  var {:pointer} PdoData_1: int;
  var {:pointer} Tmp_134: int;
  var {:pointer} SubunitAddr_2: int;
  var {:scalar} CommandType: int;
  var {:dopa} {:scalar} Offset_1: int;
  var {:pointer} TargetExt: int;
  var {:pointer} Tmp_135: int;
  var {:pointer} FdoEntry: int;
  var {:scalar} sdv_60: int;
  var {:pointer} Entry: int;
  var {:scalar} Status_6: int;
  var {:pointer} DevExt_6: int;
  var {:pointer} Tmp_136: int;
  var {:scalar} sdv_61: int;
  var {:scalar} HandlerFound: int;
  var {:scalar} OldIrql_4: int;
  var {:pointer} TargetExt_1: int;
  var {:pointer} NextIrpStack_2: int;
  var {:scalar} GenerationCount: int;
  var {:pointer} Tmp_137: int;
  var {:pointer} sdv_68: int;
  var {:scalar} Tmp_138: int;
  var {:pointer} Command_8: int;
  var {:pointer} Entry_1: int;
  var {:scalar} sdv_69: int;
  var {:scalar} SubunitFound: int;
  var {:pointer} sdv_70: int;
  var {:scalar} Opcode_1: int;
  var {:pointer} DeviceObject_7: int;
  var {:pointer} Irp_9: int;
  var {:pointer} DevExtIn: int;
  var vslice_dummy_var_261: int;
  var vslice_dummy_var_262: int;
  var vslice_dummy_var_78: int;
  var vslice_dummy_var_79: int;
  var vslice_dummy_var_80: int;
  var vslice_dummy_var_81: int;
  var vslice_dummy_var_82: int;
  var vslice_dummy_var_83: int;
  var vslice_dummy_var_84: int;

  anon0:
    call {:si_unique_call 1145} Offset_1 := __HAVOC_malloc(4);
    call {:si_unique_call 1146} Command_8 := __HAVOC_malloc(4);
    DeviceObject_7 := actual_DeviceObject_7;
    Irp_9 := actual_Irp_9;
    DevExtIn := actual_DevExtIn;
    call {:si_unique_call 1147} Tmp_134 := __HAVOC_malloc(2048);
    call {:si_unique_call 1148} Tmp_135 := __HAVOC_malloc(2048);
    call {:si_unique_call 1149} Tmp_136 := __HAVOC_malloc(2048);
    DevExt_6 := DevExtIn;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc GenerationCount;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    goto L17;

  L17:
    call {:si_unique_call 1150} Tmp_137 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    Mem_T.INT4[Tmp_137] := OldIrql_4;
    call {:si_unique_call 1151} sdv_KeAcquireSpinLock(0, Tmp_137);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    OldIrql_4 := Mem_T.INT4[Tmp_137];
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    goto L21;

  L21:
    call {:si_unique_call 1152} IoFreeIrp(0);
    call {:si_unique_call 1153} sdv_KeReleaseSpinLock(0, OldIrql_4);
    call {:si_unique_call 1154} AvcStopAllFCPProcessing(DevExt_6);
    goto L12;

  L12:
    Tmp_133 := -1073741802;
    goto LM2;

  LM2:
    return;

  anon60_Then:
    goto L21;

  anon59_Then:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    call {:si_unique_call 1155} sdv_60 := AvcAcquireRemoveLock(RemoveLock__BUS_DEVICE_EXTENSION(DevExt_6));
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} sdv_60 >= 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc Tmp_136;
    SubunitAddr_2 := Tmp_136 + 1 * 4;
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    Mem_T.INT4[Offset_1] := 0;
    call {:si_unique_call 1156} Status_6 := AvcValidateSubunitAddress(SubunitAddr_2, 32, Offset_1);
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} Status_6 == 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc Tmp_135;
    assume {:nonnull} Tmp_135 != 0;
    assume Tmp_135 > 0;
    CommandType := BAND(Mem_T.INT4[Tmp_135], BOR(BOR(BOR(1, 2), 4), 8));
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    Mem_T.INT4[Offset_1] := Mem_T.INT4[Offset_1] + 1;
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    Tmp_138 := Mem_T.INT4[Offset_1];
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc Tmp_134;
    assume {:nonnull} Tmp_134 != 0;
    assume Tmp_134 > 0;
    Opcode_1 := Mem_T.INT4[Tmp_134 + Tmp_138 * 4];
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    Mem_T.INT4[Offset_1] := Mem_T.INT4[Offset_1] + 1;
    assume {:nonnull} SubunitAddr_2 != 0;
    assume SubunitAddr_2 > 0;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} Mem_T.INT4[SubunitAddr_2] == 255;
    call {:si_unique_call 1157} HandlerFound := AvcSearchForUnitCommandHandler_sdv_static_function_7(DevExt_6, Opcode_1, Command_8);
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} HandlerFound == 0;
    call {:si_unique_call 1158} Tmp_137 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    Mem_T.INT4[Tmp_137] := OldIrql_4;
    call {:si_unique_call 1159} sdv_KeAcquireSpinLock(0, Tmp_137);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    OldIrql_4 := Mem_T.INT4[Tmp_137];
    havoc Entry;
    goto L183;

  L183:
    call {:si_unique_call 1160} TargetExt, Entry, HandlerFound, sdv_70 := AvcRequestCompletion_sdv_static_function_7#1_loop_L183(TargetExt, Entry, DevExt_6, HandlerFound, Command_8, sdv_70, Opcode_1);
    goto L183_last;

  L183_last:
    goto anon77_Then, anon77_Else;

  anon77_Else:
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} HandlerFound == 0;
    call {:si_unique_call 1161} sdv_70 := sdv_containing_record(Entry, 72);
    TargetExt := sdv_70;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} TargetExt != DevExt_6;
    call {:si_unique_call 1162} HandlerFound := AvcSearchForUnitCommandHandler_sdv_static_function_7(TargetExt, Opcode_1, Command_8);
    goto L194;

  L194:
    assume {:nonnull} Entry != 0;
    assume Entry > 0;
    havoc Entry;
    goto L194_dummy;

  L194_dummy:
    assume false;
    return;

  anon87_Then:
    assume {:partition} TargetExt == DevExt_6;
    goto L194;

  anon78_Then:
    assume {:partition} HandlerFound != 0;
    goto L184;

  L184:
    call {:si_unique_call 1163} sdv_KeReleaseSpinLock(0, OldIrql_4);
    goto L175;

  L175:
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    call {:si_unique_call 1164} AvcHandleUnitCommand_sdv_static_function_7#1(DeviceObject_7, DevExt_6);
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} yogi_error != 1;
    goto L150;

  L150:
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc vslice_dummy_var_78;
    call {:si_unique_call 1165} sdv_RtlCopyMemory(0, 0, vslice_dummy_var_78);
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} Offset_1 != 0;
    assume Offset_1 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    havoc vslice_dummy_var_79;
    call {:si_unique_call 1166} AvcPendingIrpCompletion(vslice_dummy_var_79);
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    havoc vslice_dummy_var_80;
    call {:si_unique_call 1167} AvcFreeCommandContext(vslice_dummy_var_80);
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto L46;

  L46:
    call {:si_unique_call 1168} Tmp_137 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    Mem_T.INT4[Tmp_137] := OldIrql_4;
    call {:si_unique_call 1169} sdv_KeAcquireSpinLock(0, Tmp_137);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    OldIrql_4 := Mem_T.INT4[Tmp_137];
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    call {:si_unique_call 1170} IoFreeIrp(0);
    Irp_9 := 0;
    goto L57;

  L57:
    call {:si_unique_call 1171} sdv_KeReleaseSpinLock(0, OldIrql_4);
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} Irp_9 != 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    call {:si_unique_call 1172} NextIrpStack_2 := sdv_IoGetNextIrpStackLocation(Irp_9);
    assume {:nonnull} NextIrpStack_2 != 0;
    assume NextIrpStack_2 > 0;
    assume {:nonnull} NextIrpStack_2 != 0;
    assume NextIrpStack_2 > 0;
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    assume {:nonnull} NextIrpStack_2 != 0;
    assume NextIrpStack_2 > 0;
    call {:si_unique_call 1173} sdv_IoSetCompletionRoutine(Irp_9, li2bplFunctionConstant847, DevExt_6, 1, 1, 1);
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume Irp_9 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 1174} SLIC_sdv_IoCallDriver_entry(strConst__li2bpl13, Irp_9);
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} yogi_error != 1;
    goto L227;

  L227:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    havoc vslice_dummy_var_81;
    call {:si_unique_call 1175} vslice_dummy_var_262 := sdv_IoCallDriver#0(vslice_dummy_var_81, Irp_9);
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:partition} yogi_error != 1;
    goto L61;

  L61:
    assume {:nonnull} DevExt_6 != 0;
    assume DevExt_6 > 0;
    call {:si_unique_call 1176} AvcReleaseRemoveLock(RemoveLock__BUS_DEVICE_EXTENSION(DevExt_6));
    goto L12;

  anon82_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon81_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon65_Then:
    assume !(Irp_9 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L227;

  anon64_Then:
    assume {:partition} Irp_9 == 0;
    goto L61;

  anon63_Then:
    call {:si_unique_call 1177} IoReuseIrp(Irp_9, -1073741637);
    goto L57;

  anon74_Then:
    goto L46;

  anon86_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon76_Then:
    goto L150;

  anon77_Then:
    goto L184;

  anon75_Then:
    assume {:partition} HandlerFound != 0;
    goto L175;

  anon83_Then:
    assume {:partition} Mem_T.INT4[SubunitAddr_2] != 255;
    SubunitFound := 0;
    call {:si_unique_call 1178} Tmp_137 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    Mem_T.INT4[Tmp_137] := OldIrql_4;
    call {:si_unique_call 1179} sdv_KeAcquireSpinLock(0, Tmp_137);
    assume {:nonnull} Tmp_137 != 0;
    assume Tmp_137 > 0;
    OldIrql_4 := Mem_T.INT4[Tmp_137];
    havoc FdoEntry;
    goto L97;

  L97:
    call {:si_unique_call 1180} PdoData_1, FdoEntry, sdv_61, TargetExt_1, sdv_68, Entry_1, sdv_69, SubunitFound, vslice_dummy_var_261 := AvcRequestCompletion_sdv_static_function_7#1_loop_L97(PdoData_1, SubunitAddr_2, FdoEntry, sdv_61, TargetExt_1, sdv_68, Command_8, Entry_1, sdv_69, SubunitFound, vslice_dummy_var_261);
    goto L97_last;

  L97_last:
    goto anon66_Then, anon66_Else;

  anon66_Else:
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} SubunitFound == 0;
    call {:si_unique_call 1181} sdv_68 := sdv_containing_record(FdoEntry, 72);
    TargetExt_1 := sdv_68;
    PdoData_1 := 0;
    call {:si_unique_call 1182} sdv_KeAcquireSpinLockAtDpcLevel(0);
    assume {:nonnull} TargetExt_1 != 0;
    assume TargetExt_1 > 0;
    havoc Entry_1;
    goto L114;

  L114:
    call {:si_unique_call 1183} PdoData_1, sdv_61, Entry_1 := AvcRequestCompletion_sdv_static_function_7#1_loop_L114(PdoData_1, SubunitAddr_2, sdv_61, Entry_1);
    goto L114_last;

  L114_last:
    goto anon68_Then, anon68_Else;

  anon68_Else:
    PdoData_1 := Entry_1;
    assume {:nonnull} PdoData_1 != 0;
    assume PdoData_1 > 0;
    havoc vslice_dummy_var_82;
    call {:si_unique_call 1184} sdv_61 := AvcSubunitAddrsEqual(SubunitAddr_2, vslice_dummy_var_82);
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} sdv_61 == 0;
    PdoData_1 := 0;
    assume {:nonnull} Entry_1 != 0;
    assume Entry_1 > 0;
    havoc Entry_1;
    goto anon70_Else_dummy;

  anon70_Else_dummy:
    assume false;
    return;

  anon70_Then:
    assume {:partition} sdv_61 != 0;
    goto L115;

  L115:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} PdoData_1 != 0;
    SubunitFound := 1;
    assume {:nonnull} TargetExt_1 != 0;
    assume TargetExt_1 > 0;
    havoc Entry_1;
    goto L129;

  L129:
    call {:si_unique_call 1185} Entry_1, sdv_69 := AvcRequestCompletion_sdv_static_function_7#1_loop_L129(SubunitAddr_2, Command_8, Entry_1, sdv_69);
    goto L129_last;

  L129_last:
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    goto L135;

  L135:
    assume {:nonnull} Entry_1 != 0;
    assume Entry_1 > 0;
    havoc Entry_1;
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    goto L135_dummy;

  L135_dummy:
    assume false;
    return;

  anon85_Then:
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    havoc vslice_dummy_var_83;
    call {:si_unique_call 1186} sdv_69 := AvcSubunitAddrsEqual(SubunitAddr_2, vslice_dummy_var_83);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} sdv_69 != 0;
    call {:si_unique_call 1187} vslice_dummy_var_261 := sdv_RemoveEntryList(0);
    assume {:nonnull} Command_8 != 0;
    assume Command_8 > 0;
    havoc vslice_dummy_var_84;
    call {:si_unique_call 1188} InitializeListHead(vslice_dummy_var_84);
    goto L124;

  L124:
    call {:si_unique_call 1189} sdv_KeReleaseSpinLockFromDpcLevel(0);
    assume {:nonnull} FdoEntry != 0;
    assume FdoEntry > 0;
    havoc FdoEntry;
    goto L124_dummy;

  L124_dummy:
    assume false;
    return;

  anon72_Then:
    assume {:partition} sdv_69 == 0;
    goto L135;

  anon71_Then:
    goto L124;

  anon69_Then:
    assume {:partition} PdoData_1 == 0;
    goto L124;

  anon68_Then:
    goto L115;

  anon67_Then:
    assume {:partition} SubunitFound != 0;
    goto L98;

  L98:
    call {:si_unique_call 1190} sdv_KeReleaseSpinLock(0, OldIrql_4);
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} SubunitFound != 0;
    goto L150;

  anon73_Then:
    assume {:partition} SubunitFound == 0;
    call {:si_unique_call 1191} AvcLocalResponse_sdv_static_function_7#1(DeviceObject_7, DevExt_6, 8);
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:partition} yogi_error != 1;
    goto L150;

  anon84_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon66_Then:
    goto L98;

  anon62_Then:
    assume {:partition} Status_6 != 0;
    call {:si_unique_call 1192} AvcLocalResponse_sdv_static_function_7#1(DeviceObject_7, DevExt_6, 8);
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} yogi_error != 1;
    goto L46;

  anon80_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon61_Then:
    assume {:partition} 0 > sdv_60;
    goto L17;

  anon79_Then:
    call {:si_unique_call 1193} IoFreeIrp(0);
    goto L12;
}



procedure {:origName "AvcRequestCompletion_sdv_static_function_7"} AvcRequestCompletion_sdv_static_function_7#1(actual_DeviceObject_7: int, actual_Irp_9: int, actual_DevExtIn: int) returns (Tmp_133: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_3) || sdv_irql_previous_5 == old(sdv_irql_previous_2) || sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3) || sdv_irql_previous_4 == old(sdv_irql_previous_2) || sdv_irql_previous_4 == old(sdv_irql_previous_4) || sdv_irql_previous_4 == old(sdv_irql_previous);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2) || sdv_irql_previous_3 == old(sdv_irql_previous_3) || sdv_irql_previous_3 == old(sdv_irql_previous);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcLocalResponse_sdv_static_function_7"} AvcLocalResponse_sdv_static_function_7#0(actual_DeviceObject_8: int, actual_DevExt_11: int, actual_ResponseCode: int)
{
  var {:pointer} Tmp_160: int;
  var {:pointer} Tmp_161: int;
  var {:pointer} Irp_11: int;
  var {:scalar} Tmp_162: int;
  var {:pointer} Tmp_163: int;
  var {:pointer} sdv_98: int;
  var {:pointer} NextIrpStack_4: int;
  var {:pointer} Response_2: int;
  var {:pointer} DevExt_11: int;
  var {:scalar} ResponseCode: int;
  var vslice_dummy_var_263: int;
  var vslice_dummy_var_85: int;

  anon0:
    call {:si_unique_call 1194} vslice_dummy_var_263 := __HAVOC_malloc(4);
    DevExt_11 := actual_DevExt_11;
    ResponseCode := actual_ResponseCode;
    call {:si_unique_call 1195} Tmp_160 := __HAVOC_malloc(2048);
    call {:si_unique_call 1196} Tmp_161 := __HAVOC_malloc(2048);
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    havoc Tmp_163;
    assume {:nonnull} Tmp_163 != 0;
    assume Tmp_163 > 0;
    havoc vslice_dummy_var_85;
    call {:si_unique_call 1197} Irp_11 := IoAllocateIrp(vslice_dummy_var_85, 0);
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} Irp_11 != 0;
    call {:si_unique_call 1198} sdv_98 := sdv_ExAllocateFromNPagedLookasideList(0);
    Response_2 := sdv_98;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} Response_2 != 0;
    call {:si_unique_call 1199} sdv_RtlCopyMemory(0, 0, 512);
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    havoc Tmp_160;
    assume {:nonnull} Tmp_160 != 0;
    assume Tmp_160 > 0;
    Tmp_162 := BAND(Mem_T.INT4[Tmp_160], BNOT(BOR(BOR(BOR(1, 2), 4), 8)));
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    havoc Tmp_161;
    assume {:nonnull} Tmp_161 != 0;
    assume Tmp_161 > 0;
    Mem_T.INT4[Tmp_161] := BOR(Tmp_162, ResponseCode);
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} Irp_11 != 0;
    assume Irp_11 > 0;
    call {:si_unique_call 1200} NextIrpStack_4 := sdv_IoGetNextIrpStackLocation(Irp_11);
    assume {:nonnull} NextIrpStack_4 != 0;
    assume NextIrpStack_4 > 0;
    assume {:nonnull} NextIrpStack_4 != 0;
    assume NextIrpStack_4 > 0;
    assume {:nonnull} NextIrpStack_4 != 0;
    assume NextIrpStack_4 > 0;
    call {:si_unique_call 1201} sdv_IoSetCompletionRoutine(Irp_11, li2bplFunctionConstant843, Response_2, 1, 1, 1);
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    assume false;
    return;

  anon8_Then:
    assume {:partition} Response_2 == 0;
    call {:si_unique_call 1202} IoFreeIrp(0);
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon7_Then:
    assume {:partition} Irp_11 == 0;
    goto L1;
}



procedure {:origName "AvcLocalResponse_sdv_static_function_7"} AvcLocalResponse_sdv_static_function_7#0(actual_DeviceObject_8: int, actual_DevExt_11: int, actual_ResponseCode: int);
  modifies alloc, Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcLocalResponse_sdv_static_function_7"} AvcLocalResponse_sdv_static_function_7#1(actual_DeviceObject_8: int, actual_DevExt_11: int, actual_ResponseCode: int)
{
  var {:pointer} Tmp_160: int;
  var {:pointer} Tmp_161: int;
  var {:pointer} Irp_11: int;
  var {:scalar} Tmp_162: int;
  var {:pointer} Tmp_163: int;
  var {:pointer} sdv_98: int;
  var {:pointer} NextIrpStack_4: int;
  var {:pointer} Response_2: int;
  var {:pointer} DevExt_11: int;
  var {:scalar} ResponseCode: int;
  var vslice_dummy_var_264: int;
  var vslice_dummy_var_265: int;
  var vslice_dummy_var_86: int;
  var vslice_dummy_var_87: int;

  anon0:
    call {:si_unique_call 1203} vslice_dummy_var_264 := __HAVOC_malloc(4);
    DevExt_11 := actual_DevExt_11;
    ResponseCode := actual_ResponseCode;
    call {:si_unique_call 1204} Tmp_160 := __HAVOC_malloc(2048);
    call {:si_unique_call 1205} Tmp_161 := __HAVOC_malloc(2048);
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    havoc Tmp_163;
    assume {:nonnull} Tmp_163 != 0;
    assume Tmp_163 > 0;
    havoc vslice_dummy_var_86;
    call {:si_unique_call 1206} Irp_11 := IoAllocateIrp(vslice_dummy_var_86, 0);
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} Irp_11 != 0;
    call {:si_unique_call 1207} sdv_98 := sdv_ExAllocateFromNPagedLookasideList(0);
    Response_2 := sdv_98;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} Response_2 != 0;
    call {:si_unique_call 1208} sdv_RtlCopyMemory(0, 0, 512);
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    havoc Tmp_160;
    assume {:nonnull} Tmp_160 != 0;
    assume Tmp_160 > 0;
    Tmp_162 := BAND(Mem_T.INT4[Tmp_160], BNOT(BOR(BOR(BOR(1, 2), 4), 8)));
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    havoc Tmp_161;
    assume {:nonnull} Tmp_161 != 0;
    assume Tmp_161 > 0;
    Mem_T.INT4[Tmp_161] := BOR(Tmp_162, ResponseCode);
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} Response_2 != 0;
    assume Response_2 > 0;
    assume {:nonnull} Irp_11 != 0;
    assume Irp_11 > 0;
    call {:si_unique_call 1209} NextIrpStack_4 := sdv_IoGetNextIrpStackLocation(Irp_11);
    assume {:nonnull} NextIrpStack_4 != 0;
    assume NextIrpStack_4 > 0;
    assume {:nonnull} NextIrpStack_4 != 0;
    assume NextIrpStack_4 > 0;
    assume {:nonnull} NextIrpStack_4 != 0;
    assume NextIrpStack_4 > 0;
    call {:si_unique_call 1210} sdv_IoSetCompletionRoutine(Irp_11, li2bplFunctionConstant843, Response_2, 1, 1, 1);
    assume {:nonnull} DevExt_11 != 0;
    assume DevExt_11 > 0;
    havoc vslice_dummy_var_87;
    call {:si_unique_call 1211} vslice_dummy_var_265 := sdv_IoCallDriver#0(vslice_dummy_var_87, Irp_11);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} yogi_error != 1;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon9_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon8_Then:
    assume {:partition} Response_2 == 0;
    call {:si_unique_call 1212} IoFreeIrp(0);
    goto L1;

  anon7_Then:
    assume {:partition} Irp_11 == 0;
    goto L1;
}



procedure {:origName "AvcLocalResponse_sdv_static_function_7"} AvcLocalResponse_sdv_static_function_7#1(actual_DeviceObject_8: int, actual_DevExt_11: int, actual_ResponseCode: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_3) || sdv_irql_previous_5 == old(sdv_irql_previous_2) || sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous) || sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_current) || sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3) || sdv_irql_previous_4 == old(sdv_irql_previous_2) || sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2) || sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoCallDriver"} {:osmodel} sdv_IoCallDriver#0(actual_DeviceObject_17: int, actual_Irp_19: int) returns (Tmp_367: int)
{
  var {:pointer} Irp_19: int;

  anon0:
    Irp_19 := actual_Irp_19;
    call {:si_unique_call 1213} Tmp_367 := IofCallDriver#0(0, Irp_19);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} yogi_error != 1;
    goto LM2;

  LM2:
    return;

  anon3_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "sdv_IoCallDriver"} {:osmodel} sdv_IoCallDriver#0(actual_DeviceObject_17: int, actual_Irp_19: int) returns (Tmp_367: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_3) || sdv_irql_previous_5 == old(sdv_irql_previous_2) || sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous) || sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_current) || sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3) || sdv_irql_previous_4 == old(sdv_irql_previous_2) || sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2) || sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_IoCallDriver"} {:osmodel} sdv_IoCallDriver#1(actual_DeviceObject_17: int, actual_Irp_19: int) returns (Tmp_367: int)
{
  var {:pointer} Irp_19: int;

  anon0:
    Irp_19 := actual_Irp_19;
    call {:si_unique_call 1214} Tmp_367 := IofCallDriver#1(0, Irp_19);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} yogi_error != 1;
    goto LM2;

  LM2:
    return;

  anon3_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "sdv_IoCallDriver"} {:osmodel} sdv_IoCallDriver#1(actual_DeviceObject_17: int, actual_Irp_19: int) returns (Tmp_367: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IofCallDriver"} {:osmodel} IofCallDriver#0(actual_DeviceObject_15: int, actual_Irp_17: int) returns (Tmp_355: int)
{
  var {:dopa} {:scalar} completion: int;
  var {:scalar} status_4: int;
  var {:pointer} Irp_17: int;
  var vslice_dummy_var_266: int;
  var vslice_dummy_var_267: int;
  var vslice_dummy_var_268: int;
  var vslice_dummy_var_269: int;
  var vslice_dummy_var_88: int;
  var vslice_dummy_var_89: int;
  var vslice_dummy_var_90: int;
  var vslice_dummy_var_91: int;

  anon0:
    call {:si_unique_call 1215} completion := __HAVOC_malloc(4);
    Irp_17 := actual_Irp_17;
    assume {:nonnull} completion != 0;
    assume completion > 0;
    Mem_T.INT4[completion] := 0;
    status_4 := 259;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    goto L19;

  L19:
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L21;

  L21:
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L23;

  L23:
    goto anon55_Then, anon55_Else;

  anon55_Else:
    goto L29;

  L29:
    Tmp_355 := status_4;
    goto LM2;

  LM2:
    return;

  anon55_Then:
    havoc vslice_dummy_var_88;
    call {:si_unique_call 1216} vslice_dummy_var_266 := sdv_RunIoCompletionRoutines#0(sdv_p_devobj_fdo, Irp_17, vslice_dummy_var_88, completion);
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon76_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon54_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_17;
    goto L23;

  anon53_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_17;
    goto L21;

  anon75_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_17;
    goto L19;

  anon68_Then:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    goto L58;

  L58:
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L60;

  L60:
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L62;

  L62:
    goto anon66_Then, anon66_Else;

  anon66_Else:
    goto anon67_Then, anon67_Else;

  anon67_Else:
    havoc vslice_dummy_var_89;
    call {:si_unique_call 1217} vslice_dummy_var_269 := sdv_RunIoCompletionRoutines#0(sdv_p_devobj_fdo, Irp_17, vslice_dummy_var_89, completion);
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon78_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon67_Then:
    goto L29;

  anon66_Then:
    goto L29;

  anon65_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_17;
    goto L62;

  anon64_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_17;
    goto L60;

  anon77_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_17;
    goto L58;

  anon69_Then:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    goto L32;

  L32:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L34;

  L34:
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L36;

  L36:
    goto anon58_Then, anon58_Else;

  anon58_Else:
    goto anon59_Then, anon59_Else;

  anon59_Else:
    havoc vslice_dummy_var_90;
    call {:si_unique_call 1218} vslice_dummy_var_267 := sdv_RunIoCompletionRoutines#0(sdv_p_devobj_fdo, Irp_17, vslice_dummy_var_90, completion);
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon74_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon59_Then:
    goto L29;

  anon58_Then:
    goto L29;

  anon57_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_17;
    goto L36;

  anon56_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_17;
    goto L34;

  anon73_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_17;
    goto L32;

  anon70_Then:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    goto L45;

  L45:
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L47;

  L47:
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L49;

  L49:
    goto anon62_Then, anon62_Else;

  anon62_Else:
    goto anon63_Then, anon63_Else;

  anon63_Else:
    havoc vslice_dummy_var_91;
    call {:si_unique_call 1219} vslice_dummy_var_268 := sdv_RunIoCompletionRoutines#0(sdv_p_devobj_fdo, Irp_17, vslice_dummy_var_91, completion);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon72_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon63_Then:
    goto L29;

  anon62_Then:
    goto L29;

  anon61_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_17;
    goto L49;

  anon60_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_17;
    goto L47;

  anon71_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_17;
    goto L45;
}



procedure {:origName "IofCallDriver"} {:osmodel} IofCallDriver#0(actual_DeviceObject_15: int, actual_Irp_17: int) returns (Tmp_355: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_3) || sdv_irql_previous_5 == old(sdv_irql_previous_2) || sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous) || sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_current) || sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3) || sdv_irql_previous_4 == old(sdv_irql_previous_2) || sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2) || sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "IofCallDriver"} {:osmodel} IofCallDriver#1(actual_DeviceObject_15: int, actual_Irp_17: int) returns (Tmp_355: int)
{
  var {:dopa} {:scalar} completion: int;
  var {:scalar} status_4: int;
  var {:pointer} Irp_17: int;
  var vslice_dummy_var_270: int;
  var vslice_dummy_var_271: int;
  var vslice_dummy_var_272: int;
  var vslice_dummy_var_273: int;
  var vslice_dummy_var_92: int;
  var vslice_dummy_var_93: int;
  var vslice_dummy_var_94: int;
  var vslice_dummy_var_95: int;

  anon0:
    call {:si_unique_call 1220} completion := __HAVOC_malloc(4);
    Irp_17 := actual_Irp_17;
    assume {:nonnull} completion != 0;
    assume completion > 0;
    Mem_T.INT4[completion] := 0;
    status_4 := 259;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    goto L19;

  L19:
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L21;

  L21:
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L23;

  L23:
    goto anon55_Then, anon55_Else;

  anon55_Else:
    goto L29;

  L29:
    Tmp_355 := status_4;
    goto LM2;

  LM2:
    return;

  anon55_Then:
    havoc vslice_dummy_var_92;
    call {:si_unique_call 1221} vslice_dummy_var_270 := sdv_RunIoCompletionRoutines#1(sdv_p_devobj_fdo, Irp_17, vslice_dummy_var_92, completion);
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon76_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon54_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_17;
    goto L23;

  anon53_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_17;
    goto L21;

  anon75_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_17;
    goto L19;

  anon68_Then:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    goto L58;

  L58:
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L60;

  L60:
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L62;

  L62:
    goto anon66_Then, anon66_Else;

  anon66_Else:
    goto anon67_Then, anon67_Else;

  anon67_Else:
    havoc vslice_dummy_var_93;
    call {:si_unique_call 1222} vslice_dummy_var_273 := sdv_RunIoCompletionRoutines#1(sdv_p_devobj_fdo, Irp_17, vslice_dummy_var_93, completion);
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon78_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon67_Then:
    goto L29;

  anon66_Then:
    goto L29;

  anon65_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_17;
    goto L62;

  anon64_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_17;
    goto L60;

  anon77_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_17;
    goto L58;

  anon69_Then:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    goto L32;

  L32:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L34;

  L34:
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L36;

  L36:
    goto anon58_Then, anon58_Else;

  anon58_Else:
    goto anon59_Then, anon59_Else;

  anon59_Else:
    havoc vslice_dummy_var_94;
    call {:si_unique_call 1223} vslice_dummy_var_271 := sdv_RunIoCompletionRoutines#1(sdv_p_devobj_fdo, Irp_17, vslice_dummy_var_94, completion);
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon74_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon59_Then:
    goto L29;

  anon58_Then:
    goto L29;

  anon57_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_17;
    goto L36;

  anon56_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_17;
    goto L34;

  anon73_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_17;
    goto L32;

  anon70_Then:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    goto L45;

  L45:
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L47;

  L47:
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_17;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L49;

  L49:
    goto anon62_Then, anon62_Else;

  anon62_Else:
    goto anon63_Then, anon63_Else;

  anon63_Else:
    havoc vslice_dummy_var_95;
    call {:si_unique_call 1224} vslice_dummy_var_272 := sdv_RunIoCompletionRoutines#1(sdv_p_devobj_fdo, Irp_17, vslice_dummy_var_95, completion);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon72_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon63_Then:
    goto L29;

  anon62_Then:
    goto L29;

  anon61_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_17;
    goto L49;

  anon60_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_17;
    goto L47;

  anon71_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_17;
    goto L45;
}



procedure {:origName "IofCallDriver"} {:osmodel} IofCallDriver#1(actual_DeviceObject_15: int, actual_Irp_17: int) returns (Tmp_355: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RunIoCompletionRoutines"} {:osmodel} sdv_RunIoCompletionRoutines#0(actual_DeviceObject_16: int, actual_Irp_18: int, actual_Context_4: int, actual_Completion: int) returns (Tmp_363: int)
{
  var {:scalar} Status_11: int;
  var {:pointer} irpsp: int;
  var {:pointer} DeviceObject_16: int;
  var {:pointer} Irp_18: int;
  var {:pointer} Context_4: int;
  var {:pointer} Completion: int;

  anon0:
    DeviceObject_16 := actual_DeviceObject_16;
    Irp_18 := actual_Irp_18;
    Context_4 := actual_Context_4;
    Completion := actual_Completion;
    call {:si_unique_call 1225} irpsp := sdv_IoGetNextIrpStackLocation(Irp_18);
    Status_11 := 0;
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1226} Status_11 := AvcLocalResponseCompletion_sdv_static_function_7(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L11;

  L11:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1227} Status_11 := AvcProcessSendResponseCR_sdv_static_function_7(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L28;

  L28:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1228} Status_11 := AvcRequestCompletion_sdv_static_function_7#0(DeviceObject_16, Irp_18, Context_4);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L45;

  L45:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1229} Status_11 := AvcResponseCompletion_sdv_static_function_7#0(DeviceObject_16, Irp_18, Context_4);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L62;

  L62:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1230} Status_11 := Avc_FDO_PowerComplete(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L79;

  L79:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1231} Status_11 := Avc_SynchCompletionRoutine(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L96;

  L96:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1232} Status_11 := sdv_hash_664127497(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L113;

  L113:
    Tmp_363 := Status_11;
    goto LM2;

  LM2:
    return;

  anon24_Then:
    goto L113;

  anon23_Then:
    goto L96;

  anon22_Then:
    goto L79;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon21_Then:
    goto L62;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon20_Then:
    goto L45;

  anon19_Then:
    goto L28;

  anon25_Then:
    goto L11;
}



procedure {:origName "sdv_RunIoCompletionRoutines"} {:osmodel} sdv_RunIoCompletionRoutines#0(actual_DeviceObject_16: int, actual_Irp_18: int, actual_Context_4: int, actual_Completion: int) returns (Tmp_363: int);
  modifies sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4, alloc, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_3) || sdv_irql_previous_5 == old(sdv_irql_previous_2) || sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous) || sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_current) || sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3) || sdv_irql_previous_4 == old(sdv_irql_previous_2) || sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2) || sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "sdv_RunIoCompletionRoutines"} {:osmodel} sdv_RunIoCompletionRoutines#1(actual_DeviceObject_16: int, actual_Irp_18: int, actual_Context_4: int, actual_Completion: int) returns (Tmp_363: int)
{
  var {:scalar} Status_11: int;
  var {:pointer} irpsp: int;
  var {:pointer} DeviceObject_16: int;
  var {:pointer} Irp_18: int;
  var {:pointer} Context_4: int;
  var {:pointer} Completion: int;

  anon0:
    DeviceObject_16 := actual_DeviceObject_16;
    Irp_18 := actual_Irp_18;
    Context_4 := actual_Context_4;
    Completion := actual_Completion;
    call {:si_unique_call 1233} irpsp := sdv_IoGetNextIrpStackLocation(Irp_18);
    Status_11 := 0;
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1234} Status_11 := AvcLocalResponseCompletion_sdv_static_function_7(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L11;

  L11:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1235} Status_11 := AvcProcessSendResponseCR_sdv_static_function_7(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L28;

  L28:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1236} Status_11 := AvcRequestCompletion_sdv_static_function_7#1(DeviceObject_16, Irp_18, Context_4);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L45;

  L45:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1237} Status_11 := AvcResponseCompletion_sdv_static_function_7#1(DeviceObject_16, Irp_18, Context_4);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L62;

  L62:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1238} Status_11 := Avc_FDO_PowerComplete(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L79;

  L79:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1239} Status_11 := Avc_SynchCompletionRoutine(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L96;

  L96:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call {:si_unique_call 1240} Status_11 := sdv_hash_664127497(DeviceObject_16, Irp_18, Context_4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    Mem_T.INT4[Completion] := 1;
    goto L113;

  L113:
    Tmp_363 := Status_11;
    goto LM2;

  LM2:
    return;

  anon24_Then:
    goto L113;

  anon23_Then:
    goto L96;

  anon22_Then:
    goto L79;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon21_Then:
    goto L62;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon20_Then:
    goto L45;

  anon19_Then:
    goto L28;

  anon25_Then:
    goto L11;
}



procedure {:origName "sdv_RunIoCompletionRoutines"} {:osmodel} sdv_RunIoCompletionRoutines#1(actual_DeviceObject_16: int, actual_Irp_18: int, actual_Context_4: int, actual_Completion: int) returns (Tmp_363: int);
  modifies sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4, alloc, yogi_error;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcResponseCompletion_sdv_static_function_7"} AvcResponseCompletion_sdv_static_function_7#0(actual_DeviceObject_9: int, actual_Irp_12: int, actual_DevExtIn_1: int) returns (Tmp_166: int)
{
  var {:scalar} Tmp_167: int;
  var {:pointer} Tmp_168: int;
  var {:pointer} SubunitAddr_3: int;
  var {:dopa} {:scalar} Offset_2: int;
  var {:pointer} Tmp_169: int;
  var {:scalar} ResponseCode_1: int;
  var {:scalar} idx_5: int;
  var {:scalar} Tmp_170: int;
  var {:scalar} Status_9: int;
  var {:pointer} DevExt_12: int;
  var {:pointer} Tmp_171: int;
  var {:scalar} Tmp_172: int;
  var {:pointer} Tmp_173: int;
  var {:scalar} idx_6: int;
  var {:pointer} sdv_103: int;
  var {:scalar} OldIrql_8: int;
  var {:pointer} NextIrpStack_5: int;
  var {:pointer} Tmp_174: int;
  var {:scalar} sdv_107: int;
  var {:scalar} max_1: int;
  var {:pointer} Command_12: int;
  var {:pointer} Tmp_175: int;
  var {:pointer} Tmp_176: int;
  var {:scalar} max_2: int;
  var {:pointer} Entry_5: int;
  var {:scalar} OpcodesMatch_1: int;
  var {:pointer} CallbackLink_3: int;
  var {:scalar} idx_7: int;
  var {:scalar} sdv_108: int;
  var {:scalar} max_3: int;
  var {:pointer} Tmp_177: int;
  var {:pointer} Tmp_178: int;
  var {:scalar} Tmp_179: int;
  var {:pointer} Tmp_180: int;
  var {:scalar} Opcode_3: int;
  var {:pointer} Irp_12: int;
  var {:pointer} DevExtIn_1: int;
  var vslice_dummy_var_274: int;
  var vslice_dummy_var_275: int;
  var vslice_dummy_var_96: int;
  var vslice_dummy_var_97: int;

  anon0:
    call {:si_unique_call 1241} Offset_2 := __HAVOC_malloc(4);
    Irp_12 := actual_Irp_12;
    DevExtIn_1 := actual_DevExtIn_1;
    call {:si_unique_call 1242} Tmp_169 := __HAVOC_malloc(2048);
    call {:si_unique_call 1243} Tmp_173 := __HAVOC_malloc(2048);
    call {:si_unique_call 1244} Tmp_176 := __HAVOC_malloc(2048);
    DevExt_12 := DevExtIn_1;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    goto anon164_Then, anon164_Else;

  anon164_Else:
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    goto anon115_Then, anon115_Else;

  anon115_Else:
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    havoc Tmp_169;
    SubunitAddr_3 := Tmp_169 + 1 * 4;
    assume {:nonnull} Offset_2 != 0;
    assume Offset_2 > 0;
    Mem_T.INT4[Offset_2] := 0;
    call {:si_unique_call 1245} Status_9 := AvcValidateSubunitAddress(SubunitAddr_3, 32, Offset_2);
    goto anon117_Then, anon117_Else;

  anon117_Else:
    assume {:partition} Status_9 == 0;
    Command_12 := 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    havoc Tmp_176;
    assume {:nonnull} Tmp_176 != 0;
    assume Tmp_176 > 0;
    ResponseCode_1 := BAND(Mem_T.INT4[Tmp_176], BOR(BOR(BOR(1, 2), 4), 8));
    assume {:nonnull} Offset_2 != 0;
    assume Offset_2 > 0;
    Mem_T.INT4[Offset_2] := Mem_T.INT4[Offset_2] + 1;
    assume {:nonnull} Offset_2 != 0;
    assume Offset_2 > 0;
    Tmp_167 := Mem_T.INT4[Offset_2];
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    havoc Tmp_173;
    assume {:nonnull} Tmp_173 != 0;
    assume Tmp_173 > 0;
    Opcode_3 := Mem_T.INT4[Tmp_173 + Tmp_167 * 4];
    call {:si_unique_call 1246} Tmp_178 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    Mem_T.INT4[Tmp_178] := OldIrql_8;
    call {:si_unique_call 1247} sdv_KeAcquireSpinLock(0, Tmp_178);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    OldIrql_8 := Mem_T.INT4[Tmp_178];
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    havoc Entry_5;
    goto L80;

  L80:
    call {:si_unique_call 1248} Tmp_168, idx_5, Tmp_170, Tmp_171, Tmp_172, idx_6, Tmp_174, sdv_107, max_1, Command_12, Tmp_175, max_2, Entry_5, OpcodesMatch_1, idx_7, max_3, Tmp_177, Tmp_179, Tmp_180 := AvcResponseCompletion_sdv_static_function_7#0_loop_L80(Tmp_168, SubunitAddr_3, ResponseCode_1, idx_5, Tmp_170, Tmp_171, Tmp_172, idx_6, Tmp_174, sdv_107, max_1, Command_12, Tmp_175, max_2, Entry_5, OpcodesMatch_1, idx_7, max_3, Tmp_177, Tmp_179, Tmp_180, Opcode_3);
    goto L80_last;

  L80_last:
    goto anon121_Then, anon121_Else;

  anon121_Else:
    Command_12 := Entry_5;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon167_Then, anon167_Else;

  anon167_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc vslice_dummy_var_96;
    call {:si_unique_call 1249} sdv_107 := AvcSubunitAddrsEqual(SubunitAddr_3, vslice_dummy_var_96);
    goto anon122_Then, anon122_Else;

  anon122_Else:
    assume {:partition} sdv_107 != 0;
    OpcodesMatch_1 := 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon168_Then, anon168_Else;

  anon168_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon153_Then, anon153_Else;

  anon153_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon152_Then, anon152_Else;

  anon152_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon151_Then, anon151_Else;

  anon151_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon150_Then, anon150_Else;

  anon150_Else:
    goto L97;

  L97:
    goto anon125_Then, anon125_Else;

  anon125_Else:
    assume {:partition} ResponseCode_1 != 8;
    goto anon160_Then, anon160_Else;

  anon160_Else:
    assume {:partition} ResponseCode_1 == 12;
    goto L147;

  L147:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon139_Then, anon139_Else;

  anon139_Else:
    Command_12 := 0;
    goto L119;

  L119:
    goto anon134_Then, anon134_Else;

  anon134_Else:
    assume {:partition} Command_12 != 0;
    call {:si_unique_call 1250} vslice_dummy_var_274 := sdv_RemoveEntryList(0);
    call {:si_unique_call 1251} InitializeListHead(Command_12);
    goto anon135_Then, anon135_Else;

  anon135_Else:
    assume {:partition} 15 == ResponseCode_1;
    call {:si_unique_call 1252} vslice_dummy_var_275 := AvcDuplicateCommandContext_sdv_static_function_7(Command_12);
    goto L81;

  L81:
    call {:si_unique_call 1253} sdv_KeReleaseSpinLock(0, OldIrql_8);
    goto anon148_Then, anon148_Else;

  anon148_Else:
    assume {:partition} Command_12 != 0;
    call {:si_unique_call 1254} sdv_RtlCopyMemory(0, 0, 512);
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    call {:si_unique_call 1255} sdv_108 := sdv_IsListEmpty(0);
    goto anon149_Then, anon149_Else;

  anon149_Else:
    assume {:partition} sdv_108 == 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    call {:si_unique_call 1256} sdv_103 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(Command_12));
    CallbackLink_3 := sdv_103;
    assume {:IndirectCall} true;
    assume {:nonnull} CallbackLink_3 != 0;
    assume CallbackLink_3 > 0;
    assume {:nonnull} CallbackLink_3 != 0;
    assume CallbackLink_3 > 0;
    havoc vslice_dummy_var_97;
    call {:si_unique_call 1257} AvcCommandCallback_sdv_static_function_7(Command_12, vslice_dummy_var_97);
    call {:si_unique_call 1258} ExFreeToNPagedLookasideList(AvcCommandLinkPool, CallbackLink_3);
    goto L37;

  L37:
    call {:si_unique_call 1259} Tmp_178 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    Mem_T.INT4[Tmp_178] := OldIrql_8;
    call {:si_unique_call 1260} sdv_KeAcquireSpinLock(0, Tmp_178);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    OldIrql_8 := Mem_T.INT4[Tmp_178];
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    goto anon118_Then, anon118_Else;

  anon118_Else:
    call {:si_unique_call 1261} IoFreeIrp(0);
    Irp_12 := 0;
    goto L48;

  L48:
    call {:si_unique_call 1262} sdv_KeReleaseSpinLock(0, OldIrql_8);
    goto anon119_Then, anon119_Else;

  anon119_Else:
    assume {:partition} Irp_12 != 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    call {:si_unique_call 1263} NextIrpStack_5 := sdv_IoGetNextIrpStackLocation(Irp_12);
    assume {:nonnull} NextIrpStack_5 != 0;
    assume NextIrpStack_5 > 0;
    assume {:nonnull} NextIrpStack_5 != 0;
    assume NextIrpStack_5 > 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    assume {:nonnull} NextIrpStack_5 != 0;
    assume NextIrpStack_5 > 0;
    call {:si_unique_call 1264} sdv_IoSetCompletionRoutine(Irp_12, li2bplFunctionConstant842, DevExt_12, 1, 1, 1);
    goto anon120_Then, anon120_Else;

  anon120_Else:
    assume Irp_12 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 1265} SLIC_sdv_IoCallDriver_entry(strConst__li2bpl13, Irp_12);
    goto anon165_Then, anon165_Else;

  anon165_Else:
    assume {:partition} yogi_error != 1;
    goto L272;

  L272:
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    assume false;
    return;

  anon165_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  LM2:
    return;

  anon120_Then:
    assume !(Irp_12 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L272;

  anon119_Then:
    assume {:partition} Irp_12 == 0;
    goto L10;

  L10:
    Tmp_166 := -1073741802;
    goto LM2;

  anon118_Then:
    call {:si_unique_call 1266} IoReuseIrp(Irp_12, -1073741637);
    goto L48;

  anon149_Then:
    assume {:partition} sdv_108 != 0;
    call {:si_unique_call 1267} AvcPendingIrpCompletion(Command_12);
    call {:si_unique_call 1268} AvcFreeCommandContext(Command_12);
    Command_12 := 0;
    goto L37;

  anon148_Then:
    assume {:partition} Command_12 == 0;
    goto L37;

  anon135_Then:
    assume {:partition} 15 != ResponseCode_1;
    goto L81;

  anon134_Then:
    assume {:partition} Command_12 == 0;
    goto L86;

  L86:
    assume {:nonnull} Entry_5 != 0;
    assume Entry_5 > 0;
    havoc Entry_5;
    Command_12 := 0;
    goto L86_dummy;

  L86_dummy:
    assume false;
    return;

  anon139_Then:
    goto L119;

  anon160_Then:
    assume {:partition} ResponseCode_1 != 12;
    Command_12 := 0;
    goto L119;

  anon125_Then:
    assume {:partition} ResponseCode_1 == 8;
    goto L147;

  anon150_Then:
    Command_12 := 0;
    goto L119;

  anon151_Then:
    goto anon126_Then, anon126_Else;

  anon126_Else:
    assume {:partition} ResponseCode_1 != 8;
    goto anon163_Then, anon163_Else;

  anon163_Else:
    assume {:partition} ResponseCode_1 != 10;
    goto anon162_Then, anon162_Else;

  anon162_Else:
    assume {:partition} ResponseCode_1 != 13;
    goto anon161_Then, anon161_Else;

  anon161_Else:
    assume {:partition} ResponseCode_1 == 15;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon129_Then, anon129_Else;

  anon129_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon130_Then, anon130_Else;

  anon130_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_180;
    assume {:nonnull} Tmp_180 != 0;
    assume Tmp_180 > 0;
    max_1 := Mem_T.INT4[Tmp_180];
    idx_7 := 1;
    goto L110;

  L110:
    call {:si_unique_call 1269} Tmp_174, idx_7, Tmp_179 := AvcResponseCompletion_sdv_static_function_7#0_loop_L110(Tmp_174, max_1, Command_12, idx_7, Tmp_179, Opcode_3);
    goto L110_last;

  L110_last:
    goto anon132_Then, anon132_Else;

  anon132_Else:
    assume {:partition} max_1 >= idx_7;
    Tmp_179 := idx_7;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_174;
    assume {:nonnull} Tmp_174 != 0;
    assume Tmp_174 > 0;
    goto anon171_Then, anon171_Else;

  anon171_Else:
    assume {:partition} Opcode_3 == Mem_T.INT4[Tmp_174 + Tmp_179 * 4];
    OpcodesMatch_1 := 1;
    goto L111;

  L111:
    goto anon133_Then, anon133_Else;

  anon133_Else:
    assume {:partition} OpcodesMatch_1 != 0;
    goto L119;

  anon133_Then:
    assume {:partition} OpcodesMatch_1 == 0;
    Command_12 := 0;
    goto L119;

  anon171_Then:
    assume {:partition} Opcode_3 != Mem_T.INT4[Tmp_174 + Tmp_179 * 4];
    idx_7 := idx_7 + 1;
    goto anon171_Then_dummy;

  anon171_Then_dummy:
    assume false;
    return;

  anon132_Then:
    assume {:partition} idx_7 > max_1;
    goto L111;

  anon130_Then:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon131_Then, anon131_Else;

  anon131_Else:
    OpcodesMatch_1 := 0;
    goto L355;

  L355:
    goto L111;

  anon131_Then:
    OpcodesMatch_1 := 1;
    goto L355;

  anon129_Then:
    Command_12 := 0;
    goto L119;

  anon161_Then:
    assume {:partition} ResponseCode_1 != 15;
    Command_12 := 0;
    goto L119;

  anon162_Then:
    assume {:partition} ResponseCode_1 == 13;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon128_Then, anon128_Else;

  anon128_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_177;
    assume {:nonnull} Tmp_177 != 0;
    assume Tmp_177 > 0;
    max_2 := Mem_T.INT4[Tmp_177];
    idx_6 := 1;
    goto L136;

  L136:
    call {:si_unique_call 1270} Tmp_168, Tmp_172, idx_6 := AvcResponseCompletion_sdv_static_function_7#0_loop_L136(Tmp_168, Tmp_172, idx_6, Command_12, max_2, Opcode_3);
    goto L136_last;

  L136_last:
    goto anon137_Then, anon137_Else;

  anon137_Else:
    assume {:partition} max_2 >= idx_6;
    Tmp_172 := idx_6;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_168;
    assume {:nonnull} Tmp_168 != 0;
    assume Tmp_168 > 0;
    goto anon170_Then, anon170_Else;

  anon170_Else:
    assume {:partition} Opcode_3 == Mem_T.INT4[Tmp_168 + Tmp_172 * 4];
    OpcodesMatch_1 := 1;
    goto L137;

  L137:
    goto anon138_Then, anon138_Else;

  anon138_Else:
    assume {:partition} OpcodesMatch_1 == 0;
    Command_12 := 0;
    goto L119;

  anon138_Then:
    assume {:partition} OpcodesMatch_1 != 0;
    goto L119;

  anon170_Then:
    assume {:partition} Opcode_3 != Mem_T.INT4[Tmp_168 + Tmp_172 * 4];
    idx_6 := idx_6 + 1;
    goto anon170_Then_dummy;

  anon170_Then_dummy:
    assume false;
    return;

  anon137_Then:
    assume {:partition} idx_6 > max_2;
    goto L137;

  anon128_Then:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon136_Then, anon136_Else;

  anon136_Else:
    OpcodesMatch_1 := 0;
    goto L344;

  L344:
    goto L137;

  anon136_Then:
    OpcodesMatch_1 := 1;
    goto L344;

  anon163_Then:
    assume {:partition} ResponseCode_1 == 10;
    goto L100;

  L100:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon127_Then, anon127_Else;

  anon127_Else:
    Command_12 := 0;
    goto L119;

  anon127_Then:
    goto L119;

  anon126_Then:
    assume {:partition} ResponseCode_1 == 8;
    goto L100;

  anon152_Then:
    goto L97;

  anon153_Then:
    goto anon124_Then, anon124_Else;

  anon124_Else:
    assume {:partition} ResponseCode_1 != 8;
    goto anon159_Then, anon159_Else;

  anon159_Else:
    assume {:partition} ResponseCode_1 != 10;
    goto anon158_Then, anon158_Else;

  anon158_Else:
    assume {:partition} ResponseCode_1 != 11;
    goto anon157_Then, anon157_Else;

  anon157_Else:
    assume {:partition} ResponseCode_1 == 12;
    goto L153;

  L153:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon141_Then, anon141_Else;

  anon141_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_175;
    assume {:nonnull} Tmp_175 != 0;
    assume Tmp_175 > 0;
    max_3 := Mem_T.INT4[Tmp_175];
    idx_5 := 1;
    goto L159;

  L159:
    call {:si_unique_call 1271} idx_5, Tmp_170, Tmp_171 := AvcResponseCompletion_sdv_static_function_7#0_loop_L159(idx_5, Tmp_170, Tmp_171, Command_12, max_3, Opcode_3);
    goto L159_last;

  L159_last:
    goto anon143_Then, anon143_Else;

  anon143_Else:
    assume {:partition} max_3 >= idx_5;
    Tmp_170 := idx_5;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_171;
    assume {:nonnull} Tmp_171 != 0;
    assume Tmp_171 > 0;
    goto anon169_Then, anon169_Else;

  anon169_Else:
    assume {:partition} Opcode_3 == Mem_T.INT4[Tmp_171 + Tmp_170 * 4];
    OpcodesMatch_1 := 1;
    goto L160;

  L160:
    goto anon144_Then, anon144_Else;

  anon144_Else:
    assume {:partition} OpcodesMatch_1 == 0;
    Command_12 := 0;
    goto L119;

  anon144_Then:
    assume {:partition} OpcodesMatch_1 != 0;
    goto L119;

  anon169_Then:
    assume {:partition} Opcode_3 != Mem_T.INT4[Tmp_171 + Tmp_170 * 4];
    idx_5 := idx_5 + 1;
    goto anon169_Then_dummy;

  anon169_Then_dummy:
    assume false;
    return;

  anon143_Then:
    assume {:partition} idx_5 > max_3;
    goto L160;

  anon141_Then:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon142_Then, anon142_Else;

  anon142_Else:
    OpcodesMatch_1 := 0;
    goto L329;

  L329:
    goto L160;

  anon142_Then:
    OpcodesMatch_1 := 1;
    goto L329;

  anon157_Then:
    assume {:partition} ResponseCode_1 != 12;
    Command_12 := 0;
    goto L119;

  anon158_Then:
    assume {:partition} ResponseCode_1 == 11;
    goto L153;

  anon159_Then:
    assume {:partition} ResponseCode_1 == 10;
    goto L152;

  L152:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon140_Then, anon140_Else;

  anon140_Else:
    Command_12 := 0;
    goto L119;

  anon140_Then:
    goto L119;

  anon124_Then:
    assume {:partition} ResponseCode_1 == 8;
    goto L152;

  anon168_Then:
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume {:partition} ResponseCode_1 != 8;
    goto anon156_Then, anon156_Else;

  anon156_Else:
    assume {:partition} ResponseCode_1 != 9;
    goto anon155_Then, anon155_Else;

  anon155_Else:
    assume {:partition} ResponseCode_1 != 10;
    goto anon154_Then, anon154_Else;

  anon154_Else:
    assume {:partition} ResponseCode_1 == 15;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon146_Then, anon146_Else;

  anon146_Else:
    goto L174;

  L174:
    Command_12 := 0;
    goto L119;

  anon146_Then:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon147_Then, anon147_Else;

  anon147_Else:
    goto L174;

  anon147_Then:
    goto L119;

  anon154_Then:
    assume {:partition} ResponseCode_1 != 15;
    Command_12 := 0;
    goto L119;

  anon155_Then:
    assume {:partition} ResponseCode_1 == 10;
    goto L171;

  L171:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon145_Then, anon145_Else;

  anon145_Else:
    Command_12 := 0;
    goto L119;

  anon145_Then:
    goto L119;

  anon156_Then:
    assume {:partition} ResponseCode_1 == 9;
    goto L171;

  anon123_Then:
    assume {:partition} ResponseCode_1 == 8;
    goto L171;

  anon122_Then:
    assume {:partition} sdv_107 == 0;
    goto L86;

  anon167_Then:
    goto L86;

  anon121_Then:
    goto L81;

  anon117_Then:
    assume {:partition} Status_9 != 0;
    goto L37;

  anon115_Then:
    call {:si_unique_call 1272} Tmp_178 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    Mem_T.INT4[Tmp_178] := OldIrql_8;
    call {:si_unique_call 1273} sdv_KeAcquireSpinLock(0, Tmp_178);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    OldIrql_8 := Mem_T.INT4[Tmp_178];
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    goto L17;

  L17:
    call {:si_unique_call 1274} IoFreeIrp(0);
    call {:si_unique_call 1275} sdv_KeReleaseSpinLock(0, OldIrql_8);
    call {:si_unique_call 1276} AvcStopAllFCPProcessing(DevExt_12);
    goto L10;

  anon116_Then:
    goto L17;

  anon164_Then:
    call {:si_unique_call 1277} IoFreeIrp(0);
    goto L10;
}



procedure {:origName "AvcResponseCompletion_sdv_static_function_7"} AvcResponseCompletion_sdv_static_function_7#0(actual_DeviceObject_9: int, actual_Irp_12: int, actual_DevExtIn_1: int) returns (Tmp_166: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures old(sdv_irql_current) == 0 ==> yogi_error == 0;
  free ensures old(sdv_irql_current) == 1 ==> yogi_error == 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcResponseCompletion_sdv_static_function_7"} AvcResponseCompletion_sdv_static_function_7#1(actual_DeviceObject_9: int, actual_Irp_12: int, actual_DevExtIn_1: int) returns (Tmp_166: int)
{
  var {:scalar} Tmp_167: int;
  var {:pointer} Tmp_168: int;
  var {:pointer} SubunitAddr_3: int;
  var {:dopa} {:scalar} Offset_2: int;
  var {:pointer} Tmp_169: int;
  var {:scalar} ResponseCode_1: int;
  var {:scalar} idx_5: int;
  var {:scalar} Tmp_170: int;
  var {:scalar} Status_9: int;
  var {:pointer} DevExt_12: int;
  var {:pointer} Tmp_171: int;
  var {:scalar} Tmp_172: int;
  var {:pointer} Tmp_173: int;
  var {:scalar} idx_6: int;
  var {:pointer} sdv_103: int;
  var {:scalar} OldIrql_8: int;
  var {:pointer} NextIrpStack_5: int;
  var {:pointer} Tmp_174: int;
  var {:scalar} sdv_107: int;
  var {:scalar} max_1: int;
  var {:pointer} Command_12: int;
  var {:pointer} Tmp_175: int;
  var {:pointer} Tmp_176: int;
  var {:scalar} max_2: int;
  var {:pointer} Entry_5: int;
  var {:scalar} OpcodesMatch_1: int;
  var {:pointer} CallbackLink_3: int;
  var {:scalar} idx_7: int;
  var {:scalar} sdv_108: int;
  var {:scalar} max_3: int;
  var {:pointer} Tmp_177: int;
  var {:pointer} Tmp_178: int;
  var {:scalar} Tmp_179: int;
  var {:pointer} Tmp_180: int;
  var {:scalar} Opcode_3: int;
  var {:pointer} Irp_12: int;
  var {:pointer} DevExtIn_1: int;
  var vslice_dummy_var_276: int;
  var vslice_dummy_var_277: int;
  var vslice_dummy_var_278: int;
  var vslice_dummy_var_98: int;
  var vslice_dummy_var_99: int;
  var vslice_dummy_var_100: int;

  anon0:
    call {:si_unique_call 1278} Offset_2 := __HAVOC_malloc(4);
    Irp_12 := actual_Irp_12;
    DevExtIn_1 := actual_DevExtIn_1;
    call {:si_unique_call 1279} Tmp_169 := __HAVOC_malloc(2048);
    call {:si_unique_call 1280} Tmp_173 := __HAVOC_malloc(2048);
    call {:si_unique_call 1281} Tmp_176 := __HAVOC_malloc(2048);
    DevExt_12 := DevExtIn_1;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    goto anon164_Then, anon164_Else;

  anon164_Else:
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    goto anon115_Then, anon115_Else;

  anon115_Else:
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    havoc Tmp_169;
    SubunitAddr_3 := Tmp_169 + 1 * 4;
    assume {:nonnull} Offset_2 != 0;
    assume Offset_2 > 0;
    Mem_T.INT4[Offset_2] := 0;
    call {:si_unique_call 1282} Status_9 := AvcValidateSubunitAddress(SubunitAddr_3, 32, Offset_2);
    goto anon117_Then, anon117_Else;

  anon117_Else:
    assume {:partition} Status_9 == 0;
    Command_12 := 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    havoc Tmp_176;
    assume {:nonnull} Tmp_176 != 0;
    assume Tmp_176 > 0;
    ResponseCode_1 := BAND(Mem_T.INT4[Tmp_176], BOR(BOR(BOR(1, 2), 4), 8));
    assume {:nonnull} Offset_2 != 0;
    assume Offset_2 > 0;
    Mem_T.INT4[Offset_2] := Mem_T.INT4[Offset_2] + 1;
    assume {:nonnull} Offset_2 != 0;
    assume Offset_2 > 0;
    Tmp_167 := Mem_T.INT4[Offset_2];
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    havoc Tmp_173;
    assume {:nonnull} Tmp_173 != 0;
    assume Tmp_173 > 0;
    Opcode_3 := Mem_T.INT4[Tmp_173 + Tmp_167 * 4];
    call {:si_unique_call 1283} Tmp_178 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    Mem_T.INT4[Tmp_178] := OldIrql_8;
    call {:si_unique_call 1284} sdv_KeAcquireSpinLock(0, Tmp_178);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    OldIrql_8 := Mem_T.INT4[Tmp_178];
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    havoc Entry_5;
    goto L80;

  L80:
    call {:si_unique_call 1285} Tmp_168, idx_5, Tmp_170, Tmp_171, Tmp_172, idx_6, Tmp_174, sdv_107, max_1, Command_12, Tmp_175, max_2, Entry_5, OpcodesMatch_1, idx_7, max_3, Tmp_177, Tmp_179, Tmp_180 := AvcResponseCompletion_sdv_static_function_7#1_loop_L80(Tmp_168, SubunitAddr_3, ResponseCode_1, idx_5, Tmp_170, Tmp_171, Tmp_172, idx_6, Tmp_174, sdv_107, max_1, Command_12, Tmp_175, max_2, Entry_5, OpcodesMatch_1, idx_7, max_3, Tmp_177, Tmp_179, Tmp_180, Opcode_3);
    goto L80_last;

  L80_last:
    goto anon121_Then, anon121_Else;

  anon121_Else:
    Command_12 := Entry_5;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon167_Then, anon167_Else;

  anon167_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc vslice_dummy_var_98;
    call {:si_unique_call 1286} sdv_107 := AvcSubunitAddrsEqual(SubunitAddr_3, vslice_dummy_var_98);
    goto anon122_Then, anon122_Else;

  anon122_Else:
    assume {:partition} sdv_107 != 0;
    OpcodesMatch_1 := 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon168_Then, anon168_Else;

  anon168_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon153_Then, anon153_Else;

  anon153_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon152_Then, anon152_Else;

  anon152_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon151_Then, anon151_Else;

  anon151_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon150_Then, anon150_Else;

  anon150_Else:
    goto L97;

  L97:
    goto anon125_Then, anon125_Else;

  anon125_Else:
    assume {:partition} ResponseCode_1 != 8;
    goto anon160_Then, anon160_Else;

  anon160_Else:
    assume {:partition} ResponseCode_1 == 12;
    goto L147;

  L147:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon139_Then, anon139_Else;

  anon139_Else:
    Command_12 := 0;
    goto L119;

  L119:
    goto anon134_Then, anon134_Else;

  anon134_Else:
    assume {:partition} Command_12 != 0;
    call {:si_unique_call 1287} vslice_dummy_var_276 := sdv_RemoveEntryList(0);
    call {:si_unique_call 1288} InitializeListHead(Command_12);
    goto anon135_Then, anon135_Else;

  anon135_Else:
    assume {:partition} 15 == ResponseCode_1;
    call {:si_unique_call 1289} vslice_dummy_var_277 := AvcDuplicateCommandContext_sdv_static_function_7(Command_12);
    goto L81;

  L81:
    call {:si_unique_call 1290} sdv_KeReleaseSpinLock(0, OldIrql_8);
    goto anon148_Then, anon148_Else;

  anon148_Else:
    assume {:partition} Command_12 != 0;
    call {:si_unique_call 1291} sdv_RtlCopyMemory(0, 0, 512);
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    call {:si_unique_call 1292} sdv_108 := sdv_IsListEmpty(0);
    goto anon149_Then, anon149_Else;

  anon149_Else:
    assume {:partition} sdv_108 == 0;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    call {:si_unique_call 1293} sdv_103 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(Command_12));
    CallbackLink_3 := sdv_103;
    assume {:IndirectCall} true;
    assume {:nonnull} CallbackLink_3 != 0;
    assume CallbackLink_3 > 0;
    assume {:nonnull} CallbackLink_3 != 0;
    assume CallbackLink_3 > 0;
    havoc vslice_dummy_var_99;
    call {:si_unique_call 1294} AvcCommandCallback_sdv_static_function_7(Command_12, vslice_dummy_var_99);
    call {:si_unique_call 1295} ExFreeToNPagedLookasideList(AvcCommandLinkPool, CallbackLink_3);
    goto L37;

  L37:
    call {:si_unique_call 1296} Tmp_178 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    Mem_T.INT4[Tmp_178] := OldIrql_8;
    call {:si_unique_call 1297} sdv_KeAcquireSpinLock(0, Tmp_178);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    OldIrql_8 := Mem_T.INT4[Tmp_178];
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    goto anon118_Then, anon118_Else;

  anon118_Else:
    call {:si_unique_call 1298} IoFreeIrp(0);
    Irp_12 := 0;
    goto L48;

  L48:
    call {:si_unique_call 1299} sdv_KeReleaseSpinLock(0, OldIrql_8);
    goto anon119_Then, anon119_Else;

  anon119_Else:
    assume {:partition} Irp_12 != 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    call {:si_unique_call 1300} NextIrpStack_5 := sdv_IoGetNextIrpStackLocation(Irp_12);
    assume {:nonnull} NextIrpStack_5 != 0;
    assume NextIrpStack_5 > 0;
    assume {:nonnull} NextIrpStack_5 != 0;
    assume NextIrpStack_5 > 0;
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    assume {:nonnull} NextIrpStack_5 != 0;
    assume NextIrpStack_5 > 0;
    call {:si_unique_call 1301} sdv_IoSetCompletionRoutine(Irp_12, li2bplFunctionConstant842, DevExt_12, 1, 1, 1);
    goto anon120_Then, anon120_Else;

  anon120_Else:
    assume Irp_12 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 1302} SLIC_sdv_IoCallDriver_entry(strConst__li2bpl13, Irp_12);
    goto anon165_Then, anon165_Else;

  anon165_Else:
    assume {:partition} yogi_error != 1;
    goto L272;

  L272:
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    havoc vslice_dummy_var_100;
    call {:si_unique_call 1303} vslice_dummy_var_278 := sdv_IoCallDriver#0(vslice_dummy_var_100, Irp_12);
    goto anon166_Then, anon166_Else;

  anon166_Else:
    assume {:partition} yogi_error != 1;
    goto L10;

  L10:
    Tmp_166 := -1073741802;
    goto LM2;

  LM2:
    return;

  anon166_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon165_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon120_Then:
    assume !(Irp_12 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L272;

  anon119_Then:
    assume {:partition} Irp_12 == 0;
    goto L10;

  anon118_Then:
    call {:si_unique_call 1304} IoReuseIrp(Irp_12, -1073741637);
    goto L48;

  anon149_Then:
    assume {:partition} sdv_108 != 0;
    call {:si_unique_call 1305} AvcPendingIrpCompletion(Command_12);
    call {:si_unique_call 1306} AvcFreeCommandContext(Command_12);
    Command_12 := 0;
    goto L37;

  anon148_Then:
    assume {:partition} Command_12 == 0;
    goto L37;

  anon135_Then:
    assume {:partition} 15 != ResponseCode_1;
    goto L81;

  anon134_Then:
    assume {:partition} Command_12 == 0;
    goto L86;

  L86:
    assume {:nonnull} Entry_5 != 0;
    assume Entry_5 > 0;
    havoc Entry_5;
    Command_12 := 0;
    goto L86_dummy;

  L86_dummy:
    assume false;
    return;

  anon139_Then:
    goto L119;

  anon160_Then:
    assume {:partition} ResponseCode_1 != 12;
    Command_12 := 0;
    goto L119;

  anon125_Then:
    assume {:partition} ResponseCode_1 == 8;
    goto L147;

  anon150_Then:
    Command_12 := 0;
    goto L119;

  anon151_Then:
    goto anon126_Then, anon126_Else;

  anon126_Else:
    assume {:partition} ResponseCode_1 != 8;
    goto anon163_Then, anon163_Else;

  anon163_Else:
    assume {:partition} ResponseCode_1 != 10;
    goto anon162_Then, anon162_Else;

  anon162_Else:
    assume {:partition} ResponseCode_1 != 13;
    goto anon161_Then, anon161_Else;

  anon161_Else:
    assume {:partition} ResponseCode_1 == 15;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon129_Then, anon129_Else;

  anon129_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon130_Then, anon130_Else;

  anon130_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_180;
    assume {:nonnull} Tmp_180 != 0;
    assume Tmp_180 > 0;
    max_1 := Mem_T.INT4[Tmp_180];
    idx_7 := 1;
    goto L110;

  L110:
    call {:si_unique_call 1307} Tmp_174, idx_7, Tmp_179 := AvcResponseCompletion_sdv_static_function_7#1_loop_L110(Tmp_174, max_1, Command_12, idx_7, Tmp_179, Opcode_3);
    goto L110_last;

  L110_last:
    goto anon132_Then, anon132_Else;

  anon132_Else:
    assume {:partition} max_1 >= idx_7;
    Tmp_179 := idx_7;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_174;
    assume {:nonnull} Tmp_174 != 0;
    assume Tmp_174 > 0;
    goto anon171_Then, anon171_Else;

  anon171_Else:
    assume {:partition} Opcode_3 == Mem_T.INT4[Tmp_174 + Tmp_179 * 4];
    OpcodesMatch_1 := 1;
    goto L111;

  L111:
    goto anon133_Then, anon133_Else;

  anon133_Else:
    assume {:partition} OpcodesMatch_1 != 0;
    goto L119;

  anon133_Then:
    assume {:partition} OpcodesMatch_1 == 0;
    Command_12 := 0;
    goto L119;

  anon171_Then:
    assume {:partition} Opcode_3 != Mem_T.INT4[Tmp_174 + Tmp_179 * 4];
    idx_7 := idx_7 + 1;
    goto anon171_Then_dummy;

  anon171_Then_dummy:
    assume false;
    return;

  anon132_Then:
    assume {:partition} idx_7 > max_1;
    goto L111;

  anon130_Then:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon131_Then, anon131_Else;

  anon131_Else:
    OpcodesMatch_1 := 0;
    goto L355;

  L355:
    goto L111;

  anon131_Then:
    OpcodesMatch_1 := 1;
    goto L355;

  anon129_Then:
    Command_12 := 0;
    goto L119;

  anon161_Then:
    assume {:partition} ResponseCode_1 != 15;
    Command_12 := 0;
    goto L119;

  anon162_Then:
    assume {:partition} ResponseCode_1 == 13;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon128_Then, anon128_Else;

  anon128_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_177;
    assume {:nonnull} Tmp_177 != 0;
    assume Tmp_177 > 0;
    max_2 := Mem_T.INT4[Tmp_177];
    idx_6 := 1;
    goto L136;

  L136:
    call {:si_unique_call 1308} Tmp_168, Tmp_172, idx_6 := AvcResponseCompletion_sdv_static_function_7#1_loop_L136(Tmp_168, Tmp_172, idx_6, Command_12, max_2, Opcode_3);
    goto L136_last;

  L136_last:
    goto anon137_Then, anon137_Else;

  anon137_Else:
    assume {:partition} max_2 >= idx_6;
    Tmp_172 := idx_6;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_168;
    assume {:nonnull} Tmp_168 != 0;
    assume Tmp_168 > 0;
    goto anon170_Then, anon170_Else;

  anon170_Else:
    assume {:partition} Opcode_3 == Mem_T.INT4[Tmp_168 + Tmp_172 * 4];
    OpcodesMatch_1 := 1;
    goto L137;

  L137:
    goto anon138_Then, anon138_Else;

  anon138_Else:
    assume {:partition} OpcodesMatch_1 == 0;
    Command_12 := 0;
    goto L119;

  anon138_Then:
    assume {:partition} OpcodesMatch_1 != 0;
    goto L119;

  anon170_Then:
    assume {:partition} Opcode_3 != Mem_T.INT4[Tmp_168 + Tmp_172 * 4];
    idx_6 := idx_6 + 1;
    goto anon170_Then_dummy;

  anon170_Then_dummy:
    assume false;
    return;

  anon137_Then:
    assume {:partition} idx_6 > max_2;
    goto L137;

  anon128_Then:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon136_Then, anon136_Else;

  anon136_Else:
    OpcodesMatch_1 := 0;
    goto L344;

  L344:
    goto L137;

  anon136_Then:
    OpcodesMatch_1 := 1;
    goto L344;

  anon163_Then:
    assume {:partition} ResponseCode_1 == 10;
    goto L100;

  L100:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon127_Then, anon127_Else;

  anon127_Else:
    Command_12 := 0;
    goto L119;

  anon127_Then:
    goto L119;

  anon126_Then:
    assume {:partition} ResponseCode_1 == 8;
    goto L100;

  anon152_Then:
    goto L97;

  anon153_Then:
    goto anon124_Then, anon124_Else;

  anon124_Else:
    assume {:partition} ResponseCode_1 != 8;
    goto anon159_Then, anon159_Else;

  anon159_Else:
    assume {:partition} ResponseCode_1 != 10;
    goto anon158_Then, anon158_Else;

  anon158_Else:
    assume {:partition} ResponseCode_1 != 11;
    goto anon157_Then, anon157_Else;

  anon157_Else:
    assume {:partition} ResponseCode_1 == 12;
    goto L153;

  L153:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon141_Then, anon141_Else;

  anon141_Else:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_175;
    assume {:nonnull} Tmp_175 != 0;
    assume Tmp_175 > 0;
    max_3 := Mem_T.INT4[Tmp_175];
    idx_5 := 1;
    goto L159;

  L159:
    call {:si_unique_call 1309} idx_5, Tmp_170, Tmp_171 := AvcResponseCompletion_sdv_static_function_7#1_loop_L159(idx_5, Tmp_170, Tmp_171, Command_12, max_3, Opcode_3);
    goto L159_last;

  L159_last:
    goto anon143_Then, anon143_Else;

  anon143_Else:
    assume {:partition} max_3 >= idx_5;
    Tmp_170 := idx_5;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    havoc Tmp_171;
    assume {:nonnull} Tmp_171 != 0;
    assume Tmp_171 > 0;
    goto anon169_Then, anon169_Else;

  anon169_Else:
    assume {:partition} Opcode_3 == Mem_T.INT4[Tmp_171 + Tmp_170 * 4];
    OpcodesMatch_1 := 1;
    goto L160;

  L160:
    goto anon144_Then, anon144_Else;

  anon144_Else:
    assume {:partition} OpcodesMatch_1 == 0;
    Command_12 := 0;
    goto L119;

  anon144_Then:
    assume {:partition} OpcodesMatch_1 != 0;
    goto L119;

  anon169_Then:
    assume {:partition} Opcode_3 != Mem_T.INT4[Tmp_171 + Tmp_170 * 4];
    idx_5 := idx_5 + 1;
    goto anon169_Then_dummy;

  anon169_Then_dummy:
    assume false;
    return;

  anon143_Then:
    assume {:partition} idx_5 > max_3;
    goto L160;

  anon141_Then:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon142_Then, anon142_Else;

  anon142_Else:
    OpcodesMatch_1 := 0;
    goto L329;

  L329:
    goto L160;

  anon142_Then:
    OpcodesMatch_1 := 1;
    goto L329;

  anon157_Then:
    assume {:partition} ResponseCode_1 != 12;
    Command_12 := 0;
    goto L119;

  anon158_Then:
    assume {:partition} ResponseCode_1 == 11;
    goto L153;

  anon159_Then:
    assume {:partition} ResponseCode_1 == 10;
    goto L152;

  L152:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon140_Then, anon140_Else;

  anon140_Else:
    Command_12 := 0;
    goto L119;

  anon140_Then:
    goto L119;

  anon124_Then:
    assume {:partition} ResponseCode_1 == 8;
    goto L152;

  anon168_Then:
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume {:partition} ResponseCode_1 != 8;
    goto anon156_Then, anon156_Else;

  anon156_Else:
    assume {:partition} ResponseCode_1 != 9;
    goto anon155_Then, anon155_Else;

  anon155_Else:
    assume {:partition} ResponseCode_1 != 10;
    goto anon154_Then, anon154_Else;

  anon154_Else:
    assume {:partition} ResponseCode_1 == 15;
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon146_Then, anon146_Else;

  anon146_Else:
    goto L174;

  L174:
    Command_12 := 0;
    goto L119;

  anon146_Then:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon147_Then, anon147_Else;

  anon147_Else:
    goto L174;

  anon147_Then:
    goto L119;

  anon154_Then:
    assume {:partition} ResponseCode_1 != 15;
    Command_12 := 0;
    goto L119;

  anon155_Then:
    assume {:partition} ResponseCode_1 == 10;
    goto L171;

  L171:
    assume {:nonnull} Command_12 != 0;
    assume Command_12 > 0;
    goto anon145_Then, anon145_Else;

  anon145_Else:
    Command_12 := 0;
    goto L119;

  anon145_Then:
    goto L119;

  anon156_Then:
    assume {:partition} ResponseCode_1 == 9;
    goto L171;

  anon123_Then:
    assume {:partition} ResponseCode_1 == 8;
    goto L171;

  anon122_Then:
    assume {:partition} sdv_107 == 0;
    goto L86;

  anon167_Then:
    goto L86;

  anon121_Then:
    goto L81;

  anon117_Then:
    assume {:partition} Status_9 != 0;
    goto L37;

  anon115_Then:
    call {:si_unique_call 1310} Tmp_178 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    Mem_T.INT4[Tmp_178] := OldIrql_8;
    call {:si_unique_call 1311} sdv_KeAcquireSpinLock(0, Tmp_178);
    assume {:nonnull} Tmp_178 != 0;
    assume Tmp_178 > 0;
    OldIrql_8 := Mem_T.INT4[Tmp_178];
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume {:nonnull} DevExt_12 != 0;
    assume DevExt_12 > 0;
    goto L17;

  L17:
    call {:si_unique_call 1312} IoFreeIrp(0);
    call {:si_unique_call 1313} sdv_KeReleaseSpinLock(0, OldIrql_8);
    call {:si_unique_call 1314} AvcStopAllFCPProcessing(DevExt_12);
    goto L10;

  anon116_Then:
    goto L17;

  anon164_Then:
    call {:si_unique_call 1315} IoFreeIrp(0);
    goto L10;
}



procedure {:origName "AvcResponseCompletion_sdv_static_function_7"} AvcResponseCompletion_sdv_static_function_7#1(actual_DeviceObject_9: int, actual_Irp_12: int, actual_DevExtIn_1: int) returns (Tmp_166: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_3) || sdv_irql_previous_5 == old(sdv_irql_previous_2) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2) || sdv_irql_previous_2 == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4) || sdv_irql_previous_4 == old(sdv_irql_previous_3) || sdv_irql_previous_4 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3) || sdv_irql_previous_3 == old(sdv_irql_previous_2);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcHandleUnitCommand_sdv_static_function_7"} AvcHandleUnitCommand_sdv_static_function_7#0(actual_DeviceObject_10: int, actual_DevExt_14: int)
{
  var {:scalar} CommandType_2: int;
  var {:scalar} Tmp_202: int;
  var {:scalar} Offset_3: int;
  var {:pointer} VirtualDevExt: int;
  var {:scalar} VendorID: int;
  var {:pointer} SubunitInfoBytes: int;
  var {:scalar} ResponseCode_2: int;
  var {:scalar} Tmp_203: int;
  var {:pointer} Tmp_205: int;
  var {:pointer} sdv_118: int;
  var {:scalar} oldIrql_1: int;
  var {:scalar} Page: int;
  var {:pointer} Tmp_206: int;
  var {:pointer} Entry_6: int;
  var {:pointer} Operands_1: int;
  var {:dopa} {:scalar} BytesUsed_4: int;
  var {:pointer} Tmp_208: int;
  var {:pointer} Tmp_209: int;
  var {:scalar} Opcode_4: int;
  var {:scalar} Tmp_210: int;
  var {:pointer} Tmp_212: int;
  var {:pointer} DeviceObject_10: int;
  var {:pointer} DevExt_14: int;
  var boogieTmp: int;
  var vslice_dummy_var_279: int;

  anon0:
    call {:si_unique_call 1316} BytesUsed_4 := __HAVOC_malloc(4);
    call {:si_unique_call 1317} vslice_dummy_var_279 := __HAVOC_malloc(4);
    DeviceObject_10 := actual_DeviceObject_10;
    DevExt_14 := actual_DevExt_14;
    call {:si_unique_call 1318} SubunitInfoBytes := __HAVOC_malloc(128);
    call {:si_unique_call 1319} Tmp_206 := __HAVOC_malloc(2048);
    call {:si_unique_call 1320} Tmp_208 := __HAVOC_malloc(2048);
    call {:si_unique_call 1321} Tmp_209 := __HAVOC_malloc(2048);
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    havoc Tmp_206;
    assume {:nonnull} Tmp_206 != 0;
    assume Tmp_206 > 0;
    CommandType_2 := BAND(Mem_T.INT4[Tmp_206], BOR(BOR(BOR(1, 2), 4), 8));
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    havoc Tmp_209;
    assume {:nonnull} Tmp_209 != 0;
    assume Tmp_209 > 0;
    Opcode_4 := Mem_T.INT4[Tmp_209 + 2 * 4];
    ResponseCode_2 := 8;
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    havoc Tmp_208;
    Operands_1 := Tmp_208 + 3 * 4;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} Opcode_4 != 48;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} Opcode_4 == 49;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} 1 == CommandType_2;
    call {:si_unique_call 1322} Page := corral_nondet();
    Offset_3 := 0;
    call {:si_unique_call 1323} Tmp_212 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_212 != 0;
    assume Tmp_212 > 0;
    Mem_T.INT4[Tmp_212] := oldIrql_1;
    call {:si_unique_call 1324} sdv_KeAcquireSpinLock(0, Tmp_212);
    assume {:nonnull} Tmp_212 != 0;
    assume Tmp_212 > 0;
    oldIrql_1 := Mem_T.INT4[Tmp_212];
    havoc Entry_6;
    goto L32;

  L32:
    call {:si_unique_call 1325} Tmp_202, Offset_3, VirtualDevExt, Tmp_205, sdv_118, Entry_6, Tmp_210 := AvcHandleUnitCommand_sdv_static_function_7#0_loop_L32(Tmp_202, Offset_3, VirtualDevExt, SubunitInfoBytes, Tmp_205, sdv_118, Entry_6, BytesUsed_4, Tmp_210);
    goto L32_last;

  L32_last:
    goto anon17_Then, anon17_Else;

  anon17_Else:
    call {:si_unique_call 1326} sdv_118 := sdv_containing_record(Entry_6, 72);
    VirtualDevExt := sdv_118;
    assume {:nonnull} BytesUsed_4 != 0;
    assume BytesUsed_4 > 0;
    Mem_T.INT4[BytesUsed_4] := 0;
    call {:si_unique_call 1327} sdv_KeAcquireSpinLockAtDpcLevel(0);
    Tmp_202 := Offset_3;
    Tmp_205 := SubunitInfoBytes + Tmp_202 * 4;
    Tmp_210 := 32 - Offset_3;
    call {:si_unique_call 1328} AvcPackSubunitInfo(VirtualDevExt, Tmp_210, Tmp_205, BytesUsed_4);
    assume {:nonnull} BytesUsed_4 != 0;
    assume BytesUsed_4 > 0;
    Offset_3 := Offset_3 + Mem_T.INT4[BytesUsed_4];
    call {:si_unique_call 1329} sdv_KeReleaseSpinLockFromDpcLevel(0);
    assume {:nonnull} Entry_6 != 0;
    assume Entry_6 > 0;
    havoc Entry_6;
    goto anon17_Else_dummy;

  anon17_Else_dummy:
    assume false;
    return;

  anon17_Then:
    call {:si_unique_call 1330} sdv_KeReleaseSpinLock(0, oldIrql_1);
    Tmp_203 := Page * 4;
    call {:si_unique_call 1331} sdv_RtlCopyMemory(0, 0, 4);
    ResponseCode_2 := 12;
    goto L12;

  L12:
    call {:si_unique_call 1332} AvcLocalResponse_sdv_static_function_7#0(DeviceObject_10, DevExt_14, ResponseCode_2);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} yogi_error != 1;
    goto LM2;

  LM2:
    return;

  anon21_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon16_Then:
    assume {:partition} 1 != CommandType_2;
    goto L12;

  anon19_Then:
    assume {:partition} Opcode_4 != 49;
    goto L12;

  anon20_Then:
    assume {:partition} Opcode_4 == 48;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} 1 == CommandType_2;
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    havoc VendorID;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    Mem_T.INT4[Operands_1] := 7;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    Mem_T.INT4[Operands_1 + 1 * 4] := 224;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    call {:si_unique_call 1333} boogieTmp := corral_nondet();
    Mem_T.INT4[Operands_1 + 2 * 4] := boogieTmp;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    call {:si_unique_call 1334} boogieTmp := corral_nondet();
    Mem_T.INT4[Operands_1 + 3 * 4] := boogieTmp;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    Mem_T.INT4[Operands_1 + 4 * 4] := BAND(VendorID, BOR(BOR(BOR(BOR(BOR(BOR(BOR(1, 2), 4), 8), 16), 32), 64), 128));
    ResponseCode_2 := 12;
    goto L12;

  anon18_Then:
    ResponseCode_2 := 10;
    goto L12;

  anon15_Then:
    assume {:partition} 1 != CommandType_2;
    goto L12;
}



procedure {:origName "AvcHandleUnitCommand_sdv_static_function_7"} AvcHandleUnitCommand_sdv_static_function_7#0(actual_DeviceObject_10: int, actual_DevExt_14: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_3) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4) || sdv_irql_previous_4 == old(sdv_irql_previous_3);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "AvcHandleUnitCommand_sdv_static_function_7"} AvcHandleUnitCommand_sdv_static_function_7#1(actual_DeviceObject_10: int, actual_DevExt_14: int)
{
  var {:scalar} CommandType_2: int;
  var {:scalar} Tmp_202: int;
  var {:scalar} Offset_3: int;
  var {:pointer} VirtualDevExt: int;
  var {:scalar} VendorID: int;
  var {:pointer} SubunitInfoBytes: int;
  var {:scalar} ResponseCode_2: int;
  var {:scalar} Tmp_203: int;
  var {:pointer} Tmp_205: int;
  var {:pointer} sdv_118: int;
  var {:scalar} oldIrql_1: int;
  var {:scalar} Page: int;
  var {:pointer} Tmp_206: int;
  var {:pointer} Entry_6: int;
  var {:pointer} Operands_1: int;
  var {:dopa} {:scalar} BytesUsed_4: int;
  var {:pointer} Tmp_208: int;
  var {:pointer} Tmp_209: int;
  var {:scalar} Opcode_4: int;
  var {:scalar} Tmp_210: int;
  var {:pointer} Tmp_212: int;
  var {:pointer} DeviceObject_10: int;
  var {:pointer} DevExt_14: int;
  var boogieTmp: int;
  var vslice_dummy_var_280: int;

  anon0:
    call {:si_unique_call 1335} BytesUsed_4 := __HAVOC_malloc(4);
    call {:si_unique_call 1336} vslice_dummy_var_280 := __HAVOC_malloc(4);
    DeviceObject_10 := actual_DeviceObject_10;
    DevExt_14 := actual_DevExt_14;
    call {:si_unique_call 1337} SubunitInfoBytes := __HAVOC_malloc(128);
    call {:si_unique_call 1338} Tmp_206 := __HAVOC_malloc(2048);
    call {:si_unique_call 1339} Tmp_208 := __HAVOC_malloc(2048);
    call {:si_unique_call 1340} Tmp_209 := __HAVOC_malloc(2048);
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    havoc Tmp_206;
    assume {:nonnull} Tmp_206 != 0;
    assume Tmp_206 > 0;
    CommandType_2 := BAND(Mem_T.INT4[Tmp_206], BOR(BOR(BOR(1, 2), 4), 8));
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    havoc Tmp_209;
    assume {:nonnull} Tmp_209 != 0;
    assume Tmp_209 > 0;
    Opcode_4 := Mem_T.INT4[Tmp_209 + 2 * 4];
    ResponseCode_2 := 8;
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    havoc Tmp_208;
    Operands_1 := Tmp_208 + 3 * 4;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} Opcode_4 != 48;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} Opcode_4 == 49;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} 1 == CommandType_2;
    call {:si_unique_call 1341} Page := corral_nondet();
    Offset_3 := 0;
    call {:si_unique_call 1342} Tmp_212 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_212 != 0;
    assume Tmp_212 > 0;
    Mem_T.INT4[Tmp_212] := oldIrql_1;
    call {:si_unique_call 1343} sdv_KeAcquireSpinLock(0, Tmp_212);
    assume {:nonnull} Tmp_212 != 0;
    assume Tmp_212 > 0;
    oldIrql_1 := Mem_T.INT4[Tmp_212];
    havoc Entry_6;
    goto L32;

  L32:
    call {:si_unique_call 1344} Tmp_202, Offset_3, VirtualDevExt, Tmp_205, sdv_118, Entry_6, Tmp_210 := AvcHandleUnitCommand_sdv_static_function_7#1_loop_L32(Tmp_202, Offset_3, VirtualDevExt, SubunitInfoBytes, Tmp_205, sdv_118, Entry_6, BytesUsed_4, Tmp_210);
    goto L32_last;

  L32_last:
    goto anon17_Then, anon17_Else;

  anon17_Else:
    call {:si_unique_call 1345} sdv_118 := sdv_containing_record(Entry_6, 72);
    VirtualDevExt := sdv_118;
    assume {:nonnull} BytesUsed_4 != 0;
    assume BytesUsed_4 > 0;
    Mem_T.INT4[BytesUsed_4] := 0;
    call {:si_unique_call 1346} sdv_KeAcquireSpinLockAtDpcLevel(0);
    Tmp_202 := Offset_3;
    Tmp_205 := SubunitInfoBytes + Tmp_202 * 4;
    Tmp_210 := 32 - Offset_3;
    call {:si_unique_call 1347} AvcPackSubunitInfo(VirtualDevExt, Tmp_210, Tmp_205, BytesUsed_4);
    assume {:nonnull} BytesUsed_4 != 0;
    assume BytesUsed_4 > 0;
    Offset_3 := Offset_3 + Mem_T.INT4[BytesUsed_4];
    call {:si_unique_call 1348} sdv_KeReleaseSpinLockFromDpcLevel(0);
    assume {:nonnull} Entry_6 != 0;
    assume Entry_6 > 0;
    havoc Entry_6;
    goto anon17_Else_dummy;

  anon17_Else_dummy:
    assume false;
    return;

  anon17_Then:
    call {:si_unique_call 1349} sdv_KeReleaseSpinLock(0, oldIrql_1);
    Tmp_203 := Page * 4;
    call {:si_unique_call 1350} sdv_RtlCopyMemory(0, 0, 4);
    ResponseCode_2 := 12;
    goto L12;

  L12:
    call {:si_unique_call 1351} AvcLocalResponse_sdv_static_function_7#1(DeviceObject_10, DevExt_14, ResponseCode_2);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} yogi_error != 1;
    goto LM2;

  LM2:
    return;

  anon21_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon16_Then:
    assume {:partition} 1 != CommandType_2;
    goto L12;

  anon19_Then:
    assume {:partition} Opcode_4 != 49;
    goto L12;

  anon20_Then:
    assume {:partition} Opcode_4 == 48;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} 1 == CommandType_2;
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:nonnull} DevExt_14 != 0;
    assume DevExt_14 > 0;
    havoc VendorID;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    Mem_T.INT4[Operands_1] := 7;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    Mem_T.INT4[Operands_1 + 1 * 4] := 224;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    call {:si_unique_call 1352} boogieTmp := corral_nondet();
    Mem_T.INT4[Operands_1 + 2 * 4] := boogieTmp;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    call {:si_unique_call 1353} boogieTmp := corral_nondet();
    Mem_T.INT4[Operands_1 + 3 * 4] := boogieTmp;
    assume {:nonnull} Operands_1 != 0;
    assume Operands_1 > 0;
    Mem_T.INT4[Operands_1 + 4 * 4] := BAND(VendorID, BOR(BOR(BOR(BOR(BOR(BOR(BOR(1, 2), 4), 8), 16), 32), 64), 128));
    ResponseCode_2 := 12;
    goto L12;

  anon18_Then:
    ResponseCode_2 := 10;
    goto L12;

  anon15_Then:
    assume {:partition} 1 != CommandType_2;
    goto L12;
}



procedure {:origName "AvcHandleUnitCommand_sdv_static_function_7"} AvcHandleUnitCommand_sdv_static_function_7#1(actual_DeviceObject_10: int, actual_DevExt_14: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_3) || sdv_irql_previous_5 == old(sdv_irql_previous_2) || sdv_irql_previous_5 == old(sdv_irql_previous_4) || sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous) || sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_3) || sdv_irql_previous_4 == old(sdv_irql_previous_2) || sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_2) || sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



function POW2(a: int) : bool;

axiom (forall x: int :: { POW2(x) } x == 0 || x == 1 || x == 2 || x == 4 || x == 8 || x == 16 || x == 32 || x == 64 || x == 128 || x == 256 || x == 512 || x == 1024 || x == 2048 || x == 4096 || x == 8192 || x == 16384 || x == 32768 || x == 65536 || x == 131072 || x == 262144 || x == 524288 || x == 1048576 || x == 2097152 || x == 4194304 || x == 8388608 || x == 16777216 || x == 33554432 || x == 67108864 || x == 134217728 || x == 268435456 || x == 536870912 || x == 1073741824 || x == 2147483648 || x == -2147483648 ==> POW2(x));

axiom (forall f: int :: { BAND(0, f) } BAND(0, f) == 0);

axiom (forall f: int :: { BAND(f, f) } BAND(f, f) == f);

axiom (forall f: int :: { BOR(0, f) } BOR(0, f) == f);

axiom (forall f: int :: { BOR(f, 0) } BOR(f, 0) == f);

axiom (forall x: int, f: int :: { BAND(x, f) } POW2(x) && POW2(f) && x != f ==> BAND(x, f) == 0);

axiom (forall a: int, b: int, c: int :: { BOR(a, BOR(b, c)) } BOR(a, BOR(b, c)) == BOR(BOR(a, b), c));

axiom (forall a: int, b: int, c: int :: { BAND(a, BOR(b, c)) } BAND(a, BOR(b, c)) == BAND(BOR(b, c), a));

axiom (forall x: int, f1: int, f2: int :: { BAND(BOR(x, f1), f2) } (f1 != f2 && POW2(f1) && POW2(f2) ==> BAND(BOR(x, f1), f2) == BAND(x, f2)) && (f1 == f2 ==> BAND(BOR(x, f1), f2) == f1));

axiom (forall x: int, f1: int, f2: int :: { BAND(BAND(x, BNOT(f1)), f2) } (f1 != f2 && POW2(f1) && POW2(f2) ==> BAND(BAND(x, BNOT(f1)), f2) == BAND(x, f2)) && (f1 == f2 && POW2(f1) && POW2(f2) ==> BAND(BAND(x, BNOT(f1)), f2) == 0));

axiom (forall x: int, f1: int, f2: int :: { BAND(BOR(f1, x), f2) } (f1 != f2 && POW2(f1) && POW2(f2) ==> BAND(BOR(f1, x), f2) == BAND(x, f2)) && (f1 == f2 ==> BAND(BOR(f1, x), f2) == f1));

axiom (forall x: int, y: int, f2: int :: { BAND(BAND(x, y), f2) } POW2(f2) ==> BAND(BAND(x, y), f2) == 0 || BAND(BAND(x, y), f2) == BAND(x, f2));

implementation AvcSubunitPackedTypesEqual_loop_L16(in_Tmp_55: int, in_Tmp_58: int, in_idx: int, in_SubunitType1: int, in_SubunitType2: int) returns (out_Tmp_55: int, out_Tmp_58: int, out_idx: int)
{

  entry:
    out_Tmp_55, out_Tmp_58, out_idx := in_Tmp_55, in_Tmp_58, in_idx;
    goto L16, exit;

  exit:
    return;

  L16:
    out_Tmp_55 := out_idx;
    assume {:nonnull} in_SubunitType1 != 0;
    assume in_SubunitType1 > 0;
    goto anon22_Else;

  anon22_Else:
    assume {:partition} Mem_T.INT4[in_SubunitType1 + out_Tmp_55 * 4] == 255;
    out_Tmp_58 := out_idx;
    assume {:nonnull} in_SubunitType2 != 0;
    assume in_SubunitType2 > 0;
    goto anon23_Then;

  anon23_Then:
    assume {:partition} Mem_T.INT4[in_SubunitType2 + out_Tmp_58 * 4] == 255;
    out_idx := out_idx + 1;
    goto anon23_Then_dummy;

  anon23_Then_dummy:
    havoc out_idx;
    return;
}



procedure {:LoopProcedure} AvcSubunitPackedTypesEqual_loop_L16(in_Tmp_55: int, in_Tmp_58: int, in_idx: int, in_SubunitType1: int, in_SubunitType2: int) returns (out_Tmp_55: int, out_Tmp_58: int, out_idx: int);
  free ensures out_Tmp_55 == in_idx || out_Tmp_55 == in_Tmp_55;
  free ensures out_Tmp_58 == in_idx || out_Tmp_58 == in_Tmp_58;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcStopAllFCPProcessing_loop_L22(in_sdv_29: int, in_OldIrql_1: int, in_sdv_35: int, in_Tmp_62: int, in_Command_1: int, in_DevExt_1: int) returns (out_sdv_29: int, out_OldIrql_1: int, out_sdv_35: int, out_Tmp_62: int, out_Command_1: int)
{

  entry:
    out_sdv_29, out_OldIrql_1, out_sdv_35, out_Tmp_62, out_Command_1 := in_sdv_29, in_OldIrql_1, in_sdv_35, in_Tmp_62, in_Command_1;
    goto L22, exit;

  exit:
    return;

  L22:
    call {:si_unique_call 1354} out_sdv_35 := sdv_IsListEmpty(0);
    goto anon15_Then;

  anon15_Then:
    assume {:partition} out_sdv_35 == 0;
    assume {:nonnull} in_DevExt_1 != 0;
    assume in_DevExt_1 > 0;
    call {:si_unique_call 1355} out_sdv_29 := RemoveHeadList(CleanupList__BUS_DEVICE_EXTENSION(in_DevExt_1));
    out_Command_1 := out_sdv_29;
    call {:si_unique_call 1356} InitializeListHead(out_Command_1);
    call {:si_unique_call 1357} sdv_KeReleaseSpinLock(0, out_OldIrql_1);
    call {:si_unique_call 1358} AvcPendingIrpCompletion(out_Command_1);
    call {:si_unique_call 1359} AvcFreeCommandContext(out_Command_1);
    call {:si_unique_call 1360} out_Tmp_62 := __HAVOC_malloc(4);
    assume {:nonnull} out_Tmp_62 != 0;
    assume out_Tmp_62 > 0;
    Mem_T.INT4[out_Tmp_62] := out_OldIrql_1;
    call {:si_unique_call 1361} sdv_KeAcquireSpinLock(0, out_Tmp_62);
    assume {:nonnull} out_Tmp_62 != 0;
    assume out_Tmp_62 > 0;
    out_OldIrql_1 := Mem_T.INT4[out_Tmp_62];
    goto anon15_Then_dummy;

  anon15_Then_dummy:
    call {:si_unique_call 1362} {:si_old_unique_call 1} out_sdv_29, out_OldIrql_1, out_sdv_35, out_Tmp_62, out_Command_1 := AvcStopAllFCPProcessing_loop_L22(out_sdv_29, out_OldIrql_1, out_sdv_35, out_Tmp_62, out_Command_1, in_DevExt_1);
    return;
}



procedure {:LoopProcedure} AvcStopAllFCPProcessing_loop_L22(in_sdv_29: int, in_OldIrql_1: int, in_sdv_35: int, in_Tmp_62: int, in_Command_1: int, in_DevExt_1: int) returns (out_sdv_29: int, out_OldIrql_1: int, out_sdv_35: int, out_Tmp_62: int, out_Command_1: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, Mem_T.INT4, sdv_irql_previous_5;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_current == 2 || sdv_irql_current == old(sdv_irql_current);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures out_sdv_35 == 1 || out_sdv_35 == 0 || out_sdv_35 == in_sdv_35;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcStopAllFCPProcessing_loop_L15(in_OldIrql_1: int, in_sdv_33: int, in_sdv_34: int, in_Tmp_62: int, in_Command_1: int, in_DevExt_1: int) returns (out_OldIrql_1: int, out_sdv_33: int, out_sdv_34: int, out_Tmp_62: int, out_Command_1: int)
{

  entry:
    out_OldIrql_1, out_sdv_33, out_sdv_34, out_Tmp_62, out_Command_1 := in_OldIrql_1, in_sdv_33, in_sdv_34, in_Tmp_62, in_Command_1;
    goto L15, exit;

  exit:
    return;

  L15:
    call {:si_unique_call 1363} out_sdv_33 := sdv_IsListEmpty(0);
    goto anon14_Then;

  anon14_Then:
    assume {:partition} out_sdv_33 == 0;
    assume {:nonnull} in_DevExt_1 != 0;
    assume in_DevExt_1 > 0;
    call {:si_unique_call 1364} out_sdv_34 := RemoveHeadList(PendingRequestList__BUS_DEVICE_EXTENSION(in_DevExt_1));
    out_Command_1 := out_sdv_34;
    call {:si_unique_call 1365} InitializeListHead(out_Command_1);
    call {:si_unique_call 1366} sdv_KeReleaseSpinLock(0, out_OldIrql_1);
    assume {:nonnull} out_Command_1 != 0;
    assume out_Command_1 > 0;
    call {:si_unique_call 1367} AvcPendingIrpCompletion(out_Command_1);
    call {:si_unique_call 1368} AvcFreeCommandContext(out_Command_1);
    out_Command_1 := 0;
    call {:si_unique_call 1369} out_Tmp_62 := __HAVOC_malloc(4);
    assume {:nonnull} out_Tmp_62 != 0;
    assume out_Tmp_62 > 0;
    Mem_T.INT4[out_Tmp_62] := out_OldIrql_1;
    call {:si_unique_call 1370} sdv_KeAcquireSpinLock(0, out_Tmp_62);
    assume {:nonnull} out_Tmp_62 != 0;
    assume out_Tmp_62 > 0;
    out_OldIrql_1 := Mem_T.INT4[out_Tmp_62];
    goto anon14_Then_dummy;

  anon14_Then_dummy:
    call {:si_unique_call 1371} {:si_old_unique_call 1} out_OldIrql_1, out_sdv_33, out_sdv_34, out_Tmp_62, out_Command_1 := AvcStopAllFCPProcessing_loop_L15(out_OldIrql_1, out_sdv_33, out_sdv_34, out_Tmp_62, out_Command_1, in_DevExt_1);
    return;
}



procedure {:LoopProcedure} AvcStopAllFCPProcessing_loop_L15(in_OldIrql_1: int, in_sdv_33: int, in_sdv_34: int, in_Tmp_62: int, in_Command_1: int, in_DevExt_1: int) returns (out_OldIrql_1: int, out_sdv_33: int, out_sdv_34: int, out_Tmp_62: int, out_Command_1: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, Mem_T.INT4, sdv_irql_previous_5;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_current == 2 || sdv_irql_current == old(sdv_irql_current);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures out_sdv_33 == 1 || out_sdv_33 == 0 || out_sdv_33 == in_sdv_33;
  free ensures out_Command_1 == 0 || out_Command_1 == in_Command_1;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcStopAllFCPProcessing_loop_L8(in_sdv_28: int, in_sdv_30: int, in_OldIrql_1: int, in_sdv_32: int, in_Tmp_62: int, in_Command_1: int, in_CallbackLink: int, in_sdv_37: int, in_DevExt_1: int) returns (out_sdv_28: int, out_sdv_30: int, out_OldIrql_1: int, out_sdv_32: int, out_Tmp_62: int, out_Command_1: int, out_CallbackLink: int, out_sdv_37: int)
{
  var vslice_dummy_var_101: int;

  entry:
    out_sdv_28, out_sdv_30, out_OldIrql_1, out_sdv_32, out_Tmp_62, out_Command_1, out_CallbackLink, out_sdv_37 := in_sdv_28, in_sdv_30, in_OldIrql_1, in_sdv_32, in_Tmp_62, in_Command_1, in_CallbackLink, in_sdv_37;
    goto L8, exit;

  exit:
    return;

  L8:
    call {:si_unique_call 1372} out_sdv_28 := sdv_IsListEmpty(0);
    goto anon13_Then;

  anon13_Then:
    assume {:partition} out_sdv_28 == 0;
    assume {:nonnull} in_DevExt_1 != 0;
    assume in_DevExt_1 > 0;
    call {:si_unique_call 1380} out_sdv_32 := RemoveHeadList(PendingResponseList__BUS_DEVICE_EXTENSION(in_DevExt_1));
    out_Command_1 := out_sdv_32;
    call {:si_unique_call 1381} InitializeListHead(out_Command_1);
    call {:si_unique_call 1382} sdv_KeReleaseSpinLock(0, out_OldIrql_1);
    assume {:nonnull} out_Command_1 != 0;
    assume out_Command_1 > 0;
    call {:si_unique_call 1383} out_sdv_30 := sdv_IsListEmpty(0);
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} out_sdv_30 == 0;
    assume {:nonnull} out_Command_1 != 0;
    assume out_Command_1 > 0;
    call {:si_unique_call 1375} out_sdv_37 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(out_Command_1));
    out_CallbackLink := out_sdv_37;
    assume {:IndirectCall} true;
    assume {:nonnull} out_CallbackLink != 0;
    assume out_CallbackLink > 0;
    assume {:nonnull} out_CallbackLink != 0;
    assume out_CallbackLink > 0;
    havoc vslice_dummy_var_101;
    call {:si_unique_call 1376} AvcCommandCallback_sdv_static_function_7(out_Command_1, vslice_dummy_var_101);
    call {:si_unique_call 1377} ExFreeToNPagedLookasideList(AvcCommandLinkPool, out_CallbackLink);
    goto L97;

  L97:
    call {:si_unique_call 1373} out_Tmp_62 := __HAVOC_malloc(4);
    assume {:nonnull} out_Tmp_62 != 0;
    assume out_Tmp_62 > 0;
    Mem_T.INT4[out_Tmp_62] := out_OldIrql_1;
    call {:si_unique_call 1374} sdv_KeAcquireSpinLock(0, out_Tmp_62);
    assume {:nonnull} out_Tmp_62 != 0;
    assume out_Tmp_62 > 0;
    out_OldIrql_1 := Mem_T.INT4[out_Tmp_62];
    goto L97_dummy;

  L97_dummy:
    call {:si_unique_call 1384} {:si_old_unique_call 1} out_sdv_28, out_sdv_30, out_OldIrql_1, out_sdv_32, out_Tmp_62, out_Command_1, out_CallbackLink, out_sdv_37 := AvcStopAllFCPProcessing_loop_L8(out_sdv_28, out_sdv_30, out_OldIrql_1, out_sdv_32, out_Tmp_62, out_Command_1, out_CallbackLink, out_sdv_37, in_DevExt_1);
    return;

  anon18_Then:
    assume {:partition} out_sdv_30 != 0;
    call {:si_unique_call 1378} AvcPendingIrpCompletion(out_Command_1);
    call {:si_unique_call 1379} AvcFreeCommandContext(out_Command_1);
    out_Command_1 := 0;
    goto L97;
}



procedure {:LoopProcedure} AvcStopAllFCPProcessing_loop_L8(in_sdv_28: int, in_sdv_30: int, in_OldIrql_1: int, in_sdv_32: int, in_Tmp_62: int, in_Command_1: int, in_CallbackLink: int, in_sdv_37: int, in_DevExt_1: int) returns (out_sdv_28: int, out_sdv_30: int, out_OldIrql_1: int, out_sdv_32: int, out_Tmp_62: int, out_Command_1: int, out_CallbackLink: int, out_sdv_37: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_current == 2 || sdv_irql_current == old(sdv_irql_current);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures out_sdv_28 == 1 || out_sdv_28 == 0 || out_sdv_28 == in_sdv_28;
  free ensures out_sdv_30 == 1 || out_sdv_30 == 0 || out_sdv_30 == in_sdv_30;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcPackSubunitInfo_loop_L25(in_PdoData: int, in_InnerPdoData: int, in_SubunitId: int, in_sdv_41: int) returns (out_InnerPdoData: int, out_sdv_41: int)
{
  var vslice_dummy_var_102: int;
  var vslice_dummy_var_103: int;

  entry:
    out_InnerPdoData, out_sdv_41 := in_InnerPdoData, in_sdv_41;
    goto L25, exit;

  exit:
    return;

  L25:
    goto anon36_Else;

  anon36_Else:
    assume {:nonnull} out_InnerPdoData != 0;
    assume out_InnerPdoData > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:nonnull} out_InnerPdoData != 0;
    assume out_InnerPdoData > 0;
    assume {:nonnull} in_PdoData != 0;
    assume in_PdoData > 0;
    havoc vslice_dummy_var_102;
    havoc vslice_dummy_var_103;
    call {:si_unique_call 1385} out_sdv_41 := AvcSubunitPackedTypesEqual(vslice_dummy_var_102, vslice_dummy_var_103);
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} out_sdv_41 != 0;
    assume {:nonnull} in_SubunitId != 0;
    assume in_SubunitId > 0;
    Mem_T.INT4[in_SubunitId] := Mem_T.INT4[in_SubunitId] + 1;
    goto L28;

  L28:
    assume {:nonnull} out_InnerPdoData != 0;
    assume out_InnerPdoData > 0;
    havoc out_InnerPdoData;
    goto L28_dummy;

  L28_dummy:
    call {:si_unique_call 1386} {:si_old_unique_call 1} out_InnerPdoData, out_sdv_41 := AvcPackSubunitInfo_loop_L25(in_PdoData, out_InnerPdoData, in_SubunitId, out_sdv_41);
    return;

  anon38_Then:
    assume {:partition} out_sdv_41 == 0;
    goto L28;

  anon37_Then:
    goto L28;
}



procedure {:LoopProcedure} AvcPackSubunitInfo_loop_L25(in_PdoData: int, in_InnerPdoData: int, in_SubunitId: int, in_sdv_41: int) returns (out_InnerPdoData: int, out_sdv_41: int);
  modifies Mem_T.INT4;
  free ensures out_sdv_41 == 1 || out_sdv_41 == 0 || out_sdv_41 == in_sdv_41;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcPackSubunitInfo_loop_L7(in_PdoData: int, in_LocalBytesUsed: int, in_Offset: int, in_InnerPdoData: int, in_Tmp_74: int, in_Tmp_75: int, in_Tmp_76: int, in_SubunitId: int, in_Tmp_77: int, in_sdv_41: int, in_ntStatus_7: int, in_Tmp_78: int, in_SubunitType: int, in_Tmp_80: int, in_Tmp_81: int, in_Tmp_82: int, in_Tmp_83: int, in_Length: int, in_Buffer: int) returns (out_PdoData: int, out_Offset: int, out_InnerPdoData: int, out_Tmp_74: int, out_Tmp_75: int, out_Tmp_76: int, out_Tmp_77: int, out_sdv_41: int, out_ntStatus_7: int, out_Tmp_78: int, out_Tmp_80: int, out_Tmp_81: int, out_Tmp_82: int, out_Tmp_83: int)
{
  var vslice_dummy_var_104: int;
  var vslice_dummy_var_105: int;
  var vslice_dummy_var_106: int;

  entry:
    out_PdoData, out_Offset, out_InnerPdoData, out_Tmp_74, out_Tmp_75, out_Tmp_76, out_Tmp_77, out_sdv_41, out_ntStatus_7, out_Tmp_78, out_Tmp_80, out_Tmp_81, out_Tmp_82, out_Tmp_83 := in_PdoData, in_Offset, in_InnerPdoData, in_Tmp_74, in_Tmp_75, in_Tmp_76, in_Tmp_77, in_sdv_41, in_ntStatus_7, in_Tmp_78, in_Tmp_80, in_Tmp_81, in_Tmp_82, in_Tmp_83;
    goto L7, exit;

  exit:
    return;

  L7:
    goto anon29_Else;

  anon29_Else:
    assume {:nonnull} out_PdoData != 0;
    assume out_PdoData > 0;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:nonnull} out_PdoData != 0;
    assume out_PdoData > 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:nonnull} out_PdoData != 0;
    assume out_PdoData > 0;
    havoc vslice_dummy_var_104;
    call {:si_unique_call 1389} out_ntStatus_7 := AvcUnpackSubunitAddress(vslice_dummy_var_104, in_SubunitType, in_SubunitId, in_LocalBytesUsed);
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} out_ntStatus_7 == 0;
    assume {:nonnull} in_SubunitId != 0;
    assume in_SubunitId > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} Mem_T.INT4[in_SubunitId] == 0;
    assume {:nonnull} out_PdoData != 0;
    assume out_PdoData > 0;
    havoc out_InnerPdoData;
    goto L25;

  L25:
    call {:si_unique_call 1391} out_InnerPdoData, out_sdv_41 := AvcPackSubunitInfo_loop_L25(out_PdoData, out_InnerPdoData, in_SubunitId, out_sdv_41);
    goto L25_last;

  L25_last:
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:nonnull} out_InnerPdoData != 0;
    assume out_InnerPdoData > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:nonnull} out_InnerPdoData != 0;
    assume out_InnerPdoData > 0;
    assume {:nonnull} out_PdoData != 0;
    assume out_PdoData > 0;
    havoc vslice_dummy_var_105;
    havoc vslice_dummy_var_106;
    call {:si_unique_call 1392} out_sdv_41 := AvcSubunitPackedTypesEqual(vslice_dummy_var_105, vslice_dummy_var_106);
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} out_sdv_41 != 0;
    assume {:nonnull} in_SubunitId != 0;
    assume in_SubunitId > 0;
    Mem_T.INT4[in_SubunitId] := Mem_T.INT4[in_SubunitId] + 1;
    goto L28;

  L28:
    assume {:nonnull} out_InnerPdoData != 0;
    assume out_InnerPdoData > 0;
    havoc out_InnerPdoData;
    assume false;
    return;

  anon38_Then:
    assume {:partition} out_sdv_41 == 0;
    goto L28;

  anon37_Then:
    goto L28;

  anon36_Then:
    out_Tmp_74 := out_Offset;
    out_Tmp_83 := in_Buffer + out_Tmp_74 * 4;
    out_Tmp_80 := in_Length - out_Offset;
    assume {:nonnull} in_SubunitId != 0;
    assume in_SubunitId > 0;
    call {:si_unique_call 1390} out_ntStatus_7 := AvcPackSubunitAddress(in_SubunitType, Mem_T.INT4[in_SubunitId], out_Tmp_80, out_Tmp_83, in_LocalBytesUsed);
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} out_ntStatus_7 == 0;
    assume {:nonnull} in_LocalBytesUsed != 0;
    assume in_LocalBytesUsed > 0;
    out_Offset := out_Offset + Mem_T.INT4[in_LocalBytesUsed];
    goto L10;

  L10:
    assume {:nonnull} out_PdoData != 0;
    assume out_PdoData > 0;
    havoc out_PdoData;
    goto L10_dummy;

  L10_dummy:
    call {:si_unique_call 1393} {:si_old_unique_call 1} out_PdoData, out_Offset, out_InnerPdoData, out_Tmp_74, out_Tmp_75, out_Tmp_76, out_Tmp_77, out_sdv_41, out_ntStatus_7, out_Tmp_78, out_Tmp_80, out_Tmp_81, out_Tmp_82, out_Tmp_83 := AvcPackSubunitInfo_loop_L7(out_PdoData, in_LocalBytesUsed, out_Offset, out_InnerPdoData, out_Tmp_74, out_Tmp_75, out_Tmp_76, in_SubunitId, out_Tmp_77, out_sdv_41, out_ntStatus_7, out_Tmp_78, in_SubunitType, out_Tmp_80, out_Tmp_81, out_Tmp_82, out_Tmp_83, in_Length, in_Buffer);
    return;

  anon39_Then:
    assume {:partition} out_ntStatus_7 != 0;
    goto L10;

  anon35_Then:
    assume {:partition} Mem_T.INT4[in_SubunitId] != 0;
    goto L10;

  anon34_Then:
    assume {:partition} out_ntStatus_7 != 0;
    goto L10;

  anon32_Then:
    assume {:nonnull} out_PdoData != 0;
    assume out_PdoData > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    goto L42;

  L42:
    assume {:nonnull} in_SubunitType != 0;
    assume in_SubunitType > 0;
    Mem_T.INT4[in_SubunitType] := 4;
    out_Tmp_75 := out_Offset;
    out_Tmp_76 := in_Buffer + out_Tmp_75 * 4;
    out_Tmp_77 := in_Length - out_Offset;
    call {:si_unique_call 1388} out_ntStatus_7 := AvcPackSubunitAddress(in_SubunitType, 0, out_Tmp_77, out_Tmp_76, in_LocalBytesUsed);
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} out_ntStatus_7 != 0;
    goto L51;

  L51:
    assume {:nonnull} in_SubunitType != 0;
    assume in_SubunitType > 0;
    Mem_T.INT4[in_SubunitType] := 7;
    out_Tmp_78 := out_Offset;
    out_Tmp_82 := in_Buffer + out_Tmp_78 * 4;
    out_Tmp_81 := in_Length - out_Offset;
    call {:si_unique_call 1387} out_ntStatus_7 := AvcPackSubunitAddress(in_SubunitType, 0, out_Tmp_81, out_Tmp_82, in_LocalBytesUsed);
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} out_ntStatus_7 == 0;
    assume {:nonnull} in_LocalBytesUsed != 0;
    assume in_LocalBytesUsed > 0;
    out_Offset := out_Offset + Mem_T.INT4[in_LocalBytesUsed];
    goto L10;

  anon42_Then:
    assume {:partition} out_ntStatus_7 != 0;
    goto L10;

  anon41_Then:
    assume {:partition} out_ntStatus_7 == 0;
    assume {:nonnull} in_LocalBytesUsed != 0;
    assume in_LocalBytesUsed > 0;
    out_Offset := out_Offset + Mem_T.INT4[in_LocalBytesUsed];
    goto L51;

  anon33_Then:
    assume {:nonnull} out_PdoData != 0;
    assume out_PdoData > 0;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    goto L42;

  anon40_Then:
    goto L10;

  anon31_Then:
    goto L10;
}



procedure {:LoopProcedure} AvcPackSubunitInfo_loop_L7(in_PdoData: int, in_LocalBytesUsed: int, in_Offset: int, in_InnerPdoData: int, in_Tmp_74: int, in_Tmp_75: int, in_Tmp_76: int, in_SubunitId: int, in_Tmp_77: int, in_sdv_41: int, in_ntStatus_7: int, in_Tmp_78: int, in_SubunitType: int, in_Tmp_80: int, in_Tmp_81: int, in_Tmp_82: int, in_Tmp_83: int, in_Length: int, in_Buffer: int) returns (out_PdoData: int, out_Offset: int, out_InnerPdoData: int, out_Tmp_74: int, out_Tmp_75: int, out_Tmp_76: int, out_Tmp_77: int, out_sdv_41: int, out_ntStatus_7: int, out_Tmp_78: int, out_Tmp_80: int, out_Tmp_81: int, out_Tmp_82: int, out_Tmp_83: int);
  modifies Mem_T.INT4;
  free ensures out_sdv_41 == 1 || out_sdv_41 == 0 || out_sdv_41 == in_sdv_41;
  free ensures out_ntStatus_7 == 0 || out_ntStatus_7 == -1073741811 || out_ntStatus_7 == in_ntStatus_7;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcStopSelectedFCPProcessing_loop_L23(in_Irp_7: int, in_sdv_45: int, in_sdv_47: int, in_IrpEntry: int, in_PendingIrpList: int) returns (out_Irp_7: int, out_sdv_45: int, out_sdv_47: int, out_IrpEntry: int)
{

  entry:
    out_Irp_7, out_sdv_45, out_sdv_47, out_IrpEntry := in_Irp_7, in_sdv_45, in_sdv_47, in_IrpEntry;
    goto L23, exit;

  exit:
    return;

  L23:
    call {:si_unique_call 1394} out_sdv_45 := sdv_IsListEmpty(0);
    goto anon3_Else;

  anon3_Else:
    assume {:partition} out_sdv_45 == 0;
    call {:si_unique_call 1395} out_IrpEntry := RemoveHeadList(in_PendingIrpList);
    call {:si_unique_call 1396} out_sdv_47 := sdv_containing_record(out_IrpEntry, 88);
    out_Irp_7 := out_sdv_47;
    assume {:nonnull} out_Irp_7 != 0;
    assume out_Irp_7 > 0;
    assume {:nonnull} out_Irp_7 != 0;
    assume out_Irp_7 > 0;
    call {:si_unique_call 1397} sdv_IoCompleteRequest(0, 0);
    goto anon3_Else_dummy;

  anon3_Else_dummy:
    call {:si_unique_call 1398} {:si_old_unique_call 1} out_Irp_7, out_sdv_45, out_sdv_47, out_IrpEntry := AvcStopSelectedFCPProcessing_loop_L23(out_Irp_7, out_sdv_45, out_sdv_47, out_IrpEntry, in_PendingIrpList);
    return;
}



procedure {:LoopProcedure} AvcStopSelectedFCPProcessing_loop_L23(in_Irp_7: int, in_sdv_45: int, in_sdv_47: int, in_IrpEntry: int, in_PendingIrpList: int) returns (out_Irp_7: int, out_sdv_45: int, out_sdv_47: int, out_IrpEntry: int);
  modifies alloc;
  free ensures out_sdv_45 == 1 || out_sdv_45 == 0 || out_sdv_45 == in_sdv_45;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcSubunitAddrsEqual_loop_L14(in_Tmp_101: int, in_Tmp_102: int, in_idx_1: int, in_SubunitAddr1: int, in_SubunitAddr2: int) returns (out_Tmp_101: int, out_Tmp_102: int, out_idx_1: int)
{

  entry:
    out_Tmp_101, out_Tmp_102, out_idx_1 := in_Tmp_101, in_Tmp_102, in_idx_1;
    goto L14, exit;

  exit:
    return;

  L14:
    out_Tmp_102 := out_idx_1;
    assume {:nonnull} in_SubunitAddr1 != 0;
    assume in_SubunitAddr1 > 0;
    goto anon30_Else;

  anon30_Else:
    assume {:partition} Mem_T.INT4[in_SubunitAddr1 + out_Tmp_102 * 4] == 255;
    out_Tmp_101 := out_idx_1;
    assume {:nonnull} in_SubunitAddr2 != 0;
    assume in_SubunitAddr2 > 0;
    goto anon31_Then;

  anon31_Then:
    assume {:partition} Mem_T.INT4[in_SubunitAddr2 + out_Tmp_101 * 4] == 255;
    out_idx_1 := out_idx_1 + 1;
    goto anon31_Then_dummy;

  anon31_Then_dummy:
    havoc out_idx_1;
    return;
}



procedure {:LoopProcedure} AvcSubunitAddrsEqual_loop_L14(in_Tmp_101: int, in_Tmp_102: int, in_idx_1: int, in_SubunitAddr1: int, in_SubunitAddr2: int) returns (out_Tmp_101: int, out_Tmp_102: int, out_idx_1: int);
  free ensures out_Tmp_101 == in_idx_1 || out_Tmp_101 == in_Tmp_101;
  free ensures out_Tmp_102 == in_idx_1 || out_Tmp_102 == in_Tmp_102;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcSubunitAddrsEqual_loop_L23(in_Tmp_95: int, in_Tmp_97: int, in_idx_1: int, in_SubunitAddr1: int, in_SubunitAddr2: int) returns (out_Tmp_95: int, out_Tmp_97: int, out_idx_1: int)
{

  entry:
    out_Tmp_95, out_Tmp_97, out_idx_1 := in_Tmp_95, in_Tmp_97, in_idx_1;
    goto L23, exit;

  exit:
    return;

  L23:
    out_Tmp_97 := out_idx_1;
    assume {:nonnull} in_SubunitAddr1 != 0;
    assume in_SubunitAddr1 > 0;
    goto anon34_Else;

  anon34_Else:
    assume {:partition} Mem_T.INT4[in_SubunitAddr1 + out_Tmp_97 * 4] == 255;
    out_Tmp_95 := out_idx_1;
    assume {:nonnull} in_SubunitAddr2 != 0;
    assume in_SubunitAddr2 > 0;
    goto anon35_Then;

  anon35_Then:
    assume {:partition} Mem_T.INT4[in_SubunitAddr2 + out_Tmp_95 * 4] == 255;
    out_idx_1 := out_idx_1 + 1;
    goto anon35_Then_dummy;

  anon35_Then_dummy:
    havoc out_idx_1;
    return;
}



procedure {:LoopProcedure} AvcSubunitAddrsEqual_loop_L23(in_Tmp_95: int, in_Tmp_97: int, in_idx_1: int, in_SubunitAddr1: int, in_SubunitAddr2: int) returns (out_Tmp_95: int, out_Tmp_97: int, out_idx_1: int);
  free ensures out_Tmp_95 == in_idx_1 || out_Tmp_95 == in_Tmp_95;
  free ensures out_Tmp_97 == in_idx_1 || out_Tmp_97 == in_Tmp_97;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcPendingIrpCompletion_loop_L8(in_Irp_8: int, in_Status_3: int, in_IrpStack_3: int, in_CmdIrb: int, in_Command_5: int) returns (out_Irp_8: int, out_Status_3: int, out_IrpStack_3: int, out_CmdIrb: int)
{
  var vslice_dummy_var_107: int;

  entry:
    out_Irp_8, out_Status_3, out_IrpStack_3, out_CmdIrb := in_Irp_8, in_Status_3, in_IrpStack_3, in_CmdIrb;
    goto L8, exit;

  exit:
    return;

  L8:
    goto anon11_Else;

  anon11_Else:
    assume {:partition} out_Irp_8 != 0;
    call {:si_unique_call 1402} out_IrpStack_3 := sdv_IoGetCurrentIrpStackLocation(out_Irp_8);
    assume {:nonnull} out_IrpStack_3 != 0;
    assume out_IrpStack_3 > 0;
    havoc out_CmdIrb;
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    havoc out_Status_3;
    goto L23;

  L23:
    assume {:nonnull} out_Irp_8 != 0;
    assume out_Irp_8 > 0;
    assume {:nonnull} out_Irp_8 != 0;
    assume out_Irp_8 > 0;
    call {:si_unique_call 1399} sdv_IoCompleteRequest(0, 0);
    call {:si_unique_call 1400} out_Irp_8 := AvcDequeueFCPIrp(in_Command_5);
    goto L23_dummy;

  L23_dummy:
    call {:si_unique_call 1403} {:si_old_unique_call 1} out_Irp_8, out_Status_3, out_IrpStack_3, out_CmdIrb := AvcPendingIrpCompletion_loop_L8(out_Irp_8, out_Status_3, out_IrpStack_3, out_CmdIrb, in_Command_5);
    return;

  anon15_Then:
    assume {:nonnull} out_CmdIrb != 0;
    assume out_CmdIrb > 0;
    havoc vslice_dummy_var_107;
    call {:si_unique_call 1401} out_Status_3 := AvcUnpackFCPFrame(in_Command_5, Opcode__AVC_COMMAND_IRB(out_CmdIrb), 509, vslice_dummy_var_107);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} out_Status_3 == 0;
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} out_CmdIrb != 0;
    assume out_CmdIrb > 0;
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    goto L35;

  L35:
    assume {:nonnull} out_CmdIrb != 0;
    assume out_CmdIrb > 0;
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    assume {:nonnull} out_CmdIrb != 0;
    assume out_CmdIrb > 0;
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    assume {:nonnull} out_CmdIrb != 0;
    assume out_CmdIrb > 0;
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    assume {:nonnull} out_CmdIrb != 0;
    assume out_CmdIrb > 0;
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    goto L23;

  anon14_Then:
    goto L35;

  anon13_Then:
    assume {:nonnull} out_CmdIrb != 0;
    assume out_CmdIrb > 0;
    assume {:nonnull} in_Command_5 != 0;
    assume in_Command_5 > 0;
    goto L35;

  anon12_Then:
    assume {:partition} out_Status_3 != 0;
    goto L23;
}



procedure {:LoopProcedure} AvcPendingIrpCompletion_loop_L8(in_Irp_8: int, in_Status_3: int, in_IrpStack_3: int, in_CmdIrb: int, in_Command_5: int) returns (out_Irp_8: int, out_Status_3: int, out_IrpStack_3: int, out_CmdIrb: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcFreeCommandContext_loop_L3(in_sdv_56: int, in_sdv_57: int, in_CallbackLink_1: int, in_Command_6: int) returns (out_sdv_56: int, out_sdv_57: int, out_CallbackLink_1: int)
{

  entry:
    out_sdv_56, out_sdv_57, out_CallbackLink_1 := in_sdv_56, in_sdv_57, in_CallbackLink_1;
    goto L3, exit;

  exit:
    return;

  L3:
    call {:si_unique_call 1404} out_sdv_56 := sdv_IsListEmpty(0);
    goto anon5_Else;

  anon5_Else:
    assume {:partition} out_sdv_56 == 0;
    assume {:nonnull} in_Command_6 != 0;
    assume in_Command_6 > 0;
    call {:si_unique_call 1405} out_sdv_57 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(in_Command_6));
    out_CallbackLink_1 := out_sdv_57;
    call {:si_unique_call 1406} ExFreeToNPagedLookasideList(AvcCommandLinkPool, out_CallbackLink_1);
    goto anon5_Else_dummy;

  anon5_Else_dummy:
    call {:si_unique_call 1407} {:si_old_unique_call 1} out_sdv_56, out_sdv_57, out_CallbackLink_1 := AvcFreeCommandContext_loop_L3(out_sdv_56, out_sdv_57, out_CallbackLink_1, in_Command_6);
    return;
}



procedure {:LoopProcedure} AvcFreeCommandContext_loop_L3(in_sdv_56: int, in_sdv_57: int, in_CallbackLink_1: int, in_Command_6: int) returns (out_sdv_56: int, out_sdv_57: int, out_CallbackLink_1: int);
  modifies alloc;
  free ensures out_sdv_56 == 1 || out_sdv_56 == 0 || out_sdv_56 == in_sdv_56;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcPackSubunitAddress_loop_L38(in_Tmp_115: int, in_Tmp_116: int, in_idx_2: int, in_Tmp_120: int, in_SubunitID: int, in_Length_1: int, in_Buffer_1: int) returns (out_Tmp_115: int, out_Tmp_116: int, out_idx_2: int, out_Tmp_120: int, out_SubunitID: int)
{

  entry:
    out_Tmp_115, out_Tmp_116, out_idx_2, out_Tmp_120, out_SubunitID := in_Tmp_115, in_Tmp_116, in_idx_2, in_Tmp_120, in_SubunitID;
    goto L38, exit;

  exit:
    return;

  L38:
    goto anon52_Else;

  anon52_Else:
    assume {:partition} in_Length_1 > out_idx_2;
    goto anon54_Else;

  anon54_Else:
    assume {:partition} out_SubunitID != 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} 255 > out_SubunitID;
    out_Tmp_115 := out_idx_2;
    assume {:nonnull} in_Buffer_1 != 0;
    assume in_Buffer_1 > 0;
    Mem_T.INT4[in_Buffer_1 + out_Tmp_115 * 4] := out_SubunitID;
    goto L44;

  L44:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} out_SubunitID > 254;
    out_Tmp_116 := out_SubunitID - 254;
    goto L47;

  L47:
    out_SubunitID := out_Tmp_116;
    out_idx_2 := out_idx_2 + 1;
    goto L47_dummy;

  L47_dummy:
    call {:si_unique_call 1408} {:si_old_unique_call 1} out_Tmp_115, out_Tmp_116, out_idx_2, out_Tmp_120, out_SubunitID := AvcPackSubunitAddress_loop_L38(out_Tmp_115, out_Tmp_116, out_idx_2, out_Tmp_120, out_SubunitID, in_Length_1, in_Buffer_1);
    return;

  anon56_Then:
    assume {:partition} 254 >= out_SubunitID;
    out_Tmp_116 := 0;
    goto L47;

  anon55_Then:
    assume {:partition} out_SubunitID >= 255;
    out_Tmp_120 := out_idx_2;
    assume {:nonnull} in_Buffer_1 != 0;
    assume in_Buffer_1 > 0;
    Mem_T.INT4[in_Buffer_1 + out_Tmp_120 * 4] := 255;
    goto L44;
}



procedure {:LoopProcedure} AvcPackSubunitAddress_loop_L38(in_Tmp_115: int, in_Tmp_116: int, in_idx_2: int, in_Tmp_120: int, in_SubunitID: int, in_Length_1: int, in_Buffer_1: int) returns (out_Tmp_115: int, out_Tmp_116: int, out_idx_2: int, out_Tmp_120: int, out_SubunitID: int);
  modifies Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcPackSubunitAddress_loop_L19(in_Tmp_114: int, in_Tmp_117: int, in_Tmp_118: int, in_idx_2: int, in_SubunitType_1: int, in_Length_1: int, in_Buffer_1: int, in_boogieTmp: int) returns (out_Tmp_114: int, out_Tmp_117: int, out_Tmp_118: int, out_idx_2: int, out_boogieTmp: int)
{

  entry:
    out_Tmp_114, out_Tmp_117, out_Tmp_118, out_idx_2, out_boogieTmp := in_Tmp_114, in_Tmp_117, in_Tmp_118, in_idx_2, in_boogieTmp;
    goto L19, exit;

  exit:
    return;

  L19:
    goto anon45_Else;

  anon45_Else:
    assume {:partition} in_Length_1 > out_idx_2;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} out_idx_2 != 0;
    out_Tmp_114 := out_idx_2;
    out_Tmp_117 := out_idx_2;
    assume {:nonnull} in_Buffer_1 != 0;
    assume in_Buffer_1 > 0;
    assume {:nonnull} in_SubunitType_1 != 0;
    assume in_SubunitType_1 > 0;
    Mem_T.INT4[in_Buffer_1 + out_Tmp_114 * 4] := Mem_T.INT4[in_SubunitType_1 + out_Tmp_117 * 4];
    goto L24;

  L24:
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} out_idx_2 != 0;
    goto L26;

  L26:
    out_Tmp_118 := out_idx_2;
    assume {:nonnull} in_SubunitType_1 != 0;
    assume in_SubunitType_1 > 0;
    goto anon60_Else;

  anon60_Else:
    assume {:partition} Mem_T.INT4[in_SubunitType_1 + out_Tmp_118 * 4] == 255;
    goto L27;

  L27:
    out_idx_2 := out_idx_2 + 1;
    goto L27_dummy;

  L27_dummy:
    call {:si_unique_call 1410} {:si_old_unique_call 1} out_Tmp_114, out_Tmp_117, out_Tmp_118, out_idx_2, out_boogieTmp := AvcPackSubunitAddress_loop_L19(out_Tmp_114, out_Tmp_117, out_Tmp_118, out_idx_2, in_SubunitType_1, in_Length_1, in_Buffer_1, out_boogieTmp);
    return;

  anon48_Then:
    assume {:partition} out_idx_2 == 0;
    assume {:nonnull} in_SubunitType_1 != 0;
    assume in_SubunitType_1 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} Mem_T.INT4[in_SubunitType_1] == 30;
    goto L27;

  anon49_Then:
    assume {:partition} Mem_T.INT4[in_SubunitType_1] != 30;
    goto L26;

  anon47_Then:
    assume {:partition} out_idx_2 == 0;
    assume {:nonnull} in_Buffer_1 != 0;
    assume in_Buffer_1 > 0;
    call {:si_unique_call 1409} out_boogieTmp := corral_nondet();
    Mem_T.INT4[in_Buffer_1] := out_boogieTmp;
    goto L24;
}



procedure {:LoopProcedure} AvcPackSubunitAddress_loop_L19(in_Tmp_114: int, in_Tmp_117: int, in_Tmp_118: int, in_idx_2: int, in_SubunitType_1: int, in_Length_1: int, in_Buffer_1: int, in_boogieTmp: int) returns (out_Tmp_114: int, out_Tmp_117: int, out_Tmp_118: int, out_idx_2: int, out_boogieTmp: int);
  modifies Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcValidateSubunitAddress_loop_L21(in_idx_3: int, in_Tmp_132: int, in_Buffer_2: int, in_cbIn: int) returns (out_idx_3: int, out_Tmp_132: int)
{

  entry:
    out_idx_3, out_Tmp_132 := in_idx_3, in_Tmp_132;
    goto L21, exit;

  exit:
    return;

  L21:
    goto anon41_Else;

  anon41_Else:
    assume {:partition} in_cbIn > out_idx_3;
    out_Tmp_132 := out_idx_3;
    assume {:nonnull} in_Buffer_2 != 0;
    assume in_Buffer_2 > 0;
    goto anon50_Else;

  anon50_Else:
    assume {:partition} Mem_T.INT4[in_Buffer_2 + out_Tmp_132 * 4] == 255;
    out_idx_3 := out_idx_3 + 1;
    goto anon50_Else_dummy;

  anon50_Else_dummy:
    havoc out_idx_3;
    return;
}



procedure {:LoopProcedure} AvcValidateSubunitAddress_loop_L21(in_idx_3: int, in_Tmp_132: int, in_Buffer_2: int, in_cbIn: int) returns (out_idx_3: int, out_Tmp_132: int);
  free ensures out_Tmp_132 == in_idx_3 || out_Tmp_132 == in_Tmp_132;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcValidateSubunitAddress_loop_L14(in_Tmp_130: int, in_idx_3: int, in_Buffer_2: int, in_cbIn: int) returns (out_Tmp_130: int, out_idx_3: int)
{

  entry:
    out_Tmp_130, out_idx_3 := in_Tmp_130, in_idx_3;
    goto L14, exit;

  exit:
    return;

  L14:
    goto anon39_Else;

  anon39_Else:
    assume {:partition} in_cbIn > out_idx_3;
    out_Tmp_130 := out_idx_3;
    assume {:nonnull} in_Buffer_2 != 0;
    assume in_Buffer_2 > 0;
    goto anon52_Else;

  anon52_Else:
    assume {:partition} Mem_T.INT4[in_Buffer_2 + out_Tmp_130 * 4] == 255;
    out_idx_3 := out_idx_3 + 1;
    goto anon52_Else_dummy;

  anon52_Else_dummy:
    havoc out_idx_3;
    return;
}



procedure {:LoopProcedure} AvcValidateSubunitAddress_loop_L14(in_Tmp_130: int, in_idx_3: int, in_Buffer_2: int, in_cbIn: int) returns (out_Tmp_130: int, out_idx_3: int);
  free ensures out_Tmp_130 == in_idx_3 || out_Tmp_130 == in_Tmp_130;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcCommand_sdv_static_function_7_loop_L74(in_sdv_77: int, in_sdv_78: int, in_CallbackLink_2: int, in_Command_9: int) returns (out_sdv_77: int, out_sdv_78: int, out_CallbackLink_2: int)
{

  entry:
    out_sdv_77, out_sdv_78, out_CallbackLink_2 := in_sdv_77, in_sdv_78, in_CallbackLink_2;
    goto L74, exit;

  exit:
    return;

  L74:
    call {:si_unique_call 1411} out_sdv_78 := sdv_IsListEmpty(0);
    goto anon49_Else;

  anon49_Else:
    assume {:partition} out_sdv_78 == 0;
    assume {:nonnull} in_Command_9 != 0;
    assume in_Command_9 > 0;
    call {:si_unique_call 1412} out_sdv_77 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(in_Command_9));
    out_CallbackLink_2 := out_sdv_77;
    call {:si_unique_call 1413} ExFreeToNPagedLookasideList(AvcCommandLinkPool, out_CallbackLink_2);
    goto anon49_Else_dummy;

  anon49_Else_dummy:
    call {:si_unique_call 1414} {:si_old_unique_call 1} out_sdv_77, out_sdv_78, out_CallbackLink_2 := AvcCommand_sdv_static_function_7_loop_L74(out_sdv_77, out_sdv_78, out_CallbackLink_2, in_Command_9);
    return;
}



procedure {:LoopProcedure} AvcCommand_sdv_static_function_7_loop_L74(in_sdv_77: int, in_sdv_78: int, in_CallbackLink_2: int, in_Command_9: int) returns (out_sdv_77: int, out_sdv_78: int, out_CallbackLink_2: int);
  modifies alloc;
  free ensures out_sdv_78 == 1 || out_sdv_78 == 0 || out_sdv_78 == in_sdv_78;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcCommand_sdv_static_function_7_loop_L50(in_Retries: int, in_OldIrql_5: int, in_Irp_10: int, in_WaitForEvent: int, in_Status_8: int, in_Tmp_146: int, in_OldIrql_6: int, in_sdv_80: int, in_NextIrpStack_3: int, in_sdv_85: int, in_WaitForAbort: int, in_InvalidGenLimit: int, in_tmDelay: int, in_DevExt_8: int, in_Command_9: int, in_vslice_dummy_var_34: int, in_vslice_dummy_var_35: int, in_vslice_dummy_var_36: int, in_vslice_dummy_var_37: int, in_vslice_dummy_var_39: int) returns (out_Retries: int, out_OldIrql_5: int, out_WaitForEvent: int, out_Status_8: int, out_Tmp_146: int, out_OldIrql_6: int, out_sdv_80: int, out_NextIrpStack_3: int, out_sdv_85: int, out_WaitForAbort: int, out_InvalidGenLimit: int, out_vslice_dummy_var_34: int, out_vslice_dummy_var_35: int, out_vslice_dummy_var_36: int, out_vslice_dummy_var_37: int, out_vslice_dummy_var_39: int)
{
  var vslice_dummy_var_108: int;

  entry:
    out_Retries, out_OldIrql_5, out_WaitForEvent, out_Status_8, out_Tmp_146, out_OldIrql_6, out_sdv_80, out_NextIrpStack_3, out_sdv_85, out_WaitForAbort, out_InvalidGenLimit, out_vslice_dummy_var_34, out_vslice_dummy_var_35, out_vslice_dummy_var_36, out_vslice_dummy_var_37, out_vslice_dummy_var_39 := in_Retries, in_OldIrql_5, in_WaitForEvent, in_Status_8, in_Tmp_146, in_OldIrql_6, in_sdv_80, in_NextIrpStack_3, in_sdv_85, in_WaitForAbort, in_InvalidGenLimit, in_vslice_dummy_var_34, in_vslice_dummy_var_35, in_vslice_dummy_var_36, in_vslice_dummy_var_37, in_vslice_dummy_var_39;
    goto L50, exit;

  exit:
    return;

  L50:
    call {:si_unique_call 1415} out_NextIrpStack_3 := sdv_IoGetNextIrpStackLocation(in_Irp_10);
    assume {:nonnull} out_NextIrpStack_3 != 0;
    assume out_NextIrpStack_3 > 0;
    assume {:nonnull} out_NextIrpStack_3 != 0;
    assume out_NextIrpStack_3 > 0;
    assume {:nonnull} in_Command_9 != 0;
    assume in_Command_9 > 0;
    assume {:nonnull} out_NextIrpStack_3 != 0;
    assume out_NextIrpStack_3 > 0;
    call {:si_unique_call 1416} out_Status_8 := AvcPrepareForResponseCallback(in_DevExt_8, in_Command_9);
    goto anon65_Else;

  anon65_Else:
    assume {:partition} yogi_error != 1;
    goto anon47_Then;

  anon47_Then:
    assume {:partition} out_Status_8 == 0;
    assume {:nonnull} in_DevExt_8 != 0;
    assume in_DevExt_8 > 0;
    havoc vslice_dummy_var_108;
    call {:si_unique_call 1420} out_Status_8 := Avc_SubmitIrpSynch(vslice_dummy_var_108, in_Irp_10);
    goto anon66_Else;

  anon66_Else:
    assume {:partition} yogi_error != 1;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} out_Status_8 != 0;
    out_WaitForAbort := 0;
    call {:si_unique_call 1432} out_Tmp_146 := __HAVOC_malloc(4);
    assume {:nonnull} out_Tmp_146 != 0;
    assume out_Tmp_146 > 0;
    Mem_T.INT4[out_Tmp_146] := out_OldIrql_6;
    call {:si_unique_call 1433} sdv_KeAcquireSpinLock(0, out_Tmp_146);
    assume {:nonnull} out_Tmp_146 != 0;
    assume out_Tmp_146 > 0;
    out_OldIrql_6 := Mem_T.INT4[out_Tmp_146];
    call {:si_unique_call 1434} out_sdv_80 := sdv_IsListEmpty(0);
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} out_sdv_80 != 0;
    out_WaitForAbort := 1;
    goto L104;

  L104:
    call {:si_unique_call 1429} sdv_KeReleaseSpinLock(0, out_OldIrql_6);
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} out_WaitForAbort != 0;
    call {:si_unique_call 1428} out_vslice_dummy_var_35 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} in_Command_9 != 0;
    assume in_Command_9 > 0;
    havoc out_Status_8;
    goto L108;

  L108:
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} 258 == out_Status_8;
    out_Status_8 := -1073741248;
    goto L113;

  L113:
    goto anon54_Else;

  anon54_Else:
    assume {:partition} out_Status_8 != 0;
    assume {:nonnull} in_DevExt_8 != 0;
    assume in_DevExt_8 > 0;
    goto anon55_Else;

  anon55_Else:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} -1072562032 == out_Status_8;
    goto anon58_Else;

  anon58_Else:
    assume {:partition} out_InvalidGenLimit != 0;
    assume {:nonnull} in_tmDelay != 0;
    assume in_tmDelay > 0;
    assume {:nonnull} in_tmDelay != 0;
    assume in_tmDelay > 0;
    call {:si_unique_call 1417} out_vslice_dummy_var_39 := KeDelayExecutionThread(0, 0, 0);
    out_InvalidGenLimit := out_InvalidGenLimit - 1;
    goto anon58_Else_dummy;

  anon58_Else_dummy:
    goto L_BAF_0;

  L_BAF_0:
    call {:si_unique_call 1435} {:si_old_unique_call 1} out_Retries, out_OldIrql_5, out_WaitForEvent, out_Status_8, out_Tmp_146, out_OldIrql_6, out_sdv_80, out_NextIrpStack_3, out_sdv_85, out_WaitForAbort, out_InvalidGenLimit, out_vslice_dummy_var_34, out_vslice_dummy_var_35, out_vslice_dummy_var_36, out_vslice_dummy_var_37, out_vslice_dummy_var_39 := AvcCommand_sdv_static_function_7_loop_L50(out_Retries, out_OldIrql_5, in_Irp_10, out_WaitForEvent, out_Status_8, out_Tmp_146, out_OldIrql_6, out_sdv_80, out_NextIrpStack_3, out_sdv_85, out_WaitForAbort, out_InvalidGenLimit, in_tmDelay, in_DevExt_8, in_Command_9, out_vslice_dummy_var_34, out_vslice_dummy_var_35, out_vslice_dummy_var_36, out_vslice_dummy_var_37, out_vslice_dummy_var_39);
    return;

  anon56_Then:
    assume {:partition} -1072562032 != out_Status_8;
    goto anon57_Else;

  anon57_Else:
    assume {:partition} 258 == out_Status_8;
    goto anon59_Else;

  anon59_Else:
    assume {:partition} out_Retries != 0;
    out_Retries := out_Retries - 1;
    goto anon59_Else_dummy;

  anon59_Else_dummy:
    goto L_BAF_0;

  anon53_Then:
    assume {:partition} 258 != out_Status_8;
    goto L113;

  anon52_Then:
    assume {:partition} out_WaitForAbort == 0;
    goto L108;

  anon51_Then:
    assume {:partition} out_sdv_80 == 0;
    call {:si_unique_call 1430} out_vslice_dummy_var_34 := sdv_RemoveEntryList(0);
    call {:si_unique_call 1431} InitializeListHead(in_Command_9);
    goto L104;

  anon50_Then:
    assume {:partition} out_Status_8 == 0;
    assume {:nonnull} in_Command_9 != 0;
    assume in_Command_9 > 0;
    call {:si_unique_call 1419} out_Status_8 := KeWaitForSingleObject(0, 0, 0, 0, Timeout__AVC_COMMAND_CONTEXT(in_Command_9));
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} 258 == out_Status_8;
    out_WaitForEvent := 0;
    call {:si_unique_call 1425} out_Tmp_146 := __HAVOC_malloc(4);
    assume {:nonnull} out_Tmp_146 != 0;
    assume out_Tmp_146 > 0;
    Mem_T.INT4[out_Tmp_146] := out_OldIrql_5;
    call {:si_unique_call 1426} sdv_KeAcquireSpinLock(0, out_Tmp_146);
    assume {:nonnull} out_Tmp_146 != 0;
    assume out_Tmp_146 > 0;
    out_OldIrql_5 := Mem_T.INT4[out_Tmp_146];
    call {:si_unique_call 1427} out_sdv_85 := sdv_IsListEmpty(0);
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} out_sdv_85 != 0;
    out_WaitForEvent := 1;
    goto L150;

  L150:
    call {:si_unique_call 1422} sdv_KeReleaseSpinLock(0, out_OldIrql_5);
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} out_WaitForEvent != 0;
    call {:si_unique_call 1421} out_vslice_dummy_var_37 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} in_Command_9 != 0;
    assume in_Command_9 > 0;
    havoc out_Status_8;
    goto L154;

  L154:
    call {:si_unique_call 1418} IoReuseIrp(in_Irp_10, -1073741637);
    goto L113;

  anon63_Then:
    assume {:partition} out_WaitForEvent == 0;
    goto L154;

  anon62_Then:
    assume {:partition} out_sdv_85 == 0;
    call {:si_unique_call 1423} out_vslice_dummy_var_36 := sdv_RemoveEntryList(0);
    call {:si_unique_call 1424} InitializeListHead(in_Command_9);
    goto L150;

  anon60_Then:
    assume {:partition} 258 != out_Status_8;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} out_Status_8 == 0;
    assume {:nonnull} in_Command_9 != 0;
    assume in_Command_9 > 0;
    havoc out_Status_8;
    goto L113;

  anon61_Then:
    assume {:partition} out_Status_8 != 0;
    goto L113;
}



procedure {:LoopProcedure} AvcCommand_sdv_static_function_7_loop_L50(in_Retries: int, in_OldIrql_5: int, in_Irp_10: int, in_WaitForEvent: int, in_Status_8: int, in_Tmp_146: int, in_OldIrql_6: int, in_sdv_80: int, in_NextIrpStack_3: int, in_sdv_85: int, in_WaitForAbort: int, in_InvalidGenLimit: int, in_tmDelay: int, in_DevExt_8: int, in_Command_9: int, in_vslice_dummy_var_34: int, in_vslice_dummy_var_35: int, in_vslice_dummy_var_36: int, in_vslice_dummy_var_37: int, in_vslice_dummy_var_39: int) returns (out_Retries: int, out_OldIrql_5: int, out_WaitForEvent: int, out_Status_8: int, out_Tmp_146: int, out_OldIrql_6: int, out_sdv_80: int, out_NextIrpStack_3: int, out_sdv_85: int, out_WaitForAbort: int, out_InvalidGenLimit: int, out_vslice_dummy_var_34: int, out_vslice_dummy_var_35: int, out_vslice_dummy_var_36: int, out_vslice_dummy_var_37: int, out_vslice_dummy_var_39: int);
  modifies alloc, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures out_WaitForEvent == 1 || out_WaitForEvent == 0 || out_WaitForEvent == in_WaitForEvent;
  free ensures out_sdv_80 == 1 || out_sdv_80 == 0 || out_sdv_80 == in_sdv_80;
  free ensures out_sdv_85 == 1 || out_sdv_85 == 0 || out_sdv_85 == in_sdv_85;
  free ensures out_WaitForAbort == 1 || out_WaitForAbort == 0 || out_WaitForAbort == in_WaitForAbort;
  free ensures out_vslice_dummy_var_34 == 1 || out_vslice_dummy_var_34 == 0 || out_vslice_dummy_var_34 == in_vslice_dummy_var_34;
  free ensures out_vslice_dummy_var_35 == 258 || out_vslice_dummy_var_35 == 0 || out_vslice_dummy_var_35 == in_vslice_dummy_var_35;
  free ensures out_vslice_dummy_var_36 == 1 || out_vslice_dummy_var_36 == 0 || out_vslice_dummy_var_36 == in_vslice_dummy_var_36;
  free ensures out_vslice_dummy_var_37 == 258 || out_vslice_dummy_var_37 == 0 || out_vslice_dummy_var_37 == in_vslice_dummy_var_37;
  free ensures out_vslice_dummy_var_39 == 0 || out_vslice_dummy_var_39 == -1073741823 || out_vslice_dummy_var_39 == in_vslice_dummy_var_39;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcCommand_sdv_static_function_7_loop_L32(in_Tmp_144: int, in_Padding: int, in_Tmp_147: int, in_Tmp_148: int, in_Command_9: int) returns (out_Tmp_144: int, out_Padding: int, out_Tmp_147: int, out_Tmp_148: int)
{

  entry:
    out_Tmp_144, out_Padding, out_Tmp_147, out_Tmp_148 := in_Tmp_144, in_Padding, in_Tmp_147, in_Tmp_148;
    goto L32, exit;

  exit:
    return;

  L32:
    goto anon45_Else;

  anon45_Else:
    assume {:partition} INTMOD(out_Padding, 4) != 0;
    out_Tmp_148 := out_Padding;
    out_Padding := out_Padding + 1;
    out_Tmp_144 := out_Tmp_148;
    assume {:nonnull} in_Command_9 != 0;
    assume in_Command_9 > 0;
    havoc out_Tmp_147;
    assume {:nonnull} out_Tmp_147 != 0;
    assume out_Tmp_147 > 0;
    Mem_T.INT4[out_Tmp_147 + out_Tmp_144 * 4] := 0;
    goto anon45_Else_dummy;

  anon45_Else_dummy:
    call {:si_unique_call 1436} {:si_old_unique_call 1} out_Tmp_144, out_Padding, out_Tmp_147, out_Tmp_148 := AvcCommand_sdv_static_function_7_loop_L32(out_Tmp_144, out_Padding, out_Tmp_147, out_Tmp_148, in_Command_9);
    return;
}



procedure {:LoopProcedure} AvcCommand_sdv_static_function_7_loop_L32(in_Tmp_144: int, in_Padding: int, in_Tmp_147: int, in_Tmp_148: int, in_Command_9: int) returns (out_Tmp_144: int, out_Padding: int, out_Tmp_147: int, out_Tmp_148: int);
  modifies Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcSearchForUnitCommandHandler_sdv_static_function_7_loop_L27(in_Tmp_153: int, in_max: int, in_Command_10: int, in_idx_4: int, in_Tmp_156: int, in_Opcode_2: int) returns (out_Tmp_153: int, out_idx_4: int, out_Tmp_156: int)
{

  entry:
    out_Tmp_153, out_idx_4, out_Tmp_156 := in_Tmp_153, in_idx_4, in_Tmp_156;
    goto L27, exit;

  exit:
    return;

  L27:
    goto anon21_Else;

  anon21_Else:
    assume {:partition} in_max >= out_idx_4;
    out_Tmp_156 := out_idx_4;
    assume {:nonnull} in_Command_10 != 0;
    assume in_Command_10 > 0;
    havoc out_Tmp_153;
    assume {:nonnull} out_Tmp_153 != 0;
    assume out_Tmp_153 > 0;
    goto anon27_Then;

  anon27_Then:
    assume {:partition} in_Opcode_2 != Mem_T.INT4[out_Tmp_153 + out_Tmp_156 * 4];
    out_idx_4 := out_idx_4 + 1;
    goto anon27_Then_dummy;

  anon27_Then_dummy:
    call {:si_unique_call 1437} {:si_old_unique_call 1} out_Tmp_153, out_idx_4, out_Tmp_156 := AvcSearchForUnitCommandHandler_sdv_static_function_7_loop_L27(out_Tmp_153, in_max, in_Command_10, out_idx_4, out_Tmp_156, in_Opcode_2);
    return;
}



procedure {:LoopProcedure} AvcSearchForUnitCommandHandler_sdv_static_function_7_loop_L27(in_Tmp_153: int, in_max: int, in_Command_10: int, in_idx_4: int, in_Tmp_156: int, in_Opcode_2: int) returns (out_Tmp_153: int, out_idx_4: int, out_Tmp_156: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcSearchForUnitCommandHandler_sdv_static_function_7_loop_L11(in_Tmp_152: int, in_Tmp_153: int, in_max: int, in_Tmp_154: int, in_Command_10: int, in_Entry_2: int, in_idx_4: int, in_OpcodesMatch: int, in_Tmp_156: int, in_Opcode_2: int) returns (out_Tmp_152: int, out_Tmp_153: int, out_max: int, out_Tmp_154: int, out_Command_10: int, out_Entry_2: int, out_idx_4: int, out_OpcodesMatch: int, out_Tmp_156: int)
{

  entry:
    out_Tmp_152, out_Tmp_153, out_max, out_Tmp_154, out_Command_10, out_Entry_2, out_idx_4, out_OpcodesMatch, out_Tmp_156 := in_Tmp_152, in_Tmp_153, in_max, in_Tmp_154, in_Command_10, in_Entry_2, in_idx_4, in_OpcodesMatch, in_Tmp_156;
    goto L11, exit;

  exit:
    return;

  L11:
    goto anon19_Else;

  anon19_Else:
    out_Command_10 := out_Entry_2;
    assume {:nonnull} out_Command_10 != 0;
    assume out_Command_10 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    goto L18;

  L18:
    assume {:nonnull} out_Entry_2 != 0;
    assume out_Entry_2 > 0;
    havoc out_Entry_2;
    goto L18_dummy;

  L18_dummy:
    call {:si_unique_call 1439} {:si_old_unique_call 1} out_Tmp_152, out_Tmp_153, out_max, out_Tmp_154, out_Command_10, out_Entry_2, out_idx_4, out_OpcodesMatch, out_Tmp_156 := AvcSearchForUnitCommandHandler_sdv_static_function_7_loop_L11(out_Tmp_152, out_Tmp_153, out_max, out_Tmp_154, out_Command_10, out_Entry_2, out_idx_4, out_OpcodesMatch, out_Tmp_156, in_Opcode_2);
    return;

  anon24_Then:
    assume {:nonnull} out_Command_10 != 0;
    assume out_Command_10 > 0;
    havoc out_Tmp_154;
    assume {:nonnull} out_Tmp_154 != 0;
    assume out_Tmp_154 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} 255 == Mem_T.INT4[out_Tmp_154];
    out_OpcodesMatch := 0;
    assume {:nonnull} out_Command_10 != 0;
    assume out_Command_10 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:nonnull} out_Command_10 != 0;
    assume out_Command_10 > 0;
    havoc out_Tmp_152;
    assume {:nonnull} out_Tmp_152 != 0;
    assume out_Tmp_152 > 0;
    out_max := Mem_T.INT4[out_Tmp_152];
    out_idx_4 := 1;
    goto L27;

  L27:
    call {:si_unique_call 1438} out_Tmp_153, out_idx_4, out_Tmp_156 := AvcSearchForUnitCommandHandler_sdv_static_function_7_loop_L27(out_Tmp_153, out_max, out_Command_10, out_idx_4, out_Tmp_156, in_Opcode_2);
    goto L27_last;

  L27_last:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} out_max >= out_idx_4;
    out_Tmp_156 := out_idx_4;
    assume {:nonnull} out_Command_10 != 0;
    assume out_Command_10 > 0;
    havoc out_Tmp_153;
    assume {:nonnull} out_Tmp_153 != 0;
    assume out_Tmp_153 > 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} in_Opcode_2 == Mem_T.INT4[out_Tmp_153 + out_Tmp_156 * 4];
    out_OpcodesMatch := 1;
    goto L28;

  L28:
    goto anon22_Then;

  anon22_Then:
    assume {:partition} out_OpcodesMatch == 0;
    goto L18;

  anon27_Then:
    assume {:partition} in_Opcode_2 != Mem_T.INT4[out_Tmp_153 + out_Tmp_156 * 4];
    out_idx_4 := out_idx_4 + 1;
    assume false;
    return;

  anon21_Then:
    assume {:partition} out_idx_4 > out_max;
    goto L28;

  anon26_Then:
    assume {:nonnull} out_Command_10 != 0;
    assume out_Command_10 > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    out_OpcodesMatch := 0;
    goto L74;

  L74:
    goto L28;

  anon20_Then:
    out_OpcodesMatch := 1;
    goto L74;

  anon25_Then:
    assume {:partition} 255 != Mem_T.INT4[out_Tmp_154];
    goto L18;
}



procedure {:LoopProcedure} AvcSearchForUnitCommandHandler_sdv_static_function_7_loop_L11(in_Tmp_152: int, in_Tmp_153: int, in_max: int, in_Tmp_154: int, in_Command_10: int, in_Entry_2: int, in_idx_4: int, in_OpcodesMatch: int, in_Tmp_156: int, in_Opcode_2: int) returns (out_Tmp_152: int, out_Tmp_153: int, out_max: int, out_Tmp_154: int, out_Command_10: int, out_Entry_2: int, out_idx_4: int, out_OpcodesMatch: int, out_Tmp_156: int);
  free ensures out_OpcodesMatch == 1 || out_OpcodesMatch == 0 || out_OpcodesMatch == in_OpcodesMatch;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcDuplicateCommandContext_sdv_static_function_7_loop_L38(in_sdv_95: int, in_Command_11: int, in_Entry_4: int, in_OrigCommand: int, in_vslice_dummy_var_41: int) returns (out_sdv_95: int, out_Entry_4: int, out_vslice_dummy_var_41: int)
{

  entry:
    out_sdv_95, out_Entry_4, out_vslice_dummy_var_41 := in_sdv_95, in_Entry_4, in_vslice_dummy_var_41;
    goto L38, exit;

  exit:
    return;

  L38:
    assume {:nonnull} in_OrigCommand != 0;
    assume in_OrigCommand > 0;
    call {:si_unique_call 1440} out_Entry_4 := RemoveHeadList(CallbackChain__AVC_COMMAND_CONTEXT(in_OrigCommand));
    assume {:nonnull} in_Command_11 != 0;
    assume in_Command_11 > 0;
    call {:si_unique_call 1441} out_vslice_dummy_var_41 := sdv_InsertTailList(CallbackChain__AVC_COMMAND_CONTEXT(in_Command_11), out_Entry_4);
    call {:si_unique_call 1442} out_sdv_95 := sdv_IsListEmpty(0);
    goto anon11_Then;

  anon11_Then:
    assume {:partition} out_sdv_95 == 0;
    goto anon11_Then_dummy;

  anon11_Then_dummy:
    call {:si_unique_call 1443} {:si_old_unique_call 1} out_sdv_95, out_Entry_4, out_vslice_dummy_var_41 := AvcDuplicateCommandContext_sdv_static_function_7_loop_L38(out_sdv_95, in_Command_11, out_Entry_4, in_OrigCommand, out_vslice_dummy_var_41);
    return;
}



procedure {:LoopProcedure} AvcDuplicateCommandContext_sdv_static_function_7_loop_L38(in_sdv_95: int, in_Command_11: int, in_Entry_4: int, in_OrigCommand: int, in_vslice_dummy_var_41: int) returns (out_sdv_95: int, out_Entry_4: int, out_vslice_dummy_var_41: int);
  modifies alloc, Mem_T.INT4;
  free ensures out_sdv_95 == 1 || out_sdv_95 == 0 || out_sdv_95 == in_sdv_95;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcDuplicateCommandContext_sdv_static_function_7_loop_L23(in_Entry_3: int, in_sdv_92: int, in_Command_11: int, in_OrigCommand: int, in_vslice_dummy_var_42: int) returns (out_Entry_3: int, out_sdv_92: int, out_vslice_dummy_var_42: int)
{

  entry:
    out_Entry_3, out_sdv_92, out_vslice_dummy_var_42 := in_Entry_3, in_sdv_92, in_vslice_dummy_var_42;
    goto L23, exit;

  exit:
    return;

  L23:
    call {:si_unique_call 1444} out_sdv_92 := sdv_IsListEmpty(0);
    goto anon9_Else;

  anon9_Else:
    assume {:partition} out_sdv_92 == 0;
    assume {:nonnull} in_OrigCommand != 0;
    assume in_OrigCommand > 0;
    call {:si_unique_call 1445} out_Entry_3 := RemoveHeadList(PendingIrpList__AVC_COMMAND_CONTEXT(in_OrigCommand));
    assume {:nonnull} in_Command_11 != 0;
    assume in_Command_11 > 0;
    call {:si_unique_call 1446} out_vslice_dummy_var_42 := sdv_InsertTailList(PendingIrpList__AVC_COMMAND_CONTEXT(in_Command_11), out_Entry_3);
    goto anon9_Else_dummy;

  anon9_Else_dummy:
    call {:si_unique_call 1447} {:si_old_unique_call 1} out_Entry_3, out_sdv_92, out_vslice_dummy_var_42 := AvcDuplicateCommandContext_sdv_static_function_7_loop_L23(out_Entry_3, out_sdv_92, in_Command_11, in_OrigCommand, out_vslice_dummy_var_42);
    return;
}



procedure {:LoopProcedure} AvcDuplicateCommandContext_sdv_static_function_7_loop_L23(in_Entry_3: int, in_sdv_92: int, in_Command_11: int, in_OrigCommand: int, in_vslice_dummy_var_42: int) returns (out_Entry_3: int, out_sdv_92: int, out_vslice_dummy_var_42: int);
  modifies alloc, Mem_T.INT4;
  free ensures out_sdv_92 == 1 || out_sdv_92 == 0 || out_sdv_92 == in_sdv_92;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcDequeueFCPIrp_loop_L11(in_listEntry: int, in_sdv_109: int, in_oldCancelRoutine: int, in_sdv_111: int, in_nextIrp: int, in_Command_13: int) returns (out_listEntry: int, out_sdv_109: int, out_oldCancelRoutine: int, out_sdv_111: int, out_nextIrp: int)
{

  entry:
    out_listEntry, out_sdv_109, out_oldCancelRoutine, out_sdv_111, out_nextIrp := in_listEntry, in_sdv_109, in_oldCancelRoutine, in_sdv_111, in_nextIrp;
    goto L11, exit;

  exit:
    return;

  L11:
    goto anon7_Then;

  anon7_Then:
    assume {:partition} out_nextIrp == 0;
    call {:si_unique_call 1452} out_sdv_109 := sdv_IsListEmpty(0);
    goto anon8_Else;

  anon8_Else:
    assume {:partition} out_sdv_109 == 0;
    assume {:nonnull} in_Command_13 != 0;
    assume in_Command_13 > 0;
    call {:si_unique_call 1449} out_listEntry := RemoveHeadList(PendingIrpList__AVC_COMMAND_CONTEXT(in_Command_13));
    call {:si_unique_call 1450} out_sdv_111 := sdv_containing_record(out_listEntry, 88);
    out_nextIrp := out_sdv_111;
    call {:si_unique_call 1451} out_oldCancelRoutine := sdv_IoSetCancelRoutine(out_nextIrp, 0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} out_oldCancelRoutine == 0;
    assume {:nonnull} out_nextIrp != 0;
    assume out_nextIrp > 0;
    call {:si_unique_call 1448} InitializeListHead(ListEntry_unnamed_tag_7(Overlay_unnamed_tag_6(Tail__IRP(out_nextIrp))));
    out_nextIrp := 0;
    goto anon9_Else_dummy;

  anon9_Else_dummy:
    goto L_BAF_1;

  L_BAF_1:
    call {:si_unique_call 1453} {:si_old_unique_call 1} out_listEntry, out_sdv_109, out_oldCancelRoutine, out_sdv_111, out_nextIrp := AvcDequeueFCPIrp_loop_L11(out_listEntry, out_sdv_109, out_oldCancelRoutine, out_sdv_111, out_nextIrp, in_Command_13);
    return;

  anon9_Then:
    assume {:partition} out_oldCancelRoutine != 0;
    goto anon9_Then_dummy;

  anon9_Then_dummy:
    goto L_BAF_1;
}



procedure {:LoopProcedure} AvcDequeueFCPIrp_loop_L11(in_listEntry: int, in_sdv_109: int, in_oldCancelRoutine: int, in_sdv_111: int, in_nextIrp: int, in_Command_13: int) returns (out_listEntry: int, out_sdv_109: int, out_oldCancelRoutine: int, out_sdv_111: int, out_nextIrp: int);
  modifies alloc;
  free ensures out_sdv_109 == 1 || out_sdv_109 == 0 || out_sdv_109 == in_sdv_109;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcUnpackSubunitAddress_loop_L15(in_Tmp_188: int, in_idx_8: int, in_Tmp_197: int, in_Tmp_199: int, in_Buffer_3: int, in_SubunitType_2: int) returns (out_Tmp_188: int, out_idx_8: int, out_Tmp_197: int, out_Tmp_199: int)
{

  entry:
    out_Tmp_188, out_idx_8, out_Tmp_197, out_Tmp_199 := in_Tmp_188, in_idx_8, in_Tmp_197, in_Tmp_199;
    goto L15, exit;

  exit:
    return;

  L15:
    out_Tmp_199 := out_idx_8;
    assume {:nonnull} in_Buffer_3 != 0;
    assume in_Buffer_3 > 0;
    goto anon38_Else;

  anon38_Else:
    assume {:partition} Mem_T.INT4[in_Buffer_3 + out_Tmp_199 * 4] == 255;
    out_Tmp_188 := out_idx_8;
    out_Tmp_197 := out_idx_8;
    assume {:nonnull} in_Buffer_3 != 0;
    assume in_Buffer_3 > 0;
    assume {:nonnull} in_SubunitType_2 != 0;
    assume in_SubunitType_2 > 0;
    Mem_T.INT4[in_SubunitType_2 + out_Tmp_188 * 4] := Mem_T.INT4[in_Buffer_3 + out_Tmp_197 * 4];
    out_idx_8 := out_idx_8 + 1;
    goto anon38_Else_dummy;

  anon38_Else_dummy:
    call {:si_unique_call 1454} {:si_old_unique_call 1} out_Tmp_188, out_idx_8, out_Tmp_197, out_Tmp_199 := AvcUnpackSubunitAddress_loop_L15(out_Tmp_188, out_idx_8, out_Tmp_197, out_Tmp_199, in_Buffer_3, in_SubunitType_2);
    return;
}



procedure {:LoopProcedure} AvcUnpackSubunitAddress_loop_L15(in_Tmp_188: int, in_idx_8: int, in_Tmp_197: int, in_Tmp_199: int, in_Buffer_3: int, in_SubunitType_2: int) returns (out_Tmp_188: int, out_idx_8: int, out_Tmp_197: int, out_Tmp_199: int);
  modifies Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcUnpackSubunitAddress_loop_L29(in_Tmp_185: int, in_Tmp_192: int, in_idx_8: int, in_Buffer_3: int, in_SubunitID_1: int) returns (out_Tmp_185: int, out_Tmp_192: int, out_idx_8: int)
{

  entry:
    out_Tmp_185, out_Tmp_192, out_idx_8 := in_Tmp_185, in_Tmp_192, in_idx_8;
    goto L29, exit;

  exit:
    return;

  L29:
    out_Tmp_192 := out_idx_8;
    assume {:nonnull} in_Buffer_3 != 0;
    assume in_Buffer_3 > 0;
    goto anon42_Else;

  anon42_Else:
    assume {:partition} Mem_T.INT4[in_Buffer_3 + out_Tmp_192 * 4] == 255;
    out_Tmp_185 := out_idx_8;
    assume {:nonnull} in_Buffer_3 != 0;
    assume in_Buffer_3 > 0;
    assume {:nonnull} in_SubunitID_1 != 0;
    assume in_SubunitID_1 > 0;
    Mem_T.INT4[in_SubunitID_1] := Mem_T.INT4[in_SubunitID_1] + Mem_T.INT4[in_Buffer_3 + out_Tmp_185 * 4] - 1;
    out_idx_8 := out_idx_8 + 1;
    goto anon42_Else_dummy;

  anon42_Else_dummy:
    call {:si_unique_call 1455} {:si_old_unique_call 1} out_Tmp_185, out_Tmp_192, out_idx_8 := AvcUnpackSubunitAddress_loop_L29(out_Tmp_185, out_Tmp_192, out_idx_8, in_Buffer_3, in_SubunitID_1);
    return;
}



procedure {:LoopProcedure} AvcUnpackSubunitAddress_loop_L29(in_Tmp_185: int, in_Tmp_192: int, in_idx_8: int, in_Buffer_3: int, in_SubunitID_1: int) returns (out_Tmp_185: int, out_Tmp_192: int, out_idx_8: int);
  modifies Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcUnpackSubunitAddress_loop_L38(in_Tmp_191: int, in_idx_8: int, in_Buffer_3: int) returns (out_Tmp_191: int, out_idx_8: int)
{

  entry:
    out_Tmp_191, out_idx_8 := in_Tmp_191, in_idx_8;
    goto L38, exit;

  exit:
    return;

  L38:
    out_Tmp_191 := out_idx_8;
    assume {:nonnull} in_Buffer_3 != 0;
    assume in_Buffer_3 > 0;
    goto anon45_Else;

  anon45_Else:
    assume {:partition} Mem_T.INT4[in_Buffer_3 + out_Tmp_191 * 4] == 255;
    out_idx_8 := out_idx_8 + 1;
    goto anon45_Else_dummy;

  anon45_Else_dummy:
    havoc out_idx_8;
    return;
}



procedure {:LoopProcedure} AvcUnpackSubunitAddress_loop_L38(in_Tmp_191: int, in_idx_8: int, in_Buffer_3: int) returns (out_Tmp_191: int, out_idx_8: int);
  free ensures out_Tmp_191 == in_idx_8 || out_Tmp_191 == in_Tmp_191;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcUnpackSubunitAddress_loop_L43(in_Tmp_187: int, in_idx_8: int, in_Buffer_3: int) returns (out_Tmp_187: int, out_idx_8: int)
{

  entry:
    out_Tmp_187, out_idx_8 := in_Tmp_187, in_idx_8;
    goto L43, exit;

  exit:
    return;

  L43:
    out_Tmp_187 := out_idx_8;
    assume {:nonnull} in_Buffer_3 != 0;
    assume in_Buffer_3 > 0;
    goto anon47_Else;

  anon47_Else:
    assume {:partition} Mem_T.INT4[in_Buffer_3 + out_Tmp_187 * 4] == 255;
    out_idx_8 := out_idx_8 + 1;
    goto anon47_Else_dummy;

  anon47_Else_dummy:
    havoc out_idx_8;
    return;
}



procedure {:LoopProcedure} AvcUnpackSubunitAddress_loop_L43(in_Tmp_187: int, in_idx_8: int, in_Buffer_3: int) returns (out_Tmp_187: int, out_idx_8: int);
  free ensures out_Tmp_187 == in_idx_8 || out_Tmp_187 == in_Tmp_187;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcExtractMatchingIrps_sdv_static_function_7_loop_L11(in_Irp_13: int, in_sdv_113: int, in_IrpStack_4: int, in_oldCancelRoutine_1: int, in_nextIrpEntry: int, in_IrpEntry_1: int, in_FileObject_1: int, in_IrpList: int, in_vslice_dummy_var_45: int, in_vslice_dummy_var_46: int) returns (out_Irp_13: int, out_sdv_113: int, out_IrpStack_4: int, out_oldCancelRoutine_1: int, out_nextIrpEntry: int, out_IrpEntry_1: int, out_vslice_dummy_var_45: int, out_vslice_dummy_var_46: int)
{

  entry:
    out_Irp_13, out_sdv_113, out_IrpStack_4, out_oldCancelRoutine_1, out_nextIrpEntry, out_IrpEntry_1, out_vslice_dummy_var_45, out_vslice_dummy_var_46 := in_Irp_13, in_sdv_113, in_IrpStack_4, in_oldCancelRoutine_1, in_nextIrpEntry, in_IrpEntry_1, in_vslice_dummy_var_45, in_vslice_dummy_var_46;
    goto L11, exit;

  exit:
    return;

  L11:
    goto anon10_Else;

  anon10_Else:
    call {:si_unique_call 1458} out_sdv_113 := sdv_containing_record(out_IrpEntry_1, 88);
    out_Irp_13 := out_sdv_113;
    call {:si_unique_call 1459} out_IrpStack_4 := sdv_IoGetCurrentIrpStackLocation(out_Irp_13);
    assume {:nonnull} out_IrpEntry_1 != 0;
    assume out_IrpEntry_1 > 0;
    havoc out_nextIrpEntry;
    assume {:nonnull} out_IrpStack_4 != 0;
    assume out_IrpStack_4 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    call {:si_unique_call 1460} out_oldCancelRoutine_1 := sdv_IoSetCancelRoutine(out_Irp_13, 0);
    call {:si_unique_call 1461} out_vslice_dummy_var_45 := sdv_RemoveEntryList(0);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} out_oldCancelRoutine_1 != 0;
    call {:si_unique_call 1456} out_vslice_dummy_var_46 := sdv_InsertTailList(in_IrpList, out_IrpEntry_1);
    goto L26;

  L26:
    out_IrpEntry_1 := out_nextIrpEntry;
    goto L26_dummy;

  L26_dummy:
    call {:si_unique_call 1462} {:si_old_unique_call 1} out_Irp_13, out_sdv_113, out_IrpStack_4, out_oldCancelRoutine_1, out_nextIrpEntry, out_IrpEntry_1, out_vslice_dummy_var_45, out_vslice_dummy_var_46 := AvcExtractMatchingIrps_sdv_static_function_7_loop_L11(out_Irp_13, out_sdv_113, out_IrpStack_4, out_oldCancelRoutine_1, out_nextIrpEntry, out_IrpEntry_1, in_FileObject_1, in_IrpList, out_vslice_dummy_var_45, out_vslice_dummy_var_46);
    return;

  anon11_Then:
    assume {:partition} out_oldCancelRoutine_1 == 0;
    call {:si_unique_call 1457} InitializeListHead(out_IrpEntry_1);
    goto L26;

  anon12_Then:
    goto L26;
}



procedure {:LoopProcedure} AvcExtractMatchingIrps_sdv_static_function_7_loop_L11(in_Irp_13: int, in_sdv_113: int, in_IrpStack_4: int, in_oldCancelRoutine_1: int, in_nextIrpEntry: int, in_IrpEntry_1: int, in_FileObject_1: int, in_IrpList: int, in_vslice_dummy_var_45: int, in_vslice_dummy_var_46: int) returns (out_Irp_13: int, out_sdv_113: int, out_IrpStack_4: int, out_oldCancelRoutine_1: int, out_nextIrpEntry: int, out_IrpEntry_1: int, out_vslice_dummy_var_45: int, out_vslice_dummy_var_46: int);
  modifies alloc, Mem_T.INT4;
  free ensures out_vslice_dummy_var_45 == 1 || out_vslice_dummy_var_45 == 0 || out_vslice_dummy_var_45 == in_vslice_dummy_var_45;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcExtractMatchingIrps_sdv_static_function_7_loop_L5(in_Irp_13: int, in_CommandEntry: int, in_sdv_113: int, in_IrpStack_4: int, in_oldCancelRoutine_1: int, in_nextIrpEntry: int, in_Command_14: int, in_IrpEntry_1: int, in_FileObject_1: int, in_IrpList: int, in_vslice_dummy_var_45: int, in_vslice_dummy_var_46: int) returns (out_Irp_13: int, out_CommandEntry: int, out_sdv_113: int, out_IrpStack_4: int, out_oldCancelRoutine_1: int, out_nextIrpEntry: int, out_Command_14: int, out_IrpEntry_1: int, out_vslice_dummy_var_45: int, out_vslice_dummy_var_46: int)
{

  entry:
    out_Irp_13, out_CommandEntry, out_sdv_113, out_IrpStack_4, out_oldCancelRoutine_1, out_nextIrpEntry, out_Command_14, out_IrpEntry_1, out_vslice_dummy_var_45, out_vslice_dummy_var_46 := in_Irp_13, in_CommandEntry, in_sdv_113, in_IrpStack_4, in_oldCancelRoutine_1, in_nextIrpEntry, in_Command_14, in_IrpEntry_1, in_vslice_dummy_var_45, in_vslice_dummy_var_46;
    goto L5, exit;

  exit:
    return;

  L5:
    goto anon9_Else;

  anon9_Else:
    out_Command_14 := out_CommandEntry;
    assume {:nonnull} out_Command_14 != 0;
    assume out_Command_14 > 0;
    havoc out_IrpEntry_1;
    goto L11;

  L11:
    call {:si_unique_call 1463} out_Irp_13, out_sdv_113, out_IrpStack_4, out_oldCancelRoutine_1, out_nextIrpEntry, out_IrpEntry_1, out_vslice_dummy_var_45, out_vslice_dummy_var_46 := AvcExtractMatchingIrps_sdv_static_function_7_loop_L11(out_Irp_13, out_sdv_113, out_IrpStack_4, out_oldCancelRoutine_1, out_nextIrpEntry, out_IrpEntry_1, in_FileObject_1, in_IrpList, out_vslice_dummy_var_45, out_vslice_dummy_var_46);
    goto L11_last;

  L11_last:
    goto anon10_Then, anon10_Else;

  anon10_Else:
    call {:si_unique_call 1466} out_sdv_113 := sdv_containing_record(out_IrpEntry_1, 88);
    out_Irp_13 := out_sdv_113;
    call {:si_unique_call 1467} out_IrpStack_4 := sdv_IoGetCurrentIrpStackLocation(out_Irp_13);
    assume {:nonnull} out_IrpEntry_1 != 0;
    assume out_IrpEntry_1 > 0;
    havoc out_nextIrpEntry;
    assume {:nonnull} out_IrpStack_4 != 0;
    assume out_IrpStack_4 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    call {:si_unique_call 1468} out_oldCancelRoutine_1 := sdv_IoSetCancelRoutine(out_Irp_13, 0);
    call {:si_unique_call 1469} out_vslice_dummy_var_45 := sdv_RemoveEntryList(0);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} out_oldCancelRoutine_1 != 0;
    call {:si_unique_call 1464} out_vslice_dummy_var_46 := sdv_InsertTailList(in_IrpList, out_IrpEntry_1);
    goto L26;

  L26:
    out_IrpEntry_1 := out_nextIrpEntry;
    assume false;
    return;

  anon11_Then:
    assume {:partition} out_oldCancelRoutine_1 == 0;
    call {:si_unique_call 1465} InitializeListHead(out_IrpEntry_1);
    goto L26;

  anon12_Then:
    goto L26;

  anon10_Then:
    assume {:nonnull} out_CommandEntry != 0;
    assume out_CommandEntry > 0;
    havoc out_CommandEntry;
    goto anon10_Then_dummy;

  anon10_Then_dummy:
    call {:si_unique_call 1470} {:si_old_unique_call 1} out_Irp_13, out_CommandEntry, out_sdv_113, out_IrpStack_4, out_oldCancelRoutine_1, out_nextIrpEntry, out_Command_14, out_IrpEntry_1, out_vslice_dummy_var_45, out_vslice_dummy_var_46 := AvcExtractMatchingIrps_sdv_static_function_7_loop_L5(out_Irp_13, out_CommandEntry, out_sdv_113, out_IrpStack_4, out_oldCancelRoutine_1, out_nextIrpEntry, out_Command_14, out_IrpEntry_1, in_FileObject_1, in_IrpList, out_vslice_dummy_var_45, out_vslice_dummy_var_46);
    return;
}



procedure {:LoopProcedure} AvcExtractMatchingIrps_sdv_static_function_7_loop_L5(in_Irp_13: int, in_CommandEntry: int, in_sdv_113: int, in_IrpStack_4: int, in_oldCancelRoutine_1: int, in_nextIrpEntry: int, in_Command_14: int, in_IrpEntry_1: int, in_FileObject_1: int, in_IrpList: int, in_vslice_dummy_var_45: int, in_vslice_dummy_var_46: int) returns (out_Irp_13: int, out_CommandEntry: int, out_sdv_113: int, out_IrpStack_4: int, out_oldCancelRoutine_1: int, out_nextIrpEntry: int, out_Command_14: int, out_IrpEntry_1: int, out_vslice_dummy_var_45: int, out_vslice_dummy_var_46: int);
  modifies alloc, Mem_T.INT4;
  free ensures out_vslice_dummy_var_45 == 1 || out_vslice_dummy_var_45 == 0 || out_vslice_dummy_var_45 == in_vslice_dummy_var_45;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_EnumerateChildren_loop_L15(in_PdoData_3: int) returns (out_PdoData_3: int)
{

  entry:
    out_PdoData_3 := in_PdoData_3;
    goto L15, exit;

  exit:
    return;

  L15:
    goto anon8_Else;

  anon8_Else:
    assume {:nonnull} out_PdoData_3 != 0;
    assume out_PdoData_3 > 0;
    assume {:nonnull} out_PdoData_3 != 0;
    assume out_PdoData_3 > 0;
    havoc out_PdoData_3;
    goto anon8_Else_dummy;

  anon8_Else_dummy:
    call {:si_unique_call 1471} {:si_old_unique_call 1} out_PdoData_3 := Avc_EnumerateChildren_loop_L15(out_PdoData_3);
    return;
}



procedure {:LoopProcedure} Avc_EnumerateChildren_loop_L15(in_PdoData_3: int) returns (out_PdoData_3: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_EnumerateExtrnalChildren_loop_L123(in_Tmp_441: int, in_BytesUsed_5: int, in_SubunitAddrs: int, in_SubunitInfoBytes_1: int, in_Tmp_442: int, in_Tmp_444: int, in_Tmp_445: int, in_ntStatus_18: int, in_StartOffset: int) returns (out_Tmp_441: int, out_SubunitAddrs: int, out_Tmp_442: int, out_Tmp_444: int, out_Tmp_445: int, out_ntStatus_18: int, out_StartOffset: int)
{

  entry:
    out_Tmp_441, out_SubunitAddrs, out_Tmp_442, out_Tmp_444, out_Tmp_445, out_ntStatus_18, out_StartOffset := in_Tmp_441, in_SubunitAddrs, in_Tmp_442, in_Tmp_444, in_Tmp_445, in_ntStatus_18, in_StartOffset;
    goto L123, exit;

  exit:
    return;

  L123:
    assume {:nonnull} in_BytesUsed_5 != 0;
    assume in_BytesUsed_5 > 0;
    Mem_T.INT4[in_BytesUsed_5] := 0;
    out_Tmp_441 := out_StartOffset;
    assume {:nonnull} in_SubunitInfoBytes_1 != 0;
    assume in_SubunitInfoBytes_1 > 0;
    goto anon101_Then;

  anon101_Then:
    assume {:partition} Mem_T.INT4[in_SubunitInfoBytes_1 + out_Tmp_441 * 4] != 255;
    out_Tmp_442 := 32 - out_StartOffset;
    out_Tmp_444 := out_StartOffset;
    out_Tmp_445 := in_SubunitInfoBytes_1 + out_Tmp_444 * 4;
    call {:si_unique_call 1472} out_ntStatus_18 := AvcValidateSubunitAddress(out_Tmp_445, out_Tmp_442, in_BytesUsed_5);
    goto anon92_Then;

  anon92_Then:
    assume {:partition} out_ntStatus_18 == 0;
    assume {:nonnull} in_BytesUsed_5 != 0;
    assume in_BytesUsed_5 > 0;
    out_StartOffset := out_StartOffset + Mem_T.INT4[in_BytesUsed_5];
    out_SubunitAddrs := out_SubunitAddrs + 1;
    goto anon102_Else;

  anon102_Else:
    assume {:partition} INTMOD(out_StartOffset, 4) != 0;
    goto anon102_Else_dummy;

  anon102_Else_dummy:
    call {:si_unique_call 1473} {:si_old_unique_call 1} out_Tmp_441, out_SubunitAddrs, out_Tmp_442, out_Tmp_444, out_Tmp_445, out_ntStatus_18, out_StartOffset := Avc_EnumerateExtrnalChildren_loop_L123(out_Tmp_441, in_BytesUsed_5, out_SubunitAddrs, in_SubunitInfoBytes_1, out_Tmp_442, out_Tmp_444, out_Tmp_445, out_ntStatus_18, out_StartOffset);
    return;
}



procedure {:LoopProcedure} Avc_EnumerateExtrnalChildren_loop_L123(in_Tmp_441: int, in_BytesUsed_5: int, in_SubunitAddrs: int, in_SubunitInfoBytes_1: int, in_Tmp_442: int, in_Tmp_444: int, in_Tmp_445: int, in_ntStatus_18: int, in_StartOffset: int) returns (out_Tmp_441: int, out_SubunitAddrs: int, out_Tmp_442: int, out_Tmp_444: int, out_Tmp_445: int, out_ntStatus_18: int, out_StartOffset: int);
  modifies Mem_T.INT4;
  free ensures out_ntStatus_18 == 0 || out_ntStatus_18 == -1073741811 || out_ntStatus_18 == in_ntStatus_18;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_EnumerateExtrnalChildren_loop_L107(in_Tmp_441: int, in_MorePages: int, in_BytesUsed_5: int, in_SubunitAddrs: int, in_SubunitInfoBytes_1: int, in_Tmp_442: int, in_Tmp_444: int, in_Tmp_445: int, in_Tmp_446: int, in_ntStatus_18: int, in_Command_17: int, in_Tmp_449: int, in_StartOffset: int, in_Tmp_451: int, in_page: int) returns (out_Tmp_441: int, out_MorePages: int, out_SubunitAddrs: int, out_Tmp_442: int, out_Tmp_444: int, out_Tmp_445: int, out_Tmp_446: int, out_ntStatus_18: int, out_Tmp_449: int, out_StartOffset: int, out_Tmp_451: int, out_page: int)
{
  var vslice_dummy_var_109: int;

  entry:
    out_Tmp_441, out_MorePages, out_SubunitAddrs, out_Tmp_442, out_Tmp_444, out_Tmp_445, out_Tmp_446, out_ntStatus_18, out_Tmp_449, out_StartOffset, out_Tmp_451, out_page := in_Tmp_441, in_MorePages, in_SubunitAddrs, in_Tmp_442, in_Tmp_444, in_Tmp_445, in_Tmp_446, in_ntStatus_18, in_Tmp_449, in_StartOffset, in_Tmp_451, in_page;
    goto L107, exit;

  exit:
    return;

  L107:
    goto anon88_Else;

  anon88_Else:
    assume {:partition} out_MorePages != 0;
    goto anon89_Else;

  anon89_Else:
    assume {:partition} 8 > out_page;
    goto anon90_Else;

  anon90_Else:
    assume {:partition} 32 > out_StartOffset;
    assume {:nonnull} in_Command_17 != 0;
    assume in_Command_17 > 0;
    havoc vslice_dummy_var_109;
    call {:si_unique_call 1477} out_ntStatus_18 := AvcReq_SubUnitInfo(vslice_dummy_var_109, out_page);
    goto anon100_Else;

  anon100_Else:
    assume {:partition} yogi_error != 1;
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} out_ntStatus_18 != 0;
    out_MorePages := 0;
    goto L117;

  L117:
    out_page := out_page + 1;
    goto L117_dummy;

  L117_dummy:
    call {:si_unique_call 1478} {:si_old_unique_call 1} out_Tmp_441, out_MorePages, out_SubunitAddrs, out_Tmp_442, out_Tmp_444, out_Tmp_445, out_Tmp_446, out_ntStatus_18, out_Tmp_449, out_StartOffset, out_Tmp_451, out_page := Avc_EnumerateExtrnalChildren_loop_L107(out_Tmp_441, out_MorePages, in_BytesUsed_5, out_SubunitAddrs, in_SubunitInfoBytes_1, out_Tmp_442, out_Tmp_444, out_Tmp_445, out_Tmp_446, out_ntStatus_18, in_Command_17, out_Tmp_449, out_StartOffset, out_Tmp_451, out_page);
    return;

  anon91_Then:
    assume {:partition} out_ntStatus_18 == 0;
    assume {:nonnull} in_Command_17 != 0;
    assume in_Command_17 > 0;
    havoc out_Tmp_451;
    assume {:nonnull} in_Command_17 != 0;
    assume in_Command_17 > 0;
    havoc out_Tmp_449;
    out_Tmp_446 := out_page * 4;
    call {:si_unique_call 1476} sdv_RtlCopyMemory(0, 0, 4);
    goto L123;

  L123:
    call {:si_unique_call 1475} out_Tmp_441, out_SubunitAddrs, out_Tmp_442, out_Tmp_444, out_Tmp_445, out_ntStatus_18, out_StartOffset := Avc_EnumerateExtrnalChildren_loop_L123(out_Tmp_441, in_BytesUsed_5, out_SubunitAddrs, in_SubunitInfoBytes_1, out_Tmp_442, out_Tmp_444, out_Tmp_445, out_ntStatus_18, out_StartOffset);
    goto L123_last;

  L123_last:
    assume {:nonnull} in_BytesUsed_5 != 0;
    assume in_BytesUsed_5 > 0;
    Mem_T.INT4[in_BytesUsed_5] := 0;
    out_Tmp_441 := out_StartOffset;
    assume {:nonnull} in_SubunitInfoBytes_1 != 0;
    assume in_SubunitInfoBytes_1 > 0;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume {:partition} Mem_T.INT4[in_SubunitInfoBytes_1 + out_Tmp_441 * 4] == 255;
    out_MorePages := 0;
    goto L117;

  anon101_Then:
    assume {:partition} Mem_T.INT4[in_SubunitInfoBytes_1 + out_Tmp_441 * 4] != 255;
    out_Tmp_442 := 32 - out_StartOffset;
    out_Tmp_444 := out_StartOffset;
    out_Tmp_445 := in_SubunitInfoBytes_1 + out_Tmp_444 * 4;
    call {:si_unique_call 1474} out_ntStatus_18 := AvcValidateSubunitAddress(out_Tmp_445, out_Tmp_442, in_BytesUsed_5);
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} out_ntStatus_18 != 0;
    assume {:nonnull} in_BytesUsed_5 != 0;
    assume in_BytesUsed_5 > 0;
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} INTMOD(out_StartOffset + Mem_T.INT4[in_BytesUsed_5], 4) != 0;
    out_MorePages := 0;
    goto L117;

  anon93_Then:
    assume {:partition} INTMOD(out_StartOffset + Mem_T.INT4[in_BytesUsed_5], 4) == 0;
    goto L117;

  anon92_Then:
    assume {:partition} out_ntStatus_18 == 0;
    assume {:nonnull} in_BytesUsed_5 != 0;
    assume in_BytesUsed_5 > 0;
    out_StartOffset := out_StartOffset + Mem_T.INT4[in_BytesUsed_5];
    out_SubunitAddrs := out_SubunitAddrs + 1;
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume {:partition} INTMOD(out_StartOffset, 4) != 0;
    assume false;
    return;

  anon102_Then:
    assume {:partition} INTMOD(out_StartOffset, 4) == 0;
    goto L117;
}



procedure {:LoopProcedure} Avc_EnumerateExtrnalChildren_loop_L107(in_Tmp_441: int, in_MorePages: int, in_BytesUsed_5: int, in_SubunitAddrs: int, in_SubunitInfoBytes_1: int, in_Tmp_442: int, in_Tmp_444: int, in_Tmp_445: int, in_Tmp_446: int, in_ntStatus_18: int, in_Command_17: int, in_Tmp_449: int, in_StartOffset: int, in_Tmp_451: int, in_page: int) returns (out_Tmp_441: int, out_MorePages: int, out_SubunitAddrs: int, out_Tmp_442: int, out_Tmp_444: int, out_Tmp_445: int, out_Tmp_446: int, out_ntStatus_18: int, out_Tmp_449: int, out_StartOffset: int, out_Tmp_451: int, out_page: int);
  modifies Mem_T.INT4, alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures out_MorePages == 0 || out_MorePages == in_MorePages;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_EnumerateExtrnalChildren_loop_L52(in_SubunitID_2: int, in_SubunitAddr_5: int, in_ntStatus_18: int, in_MaxSubunitID: int, in_SubunitType_3: int, in_BusExtension_9: int) returns (out_SubunitID_2: int, out_ntStatus_18: int)
{

  entry:
    out_SubunitID_2, out_ntStatus_18 := in_SubunitID_2, in_ntStatus_18;
    goto L52, exit;

  exit:
    return;

  L52:
    assume {:nonnull} in_MaxSubunitID != 0;
    assume in_MaxSubunitID > 0;
    goto anon79_Else;

  anon79_Else:
    assume {:partition} Mem_T.INT4[in_MaxSubunitID] >= out_SubunitID_2;
    call {:si_unique_call 1479} out_ntStatus_18 := AvcPackSubunitAddress(in_SubunitType_3, out_SubunitID_2, 32, in_SubunitAddr_5, 0);
    call {:si_unique_call 1480} Avc_FindOrCreatePDO(in_BusExtension_9, in_SubunitAddr_5, 3);
    goto anon98_Else;

  anon98_Else:
    assume {:partition} yogi_error != 1;
    out_SubunitID_2 := out_SubunitID_2 + 1;
    goto anon98_Else_dummy;

  anon98_Else_dummy:
    call {:si_unique_call 1481} {:si_old_unique_call 1} out_SubunitID_2, out_ntStatus_18 := Avc_EnumerateExtrnalChildren_loop_L52(out_SubunitID_2, in_SubunitAddr_5, out_ntStatus_18, in_MaxSubunitID, in_SubunitType_3, in_BusExtension_9);
    return;
}



procedure {:LoopProcedure} Avc_EnumerateExtrnalChildren_loop_L52(in_SubunitID_2: int, in_SubunitAddr_5: int, in_ntStatus_18: int, in_MaxSubunitID: int, in_SubunitType_3: int, in_BusExtension_9: int) returns (out_SubunitID_2: int, out_ntStatus_18: int);
  modifies Mem_T.INT4, alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures out_ntStatus_18 == 0 || out_ntStatus_18 == -1073741811 || out_ntStatus_18 == in_ntStatus_18;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_EnumerateExtrnalChildren_loop_L30(in_SubunitID_2: int, in_SubunitAddr_5: int, in_SubunitAddrs: int, in_SubunitInfoBytes_1: int, in_Tmp_443: int, in_ntStatus_18: int, in_Tmp_447: int, in_MaxSubunitID: int, in_SubunitType_3: int, in_BytesUsed_6: int, in_HasSingleCameraSubunit: int, in_HasSingleTapeSubunit: int, in_StartOffset: int, in_BusExtension_9: int) returns (out_SubunitID_2: int, out_SubunitAddrs: int, out_Tmp_443: int, out_ntStatus_18: int, out_Tmp_447: int, out_HasSingleCameraSubunit: int, out_HasSingleTapeSubunit: int, out_StartOffset: int)
{

  entry:
    out_SubunitID_2, out_SubunitAddrs, out_Tmp_443, out_ntStatus_18, out_Tmp_447, out_HasSingleCameraSubunit, out_HasSingleTapeSubunit, out_StartOffset := in_SubunitID_2, in_SubunitAddrs, in_Tmp_443, in_ntStatus_18, in_Tmp_447, in_HasSingleCameraSubunit, in_HasSingleTapeSubunit, in_StartOffset;
    goto L30, exit;

  exit:
    return;

  L30:
    goto anon72_Else;

  anon72_Else:
    assume {:partition} out_SubunitAddrs != 0;
    out_Tmp_447 := out_StartOffset;
    out_Tmp_443 := in_SubunitInfoBytes_1 + out_Tmp_447 * 4;
    call {:si_unique_call 1482} out_ntStatus_18 := AvcUnpackSubunitAddress(out_Tmp_443, in_SubunitType_3, in_MaxSubunitID, in_BytesUsed_6);
    goto anon74_Else;

  anon74_Else:
    assume {:partition} out_ntStatus_18 == 0;
    assume {:nonnull} in_SubunitType_3 != 0;
    assume in_SubunitType_3 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} Mem_T.INT4[in_SubunitType_3] == 4;
    assume {:nonnull} in_MaxSubunitID != 0;
    assume in_MaxSubunitID > 0;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} Mem_T.INT4[in_MaxSubunitID] == 0;
    out_HasSingleTapeSubunit := 1;
    goto L46;

  L46:
    assume {:nonnull} in_BytesUsed_6 != 0;
    assume in_BytesUsed_6 > 0;
    out_StartOffset := out_StartOffset + Mem_T.INT4[in_BytesUsed_6];
    out_SubunitAddrs := out_SubunitAddrs - 1;
    goto L46_dummy;

  L46_dummy:
    call {:si_unique_call 1486} {:si_old_unique_call 1} out_SubunitID_2, out_SubunitAddrs, out_Tmp_443, out_ntStatus_18, out_Tmp_447, out_HasSingleCameraSubunit, out_HasSingleTapeSubunit, out_StartOffset := Avc_EnumerateExtrnalChildren_loop_L30(out_SubunitID_2, in_SubunitAddr_5, out_SubunitAddrs, in_SubunitInfoBytes_1, out_Tmp_443, out_ntStatus_18, out_Tmp_447, in_MaxSubunitID, in_SubunitType_3, in_BytesUsed_6, out_HasSingleCameraSubunit, out_HasSingleTapeSubunit, out_StartOffset, in_BusExtension_9);
    return;

  anon77_Then:
    assume {:partition} Mem_T.INT4[in_MaxSubunitID] != 0;
    goto L43;

  L43:
    assume {:nonnull} in_SubunitType_3 != 0;
    assume in_SubunitType_3 > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} Mem_T.INT4[in_SubunitType_3] != 7;
    goto L51;

  L51:
    out_SubunitID_2 := 0;
    goto L52;

  L52:
    call {:si_unique_call 1483} out_SubunitID_2, out_ntStatus_18 := Avc_EnumerateExtrnalChildren_loop_L52(out_SubunitID_2, in_SubunitAddr_5, out_ntStatus_18, in_MaxSubunitID, in_SubunitType_3, in_BusExtension_9);
    goto L52_last;

  L52_last:
    assume {:nonnull} in_MaxSubunitID != 0;
    assume in_MaxSubunitID > 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} Mem_T.INT4[in_MaxSubunitID] >= out_SubunitID_2;
    call {:si_unique_call 1484} out_ntStatus_18 := AvcPackSubunitAddress(in_SubunitType_3, out_SubunitID_2, 32, in_SubunitAddr_5, 0);
    call {:si_unique_call 1485} Avc_FindOrCreatePDO(in_BusExtension_9, in_SubunitAddr_5, 3);
    goto anon98_Else;

  anon98_Else:
    assume {:partition} yogi_error != 1;
    out_SubunitID_2 := out_SubunitID_2 + 1;
    assume false;
    return;

  anon79_Then:
    assume {:partition} out_SubunitID_2 > Mem_T.INT4[in_MaxSubunitID];
    goto L46;

  anon76_Then:
    assume {:partition} Mem_T.INT4[in_SubunitType_3] == 7;
    assume {:nonnull} in_MaxSubunitID != 0;
    assume in_MaxSubunitID > 0;
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} Mem_T.INT4[in_MaxSubunitID] != 0;
    goto L51;

  anon78_Then:
    assume {:partition} Mem_T.INT4[in_MaxSubunitID] == 0;
    out_HasSingleCameraSubunit := 1;
    goto L46;

  anon75_Then:
    assume {:partition} Mem_T.INT4[in_SubunitType_3] != 4;
    goto L43;
}



procedure {:LoopProcedure} Avc_EnumerateExtrnalChildren_loop_L30(in_SubunitID_2: int, in_SubunitAddr_5: int, in_SubunitAddrs: int, in_SubunitInfoBytes_1: int, in_Tmp_443: int, in_ntStatus_18: int, in_Tmp_447: int, in_MaxSubunitID: int, in_SubunitType_3: int, in_BytesUsed_6: int, in_HasSingleCameraSubunit: int, in_HasSingleTapeSubunit: int, in_StartOffset: int, in_BusExtension_9: int) returns (out_SubunitID_2: int, out_SubunitAddrs: int, out_Tmp_443: int, out_ntStatus_18: int, out_Tmp_447: int, out_HasSingleCameraSubunit: int, out_HasSingleTapeSubunit: int, out_StartOffset: int);
  modifies Mem_T.INT4, alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures out_ntStatus_18 == 0 || out_ntStatus_18 == -1073741811 || out_ntStatus_18 == in_ntStatus_18;
  free ensures out_HasSingleCameraSubunit == 1 || out_HasSingleCameraSubunit == in_HasSingleCameraSubunit;
  free ensures out_HasSingleTapeSubunit == 1 || out_HasSingleTapeSubunit == in_HasSingleTapeSubunit;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_EnumerateExtrnalChildren_loop_L91(in_PdoData_4: int) returns (out_PdoData_4: int)
{

  entry:
    out_PdoData_4 := in_PdoData_4;
    goto L91, exit;

  exit:
    return;

  L91:
    goto anon86_Else;

  anon86_Else:
    assume {:nonnull} out_PdoData_4 != 0;
    assume out_PdoData_4 > 0;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:nonnull} out_PdoData_4 != 0;
    assume out_PdoData_4 > 0;
    goto L96;

  L96:
    assume {:nonnull} out_PdoData_4 != 0;
    assume out_PdoData_4 > 0;
    havoc out_PdoData_4;
    goto L96_dummy;

  L96_dummy:
    call {:si_unique_call 1487} {:si_old_unique_call 1} out_PdoData_4 := Avc_EnumerateExtrnalChildren_loop_L91(out_PdoData_4);
    return;

  anon87_Then:
    goto L96;
}



procedure {:LoopProcedure} Avc_EnumerateExtrnalChildren_loop_L91(in_PdoData_4: int) returns (out_PdoData_4: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_BuildIds_loop_L441(in_Tmp_484: int, in_SubunitAddrLen_1: int, in_Tmp_500: int, in_Tmp_502: int, in_idx_9: int, in_SubunitType_4: int, in_Tmp_511: int, in_vslice_dummy_var_139: int, in_vslice_dummy_var_140: int, in_vslice_dummy_var_210: int, in_vslice_dummy_var_211: int, in_vslice_dummy_var_212: int) returns (out_Tmp_484: int, out_Tmp_500: int, out_Tmp_502: int, out_idx_9: int, out_Tmp_511: int, out_vslice_dummy_var_139: int, out_vslice_dummy_var_140: int, out_vslice_dummy_var_210: int, out_vslice_dummy_var_211: int, out_vslice_dummy_var_212: int)
{

  entry:
    out_Tmp_484, out_Tmp_500, out_Tmp_502, out_idx_9, out_Tmp_511, out_vslice_dummy_var_139, out_vslice_dummy_var_140, out_vslice_dummy_var_210, out_vslice_dummy_var_211, out_vslice_dummy_var_212 := in_Tmp_484, in_Tmp_500, in_Tmp_502, in_idx_9, in_Tmp_511, in_vslice_dummy_var_139, in_vslice_dummy_var_140, in_vslice_dummy_var_210, in_vslice_dummy_var_211, in_vslice_dummy_var_212;
    goto L441, exit;

  exit:
    return;

  L441:
    assume {:nonnull} in_SubunitAddrLen_1 != 0;
    assume in_SubunitAddrLen_1 > 0;
    goto anon190_Else;

  anon190_Else:
    assume {:partition} Mem_T.INT4[in_SubunitAddrLen_1] > out_idx_9;
    goto anon191_Then, anon191_Else;

  anon191_Else:
    assume {:partition} out_idx_9 != 0;
    call {:si_unique_call 1488} out_Tmp_484 := corral_nondet();
    call {:si_unique_call 1489} out_vslice_dummy_var_210 := RtlIntegerToUnicodeString(out_Tmp_484, 16, 0);
    call {:si_unique_call 1490} out_vslice_dummy_var_139 := corral_nondet();
    out_Tmp_502 := out_idx_9;
    assume {:nonnull} in_SubunitType_4 != 0;
    assume in_SubunitType_4 > 0;
    out_Tmp_511 := BAND(Mem_T.INT4[in_SubunitType_4 + out_Tmp_502 * 4], BOR(BOR(BOR(1, 2), 4), 8));
    call {:si_unique_call 1491} out_vslice_dummy_var_211 := RtlIntegerToUnicodeString(out_Tmp_511, 16, 0);
    call {:si_unique_call 1492} out_vslice_dummy_var_140 := corral_nondet();
    goto L461;

  L461:
    out_idx_9 := out_idx_9 + 1;
    goto L461_dummy;

  L461_dummy:
    havoc out_idx_9;
    return;

  anon191_Then:
    assume {:partition} out_idx_9 == 0;
    assume {:nonnull} in_SubunitType_4 != 0;
    assume in_SubunitType_4 > 0;
    out_Tmp_500 := Mem_T.INT4[in_SubunitType_4];
    call {:si_unique_call 1493} out_vslice_dummy_var_212 := RtlIntegerToUnicodeString(out_Tmp_500, 16, 0);
    goto L461;
}



procedure {:LoopProcedure} Avc_BuildIds_loop_L441(in_Tmp_484: int, in_SubunitAddrLen_1: int, in_Tmp_500: int, in_Tmp_502: int, in_idx_9: int, in_SubunitType_4: int, in_Tmp_511: int, in_vslice_dummy_var_139: int, in_vslice_dummy_var_140: int, in_vslice_dummy_var_210: int, in_vslice_dummy_var_211: int, in_vslice_dummy_var_212: int) returns (out_Tmp_484: int, out_Tmp_500: int, out_Tmp_502: int, out_idx_9: int, out_Tmp_511: int, out_vslice_dummy_var_139: int, out_vslice_dummy_var_140: int, out_vslice_dummy_var_210: int, out_vslice_dummy_var_211: int, out_vslice_dummy_var_212: int);
  free ensures out_Tmp_502 == in_idx_9 || out_Tmp_502 == in_Tmp_502;
  free ensures out_vslice_dummy_var_210 == 0 || out_vslice_dummy_var_210 == -1073741823 || out_vslice_dummy_var_210 == in_vslice_dummy_var_210;
  free ensures out_vslice_dummy_var_211 == 0 || out_vslice_dummy_var_211 == -1073741823 || out_vslice_dummy_var_211 == in_vslice_dummy_var_211;
  free ensures out_vslice_dummy_var_212 == 0 || out_vslice_dummy_var_212 == -1073741823 || out_vslice_dummy_var_212 == in_vslice_dummy_var_212;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_FindOrCreatePDO_loop_L13(in_PdoData_6: int, in_sdv_335: int, in_Entry_8: int, in_SubunitAddr_9: int) returns (out_PdoData_6: int, out_sdv_335: int, out_Entry_8: int)
{
  var vslice_dummy_var_110: int;

  entry:
    out_PdoData_6, out_sdv_335, out_Entry_8 := in_PdoData_6, in_sdv_335, in_Entry_8;
    goto L13, exit;

  exit:
    return;

  L13:
    goto anon45_Else;

  anon45_Else:
    out_PdoData_6 := out_Entry_8;
    assume {:nonnull} out_PdoData_6 != 0;
    assume out_PdoData_6 > 0;
    havoc vslice_dummy_var_110;
    call {:si_unique_call 1494} out_sdv_335 := AvcSubunitAddrsEqual(in_SubunitAddr_9, vslice_dummy_var_110);
    goto anon47_Else;

  anon47_Else:
    assume {:partition} out_sdv_335 == 0;
    out_PdoData_6 := 0;
    assume {:nonnull} out_Entry_8 != 0;
    assume out_Entry_8 > 0;
    havoc out_Entry_8;
    goto anon47_Else_dummy;

  anon47_Else_dummy:
    call {:si_unique_call 1495} {:si_old_unique_call 1} out_PdoData_6, out_sdv_335, out_Entry_8 := Avc_FindOrCreatePDO_loop_L13(out_PdoData_6, out_sdv_335, out_Entry_8, in_SubunitAddr_9);
    return;
}



procedure {:LoopProcedure} Avc_FindOrCreatePDO_loop_L13(in_PdoData_6: int, in_sdv_335: int, in_Entry_8: int, in_SubunitAddr_9: int) returns (out_PdoData_6: int, out_sdv_335: int, out_Entry_8: int);
  free ensures out_PdoData_6 == 0 || out_PdoData_6 == in_PdoData_6;
  free ensures out_sdv_335 == 1 || out_sdv_335 == 0 || out_sdv_335 == in_sdv_335;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_FDO_Pnp_loop_L52(in_PdoData_7: int, in_BusExtension_15: int, in_Next: int) returns (out_PdoData_7: int, out_Next: int)
{

  entry:
    out_PdoData_7, out_Next := in_PdoData_7, in_Next;
    goto L52, exit;

  exit:
    return;

  L52:
    goto anon126_Else;

  anon126_Else:
    out_PdoData_7 := out_Next;
    assume {:nonnull} out_Next != 0;
    assume out_Next > 0;
    havoc out_Next;
    call {:si_unique_call 1496} AvcRemoveFromPdoList(in_BusExtension_15, out_PdoData_7);
    assume {:nonnull} out_PdoData_7 != 0;
    assume out_PdoData_7 > 0;
    assume {:nonnull} out_PdoData_7 != 0;
    assume out_PdoData_7 > 0;
    goto anon126_Else_dummy;

  anon126_Else_dummy:
    call {:si_unique_call 1497} {:si_old_unique_call 1} out_PdoData_7, out_Next := Avc_FDO_Pnp_loop_L52(out_PdoData_7, in_BusExtension_15, out_Next);
    return;
}



procedure {:LoopProcedure} Avc_FDO_Pnp_loop_L52(in_PdoData_7: int, in_BusExtension_15: int, in_Next: int) returns (out_PdoData_7: int, out_Next: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_FDO_Pnp_loop_L144(in_Relations: int, in_cObjects: int, in_Tmp_548: int, in_Tmp_551: int, in_Tmp_558: int, in_Tmp_559: int, in_PdoData_9: int, in_vslice_dummy_var_227: int) returns (out_cObjects: int, out_Tmp_548: int, out_Tmp_551: int, out_Tmp_558: int, out_Tmp_559: int, out_PdoData_9: int, out_vslice_dummy_var_227: int)
{

  entry:
    out_cObjects, out_Tmp_548, out_Tmp_551, out_Tmp_558, out_Tmp_559, out_PdoData_9, out_vslice_dummy_var_227 := in_cObjects, in_Tmp_548, in_Tmp_551, in_Tmp_558, in_Tmp_559, in_PdoData_9, in_vslice_dummy_var_227;
    goto L144, exit;

  exit:
    return;

  L144:
    goto anon136_Else;

  anon136_Else:
    assume {:nonnull} out_PdoData_9 != 0;
    assume out_PdoData_9 > 0;
    goto anon137_Then, anon137_Else;

  anon137_Else:
    assume {:nonnull} out_PdoData_9 != 0;
    assume out_PdoData_9 > 0;
    goto anon138_Then, anon138_Else;

  anon138_Else:
    out_Tmp_551 := out_cObjects;
    assume {:nonnull} in_Relations != 0;
    assume in_Relations > 0;
    havoc out_Tmp_548;
    assume {:nonnull} out_PdoData_9 != 0;
    assume out_PdoData_9 > 0;
    assume {:nonnull} out_Tmp_548 != 0;
    assume out_Tmp_548 > 0;
    out_Tmp_558 := out_cObjects;
    assume {:nonnull} in_Relations != 0;
    assume in_Relations > 0;
    havoc out_Tmp_559;
    assume {:nonnull} out_Tmp_559 != 0;
    assume out_Tmp_559 > 0;
    call {:si_unique_call 1498} out_vslice_dummy_var_227 := sdv_ObReferenceObject(0);
    out_cObjects := out_cObjects + 1;
    goto L147;

  L147:
    assume {:nonnull} out_PdoData_9 != 0;
    assume out_PdoData_9 > 0;
    havoc out_PdoData_9;
    goto L147_dummy;

  L147_dummy:
    call {:si_unique_call 1499} {:si_old_unique_call 1} out_cObjects, out_Tmp_548, out_Tmp_551, out_Tmp_558, out_Tmp_559, out_PdoData_9, out_vslice_dummy_var_227 := Avc_FDO_Pnp_loop_L144(in_Relations, out_cObjects, out_Tmp_548, out_Tmp_551, out_Tmp_558, out_Tmp_559, out_PdoData_9, out_vslice_dummy_var_227);
    return;

  anon138_Then:
    goto L147;

  anon137_Then:
    goto L147;
}



procedure {:LoopProcedure} Avc_FDO_Pnp_loop_L144(in_Relations: int, in_cObjects: int, in_Tmp_548: int, in_Tmp_551: int, in_Tmp_558: int, in_Tmp_559: int, in_PdoData_9: int, in_vslice_dummy_var_227: int) returns (out_cObjects: int, out_Tmp_548: int, out_Tmp_551: int, out_Tmp_558: int, out_Tmp_559: int, out_PdoData_9: int, out_vslice_dummy_var_227: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_FDO_Pnp_loop_L140(in_Relations: int, in_Tmp_545: int, in_cObjects: int, in_cIncomingObjects: int, in_Tmp_552: int, in_Tmp_555: int, in_Tmp_557: int, in_OldRelations: int) returns (out_Tmp_545: int, out_cObjects: int, out_Tmp_552: int, out_Tmp_555: int, out_Tmp_557: int)
{

  entry:
    out_Tmp_545, out_cObjects, out_Tmp_552, out_Tmp_555, out_Tmp_557 := in_Tmp_545, in_cObjects, in_Tmp_552, in_Tmp_555, in_Tmp_557;
    goto L140, exit;

  exit:
    return;

  L140:
    goto anon135_Else;

  anon135_Else:
    assume {:partition} in_cIncomingObjects > out_cObjects;
    out_Tmp_555 := out_cObjects;
    assume {:nonnull} in_Relations != 0;
    assume in_Relations > 0;
    havoc out_Tmp_557;
    out_Tmp_545 := out_cObjects;
    assume {:nonnull} in_OldRelations != 0;
    assume in_OldRelations > 0;
    havoc out_Tmp_552;
    assume {:nonnull} out_Tmp_552 != 0;
    assume out_Tmp_552 > 0;
    assume {:nonnull} out_Tmp_557 != 0;
    assume out_Tmp_557 > 0;
    out_cObjects := out_cObjects + 1;
    goto anon135_Else_dummy;

  anon135_Else_dummy:
    call {:si_unique_call 1500} {:si_old_unique_call 1} out_Tmp_545, out_cObjects, out_Tmp_552, out_Tmp_555, out_Tmp_557 := Avc_FDO_Pnp_loop_L140(in_Relations, out_Tmp_545, out_cObjects, in_cIncomingObjects, out_Tmp_552, out_Tmp_555, out_Tmp_557, in_OldRelations);
    return;
}



procedure {:LoopProcedure} Avc_FDO_Pnp_loop_L140(in_Relations: int, in_Tmp_545: int, in_cObjects: int, in_cIncomingObjects: int, in_Tmp_552: int, in_Tmp_555: int, in_Tmp_557: int, in_OldRelations: int) returns (out_Tmp_545: int, out_cObjects: int, out_Tmp_552: int, out_Tmp_555: int, out_Tmp_557: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_FDO_Pnp_loop_L121(in_cObjects: int, in_PdoData_9: int) returns (out_cObjects: int, out_PdoData_9: int)
{

  entry:
    out_cObjects, out_PdoData_9 := in_cObjects, in_PdoData_9;
    goto L121, exit;

  exit:
    return;

  L121:
    goto anon133_Else;

  anon133_Else:
    assume {:nonnull} out_PdoData_9 != 0;
    assume out_PdoData_9 > 0;
    goto anon134_Then, anon134_Else;

  anon134_Else:
    out_cObjects := out_cObjects + 1;
    goto L124;

  L124:
    assume {:nonnull} out_PdoData_9 != 0;
    assume out_PdoData_9 > 0;
    havoc out_PdoData_9;
    goto L124_dummy;

  L124_dummy:
    call {:si_unique_call 1501} {:si_old_unique_call 1} out_cObjects, out_PdoData_9 := Avc_FDO_Pnp_loop_L121(out_cObjects, out_PdoData_9);
    return;

  anon134_Then:
    goto L124;
}



procedure {:LoopProcedure} Avc_FDO_Pnp_loop_L121(in_cObjects: int, in_PdoData_9: int) returns (out_cObjects: int, out_PdoData_9: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation Avc_FDO_Pnp_loop_L182(in_PdoData_8: int, in_sdv_357: int, in_PdoExtension_1: int, in_sdv_363: int, in_BusExtension_15: int, in_Tmp_560: int) returns (out_PdoData_8: int, out_sdv_357: int, out_PdoExtension_1: int, out_sdv_363: int, out_Tmp_560: int)
{

  entry:
    out_PdoData_8, out_sdv_357, out_PdoExtension_1, out_sdv_363, out_Tmp_560 := in_PdoData_8, in_sdv_357, in_PdoExtension_1, in_sdv_363, in_Tmp_560;
    goto L182, exit;

  exit:
    return;

  L182:
    call {:si_unique_call 1502} out_sdv_357 := sdv_IsListEmpty(0);
    goto anon139_Else;

  anon139_Else:
    assume {:partition} out_sdv_357 == 0;
    assume {:nonnull} in_BusExtension_15 != 0;
    assume in_BusExtension_15 > 0;
    call {:si_unique_call 1510} out_sdv_363 := RemoveHeadList(PdoList__BUS_DEVICE_EXTENSION(in_BusExtension_15));
    out_PdoData_8 := out_sdv_363;
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    havoc out_Tmp_560;
    assume {:nonnull} out_Tmp_560 != 0;
    assume out_Tmp_560 > 0;
    havoc out_PdoExtension_1;
    assume {:nonnull} out_PdoExtension_1 != 0;
    assume out_PdoExtension_1 > 0;
    goto anon175_Then, anon175_Else;

  anon175_Else:
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    call {:si_unique_call 1509} RemoveConnectionMgr(out_PdoData_8);
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    goto anon141_Then, anon141_Else;

  anon141_Else:
    call {:si_unique_call 1508} sdv_ExFreePool(0);
    goto L229;

  L229:
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    goto anon142_Then, anon142_Else;

  anon142_Else:
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    call {:si_unique_call 1507} sdv_ExFreePool(0);
    goto L233;

  L233:
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    goto anon143_Then, anon143_Else;

  anon143_Else:
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    call {:si_unique_call 1506} sdv_ExFreePool(0);
    goto L237;

  L237:
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    goto anon144_Then, anon144_Else;

  anon144_Else:
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    call {:si_unique_call 1505} sdv_ExFreePool(0);
    goto L241;

  L241:
    call {:si_unique_call 1503} sdv_ExFreePool(0);
    assume {:nonnull} out_PdoExtension_1 != 0;
    assume out_PdoExtension_1 > 0;
    call {:si_unique_call 1504} IoDeleteDevice(0);
    goto L241_dummy;

  L241_dummy:
    goto L_BAF_2;

  L_BAF_2:
    call {:si_unique_call 1512} {:si_old_unique_call 1} out_PdoData_8, out_sdv_357, out_PdoExtension_1, out_sdv_363, out_Tmp_560 := Avc_FDO_Pnp_loop_L182(out_PdoData_8, out_sdv_357, out_PdoExtension_1, out_sdv_363, in_BusExtension_15, out_Tmp_560);
    return;

  anon144_Then:
    goto L241;

  anon143_Then:
    goto L237;

  anon142_Then:
    goto L233;

  anon141_Then:
    goto L229;

  anon175_Then:
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    call {:si_unique_call 1511} InitializeListHead(PdoList__PDO_DATA(out_PdoData_8));
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    assume {:nonnull} out_PdoData_8 != 0;
    assume out_PdoData_8 > 0;
    goto anon175_Then_dummy;

  anon175_Then_dummy:
    goto L_BAF_2;
}



procedure {:LoopProcedure} Avc_FDO_Pnp_loop_L182(in_PdoData_8: int, in_sdv_357: int, in_PdoExtension_1: int, in_sdv_363: int, in_BusExtension_15: int, in_Tmp_560: int) returns (out_PdoData_8: int, out_sdv_357: int, out_PdoExtension_1: int, out_sdv_363: int, out_Tmp_560: int);
  modifies alloc;
  free ensures out_sdv_357 == 1 || out_sdv_357 == 0 || out_sdv_357 == in_sdv_357;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation RtlLargeIntegerToUnicodeString_loop_L29(in_Value_1: int, in_Mask: int, in_Tmp_564: int, in_ptr: int, in_Tmp_567: int) returns (out_Value_1: int, out_Tmp_564: int, out_Tmp_567: int)
{
  var vslice_dummy_var_111: int;

  entry:
    out_Value_1, out_Tmp_564, out_Tmp_567 := in_Value_1, in_Tmp_564, in_Tmp_567;
    goto L29, exit;

  exit:
    return;

  L29:
    out_Tmp_564 := BAND(out_Value_1, in_Mask);
    out_Tmp_567 := out_Tmp_564;
    assume {:nonnull} in_ptr != 0;
    assume in_ptr > 0;
    havoc vslice_dummy_var_111;
    Mem_T.INT4[in_ptr] := vslice_dummy_var_111;
    call {:si_unique_call 1513} out_Value_1 := corral_nondet();
    goto anon33_Then;

  anon33_Then:
    assume {:partition} out_Value_1 != 0;
    goto anon33_Then_dummy;

  anon33_Then_dummy:
    call {:si_unique_call 1514} {:si_old_unique_call 1} out_Value_1, out_Tmp_564, out_Tmp_567 := RtlLargeIntegerToUnicodeString_loop_L29(out_Value_1, in_Mask, out_Tmp_564, in_ptr, out_Tmp_567);
    return;
}



procedure {:LoopProcedure} RtlLargeIntegerToUnicodeString_loop_L29(in_Value_1: int, in_Mask: int, in_Tmp_564: int, in_ptr: int, in_Tmp_567: int) returns (out_Value_1: int, out_Tmp_564: int, out_Tmp_567: int);
  modifies Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation RtlLargeIntegerToUnicodeString_loop_L47(in_Tmp_563: int, in_Value_1: int, in_Tmp_566: int, in_ptr: int) returns (out_Tmp_563: int, out_Value_1: int, out_Tmp_566: int)
{
  var vslice_dummy_var_112: int;

  entry:
    out_Tmp_563, out_Value_1, out_Tmp_566 := in_Tmp_563, in_Value_1, in_Tmp_566;
    goto L47, exit;

  exit:
    return;

  L47:
    out_Tmp_563 := INTMOD(out_Value_1, 10);
    out_Tmp_566 := out_Tmp_563;
    assume {:nonnull} in_ptr != 0;
    assume in_ptr > 0;
    havoc vslice_dummy_var_112;
    Mem_T.INT4[in_ptr] := vslice_dummy_var_112;
    out_Value_1 := INTDIV(out_Value_1, 10);
    goto anon31_Then;

  anon31_Then:
    assume {:partition} out_Value_1 != 0;
    goto anon31_Then_dummy;

  anon31_Then_dummy:
    call {:si_unique_call 1515} {:si_old_unique_call 1} out_Tmp_563, out_Value_1, out_Tmp_566 := RtlLargeIntegerToUnicodeString_loop_L47(out_Tmp_563, out_Value_1, out_Tmp_566, in_ptr);
    return;
}



procedure {:LoopProcedure} RtlLargeIntegerToUnicodeString_loop_L47(in_Tmp_563: int, in_Value_1: int, in_Tmp_566: int, in_ptr: int) returns (out_Tmp_563: int, out_Value_1: int, out_Tmp_566: int);
  modifies Mem_T.INT4;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcRobustStatusRequest_loop_L13(in_Retries_1: int, in_ntStatus_30: int, in_tmDelay_1: int, in_Command_20: int, in_vslice_dummy_var_229: int) returns (out_Retries_1: int, out_ntStatus_30: int, out_vslice_dummy_var_229: int)
{

  entry:
    out_Retries_1, out_ntStatus_30, out_vslice_dummy_var_229 := in_Retries_1, in_ntStatus_30, in_vslice_dummy_var_229;
    goto L13, exit;

  exit:
    return;

  L13:
    assume {:CounterLoop 10} {:Counter "Retries_1"} true;
    goto anon23_Else;

  anon23_Else:
    assume {:partition} 10 > out_Retries_1;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} out_Retries_1 != 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} out_ntStatus_30 != 258;
    call {:si_unique_call 1517} out_vslice_dummy_var_229 := KeDelayExecutionThread(0, 0, 0);
    goto L16;

  L16:
    call {:si_unique_call 1516} out_ntStatus_30 := AvcStatus(in_Command_20);
    goto anon33_Else;

  anon33_Else:
    assume {:partition} yogi_error != 1;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} out_ntStatus_30 != 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} out_ntStatus_30 != -1073741435;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} out_ntStatus_30 != -1073741668;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} out_ntStatus_30 != -1073741643;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} out_ntStatus_30 != -1073741248;
    goto anon32_Else;

  anon32_Else:
    assume {:partition} out_ntStatus_30 == 258;
    goto L27;

  L27:
    assume {:nonnull} in_tmDelay_1 != 0;
    assume in_tmDelay_1 > 0;
    goto L33;

  L33:
    out_Retries_1 := out_Retries_1 + 1;
    goto L33_dummy;

  L33_dummy:
    call {:si_unique_call 1518} {:si_old_unique_call 1} out_Retries_1, out_ntStatus_30, out_vslice_dummy_var_229 := AvcRobustStatusRequest_loop_L13(out_Retries_1, out_ntStatus_30, in_tmDelay_1, in_Command_20, out_vslice_dummy_var_229);
    return;

  anon31_Then:
    assume {:partition} out_ntStatus_30 == -1073741248;
    goto L27;

  anon30_Then:
    assume {:partition} out_ntStatus_30 == -1073741643;
    goto L27;

  anon29_Then:
    assume {:partition} out_ntStatus_30 == -1073741668;
    goto L27;

  anon28_Then:
    assume {:partition} out_ntStatus_30 == -1073741435;
    goto L27;

  anon26_Then:
    assume {:partition} out_ntStatus_30 == 0;
    assume {:nonnull} in_Command_20 != 0;
    assume in_Command_20 > 0;
    goto anon27_Else;

  anon27_Else:
    assume {:nonnull} in_tmDelay_1 != 0;
    assume in_tmDelay_1 > 0;
    goto L33;

  anon25_Then:
    assume {:partition} out_ntStatus_30 == 258;
    goto L16;

  anon24_Then:
    assume {:partition} out_Retries_1 == 0;
    goto L16;
}



procedure {:LoopProcedure} AvcRobustStatusRequest_loop_L13(in_Retries_1: int, in_ntStatus_30: int, in_tmDelay_1: int, in_Command_20: int, in_vslice_dummy_var_229: int) returns (out_Retries_1: int, out_ntStatus_30: int, out_vslice_dummy_var_229: int);
  modifies alloc, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures out_vslice_dummy_var_229 == 0 || out_vslice_dummy_var_229 == -1073741823 || out_vslice_dummy_var_229 == in_vslice_dummy_var_229;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation sdv_hash_672547288_loop_L4(in_s_p_e_c_i_a_l_4: int, in_s_p_e_c_i_a_l_6: int, in_s_p_e_c_i_a_l_7: int) returns (out_s_p_e_c_i_a_l_6: int)
{

  entry:
    out_s_p_e_c_i_a_l_6 := in_s_p_e_c_i_a_l_6;
    goto L4, exit;

  exit:
    return;

  L4:
    out_s_p_e_c_i_a_l_6 := out_s_p_e_c_i_a_l_6 - 1;
    goto anon3_Else;

  anon3_Else:
    assume {:partition} out_s_p_e_c_i_a_l_6 >= 0;
    assume {:IndirectCall} true;
    assume in_s_p_e_c_i_a_l_7 == li2bplFunctionConstant374;
    call {:si_unique_call 1519} sdv_hash_330311584_sdv_special_DTOR(in_s_p_e_c_i_a_l_4);
    goto anon3_Else_dummy;

  anon3_Else_dummy:
    havoc out_s_p_e_c_i_a_l_6;
    return;
}



procedure {:LoopProcedure} sdv_hash_672547288_loop_L4(in_s_p_e_c_i_a_l_4: int, in_s_p_e_c_i_a_l_6: int, in_s_p_e_c_i_a_l_7: int) returns (out_s_p_e_c_i_a_l_6: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcRequestCompletion_sdv_static_function_7#0_loop_L183(in_TargetExt: int, in_Entry: int, in_DevExt_6: int, in_HandlerFound: int, in_Command_8: int, in_sdv_70: int, in_Opcode_1: int) returns (out_TargetExt: int, out_Entry: int, out_HandlerFound: int, out_sdv_70: int)
{

  entry:
    out_TargetExt, out_Entry, out_HandlerFound, out_sdv_70 := in_TargetExt, in_Entry, in_HandlerFound, in_sdv_70;
    goto L183, exit;

  exit:
    return;

  L183:
    goto anon77_Else;

  anon77_Else:
    goto anon78_Else;

  anon78_Else:
    assume {:partition} out_HandlerFound == 0;
    call {:si_unique_call 1521} out_sdv_70 := sdv_containing_record(out_Entry, 72);
    out_TargetExt := out_sdv_70;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} out_TargetExt != in_DevExt_6;
    call {:si_unique_call 1520} out_HandlerFound := AvcSearchForUnitCommandHandler_sdv_static_function_7(out_TargetExt, in_Opcode_1, in_Command_8);
    goto L194;

  L194:
    assume {:nonnull} out_Entry != 0;
    assume out_Entry > 0;
    havoc out_Entry;
    goto L194_dummy;

  L194_dummy:
    call {:si_unique_call 1522} {:si_old_unique_call 1} out_TargetExt, out_Entry, out_HandlerFound, out_sdv_70 := AvcRequestCompletion_sdv_static_function_7#0_loop_L183(out_TargetExt, out_Entry, in_DevExt_6, out_HandlerFound, in_Command_8, out_sdv_70, in_Opcode_1);
    return;

  anon87_Then:
    assume {:partition} out_TargetExt == in_DevExt_6;
    goto L194;
}



procedure {:LoopProcedure} AvcRequestCompletion_sdv_static_function_7#0_loop_L183(in_TargetExt: int, in_Entry: int, in_DevExt_6: int, in_HandlerFound: int, in_Command_8: int, in_sdv_70: int, in_Opcode_1: int) returns (out_TargetExt: int, out_Entry: int, out_HandlerFound: int, out_sdv_70: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures out_HandlerFound == 1 || out_HandlerFound == 0 || out_HandlerFound == in_HandlerFound;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcRequestCompletion_sdv_static_function_7#0_loop_L129(in_SubunitAddr_2: int, in_Command_8: int, in_Entry_1: int, in_sdv_69: int) returns (out_Entry_1: int, out_sdv_69: int)
{
  var vslice_dummy_var_113: int;

  entry:
    out_Entry_1, out_sdv_69 := in_Entry_1, in_sdv_69;
    goto L129, exit;

  exit:
    return;

  L129:
    goto anon71_Else;

  anon71_Else:
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    goto L135;

  L135:
    assume {:nonnull} out_Entry_1 != 0;
    assume out_Entry_1 > 0;
    havoc out_Entry_1;
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    goto L135_dummy;

  L135_dummy:
    call {:si_unique_call 1524} {:si_old_unique_call 1} out_Entry_1, out_sdv_69 := AvcRequestCompletion_sdv_static_function_7#0_loop_L129(in_SubunitAddr_2, in_Command_8, out_Entry_1, out_sdv_69);
    return;

  anon85_Then:
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    havoc vslice_dummy_var_113;
    call {:si_unique_call 1523} out_sdv_69 := AvcSubunitAddrsEqual(in_SubunitAddr_2, vslice_dummy_var_113);
    goto anon72_Then;

  anon72_Then:
    assume {:partition} out_sdv_69 == 0;
    goto L135;
}



procedure {:LoopProcedure} AvcRequestCompletion_sdv_static_function_7#0_loop_L129(in_SubunitAddr_2: int, in_Command_8: int, in_Entry_1: int, in_sdv_69: int) returns (out_Entry_1: int, out_sdv_69: int);
  free ensures out_sdv_69 == 1 || out_sdv_69 == 0 || out_sdv_69 == in_sdv_69;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcRequestCompletion_sdv_static_function_7#0_loop_L114(in_PdoData_1: int, in_SubunitAddr_2: int, in_sdv_61: int, in_Entry_1: int) returns (out_PdoData_1: int, out_sdv_61: int, out_Entry_1: int)
{
  var vslice_dummy_var_114: int;

  entry:
    out_PdoData_1, out_sdv_61, out_Entry_1 := in_PdoData_1, in_sdv_61, in_Entry_1;
    goto L114, exit;

  exit:
    return;

  L114:
    goto anon68_Else;

  anon68_Else:
    out_PdoData_1 := out_Entry_1;
    assume {:nonnull} out_PdoData_1 != 0;
    assume out_PdoData_1 > 0;
    havoc vslice_dummy_var_114;
    call {:si_unique_call 1525} out_sdv_61 := AvcSubunitAddrsEqual(in_SubunitAddr_2, vslice_dummy_var_114);
    goto anon70_Else;

  anon70_Else:
    assume {:partition} out_sdv_61 == 0;
    out_PdoData_1 := 0;
    assume {:nonnull} out_Entry_1 != 0;
    assume out_Entry_1 > 0;
    havoc out_Entry_1;
    goto anon70_Else_dummy;

  anon70_Else_dummy:
    call {:si_unique_call 1526} {:si_old_unique_call 1} out_PdoData_1, out_sdv_61, out_Entry_1 := AvcRequestCompletion_sdv_static_function_7#0_loop_L114(out_PdoData_1, in_SubunitAddr_2, out_sdv_61, out_Entry_1);
    return;
}



procedure {:LoopProcedure} AvcRequestCompletion_sdv_static_function_7#0_loop_L114(in_PdoData_1: int, in_SubunitAddr_2: int, in_sdv_61: int, in_Entry_1: int) returns (out_PdoData_1: int, out_sdv_61: int, out_Entry_1: int);
  free ensures out_PdoData_1 == 0 || out_PdoData_1 == in_PdoData_1;
  free ensures out_sdv_61 == 1 || out_sdv_61 == 0 || out_sdv_61 == in_sdv_61;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcRequestCompletion_sdv_static_function_7#0_loop_L97(in_PdoData_1: int, in_SubunitAddr_2: int, in_FdoEntry: int, in_sdv_61: int, in_TargetExt_1: int, in_sdv_68: int, in_Command_8: int, in_Entry_1: int, in_sdv_69: int, in_SubunitFound: int, in_vslice_dummy_var_260: int) returns (out_PdoData_1: int, out_FdoEntry: int, out_sdv_61: int, out_TargetExt_1: int, out_sdv_68: int, out_Entry_1: int, out_sdv_69: int, out_SubunitFound: int, out_vslice_dummy_var_260: int)
{
  var vslice_dummy_var_115: int;
  var vslice_dummy_var_116: int;
  var vslice_dummy_var_117: int;

  entry:
    out_PdoData_1, out_FdoEntry, out_sdv_61, out_TargetExt_1, out_sdv_68, out_Entry_1, out_sdv_69, out_SubunitFound, out_vslice_dummy_var_260 := in_PdoData_1, in_FdoEntry, in_sdv_61, in_TargetExt_1, in_sdv_68, in_Entry_1, in_sdv_69, in_SubunitFound, in_vslice_dummy_var_260;
    goto L97, exit;

  exit:
    return;

  L97:
    goto anon66_Else;

  anon66_Else:
    goto anon67_Else;

  anon67_Else:
    assume {:partition} out_SubunitFound == 0;
    call {:si_unique_call 1531} out_sdv_68 := sdv_containing_record(out_FdoEntry, 72);
    out_TargetExt_1 := out_sdv_68;
    out_PdoData_1 := 0;
    call {:si_unique_call 1532} sdv_KeAcquireSpinLockAtDpcLevel(0);
    assume {:nonnull} out_TargetExt_1 != 0;
    assume out_TargetExt_1 > 0;
    havoc out_Entry_1;
    goto L114;

  L114:
    call {:si_unique_call 1530} out_PdoData_1, out_sdv_61, out_Entry_1 := AvcRequestCompletion_sdv_static_function_7#0_loop_L114(out_PdoData_1, in_SubunitAddr_2, out_sdv_61, out_Entry_1);
    goto L114_last;

  L114_last:
    goto anon68_Then, anon68_Else;

  anon68_Else:
    out_PdoData_1 := out_Entry_1;
    assume {:nonnull} out_PdoData_1 != 0;
    assume out_PdoData_1 > 0;
    havoc vslice_dummy_var_116;
    call {:si_unique_call 1533} out_sdv_61 := AvcSubunitAddrsEqual(in_SubunitAddr_2, vslice_dummy_var_116);
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} out_sdv_61 == 0;
    out_PdoData_1 := 0;
    assume {:nonnull} out_Entry_1 != 0;
    assume out_Entry_1 > 0;
    havoc out_Entry_1;
    assume false;
    return;

  anon70_Then:
    assume {:partition} out_sdv_61 != 0;
    goto L115;

  L115:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} out_PdoData_1 != 0;
    out_SubunitFound := 1;
    assume {:nonnull} out_TargetExt_1 != 0;
    assume out_TargetExt_1 > 0;
    havoc out_Entry_1;
    goto L129;

  L129:
    call {:si_unique_call 1534} out_Entry_1, out_sdv_69 := AvcRequestCompletion_sdv_static_function_7#0_loop_L129(in_SubunitAddr_2, in_Command_8, out_Entry_1, out_sdv_69);
    goto L129_last;

  L129_last:
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    goto L135;

  L135:
    assume {:nonnull} out_Entry_1 != 0;
    assume out_Entry_1 > 0;
    havoc out_Entry_1;
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    assume false;
    return;

  anon85_Then:
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    havoc vslice_dummy_var_117;
    call {:si_unique_call 1535} out_sdv_69 := AvcSubunitAddrsEqual(in_SubunitAddr_2, vslice_dummy_var_117);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} out_sdv_69 != 0;
    call {:si_unique_call 1528} out_vslice_dummy_var_260 := sdv_RemoveEntryList(0);
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    havoc vslice_dummy_var_115;
    call {:si_unique_call 1529} InitializeListHead(vslice_dummy_var_115);
    goto L124;

  L124:
    call {:si_unique_call 1527} sdv_KeReleaseSpinLockFromDpcLevel(0);
    assume {:nonnull} out_FdoEntry != 0;
    assume out_FdoEntry > 0;
    havoc out_FdoEntry;
    goto L124_dummy;

  L124_dummy:
    call {:si_unique_call 1536} {:si_old_unique_call 1} out_PdoData_1, out_FdoEntry, out_sdv_61, out_TargetExt_1, out_sdv_68, out_Entry_1, out_sdv_69, out_SubunitFound, out_vslice_dummy_var_260 := AvcRequestCompletion_sdv_static_function_7#0_loop_L97(out_PdoData_1, in_SubunitAddr_2, out_FdoEntry, out_sdv_61, out_TargetExt_1, out_sdv_68, in_Command_8, out_Entry_1, out_sdv_69, out_SubunitFound, out_vslice_dummy_var_260);
    return;

  anon72_Then:
    assume {:partition} out_sdv_69 == 0;
    goto L135;

  anon71_Then:
    goto L124;

  anon69_Then:
    assume {:partition} out_PdoData_1 == 0;
    goto L124;

  anon68_Then:
    goto L115;
}



procedure {:LoopProcedure} AvcRequestCompletion_sdv_static_function_7#0_loop_L97(in_PdoData_1: int, in_SubunitAddr_2: int, in_FdoEntry: int, in_sdv_61: int, in_TargetExt_1: int, in_sdv_68: int, in_Command_8: int, in_Entry_1: int, in_sdv_69: int, in_SubunitFound: int, in_vslice_dummy_var_260: int) returns (out_PdoData_1: int, out_FdoEntry: int, out_sdv_61: int, out_TargetExt_1: int, out_sdv_68: int, out_Entry_1: int, out_sdv_69: int, out_SubunitFound: int, out_vslice_dummy_var_260: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_current == old(sdv_irql_current);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures out_sdv_61 == 1 || out_sdv_61 == 0 || out_sdv_61 == in_sdv_61;
  free ensures out_sdv_69 == 1 || out_sdv_69 == 0 || out_sdv_69 == in_sdv_69;
  free ensures out_SubunitFound == 1 || out_SubunitFound == in_SubunitFound;
  free ensures out_vslice_dummy_var_260 == 1 || out_vslice_dummy_var_260 == 0 || out_vslice_dummy_var_260 == in_vslice_dummy_var_260;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcRequestCompletion_sdv_static_function_7#1_loop_L183(in_TargetExt: int, in_Entry: int, in_DevExt_6: int, in_HandlerFound: int, in_Command_8: int, in_sdv_70: int, in_Opcode_1: int) returns (out_TargetExt: int, out_Entry: int, out_HandlerFound: int, out_sdv_70: int)
{

  entry:
    out_TargetExt, out_Entry, out_HandlerFound, out_sdv_70 := in_TargetExt, in_Entry, in_HandlerFound, in_sdv_70;
    goto L183, exit;

  exit:
    return;

  L183:
    goto anon77_Else;

  anon77_Else:
    goto anon78_Else;

  anon78_Else:
    assume {:partition} out_HandlerFound == 0;
    call {:si_unique_call 1538} out_sdv_70 := sdv_containing_record(out_Entry, 72);
    out_TargetExt := out_sdv_70;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} out_TargetExt != in_DevExt_6;
    call {:si_unique_call 1537} out_HandlerFound := AvcSearchForUnitCommandHandler_sdv_static_function_7(out_TargetExt, in_Opcode_1, in_Command_8);
    goto L194;

  L194:
    assume {:nonnull} out_Entry != 0;
    assume out_Entry > 0;
    havoc out_Entry;
    goto L194_dummy;

  L194_dummy:
    call {:si_unique_call 1539} {:si_old_unique_call 1} out_TargetExt, out_Entry, out_HandlerFound, out_sdv_70 := AvcRequestCompletion_sdv_static_function_7#1_loop_L183(out_TargetExt, out_Entry, in_DevExt_6, out_HandlerFound, in_Command_8, out_sdv_70, in_Opcode_1);
    return;

  anon87_Then:
    assume {:partition} out_TargetExt == in_DevExt_6;
    goto L194;
}



procedure {:LoopProcedure} AvcRequestCompletion_sdv_static_function_7#1_loop_L183(in_TargetExt: int, in_Entry: int, in_DevExt_6: int, in_HandlerFound: int, in_Command_8: int, in_sdv_70: int, in_Opcode_1: int) returns (out_TargetExt: int, out_Entry: int, out_HandlerFound: int, out_sdv_70: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures out_HandlerFound == 1 || out_HandlerFound == 0 || out_HandlerFound == in_HandlerFound;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcRequestCompletion_sdv_static_function_7#1_loop_L129(in_SubunitAddr_2: int, in_Command_8: int, in_Entry_1: int, in_sdv_69: int) returns (out_Entry_1: int, out_sdv_69: int)
{
  var vslice_dummy_var_118: int;

  entry:
    out_Entry_1, out_sdv_69 := in_Entry_1, in_sdv_69;
    goto L129, exit;

  exit:
    return;

  L129:
    goto anon71_Else;

  anon71_Else:
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    goto L135;

  L135:
    assume {:nonnull} out_Entry_1 != 0;
    assume out_Entry_1 > 0;
    havoc out_Entry_1;
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    goto L135_dummy;

  L135_dummy:
    call {:si_unique_call 1541} {:si_old_unique_call 1} out_Entry_1, out_sdv_69 := AvcRequestCompletion_sdv_static_function_7#1_loop_L129(in_SubunitAddr_2, in_Command_8, out_Entry_1, out_sdv_69);
    return;

  anon85_Then:
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    havoc vslice_dummy_var_118;
    call {:si_unique_call 1540} out_sdv_69 := AvcSubunitAddrsEqual(in_SubunitAddr_2, vslice_dummy_var_118);
    goto anon72_Then;

  anon72_Then:
    assume {:partition} out_sdv_69 == 0;
    goto L135;
}



procedure {:LoopProcedure} AvcRequestCompletion_sdv_static_function_7#1_loop_L129(in_SubunitAddr_2: int, in_Command_8: int, in_Entry_1: int, in_sdv_69: int) returns (out_Entry_1: int, out_sdv_69: int);
  free ensures out_sdv_69 == 1 || out_sdv_69 == 0 || out_sdv_69 == in_sdv_69;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcRequestCompletion_sdv_static_function_7#1_loop_L114(in_PdoData_1: int, in_SubunitAddr_2: int, in_sdv_61: int, in_Entry_1: int) returns (out_PdoData_1: int, out_sdv_61: int, out_Entry_1: int)
{
  var vslice_dummy_var_119: int;

  entry:
    out_PdoData_1, out_sdv_61, out_Entry_1 := in_PdoData_1, in_sdv_61, in_Entry_1;
    goto L114, exit;

  exit:
    return;

  L114:
    goto anon68_Else;

  anon68_Else:
    out_PdoData_1 := out_Entry_1;
    assume {:nonnull} out_PdoData_1 != 0;
    assume out_PdoData_1 > 0;
    havoc vslice_dummy_var_119;
    call {:si_unique_call 1542} out_sdv_61 := AvcSubunitAddrsEqual(in_SubunitAddr_2, vslice_dummy_var_119);
    goto anon70_Else;

  anon70_Else:
    assume {:partition} out_sdv_61 == 0;
    out_PdoData_1 := 0;
    assume {:nonnull} out_Entry_1 != 0;
    assume out_Entry_1 > 0;
    havoc out_Entry_1;
    goto anon70_Else_dummy;

  anon70_Else_dummy:
    call {:si_unique_call 1543} {:si_old_unique_call 1} out_PdoData_1, out_sdv_61, out_Entry_1 := AvcRequestCompletion_sdv_static_function_7#1_loop_L114(out_PdoData_1, in_SubunitAddr_2, out_sdv_61, out_Entry_1);
    return;
}



procedure {:LoopProcedure} AvcRequestCompletion_sdv_static_function_7#1_loop_L114(in_PdoData_1: int, in_SubunitAddr_2: int, in_sdv_61: int, in_Entry_1: int) returns (out_PdoData_1: int, out_sdv_61: int, out_Entry_1: int);
  free ensures out_PdoData_1 == 0 || out_PdoData_1 == in_PdoData_1;
  free ensures out_sdv_61 == 1 || out_sdv_61 == 0 || out_sdv_61 == in_sdv_61;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcRequestCompletion_sdv_static_function_7#1_loop_L97(in_PdoData_1: int, in_SubunitAddr_2: int, in_FdoEntry: int, in_sdv_61: int, in_TargetExt_1: int, in_sdv_68: int, in_Command_8: int, in_Entry_1: int, in_sdv_69: int, in_SubunitFound: int, in_vslice_dummy_var_261: int) returns (out_PdoData_1: int, out_FdoEntry: int, out_sdv_61: int, out_TargetExt_1: int, out_sdv_68: int, out_Entry_1: int, out_sdv_69: int, out_SubunitFound: int, out_vslice_dummy_var_261: int)
{
  var vslice_dummy_var_120: int;
  var vslice_dummy_var_121: int;
  var vslice_dummy_var_122: int;

  entry:
    out_PdoData_1, out_FdoEntry, out_sdv_61, out_TargetExt_1, out_sdv_68, out_Entry_1, out_sdv_69, out_SubunitFound, out_vslice_dummy_var_261 := in_PdoData_1, in_FdoEntry, in_sdv_61, in_TargetExt_1, in_sdv_68, in_Entry_1, in_sdv_69, in_SubunitFound, in_vslice_dummy_var_261;
    goto L97, exit;

  exit:
    return;

  L97:
    goto anon66_Else;

  anon66_Else:
    goto anon67_Else;

  anon67_Else:
    assume {:partition} out_SubunitFound == 0;
    call {:si_unique_call 1548} out_sdv_68 := sdv_containing_record(out_FdoEntry, 72);
    out_TargetExt_1 := out_sdv_68;
    out_PdoData_1 := 0;
    call {:si_unique_call 1549} sdv_KeAcquireSpinLockAtDpcLevel(0);
    assume {:nonnull} out_TargetExt_1 != 0;
    assume out_TargetExt_1 > 0;
    havoc out_Entry_1;
    goto L114;

  L114:
    call {:si_unique_call 1547} out_PdoData_1, out_sdv_61, out_Entry_1 := AvcRequestCompletion_sdv_static_function_7#1_loop_L114(out_PdoData_1, in_SubunitAddr_2, out_sdv_61, out_Entry_1);
    goto L114_last;

  L114_last:
    goto anon68_Then, anon68_Else;

  anon68_Else:
    out_PdoData_1 := out_Entry_1;
    assume {:nonnull} out_PdoData_1 != 0;
    assume out_PdoData_1 > 0;
    havoc vslice_dummy_var_121;
    call {:si_unique_call 1550} out_sdv_61 := AvcSubunitAddrsEqual(in_SubunitAddr_2, vslice_dummy_var_121);
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} out_sdv_61 == 0;
    out_PdoData_1 := 0;
    assume {:nonnull} out_Entry_1 != 0;
    assume out_Entry_1 > 0;
    havoc out_Entry_1;
    assume false;
    return;

  anon70_Then:
    assume {:partition} out_sdv_61 != 0;
    goto L115;

  L115:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} out_PdoData_1 != 0;
    out_SubunitFound := 1;
    assume {:nonnull} out_TargetExt_1 != 0;
    assume out_TargetExt_1 > 0;
    havoc out_Entry_1;
    goto L129;

  L129:
    call {:si_unique_call 1551} out_Entry_1, out_sdv_69 := AvcRequestCompletion_sdv_static_function_7#1_loop_L129(in_SubunitAddr_2, in_Command_8, out_Entry_1, out_sdv_69);
    goto L129_last;

  L129_last:
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    goto L135;

  L135:
    assume {:nonnull} out_Entry_1 != 0;
    assume out_Entry_1 > 0;
    havoc out_Entry_1;
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    assume false;
    return;

  anon85_Then:
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    havoc vslice_dummy_var_122;
    call {:si_unique_call 1552} out_sdv_69 := AvcSubunitAddrsEqual(in_SubunitAddr_2, vslice_dummy_var_122);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} out_sdv_69 != 0;
    call {:si_unique_call 1545} out_vslice_dummy_var_261 := sdv_RemoveEntryList(0);
    assume {:nonnull} in_Command_8 != 0;
    assume in_Command_8 > 0;
    havoc vslice_dummy_var_120;
    call {:si_unique_call 1546} InitializeListHead(vslice_dummy_var_120);
    goto L124;

  L124:
    call {:si_unique_call 1544} sdv_KeReleaseSpinLockFromDpcLevel(0);
    assume {:nonnull} out_FdoEntry != 0;
    assume out_FdoEntry > 0;
    havoc out_FdoEntry;
    goto L124_dummy;

  L124_dummy:
    call {:si_unique_call 1553} {:si_old_unique_call 1} out_PdoData_1, out_FdoEntry, out_sdv_61, out_TargetExt_1, out_sdv_68, out_Entry_1, out_sdv_69, out_SubunitFound, out_vslice_dummy_var_261 := AvcRequestCompletion_sdv_static_function_7#1_loop_L97(out_PdoData_1, in_SubunitAddr_2, out_FdoEntry, out_sdv_61, out_TargetExt_1, out_sdv_68, in_Command_8, out_Entry_1, out_sdv_69, out_SubunitFound, out_vslice_dummy_var_261);
    return;

  anon72_Then:
    assume {:partition} out_sdv_69 == 0;
    goto L135;

  anon71_Then:
    goto L124;

  anon69_Then:
    assume {:partition} out_PdoData_1 == 0;
    goto L124;

  anon68_Then:
    goto L115;
}



procedure {:LoopProcedure} AvcRequestCompletion_sdv_static_function_7#1_loop_L97(in_PdoData_1: int, in_SubunitAddr_2: int, in_FdoEntry: int, in_sdv_61: int, in_TargetExt_1: int, in_sdv_68: int, in_Command_8: int, in_Entry_1: int, in_sdv_69: int, in_SubunitFound: int, in_vslice_dummy_var_261: int) returns (out_PdoData_1: int, out_FdoEntry: int, out_sdv_61: int, out_TargetExt_1: int, out_sdv_68: int, out_Entry_1: int, out_sdv_69: int, out_SubunitFound: int, out_vslice_dummy_var_261: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_current == old(sdv_irql_current);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures out_sdv_61 == 1 || out_sdv_61 == 0 || out_sdv_61 == in_sdv_61;
  free ensures out_sdv_69 == 1 || out_sdv_69 == 0 || out_sdv_69 == in_sdv_69;
  free ensures out_SubunitFound == 1 || out_SubunitFound == in_SubunitFound;
  free ensures out_vslice_dummy_var_261 == 1 || out_vslice_dummy_var_261 == 0 || out_vslice_dummy_var_261 == in_vslice_dummy_var_261;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcResponseCompletion_sdv_static_function_7#0_loop_L110(in_Tmp_174: int, in_max_1: int, in_Command_12: int, in_idx_7: int, in_Tmp_179: int, in_Opcode_3: int) returns (out_Tmp_174: int, out_idx_7: int, out_Tmp_179: int)
{

  entry:
    out_Tmp_174, out_idx_7, out_Tmp_179 := in_Tmp_174, in_idx_7, in_Tmp_179;
    goto L110, exit;

  exit:
    return;

  L110:
    goto anon132_Else;

  anon132_Else:
    assume {:partition} in_max_1 >= out_idx_7;
    out_Tmp_179 := out_idx_7;
    assume {:nonnull} in_Command_12 != 0;
    assume in_Command_12 > 0;
    havoc out_Tmp_174;
    assume {:nonnull} out_Tmp_174 != 0;
    assume out_Tmp_174 > 0;
    goto anon171_Then;

  anon171_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_174 + out_Tmp_179 * 4];
    out_idx_7 := out_idx_7 + 1;
    goto anon171_Then_dummy;

  anon171_Then_dummy:
    call {:si_unique_call 1554} {:si_old_unique_call 1} out_Tmp_174, out_idx_7, out_Tmp_179 := AvcResponseCompletion_sdv_static_function_7#0_loop_L110(out_Tmp_174, in_max_1, in_Command_12, out_idx_7, out_Tmp_179, in_Opcode_3);
    return;
}



procedure {:LoopProcedure} AvcResponseCompletion_sdv_static_function_7#0_loop_L110(in_Tmp_174: int, in_max_1: int, in_Command_12: int, in_idx_7: int, in_Tmp_179: int, in_Opcode_3: int) returns (out_Tmp_174: int, out_idx_7: int, out_Tmp_179: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcResponseCompletion_sdv_static_function_7#0_loop_L136(in_Tmp_168: int, in_Tmp_172: int, in_idx_6: int, in_Command_12: int, in_max_2: int, in_Opcode_3: int) returns (out_Tmp_168: int, out_Tmp_172: int, out_idx_6: int)
{

  entry:
    out_Tmp_168, out_Tmp_172, out_idx_6 := in_Tmp_168, in_Tmp_172, in_idx_6;
    goto L136, exit;

  exit:
    return;

  L136:
    goto anon137_Else;

  anon137_Else:
    assume {:partition} in_max_2 >= out_idx_6;
    out_Tmp_172 := out_idx_6;
    assume {:nonnull} in_Command_12 != 0;
    assume in_Command_12 > 0;
    havoc out_Tmp_168;
    assume {:nonnull} out_Tmp_168 != 0;
    assume out_Tmp_168 > 0;
    goto anon170_Then;

  anon170_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_168 + out_Tmp_172 * 4];
    out_idx_6 := out_idx_6 + 1;
    goto anon170_Then_dummy;

  anon170_Then_dummy:
    call {:si_unique_call 1555} {:si_old_unique_call 1} out_Tmp_168, out_Tmp_172, out_idx_6 := AvcResponseCompletion_sdv_static_function_7#0_loop_L136(out_Tmp_168, out_Tmp_172, out_idx_6, in_Command_12, in_max_2, in_Opcode_3);
    return;
}



procedure {:LoopProcedure} AvcResponseCompletion_sdv_static_function_7#0_loop_L136(in_Tmp_168: int, in_Tmp_172: int, in_idx_6: int, in_Command_12: int, in_max_2: int, in_Opcode_3: int) returns (out_Tmp_168: int, out_Tmp_172: int, out_idx_6: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcResponseCompletion_sdv_static_function_7#0_loop_L159(in_idx_5: int, in_Tmp_170: int, in_Tmp_171: int, in_Command_12: int, in_max_3: int, in_Opcode_3: int) returns (out_idx_5: int, out_Tmp_170: int, out_Tmp_171: int)
{

  entry:
    out_idx_5, out_Tmp_170, out_Tmp_171 := in_idx_5, in_Tmp_170, in_Tmp_171;
    goto L159, exit;

  exit:
    return;

  L159:
    goto anon143_Else;

  anon143_Else:
    assume {:partition} in_max_3 >= out_idx_5;
    out_Tmp_170 := out_idx_5;
    assume {:nonnull} in_Command_12 != 0;
    assume in_Command_12 > 0;
    havoc out_Tmp_171;
    assume {:nonnull} out_Tmp_171 != 0;
    assume out_Tmp_171 > 0;
    goto anon169_Then;

  anon169_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_171 + out_Tmp_170 * 4];
    out_idx_5 := out_idx_5 + 1;
    goto anon169_Then_dummy;

  anon169_Then_dummy:
    call {:si_unique_call 1556} {:si_old_unique_call 1} out_idx_5, out_Tmp_170, out_Tmp_171 := AvcResponseCompletion_sdv_static_function_7#0_loop_L159(out_idx_5, out_Tmp_170, out_Tmp_171, in_Command_12, in_max_3, in_Opcode_3);
    return;
}



procedure {:LoopProcedure} AvcResponseCompletion_sdv_static_function_7#0_loop_L159(in_idx_5: int, in_Tmp_170: int, in_Tmp_171: int, in_Command_12: int, in_max_3: int, in_Opcode_3: int) returns (out_idx_5: int, out_Tmp_170: int, out_Tmp_171: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcResponseCompletion_sdv_static_function_7#0_loop_L80(in_Tmp_168: int, in_SubunitAddr_3: int, in_ResponseCode_1: int, in_idx_5: int, in_Tmp_170: int, in_Tmp_171: int, in_Tmp_172: int, in_idx_6: int, in_Tmp_174: int, in_sdv_107: int, in_max_1: int, in_Command_12: int, in_Tmp_175: int, in_max_2: int, in_Entry_5: int, in_OpcodesMatch_1: int, in_idx_7: int, in_max_3: int, in_Tmp_177: int, in_Tmp_179: int, in_Tmp_180: int, in_Opcode_3: int) returns (out_Tmp_168: int, out_idx_5: int, out_Tmp_170: int, out_Tmp_171: int, out_Tmp_172: int, out_idx_6: int, out_Tmp_174: int, out_sdv_107: int, out_max_1: int, out_Command_12: int, out_Tmp_175: int, out_max_2: int, out_Entry_5: int, out_OpcodesMatch_1: int, out_idx_7: int, out_max_3: int, out_Tmp_177: int, out_Tmp_179: int, out_Tmp_180: int)
{
  var vslice_dummy_var_123: int;

  entry:
    out_Tmp_168, out_idx_5, out_Tmp_170, out_Tmp_171, out_Tmp_172, out_idx_6, out_Tmp_174, out_sdv_107, out_max_1, out_Command_12, out_Tmp_175, out_max_2, out_Entry_5, out_OpcodesMatch_1, out_idx_7, out_max_3, out_Tmp_177, out_Tmp_179, out_Tmp_180 := in_Tmp_168, in_idx_5, in_Tmp_170, in_Tmp_171, in_Tmp_172, in_idx_6, in_Tmp_174, in_sdv_107, in_max_1, in_Command_12, in_Tmp_175, in_max_2, in_Entry_5, in_OpcodesMatch_1, in_idx_7, in_max_3, in_Tmp_177, in_Tmp_179, in_Tmp_180;
    goto L80, exit;

  exit:
    return;

  L80:
    goto anon121_Else;

  anon121_Else:
    out_Command_12 := out_Entry_5;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon167_Then, anon167_Else;

  anon167_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc vslice_dummy_var_123;
    call {:si_unique_call 1557} out_sdv_107 := AvcSubunitAddrsEqual(in_SubunitAddr_3, vslice_dummy_var_123);
    goto anon122_Then, anon122_Else;

  anon122_Else:
    assume {:partition} out_sdv_107 != 0;
    out_OpcodesMatch_1 := 0;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon168_Then, anon168_Else;

  anon168_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon153_Then, anon153_Else;

  anon153_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon152_Then, anon152_Else;

  anon152_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon151_Then, anon151_Else;

  anon151_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon150_Then, anon150_Else;

  anon150_Else:
    goto L97;

  L97:
    goto anon125_Then, anon125_Else;

  anon125_Else:
    assume {:partition} in_ResponseCode_1 != 8;
    goto anon160_Then, anon160_Else;

  anon160_Else:
    assume {:partition} in_ResponseCode_1 == 12;
    goto L147;

  L147:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon139_Then, anon139_Else;

  anon139_Else:
    out_Command_12 := 0;
    goto L119;

  L119:
    goto anon134_Then;

  anon134_Then:
    assume {:partition} out_Command_12 == 0;
    goto L86;

  L86:
    assume {:nonnull} out_Entry_5 != 0;
    assume out_Entry_5 > 0;
    havoc out_Entry_5;
    out_Command_12 := 0;
    goto L86_dummy;

  L86_dummy:
    call {:si_unique_call 1561} {:si_old_unique_call 1} out_Tmp_168, out_idx_5, out_Tmp_170, out_Tmp_171, out_Tmp_172, out_idx_6, out_Tmp_174, out_sdv_107, out_max_1, out_Command_12, out_Tmp_175, out_max_2, out_Entry_5, out_OpcodesMatch_1, out_idx_7, out_max_3, out_Tmp_177, out_Tmp_179, out_Tmp_180 := AvcResponseCompletion_sdv_static_function_7#0_loop_L80(out_Tmp_168, in_SubunitAddr_3, in_ResponseCode_1, out_idx_5, out_Tmp_170, out_Tmp_171, out_Tmp_172, out_idx_6, out_Tmp_174, out_sdv_107, out_max_1, out_Command_12, out_Tmp_175, out_max_2, out_Entry_5, out_OpcodesMatch_1, out_idx_7, out_max_3, out_Tmp_177, out_Tmp_179, out_Tmp_180, in_Opcode_3);
    return;

  anon139_Then:
    goto L119;

  anon160_Then:
    assume {:partition} in_ResponseCode_1 != 12;
    out_Command_12 := 0;
    goto L119;

  anon125_Then:
    assume {:partition} in_ResponseCode_1 == 8;
    goto L147;

  anon150_Then:
    out_Command_12 := 0;
    goto L119;

  anon151_Then:
    goto anon126_Then, anon126_Else;

  anon126_Else:
    assume {:partition} in_ResponseCode_1 != 8;
    goto anon163_Then, anon163_Else;

  anon163_Else:
    assume {:partition} in_ResponseCode_1 != 10;
    goto anon162_Then, anon162_Else;

  anon162_Else:
    assume {:partition} in_ResponseCode_1 != 13;
    goto anon161_Then, anon161_Else;

  anon161_Else:
    assume {:partition} in_ResponseCode_1 == 15;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon129_Then, anon129_Else;

  anon129_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon130_Then, anon130_Else;

  anon130_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_180;
    assume {:nonnull} out_Tmp_180 != 0;
    assume out_Tmp_180 > 0;
    out_max_1 := Mem_T.INT4[out_Tmp_180];
    out_idx_7 := 1;
    goto L110;

  L110:
    call {:si_unique_call 1560} out_Tmp_174, out_idx_7, out_Tmp_179 := AvcResponseCompletion_sdv_static_function_7#0_loop_L110(out_Tmp_174, out_max_1, out_Command_12, out_idx_7, out_Tmp_179, in_Opcode_3);
    goto L110_last;

  L110_last:
    goto anon132_Then, anon132_Else;

  anon132_Else:
    assume {:partition} out_max_1 >= out_idx_7;
    out_Tmp_179 := out_idx_7;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_174;
    assume {:nonnull} out_Tmp_174 != 0;
    assume out_Tmp_174 > 0;
    goto anon171_Then, anon171_Else;

  anon171_Else:
    assume {:partition} in_Opcode_3 == Mem_T.INT4[out_Tmp_174 + out_Tmp_179 * 4];
    out_OpcodesMatch_1 := 1;
    goto L111;

  L111:
    goto anon133_Then, anon133_Else;

  anon133_Else:
    assume {:partition} out_OpcodesMatch_1 != 0;
    goto L119;

  anon133_Then:
    assume {:partition} out_OpcodesMatch_1 == 0;
    out_Command_12 := 0;
    goto L119;

  anon171_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_174 + out_Tmp_179 * 4];
    out_idx_7 := out_idx_7 + 1;
    assume false;
    return;

  anon132_Then:
    assume {:partition} out_idx_7 > out_max_1;
    goto L111;

  anon130_Then:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon131_Then, anon131_Else;

  anon131_Else:
    out_OpcodesMatch_1 := 0;
    goto L355;

  L355:
    goto L111;

  anon131_Then:
    out_OpcodesMatch_1 := 1;
    goto L355;

  anon129_Then:
    out_Command_12 := 0;
    goto L119;

  anon161_Then:
    assume {:partition} in_ResponseCode_1 != 15;
    out_Command_12 := 0;
    goto L119;

  anon162_Then:
    assume {:partition} in_ResponseCode_1 == 13;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon128_Then, anon128_Else;

  anon128_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_177;
    assume {:nonnull} out_Tmp_177 != 0;
    assume out_Tmp_177 > 0;
    out_max_2 := Mem_T.INT4[out_Tmp_177];
    out_idx_6 := 1;
    goto L136;

  L136:
    call {:si_unique_call 1559} out_Tmp_168, out_Tmp_172, out_idx_6 := AvcResponseCompletion_sdv_static_function_7#0_loop_L136(out_Tmp_168, out_Tmp_172, out_idx_6, out_Command_12, out_max_2, in_Opcode_3);
    goto L136_last;

  L136_last:
    goto anon137_Then, anon137_Else;

  anon137_Else:
    assume {:partition} out_max_2 >= out_idx_6;
    out_Tmp_172 := out_idx_6;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_168;
    assume {:nonnull} out_Tmp_168 != 0;
    assume out_Tmp_168 > 0;
    goto anon170_Then, anon170_Else;

  anon170_Else:
    assume {:partition} in_Opcode_3 == Mem_T.INT4[out_Tmp_168 + out_Tmp_172 * 4];
    out_OpcodesMatch_1 := 1;
    goto L137;

  L137:
    goto anon138_Then, anon138_Else;

  anon138_Else:
    assume {:partition} out_OpcodesMatch_1 == 0;
    out_Command_12 := 0;
    goto L119;

  anon138_Then:
    assume {:partition} out_OpcodesMatch_1 != 0;
    goto L119;

  anon170_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_168 + out_Tmp_172 * 4];
    out_idx_6 := out_idx_6 + 1;
    assume false;
    return;

  anon137_Then:
    assume {:partition} out_idx_6 > out_max_2;
    goto L137;

  anon128_Then:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon136_Then, anon136_Else;

  anon136_Else:
    out_OpcodesMatch_1 := 0;
    goto L344;

  L344:
    goto L137;

  anon136_Then:
    out_OpcodesMatch_1 := 1;
    goto L344;

  anon163_Then:
    assume {:partition} in_ResponseCode_1 == 10;
    goto L100;

  L100:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon127_Then, anon127_Else;

  anon127_Else:
    out_Command_12 := 0;
    goto L119;

  anon127_Then:
    goto L119;

  anon126_Then:
    assume {:partition} in_ResponseCode_1 == 8;
    goto L100;

  anon152_Then:
    goto L97;

  anon153_Then:
    goto anon124_Then, anon124_Else;

  anon124_Else:
    assume {:partition} in_ResponseCode_1 != 8;
    goto anon159_Then, anon159_Else;

  anon159_Else:
    assume {:partition} in_ResponseCode_1 != 10;
    goto anon158_Then, anon158_Else;

  anon158_Else:
    assume {:partition} in_ResponseCode_1 != 11;
    goto anon157_Then, anon157_Else;

  anon157_Else:
    assume {:partition} in_ResponseCode_1 == 12;
    goto L153;

  L153:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon141_Then, anon141_Else;

  anon141_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_175;
    assume {:nonnull} out_Tmp_175 != 0;
    assume out_Tmp_175 > 0;
    out_max_3 := Mem_T.INT4[out_Tmp_175];
    out_idx_5 := 1;
    goto L159;

  L159:
    call {:si_unique_call 1558} out_idx_5, out_Tmp_170, out_Tmp_171 := AvcResponseCompletion_sdv_static_function_7#0_loop_L159(out_idx_5, out_Tmp_170, out_Tmp_171, out_Command_12, out_max_3, in_Opcode_3);
    goto L159_last;

  L159_last:
    goto anon143_Then, anon143_Else;

  anon143_Else:
    assume {:partition} out_max_3 >= out_idx_5;
    out_Tmp_170 := out_idx_5;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_171;
    assume {:nonnull} out_Tmp_171 != 0;
    assume out_Tmp_171 > 0;
    goto anon169_Then, anon169_Else;

  anon169_Else:
    assume {:partition} in_Opcode_3 == Mem_T.INT4[out_Tmp_171 + out_Tmp_170 * 4];
    out_OpcodesMatch_1 := 1;
    goto L160;

  L160:
    goto anon144_Then, anon144_Else;

  anon144_Else:
    assume {:partition} out_OpcodesMatch_1 == 0;
    out_Command_12 := 0;
    goto L119;

  anon144_Then:
    assume {:partition} out_OpcodesMatch_1 != 0;
    goto L119;

  anon169_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_171 + out_Tmp_170 * 4];
    out_idx_5 := out_idx_5 + 1;
    assume false;
    return;

  anon143_Then:
    assume {:partition} out_idx_5 > out_max_3;
    goto L160;

  anon141_Then:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon142_Then, anon142_Else;

  anon142_Else:
    out_OpcodesMatch_1 := 0;
    goto L329;

  L329:
    goto L160;

  anon142_Then:
    out_OpcodesMatch_1 := 1;
    goto L329;

  anon157_Then:
    assume {:partition} in_ResponseCode_1 != 12;
    out_Command_12 := 0;
    goto L119;

  anon158_Then:
    assume {:partition} in_ResponseCode_1 == 11;
    goto L153;

  anon159_Then:
    assume {:partition} in_ResponseCode_1 == 10;
    goto L152;

  L152:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon140_Then, anon140_Else;

  anon140_Else:
    out_Command_12 := 0;
    goto L119;

  anon140_Then:
    goto L119;

  anon124_Then:
    assume {:partition} in_ResponseCode_1 == 8;
    goto L152;

  anon168_Then:
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume {:partition} in_ResponseCode_1 != 8;
    goto anon156_Then, anon156_Else;

  anon156_Else:
    assume {:partition} in_ResponseCode_1 != 9;
    goto anon155_Then, anon155_Else;

  anon155_Else:
    assume {:partition} in_ResponseCode_1 != 10;
    goto anon154_Then, anon154_Else;

  anon154_Else:
    assume {:partition} in_ResponseCode_1 == 15;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon146_Then, anon146_Else;

  anon146_Else:
    goto L174;

  L174:
    out_Command_12 := 0;
    goto L119;

  anon146_Then:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon147_Then, anon147_Else;

  anon147_Else:
    goto L174;

  anon147_Then:
    goto L119;

  anon154_Then:
    assume {:partition} in_ResponseCode_1 != 15;
    out_Command_12 := 0;
    goto L119;

  anon155_Then:
    assume {:partition} in_ResponseCode_1 == 10;
    goto L171;

  L171:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon145_Then, anon145_Else;

  anon145_Else:
    out_Command_12 := 0;
    goto L119;

  anon145_Then:
    goto L119;

  anon156_Then:
    assume {:partition} in_ResponseCode_1 == 9;
    goto L171;

  anon123_Then:
    assume {:partition} in_ResponseCode_1 == 8;
    goto L171;

  anon122_Then:
    assume {:partition} out_sdv_107 == 0;
    goto L86;

  anon167_Then:
    goto L86;
}



procedure {:LoopProcedure} AvcResponseCompletion_sdv_static_function_7#0_loop_L80(in_Tmp_168: int, in_SubunitAddr_3: int, in_ResponseCode_1: int, in_idx_5: int, in_Tmp_170: int, in_Tmp_171: int, in_Tmp_172: int, in_idx_6: int, in_Tmp_174: int, in_sdv_107: int, in_max_1: int, in_Command_12: int, in_Tmp_175: int, in_max_2: int, in_Entry_5: int, in_OpcodesMatch_1: int, in_idx_7: int, in_max_3: int, in_Tmp_177: int, in_Tmp_179: int, in_Tmp_180: int, in_Opcode_3: int) returns (out_Tmp_168: int, out_idx_5: int, out_Tmp_170: int, out_Tmp_171: int, out_Tmp_172: int, out_idx_6: int, out_Tmp_174: int, out_sdv_107: int, out_max_1: int, out_Command_12: int, out_Tmp_175: int, out_max_2: int, out_Entry_5: int, out_OpcodesMatch_1: int, out_idx_7: int, out_max_3: int, out_Tmp_177: int, out_Tmp_179: int, out_Tmp_180: int);
  free ensures out_sdv_107 == 1 || out_sdv_107 == 0 || out_sdv_107 == in_sdv_107;
  free ensures out_Command_12 == 0 || out_Command_12 == in_Command_12;
  free ensures out_OpcodesMatch_1 == 0 || out_OpcodesMatch_1 == 1 || out_OpcodesMatch_1 == in_OpcodesMatch_1;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcResponseCompletion_sdv_static_function_7#1_loop_L110(in_Tmp_174: int, in_max_1: int, in_Command_12: int, in_idx_7: int, in_Tmp_179: int, in_Opcode_3: int) returns (out_Tmp_174: int, out_idx_7: int, out_Tmp_179: int)
{

  entry:
    out_Tmp_174, out_idx_7, out_Tmp_179 := in_Tmp_174, in_idx_7, in_Tmp_179;
    goto L110, exit;

  exit:
    return;

  L110:
    goto anon132_Else;

  anon132_Else:
    assume {:partition} in_max_1 >= out_idx_7;
    out_Tmp_179 := out_idx_7;
    assume {:nonnull} in_Command_12 != 0;
    assume in_Command_12 > 0;
    havoc out_Tmp_174;
    assume {:nonnull} out_Tmp_174 != 0;
    assume out_Tmp_174 > 0;
    goto anon171_Then;

  anon171_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_174 + out_Tmp_179 * 4];
    out_idx_7 := out_idx_7 + 1;
    goto anon171_Then_dummy;

  anon171_Then_dummy:
    call {:si_unique_call 1562} {:si_old_unique_call 1} out_Tmp_174, out_idx_7, out_Tmp_179 := AvcResponseCompletion_sdv_static_function_7#1_loop_L110(out_Tmp_174, in_max_1, in_Command_12, out_idx_7, out_Tmp_179, in_Opcode_3);
    return;
}



procedure {:LoopProcedure} AvcResponseCompletion_sdv_static_function_7#1_loop_L110(in_Tmp_174: int, in_max_1: int, in_Command_12: int, in_idx_7: int, in_Tmp_179: int, in_Opcode_3: int) returns (out_Tmp_174: int, out_idx_7: int, out_Tmp_179: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcResponseCompletion_sdv_static_function_7#1_loop_L136(in_Tmp_168: int, in_Tmp_172: int, in_idx_6: int, in_Command_12: int, in_max_2: int, in_Opcode_3: int) returns (out_Tmp_168: int, out_Tmp_172: int, out_idx_6: int)
{

  entry:
    out_Tmp_168, out_Tmp_172, out_idx_6 := in_Tmp_168, in_Tmp_172, in_idx_6;
    goto L136, exit;

  exit:
    return;

  L136:
    goto anon137_Else;

  anon137_Else:
    assume {:partition} in_max_2 >= out_idx_6;
    out_Tmp_172 := out_idx_6;
    assume {:nonnull} in_Command_12 != 0;
    assume in_Command_12 > 0;
    havoc out_Tmp_168;
    assume {:nonnull} out_Tmp_168 != 0;
    assume out_Tmp_168 > 0;
    goto anon170_Then;

  anon170_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_168 + out_Tmp_172 * 4];
    out_idx_6 := out_idx_6 + 1;
    goto anon170_Then_dummy;

  anon170_Then_dummy:
    call {:si_unique_call 1563} {:si_old_unique_call 1} out_Tmp_168, out_Tmp_172, out_idx_6 := AvcResponseCompletion_sdv_static_function_7#1_loop_L136(out_Tmp_168, out_Tmp_172, out_idx_6, in_Command_12, in_max_2, in_Opcode_3);
    return;
}



procedure {:LoopProcedure} AvcResponseCompletion_sdv_static_function_7#1_loop_L136(in_Tmp_168: int, in_Tmp_172: int, in_idx_6: int, in_Command_12: int, in_max_2: int, in_Opcode_3: int) returns (out_Tmp_168: int, out_Tmp_172: int, out_idx_6: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcResponseCompletion_sdv_static_function_7#1_loop_L159(in_idx_5: int, in_Tmp_170: int, in_Tmp_171: int, in_Command_12: int, in_max_3: int, in_Opcode_3: int) returns (out_idx_5: int, out_Tmp_170: int, out_Tmp_171: int)
{

  entry:
    out_idx_5, out_Tmp_170, out_Tmp_171 := in_idx_5, in_Tmp_170, in_Tmp_171;
    goto L159, exit;

  exit:
    return;

  L159:
    goto anon143_Else;

  anon143_Else:
    assume {:partition} in_max_3 >= out_idx_5;
    out_Tmp_170 := out_idx_5;
    assume {:nonnull} in_Command_12 != 0;
    assume in_Command_12 > 0;
    havoc out_Tmp_171;
    assume {:nonnull} out_Tmp_171 != 0;
    assume out_Tmp_171 > 0;
    goto anon169_Then;

  anon169_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_171 + out_Tmp_170 * 4];
    out_idx_5 := out_idx_5 + 1;
    goto anon169_Then_dummy;

  anon169_Then_dummy:
    call {:si_unique_call 1564} {:si_old_unique_call 1} out_idx_5, out_Tmp_170, out_Tmp_171 := AvcResponseCompletion_sdv_static_function_7#1_loop_L159(out_idx_5, out_Tmp_170, out_Tmp_171, in_Command_12, in_max_3, in_Opcode_3);
    return;
}



procedure {:LoopProcedure} AvcResponseCompletion_sdv_static_function_7#1_loop_L159(in_idx_5: int, in_Tmp_170: int, in_Tmp_171: int, in_Command_12: int, in_max_3: int, in_Opcode_3: int) returns (out_idx_5: int, out_Tmp_170: int, out_Tmp_171: int);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcResponseCompletion_sdv_static_function_7#1_loop_L80(in_Tmp_168: int, in_SubunitAddr_3: int, in_ResponseCode_1: int, in_idx_5: int, in_Tmp_170: int, in_Tmp_171: int, in_Tmp_172: int, in_idx_6: int, in_Tmp_174: int, in_sdv_107: int, in_max_1: int, in_Command_12: int, in_Tmp_175: int, in_max_2: int, in_Entry_5: int, in_OpcodesMatch_1: int, in_idx_7: int, in_max_3: int, in_Tmp_177: int, in_Tmp_179: int, in_Tmp_180: int, in_Opcode_3: int) returns (out_Tmp_168: int, out_idx_5: int, out_Tmp_170: int, out_Tmp_171: int, out_Tmp_172: int, out_idx_6: int, out_Tmp_174: int, out_sdv_107: int, out_max_1: int, out_Command_12: int, out_Tmp_175: int, out_max_2: int, out_Entry_5: int, out_OpcodesMatch_1: int, out_idx_7: int, out_max_3: int, out_Tmp_177: int, out_Tmp_179: int, out_Tmp_180: int)
{
  var vslice_dummy_var_124: int;

  entry:
    out_Tmp_168, out_idx_5, out_Tmp_170, out_Tmp_171, out_Tmp_172, out_idx_6, out_Tmp_174, out_sdv_107, out_max_1, out_Command_12, out_Tmp_175, out_max_2, out_Entry_5, out_OpcodesMatch_1, out_idx_7, out_max_3, out_Tmp_177, out_Tmp_179, out_Tmp_180 := in_Tmp_168, in_idx_5, in_Tmp_170, in_Tmp_171, in_Tmp_172, in_idx_6, in_Tmp_174, in_sdv_107, in_max_1, in_Command_12, in_Tmp_175, in_max_2, in_Entry_5, in_OpcodesMatch_1, in_idx_7, in_max_3, in_Tmp_177, in_Tmp_179, in_Tmp_180;
    goto L80, exit;

  exit:
    return;

  L80:
    goto anon121_Else;

  anon121_Else:
    out_Command_12 := out_Entry_5;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon167_Then, anon167_Else;

  anon167_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc vslice_dummy_var_124;
    call {:si_unique_call 1565} out_sdv_107 := AvcSubunitAddrsEqual(in_SubunitAddr_3, vslice_dummy_var_124);
    goto anon122_Then, anon122_Else;

  anon122_Else:
    assume {:partition} out_sdv_107 != 0;
    out_OpcodesMatch_1 := 0;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon168_Then, anon168_Else;

  anon168_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon153_Then, anon153_Else;

  anon153_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon152_Then, anon152_Else;

  anon152_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon151_Then, anon151_Else;

  anon151_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon150_Then, anon150_Else;

  anon150_Else:
    goto L97;

  L97:
    goto anon125_Then, anon125_Else;

  anon125_Else:
    assume {:partition} in_ResponseCode_1 != 8;
    goto anon160_Then, anon160_Else;

  anon160_Else:
    assume {:partition} in_ResponseCode_1 == 12;
    goto L147;

  L147:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon139_Then, anon139_Else;

  anon139_Else:
    out_Command_12 := 0;
    goto L119;

  L119:
    goto anon134_Then;

  anon134_Then:
    assume {:partition} out_Command_12 == 0;
    goto L86;

  L86:
    assume {:nonnull} out_Entry_5 != 0;
    assume out_Entry_5 > 0;
    havoc out_Entry_5;
    out_Command_12 := 0;
    goto L86_dummy;

  L86_dummy:
    call {:si_unique_call 1569} {:si_old_unique_call 1} out_Tmp_168, out_idx_5, out_Tmp_170, out_Tmp_171, out_Tmp_172, out_idx_6, out_Tmp_174, out_sdv_107, out_max_1, out_Command_12, out_Tmp_175, out_max_2, out_Entry_5, out_OpcodesMatch_1, out_idx_7, out_max_3, out_Tmp_177, out_Tmp_179, out_Tmp_180 := AvcResponseCompletion_sdv_static_function_7#1_loop_L80(out_Tmp_168, in_SubunitAddr_3, in_ResponseCode_1, out_idx_5, out_Tmp_170, out_Tmp_171, out_Tmp_172, out_idx_6, out_Tmp_174, out_sdv_107, out_max_1, out_Command_12, out_Tmp_175, out_max_2, out_Entry_5, out_OpcodesMatch_1, out_idx_7, out_max_3, out_Tmp_177, out_Tmp_179, out_Tmp_180, in_Opcode_3);
    return;

  anon139_Then:
    goto L119;

  anon160_Then:
    assume {:partition} in_ResponseCode_1 != 12;
    out_Command_12 := 0;
    goto L119;

  anon125_Then:
    assume {:partition} in_ResponseCode_1 == 8;
    goto L147;

  anon150_Then:
    out_Command_12 := 0;
    goto L119;

  anon151_Then:
    goto anon126_Then, anon126_Else;

  anon126_Else:
    assume {:partition} in_ResponseCode_1 != 8;
    goto anon163_Then, anon163_Else;

  anon163_Else:
    assume {:partition} in_ResponseCode_1 != 10;
    goto anon162_Then, anon162_Else;

  anon162_Else:
    assume {:partition} in_ResponseCode_1 != 13;
    goto anon161_Then, anon161_Else;

  anon161_Else:
    assume {:partition} in_ResponseCode_1 == 15;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon129_Then, anon129_Else;

  anon129_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon130_Then, anon130_Else;

  anon130_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_180;
    assume {:nonnull} out_Tmp_180 != 0;
    assume out_Tmp_180 > 0;
    out_max_1 := Mem_T.INT4[out_Tmp_180];
    out_idx_7 := 1;
    goto L110;

  L110:
    call {:si_unique_call 1568} out_Tmp_174, out_idx_7, out_Tmp_179 := AvcResponseCompletion_sdv_static_function_7#1_loop_L110(out_Tmp_174, out_max_1, out_Command_12, out_idx_7, out_Tmp_179, in_Opcode_3);
    goto L110_last;

  L110_last:
    goto anon132_Then, anon132_Else;

  anon132_Else:
    assume {:partition} out_max_1 >= out_idx_7;
    out_Tmp_179 := out_idx_7;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_174;
    assume {:nonnull} out_Tmp_174 != 0;
    assume out_Tmp_174 > 0;
    goto anon171_Then, anon171_Else;

  anon171_Else:
    assume {:partition} in_Opcode_3 == Mem_T.INT4[out_Tmp_174 + out_Tmp_179 * 4];
    out_OpcodesMatch_1 := 1;
    goto L111;

  L111:
    goto anon133_Then, anon133_Else;

  anon133_Else:
    assume {:partition} out_OpcodesMatch_1 != 0;
    goto L119;

  anon133_Then:
    assume {:partition} out_OpcodesMatch_1 == 0;
    out_Command_12 := 0;
    goto L119;

  anon171_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_174 + out_Tmp_179 * 4];
    out_idx_7 := out_idx_7 + 1;
    assume false;
    return;

  anon132_Then:
    assume {:partition} out_idx_7 > out_max_1;
    goto L111;

  anon130_Then:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon131_Then, anon131_Else;

  anon131_Else:
    out_OpcodesMatch_1 := 0;
    goto L355;

  L355:
    goto L111;

  anon131_Then:
    out_OpcodesMatch_1 := 1;
    goto L355;

  anon129_Then:
    out_Command_12 := 0;
    goto L119;

  anon161_Then:
    assume {:partition} in_ResponseCode_1 != 15;
    out_Command_12 := 0;
    goto L119;

  anon162_Then:
    assume {:partition} in_ResponseCode_1 == 13;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon128_Then, anon128_Else;

  anon128_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_177;
    assume {:nonnull} out_Tmp_177 != 0;
    assume out_Tmp_177 > 0;
    out_max_2 := Mem_T.INT4[out_Tmp_177];
    out_idx_6 := 1;
    goto L136;

  L136:
    call {:si_unique_call 1567} out_Tmp_168, out_Tmp_172, out_idx_6 := AvcResponseCompletion_sdv_static_function_7#1_loop_L136(out_Tmp_168, out_Tmp_172, out_idx_6, out_Command_12, out_max_2, in_Opcode_3);
    goto L136_last;

  L136_last:
    goto anon137_Then, anon137_Else;

  anon137_Else:
    assume {:partition} out_max_2 >= out_idx_6;
    out_Tmp_172 := out_idx_6;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_168;
    assume {:nonnull} out_Tmp_168 != 0;
    assume out_Tmp_168 > 0;
    goto anon170_Then, anon170_Else;

  anon170_Else:
    assume {:partition} in_Opcode_3 == Mem_T.INT4[out_Tmp_168 + out_Tmp_172 * 4];
    out_OpcodesMatch_1 := 1;
    goto L137;

  L137:
    goto anon138_Then, anon138_Else;

  anon138_Else:
    assume {:partition} out_OpcodesMatch_1 == 0;
    out_Command_12 := 0;
    goto L119;

  anon138_Then:
    assume {:partition} out_OpcodesMatch_1 != 0;
    goto L119;

  anon170_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_168 + out_Tmp_172 * 4];
    out_idx_6 := out_idx_6 + 1;
    assume false;
    return;

  anon137_Then:
    assume {:partition} out_idx_6 > out_max_2;
    goto L137;

  anon128_Then:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon136_Then, anon136_Else;

  anon136_Else:
    out_OpcodesMatch_1 := 0;
    goto L344;

  L344:
    goto L137;

  anon136_Then:
    out_OpcodesMatch_1 := 1;
    goto L344;

  anon163_Then:
    assume {:partition} in_ResponseCode_1 == 10;
    goto L100;

  L100:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon127_Then, anon127_Else;

  anon127_Else:
    out_Command_12 := 0;
    goto L119;

  anon127_Then:
    goto L119;

  anon126_Then:
    assume {:partition} in_ResponseCode_1 == 8;
    goto L100;

  anon152_Then:
    goto L97;

  anon153_Then:
    goto anon124_Then, anon124_Else;

  anon124_Else:
    assume {:partition} in_ResponseCode_1 != 8;
    goto anon159_Then, anon159_Else;

  anon159_Else:
    assume {:partition} in_ResponseCode_1 != 10;
    goto anon158_Then, anon158_Else;

  anon158_Else:
    assume {:partition} in_ResponseCode_1 != 11;
    goto anon157_Then, anon157_Else;

  anon157_Else:
    assume {:partition} in_ResponseCode_1 == 12;
    goto L153;

  L153:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon141_Then, anon141_Else;

  anon141_Else:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_175;
    assume {:nonnull} out_Tmp_175 != 0;
    assume out_Tmp_175 > 0;
    out_max_3 := Mem_T.INT4[out_Tmp_175];
    out_idx_5 := 1;
    goto L159;

  L159:
    call {:si_unique_call 1566} out_idx_5, out_Tmp_170, out_Tmp_171 := AvcResponseCompletion_sdv_static_function_7#1_loop_L159(out_idx_5, out_Tmp_170, out_Tmp_171, out_Command_12, out_max_3, in_Opcode_3);
    goto L159_last;

  L159_last:
    goto anon143_Then, anon143_Else;

  anon143_Else:
    assume {:partition} out_max_3 >= out_idx_5;
    out_Tmp_170 := out_idx_5;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    havoc out_Tmp_171;
    assume {:nonnull} out_Tmp_171 != 0;
    assume out_Tmp_171 > 0;
    goto anon169_Then, anon169_Else;

  anon169_Else:
    assume {:partition} in_Opcode_3 == Mem_T.INT4[out_Tmp_171 + out_Tmp_170 * 4];
    out_OpcodesMatch_1 := 1;
    goto L160;

  L160:
    goto anon144_Then, anon144_Else;

  anon144_Else:
    assume {:partition} out_OpcodesMatch_1 == 0;
    out_Command_12 := 0;
    goto L119;

  anon144_Then:
    assume {:partition} out_OpcodesMatch_1 != 0;
    goto L119;

  anon169_Then:
    assume {:partition} in_Opcode_3 != Mem_T.INT4[out_Tmp_171 + out_Tmp_170 * 4];
    out_idx_5 := out_idx_5 + 1;
    assume false;
    return;

  anon143_Then:
    assume {:partition} out_idx_5 > out_max_3;
    goto L160;

  anon141_Then:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon142_Then, anon142_Else;

  anon142_Else:
    out_OpcodesMatch_1 := 0;
    goto L329;

  L329:
    goto L160;

  anon142_Then:
    out_OpcodesMatch_1 := 1;
    goto L329;

  anon157_Then:
    assume {:partition} in_ResponseCode_1 != 12;
    out_Command_12 := 0;
    goto L119;

  anon158_Then:
    assume {:partition} in_ResponseCode_1 == 11;
    goto L153;

  anon159_Then:
    assume {:partition} in_ResponseCode_1 == 10;
    goto L152;

  L152:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon140_Then, anon140_Else;

  anon140_Else:
    out_Command_12 := 0;
    goto L119;

  anon140_Then:
    goto L119;

  anon124_Then:
    assume {:partition} in_ResponseCode_1 == 8;
    goto L152;

  anon168_Then:
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume {:partition} in_ResponseCode_1 != 8;
    goto anon156_Then, anon156_Else;

  anon156_Else:
    assume {:partition} in_ResponseCode_1 != 9;
    goto anon155_Then, anon155_Else;

  anon155_Else:
    assume {:partition} in_ResponseCode_1 != 10;
    goto anon154_Then, anon154_Else;

  anon154_Else:
    assume {:partition} in_ResponseCode_1 == 15;
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon146_Then, anon146_Else;

  anon146_Else:
    goto L174;

  L174:
    out_Command_12 := 0;
    goto L119;

  anon146_Then:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon147_Then, anon147_Else;

  anon147_Else:
    goto L174;

  anon147_Then:
    goto L119;

  anon154_Then:
    assume {:partition} in_ResponseCode_1 != 15;
    out_Command_12 := 0;
    goto L119;

  anon155_Then:
    assume {:partition} in_ResponseCode_1 == 10;
    goto L171;

  L171:
    assume {:nonnull} out_Command_12 != 0;
    assume out_Command_12 > 0;
    goto anon145_Then, anon145_Else;

  anon145_Else:
    out_Command_12 := 0;
    goto L119;

  anon145_Then:
    goto L119;

  anon156_Then:
    assume {:partition} in_ResponseCode_1 == 9;
    goto L171;

  anon123_Then:
    assume {:partition} in_ResponseCode_1 == 8;
    goto L171;

  anon122_Then:
    assume {:partition} out_sdv_107 == 0;
    goto L86;

  anon167_Then:
    goto L86;
}



procedure {:LoopProcedure} AvcResponseCompletion_sdv_static_function_7#1_loop_L80(in_Tmp_168: int, in_SubunitAddr_3: int, in_ResponseCode_1: int, in_idx_5: int, in_Tmp_170: int, in_Tmp_171: int, in_Tmp_172: int, in_idx_6: int, in_Tmp_174: int, in_sdv_107: int, in_max_1: int, in_Command_12: int, in_Tmp_175: int, in_max_2: int, in_Entry_5: int, in_OpcodesMatch_1: int, in_idx_7: int, in_max_3: int, in_Tmp_177: int, in_Tmp_179: int, in_Tmp_180: int, in_Opcode_3: int) returns (out_Tmp_168: int, out_idx_5: int, out_Tmp_170: int, out_Tmp_171: int, out_Tmp_172: int, out_idx_6: int, out_Tmp_174: int, out_sdv_107: int, out_max_1: int, out_Command_12: int, out_Tmp_175: int, out_max_2: int, out_Entry_5: int, out_OpcodesMatch_1: int, out_idx_7: int, out_max_3: int, out_Tmp_177: int, out_Tmp_179: int, out_Tmp_180: int);
  free ensures out_sdv_107 == 1 || out_sdv_107 == 0 || out_sdv_107 == in_sdv_107;
  free ensures out_Command_12 == 0 || out_Command_12 == in_Command_12;
  free ensures out_OpcodesMatch_1 == 0 || out_OpcodesMatch_1 == 1 || out_OpcodesMatch_1 == in_OpcodesMatch_1;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcHandleUnitCommand_sdv_static_function_7#0_loop_L32(in_Tmp_202: int, in_Offset_3: int, in_VirtualDevExt: int, in_SubunitInfoBytes: int, in_Tmp_205: int, in_sdv_118: int, in_Entry_6: int, in_BytesUsed_4: int, in_Tmp_210: int) returns (out_Tmp_202: int, out_Offset_3: int, out_VirtualDevExt: int, out_Tmp_205: int, out_sdv_118: int, out_Entry_6: int, out_Tmp_210: int)
{

  entry:
    out_Tmp_202, out_Offset_3, out_VirtualDevExt, out_Tmp_205, out_sdv_118, out_Entry_6, out_Tmp_210 := in_Tmp_202, in_Offset_3, in_VirtualDevExt, in_Tmp_205, in_sdv_118, in_Entry_6, in_Tmp_210;
    goto L32, exit;

  exit:
    return;

  L32:
    goto anon17_Else;

  anon17_Else:
    call {:si_unique_call 1570} out_sdv_118 := sdv_containing_record(out_Entry_6, 72);
    out_VirtualDevExt := out_sdv_118;
    assume {:nonnull} in_BytesUsed_4 != 0;
    assume in_BytesUsed_4 > 0;
    Mem_T.INT4[in_BytesUsed_4] := 0;
    call {:si_unique_call 1571} sdv_KeAcquireSpinLockAtDpcLevel(0);
    out_Tmp_202 := out_Offset_3;
    out_Tmp_205 := in_SubunitInfoBytes + out_Tmp_202 * 4;
    out_Tmp_210 := 32 - out_Offset_3;
    call {:si_unique_call 1572} AvcPackSubunitInfo(out_VirtualDevExt, out_Tmp_210, out_Tmp_205, in_BytesUsed_4);
    assume {:nonnull} in_BytesUsed_4 != 0;
    assume in_BytesUsed_4 > 0;
    out_Offset_3 := out_Offset_3 + Mem_T.INT4[in_BytesUsed_4];
    call {:si_unique_call 1573} sdv_KeReleaseSpinLockFromDpcLevel(0);
    assume {:nonnull} out_Entry_6 != 0;
    assume out_Entry_6 > 0;
    havoc out_Entry_6;
    goto anon17_Else_dummy;

  anon17_Else_dummy:
    call {:si_unique_call 1574} {:si_old_unique_call 1} out_Tmp_202, out_Offset_3, out_VirtualDevExt, out_Tmp_205, out_sdv_118, out_Entry_6, out_Tmp_210 := AvcHandleUnitCommand_sdv_static_function_7#0_loop_L32(out_Tmp_202, out_Offset_3, out_VirtualDevExt, in_SubunitInfoBytes, out_Tmp_205, out_sdv_118, out_Entry_6, in_BytesUsed_4, out_Tmp_210);
    return;
}



procedure {:LoopProcedure} AvcHandleUnitCommand_sdv_static_function_7#0_loop_L32(in_Tmp_202: int, in_Offset_3: int, in_VirtualDevExt: int, in_SubunitInfoBytes: int, in_Tmp_205: int, in_sdv_118: int, in_Entry_6: int, in_BytesUsed_4: int, in_Tmp_210: int) returns (out_Tmp_202: int, out_Offset_3: int, out_VirtualDevExt: int, out_Tmp_205: int, out_sdv_118: int, out_Entry_6: int, out_Tmp_210: int);
  modifies Mem_T.INT4, alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_current == old(sdv_irql_current);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation AvcHandleUnitCommand_sdv_static_function_7#1_loop_L32(in_Tmp_202: int, in_Offset_3: int, in_VirtualDevExt: int, in_SubunitInfoBytes: int, in_Tmp_205: int, in_sdv_118: int, in_Entry_6: int, in_BytesUsed_4: int, in_Tmp_210: int) returns (out_Tmp_202: int, out_Offset_3: int, out_VirtualDevExt: int, out_Tmp_205: int, out_sdv_118: int, out_Entry_6: int, out_Tmp_210: int)
{

  entry:
    out_Tmp_202, out_Offset_3, out_VirtualDevExt, out_Tmp_205, out_sdv_118, out_Entry_6, out_Tmp_210 := in_Tmp_202, in_Offset_3, in_VirtualDevExt, in_Tmp_205, in_sdv_118, in_Entry_6, in_Tmp_210;
    goto L32, exit;

  exit:
    return;

  L32:
    goto anon17_Else;

  anon17_Else:
    call {:si_unique_call 1575} out_sdv_118 := sdv_containing_record(out_Entry_6, 72);
    out_VirtualDevExt := out_sdv_118;
    assume {:nonnull} in_BytesUsed_4 != 0;
    assume in_BytesUsed_4 > 0;
    Mem_T.INT4[in_BytesUsed_4] := 0;
    call {:si_unique_call 1576} sdv_KeAcquireSpinLockAtDpcLevel(0);
    out_Tmp_202 := out_Offset_3;
    out_Tmp_205 := in_SubunitInfoBytes + out_Tmp_202 * 4;
    out_Tmp_210 := 32 - out_Offset_3;
    call {:si_unique_call 1577} AvcPackSubunitInfo(out_VirtualDevExt, out_Tmp_210, out_Tmp_205, in_BytesUsed_4);
    assume {:nonnull} in_BytesUsed_4 != 0;
    assume in_BytesUsed_4 > 0;
    out_Offset_3 := out_Offset_3 + Mem_T.INT4[in_BytesUsed_4];
    call {:si_unique_call 1578} sdv_KeReleaseSpinLockFromDpcLevel(0);
    assume {:nonnull} out_Entry_6 != 0;
    assume out_Entry_6 > 0;
    havoc out_Entry_6;
    goto anon17_Else_dummy;

  anon17_Else_dummy:
    call {:si_unique_call 1579} {:si_old_unique_call 1} out_Tmp_202, out_Offset_3, out_VirtualDevExt, out_Tmp_205, out_sdv_118, out_Entry_6, out_Tmp_210 := AvcHandleUnitCommand_sdv_static_function_7#1_loop_L32(out_Tmp_202, out_Offset_3, out_VirtualDevExt, in_SubunitInfoBytes, out_Tmp_205, out_sdv_118, out_Entry_6, in_BytesUsed_4, out_Tmp_210);
    return;
}



procedure {:LoopProcedure} AvcHandleUnitCommand_sdv_static_function_7#1_loop_L32(in_Tmp_202: int, in_Offset_3: int, in_VirtualDevExt: int, in_SubunitInfoBytes: int, in_Tmp_205: int, in_sdv_118: int, in_Entry_6: int, in_BytesUsed_4: int, in_Tmp_210: int) returns (out_Tmp_202: int, out_Offset_3: int, out_VirtualDevExt: int, out_Tmp_205: int, out_sdv_118: int, out_Entry_6: int, out_Tmp_210: int);
  modifies Mem_T.INT4, alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;
  free ensures old(sdv_irql_current) == sdv_irql_current;
  free ensures old(sdv_irql_previous) == sdv_irql_previous;
  free ensures sdv_irql_previous_5 == old(sdv_irql_previous_5) || sdv_irql_previous_5 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_2 == old(sdv_irql_previous_2);
  free ensures sdv_irql_current == old(sdv_irql_current);
  free ensures sdv_irql_previous == old(sdv_irql_previous);
  free ensures sdv_irql_previous_4 == old(sdv_irql_previous_4);
  free ensures sdv_irql_previous_3 == old(sdv_irql_previous_3);
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



procedure fakeMain() returns (Tmp_294: int, dup_assertVar: bool);
  modifies alloc, SLAM_guard_S_0, yogi_error, Mem_T.INT4, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:entrypoint} fakeMain() returns (Tmp_294: int, dup_assertVar: bool)
{

  start:
    call Tmp_294, dup_assertVar := main();
    assume {:OldAssert} !dup_assertVar;
    return;
}


