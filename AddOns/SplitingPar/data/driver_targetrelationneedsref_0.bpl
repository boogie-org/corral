var {:scalar} alloc: int;

var {:scalar} ref: int;

var {:scalar} yogi_error: int;

var {:scalar} passed_on: int;

var {:pointer} SLAM_guard_S_0: int;

var {:scalar} in_pnp: int;

var {:scalar} sdv_end_info: int;

var {:scalar} sdv_start_info: int;

var {:scalar} Mem_T.CurrentStackLocation_unnamed_tag_6: [int]int;

var {:scalar} Mem_T.Information__IO_STATUS_BLOCK: [int]int;

var {:scalar} Mem_T.MinorFunction__IO_STACK_LOCATION: [int]int;

var {:scalar} Mem_T.Status__IO_STATUS_BLOCK: [int]int;

var {:scalar} Mem_T.Type_unnamed_tag_26: [int]int;

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

const WHEA_ERROR_PACKET_SECTION_GUID: int;

const sdv_cancelFptr: int;

const SLAM_guard_S_0_init: int;

const sdv_IoBuildSynchronousFsdRequest_irp: int;

const sdv_harnessStackLocation_next: int;

const sdv_other_irp: int;

const sdv_IoBuildDeviceIoControlRequest_irp: int;

const sdv_harnessDeviceExtension_two: int;

const sdv_context: int;

const sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock: int;

const sdv_pv3: int;

const sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX: int;

const sdv_compFset: int;

const sdv_IoBuildAsynchronousFsdRequest_harnessIrp: int;

const sdv_kdpc3: int;

const sdv_p_devobj_pdo: int;

const sdv_invoke_on_error: int;

const sdv_kinterrupt: int;

const sdv_IoGetDeviceToVerify_DEVICE_OBJECT: int;

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

const sdv_invoke_on_cancel: int;

const sdv_isr_routine: int;

const sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT: int;

const sdv_irp: int;

const sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next: int;

const sdv_IoCreateSynchronizationEvent_KEVENT: int;

const sdv_ControllerPirp: int;

const sdv_harnessStackLocation: int;

const sdv_other_harnessStackLocation_next: int;

const sdv_IoCreateController_CONTROLLER_OBJECT: int;

const sdv_invoke_on_success: int;

const sdv_devobj_top: int;

const sdv_pv2: int;

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

const sdv_IoInitializeIrp_irp: int;

const sdv_IoCreateNotificationEvent_KEVENT: int;

const sdv_other_harnessStackLocation: int;

const sdv_maskedEflags: int;

const sdv_MmMapIoSpace_int: int;

const GUID_TRANSLATOR_INTERFACE_STANDARD: int;

const GUID_LIDOPEN_POWERSTATE: int;

const GUID_PROCESSOR_PARKING_CORE_OVERRIDE: int;

const GUID_PCIEXPRESS_SETTINGS_SUBGROUP: int;

const GUID_ARBITER_INTERFACE_STANDARD: int;

const GUID_PROCESSOR_PERF_INCREASE_TIME: int;

const MOUNTDEV_MOUNTED_DEVICE_GUID: int;

const GUID_DEVINTERFACE_STORAGEPORT: int;

const GUID_IO_DEVICE_EXTERNAL_REQUEST: int;

const VSP_DIAG_DISCOVER_SNAPSHOTS_ENTER: int;

const VSP_DIAG_PRE_EXPOSURE_ENTER: int;

const GUID_DEVINTERFACE_CDCHANGER: int;

const GUID_IO_VOLUME_NAME_CHANGE: int;

const GUID_IO_DEVICE_BECOMING_READY: int;

const GUID_MF_ENUMERATION_INTERFACE: int;

const GUID_ALLOW_RTC_WAKE: int;

const GUID_LEGACY_DEVICE_DETECTION_STANDARD: int;

const VSP_DIAG_PREPARE_LEAVE: int;

const GUID_BATTERY_DISCHARGE_LEVEL_2: int;

const GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD: int;

const GUID_IO_VOLUME_NEED_CHKDSK: int;

const GUID_PNP_POWER_SETTING_CHANGE: int;

const GUID_MONITOR_POWER_ON: int;

const VSP_DIAG_DISMOUNT_LEAVE: int;

const GUID_ACPI_REGS_INTERFACE_STANDARD: int;

const GUID_IO_DISK_LAYOUT_CHANGE: int;

const GUID_PARTITION_UNIT_INTERFACE_STANDARD: int;

const GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD: int;

const GUID_ACDC_POWER_SOURCE: int;

const GUID_IO_VOLUME_INFO_MAKE_COMPAT: int;

const GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME: int;

const GUID_PROCESSOR_THROTTLE_MINIMUM: int;

const GUID_ALLOW_AWAYMODE: int;

const GUID_DEVINTERFACE_TAPE: int;

const VSP_DIAG_REVERT_LEAVE: int;

const GUID_DISK_ADAPTIVE_POWERDOWN: int;

const GUID_SYSTEM_BUTTON_SUBGROUP: int;

const VSP_DIAG_END_COMMIT_LEAVE: int;

const GUID_SYSTEM_COOLING_POLICY: int;

const PARTITION_MSFT_RESERVED_GUID: int;

const GUID_BATTERY_DISCHARGE_LEVEL_3: int;

const GUID_BUS_TYPE_PCI: int;

const GUID_ALLOW_SYSTEM_REQUIRED: int;

const GUID_TARGET_DEVICE_QUERY_REMOVE: int;

const GUID_DEVINTERFACE_HIDDEN_VOLUME: int;

const GUID_PCI_BUS_INTERFACE_STANDARD: int;

const GUID_HWPROFILE_QUERY_CHANGE: int;

const VSP_DIAG_SET_IGNORABLE_LEAVE: int;

const GUID_LOCK_CONSOLE_ON_WAKE: int;

const VSP_DIAG_FLUSH_HOLD_FS_LEAVE: int;

const GUID_VIDEO_POWERDOWN_TIMEOUT: int;

const VSP_DIAG_ADJUST_BITMAP_LEAVE: int;

const GUID_IO_VOLUME_DISMOUNT: int;

const GUID_PROCESSOR_IDLESTATE_POLICY: int;

const GUID_IO_VOLUME_PREPARING_EJECT: int;

const GUID_REENUMERATE_SELF_INTERFACE_STANDARD: int;

const GUID_ALLOW_DISPLAY_REQUIRED: int;

const GUID_UNATTEND_SLEEP_TIMEOUT: int;

const GUID_CRITICAL_POWER_TRANSITION: int;

const GUID_SLEEP_IDLE_THRESHOLD: int;

const GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY: int;

const GUID_IO_VOLUME_DISMOUNT_FAILED: int;

const VSP_DIAG_ACTIVATE_LEAVE: int;

const GUID_PROCESSOR_THROTTLE_MAXIMUM: int;

const PARTITION_BASIC_DATA_GUID: int;

const GUID_PROCESSOR_PARKING_PERF_STATE: int;

const GUID_PROCESSOR_PERF_DECREASE_POLICY: int;

const VSP_DIAG_FLUSH_HOLD_FS_ENTER: int;

const PARTITION_ENTRY_UNUSED_GUID: int;

const VSP_DIAG_ACTIVATE_ENTER: int;

const VOLSNAP_APPINFO_GUID_SYSTEM_HIDDEN: int;

const GUID_AGP_TARGET_BUS_INTERFACE_STANDARD: int;

const GUID_IO_VOLUME_FORCE_CLOSED: int;

const GUID_ALLOW_STANDBY_STATES: int;

const VSP_DIAG_PROTECTED_BITMAP_ENTER: int;

const VIRTUAL_STORAGE_TYPE_VENDOR_MICROSOFT: int;

const GUID_STANDBY_TIMEOUT: int;

const GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD: int;

const VSP_DIAG_SET_IGNORABLE_ENTER: int;

const GUID_PROCESSOR_PERFSTATE_POLICY: int;

const VSP_DIAG_DISCOVER_SNAPSHOTS_LEAVE: int;

const GUID_IO_VOLUME_LOCK: int;

const GUID_BUS_INTERFACE_STANDARD: int;

const GUID_IO_VOLUME_DEVICE_INTERFACE: int;

const GUID_IO_VOLUME_WEARING_OUT: int;

const GUID_BATTERY_DISCHARGE_ACTION_1: int;

const GUID_IO_VOLUME_BACKGROUND_FORMAT: int;

const GUID_ACPI_INTERFACE_STANDARD2: int;

const GUID_PROCESSOR_PERF_INCREASE_POLICY: int;

const VSP_DIAG_DELETE_PROCESS_LEAVE: int;

const GUID_VIDEO_SUBGROUP: int;

const PARTITION_CLUSTER_GUID: int;

const GUID_IO_CDROM_EXCLUSIVE_LOCK: int;

const GUID_TYPICAL_POWER_SAVINGS: int;

const GUID_HIBERNATE_FASTS4_POLICY: int;

const GUID_IO_VOLUME_UNIQUE_ID_CHANGE: int;

const GUID_DEVICE_INTERFACE_REMOVAL: int;

const GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR: int;

const GUID_PCI_DEVICE_PRESENT_INTERFACE: int;

const GUID_POWER_DEVICE_TIMEOUTS: int;

const GUID_MSIX_TABLE_CONFIG_INTERFACE: int;

const GUID_PROCESSOR_SETTINGS_SUBGROUP: int;

const GUID_HWPROFILE_CHANGE_COMPLETE: int;

const IoFileObjectType: int;

const GUID_IO_MEDIA_ARRIVAL: int;

const GUID_BUS_TYPE_AVC: int;

const VSP_DIAG_DELETE_PROCESS_ENTER: int;

const GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS: int;

const GUID_BATTERY_DISCHARGE_FLAGS_2: int;

const VSP_DIAG_ACTIVATE_LOOP_ENTER: int;

const GUID_DEVINTERFACE_VOLUME: int;

const GUID_DEVICE_EVENT_RBC: int;

const GUID_HIBERNATE_TIMEOUT: int;

const GUID_DEVINTERFACE_MEDIUMCHANGER: int;

const GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD: int;

const GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME: int;

const GUID_SESSION_DISPLAY_STATE: int;

const GUID_BATTERY_DISCHARGE_ACTION_3: int;

const GUID_POWER_DEVICE_ENABLE: int;

const GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE: int;

const GUID_PROCESSOR_CORE_PARKING_MIN_CORES: int;

const GUID_PNP_CUSTOM_NOTIFICATION: int;

const GUID_IO_VOLUME_UNLOCK: int;

const GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD: int;

const GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR: int;

const ntAuthority: int;

const GUID_ACPI_INTERFACE_STANDARD: int;

const GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING: int;

const PARTITION_SYSTEM_GUID: int;

const GUID_SLEEPBUTTON_ACTION_FLAGS: int;

const PARTITION_LDM_DATA_GUID: int;

const GUID_POWERBUTTON_ACTION: int;

const PARTITION_MSFT_RECOVERY_GUID: int;

const GUID_ACPI_CMOS_INTERFACE_STANDARD: int;

const GUID_USERINTERFACEBUTTON_ACTION: int;

const GUID_PROCESSOR_THROTTLE_POLICY: int;

const GUID_PCIEXPRESS_ASPM_POLICY: int;

const GUID_DEVINTERFACE_WRITEONCEDISK: int;

const GUID_BUS_TYPE_ISAPNP: int;

const GUID_BATTERY_PERCENTAGE_REMAINING: int;

const GUID_BATTERY_DISCHARGE_ACTION_2: int;

const GUID_APPLAUNCH_BUTTON: int;

const GUID_BATTERY_DISCHARGE_FLAGS_1: int;

const GUID_PROCESSOR_ALLOW_THROTTLING: int;

const VSP_DIAG_END_COMMIT_ENTER: int;

const VSP_DIAG_REMOUNT_LEAVE: int;

const DATAID_VSP_PRI_VIOLATION_COUNT: int;

const GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE: int;

const GUID_BUS_TYPE_DOT4PRT: int;

const VSP_DIAG_IGNORABLE_PRODUCT_ENTER: int;

const GUID_BUS_TYPE_EISA: int;

const GUID_DISK_BURST_IGNORE_THRESHOLD: int;

const GUID_SLEEPBUTTON_ACTION: int;

const GUID_PROCESSOR_IDLE_DISABLE: int;

const GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED: int;

const GUID_BUS_TYPE_IRDA: int;

const GUID_DISK_POWERDOWN_TIMEOUT: int;

const GUID_CONSOLE_DISPLAY_STATE: int;

const GUID_BATTERY_DISCHARGE_FLAGS_0: int;

const VSP_DIAG_ACTIVATE_LOOP_LEAVE: int;

const VIRTUAL_STORAGE_TYPE_VENDOR_UNKNOWN: int;

const GUID_BUS_TYPE_MCA: int;

const GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS: int;

const GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD: int;

const KeTickCount: int;

const GUID_PNP_LOCATION_INTERFACE: int;

const GUID_BUS_TYPE_INTERNAL: int;

const GUID_IO_VOLUME_PHYSICAL_CONFIGURATION_CHANGE: int;

const GUID_IO_DISK_CLONE_ARRIVAL: int;

const GUID_DEVINTERFACE_FLOPPY: int;

const GUID_IO_TAPE_ERASE: int;

const SeExports: int;

const VSP_DIAG_PREPARE_ENTER: int;

const VSP_DIAG_PROTECTED_BITMAP_LEAVE: int;

const NO_SUBGROUP_GUID: int;

const GUID_PROCESSOR_PCC_INTERFACE_STANDARD: int;

const ALL_POWERSCHEMES_GUID: int;

const GUID_LIDSWITCH_STATE_CHANGE: int;

const GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY: int;

const GUID_DEVINTERFACE_PARTITION: int;

const VSP_DIAG_ADJUST_BITMAP_ENTER: int;

const GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS: int;

const GUID_PROCESSOR_IDLE_ALLOW_SCALING: int;

const GUID_LIDCLOSE_ACTION_FLAGS: int;

const GUID_IO_MEDIA_REMOVAL: int;

const GUID_BUS_TYPE_SD: int;

const GUID_PNP_POWER_NOTIFICATION: int;

const GUID_IO_MEDIA_EJECT_REQUEST: int;

const GUID_PROCESSOR_IDLE_TIME_CHECK: int;

const GUID_BUS_TYPE_HID: int;

const GUID_TARGET_DEVICE_REMOVE_COMPLETE: int;

const GUID_PROCESSOR_PERF_INCREASE_THRESHOLD: int;

const GUID_BACKGROUND_TASK_NOTIFICATION: int;

const GUID_POWER_DEVICE_WAKE_ENABLE: int;

const GUID_PROCESSOR_PERF_HISTORY: int;

const GUID_PCMCIA_BUS_INTERFACE_STANDARD: int;

const GUID_BUS_TYPE_PCMCIA: int;

const GUID_VIDEO_ANNOYANCE_TIMEOUT: int;

const GUID_BATTERY_DISCHARGE_FLAGS_3: int;

const GUID_PROCESSOR_CORE_PARKING_MAX_CORES: int;

const VOLSNAP_APPINFO_GUID_CLIENT_ACCESSIBLE: int;

const GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE: int;

const GUID_VIDEO_ADAPTIVE_POWERDOWN: int;

const GUID_BUS_TYPE_1394: int;

const GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD: int;

const GUID_TARGET_DEVICE_REMOVE_CANCELLED: int;

const GUID_MIN_POWER_SAVINGS: int;

const GUID_DEVICE_IDLE_POLICY: int;

const GUID_PROCESSOR_PERF_BOOST_POLICY: int;

const VSP_DIAG_PRE_EXPOSURE_LEAVE: int;

const GUID_LIDCLOSE_ACTION: int;

const VSP_DIAG_VALIDATE_FILES_LEAVE: int;

const GUID_IO_VOLUME_MOUNT: int;

const GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS: int;

const GUID_DEVINTERFACE_CDROM: int;

const VSP_DIAG_DISMOUNT_ENTER: int;

const GUID_DEVINTERFACE_DISK: int;

const GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD: int;

const GUID_SLEEP_SUBGROUP: int;

const GUID_POWERBUTTON_ACTION_FLAGS: int;

const GUID_PROCESSOR_PERF_DECREASE_TIME: int;

const GUID_IO_VOLUME_WORM_NEAR_FULL: int;

const VSP_DIAG_VALIDATE_FILES_ENTER: int;

const GUID_MAX_POWER_SAVINGS: int;

const GUID_WUDF_DEVICE_HOST_PROBLEM: int;

const GUID_BATTERY_SUBGROUP: int;

const GUID_IO_VOLUME_FVE_STATUS_CHANGE: int;

const GUID_BUS_TYPE_SERENUM: int;

const VSP_DIAG_VOLUME_SAFE_LEAVE: int;

const GUID_HWPROFILE_CHANGE_CANCELLED: int;

const GUID_BUS_TYPE_LPTENUM: int;

const PARTITION_LDM_METADATA_GUID: int;

const GUID_DEVICE_INTERFACE_ARRIVAL: int;

const GUID_IO_VOLUME_CHANGE_SIZE: int;

const GUID_IDLE_BACKGROUND_TASK: int;

const GUID_DISK_SUBGROUP: int;

const VSP_DIFF_AREA_FILE_GUID: int;

const VSP_DIAG_REVERT_ENTER: int;

const GUID_IO_CDROM_EXCLUSIVE_UNLOCK: int;

const GUID_BUS_TYPE_USB: int;

const GUID_POWERSCHEME_PERSONALITY: int;

const GUID_IO_DRIVE_REQUIRES_CLEANING: int;

const VSP_DIAG_VOLUME_SAFE_ENTER: int;

const GUID_INT_ROUTE_INTERFACE_STANDARD: int;

const GUID_BATTERY_DISCHARGE_LEVEL_1: int;

const GUID_IO_VOLUME_CHANGE: int;

const GUID_IO_VOLUME_LOCK_FAILED: int;

const GUID_BUS_TYPE_USBPRINT: int;

const GUID_BATTERY_DISCHARGE_ACTION_0: int;

const GUID_ENABLE_SWITCH_FORCED_SHUTDOWN: int;

const VSP_DIAG_IGNORABLE_PRODUCT_LEAVE: int;

const GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING: int;

const GUID_PROCESSOR_PERF_DECREASE_THRESHOLD: int;

const GUID_BATTERY_DISCHARGE_LEVEL_0: int;

const GUID_VIDEO_DIM_TIMEOUT: int;

const GUID_ACTIVE_POWERSCHEME: int;

const GUID_SYSTEM_AWAYMODE: int;

const VSP_DIAG_REMOUNT_ENTER: int;

const VOLSNAP_DIAG_TRACE_PROVIDER: int;

const GUID_PROCESSOR_PERF_TIME_CHECK: int;

procedure {:origName "_sdv_init2"} _sdv_init2();
  modifies alloc;



implementation {:origName "_sdv_init2"} _sdv_init2()
{
  var vslice_dummy_var_0: int;

  anon0:
    call {:si_unique_call 0} vslice_dummy_var_0 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "VspFreeBitMap"} VspFreeBitMap(actual_BitMap: int);
  modifies alloc;



implementation {:origName "VspFreeBitMap"} VspFreeBitMap(actual_BitMap: int)
{
  var {:scalar} i: int;
  var {:scalar} Tmp_2: int;
  var {:pointer} Tmp_4: int;
  var {:pointer} Tmp_5: int;
  var {:scalar} Tmp_6: int;
  var {:pointer} Tmp_7: int;
  var {:scalar} Tmp_9: int;
  var {:pointer} BitMap: int;
  var vslice_dummy_var_1: int;

  anon0:
    call {:si_unique_call 1} vslice_dummy_var_1 := __HAVOC_malloc(4);
    BitMap := actual_BitMap;
    i := 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} BitMap != 0;
    assume {:nonnull} BitMap != 0;
    assume BitMap > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    i := 0;
    goto L9;

  L9:
    call {:si_unique_call 2} i, Tmp_2, Tmp_4, Tmp_5, Tmp_6, Tmp_7, Tmp_9 := VspFreeBitMap_loop_L9(i, Tmp_2, Tmp_4, Tmp_5, Tmp_6, Tmp_7, Tmp_9, BitMap);
    goto L9_last;

  L9_last:
    assume {:nonnull} BitMap != 0;
    assume BitMap > 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    Tmp_2 := i;
    assume {:nonnull} BitMap != 0;
    assume BitMap > 0;
    havoc Tmp_7;
    assume {:nonnull} Tmp_7 != 0;
    assume Tmp_7 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    Tmp_9 := i;
    assume {:nonnull} BitMap != 0;
    assume BitMap > 0;
    havoc Tmp_4;
    assume {:nonnull} Tmp_4 != 0;
    assume Tmp_4 > 0;
    call {:si_unique_call 3} ExFreePoolWithTag(0, 0);
    Tmp_6 := i;
    assume {:nonnull} BitMap != 0;
    assume BitMap > 0;
    havoc Tmp_5;
    assume {:nonnull} Tmp_5 != 0;
    assume Tmp_5 > 0;
    goto L14;

  L14:
    i := i + 1;
    goto L14_dummy;

  L14_dummy:
    assume false;
    return;

  anon12_Then:
    goto L14;

  anon10_Then:
    call {:si_unique_call 4} ExFreePoolWithTag(0, 0);
    assume {:nonnull} BitMap != 0;
    assume BitMap > 0;
    goto L1;

  L1:
    return;

  anon9_Then:
    goto L1;

  anon11_Then:
    assume {:partition} BitMap == 0;
    goto L1;
}



procedure {:origName "SLIC_ABORT_9_0"} SLIC_ABORT_9_0(actual_caller: int, actual_sdv: int, actual_sdv_1: int);
  modifies yogi_error;



implementation {:origName "SLIC_ABORT_9_0"} SLIC_ABORT_9_0(actual_caller: int, actual_sdv: int, actual_sdv_1: int)
{
  var {:pointer} caller: int;
  var {:pointer} sdv: int;
  var {:scalar} sdv_1: int;

  anon0:
    caller := actual_caller;
    sdv := actual_sdv;
    sdv_1 := actual_sdv_1;
    call {:si_unique_call 5} SLIC_ERROR_ROUTINE(strConst__li2bpl1);
    return;
}



procedure {:origName "SLIC_PoCallDriver_entry"} {:osmodel} SLIC_PoCallDriver_entry(actual_caller_2: int);
  modifies passed_on;
  free ensures old(passed_on) == 1 ==> passed_on != 0;
  free ensures old(passed_on) == 0 ==> passed_on != 0;
  free ensures passed_on == 1;
  free ensures false || old(passed_on) == 1 || old(passed_on) == 0;
  free ensures false || passed_on == 1 || passed_on == 0;



implementation {:origName "SLIC_PoCallDriver_entry"} {:osmodel} SLIC_PoCallDriver_entry(actual_caller_2: int)
{

  anon0:
    passed_on := 1;
    return;
}



procedure {:origName "_sdv_init7"} {:osmodel} _sdv_init7();
  modifies SLAM_guard_S_0, in_pnp, passed_on, ref, yogi_error;
  free ensures old(in_pnp) == 0 ==> in_pnp != 1;
  free ensures old(in_pnp) == 1 ==> in_pnp != 1;
  free ensures old(passed_on) == 1 ==> passed_on != 1;
  free ensures old(passed_on) == 0 ==> passed_on != 1;
  free ensures old(ref) == 0 ==> ref != 1;
  free ensures old(ref) == 1 ==> ref != 1;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures ref == 0;
  free ensures yogi_error == 0;
  free ensures passed_on == 0;
  free ensures in_pnp == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(in_pnp) == 0 || old(in_pnp) == 1;
  free ensures false || old(passed_on) == 1 || old(passed_on) == 0;
  free ensures false || old(ref) == 0 || old(ref) == 1;
  free ensures false || in_pnp == 0 || in_pnp == 1;
  free ensures false || passed_on == 1 || passed_on == 0;
  free ensures false || ref == 0 || ref == 1;



implementation {:origName "_sdv_init7"} {:osmodel} _sdv_init7()
{

  anon0:
    SLAM_guard_S_0 := SLAM_guard_S_0_init;
    in_pnp := 0;
    passed_on := 0;
    ref := 0;
    yogi_error := 0;
    assume sdv_cancelFptr == 0;
    return;
}



procedure {:origName "SLIC_sdv_RunDispatchFunction_entry"} {:osmodel} SLIC_sdv_RunDispatchFunction_entry(actual_caller_5: int);
  modifies passed_on, ref;
  free ensures old(passed_on) == 1 ==> passed_on != 1;
  free ensures old(passed_on) == 0 ==> passed_on != 1;
  free ensures old(ref) == 0 ==> ref != 1;
  free ensures old(ref) == 1 ==> ref != 1;
  free ensures ref == 0;
  free ensures passed_on == 0;
  free ensures false || old(passed_on) == 1 || old(passed_on) == 0;
  free ensures false || old(ref) == 0 || old(ref) == 1;
  free ensures false || passed_on == 1 || passed_on == 0;
  free ensures false || ref == 0 || ref == 1;



implementation {:origName "SLIC_sdv_RunDispatchFunction_entry"} {:osmodel} SLIC_sdv_RunDispatchFunction_entry(actual_caller_5: int)
{

  anon0:
    passed_on := 0;
    ref := 0;
    return;
}



procedure {:origName "SLIC_sdv_RunDispatchFunction_exit"} {:osmodel} SLIC_sdv_RunDispatchFunction_exit(actual_caller_6: int, actual_sdv_2: int, actual_sdv_3: int);
  modifies yogi_error;
  free ensures old(in_pnp) == 0 ==> yogi_error == 0;
  free ensures old(passed_on) == 1 ==> yogi_error == 0;
  free ensures old(ref) == 1 ==> yogi_error == 0;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(in_pnp) == 0 || old(in_pnp) == 1;
  free ensures false || old(passed_on) == 1 || old(passed_on) == 0;
  free ensures false || old(ref) == 0 || old(ref) == 1;
  free ensures false || in_pnp == 0 || in_pnp == 1;
  free ensures false || passed_on == 1 || passed_on == 0;
  free ensures false || ref == 0 || ref == 1;



implementation {:origName "SLIC_sdv_RunDispatchFunction_exit"} {:osmodel} SLIC_sdv_RunDispatchFunction_exit(actual_caller_6: int, actual_sdv_2: int, actual_sdv_3: int)
{
  var {:pointer} Tmp_11: int;
  var {:pointer} Tmp_12: int;
  var {:pointer} Tmp_13: int;
  var {:pointer} caller_6: int;
  var {:pointer} sdv_2: int;
  var {:scalar} sdv_3: int;

  anon0:
    caller_6 := actual_caller_6;
    sdv_2 := actual_sdv_2;
    sdv_3 := actual_sdv_3;
    assume {:nonnull} sdv_2 != 0;
    assume sdv_2 > 0;
    Tmp_11 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_2)))];
    assume {:nonnull} sdv_2 != 0;
    assume sdv_2 > 0;
    Tmp_13 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_2)))];
    assume {:nonnull} sdv_2 != 0;
    assume sdv_2 > 0;
    Tmp_12 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_2)))];
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} in_pnp == 1;
    assume {:nonnull} Tmp_12 != 0;
    assume Tmp_12 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:nonnull} Tmp_13 != 0;
    assume Tmp_13 > 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(Tmp_13)] == 7;
    assume {:nonnull} Tmp_11 != 0;
    assume Tmp_11 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(Tmp_11)))] == 4;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} 0 <= sdv_3;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} passed_on == 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} ref == 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} sdv_start_info != sdv_end_info;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} sdv_end_info != 0;
    call {:si_unique_call 6} SLIC_ABORT_9_0(caller_6, sdv_2, sdv_3);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto L2;

  L2:
    goto LM2;

  LM2:
    return;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon21_Then:
    assume {:partition} sdv_end_info == 0;
    goto L2;

  anon22_Then:
    assume {:partition} sdv_start_info == sdv_end_info;
    goto L2;

  anon23_Then:
    assume {:partition} ref != 0;
    goto L2;

  anon24_Then:
    assume {:partition} passed_on != 0;
    goto L2;

  anon25_Then:
    assume {:partition} sdv_3 < 0;
    goto L2;

  anon26_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(Tmp_11)))] != 4;
    goto L2;

  anon27_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(Tmp_13)] != 7;
    goto L2;

  anon28_Then:
    goto L2;

  anon29_Then:
    assume {:partition} in_pnp != 1;
    goto L2;
}



procedure {:origName "SLIC_VolSnapPnp_entry"} {:osmodel} SLIC_VolSnapPnp_entry(actual_caller_7: int);
  modifies in_pnp;
  free ensures old(in_pnp) == 0 ==> in_pnp != 0;
  free ensures old(in_pnp) == 1 ==> in_pnp != 0;
  free ensures in_pnp == 1;
  free ensures false || old(in_pnp) == 0 || old(in_pnp) == 1;
  free ensures false || in_pnp == 0 || in_pnp == 1;



implementation {:origName "SLIC_VolSnapPnp_entry"} {:osmodel} SLIC_VolSnapPnp_entry(actual_caller_7: int)
{

  anon0:
    in_pnp := 1;
    return;
}



procedure {:origName "SLIC_ObReferenceObjectByHandle_entry"} {:osmodel} SLIC_ObReferenceObjectByHandle_entry(actual_caller_8: int);
  modifies ref;
  free ensures old(ref) == 0 ==> ref != 0;
  free ensures old(ref) == 1 ==> ref != 0;
  free ensures ref == 1;
  free ensures false || old(ref) == 0 || old(ref) == 1;
  free ensures false || ref == 0 || ref == 1;



implementation {:origName "SLIC_ObReferenceObjectByHandle_entry"} {:osmodel} SLIC_ObReferenceObjectByHandle_entry(actual_caller_8: int)
{

  anon0:
    ref := 1;
    return;
}



procedure {:origName "SLIC_ERROR_ROUTINE"} SLIC_ERROR_ROUTINE(actual_msg: int);
  modifies yogi_error;
  free ensures yogi_error == 1;
  free ensures old(yogi_error) == 0;



implementation {:origName "SLIC_ERROR_ROUTINE"} SLIC_ERROR_ROUTINE(actual_msg: int)
{

  anon0:
    yogi_error := 1;
    return;
}



procedure {:origName "SLIC_ObfReferenceObject_entry"} {:osmodel} SLIC_ObfReferenceObject_entry(actual_caller_9: int);
  modifies ref;
  free ensures old(ref) == 0 ==> ref != 0;
  free ensures old(ref) == 1 ==> ref != 0;
  free ensures ref == 1;
  free ensures false || old(ref) == 0 || old(ref) == 1;
  free ensures false || ref == 0 || ref == 1;



implementation {:origName "SLIC_ObfReferenceObject_entry"} {:osmodel} SLIC_ObfReferenceObject_entry(actual_caller_9: int)
{

  anon0:
    ref := 1;
    return;
}



procedure {:origName "_sdv_init3"} _sdv_init3();
  modifies alloc;



implementation {:origName "_sdv_init3"} _sdv_init3()
{
  var vslice_dummy_var_2: int;

  anon0:
    call {:si_unique_call 7} vslice_dummy_var_2 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IofCompleteRequest"} {:osmodel} IofCompleteRequest(actual_pirp: int, actual_PriorityBoost: int);
  modifies alloc;



implementation {:origName "IofCompleteRequest"} {:osmodel} IofCompleteRequest(actual_pirp: int, actual_PriorityBoost: int)
{
  var vslice_dummy_var_3: int;

  anon0:
    call {:si_unique_call 8} vslice_dummy_var_3 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KfAcquireSpinLock"} {:osmodel} KfAcquireSpinLock(actual_SpinLock: int) returns (Tmp_66: int);



implementation {:origName "KfAcquireSpinLock"} {:osmodel} KfAcquireSpinLock(actual_SpinLock: int) returns (Tmp_66: int)
{

  anon0:
    havoc Tmp_66;
    return;
}



procedure {:origName "sdv_RunAddDevice"} {:osmodel} sdv_RunAddDevice(actual_p1: int, actual_p2: int) returns (Tmp_68: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26;
  free ensures Tmp_68 == 0 || Tmp_68 == -1073741810 || Tmp_68 == -1073741824 || Tmp_68 == -1073741771 || Tmp_68 == -1073741670 || Tmp_68 == -1073741823;



implementation {:origName "sdv_RunAddDevice"} {:osmodel} sdv_RunAddDevice(actual_p1: int, actual_p2: int) returns (Tmp_68: int)
{
  var {:scalar} status: int;
  var {:pointer} p1: int;
  var {:pointer} p2: int;

  anon0:
    p1 := actual_p1;
    p2 := actual_p2;
    status := 0;
    call {:si_unique_call 9} sdv_stub_add_begin();
    call {:si_unique_call 10} status := VolSnapAddDevice(p1, p2);
    call {:si_unique_call 11} sdv_stub_add_end();
    Tmp_68 := status;
    return;
}



procedure {:origName "IoGetDeviceProperty"} {:osmodel} IoGetDeviceProperty(actual_DeviceObject: int, actual_DeviceProperty: int, actual_BufferLength: int, actual_PropertyBuffer: int, actual_ResultLength: int) returns (Tmp_70: int);
  free ensures Tmp_70 == -1073741584 || Tmp_70 == -1073741808 || Tmp_70 == -1073741823 || Tmp_70 == 0 || Tmp_70 == -1073741789;



implementation {:origName "IoGetDeviceProperty"} {:osmodel} IoGetDeviceProperty(actual_DeviceObject: int, actual_DeviceProperty: int, actual_BufferLength: int, actual_PropertyBuffer: int, actual_ResultLength: int) returns (Tmp_70: int)
{
  var {:scalar} L: int;
  var {:scalar} sdv_67: int;
  var {:scalar} BufferLength: int;
  var {:pointer} ResultLength: int;

  anon0:
    BufferLength := actual_BufferLength;
    ResultLength := actual_ResultLength;
    L := sdv_67;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} 0 >= L;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} L != 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} L == -1;
    Tmp_70 := -1073741584;
    goto L1;

  L1:
    return;

  anon11_Then:
    assume {:partition} L != -1;
    Tmp_70 := -1073741808;
    goto L1;

  anon10_Then:
    assume {:partition} L == 0;
    Tmp_70 := -1073741823;
    goto L1;

  anon12_Then:
    assume {:partition} L > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} BufferLength >= L;
    assume {:nonnull} ResultLength != 0;
    assume ResultLength > 0;
    Tmp_70 := 0;
    goto L1;

  anon9_Then:
    assume {:partition} L > BufferLength;
    assume {:nonnull} ResultLength != 0;
    assume ResultLength > 0;
    Tmp_70 := -1073741789;
    goto L1;
}



procedure {:origName "ExInitializeNPagedLookasideList"} {:osmodel} ExInitializeNPagedLookasideList(actual_Lookaside: int, actual_Allocate: int, actual_Free: int, actual_Flags: int, actual_Size: int, actual_Tag: int, actual_Depth: int);
  modifies alloc;



implementation {:origName "ExInitializeNPagedLookasideList"} {:osmodel} ExInitializeNPagedLookasideList(actual_Lookaside: int, actual_Allocate: int, actual_Free: int, actual_Flags: int, actual_Size: int, actual_Tag: int, actual_Depth: int)
{
  var vslice_dummy_var_4: int;

  anon0:
    call {:si_unique_call 12} vslice_dummy_var_4 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KeReleaseMutex"} {:osmodel} KeReleaseMutex(actual_Mutex: int, actual_Wait: int) returns (Tmp_74: int);
  free ensures Tmp_74 == 0;



implementation {:origName "KeReleaseMutex"} {:osmodel} KeReleaseMutex(actual_Mutex: int, actual_Wait: int) returns (Tmp_74: int)
{

  anon0:
    Tmp_74 := 0;
    return;
}



procedure {:origName "KeInitializeDpc"} {:osmodel} KeInitializeDpc(actual_Dpc: int, actual_DeferredRoutine: int, actual_DeferredContext: int);
  modifies alloc;



implementation {:origName "KeInitializeDpc"} {:osmodel} KeInitializeDpc(actual_Dpc: int, actual_DeferredRoutine: int, actual_DeferredContext: int)
{
  var {:pointer} Dpc: int;
  var {:scalar} DeferredRoutine: int;
  var vslice_dummy_var_5: int;

  anon0:
    call {:si_unique_call 13} vslice_dummy_var_5 := __HAVOC_malloc(4);
    Dpc := actual_Dpc;
    DeferredRoutine := actual_DeferredRoutine;
    assume {:nonnull} Dpc != 0;
    assume Dpc > 0;
    return;
}



procedure {:origName "IoCreateDevice"} {:osmodel} IoCreateDevice(actual_DriverObject: int, actual_DeviceExtensionSize: int, actual_DeviceName: int, actual_DeviceType: int, actual_DeviceCharacteristics: int, actual_Exclusive: int, actual_DeviceObject_1: int) returns (Tmp_78: int);
  free ensures Tmp_78 == -1073741824 || Tmp_78 == -1073741771 || Tmp_78 == -1073741670 || Tmp_78 == -1073741823 || Tmp_78 == 0;



implementation {:origName "IoCreateDevice"} {:osmodel} IoCreateDevice(actual_DriverObject: int, actual_DeviceExtensionSize: int, actual_DeviceName: int, actual_DeviceType: int, actual_DeviceCharacteristics: int, actual_Exclusive: int, actual_DeviceObject_1: int) returns (Tmp_78: int)
{
  var {:pointer} DeviceObject_1: int;

  anon0:
    DeviceObject_1 := actual_DeviceObject_1;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    goto anon14_Then, anon14_Else;

  anon14_Else:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:nonnull} DeviceObject_1 != 0;
    assume DeviceObject_1 > 0;
    Tmp_78 := -1073741824;
    goto L1;

  L1:
    return;

  anon12_Then:
    assume {:nonnull} DeviceObject_1 != 0;
    assume DeviceObject_1 > 0;
    Tmp_78 := -1073741771;
    goto L1;

  anon13_Then:
    assume {:nonnull} DeviceObject_1 != 0;
    assume DeviceObject_1 > 0;
    Tmp_78 := -1073741670;
    goto L1;

  anon14_Then:
    assume {:nonnull} DeviceObject_1 != 0;
    assume DeviceObject_1 > 0;
    Tmp_78 := -1073741823;
    goto L1;

  anon15_Then:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:nonnull} sdv_p_devobj_fdo != 0;
    assume sdv_p_devobj_fdo > 0;
    assume {:nonnull} DeviceObject_1 != 0;
    assume DeviceObject_1 > 0;
    goto L21;

  L21:
    Tmp_78 := 0;
    goto L1;

  anon11_Then:
    assume {:nonnull} sdv_p_devobj_child_pdo != 0;
    assume sdv_p_devobj_child_pdo > 0;
    assume {:nonnull} DeviceObject_1 != 0;
    assume DeviceObject_1 > 0;
    goto L21;
}



procedure {:origName "IoQueueWorkItem"} {:osmodel} IoQueueWorkItem(actual_IoWorkItem: int, actual_WorkerRoutine: int, actual_QueueType: int, actual_Context: int);
  modifies alloc;



implementation {:origName "IoQueueWorkItem"} {:osmodel} IoQueueWorkItem(actual_IoWorkItem: int, actual_WorkerRoutine: int, actual_QueueType: int, actual_Context: int)
{
  var vslice_dummy_var_6: int;

  anon0:
    call {:si_unique_call 14} vslice_dummy_var_6 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoDetachDevice"} {:osmodel} IoDetachDevice(actual_TargetDevice: int);
  modifies alloc;



implementation {:origName "IoDetachDevice"} {:osmodel} IoDetachDevice(actual_TargetDevice: int)
{
  var vslice_dummy_var_7: int;

  anon0:
    call {:si_unique_call 15} vslice_dummy_var_7 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_SetPowerIrpMinorFunction"} {:osmodel} sdv_SetPowerIrpMinorFunction(actual_pirp_1: int);
  modifies alloc, Mem_T.MinorFunction__IO_STACK_LOCATION;



implementation {:origName "sdv_SetPowerIrpMinorFunction"} {:osmodel} sdv_SetPowerIrpMinorFunction(actual_pirp_1: int)
{
  var {:pointer} r: int;
  var {:pointer} pirp_1: int;
  var vslice_dummy_var_8: int;

  anon0:
    call {:si_unique_call 16} vslice_dummy_var_8 := __HAVOC_malloc(4);
    pirp_1 := actual_pirp_1;
    assume {:nonnull} pirp_1 != 0;
    assume pirp_1 > 0;
    r := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(pirp_1)))];
    goto anon11_Then, anon11_Else;

  anon11_Else:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:nonnull} r != 0;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 0;
    goto L1;

  L1:
    return;

  anon12_Then:
    assume {:nonnull} r != 0;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 1;
    goto L1;

  anon13_Then:
    assume {:nonnull} r != 0;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 3;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:nonnull} r != 0;
    assume r > 0;
    goto L1;

  anon15_Then:
    assume {:nonnull} r != 0;
    assume r > 0;
    goto L1;

  anon11_Then:
    assume {:nonnull} r != 0;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 2;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} r != 0;
    assume r > 0;
    goto L1;

  anon14_Then:
    assume {:nonnull} r != 0;
    assume r > 0;
    goto L1;
}



procedure {:origName "sdv_stub_dispatch_end"} {:osmodel} sdv_stub_dispatch_end(actual_s: int, actual_pirp_2: int);
  modifies alloc;



implementation {:origName "sdv_stub_dispatch_end"} {:osmodel} sdv_stub_dispatch_end(actual_s: int, actual_pirp_2: int)
{
  var vslice_dummy_var_9: int;

  anon0:
    call {:si_unique_call 17} vslice_dummy_var_9 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "EtwRegister"} {:osmodel} EtwRegister(actual_ProviderId: int, actual_EnableCallback: int, actual_CallbackContext: int, actual_RegHandle: int) returns (Tmp_88: int);
  free ensures Tmp_88 == 0 || Tmp_88 == -1073741823 || Tmp_88 == -1073741811;



implementation {:origName "EtwRegister"} {:osmodel} EtwRegister(actual_ProviderId: int, actual_EnableCallback: int, actual_CallbackContext: int, actual_RegHandle: int) returns (Tmp_88: int)
{

  anon0:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    Tmp_88 := 0;
    goto L1;

  L1:
    return;

  anon6_Then:
    Tmp_88 := -1073741823;
    goto L1;

  anon5_Then:
    Tmp_88 := -1073741811;
    goto L1;
}



procedure {:origName "sdv_SetStatus"} {:osmodel} sdv_SetStatus(actual_pirp_3: int);
  modifies alloc, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_SetStatus"} {:osmodel} sdv_SetStatus(actual_pirp_3: int)
{
  var {:pointer} pirp_3: int;
  var vslice_dummy_var_10: int;

  anon0:
    call {:si_unique_call 18} vslice_dummy_var_10 := __HAVOC_malloc(4);
    pirp_3 := actual_pirp_3;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} pirp_3 != 0;
    assume pirp_3 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_3))] := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} pirp_3 != 0;
    assume pirp_3 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_3))] := -1073741637;
    goto L1;
}



procedure {:nohoudini} {:origName "sdv_main"} {:osmodel} sdv_main();
  modifies alloc, SLAM_guard_S_0, passed_on, ref, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, in_pnp, Mem_T.Type_unnamed_tag_26, sdv_start_info, sdv_end_info, yogi_error, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;



implementation {:origName "sdv_main"} {:osmodel} sdv_main()
{
  var {:scalar} u: int;
  var {:scalar} sdv_76: int;
  var vslice_dummy_var_11: int;
  var vslice_dummy_var_12: int;
  var vslice_dummy_var_13: int;
  var vslice_dummy_var_14: int;

  anon0:
    call {:si_unique_call 19} u := __HAVOC_malloc(12);
    call {:si_unique_call 20} vslice_dummy_var_11 := __HAVOC_malloc(4);
    SLAM_guard_S_0 := sdv_irp;
    assume SLAM_guard_S_0 != 0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    goto anon19_Then, anon19_Else;

  anon19_Else:
    call {:si_unique_call 21} sdv_RunUnload(sdv_driver_object);
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon19_Then:
    goto L1;

  anon20_Then:
    call {:si_unique_call 22} sdv_stub_driver_init();
    call {:si_unique_call 23} vslice_dummy_var_13 := sdv_RunStartDevice(sdv_p_devobj_fdo, sdv_irp);
    goto L1;

  anon21_Then:
    call {:si_unique_call 24} vslice_dummy_var_12 := sdv_RunAddDevice(sdv_driver_object, sdv_p_devobj_pdo);
    goto L1;

  anon22_Then:
    call {:si_unique_call 25} vslice_dummy_var_14 := DriverEntry(sdv_driver_object, u);
    goto L1;

  anon17_Then:
    call {:si_unique_call 26} sdv_stub_driver_init();
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume sdv_irp == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 27} SLIC_sdv_RunDispatchFunction_entry(0);
    goto L68;

  L68:
    call {:si_unique_call 28} sdv_76 := sdv_RunDispatchFunction(sdv_p_devobj_fdo, sdv_irp);
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume sdv_irp == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 29} SLIC_sdv_RunDispatchFunction_exit(strConst__li2bpl2, sdv_irp, sdv_76);
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} yogi_error != 1;
    goto L1;

  anon24_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon23_Then:
    assume !(sdv_irp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L1;

  anon18_Then:
    assume !(sdv_irp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L68;
}



procedure {:origName "ZwOpenEvent"} {:osmodel} ZwOpenEvent(actual_EventHandle: int, actual_DesiredAccess: int, actual_ObjectAttributes: int) returns (Tmp_94: int);
  modifies alloc;
  free ensures Tmp_94 == 0 || Tmp_94 == -1073741823;



implementation {:origName "ZwOpenEvent"} {:osmodel} ZwOpenEvent(actual_EventHandle: int, actual_DesiredAccess: int, actual_ObjectAttributes: int) returns (Tmp_94: int)
{
  var {:pointer} sdv_79: int;
  var {:pointer} EventHandle: int;

  anon0:
    EventHandle := actual_EventHandle;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 30} sdv_79 := __HAVOC_malloc(4);
    assume {:nonnull} EventHandle != 0;
    assume EventHandle > 0;
    Tmp_94 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} EventHandle != 0;
    assume EventHandle > 0;
    Tmp_94 := -1073741823;
    goto L1;
}



procedure {:origName "IoDeleteSymbolicLink"} {:osmodel} IoDeleteSymbolicLink(actual_SymbolicLinkName: int) returns (Tmp_96: int);
  free ensures Tmp_96 == 0 || Tmp_96 == -1073741823;



implementation {:origName "IoDeleteSymbolicLink"} {:osmodel} IoDeleteSymbolicLink(actual_SymbolicLinkName: int) returns (Tmp_96: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_96 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_96 := -1073741823;
    goto L1;
}



procedure {:origName "IoAllocateErrorLogEntry"} {:osmodel} IoAllocateErrorLogEntry(actual_IoObject: int, actual_EntrySize: int) returns (Tmp_98: int);
  modifies alloc;



implementation {:origName "IoAllocateErrorLogEntry"} {:osmodel} IoAllocateErrorLogEntry(actual_IoObject: int, actual_EntrySize: int) returns (Tmp_98: int)
{
  var {:pointer} sdv_82: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 31} sdv_82 := __HAVOC_malloc(1);
    Tmp_98 := sdv_82;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_98 := 0;
    goto L1;
}



procedure {:origName "PoCallDriver"} {:osmodel} PoCallDriver(actual_DeviceObject_2: int, actual_Irp: int) returns (Tmp_100: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK;
  free ensures Tmp_100 == 259;



implementation {:origName "PoCallDriver"} {:osmodel} PoCallDriver(actual_DeviceObject_2: int, actual_Irp: int) returns (Tmp_100: int)
{
  var {:scalar} status_2: int;
  var {:pointer} Irp: int;

  anon0:
    Irp := actual_Irp;
    status_2 := 259;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    goto anon41_Then, anon41_Else;

  anon41_Else:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := 259;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L19;

  L19:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L21;

  L21:
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp;
    goto L25;

  L25:
    Tmp_100 := status_2;
    return;

  anon33_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 259;
    goto L25;

  anon32_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp;
    goto L21;

  anon44_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp;
    goto L19;

  anon40_Then:
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := -1073741823;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L44;

  L44:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L46;

  L46:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741823;
    goto L25;

  anon39_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp;
    goto L25;

  anon38_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp;
    goto L46;

  anon45_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp;
    goto L44;

  anon41_Then:
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := -1073741536;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L28;

  L28:
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L30;

  L30:
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741536;
    goto L25;

  anon35_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp;
    goto L25;

  anon34_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp;
    goto L30;

  anon43_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp;
    goto L28;

  anon31_Then:
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L36;

  L36:
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L38;

  L38:
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 0;
    goto L25;

  anon37_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp;
    goto L25;

  anon36_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp;
    goto L38;

  anon42_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp;
    goto L36;
}



procedure {:origName "KeCancelTimer"} {:osmodel} KeCancelTimer(actual_Timer: int) returns (Tmp_102: int);
  free ensures Tmp_102 == 1 || Tmp_102 == 0;



implementation {:origName "KeCancelTimer"} {:osmodel} KeCancelTimer(actual_Timer: int) returns (Tmp_102: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_102 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_102 := 0;
    goto L1;
}



procedure {:origName "IoWriteErrorLogEntry"} {:osmodel} IoWriteErrorLogEntry(actual_ElEntry: int);
  modifies alloc;



implementation {:origName "IoWriteErrorLogEntry"} {:osmodel} IoWriteErrorLogEntry(actual_ElEntry: int)
{
  var vslice_dummy_var_15: int;

  anon0:
    call {:si_unique_call 32} vslice_dummy_var_15 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "ZwUnmapViewOfSection"} {:osmodel} ZwUnmapViewOfSection(actual_ProcessHandle: int, actual_BaseAddress: int) returns (Tmp_106: int);
  free ensures Tmp_106 == -1073741823 || Tmp_106 == -1073741811 || Tmp_106 == 0;



implementation {:origName "ZwUnmapViewOfSection"} {:osmodel} ZwUnmapViewOfSection(actual_ProcessHandle: int, actual_BaseAddress: int) returns (Tmp_106: int)
{

  anon0:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    Tmp_106 := -1073741823;
    goto L1;

  L1:
    return;

  anon6_Then:
    Tmp_106 := -1073741811;
    goto L1;

  anon5_Then:
    Tmp_106 := 0;
    goto L1;
}



procedure {:origName "sdv_stub_add_begin"} {:osmodel} sdv_stub_add_begin();
  modifies alloc;



implementation {:origName "sdv_stub_add_begin"} {:osmodel} sdv_stub_add_begin()
{
  var vslice_dummy_var_16: int;

  anon0:
    call {:si_unique_call 33} vslice_dummy_var_16 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "PoStartNextPowerIrp"} {:osmodel} PoStartNextPowerIrp(actual_Irp_1: int);
  modifies alloc;



implementation {:origName "PoStartNextPowerIrp"} {:osmodel} PoStartNextPowerIrp(actual_Irp_1: int)
{
  var vslice_dummy_var_17: int;

  anon0:
    call {:si_unique_call 34} vslice_dummy_var_17 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "ZwSetInformationFile"} {:osmodel} ZwSetInformationFile(actual_FileHandle: int, actual_IoStatusBlock: int, actual_FileInformation: int, actual_Length: int, actual_FileInformationClass: int) returns (Tmp_112: int);
  free ensures Tmp_112 == 0 || Tmp_112 == -1073741823;



implementation {:origName "ZwSetInformationFile"} {:osmodel} ZwSetInformationFile(actual_FileHandle: int, actual_IoStatusBlock: int, actual_FileInformation: int, actual_Length: int, actual_FileInformationClass: int) returns (Tmp_112: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_112 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_112 := -1073741823;
    goto L1;
}



procedure {:origName "KeWaitForSingleObject"} {:osmodel} KeWaitForSingleObject(actual_Object: int, actual_WaitReason: int, actual_WaitMode: int, actual_Alertable: int, actual_Timeout: int) returns (Tmp_114: int);
  free ensures Tmp_114 == 258 || Tmp_114 == 0;



implementation {:origName "KeWaitForSingleObject"} {:osmodel} KeWaitForSingleObject(actual_Object: int, actual_WaitReason: int, actual_WaitMode: int, actual_Alertable: int, actual_Timeout: int) returns (Tmp_114: int)
{
  var {:pointer} Timeout: int;

  anon0:
    Timeout := actual_Timeout;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} Timeout != 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    Tmp_114 := 258;
    goto L1;

  L1:
    return;

  anon6_Then:
    Tmp_114 := 0;
    goto L1;

  anon5_Then:
    assume {:partition} Timeout == 0;
    Tmp_114 := 0;
    goto L1;
}



procedure {:origName "IoDeleteDevice"} {:osmodel} IoDeleteDevice(actual_DeviceObject_3: int);
  modifies alloc;



implementation {:origName "IoDeleteDevice"} {:osmodel} IoDeleteDevice(actual_DeviceObject_3: int)
{
  var vslice_dummy_var_18: int;

  anon0:
    call {:si_unique_call 35} vslice_dummy_var_18 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KeSetEvent"} {:osmodel} KeSetEvent(actual_Event: int, actual_Increment: int, actual_Wait_1: int) returns (Tmp_118: int);



implementation {:origName "KeSetEvent"} {:osmodel} KeSetEvent(actual_Event: int, actual_Increment: int, actual_Wait_1: int) returns (Tmp_118: int)
{
  var {:scalar} OldState: int;
  var {:pointer} Event: int;

  anon0:
    Event := actual_Event;
    assume {:nonnull} Event != 0;
    assume Event > 0;
    havoc OldState;
    assume {:nonnull} Event != 0;
    assume Event > 0;
    Tmp_118 := OldState;
    return;
}



procedure {:origName "ExUuidCreate"} {:osmodel} ExUuidCreate(actual_Uuid: int) returns (Tmp_120: int);
  free ensures Tmp_120 == 0 || Tmp_120 == -1073741267;



implementation {:origName "ExUuidCreate"} {:osmodel} ExUuidCreate(actual_Uuid: int) returns (Tmp_120: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_120 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_120 := -1073741267;
    goto L1;
}



procedure {:origName "ObReferenceObjectByHandle"} {:osmodel} ObReferenceObjectByHandle(actual_Handle: int, actual_DesiredAccess_1: int, actual_ObjectType: int, actual_AccessMode: int, actual_Object_1: int, actual_HandleInformation: int) returns (Tmp_124: int);
  modifies ref;
  free ensures Tmp_124 == 0 || Tmp_124 == -1073741823;



implementation {:origName "ObReferenceObjectByHandle"} {:osmodel} ObReferenceObjectByHandle(actual_Handle: int, actual_DesiredAccess_1: int, actual_ObjectType: int, actual_AccessMode: int, actual_Object_1: int, actual_HandleInformation: int) returns (Tmp_124: int)
{

  anon0:
    call {:si_unique_call 36} SLIC_ObReferenceObjectByHandle_entry(0);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_124 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_124 := -1073741823;
    goto L1;
}



procedure {:origName "IoAllocateDriverObjectExtension"} {:osmodel} IoAllocateDriverObjectExtension(actual_DriverObject_1: int, actual_ClientIdentificationAddress: int, actual_DriverObjectExtensionSize: int, actual_DriverObjectExtension: int) returns (Tmp_126: int);
  free ensures Tmp_126 == -1073741670 || Tmp_126 == -1073741771 || Tmp_126 == 0;



implementation {:origName "IoAllocateDriverObjectExtension"} {:osmodel} IoAllocateDriverObjectExtension(actual_DriverObject_1: int, actual_ClientIdentificationAddress: int, actual_DriverObjectExtensionSize: int, actual_DriverObjectExtension: int) returns (Tmp_126: int)
{

  anon0:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    Tmp_126 := -1073741670;
    goto L1;

  L1:
    return;

  anon6_Then:
    Tmp_126 := -1073741771;
    goto L1;

  anon5_Then:
    Tmp_126 := 0;
    goto L1;
}



procedure {:origName "IoReleaseCancelSpinLock"} {:osmodel} IoReleaseCancelSpinLock(actual_new: int);
  modifies alloc;



implementation {:origName "IoReleaseCancelSpinLock"} {:osmodel} IoReleaseCancelSpinLock(actual_new: int)
{
  var {:scalar} new: int;
  var vslice_dummy_var_19: int;

  anon0:
    call {:si_unique_call 37} vslice_dummy_var_19 := __HAVOC_malloc(4);
    new := actual_new;
    return;
}



procedure {:origName "ObfDereferenceObject"} {:osmodel} ObfDereferenceObject(actual_Object_2: int) returns (Tmp_130: int);



implementation {:origName "ObfDereferenceObject"} {:osmodel} ObfDereferenceObject(actual_Object_2: int) returns (Tmp_130: int)
{

  anon0:
    return;
}



procedure {:origName "KeReleaseSemaphore"} {:osmodel} KeReleaseSemaphore(actual_Semaphore: int, actual_Increment_1: int, actual_Adjustment: int, actual_Wait_2: int) returns (Tmp_132: int);



implementation {:origName "KeReleaseSemaphore"} {:osmodel} KeReleaseSemaphore(actual_Semaphore: int, actual_Increment_1: int, actual_Adjustment: int, actual_Wait_2: int) returns (Tmp_132: int)
{
  var {:scalar} r_1: int;

  anon0:
    Tmp_132 := r_1;
    return;
}



procedure {:origName "ExWaitForRundownProtectionReleaseCacheAware"} {:osmodel} ExWaitForRundownProtectionReleaseCacheAware(actual_RunRef: int);
  modifies alloc;



implementation {:origName "ExWaitForRundownProtectionReleaseCacheAware"} {:osmodel} ExWaitForRundownProtectionReleaseCacheAware(actual_RunRef: int)
{
  var vslice_dummy_var_20: int;

  anon0:
    call {:si_unique_call 38} vslice_dummy_var_20 := __HAVOC_malloc(4);
    return;
}



procedure {:nohoudini} {:origName "main"} {:osmodel} {:entrypoint} main() returns (Tmp_136: int, dup_assertVar: bool);
  modifies alloc, SLAM_guard_S_0, in_pnp, passed_on, ref, yogi_error, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Type_unnamed_tag_26, sdv_start_info, sdv_end_info, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures yogi_error == 1 || yogi_error == 0;
  free ensures old(yogi_error) == 0;
  free ensures alloc >= old(alloc);



implementation {:origName "main"} {:osmodel} main() returns (Tmp_136: int, dup_assertVar: bool)
{
  var {:scalar} Tmp_137: int;
  var {:scalar} Tmp_138: int;
  var boogieTmp: int;
  var WHEA_ERROR_PACKET_SECTION_GUID__Loc: int;
  var SLAM_guard_S_0_init__Loc: int;
  var sdv_harnessStackLocation_next__Loc: int;
  var sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc: int;
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
  var sdv_devobj_fdo__Loc: int;
  var sdv_StartIoIrp__Loc: int;
  var sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc: int;
  var sdv_PowerIrp__Loc: int;
  var sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc: int;
  var sdv_other_harnessIrp__Loc: int;
  var sdv_IoCreateNotificationEvent_KEVENT__Loc: int;
  var sdv_other_harnessStackLocation__Loc: int;
  var GUID_TRANSLATOR_INTERFACE_STANDARD__Loc: int;
  var GUID_LIDOPEN_POWERSTATE__Loc: int;
  var GUID_PROCESSOR_PARKING_CORE_OVERRIDE__Loc: int;
  var GUID_PCIEXPRESS_SETTINGS_SUBGROUP__Loc: int;
  var GUID_ARBITER_INTERFACE_STANDARD__Loc: int;
  var GUID_PROCESSOR_PERF_INCREASE_TIME__Loc: int;
  var MOUNTDEV_MOUNTED_DEVICE_GUID__Loc: int;
  var GUID_DEVINTERFACE_STORAGEPORT__Loc: int;
  var GUID_IO_DEVICE_EXTERNAL_REQUEST__Loc: int;
  var VSP_DIAG_DISCOVER_SNAPSHOTS_ENTER__Loc: int;
  var VSP_DIAG_PRE_EXPOSURE_ENTER__Loc: int;
  var GUID_DEVINTERFACE_CDCHANGER__Loc: int;
  var GUID_IO_VOLUME_NAME_CHANGE__Loc: int;
  var GUID_IO_DEVICE_BECOMING_READY__Loc: int;
  var GUID_MF_ENUMERATION_INTERFACE__Loc: int;
  var GUID_ALLOW_RTC_WAKE__Loc: int;
  var GUID_LEGACY_DEVICE_DETECTION_STANDARD__Loc: int;
  var VSP_DIAG_PREPARE_LEAVE__Loc: int;
  var GUID_BATTERY_DISCHARGE_LEVEL_2__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD__Loc: int;
  var GUID_IO_VOLUME_NEED_CHKDSK__Loc: int;
  var GUID_PNP_POWER_SETTING_CHANGE__Loc: int;
  var GUID_MONITOR_POWER_ON__Loc: int;
  var VSP_DIAG_DISMOUNT_LEAVE__Loc: int;
  var GUID_ACPI_REGS_INTERFACE_STANDARD__Loc: int;
  var GUID_IO_DISK_LAYOUT_CHANGE__Loc: int;
  var GUID_PARTITION_UNIT_INTERFACE_STANDARD__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD__Loc: int;
  var GUID_ACDC_POWER_SOURCE__Loc: int;
  var GUID_IO_VOLUME_INFO_MAKE_COMPAT__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME__Loc: int;
  var GUID_PROCESSOR_THROTTLE_MINIMUM__Loc: int;
  var GUID_ALLOW_AWAYMODE__Loc: int;
  var GUID_DEVINTERFACE_TAPE__Loc: int;
  var VSP_DIAG_REVERT_LEAVE__Loc: int;
  var GUID_DISK_ADAPTIVE_POWERDOWN__Loc: int;
  var GUID_SYSTEM_BUTTON_SUBGROUP__Loc: int;
  var VSP_DIAG_END_COMMIT_LEAVE__Loc: int;
  var GUID_SYSTEM_COOLING_POLICY__Loc: int;
  var PARTITION_MSFT_RESERVED_GUID__Loc: int;
  var GUID_BATTERY_DISCHARGE_LEVEL_3__Loc: int;
  var GUID_BUS_TYPE_PCI__Loc: int;
  var GUID_ALLOW_SYSTEM_REQUIRED__Loc: int;
  var GUID_TARGET_DEVICE_QUERY_REMOVE__Loc: int;
  var GUID_DEVINTERFACE_HIDDEN_VOLUME__Loc: int;
  var GUID_PCI_BUS_INTERFACE_STANDARD__Loc: int;
  var GUID_HWPROFILE_QUERY_CHANGE__Loc: int;
  var VSP_DIAG_SET_IGNORABLE_LEAVE__Loc: int;
  var GUID_LOCK_CONSOLE_ON_WAKE__Loc: int;
  var VSP_DIAG_FLUSH_HOLD_FS_LEAVE__Loc: int;
  var GUID_VIDEO_POWERDOWN_TIMEOUT__Loc: int;
  var VSP_DIAG_ADJUST_BITMAP_LEAVE__Loc: int;
  var GUID_IO_VOLUME_DISMOUNT__Loc: int;
  var GUID_PROCESSOR_IDLESTATE_POLICY__Loc: int;
  var GUID_IO_VOLUME_PREPARING_EJECT__Loc: int;
  var GUID_REENUMERATE_SELF_INTERFACE_STANDARD__Loc: int;
  var GUID_ALLOW_DISPLAY_REQUIRED__Loc: int;
  var GUID_UNATTEND_SLEEP_TIMEOUT__Loc: int;
  var GUID_CRITICAL_POWER_TRANSITION__Loc: int;
  var GUID_SLEEP_IDLE_THRESHOLD__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY__Loc: int;
  var GUID_IO_VOLUME_DISMOUNT_FAILED__Loc: int;
  var VSP_DIAG_ACTIVATE_LEAVE__Loc: int;
  var GUID_PROCESSOR_THROTTLE_MAXIMUM__Loc: int;
  var PARTITION_BASIC_DATA_GUID__Loc: int;
  var GUID_PROCESSOR_PARKING_PERF_STATE__Loc: int;
  var GUID_PROCESSOR_PERF_DECREASE_POLICY__Loc: int;
  var VSP_DIAG_FLUSH_HOLD_FS_ENTER__Loc: int;
  var PARTITION_ENTRY_UNUSED_GUID__Loc: int;
  var VSP_DIAG_ACTIVATE_ENTER__Loc: int;
  var VOLSNAP_APPINFO_GUID_SYSTEM_HIDDEN__Loc: int;
  var GUID_AGP_TARGET_BUS_INTERFACE_STANDARD__Loc: int;
  var GUID_IO_VOLUME_FORCE_CLOSED__Loc: int;
  var GUID_ALLOW_STANDBY_STATES__Loc: int;
  var VSP_DIAG_PROTECTED_BITMAP_ENTER__Loc: int;
  var VIRTUAL_STORAGE_TYPE_VENDOR_MICROSOFT__Loc: int;
  var GUID_STANDBY_TIMEOUT__Loc: int;
  var GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD__Loc: int;
  var VSP_DIAG_SET_IGNORABLE_ENTER__Loc: int;
  var GUID_PROCESSOR_PERFSTATE_POLICY__Loc: int;
  var VSP_DIAG_DISCOVER_SNAPSHOTS_LEAVE__Loc: int;
  var GUID_IO_VOLUME_LOCK__Loc: int;
  var GUID_BUS_INTERFACE_STANDARD__Loc: int;
  var GUID_IO_VOLUME_DEVICE_INTERFACE__Loc: int;
  var GUID_IO_VOLUME_WEARING_OUT__Loc: int;
  var GUID_BATTERY_DISCHARGE_ACTION_1__Loc: int;
  var GUID_IO_VOLUME_BACKGROUND_FORMAT__Loc: int;
  var GUID_ACPI_INTERFACE_STANDARD2__Loc: int;
  var GUID_PROCESSOR_PERF_INCREASE_POLICY__Loc: int;
  var VSP_DIAG_DELETE_PROCESS_LEAVE__Loc: int;
  var GUID_VIDEO_SUBGROUP__Loc: int;
  var PARTITION_CLUSTER_GUID__Loc: int;
  var GUID_IO_CDROM_EXCLUSIVE_LOCK__Loc: int;
  var GUID_TYPICAL_POWER_SAVINGS__Loc: int;
  var GUID_HIBERNATE_FASTS4_POLICY__Loc: int;
  var GUID_IO_VOLUME_UNIQUE_ID_CHANGE__Loc: int;
  var GUID_DEVICE_INTERFACE_REMOVAL__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR__Loc: int;
  var GUID_PCI_DEVICE_PRESENT_INTERFACE__Loc: int;
  var GUID_POWER_DEVICE_TIMEOUTS__Loc: int;
  var GUID_MSIX_TABLE_CONFIG_INTERFACE__Loc: int;
  var GUID_PROCESSOR_SETTINGS_SUBGROUP__Loc: int;
  var GUID_HWPROFILE_CHANGE_COMPLETE__Loc: int;
  var GUID_IO_MEDIA_ARRIVAL__Loc: int;
  var GUID_BUS_TYPE_AVC__Loc: int;
  var VSP_DIAG_DELETE_PROCESS_ENTER__Loc: int;
  var GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__Loc: int;
  var GUID_BATTERY_DISCHARGE_FLAGS_2__Loc: int;
  var VSP_DIAG_ACTIVATE_LOOP_ENTER__Loc: int;
  var GUID_DEVINTERFACE_VOLUME__Loc: int;
  var GUID_DEVICE_EVENT_RBC__Loc: int;
  var GUID_HIBERNATE_TIMEOUT__Loc: int;
  var GUID_DEVINTERFACE_MEDIUMCHANGER__Loc: int;
  var GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME__Loc: int;
  var GUID_SESSION_DISPLAY_STATE__Loc: int;
  var GUID_BATTERY_DISCHARGE_ACTION_3__Loc: int;
  var GUID_POWER_DEVICE_ENABLE__Loc: int;
  var GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_MIN_CORES__Loc: int;
  var GUID_PNP_CUSTOM_NOTIFICATION__Loc: int;
  var GUID_IO_VOLUME_UNLOCK__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR__Loc: int;
  var ntAuthority__Loc: int;
  var GUID_ACPI_INTERFACE_STANDARD__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING__Loc: int;
  var PARTITION_SYSTEM_GUID__Loc: int;
  var GUID_SLEEPBUTTON_ACTION_FLAGS__Loc: int;
  var PARTITION_LDM_DATA_GUID__Loc: int;
  var GUID_POWERBUTTON_ACTION__Loc: int;
  var PARTITION_MSFT_RECOVERY_GUID__Loc: int;
  var GUID_ACPI_CMOS_INTERFACE_STANDARD__Loc: int;
  var GUID_USERINTERFACEBUTTON_ACTION__Loc: int;
  var GUID_PROCESSOR_THROTTLE_POLICY__Loc: int;
  var GUID_PCIEXPRESS_ASPM_POLICY__Loc: int;
  var GUID_DEVINTERFACE_WRITEONCEDISK__Loc: int;
  var GUID_BUS_TYPE_ISAPNP__Loc: int;
  var GUID_BATTERY_PERCENTAGE_REMAINING__Loc: int;
  var GUID_BATTERY_DISCHARGE_ACTION_2__Loc: int;
  var GUID_APPLAUNCH_BUTTON__Loc: int;
  var GUID_BATTERY_DISCHARGE_FLAGS_1__Loc: int;
  var GUID_PROCESSOR_ALLOW_THROTTLING__Loc: int;
  var VSP_DIAG_END_COMMIT_ENTER__Loc: int;
  var VSP_DIAG_REMOUNT_LEAVE__Loc: int;
  var GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE__Loc: int;
  var GUID_BUS_TYPE_DOT4PRT__Loc: int;
  var VSP_DIAG_IGNORABLE_PRODUCT_ENTER__Loc: int;
  var GUID_BUS_TYPE_EISA__Loc: int;
  var GUID_DISK_BURST_IGNORE_THRESHOLD__Loc: int;
  var GUID_SLEEPBUTTON_ACTION__Loc: int;
  var GUID_PROCESSOR_IDLE_DISABLE__Loc: int;
  var GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED__Loc: int;
  var GUID_BUS_TYPE_IRDA__Loc: int;
  var GUID_DISK_POWERDOWN_TIMEOUT__Loc: int;
  var GUID_CONSOLE_DISPLAY_STATE__Loc: int;
  var GUID_BATTERY_DISCHARGE_FLAGS_0__Loc: int;
  var VSP_DIAG_ACTIVATE_LOOP_LEAVE__Loc: int;
  var VIRTUAL_STORAGE_TYPE_VENDOR_UNKNOWN__Loc: int;
  var GUID_BUS_TYPE_MCA__Loc: int;
  var GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS__Loc: int;
  var GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD__Loc: int;
  var KeTickCount__Loc: int;
  var GUID_PNP_LOCATION_INTERFACE__Loc: int;
  var GUID_BUS_TYPE_INTERNAL__Loc: int;
  var GUID_IO_VOLUME_PHYSICAL_CONFIGURATION_CHANGE__Loc: int;
  var GUID_IO_DISK_CLONE_ARRIVAL__Loc: int;
  var GUID_DEVINTERFACE_FLOPPY__Loc: int;
  var GUID_IO_TAPE_ERASE__Loc: int;
  var VSP_DIAG_PREPARE_ENTER__Loc: int;
  var VSP_DIAG_PROTECTED_BITMAP_LEAVE__Loc: int;
  var NO_SUBGROUP_GUID__Loc: int;
  var GUID_PROCESSOR_PCC_INTERFACE_STANDARD__Loc: int;
  var ALL_POWERSCHEMES_GUID__Loc: int;
  var GUID_LIDSWITCH_STATE_CHANGE__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY__Loc: int;
  var GUID_DEVINTERFACE_PARTITION__Loc: int;
  var VSP_DIAG_ADJUST_BITMAP_ENTER__Loc: int;
  var GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS__Loc: int;
  var GUID_PROCESSOR_IDLE_ALLOW_SCALING__Loc: int;
  var GUID_LIDCLOSE_ACTION_FLAGS__Loc: int;
  var GUID_IO_MEDIA_REMOVAL__Loc: int;
  var GUID_BUS_TYPE_SD__Loc: int;
  var GUID_PNP_POWER_NOTIFICATION__Loc: int;
  var GUID_IO_MEDIA_EJECT_REQUEST__Loc: int;
  var GUID_PROCESSOR_IDLE_TIME_CHECK__Loc: int;
  var GUID_BUS_TYPE_HID__Loc: int;
  var GUID_TARGET_DEVICE_REMOVE_COMPLETE__Loc: int;
  var GUID_PROCESSOR_PERF_INCREASE_THRESHOLD__Loc: int;
  var GUID_BACKGROUND_TASK_NOTIFICATION__Loc: int;
  var GUID_POWER_DEVICE_WAKE_ENABLE__Loc: int;
  var GUID_PROCESSOR_PERF_HISTORY__Loc: int;
  var GUID_PCMCIA_BUS_INTERFACE_STANDARD__Loc: int;
  var GUID_BUS_TYPE_PCMCIA__Loc: int;
  var GUID_VIDEO_ANNOYANCE_TIMEOUT__Loc: int;
  var GUID_BATTERY_DISCHARGE_FLAGS_3__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_MAX_CORES__Loc: int;
  var VOLSNAP_APPINFO_GUID_CLIENT_ACCESSIBLE__Loc: int;
  var GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE__Loc: int;
  var GUID_VIDEO_ADAPTIVE_POWERDOWN__Loc: int;
  var GUID_BUS_TYPE_1394__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD__Loc: int;
  var GUID_TARGET_DEVICE_REMOVE_CANCELLED__Loc: int;
  var GUID_MIN_POWER_SAVINGS__Loc: int;
  var GUID_DEVICE_IDLE_POLICY__Loc: int;
  var GUID_PROCESSOR_PERF_BOOST_POLICY__Loc: int;
  var VSP_DIAG_PRE_EXPOSURE_LEAVE__Loc: int;
  var GUID_LIDCLOSE_ACTION__Loc: int;
  var VSP_DIAG_VALIDATE_FILES_LEAVE__Loc: int;
  var GUID_IO_VOLUME_MOUNT__Loc: int;
  var GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS__Loc: int;
  var GUID_DEVINTERFACE_CDROM__Loc: int;
  var VSP_DIAG_DISMOUNT_ENTER__Loc: int;
  var GUID_DEVINTERFACE_DISK__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD__Loc: int;
  var GUID_SLEEP_SUBGROUP__Loc: int;
  var GUID_POWERBUTTON_ACTION_FLAGS__Loc: int;
  var GUID_PROCESSOR_PERF_DECREASE_TIME__Loc: int;
  var GUID_IO_VOLUME_WORM_NEAR_FULL__Loc: int;
  var VSP_DIAG_VALIDATE_FILES_ENTER__Loc: int;
  var GUID_MAX_POWER_SAVINGS__Loc: int;
  var GUID_WUDF_DEVICE_HOST_PROBLEM__Loc: int;
  var GUID_BATTERY_SUBGROUP__Loc: int;
  var GUID_IO_VOLUME_FVE_STATUS_CHANGE__Loc: int;
  var GUID_BUS_TYPE_SERENUM__Loc: int;
  var VSP_DIAG_VOLUME_SAFE_LEAVE__Loc: int;
  var GUID_HWPROFILE_CHANGE_CANCELLED__Loc: int;
  var GUID_BUS_TYPE_LPTENUM__Loc: int;
  var PARTITION_LDM_METADATA_GUID__Loc: int;
  var GUID_DEVICE_INTERFACE_ARRIVAL__Loc: int;
  var GUID_IO_VOLUME_CHANGE_SIZE__Loc: int;
  var GUID_IDLE_BACKGROUND_TASK__Loc: int;
  var GUID_DISK_SUBGROUP__Loc: int;
  var VSP_DIFF_AREA_FILE_GUID__Loc: int;
  var VSP_DIAG_REVERT_ENTER__Loc: int;
  var GUID_IO_CDROM_EXCLUSIVE_UNLOCK__Loc: int;
  var GUID_BUS_TYPE_USB__Loc: int;
  var GUID_POWERSCHEME_PERSONALITY__Loc: int;
  var GUID_IO_DRIVE_REQUIRES_CLEANING__Loc: int;
  var VSP_DIAG_VOLUME_SAFE_ENTER__Loc: int;
  var GUID_INT_ROUTE_INTERFACE_STANDARD__Loc: int;
  var GUID_BATTERY_DISCHARGE_LEVEL_1__Loc: int;
  var GUID_IO_VOLUME_CHANGE__Loc: int;
  var GUID_IO_VOLUME_LOCK_FAILED__Loc: int;
  var GUID_BUS_TYPE_USBPRINT__Loc: int;
  var GUID_BATTERY_DISCHARGE_ACTION_0__Loc: int;
  var GUID_ENABLE_SWITCH_FORCED_SHUTDOWN__Loc: int;
  var VSP_DIAG_IGNORABLE_PRODUCT_LEAVE__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING__Loc: int;
  var GUID_PROCESSOR_PERF_DECREASE_THRESHOLD__Loc: int;
  var GUID_BATTERY_DISCHARGE_LEVEL_0__Loc: int;
  var GUID_VIDEO_DIM_TIMEOUT__Loc: int;
  var GUID_ACTIVE_POWERSCHEME__Loc: int;
  var GUID_SYSTEM_AWAYMODE__Loc: int;
  var VSP_DIAG_REMOUNT_ENTER__Loc: int;
  var VOLSNAP_DIAG_TRACE_PROVIDER__Loc: int;
  var GUID_PROCESSOR_PERF_TIME_CHECK__Loc: int;
  var vslice_dummy_var_358: int;
  var vslice_dummy_var_359: int;
  var vslice_dummy_var_360: int;
  var vslice_dummy_var_361: int;
  var vslice_dummy_var_362: int;
  var vslice_dummy_var_363: int;
  var vslice_dummy_var_364: int;
  var vslice_dummy_var_365: int;
  var vslice_dummy_var_366: int;
  var vslice_dummy_var_367: int;
  var vslice_dummy_var_368: int;
  var vslice_dummy_var_369: int;
  var vslice_dummy_var_370: int;
  var vslice_dummy_var_371: int;
  var vslice_dummy_var_372: int;
  var vslice_dummy_var_373: int;
  var vslice_dummy_var_374: int;
  var vslice_dummy_var_375: int;
  var vslice_dummy_var_376: int;
  var vslice_dummy_var_377: int;
  var vslice_dummy_var_378: int;
  var vslice_dummy_var_379: int;
  var vslice_dummy_var_380: int;
  var vslice_dummy_var_381: int;
  var vslice_dummy_var_382: int;
  var vslice_dummy_var_383: int;
  var vslice_dummy_var_1133: int;

  anon0:
    dup_assertVar := true;
    assume alloc > 0;
    call {:si_unique_call 39} WHEA_ERROR_PACKET_SECTION_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume WHEA_ERROR_PACKET_SECTION_GUID__Loc == WHEA_ERROR_PACKET_SECTION_GUID;
    assume WHEA_ERROR_PACKET_SECTION_GUID != 0;
    call {:si_unique_call 40} SLAM_guard_S_0_init__Loc := __HAVOC_malloc_or_null(248);
    assume SLAM_guard_S_0_init__Loc == SLAM_guard_S_0_init;
    assume SLAM_guard_S_0_init != 0;
    call {:si_unique_call 41} sdv_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(496);
    assume sdv_harnessStackLocation_next__Loc == sdv_harnessStackLocation_next;
    assume sdv_harnessStackLocation_next != 0;
    call {:si_unique_call 42} sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc := __HAVOC_malloc_or_null(76);
    assume sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc == sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX;
    assume sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX != 0;
    call {:si_unique_call 43} sdv_IoBuildAsynchronousFsdRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_IoBuildAsynchronousFsdRequest_harnessIrp__Loc == sdv_IoBuildAsynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildAsynchronousFsdRequest_harnessIrp != 0;
    call {:si_unique_call 44} sdv_IoGetDeviceToVerify_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(320);
    assume sdv_IoGetDeviceToVerify_DEVICE_OBJECT__Loc == sdv_IoGetDeviceToVerify_DEVICE_OBJECT;
    assume sdv_IoGetDeviceToVerify_DEVICE_OBJECT != 0;
    call {:si_unique_call 45} sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(496);
    assume sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next__Loc == sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next;
    assume sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next != 0;
    call {:si_unique_call 46} sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock__Loc == sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;
    assume sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    call {:si_unique_call 47} sdv_ControllerIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_ControllerIrp__Loc == sdv_ControllerIrp;
    assume sdv_ControllerIrp != 0;
    call {:si_unique_call 48} sdv_devobj_pdo__Loc := __HAVOC_malloc_or_null(320);
    assume sdv_devobj_pdo__Loc == sdv_devobj_pdo;
    assume sdv_devobj_pdo != 0;
    call {:si_unique_call 49} sdv_IoGetDmaAdapter_DMA_ADAPTER__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_IoGetDmaAdapter_DMA_ADAPTER__Loc == sdv_IoGetDmaAdapter_DMA_ADAPTER;
    assume sdv_IoGetDmaAdapter_DMA_ADAPTER != 0;
    call {:si_unique_call 50} sdv_IoInitializeIrp_harnessIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_IoInitializeIrp_harnessIrp__Loc == sdv_IoInitializeIrp_harnessIrp;
    assume sdv_IoInitializeIrp_harnessIrp != 0;
    call {:si_unique_call 51} sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(320);
    assume sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT__Loc == sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT;
    assume sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT != 0;
    call {:si_unique_call 52} sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(496);
    assume sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next__Loc == sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next;
    assume sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next != 0;
    call {:si_unique_call 53} sdv_IoCreateSynchronizationEvent_KEVENT__Loc := __HAVOC_malloc_or_null(124);
    assume sdv_IoCreateSynchronizationEvent_KEVENT__Loc == sdv_IoCreateSynchronizationEvent_KEVENT;
    assume sdv_IoCreateSynchronizationEvent_KEVENT != 0;
    call {:si_unique_call 54} sdv_harnessStackLocation__Loc := __HAVOC_malloc_or_null(496);
    assume sdv_harnessStackLocation__Loc == sdv_harnessStackLocation;
    assume sdv_harnessStackLocation != 0;
    call {:si_unique_call 55} sdv_other_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(496);
    assume sdv_other_harnessStackLocation_next__Loc == sdv_other_harnessStackLocation_next;
    assume sdv_other_harnessStackLocation_next != 0;
    call {:si_unique_call 56} sdv_IoCreateController_CONTROLLER_OBJECT__Loc := __HAVOC_malloc_or_null(60);
    assume sdv_IoCreateController_CONTROLLER_OBJECT__Loc == sdv_IoCreateController_CONTROLLER_OBJECT;
    assume sdv_IoCreateController_CONTROLLER_OBJECT != 0;
    call {:si_unique_call 57} sdv_devobj_top__Loc := __HAVOC_malloc_or_null(320);
    assume sdv_devobj_top__Loc == sdv_devobj_top;
    assume sdv_devobj_top != 0;
    call {:si_unique_call 58} sdv_kdpc_val3__Loc := __HAVOC_malloc_or_null(40);
    assume sdv_kdpc_val3__Loc == sdv_kdpc_val3;
    assume sdv_kdpc_val3 != 0;
    call {:si_unique_call 59} sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc == sdv_IoBuildSynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildSynchronousFsdRequest_harnessIrp != 0;
    call {:si_unique_call 60} sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(320);
    assume sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc == sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT;
    assume sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT != 0;
    call {:si_unique_call 61} sdv_driver_object__Loc := __HAVOC_malloc_or_null(68);
    assume sdv_driver_object__Loc == sdv_driver_object;
    assume sdv_driver_object != 0;
    call {:si_unique_call 62} sdv_MapRegisterBase_val__Loc := __HAVOC_malloc_or_null(4);
    assume sdv_MapRegisterBase_val__Loc == sdv_MapRegisterBase_val;
    assume sdv_MapRegisterBase_val != 0;
    call {:si_unique_call 63} sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING__Loc := __HAVOC_malloc_or_null(16);
    assume sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING__Loc == sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING;
    assume sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING != 0;
    call {:si_unique_call 64} sdv_IoMakeAssociatedIrp_harnessIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_IoMakeAssociatedIrp_harnessIrp__Loc == sdv_IoMakeAssociatedIrp_harnessIrp;
    assume sdv_IoMakeAssociatedIrp_harnessIrp != 0;
    call {:si_unique_call 65} sdv_devobj_child_pdo__Loc := __HAVOC_malloc_or_null(320);
    assume sdv_devobj_child_pdo__Loc == sdv_devobj_child_pdo;
    assume sdv_devobj_child_pdo != 0;
    call {:si_unique_call 66} sdv_harnessIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_harnessIrp__Loc == sdv_harnessIrp;
    assume sdv_harnessIrp != 0;
    call {:si_unique_call 67} sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(496);
    assume sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next__Loc == sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next;
    assume sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next != 0;
    call {:si_unique_call 68} sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock__Loc == sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock;
    assume sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    call {:si_unique_call 69} sdv_kinterrupt_val__Loc := __HAVOC_malloc_or_null(0);
    assume sdv_kinterrupt_val__Loc == sdv_kinterrupt_val;
    assume sdv_kinterrupt_val != 0;
    call {:si_unique_call 70} sdv_devobj_fdo__Loc := __HAVOC_malloc_or_null(320);
    assume sdv_devobj_fdo__Loc == sdv_devobj_fdo;
    assume sdv_devobj_fdo != 0;
    call {:si_unique_call 71} sdv_StartIoIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_StartIoIrp__Loc == sdv_StartIoIrp;
    assume sdv_StartIoIrp != 0;
    call {:si_unique_call 72} sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc == sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;
    assume sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    call {:si_unique_call 73} sdv_PowerIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_PowerIrp__Loc == sdv_PowerIrp;
    assume sdv_PowerIrp != 0;
    call {:si_unique_call 74} sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc == sdv_IoBuildDeviceIoControlRequest_harnessIrp;
    assume sdv_IoBuildDeviceIoControlRequest_harnessIrp != 0;
    call {:si_unique_call 75} sdv_other_harnessIrp__Loc := __HAVOC_malloc_or_null(248);
    assume sdv_other_harnessIrp__Loc == sdv_other_harnessIrp;
    assume sdv_other_harnessIrp != 0;
    call {:si_unique_call 76} sdv_IoCreateNotificationEvent_KEVENT__Loc := __HAVOC_malloc_or_null(124);
    assume sdv_IoCreateNotificationEvent_KEVENT__Loc == sdv_IoCreateNotificationEvent_KEVENT;
    assume sdv_IoCreateNotificationEvent_KEVENT != 0;
    call {:si_unique_call 77} sdv_other_harnessStackLocation__Loc := __HAVOC_malloc_or_null(496);
    assume sdv_other_harnessStackLocation__Loc == sdv_other_harnessStackLocation;
    assume sdv_other_harnessStackLocation != 0;
    call {:si_unique_call 78} GUID_TRANSLATOR_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TRANSLATOR_INTERFACE_STANDARD__Loc == GUID_TRANSLATOR_INTERFACE_STANDARD;
    assume GUID_TRANSLATOR_INTERFACE_STANDARD != 0;
    call {:si_unique_call 79} GUID_LIDOPEN_POWERSTATE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LIDOPEN_POWERSTATE__Loc == GUID_LIDOPEN_POWERSTATE;
    assume GUID_LIDOPEN_POWERSTATE != 0;
    call {:si_unique_call 80} GUID_PROCESSOR_PARKING_CORE_OVERRIDE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PARKING_CORE_OVERRIDE__Loc == GUID_PROCESSOR_PARKING_CORE_OVERRIDE;
    assume GUID_PROCESSOR_PARKING_CORE_OVERRIDE != 0;
    call {:si_unique_call 81} GUID_PCIEXPRESS_SETTINGS_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCIEXPRESS_SETTINGS_SUBGROUP__Loc == GUID_PCIEXPRESS_SETTINGS_SUBGROUP;
    assume GUID_PCIEXPRESS_SETTINGS_SUBGROUP != 0;
    call {:si_unique_call 82} GUID_ARBITER_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ARBITER_INTERFACE_STANDARD__Loc == GUID_ARBITER_INTERFACE_STANDARD;
    assume GUID_ARBITER_INTERFACE_STANDARD != 0;
    call {:si_unique_call 83} GUID_PROCESSOR_PERF_INCREASE_TIME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_INCREASE_TIME__Loc == GUID_PROCESSOR_PERF_INCREASE_TIME;
    assume GUID_PROCESSOR_PERF_INCREASE_TIME != 0;
    call {:si_unique_call 84} MOUNTDEV_MOUNTED_DEVICE_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume MOUNTDEV_MOUNTED_DEVICE_GUID__Loc == MOUNTDEV_MOUNTED_DEVICE_GUID;
    assume MOUNTDEV_MOUNTED_DEVICE_GUID != 0;
    call {:si_unique_call 85} GUID_DEVINTERFACE_STORAGEPORT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_STORAGEPORT__Loc == GUID_DEVINTERFACE_STORAGEPORT;
    assume GUID_DEVINTERFACE_STORAGEPORT != 0;
    call {:si_unique_call 86} GUID_IO_DEVICE_EXTERNAL_REQUEST__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_DEVICE_EXTERNAL_REQUEST__Loc == GUID_IO_DEVICE_EXTERNAL_REQUEST;
    assume GUID_IO_DEVICE_EXTERNAL_REQUEST != 0;
    call {:si_unique_call 87} VSP_DIAG_DISCOVER_SNAPSHOTS_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_DISCOVER_SNAPSHOTS_ENTER__Loc == VSP_DIAG_DISCOVER_SNAPSHOTS_ENTER;
    assume VSP_DIAG_DISCOVER_SNAPSHOTS_ENTER != 0;
    call {:si_unique_call 88} VSP_DIAG_PRE_EXPOSURE_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_PRE_EXPOSURE_ENTER__Loc == VSP_DIAG_PRE_EXPOSURE_ENTER;
    assume VSP_DIAG_PRE_EXPOSURE_ENTER != 0;
    call {:si_unique_call 89} GUID_DEVINTERFACE_CDCHANGER__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_CDCHANGER__Loc == GUID_DEVINTERFACE_CDCHANGER;
    assume GUID_DEVINTERFACE_CDCHANGER != 0;
    call {:si_unique_call 90} GUID_IO_VOLUME_NAME_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_NAME_CHANGE__Loc == GUID_IO_VOLUME_NAME_CHANGE;
    assume GUID_IO_VOLUME_NAME_CHANGE != 0;
    call {:si_unique_call 91} GUID_IO_DEVICE_BECOMING_READY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_DEVICE_BECOMING_READY__Loc == GUID_IO_DEVICE_BECOMING_READY;
    assume GUID_IO_DEVICE_BECOMING_READY != 0;
    call {:si_unique_call 92} GUID_MF_ENUMERATION_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MF_ENUMERATION_INTERFACE__Loc == GUID_MF_ENUMERATION_INTERFACE;
    assume GUID_MF_ENUMERATION_INTERFACE != 0;
    call {:si_unique_call 93} GUID_ALLOW_RTC_WAKE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_RTC_WAKE__Loc == GUID_ALLOW_RTC_WAKE;
    assume GUID_ALLOW_RTC_WAKE != 0;
    call {:si_unique_call 94} GUID_LEGACY_DEVICE_DETECTION_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LEGACY_DEVICE_DETECTION_STANDARD__Loc == GUID_LEGACY_DEVICE_DETECTION_STANDARD;
    assume GUID_LEGACY_DEVICE_DETECTION_STANDARD != 0;
    call {:si_unique_call 95} VSP_DIAG_PREPARE_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_PREPARE_LEAVE__Loc == VSP_DIAG_PREPARE_LEAVE;
    assume VSP_DIAG_PREPARE_LEAVE != 0;
    call {:si_unique_call 96} GUID_BATTERY_DISCHARGE_LEVEL_2__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_LEVEL_2__Loc == GUID_BATTERY_DISCHARGE_LEVEL_2;
    assume GUID_BATTERY_DISCHARGE_LEVEL_2 != 0;
    call {:si_unique_call 97} GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD != 0;
    call {:si_unique_call 98} GUID_IO_VOLUME_NEED_CHKDSK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_NEED_CHKDSK__Loc == GUID_IO_VOLUME_NEED_CHKDSK;
    assume GUID_IO_VOLUME_NEED_CHKDSK != 0;
    call {:si_unique_call 99} GUID_PNP_POWER_SETTING_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PNP_POWER_SETTING_CHANGE__Loc == GUID_PNP_POWER_SETTING_CHANGE;
    assume GUID_PNP_POWER_SETTING_CHANGE != 0;
    call {:si_unique_call 100} GUID_MONITOR_POWER_ON__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MONITOR_POWER_ON__Loc == GUID_MONITOR_POWER_ON;
    assume GUID_MONITOR_POWER_ON != 0;
    call {:si_unique_call 101} VSP_DIAG_DISMOUNT_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_DISMOUNT_LEAVE__Loc == VSP_DIAG_DISMOUNT_LEAVE;
    assume VSP_DIAG_DISMOUNT_LEAVE != 0;
    call {:si_unique_call 102} GUID_ACPI_REGS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_REGS_INTERFACE_STANDARD__Loc == GUID_ACPI_REGS_INTERFACE_STANDARD;
    assume GUID_ACPI_REGS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 103} GUID_IO_DISK_LAYOUT_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_DISK_LAYOUT_CHANGE__Loc == GUID_IO_DISK_LAYOUT_CHANGE;
    assume GUID_IO_DISK_LAYOUT_CHANGE != 0;
    call {:si_unique_call 104} GUID_PARTITION_UNIT_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PARTITION_UNIT_INTERFACE_STANDARD__Loc == GUID_PARTITION_UNIT_INTERFACE_STANDARD;
    assume GUID_PARTITION_UNIT_INTERFACE_STANDARD != 0;
    call {:si_unique_call 105} GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD != 0;
    call {:si_unique_call 106} GUID_ACDC_POWER_SOURCE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACDC_POWER_SOURCE__Loc == GUID_ACDC_POWER_SOURCE;
    assume GUID_ACDC_POWER_SOURCE != 0;
    call {:si_unique_call 107} GUID_IO_VOLUME_INFO_MAKE_COMPAT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_INFO_MAKE_COMPAT__Loc == GUID_IO_VOLUME_INFO_MAKE_COMPAT;
    assume GUID_IO_VOLUME_INFO_MAKE_COMPAT != 0;
    call {:si_unique_call 108} GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME__Loc == GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME;
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME != 0;
    call {:si_unique_call 109} GUID_PROCESSOR_THROTTLE_MINIMUM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_THROTTLE_MINIMUM__Loc == GUID_PROCESSOR_THROTTLE_MINIMUM;
    assume GUID_PROCESSOR_THROTTLE_MINIMUM != 0;
    call {:si_unique_call 110} GUID_ALLOW_AWAYMODE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_AWAYMODE__Loc == GUID_ALLOW_AWAYMODE;
    assume GUID_ALLOW_AWAYMODE != 0;
    call {:si_unique_call 111} GUID_DEVINTERFACE_TAPE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_TAPE__Loc == GUID_DEVINTERFACE_TAPE;
    assume GUID_DEVINTERFACE_TAPE != 0;
    call {:si_unique_call 112} VSP_DIAG_REVERT_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_REVERT_LEAVE__Loc == VSP_DIAG_REVERT_LEAVE;
    assume VSP_DIAG_REVERT_LEAVE != 0;
    call {:si_unique_call 113} GUID_DISK_ADAPTIVE_POWERDOWN__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_ADAPTIVE_POWERDOWN__Loc == GUID_DISK_ADAPTIVE_POWERDOWN;
    assume GUID_DISK_ADAPTIVE_POWERDOWN != 0;
    call {:si_unique_call 114} GUID_SYSTEM_BUTTON_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SYSTEM_BUTTON_SUBGROUP__Loc == GUID_SYSTEM_BUTTON_SUBGROUP;
    assume GUID_SYSTEM_BUTTON_SUBGROUP != 0;
    call {:si_unique_call 115} VSP_DIAG_END_COMMIT_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_END_COMMIT_LEAVE__Loc == VSP_DIAG_END_COMMIT_LEAVE;
    assume VSP_DIAG_END_COMMIT_LEAVE != 0;
    call {:si_unique_call 116} GUID_SYSTEM_COOLING_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SYSTEM_COOLING_POLICY__Loc == GUID_SYSTEM_COOLING_POLICY;
    assume GUID_SYSTEM_COOLING_POLICY != 0;
    call {:si_unique_call 117} PARTITION_MSFT_RESERVED_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume PARTITION_MSFT_RESERVED_GUID__Loc == PARTITION_MSFT_RESERVED_GUID;
    assume PARTITION_MSFT_RESERVED_GUID != 0;
    call {:si_unique_call 118} GUID_BATTERY_DISCHARGE_LEVEL_3__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_LEVEL_3__Loc == GUID_BATTERY_DISCHARGE_LEVEL_3;
    assume GUID_BATTERY_DISCHARGE_LEVEL_3 != 0;
    call {:si_unique_call 119} GUID_BUS_TYPE_PCI__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_PCI__Loc == GUID_BUS_TYPE_PCI;
    assume GUID_BUS_TYPE_PCI != 0;
    call {:si_unique_call 120} GUID_ALLOW_SYSTEM_REQUIRED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_SYSTEM_REQUIRED__Loc == GUID_ALLOW_SYSTEM_REQUIRED;
    assume GUID_ALLOW_SYSTEM_REQUIRED != 0;
    call {:si_unique_call 121} GUID_TARGET_DEVICE_QUERY_REMOVE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TARGET_DEVICE_QUERY_REMOVE__Loc == GUID_TARGET_DEVICE_QUERY_REMOVE;
    assume GUID_TARGET_DEVICE_QUERY_REMOVE != 0;
    call {:si_unique_call 122} GUID_DEVINTERFACE_HIDDEN_VOLUME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_HIDDEN_VOLUME__Loc == GUID_DEVINTERFACE_HIDDEN_VOLUME;
    assume GUID_DEVINTERFACE_HIDDEN_VOLUME != 0;
    call {:si_unique_call 123} GUID_PCI_BUS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_BUS_INTERFACE_STANDARD__Loc == GUID_PCI_BUS_INTERFACE_STANDARD;
    assume GUID_PCI_BUS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 124} GUID_HWPROFILE_QUERY_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HWPROFILE_QUERY_CHANGE__Loc == GUID_HWPROFILE_QUERY_CHANGE;
    assume GUID_HWPROFILE_QUERY_CHANGE != 0;
    call {:si_unique_call 125} VSP_DIAG_SET_IGNORABLE_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_SET_IGNORABLE_LEAVE__Loc == VSP_DIAG_SET_IGNORABLE_LEAVE;
    assume VSP_DIAG_SET_IGNORABLE_LEAVE != 0;
    call {:si_unique_call 126} GUID_LOCK_CONSOLE_ON_WAKE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LOCK_CONSOLE_ON_WAKE__Loc == GUID_LOCK_CONSOLE_ON_WAKE;
    assume GUID_LOCK_CONSOLE_ON_WAKE != 0;
    call {:si_unique_call 127} VSP_DIAG_FLUSH_HOLD_FS_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_FLUSH_HOLD_FS_LEAVE__Loc == VSP_DIAG_FLUSH_HOLD_FS_LEAVE;
    assume VSP_DIAG_FLUSH_HOLD_FS_LEAVE != 0;
    call {:si_unique_call 128} GUID_VIDEO_POWERDOWN_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_POWERDOWN_TIMEOUT__Loc == GUID_VIDEO_POWERDOWN_TIMEOUT;
    assume GUID_VIDEO_POWERDOWN_TIMEOUT != 0;
    call {:si_unique_call 129} VSP_DIAG_ADJUST_BITMAP_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_ADJUST_BITMAP_LEAVE__Loc == VSP_DIAG_ADJUST_BITMAP_LEAVE;
    assume VSP_DIAG_ADJUST_BITMAP_LEAVE != 0;
    call {:si_unique_call 130} GUID_IO_VOLUME_DISMOUNT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_DISMOUNT__Loc == GUID_IO_VOLUME_DISMOUNT;
    assume GUID_IO_VOLUME_DISMOUNT != 0;
    call {:si_unique_call 131} GUID_PROCESSOR_IDLESTATE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLESTATE_POLICY__Loc == GUID_PROCESSOR_IDLESTATE_POLICY;
    assume GUID_PROCESSOR_IDLESTATE_POLICY != 0;
    call {:si_unique_call 132} GUID_IO_VOLUME_PREPARING_EJECT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_PREPARING_EJECT__Loc == GUID_IO_VOLUME_PREPARING_EJECT;
    assume GUID_IO_VOLUME_PREPARING_EJECT != 0;
    call {:si_unique_call 133} GUID_REENUMERATE_SELF_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_REENUMERATE_SELF_INTERFACE_STANDARD__Loc == GUID_REENUMERATE_SELF_INTERFACE_STANDARD;
    assume GUID_REENUMERATE_SELF_INTERFACE_STANDARD != 0;
    call {:si_unique_call 134} GUID_ALLOW_DISPLAY_REQUIRED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_DISPLAY_REQUIRED__Loc == GUID_ALLOW_DISPLAY_REQUIRED;
    assume GUID_ALLOW_DISPLAY_REQUIRED != 0;
    call {:si_unique_call 135} GUID_UNATTEND_SLEEP_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_UNATTEND_SLEEP_TIMEOUT__Loc == GUID_UNATTEND_SLEEP_TIMEOUT;
    assume GUID_UNATTEND_SLEEP_TIMEOUT != 0;
    call {:si_unique_call 136} GUID_CRITICAL_POWER_TRANSITION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_CRITICAL_POWER_TRANSITION__Loc == GUID_CRITICAL_POWER_TRANSITION;
    assume GUID_CRITICAL_POWER_TRANSITION != 0;
    call {:si_unique_call 137} GUID_SLEEP_IDLE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SLEEP_IDLE_THRESHOLD__Loc == GUID_SLEEP_IDLE_THRESHOLD;
    assume GUID_SLEEP_IDLE_THRESHOLD != 0;
    call {:si_unique_call 138} GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY__Loc == GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY;
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY != 0;
    call {:si_unique_call 139} GUID_IO_VOLUME_DISMOUNT_FAILED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_DISMOUNT_FAILED__Loc == GUID_IO_VOLUME_DISMOUNT_FAILED;
    assume GUID_IO_VOLUME_DISMOUNT_FAILED != 0;
    call {:si_unique_call 140} VSP_DIAG_ACTIVATE_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_ACTIVATE_LEAVE__Loc == VSP_DIAG_ACTIVATE_LEAVE;
    assume VSP_DIAG_ACTIVATE_LEAVE != 0;
    call {:si_unique_call 141} GUID_PROCESSOR_THROTTLE_MAXIMUM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_THROTTLE_MAXIMUM__Loc == GUID_PROCESSOR_THROTTLE_MAXIMUM;
    assume GUID_PROCESSOR_THROTTLE_MAXIMUM != 0;
    call {:si_unique_call 142} PARTITION_BASIC_DATA_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume PARTITION_BASIC_DATA_GUID__Loc == PARTITION_BASIC_DATA_GUID;
    assume PARTITION_BASIC_DATA_GUID != 0;
    call {:si_unique_call 143} GUID_PROCESSOR_PARKING_PERF_STATE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PARKING_PERF_STATE__Loc == GUID_PROCESSOR_PARKING_PERF_STATE;
    assume GUID_PROCESSOR_PARKING_PERF_STATE != 0;
    call {:si_unique_call 144} GUID_PROCESSOR_PERF_DECREASE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_DECREASE_POLICY__Loc == GUID_PROCESSOR_PERF_DECREASE_POLICY;
    assume GUID_PROCESSOR_PERF_DECREASE_POLICY != 0;
    call {:si_unique_call 145} VSP_DIAG_FLUSH_HOLD_FS_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_FLUSH_HOLD_FS_ENTER__Loc == VSP_DIAG_FLUSH_HOLD_FS_ENTER;
    assume VSP_DIAG_FLUSH_HOLD_FS_ENTER != 0;
    call {:si_unique_call 146} PARTITION_ENTRY_UNUSED_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume PARTITION_ENTRY_UNUSED_GUID__Loc == PARTITION_ENTRY_UNUSED_GUID;
    assume PARTITION_ENTRY_UNUSED_GUID != 0;
    call {:si_unique_call 147} VSP_DIAG_ACTIVATE_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_ACTIVATE_ENTER__Loc == VSP_DIAG_ACTIVATE_ENTER;
    assume VSP_DIAG_ACTIVATE_ENTER != 0;
    call {:si_unique_call 148} VOLSNAP_APPINFO_GUID_SYSTEM_HIDDEN__Loc := __HAVOC_malloc_or_null(16);
    assume VOLSNAP_APPINFO_GUID_SYSTEM_HIDDEN__Loc == VOLSNAP_APPINFO_GUID_SYSTEM_HIDDEN;
    assume VOLSNAP_APPINFO_GUID_SYSTEM_HIDDEN != 0;
    call {:si_unique_call 149} GUID_AGP_TARGET_BUS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_AGP_TARGET_BUS_INTERFACE_STANDARD__Loc == GUID_AGP_TARGET_BUS_INTERFACE_STANDARD;
    assume GUID_AGP_TARGET_BUS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 150} GUID_IO_VOLUME_FORCE_CLOSED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_FORCE_CLOSED__Loc == GUID_IO_VOLUME_FORCE_CLOSED;
    assume GUID_IO_VOLUME_FORCE_CLOSED != 0;
    call {:si_unique_call 151} GUID_ALLOW_STANDBY_STATES__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_STANDBY_STATES__Loc == GUID_ALLOW_STANDBY_STATES;
    assume GUID_ALLOW_STANDBY_STATES != 0;
    call {:si_unique_call 152} VSP_DIAG_PROTECTED_BITMAP_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_PROTECTED_BITMAP_ENTER__Loc == VSP_DIAG_PROTECTED_BITMAP_ENTER;
    assume VSP_DIAG_PROTECTED_BITMAP_ENTER != 0;
    call {:si_unique_call 153} VIRTUAL_STORAGE_TYPE_VENDOR_MICROSOFT__Loc := __HAVOC_malloc_or_null(16);
    assume VIRTUAL_STORAGE_TYPE_VENDOR_MICROSOFT__Loc == VIRTUAL_STORAGE_TYPE_VENDOR_MICROSOFT;
    assume VIRTUAL_STORAGE_TYPE_VENDOR_MICROSOFT != 0;
    call {:si_unique_call 154} GUID_STANDBY_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_STANDBY_TIMEOUT__Loc == GUID_STANDBY_TIMEOUT;
    assume GUID_STANDBY_TIMEOUT != 0;
    call {:si_unique_call 155} GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD__Loc == GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD;
    assume GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD != 0;
    call {:si_unique_call 156} VSP_DIAG_SET_IGNORABLE_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_SET_IGNORABLE_ENTER__Loc == VSP_DIAG_SET_IGNORABLE_ENTER;
    assume VSP_DIAG_SET_IGNORABLE_ENTER != 0;
    call {:si_unique_call 157} GUID_PROCESSOR_PERFSTATE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERFSTATE_POLICY__Loc == GUID_PROCESSOR_PERFSTATE_POLICY;
    assume GUID_PROCESSOR_PERFSTATE_POLICY != 0;
    call {:si_unique_call 158} VSP_DIAG_DISCOVER_SNAPSHOTS_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_DISCOVER_SNAPSHOTS_LEAVE__Loc == VSP_DIAG_DISCOVER_SNAPSHOTS_LEAVE;
    assume VSP_DIAG_DISCOVER_SNAPSHOTS_LEAVE != 0;
    call {:si_unique_call 159} GUID_IO_VOLUME_LOCK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_LOCK__Loc == GUID_IO_VOLUME_LOCK;
    assume GUID_IO_VOLUME_LOCK != 0;
    call {:si_unique_call 160} GUID_BUS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_INTERFACE_STANDARD__Loc == GUID_BUS_INTERFACE_STANDARD;
    assume GUID_BUS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 161} GUID_IO_VOLUME_DEVICE_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_DEVICE_INTERFACE__Loc == GUID_IO_VOLUME_DEVICE_INTERFACE;
    assume GUID_IO_VOLUME_DEVICE_INTERFACE != 0;
    call {:si_unique_call 162} GUID_IO_VOLUME_WEARING_OUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_WEARING_OUT__Loc == GUID_IO_VOLUME_WEARING_OUT;
    assume GUID_IO_VOLUME_WEARING_OUT != 0;
    call {:si_unique_call 163} GUID_BATTERY_DISCHARGE_ACTION_1__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_ACTION_1__Loc == GUID_BATTERY_DISCHARGE_ACTION_1;
    assume GUID_BATTERY_DISCHARGE_ACTION_1 != 0;
    call {:si_unique_call 164} GUID_IO_VOLUME_BACKGROUND_FORMAT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_BACKGROUND_FORMAT__Loc == GUID_IO_VOLUME_BACKGROUND_FORMAT;
    assume GUID_IO_VOLUME_BACKGROUND_FORMAT != 0;
    call {:si_unique_call 165} GUID_ACPI_INTERFACE_STANDARD2__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_INTERFACE_STANDARD2__Loc == GUID_ACPI_INTERFACE_STANDARD2;
    assume GUID_ACPI_INTERFACE_STANDARD2 != 0;
    call {:si_unique_call 166} GUID_PROCESSOR_PERF_INCREASE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_INCREASE_POLICY__Loc == GUID_PROCESSOR_PERF_INCREASE_POLICY;
    assume GUID_PROCESSOR_PERF_INCREASE_POLICY != 0;
    call {:si_unique_call 167} VSP_DIAG_DELETE_PROCESS_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_DELETE_PROCESS_LEAVE__Loc == VSP_DIAG_DELETE_PROCESS_LEAVE;
    assume VSP_DIAG_DELETE_PROCESS_LEAVE != 0;
    call {:si_unique_call 168} GUID_VIDEO_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_SUBGROUP__Loc == GUID_VIDEO_SUBGROUP;
    assume GUID_VIDEO_SUBGROUP != 0;
    call {:si_unique_call 169} PARTITION_CLUSTER_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume PARTITION_CLUSTER_GUID__Loc == PARTITION_CLUSTER_GUID;
    assume PARTITION_CLUSTER_GUID != 0;
    call {:si_unique_call 170} GUID_IO_CDROM_EXCLUSIVE_LOCK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_CDROM_EXCLUSIVE_LOCK__Loc == GUID_IO_CDROM_EXCLUSIVE_LOCK;
    assume GUID_IO_CDROM_EXCLUSIVE_LOCK != 0;
    call {:si_unique_call 171} GUID_TYPICAL_POWER_SAVINGS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TYPICAL_POWER_SAVINGS__Loc == GUID_TYPICAL_POWER_SAVINGS;
    assume GUID_TYPICAL_POWER_SAVINGS != 0;
    call {:si_unique_call 172} GUID_HIBERNATE_FASTS4_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HIBERNATE_FASTS4_POLICY__Loc == GUID_HIBERNATE_FASTS4_POLICY;
    assume GUID_HIBERNATE_FASTS4_POLICY != 0;
    call {:si_unique_call 173} GUID_IO_VOLUME_UNIQUE_ID_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_UNIQUE_ID_CHANGE__Loc == GUID_IO_VOLUME_UNIQUE_ID_CHANGE;
    assume GUID_IO_VOLUME_UNIQUE_ID_CHANGE != 0;
    call {:si_unique_call 174} GUID_DEVICE_INTERFACE_REMOVAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_INTERFACE_REMOVAL__Loc == GUID_DEVICE_INTERFACE_REMOVAL;
    assume GUID_DEVICE_INTERFACE_REMOVAL != 0;
    call {:si_unique_call 175} GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR__Loc == GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR;
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR != 0;
    call {:si_unique_call 176} GUID_PCI_DEVICE_PRESENT_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_DEVICE_PRESENT_INTERFACE__Loc == GUID_PCI_DEVICE_PRESENT_INTERFACE;
    assume GUID_PCI_DEVICE_PRESENT_INTERFACE != 0;
    call {:si_unique_call 177} GUID_POWER_DEVICE_TIMEOUTS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWER_DEVICE_TIMEOUTS__Loc == GUID_POWER_DEVICE_TIMEOUTS;
    assume GUID_POWER_DEVICE_TIMEOUTS != 0;
    call {:si_unique_call 178} GUID_MSIX_TABLE_CONFIG_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MSIX_TABLE_CONFIG_INTERFACE__Loc == GUID_MSIX_TABLE_CONFIG_INTERFACE;
    assume GUID_MSIX_TABLE_CONFIG_INTERFACE != 0;
    call {:si_unique_call 179} GUID_PROCESSOR_SETTINGS_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_SETTINGS_SUBGROUP__Loc == GUID_PROCESSOR_SETTINGS_SUBGROUP;
    assume GUID_PROCESSOR_SETTINGS_SUBGROUP != 0;
    call {:si_unique_call 180} GUID_HWPROFILE_CHANGE_COMPLETE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HWPROFILE_CHANGE_COMPLETE__Loc == GUID_HWPROFILE_CHANGE_COMPLETE;
    assume GUID_HWPROFILE_CHANGE_COMPLETE != 0;
    call {:si_unique_call 181} GUID_IO_MEDIA_ARRIVAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_MEDIA_ARRIVAL__Loc == GUID_IO_MEDIA_ARRIVAL;
    assume GUID_IO_MEDIA_ARRIVAL != 0;
    call {:si_unique_call 182} GUID_BUS_TYPE_AVC__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_AVC__Loc == GUID_BUS_TYPE_AVC;
    assume GUID_BUS_TYPE_AVC != 0;
    call {:si_unique_call 183} VSP_DIAG_DELETE_PROCESS_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_DELETE_PROCESS_ENTER__Loc == VSP_DIAG_DELETE_PROCESS_ENTER;
    assume VSP_DIAG_DELETE_PROCESS_ENTER != 0;
    call {:si_unique_call 184} GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__Loc == GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS;
    assume GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS != 0;
    call {:si_unique_call 185} GUID_BATTERY_DISCHARGE_FLAGS_2__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_FLAGS_2__Loc == GUID_BATTERY_DISCHARGE_FLAGS_2;
    assume GUID_BATTERY_DISCHARGE_FLAGS_2 != 0;
    call {:si_unique_call 186} VSP_DIAG_ACTIVATE_LOOP_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_ACTIVATE_LOOP_ENTER__Loc == VSP_DIAG_ACTIVATE_LOOP_ENTER;
    assume VSP_DIAG_ACTIVATE_LOOP_ENTER != 0;
    call {:si_unique_call 187} GUID_DEVINTERFACE_VOLUME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_VOLUME__Loc == GUID_DEVINTERFACE_VOLUME;
    assume GUID_DEVINTERFACE_VOLUME != 0;
    call {:si_unique_call 188} GUID_DEVICE_EVENT_RBC__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_EVENT_RBC__Loc == GUID_DEVICE_EVENT_RBC;
    assume GUID_DEVICE_EVENT_RBC != 0;
    call {:si_unique_call 189} GUID_HIBERNATE_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HIBERNATE_TIMEOUT__Loc == GUID_HIBERNATE_TIMEOUT;
    assume GUID_HIBERNATE_TIMEOUT != 0;
    call {:si_unique_call 190} GUID_DEVINTERFACE_MEDIUMCHANGER__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_MEDIUMCHANGER__Loc == GUID_DEVINTERFACE_MEDIUMCHANGER;
    assume GUID_DEVINTERFACE_MEDIUMCHANGER != 0;
    call {:si_unique_call 191} GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD__Loc == GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD;
    assume GUID_ACPI_PORT_RANGES_INTERFACE_STANDARD != 0;
    call {:si_unique_call 192} GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME__Loc == GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME;
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME != 0;
    call {:si_unique_call 193} GUID_SESSION_DISPLAY_STATE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SESSION_DISPLAY_STATE__Loc == GUID_SESSION_DISPLAY_STATE;
    assume GUID_SESSION_DISPLAY_STATE != 0;
    call {:si_unique_call 194} GUID_BATTERY_DISCHARGE_ACTION_3__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_ACTION_3__Loc == GUID_BATTERY_DISCHARGE_ACTION_3;
    assume GUID_BATTERY_DISCHARGE_ACTION_3 != 0;
    call {:si_unique_call 195} GUID_POWER_DEVICE_ENABLE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWER_DEVICE_ENABLE__Loc == GUID_POWER_DEVICE_ENABLE;
    assume GUID_POWER_DEVICE_ENABLE != 0;
    call {:si_unique_call 196} GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE__Loc == GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE;
    assume GUID_PCI_EXPRESS_ROOT_PORT_INTERFACE != 0;
    call {:si_unique_call 197} GUID_PROCESSOR_CORE_PARKING_MIN_CORES__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_MIN_CORES__Loc == GUID_PROCESSOR_CORE_PARKING_MIN_CORES;
    assume GUID_PROCESSOR_CORE_PARKING_MIN_CORES != 0;
    call {:si_unique_call 198} GUID_PNP_CUSTOM_NOTIFICATION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PNP_CUSTOM_NOTIFICATION__Loc == GUID_PNP_CUSTOM_NOTIFICATION;
    assume GUID_PNP_CUSTOM_NOTIFICATION != 0;
    call {:si_unique_call 199} GUID_IO_VOLUME_UNLOCK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_UNLOCK__Loc == GUID_IO_VOLUME_UNLOCK;
    assume GUID_IO_VOLUME_UNLOCK != 0;
    call {:si_unique_call 200} GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD != 0;
    call {:si_unique_call 201} GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR__Loc == GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR;
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR != 0;
    call {:si_unique_call 202} ntAuthority__Loc := __HAVOC_malloc_or_null(4);
    assume ntAuthority__Loc == ntAuthority;
    assume ntAuthority != 0;
    call {:si_unique_call 203} GUID_ACPI_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_INTERFACE_STANDARD__Loc == GUID_ACPI_INTERFACE_STANDARD;
    assume GUID_ACPI_INTERFACE_STANDARD != 0;
    call {:si_unique_call 204} GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING__Loc == GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING;
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING != 0;
    call {:si_unique_call 205} PARTITION_SYSTEM_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume PARTITION_SYSTEM_GUID__Loc == PARTITION_SYSTEM_GUID;
    assume PARTITION_SYSTEM_GUID != 0;
    call {:si_unique_call 206} GUID_SLEEPBUTTON_ACTION_FLAGS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SLEEPBUTTON_ACTION_FLAGS__Loc == GUID_SLEEPBUTTON_ACTION_FLAGS;
    assume GUID_SLEEPBUTTON_ACTION_FLAGS != 0;
    call {:si_unique_call 207} PARTITION_LDM_DATA_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume PARTITION_LDM_DATA_GUID__Loc == PARTITION_LDM_DATA_GUID;
    assume PARTITION_LDM_DATA_GUID != 0;
    call {:si_unique_call 208} GUID_POWERBUTTON_ACTION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWERBUTTON_ACTION__Loc == GUID_POWERBUTTON_ACTION;
    assume GUID_POWERBUTTON_ACTION != 0;
    call {:si_unique_call 209} PARTITION_MSFT_RECOVERY_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume PARTITION_MSFT_RECOVERY_GUID__Loc == PARTITION_MSFT_RECOVERY_GUID;
    assume PARTITION_MSFT_RECOVERY_GUID != 0;
    call {:si_unique_call 210} GUID_ACPI_CMOS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACPI_CMOS_INTERFACE_STANDARD__Loc == GUID_ACPI_CMOS_INTERFACE_STANDARD;
    assume GUID_ACPI_CMOS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 211} GUID_USERINTERFACEBUTTON_ACTION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_USERINTERFACEBUTTON_ACTION__Loc == GUID_USERINTERFACEBUTTON_ACTION;
    assume GUID_USERINTERFACEBUTTON_ACTION != 0;
    call {:si_unique_call 212} GUID_PROCESSOR_THROTTLE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_THROTTLE_POLICY__Loc == GUID_PROCESSOR_THROTTLE_POLICY;
    assume GUID_PROCESSOR_THROTTLE_POLICY != 0;
    call {:si_unique_call 213} GUID_PCIEXPRESS_ASPM_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCIEXPRESS_ASPM_POLICY__Loc == GUID_PCIEXPRESS_ASPM_POLICY;
    assume GUID_PCIEXPRESS_ASPM_POLICY != 0;
    call {:si_unique_call 214} GUID_DEVINTERFACE_WRITEONCEDISK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_WRITEONCEDISK__Loc == GUID_DEVINTERFACE_WRITEONCEDISK;
    assume GUID_DEVINTERFACE_WRITEONCEDISK != 0;
    call {:si_unique_call 215} GUID_BUS_TYPE_ISAPNP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_ISAPNP__Loc == GUID_BUS_TYPE_ISAPNP;
    assume GUID_BUS_TYPE_ISAPNP != 0;
    call {:si_unique_call 216} GUID_BATTERY_PERCENTAGE_REMAINING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_PERCENTAGE_REMAINING__Loc == GUID_BATTERY_PERCENTAGE_REMAINING;
    assume GUID_BATTERY_PERCENTAGE_REMAINING != 0;
    call {:si_unique_call 217} GUID_BATTERY_DISCHARGE_ACTION_2__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_ACTION_2__Loc == GUID_BATTERY_DISCHARGE_ACTION_2;
    assume GUID_BATTERY_DISCHARGE_ACTION_2 != 0;
    call {:si_unique_call 218} GUID_APPLAUNCH_BUTTON__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_APPLAUNCH_BUTTON__Loc == GUID_APPLAUNCH_BUTTON;
    assume GUID_APPLAUNCH_BUTTON != 0;
    call {:si_unique_call 219} GUID_BATTERY_DISCHARGE_FLAGS_1__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_FLAGS_1__Loc == GUID_BATTERY_DISCHARGE_FLAGS_1;
    assume GUID_BATTERY_DISCHARGE_FLAGS_1 != 0;
    call {:si_unique_call 220} GUID_PROCESSOR_ALLOW_THROTTLING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_ALLOW_THROTTLING__Loc == GUID_PROCESSOR_ALLOW_THROTTLING;
    assume GUID_PROCESSOR_ALLOW_THROTTLING != 0;
    call {:si_unique_call 221} VSP_DIAG_END_COMMIT_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_END_COMMIT_ENTER__Loc == VSP_DIAG_END_COMMIT_ENTER;
    assume VSP_DIAG_END_COMMIT_ENTER != 0;
    call {:si_unique_call 222} VSP_DIAG_REMOUNT_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_REMOUNT_LEAVE__Loc == VSP_DIAG_REMOUNT_LEAVE;
    assume VSP_DIAG_REMOUNT_LEAVE != 0;
    call {:si_unique_call 223} GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE__Loc == GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE;
    assume GUID_PCI_EXPRESS_LINK_QUIESCENT_INTERFACE != 0;
    call {:si_unique_call 224} GUID_BUS_TYPE_DOT4PRT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_DOT4PRT__Loc == GUID_BUS_TYPE_DOT4PRT;
    assume GUID_BUS_TYPE_DOT4PRT != 0;
    call {:si_unique_call 225} VSP_DIAG_IGNORABLE_PRODUCT_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_IGNORABLE_PRODUCT_ENTER__Loc == VSP_DIAG_IGNORABLE_PRODUCT_ENTER;
    assume VSP_DIAG_IGNORABLE_PRODUCT_ENTER != 0;
    call {:si_unique_call 226} GUID_BUS_TYPE_EISA__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_EISA__Loc == GUID_BUS_TYPE_EISA;
    assume GUID_BUS_TYPE_EISA != 0;
    call {:si_unique_call 227} GUID_DISK_BURST_IGNORE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_BURST_IGNORE_THRESHOLD__Loc == GUID_DISK_BURST_IGNORE_THRESHOLD;
    assume GUID_DISK_BURST_IGNORE_THRESHOLD != 0;
    call {:si_unique_call 228} GUID_SLEEPBUTTON_ACTION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SLEEPBUTTON_ACTION__Loc == GUID_SLEEPBUTTON_ACTION;
    assume GUID_SLEEPBUTTON_ACTION != 0;
    call {:si_unique_call 229} GUID_PROCESSOR_IDLE_DISABLE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_DISABLE__Loc == GUID_PROCESSOR_IDLE_DISABLE;
    assume GUID_PROCESSOR_IDLE_DISABLE != 0;
    call {:si_unique_call 230} GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED__Loc == GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED;
    assume GUID_TARGET_DEVICE_TRANSPORT_RELATIONS_CHANGED != 0;
    call {:si_unique_call 231} GUID_BUS_TYPE_IRDA__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_IRDA__Loc == GUID_BUS_TYPE_IRDA;
    assume GUID_BUS_TYPE_IRDA != 0;
    call {:si_unique_call 232} GUID_DISK_POWERDOWN_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_POWERDOWN_TIMEOUT__Loc == GUID_DISK_POWERDOWN_TIMEOUT;
    assume GUID_DISK_POWERDOWN_TIMEOUT != 0;
    call {:si_unique_call 233} GUID_CONSOLE_DISPLAY_STATE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_CONSOLE_DISPLAY_STATE__Loc == GUID_CONSOLE_DISPLAY_STATE;
    assume GUID_CONSOLE_DISPLAY_STATE != 0;
    call {:si_unique_call 234} GUID_BATTERY_DISCHARGE_FLAGS_0__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_FLAGS_0__Loc == GUID_BATTERY_DISCHARGE_FLAGS_0;
    assume GUID_BATTERY_DISCHARGE_FLAGS_0 != 0;
    call {:si_unique_call 235} VSP_DIAG_ACTIVATE_LOOP_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_ACTIVATE_LOOP_LEAVE__Loc == VSP_DIAG_ACTIVATE_LOOP_LEAVE;
    assume VSP_DIAG_ACTIVATE_LOOP_LEAVE != 0;
    call {:si_unique_call 236} VIRTUAL_STORAGE_TYPE_VENDOR_UNKNOWN__Loc := __HAVOC_malloc_or_null(16);
    assume VIRTUAL_STORAGE_TYPE_VENDOR_UNKNOWN__Loc == VIRTUAL_STORAGE_TYPE_VENDOR_UNKNOWN;
    assume VIRTUAL_STORAGE_TYPE_VENDOR_UNKNOWN != 0;
    call {:si_unique_call 237} GUID_BUS_TYPE_MCA__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_MCA__Loc == GUID_BUS_TYPE_MCA;
    assume GUID_BUS_TYPE_MCA != 0;
    call {:si_unique_call 238} GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS__Loc == GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS;
    assume GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS != 0;
    call {:si_unique_call 239} GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD__Loc == GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD;
    assume GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD != 0;
    call {:si_unique_call 240} KeTickCount__Loc := __HAVOC_malloc_or_null(12);
    assume KeTickCount__Loc == KeTickCount;
    assume KeTickCount != 0;
    call {:si_unique_call 241} GUID_PNP_LOCATION_INTERFACE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PNP_LOCATION_INTERFACE__Loc == GUID_PNP_LOCATION_INTERFACE;
    assume GUID_PNP_LOCATION_INTERFACE != 0;
    call {:si_unique_call 242} GUID_BUS_TYPE_INTERNAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_INTERNAL__Loc == GUID_BUS_TYPE_INTERNAL;
    assume GUID_BUS_TYPE_INTERNAL != 0;
    call {:si_unique_call 243} GUID_IO_VOLUME_PHYSICAL_CONFIGURATION_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_PHYSICAL_CONFIGURATION_CHANGE__Loc == GUID_IO_VOLUME_PHYSICAL_CONFIGURATION_CHANGE;
    assume GUID_IO_VOLUME_PHYSICAL_CONFIGURATION_CHANGE != 0;
    call {:si_unique_call 244} GUID_IO_DISK_CLONE_ARRIVAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_DISK_CLONE_ARRIVAL__Loc == GUID_IO_DISK_CLONE_ARRIVAL;
    assume GUID_IO_DISK_CLONE_ARRIVAL != 0;
    call {:si_unique_call 245} GUID_DEVINTERFACE_FLOPPY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_FLOPPY__Loc == GUID_DEVINTERFACE_FLOPPY;
    assume GUID_DEVINTERFACE_FLOPPY != 0;
    call {:si_unique_call 246} GUID_IO_TAPE_ERASE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_TAPE_ERASE__Loc == GUID_IO_TAPE_ERASE;
    assume GUID_IO_TAPE_ERASE != 0;
    call {:si_unique_call 247} VSP_DIAG_PREPARE_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_PREPARE_ENTER__Loc == VSP_DIAG_PREPARE_ENTER;
    assume VSP_DIAG_PREPARE_ENTER != 0;
    call {:si_unique_call 248} VSP_DIAG_PROTECTED_BITMAP_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_PROTECTED_BITMAP_LEAVE__Loc == VSP_DIAG_PROTECTED_BITMAP_LEAVE;
    assume VSP_DIAG_PROTECTED_BITMAP_LEAVE != 0;
    call {:si_unique_call 249} NO_SUBGROUP_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume NO_SUBGROUP_GUID__Loc == NO_SUBGROUP_GUID;
    assume NO_SUBGROUP_GUID != 0;
    call {:si_unique_call 250} GUID_PROCESSOR_PCC_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PCC_INTERFACE_STANDARD__Loc == GUID_PROCESSOR_PCC_INTERFACE_STANDARD;
    assume GUID_PROCESSOR_PCC_INTERFACE_STANDARD != 0;
    call {:si_unique_call 251} ALL_POWERSCHEMES_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume ALL_POWERSCHEMES_GUID__Loc == ALL_POWERSCHEMES_GUID;
    assume ALL_POWERSCHEMES_GUID != 0;
    call {:si_unique_call 252} GUID_LIDSWITCH_STATE_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LIDSWITCH_STATE_CHANGE__Loc == GUID_LIDSWITCH_STATE_CHANGE;
    assume GUID_LIDSWITCH_STATE_CHANGE != 0;
    call {:si_unique_call 253} GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY__Loc == GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY;
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY != 0;
    call {:si_unique_call 254} GUID_DEVINTERFACE_PARTITION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_PARTITION__Loc == GUID_DEVINTERFACE_PARTITION;
    assume GUID_DEVINTERFACE_PARTITION != 0;
    call {:si_unique_call 255} VSP_DIAG_ADJUST_BITMAP_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_ADJUST_BITMAP_ENTER__Loc == VSP_DIAG_ADJUST_BITMAP_ENTER;
    assume VSP_DIAG_ADJUST_BITMAP_ENTER != 0;
    call {:si_unique_call 256} GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS__Loc == GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS;
    assume GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS != 0;
    call {:si_unique_call 257} GUID_PROCESSOR_IDLE_ALLOW_SCALING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_ALLOW_SCALING__Loc == GUID_PROCESSOR_IDLE_ALLOW_SCALING;
    assume GUID_PROCESSOR_IDLE_ALLOW_SCALING != 0;
    call {:si_unique_call 258} GUID_LIDCLOSE_ACTION_FLAGS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LIDCLOSE_ACTION_FLAGS__Loc == GUID_LIDCLOSE_ACTION_FLAGS;
    assume GUID_LIDCLOSE_ACTION_FLAGS != 0;
    call {:si_unique_call 259} GUID_IO_MEDIA_REMOVAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_MEDIA_REMOVAL__Loc == GUID_IO_MEDIA_REMOVAL;
    assume GUID_IO_MEDIA_REMOVAL != 0;
    call {:si_unique_call 260} GUID_BUS_TYPE_SD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_SD__Loc == GUID_BUS_TYPE_SD;
    assume GUID_BUS_TYPE_SD != 0;
    call {:si_unique_call 261} GUID_PNP_POWER_NOTIFICATION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PNP_POWER_NOTIFICATION__Loc == GUID_PNP_POWER_NOTIFICATION;
    assume GUID_PNP_POWER_NOTIFICATION != 0;
    call {:si_unique_call 262} GUID_IO_MEDIA_EJECT_REQUEST__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_MEDIA_EJECT_REQUEST__Loc == GUID_IO_MEDIA_EJECT_REQUEST;
    assume GUID_IO_MEDIA_EJECT_REQUEST != 0;
    call {:si_unique_call 263} GUID_PROCESSOR_IDLE_TIME_CHECK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_TIME_CHECK__Loc == GUID_PROCESSOR_IDLE_TIME_CHECK;
    assume GUID_PROCESSOR_IDLE_TIME_CHECK != 0;
    call {:si_unique_call 264} GUID_BUS_TYPE_HID__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_HID__Loc == GUID_BUS_TYPE_HID;
    assume GUID_BUS_TYPE_HID != 0;
    call {:si_unique_call 265} GUID_TARGET_DEVICE_REMOVE_COMPLETE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TARGET_DEVICE_REMOVE_COMPLETE__Loc == GUID_TARGET_DEVICE_REMOVE_COMPLETE;
    assume GUID_TARGET_DEVICE_REMOVE_COMPLETE != 0;
    call {:si_unique_call 266} GUID_PROCESSOR_PERF_INCREASE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_INCREASE_THRESHOLD__Loc == GUID_PROCESSOR_PERF_INCREASE_THRESHOLD;
    assume GUID_PROCESSOR_PERF_INCREASE_THRESHOLD != 0;
    call {:si_unique_call 267} GUID_BACKGROUND_TASK_NOTIFICATION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BACKGROUND_TASK_NOTIFICATION__Loc == GUID_BACKGROUND_TASK_NOTIFICATION;
    assume GUID_BACKGROUND_TASK_NOTIFICATION != 0;
    call {:si_unique_call 268} GUID_POWER_DEVICE_WAKE_ENABLE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWER_DEVICE_WAKE_ENABLE__Loc == GUID_POWER_DEVICE_WAKE_ENABLE;
    assume GUID_POWER_DEVICE_WAKE_ENABLE != 0;
    call {:si_unique_call 269} GUID_PROCESSOR_PERF_HISTORY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_HISTORY__Loc == GUID_PROCESSOR_PERF_HISTORY;
    assume GUID_PROCESSOR_PERF_HISTORY != 0;
    call {:si_unique_call 270} GUID_PCMCIA_BUS_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCMCIA_BUS_INTERFACE_STANDARD__Loc == GUID_PCMCIA_BUS_INTERFACE_STANDARD;
    assume GUID_PCMCIA_BUS_INTERFACE_STANDARD != 0;
    call {:si_unique_call 271} GUID_BUS_TYPE_PCMCIA__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_PCMCIA__Loc == GUID_BUS_TYPE_PCMCIA;
    assume GUID_BUS_TYPE_PCMCIA != 0;
    call {:si_unique_call 272} GUID_VIDEO_ANNOYANCE_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_ANNOYANCE_TIMEOUT__Loc == GUID_VIDEO_ANNOYANCE_TIMEOUT;
    assume GUID_VIDEO_ANNOYANCE_TIMEOUT != 0;
    call {:si_unique_call 273} GUID_BATTERY_DISCHARGE_FLAGS_3__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_FLAGS_3__Loc == GUID_BATTERY_DISCHARGE_FLAGS_3;
    assume GUID_BATTERY_DISCHARGE_FLAGS_3 != 0;
    call {:si_unique_call 274} GUID_PROCESSOR_CORE_PARKING_MAX_CORES__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_MAX_CORES__Loc == GUID_PROCESSOR_CORE_PARKING_MAX_CORES;
    assume GUID_PROCESSOR_CORE_PARKING_MAX_CORES != 0;
    call {:si_unique_call 275} VOLSNAP_APPINFO_GUID_CLIENT_ACCESSIBLE__Loc := __HAVOC_malloc_or_null(16);
    assume VOLSNAP_APPINFO_GUID_CLIENT_ACCESSIBLE__Loc == VOLSNAP_APPINFO_GUID_CLIENT_ACCESSIBLE;
    assume VOLSNAP_APPINFO_GUID_CLIENT_ACCESSIBLE != 0;
    call {:si_unique_call 276} GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE__Loc == GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE;
    assume GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE != 0;
    call {:si_unique_call 277} GUID_VIDEO_ADAPTIVE_POWERDOWN__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_ADAPTIVE_POWERDOWN__Loc == GUID_VIDEO_ADAPTIVE_POWERDOWN;
    assume GUID_VIDEO_ADAPTIVE_POWERDOWN != 0;
    call {:si_unique_call 278} GUID_BUS_TYPE_1394__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_1394__Loc == GUID_BUS_TYPE_1394;
    assume GUID_BUS_TYPE_1394 != 0;
    call {:si_unique_call 279} GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD != 0;
    call {:si_unique_call 280} GUID_TARGET_DEVICE_REMOVE_CANCELLED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TARGET_DEVICE_REMOVE_CANCELLED__Loc == GUID_TARGET_DEVICE_REMOVE_CANCELLED;
    assume GUID_TARGET_DEVICE_REMOVE_CANCELLED != 0;
    call {:si_unique_call 281} GUID_MIN_POWER_SAVINGS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MIN_POWER_SAVINGS__Loc == GUID_MIN_POWER_SAVINGS;
    assume GUID_MIN_POWER_SAVINGS != 0;
    call {:si_unique_call 282} GUID_DEVICE_IDLE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_IDLE_POLICY__Loc == GUID_DEVICE_IDLE_POLICY;
    assume GUID_DEVICE_IDLE_POLICY != 0;
    call {:si_unique_call 283} GUID_PROCESSOR_PERF_BOOST_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_BOOST_POLICY__Loc == GUID_PROCESSOR_PERF_BOOST_POLICY;
    assume GUID_PROCESSOR_PERF_BOOST_POLICY != 0;
    call {:si_unique_call 284} VSP_DIAG_PRE_EXPOSURE_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_PRE_EXPOSURE_LEAVE__Loc == VSP_DIAG_PRE_EXPOSURE_LEAVE;
    assume VSP_DIAG_PRE_EXPOSURE_LEAVE != 0;
    call {:si_unique_call 285} GUID_LIDCLOSE_ACTION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LIDCLOSE_ACTION__Loc == GUID_LIDCLOSE_ACTION;
    assume GUID_LIDCLOSE_ACTION != 0;
    call {:si_unique_call 286} VSP_DIAG_VALIDATE_FILES_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_VALIDATE_FILES_LEAVE__Loc == VSP_DIAG_VALIDATE_FILES_LEAVE;
    assume VSP_DIAG_VALIDATE_FILES_LEAVE != 0;
    call {:si_unique_call 287} GUID_IO_VOLUME_MOUNT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_MOUNT__Loc == GUID_IO_VOLUME_MOUNT;
    assume GUID_IO_VOLUME_MOUNT != 0;
    call {:si_unique_call 288} GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS__Loc == GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS;
    assume GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS != 0;
    call {:si_unique_call 289} GUID_DEVINTERFACE_CDROM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_CDROM__Loc == GUID_DEVINTERFACE_CDROM;
    assume GUID_DEVINTERFACE_CDROM != 0;
    call {:si_unique_call 290} VSP_DIAG_DISMOUNT_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_DISMOUNT_ENTER__Loc == VSP_DIAG_DISMOUNT_ENTER;
    assume VSP_DIAG_DISMOUNT_ENTER != 0;
    call {:si_unique_call 291} GUID_DEVINTERFACE_DISK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVINTERFACE_DISK__Loc == GUID_DEVINTERFACE_DISK;
    assume GUID_DEVINTERFACE_DISK != 0;
    call {:si_unique_call 292} GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD != 0;
    call {:si_unique_call 293} GUID_SLEEP_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SLEEP_SUBGROUP__Loc == GUID_SLEEP_SUBGROUP;
    assume GUID_SLEEP_SUBGROUP != 0;
    call {:si_unique_call 294} GUID_POWERBUTTON_ACTION_FLAGS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWERBUTTON_ACTION_FLAGS__Loc == GUID_POWERBUTTON_ACTION_FLAGS;
    assume GUID_POWERBUTTON_ACTION_FLAGS != 0;
    call {:si_unique_call 295} GUID_PROCESSOR_PERF_DECREASE_TIME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_DECREASE_TIME__Loc == GUID_PROCESSOR_PERF_DECREASE_TIME;
    assume GUID_PROCESSOR_PERF_DECREASE_TIME != 0;
    call {:si_unique_call 296} GUID_IO_VOLUME_WORM_NEAR_FULL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_WORM_NEAR_FULL__Loc == GUID_IO_VOLUME_WORM_NEAR_FULL;
    assume GUID_IO_VOLUME_WORM_NEAR_FULL != 0;
    call {:si_unique_call 297} VSP_DIAG_VALIDATE_FILES_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_VALIDATE_FILES_ENTER__Loc == VSP_DIAG_VALIDATE_FILES_ENTER;
    assume VSP_DIAG_VALIDATE_FILES_ENTER != 0;
    call {:si_unique_call 298} GUID_MAX_POWER_SAVINGS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MAX_POWER_SAVINGS__Loc == GUID_MAX_POWER_SAVINGS;
    assume GUID_MAX_POWER_SAVINGS != 0;
    call {:si_unique_call 299} GUID_WUDF_DEVICE_HOST_PROBLEM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_WUDF_DEVICE_HOST_PROBLEM__Loc == GUID_WUDF_DEVICE_HOST_PROBLEM;
    assume GUID_WUDF_DEVICE_HOST_PROBLEM != 0;
    call {:si_unique_call 300} GUID_BATTERY_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_SUBGROUP__Loc == GUID_BATTERY_SUBGROUP;
    assume GUID_BATTERY_SUBGROUP != 0;
    call {:si_unique_call 301} GUID_IO_VOLUME_FVE_STATUS_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_FVE_STATUS_CHANGE__Loc == GUID_IO_VOLUME_FVE_STATUS_CHANGE;
    assume GUID_IO_VOLUME_FVE_STATUS_CHANGE != 0;
    call {:si_unique_call 302} GUID_BUS_TYPE_SERENUM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_SERENUM__Loc == GUID_BUS_TYPE_SERENUM;
    assume GUID_BUS_TYPE_SERENUM != 0;
    call {:si_unique_call 303} VSP_DIAG_VOLUME_SAFE_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_VOLUME_SAFE_LEAVE__Loc == VSP_DIAG_VOLUME_SAFE_LEAVE;
    assume VSP_DIAG_VOLUME_SAFE_LEAVE != 0;
    call {:si_unique_call 304} GUID_HWPROFILE_CHANGE_CANCELLED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HWPROFILE_CHANGE_CANCELLED__Loc == GUID_HWPROFILE_CHANGE_CANCELLED;
    assume GUID_HWPROFILE_CHANGE_CANCELLED != 0;
    call {:si_unique_call 305} GUID_BUS_TYPE_LPTENUM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_LPTENUM__Loc == GUID_BUS_TYPE_LPTENUM;
    assume GUID_BUS_TYPE_LPTENUM != 0;
    call {:si_unique_call 306} PARTITION_LDM_METADATA_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume PARTITION_LDM_METADATA_GUID__Loc == PARTITION_LDM_METADATA_GUID;
    assume PARTITION_LDM_METADATA_GUID != 0;
    call {:si_unique_call 307} GUID_DEVICE_INTERFACE_ARRIVAL__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_INTERFACE_ARRIVAL__Loc == GUID_DEVICE_INTERFACE_ARRIVAL;
    assume GUID_DEVICE_INTERFACE_ARRIVAL != 0;
    call {:si_unique_call 308} GUID_IO_VOLUME_CHANGE_SIZE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_CHANGE_SIZE__Loc == GUID_IO_VOLUME_CHANGE_SIZE;
    assume GUID_IO_VOLUME_CHANGE_SIZE != 0;
    call {:si_unique_call 309} GUID_IDLE_BACKGROUND_TASK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IDLE_BACKGROUND_TASK__Loc == GUID_IDLE_BACKGROUND_TASK;
    assume GUID_IDLE_BACKGROUND_TASK != 0;
    call {:si_unique_call 310} GUID_DISK_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_SUBGROUP__Loc == GUID_DISK_SUBGROUP;
    assume GUID_DISK_SUBGROUP != 0;
    call {:si_unique_call 311} VSP_DIFF_AREA_FILE_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume VSP_DIFF_AREA_FILE_GUID__Loc == VSP_DIFF_AREA_FILE_GUID;
    assume VSP_DIFF_AREA_FILE_GUID != 0;
    call {:si_unique_call 312} VSP_DIAG_REVERT_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_REVERT_ENTER__Loc == VSP_DIAG_REVERT_ENTER;
    assume VSP_DIAG_REVERT_ENTER != 0;
    call {:si_unique_call 313} GUID_IO_CDROM_EXCLUSIVE_UNLOCK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_CDROM_EXCLUSIVE_UNLOCK__Loc == GUID_IO_CDROM_EXCLUSIVE_UNLOCK;
    assume GUID_IO_CDROM_EXCLUSIVE_UNLOCK != 0;
    call {:si_unique_call 314} GUID_BUS_TYPE_USB__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_USB__Loc == GUID_BUS_TYPE_USB;
    assume GUID_BUS_TYPE_USB != 0;
    call {:si_unique_call 315} GUID_POWERSCHEME_PERSONALITY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWERSCHEME_PERSONALITY__Loc == GUID_POWERSCHEME_PERSONALITY;
    assume GUID_POWERSCHEME_PERSONALITY != 0;
    call {:si_unique_call 316} GUID_IO_DRIVE_REQUIRES_CLEANING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_DRIVE_REQUIRES_CLEANING__Loc == GUID_IO_DRIVE_REQUIRES_CLEANING;
    assume GUID_IO_DRIVE_REQUIRES_CLEANING != 0;
    call {:si_unique_call 317} VSP_DIAG_VOLUME_SAFE_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_VOLUME_SAFE_ENTER__Loc == VSP_DIAG_VOLUME_SAFE_ENTER;
    assume VSP_DIAG_VOLUME_SAFE_ENTER != 0;
    call {:si_unique_call 318} GUID_INT_ROUTE_INTERFACE_STANDARD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_INT_ROUTE_INTERFACE_STANDARD__Loc == GUID_INT_ROUTE_INTERFACE_STANDARD;
    assume GUID_INT_ROUTE_INTERFACE_STANDARD != 0;
    call {:si_unique_call 319} GUID_BATTERY_DISCHARGE_LEVEL_1__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_LEVEL_1__Loc == GUID_BATTERY_DISCHARGE_LEVEL_1;
    assume GUID_BATTERY_DISCHARGE_LEVEL_1 != 0;
    call {:si_unique_call 320} GUID_IO_VOLUME_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_CHANGE__Loc == GUID_IO_VOLUME_CHANGE;
    assume GUID_IO_VOLUME_CHANGE != 0;
    call {:si_unique_call 321} GUID_IO_VOLUME_LOCK_FAILED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IO_VOLUME_LOCK_FAILED__Loc == GUID_IO_VOLUME_LOCK_FAILED;
    assume GUID_IO_VOLUME_LOCK_FAILED != 0;
    call {:si_unique_call 322} GUID_BUS_TYPE_USBPRINT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BUS_TYPE_USBPRINT__Loc == GUID_BUS_TYPE_USBPRINT;
    assume GUID_BUS_TYPE_USBPRINT != 0;
    call {:si_unique_call 323} GUID_BATTERY_DISCHARGE_ACTION_0__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_ACTION_0__Loc == GUID_BATTERY_DISCHARGE_ACTION_0;
    assume GUID_BATTERY_DISCHARGE_ACTION_0 != 0;
    call {:si_unique_call 324} GUID_ENABLE_SWITCH_FORCED_SHUTDOWN__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ENABLE_SWITCH_FORCED_SHUTDOWN__Loc == GUID_ENABLE_SWITCH_FORCED_SHUTDOWN;
    assume GUID_ENABLE_SWITCH_FORCED_SHUTDOWN != 0;
    call {:si_unique_call 325} VSP_DIAG_IGNORABLE_PRODUCT_LEAVE__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_IGNORABLE_PRODUCT_LEAVE__Loc == VSP_DIAG_IGNORABLE_PRODUCT_LEAVE;
    assume VSP_DIAG_IGNORABLE_PRODUCT_LEAVE != 0;
    call {:si_unique_call 326} GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING__Loc == GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING;
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING != 0;
    call {:si_unique_call 327} GUID_PROCESSOR_PERF_DECREASE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_DECREASE_THRESHOLD__Loc == GUID_PROCESSOR_PERF_DECREASE_THRESHOLD;
    assume GUID_PROCESSOR_PERF_DECREASE_THRESHOLD != 0;
    call {:si_unique_call 328} GUID_BATTERY_DISCHARGE_LEVEL_0__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_LEVEL_0__Loc == GUID_BATTERY_DISCHARGE_LEVEL_0;
    assume GUID_BATTERY_DISCHARGE_LEVEL_0 != 0;
    call {:si_unique_call 329} GUID_VIDEO_DIM_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_DIM_TIMEOUT__Loc == GUID_VIDEO_DIM_TIMEOUT;
    assume GUID_VIDEO_DIM_TIMEOUT != 0;
    call {:si_unique_call 330} GUID_ACTIVE_POWERSCHEME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACTIVE_POWERSCHEME__Loc == GUID_ACTIVE_POWERSCHEME;
    assume GUID_ACTIVE_POWERSCHEME != 0;
    call {:si_unique_call 331} GUID_SYSTEM_AWAYMODE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SYSTEM_AWAYMODE__Loc == GUID_SYSTEM_AWAYMODE;
    assume GUID_SYSTEM_AWAYMODE != 0;
    call {:si_unique_call 332} VSP_DIAG_REMOUNT_ENTER__Loc := __HAVOC_malloc_or_null(28);
    assume VSP_DIAG_REMOUNT_ENTER__Loc == VSP_DIAG_REMOUNT_ENTER;
    assume VSP_DIAG_REMOUNT_ENTER != 0;
    call {:si_unique_call 333} VOLSNAP_DIAG_TRACE_PROVIDER__Loc := __HAVOC_malloc_or_null(16);
    assume VOLSNAP_DIAG_TRACE_PROVIDER__Loc == VOLSNAP_DIAG_TRACE_PROVIDER;
    assume VOLSNAP_DIAG_TRACE_PROVIDER != 0;
    call {:si_unique_call 334} GUID_PROCESSOR_PERF_TIME_CHECK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_TIME_CHECK__Loc == GUID_PROCESSOR_PERF_TIME_CHECK;
    assume GUID_PROCESSOR_PERF_TIME_CHECK != 0;
    call {:si_unique_call 335} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_harnessDeviceExtension_two == boogieTmp;
    call {:si_unique_call 336} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_context == boogieTmp;
    call {:si_unique_call 337} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_pv3 == boogieTmp;
    call {:si_unique_call 338} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_pv2 == boogieTmp;
    call {:si_unique_call 339} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_pDpcContext == boogieTmp;
    call {:si_unique_call 340} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_harnessDeviceExtension == boogieTmp;
    call {:si_unique_call 341} boogieTmp := __HAVOC_malloc_or_null(4);
    assume igdoe == boogieTmp;
    call {:si_unique_call 342} boogieTmp := __HAVOC_malloc_or_null(248);
    assume sicrni == boogieTmp;
    call {:si_unique_call 343} boogieTmp := __HAVOC_malloc_or_null(24);
    call {:si_unique_call 344} boogieTmp := __HAVOC_malloc_or_null(4);
    assume IoFileObjectType == boogieTmp;
    call {:si_unique_call 345} boogieTmp := __HAVOC_malloc_or_null(4);
    call {:si_unique_call 346} boogieTmp := __HAVOC_malloc_or_null(1644);
    call {:si_unique_call 347} boogieTmp := __HAVOC_malloc_or_null(396);
    assume SeExports == boogieTmp;
    call {:si_unique_call 348} vslice_dummy_var_358 := __HAVOC_malloc(4);
    call {:si_unique_call 349} vslice_dummy_var_359 := __HAVOC_malloc(4);
    call {:si_unique_call 350} vslice_dummy_var_360 := __HAVOC_malloc(4);
    call {:si_unique_call 351} vslice_dummy_var_361 := __HAVOC_malloc(4);
    call {:si_unique_call 352} vslice_dummy_var_362 := __HAVOC_malloc(4);
    call {:si_unique_call 353} vslice_dummy_var_363 := __HAVOC_malloc(4);
    call {:si_unique_call 354} vslice_dummy_var_364 := __HAVOC_malloc(4);
    call {:si_unique_call 355} vslice_dummy_var_365 := __HAVOC_malloc(4);
    call {:si_unique_call 356} vslice_dummy_var_366 := __HAVOC_malloc(4);
    call {:si_unique_call 357} vslice_dummy_var_367 := __HAVOC_malloc(4);
    call {:si_unique_call 358} vslice_dummy_var_368 := __HAVOC_malloc(4);
    call {:si_unique_call 359} vslice_dummy_var_369 := __HAVOC_malloc(4);
    call {:si_unique_call 360} vslice_dummy_var_370 := __HAVOC_malloc(4);
    call {:si_unique_call 361} vslice_dummy_var_371 := __HAVOC_malloc(4);
    call {:si_unique_call 362} vslice_dummy_var_372 := __HAVOC_malloc(4);
    call {:si_unique_call 363} vslice_dummy_var_373 := __HAVOC_malloc(4);
    call {:si_unique_call 364} vslice_dummy_var_374 := __HAVOC_malloc(4);
    call {:si_unique_call 365} vslice_dummy_var_375 := __HAVOC_malloc(4);
    call {:si_unique_call 366} vslice_dummy_var_376 := __HAVOC_malloc(4);
    call {:si_unique_call 367} vslice_dummy_var_377 := __HAVOC_malloc(4);
    call {:si_unique_call 368} vslice_dummy_var_378 := __HAVOC_malloc(144);
    call {:si_unique_call 369} vslice_dummy_var_379 := __HAVOC_malloc(4);
    call {:si_unique_call 370} vslice_dummy_var_380 := __HAVOC_malloc(4);
    call {:si_unique_call 371} vslice_dummy_var_381 := __HAVOC_malloc(4);
    call {:si_unique_call 372} vslice_dummy_var_382 := __HAVOC_malloc(4);
    call {:si_unique_call 373} vslice_dummy_var_1133 := __HAVOC_malloc(140);
    call {:si_unique_call 374} vslice_dummy_var_383 := __HAVOC_malloc(4);
    assume {:mainInitDone} true;
    call {:si_unique_call 375} corralExtraInit();
    call {:si_unique_call 376} corralExplainErrorInit();
    call {:si_unique_call 377} _sdv_init7();
    call {:si_unique_call 378} _sdv_init1();
    call {:si_unique_call 379} _sdv_init4();
    call {:si_unique_call 380} _sdv_init5();
    call {:si_unique_call 381} _sdv_init3();
    call {:si_unique_call 382} _sdv_init2();
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} sdv_harnessDeviceExtension == 0;
    Tmp_137 := 0;
    goto L30;

  L30:
    assume Tmp_137 != 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} sdv_harnessDeviceExtension_two == 0;
    Tmp_138 := 0;
    goto L34;

  L34:
    assume Tmp_138 != 0;
    assume {:nonnull} sdv_irp != 0;
    assume sdv_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_irp)))] := sdv_harnessStackLocation;
    assume {:nonnull} sdv_other_irp != 0;
    assume sdv_other_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_other_irp)))] := sdv_other_harnessStackLocation;
    call {:si_unique_call 383} sdv_main();
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} yogi_error == 1;
    goto L28;

  L28:
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
    goto L28;

  anon10_Then:
    assume {:partition} sdv_harnessDeviceExtension_two != 0;
    Tmp_138 := 1;
    goto L34;

  anon9_Then:
    assume {:partition} sdv_harnessDeviceExtension != 0;
    Tmp_137 := 1;
    goto L30;
}



procedure {:origName "IoRegisterDriverReinitialization"} {:osmodel} IoRegisterDriverReinitialization(actual_DriverObject_2: int, actual_DriverReinitializationRoutine: int, actual_Context_1: int);
  modifies alloc;



implementation {:origName "IoRegisterDriverReinitialization"} {:osmodel} IoRegisterDriverReinitialization(actual_DriverObject_2: int, actual_DriverReinitializationRoutine: int, actual_Context_1: int)
{
  var vslice_dummy_var_21: int;

  anon0:
    call {:si_unique_call 384} vslice_dummy_var_21 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_stub_add_end"} {:osmodel} sdv_stub_add_end();
  modifies alloc;



implementation {:origName "sdv_stub_add_end"} {:osmodel} sdv_stub_add_end()
{
  var vslice_dummy_var_22: int;

  anon0:
    call {:si_unique_call 385} vslice_dummy_var_22 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "RtlInitUnicodeString"} {:osmodel} RtlInitUnicodeString(actual_DestinationString: int, actual_SourceString: int);
  modifies alloc;



implementation {:origName "RtlInitUnicodeString"} {:osmodel} RtlInitUnicodeString(actual_DestinationString: int, actual_SourceString: int)
{
  var {:pointer} DestinationString: int;
  var {:pointer} SourceString: int;
  var vslice_dummy_var_23: int;

  anon0:
    call {:si_unique_call 386} vslice_dummy_var_23 := __HAVOC_malloc(4);
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



procedure {:origName "IoAttachDeviceToDeviceStack"} {:osmodel} IoAttachDeviceToDeviceStack(actual_SourceDevice: int, actual_TargetDevice_1: int) returns (Tmp_146: int);
  free ensures Tmp_146 == 0 || Tmp_146 == actual_TargetDevice_1;



implementation {:origName "IoAttachDeviceToDeviceStack"} {:osmodel} IoAttachDeviceToDeviceStack(actual_SourceDevice: int, actual_TargetDevice_1: int) returns (Tmp_146: int)
{
  var {:pointer} TargetDevice_1: int;

  anon0:
    TargetDevice_1 := actual_TargetDevice_1;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} TargetDevice_1 == sdv_p_devobj_pdo;
    Tmp_146 := TargetDevice_1;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} TargetDevice_1 != sdv_p_devobj_pdo;
    Tmp_146 := 0;
    goto L1;
}



procedure {:origName "IoUninitializeWorkItem"} {:osmodel} IoUninitializeWorkItem(actual_IoWorkItem_1: int);
  modifies alloc;



implementation {:origName "IoUninitializeWorkItem"} {:osmodel} IoUninitializeWorkItem(actual_IoWorkItem_1: int)
{
  var vslice_dummy_var_24: int;

  anon0:
    call {:si_unique_call 387} vslice_dummy_var_24 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KeInitializeMutex"} {:osmodel} KeInitializeMutex(actual_Mutex_1: int, actual_Level: int);
  modifies alloc;



implementation {:origName "KeInitializeMutex"} {:osmodel} KeInitializeMutex(actual_Mutex_1: int, actual_Level: int)
{
  var vslice_dummy_var_25: int;

  anon0:
    call {:si_unique_call 388} vslice_dummy_var_25 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KfReleaseSpinLock"} {:osmodel} KfReleaseSpinLock(actual_SpinLock_1: int, actual_NewIrql: int);
  modifies alloc;



implementation {:origName "KfReleaseSpinLock"} {:osmodel} KfReleaseSpinLock(actual_SpinLock_1: int, actual_NewIrql: int)
{
  var {:scalar} NewIrql: int;
  var vslice_dummy_var_26: int;

  anon0:
    call {:si_unique_call 389} vslice_dummy_var_26 := __HAVOC_malloc(4);
    NewIrql := actual_NewIrql;
    return;
}



procedure {:origName "KeInitializeSemaphore"} {:osmodel} KeInitializeSemaphore(actual_Semaphore_1: int, actual_Count: int, actual_Limit: int);
  modifies alloc;



implementation {:origName "KeInitializeSemaphore"} {:osmodel} KeInitializeSemaphore(actual_Semaphore_1: int, actual_Count: int, actual_Limit: int)
{
  var vslice_dummy_var_27: int;

  anon0:
    call {:si_unique_call 390} vslice_dummy_var_27 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_RunStartDevice"} {:osmodel} sdv_RunStartDevice(actual_po: int, actual_pirp_4: int) returns (Tmp_156: int);
  modifies Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, alloc, in_pnp, Mem_T.CurrentStackLocation_unnamed_tag_6, ref, Mem_T.Type_unnamed_tag_26, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_RunStartDevice"} {:osmodel} sdv_RunStartDevice(actual_po: int, actual_pirp_4: int) returns (Tmp_156: int)
{
  var {:pointer} ps: int;
  var {:scalar} status_3: int;
  var {:pointer} po: int;
  var {:pointer} pirp_4: int;

  anon0:
    po := actual_po;
    pirp_4 := actual_pirp_4;
    status_3 := 0;
    assume {:nonnull} pirp_4 != 0;
    assume pirp_4 > 0;
    ps := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(pirp_4)))];
    assume {:nonnull} ps != 0;
    assume ps > 0;
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] := 0;
    assume {:nonnull} pirp_4 != 0;
    assume pirp_4 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_4))] := 0;
    assume {:nonnull} pirp_4 != 0;
    assume pirp_4 > 0;
    assume {:nonnull} pirp_4 != 0;
    assume pirp_4 > 0;
    call {:si_unique_call 391} sdv_SetStatus(pirp_4);
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 392} sdv_stub_dispatch_begin();
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume pirp_4 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 393} SLIC_VolSnapPnp_entry(0);
    goto L32;

  L32:
    call {:si_unique_call 394} status_3 := VolSnapPnp(po, pirp_4);
    call {:si_unique_call 395} sdv_stub_dispatch_end(status_3, 0);
    Tmp_156 := status_3;
    return;

  anon3_Then:
    assume !(pirp_4 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L32;
}



procedure {:origName "IoFreeMdl"} {:osmodel} IoFreeMdl(actual_Mdl: int);
  modifies alloc;



implementation {:origName "IoFreeMdl"} {:osmodel} IoFreeMdl(actual_Mdl: int)
{
  var vslice_dummy_var_28: int;

  anon0:
    call {:si_unique_call 396} vslice_dummy_var_28 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoVolumeDeviceToDosName"} {:osmodel} IoVolumeDeviceToDosName(actual_VolumeDeviceObject: int, actual_DosName: int) returns (Tmp_160: int);
  free ensures Tmp_160 == 0 || Tmp_160 == -1073741823;



implementation {:origName "IoVolumeDeviceToDosName"} {:osmodel} IoVolumeDeviceToDosName(actual_VolumeDeviceObject: int, actual_DosName: int) returns (Tmp_160: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_160 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_160 := -1073741823;
    goto L1;
}



procedure {:origName "sdv_RunDispatchFunction"} {:osmodel} sdv_RunDispatchFunction(actual_po_1: int, actual_pirp_5: int) returns (Tmp_162: int);
  modifies sdv_start_info, sdv_end_info, alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.MinorFunction__IO_STACK_LOCATION, in_pnp, Mem_T.CurrentStackLocation_unnamed_tag_6, ref, Mem_T.Type_unnamed_tag_26, Mem_T.Information__IO_STATUS_BLOCK, passed_on;



implementation {:origName "sdv_RunDispatchFunction"} {:osmodel} sdv_RunDispatchFunction(actual_po_1: int, actual_pirp_5: int) returns (Tmp_162: int)
{
  var {:pointer} ps_1: int;
  var {:scalar} minor: int;
  var {:scalar} Tmp_163: int;
  var {:scalar} Tmp_164: int;
  var {:scalar} sdv_98: int;
  var {:scalar} status_4: int;
  var {:pointer} po_1: int;
  var {:pointer} pirp_5: int;

  anon0:
    po_1 := actual_po_1;
    pirp_5 := actual_pirp_5;
    status_4 := 0;
    minor := sdv_98;
    assume {:nonnull} pirp_5 != 0;
    assume pirp_5 > 0;
    ps_1 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(pirp_5)))];
    assume {:nonnull} pirp_5 != 0;
    assume pirp_5 > 0;
    assume {:nonnull} pirp_5 != 0;
    assume pirp_5 > 0;
    sdv_start_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_5))];
    sdv_end_info := sdv_start_info;
    call {:si_unique_call 397} sdv_SetStatus(pirp_5);
    assume {:nonnull} pirp_5 != 0;
    assume pirp_5 > 0;
    assume {:nonnull} pirp_5 != 0;
    assume pirp_5 > 0;
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_1)] := minor;
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 398} sdv_stub_dispatch_begin();
    goto anon23_Then, anon23_Else;

  anon23_Else:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    goto anon31_Then, anon31_Else;

  anon31_Else:
    goto anon30_Then, anon30_Else;

  anon30_Else:
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_1)] != 0;
    goto L47;

  L47:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_1)] == 3;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    Tmp_164 := 0;
    goto L125;

  L125:
    assume Tmp_164 != 0;
    goto L48;

  L48:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_1)] == 2;
    goto L53;

  L53:
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume pirp_5 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 399} SLIC_VolSnapPnp_entry(0);
    goto L100;

  L100:
    call {:si_unique_call 400} status_4 := VolSnapPnp(po_1, pirp_5);
    goto L59;

  L59:
    call {:si_unique_call 401} sdv_stub_dispatch_end(status_4, 0);
    assume {:nonnull} pirp_5 != 0;
    assume pirp_5 > 0;
    sdv_end_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_5))];
    Tmp_162 := status_4;
    return;

  anon28_Then:
    assume !(pirp_5 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L100;

  anon26_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_1)] != 2;
    goto L53;

  anon27_Then:
    Tmp_164 := 1;
    goto L125;

  anon25_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_1)] != 3;
    goto L48;

  anon33_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps_1)] == 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    Tmp_163 := 0;
    goto L130;

  L130:
    assume Tmp_163 != 0;
    goto L47;

  anon24_Then:
    Tmp_163 := 1;
    goto L130;

  anon29_Then:
    call {:si_unique_call 402} status_4 := sdv_DoNothing();
    goto L59;

  anon30_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 403} status_4 := sdv_DoNothing();
    goto L59;

  anon31_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 404} sdv_SetPowerIrpMinorFunction(pirp_5);
    call {:si_unique_call 405} status_4 := VolSnapPower(po_1, pirp_5);
    goto L59;

  anon32_Then:
    call {:si_unique_call 406} status_4 := sdv_DoNothing();
    goto L59;

  anon23_Then:
    assume {:nonnull} ps_1 != 0;
    assume ps_1 > 0;
    call {:si_unique_call 407} status_4 := sdv_DoNothing();
    goto L59;
}



procedure {:origName "IoRegisterDeviceInterface"} {:osmodel} IoRegisterDeviceInterface(actual_PhysicalDeviceObject: int, actual_InterfaceClassGuid: int, actual_ReferenceString: int, actual_SymbolicLinkName_1: int) returns (Tmp_166: int);
  free ensures Tmp_166 == -1073741823 || Tmp_166 == -1073741808 || Tmp_166 == 0;



implementation {:origName "IoRegisterDeviceInterface"} {:osmodel} IoRegisterDeviceInterface(actual_PhysicalDeviceObject: int, actual_InterfaceClassGuid: int, actual_ReferenceString: int, actual_SymbolicLinkName_1: int) returns (Tmp_166: int)
{
  var {:scalar} Tmp_168: int;
  var {:pointer} SymbolicLinkName_1: int;

  anon0:
    SymbolicLinkName_1 := actual_SymbolicLinkName_1;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    goto anon9_Then, anon9_Else;

  anon9_Else:
    Tmp_166 := -1073741823;
    goto L1;

  L1:
    return;

  anon9_Then:
    Tmp_166 := -1073741808;
    goto L1;

  anon7_Then:
    assume {:nonnull} SymbolicLinkName_1 != 0;
    assume SymbolicLinkName_1 > 0;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    Tmp_168 := 0;
    goto L22;

  L22:
    assume Tmp_168 != 0;
    Tmp_166 := 0;
    goto L1;

  anon8_Then:
    Tmp_168 := 1;
    goto L22;
}



procedure {:origName "IoBuildSynchronousFsdRequest"} {:osmodel} IoBuildSynchronousFsdRequest(actual_MajorFunction: int, actual_DeviceObject_4: int, actual_Buffer: int, actual_Length_1: int, actual_StartingOffset: int, actual_Event_1: int, actual_IoStatusBlock_1: int) returns (Tmp_169: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "IoBuildSynchronousFsdRequest"} {:osmodel} IoBuildSynchronousFsdRequest(actual_MajorFunction: int, actual_DeviceObject_4: int, actual_Buffer: int, actual_Length_1: int, actual_StartingOffset: int, actual_Event_1: int, actual_IoStatusBlock_1: int) returns (Tmp_169: int)
{
  var {:pointer} Tmp_170: int;
  var {:scalar} MajorFunction: int;
  var {:pointer} IoStatusBlock_1: int;

  anon0:
    MajorFunction := actual_MajorFunction;
    IoStatusBlock_1 := actual_IoStatusBlock_1;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_irp != 0;
    assume sdv_IoBuildSynchronousFsdRequest_irp > 0;
    Tmp_170 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_IoBuildSynchronousFsdRequest_irp)))];
    assume {:nonnull} Tmp_170 != 0;
    assume Tmp_170 > 0;
    assume {:nonnull} IoStatusBlock_1 != 0;
    assume IoStatusBlock_1 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatusBlock_1)] := 0;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_irp != 0;
    assume sdv_IoBuildSynchronousFsdRequest_irp > 0;
    Tmp_169 := sdv_IoBuildSynchronousFsdRequest_irp;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_irp != 0;
    assume sdv_IoBuildSynchronousFsdRequest_irp > 0;
    assume {:nonnull} IoStatusBlock_1 != 0;
    assume IoStatusBlock_1 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatusBlock_1)] := -1073741823;
    Tmp_169 := 0;
    goto L1;
}



procedure {:origName "KeResetEvent"} {:osmodel} KeResetEvent(actual_Event_2: int) returns (Tmp_172: int);



implementation {:origName "KeResetEvent"} {:osmodel} KeResetEvent(actual_Event_2: int) returns (Tmp_172: int)
{
  var {:scalar} OldState_1: int;
  var {:pointer} Event_2: int;

  anon0:
    Event_2 := actual_Event_2;
    assume {:nonnull} Event_2 != 0;
    assume Event_2 > 0;
    havoc OldState_1;
    assume {:nonnull} Event_2 != 0;
    assume Event_2 > 0;
    Tmp_172 := OldState_1;
    return;
}



procedure {:origName "ExFreePoolWithTag"} {:osmodel} ExFreePoolWithTag(actual_P: int, actual_Tag_1: int);
  modifies alloc;



implementation {:origName "ExFreePoolWithTag"} {:osmodel} ExFreePoolWithTag(actual_P: int, actual_Tag_1: int)
{
  var vslice_dummy_var_29: int;

  anon0:
    call {:si_unique_call 408} vslice_dummy_var_29 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "_sdv_init5"} {:osmodel} _sdv_init5();
  modifies alloc;



implementation {:origName "_sdv_init5"} {:osmodel} _sdv_init5()
{
  var vslice_dummy_var_30: int;

  anon0:
    call {:si_unique_call 409} vslice_dummy_var_30 := __HAVOC_malloc(4);
    assume sdv_apc_disabled == 0;
    assume sdv_ControllerPirp == sdv_ControllerIrp;
    assume sdv_StartIopirp == sdv_StartIoIrp;
    assume sdv_power_irp == sdv_PowerIrp;
    assume sdv_irp == sdv_harnessIrp;
    assume sdv_other_irp == sdv_other_harnessIrp;
    assume sdv_IoMakeAssociatedIrp_irp == sdv_IoMakeAssociatedIrp_harnessIrp;
    assume sdv_IoBuildDeviceIoControlRequest_irp == sdv_IoBuildDeviceIoControlRequest_harnessIrp;
    assume sdv_IoBuildSynchronousFsdRequest_irp == sdv_IoBuildSynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildAsynchronousFsdRequest_irp == sdv_IoBuildAsynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock == sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;
    assume sdv_IoInitializeIrp_irp == sdv_IoInitializeIrp_harnessIrp;
    assume sdv_maskedEflags == 0;
    assume sdv_kdpc3 == sdv_kdpc_val3;
    assume sdv_p_devobj_fdo == sdv_devobj_fdo;
    assume sdv_p_devobj_pdo == sdv_devobj_pdo;
    assume sdv_p_devobj_child_pdo == sdv_devobj_child_pdo;
    assume sdv_kinterrupt == sdv_kinterrupt_val;
    assume sdv_MapRegisterBase == sdv_MapRegisterBase_val;
    assume sdv_invoke_on_success == 0;
    assume sdv_invoke_on_error == 0;
    assume sdv_invoke_on_cancel == 0;
    assume sdv_Io_Removelock_release_wait_returned == 0;
    assume sdv_compFset == 0;
    assume sdv_isr_routine == li2bplFunctionConstant1389;
    assume sdv_ke_dpc == li2bplFunctionConstant1391;
    assume sdv_dpc_ke_registered == 0;
    assume sdv_io_dpc == li2bplFunctionConstant1394;
    assume sdv_p_devobj_top == sdv_devobj_top;
    assume sdv_MmMapIoSpace_int == 0;
    return;
}



procedure {:origName "ObfReferenceObject"} {:osmodel} ObfReferenceObject(actual_Object_3: int) returns (Tmp_180: int);
  modifies ref;



implementation {:origName "ObfReferenceObject"} {:osmodel} ObfReferenceObject(actual_Object_3: int) returns (Tmp_180: int)
{

  anon0:
    call {:si_unique_call 410} SLIC_ObfReferenceObject_entry(0);
    return;
}



procedure {:origName "ExDeleteNPagedLookasideList"} {:osmodel} ExDeleteNPagedLookasideList(actual_Lookaside_1: int);
  modifies alloc;



implementation {:origName "ExDeleteNPagedLookasideList"} {:osmodel} ExDeleteNPagedLookasideList(actual_Lookaside_1: int)
{
  var vslice_dummy_var_31: int;

  anon0:
    call {:si_unique_call 411} vslice_dummy_var_31 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IofCallDriver"} {:osmodel} IofCallDriver(actual_DeviceObject_5: int, actual_Irp_2: int) returns (Tmp_184: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK;
  free ensures Tmp_184 == 259;



implementation {:origName "IofCallDriver"} {:osmodel} IofCallDriver(actual_DeviceObject_5: int, actual_Irp_2: int) returns (Tmp_184: int)
{
  var {:scalar} status_5: int;
  var {:pointer} Irp_2: int;

  anon0:
    Irp_2 := actual_Irp_2;
    status_5 := 259;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:nonnull} Irp_2 != 0;
    assume Irp_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := 259;
    assume {:nonnull} Irp_2 != 0;
    assume Irp_2 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_2;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L19;

  L19:
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_2;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L21;

  L21:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_2;
    goto L25;

  L25:
    Tmp_184 := status_5;
    return;

  anon32_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_2;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 259;
    goto L25;

  anon31_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_2;
    goto L21;

  anon44_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_2;
    goto L19;

  anon39_Then:
    assume {:nonnull} Irp_2 != 0;
    assume Irp_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := -1073741823;
    assume {:nonnull} Irp_2 != 0;
    assume Irp_2 > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_2;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L44;

  L44:
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_2;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L46;

  L46:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_2;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741823;
    goto L25;

  anon38_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_2;
    goto L25;

  anon37_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_2;
    goto L46;

  anon45_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_2;
    goto L44;

  anon40_Then:
    assume {:nonnull} Irp_2 != 0;
    assume Irp_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := -1073741536;
    assume {:nonnull} Irp_2 != 0;
    assume Irp_2 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_2;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L28;

  L28:
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_2;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L30;

  L30:
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_2;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741536;
    goto L25;

  anon34_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_2;
    goto L25;

  anon33_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_2;
    goto L30;

  anon43_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_2;
    goto L28;

  anon41_Then:
    assume {:nonnull} Irp_2 != 0;
    assume Irp_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_2))] := 0;
    assume {:nonnull} Irp_2 != 0;
    assume Irp_2 > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_2;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L36;

  L36:
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_2;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    goto L38;

  L38:
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_2;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 0;
    goto L25;

  anon36_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_2;
    goto L25;

  anon35_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_2;
    goto L38;

  anon42_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_2;
    goto L36;
}



procedure {:origName "ZwOpenKey"} {:osmodel} ZwOpenKey(actual_KeyHandle: int, actual_DesiredAccess_2: int, actual_ObjectAttributes_1: int) returns (Tmp_186: int);
  modifies alloc;
  free ensures Tmp_186 == 0 || Tmp_186 == -1073741727;



implementation {:origName "ZwOpenKey"} {:osmodel} ZwOpenKey(actual_KeyHandle: int, actual_DesiredAccess_2: int, actual_ObjectAttributes_1: int) returns (Tmp_186: int)
{
  var {:pointer} sdv_108: int;
  var {:pointer} KeyHandle: int;

  anon0:
    KeyHandle := actual_KeyHandle;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 412} sdv_108 := __HAVOC_malloc(4);
    assume {:nonnull} KeyHandle != 0;
    assume KeyHandle > 0;
    Tmp_186 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} KeyHandle != 0;
    assume KeyHandle > 0;
    Tmp_186 := -1073741727;
    goto L1;
}



procedure {:origName "KeInitializeEvent"} {:osmodel} KeInitializeEvent(actual_Event_3: int, actual_Type: int, actual_State: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26;



implementation {:origName "KeInitializeEvent"} {:osmodel} KeInitializeEvent(actual_Event_3: int, actual_Type: int, actual_State: int)
{
  var {:pointer} Event_3: int;
  var {:scalar} Type: int;
  var {:scalar} State: int;
  var vslice_dummy_var_32: int;

  anon0:
    call {:si_unique_call 413} vslice_dummy_var_32 := __HAVOC_malloc(4);
    Event_3 := actual_Event_3;
    Type := actual_Type;
    State := actual_State;
    assume {:nonnull} Event_3 != 0;
    assume Event_3 > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(Header__KEVENT(Event_3))] := Type;
    assume {:nonnull} Event_3 != 0;
    assume Event_3 > 0;
    assume {:nonnull} Event_3 != 0;
    assume Event_3 > 0;
    assume {:nonnull} Event_3 != 0;
    assume Event_3 > 0;
    return;
}



procedure {:origName "KeInitializeTimer"} {:osmodel} KeInitializeTimer(actual_Timer_1: int);
  modifies alloc;



implementation {:origName "KeInitializeTimer"} {:osmodel} KeInitializeTimer(actual_Timer_1: int)
{
  var vslice_dummy_var_33: int;

  anon0:
    call {:si_unique_call 414} vslice_dummy_var_33 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoBuildDeviceIoControlRequest"} {:osmodel} IoBuildDeviceIoControlRequest(actual_IoControlCode: int, actual_DeviceObject_6: int, actual_InputBuffer: int, actual_InputBufferLength: int, actual_OutputBuffer: int, actual_OutputBufferLength: int, actual_InternalDeviceIoControl: int, actual_Event_4: int, actual_IoStatusBlock_2: int) returns (Tmp_192: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "IoBuildDeviceIoControlRequest"} {:osmodel} IoBuildDeviceIoControlRequest(actual_IoControlCode: int, actual_DeviceObject_6: int, actual_InputBuffer: int, actual_InputBufferLength: int, actual_OutputBuffer: int, actual_OutputBufferLength: int, actual_InternalDeviceIoControl: int, actual_Event_4: int, actual_IoStatusBlock_2: int) returns (Tmp_192: int)
{
  var {:pointer} Tmp_193: int;
  var {:pointer} Tmp_194: int;
  var {:scalar} InternalDeviceIoControl: int;
  var {:pointer} IoStatusBlock_2: int;

  anon0:
    InternalDeviceIoControl := actual_InternalDeviceIoControl;
    IoStatusBlock_2 := actual_IoStatusBlock_2;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} InternalDeviceIoControl != 0;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_irp != 0;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    Tmp_194 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_IoBuildDeviceIoControlRequest_irp)))];
    assume {:nonnull} Tmp_194 != 0;
    assume Tmp_194 > 0;
    goto L14;

  L14:
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_irp != 0;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    assume {:nonnull} IoStatusBlock_2 != 0;
    assume IoStatusBlock_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatusBlock_2)] := 0;
    Tmp_192 := sdv_IoBuildDeviceIoControlRequest_irp;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} InternalDeviceIoControl == 0;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_irp != 0;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    Tmp_193 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_IoBuildDeviceIoControlRequest_irp)))];
    assume {:nonnull} Tmp_193 != 0;
    assume Tmp_193 > 0;
    goto L14;

  anon5_Then:
    havoc Mem_T.Status__IO_STATUS_BLOCK;
    assume {:nonnull} IoStatusBlock_2 != 0;
    assume IoStatusBlock_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatusBlock_2)] := -1073741823;
    Tmp_192 := 0;
    goto L1;
}



procedure {:origName "IoAcquireCancelSpinLock"} {:osmodel} IoAcquireCancelSpinLock(actual_p_3: int);
  modifies alloc;



implementation {:origName "IoAcquireCancelSpinLock"} {:osmodel} IoAcquireCancelSpinLock(actual_p_3: int)
{
  var {:pointer} p_3: int;
  var vslice_dummy_var_34: int;

  anon0:
    call {:si_unique_call 415} vslice_dummy_var_34 := __HAVOC_malloc(4);
    p_3 := actual_p_3;
    assume {:nonnull} p_3 != 0;
    assume p_3 > 0;
    return;
}



procedure {:origName "IoFreeIrp"} {:osmodel} IoFreeIrp(actual_pirp_6: int);
  modifies alloc;



implementation {:origName "IoFreeIrp"} {:osmodel} IoFreeIrp(actual_pirp_6: int)
{
  var vslice_dummy_var_35: int;

  anon0:
    call {:si_unique_call 416} vslice_dummy_var_35 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoInvalidateDeviceRelations"} {:osmodel} IoInvalidateDeviceRelations(actual_DeviceObject_7: int, actual_Type_1: int);
  modifies alloc;



implementation {:origName "IoInvalidateDeviceRelations"} {:osmodel} IoInvalidateDeviceRelations(actual_DeviceObject_7: int, actual_Type_1: int)
{
  var vslice_dummy_var_36: int;

  anon0:
    call {:si_unique_call 417} vslice_dummy_var_36 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoForwardIrpSynchronously"} {:osmodel} IoForwardIrpSynchronously(actual_DeviceObject_8: int, actual_Irp_3: int) returns (Tmp_202: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK;
  free ensures Tmp_202 == 1 || Tmp_202 == 0;



implementation {:origName "IoForwardIrpSynchronously"} {:osmodel} IoForwardIrpSynchronously(actual_DeviceObject_8: int, actual_Irp_3: int) returns (Tmp_202: int)
{
  var {:pointer} Irp_3: int;

  anon0:
    Irp_3 := actual_Irp_3;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))] := 0;
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    Tmp_202 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_3))] := -1073741823;
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    Tmp_202 := 0;
    goto L1;
}



procedure {:origName "MmUnlockPages"} {:osmodel} MmUnlockPages(actual_MemoryDescriptorList: int);
  modifies alloc;



implementation {:origName "MmUnlockPages"} {:osmodel} MmUnlockPages(actual_MemoryDescriptorList: int)
{
  var vslice_dummy_var_37: int;

  anon0:
    call {:si_unique_call 418} vslice_dummy_var_37 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "ExAllocatePoolWithTag"} {:osmodel} ExAllocatePoolWithTag(actual_PoolType: int, actual_NumberOfBytes: int, actual_Tag_2: int) returns (Tmp_206: int);
  modifies alloc;



implementation {:origName "ExAllocatePoolWithTag"} {:osmodel} ExAllocatePoolWithTag(actual_PoolType: int, actual_NumberOfBytes: int, actual_Tag_2: int) returns (Tmp_206: int)
{
  var {:pointer} sdv_112: int;
  var {:scalar} NumberOfBytes: int;

  anon0:
    NumberOfBytes := actual_NumberOfBytes;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 419} sdv_112 := __HAVOC_malloc(NumberOfBytes);
    Tmp_206 := sdv_112;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_206 := 0;
    goto L1;
}



procedure {:origName "sdv_RunUnload"} {:osmodel} sdv_RunUnload(actual_pdrivo: int);
  modifies alloc;



implementation {:origName "sdv_RunUnload"} {:osmodel} sdv_RunUnload(actual_pdrivo: int)
{
  var {:pointer} pdrivo: int;
  var vslice_dummy_var_38: int;

  anon0:
    call {:si_unique_call 420} vslice_dummy_var_38 := __HAVOC_malloc(4);
    pdrivo := actual_pdrivo;
    call {:si_unique_call 421} VolSnapUnload(pdrivo);
    return;
}



procedure {:origName "IoSetDeviceInterfaceState"} {:osmodel} IoSetDeviceInterfaceState(actual_SymbolicLinkName_2: int, actual_Enable: int) returns (Tmp_210: int);
  free ensures Tmp_210 == -1073741772 || Tmp_210 == -1073741824 || Tmp_210 == -1073741789 || Tmp_210 == -1073741670 || Tmp_210 == -1073741808 || Tmp_210 == 0;



implementation {:origName "IoSetDeviceInterfaceState"} {:osmodel} IoSetDeviceInterfaceState(actual_SymbolicLinkName_2: int, actual_Enable: int) returns (Tmp_210: int)
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
    Tmp_210 := -1073741772;
    goto L1;

  L1:
    return;

  anon12_Then:
    Tmp_210 := -1073741824;
    goto L1;

  anon13_Then:
    Tmp_210 := -1073741789;
    goto L1;

  anon14_Then:
    Tmp_210 := -1073741670;
    goto L1;

  anon15_Then:
    Tmp_210 := -1073741808;
    goto L1;

  anon11_Then:
    Tmp_210 := 0;
    goto L1;
}



procedure {:origName "sdv_stub_driver_init"} {:osmodel} sdv_stub_driver_init();
  modifies alloc;



implementation {:origName "sdv_stub_driver_init"} {:osmodel} sdv_stub_driver_init()
{
  var vslice_dummy_var_39: int;

  anon0:
    call {:si_unique_call 422} vslice_dummy_var_39 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_stub_dispatch_begin"} {:osmodel} sdv_stub_dispatch_begin();
  modifies alloc;



implementation {:origName "sdv_stub_dispatch_begin"} {:osmodel} sdv_stub_dispatch_begin()
{
  var vslice_dummy_var_40: int;

  anon0:
    call {:si_unique_call 423} vslice_dummy_var_40 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoGetDriverObjectExtension"} {:osmodel} IoGetDriverObjectExtension(actual_DriverObject_3: int, actual_ClientIdentificationAddress_1: int) returns (Tmp_216: int);



implementation {:origName "IoGetDriverObjectExtension"} {:osmodel} IoGetDriverObjectExtension(actual_DriverObject_3: int, actual_ClientIdentificationAddress_1: int) returns (Tmp_216: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_216 := igdoe;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_216 := 0;
    goto L1;
}



procedure {:origName "ZwClose"} {:osmodel} ZwClose(actual_Handle_1: int) returns (Tmp_218: int);
  free ensures Tmp_218 == 0;



implementation {:origName "ZwClose"} {:osmodel} ZwClose(actual_Handle_1: int) returns (Tmp_218: int)
{

  anon0:
    Tmp_218 := 0;
    return;
}



procedure {:origName "IoInitializeWorkItem"} {:osmodel} IoInitializeWorkItem(actual_IoObject_1: int, actual_IoWorkItem_2: int);
  modifies alloc;



implementation {:origName "IoInitializeWorkItem"} {:osmodel} IoInitializeWorkItem(actual_IoObject_1: int, actual_IoWorkItem_2: int)
{
  var vslice_dummy_var_41: int;

  anon0:
    call {:si_unique_call 424} vslice_dummy_var_41 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoRegisterBootDriverReinitialization"} {:osmodel} IoRegisterBootDriverReinitialization(actual_DriverObject_4: int, actual_DriverReinitializationRoutine_1: int, actual_Context_2: int);
  modifies alloc;



implementation {:origName "IoRegisterBootDriverReinitialization"} {:osmodel} IoRegisterBootDriverReinitialization(actual_DriverObject_4: int, actual_DriverReinitializationRoutine_1: int, actual_Context_2: int)
{
  var vslice_dummy_var_42: int;

  anon0:
    call {:si_unique_call 425} vslice_dummy_var_42 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_DoNothing"} {:osmodel} sdv_DoNothing() returns (Tmp_224: int);
  free ensures Tmp_224 == -1073741823;



implementation {:origName "sdv_DoNothing"} {:osmodel} sdv_DoNothing() returns (Tmp_224: int)
{

  anon0:
    Tmp_224 := -1073741823;
    return;
}



procedure {:origName "_sdv_init4"} _sdv_init4();
  modifies alloc;



implementation {:origName "_sdv_init4"} _sdv_init4()
{
  var vslice_dummy_var_43: int;

  anon0:
    call {:si_unique_call 426} vslice_dummy_var_43 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_hash_1038281869"} sdv_hash_1038281869(actual_Filter: int, actual_NeedLock: int, actual_IsFinalRemove: int, actual_DontDeleteDevnode: int) returns (Tmp_228: int);
  modifies alloc, ref, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures Tmp_228 == 0 || Tmp_228 == -1073741811;



implementation {:origName "sdv_hash_1038281869"} sdv_hash_1038281869(actual_Filter: int, actual_NeedLock: int, actual_IsFinalRemove: int, actual_DontDeleteDevnode: int) returns (Tmp_228: int)
{
  var {:scalar} irql: int;
  var {:pointer} extension: int;
  var {:pointer} Filter: int;
  var {:scalar} NeedLock: int;
  var {:scalar} IsFinalRemove: int;
  var {:scalar} DontDeleteDevnode: int;
  var vslice_dummy_var_44: int;
  var vslice_dummy_var_45: int;
  var vslice_dummy_var_1134: int;
  var vslice_dummy_var_1135: int;

  anon0:
    Filter := actual_Filter;
    NeedLock := actual_NeedLock;
    IsFinalRemove := actual_IsFinalRemove;
    DontDeleteDevnode := actual_DontDeleteDevnode;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} NeedLock != 0;
    assume {:nonnull} Filter != 0;
    assume Filter > 0;
    havoc vslice_dummy_var_1134;
    call {:si_unique_call 427} sdv_hash_613687309(vslice_dummy_var_1134);
    goto L6;

  L6:
    call {:si_unique_call 428} irql := KfAcquireSpinLock(0);
    assume {:nonnull} Filter != 0;
    assume Filter > 0;
    havoc extension;
    assume {:nonnull} Filter != 0;
    assume Filter > 0;
    call {:si_unique_call 429} KfReleaseSpinLock(0, irql);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} extension != 0;
    assume {:nonnull} extension != 0;
    assume extension > 0;
    call {:si_unique_call 430} vslice_dummy_var_44 := ObfReferenceObject(0);
    assume {:nonnull} extension != 0;
    assume extension > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} Filter != 0;
    assume Filter > 0;
    assume {:nonnull} extension != 0;
    assume extension > 0;
    call {:si_unique_call 431} InsertTailList(DeadVolumeList_FILTER_EXTENSION(Filter), ListEntry_VOLUME_EXTENSION(extension));
    goto L19;

  L19:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} NeedLock != 0;
    assume {:nonnull} Filter != 0;
    assume Filter > 0;
    havoc vslice_dummy_var_1135;
    call {:si_unique_call 432} sdv_hash_986004649(vslice_dummy_var_1135);
    goto L27;

  L27:
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} extension != 0;
    call {:si_unique_call 433} sdv_hash_259372028(extension, NeedLock, IsFinalRemove, DontDeleteDevnode);
    assume {:nonnull} extension != 0;
    assume extension > 0;
    call {:si_unique_call 434} vslice_dummy_var_45 := ObfDereferenceObject(0);
    Tmp_228 := 0;
    goto L1;

  L1:
    return;

  anon15_Then:
    assume {:partition} extension == 0;
    Tmp_228 := -1073741811;
    goto L1;

  anon13_Then:
    assume {:partition} NeedLock == 0;
    goto L27;

  anon14_Then:
    goto L19;

  anon12_Then:
    assume {:partition} extension == 0;
    goto L19;

  anon11_Then:
    assume {:partition} NeedLock == 0;
    goto L6;
}



procedure {:origName "sdv_hash_984605889"} sdv_hash_984605889(actual_Filter_1: int, actual_TargetObject: int, actual_Offset: int, actual_Key: int, actual_FileObject: int) returns (Tmp_232: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_984605889"} sdv_hash_984605889(actual_Filter_1: int, actual_TargetObject: int, actual_Offset: int, actual_Key: int, actual_FileObject: int) returns (Tmp_232: int)
{
  var {:pointer} Filter_1: int;
  var {:pointer} TargetObject: int;
  var {:scalar} Offset: int;
  var {:scalar} Key: int;
  var {:pointer} FileObject: int;

  anon0:
    Filter_1 := actual_Filter_1;
    TargetObject := actual_TargetObject;
    Offset := actual_Offset;
    Key := actual_Key;
    FileObject := actual_FileObject;
    call {:si_unique_call 435} Tmp_232 := sdv_hash_1005542269(Filter_1, TargetObject, 3, Offset, Key, FileObject, 1);
    return;
}



procedure {:origName "sdv_hash_515123808"} sdv_hash_515123808(actual_List: int, actual_AddList: int, actual_AddFront: int);
  modifies alloc;



implementation {:origName "sdv_hash_515123808"} sdv_hash_515123808(actual_List: int, actual_AddList: int, actual_AddFront: int)
{
  var {:pointer} Tmp_234: int;
  var {:pointer} Tmp_235: int;
  var {:pointer} Tmp_236: int;
  var {:pointer} Tmp_237: int;
  var {:pointer} Tmp_239: int;
  var {:pointer} Tmp_240: int;
  var {:pointer} List: int;
  var {:pointer} AddList: int;
  var {:scalar} AddFront: int;
  var vslice_dummy_var_46: int;

  anon0:
    call {:si_unique_call 436} vslice_dummy_var_46 := __HAVOC_malloc(4);
    List := actual_List;
    AddList := actual_AddList;
    AddFront := actual_AddFront;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} AddFront != 0;
    assume {:nonnull} AddList != 0;
    assume AddList > 0;
    havoc Tmp_237;
    assume {:nonnull} List != 0;
    assume List > 0;
    assume {:nonnull} Tmp_237 != 0;
    assume Tmp_237 > 0;
    assume {:nonnull} List != 0;
    assume List > 0;
    havoc Tmp_235;
    assume {:nonnull} AddList != 0;
    assume AddList > 0;
    assume {:nonnull} Tmp_235 != 0;
    assume Tmp_235 > 0;
    assume {:nonnull} AddList != 0;
    assume AddList > 0;
    assume {:nonnull} List != 0;
    assume List > 0;
    assume {:nonnull} List != 0;
    assume List > 0;
    havoc Tmp_234;
    assume {:nonnull} Tmp_234 != 0;
    assume Tmp_234 > 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} AddFront == 0;
    assume {:nonnull} AddList != 0;
    assume AddList > 0;
    havoc Tmp_240;
    assume {:nonnull} List != 0;
    assume List > 0;
    assume {:nonnull} Tmp_240 != 0;
    assume Tmp_240 > 0;
    assume {:nonnull} List != 0;
    assume List > 0;
    havoc Tmp_236;
    assume {:nonnull} AddList != 0;
    assume AddList > 0;
    assume {:nonnull} Tmp_236 != 0;
    assume Tmp_236 > 0;
    assume {:nonnull} AddList != 0;
    assume AddList > 0;
    assume {:nonnull} List != 0;
    assume List > 0;
    assume {:nonnull} List != 0;
    assume List > 0;
    havoc Tmp_239;
    assume {:nonnull} Tmp_239 != 0;
    assume Tmp_239 > 0;
    goto L1;
}



procedure {:origName "IoGetCurrentIrpStackLocation"} IoGetCurrentIrpStackLocation(actual_Irp_4: int) returns (Tmp_242: int);



implementation {:origName "IoGetCurrentIrpStackLocation"} IoGetCurrentIrpStackLocation(actual_Irp_4: int) returns (Tmp_242: int)
{
  var {:pointer} Irp_4: int;

  anon0:
    Irp_4 := actual_Irp_4;
    assume {:nonnull} Irp_4 != 0;
    assume Irp_4 > 0;
    Tmp_242 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(Irp_4)))];
    return;
}



procedure {:origName "sdv_hash_890975460"} sdv_hash_890975460(actual_Context_3: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_890975460"} sdv_hash_890975460(actual_Context_3: int)
{
  var {:scalar} majorFunction: int;
  var {:scalar} Tmp_244: int;
  var {:scalar} sdv_119: int;
  var {:pointer} Tmp_245: int;
  var {:pointer} irpSp: int;
  var {:scalar} irql2: int;
  var {:scalar} sdv_122: int;
  var {:pointer} filter: int;
  var {:scalar} sdv_127: int;
  var {:scalar} sdv_128: int;
  var {:scalar} sdv_129: int;
  var {:pointer} irp: int;
  var {:pointer} Tmp_247: int;
  var {:pointer} l: int;
  var {:scalar} q: int;
  var {:pointer} Tmp_248: int;
  var {:pointer} driver: int;
  var {:pointer} Tmp_249: int;
  var {:pointer} tmp: int;
  var {:pointer} Tmp_250: int;
  var {:scalar} irql_1: int;
  var {:pointer} Tmp_251: int;
  var {:scalar} sdv_133: int;
  var {:pointer} Tmp_252: int;
  var {:pointer} Context_3: int;
  var vslice_dummy_var_47: int;
  var vslice_dummy_var_48: int;
  var vslice_dummy_var_49: int;
  var vslice_dummy_var_50: int;
  var vslice_dummy_var_51: int;
  var vslice_dummy_var_52: int;
  var vslice_dummy_var_53: int;
  var vslice_dummy_var_54: int;
  var vslice_dummy_var_55: int;
  var vslice_dummy_var_56: int;
  var vslice_dummy_var_57: int;
  var vslice_dummy_var_58: int;
  var vslice_dummy_var_59: int;
  var vslice_dummy_var_60: int;
  var vslice_dummy_var_61: int;
  var vslice_dummy_var_62: int;
  var vslice_dummy_var_63: int;
  var vslice_dummy_var_64: int;
  var vslice_dummy_var_65: int;
  var vslice_dummy_var_66: int;
  var vslice_dummy_var_67: int;
  var vslice_dummy_var_68: int;
  var vslice_dummy_var_69: int;
  var vslice_dummy_var_70: int;
  var vslice_dummy_var_71: int;
  var vslice_dummy_var_72: int;
  var vslice_dummy_var_1136: int;
  var vslice_dummy_var_1137: int;
  var vslice_dummy_var_1138: int;
  var vslice_dummy_var_1139: int;
  var vslice_dummy_var_1140: int;
  var vslice_dummy_var_1141: int;
  var vslice_dummy_var_1142: int;
  var vslice_dummy_var_1143: int;
  var vslice_dummy_var_1144: int;
  var vslice_dummy_var_1145: int;
  var vslice_dummy_var_1146: int;
  var vslice_dummy_var_1147: int;
  var vslice_dummy_var_1148: int;
  var vslice_dummy_var_1149: int;
  var vslice_dummy_var_1150: int;
  var vslice_dummy_var_1151: int;
  var vslice_dummy_var_1152: int;
  var vslice_dummy_var_1153: int;
  var vslice_dummy_var_1154: int;
  var vslice_dummy_var_1155: int;
  var vslice_dummy_var_1156: int;
  var vslice_dummy_var_1157: int;

  anon0:
    call {:si_unique_call 437} vslice_dummy_var_47 := __HAVOC_malloc(4);
    call {:si_unique_call 438} q := __HAVOC_malloc(8);
    Context_3 := actual_Context_3;
    call {:si_unique_call 439} Tmp_248 := __HAVOC_malloc(112);
    filter := Context_3;
    irql_1 := 0;
    irql2 := 0;
    l := 0;
    tmp := 0;
    irp := 0;
    irpSp := 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    havoc Tmp_250;
    assume {:nonnull} Tmp_250 != 0;
    assume Tmp_250 > 0;
    havoc driver;
    majorFunction := 0;
    call {:si_unique_call 440} InitializeListHead(q);
    call {:si_unique_call 441} irql_1 := KfAcquireSpinLock(0);
    assume {:nonnull} filter != 0;
    assume filter > 0;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    goto anon94_Then, anon94_Else;

  anon94_Else:
    call {:si_unique_call 442} KfReleaseSpinLock(0, irql_1);
    goto L1;

  L1:
    return;

  anon94_Then:
    call {:si_unique_call 443} sdv_hash_161800534(filter, 0, 1);
    call {:si_unique_call 444} Tmp_249 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_249 != 0;
    assume Tmp_249 > 0;
    call {:si_unique_call 445} IoAcquireCancelSpinLock(Tmp_249);
    assume {:nonnull} Tmp_249 != 0;
    assume Tmp_249 > 0;
    havoc irql2;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    call {:si_unique_call 446} sdv_127 := IsListEmpty(BandwidthRequestQueue_FILTER_EXTENSION(filter));
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:partition} sdv_127 != 0;
    goto L55;

  L55:
    call {:si_unique_call 447} IoReleaseCancelSpinLock(irql2);
    assume {:nonnull} filter != 0;
    assume filter > 0;
    call {:si_unique_call 448} sdv_128 := IsListEmpty(HoldQueue_FILTER_EXTENSION(filter));
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} sdv_128 != 0;
    goto L65;

  L65:
    call {:si_unique_call 449} KfReleaseSpinLock(0, irql_1);
    call {:si_unique_call 450} sdv_129 := IsListEmpty(q);
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} sdv_129 == 0;
    assume {:nonnull} q != 0;
    assume q > 0;
    havoc l;
    goto L75;

  L75:
    call {:si_unique_call 451} majorFunction, Tmp_244, irpSp, irp, l, Tmp_248, tmp, vslice_dummy_var_50, vslice_dummy_var_51, vslice_dummy_var_52, vslice_dummy_var_53, vslice_dummy_var_54, vslice_dummy_var_55, vslice_dummy_var_56, vslice_dummy_var_57, vslice_dummy_var_58, vslice_dummy_var_59, vslice_dummy_var_60, vslice_dummy_var_61, vslice_dummy_var_62, vslice_dummy_var_63, vslice_dummy_var_64, vslice_dummy_var_65, vslice_dummy_var_66, vslice_dummy_var_67, vslice_dummy_var_68, vslice_dummy_var_69, vslice_dummy_var_70, vslice_dummy_var_71, vslice_dummy_var_72 := sdv_hash_890975460_loop_L75(majorFunction, Tmp_244, irpSp, irp, l, Tmp_248, driver, tmp, vslice_dummy_var_50, vslice_dummy_var_51, vslice_dummy_var_52, vslice_dummy_var_53, vslice_dummy_var_54, vslice_dummy_var_55, vslice_dummy_var_56, vslice_dummy_var_57, vslice_dummy_var_58, vslice_dummy_var_59, vslice_dummy_var_60, vslice_dummy_var_61, vslice_dummy_var_62, vslice_dummy_var_63, vslice_dummy_var_64, vslice_dummy_var_65, vslice_dummy_var_66, vslice_dummy_var_67, vslice_dummy_var_68, vslice_dummy_var_69, vslice_dummy_var_70, vslice_dummy_var_71, vslice_dummy_var_72);
    goto L75_last;

  L75_last:
    goto anon87_Then, anon87_Else;

  anon87_Else:
    irp := l;
    call {:si_unique_call 452} irpSp := IoGetCurrentIrpStackLocation(irp);
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc majorFunction;
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} majorFunction == 4;
    goto L87;

  L87:
    assume {:nonnull} l != 0;
    assume l > 0;
    havoc tmp;
    call {:si_unique_call 453} vslice_dummy_var_50 := RemoveEntryList(l);
    l := tmp;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc Tmp_244;
    assume {:nonnull} driver != 0;
    assume driver > 0;
    havoc Tmp_248;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    assume Tmp_244 != 27;
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume Tmp_244 != 26;
    goto anon98_Then, anon98_Else;

  anon98_Else:
    assume Tmp_244 != 25;
    goto anon99_Then, anon99_Else;

  anon99_Else:
    assume Tmp_244 != 24;
    goto anon100_Then, anon100_Else;

  anon100_Else:
    assume Tmp_244 != 23;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume Tmp_244 != 22;
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume Tmp_244 != 21;
    goto anon103_Then, anon103_Else;

  anon103_Else:
    assume Tmp_244 != 20;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume Tmp_244 != 19;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    assume Tmp_244 != 18;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume Tmp_244 != 17;
    goto anon107_Then, anon107_Else;

  anon107_Else:
    assume Tmp_244 != 16;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume Tmp_244 != 15;
    goto anon109_Then, anon109_Else;

  anon109_Else:
    assume Tmp_244 != 14;
    goto anon110_Then, anon110_Else;

  anon110_Else:
    assume Tmp_244 != 13;
    goto anon111_Then, anon111_Else;

  anon111_Else:
    assume Tmp_244 != 12;
    goto anon112_Then, anon112_Else;

  anon112_Else:
    assume Tmp_244 != 11;
    goto anon113_Then, anon113_Else;

  anon113_Else:
    assume Tmp_244 != 10;
    goto anon114_Then, anon114_Else;

  anon114_Else:
    assume Tmp_244 != 9;
    goto anon115_Then, anon115_Else;

  anon115_Else:
    assume Tmp_244 != 8;
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume Tmp_244 != 7;
    goto anon117_Then, anon117_Else;

  anon117_Else:
    assume Tmp_244 != 6;
    goto anon118_Then, anon118_Else;

  anon118_Else:
    assume Tmp_244 != 5;
    goto anon119_Then, anon119_Else;

  anon119_Else:
    assume Tmp_244 != 4;
    goto anon120_Then, anon120_Else;

  anon120_Else:
    assume Tmp_244 != 3;
    goto anon121_Then, anon121_Else;

  anon121_Else:
    assume Tmp_244 != 2;
    goto anon122_Then, anon122_Else;

  anon122_Else:
    assume Tmp_244 != 1;
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume false;
    return;

  anon123_Then:
    assume Tmp_244 == 0;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1136;
    call {:si_unique_call 454} vslice_dummy_var_72 := VolSnapDefaultDispatch(vslice_dummy_var_1136, irp);
    goto L95;

  L95:
    assume {:nonnull} l != 0;
    assume l > 0;
    havoc l;
    goto L95_dummy;

  L95_dummy:
    assume false;
    return;

  anon122_Then:
    assume Tmp_244 == 1;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1137;
    call {:si_unique_call 455} vslice_dummy_var_71 := VolSnapDefaultDispatch(vslice_dummy_var_1137, irp);
    goto L95;

  anon121_Then:
    assume Tmp_244 == 2;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1138;
    call {:si_unique_call 456} vslice_dummy_var_70 := VolSnapDefaultDispatch(vslice_dummy_var_1138, irp);
    goto L95;

  anon120_Then:
    assume Tmp_244 == 3;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    goto L95;

  anon119_Then:
    assume Tmp_244 == 4;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    goto L95;

  anon118_Then:
    assume Tmp_244 == 5;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1139;
    call {:si_unique_call 457} vslice_dummy_var_69 := VolSnapDefaultDispatch(vslice_dummy_var_1139, irp);
    goto L95;

  anon117_Then:
    assume Tmp_244 == 6;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1140;
    call {:si_unique_call 458} vslice_dummy_var_68 := VolSnapDefaultDispatch(vslice_dummy_var_1140, irp);
    goto L95;

  anon116_Then:
    assume Tmp_244 == 7;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1141;
    call {:si_unique_call 459} vslice_dummy_var_67 := VolSnapDefaultDispatch(vslice_dummy_var_1141, irp);
    goto L95;

  anon115_Then:
    assume Tmp_244 == 8;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1142;
    call {:si_unique_call 460} vslice_dummy_var_66 := VolSnapDefaultDispatch(vslice_dummy_var_1142, irp);
    goto L95;

  anon114_Then:
    assume Tmp_244 == 9;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1143;
    call {:si_unique_call 461} vslice_dummy_var_65 := VolSnapDefaultDispatch(vslice_dummy_var_1143, irp);
    goto L95;

  anon113_Then:
    assume Tmp_244 == 10;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1144;
    call {:si_unique_call 462} vslice_dummy_var_64 := VolSnapDefaultDispatch(vslice_dummy_var_1144, irp);
    goto L95;

  anon112_Then:
    assume Tmp_244 == 11;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1145;
    call {:si_unique_call 463} vslice_dummy_var_63 := VolSnapDefaultDispatch(vslice_dummy_var_1145, irp);
    goto L95;

  anon111_Then:
    assume Tmp_244 == 12;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1146;
    call {:si_unique_call 464} vslice_dummy_var_62 := VolSnapDefaultDispatch(vslice_dummy_var_1146, irp);
    goto L95;

  anon110_Then:
    assume Tmp_244 == 13;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1147;
    call {:si_unique_call 465} vslice_dummy_var_61 := VolSnapDefaultDispatch(vslice_dummy_var_1147, irp);
    goto L95;

  anon109_Then:
    assume Tmp_244 == 14;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    goto L95;

  anon108_Then:
    assume Tmp_244 == 15;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1148;
    call {:si_unique_call 466} vslice_dummy_var_60 := VolSnapDefaultDispatch(vslice_dummy_var_1148, irp);
    goto L95;

  anon107_Then:
    assume Tmp_244 == 16;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1149;
    call {:si_unique_call 467} vslice_dummy_var_59 := VolSnapDefaultDispatch(vslice_dummy_var_1149, irp);
    goto L95;

  anon106_Then:
    assume Tmp_244 == 17;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1150;
    call {:si_unique_call 468} vslice_dummy_var_58 := VolSnapDefaultDispatch(vslice_dummy_var_1150, irp);
    goto L95;

  anon105_Then:
    assume Tmp_244 == 18;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    goto L95;

  anon104_Then:
    assume Tmp_244 == 19;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1151;
    call {:si_unique_call 469} vslice_dummy_var_57 := VolSnapDefaultDispatch(vslice_dummy_var_1151, irp);
    goto L95;

  anon103_Then:
    assume Tmp_244 == 20;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1152;
    call {:si_unique_call 470} vslice_dummy_var_56 := VolSnapDefaultDispatch(vslice_dummy_var_1152, irp);
    goto L95;

  anon102_Then:
    assume Tmp_244 == 21;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1153;
    call {:si_unique_call 471} vslice_dummy_var_55 := VolSnapDefaultDispatch(vslice_dummy_var_1153, irp);
    goto L95;

  anon101_Then:
    assume Tmp_244 == 22;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    goto L95;

  anon100_Then:
    assume Tmp_244 == 23;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1154;
    call {:si_unique_call 472} vslice_dummy_var_54 := VolSnapDefaultDispatch(vslice_dummy_var_1154, irp);
    goto L95;

  anon99_Then:
    assume Tmp_244 == 24;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1155;
    call {:si_unique_call 473} vslice_dummy_var_53 := VolSnapDefaultDispatch(vslice_dummy_var_1155, irp);
    goto L95;

  anon98_Then:
    assume Tmp_244 == 25;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1156;
    call {:si_unique_call 474} vslice_dummy_var_52 := VolSnapDefaultDispatch(vslice_dummy_var_1156, irp);
    goto L95;

  anon97_Then:
    assume Tmp_244 == 26;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    havoc vslice_dummy_var_1157;
    call {:si_unique_call 475} vslice_dummy_var_51 := VolSnapDefaultDispatch(vslice_dummy_var_1157, irp);
    goto L95;

  anon96_Then:
    assume Tmp_244 == 27;
    assume {:nonnull} Tmp_248 != 0;
    assume Tmp_248 > 0;
    goto L95;

  anon95_Then:
    assume {:partition} majorFunction != 4;
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} majorFunction != 3;
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} majorFunction != 22;
    goto L95;

  anon89_Then:
    assume {:partition} majorFunction == 22;
    goto L87;

  anon88_Then:
    assume {:partition} majorFunction == 3;
    goto L87;

  anon87_Then:
    call {:si_unique_call 476} sdv_122 := IsListEmpty(q);
    goto anon90_Then, anon90_Else;

  anon90_Else:
    assume {:partition} sdv_122 == 0;
    call {:si_unique_call 477} sdv_133 := corral_nondet();
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} sdv_133 != 0;
    call {:si_unique_call 478} irql_1 := KfAcquireSpinLock(0);
    assume {:nonnull} filter != 0;
    assume filter > 0;
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:nonnull} filter != 0;
    assume filter > 0;
    call {:si_unique_call 479} sdv_119 := IsListEmpty(IrpList__VSP_LOVELACE_DPC_CONTEXT(LovelaceContext_FILTER_EXTENSION(filter)));
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} sdv_119 != 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} q != 0;
    assume q > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} q != 0;
    assume q > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    havoc Tmp_252;
    assume {:nonnull} Tmp_252 != 0;
    assume Tmp_252 > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    havoc Tmp_245;
    assume {:nonnull} Tmp_245 != 0;
    assume Tmp_245 > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    goto L122;

  L122:
    call {:si_unique_call 480} IoQueueWorkItem(0, li2bplFunctionConstant1287, 1, 0);
    call {:si_unique_call 481} KfReleaseSpinLock(0, irql_1);
    goto L1;

  anon93_Then:
    assume {:partition} sdv_119 == 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    call {:si_unique_call 482} AppendTailList(IrpList__VSP_LOVELACE_DPC_CONTEXT(LovelaceContext_FILTER_EXTENSION(filter)), q);
    call {:si_unique_call 483} vslice_dummy_var_48 := RemoveEntryList(q);
    goto L122;

  anon92_Then:
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} q != 0;
    assume q > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} q != 0;
    assume q > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    havoc Tmp_251;
    assume {:nonnull} Tmp_251 != 0;
    assume Tmp_251 > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    havoc Tmp_247;
    assume {:nonnull} Tmp_247 != 0;
    assume Tmp_247 > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    goto L122;

  anon91_Then:
    assume {:partition} sdv_133 == 0;
    call {:si_unique_call 484} sdv_hash_588722555(driver, q);
    goto L1;

  anon90_Then:
    assume {:partition} sdv_122 != 0;
    goto L1;

  anon86_Then:
    assume {:partition} sdv_129 != 0;
    goto L1;

  anon85_Then:
    assume {:partition} sdv_128 == 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    call {:si_unique_call 485} AppendTailList(q, HoldQueue_FILTER_EXTENSION(filter));
    assume {:nonnull} filter != 0;
    assume filter > 0;
    call {:si_unique_call 486} vslice_dummy_var_49 := RemoveEntryList(HoldQueue_FILTER_EXTENSION(filter));
    assume {:nonnull} filter != 0;
    assume filter > 0;
    call {:si_unique_call 487} InitializeListHead(HoldQueue_FILTER_EXTENSION(filter));
    goto L65;

  anon84_Then:
    assume {:partition} sdv_127 == 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} q != 0;
    assume q > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    assume {:nonnull} q != 0;
    assume q > 0;
    assume {:nonnull} filter != 0;
    assume filter > 0;
    call {:si_unique_call 488} InitializeListHead(BandwidthRequestQueue_FILTER_EXTENSION(filter));
    assume {:nonnull} q != 0;
    assume q > 0;
    assume {:nonnull} q != 0;
    assume q > 0;
    goto L55;

  anon83_Then:
    call {:si_unique_call 489} KfReleaseSpinLock(0, irql_1);
    goto L1;
}



procedure {:origName "sdv_hash_617980994"} sdv_hash_617980994(actual_RootExtension: int, actual_WorkItem: int);
  modifies alloc;



implementation {:origName "sdv_hash_617980994"} sdv_hash_617980994(actual_RootExtension: int, actual_WorkItem: int)
{
  var {:scalar} irql_2: int;
  var {:pointer} RootExtension: int;
  var {:pointer} WorkItem: int;
  var vslice_dummy_var_73: int;

  anon0:
    call {:si_unique_call 490} vslice_dummy_var_73 := __HAVOC_malloc(4);
    RootExtension := actual_RootExtension;
    WorkItem := actual_WorkItem;
    call {:si_unique_call 491} irql_2 := KfAcquireSpinLock(0);
    assume {:nonnull} RootExtension != 0;
    assume RootExtension > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} RootExtension != 0;
    assume RootExtension > 0;
    assume {:nonnull} WorkItem != 0;
    assume WorkItem > 0;
    call {:si_unique_call 492} InsertTailList(MediumPriorityQueue__DO_EXTENSION(RootExtension), List__WORK_QUEUE_ITEM(WorkItem));
    call {:si_unique_call 493} KfReleaseSpinLock(0, irql_2);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} RootExtension != 0;
    assume RootExtension > 0;
    call {:si_unique_call 494} KfReleaseSpinLock(0, irql_2);
    assume {:nonnull} RootExtension != 0;
    assume RootExtension > 0;
    assume {:nonnull} RootExtension != 0;
    assume RootExtension > 0;
    assume {:nonnull} RootExtension != 0;
    assume RootExtension > 0;
    assume {:nonnull} RootExtension != 0;
    assume RootExtension > 0;
    goto L1;
}



procedure {:origName "VolSnapPower"} VolSnapPower(actual_DeviceObject_9: int, actual_Irp_5: int) returns (Tmp_255: int);
  modifies alloc, passed_on, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.CurrentStackLocation_unnamed_tag_6;



implementation {:origName "VolSnapPower"} VolSnapPower(actual_DeviceObject_9: int, actual_Irp_5: int) returns (Tmp_255: int)
{
  var {:pointer} irpSp_1: int;
  var {:pointer} filter_1: int;
  var {:scalar} status_6: int;
  var {:pointer} DeviceObject_9: int;
  var {:pointer} Irp_5: int;

  anon0:
    DeviceObject_9 := actual_DeviceObject_9;
    Irp_5 := actual_Irp_5;
    assume {:nonnull} DeviceObject_9 != 0;
    assume DeviceObject_9 > 0;
    havoc filter_1;
    call {:si_unique_call 495} irpSp_1 := IoGetCurrentIrpStackLocation(Irp_5);
    assume {:nonnull} filter_1 != 0;
    assume filter_1 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    call {:si_unique_call 496} PoStartNextPowerIrp(0);
    call {:si_unique_call 497} IoSkipCurrentIrpStackLocation(Irp_5);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume Irp_5 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 498} SLIC_PoCallDriver_entry(0);
    goto L45;

  L45:
    call {:si_unique_call 499} Tmp_255 := PoCallDriver(0, Irp_5);
    goto L1;

  L1:
    return;

  anon15_Then:
    assume !(Irp_5 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L45;

  anon13_Then:
    assume {:nonnull} irpSp_1 != 0;
    assume irpSp_1 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_1)] != 0;
    assume {:nonnull} irpSp_1 != 0;
    assume irpSp_1 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_1)] != 1;
    assume {:nonnull} irpSp_1 != 0;
    assume irpSp_1 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_1)] != 2;
    assume {:nonnull} irpSp_1 != 0;
    assume irpSp_1 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_1)] == 3;
    goto L25;

  L25:
    status_6 := 0;
    goto L27;

  L27:
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_5))] := status_6;
    call {:si_unique_call 500} PoStartNextPowerIrp(0);
    call {:si_unique_call 501} IofCompleteRequest(0, 0);
    Tmp_255 := status_6;
    goto L1;

  anon16_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_1)] != 3;
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    status_6 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_5))];
    goto L27;

  anon17_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_1)] == 2;
    goto L25;

  anon18_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_1)] == 1;
    goto L25;

  anon14_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_1)] == 0;
    goto L25;
}



procedure {:origName "sdv_hash_570003108"} sdv_hash_570003108(actual_Extension: int, actual_DiffAreaFilter: int, actual_SpecificIoStatus: int, actual_FinalStatus: int, actual_UniqueErrorValue: int, actual_PerformSynchronously: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, ref, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_570003108"} sdv_hash_570003108(actual_Extension: int, actual_DiffAreaFilter: int, actual_SpecificIoStatus: int, actual_FinalStatus: int, actual_UniqueErrorValue: int, actual_PerformSynchronously: int)
{
  var {:pointer} context: int;
  var {:pointer} Tmp_262: int;
  var {:pointer} root: int;
  var {:pointer} Extension: int;
  var {:pointer} DiffAreaFilter: int;
  var {:scalar} SpecificIoStatus: int;
  var {:scalar} FinalStatus: int;
  var {:scalar} UniqueErrorValue: int;
  var {:scalar} PerformSynchronously: int;
  var vslice_dummy_var_74: int;
  var vslice_dummy_var_75: int;
  var vslice_dummy_var_76: int;
  var vslice_dummy_var_77: int;
  var vslice_dummy_var_78: int;
  var vslice_dummy_var_79: int;

  anon0:
    call {:si_unique_call 502} vslice_dummy_var_74 := __HAVOC_malloc(4);
    Extension := actual_Extension;
    DiffAreaFilter := actual_DiffAreaFilter;
    SpecificIoStatus := actual_SpecificIoStatus;
    FinalStatus := actual_FinalStatus;
    UniqueErrorValue := actual_UniqueErrorValue;
    PerformSynchronously := actual_PerformSynchronously;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} FinalStatus == 16;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} SpecificIoStatus == -1073348594;
    assume {:nonnull} Extension != 0;
    assume Extension > 0;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} UniqueErrorValue != 11;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} UniqueErrorValue != 14;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} UniqueErrorValue != 15;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} UniqueErrorValue != 16;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} UniqueErrorValue != 17;
    SpecificIoStatus := -1073348548;
    goto L6;

  L6:
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} Extension != 0;
    assume {:nonnull} Extension != 0;
    assume Extension > 0;
    havoc root;
    goto L18;

  L18:
    call {:si_unique_call 503} context := sdv_hash_859757058(root);
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} context != 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(context)] := 8;
    assume {:nonnull} context != 0;
    assume context > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} Extension != 0;
    assume {:nonnull} Extension != 0;
    assume Extension > 0;
    call {:si_unique_call 504} vslice_dummy_var_76 := ObfReferenceObject(0);
    assume {:nonnull} Extension != 0;
    assume Extension > 0;
    havoc Tmp_262;
    assume {:nonnull} Tmp_262 != 0;
    assume Tmp_262 > 0;
    call {:si_unique_call 505} vslice_dummy_var_77 := ObfReferenceObject(0);
    assume {:nonnull} Extension != 0;
    assume Extension > 0;
    call {:si_unique_call 506} vslice_dummy_var_78 := ObfReferenceObject(0);
    goto L31;

  L31:
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} DiffAreaFilter != 0;
    assume {:nonnull} DiffAreaFilter != 0;
    assume DiffAreaFilter > 0;
    call {:si_unique_call 507} vslice_dummy_var_79 := ObfReferenceObject(0);
    call {:si_unique_call 508} vslice_dummy_var_75 := ObfReferenceObject(0);
    goto L41;

  L41:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} PerformSynchronously != 0;
    call {:si_unique_call 509} sdv_hash_90601371(context);
    goto L1;

  L1:
    return;

  anon38_Then:
    assume {:partition} PerformSynchronously == 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    call {:si_unique_call 510} sdv_hash_617980994(root, WorkItem__VSP_CONTEXT(context));
    goto L1;

  anon37_Then:
    assume {:partition} DiffAreaFilter == 0;
    goto L41;

  anon39_Then:
    assume {:partition} Extension == 0;
    goto L31;

  anon36_Then:
    assume {:partition} context == 0;
    goto L1;

  anon28_Then:
    assume {:partition} Extension == 0;
    assume {:nonnull} DiffAreaFilter != 0;
    assume DiffAreaFilter > 0;
    havoc root;
    goto L18;

  anon35_Then:
    assume {:partition} UniqueErrorValue == 17;
    goto L1;

  anon34_Then:
    assume {:partition} UniqueErrorValue == 16;
    goto L1;

  anon33_Then:
    assume {:partition} UniqueErrorValue == 15;
    goto L1;

  anon32_Then:
    assume {:partition} UniqueErrorValue == 14;
    goto L1;

  anon31_Then:
    assume {:partition} UniqueErrorValue == 11;
    goto L1;

  anon30_Then:
    goto L1;

  anon29_Then:
    assume {:partition} SpecificIoStatus != -1073348594;
    goto L1;

  anon27_Then:
    assume {:partition} FinalStatus != 16;
    goto L6;
}



procedure {:origName "sdv_hash_826125959"} sdv_hash_826125959(actual_VolumeNumber: int);
  modifies alloc;



implementation {:origName "sdv_hash_826125959"} sdv_hash_826125959(actual_VolumeNumber: int)
{
  var {:pointer} buffer: int;
  var {:scalar} dosName: int;
  var vslice_dummy_var_80: int;
  var vslice_dummy_var_81: int;
  var vslice_dummy_var_82: int;
  var vslice_dummy_var_83: int;

  anon0:
    call {:si_unique_call 511} vslice_dummy_var_80 := __HAVOC_malloc(4);
    call {:si_unique_call 512} dosName := __HAVOC_malloc(12);
    call {:si_unique_call 513} buffer := __HAVOC_malloc(400);
    call {:si_unique_call 514} vslice_dummy_var_82 := __HAVOC_malloc(148);
    call {:si_unique_call 515} vslice_dummy_var_83 := corral_nondet();
    call {:si_unique_call 516} RtlInitUnicodeString(dosName, buffer);
    call {:si_unique_call 517} vslice_dummy_var_81 := IoDeleteSymbolicLink(0);
    return;
}



procedure {:origName "IoSkipCurrentIrpStackLocation"} IoSkipCurrentIrpStackLocation(actual_Irp_6: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6;



implementation {:origName "IoSkipCurrentIrpStackLocation"} IoSkipCurrentIrpStackLocation(actual_Irp_6: int)
{
  var {:pointer} Irp_6: int;
  var vslice_dummy_var_84: int;

  anon0:
    call {:si_unique_call 518} vslice_dummy_var_84 := __HAVOC_malloc(4);
    Irp_6 := actual_Irp_6;
    assume {:nonnull} Irp_6 != 0;
    assume Irp_6 > 0;
    assume {:nonnull} Irp_6 != 0;
    assume Irp_6 > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(Irp_6)))] := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(Irp_6)))];
    return;
}



procedure {:origName "DriverEntry"} DriverEntry(actual_DriverObject_5: int, actual_RegistryPath: int) returns (Tmp_269: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, ref;
  free ensures Tmp_269 == -1073741811 || Tmp_269 == -1073741824 || Tmp_269 == -1073741771 || Tmp_269 == -1073741670 || Tmp_269 == -1073741823 || Tmp_269 == 0;



implementation {:origName "DriverEntry"} DriverEntry(actual_DriverObject_5: int, actual_RegistryPath: int) returns (Tmp_269: int)
{
  var {:scalar} i_1: int;
  var {:pointer} Tmp_270: int;
  var {:pointer} Tmp_271: int;
  var {:pointer} s_p_e_c_i_a_l_1: int;
  var {:pointer} deviceObject: int;
  var {:scalar} Tmp_272: int;
  var {:pointer} Tmp_273: int;
  var {:pointer} Tmp_274: int;
  var {:pointer} Tmp_275: int;
  var {:pointer} Tmp_276: int;
  var {:pointer} Tmp_277: int;
  var {:pointer} Tmp_278: int;
  var {:scalar} oa: int;
  var {:pointer} Tmp_280: int;
  var {:pointer} sdv_149: int;
  var {:pointer} Tmp_281: int;
  var {:pointer} Tmp_282: int;
  var {:scalar} Tmp_284: int;
  var {:pointer} rootExtension: int;
  var {:scalar} string: int;
  var {:pointer} Tmp_285: int;
  var {:scalar} Tmp_286: int;
  var {:scalar} sdv_157: int;
  var {:pointer} Tmp_287: int;
  var {:pointer} Tmp_288: int;
  var {:pointer} Tmp_289: int;
  var {:pointer} Tmp_290: int;
  var {:scalar} status_7: int;
  var {:scalar} Tmp_291: int;
  var {:pointer} Tmp_293: int;
  var {:pointer} Tmp_294: int;
  var {:pointer} event: int;
  var {:scalar} Tmp_295: int;
  var {:pointer} h: int;
  var {:scalar} Tmp_296: int;
  var {:pointer} DriverObject_5: int;
  var {:pointer} RegistryPath: int;
  var boogieTmp: int;
  var vslice_dummy_var_85: int;
  var vslice_dummy_var_86: int;
  var vslice_dummy_var_87: int;
  var vslice_dummy_var_1158: int;
  var vslice_dummy_var_1159: int;
  var vslice_dummy_var_1160: int;

  anon0:
    call {:si_unique_call 519} deviceObject := __HAVOC_malloc(4);
    call {:si_unique_call 520} oa := __HAVOC_malloc(24);
    call {:si_unique_call 521} string := __HAVOC_malloc(12);
    call {:si_unique_call 522} event := __HAVOC_malloc(4);
    call {:si_unique_call 523} h := __HAVOC_malloc(4);
    DriverObject_5 := actual_DriverObject_5;
    RegistryPath := actual_RegistryPath;
    call {:si_unique_call 524} Tmp_270 := __HAVOC_malloc(112);
    call {:si_unique_call 525} Tmp_273 := __HAVOC_malloc(112);
    call {:si_unique_call 526} Tmp_274 := __HAVOC_malloc(36);
    call {:si_unique_call 527} Tmp_275 := __HAVOC_malloc(1152);
    call {:si_unique_call 528} Tmp_277 := __HAVOC_malloc(112);
    call {:si_unique_call 529} Tmp_278 := __HAVOC_malloc(72);
    call {:si_unique_call 530} Tmp_281 := __HAVOC_malloc(112);
    call {:si_unique_call 531} Tmp_287 := __HAVOC_malloc(112);
    call {:si_unique_call 532} Tmp_288 := __HAVOC_malloc(112);
    call {:si_unique_call 533} Tmp_289 := __HAVOC_malloc(112);
    call {:si_unique_call 534} Tmp_290 := __HAVOC_malloc(112);
    call {:si_unique_call 535} Tmp_293 := __HAVOC_malloc(136);
    i_1 := 0;
    assume {:nonnull} deviceObject != 0;
    assume deviceObject > 0;
    status_7 := 0;
    rootExtension := 0;
    assume {:nonnull} string != 0;
    assume string > 0;
    assume {:nonnull} string != 0;
    assume string > 0;
    assume {:nonnull} string != 0;
    assume string > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} h != 0;
    assume h > 0;
    assume {:nonnull} event != 0;
    assume event > 0;
    i_1 := 0;
    goto L27;

  L27:
    call {:si_unique_call 536} i_1, Tmp_273, Tmp_296 := DriverEntry_loop_L27(i_1, Tmp_273, Tmp_296, DriverObject_5);
    goto L27_last;

  L27_last:
    assume {:CounterLoop 27} {:Counter "i_1"} true;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} 27 >= i_1;
    Tmp_296 := i_1;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    havoc Tmp_273;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume Tmp_296 <= 2;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume Tmp_296 != 2;
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume Tmp_296 != 1;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume Tmp_296 != 0;
    goto L298;

  L298:
    i_1 := i_1 + 1;
    goto L298_dummy;

  L298_dummy:
    assume false;
    return;

  anon73_Then:
    assume Tmp_296 == 0;
    Tmp_296 := 0;
    assume {:nonnull} Tmp_273 != 0;
    assume Tmp_273 > 0;
    goto L298;

  anon72_Then:
    assume Tmp_296 == 1;
    Tmp_296 := 1;
    assume {:nonnull} Tmp_273 != 0;
    assume Tmp_273 > 0;
    goto L298;

  anon71_Then:
    assume Tmp_296 == 2;
    Tmp_296 := 2;
    assume {:nonnull} Tmp_273 != 0;
    assume Tmp_273 > 0;
    goto L298;

  anon70_Then:
    assume Tmp_296 > 2;
    assume {:nonnull} Tmp_273 != 0;
    assume Tmp_273 > 0;
    goto L298;

  anon51_Then:
    assume {:partition} i_1 > 27;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    havoc Tmp_276;
    assume {:nonnull} Tmp_276 != 0;
    assume Tmp_276 > 0;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    havoc Tmp_289;
    assume {:nonnull} Tmp_289 != 0;
    assume Tmp_289 > 0;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    havoc Tmp_288;
    assume {:nonnull} Tmp_288 != 0;
    assume Tmp_288 > 0;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    havoc Tmp_270;
    assume {:nonnull} Tmp_270 != 0;
    assume Tmp_270 > 0;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    havoc Tmp_290;
    assume {:nonnull} Tmp_290 != 0;
    assume Tmp_290 > 0;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    havoc Tmp_277;
    assume {:nonnull} Tmp_277 != 0;
    assume Tmp_277 > 0;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    havoc Tmp_281;
    assume {:nonnull} Tmp_281 != 0;
    assume Tmp_281 > 0;
    assume {:nonnull} DriverObject_5 != 0;
    assume DriverObject_5 > 0;
    havoc Tmp_287;
    assume {:nonnull} Tmp_287 != 0;
    assume Tmp_287 > 0;
    call {:si_unique_call 537} status_7 := IoAllocateDriverObjectExtension(0, 0, 1200, 0);
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} status_7 >= 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 538} InitializeListHead(FilterList__DO_EXTENSION(rootExtension));
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 539} InitializeListHead(HoldIrps__DO_EXTENSION(rootExtension));
    call {:si_unique_call 540} KeInitializeTimer(0);
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 541} KeInitializeDpc(HoldTimerDpc__DO_EXTENSION(rootExtension), li2bplFunctionConstant999, 0);
    call {:si_unique_call 542} KeInitializeSemaphore(0, 1, 1);
    call {:si_unique_call 543} KeInitializeSemaphore(0, 1, 1);
    i_1 := 0;
    goto L69;

  L69:
    call {:si_unique_call 544} i_1, Tmp_272, Tmp_274, Tmp_275, Tmp_278, Tmp_285, Tmp_286, Tmp_294, Tmp_295 := DriverEntry_loop_L69(i_1, Tmp_272, Tmp_274, Tmp_275, Tmp_278, rootExtension, Tmp_285, Tmp_286, Tmp_294, Tmp_295);
    goto L69_last;

  L69_last:
    assume {:CounterLoop 9} {:Counter "i_1"} true;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} 9 > i_1;
    Tmp_272 := i_1;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    havoc Tmp_278;
    Tmp_294 := Tmp_278 + Tmp_272 * 8;
    call {:si_unique_call 545} InitializeListHead(Tmp_294);
    Tmp_295 := i_1;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    havoc Tmp_275;
    call {:si_unique_call 546} KeInitializeSemaphore(0, 0, -1);
    Tmp_286 := i_1;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    havoc Tmp_274;
    Tmp_285 := Tmp_274 + Tmp_286 * 4;
    call {:si_unique_call 547} KeInitializeSpinLock(Tmp_285);
    i_1 := i_1 + 1;
    goto anon53_Else_dummy;

  anon53_Else_dummy:
    assume false;
    return;

  anon53_Then:
    assume {:partition} i_1 >= 9;
    call {:si_unique_call 548} KeInitializeSemaphore(0, 1, 1);
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 549} InitializeListHead(LowPriorityQueue__DO_EXTENSION(rootExtension));
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 550} InitializeListHead(MediumPriorityQueue__DO_EXTENSION(rootExtension));
    call {:si_unique_call 551} IoRegisterDriverReinitialization(0, li2bplFunctionConstant1210, 0);
    call {:si_unique_call 552} IoRegisterBootDriverReinitialization(0, li2bplFunctionConstant1209, 0);
    call {:si_unique_call 553} ExInitializeNPagedLookasideList(0, 0, 0, 0, 152, -481071274, 32);
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 554} boogieTmp := sdv_hash_859757058(rootExtension);
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 555} InitializeListHead(IrpWaitingList__DO_EXTENSION(rootExtension));
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 556} KeInitializeSpinLock(ESpinLock__DO_EXTENSION(rootExtension));
    call {:si_unique_call 557} ExInitializeNPagedLookasideList(0, 0, 0, 0, 40, -481071274, 32);
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 558} boogieTmp := sdv_hash_77318239(rootExtension);
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 559} InitializeListHead(WriteContextIrpWaitingList__DO_EXTENSION(rootExtension));
    call {:si_unique_call 560} ExInitializeNPagedLookasideList(0, 0, 0, 0, 128, -195858602, 32);
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 561} boogieTmp := sdv_hash_234498906(rootExtension);
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 562} InitializeListHead(WorkItemWaitingList__DO_EXTENSION(rootExtension));
    assume {:nonnull} RegistryPath != 0;
    assume RegistryPath > 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    havoc Tmp_291;
    call {:si_unique_call 563} sdv_149 := ExAllocatePoolWithTag(1, Tmp_291, -212635818);
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    status_7 := -1073741811;
    goto L158;

  L158:
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} status_7 >= 0;
    goto L160;

  L160:
    assume {:nonnull} h != 0;
    assume h > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    call {:si_unique_call 564} vslice_dummy_var_85 := ZwClose(0);
    assume {:nonnull} h != 0;
    assume h > 0;
    goto L161;

  L161:
    Tmp_269 := status_7;
    goto L1;

  L1:
    return;

  anon60_Then:
    goto L161;

  anon58_Then:
    assume {:partition} 0 > status_7;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} rootExtension != 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 565} ExFreePoolWithTag(0, 0);
    goto L167;

  L167:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    havoc vslice_dummy_var_1158;
    call {:si_unique_call 566} sdv_hash_364468681(rootExtension, vslice_dummy_var_1158);
    goto L171;

  L171:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    havoc vslice_dummy_var_1159;
    call {:si_unique_call 567} ExFreeToNPagedLookasideList(ContextLookasideList__DO_EXTENSION(rootExtension), vslice_dummy_var_1159);
    goto L175;

  L175:
    call {:si_unique_call 568} ExDeleteNPagedLookasideList(0);
    call {:si_unique_call 569} ExDeleteNPagedLookasideList(0);
    call {:si_unique_call 570} ExDeleteNPagedLookasideList(0);
    goto L160;

  anon63_Then:
    goto L175;

  anon62_Then:
    goto L171;

  anon61_Then:
    goto L167;

  anon59_Then:
    assume {:partition} rootExtension == 0;
    goto L160;

  anon57_Then:
    assume {:nonnull} RegistryPath != 0;
    assume RegistryPath > 0;
    havoc Tmp_284;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    havoc Tmp_280;
    assume {:nonnull} Tmp_280 != 0;
    assume Tmp_280 > 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 571} InitializeListHead(AdjustBitmapQueue__DO_EXTENSION(rootExtension));
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 572} KeInitializeEvent(PastBootReinit__DO_EXTENSION(rootExtension), 0, 0);
    call {:si_unique_call 573} KeInitializeMutex(0, 0);
    call {:si_unique_call 574} status_7 := EtwRegister(0, 0, 0, 0);
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} status_7 >= 0;
    goto L205;

  L205:
    call {:si_unique_call 575} status_7 := corral_nondet();
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} status_7 >= 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto L210;

  L210:
    status_7 := 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 576} boogieTmp := VspIsSetup();
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    call {:si_unique_call 577} status_7 := IoCreateDevice(0, 0, 0, 34, 0, 0, deviceObject);
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} status_7 >= 0;
    goto L220;

  L220:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 578} InitializeListHead(DiffAreaTimers__DO_EXTENSION(rootExtension));
    Tmp_293 := strConst__li2bpl4;
    call {:si_unique_call 579} RtlInitUnicodeString(string, Tmp_293);
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    assume {:nonnull} oa != 0;
    assume oa > 0;
    call {:si_unique_call 580} status_7 := ZwOpenEvent(h, 0, 0);
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} status_7 >= 0;
    assume {:nonnull} h != 0;
    assume h > 0;
    havoc vslice_dummy_var_1160;
    call {:si_unique_call 581} status_7 := _ObReferenceObjectByHandle(vslice_dummy_var_1160, 0, 0, 0, event, 0);
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} status_7 >= 0;
    assume {:nonnull} event != 0;
    assume event > 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto L254;

  L254:
    call {:si_unique_call 582} vslice_dummy_var_86 := ZwClose(0);
    assume {:nonnull} h != 0;
    assume h > 0;
    goto L246;

  L246:
    call {:si_unique_call 583} sdv_157 := corral_nondet();
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    Tmp_271 := KeTickCount;
    assume {:nonnull} Tmp_271 != 0;
    assume Tmp_271 > 0;
    havoc s_p_e_c_i_a_l_1;
    goto L263;

  L263:
    call {:si_unique_call 584} Tmp_282 := DriverEntry_loop_L263(s_p_e_c_i_a_l_1, Tmp_282, rootExtension);
    goto L263_last;

  L263_last:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    assume {:nonnull} s_p_e_c_i_a_l_1 != 0;
    assume s_p_e_c_i_a_l_1 > 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    assume {:nonnull} s_p_e_c_i_a_l_1 != 0;
    assume s_p_e_c_i_a_l_1 > 0;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    Tmp_282 := LastCheckTickCount__DO_EXTENSION(rootExtension);
    assume {:nonnull} Tmp_282 != 0;
    assume Tmp_282 > 0;
    assume {:nonnull} s_p_e_c_i_a_l_1 != 0;
    assume s_p_e_c_i_a_l_1 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    call {:si_unique_call 585} vslice_dummy_var_87 := corral_nondet();
    status_7 := 0;
    goto L158;

  anon75_Then:
    goto anon75_Then_dummy;

  anon75_Then_dummy:
    assume false;
    return;

  anon69_Then:
    assume {:partition} 0 > status_7;
    goto L254;

  anon68_Then:
    assume {:partition} 0 > status_7;
    goto L246;

  anon67_Then:
    assume {:partition} 0 > status_7;
    goto L158;

  anon66_Then:
    goto L220;

  anon65_Then:
    assume {:partition} 0 > status_7;
    goto L210;

  anon64_Then:
    assume {:partition} 0 > status_7;
    assume {:nonnull} rootExtension != 0;
    assume rootExtension > 0;
    goto L205;

  anon74_Then:
    status_7 := -1073741670;
    goto L158;

  anon56_Then:
    status_7 := -1073741670;
    goto L158;

  anon55_Then:
    call {:si_unique_call 586} ExDeleteNPagedLookasideList(0);
    call {:si_unique_call 587} ExDeleteNPagedLookasideList(0);
    Tmp_269 := -1073741670;
    goto L1;

  anon54_Then:
    call {:si_unique_call 588} ExDeleteNPagedLookasideList(0);
    Tmp_269 := -1073741670;
    goto L1;

  anon52_Then:
    assume {:partition} 0 > status_7;
    Tmp_269 := status_7;
    goto L1;
}



procedure {:origName "sdv_hash_84974865"} sdv_hash_84974865(actual_Filter_2: int) returns (Tmp_297: int);
  modifies alloc;
  free ensures Tmp_297 == -1073741810 || Tmp_297 == 0;



implementation {:origName "sdv_hash_84974865"} sdv_hash_84974865(actual_Filter_2: int) returns (Tmp_297: int)
{
  var {:pointer} Filter_2: int;

  anon0:
    Filter_2 := actual_Filter_2;
    assume {:nonnull} Filter_2 != 0;
    assume Filter_2 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 589} sdv_hash_946681144(Filter_2);
    Tmp_297 := -1073741810;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_297 := 0;
    goto L1;
}



procedure {:origName "sdv_hash_161800534"} sdv_hash_161800534(actual_Filter_3: int, actual_State_1: int, actual_LockHeld: int);
  modifies alloc;



implementation {:origName "sdv_hash_161800534"} sdv_hash_161800534(actual_Filter_3: int, actual_State_1: int, actual_LockHeld: int)
{
  var {:scalar} irql_3: int;
  var {:scalar} LockHeld: int;
  var vslice_dummy_var_88: int;

  anon0:
    call {:si_unique_call 590} vslice_dummy_var_88 := __HAVOC_malloc(4);
    LockHeld := actual_LockHeld;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} LockHeld != 0;
    goto L12;

  L12:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} LockHeld == 0;
    call {:si_unique_call 591} KfReleaseSpinLock(0, irql_3);
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} LockHeld != 0;
    goto L1;

  anon5_Then:
    assume {:partition} LockHeld == 0;
    call {:si_unique_call 592} irql_3 := KfAcquireSpinLock(0);
    goto L12;
}



procedure {:origName "sdv_hash_493014447"} sdv_hash_493014447(actual_RootExtension_1: int, actual_Context_4: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_493014447"} sdv_hash_493014447(actual_RootExtension_1: int, actual_Context_4: int)
{
  var {:pointer} Tmp_301: int;
  var {:pointer} irpSp_2: int;
  var {:scalar} all: int;
  var {:pointer} Tmp_305: int;
  var {:pointer} Tmp_306: int;
  var {:scalar} Tmp_307: int;
  var {:scalar} sdv_171: int;
  var {:pointer} Tmp_308: int;
  var {:pointer} irp_1: int;
  var {:pointer} l_1: int;
  var {:scalar} Tmp_309: int;
  var {:scalar} irql_4: int;
  var {:scalar} sdv_178: int;
  var {:pointer} RootExtension_1: int;
  var {:pointer} Context_4: int;
  var vslice_dummy_var_89: int;
  var vslice_dummy_var_90: int;
  var vslice_dummy_var_91: int;
  var vslice_dummy_var_92: int;
  var vslice_dummy_var_93: int;
  var vslice_dummy_var_94: int;
  var vslice_dummy_var_95: int;
  var vslice_dummy_var_96: int;
  var vslice_dummy_var_97: int;
  var vslice_dummy_var_98: int;
  var vslice_dummy_var_99: int;
  var vslice_dummy_var_100: int;
  var vslice_dummy_var_101: int;
  var vslice_dummy_var_102: int;
  var vslice_dummy_var_103: int;
  var vslice_dummy_var_104: int;
  var vslice_dummy_var_105: int;
  var vslice_dummy_var_106: int;
  var vslice_dummy_var_107: int;
  var vslice_dummy_var_108: int;
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
  var vslice_dummy_var_1161: int;
  var vslice_dummy_var_1162: int;
  var vslice_dummy_var_1163: int;
  var vslice_dummy_var_1164: int;
  var vslice_dummy_var_1165: int;
  var vslice_dummy_var_1166: int;
  var vslice_dummy_var_1167: int;
  var vslice_dummy_var_1168: int;
  var vslice_dummy_var_1169: int;
  var vslice_dummy_var_1170: int;
  var vslice_dummy_var_1171: int;
  var vslice_dummy_var_1172: int;
  var vslice_dummy_var_1173: int;
  var vslice_dummy_var_1174: int;
  var vslice_dummy_var_1175: int;
  var vslice_dummy_var_1176: int;
  var vslice_dummy_var_1177: int;
  var vslice_dummy_var_1178: int;
  var vslice_dummy_var_1179: int;
  var vslice_dummy_var_1180: int;
  var vslice_dummy_var_1181: int;
  var vslice_dummy_var_1182: int;
  var vslice_dummy_var_1183: int;
  var vslice_dummy_var_1184: int;
  var vslice_dummy_var_1185: int;
  var vslice_dummy_var_1186: int;
  var vslice_dummy_var_1187: int;
  var vslice_dummy_var_1188: int;
  var vslice_dummy_var_1189: int;
  var vslice_dummy_var_1190: int;
  var vslice_dummy_var_1191: int;
  var vslice_dummy_var_1192: int;
  var vslice_dummy_var_1193: int;
  var vslice_dummy_var_1194: int;
  var vslice_dummy_var_1195: int;
  var vslice_dummy_var_1196: int;
  var vslice_dummy_var_1197: int;
  var vslice_dummy_var_1198: int;
  var vslice_dummy_var_1199: int;
  var vslice_dummy_var_1200: int;
  var vslice_dummy_var_1201: int;
  var vslice_dummy_var_1202: int;
  var vslice_dummy_var_1203: int;
  var vslice_dummy_var_1204: int;

  anon0:
    call {:si_unique_call 593} vslice_dummy_var_89 := __HAVOC_malloc(4);
    RootExtension_1 := actual_RootExtension_1;
    Context_4 := actual_Context_4;
    call {:si_unique_call 594} Tmp_301 := __HAVOC_malloc(112);
    call {:si_unique_call 595} vslice_dummy_var_90 := __HAVOC_malloc(48);
    call {:si_unique_call 596} Tmp_308 := __HAVOC_malloc(112);
    all := 0;
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    goto anon124_Then, anon124_Else;

  anon124_Else:
    call {:si_unique_call 597} irql_4 := KfAcquireSpinLock(0);
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    call {:si_unique_call 598} sdv_171 := IsListEmpty(IrpWaitingList__DO_EXTENSION(RootExtension_1));
    goto anon121_Then, anon121_Else;

  anon121_Else:
    assume {:partition} sdv_171 != 0;
    call {:si_unique_call 599} KfReleaseSpinLock(0, irql_4);
    goto L1;

  L1:
    return;

  anon121_Then:
    assume {:partition} sdv_171 == 0;
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    call {:si_unique_call 600} l_1 := RemoveHeadList(IrpWaitingList__DO_EXTENSION(RootExtension_1));
    call {:si_unique_call 601} KfReleaseSpinLock(0, irql_4);
    irp_1 := l_1;
    call {:si_unique_call 602} irpSp_2 := IoGetCurrentIrpStackLocation(irp_1);
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc Tmp_309;
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    havoc Tmp_305;
    assume {:nonnull} Tmp_305 != 0;
    assume Tmp_305 > 0;
    havoc Tmp_301;
    goto anon125_Then, anon125_Else;

  anon125_Else:
    assume Tmp_309 != 27;
    goto anon126_Then, anon126_Else;

  anon126_Else:
    assume Tmp_309 != 26;
    goto anon127_Then, anon127_Else;

  anon127_Else:
    assume Tmp_309 != 25;
    goto anon128_Then, anon128_Else;

  anon128_Else:
    assume Tmp_309 != 24;
    goto anon129_Then, anon129_Else;

  anon129_Else:
    assume Tmp_309 != 23;
    goto anon130_Then, anon130_Else;

  anon130_Else:
    assume Tmp_309 != 22;
    goto anon131_Then, anon131_Else;

  anon131_Else:
    assume Tmp_309 != 21;
    goto anon132_Then, anon132_Else;

  anon132_Else:
    assume Tmp_309 != 20;
    goto anon133_Then, anon133_Else;

  anon133_Else:
    assume Tmp_309 != 19;
    goto anon134_Then, anon134_Else;

  anon134_Else:
    assume Tmp_309 != 18;
    goto anon135_Then, anon135_Else;

  anon135_Else:
    assume Tmp_309 != 17;
    goto anon136_Then, anon136_Else;

  anon136_Else:
    assume Tmp_309 != 16;
    goto anon137_Then, anon137_Else;

  anon137_Else:
    assume Tmp_309 != 15;
    goto anon138_Then, anon138_Else;

  anon138_Else:
    assume Tmp_309 != 14;
    goto anon139_Then, anon139_Else;

  anon139_Else:
    assume Tmp_309 != 13;
    goto anon140_Then, anon140_Else;

  anon140_Else:
    assume Tmp_309 != 12;
    goto anon141_Then, anon141_Else;

  anon141_Else:
    assume Tmp_309 != 11;
    goto anon142_Then, anon142_Else;

  anon142_Else:
    assume Tmp_309 != 10;
    goto anon143_Then, anon143_Else;

  anon143_Else:
    assume Tmp_309 != 9;
    goto anon144_Then, anon144_Else;

  anon144_Else:
    assume Tmp_309 != 8;
    goto anon145_Then, anon145_Else;

  anon145_Else:
    assume Tmp_309 != 7;
    goto anon146_Then, anon146_Else;

  anon146_Else:
    assume Tmp_309 != 6;
    goto anon147_Then, anon147_Else;

  anon147_Else:
    assume Tmp_309 != 5;
    goto anon148_Then, anon148_Else;

  anon148_Else:
    assume Tmp_309 != 4;
    goto anon149_Then, anon149_Else;

  anon149_Else:
    assume Tmp_309 != 3;
    goto anon150_Then, anon150_Else;

  anon150_Else:
    assume Tmp_309 != 2;
    goto anon151_Then, anon151_Else;

  anon151_Else:
    assume Tmp_309 != 1;
    goto anon152_Then, anon152_Else;

  anon152_Else:
    assume false;
    return;

  anon152_Then:
    assume Tmp_309 == 0;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1161;
    call {:si_unique_call 603} vslice_dummy_var_112 := VolSnapDefaultDispatch(vslice_dummy_var_1161, irp_1);
    goto L1;

  anon151_Then:
    assume Tmp_309 == 1;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1162;
    call {:si_unique_call 604} vslice_dummy_var_111 := VolSnapDefaultDispatch(vslice_dummy_var_1162, irp_1);
    goto L1;

  anon150_Then:
    assume Tmp_309 == 2;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1163;
    call {:si_unique_call 605} vslice_dummy_var_110 := VolSnapDefaultDispatch(vslice_dummy_var_1163, irp_1);
    goto L1;

  anon149_Then:
    assume Tmp_309 == 3;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    goto L1;

  anon148_Then:
    assume Tmp_309 == 4;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    goto L1;

  anon147_Then:
    assume Tmp_309 == 5;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1164;
    call {:si_unique_call 606} vslice_dummy_var_109 := VolSnapDefaultDispatch(vslice_dummy_var_1164, irp_1);
    goto L1;

  anon146_Then:
    assume Tmp_309 == 6;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1165;
    call {:si_unique_call 607} vslice_dummy_var_108 := VolSnapDefaultDispatch(vslice_dummy_var_1165, irp_1);
    goto L1;

  anon145_Then:
    assume Tmp_309 == 7;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1166;
    call {:si_unique_call 608} vslice_dummy_var_107 := VolSnapDefaultDispatch(vslice_dummy_var_1166, irp_1);
    goto L1;

  anon144_Then:
    assume Tmp_309 == 8;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1167;
    call {:si_unique_call 609} vslice_dummy_var_106 := VolSnapDefaultDispatch(vslice_dummy_var_1167, irp_1);
    goto L1;

  anon143_Then:
    assume Tmp_309 == 9;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1168;
    call {:si_unique_call 610} vslice_dummy_var_105 := VolSnapDefaultDispatch(vslice_dummy_var_1168, irp_1);
    goto L1;

  anon142_Then:
    assume Tmp_309 == 10;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1169;
    call {:si_unique_call 611} vslice_dummy_var_104 := VolSnapDefaultDispatch(vslice_dummy_var_1169, irp_1);
    goto L1;

  anon141_Then:
    assume Tmp_309 == 11;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1170;
    call {:si_unique_call 612} vslice_dummy_var_103 := VolSnapDefaultDispatch(vslice_dummy_var_1170, irp_1);
    goto L1;

  anon140_Then:
    assume Tmp_309 == 12;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1171;
    call {:si_unique_call 613} vslice_dummy_var_102 := VolSnapDefaultDispatch(vslice_dummy_var_1171, irp_1);
    goto L1;

  anon139_Then:
    assume Tmp_309 == 13;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1172;
    call {:si_unique_call 614} vslice_dummy_var_101 := VolSnapDefaultDispatch(vslice_dummy_var_1172, irp_1);
    goto L1;

  anon138_Then:
    assume Tmp_309 == 14;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    goto L1;

  anon137_Then:
    assume Tmp_309 == 15;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1173;
    call {:si_unique_call 615} vslice_dummy_var_100 := VolSnapDefaultDispatch(vslice_dummy_var_1173, irp_1);
    goto L1;

  anon136_Then:
    assume Tmp_309 == 16;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1174;
    call {:si_unique_call 616} vslice_dummy_var_99 := VolSnapDefaultDispatch(vslice_dummy_var_1174, irp_1);
    goto L1;

  anon135_Then:
    assume Tmp_309 == 17;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1175;
    call {:si_unique_call 617} vslice_dummy_var_98 := VolSnapDefaultDispatch(vslice_dummy_var_1175, irp_1);
    goto L1;

  anon134_Then:
    assume Tmp_309 == 18;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    goto L1;

  anon133_Then:
    assume Tmp_309 == 19;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1176;
    call {:si_unique_call 618} vslice_dummy_var_97 := VolSnapDefaultDispatch(vslice_dummy_var_1176, irp_1);
    goto L1;

  anon132_Then:
    assume Tmp_309 == 20;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1177;
    call {:si_unique_call 619} vslice_dummy_var_96 := VolSnapDefaultDispatch(vslice_dummy_var_1177, irp_1);
    goto L1;

  anon131_Then:
    assume Tmp_309 == 21;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1178;
    call {:si_unique_call 620} vslice_dummy_var_95 := VolSnapDefaultDispatch(vslice_dummy_var_1178, irp_1);
    goto L1;

  anon130_Then:
    assume Tmp_309 == 22;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    goto L1;

  anon129_Then:
    assume Tmp_309 == 23;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1179;
    call {:si_unique_call 621} vslice_dummy_var_94 := VolSnapDefaultDispatch(vslice_dummy_var_1179, irp_1);
    goto L1;

  anon128_Then:
    assume Tmp_309 == 24;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1180;
    call {:si_unique_call 622} vslice_dummy_var_93 := VolSnapDefaultDispatch(vslice_dummy_var_1180, irp_1);
    goto L1;

  anon127_Then:
    assume Tmp_309 == 25;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1181;
    call {:si_unique_call 623} vslice_dummy_var_92 := VolSnapDefaultDispatch(vslice_dummy_var_1181, irp_1);
    goto L1;

  anon126_Then:
    assume Tmp_309 == 26;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1182;
    call {:si_unique_call 624} vslice_dummy_var_91 := VolSnapDefaultDispatch(vslice_dummy_var_1182, irp_1);
    goto L1;

  anon125_Then:
    assume Tmp_309 == 27;
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    goto L1;

  anon124_Then:
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    call {:si_unique_call 625} ExFreeToNPagedLookasideList(ContextLookasideList__DO_EXTENSION(RootExtension_1), Context_4);
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    havoc all;
    all := INTMOD(all, 12);
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    call {:si_unique_call 626} vslice_dummy_var_113 := _InterlockedIncrement64(ContextFreeCount_VSP_DEBUG_INFO(Dbg__DO_EXTENSION(RootExtension_1)));
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    goto anon122_Then, anon122_Else;

  anon122_Else:
    call {:si_unique_call 627} irql_4 := KfAcquireSpinLock(0);
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    call {:si_unique_call 628} sdv_178 := IsListEmpty(IrpWaitingList__DO_EXTENSION(RootExtension_1));
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume {:partition} sdv_178 != 0;
    call {:si_unique_call 629} KfReleaseSpinLock(0, irql_4);
    goto L1;

  anon123_Then:
    assume {:partition} sdv_178 == 0;
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    call {:si_unique_call 630} l_1 := RemoveHeadList(IrpWaitingList__DO_EXTENSION(RootExtension_1));
    call {:si_unique_call 631} KfReleaseSpinLock(0, irql_4);
    irp_1 := l_1;
    call {:si_unique_call 632} irpSp_2 := IoGetCurrentIrpStackLocation(irp_1);
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc Tmp_307;
    assume {:nonnull} RootExtension_1 != 0;
    assume RootExtension_1 > 0;
    havoc Tmp_306;
    assume {:nonnull} Tmp_306 != 0;
    assume Tmp_306 > 0;
    havoc Tmp_308;
    goto anon153_Then, anon153_Else;

  anon153_Else:
    assume Tmp_307 != 27;
    goto anon154_Then, anon154_Else;

  anon154_Else:
    assume Tmp_307 != 26;
    goto anon155_Then, anon155_Else;

  anon155_Else:
    assume Tmp_307 != 25;
    goto anon156_Then, anon156_Else;

  anon156_Else:
    assume Tmp_307 != 24;
    goto anon157_Then, anon157_Else;

  anon157_Else:
    assume Tmp_307 != 23;
    goto anon158_Then, anon158_Else;

  anon158_Else:
    assume Tmp_307 != 22;
    goto anon159_Then, anon159_Else;

  anon159_Else:
    assume Tmp_307 != 21;
    goto anon160_Then, anon160_Else;

  anon160_Else:
    assume Tmp_307 != 20;
    goto anon161_Then, anon161_Else;

  anon161_Else:
    assume Tmp_307 != 19;
    goto anon162_Then, anon162_Else;

  anon162_Else:
    assume Tmp_307 != 18;
    goto anon163_Then, anon163_Else;

  anon163_Else:
    assume Tmp_307 != 17;
    goto anon164_Then, anon164_Else;

  anon164_Else:
    assume Tmp_307 != 16;
    goto anon165_Then, anon165_Else;

  anon165_Else:
    assume Tmp_307 != 15;
    goto anon166_Then, anon166_Else;

  anon166_Else:
    assume Tmp_307 != 14;
    goto anon167_Then, anon167_Else;

  anon167_Else:
    assume Tmp_307 != 13;
    goto anon168_Then, anon168_Else;

  anon168_Else:
    assume Tmp_307 != 12;
    goto anon169_Then, anon169_Else;

  anon169_Else:
    assume Tmp_307 != 11;
    goto anon170_Then, anon170_Else;

  anon170_Else:
    assume Tmp_307 != 10;
    goto anon171_Then, anon171_Else;

  anon171_Else:
    assume Tmp_307 != 9;
    goto anon172_Then, anon172_Else;

  anon172_Else:
    assume Tmp_307 != 8;
    goto anon173_Then, anon173_Else;

  anon173_Else:
    assume Tmp_307 != 7;
    goto anon174_Then, anon174_Else;

  anon174_Else:
    assume Tmp_307 != 6;
    goto anon175_Then, anon175_Else;

  anon175_Else:
    assume Tmp_307 != 5;
    goto anon176_Then, anon176_Else;

  anon176_Else:
    assume Tmp_307 != 4;
    goto anon177_Then, anon177_Else;

  anon177_Else:
    assume Tmp_307 != 3;
    goto anon178_Then, anon178_Else;

  anon178_Else:
    assume Tmp_307 != 2;
    goto anon179_Then, anon179_Else;

  anon179_Else:
    assume Tmp_307 != 1;
    goto anon180_Then, anon180_Else;

  anon180_Else:
    assume false;
    return;

  anon180_Then:
    assume Tmp_307 == 0;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1183;
    call {:si_unique_call 633} vslice_dummy_var_135 := VolSnapDefaultDispatch(vslice_dummy_var_1183, irp_1);
    goto L1;

  anon179_Then:
    assume Tmp_307 == 1;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1184;
    call {:si_unique_call 634} vslice_dummy_var_134 := VolSnapDefaultDispatch(vslice_dummy_var_1184, irp_1);
    goto L1;

  anon178_Then:
    assume Tmp_307 == 2;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1185;
    call {:si_unique_call 635} vslice_dummy_var_133 := VolSnapDefaultDispatch(vslice_dummy_var_1185, irp_1);
    goto L1;

  anon177_Then:
    assume Tmp_307 == 3;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    goto L1;

  anon176_Then:
    assume Tmp_307 == 4;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    goto L1;

  anon175_Then:
    assume Tmp_307 == 5;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1186;
    call {:si_unique_call 636} vslice_dummy_var_132 := VolSnapDefaultDispatch(vslice_dummy_var_1186, irp_1);
    goto L1;

  anon174_Then:
    assume Tmp_307 == 6;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1187;
    call {:si_unique_call 637} vslice_dummy_var_131 := VolSnapDefaultDispatch(vslice_dummy_var_1187, irp_1);
    goto L1;

  anon173_Then:
    assume Tmp_307 == 7;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1188;
    call {:si_unique_call 638} vslice_dummy_var_130 := VolSnapDefaultDispatch(vslice_dummy_var_1188, irp_1);
    goto L1;

  anon172_Then:
    assume Tmp_307 == 8;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1189;
    call {:si_unique_call 639} vslice_dummy_var_129 := VolSnapDefaultDispatch(vslice_dummy_var_1189, irp_1);
    goto L1;

  anon171_Then:
    assume Tmp_307 == 9;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1190;
    call {:si_unique_call 640} vslice_dummy_var_128 := VolSnapDefaultDispatch(vslice_dummy_var_1190, irp_1);
    goto L1;

  anon170_Then:
    assume Tmp_307 == 10;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1191;
    call {:si_unique_call 641} vslice_dummy_var_127 := VolSnapDefaultDispatch(vslice_dummy_var_1191, irp_1);
    goto L1;

  anon169_Then:
    assume Tmp_307 == 11;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1192;
    call {:si_unique_call 642} vslice_dummy_var_126 := VolSnapDefaultDispatch(vslice_dummy_var_1192, irp_1);
    goto L1;

  anon168_Then:
    assume Tmp_307 == 12;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1193;
    call {:si_unique_call 643} vslice_dummy_var_125 := VolSnapDefaultDispatch(vslice_dummy_var_1193, irp_1);
    goto L1;

  anon167_Then:
    assume Tmp_307 == 13;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1194;
    call {:si_unique_call 644} vslice_dummy_var_124 := VolSnapDefaultDispatch(vslice_dummy_var_1194, irp_1);
    goto L1;

  anon166_Then:
    assume Tmp_307 == 14;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    goto L1;

  anon165_Then:
    assume Tmp_307 == 15;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1195;
    call {:si_unique_call 645} vslice_dummy_var_123 := VolSnapDefaultDispatch(vslice_dummy_var_1195, irp_1);
    goto L1;

  anon164_Then:
    assume Tmp_307 == 16;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1196;
    call {:si_unique_call 646} vslice_dummy_var_122 := VolSnapDefaultDispatch(vslice_dummy_var_1196, irp_1);
    goto L1;

  anon163_Then:
    assume Tmp_307 == 17;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1197;
    call {:si_unique_call 647} vslice_dummy_var_121 := VolSnapDefaultDispatch(vslice_dummy_var_1197, irp_1);
    goto L1;

  anon162_Then:
    assume Tmp_307 == 18;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    goto L1;

  anon161_Then:
    assume Tmp_307 == 19;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1198;
    call {:si_unique_call 648} vslice_dummy_var_120 := VolSnapDefaultDispatch(vslice_dummy_var_1198, irp_1);
    goto L1;

  anon160_Then:
    assume Tmp_307 == 20;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1199;
    call {:si_unique_call 649} vslice_dummy_var_119 := VolSnapDefaultDispatch(vslice_dummy_var_1199, irp_1);
    goto L1;

  anon159_Then:
    assume Tmp_307 == 21;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1200;
    call {:si_unique_call 650} vslice_dummy_var_118 := VolSnapDefaultDispatch(vslice_dummy_var_1200, irp_1);
    goto L1;

  anon158_Then:
    assume Tmp_307 == 22;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    goto L1;

  anon157_Then:
    assume Tmp_307 == 23;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1201;
    call {:si_unique_call 651} vslice_dummy_var_117 := VolSnapDefaultDispatch(vslice_dummy_var_1201, irp_1);
    goto L1;

  anon156_Then:
    assume Tmp_307 == 24;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1202;
    call {:si_unique_call 652} vslice_dummy_var_116 := VolSnapDefaultDispatch(vslice_dummy_var_1202, irp_1);
    goto L1;

  anon155_Then:
    assume Tmp_307 == 25;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1203;
    call {:si_unique_call 653} vslice_dummy_var_115 := VolSnapDefaultDispatch(vslice_dummy_var_1203, irp_1);
    goto L1;

  anon154_Then:
    assume Tmp_307 == 26;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    havoc vslice_dummy_var_1204;
    call {:si_unique_call 654} vslice_dummy_var_114 := VolSnapDefaultDispatch(vslice_dummy_var_1204, irp_1);
    goto L1;

  anon153_Then:
    assume Tmp_307 == 27;
    assume {:nonnull} Tmp_308 != 0;
    assume Tmp_308 > 0;
    goto L1;

  anon122_Then:
    goto L1;
}



procedure {:origName "VspIsSetup"} VspIsSetup() returns (Tmp_311: int);
  modifies alloc;
  free ensures Tmp_311 == 1 || Tmp_311 == 0;



implementation {:origName "VspIsSetup"} VspIsSetup() returns (Tmp_311: int)
{
  var {:scalar} oa_1: int;
  var {:pointer} queryTable: int;
  var {:pointer} Tmp_314: int;
  var {:dopa} {:scalar} result: int;
  var {:scalar} Tmp_315: int;
  var {:scalar} keyName: int;
  var {:scalar} status_8: int;
  var {:pointer} h_1: int;
  var {:dopa} {:scalar} zero: int;
  var vslice_dummy_var_136: int;
  var vslice_dummy_var_137: int;

  anon0:
    call {:si_unique_call 655} oa_1 := __HAVOC_malloc(24);
    call {:si_unique_call 656} result := __HAVOC_malloc(4);
    call {:si_unique_call 657} keyName := __HAVOC_malloc(12);
    call {:si_unique_call 658} h_1 := __HAVOC_malloc(4);
    call {:si_unique_call 659} zero := __HAVOC_malloc(4);
    call {:si_unique_call 660} vslice_dummy_var_137 := __HAVOC_malloc(124);
    call {:si_unique_call 661} queryTable := __HAVOC_malloc(56);
    call {:si_unique_call 662} Tmp_314 := __HAVOC_malloc(240);
    assume {:nonnull} keyName != 0;
    assume keyName > 0;
    assume {:nonnull} keyName != 0;
    assume keyName > 0;
    assume {:nonnull} keyName != 0;
    assume keyName > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    status_8 := 0;
    assume {:nonnull} h_1 != 0;
    assume h_1 > 0;
    assume {:nonnull} zero != 0;
    assume zero > 0;
    assume {:nonnull} result != 0;
    assume result > 0;
    Tmp_314 := strConst__li2bpl5;
    call {:si_unique_call 663} RtlInitUnicodeString(keyName, Tmp_314);
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    assume {:nonnull} oa_1 != 0;
    assume oa_1 > 0;
    call {:si_unique_call 664} status_8 := ZwOpenKey(h_1, 0, 0);
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} status_8 < 0;
    assume {:nonnull} queryTable != 0;
    assume queryTable > 0;
    assume {:nonnull} queryTable != 0;
    assume queryTable > 0;
    assume {:nonnull} queryTable != 0;
    assume queryTable > 0;
    assume {:nonnull} queryTable != 0;
    assume queryTable > 0;
    assume {:nonnull} queryTable != 0;
    assume queryTable > 0;
    assume {:nonnull} queryTable != 0;
    assume queryTable > 0;
    call {:si_unique_call 665} status_8 := corral_nondet();
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} status_8 >= 0;
    goto L56;

  L56:
    assume {:nonnull} result != 0;
    assume result > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    Tmp_315 := 1;
    goto L59;

  L59:
    Tmp_311 := Tmp_315;
    goto L1;

  L1:
    return;

  anon9_Then:
    Tmp_315 := 0;
    goto L59;

  anon8_Then:
    assume {:partition} 0 > status_8;
    assume {:nonnull} result != 0;
    assume result > 0;
    assume {:nonnull} zero != 0;
    assume zero > 0;
    goto L56;

  anon7_Then:
    assume {:partition} 0 <= status_8;
    call {:si_unique_call 666} vslice_dummy_var_136 := ZwClose(0);
    Tmp_311 := 1;
    goto L1;
}



procedure {:origName "sdv_hash_613687309"} sdv_hash_613687309(actual_RootExtension_2: int);
  modifies alloc;



implementation {:origName "sdv_hash_613687309"} sdv_hash_613687309(actual_RootExtension_2: int)
{
  var {:pointer} RootExtension_2: int;
  var boogieTmp: int;
  var vslice_dummy_var_138: int;
  var vslice_dummy_var_139: int;

  anon0:
    call {:si_unique_call 667} vslice_dummy_var_138 := __HAVOC_malloc(4);
    RootExtension_2 := actual_RootExtension_2;
    call {:si_unique_call 668} vslice_dummy_var_139 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} RootExtension_2 != 0;
    assume RootExtension_2 > 0;
    call {:si_unique_call 669} boogieTmp := PsGetCurrentThread();
    return;
}



procedure {:origName "sdv_hash_805325738"} sdv_hash_805325738(actual_Extension_1: int, actual_WorkItem_1: int, actual_AlwaysPost: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26;



implementation {:origName "sdv_hash_805325738"} sdv_hash_805325738(actual_Extension_1: int, actual_WorkItem_1: int, actual_AlwaysPost: int)
{
  var {:scalar} synchronousCall: int;
  var {:scalar} context_1: int;
  var {:pointer} filter_2: int;
  var {:scalar} sdv_187: int;
  var {:pointer} Tmp_320: int;
  var {:scalar} irql_5: int;
  var {:pointer} Extension_1: int;
  var {:pointer} WorkItem_1: int;
  var {:scalar} AlwaysPost: int;
  var vslice_dummy_var_140: int;
  var vslice_dummy_var_141: int;
  var vslice_dummy_var_1205: int;

  anon0:
    call {:si_unique_call 670} vslice_dummy_var_140 := __HAVOC_malloc(4);
    call {:si_unique_call 671} context_1 := __HAVOC_malloc(2204);
    Extension_1 := actual_Extension_1;
    WorkItem_1 := actual_WorkItem_1;
    AlwaysPost := actual_AlwaysPost;
    filter_2 := 0;
    irql_5 := 0;
    synchronousCall := 0;
    assume {:nonnull} Extension_1 != 0;
    assume Extension_1 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    filter_2 := Extension_1;
    goto L13;

  L13:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} WorkItem_1 != 0;
    synchronousCall := 0;
    goto L16;

  L16:
    call {:si_unique_call 672} irql_5 := KfAcquireSpinLock(0);
    assume {:nonnull} filter_2 != 0;
    assume filter_2 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} WorkItem_1 != 0;
    assume WorkItem_1 > 0;
    assume {:nonnull} filter_2 != 0;
    assume filter_2 > 0;
    call {:si_unique_call 673} InsertTailList(NonPagedResourceList_FILTER_EXTENSION(filter_2), List__WORK_QUEUE_ITEM(WorkItem_1));
    call {:si_unique_call 674} KfReleaseSpinLock(0, irql_5);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} synchronousCall != 0;
    call {:si_unique_call 675} vslice_dummy_var_141 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto L1;

  L1:
    return;

  anon15_Then:
    assume {:partition} synchronousCall == 0;
    goto L1;

  anon14_Then:
    assume {:nonnull} filter_2 != 0;
    assume filter_2 > 0;
    call {:si_unique_call 676} KfReleaseSpinLock(0, irql_5);
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} synchronousCall == 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} AlwaysPost != 0;
    call {:si_unique_call 677} sdv_187 := sdv_hash_672018212(filter_2, 2);
    assume {:nonnull} filter_2 != 0;
    assume filter_2 > 0;
    havoc vslice_dummy_var_1205;
    call {:si_unique_call 678} sdv_hash_21074203(vslice_dummy_var_1205, WorkItem_1, sdv_187);
    goto L1;

  anon17_Then:
    assume {:partition} AlwaysPost == 0;
    assume {:nonnull} WorkItem_1 != 0;
    assume WorkItem_1 > 0;
    goto L1;

  anon16_Then:
    assume {:partition} synchronousCall != 0;
    goto L1;

  anon13_Then:
    assume {:partition} WorkItem_1 == 0;
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    WorkItem_1 := WorkItem__VSP_CONTEXT(context_1);
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(context_1)] := 7;
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    call {:si_unique_call 679} KeInitializeEvent(Event_sdv_hash_70411571(Event__VSP_CONTEXT(context_1)), 0, 0);
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    synchronousCall := 1;
    goto L16;

  anon18_Then:
    Tmp_320 := Extension_1;
    assume {:nonnull} Tmp_320 != 0;
    assume Tmp_320 > 0;
    havoc filter_2;
    goto L13;
}



procedure {:origName "RemoveEntryList"} RemoveEntryList(actual_Entry: int) returns (Tmp_321: int);



implementation {:origName "RemoveEntryList"} RemoveEntryList(actual_Entry: int) returns (Tmp_321: int)
{
  var {:pointer} Blink: int;
  var {:pointer} Flink: int;
  var {:pointer} Entry: int;

  anon0:
    Entry := actual_Entry;
    assume {:nonnull} Entry != 0;
    assume Entry > 0;
    havoc Flink;
    assume {:nonnull} Entry != 0;
    assume Entry > 0;
    havoc Blink;
    assume {:nonnull} Blink != 0;
    assume Blink > 0;
    assume {:nonnull} Flink != 0;
    assume Flink > 0;
    call {:si_unique_call 680} Tmp_321 := corral_nondet();
    return;
}



procedure {:origName "IoGetNextIrpStackLocation"} IoGetNextIrpStackLocation(actual_Irp_7: int) returns (Tmp_323: int);



implementation {:origName "IoGetNextIrpStackLocation"} IoGetNextIrpStackLocation(actual_Irp_7: int) returns (Tmp_323: int)
{
  var {:pointer} Irp_7: int;

  anon0:
    Irp_7 := actual_Irp_7;
    assume {:nonnull} Irp_7 != 0;
    assume Irp_7 > 0;
    Tmp_323 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(Irp_7)))];
    return;
}



procedure {:origName "VspCancelRoutine"} VspCancelRoutine(actual_DeviceObject_10: int, actual_Irp_8: int);
  modifies alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "VspCancelRoutine"} VspCancelRoutine(actual_DeviceObject_10: int, actual_Irp_8: int)
{
  var {:pointer} filter_3: int;
  var {:pointer} DeviceObject_10: int;
  var {:pointer} Irp_8: int;
  var vslice_dummy_var_142: int;
  var vslice_dummy_var_143: int;
  var vslice_dummy_var_1206: int;

  anon0:
    call {:si_unique_call 681} vslice_dummy_var_142 := __HAVOC_malloc(4);
    DeviceObject_10 := actual_DeviceObject_10;
    Irp_8 := actual_Irp_8;
    assume {:nonnull} DeviceObject_10 != 0;
    assume DeviceObject_10 > 0;
    havoc filter_3;
    assume {:nonnull} filter_3 != 0;
    assume filter_3 > 0;
    assume {:nonnull} Irp_8 != 0;
    assume Irp_8 > 0;
    call {:si_unique_call 682} vslice_dummy_var_143 := RemoveEntryList(ListEntry_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(Irp_8))));
    assume {:nonnull} Irp_8 != 0;
    assume Irp_8 > 0;
    havoc vslice_dummy_var_1206;
    call {:si_unique_call 683} IoReleaseCancelSpinLock(vslice_dummy_var_1206);
    assume {:nonnull} Irp_8 != 0;
    assume Irp_8 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_8))] := -1073741536;
    assume {:nonnull} Irp_8 != 0;
    assume Irp_8 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_8))] := 0;
    call {:si_unique_call 684} IofCompleteRequest(0, 0);
    return;
}



procedure {:origName "InsertTailList"} InsertTailList(actual_ListHead: int, actual_Entry_1: int);
  modifies alloc;



implementation {:origName "InsertTailList"} InsertTailList(actual_ListHead: int, actual_Entry_1: int)
{
  var {:pointer} Blink_1: int;
  var {:pointer} ListHead: int;
  var {:pointer} Entry_1: int;
  var vslice_dummy_var_144: int;

  anon0:
    call {:si_unique_call 685} vslice_dummy_var_144 := __HAVOC_malloc(4);
    ListHead := actual_ListHead;
    Entry_1 := actual_Entry_1;
    assume {:nonnull} ListHead != 0;
    assume ListHead > 0;
    havoc Blink_1;
    assume {:nonnull} Entry_1 != 0;
    assume Entry_1 > 0;
    assume {:nonnull} Entry_1 != 0;
    assume Entry_1 > 0;
    assume {:nonnull} Blink_1 != 0;
    assume Blink_1 > 0;
    assume {:nonnull} ListHead != 0;
    assume ListHead > 0;
    return;
}



procedure {:origName "sdv_hash_206641207"} sdv_hash_206641207(actual_Filter_4: int, actual_SendToSelf: int) returns (Tmp_329: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_206641207"} sdv_hash_206641207(actual_Filter_4: int, actual_SendToSelf: int) returns (Tmp_329: int)
{
  var {:pointer} irp_2: int;
  var {:scalar} ioStatus: int;
  var {:scalar} status_9: int;
  var {:scalar} event_1: int;
  var {:pointer} Filter_4: int;
  var {:scalar} SendToSelf: int;
  var vslice_dummy_var_145: int;

  anon0:
    call {:si_unique_call 686} ioStatus := __HAVOC_malloc(12);
    call {:si_unique_call 687} event_1 := __HAVOC_malloc(124);
    Filter_4 := actual_Filter_4;
    SendToSelf := actual_SendToSelf;
    call {:si_unique_call 688} KeInitializeEvent(event_1, 0, 0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} SendToSelf != 0;
    assume {:nonnull} Filter_4 != 0;
    assume Filter_4 > 0;
    goto L16;

  L16:
    call {:si_unique_call 689} irp_2 := IoBuildDeviceIoControlRequest(5685260, 0, 0, 0, 0, 0, 0, 0, ioStatus);
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} irp_2 != 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} SendToSelf != 0;
    assume {:nonnull} Filter_4 != 0;
    assume Filter_4 > 0;
    goto L25;

  L25:
    call {:si_unique_call 690} status_9 := IofCallDriver(0, irp_2);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} status_9 == 259;
    call {:si_unique_call 691} vslice_dummy_var_145 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus != 0;
    assume ioStatus > 0;
    status_9 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(ioStatus)];
    goto L30;

  L30:
    Tmp_329 := status_9;
    goto L1;

  L1:
    return;

  anon12_Then:
    assume {:partition} status_9 != 259;
    goto L30;

  anon11_Then:
    assume {:partition} SendToSelf == 0;
    assume {:nonnull} Filter_4 != 0;
    assume Filter_4 > 0;
    goto L25;

  anon10_Then:
    assume {:partition} irp_2 == 0;
    Tmp_329 := -1073741670;
    goto L1;

  anon9_Then:
    assume {:partition} SendToSelf == 0;
    assume {:nonnull} Filter_4 != 0;
    assume Filter_4 > 0;
    goto L16;
}



procedure {:origName "sdv_hash_69582830"} sdv_hash_69582830(actual_Extension_2: int) returns (Tmp_333: int);
  modifies alloc, ref, Mem_T.Type_unnamed_tag_26;
  free ensures Tmp_333 == -1073741811 || Tmp_333 == 0 || Tmp_333 == -1073741823 || Tmp_333 == -1073741670;



implementation {:origName "sdv_hash_69582830"} sdv_hash_69582830(actual_Extension_2: int) returns (Tmp_333: int)
{
  var {:scalar} pastReinit: int;
  var {:scalar} deviceInstallState: int;
  var {:pointer} context_2: int;
  var {:scalar} sdv_196: int;
  var {:pointer} filter_4: int;
  var {:scalar} bytes: int;
  var {:scalar} sdv_205: int;
  var {:pointer} Tmp_336: int;
  var {:pointer} Tmp_337: int;
  var {:scalar} status_10: int;
  var {:pointer} Tmp_338: int;
  var {:scalar} irql_6: int;
  var {:pointer} Extension_2: int;
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
  var vslice_dummy_var_1207: int;
  var vslice_dummy_var_1208: int;
  var vslice_dummy_var_1209: int;
  var vslice_dummy_var_1210: int;
  var vslice_dummy_var_1211: int;
  var vslice_dummy_var_1212: int;
  var vslice_dummy_var_1213: int;
  var vslice_dummy_var_1214: int;
  var vslice_dummy_var_1215: int;
  var vslice_dummy_var_1216: int;

  anon0:
    Extension_2 := actual_Extension_2;
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc filter_4;
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    Tmp_333 := -1073741811;
    goto L1;

  L1:
    return;

  anon42_Then:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc Tmp_337;
    assume {:nonnull} Tmp_337 != 0;
    assume Tmp_337 > 0;
    havoc pastReinit;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} pastReinit != 0;
    assume {:nonnull} filter_4 != 0;
    assume filter_4 > 0;
    havoc Tmp_336;
    assume {:nonnull} Tmp_336 != 0;
    assume Tmp_336 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    call {:si_unique_call 692} Tmp_338 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_338 != 0;
    assume Tmp_338 > 0;
    call {:si_unique_call 693} status_10 := IoGetDeviceProperty(0, 18, 4, 0, Tmp_338);
    assume {:nonnull} Tmp_338 != 0;
    assume Tmp_338 > 0;
    havoc bytes;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} status_10 >= 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} deviceInstallState != 0;
    goto L32;

  L32:
    Tmp_333 := 0;
    goto L1;

  anon32_Then:
    assume {:partition} deviceInstallState == 0;
    goto L23;

  L23:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc vslice_dummy_var_1207;
    call {:si_unique_call 694} sdv_hash_613687309(vslice_dummy_var_1207);
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    call {:si_unique_call 695} status_10 := IoRegisterDeviceInterface(0, 0, 0, MountedDeviceInterfaceName_VOLUME_EXTENSION(Extension_2));
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} status_10 >= 0;
    call {:si_unique_call 696} vslice_dummy_var_146 := IoSetDeviceInterfaceState(0, 1);
    goto L35;

  L35:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc vslice_dummy_var_1208;
    call {:si_unique_call 697} sdv_hash_986004649(vslice_dummy_var_1208);
    Tmp_333 := 0;
    goto L1;

  anon34_Then:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    call {:si_unique_call 698} vslice_dummy_var_147 := KeSetEvent(PreExposureEvent_VOLUME_EXTENSION(Extension_2), 0, 0);
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc vslice_dummy_var_1209;
    call {:si_unique_call 699} sdv_hash_986004649(vslice_dummy_var_1209);
    Tmp_333 := 0;
    goto L1;

  anon45_Then:
    goto anon37_Then, anon37_Else;

  anon37_Else:
    call {:si_unique_call 700} irql_6 := KfAcquireSpinLock(0);
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc vslice_dummy_var_1210;
    call {:si_unique_call 701} VspFreeBitMap(vslice_dummy_var_1210);
    call {:si_unique_call 702} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    goto L67;

  L67:
    call {:si_unique_call 703} KfReleaseSpinLock(0, irql_6);
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc vslice_dummy_var_1211;
    call {:si_unique_call 704} sdv_hash_986004649(vslice_dummy_var_1211);
    Tmp_333 := 0;
    goto L1;

  anon38_Then:
    goto L67;

  anon37_Then:
    call {:si_unique_call 705} sdv_196 := KeCancelTimer(0);
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} sdv_196 != 0;
    call {:si_unique_call 706} vslice_dummy_var_148 := ObfDereferenceObject(0);
    assume {:nonnull} filter_4 != 0;
    assume filter_4 > 0;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc vslice_dummy_var_1212;
    call {:si_unique_call 707} sdv_hash_986004649(vslice_dummy_var_1212);
    assume {:nonnull} filter_4 != 0;
    assume filter_4 > 0;
    call {:si_unique_call 708} vslice_dummy_var_150 := KeSetEvent(EndCommitProcessCompleted_FILTER_EXTENSION(filter_4), 0, 0);
    assume {:nonnull} filter_4 != 0;
    assume filter_4 > 0;
    call {:si_unique_call 709} vslice_dummy_var_153 := ObfDereferenceObject(0);
    Tmp_333 := -1073741823;
    goto L1;

  anon40_Then:
    call {:si_unique_call 710} vslice_dummy_var_149 := ObfReferenceObject(0);
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc vslice_dummy_var_1213;
    call {:si_unique_call 711} sdv_hash_986004649(vslice_dummy_var_1213);
    assume {:nonnull} filter_4 != 0;
    assume filter_4 > 0;
    havoc vslice_dummy_var_1214;
    call {:si_unique_call 712} context_2 := sdv_hash_859757058(vslice_dummy_var_1214);
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} context_2 != 0;
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    call {:si_unique_call 713} vslice_dummy_var_154 := ObfReferenceObject(0);
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(context_2)] := 4;
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    call {:si_unique_call 714} sdv_205 := sdv_hash_672018212(filter_4, 3);
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    assume {:nonnull} filter_4 != 0;
    assume filter_4 > 0;
    havoc vslice_dummy_var_1215;
    call {:si_unique_call 715} sdv_hash_21074203(vslice_dummy_var_1215, WorkItem__VSP_CONTEXT(context_2), sdv_205);
    Tmp_333 := 0;
    goto L1;

  anon41_Then:
    assume {:partition} context_2 == 0;
    assume {:nonnull} filter_4 != 0;
    assume filter_4 > 0;
    call {:si_unique_call 716} vslice_dummy_var_151 := KeSetEvent(EndCommitProcessCompleted_FILTER_EXTENSION(filter_4), 0, 0);
    call {:si_unique_call 717} vslice_dummy_var_152 := ObfDereferenceObject(0);
    assume {:nonnull} filter_4 != 0;
    assume filter_4 > 0;
    call {:si_unique_call 718} vslice_dummy_var_155 := ObfDereferenceObject(0);
    Tmp_333 := -1073741670;
    goto L1;

  anon39_Then:
    assume {:partition} sdv_196 == 0;
    assume {:nonnull} Extension_2 != 0;
    assume Extension_2 > 0;
    havoc vslice_dummy_var_1216;
    call {:si_unique_call 719} sdv_hash_986004649(vslice_dummy_var_1216);
    Tmp_333 := 0;
    goto L1;

  anon36_Then:
    assume {:partition} 0 > status_10;
    goto L35;

  anon35_Then:
    goto L35;

  anon33_Then:
    goto L35;

  anon31_Then:
    assume {:partition} 0 > status_10;
    goto L32;

  anon44_Then:
    goto L23;

  anon43_Then:
    assume {:partition} pastReinit == 0;
    goto L23;
}



procedure {:origName "_ObReferenceObjectByHandle"} _ObReferenceObjectByHandle(actual_Handle_2: int, actual_DesiredAccess_3: int, actual_ObjectType_1: int, actual_AccessMode_1: int, actual_pObject: int, actual_pHandleInformation: int) returns (Tmp_340: int);
  modifies ref;
  free ensures Tmp_340 == 0 || Tmp_340 == -1073741823;



implementation {:origName "_ObReferenceObjectByHandle"} _ObReferenceObjectByHandle(actual_Handle_2: int, actual_DesiredAccess_3: int, actual_ObjectType_1: int, actual_AccessMode_1: int, actual_pObject: int, actual_pHandleInformation: int) returns (Tmp_340: int)
{
  var {:scalar} Status: int;
  var {:pointer} Object_4: int;
  var {:scalar} DesiredAccess_3: int;
  var {:scalar} AccessMode_1: int;
  var {:pointer} pObject: int;

  anon0:
    DesiredAccess_3 := actual_DesiredAccess_3;
    AccessMode_1 := actual_AccessMode_1;
    pObject := actual_pObject;
    call {:si_unique_call 720} Status := ObReferenceObjectByHandle(0, DesiredAccess_3, 0, AccessMode_1, 0, 0);
    assume {:nonnull} pObject != 0;
    assume pObject > 0;
    Tmp_340 := Status;
    return;
}



procedure {:origName "IsListEmpty"} IsListEmpty(actual_ListHead_1: int) returns (Tmp_342: int);



implementation {:origName "IsListEmpty"} IsListEmpty(actual_ListHead_1: int) returns (Tmp_342: int)
{

  anon0:
    call {:si_unique_call 721} Tmp_342 := corral_nondet();
    return;
}



procedure {:origName "sdv_hash_234498906"} sdv_hash_234498906(actual_RootExtension_3: int) returns (Tmp_344: int);
  modifies alloc;



implementation {:origName "sdv_hash_234498906"} sdv_hash_234498906(actual_RootExtension_3: int) returns (Tmp_344: int)
{
  var {:pointer} sdv_210: int;
  var {:pointer} tableEntry: int;
  var {:pointer} RootExtension_3: int;

  anon0:
    RootExtension_3 := actual_RootExtension_3;
    assume {:nonnull} RootExtension_3 != 0;
    assume RootExtension_3 > 0;
    call {:si_unique_call 722} sdv_210 := ExAllocateFromNPagedLookasideList(TempTableEntryLookasideList__DO_EXTENSION(RootExtension_3));
    tableEntry := sdv_210;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} tableEntry != 0;
    assume {:nonnull} tableEntry != 0;
    assume tableEntry > 0;
    call {:si_unique_call 723} InitializeListHead(LinkedTableEntries__TEMP_TRANSLATION_TABLE_ENTRY(tableEntry));
    goto L12;

  L12:
    Tmp_344 := tableEntry;
    return;

  anon3_Then:
    assume {:partition} tableEntry == 0;
    goto L12;
}



procedure {:origName "InitializeListHead"} InitializeListHead(actual_ListHead_2: int);
  modifies alloc;



implementation {:origName "InitializeListHead"} InitializeListHead(actual_ListHead_2: int)
{
  var {:pointer} ListHead_2: int;
  var vslice_dummy_var_156: int;

  anon0:
    call {:si_unique_call 724} vslice_dummy_var_156 := __HAVOC_malloc(4);
    ListHead_2 := actual_ListHead_2;
    assume {:nonnull} ListHead_2 != 0;
    assume ListHead_2 > 0;
    assume {:nonnull} ListHead_2 != 0;
    assume ListHead_2 > 0;
    return;
}



procedure {:origName "sdv_hash_802123720"} sdv_hash_802123720(actual_Extension_3: int);
  modifies alloc;



implementation {:origName "sdv_hash_802123720"} sdv_hash_802123720(actual_Extension_3: int)
{
  var {:scalar} irql_7: int;
  var vslice_dummy_var_157: int;

  anon0:
    call {:si_unique_call 725} vslice_dummy_var_157 := __HAVOC_malloc(4);
    call {:si_unique_call 726} irql_7 := KfAcquireSpinLock(0);
    call {:si_unique_call 727} KfReleaseSpinLock(0, irql_7);
    return;
}



procedure {:origName "sdv_hash_21074203"} sdv_hash_21074203(actual_RootExtension_4: int, actual_WorkItem_2: int, actual_QueueNumber: int);
  modifies alloc;



implementation {:origName "sdv_hash_21074203"} sdv_hash_21074203(actual_RootExtension_4: int, actual_WorkItem_2: int, actual_QueueNumber: int)
{
  var {:scalar} Tmp_350: int;
  var {:scalar} Tmp_351: int;
  var {:pointer} Tmp_352: int;
  var {:pointer} Tmp_353: int;
  var {:pointer} Tmp_355: int;
  var {:scalar} Tmp_356: int;
  var {:pointer} Tmp_359: int;
  var {:pointer} Tmp_360: int;
  var {:scalar} Tmp_361: int;
  var {:scalar} irql_8: int;
  var {:pointer} RootExtension_4: int;
  var {:pointer} WorkItem_2: int;
  var {:scalar} QueueNumber: int;
  var vslice_dummy_var_158: int;
  var vslice_dummy_var_159: int;

  anon0:
    call {:si_unique_call 728} vslice_dummy_var_158 := __HAVOC_malloc(4);
    RootExtension_4 := actual_RootExtension_4;
    WorkItem_2 := actual_WorkItem_2;
    QueueNumber := actual_QueueNumber;
    call {:si_unique_call 729} Tmp_353 := __HAVOC_malloc(72);
    call {:si_unique_call 730} Tmp_355 := __HAVOC_malloc(36);
    call {:si_unique_call 731} Tmp_359 := __HAVOC_malloc(1152);
    call {:si_unique_call 732} Tmp_360 := __HAVOC_malloc(36);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} QueueNumber < 9;
    Tmp_351 := QueueNumber;
    assume {:nonnull} RootExtension_4 != 0;
    assume RootExtension_4 > 0;
    havoc Tmp_360;
    call {:si_unique_call 733} irql_8 := KfAcquireSpinLock(0);
    Tmp_356 := QueueNumber;
    assume {:nonnull} RootExtension_4 != 0;
    assume RootExtension_4 > 0;
    havoc Tmp_353;
    Tmp_352 := Tmp_353 + Tmp_356 * 8;
    assume {:nonnull} WorkItem_2 != 0;
    assume WorkItem_2 > 0;
    call {:si_unique_call 734} InsertTailList(Tmp_352, List__WORK_QUEUE_ITEM(WorkItem_2));
    Tmp_350 := QueueNumber;
    assume {:nonnull} RootExtension_4 != 0;
    assume RootExtension_4 > 0;
    havoc Tmp_355;
    call {:si_unique_call 735} KfReleaseSpinLock(0, irql_8);
    Tmp_361 := QueueNumber;
    assume {:nonnull} RootExtension_4 != 0;
    assume RootExtension_4 > 0;
    havoc Tmp_359;
    call {:si_unique_call 736} vslice_dummy_var_159 := KeReleaseSemaphore(0, 0, 1, 0);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} 9 <= QueueNumber;
    goto L1;
}



procedure {:origName "sdv_hash_774522858"} sdv_hash_774522858(actual_Resource: int, actual_Filter_5: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26;



implementation {:origName "sdv_hash_774522858"} sdv_hash_774522858(actual_Resource: int, actual_Filter_5: int)
{
  var {:pointer} Resource: int;
  var {:pointer} Filter_5: int;
  var vslice_dummy_var_160: int;
  var vslice_dummy_var_161: int;

  anon0:
    call {:si_unique_call 737} vslice_dummy_var_160 := __HAVOC_malloc(4);
    Resource := actual_Resource;
    Filter_5 := actual_Filter_5;
    assume {:nonnull} Filter_5 != 0;
    assume Filter_5 > 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} Resource != 0;
    assume {:nonnull} Resource != 0;
    assume Resource > 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:nonnull} Resource != 0;
    assume Resource > 0;
    assume {:nonnull} Resource != 0;
    assume Resource > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(Resource)] := 0;
    assume {:nonnull} Resource != 0;
    assume Resource > 0;
    goto L8;

  L8:
    call {:si_unique_call 738} vslice_dummy_var_161 := KeReleaseSemaphore(0, 0, 1, 0);
    goto L1;

  L1:
    return;

  anon5_Then:
    goto L1;

  anon6_Then:
    assume {:partition} Resource == 0;
    goto L8;
}



procedure {:origName "sdv_hash_1035268778"} sdv_hash_1035268778(actual_Filter_6: int, actual_Irp_9: int) returns (Tmp_366: int);
  modifies alloc, ref, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_1035268778"} sdv_hash_1035268778(actual_Filter_6: int, actual_Irp_9: int) returns (Tmp_366: int)
{
  var {:scalar} i_2: int;
  var {:scalar} Tmp_367: int;
  var {:pointer} deviceRelations: int;
  var {:scalar} size: int;
  var {:scalar} sdv_218: int;
  var {:pointer} Tmp_368: int;
  var {:scalar} Tmp_369: int;
  var {:pointer} sdv_220: int;
  var {:pointer} sdv_222: int;
  var {:pointer} Tmp_371: int;
  var {:scalar} Tmp_372: int;
  var {:pointer} Tmp_373: int;
  var {:scalar} sdv_227: int;
  var {:pointer} newRelations: int;
  var {:scalar} numVolumes: int;
  var {:pointer} l_2: int;
  var {:pointer} Tmp_375: int;
  var {:scalar} status_11: int;
  var {:scalar} Tmp_376: int;
  var {:pointer} extension_1: int;
  var {:scalar} Tmp_377: int;
  var {:pointer} Tmp_379: int;
  var {:pointer} sdv_233: int;
  var {:pointer} Tmp_380: int;
  var {:pointer} Tmp_381: int;
  var {:pointer} Filter_6: int;
  var {:pointer} Irp_9: int;
  var vslice_dummy_var_162: int;
  var vslice_dummy_var_163: int;
  var vslice_dummy_var_164: int;

  anon0:
    Filter_6 := actual_Filter_6;
    Irp_9 := actual_Irp_9;
    call {:si_unique_call 739} Tmp_371 := __HAVOC_malloc(4);
    call {:si_unique_call 740} Tmp_379 := __HAVOC_malloc(4);
    call {:si_unique_call 741} Tmp_381 := __HAVOC_malloc(4);
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    numVolumes := 0;
    goto L17;

  L17:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    status_11 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_9))];
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} numVolumes != 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} status_11 >= 0;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    deviceRelations := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_9))];
    assume {:nonnull} deviceRelations != 0;
    assume deviceRelations > 0;
    havoc size;
    call {:si_unique_call 742} sdv_220 := ExAllocatePoolWithTag(1, size, -229413034);
    newRelations := sdv_220;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} newRelations != 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} 4 <= size;
    assume {:nonnull} deviceRelations != 0;
    assume deviceRelations > 0;
    assume {:nonnull} newRelations != 0;
    assume newRelations > 0;
    assume {:nonnull} deviceRelations != 0;
    assume deviceRelations > 0;
    havoc i_2;
    call {:si_unique_call 743} ExFreePoolWithTag(0, 0);
    goto L40;

  L40:
    numVolumes := 0;
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    havoc l_2;
    goto L42;

  L42:
    call {:si_unique_call 744} Tmp_367, Tmp_372, numVolumes, l_2, extension_1, Tmp_381, vslice_dummy_var_163 := sdv_hash_1035268778_loop_L42(i_2, Tmp_367, Tmp_372, newRelations, numVolumes, l_2, extension_1, Tmp_381, vslice_dummy_var_163);
    goto L42_last;

  L42_last:
    goto anon54_Then, anon54_Else;

  anon54_Else:
    extension_1 := l_2;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:nonnull} extension_1 != 0;
    assume extension_1 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:nonnull} extension_1 != 0;
    assume extension_1 > 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    goto L50;

  L50:
    assume {:nonnull} l_2 != 0;
    assume l_2 > 0;
    havoc l_2;
    goto L50_dummy;

  L50_dummy:
    assume false;
    return;

  anon57_Then:
    goto L46;

  L46:
    Tmp_372 := numVolumes;
    numVolumes := numVolumes + 1;
    Tmp_367 := i_2 + Tmp_372;
    assume {:nonnull} newRelations != 0;
    assume newRelations > 0;
    havoc Tmp_381;
    assume {:nonnull} Tmp_381 != 0;
    assume Tmp_381 > 0;
    assume {:nonnull} extension_1 != 0;
    assume extension_1 > 0;
    assume {:nonnull} extension_1 != 0;
    assume extension_1 > 0;
    call {:si_unique_call 745} vslice_dummy_var_163 := ObfReferenceObject(0);
    goto L50;

  anon56_Then:
    goto L46;

  anon67_Then:
    goto L46;

  anon54_Then:
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    havoc Tmp_375;
    assume {:nonnull} Tmp_375 != 0;
    assume Tmp_375 > 0;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    Tmp_369 := numVolumes;
    numVolumes := numVolumes + 1;
    Tmp_377 := i_2 + Tmp_369;
    assume {:nonnull} newRelations != 0;
    assume newRelations > 0;
    havoc Tmp_371;
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    havoc Tmp_380;
    assume {:nonnull} Tmp_371 != 0;
    assume Tmp_371 > 0;
    assume {:nonnull} Tmp_380 != 0;
    assume Tmp_380 > 0;
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    havoc Tmp_373;
    assume {:nonnull} Tmp_373 != 0;
    assume Tmp_373 > 0;
    call {:si_unique_call 746} vslice_dummy_var_164 := ObfReferenceObject(0);
    goto L54;

  L54:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_9))] := newRelations;
    goto L60;

  L60:
    call {:si_unique_call 747} sdv_227, l_2, extension_1 := sdv_hash_1035268778_loop_L60(sdv_227, l_2, extension_1, Filter_6);
    goto L60_last;

  L60_last:
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    call {:si_unique_call 758} sdv_227 := IsListEmpty(DeadVolumeList_FILTER_EXTENSION(Filter_6));
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} sdv_227 != 0;
    Tmp_366 := 0;
    goto L1;

  L1:
    return;

  anon58_Then:
    assume {:partition} sdv_227 == 0;
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    call {:si_unique_call 748} l_2 := RemoveHeadList(DeadVolumeList_FILTER_EXTENSION(Filter_6));
    extension_1 := l_2;
    goto anon58_Then_dummy;

  anon58_Then_dummy:
    assume false;
    return;

  anon68_Then:
    goto L54;

  anon55_Then:
    goto L54;

  anon53_Then:
    assume {:partition} size < 4;
    goto L29;

  L29:
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} newRelations != 0;
    call {:si_unique_call 749} ExFreePoolWithTag(0, 0);
    goto L73;

  L73:
    i_2 := 0;
    goto L77;

  L77:
    call {:si_unique_call 750} i_2, Tmp_376, Tmp_379, vslice_dummy_var_162 := sdv_hash_1035268778_loop_L77(i_2, deviceRelations, Tmp_376, Tmp_379, vslice_dummy_var_162);
    goto L77_last;

  L77_last:
    assume {:nonnull} deviceRelations != 0;
    assume deviceRelations > 0;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    Tmp_376 := i_2;
    assume {:nonnull} deviceRelations != 0;
    assume deviceRelations > 0;
    havoc Tmp_379;
    assume {:nonnull} Tmp_379 != 0;
    assume Tmp_379 > 0;
    call {:si_unique_call 751} vslice_dummy_var_162 := ObfDereferenceObject(0);
    i_2 := i_2 + 1;
    goto anon59_Else_dummy;

  anon59_Else_dummy:
    assume false;
    return;

  anon59_Then:
    call {:si_unique_call 752} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_9))] := 0;
    Tmp_366 := -1073741670;
    goto L1;

  anon52_Then:
    assume {:partition} newRelations == 0;
    goto L73;

  anon66_Then:
    assume {:partition} newRelations == 0;
    goto L29;

  anon51_Then:
    assume {:partition} 0 > status_11;
    size := 8 + numVolumes * 4;
    call {:si_unique_call 753} sdv_222 := ExAllocatePoolWithTag(1, size, -229413034);
    newRelations := sdv_222;
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} newRelations != 0;
    assume {:nonnull} newRelations != 0;
    assume newRelations > 0;
    i_2 := 0;
    goto L40;

  anon69_Then:
    assume {:partition} newRelations == 0;
    Tmp_366 := -1073741670;
    goto L1;

  anon65_Then:
    assume {:partition} numVolumes == 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} status_11 >= 0;
    Tmp_366 := status_11;
    goto L1;

  anon50_Then:
    assume {:partition} 0 > status_11;
    call {:si_unique_call 754} sdv_233 := ExAllocatePoolWithTag(1, 8, -229413034);
    newRelations := sdv_233;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} newRelations != 0;
    assume {:nonnull} newRelations != 0;
    assume newRelations > 0;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_9))] := newRelations;
    goto L108;

  L108:
    call {:si_unique_call 755} sdv_218, l_2, extension_1 := sdv_hash_1035268778_loop_L108(sdv_218, l_2, extension_1, Filter_6);
    goto L108_last;

  L108_last:
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    call {:si_unique_call 759} sdv_218 := IsListEmpty(DeadVolumeList_FILTER_EXTENSION(Filter_6));
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} sdv_218 != 0;
    Tmp_366 := 0;
    goto L1;

  anon60_Then:
    assume {:partition} sdv_218 == 0;
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    call {:si_unique_call 756} l_2 := RemoveHeadList(DeadVolumeList_FILTER_EXTENSION(Filter_6));
    extension_1 := l_2;
    goto anon60_Then_dummy;

  anon60_Then_dummy:
    assume false;
    return;

  anon70_Then:
    assume {:partition} newRelations == 0;
    Tmp_366 := -1073741670;
    goto L1;

  anon49_Then:
    numVolumes := 0;
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    havoc l_2;
    goto L122;

  L122:
    call {:si_unique_call 757} numVolumes, l_2, extension_1 := sdv_hash_1035268778_loop_L122(numVolumes, l_2, extension_1);
    goto L122_last;

  L122_last:
    goto anon61_Then, anon61_Else;

  anon61_Else:
    extension_1 := l_2;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    goto L133;

  L133:
    numVolumes := numVolumes + 1;
    goto L132;

  L132:
    assume {:nonnull} l_2 != 0;
    assume l_2 > 0;
    havoc l_2;
    goto L132_dummy;

  L132_dummy:
    assume false;
    return;

  anon71_Then:
    assume {:nonnull} extension_1 != 0;
    assume extension_1 > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    goto L133;

  anon63_Then:
    assume {:nonnull} extension_1 != 0;
    assume extension_1 > 0;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    goto L133;

  anon64_Then:
    goto L132;

  anon61_Then:
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:nonnull} Filter_6 != 0;
    assume Filter_6 > 0;
    havoc Tmp_368;
    assume {:nonnull} Tmp_368 != 0;
    assume Tmp_368 > 0;
    goto anon72_Then, anon72_Else;

  anon72_Else:
    numVolumes := numVolumes + 1;
    goto L17;

  anon72_Then:
    goto L17;

  anon62_Then:
    goto L17;
}



procedure {:origName "VolSnapUnload"} VolSnapUnload(actual_DriverObject_6: int);
  modifies alloc;



implementation {:origName "VolSnapUnload"} VolSnapUnload(actual_DriverObject_6: int)
{
  var vslice_dummy_var_165: int;

  anon0:
    call {:si_unique_call 760} vslice_dummy_var_165 := __HAVOC_malloc(4);
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    goto L8;

  L8:
    goto L1;

  L1:
    return;

  anon6_Then:
    goto L8;

  anon5_Then:
    goto L1;
}



procedure {:origName "sdv_hash_946681144"} sdv_hash_946681144(actual_Filter_7: int);
  modifies alloc;



implementation {:origName "sdv_hash_946681144"} sdv_hash_946681144(actual_Filter_7: int)
{
  var {:scalar} sdv_234: int;
  var {:pointer} Filter_7: int;
  var vslice_dummy_var_166: int;
  var vslice_dummy_var_167: int;

  anon0:
    call {:si_unique_call 761} vslice_dummy_var_166 := __HAVOC_malloc(4);
    Filter_7 := actual_Filter_7;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} sdv_234 == 0;
    assume {:nonnull} Filter_7 != 0;
    assume Filter_7 > 0;
    call {:si_unique_call 762} vslice_dummy_var_167 := KeSetEvent(DeviceRefCountZero_FILTER_EXTENSION(Filter_7), 0, 0);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} sdv_234 != 0;
    goto L1;
}



procedure {:origName "sdv_hash_601969222"} sdv_hash_601969222(actual_TimerDpc: int, actual_Context_5: int, actual_SystemArgument1: int, actual_SystemArgument2: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_601969222"} sdv_hash_601969222(actual_TimerDpc: int, actual_Context_5: int, actual_SystemArgument1: int, actual_SystemArgument2: int)
{
  var {:pointer} Tmp_388: int;
  var {:pointer} context_3: int;
  var {:pointer} filter_5: int;
  var {:scalar} sdv_241: int;
  var {:pointer} l_3: int;
  var {:pointer} Tmp_394: int;
  var {:scalar} irql_9: int;
  var {:pointer} Context_5: int;
  var vslice_dummy_var_168: int;
  var vslice_dummy_var_169: int;
  var vslice_dummy_var_170: int;
  var vslice_dummy_var_171: int;
  var vslice_dummy_var_1217: int;

  anon0:
    call {:si_unique_call 763} vslice_dummy_var_168 := __HAVOC_malloc(4);
    Context_5 := actual_Context_5;
    context_3 := Context_5;
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    havoc filter_5;
    assume {:nonnull} filter_5 != 0;
    assume filter_5 > 0;
    Tmp_394 := DEVICE_EXTENSION_FILTER_EXTENSION(filter_5);
    assume {:nonnull} Tmp_394 != 0;
    assume Tmp_394 > 0;
    call {:si_unique_call 764} irql_9 := KfAcquireSpinLock(0);
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    call {:si_unique_call 765} vslice_dummy_var_169 := RemoveEntryList(ListEntry_sdv_hash_118015372(PnpWaitTimer__VSP_CONTEXT(context_3)));
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    goto L18;

  L18:
    assume {:nonnull} filter_5 != 0;
    assume filter_5 > 0;
    Tmp_388 := DEVICE_EXTENSION_FILTER_EXTENSION(filter_5);
    assume {:nonnull} Tmp_388 != 0;
    assume Tmp_388 > 0;
    call {:si_unique_call 766} KfReleaseSpinLock(0, irql_9);
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    call {:si_unique_call 767} ExFreePoolWithTag(0, 0);
    call {:si_unique_call 768} irql_9 := KfAcquireSpinLock(0);
    assume {:nonnull} filter_5 != 0;
    assume filter_5 > 0;
    call {:si_unique_call 769} KfReleaseSpinLock(0, irql_9);
    assume {:nonnull} filter_5 != 0;
    assume filter_5 > 0;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    goto L1;

  L1:
    return;

  anon8_Then:
    call {:si_unique_call 770} irql_9 := KfAcquireSpinLock(0);
    goto L47;

  L47:
    call {:si_unique_call 771} sdv_241, l_3 := sdv_hash_601969222_loop_L47(filter_5, sdv_241, l_3);
    goto L47_last;

  L47_last:
    assume {:nonnull} filter_5 != 0;
    assume filter_5 > 0;
    call {:si_unique_call 779} sdv_241 := IsListEmpty(CopyOnWriteList_FILTER_EXTENSION(filter_5));
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} sdv_241 != 0;
    call {:si_unique_call 772} KfReleaseSpinLock(0, irql_9);
    assume {:nonnull} filter_5 != 0;
    assume filter_5 > 0;
    havoc vslice_dummy_var_1217;
    call {:si_unique_call 773} sdv_hash_493014447(vslice_dummy_var_1217, context_3);
    call {:si_unique_call 774} vslice_dummy_var_170 := ObfDereferenceObject(0);
    assume {:nonnull} filter_5 != 0;
    assume filter_5 > 0;
    call {:si_unique_call 775} vslice_dummy_var_171 := ObfDereferenceObject(0);
    goto L1;

  anon9_Then:
    assume {:partition} sdv_241 == 0;
    assume {:nonnull} filter_5 != 0;
    assume filter_5 > 0;
    call {:si_unique_call 776} l_3 := RemoveHeadList(CopyOnWriteList_FILTER_EXTENSION(filter_5));
    call {:si_unique_call 777} ExFreePoolWithTag(0, 0);
    call {:si_unique_call 778} ExFreePoolWithTag(0, 0);
    goto anon9_Then_dummy;

  anon9_Then_dummy:
    assume false;
    return;

  anon7_Then:
    goto L18;
}



procedure {:origName "KeInitializeSpinLock"} KeInitializeSpinLock(actual_SpinLock_2: int);
  modifies alloc;



implementation {:origName "KeInitializeSpinLock"} KeInitializeSpinLock(actual_SpinLock_2: int)
{
  var {:pointer} SpinLock_2: int;
  var vslice_dummy_var_172: int;

  anon0:
    call {:si_unique_call 780} vslice_dummy_var_172 := __HAVOC_malloc(4);
    SpinLock_2 := actual_SpinLock_2;
    assume {:nonnull} SpinLock_2 != 0;
    assume SpinLock_2 > 0;
    return;
}



procedure {:origName "ExFreeToNPagedLookasideList"} ExFreeToNPagedLookasideList(actual_Lookaside_2: int, actual_Entry_2: int);
  modifies alloc;



implementation {:origName "ExFreeToNPagedLookasideList"} ExFreeToNPagedLookasideList(actual_Lookaside_2: int, actual_Entry_2: int)
{
  var {:pointer} Tmp_397: int;
  var {:pointer} Lookaside_2: int;
  var vslice_dummy_var_173: int;
  var vslice_dummy_var_174: int;

  anon0:
    call {:si_unique_call 781} vslice_dummy_var_173 := __HAVOC_malloc(4);
    Lookaside_2 := actual_Lookaside_2;
    assume {:nonnull} Lookaside_2 != 0;
    assume Lookaside_2 > 0;
    assume {:nonnull} Lookaside_2 != 0;
    assume Lookaside_2 > 0;
    Tmp_397 := ListHead__GENERAL_LOOKASIDE(L__NPAGED_LOOKASIDE_LIST(Lookaside_2));
    assume {:nonnull} Lookaside_2 != 0;
    assume Lookaside_2 > 0;
    assume {:nonnull} Tmp_397 != 0;
    assume Tmp_397 > 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:nonnull} Lookaside_2 != 0;
    assume Lookaside_2 > 0;
    assume {:nonnull} Lookaside_2 != 0;
    assume Lookaside_2 > 0;
    goto L1;

  L1:
    return;

  anon6_Then:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto L1;

  anon5_Then:
    call {:si_unique_call 782} vslice_dummy_var_174 := __HAVOC_malloc(1);
    goto L1;
}



procedure {:origName "sdv_hash_317697039"} sdv_hash_317697039(actual_Filter_8: int) returns (Tmp_400: int);



implementation {:origName "sdv_hash_317697039"} sdv_hash_317697039(actual_Filter_8: int) returns (Tmp_400: int)
{
  var {:pointer} Tmp_402: int;
  var {:pointer} Filter_8: int;

  anon0:
    Filter_8 := actual_Filter_8;
    assume {:nonnull} Filter_8 != 0;
    assume Filter_8 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} Filter_8 != 0;
    assume Filter_8 > 0;
    havoc Tmp_402;
    goto L9;

  L9:
    Tmp_400 := Tmp_402;
    return;

  anon3_Then:
    Tmp_402 := 0;
    goto L9;
}



procedure {:origName "sdv_hash_1005542269"} sdv_hash_1005542269(actual_Filter_9: int, actual_TargetObject_1: int, actual_MajorFunction_1: int, actual_Offset_1: int, actual_Key_1: int, actual_FileObject_1: int, actual_IoReason: int) returns (Tmp_403: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_1005542269"} sdv_hash_1005542269(actual_Filter_9: int, actual_TargetObject_1: int, actual_MajorFunction_1: int, actual_Offset_1: int, actual_Key_1: int, actual_FileObject_1: int, actual_IoReason: int) returns (Tmp_403: int)
{
  var {:scalar} status_12: int;
  var {:pointer} Filter_9: int;
  var {:pointer} TargetObject_1: int;
  var {:scalar} MajorFunction_1: int;
  var {:scalar} Offset_1: int;
  var {:scalar} Key_1: int;
  var {:pointer} FileObject_1: int;
  var {:scalar} IoReason: int;
  var vslice_dummy_var_175: int;
  var vslice_dummy_var_176: int;
  var vslice_dummy_var_1218: int;

  anon0:
    Filter_9 := actual_Filter_9;
    TargetObject_1 := actual_TargetObject_1;
    MajorFunction_1 := actual_MajorFunction_1;
    Offset_1 := actual_Offset_1;
    Key_1 := actual_Key_1;
    FileObject_1 := actual_FileObject_1;
    IoReason := actual_IoReason;
    call {:si_unique_call 783} vslice_dummy_var_175 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} Filter_9 != 0;
    assume Filter_9 > 0;
    havoc vslice_dummy_var_1218;
    call {:si_unique_call 784} status_12 := VspSynchronousIo(vslice_dummy_var_1218, TargetObject_1, MajorFunction_1, Offset_1, 16384, Key_1, FileObject_1, 0, Filter_9, IoReason);
    call {:si_unique_call 785} vslice_dummy_var_176 := KeReleaseMutex(0, 0);
    Tmp_403 := status_12;
    return;
}



procedure {:origName "sdv_hash_986004649"} sdv_hash_986004649(actual_RootExtension_5: int);
  modifies alloc;



implementation {:origName "sdv_hash_986004649"} sdv_hash_986004649(actual_RootExtension_5: int)
{
  var vslice_dummy_var_177: int;
  var vslice_dummy_var_178: int;

  anon0:
    call {:si_unique_call 786} vslice_dummy_var_177 := __HAVOC_malloc(4);
    call {:si_unique_call 787} vslice_dummy_var_178 := KeReleaseSemaphore(0, 0, 1, 0);
    return;
}



procedure {:origName "sdv_hash_403736888"} sdv_hash_403736888(actual_Filter_10: int, actual_IoReason_1: int, actual_MajorFunction_2: int, actual_Offset_2: int, actual_Length_2: int, actual_StartTickCount: int, actual_Irp_10: int);
  modifies alloc;



implementation {:origName "sdv_hash_403736888"} sdv_hash_403736888(actual_Filter_10: int, actual_IoReason_1: int, actual_MajorFunction_2: int, actual_Offset_2: int, actual_Length_2: int, actual_StartTickCount: int, actual_Irp_10: int)
{
  var {:scalar} i_3: int;
  var {:pointer} Tmp_407: int;
  var {:pointer} Tmp_408: int;
  var {:scalar} tick: int;
  var {:pointer} Tmp_409: int;
  var {:pointer} Tmp_410: int;
  var {:scalar} skippedBytes: int;
  var {:pointer} Tmp_411: int;
  var {:pointer} Tmp_412: int;
  var {:pointer} Tmp_413: int;
  var {:pointer} Tmp_414: int;
  var {:pointer} s_p_e_c_i_a_l_2: int;
  var {:pointer} Tmp_415: int;
  var {:pointer} Tmp_416: int;
  var {:pointer} Tmp_417: int;
  var {:scalar} Tmp_419: int;
  var {:pointer} Tmp_420: int;
  var {:scalar} ioTicks: int;
  var {:pointer} Tmp_422: int;
  var {:scalar} Tmp_423: int;
  var {:scalar} Tmp_425: int;
  var {:scalar} totalTime: int;
  var {:scalar} Tmp_426: int;
  var {:scalar} readTime: int;
  var {:pointer} Tmp_427: int;
  var {:scalar} Tmp_428: int;
  var {:pointer} Tmp_429: int;
  var {:scalar} j: int;
  var {:scalar} Tmp_430: int;
  var {:pointer} Tmp_431: int;
  var {:pointer} Tmp_432: int;
  var {:scalar} Tmp_433: int;
  var {:pointer} Tmp_434: int;
  var {:pointer} Tmp_435: int;
  var {:pointer} Tmp_437: int;
  var {:pointer} Tmp_438: int;
  var {:scalar} sdv_250: int;
  var {:pointer} Tmp_440: int;
  var {:pointer} Tmp_441: int;
  var {:scalar} skippedTime: int;
  var {:scalar} sdv_251: int;
  var {:scalar} sdv_252: int;
  var {:scalar} Tmp_442: int;
  var {:pointer} Tmp_443: int;
  var {:pointer} Tmp_444: int;
  var {:pointer} Tmp_445: int;
  var {:scalar} Tmp_446: int;
  var {:scalar} readBytes: int;
  var {:pointer} Tmp_447: int;
  var {:pointer} Tmp_448: int;
  var {:pointer} Tmp_449: int;
  var {:pointer} Tmp_450: int;
  var {:pointer} Tmp_451: int;
  var {:scalar} volsnapTime: int;
  var {:scalar} Tmp_452: int;
  var {:pointer} Tmp_453: int;
  var {:pointer} Tmp_454: int;
  var {:scalar} irql_10: int;
  var {:pointer} Tmp_455: int;
  var {:pointer} Tmp_456: int;
  var {:pointer} Tmp_457: int;
  var {:scalar} Tmp_458: int;
  var {:pointer} Tmp_459: int;
  var {:scalar} Tmp_461: int;
  var {:pointer} Tmp_462: int;
  var {:scalar} Tmp_463: int;
  var {:pointer} Filter_10: int;
  var {:scalar} IoReason_1: int;
  var {:scalar} MajorFunction_2: int;
  var {:scalar} Offset_2: int;
  var {:scalar} Length_2: int;
  var {:scalar} StartTickCount: int;
  var {:pointer} Irp_10: int;
  var vslice_dummy_var_179: int;
  var vslice_dummy_var_180: int;
  var vslice_dummy_var_181: int;

  anon0:
    call {:si_unique_call 788} tick := __HAVOC_malloc(20);
    call {:si_unique_call 789} vslice_dummy_var_179 := __HAVOC_malloc(4);
    Filter_10 := actual_Filter_10;
    IoReason_1 := actual_IoReason_1;
    MajorFunction_2 := actual_MajorFunction_2;
    Offset_2 := actual_Offset_2;
    Length_2 := actual_Length_2;
    StartTickCount := actual_StartTickCount;
    Irp_10 := actual_Irp_10;
    call {:si_unique_call 790} Tmp_407 := __HAVOC_malloc(100);
    call {:si_unique_call 791} Tmp_408 := __HAVOC_malloc(40);
    call {:si_unique_call 792} Tmp_409 := __HAVOC_malloc(200);
    call {:si_unique_call 793} Tmp_410 := __HAVOC_malloc(100);
    call {:si_unique_call 794} Tmp_411 := __HAVOC_malloc(100);
    call {:si_unique_call 795} Tmp_412 := __HAVOC_malloc(100);
    call {:si_unique_call 796} Tmp_413 := __HAVOC_malloc(100);
    call {:si_unique_call 797} Tmp_414 := __HAVOC_malloc(100);
    call {:si_unique_call 798} Tmp_415 := __HAVOC_malloc(100);
    call {:si_unique_call 799} Tmp_416 := __HAVOC_malloc(100);
    call {:si_unique_call 800} Tmp_417 := __HAVOC_malloc(200);
    call {:si_unique_call 801} Tmp_420 := __HAVOC_malloc(100);
    call {:si_unique_call 802} vslice_dummy_var_180 := __HAVOC_malloc(200);
    call {:si_unique_call 803} Tmp_422 := __HAVOC_malloc(200);
    call {:si_unique_call 804} Tmp_427 := __HAVOC_malloc(100);
    call {:si_unique_call 805} Tmp_429 := __HAVOC_malloc(40);
    call {:si_unique_call 806} Tmp_431 := __HAVOC_malloc(100);
    call {:si_unique_call 807} Tmp_432 := __HAVOC_malloc(100);
    call {:si_unique_call 808} Tmp_434 := __HAVOC_malloc(100);
    call {:si_unique_call 809} Tmp_435 := __HAVOC_malloc(100);
    call {:si_unique_call 810} Tmp_437 := __HAVOC_malloc(200);
    call {:si_unique_call 811} Tmp_440 := __HAVOC_malloc(100);
    call {:si_unique_call 812} Tmp_441 := __HAVOC_malloc(200);
    call {:si_unique_call 813} Tmp_443 := __HAVOC_malloc(100);
    call {:si_unique_call 814} Tmp_444 := __HAVOC_malloc(200);
    call {:si_unique_call 815} Tmp_445 := __HAVOC_malloc(100);
    call {:si_unique_call 816} Tmp_447 := __HAVOC_malloc(200);
    call {:si_unique_call 817} Tmp_448 := __HAVOC_malloc(200);
    call {:si_unique_call 818} Tmp_449 := __HAVOC_malloc(100);
    call {:si_unique_call 819} Tmp_450 := __HAVOC_malloc(200);
    call {:si_unique_call 820} Tmp_451 := __HAVOC_malloc(100);
    call {:si_unique_call 821} Tmp_453 := __HAVOC_malloc(200);
    call {:si_unique_call 822} Tmp_454 := __HAVOC_malloc(100);
    call {:si_unique_call 823} Tmp_455 := __HAVOC_malloc(100);
    call {:si_unique_call 824} Tmp_456 := __HAVOC_malloc(100);
    call {:si_unique_call 825} Tmp_457 := __HAVOC_malloc(200);
    call {:si_unique_call 826} Tmp_459 := __HAVOC_malloc(100);
    call {:si_unique_call 827} vslice_dummy_var_181 := __HAVOC_malloc(40);
    call {:si_unique_call 828} Tmp_462 := __HAVOC_malloc(100);
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} Filter_10 != 0;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} Length_2 != 0;
    totalTime := 0;
    call {:si_unique_call 829} irql_10 := KfAcquireSpinLock(0);
    Tmp_438 := KeTickCount;
    assume {:nonnull} Tmp_438 != 0;
    assume Tmp_438 > 0;
    havoc s_p_e_c_i_a_l_2;
    goto L26;

  L26:
    call {:si_unique_call 830} sdv_hash_403736888_loop_L26(tick, s_p_e_c_i_a_l_2);
    goto L26_last;

  L26_last:
    assume {:nonnull} s_p_e_c_i_a_l_2 != 0;
    assume s_p_e_c_i_a_l_2 > 0;
    assume {:nonnull} tick != 0;
    assume tick > 0;
    assume {:nonnull} s_p_e_c_i_a_l_2 != 0;
    assume s_p_e_c_i_a_l_2 > 0;
    assume {:nonnull} tick != 0;
    assume tick > 0;
    assume {:nonnull} s_p_e_c_i_a_l_2 != 0;
    assume s_p_e_c_i_a_l_2 > 0;
    assume {:nonnull} tick != 0;
    assume tick > 0;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    call {:si_unique_call 831} sdv_250 := corral_nondet();
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    assume {:nonnull} tick != 0;
    assume tick > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_412;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_449;
    assume {:nonnull} Tmp_412 != 0;
    assume Tmp_412 > 0;
    assume {:nonnull} Tmp_449 != 0;
    assume Tmp_449 > 0;
    havoc readTime;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_417;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    assume {:nonnull} Tmp_417 != 0;
    assume Tmp_417 > 0;
    havoc readBytes;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_422;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    assume {:nonnull} Tmp_422 != 0;
    assume Tmp_422 > 0;
    havoc skippedBytes;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} readBytes > skippedBytes;
    skippedTime := INTDIV(INTDIV(100 * skippedBytes, readBytes) * readTime, 100);
    goto L44;

  L44:
    readTime := readTime - skippedTime;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_407;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_411;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_431;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_462;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_456;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_434;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_415;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_459;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_451;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_445;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_427;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_432;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_413;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_410;
    assume {:nonnull} Tmp_407 != 0;
    assume Tmp_407 > 0;
    assume {:nonnull} Tmp_410 != 0;
    assume Tmp_410 > 0;
    assume {:nonnull} Tmp_411 != 0;
    assume Tmp_411 > 0;
    assume {:nonnull} Tmp_413 != 0;
    assume Tmp_413 > 0;
    assume {:nonnull} Tmp_415 != 0;
    assume Tmp_415 > 0;
    assume {:nonnull} Tmp_427 != 0;
    assume Tmp_427 > 0;
    assume {:nonnull} Tmp_431 != 0;
    assume Tmp_431 > 0;
    assume {:nonnull} Tmp_432 != 0;
    assume Tmp_432 > 0;
    assume {:nonnull} Tmp_434 != 0;
    assume Tmp_434 > 0;
    assume {:nonnull} Tmp_445 != 0;
    assume Tmp_445 > 0;
    assume {:nonnull} Tmp_451 != 0;
    assume Tmp_451 > 0;
    assume {:nonnull} Tmp_456 != 0;
    assume Tmp_456 > 0;
    assume {:nonnull} Tmp_459 != 0;
    assume Tmp_459 > 0;
    assume {:nonnull} Tmp_462 != 0;
    assume Tmp_462 > 0;
    havoc volsnapTime;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_435;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_414;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_443;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_416;
    assume {:nonnull} Tmp_414 != 0;
    assume Tmp_414 > 0;
    assume {:nonnull} Tmp_416 != 0;
    assume Tmp_416 > 0;
    assume {:nonnull} Tmp_435 != 0;
    assume Tmp_435 > 0;
    assume {:nonnull} Tmp_443 != 0;
    assume Tmp_443 > 0;
    havoc totalTime;
    i_3 := 0;
    goto L48;

  L48:
    call {:si_unique_call 832} i_3, Tmp_442, Tmp_454, Tmp_455, Tmp_463 := sdv_hash_403736888_loop_L48(i_3, Tmp_442, Tmp_454, Tmp_455, Tmp_463, Filter_10);
    goto L48_last;

  L48_last:
    assume {:CounterLoop 25} {:Counter "i_3"} true;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} 25 > i_3;
    Tmp_442 := i_3;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_454;
    Tmp_463 := i_3;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_455;
    assume {:nonnull} Tmp_454 != 0;
    assume Tmp_454 > 0;
    assume {:nonnull} Tmp_455 != 0;
    assume Tmp_455 > 0;
    i_3 := i_3 + 1;
    goto anon52_Else_dummy;

  anon52_Else_dummy:
    assume false;
    return;

  anon52_Then:
    assume {:partition} i_3 >= 25;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_453;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    assume {:nonnull} Tmp_453 != 0;
    assume Tmp_453 > 0;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_437;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    assume {:nonnull} Tmp_437 != 0;
    assume Tmp_437 > 0;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    assume {:nonnull} tick != 0;
    assume tick > 0;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} totalTime != 0;
    i_3 := INTDIV(totalTime * 5, 100000000);
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} i_3 >= 5;
    i_3 := 4;
    goto L57;

  L57:
    j := INTDIV(volsnapTime * 10, totalTime);
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} j >= 10;
    j := 9;
    goto L60;

  L60:
    Tmp_446 := j;
    Tmp_458 := i_3;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_447;
    assume {:nonnull} Tmp_447 != 0;
    assume Tmp_447 > 0;
    havoc Tmp_408;
    Tmp_423 := j;
    Tmp_425 := i_3;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_448;
    assume {:nonnull} Tmp_448 != 0;
    assume Tmp_448 > 0;
    havoc Tmp_429;
    Tmp_428 := i_3;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_450;
    assume {:nonnull} Tmp_450 != 0;
    assume Tmp_450 > 0;
    assume {:nonnull} Tmp_408 != 0;
    assume Tmp_408 > 0;
    assume {:nonnull} Tmp_429 != 0;
    assume Tmp_429 > 0;
    goto L37;

  L37:
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} MajorFunction_2 == 4;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    goto L64;

  L64:
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    goto L66;

  L66:
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} StartTickCount != 0;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:nonnull} tick != 0;
    assume tick > 0;
    havoc ioTicks;
    goto L71;

  L71:
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    assume {:nonnull} tick != 0;
    assume tick > 0;
    goto L72;

  L72:
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} 25 > IoReason_1;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} Irp_10 != 0;
    call {:si_unique_call 833} sdv_251 := corral_nondet();
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} 2 > sdv_251;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} IoReason_1 != 0;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} IoReason_1 != 6;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} IoReason_1 != 7;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} IoReason_1 != 8;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} IoReason_1 == 22;
    goto L84;

  L84:
    IoReason_1 := 23;
    goto L77;

  L77:
    Tmp_433 := IoReason_1;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_457;
    Tmp_419 := IoReason_1;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_444;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    assume {:nonnull} Tmp_444 != 0;
    assume Tmp_444 > 0;
    assume {:nonnull} Tmp_457 != 0;
    assume Tmp_457 > 0;
    Tmp_426 := IoReason_1;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_409;
    Tmp_452 := IoReason_1;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_441;
    assume {:nonnull} Tmp_409 != 0;
    assume Tmp_409 > 0;
    assume {:nonnull} Tmp_441 != 0;
    assume Tmp_441 > 0;
    call {:si_unique_call 834} sdv_252 := corral_nondet();
    Tmp_461 := IoReason_1;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_420;
    Tmp_430 := IoReason_1;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    havoc Tmp_440;
    assume {:nonnull} Tmp_420 != 0;
    assume Tmp_420 > 0;
    assume {:nonnull} Tmp_440 != 0;
    assume Tmp_440 > 0;
    goto L73;

  L73:
    call {:si_unique_call 835} KfReleaseSpinLock(0, irql_10);
    goto L1;

  L1:
    return;

  anon61_Then:
    assume {:partition} IoReason_1 != 22;
    goto L77;

  anon62_Then:
    assume {:partition} IoReason_1 == 8;
    goto L84;

  anon63_Then:
    assume {:partition} IoReason_1 == 7;
    goto L84;

  anon64_Then:
    assume {:partition} IoReason_1 == 6;
    goto L84;

  anon60_Then:
    assume {:partition} IoReason_1 == 0;
    goto L84;

  anon59_Then:
    assume {:partition} sdv_251 >= 2;
    goto L77;

  anon58_Then:
    assume {:partition} Irp_10 == 0;
    goto L77;

  anon57_Then:
    assume {:partition} IoReason_1 >= 25;
    goto L73;

  anon56_Then:
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    assume {:nonnull} tick != 0;
    assume tick > 0;
    havoc ioTicks;
    goto L71;

  anon55_Then:
    assume {:partition} StartTickCount == 0;
    ioTicks := 0;
    goto L72;

  anon54_Then:
    goto L64;

  anon51_Then:
    assume {:partition} MajorFunction_2 != 4;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} MajorFunction_2 != 0;
    assume {:nonnull} Filter_10 != 0;
    assume Filter_10 > 0;
    goto L66;

  anon53_Then:
    assume {:partition} MajorFunction_2 == 0;
    goto L66;

  anon69_Then:
    assume {:partition} 10 > j;
    goto L60;

  anon68_Then:
    assume {:partition} 5 > i_3;
    goto L57;

  anon67_Then:
    assume {:partition} totalTime == 0;
    goto L37;

  anon66_Then:
    assume {:partition} skippedBytes >= readBytes;
    skippedTime := readTime;
    goto L44;

  anon50_Then:
    goto L37;

  anon65_Then:
    goto anon65_Then_dummy;

  anon65_Then_dummy:
    assume false;
    return;

  anon49_Then:
    assume {:partition} Length_2 == 0;
    goto L1;

  anon48_Then:
    goto L1;

  anon47_Then:
    assume {:partition} Filter_10 == 0;
    goto L1;
}



procedure {:origName "sdv_hash_224765598"} sdv_hash_224765598(actual_Extension_4: int);
  modifies alloc;



implementation {:origName "sdv_hash_224765598"} sdv_hash_224765598(actual_Extension_4: int)
{
  var {:scalar} sdv_253: int;
  var {:pointer} Extension_4: int;
  var vslice_dummy_var_182: int;
  var vslice_dummy_var_183: int;

  anon0:
    call {:si_unique_call 836} vslice_dummy_var_182 := __HAVOC_malloc(4);
    Extension_4 := actual_Extension_4;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} sdv_253 == 0;
    assume {:nonnull} Extension_4 != 0;
    assume Extension_4 > 0;
    call {:si_unique_call 837} vslice_dummy_var_183 := KeSetEvent(ZeroRefEvent_VOLUME_EXTENSION(Extension_4), 0, 0);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} sdv_253 != 0;
    goto L1;
}



procedure {:origName "sdv_hash_257967338"} sdv_hash_257967338(actual_Filter_11: int) returns (Tmp_466: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_257967338"} sdv_hash_257967338(actual_Filter_11: int) returns (Tmp_466: int)
{
  var {:pointer} irp_3: int;
  var {:scalar} ioStatus_1: int;
  var {:scalar} status_13: int;
  var {:scalar} event_2: int;
  var {:scalar} lengthInfo: int;
  var {:pointer} Filter_11: int;
  var vslice_dummy_var_184: int;

  anon0:
    call {:si_unique_call 838} ioStatus_1 := __HAVOC_malloc(12);
    call {:si_unique_call 839} event_2 := __HAVOC_malloc(124);
    call {:si_unique_call 840} lengthInfo := __HAVOC_malloc(20);
    Filter_11 := actual_Filter_11;
    assume {:nonnull} Filter_11 != 0;
    assume Filter_11 > 0;
    call {:si_unique_call 841} KeInitializeEvent(event_2, 0, 0);
    call {:si_unique_call 842} irp_3 := IoBuildDeviceIoControlRequest(475228, 0, 0, 0, 0, 8, 0, 0, ioStatus_1);
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} irp_3 != 0;
    call {:si_unique_call 843} status_13 := IofCallDriver(0, irp_3);
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} status_13 == 259;
    call {:si_unique_call 844} vslice_dummy_var_184 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_1 != 0;
    assume ioStatus_1 > 0;
    status_13 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(ioStatus_1)];
    goto L27;

  L27:
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} status_13 >= 0;
    assume {:nonnull} lengthInfo != 0;
    assume lengthInfo > 0;
    havoc Tmp_466;
    goto L1;

  L1:
    return;

  anon9_Then:
    assume {:partition} 0 > status_13;
    Tmp_466 := 0;
    goto L1;

  anon8_Then:
    assume {:partition} status_13 != 259;
    goto L27;

  anon7_Then:
    assume {:partition} irp_3 == 0;
    Tmp_466 := 0;
    goto L1;
}



procedure {:origName "sdv_hash_853253100"} sdv_hash_853253100(actual_Extension_5: int);
  modifies alloc;



implementation {:origName "sdv_hash_853253100"} sdv_hash_853253100(actual_Extension_5: int)
{
  var {:pointer} workItem: int;
  var {:pointer} context_4: int;
  var {:scalar} sdv_260: int;
  var {:scalar} sdv_261: int;
  var {:pointer} filter_6: int;
  var {:pointer} parameter: int;
  var {:scalar} sdv_263: int;
  var {:pointer} l_4: int;
  var {:scalar} routine: int;
  var {:scalar} q_1: int;
  var {:scalar} sdv_265: int;
  var {:scalar} irql_11: int;
  var {:pointer} e: int;
  var {:pointer} Extension_5: int;
  var vslice_dummy_var_185: int;
  var vslice_dummy_var_1219: int;
  var vslice_dummy_var_1220: int;

  anon0:
    call {:si_unique_call 845} vslice_dummy_var_185 := __HAVOC_malloc(4);
    call {:si_unique_call 846} q_1 := __HAVOC_malloc(8);
    Extension_5 := actual_Extension_5;
    assume {:nonnull} Extension_5 != 0;
    assume Extension_5 > 0;
    havoc filter_6;
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    goto L17;

  L17:
    call {:si_unique_call 847} workItem, context_4, sdv_261, sdv_263, l_4, irql_11, e := sdv_hash_853253100_loop_L17(workItem, context_4, sdv_261, filter_6, sdv_263, l_4, q_1, irql_11, e);
    goto L17_last;

  L17_last:
    call {:si_unique_call 863} irql_11 := KfAcquireSpinLock(0);
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    call {:si_unique_call 864} sdv_261 := IsListEmpty(PagedResourceList_FILTER_EXTENSION(filter_6));
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} sdv_261 != 0;
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    call {:si_unique_call 848} KfReleaseSpinLock(0, irql_11);
    goto L1;

  L1:
    return;

  anon31_Then:
    assume {:partition} sdv_261 == 0;
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    assume {:nonnull} q_1 != 0;
    assume q_1 > 0;
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    assume {:nonnull} q_1 != 0;
    assume q_1 > 0;
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    call {:si_unique_call 849} InitializeListHead(PagedResourceList_FILTER_EXTENSION(filter_6));
    call {:si_unique_call 850} KfReleaseSpinLock(0, irql_11);
    assume {:nonnull} q_1 != 0;
    assume q_1 > 0;
    assume {:nonnull} q_1 != 0;
    assume q_1 > 0;
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    goto L47;

  L47:
    call {:si_unique_call 851} workItem, context_4, sdv_263, l_4, e := sdv_hash_853253100_loop_L47(workItem, context_4, sdv_263, l_4, q_1, e);
    goto L47_last;

  L47_last:
    call {:si_unique_call 862} l_4 := RemoveHeadList(q_1);
    workItem := l_4;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    havoc context_4;
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    havoc e;
    assume {:nonnull} e != 0;
    assume e > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    goto L67;

  L67:
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} workItem != 0;
    call {:si_unique_call 852} irql_11 := KfAcquireSpinLock(0);
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    call {:si_unique_call 853} sdv_hash_515123808(PagedResourceList_FILTER_EXTENSION(filter_6), q_1, 1);
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    goto L78;

  L78:
    call {:si_unique_call 854} KfReleaseSpinLock(0, irql_11);
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto L1;

  anon36_Then:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    call {:si_unique_call 855} sdv_265 := sdv_hash_672018212(Extension_5, 1);
    assume {:nonnull} Extension_5 != 0;
    assume Extension_5 > 0;
    havoc vslice_dummy_var_1219;
    call {:si_unique_call 856} sdv_hash_21074203(vslice_dummy_var_1219, workItem, sdv_265);
    goto L1;

  anon37_Then:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    havoc routine;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    havoc parameter;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto L1;

  anon35_Then:
    goto L78;

  anon44_Then:
    assume {:partition} workItem == 0;
    goto anon44_Then_dummy;

  anon44_Then_dummy:
    assume false;
    return;

  anon43_Then:
    goto L58;

  L58:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    call {:si_unique_call 857} sdv_263 := IsListEmpty(q_1);
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} sdv_263 != 0;
    workItem := 0;
    goto L67;

  anon34_Then:
    assume {:partition} sdv_263 == 0;
    goto anon34_Then_dummy;

  anon34_Then_dummy:
    assume false;
    return;

  anon42_Then:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto anon38_Then, anon38_Else;

  anon38_Else:
    goto L67;

  anon38_Then:
    goto L58;

  anon33_Then:
    goto L58;

  anon32_Then:
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    call {:si_unique_call 858} l_4 := RemoveHeadList(PagedResourceList_FILTER_EXTENSION(filter_6));
    workItem := l_4;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:nonnull} filter_6 != 0;
    assume filter_6 > 0;
    goto L106;

  L106:
    call {:si_unique_call 859} KfReleaseSpinLock(0, irql_11);
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto L1;

  anon39_Then:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    call {:si_unique_call 860} sdv_260 := sdv_hash_672018212(Extension_5, 1);
    assume {:nonnull} Extension_5 != 0;
    assume Extension_5 > 0;
    havoc vslice_dummy_var_1220;
    call {:si_unique_call 861} sdv_hash_21074203(vslice_dummy_var_1220, workItem, sdv_260);
    goto L1;

  anon40_Then:
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    havoc routine;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    havoc parameter;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    assume {:nonnull} workItem != 0;
    assume workItem > 0;
    goto L1;

  anon45_Then:
    goto L106;

  anon41_Then:
    goto L1;
}



procedure {:origName "sdv_hash_301435450"} sdv_hash_301435450(actual_Extension_6: int) returns (Tmp_470: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, ref, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_301435450"} sdv_hash_301435450(actual_Extension_6: int) returns (Tmp_470: int)
{
  var {:pointer} diffAreaFile: int;
  var {:scalar} status_14: int;
  var {:pointer} Extension_6: int;
  var vslice_dummy_var_1221: int;
  var vslice_dummy_var_1222: int;
  var vslice_dummy_var_1223: int;
  var vslice_dummy_var_1224: int;
  var vslice_dummy_var_1225: int;
  var vslice_dummy_var_1226: int;

  anon0:
    Extension_6 := actual_Extension_6;
    assume {:nonnull} Extension_6 != 0;
    assume Extension_6 > 0;
    havoc vslice_dummy_var_1221;
    call {:si_unique_call 865} status_14 := sdv_hash_84974865(vslice_dummy_var_1221);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} status_14 >= 0;
    assume {:nonnull} Extension_6 != 0;
    assume Extension_6 > 0;
    havoc vslice_dummy_var_1222;
    call {:si_unique_call 866} status_14 := sdv_hash_1005562481(vslice_dummy_var_1222, SnapshotGuid_VOLUME_EXTENSION(Extension_6), 0, 0);
    assume {:nonnull} Extension_6 != 0;
    assume Extension_6 > 0;
    havoc vslice_dummy_var_1223;
    call {:si_unique_call 867} sdv_hash_946681144(vslice_dummy_var_1223);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} status_14 >= 0;
    assume {:nonnull} Extension_6 != 0;
    assume Extension_6 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:nonnull} Extension_6 != 0;
    assume Extension_6 > 0;
    havoc diffAreaFile;
    assume {:nonnull} diffAreaFile != 0;
    assume diffAreaFile > 0;
    havoc vslice_dummy_var_1224;
    call {:si_unique_call 868} status_14 := sdv_hash_84974865(vslice_dummy_var_1224);
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} status_14 >= 0;
    assume {:nonnull} Extension_6 != 0;
    assume Extension_6 > 0;
    assume {:nonnull} diffAreaFile != 0;
    assume diffAreaFile > 0;
    havoc vslice_dummy_var_1225;
    call {:si_unique_call 869} status_14 := sdv_hash_1005562481(vslice_dummy_var_1225, SnapshotGuid_VOLUME_EXTENSION(Extension_6), 0, 0);
    assume {:nonnull} diffAreaFile != 0;
    assume diffAreaFile > 0;
    havoc vslice_dummy_var_1226;
    call {:si_unique_call 870} sdv_hash_946681144(vslice_dummy_var_1226);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} status_14 < 0;
    Tmp_470 := status_14;
    goto L1;

  L1:
    return;

  anon15_Then:
    assume {:partition} 0 <= status_14;
    goto L25;

  L25:
    Tmp_470 := 0;
    goto L1;

  anon14_Then:
    assume {:partition} 0 > status_14;
    Tmp_470 := status_14;
    goto L1;

  anon13_Then:
    goto L25;

  anon12_Then:
    assume {:partition} 0 > status_14;
    Tmp_470 := status_14;
    goto L1;

  anon11_Then:
    assume {:partition} 0 > status_14;
    Tmp_470 := status_14;
    goto L1;
}



procedure {:origName "sdv_hash_24220996"} sdv_hash_24220996(actual_Filter_12: int);
  modifies alloc, ref, Mem_T.Type_unnamed_tag_26;



implementation {:origName "sdv_hash_24220996"} sdv_hash_24220996(actual_Filter_12: int)
{
  var {:pointer} context_5: int;
  var {:pointer} buffer_1: int;
  var {:scalar} sdv_276: int;
  var {:scalar} irql_12: int;
  var {:pointer} Filter_12: int;
  var vslice_dummy_var_186: int;
  var vslice_dummy_var_187: int;
  var vslice_dummy_var_188: int;
  var vslice_dummy_var_189: int;
  var vslice_dummy_var_190: int;
  var vslice_dummy_var_191: int;
  var vslice_dummy_var_1227: int;

  anon0:
    call {:si_unique_call 871} vslice_dummy_var_186 := __HAVOC_malloc(4);
    Filter_12 := actual_Filter_12;
    assume {:nonnull} Filter_12 != 0;
    assume Filter_12 > 0;
    havoc vslice_dummy_var_1227;
    call {:si_unique_call 872} context_5 := sdv_hash_859757058(vslice_dummy_var_1227);
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} context_5 != 0;
    assume {:nonnull} Filter_12 != 0;
    assume Filter_12 > 0;
    call {:si_unique_call 873} vslice_dummy_var_189 := ObfReferenceObject(0);
    assume {:nonnull} context_5 != 0;
    assume context_5 > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(context_5)] := 5;
    assume {:nonnull} context_5 != 0;
    assume context_5 > 0;
    assume {:nonnull} context_5 != 0;
    assume context_5 > 0;
    assume {:nonnull} context_5 != 0;
    assume context_5 > 0;
    assume {:nonnull} context_5 != 0;
    assume context_5 > 0;
    assume {:nonnull} Filter_12 != 0;
    assume Filter_12 > 0;
    call {:si_unique_call 874} vslice_dummy_var_190 := ObfReferenceObject(0);
    call {:si_unique_call 875} vslice_dummy_var_187 := ObfReferenceObject(0);
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} sdv_276 != 0;
    goto L36;

  L36:
    call {:si_unique_call 876} irql_12 := KfAcquireSpinLock(0);
    assume {:nonnull} Filter_12 != 0;
    assume Filter_12 > 0;
    havoc buffer_1;
    assume {:nonnull} Filter_12 != 0;
    assume Filter_12 > 0;
    assume {:nonnull} Filter_12 != 0;
    assume Filter_12 > 0;
    assume {:nonnull} Filter_12 != 0;
    assume Filter_12 > 0;
    call {:si_unique_call 877} KfReleaseSpinLock(0, irql_12);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} buffer_1 != 0;
    call {:si_unique_call 878} ExFreePoolWithTag(0, 0);
    goto L48;

  L48:
    assume {:nonnull} Filter_12 != 0;
    assume Filter_12 > 0;
    call {:si_unique_call 879} vslice_dummy_var_191 := ObfDereferenceObject(0);
    goto L1;

  L1:
    return;

  anon9_Then:
    assume {:partition} buffer_1 == 0;
    goto L48;

  anon8_Then:
    assume {:partition} sdv_276 == 0;
    call {:si_unique_call 880} sdv_hash_946681144(Filter_12);
    call {:si_unique_call 881} vslice_dummy_var_188 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto L36;

  anon7_Then:
    assume {:partition} context_5 == 0;
    goto L1;
}



procedure {:origName "_sdv_init1"} _sdv_init1();
  modifies alloc;



implementation {:origName "_sdv_init1"} _sdv_init1()
{
  var vslice_dummy_var_192: int;

  anon0:
    call {:si_unique_call 882} vslice_dummy_var_192 := __HAVOC_malloc(4);
    assume DATAID_VSP_PRI_VIOLATION_COUNT == 6377;
    return;
}



procedure {:origName "sdv_hash_1005562481"} sdv_hash_1005562481(actual_Filter_13: int, actual_SnapshotGuid: int, actual_NonPagedResourceHeld: int, actual_ControlFileHandle: int) returns (Tmp_479: int);
  modifies Mem_T.Type_unnamed_tag_26, ref, alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_1005562481"} sdv_hash_1005562481(actual_Filter_13: int, actual_SnapshotGuid: int, actual_NonPagedResourceHeld: int, actual_ControlFileHandle: int) returns (Tmp_479: int)
{
  var {:pointer} controlItem: int;
  var {:scalar} sdv_280: int;
  var {:pointer} sdv_281: int;
  var {:pointer} context_6: int;
  var {:pointer} controlBlock: int;
  var {:scalar} needWrite: int;
  var {:scalar} sdv_282: int;
  var {:pointer} sdv_283: int;
  var {:scalar} byteOffset: int;
  var {:scalar} sdv_288: int;
  var {:scalar} sdv_292: int;
  var {:pointer} hh: int;
  var {:scalar} sdv_294: int;
  var {:scalar} status_15: int;
  var {:scalar} itemsLeft: int;
  var {:scalar} offset: int;
  var {:pointer} Tmp_482: int;
  var {:pointer} h_2: int;
  var {:pointer} Tmp_483: int;
  var {:pointer} Filter_13: int;
  var {:pointer} SnapshotGuid: int;
  var {:scalar} NonPagedResourceHeld: int;
  var {:pointer} ControlFileHandle: int;
  var vslice_dummy_var_193: int;
  var vslice_dummy_var_194: int;
  var vslice_dummy_var_195: int;
  var vslice_dummy_var_196: int;
  var vslice_dummy_var_197: int;
  var vslice_dummy_var_198: int;
  var vslice_dummy_var_1228: int;
  var vslice_dummy_var_1229: int;
  var vslice_dummy_var_1230: int;
  var vslice_dummy_var_1231: int;

  anon0:
    Filter_13 := actual_Filter_13;
    SnapshotGuid := actual_SnapshotGuid;
    NonPagedResourceHeld := actual_NonPagedResourceHeld;
    ControlFileHandle := actual_ControlFileHandle;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} ControlFileHandle != 0;
    assume {:nonnull} ControlFileHandle != 0;
    assume ControlFileHandle > 0;
    goto L17;

  L17:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} NonPagedResourceHeld != 0;
    goto L22;

  L22:
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    havoc Tmp_482;
    assume {:nonnull} Tmp_482 != 0;
    assume Tmp_482 > 0;
    havoc Tmp_483;
    assume {:nonnull} Tmp_483 != 0;
    assume Tmp_483 > 0;
    havoc controlBlock;
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    havoc byteOffset;
    itemsLeft := 0;
    goto L28;

  L28:
    call {:si_unique_call 883} controlItem, sdv_281, needWrite, sdv_283, byteOffset, sdv_288, status_15, itemsLeft, offset := sdv_hash_1005562481_loop_L28(controlItem, sdv_281, controlBlock, needWrite, sdv_283, byteOffset, sdv_288, status_15, itemsLeft, offset, Filter_13, SnapshotGuid);
    goto L28_last;

  L28_last:
    call {:si_unique_call 903} sdv_281 := sdv_hash_317697039(Filter_13);
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    havoc vslice_dummy_var_1231;
    call {:si_unique_call 904} status_15 := sdv_hash_984605889(Filter_13, vslice_dummy_var_1231, byteOffset, -699198463, sdv_281);
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} status_15 >= 0;
    needWrite := 0;
    offset := 128;
    goto L39;

  L39:
    call {:si_unique_call 884} controlItem, needWrite, sdv_288, itemsLeft, offset := sdv_hash_1005562481_loop_L39(controlItem, controlBlock, needWrite, sdv_288, itemsLeft, offset, Filter_13, SnapshotGuid);
    goto L39_last;

  L39_last:
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} 16384 > offset;
    controlItem := controlBlock;
    assume {:nonnull} controlItem != 0;
    assume controlItem > 0;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:nonnull} controlItem != 0;
    assume controlItem > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} SnapshotGuid != 0;
    assume {:nonnull} controlItem != 0;
    assume controlItem > 0;
    call {:si_unique_call 885} sdv_288 := IsEqualGUID(SnapshotGuid__VSP_CONTROL_ITEM_SNAPSHOT(controlItem), SnapshotGuid);
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} sdv_288 != 0;
    call {:si_unique_call 886} sdv_hash_194037626(Filter_13, controlItem);
    assume {:nonnull} controlItem != 0;
    assume controlItem > 0;
    needWrite := 1;
    goto L45;

  L45:
    offset := offset + 128;
    goto L45_dummy;

  L45_dummy:
    assume false;
    return;

  anon66_Then:
    assume {:partition} sdv_288 == 0;
    itemsLeft := 1;
    goto L45;

  anon64_Then:
    assume {:partition} SnapshotGuid == 0;
    assume {:nonnull} controlItem != 0;
    assume controlItem > 0;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    call {:si_unique_call 887} sdv_hash_194037626(Filter_13, controlItem);
    assume {:nonnull} controlItem != 0;
    assume controlItem > 0;
    needWrite := 1;
    goto L45;

  anon65_Then:
    itemsLeft := 1;
    goto L45;

  anon63_Then:
    goto L45;

  anon80_Then:
    goto L40;

  L40:
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} needWrite != 0;
    call {:si_unique_call 888} sdv_283 := sdv_hash_317697039(Filter_13);
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    havoc vslice_dummy_var_1228;
    call {:si_unique_call 889} status_15 := sdv_hash_916928578(Filter_13, vslice_dummy_var_1228, byteOffset, -699198462, sdv_283);
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} status_15 < 0;
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} NonPagedResourceHeld != 0;
    goto L83;

  L83:
    Tmp_479 := status_15;
    goto L1;

  L1:
    return;

  anon69_Then:
    assume {:partition} NonPagedResourceHeld == 0;
    call {:si_unique_call 890} sdv_hash_692646834(Filter_13);
    goto L83;

  anon68_Then:
    assume {:partition} 0 <= status_15;
    goto L70;

  L70:
    assume {:nonnull} controlBlock != 0;
    assume controlBlock > 0;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} itemsLeft != 0;
    h_2 := 0;
    hh := 0;
    goto L90;

  L90:
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} NonPagedResourceHeld != 0;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} h_2 != 0;
    goto L96;

  L96:
    assume {:nonnull} context_6 != 0;
    assume context_6 > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(context_6)] := 14;
    assume {:nonnull} context_6 != 0;
    assume context_6 > 0;
    assume {:nonnull} context_6 != 0;
    assume context_6 > 0;
    assume {:nonnull} context_6 != 0;
    assume context_6 > 0;
    assume {:nonnull} context_6 != 0;
    assume context_6 > 0;
    assume {:nonnull} context_6 != 0;
    assume context_6 > 0;
    assume {:nonnull} context_6 != 0;
    assume context_6 > 0;
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    call {:si_unique_call 891} vslice_dummy_var_196 := ObfReferenceObject(0);
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    call {:si_unique_call 892} vslice_dummy_var_193 := KeResetEvent(ControlBlockFileHandleReady_FILTER_EXTENSION(Filter_13));
    goto L112;

  L112:
    Tmp_479 := 0;
    goto L1;

  anon73_Then:
    assume {:partition} h_2 == 0;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} hh == 0;
    goto L112;

  anon74_Then:
    assume {:partition} hh != 0;
    goto L96;

  anon72_Then:
    assume {:partition} NonPagedResourceHeld == 0;
    call {:si_unique_call 893} sdv_hash_692646834(Filter_13);
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} h_2 != 0;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} ControlFileHandle != 0;
    assume {:nonnull} ControlFileHandle != 0;
    assume ControlFileHandle > 0;
    goto L114;

  L114:
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} hh != 0;
    call {:si_unique_call 894} vslice_dummy_var_195 := ZwClose(0);
    goto L112;

  anon76_Then:
    assume {:partition} hh == 0;
    goto L112;

  anon77_Then:
    assume {:partition} ControlFileHandle == 0;
    call {:si_unique_call 895} vslice_dummy_var_194 := ZwClose(0);
    goto L114;

  anon75_Then:
    assume {:partition} h_2 == 0;
    goto L114;

  anon70_Then:
    assume {:partition} itemsLeft == 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} NonPagedResourceHeld == 0;
    h_2 := sdv_294;
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    call {:si_unique_call 896} vslice_dummy_var_198 := sdv_hash_307580759(Filter_13, 0, -1, 0);
    hh := sdv_282;
    goto L90;

  anon71_Then:
    assume {:partition} NonPagedResourceHeld != 0;
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    havoc vslice_dummy_var_1229;
    call {:si_unique_call 897} context_6 := sdv_hash_859757058(vslice_dummy_var_1229);
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} context_6 != 0;
    h_2 := sdv_280;
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    call {:si_unique_call 898} vslice_dummy_var_197 := sdv_hash_307580759(Filter_13, 0, -1, 0);
    hh := sdv_292;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} h_2 == 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} hh == 0;
    assume {:nonnull} Filter_13 != 0;
    assume Filter_13 > 0;
    havoc vslice_dummy_var_1230;
    call {:si_unique_call 899} sdv_hash_493014447(vslice_dummy_var_1230, context_6);
    goto L90;

  anon79_Then:
    assume {:partition} hh != 0;
    goto L90;

  anon81_Then:
    assume {:partition} h_2 != 0;
    goto L90;

  anon78_Then:
    assume {:partition} context_6 == 0;
    h_2 := 0;
    hh := 0;
    goto L90;

  anon67_Then:
    assume {:nonnull} controlBlock != 0;
    assume controlBlock > 0;
    havoc byteOffset;
    goto anon67_Then_dummy;

  anon67_Then_dummy:
    assume false;
    return;

  anon62_Then:
    assume {:partition} needWrite == 0;
    goto L70;

  anon61_Then:
    assume {:partition} offset >= 16384;
    goto L40;

  anon59_Then:
    assume {:partition} 0 > status_15;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} NonPagedResourceHeld != 0;
    goto L166;

  L166:
    Tmp_479 := status_15;
    goto L1;

  anon60_Then:
    assume {:partition} NonPagedResourceHeld == 0;
    call {:si_unique_call 900} sdv_hash_692646834(Filter_13);
    goto L166;

  anon57_Then:
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} NonPagedResourceHeld != 0;
    goto L170;

  L170:
    Tmp_479 := 0;
    goto L1;

  anon58_Then:
    assume {:partition} NonPagedResourceHeld == 0;
    call {:si_unique_call 901} sdv_hash_692646834(Filter_13);
    goto L170;

  anon56_Then:
    assume {:partition} NonPagedResourceHeld == 0;
    call {:si_unique_call 902} sdv_hash_805325738(Filter_13, 0, 0);
    goto L22;

  anon55_Then:
    assume {:partition} ControlFileHandle == 0;
    goto L17;
}



procedure {:origName "sdv_hash_185580169"} sdv_hash_185580169(actual_Filter_14: int, actual_SnapshotProtectModeFailureReason: int, actual_FailureStatus: int, actual_UniqueId: int) returns (Tmp_484: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, ref, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures Tmp_484 == 1 || Tmp_484 == 0;



implementation {:origName "sdv_hash_185580169"} sdv_hash_185580169(actual_Filter_14: int, actual_SnapshotProtectModeFailureReason: int, actual_FailureStatus: int, actual_UniqueId: int) returns (Tmp_484: int)
{
  var {:scalar} logCode: int;
  var {:scalar} sdv_297: int;
  var {:scalar} irql_13: int;
  var {:pointer} extension_2: int;
  var {:pointer} Filter_14: int;
  var {:scalar} SnapshotProtectModeFailureReason: int;
  var {:scalar} FailureStatus: int;
  var {:scalar} UniqueId: int;

  anon0:
    Filter_14 := actual_Filter_14;
    SnapshotProtectModeFailureReason := actual_SnapshotProtectModeFailureReason;
    FailureStatus := actual_FailureStatus;
    UniqueId := actual_UniqueId;
    assume {:nonnull} Filter_14 != 0;
    assume Filter_14 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:nonnull} Filter_14 != 0;
    assume Filter_14 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    Tmp_484 := 1;
    goto L1;

  L1:
    return;

  anon44_Then:
    call {:si_unique_call 905} irql_13 := KfAcquireSpinLock(0);
    assume {:nonnull} Filter_14 != 0;
    assume Filter_14 > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:nonnull} Filter_14 != 0;
    assume Filter_14 > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    call {:si_unique_call 906} KfReleaseSpinLock(0, irql_13);
    Tmp_484 := 1;
    goto L1;

  anon46_Then:
    assume {:nonnull} Filter_14 != 0;
    assume Filter_14 > 0;
    call {:si_unique_call 907} sdv_297 := IsListEmpty(VolumeList_FILTER_EXTENSION(Filter_14));
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} sdv_297 != 0;
    goto L32;

  L32:
    assume {:nonnull} Filter_14 != 0;
    assume Filter_14 > 0;
    assume {:nonnull} Filter_14 != 0;
    assume Filter_14 > 0;
    assume {:nonnull} Filter_14 != 0;
    assume Filter_14 > 0;
    call {:si_unique_call 908} KfReleaseSpinLock(0, irql_13);
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 1;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 2;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 3;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 4;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 5;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 6;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 7;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 8;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 9;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 10;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 11;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 12;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 13;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} SnapshotProtectModeFailureReason != 14;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} SnapshotProtectModeFailureReason == 15;
    logCode := -1073348514;
    goto L59;

  L59:
    call {:si_unique_call 909} sdv_hash_570003108(0, Filter_14, logCode, FailureStatus, UniqueId, 0);
    Tmp_484 := 1;
    goto L1;

  anon49_Then:
    assume {:partition} SnapshotProtectModeFailureReason != 15;
    Tmp_484 := 1;
    goto L1;

  anon50_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 14;
    logCode := -1073348515;
    goto L59;

  anon51_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 13;
    logCode := -1073348516;
    goto L59;

  anon52_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 12;
    logCode := -1073348517;
    goto L59;

  anon53_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 11;
    logCode := -1073348518;
    goto L59;

  anon54_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 10;
    logCode := -1073348519;
    goto L59;

  anon55_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 9;
    logCode := -1073348520;
    goto L59;

  anon56_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 8;
    logCode := -1073348521;
    goto L59;

  anon57_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 7;
    logCode := -1073348522;
    goto L59;

  anon58_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 6;
    logCode := -1073348523;
    goto L59;

  anon59_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 5;
    logCode := -1073348524;
    goto L59;

  anon60_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 4;
    logCode := -1073348525;
    goto L59;

  anon61_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 3;
    logCode := -1073348526;
    goto L59;

  anon62_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 2;
    logCode := -1073348527;
    goto L59;

  anon48_Then:
    assume {:partition} SnapshotProtectModeFailureReason == 1;
    logCode := -1073348528;
    goto L59;

  anon47_Then:
    assume {:partition} sdv_297 == 0;
    assume {:nonnull} Filter_14 != 0;
    assume Filter_14 > 0;
    havoc extension_2;
    assume {:nonnull} extension_2 != 0;
    assume extension_2 > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    call {:si_unique_call 910} KfReleaseSpinLock(0, irql_13);
    Tmp_484 := 0;
    goto L1;

  anon63_Then:
    goto L32;

  anon45_Then:
    call {:si_unique_call 911} KfReleaseSpinLock(0, irql_13);
    Tmp_484 := 0;
    goto L1;

  anon43_Then:
    Tmp_484 := 0;
    goto L1;
}



procedure {:origName "sdv_hash_899948027"} sdv_hash_899948027(actual_RootExtension_6: int) returns (Tmp_486: int);
  modifies alloc;
  free ensures Tmp_486 == 0;



implementation {:origName "sdv_hash_899948027"} sdv_hash_899948027(actual_RootExtension_6: int) returns (Tmp_486: int)
{
  var {:scalar} i_4: int;
  var {:pointer} Tmp_488: int;
  var {:scalar} Tmp_490: int;
  var {:pointer} RootExtension_6: int;
  var vslice_dummy_var_199: int;
  var vslice_dummy_var_200: int;
  var vslice_dummy_var_201: int;
  var vslice_dummy_var_202: int;
  var vslice_dummy_var_203: int;

  anon0:
    RootExtension_6 := actual_RootExtension_6;
    call {:si_unique_call 912} Tmp_488 := __HAVOC_malloc(1152);
    call {:si_unique_call 913} vslice_dummy_var_199 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} RootExtension_6 != 0;
    assume RootExtension_6 > 0;
    assume {:nonnull} RootExtension_6 != 0;
    assume RootExtension_6 > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    call {:si_unique_call 914} vslice_dummy_var_200 := KeReleaseSemaphore(0, 0, 1, 0);
    Tmp_486 := 0;
    goto L1;

  L1:
    return;

  anon9_Then:
    i_4 := 0;
    goto L17;

  L17:
    call {:si_unique_call 915} i_4, Tmp_488, Tmp_490, vslice_dummy_var_203 := sdv_hash_899948027_loop_L17(i_4, Tmp_488, Tmp_490, RootExtension_6, vslice_dummy_var_203);
    goto L17_last;

  L17_last:
    assume {:CounterLoop 9} {:Counter "i_4"} true;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} 9 > i_4;
    Tmp_490 := i_4;
    assume {:nonnull} RootExtension_6 != 0;
    assume RootExtension_6 > 0;
    havoc Tmp_488;
    call {:si_unique_call 916} vslice_dummy_var_203 := KeReleaseSemaphore(0, 0, 1, 0);
    i_4 := i_4 + 1;
    goto anon7_Else_dummy;

  anon7_Else_dummy:
    assume false;
    return;

  anon7_Then:
    assume {:partition} i_4 >= 9;
    assume {:nonnull} RootExtension_6 != 0;
    assume RootExtension_6 > 0;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    call {:si_unique_call 917} vslice_dummy_var_201 := KeReleaseSemaphore(0, 0, 1, 0);
    Tmp_486 := 0;
    goto L1;

  anon8_Then:
    assume {:nonnull} RootExtension_6 != 0;
    assume RootExtension_6 > 0;
    assume {:nonnull} RootExtension_6 != 0;
    assume RootExtension_6 > 0;
    assume {:nonnull} RootExtension_6 != 0;
    assume RootExtension_6 > 0;
    assume {:nonnull} RootExtension_6 != 0;
    assume RootExtension_6 > 0;
    call {:si_unique_call 918} vslice_dummy_var_202 := KeReleaseSemaphore(0, 0, 1, 0);
    Tmp_486 := 0;
    goto L1;
}



procedure {:origName "PsGetCurrentThread"} PsGetCurrentThread() returns (Tmp_491: int);
  modifies alloc;



implementation {:origName "PsGetCurrentThread"} PsGetCurrentThread() returns (Tmp_491: int)
{
  var {:pointer} sdv_304: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    sdv_304 := 0;
    goto L6;

  L6:
    Tmp_491 := sdv_304;
    return;

  anon3_Then:
    call {:si_unique_call 919} sdv_304 := __HAVOC_malloc(1);
    goto L6;
}



procedure {:origName "RemoveHeadList"} RemoveHeadList(actual_ListHead_3: int) returns (Tmp_493: int);



implementation {:origName "RemoveHeadList"} RemoveHeadList(actual_ListHead_3: int) returns (Tmp_493: int)
{
  var {:pointer} Entry_3: int;
  var {:pointer} Flink_1: int;
  var {:pointer} ListHead_3: int;

  anon0:
    ListHead_3 := actual_ListHead_3;
    assume {:nonnull} ListHead_3 != 0;
    assume ListHead_3 > 0;
    havoc Entry_3;
    assume {:nonnull} Entry_3 != 0;
    assume Entry_3 > 0;
    havoc Flink_1;
    assume {:nonnull} ListHead_3 != 0;
    assume ListHead_3 > 0;
    assume {:nonnull} Flink_1 != 0;
    assume Flink_1 > 0;
    Tmp_493 := Entry_3;
    return;
}



procedure {:origName "sdv_hash_588722555"} sdv_hash_588722555(actual_DriverObject_7: int, actual_IrpQueue: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_588722555"} sdv_hash_588722555(actual_DriverObject_7: int, actual_IrpQueue: int)
{
  var {:pointer} irpSp_3: int;
  var {:scalar} Tmp_495: int;
  var {:scalar} sdv_305: int;
  var {:pointer} irp_4: int;
  var {:pointer} l_5: int;
  var {:pointer} Tmp_498: int;
  var {:pointer} DriverObject_7: int;
  var {:pointer} IrpQueue: int;
  var vslice_dummy_var_204: int;
  var vslice_dummy_var_205: int;
  var vslice_dummy_var_206: int;
  var vslice_dummy_var_207: int;
  var vslice_dummy_var_208: int;
  var vslice_dummy_var_209: int;
  var vslice_dummy_var_210: int;
  var vslice_dummy_var_211: int;
  var vslice_dummy_var_212: int;
  var vslice_dummy_var_213: int;
  var vslice_dummy_var_214: int;
  var vslice_dummy_var_215: int;
  var vslice_dummy_var_216: int;
  var vslice_dummy_var_217: int;
  var vslice_dummy_var_218: int;
  var vslice_dummy_var_219: int;
  var vslice_dummy_var_220: int;
  var vslice_dummy_var_221: int;
  var vslice_dummy_var_222: int;
  var vslice_dummy_var_223: int;
  var vslice_dummy_var_224: int;
  var vslice_dummy_var_225: int;
  var vslice_dummy_var_226: int;
  var vslice_dummy_var_1232: int;
  var vslice_dummy_var_1233: int;
  var vslice_dummy_var_1234: int;
  var vslice_dummy_var_1235: int;
  var vslice_dummy_var_1236: int;
  var vslice_dummy_var_1237: int;
  var vslice_dummy_var_1238: int;
  var vslice_dummy_var_1239: int;
  var vslice_dummy_var_1240: int;
  var vslice_dummy_var_1241: int;
  var vslice_dummy_var_1242: int;
  var vslice_dummy_var_1243: int;
  var vslice_dummy_var_1244: int;
  var vslice_dummy_var_1245: int;
  var vslice_dummy_var_1246: int;
  var vslice_dummy_var_1247: int;
  var vslice_dummy_var_1248: int;
  var vslice_dummy_var_1249: int;
  var vslice_dummy_var_1250: int;
  var vslice_dummy_var_1251: int;
  var vslice_dummy_var_1252: int;
  var vslice_dummy_var_1253: int;

  anon0:
    call {:si_unique_call 920} vslice_dummy_var_204 := __HAVOC_malloc(4);
    DriverObject_7 := actual_DriverObject_7;
    IrpQueue := actual_IrpQueue;
    call {:si_unique_call 921} Tmp_498 := __HAVOC_malloc(112);
    goto L6;

  L6:
    call {:si_unique_call 922} irpSp_3, Tmp_495, sdv_305, irp_4, l_5, Tmp_498, vslice_dummy_var_205, vslice_dummy_var_206, vslice_dummy_var_207, vslice_dummy_var_208, vslice_dummy_var_209, vslice_dummy_var_210, vslice_dummy_var_211, vslice_dummy_var_212, vslice_dummy_var_213, vslice_dummy_var_214, vslice_dummy_var_215, vslice_dummy_var_216, vslice_dummy_var_217, vslice_dummy_var_218, vslice_dummy_var_219, vslice_dummy_var_220, vslice_dummy_var_221, vslice_dummy_var_222, vslice_dummy_var_223, vslice_dummy_var_224, vslice_dummy_var_225, vslice_dummy_var_226 := sdv_hash_588722555_loop_L6(irpSp_3, Tmp_495, sdv_305, irp_4, l_5, Tmp_498, DriverObject_7, IrpQueue, vslice_dummy_var_205, vslice_dummy_var_206, vslice_dummy_var_207, vslice_dummy_var_208, vslice_dummy_var_209, vslice_dummy_var_210, vslice_dummy_var_211, vslice_dummy_var_212, vslice_dummy_var_213, vslice_dummy_var_214, vslice_dummy_var_215, vslice_dummy_var_216, vslice_dummy_var_217, vslice_dummy_var_218, vslice_dummy_var_219, vslice_dummy_var_220, vslice_dummy_var_221, vslice_dummy_var_222, vslice_dummy_var_223, vslice_dummy_var_224, vslice_dummy_var_225, vslice_dummy_var_226);
    goto L6_last;

  L6_last:
    call {:si_unique_call 947} sdv_305 := IsListEmpty(IrpQueue);
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} sdv_305 == 0;
    call {:si_unique_call 923} l_5 := RemoveHeadList(IrpQueue);
    irp_4 := l_5;
    call {:si_unique_call 924} irpSp_3 := IoGetCurrentIrpStackLocation(irp_4);
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc Tmp_495;
    assume {:nonnull} DriverObject_7 != 0;
    assume DriverObject_7 > 0;
    havoc Tmp_498;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume Tmp_495 != 27;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume Tmp_495 != 26;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume Tmp_495 != 25;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume Tmp_495 != 24;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume Tmp_495 != 23;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume Tmp_495 != 22;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume Tmp_495 != 21;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume Tmp_495 != 20;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume Tmp_495 != 19;
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume Tmp_495 != 18;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume Tmp_495 != 17;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume Tmp_495 != 16;
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume Tmp_495 != 15;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume Tmp_495 != 14;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume Tmp_495 != 13;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume Tmp_495 != 12;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume Tmp_495 != 11;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume Tmp_495 != 10;
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume Tmp_495 != 9;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume Tmp_495 != 8;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume Tmp_495 != 7;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume Tmp_495 != 6;
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume Tmp_495 != 5;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume Tmp_495 != 4;
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume Tmp_495 != 3;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume Tmp_495 != 2;
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume Tmp_495 != 1;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume false;
    return;

  anon87_Then:
    assume Tmp_495 == 0;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1232;
    call {:si_unique_call 925} vslice_dummy_var_226 := VolSnapDefaultDispatch(vslice_dummy_var_1232, irp_4);
    goto anon87_Then_dummy;

  anon87_Then_dummy:
    assume false;
    return;

  anon86_Then:
    assume Tmp_495 == 1;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1233;
    call {:si_unique_call 926} vslice_dummy_var_225 := VolSnapDefaultDispatch(vslice_dummy_var_1233, irp_4);
    goto anon86_Then_dummy;

  anon86_Then_dummy:
    assume false;
    return;

  anon85_Then:
    assume Tmp_495 == 2;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1234;
    call {:si_unique_call 927} vslice_dummy_var_224 := VolSnapDefaultDispatch(vslice_dummy_var_1234, irp_4);
    goto anon85_Then_dummy;

  anon85_Then_dummy:
    assume false;
    return;

  anon84_Then:
    assume Tmp_495 == 3;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    goto anon84_Then_dummy;

  anon84_Then_dummy:
    assume false;
    return;

  anon83_Then:
    assume Tmp_495 == 4;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    goto anon83_Then_dummy;

  anon83_Then_dummy:
    assume false;
    return;

  anon82_Then:
    assume Tmp_495 == 5;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1235;
    call {:si_unique_call 928} vslice_dummy_var_223 := VolSnapDefaultDispatch(vslice_dummy_var_1235, irp_4);
    goto anon82_Then_dummy;

  anon82_Then_dummy:
    assume false;
    return;

  anon81_Then:
    assume Tmp_495 == 6;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1236;
    call {:si_unique_call 929} vslice_dummy_var_222 := VolSnapDefaultDispatch(vslice_dummy_var_1236, irp_4);
    goto anon81_Then_dummy;

  anon81_Then_dummy:
    assume false;
    return;

  anon80_Then:
    assume Tmp_495 == 7;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1237;
    call {:si_unique_call 930} vslice_dummy_var_221 := VolSnapDefaultDispatch(vslice_dummy_var_1237, irp_4);
    goto anon80_Then_dummy;

  anon80_Then_dummy:
    assume false;
    return;

  anon79_Then:
    assume Tmp_495 == 8;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1238;
    call {:si_unique_call 931} vslice_dummy_var_220 := VolSnapDefaultDispatch(vslice_dummy_var_1238, irp_4);
    goto anon79_Then_dummy;

  anon79_Then_dummy:
    assume false;
    return;

  anon78_Then:
    assume Tmp_495 == 9;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1239;
    call {:si_unique_call 932} vslice_dummy_var_219 := VolSnapDefaultDispatch(vslice_dummy_var_1239, irp_4);
    goto anon78_Then_dummy;

  anon78_Then_dummy:
    assume false;
    return;

  anon77_Then:
    assume Tmp_495 == 10;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1240;
    call {:si_unique_call 933} vslice_dummy_var_218 := VolSnapDefaultDispatch(vslice_dummy_var_1240, irp_4);
    goto anon77_Then_dummy;

  anon77_Then_dummy:
    assume false;
    return;

  anon76_Then:
    assume Tmp_495 == 11;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1241;
    call {:si_unique_call 934} vslice_dummy_var_217 := VolSnapDefaultDispatch(vslice_dummy_var_1241, irp_4);
    goto anon76_Then_dummy;

  anon76_Then_dummy:
    assume false;
    return;

  anon75_Then:
    assume Tmp_495 == 12;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1242;
    call {:si_unique_call 935} vslice_dummy_var_216 := VolSnapDefaultDispatch(vslice_dummy_var_1242, irp_4);
    goto anon75_Then_dummy;

  anon75_Then_dummy:
    assume false;
    return;

  anon74_Then:
    assume Tmp_495 == 13;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1243;
    call {:si_unique_call 936} vslice_dummy_var_215 := VolSnapDefaultDispatch(vslice_dummy_var_1243, irp_4);
    goto anon74_Then_dummy;

  anon74_Then_dummy:
    assume false;
    return;

  anon73_Then:
    assume Tmp_495 == 14;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    goto anon73_Then_dummy;

  anon73_Then_dummy:
    assume false;
    return;

  anon72_Then:
    assume Tmp_495 == 15;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1244;
    call {:si_unique_call 937} vslice_dummy_var_214 := VolSnapDefaultDispatch(vslice_dummy_var_1244, irp_4);
    goto anon72_Then_dummy;

  anon72_Then_dummy:
    assume false;
    return;

  anon71_Then:
    assume Tmp_495 == 16;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1245;
    call {:si_unique_call 938} vslice_dummy_var_213 := VolSnapDefaultDispatch(vslice_dummy_var_1245, irp_4);
    goto anon71_Then_dummy;

  anon71_Then_dummy:
    assume false;
    return;

  anon70_Then:
    assume Tmp_495 == 17;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1246;
    call {:si_unique_call 939} vslice_dummy_var_212 := VolSnapDefaultDispatch(vslice_dummy_var_1246, irp_4);
    goto anon70_Then_dummy;

  anon70_Then_dummy:
    assume false;
    return;

  anon69_Then:
    assume Tmp_495 == 18;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    goto anon69_Then_dummy;

  anon69_Then_dummy:
    assume false;
    return;

  anon68_Then:
    assume Tmp_495 == 19;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1247;
    call {:si_unique_call 940} vslice_dummy_var_211 := VolSnapDefaultDispatch(vslice_dummy_var_1247, irp_4);
    goto anon68_Then_dummy;

  anon68_Then_dummy:
    assume false;
    return;

  anon67_Then:
    assume Tmp_495 == 20;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1248;
    call {:si_unique_call 941} vslice_dummy_var_210 := VolSnapDefaultDispatch(vslice_dummy_var_1248, irp_4);
    goto anon67_Then_dummy;

  anon67_Then_dummy:
    assume false;
    return;

  anon66_Then:
    assume Tmp_495 == 21;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1249;
    call {:si_unique_call 942} vslice_dummy_var_209 := VolSnapDefaultDispatch(vslice_dummy_var_1249, irp_4);
    goto anon66_Then_dummy;

  anon66_Then_dummy:
    assume false;
    return;

  anon65_Then:
    assume Tmp_495 == 22;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    goto anon65_Then_dummy;

  anon65_Then_dummy:
    assume false;
    return;

  anon64_Then:
    assume Tmp_495 == 23;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1250;
    call {:si_unique_call 943} vslice_dummy_var_208 := VolSnapDefaultDispatch(vslice_dummy_var_1250, irp_4);
    goto anon64_Then_dummy;

  anon64_Then_dummy:
    assume false;
    return;

  anon63_Then:
    assume Tmp_495 == 24;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1251;
    call {:si_unique_call 944} vslice_dummy_var_207 := VolSnapDefaultDispatch(vslice_dummy_var_1251, irp_4);
    goto anon63_Then_dummy;

  anon63_Then_dummy:
    assume false;
    return;

  anon62_Then:
    assume Tmp_495 == 25;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1252;
    call {:si_unique_call 945} vslice_dummy_var_206 := VolSnapDefaultDispatch(vslice_dummy_var_1252, irp_4);
    goto anon62_Then_dummy;

  anon62_Then_dummy:
    assume false;
    return;

  anon61_Then:
    assume Tmp_495 == 26;
    assume {:IndirectCall} true;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} irpSp_3 != 0;
    assume irpSp_3 > 0;
    havoc vslice_dummy_var_1253;
    call {:si_unique_call 946} vslice_dummy_var_205 := VolSnapDefaultDispatch(vslice_dummy_var_1253, irp_4);
    goto anon61_Then_dummy;

  anon61_Then_dummy:
    assume false;
    return;

  anon60_Then:
    assume Tmp_495 == 27;
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    goto anon60_Then_dummy;

  anon60_Then_dummy:
    assume false;
    return;

  anon59_Then:
    assume {:partition} sdv_305 != 0;
    return;
}



procedure {:origName "VspFreeIrp"} VspFreeIrp(actual_Irp_11: int, actual_FreeBuffer: int);
  modifies alloc;



implementation {:origName "VspFreeIrp"} VspFreeIrp(actual_Irp_11: int, actual_FreeBuffer: int)
{
  var {:pointer} Tmp_501: int;
  var {:pointer} Irp_11: int;
  var {:scalar} FreeBuffer: int;
  var vslice_dummy_var_227: int;

  anon0:
    call {:si_unique_call 948} vslice_dummy_var_227 := __HAVOC_malloc(4);
    Irp_11 := actual_Irp_11;
    FreeBuffer := actual_FreeBuffer;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} Irp_11 != 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} FreeBuffer != 0;
    assume {:nonnull} Irp_11 != 0;
    assume Irp_11 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:nonnull} Irp_11 != 0;
    assume Irp_11 > 0;
    havoc Tmp_501;
    assume {:nonnull} Tmp_501 != 0;
    assume Tmp_501 > 0;
    call {:si_unique_call 949} ExFreePoolWithTag(0, 0);
    goto L9;

  L9:
    assume {:nonnull} Irp_11 != 0;
    assume Irp_11 > 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    call {:si_unique_call 950} IoFreeMdl(0);
    goto L15;

  L15:
    call {:si_unique_call 951} IoFreeIrp(0);
    goto L1;

  L1:
    return;

  anon11_Then:
    goto L15;

  anon12_Then:
    goto L9;

  anon10_Then:
    assume {:partition} FreeBuffer == 0;
    goto L9;

  anon9_Then:
    assume {:partition} Irp_11 == 0;
    goto L1;
}



procedure {:origName "sdv_hash_242852003"} sdv_hash_242852003(actual_Filter_15: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_242852003"} sdv_hash_242852003(actual_Filter_15: int)
{
  var {:pointer} Tmp_503: int;
  var {:scalar} sdv_311: int;
  var {:pointer} Tmp_504: int;
  var {:scalar} q_2: int;
  var {:scalar} emptyQueue: int;
  var {:scalar} irql_14: int;
  var {:pointer} Filter_15: int;
  var vslice_dummy_var_228: int;
  var vslice_dummy_var_229: int;
  var vslice_dummy_var_230: int;
  var vslice_dummy_var_1254: int;

  anon0:
    call {:si_unique_call 952} vslice_dummy_var_228 := __HAVOC_malloc(4);
    call {:si_unique_call 953} q_2 := __HAVOC_malloc(8);
    Filter_15 := actual_Filter_15;
    call {:si_unique_call 954} irql_14 := KfAcquireSpinLock(0);
    assume {:nonnull} Filter_15 != 0;
    assume Filter_15 > 0;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    call {:si_unique_call 955} KfReleaseSpinLock(0, irql_14);
    call {:si_unique_call 956} vslice_dummy_var_229 := KeReleaseSemaphore(0, 0, 1, 0);
    goto L1;

  L1:
    return;

  anon7_Then:
    assume {:nonnull} Filter_15 != 0;
    assume Filter_15 > 0;
    call {:si_unique_call 957} sdv_311 := IsListEmpty(HoldQueue_FILTER_EXTENSION(Filter_15));
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} sdv_311 != 0;
    emptyQueue := 0;
    goto L27;

  L27:
    call {:si_unique_call 958} KfReleaseSpinLock(0, irql_14);
    call {:si_unique_call 959} vslice_dummy_var_230 := KeReleaseSemaphore(0, 0, 1, 0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} emptyQueue != 0;
    assume {:nonnull} q_2 != 0;
    assume q_2 > 0;
    assume {:nonnull} q_2 != 0;
    assume q_2 > 0;
    assume {:nonnull} Filter_15 != 0;
    assume Filter_15 > 0;
    Tmp_504 := DEVICE_EXTENSION_FILTER_EXTENSION(Filter_15);
    assume {:nonnull} Tmp_504 != 0;
    assume Tmp_504 > 0;
    havoc Tmp_503;
    assume {:nonnull} Tmp_503 != 0;
    assume Tmp_503 > 0;
    havoc vslice_dummy_var_1254;
    call {:si_unique_call 960} sdv_hash_588722555(vslice_dummy_var_1254, q_2);
    goto L1;

  anon9_Then:
    assume {:partition} emptyQueue == 0;
    goto L1;

  anon8_Then:
    assume {:partition} sdv_311 == 0;
    emptyQueue := 1;
    assume {:nonnull} Filter_15 != 0;
    assume Filter_15 > 0;
    assume {:nonnull} q_2 != 0;
    assume q_2 > 0;
    assume {:nonnull} Filter_15 != 0;
    assume Filter_15 > 0;
    assume {:nonnull} q_2 != 0;
    assume q_2 > 0;
    assume {:nonnull} Filter_15 != 0;
    assume Filter_15 > 0;
    call {:si_unique_call 961} InitializeListHead(HoldQueue_FILTER_EXTENSION(Filter_15));
    goto L27;
}



procedure {:origName "sdv_hash_692646834"} sdv_hash_692646834(actual_Extension_7: int);
  modifies alloc;



implementation {:origName "sdv_hash_692646834"} sdv_hash_692646834(actual_Extension_7: int)
{
  var {:pointer} Tmp_507: int;
  var {:pointer} workItem_1: int;
  var {:scalar} sdv_315: int;
  var {:scalar} sdv_316: int;
  var {:pointer} filter_7: int;
  var {:pointer} Tmp_509: int;
  var {:scalar} sdv_318: int;
  var {:pointer} l_6: int;
  var {:scalar} q_3: int;
  var {:pointer} Tmp_510: int;
  var {:scalar} irql_15: int;
  var {:pointer} Extension_7: int;
  var vslice_dummy_var_231: int;
  var vslice_dummy_var_1255: int;

  anon0:
    call {:si_unique_call 962} q_3 := __HAVOC_malloc(8);
    call {:si_unique_call 963} vslice_dummy_var_231 := __HAVOC_malloc(4);
    Extension_7 := actual_Extension_7;
    assume {:nonnull} Extension_7 != 0;
    assume Extension_7 > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    filter_7 := Extension_7;
    goto L12;

  L12:
    assume {:nonnull} filter_7 != 0;
    assume filter_7 > 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    goto L13;

  L13:
    call {:si_unique_call 964} Tmp_507, workItem_1, sdv_315, sdv_316, Tmp_509, l_6, irql_15 := sdv_hash_692646834_loop_L13(Tmp_507, workItem_1, sdv_315, sdv_316, filter_7, Tmp_509, l_6, q_3, irql_15);
    goto L13_last;

  L13_last:
    call {:si_unique_call 976} irql_15 := KfAcquireSpinLock(0);
    assume {:nonnull} filter_7 != 0;
    assume filter_7 > 0;
    call {:si_unique_call 977} sdv_316 := IsListEmpty(NonPagedResourceList_FILTER_EXTENSION(filter_7));
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} sdv_316 != 0;
    assume {:nonnull} filter_7 != 0;
    assume filter_7 > 0;
    call {:si_unique_call 965} KfReleaseSpinLock(0, irql_15);
    goto L1;

  L1:
    return;

  anon23_Then:
    assume {:partition} sdv_316 == 0;
    assume {:nonnull} filter_7 != 0;
    assume filter_7 > 0;
    assume {:nonnull} q_3 != 0;
    assume q_3 > 0;
    assume {:nonnull} filter_7 != 0;
    assume filter_7 > 0;
    assume {:nonnull} q_3 != 0;
    assume q_3 > 0;
    assume {:nonnull} filter_7 != 0;
    assume filter_7 > 0;
    call {:si_unique_call 966} InitializeListHead(NonPagedResourceList_FILTER_EXTENSION(filter_7));
    call {:si_unique_call 967} KfReleaseSpinLock(0, irql_15);
    assume {:nonnull} q_3 != 0;
    assume q_3 > 0;
    assume {:nonnull} q_3 != 0;
    assume q_3 > 0;
    assume {:nonnull} filter_7 != 0;
    assume filter_7 > 0;
    goto L38;

  L38:
    call {:si_unique_call 968} Tmp_507, workItem_1, sdv_315, Tmp_509, l_6 := sdv_hash_692646834_loop_L38(Tmp_507, workItem_1, sdv_315, Tmp_509, l_6, q_3);
    goto L38_last;

  L38_last:
    call {:si_unique_call 975} l_6 := RemoveHeadList(q_3);
    workItem_1 := l_6;
    assume {:nonnull} workItem_1 != 0;
    assume workItem_1 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:nonnull} workItem_1 != 0;
    assume workItem_1 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:nonnull} workItem_1 != 0;
    assume workItem_1 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    goto L51;

  L51:
    assume {:nonnull} filter_7 != 0;
    assume filter_7 > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} workItem_1 != 0;
    call {:si_unique_call 969} irql_15 := KfAcquireSpinLock(0);
    assume {:nonnull} filter_7 != 0;
    assume filter_7 > 0;
    call {:si_unique_call 970} sdv_hash_515123808(NonPagedResourceList_FILTER_EXTENSION(filter_7), q_3, 1);
    call {:si_unique_call 971} KfReleaseSpinLock(0, irql_15);
    assume {:nonnull} workItem_1 != 0;
    assume workItem_1 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:nonnull} workItem_1 != 0;
    assume workItem_1 > 0;
    goto L1;

  anon26_Then:
    call {:si_unique_call 972} sdv_318 := sdv_hash_672018212(Extension_7, 2);
    assume {:nonnull} Extension_7 != 0;
    assume Extension_7 > 0;
    havoc vslice_dummy_var_1255;
    call {:si_unique_call 973} sdv_hash_21074203(vslice_dummy_var_1255, workItem_1, sdv_318);
    goto L1;

  anon29_Then:
    assume {:partition} workItem_1 == 0;
    goto anon29_Then_dummy;

  anon29_Then_dummy:
    assume false;
    return;

  anon25_Then:
    assume {:nonnull} workItem_1 != 0;
    assume workItem_1 > 0;
    havoc Tmp_509;
    assume {:nonnull} Tmp_509 != 0;
    assume Tmp_509 > 0;
    havoc Tmp_507;
    assume {:nonnull} Tmp_507 != 0;
    assume Tmp_507 > 0;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    goto L51;

  anon30_Then:
    goto L44;

  L44:
    assume {:nonnull} workItem_1 != 0;
    assume workItem_1 > 0;
    call {:si_unique_call 974} sdv_315 := IsListEmpty(q_3);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} sdv_315 != 0;
    workItem_1 := 0;
    goto L51;

  anon27_Then:
    assume {:partition} sdv_315 == 0;
    goto anon27_Then_dummy;

  anon27_Then_dummy:
    assume false;
    return;

  anon24_Then:
    goto L44;

  anon28_Then:
    goto L44;

  anon22_Then:
    goto L1;

  anon21_Then:
    Tmp_510 := Extension_7;
    assume {:nonnull} Tmp_510 != 0;
    assume Tmp_510 > 0;
    havoc filter_7;
    goto L12;
}



procedure {:origName "sdv_hash_881177106"} sdv_hash_881177106(actual_Extension_8: int, actual_Irp_12: int) returns (Tmp_512: int);
  modifies alloc, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures Tmp_512 == -1073741637 || Tmp_512 == 0 || Tmp_512 == -1073741670;



implementation {:origName "sdv_hash_881177106"} sdv_hash_881177106(actual_Extension_8: int, actual_Irp_12: int) returns (Tmp_512: int)
{
  var {:pointer} Tmp_514: int;
  var {:pointer} irpSp_4: int;
  var {:scalar} Tmp_515: int;
  var {:scalar} Tmp_516: int;
  var {:scalar} string_1: int;
  var {:pointer} buffer_2: int;
  var {:pointer} sdv_322: int;
  var {:pointer} id: int;
  var {:scalar} Tmp_517: int;
  var {:pointer} Tmp_518: int;
  var {:pointer} Irp_12: int;
  var vslice_dummy_var_232: int;
  var vslice_dummy_var_233: int;

  anon0:
    call {:si_unique_call 978} string_1 := __HAVOC_malloc(12);
    Irp_12 := actual_Irp_12;
    call {:si_unique_call 979} vslice_dummy_var_232 := __HAVOC_malloc(100);
    call {:si_unique_call 980} Tmp_514 := __HAVOC_malloc(92);
    call {:si_unique_call 981} buffer_2 := __HAVOC_malloc(400);
    call {:si_unique_call 982} Tmp_518 := __HAVOC_malloc(92);
    call {:si_unique_call 983} irpSp_4 := IoGetCurrentIrpStackLocation(Irp_12);
    assume {:nonnull} irpSp_4 != 0;
    assume irpSp_4 > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:nonnull} irpSp_4 != 0;
    assume irpSp_4 > 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:nonnull} irpSp_4 != 0;
    assume irpSp_4 > 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    call {:si_unique_call 984} vslice_dummy_var_233 := corral_nondet();
    call {:si_unique_call 985} RtlInitUnicodeString(string_1, buffer_2);
    goto L30;

  L30:
    assume {:nonnull} string_1 != 0;
    assume string_1 > 0;
    havoc Tmp_517;
    call {:si_unique_call 986} sdv_322 := ExAllocatePoolWithTag(1, Tmp_517, -262967466);
    id := sdv_322;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} id != 0;
    assume {:nonnull} string_1 != 0;
    assume string_1 > 0;
    havoc Tmp_515;
    assume {:nonnull} id != 0;
    assume id > 0;
    assume {:nonnull} string_1 != 0;
    assume string_1 > 0;
    havoc Tmp_516;
    assume {:nonnull} id != 0;
    assume id > 0;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := id;
    Tmp_512 := 0;
    goto L1;

  L1:
    return;

  anon12_Then:
    assume {:partition} id == 0;
    Tmp_512 := -1073741670;
    goto L1;

  anon10_Then:
    Tmp_512 := -1073741637;
    goto L1;

  anon11_Then:
    Tmp_518 := strConst__li2bpl9;
    call {:si_unique_call 987} RtlInitUnicodeString(string_1, Tmp_518);
    goto L30;

  anon9_Then:
    Tmp_514 := strConst__li2bpl9;
    call {:si_unique_call 988} RtlInitUnicodeString(string_1, Tmp_514);
    goto L30;
}



procedure {:origName "VspSynchronousIo"} VspSynchronousIo(actual_Irp_13: int, actual_TargetObject_2: int, actual_MajorFunction_3: int, actual_Offset_3: int, actual_Length_3: int, actual_Key_2: int, actual_FileObject_2: int, actual_Thread: int, actual_Filter_16: int, actual_IoReason_2: int) returns (Tmp_520: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "VspSynchronousIo"} VspSynchronousIo(actual_Irp_13: int, actual_TargetObject_2: int, actual_MajorFunction_3: int, actual_Offset_3: int, actual_Length_3: int, actual_Key_2: int, actual_FileObject_2: int, actual_Thread: int, actual_Filter_16: int, actual_IoReason_2: int) returns (Tmp_520: int)
{
  var {:pointer} nextSp: int;
  var {:scalar} Tmp_521: int;
  var {:scalar} tick_1: int;
  var {:pointer} s_p_e_c_i_a_l_3: int;
  var {:pointer} Tmp_522: int;
  var {:scalar} restartCount: int;
  var {:scalar} Tmp_524: int;
  var {:scalar} event_3: int;
  var {:pointer} Irp_13: int;
  var {:pointer} TargetObject_2: int;
  var {:scalar} MajorFunction_3: int;
  var {:scalar} Offset_3: int;
  var {:scalar} Length_3: int;
  var {:scalar} Key_2: int;
  var {:pointer} FileObject_2: int;
  var {:pointer} Thread: int;
  var {:pointer} Filter_16: int;
  var {:scalar} IoReason_2: int;
  var boogieTmp: int;
  var vslice_dummy_var_234: int;
  var vslice_dummy_var_235: int;
  var vslice_dummy_var_1256: int;
  var vslice_dummy_var_1257: int;

  anon0:
    call {:si_unique_call 989} tick_1 := __HAVOC_malloc(20);
    call {:si_unique_call 990} event_3 := __HAVOC_malloc(124);
    Irp_13 := actual_Irp_13;
    TargetObject_2 := actual_TargetObject_2;
    MajorFunction_3 := actual_MajorFunction_3;
    Offset_3 := actual_Offset_3;
    Length_3 := actual_Length_3;
    Key_2 := actual_Key_2;
    FileObject_2 := actual_FileObject_2;
    Thread := actual_Thread;
    Filter_16 := actual_Filter_16;
    IoReason_2 := actual_IoReason_2;
    restartCount := 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} Length_3 != 0;
    goto L13;

  L13:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} Key_2 != 0;
    goto L15;

  L15:
    call {:si_unique_call 991} nextSp, s_p_e_c_i_a_l_3, Tmp_522, restartCount, boogieTmp, vslice_dummy_var_234, vslice_dummy_var_235 := VspSynchronousIo_loop_L15(nextSp, tick_1, s_p_e_c_i_a_l_3, Tmp_522, restartCount, event_3, Irp_13, TargetObject_2, MajorFunction_3, Offset_3, Length_3, Key_2, FileObject_2, Thread, boogieTmp, vslice_dummy_var_234, vslice_dummy_var_235);
    goto L15_last;

  L15_last:
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} FileObject_2 != 1;
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    goto L17;

  L17:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} Thread != 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} Thread != 1;
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    goto L23;

  L23:
    call {:si_unique_call 992} nextSp := IoGetNextIrpStackLocation(Irp_13);
    assume {:nonnull} nextSp != 0;
    assume nextSp > 0;
    assume {:nonnull} nextSp != 0;
    assume nextSp > 0;
    assume {:nonnull} nextSp != 0;
    assume nextSp > 0;
    assume {:nonnull} nextSp != 0;
    assume nextSp > 0;
    assume {:nonnull} nextSp != 0;
    assume nextSp > 0;
    assume {:nonnull} nextSp != 0;
    assume nextSp > 0;
    call {:si_unique_call 993} KeInitializeEvent(event_3, 0, 0);
    call {:si_unique_call 994} IoSetCompletionRoutine(Irp_13, li2bplFunctionConstant853, event_3, 1, 1, 1);
    Tmp_522 := KeTickCount;
    assume {:nonnull} Tmp_522 != 0;
    assume Tmp_522 > 0;
    havoc s_p_e_c_i_a_l_3;
    goto L43;

  L43:
    call {:si_unique_call 995} VspSynchronousIo_loop_L43(tick_1, s_p_e_c_i_a_l_3);
    goto L43_last;

  L43_last:
    assume {:nonnull} s_p_e_c_i_a_l_3 != 0;
    assume s_p_e_c_i_a_l_3 > 0;
    assume {:nonnull} tick_1 != 0;
    assume tick_1 > 0;
    assume {:nonnull} s_p_e_c_i_a_l_3 != 0;
    assume s_p_e_c_i_a_l_3 > 0;
    assume {:nonnull} tick_1 != 0;
    assume tick_1 > 0;
    assume {:nonnull} s_p_e_c_i_a_l_3 != 0;
    assume s_p_e_c_i_a_l_3 > 0;
    assume {:nonnull} tick_1 != 0;
    assume tick_1 > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    call {:si_unique_call 996} vslice_dummy_var_234 := IofCallDriver(0, Irp_13);
    call {:si_unique_call 997} vslice_dummy_var_235 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))] == -1073741536;
    restartCount := restartCount + 1;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} 10 < restartCount;
    goto L57;

  L57:
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))] >= 0;
    goto L62;

  L62:
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    Tmp_521 := Length_3;
    assume {:nonnull} tick_1 != 0;
    assume tick_1 > 0;
    havoc vslice_dummy_var_1256;
    call {:si_unique_call 998} sdv_hash_403736888(Filter_16, IoReason_2, MajorFunction_3, Offset_3, Tmp_521, vslice_dummy_var_1256, Irp_13);
    goto L68;

  L68:
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    Tmp_520 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))];
    return;

  anon26_Then:
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    Tmp_524 := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))];
    assume {:nonnull} tick_1 != 0;
    assume tick_1 > 0;
    havoc vslice_dummy_var_1257;
    call {:si_unique_call 999} sdv_hash_403736888(Filter_16, IoReason_2, 0, 0, Tmp_524, vslice_dummy_var_1257, Irp_13);
    goto L68;

  anon25_Then:
    assume {:partition} 0 > Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))];
    goto L62;

  anon30_Then:
    assume {:partition} restartCount <= 10;
    goto anon30_Then_dummy;

  anon30_Then_dummy:
    assume false;
    return;

  anon24_Then:
    assume {:partition} Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))] != -1073741536;
    goto L57;

  anon29_Then:
    goto anon29_Then_dummy;

  anon29_Then_dummy:
    assume false;
    return;

  anon23_Then:
    assume {:partition} Thread == 1;
    goto L23;

  anon22_Then:
    assume {:partition} Thread == 0;
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    call {:si_unique_call 1000} boogieTmp := PsGetCurrentThread();
    goto L23;

  anon28_Then:
    assume {:partition} FileObject_2 == 1;
    goto L17;

  anon21_Then:
    assume {:partition} Key_2 == 0;
    Key_2 := -699203584;
    goto L15;

  anon27_Then:
    assume {:partition} Length_3 == 0;
    Length_3 := 16384;
    goto L13;
}



procedure {:origName "IoSetCompletionRoutine"} IoSetCompletionRoutine(actual_Irp_14: int, actual_CompletionRoutine: int, actual_Context_6: int, actual_InvokeOnSuccess: int, actual_InvokeOnError: int, actual_InvokeOnCancel: int);
  modifies alloc;



implementation {:origName "IoSetCompletionRoutine"} IoSetCompletionRoutine(actual_Irp_14: int, actual_CompletionRoutine: int, actual_Context_6: int, actual_InvokeOnSuccess: int, actual_InvokeOnError: int, actual_InvokeOnCancel: int)
{
  var {:pointer} irpSp_5: int;
  var {:pointer} Irp_14: int;
  var {:scalar} CompletionRoutine: int;
  var {:pointer} Context_6: int;
  var {:scalar} InvokeOnSuccess: int;
  var {:scalar} InvokeOnError: int;
  var {:scalar} InvokeOnCancel: int;
  var vslice_dummy_var_236: int;

  anon0:
    call {:si_unique_call 1001} vslice_dummy_var_236 := __HAVOC_malloc(4);
    Irp_14 := actual_Irp_14;
    CompletionRoutine := actual_CompletionRoutine;
    Context_6 := actual_Context_6;
    InvokeOnSuccess := actual_InvokeOnSuccess;
    InvokeOnError := actual_InvokeOnError;
    InvokeOnCancel := actual_InvokeOnCancel;
    call {:si_unique_call 1002} irpSp_5 := IoGetNextIrpStackLocation(Irp_14);
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} InvokeOnSuccess != 0;
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    goto L12;

  L12:
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} InvokeOnError != 0;
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    goto L14;

  L14:
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} InvokeOnCancel != 0;
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    goto L1;

  L1:
    return;

  anon8_Then:
    assume {:partition} InvokeOnCancel == 0;
    goto L1;

  anon7_Then:
    assume {:partition} InvokeOnError == 0;
    goto L14;

  anon9_Then:
    assume {:partition} InvokeOnSuccess == 0;
    goto L12;
}



procedure {:origName "VolSnapDefaultDispatch"} VolSnapDefaultDispatch(actual_DeviceObject_11: int, actual_Irp_15: int) returns (Tmp_527: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "VolSnapDefaultDispatch"} VolSnapDefaultDispatch(actual_DeviceObject_11: int, actual_Irp_15: int) returns (Tmp_527: int)
{
  var {:pointer} irpSp_6: int;
  var {:pointer} filter_8: int;
  var {:scalar} status_16: int;
  var {:pointer} DeviceObject_11: int;
  var {:pointer} Irp_15: int;

  anon0:
    DeviceObject_11 := actual_DeviceObject_11;
    Irp_15 := actual_Irp_15;
    assume {:nonnull} DeviceObject_11 != 0;
    assume DeviceObject_11 > 0;
    havoc filter_8;
    call {:si_unique_call 1003} irpSp_6 := IoGetCurrentIrpStackLocation(Irp_15);
    assume {:nonnull} filter_8 != 0;
    assume filter_8 > 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    call {:si_unique_call 1004} IoSkipCurrentIrpStackLocation(Irp_15);
    call {:si_unique_call 1005} Tmp_527 := IofCallDriver(0, Irp_15);
    goto L1;

  L1:
    return;

  anon5_Then:
    assume {:nonnull} irpSp_6 != 0;
    assume irpSp_6 > 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:nonnull} Irp_15 != 0;
    assume Irp_15 > 0;
    status_16 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_15))];
    goto L25;

  L25:
    assume {:nonnull} Irp_15 != 0;
    assume Irp_15 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_15))] := status_16;
    assume {:nonnull} Irp_15 != 0;
    assume Irp_15 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_15))] := 0;
    call {:si_unique_call 1006} IofCompleteRequest(0, 0);
    Tmp_527 := status_16;
    goto L1;

  anon6_Then:
    status_16 := -1073741808;
    goto L25;
}



procedure {:origName "sdv_hash_307580759"} sdv_hash_307580759(actual_Filter_17: int, actual_ControlBlockOffset: int, actual_MaximumDiffAreaSpace: int, actual_ResetSnapshotProtectionMode: int) returns (Tmp_529: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_307580759"} sdv_hash_307580759(actual_Filter_17: int, actual_ControlBlockOffset: int, actual_MaximumDiffAreaSpace: int, actual_ResetSnapshotProtectionMode: int) returns (Tmp_529: int)
{
  var {:pointer} Tmp_530: int;
  var {:scalar} tick_2: int;
  var {:pointer} s_p_e_c_i_a_l_4: int;
  var {:pointer} Tmp_531: int;
  var {:scalar} allocSize: int;
  var {:scalar} byteOffset_1: int;
  var {:pointer} s_p_e_c_i_a_l_5: int;
  var {:pointer} buffer_3: int;
  var {:scalar} sdv_339: int;
  var {:pointer} startBlock: int;
  var {:pointer} irp_5: int;
  var {:scalar} ioStatus_2: int;
  var {:scalar} status_17: int;
  var {:pointer} Tmp_533: int;
  var {:scalar} event_4: int;
  var {:pointer} Filter_17: int;
  var {:scalar} ControlBlockOffset: int;
  var {:scalar} MaximumDiffAreaSpace: int;
  var {:scalar} ResetSnapshotProtectionMode: int;
  var vslice_dummy_var_237: int;
  var vslice_dummy_var_238: int;
  var vslice_dummy_var_1258: int;
  var vslice_dummy_var_1259: int;

  anon0:
    call {:si_unique_call 1007} tick_2 := __HAVOC_malloc(20);
    call {:si_unique_call 1008} byteOffset_1 := __HAVOC_malloc(20);
    call {:si_unique_call 1009} ioStatus_2 := __HAVOC_malloc(12);
    call {:si_unique_call 1010} event_4 := __HAVOC_malloc(124);
    Filter_17 := actual_Filter_17;
    ControlBlockOffset := actual_ControlBlockOffset;
    MaximumDiffAreaSpace := actual_MaximumDiffAreaSpace;
    ResetSnapshotProtectionMode := actual_ResetSnapshotProtectionMode;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    Tmp_529 := -1073741811;
    goto L1;

  L1:
    return;

  anon33_Then:
    allocSize := 8192;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} 4096 > allocSize;
    allocSize := 4096;
    goto L19;

  L19:
    call {:si_unique_call 1011} buffer_3 := ExAllocatePoolWithTag(0, allocSize, -497848490);
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} buffer_3 != 0;
    call {:si_unique_call 1012} KeInitializeEvent(event_4, 0, 0);
    assume {:nonnull} byteOffset_1 != 0;
    assume byteOffset_1 > 0;
    call {:si_unique_call 1013} irp_5 := IoBuildSynchronousFsdRequest(3, 0, 0, 8192, 0, 0, ioStatus_2);
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} irp_5 != 0;
    Tmp_531 := KeTickCount;
    assume {:nonnull} Tmp_531 != 0;
    assume Tmp_531 > 0;
    havoc s_p_e_c_i_a_l_4;
    goto L41;

  L41:
    call {:si_unique_call 1014} sdv_hash_307580759_loop_L41(tick_2, s_p_e_c_i_a_l_4);
    goto L41_last;

  L41_last:
    assume {:nonnull} s_p_e_c_i_a_l_4 != 0;
    assume s_p_e_c_i_a_l_4 > 0;
    assume {:nonnull} tick_2 != 0;
    assume tick_2 > 0;
    assume {:nonnull} s_p_e_c_i_a_l_4 != 0;
    assume s_p_e_c_i_a_l_4 > 0;
    assume {:nonnull} tick_2 != 0;
    assume tick_2 > 0;
    assume {:nonnull} s_p_e_c_i_a_l_4 != 0;
    assume s_p_e_c_i_a_l_4 > 0;
    assume {:nonnull} tick_2 != 0;
    assume tick_2 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    call {:si_unique_call 1015} status_17 := IofCallDriver(0, irp_5);
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} status_17 == 259;
    call {:si_unique_call 1016} vslice_dummy_var_237 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_2 != 0;
    assume ioStatus_2 > 0;
    status_17 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(ioStatus_2)];
    goto L53;

  L53:
    assume {:nonnull} tick_2 != 0;
    assume tick_2 > 0;
    havoc vslice_dummy_var_1258;
    call {:si_unique_call 1017} sdv_hash_403736888(Filter_17, 1, 3, 0, 8192, vslice_dummy_var_1258, 0);
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} status_17 >= 0;
    call {:si_unique_call 1018} sdv_339 := sdv_hash_1053884949(Filter_17, buffer_3);
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} sdv_339 != 0;
    startBlock := buffer_3;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} MaximumDiffAreaSpace == -1;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    goto L83;

  L83:
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    havoc Tmp_533;
    assume {:nonnull} Tmp_533 != 0;
    assume Tmp_533 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Tmp_533 != 0;
    assume Tmp_533 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Tmp_533 != 0;
    assume Tmp_533 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Tmp_533 != 0;
    assume Tmp_533 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    goto L85;

  L85:
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} ResetSnapshotProtectionMode == 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    goto L94;

  L94:
    call {:si_unique_call 1019} KeInitializeEvent(event_4, 0, 0);
    assume {:nonnull} byteOffset_1 != 0;
    assume byteOffset_1 > 0;
    call {:si_unique_call 1020} irp_5 := IoBuildSynchronousFsdRequest(4, 0, 0, 8192, 0, 0, ioStatus_2);
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} irp_5 != 0;
    Tmp_530 := KeTickCount;
    assume {:nonnull} Tmp_530 != 0;
    assume Tmp_530 > 0;
    havoc s_p_e_c_i_a_l_5;
    goto L109;

  L109:
    call {:si_unique_call 1021} sdv_hash_307580759_loop_L109(tick_2, s_p_e_c_i_a_l_5);
    goto L109_last;

  L109_last:
    assume {:nonnull} s_p_e_c_i_a_l_5 != 0;
    assume s_p_e_c_i_a_l_5 > 0;
    assume {:nonnull} tick_2 != 0;
    assume tick_2 > 0;
    assume {:nonnull} s_p_e_c_i_a_l_5 != 0;
    assume s_p_e_c_i_a_l_5 > 0;
    assume {:nonnull} tick_2 != 0;
    assume tick_2 > 0;
    assume {:nonnull} s_p_e_c_i_a_l_5 != 0;
    assume s_p_e_c_i_a_l_5 > 0;
    assume {:nonnull} tick_2 != 0;
    assume tick_2 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    call {:si_unique_call 1022} status_17 := IofCallDriver(0, irp_5);
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} status_17 == 259;
    call {:si_unique_call 1023} vslice_dummy_var_238 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_2 != 0;
    assume ioStatus_2 > 0;
    status_17 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(ioStatus_2)];
    goto L121;

  L121:
    assume {:nonnull} tick_2 != 0;
    assume tick_2 > 0;
    havoc vslice_dummy_var_1259;
    call {:si_unique_call 1024} sdv_hash_403736888(Filter_17, 2, 4, 0, 8192, vslice_dummy_var_1259, 0);
    call {:si_unique_call 1025} ExFreePoolWithTag(0, 0);
    Tmp_529 := status_17;
    goto L1;

  anon42_Then:
    assume {:partition} status_17 != 259;
    goto L121;

  anon48_Then:
    goto anon48_Then_dummy;

  anon48_Then_dummy:
    assume false;
    return;

  anon41_Then:
    assume {:partition} irp_5 == 0;
    call {:si_unique_call 1026} ExFreePoolWithTag(0, 0);
    Tmp_529 := -1073741670;
    goto L1;

  anon40_Then:
    assume {:partition} ResetSnapshotProtectionMode != 0;
    goto L91;

  L91:
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    goto L94;

  anon47_Then:
    goto L91;

  anon46_Then:
    goto L85;

  anon39_Then:
    assume {:nonnull} Filter_17 != 0;
    assume Filter_17 > 0;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    goto L83;

  anon45_Then:
    assume {:partition} MaximumDiffAreaSpace != -1;
    assume {:nonnull} startBlock != 0;
    assume startBlock > 0;
    goto L83;

  anon38_Then:
    assume {:partition} sdv_339 == 0;
    call {:si_unique_call 1027} ExFreePoolWithTag(0, 0);
    Tmp_529 := 0;
    goto L1;

  anon37_Then:
    assume {:partition} 0 > status_17;
    call {:si_unique_call 1028} ExFreePoolWithTag(0, 0);
    Tmp_529 := status_17;
    goto L1;

  anon36_Then:
    assume {:partition} status_17 != 259;
    goto L53;

  anon44_Then:
    goto anon44_Then_dummy;

  anon44_Then_dummy:
    assume false;
    return;

  anon35_Then:
    assume {:partition} irp_5 == 0;
    call {:si_unique_call 1029} ExFreePoolWithTag(0, 0);
    Tmp_529 := -1073741670;
    goto L1;

  anon34_Then:
    assume {:partition} buffer_3 == 0;
    Tmp_529 := -1073741670;
    goto L1;

  anon43_Then:
    assume {:partition} allocSize >= 4096;
    goto L19;
}



procedure {:origName "sdv_hash_672018212"} sdv_hash_672018212(actual_Extension_9: int, actual_QueueType_1: int) returns (Tmp_534: int);
  free ensures Tmp_534 == 8 || Tmp_534 == 6 || Tmp_534 == 7 || Tmp_534 == 5 || Tmp_534 == actual_QueueType_1;



implementation {:origName "sdv_hash_672018212"} sdv_hash_672018212(actual_Extension_9: int, actual_QueueType_1: int) returns (Tmp_534: int)
{
  var {:scalar} n: int;
  var {:pointer} Tmp_535: int;
  var {:pointer} filter_9: int;
  var {:pointer} Extension_9: int;
  var {:scalar} QueueType_1: int;

  anon0:
    Extension_9 := actual_Extension_9;
    QueueType_1 := actual_QueueType_1;
    n := 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} QueueType_1 != 2;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} QueueType_1 != 1;
    goto L13;

  L13:
    Tmp_534 := QueueType_1;
    return;

  anon20_Then:
    assume {:partition} QueueType_1 == 1;
    goto L10;

  L10:
    assume {:nonnull} Extension_9 != 0;
    assume Extension_9 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    filter_9 := Extension_9;
    goto L16;

  L16:
    assume {:nonnull} filter_9 != 0;
    assume filter_9 > 0;
    havoc n;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} n != 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} QueueType_1 == 2;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} n != 1;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} n == 2;
    QueueType_1 := 8;
    goto L13;

  anon24_Then:
    assume {:partition} n != 2;
    goto L13;

  anon23_Then:
    assume {:partition} n == 1;
    QueueType_1 := 6;
    goto L13;

  anon21_Then:
    assume {:partition} QueueType_1 != 2;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} n != 1;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} n == 2;
    QueueType_1 := 7;
    goto L13;

  anon25_Then:
    assume {:partition} n != 2;
    goto L13;

  anon22_Then:
    assume {:partition} n == 1;
    QueueType_1 := 5;
    goto L13;

  anon27_Then:
    assume {:partition} n == 0;
    goto L13;

  anon19_Then:
    Tmp_535 := Extension_9;
    assume {:nonnull} Tmp_535 != 0;
    assume Tmp_535 > 0;
    havoc filter_9;
    goto L16;

  anon26_Then:
    assume {:partition} QueueType_1 == 2;
    goto L10;
}



procedure {:origName "sdv_hash_414123790"} sdv_hash_414123790(actual_RootExtension_7: int, actual_SnapshotGuid_1: int, actual_SnapshotOrDiffAreaFilter: int) returns (Tmp_537: int);
  modifies alloc;



implementation {:origName "sdv_hash_414123790"} sdv_hash_414123790(actual_RootExtension_7: int, actual_SnapshotGuid_1: int, actual_SnapshotOrDiffAreaFilter: int) returns (Tmp_537: int)
{
  var {:pointer} lookupEntry: int;
  var {:pointer} sdv_344: int;
  var {:scalar} lookupEntryBuffer: int;
  var {:scalar} sdv_346: int;
  var {:pointer} l_7: int;
  var {:scalar} sdv_348: int;
  var {:pointer} SnapshotGuid_1: int;
  var {:pointer} SnapshotOrDiffAreaFilter: int;
  var vslice_dummy_var_239: int;
  var vslice_dummy_var_240: int;
  var vslice_dummy_var_241: int;
  var vslice_dummy_var_242: int;
  var vslice_dummy_var_243: int;

  anon0:
    call {:si_unique_call 1030} lookupEntryBuffer := __HAVOC_malloc(152);
    SnapshotGuid_1 := actual_SnapshotGuid_1;
    SnapshotOrDiffAreaFilter := actual_SnapshotOrDiffAreaFilter;
    assume {:nonnull} SnapshotGuid_1 != 0;
    assume SnapshotGuid_1 > 0;
    assume {:nonnull} lookupEntryBuffer != 0;
    assume lookupEntryBuffer > 0;
    assume {:nonnull} SnapshotGuid_1 != 0;
    assume SnapshotGuid_1 > 0;
    assume {:nonnull} lookupEntryBuffer != 0;
    assume lookupEntryBuffer > 0;
    assume {:nonnull} SnapshotGuid_1 != 0;
    assume SnapshotGuid_1 > 0;
    assume {:nonnull} lookupEntryBuffer != 0;
    assume lookupEntryBuffer > 0;
    assume {:nonnull} SnapshotGuid_1 != 0;
    assume SnapshotGuid_1 > 0;
    assume {:nonnull} lookupEntryBuffer != 0;
    assume lookupEntryBuffer > 0;
    call {:si_unique_call 1031} vslice_dummy_var_243 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    sdv_344 := 0;
    goto L16;

  L16:
    lookupEntry := sdv_344;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} lookupEntry != 0;
    assume {:nonnull} lookupEntry != 0;
    assume lookupEntry > 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    goto L21;

  L21:
    call {:si_unique_call 1032} vslice_dummy_var_239 := KeReleaseMutex(0, 0);
    Tmp_537 := lookupEntry;
    goto L1;

  L1:
    return;

  anon22_Then:
    assume {:nonnull} lookupEntry != 0;
    assume lookupEntry > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    goto L21;

  anon23_Then:
    goto L18;

  L18:
    assume {:nonnull} SnapshotOrDiffAreaFilter != 0;
    assume SnapshotOrDiffAreaFilter > 0;
    havoc l_7;
    goto L25;

  L25:
    call {:si_unique_call 1033} lookupEntry, sdv_346, l_7 := sdv_hash_414123790_loop_L25(lookupEntry, sdv_346, l_7, SnapshotGuid_1);
    goto L25_last;

  L25_last:
    goto anon24_Then, anon24_Else;

  anon24_Else:
    lookupEntry := l_7;
    assume {:nonnull} lookupEntry != 0;
    assume lookupEntry > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:nonnull} lookupEntry != 0;
    assume lookupEntry > 0;
    call {:si_unique_call 1034} sdv_346 := IsEqualGUID(OriginalSnapshotGuid__VSP_LOOKUP_TABLE_ENTRY(lookupEntry), SnapshotGuid_1);
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} sdv_346 != 0;
    call {:si_unique_call 1035} vslice_dummy_var_240 := KeReleaseMutex(0, 0);
    Tmp_537 := lookupEntry;
    goto L1;

  anon25_Then:
    assume {:partition} sdv_346 == 0;
    goto L29;

  L29:
    assume {:nonnull} l_7 != 0;
    assume l_7 > 0;
    havoc l_7;
    goto L29_dummy;

  L29_dummy:
    assume false;
    return;

  anon29_Then:
    goto L29;

  anon24_Then:
    assume {:nonnull} SnapshotOrDiffAreaFilter != 0;
    assume SnapshotOrDiffAreaFilter > 0;
    havoc l_7;
    goto L38;

  L38:
    call {:si_unique_call 1036} lookupEntry, l_7, sdv_348 := sdv_hash_414123790_loop_L38(lookupEntry, l_7, sdv_348, SnapshotGuid_1);
    goto L38_last;

  L38_last:
    goto anon26_Then, anon26_Else;

  anon26_Else:
    lookupEntry := l_7;
    assume {:nonnull} lookupEntry != 0;
    assume lookupEntry > 0;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:nonnull} lookupEntry != 0;
    assume lookupEntry > 0;
    call {:si_unique_call 1037} sdv_348 := IsEqualGUID(OriginalSnapshotGuid__VSP_LOOKUP_TABLE_ENTRY(lookupEntry), SnapshotGuid_1);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} sdv_348 != 0;
    call {:si_unique_call 1038} vslice_dummy_var_242 := KeReleaseMutex(0, 0);
    Tmp_537 := lookupEntry;
    goto L1;

  anon27_Then:
    assume {:partition} sdv_348 == 0;
    goto L44;

  L44:
    assume {:nonnull} l_7 != 0;
    assume l_7 > 0;
    havoc l_7;
    goto L44_dummy;

  L44_dummy:
    assume false;
    return;

  anon30_Then:
    goto L44;

  anon26_Then:
    call {:si_unique_call 1039} vslice_dummy_var_241 := KeReleaseMutex(0, 0);
    Tmp_537 := 0;
    goto L1;

  anon28_Then:
    assume {:partition} lookupEntry == 0;
    goto L18;

  anon21_Then:
    call {:si_unique_call 1040} sdv_344 := __HAVOC_malloc(1);
    goto L16;
}



procedure {:origName "sdv_hash_210112601"} sdv_hash_210112601(actual_Filter_18: int, actual_ListOfDiffAreaFilesToClose: int, actual_LisfOfDeviceObjectsToDelete: int, actual_KeepOnDisk: int, actual_DontWakePnp: int, actual_DeleteNewest: int) returns (Tmp_539: int);
  modifies alloc, ref, Mem_T.Type_unnamed_tag_26, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures Tmp_539 == -1073741811 || Tmp_539 == 0;



implementation {:origName "sdv_hash_210112601"} sdv_hash_210112601(actual_Filter_18: int, actual_ListOfDiffAreaFilesToClose: int, actual_LisfOfDeviceObjectsToDelete: int, actual_KeepOnDisk: int, actual_DontWakePnp: int, actual_DeleteNewest: int) returns (Tmp_539: int)
{
  var {:scalar} sdv_350: int;
  var {:pointer} filter_10: int;
  var {:pointer} l_8: int;
  var {:pointer} Tmp_544: int;
  var {:scalar} irql_16: int;
  var {:pointer} extension_3: int;
  var {:pointer} Filter_18: int;
  var {:pointer} ListOfDiffAreaFilesToClose: int;
  var {:pointer} LisfOfDeviceObjectsToDelete: int;
  var {:scalar} KeepOnDisk: int;
  var {:scalar} DontWakePnp: int;
  var {:scalar} DeleteNewest: int;
  var vslice_dummy_var_244: int;
  var vslice_dummy_var_245: int;
  var vslice_dummy_var_246: int;
  var vslice_dummy_var_247: int;
  var vslice_dummy_var_248: int;
  var vslice_dummy_var_1260: int;

  anon0:
    Filter_18 := actual_Filter_18;
    ListOfDiffAreaFilesToClose := actual_ListOfDiffAreaFilesToClose;
    LisfOfDeviceObjectsToDelete := actual_LisfOfDeviceObjectsToDelete;
    KeepOnDisk := actual_KeepOnDisk;
    DontWakePnp := actual_DontWakePnp;
    DeleteNewest := actual_DeleteNewest;
    filter_10 := Filter_18;
    assume {:nonnull} filter_10 != 0;
    assume filter_10 > 0;
    call {:si_unique_call 1041} sdv_350 := IsListEmpty(VolumeList_FILTER_EXTENSION(filter_10));
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} sdv_350 != 0;
    Tmp_539 := -1073741811;
    goto L1;

  L1:
    return;

  anon9_Then:
    assume {:partition} sdv_350 == 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} DeleteNewest != 0;
    assume {:nonnull} filter_10 != 0;
    assume filter_10 > 0;
    havoc l_8;
    goto L19;

  L19:
    extension_3 := l_8;
    call {:si_unique_call 1042} irql_16 := KfAcquireSpinLock(0);
    call {:si_unique_call 1043} KfReleaseSpinLock(0, irql_16);
    call {:si_unique_call 1044} sdv_hash_280759867(extension_3);
    call {:si_unique_call 1045} sdv_hash_802123720(extension_3);
    call {:si_unique_call 1046} sdv_hash_1048709922(filter_10);
    assume {:nonnull} extension_3 != 0;
    assume extension_3 > 0;
    call {:si_unique_call 1047} vslice_dummy_var_247 := ObfReferenceObject(0);
    call {:si_unique_call 1048} irql_16 := KfAcquireSpinLock(0);
    assume {:nonnull} extension_3 != 0;
    assume extension_3 > 0;
    call {:si_unique_call 1049} vslice_dummy_var_244 := RemoveEntryList(ListEntry_VOLUME_EXTENSION(extension_3));
    assume {:nonnull} filter_10 != 0;
    assume filter_10 > 0;
    call {:si_unique_call 1050} vslice_dummy_var_245 := IsListEmpty(VolumeList_FILTER_EXTENSION(filter_10));
    call {:si_unique_call 1051} KfReleaseSpinLock(0, irql_16);
    call {:si_unique_call 1052} sdv_hash_242852003(filter_10);
    call {:si_unique_call 1053} sdv_hash_172139115(extension_3, ListOfDiffAreaFilesToClose, KeepOnDisk);
    assume {:nonnull} extension_3 != 0;
    assume extension_3 > 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:nonnull} extension_3 != 0;
    assume extension_3 > 0;
    assume {:nonnull} filter_10 != 0;
    assume filter_10 > 0;
    call {:si_unique_call 1054} InsertTailList(DeadVolumeList_FILTER_EXTENSION(filter_10), ListEntry_VOLUME_EXTENSION(extension_3));
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} DontWakePnp != 0;
    goto L82;

  L82:
    assume {:nonnull} extension_3 != 0;
    assume extension_3 > 0;
    call {:si_unique_call 1055} InsertTailList(LisfOfDeviceObjectsToDelete, AnotherListEntry_VOLUME_EXTENSION(extension_3));
    Tmp_539 := 0;
    goto L1;

  anon12_Then:
    assume {:partition} DontWakePnp == 0;
    call {:si_unique_call 1056} IoInvalidateDeviceRelations(0, 0);
    goto L82;

  anon11_Then:
    assume {:nonnull} filter_10 != 0;
    assume filter_10 > 0;
    Tmp_544 := DEVICE_EXTENSION_FILTER_EXTENSION(filter_10);
    assume {:nonnull} Tmp_544 != 0;
    assume Tmp_544 > 0;
    call {:si_unique_call 1057} vslice_dummy_var_248 := corral_nondet();
    assume {:nonnull} extension_3 != 0;
    assume extension_3 > 0;
    havoc vslice_dummy_var_1260;
    call {:si_unique_call 1058} sdv_hash_826125959(vslice_dummy_var_1260);
    call {:si_unique_call 1059} vslice_dummy_var_246 := IoDeleteSymbolicLink(0);
    assume {:nonnull} extension_3 != 0;
    assume extension_3 > 0;
    call {:si_unique_call 1060} ExFreePoolWithTag(0, 0);
    call {:si_unique_call 1061} IoDeleteDevice(0);
    goto L82;

  anon10_Then:
    assume {:partition} DeleteNewest == 0;
    assume {:nonnull} filter_10 != 0;
    assume filter_10 > 0;
    havoc l_8;
    goto L19;
}



procedure {:origName "IsEqualGUID"} IsEqualGUID(actual_rguid1: int, actual_rguid2: int) returns (Tmp_545: int);
  free ensures Tmp_545 == 0 || Tmp_545 == 1;



implementation {:origName "IsEqualGUID"} IsEqualGUID(actual_rguid1: int, actual_rguid2: int) returns (Tmp_545: int)
{
  var {:scalar} sdv_361: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} sdv_361 != 0;
    Tmp_545 := 0;
    goto L10;

  L10:
    return;

  anon3_Then:
    assume {:partition} sdv_361 == 0;
    Tmp_545 := 1;
    goto L10;
}



procedure {:origName "IoCopyCurrentIrpStackLocationToNext"} IoCopyCurrentIrpStackLocationToNext(actual_Irp_16: int);
  modifies alloc;



implementation {:origName "IoCopyCurrentIrpStackLocationToNext"} IoCopyCurrentIrpStackLocationToNext(actual_Irp_16: int)
{
  var {:pointer} nextIrpSp: int;
  var {:pointer} Irp_16: int;
  var vslice_dummy_var_249: int;
  var vslice_dummy_var_250: int;

  anon0:
    call {:si_unique_call 1062} vslice_dummy_var_249 := __HAVOC_malloc(4);
    Irp_16 := actual_Irp_16;
    call {:si_unique_call 1063} vslice_dummy_var_250 := IoGetCurrentIrpStackLocation(Irp_16);
    call {:si_unique_call 1064} nextIrpSp := IoGetNextIrpStackLocation(Irp_16);
    assume {:nonnull} nextIrpSp != 0;
    assume nextIrpSp > 0;
    return;
}



procedure {:origName "sdv_hash_177085617"} sdv_hash_177085617(actual_Resource_1: int, actual_Filter_19: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26;



implementation {:origName "sdv_hash_177085617"} sdv_hash_177085617(actual_Resource_1: int, actual_Filter_19: int)
{
  var {:pointer} Resource_1: int;
  var {:pointer} Filter_19: int;
  var boogieTmp: int;
  var vslice_dummy_var_251: int;
  var vslice_dummy_var_252: int;

  anon0:
    call {:si_unique_call 1065} vslice_dummy_var_251 := __HAVOC_malloc(4);
    Resource_1 := actual_Resource_1;
    Filter_19 := actual_Filter_19;
    call {:si_unique_call 1066} vslice_dummy_var_252 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} Filter_19 != 0;
    assume Filter_19 > 0;
    call {:si_unique_call 1067} boogieTmp := PsGetCurrentThread();
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} Resource_1 != 0;
    assume {:nonnull} Resource_1 != 0;
    assume Resource_1 > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(Resource_1)] := 3;
    assume {:nonnull} Filter_19 != 0;
    assume Filter_19 > 0;
    assume {:nonnull} Resource_1 != 0;
    assume Resource_1 > 0;
    assume {:nonnull} Resource_1 != 0;
    assume Resource_1 > 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} Resource_1 == 0;
    goto L1;
}



procedure {:origName "sdv_hash_259372028"} sdv_hash_259372028(actual_Extension_10: int, actual_NeedLock_1: int, actual_IsFinalRemove_1: int, actual_DontDeleteDevnode_1: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, ref, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_259372028"} sdv_hash_259372028(actual_Extension_10: int, actual_NeedLock_1: int, actual_IsFinalRemove_1: int, actual_DontDeleteDevnode_1: int)
{
  var {:pointer} context_7: int;
  var {:pointer} Tmp_553: int;
  var {:pointer} Tmp_555: int;
  var {:pointer} Tmp_556: int;
  var {:pointer} root_1: int;
  var {:pointer} Tmp_560: int;
  var {:scalar} irql_17: int;
  var {:pointer} Tmp_561: int;
  var {:pointer} Extension_10: int;
  var {:scalar} NeedLock_1: int;
  var {:scalar} IsFinalRemove_1: int;
  var {:scalar} DontDeleteDevnode_1: int;
  var vslice_dummy_var_253: int;
  var vslice_dummy_var_254: int;
  var vslice_dummy_var_255: int;
  var vslice_dummy_var_256: int;
  var vslice_dummy_var_257: int;
  var vslice_dummy_var_258: int;
  var vslice_dummy_var_259: int;
  var vslice_dummy_var_260: int;
  var vslice_dummy_var_261: int;
  var vslice_dummy_var_262: int;
  var vslice_dummy_var_1261: int;
  var vslice_dummy_var_1262: int;
  var vslice_dummy_var_1263: int;
  var vslice_dummy_var_1264: int;

  anon0:
    call {:si_unique_call 1068} vslice_dummy_var_253 := __HAVOC_malloc(4);
    Extension_10 := actual_Extension_10;
    NeedLock_1 := actual_NeedLock_1;
    IsFinalRemove_1 := actual_IsFinalRemove_1;
    DontDeleteDevnode_1 := actual_DontDeleteDevnode_1;
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc root_1;
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    call {:si_unique_call 1069} vslice_dummy_var_254 := sdv_hash_301435450(Extension_10);
    goto L12;

  L12:
    call {:si_unique_call 1070} context_7 := sdv_hash_859757058(root_1);
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} context_7 != 0;
    assume {:nonnull} context_7 != 0;
    assume context_7 > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(context_7)] := 4;
    assume {:nonnull} context_7 != 0;
    assume context_7 > 0;
    assume {:nonnull} context_7 != 0;
    assume context_7 > 0;
    assume {:nonnull} context_7 != 0;
    assume context_7 > 0;
    assume {:nonnull} context_7 != 0;
    assume context_7 > 0;
    assume {:nonnull} context_7 != 0;
    assume context_7 > 0;
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    call {:si_unique_call 1071} vslice_dummy_var_260 := ObfReferenceObject(0);
    assume {:nonnull} context_7 != 0;
    assume context_7 > 0;
    call {:si_unique_call 1072} sdv_hash_1047753544(Extension_10, WorkItem__VSP_CONTEXT(context_7));
    goto L35;

  L35:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} NeedLock_1 != 0;
    call {:si_unique_call 1073} sdv_hash_613687309(root_1);
    goto L36;

  L36:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    call {:si_unique_call 1074} vslice_dummy_var_256 := sdv_hash_899948027(root_1);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto L40;

  L40:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc Tmp_560;
    assume {:nonnull} Tmp_560 != 0;
    assume Tmp_560 > 0;
    call {:si_unique_call 1075} irql_17 := KfAcquireSpinLock(0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc Tmp_556;
    assume {:nonnull} Tmp_556 != 0;
    assume Tmp_556 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc Tmp_555;
    assume {:nonnull} Tmp_555 != 0;
    assume Tmp_555 > 0;
    call {:si_unique_call 1076} vslice_dummy_var_261 := RemoveEntryList(FilterListEntry__VSP_DIFF_AREA_FILE(Tmp_555));
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc Tmp_553;
    assume {:nonnull} Tmp_553 != 0;
    assume Tmp_553 > 0;
    goto L53;

  L53:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc Tmp_561;
    assume {:nonnull} Tmp_561 != 0;
    assume Tmp_561 > 0;
    call {:si_unique_call 1077} KfReleaseSpinLock(0, irql_17);
    goto L45;

  L45:
    call {:si_unique_call 1078} sdv_hash_141061226(Extension_10);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    call {:si_unique_call 1079} vslice_dummy_var_257 := KeSetEvent(PreExposureEvent_VOLUME_EXTENSION(Extension_10), 0, 0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto L61;

  L61:
    call {:si_unique_call 1080} irql_17 := KfAcquireSpinLock(0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc vslice_dummy_var_1261;
    call {:si_unique_call 1081} VspFreeBitMap(vslice_dummy_var_1261);
    call {:si_unique_call 1082} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto L70;

  L70:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc vslice_dummy_var_1262;
    call {:si_unique_call 1083} VspFreeBitMap(vslice_dummy_var_1262);
    call {:si_unique_call 1084} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto L78;

  L78:
    call {:si_unique_call 1085} KfReleaseSpinLock(0, irql_17);
    call {:si_unique_call 1086} sdv_hash_1047753544(Extension_10, 0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    call {:si_unique_call 1087} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto L92;

  L92:
    call {:si_unique_call 1088} sdv_hash_853253100(Extension_10);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc vslice_dummy_var_1263;
    call {:si_unique_call 1089} VspFreeIrp(vslice_dummy_var_1263, 1);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} IsFinalRemove_1 != 0;
    goto L110;

  L110:
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} NeedLock_1 != 0;
    call {:si_unique_call 1090} sdv_hash_986004649(root_1);
    goto L1;

  L1:
    return;

  anon41_Then:
    assume {:partition} NeedLock_1 == 0;
    goto L1;

  anon40_Then:
    assume {:partition} IsFinalRemove_1 == 0;
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    call {:si_unique_call 1091} IoInvalidateDeviceRelations(0, 0);
    goto L110;

  anon45_Then:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} DontDeleteDevnode_1 != 0;
    goto L117;

  L117:
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    havoc vslice_dummy_var_1264;
    call {:si_unique_call 1092} sdv_hash_826125959(vslice_dummy_var_1264);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    call {:si_unique_call 1093} vslice_dummy_var_259 := IoDeleteSymbolicLink(0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    call {:si_unique_call 1094} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto L121;

  L121:
    call {:si_unique_call 1095} IoDeleteDevice(0);
    goto L110;

  anon42_Then:
    goto L121;

  anon39_Then:
    assume {:partition} DontDeleteDevnode_1 == 0;
    call {:si_unique_call 1096} vslice_dummy_var_258 := corral_nondet();
    goto L117;

  anon38_Then:
    goto L92;

  anon37_Then:
    goto L78;

  anon36_Then:
    goto L70;

  anon35_Then:
    goto L61;

  anon44_Then:
    goto L53;

  anon34_Then:
    goto L45;

  anon33_Then:
    goto L40;

  anon32_Then:
    assume {:partition} NeedLock_1 == 0;
    goto L36;

  anon31_Then:
    assume {:partition} context_7 == 0;
    call {:si_unique_call 1097} vslice_dummy_var_255 := ZwUnmapViewOfSection(0, 0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    call {:si_unique_call 1098} vslice_dummy_var_262 := ZwUnmapViewOfSection(0, 0);
    assume {:nonnull} Extension_10 != 0;
    assume Extension_10 > 0;
    goto L35;

  anon43_Then:
    goto L12;
}



procedure {:origName "sdv_hash_1053884949"} sdv_hash_1053884949(actual_Filter_20: int, actual_BootSector: int) returns (Tmp_563: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK;
  free ensures Tmp_563 == 0 || Tmp_563 == 1;



implementation {:origName "sdv_hash_1053884949"} sdv_hash_1053884949(actual_Filter_20: int, actual_BootSector: int) returns (Tmp_563: int)
{
  var {:pointer} Tmp_564: int;
  var {:scalar} sdv_379: int;
  var {:scalar} numSectors: int;
  var {:pointer} p_4: int;
  var {:pointer} Filter_20: int;
  var {:pointer} BootSector: int;

  anon0:
    Filter_20 := actual_Filter_20;
    BootSector := actual_BootSector;
    p_4 := BootSector;
    assume {:nonnull} p_4 != 0;
    assume p_4 > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    goto L11;

  L11:
    Tmp_563 := 0;
    goto L1;

  L1:
    return;

  anon21_Then:
    assume {:nonnull} p_4 != 0;
    assume p_4 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:nonnull} p_4 != 0;
    assume p_4 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:nonnull} p_4 != 0;
    assume p_4 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:nonnull} p_4 != 0;
    assume p_4 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:nonnull} p_4 != 0;
    assume p_4 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    Tmp_564 := p_4;
    assume {:nonnull} Tmp_564 != 0;
    assume Tmp_564 > 0;
    havoc numSectors;
    call {:si_unique_call 1099} sdv_379 := sdv_hash_257967338(Filter_20);
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} numSectors > sdv_379;
    Tmp_563 := 0;
    goto L1;

  anon20_Then:
    assume {:partition} sdv_379 >= numSectors;
    Tmp_563 := 1;
    goto L1;

  anon19_Then:
    goto L11;

  anon18_Then:
    goto L11;

  anon17_Then:
    goto L11;

  anon16_Then:
    goto L11;

  anon15_Then:
    goto L11;
}



procedure {:origName "sdv_hash_916928578"} sdv_hash_916928578(actual_Filter_21: int, actual_TargetObject_3: int, actual_Offset_4: int, actual_Key_3: int, actual_FileObject_3: int) returns (Tmp_566: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_916928578"} sdv_hash_916928578(actual_Filter_21: int, actual_TargetObject_3: int, actual_Offset_4: int, actual_Key_3: int, actual_FileObject_3: int) returns (Tmp_566: int)
{
  var {:pointer} Filter_21: int;
  var {:pointer} TargetObject_3: int;
  var {:scalar} Offset_4: int;
  var {:scalar} Key_3: int;
  var {:pointer} FileObject_3: int;

  anon0:
    Filter_21 := actual_Filter_21;
    TargetObject_3 := actual_TargetObject_3;
    Offset_4 := actual_Offset_4;
    Key_3 := actual_Key_3;
    FileObject_3 := actual_FileObject_3;
    call {:si_unique_call 1100} Tmp_566 := sdv_hash_1005542269(Filter_21, TargetObject_3, 4, Offset_4, Key_3, FileObject_3, 2);
    return;
}



procedure {:origName "sdv_hash_375749048"} sdv_hash_375749048(actual_Filter_22: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_375749048"} sdv_hash_375749048(actual_Filter_22: int)
{
  var {:scalar} irql_18: int;
  var {:pointer} Filter_22: int;
  var vslice_dummy_var_263: int;

  anon0:
    call {:si_unique_call 1101} vslice_dummy_var_263 := __HAVOC_malloc(4);
    Filter_22 := actual_Filter_22;
    assume {:nonnull} Filter_22 != 0;
    assume Filter_22 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:nonnull} Filter_22 != 0;
    assume Filter_22 > 0;
    call {:si_unique_call 1102} irql_18 := KfAcquireSpinLock(0);
    assume {:nonnull} Filter_22 != 0;
    assume Filter_22 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:nonnull} Filter_22 != 0;
    assume Filter_22 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:nonnull} Filter_22 != 0;
    assume Filter_22 > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    call {:si_unique_call 1103} KfReleaseSpinLock(0, irql_18);
    assume {:nonnull} Filter_22 != 0;
    assume Filter_22 > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    call {:si_unique_call 1104} sdv_hash_1048709922(Filter_22);
    goto L31;

  L31:
    call {:si_unique_call 1105} sdv_hash_242852003(Filter_22);
    goto L1;

  L1:
    return;

  anon21_Then:
    assume {:nonnull} Filter_22 != 0;
    assume Filter_22 > 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:nonnull} Filter_22 != 0;
    assume Filter_22 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:nonnull} Filter_22 != 0;
    assume Filter_22 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    call {:si_unique_call 1106} sdv_hash_1048709922(Filter_22);
    goto L31;

  anon24_Then:
    goto L31;

  anon23_Then:
    goto L31;

  anon22_Then:
    goto L31;

  anon20_Then:
    goto L12;

  L12:
    call {:si_unique_call 1107} KfReleaseSpinLock(0, irql_18);
    call {:si_unique_call 1108} sdv_hash_1048709922(Filter_22);
    goto L31;

  anon19_Then:
    goto L12;

  anon18_Then:
    goto L12;

  anon17_Then:
    goto L1;
}



procedure {:origName "sdv_hash_208558080"} sdv_hash_208558080(actual_Filter_23: int, actual_NeedLock_2: int) returns (Tmp_570: int);
  modifies alloc;
  free ensures Tmp_570 == -1073741823 || Tmp_570 == 0;



implementation {:origName "sdv_hash_208558080"} sdv_hash_208558080(actual_Filter_23: int, actual_NeedLock_2: int) returns (Tmp_570: int)
{
  var {:pointer} diffAreaFile_1: int;
  var {:pointer} l_9: int;
  var {:pointer} Tmp_572: int;
  var {:pointer} extension_4: int;
  var {:pointer} Filter_23: int;
  var {:scalar} NeedLock_2: int;
  var vslice_dummy_var_1265: int;
  var vslice_dummy_var_1266: int;
  var vslice_dummy_var_1267: int;

  anon0:
    Filter_23 := actual_Filter_23;
    NeedLock_2 := actual_NeedLock_2;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} NeedLock_2 != 0;
    assume {:nonnull} Filter_23 != 0;
    assume Filter_23 > 0;
    havoc vslice_dummy_var_1265;
    call {:si_unique_call 1109} sdv_hash_613687309(vslice_dummy_var_1265);
    goto L10;

  L10:
    assume {:nonnull} Filter_23 != 0;
    assume Filter_23 > 0;
    havoc l_9;
    goto L14;

  L14:
    call {:si_unique_call 1110} diffAreaFile_1, l_9, Tmp_572, extension_4 := sdv_hash_208558080_loop_L14(diffAreaFile_1, l_9, Tmp_572, extension_4, Filter_23);
    goto L14_last;

  L14_last:
    goto anon14_Then, anon14_Else;

  anon14_Else:
    diffAreaFile_1 := l_9;
    assume {:nonnull} diffAreaFile_1 != 0;
    assume diffAreaFile_1 > 0;
    havoc extension_4;
    assume {:nonnull} extension_4 != 0;
    assume extension_4 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:nonnull} extension_4 != 0;
    assume extension_4 > 0;
    havoc Tmp_572;
    assume {:nonnull} Tmp_572 != 0;
    assume Tmp_572 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} NeedLock_2 != 0;
    assume {:nonnull} Filter_23 != 0;
    assume Filter_23 > 0;
    havoc vslice_dummy_var_1266;
    call {:si_unique_call 1111} sdv_hash_986004649(vslice_dummy_var_1266);
    goto L22;

  L22:
    Tmp_570 := -1073741823;
    goto L1;

  L1:
    return;

  anon16_Then:
    assume {:partition} NeedLock_2 == 0;
    goto L22;

  anon18_Then:
    goto L19;

  L19:
    assume {:nonnull} l_9 != 0;
    assume l_9 > 0;
    havoc l_9;
    goto L19_dummy;

  L19_dummy:
    assume false;
    return;

  anon17_Then:
    goto L19;

  anon14_Then:
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} NeedLock_2 != 0;
    assume {:nonnull} Filter_23 != 0;
    assume Filter_23 > 0;
    havoc vslice_dummy_var_1267;
    call {:si_unique_call 1112} sdv_hash_986004649(vslice_dummy_var_1267);
    goto L26;

  L26:
    Tmp_570 := 0;
    goto L1;

  anon15_Then:
    assume {:partition} NeedLock_2 == 0;
    goto L26;

  anon13_Then:
    assume {:partition} NeedLock_2 == 0;
    goto L10;
}



procedure {:origName "sdv_hash_280759867"} sdv_hash_280759867(actual_Extension_11: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_280759867"} sdv_hash_280759867(actual_Extension_11: int)
{
  var {:scalar} irql_19: int;
  var {:pointer} Extension_11: int;
  var vslice_dummy_var_264: int;
  var vslice_dummy_var_265: int;
  var vslice_dummy_var_1268: int;

  anon0:
    call {:si_unique_call 1113} vslice_dummy_var_264 := __HAVOC_malloc(4);
    Extension_11 := actual_Extension_11;
    assume {:nonnull} Extension_11 != 0;
    assume Extension_11 > 0;
    havoc vslice_dummy_var_1268;
    call {:si_unique_call 1114} sdv_hash_890975460(vslice_dummy_var_1268);
    call {:si_unique_call 1115} irql_19 := KfAcquireSpinLock(0);
    assume {:nonnull} Extension_11 != 0;
    assume Extension_11 > 0;
    call {:si_unique_call 1116} KeInitializeEvent(ZeroRefEvent_VOLUME_EXTENSION(Extension_11), 0, 0);
    call {:si_unique_call 1117} KfReleaseSpinLock(0, irql_19);
    call {:si_unique_call 1118} sdv_hash_224765598(Extension_11);
    call {:si_unique_call 1119} vslice_dummy_var_265 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    return;
}



procedure {:origName "sdv_hash_1047753544"} sdv_hash_1047753544(actual_Extension_12: int, actual_WorkItem_3: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26;



implementation {:origName "sdv_hash_1047753544"} sdv_hash_1047753544(actual_Extension_12: int, actual_WorkItem_3: int)
{
  var {:scalar} synchronousCall_1: int;
  var {:scalar} context_8: int;
  var {:pointer} filter_11: int;
  var {:scalar} sdv_389: int;
  var {:pointer} parameter_1: int;
  var {:scalar} routine_1: int;
  var {:scalar} irql_20: int;
  var {:pointer} Extension_12: int;
  var {:pointer} WorkItem_3: int;
  var vslice_dummy_var_266: int;
  var vslice_dummy_var_267: int;
  var vslice_dummy_var_1269: int;

  anon0:
    call {:si_unique_call 1120} context_8 := __HAVOC_malloc(2204);
    call {:si_unique_call 1121} vslice_dummy_var_266 := __HAVOC_malloc(4);
    Extension_12 := actual_Extension_12;
    WorkItem_3 := actual_WorkItem_3;
    assume {:nonnull} Extension_12 != 0;
    assume Extension_12 > 0;
    havoc filter_11;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} WorkItem_3 != 0;
    synchronousCall_1 := 0;
    goto L16;

  L16:
    call {:si_unique_call 1122} irql_20 := KfAcquireSpinLock(0);
    assume {:nonnull} filter_11 != 0;
    assume filter_11 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:nonnull} WorkItem_3 != 0;
    assume WorkItem_3 > 0;
    assume {:nonnull} filter_11 != 0;
    assume filter_11 > 0;
    call {:si_unique_call 1123} InsertTailList(PagedResourceList_FILTER_EXTENSION(filter_11), List__WORK_QUEUE_ITEM(WorkItem_3));
    call {:si_unique_call 1124} KfReleaseSpinLock(0, irql_20);
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} synchronousCall_1 != 0;
    call {:si_unique_call 1125} vslice_dummy_var_267 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto L1;

  L1:
    return;

  anon14_Then:
    assume {:partition} synchronousCall_1 == 0;
    goto L1;

  anon13_Then:
    assume {:nonnull} filter_11 != 0;
    assume filter_11 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} synchronousCall_1 != 0;
    goto L35;

  L35:
    call {:si_unique_call 1126} KfReleaseSpinLock(0, irql_20);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} synchronousCall_1 == 0;
    assume {:nonnull} WorkItem_3 != 0;
    assume WorkItem_3 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    call {:si_unique_call 1127} sdv_389 := sdv_hash_672018212(Extension_12, 1);
    assume {:nonnull} filter_11 != 0;
    assume filter_11 > 0;
    havoc vslice_dummy_var_1269;
    call {:si_unique_call 1128} sdv_hash_21074203(vslice_dummy_var_1269, WorkItem_3, sdv_389);
    goto L1;

  anon16_Then:
    assume {:nonnull} WorkItem_3 != 0;
    assume WorkItem_3 > 0;
    havoc routine_1;
    assume {:nonnull} WorkItem_3 != 0;
    assume WorkItem_3 > 0;
    havoc parameter_1;
    assume {:nonnull} WorkItem_3 != 0;
    assume WorkItem_3 > 0;
    assume {:nonnull} WorkItem_3 != 0;
    assume WorkItem_3 > 0;
    assume {:nonnull} WorkItem_3 != 0;
    assume WorkItem_3 > 0;
    goto L1;

  anon15_Then:
    assume {:partition} synchronousCall_1 != 0;
    goto L1;

  anon18_Then:
    assume {:partition} synchronousCall_1 == 0;
    assume {:nonnull} filter_11 != 0;
    assume filter_11 > 0;
    goto L35;

  anon17_Then:
    assume {:partition} WorkItem_3 == 0;
    assume {:nonnull} context_8 != 0;
    assume context_8 > 0;
    WorkItem_3 := WorkItem__VSP_CONTEXT(context_8);
    assume {:nonnull} context_8 != 0;
    assume context_8 > 0;
    Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(context_8)] := 7;
    assume {:nonnull} context_8 != 0;
    assume context_8 > 0;
    call {:si_unique_call 1129} KeInitializeEvent(Event_sdv_hash_70411571(Event__VSP_CONTEXT(context_8)), 0, 0);
    assume {:nonnull} context_8 != 0;
    assume context_8 > 0;
    assume {:nonnull} context_8 != 0;
    assume context_8 > 0;
    assume {:nonnull} context_8 != 0;
    assume context_8 > 0;
    synchronousCall_1 := 1;
    goto L16;
}



procedure {:origName "sdv_hash_997443178"} sdv_hash_997443178(actual_TimerDpc_1: int, actual_Context_7: int, actual_SystemArgument1_1: int, actual_SystemArgument2_1: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_997443178"} sdv_hash_997443178(actual_TimerDpc_1: int, actual_Context_7: int, actual_SystemArgument1_1: int, actual_SystemArgument2_1: int)
{
  var {:pointer} context_9: int;
  var {:scalar} sdv_391: int;
  var {:pointer} filter_12: int;
  var {:pointer} l_10: int;
  var {:scalar} irql_21: int;
  var {:pointer} Context_7: int;
  var vslice_dummy_var_268: int;
  var vslice_dummy_var_269: int;
  var vslice_dummy_var_270: int;
  var vslice_dummy_var_1270: int;

  anon0:
    call {:si_unique_call 1130} vslice_dummy_var_268 := __HAVOC_malloc(4);
    Context_7 := actual_Context_7;
    context_9 := Context_7;
    assume {:nonnull} context_9 != 0;
    assume context_9 > 0;
    havoc filter_12;
    call {:si_unique_call 1131} irql_21 := KfAcquireSpinLock(0);
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    call {:si_unique_call 1132} KfReleaseSpinLock(0, irql_21);
    assume {:nonnull} context_9 != 0;
    assume context_9 > 0;
    call {:si_unique_call 1133} ExFreePoolWithTag(0, 0);
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    havoc vslice_dummy_var_1270;
    call {:si_unique_call 1134} sdv_hash_493014447(vslice_dummy_var_1270, context_9);
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    call {:si_unique_call 1135} irql_21 := KfAcquireSpinLock(0);
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    goto L39;

  L39:
    call {:si_unique_call 1136} KfReleaseSpinLock(0, irql_21);
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    call {:si_unique_call 1137} vslice_dummy_var_270 := ObfDereferenceObject(0);
    goto L1;

  L1:
    return;

  anon16_Then:
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    goto L49;

  L49:
    call {:si_unique_call 1138} sdv_391, l_10 := sdv_hash_997443178_loop_L49(sdv_391, filter_12, l_10);
    goto L49_last;

  L49_last:
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    call {:si_unique_call 1144} sdv_391 := IsListEmpty(CopyOnWriteList_FILTER_EXTENSION(filter_12));
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} sdv_391 != 0;
    call {:si_unique_call 1139} KfReleaseSpinLock(0, irql_21);
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    goto L1;

  anon18_Then:
    assume {:partition} sdv_391 == 0;
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    call {:si_unique_call 1140} l_10 := RemoveHeadList(CopyOnWriteList_FILTER_EXTENSION(filter_12));
    call {:si_unique_call 1141} ExFreePoolWithTag(0, 0);
    call {:si_unique_call 1142} ExFreePoolWithTag(0, 0);
    goto anon18_Then_dummy;

  anon18_Then_dummy:
    assume false;
    return;

  anon17_Then:
    goto L39;

  anon15_Then:
    goto L28;

  L28:
    assume {:nonnull} filter_12 != 0;
    assume filter_12 > 0;
    call {:si_unique_call 1143} vslice_dummy_var_269 := ObfDereferenceObject(0);
    goto L1;

  anon14_Then:
    goto L28;

  anon13_Then:
    goto L28;
}



procedure {:origName "sdv_hash_364468681"} sdv_hash_364468681(actual_RootExtension_8: int, actual_TempTableEntry: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26;



implementation {:origName "sdv_hash_364468681"} sdv_hash_364468681(actual_RootExtension_8: int, actual_TempTableEntry: int)
{
  var {:pointer} workItem_2: int;
  var {:pointer} context_10: int;
  var {:pointer} Tmp_582: int;
  var {:scalar} sdv_400: int;
  var {:scalar} sdv_404: int;
  var {:pointer} Tmp_583: int;
  var {:pointer} l_11: int;
  var {:pointer} tableEntry_1: int;
  var {:scalar} irql_22: int;
  var {:pointer} RootExtension_8: int;
  var {:pointer} TempTableEntry: int;
  var vslice_dummy_var_271: int;
  var vslice_dummy_var_1271: int;
  var vslice_dummy_var_1272: int;

  anon0:
    call {:si_unique_call 1145} vslice_dummy_var_271 := __HAVOC_malloc(4);
    RootExtension_8 := actual_RootExtension_8;
    TempTableEntry := actual_TempTableEntry;
    tableEntry_1 := TempTableEntry;
    assume {:nonnull} RootExtension_8 != 0;
    assume RootExtension_8 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:nonnull} RootExtension_8 != 0;
    assume RootExtension_8 > 0;
    call {:si_unique_call 1146} ExFreeToNPagedLookasideList(TempTableEntryLookasideList__DO_EXTENSION(RootExtension_8), tableEntry_1);
    assume {:nonnull} RootExtension_8 != 0;
    assume RootExtension_8 > 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    call {:si_unique_call 1147} irql_22 := KfAcquireSpinLock(0);
    assume {:nonnull} RootExtension_8 != 0;
    assume RootExtension_8 > 0;
    call {:si_unique_call 1148} sdv_400 := IsListEmpty(WorkItemWaitingList__DO_EXTENSION(RootExtension_8));
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} sdv_400 != 0;
    call {:si_unique_call 1149} KfReleaseSpinLock(0, irql_22);
    goto L1;

  L1:
    return;

  anon11_Then:
    assume {:partition} sdv_400 == 0;
    assume {:nonnull} RootExtension_8 != 0;
    assume RootExtension_8 > 0;
    call {:si_unique_call 1150} l_11 := RemoveHeadList(WorkItemWaitingList__DO_EXTENSION(RootExtension_8));
    call {:si_unique_call 1151} KfReleaseSpinLock(0, irql_22);
    workItem_2 := l_11;
    context_10 := workItem_2;
    assume {:nonnull} context_10 != 0;
    assume context_10 > 0;
    Tmp_583 := WriteVolume__VSP_CONTEXT(context_10);
    assume {:nonnull} Tmp_583 != 0;
    assume Tmp_583 > 0;
    havoc vslice_dummy_var_1271;
    call {:si_unique_call 1152} sdv_hash_805325738(vslice_dummy_var_1271, workItem_2, 1);
    goto L1;

  anon10_Then:
    goto L1;

  anon12_Then:
    call {:si_unique_call 1153} irql_22 := KfAcquireSpinLock(0);
    assume {:nonnull} RootExtension_8 != 0;
    assume RootExtension_8 > 0;
    assume {:nonnull} RootExtension_8 != 0;
    assume RootExtension_8 > 0;
    call {:si_unique_call 1154} sdv_404 := IsListEmpty(WorkItemWaitingList__DO_EXTENSION(RootExtension_8));
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} sdv_404 != 0;
    call {:si_unique_call 1155} KfReleaseSpinLock(0, irql_22);
    goto L1;

  anon9_Then:
    assume {:partition} sdv_404 == 0;
    assume {:nonnull} RootExtension_8 != 0;
    assume RootExtension_8 > 0;
    call {:si_unique_call 1156} l_11 := RemoveHeadList(WorkItemWaitingList__DO_EXTENSION(RootExtension_8));
    call {:si_unique_call 1157} KfReleaseSpinLock(0, irql_22);
    workItem_2 := l_11;
    context_10 := workItem_2;
    assume {:nonnull} context_10 != 0;
    assume context_10 > 0;
    Tmp_582 := WriteVolume__VSP_CONTEXT(context_10);
    assume {:nonnull} Tmp_582 != 0;
    assume Tmp_582 > 0;
    havoc vslice_dummy_var_1272;
    call {:si_unique_call 1158} sdv_hash_805325738(vslice_dummy_var_1272, workItem_2, 1);
    goto L1;
}



procedure {:origName "_InterlockedIncrement64"} _InterlockedIncrement64(actual_Addend: int) returns (Tmp_586: int);



implementation {:origName "_InterlockedIncrement64"} _InterlockedIncrement64(actual_Addend: int) returns (Tmp_586: int)
{
  var {:scalar} sdv_407: int;
  var {:scalar} Old: int;
  var {:pointer} Addend: int;

  anon0:
    Addend := actual_Addend;
    goto L4;

  L4:
    call {:si_unique_call 1159} Old := _InterlockedIncrement64_loop_L4(sdv_407, Old, Addend);
    goto L4_last;

  L4_last:
    assume {:nonnull} Addend != 0;
    assume Addend > 0;
    havoc Old;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} sdv_407 == Old;
    Tmp_586 := Old + 1;
    return;

  anon3_Then:
    assume {:partition} sdv_407 != Old;
    goto anon3_Then_dummy;

  anon3_Then_dummy:
    assume false;
    return;
}



procedure {:origName "ExAllocateFromNPagedLookasideList"} ExAllocateFromNPagedLookasideList(actual_Lookaside_3: int) returns (Tmp_588: int);
  modifies alloc;



implementation {:origName "ExAllocateFromNPagedLookasideList"} ExAllocateFromNPagedLookasideList(actual_Lookaside_3: int) returns (Tmp_588: int)
{
  var {:pointer} sdv_408: int;
  var {:pointer} Entry_4: int;
  var {:pointer} Lookaside_3: int;

  anon0:
    Lookaside_3 := actual_Lookaside_3;
    assume {:nonnull} Lookaside_3 != 0;
    assume Lookaside_3 > 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    sdv_408 := 0;
    goto L8;

  L8:
    Entry_4 := sdv_408;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} Entry_4 != 0;
    goto L11;

  L11:
    Tmp_588 := Entry_4;
    return;

  anon6_Then:
    assume {:partition} Entry_4 == 0;
    assume {:nonnull} Lookaside_3 != 0;
    assume Lookaside_3 > 0;
    assume {:nonnull} Lookaside_3 != 0;
    assume Lookaside_3 > 0;
    goto L11;

  anon5_Then:
    call {:si_unique_call 1160} sdv_408 := __HAVOC_malloc(1);
    goto L8;
}



procedure {:origName "sdv_hash_811354472"} sdv_hash_811354472(actual_Filter_24: int);
  modifies alloc;



implementation {:origName "sdv_hash_811354472"} sdv_hash_811354472(actual_Filter_24: int)
{
  var {:pointer} Tmp_591: int;
  var {:pointer} Tmp_592: int;
  var {:pointer} lookupEntry_1: int;
  var {:scalar} sdv_414: int;
  var {:pointer} Tmp_593: int;
  var {:scalar} sdv_417: int;
  var {:pointer} Tmp_596: int;
  var {:pointer} l_12: int;
  var {:pointer} Filter_24: int;
  var vslice_dummy_var_272: int;
  var vslice_dummy_var_273: int;
  var vslice_dummy_var_274: int;
  var vslice_dummy_var_275: int;
  var vslice_dummy_var_276: int;
  var vslice_dummy_var_277: int;

  anon0:
    call {:si_unique_call 1161} vslice_dummy_var_272 := __HAVOC_malloc(4);
    Filter_24 := actual_Filter_24;
    assume {:nonnull} Filter_24 != 0;
    assume Filter_24 > 0;
    Tmp_593 := DEVICE_EXTENSION_FILTER_EXTENSION(Filter_24);
    assume {:nonnull} Tmp_593 != 0;
    assume Tmp_593 > 0;
    call {:si_unique_call 1162} vslice_dummy_var_274 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto L11;

  L11:
    call {:si_unique_call 1163} Tmp_591, lookupEntry_1, sdv_414, l_12, vslice_dummy_var_277 := sdv_hash_811354472_loop_L11(Tmp_591, lookupEntry_1, sdv_414, l_12, Filter_24, vslice_dummy_var_277);
    goto L11_last;

  L11_last:
    assume {:nonnull} Filter_24 != 0;
    assume Filter_24 > 0;
    call {:si_unique_call 1172} sdv_414 := IsListEmpty(SnapshotLookupTableEntries_FILTER_EXTENSION(Filter_24));
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} sdv_414 != 0;
    goto L18;

  L18:
    call {:si_unique_call 1164} lookupEntry_1, sdv_417, Tmp_596, l_12, vslice_dummy_var_273, vslice_dummy_var_276 := sdv_hash_811354472_loop_L18(lookupEntry_1, sdv_417, Tmp_596, l_12, Filter_24, vslice_dummy_var_273, vslice_dummy_var_276);
    goto L18_last;

  L18_last:
    assume {:nonnull} Filter_24 != 0;
    assume Filter_24 > 0;
    call {:si_unique_call 1171} sdv_417 := IsListEmpty(DiffAreaLookupTableEntries_FILTER_EXTENSION(Filter_24));
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} sdv_417 != 0;
    assume {:nonnull} Filter_24 != 0;
    assume Filter_24 > 0;
    Tmp_592 := DEVICE_EXTENSION_FILTER_EXTENSION(Filter_24);
    assume {:nonnull} Tmp_592 != 0;
    assume Tmp_592 > 0;
    call {:si_unique_call 1165} vslice_dummy_var_275 := KeReleaseMutex(0, 0);
    return;

  anon12_Then:
    assume {:partition} sdv_417 == 0;
    assume {:nonnull} Filter_24 != 0;
    assume Filter_24 > 0;
    call {:si_unique_call 1166} l_12 := RemoveHeadList(DiffAreaLookupTableEntries_FILTER_EXTENSION(Filter_24));
    lookupEntry_1 := l_12;
    assume {:nonnull} lookupEntry_1 != 0;
    assume lookupEntry_1 > 0;
    assume {:nonnull} lookupEntry_1 != 0;
    assume lookupEntry_1 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    call {:si_unique_call 1167} vslice_dummy_var_273 := ZwClose(0);
    assume {:nonnull} lookupEntry_1 != 0;
    assume lookupEntry_1 > 0;
    goto L32;

  L32:
    assume {:nonnull} lookupEntry_1 != 0;
    assume lookupEntry_1 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:nonnull} Filter_24 != 0;
    assume Filter_24 > 0;
    Tmp_596 := DEVICE_EXTENSION_FILTER_EXTENSION(Filter_24);
    assume {:nonnull} Tmp_596 != 0;
    assume Tmp_596 > 0;
    call {:si_unique_call 1168} vslice_dummy_var_276 := corral_nondet();
    goto anon13_Else_dummy;

  anon13_Else_dummy:
    assume false;
    return;

  anon13_Then:
    goto anon13_Then_dummy;

  anon13_Then_dummy:
    assume false;
    return;

  anon14_Then:
    goto L32;

  anon11_Then:
    assume {:partition} sdv_414 == 0;
    assume {:nonnull} Filter_24 != 0;
    assume Filter_24 > 0;
    call {:si_unique_call 1169} l_12 := RemoveHeadList(SnapshotLookupTableEntries_FILTER_EXTENSION(Filter_24));
    lookupEntry_1 := l_12;
    assume {:nonnull} lookupEntry_1 != 0;
    assume lookupEntry_1 > 0;
    assume {:nonnull} lookupEntry_1 != 0;
    assume lookupEntry_1 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:nonnull} Filter_24 != 0;
    assume Filter_24 > 0;
    Tmp_591 := DEVICE_EXTENSION_FILTER_EXTENSION(Filter_24);
    assume {:nonnull} Tmp_591 != 0;
    assume Tmp_591 > 0;
    call {:si_unique_call 1170} vslice_dummy_var_277 := corral_nondet();
    goto anon15_Else_dummy;

  anon15_Else_dummy:
    assume false;
    return;

  anon15_Then:
    goto anon15_Then_dummy;

  anon15_Then_dummy:
    assume false;
    return;
}



procedure {:origName "AppendTailList"} AppendTailList(actual_ListHead_4: int, actual_ListToAppend: int);
  modifies alloc;



implementation {:origName "AppendTailList"} AppendTailList(actual_ListHead_4: int, actual_ListToAppend: int)
{
  var {:pointer} ListEnd: int;
  var {:pointer} Tmp_601: int;
  var {:pointer} Tmp_602: int;
  var {:pointer} ListHead_4: int;
  var {:pointer} ListToAppend: int;
  var vslice_dummy_var_278: int;

  anon0:
    call {:si_unique_call 1173} vslice_dummy_var_278 := __HAVOC_malloc(4);
    ListHead_4 := actual_ListHead_4;
    ListToAppend := actual_ListToAppend;
    assume {:nonnull} ListHead_4 != 0;
    assume ListHead_4 > 0;
    havoc ListEnd;
    assume {:nonnull} ListHead_4 != 0;
    assume ListHead_4 > 0;
    havoc Tmp_602;
    assume {:nonnull} Tmp_602 != 0;
    assume Tmp_602 > 0;
    assume {:nonnull} ListHead_4 != 0;
    assume ListHead_4 > 0;
    assume {:nonnull} ListToAppend != 0;
    assume ListToAppend > 0;
    assume {:nonnull} ListToAppend != 0;
    assume ListToAppend > 0;
    havoc Tmp_601;
    assume {:nonnull} Tmp_601 != 0;
    assume Tmp_601 > 0;
    assume {:nonnull} ListToAppend != 0;
    assume ListToAppend > 0;
    return;
}



procedure {:origName "sdv_hash_859757058"} sdv_hash_859757058(actual_RootExtension_9: int) returns (Tmp_604: int);
  modifies alloc;



implementation {:origName "sdv_hash_859757058"} sdv_hash_859757058(actual_RootExtension_9: int) returns (Tmp_604: int)
{
  var {:pointer} sdv_419: int;
  var {:pointer} context_11: int;
  var {:pointer} RootExtension_9: int;

  anon0:
    RootExtension_9 := actual_RootExtension_9;
    assume {:nonnull} RootExtension_9 != 0;
    assume RootExtension_9 > 0;
    call {:si_unique_call 1174} sdv_419 := ExAllocateFromNPagedLookasideList(ContextLookasideList__DO_EXTENSION(RootExtension_9));
    context_11 := sdv_419;
    Tmp_604 := context_11;
    return;
}



procedure {:origName "sdv_hash_1048709922"} sdv_hash_1048709922(actual_Filter_25: int);
  modifies alloc;



implementation {:origName "sdv_hash_1048709922"} sdv_hash_1048709922(actual_Filter_25: int)
{
  var {:scalar} irql_23: int;
  var {:pointer} Filter_25: int;
  var vslice_dummy_var_279: int;
  var vslice_dummy_var_280: int;
  var vslice_dummy_var_281: int;
  var vslice_dummy_var_282: int;
  var vslice_dummy_var_283: int;
  var vslice_dummy_var_284: int;

  anon0:
    call {:si_unique_call 1175} vslice_dummy_var_279 := __HAVOC_malloc(4);
    Filter_25 := actual_Filter_25;
    call {:si_unique_call 1176} vslice_dummy_var_280 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    call {:si_unique_call 1177} irql_23 := KfAcquireSpinLock(0);
    assume {:nonnull} Filter_25 != 0;
    assume Filter_25 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 1178} KfReleaseSpinLock(0, irql_23);
    call {:si_unique_call 1179} vslice_dummy_var_282 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} Filter_25 != 0;
    assume Filter_25 > 0;
    call {:si_unique_call 1180} vslice_dummy_var_283 := KeResetEvent(ZeroRefEvent_FILTER_EXTENSION(Filter_25));
    call {:si_unique_call 1181} ExWaitForRundownProtectionReleaseCacheAware(0);
    assume {:nonnull} Filter_25 != 0;
    assume Filter_25 > 0;
    call {:si_unique_call 1182} vslice_dummy_var_284 := KeSetEvent(ZeroRefEvent_FILTER_EXTENSION(Filter_25), 0, 0);
    goto L1;

  L1:
    return;

  anon3_Then:
    call {:si_unique_call 1183} KfReleaseSpinLock(0, irql_23);
    call {:si_unique_call 1184} vslice_dummy_var_281 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto L1;
}



procedure {:origName "sdv_hash_742206354"} sdv_hash_742206354(actual_ListOfDiffAreaFilesToClose_1: int, actual_ListOfDeviceObjectsToDelete: int, actual_KeepOnDisk_1: int);
  modifies alloc;



implementation {:origName "sdv_hash_742206354"} sdv_hash_742206354(actual_ListOfDiffAreaFilesToClose_1: int, actual_ListOfDeviceObjectsToDelete: int, actual_KeepOnDisk_1: int)
{
  var {:scalar} sdv_428: int;
  var {:scalar} dispInfo: int;
  var {:scalar} sdv_431: int;
  var {:pointer} l_13: int;
  var {:pointer} extension_5: int;
  var {:pointer} ListOfDiffAreaFilesToClose_1: int;
  var {:pointer} ListOfDeviceObjectsToDelete: int;
  var {:scalar} KeepOnDisk_1: int;
  var vslice_dummy_var_285: int;
  var vslice_dummy_var_286: int;
  var vslice_dummy_var_287: int;
  var vslice_dummy_var_288: int;
  var vslice_dummy_var_289: int;

  anon0:
    call {:si_unique_call 1185} vslice_dummy_var_285 := __HAVOC_malloc(4);
    call {:si_unique_call 1186} dispInfo := __HAVOC_malloc(4);
    call {:si_unique_call 1187} vslice_dummy_var_286 := __HAVOC_malloc(12);
    ListOfDiffAreaFilesToClose_1 := actual_ListOfDiffAreaFilesToClose_1;
    ListOfDeviceObjectsToDelete := actual_ListOfDeviceObjectsToDelete;
    KeepOnDisk_1 := actual_KeepOnDisk_1;
    goto L11;

  L11:
    call {:si_unique_call 1188} sdv_428, l_13, vslice_dummy_var_287, vslice_dummy_var_289 := sdv_hash_742206354_loop_L11(sdv_428, dispInfo, l_13, ListOfDiffAreaFilesToClose_1, KeepOnDisk_1, vslice_dummy_var_287, vslice_dummy_var_289);
    goto L11_last;

  L11_last:
    call {:si_unique_call 1197} sdv_428 := IsListEmpty(ListOfDiffAreaFilesToClose_1);
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} sdv_428 != 0;
    goto L18;

  L18:
    call {:si_unique_call 1189} sdv_431, l_13, extension_5, vslice_dummy_var_288 := sdv_hash_742206354_loop_L18(sdv_431, l_13, extension_5, ListOfDeviceObjectsToDelete, vslice_dummy_var_288);
    goto L18_last;

  L18_last:
    call {:si_unique_call 1196} sdv_431 := IsListEmpty(ListOfDeviceObjectsToDelete);
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} sdv_431 == 0;
    call {:si_unique_call 1190} l_13 := RemoveHeadList(ListOfDeviceObjectsToDelete);
    extension_5 := l_13;
    assume {:nonnull} extension_5 != 0;
    assume extension_5 > 0;
    call {:si_unique_call 1191} vslice_dummy_var_288 := ObfDereferenceObject(0);
    goto anon8_Else_dummy;

  anon8_Else_dummy:
    assume false;
    return;

  anon8_Then:
    assume {:partition} sdv_431 != 0;
    return;

  anon7_Then:
    assume {:partition} sdv_428 == 0;
    call {:si_unique_call 1192} l_13 := RemoveHeadList(ListOfDiffAreaFilesToClose_1);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} KeepOnDisk_1 != 0;
    assume {:nonnull} dispInfo != 0;
    assume dispInfo > 0;
    call {:si_unique_call 1193} vslice_dummy_var_289 := ZwSetInformationFile(0, 0, 0, 1, 13);
    goto L33;

  L33:
    call {:si_unique_call 1194} vslice_dummy_var_287 := ZwClose(0);
    call {:si_unique_call 1195} ExFreePoolWithTag(0, 0);
    goto L33_dummy;

  L33_dummy:
    assume false;
    return;

  anon9_Then:
    assume {:partition} KeepOnDisk_1 == 0;
    goto L33;
}



procedure {:origName "sdv_hash_194037626"} sdv_hash_194037626(actual_Filter_26: int, actual_ControlItem: int);
  modifies alloc;



implementation {:origName "sdv_hash_194037626"} sdv_hash_194037626(actual_Filter_26: int, actual_ControlItem: int)
{
  var {:pointer} Tmp_614: int;
  var {:pointer} lookupEntry_2: int;
  var {:pointer} Tmp_615: int;
  var {:pointer} Tmp_618: int;
  var {:pointer} Tmp_619: int;
  var {:pointer} Filter_26: int;
  var {:pointer} ControlItem: int;
  var vslice_dummy_var_290: int;
  var vslice_dummy_var_291: int;
  var vslice_dummy_var_292: int;
  var vslice_dummy_var_293: int;
  var vslice_dummy_var_294: int;
  var vslice_dummy_var_295: int;
  var vslice_dummy_var_296: int;
  var vslice_dummy_var_297: int;
  var vslice_dummy_var_1273: int;

  anon0:
    call {:si_unique_call 1198} vslice_dummy_var_290 := __HAVOC_malloc(4);
    Filter_26 := actual_Filter_26;
    ControlItem := actual_ControlItem;
    assume {:nonnull} Filter_26 != 0;
    assume Filter_26 > 0;
    Tmp_619 := DEVICE_EXTENSION_FILTER_EXTENSION(Filter_26);
    assume {:nonnull} Tmp_619 != 0;
    assume Tmp_619 > 0;
    call {:si_unique_call 1199} vslice_dummy_var_292 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ControlItem != 0;
    assume ControlItem > 0;
    assume {:nonnull} Filter_26 != 0;
    assume Filter_26 > 0;
    havoc vslice_dummy_var_1273;
    call {:si_unique_call 1200} lookupEntry_2 := sdv_hash_414123790(vslice_dummy_var_1273, SnapshotGuid__VSP_CONTROL_ITEM_SNAPSHOT(ControlItem), Filter_26);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} lookupEntry_2 != 0;
    assume {:nonnull} ControlItem != 0;
    assume ControlItem > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    call {:si_unique_call 1201} vslice_dummy_var_293 := RemoveEntryList(SnapshotFilterListEntry__VSP_LOOKUP_TABLE_ENTRY(lookupEntry_2));
    goto L21;

  L21:
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    goto L27;

  L27:
    assume {:nonnull} Filter_26 != 0;
    assume Filter_26 > 0;
    Tmp_615 := DEVICE_EXTENSION_FILTER_EXTENSION(Filter_26);
    assume {:nonnull} Tmp_615 != 0;
    assume Tmp_615 > 0;
    call {:si_unique_call 1202} vslice_dummy_var_294 := KeReleaseMutex(0, 0);
    goto L1;

  L1:
    return;

  anon19_Then:
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:nonnull} Filter_26 != 0;
    assume Filter_26 > 0;
    Tmp_614 := DEVICE_EXTENSION_FILTER_EXTENSION(Filter_26);
    assume {:nonnull} Tmp_614 != 0;
    assume Tmp_614 > 0;
    call {:si_unique_call 1203} vslice_dummy_var_295 := corral_nondet();
    goto L27;

  anon20_Then:
    goto L27;

  anon18_Then:
    goto L21;

  anon16_Then:
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    call {:si_unique_call 1204} vslice_dummy_var_296 := RemoveEntryList(DiffAreaFilterListEntry__VSP_LOOKUP_TABLE_ENTRY(lookupEntry_2));
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    call {:si_unique_call 1205} vslice_dummy_var_291 := ZwClose(0);
    assume {:nonnull} lookupEntry_2 != 0;
    assume lookupEntry_2 > 0;
    goto L21;

  anon21_Then:
    goto L21;

  anon17_Then:
    goto L21;

  anon15_Then:
    assume {:partition} lookupEntry_2 == 0;
    assume {:nonnull} Filter_26 != 0;
    assume Filter_26 > 0;
    Tmp_618 := DEVICE_EXTENSION_FILTER_EXTENSION(Filter_26);
    assume {:nonnull} Tmp_618 != 0;
    assume Tmp_618 > 0;
    call {:si_unique_call 1206} vslice_dummy_var_297 := KeReleaseMutex(0, 0);
    goto L1;
}



procedure {:origName "sdv_hash_90601371"} sdv_hash_90601371(actual_Context_8: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_90601371"} sdv_hash_90601371(actual_Context_8: int)
{
  var {:scalar} Tmp_622: int;
  var {:scalar} allStringsLimit: int;
  var {:pointer} sdv_444: int;
  var {:scalar} myStringLength: int;
  var {:pointer} context_12: int;
  var {:pointer} buf: int;
  var {:scalar} diffAreaFilterDosName: int;
  var {:scalar} systemStringLength: int;
  var {:scalar} deviceName: int;
  var {:pointer} errorLogPacket: int;
  var {:pointer} filter_13: int;
  var {:pointer} diffAreaFilter: int;
  var {:pointer} buffer_4: int;
  var {:scalar} v: int;
  var {:scalar} filterDosName: int;
  var {:scalar} Tmp_633: int;
  var {:scalar} status_19: int;
  var {:scalar} w: int;
  var {:scalar} Tmp_636: int;
  var {:scalar} Tmp_637: int;
  var {:pointer} extension_6: int;
  var {:pointer} p_5: int;
  var {:scalar} Tmp_640: int;
  var {:scalar} limit: int;
  var {:pointer} Context_8: int;
  var vslice_dummy_var_298: int;
  var vslice_dummy_var_299: int;
  var vslice_dummy_var_300: int;
  var vslice_dummy_var_301: int;
  var vslice_dummy_var_302: int;
  var vslice_dummy_var_303: int;
  var vslice_dummy_var_304: int;
  var vslice_dummy_var_305: int;
  var vslice_dummy_var_306: int;
  var vslice_dummy_var_307: int;
  var vslice_dummy_var_1274: int;

  anon0:
    call {:si_unique_call 1207} vslice_dummy_var_298 := __HAVOC_malloc(4);
    call {:si_unique_call 1208} diffAreaFilterDosName := __HAVOC_malloc(12);
    call {:si_unique_call 1209} deviceName := __HAVOC_malloc(12);
    call {:si_unique_call 1210} filterDosName := __HAVOC_malloc(12);
    Context_8 := actual_Context_8;
    call {:si_unique_call 1211} vslice_dummy_var_301 := __HAVOC_malloc(140);
    call {:si_unique_call 1212} buf := __HAVOC_malloc(40);
    call {:si_unique_call 1213} buffer_4 := __HAVOC_malloc(400);
    context_12 := Context_8;
    assume {:nonnull} context_12 != 0;
    assume context_12 > 0;
    havoc extension_6;
    assume {:nonnull} context_12 != 0;
    assume context_12 > 0;
    havoc diffAreaFilter;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} extension_6 != 0;
    assume {:nonnull} extension_6 != 0;
    assume extension_6 > 0;
    havoc filter_13;
    goto L28;

  L28:
    call {:si_unique_call 1214} status_19 := sdv_hash_84974865(filter_13);
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} status_19 < 0;
    goto L47;

  L47:
    assume {:nonnull} filter_13 != 0;
    assume filter_13 > 0;
    havoc vslice_dummy_var_1274;
    call {:si_unique_call 1215} sdv_hash_493014447(vslice_dummy_var_1274, context_12);
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} extension_6 != 0;
    assume {:nonnull} extension_6 != 0;
    assume extension_6 > 0;
    call {:si_unique_call 1216} vslice_dummy_var_303 := ObfDereferenceObject(0);
    goto L51;

  L51:
    call {:si_unique_call 1217} vslice_dummy_var_299 := ObfDereferenceObject(0);
    assume {:nonnull} filter_13 != 0;
    assume filter_13 > 0;
    call {:si_unique_call 1218} vslice_dummy_var_304 := ObfDereferenceObject(0);
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} diffAreaFilter != 0;
    call {:si_unique_call 1219} vslice_dummy_var_300 := ObfDereferenceObject(0);
    assume {:nonnull} diffAreaFilter != 0;
    assume diffAreaFilter > 0;
    call {:si_unique_call 1220} vslice_dummy_var_305 := ObfDereferenceObject(0);
    goto L1;

  L1:
    return;

  anon63_Then:
    assume {:partition} diffAreaFilter == 0;
    goto L1;

  anon62_Then:
    assume {:partition} extension_6 == 0;
    goto L51;

  anon59_Then:
    assume {:partition} 0 <= status_19;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} diffAreaFilter != 0;
    call {:si_unique_call 1221} status_19 := sdv_hash_84974865(diffAreaFilter);
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} status_19 < 0;
    call {:si_unique_call 1222} sdv_hash_946681144(filter_13);
    goto L47;

  anon61_Then:
    assume {:partition} 0 <= status_19;
    goto L35;

  L35:
    assume {:nonnull} filter_13 != 0;
    assume filter_13 > 0;
    call {:si_unique_call 1223} status_19 := IoVolumeDeviceToDosName(0, 0);
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} status_19 >= 0;
    goto L70;

  L70:
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    havoc myStringLength;
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} diffAreaFilter != 0;
    assume {:nonnull} diffAreaFilter != 0;
    assume diffAreaFilter > 0;
    call {:si_unique_call 1224} status_19 := IoVolumeDeviceToDosName(0, 0);
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} status_19 >= 0;
    goto L79;

  L79:
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    havoc myStringLength;
    goto L72;

  L72:
    systemStringLength := 16;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} extension_6 != 0;
    call {:si_unique_call 1225} vslice_dummy_var_302 := corral_nondet();
    call {:si_unique_call 1226} RtlInitUnicodeString(deviceName, buffer_4);
    assume {:nonnull} deviceName != 0;
    assume deviceName > 0;
    havoc systemStringLength;
    goto L92;

  L92:
    limit := 104;
    allStringsLimit := 152;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} limit > allStringsLimit - systemStringLength;
    limit := allStringsLimit - systemStringLength;
    goto L95;

  L95:
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} myStringLength > limit;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} diffAreaFilter != 0;
    limit := INTDIV(limit, 2);
    goto L99;

  L99:
    limit := BAND(limit, BNOT(1));
    limit := limit - 2;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    havoc v;
    w := limit - 12;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    goto anon82_Then, anon82_Else;

  anon82_Else:
    goto L112;

  L112:
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} diffAreaFilter != 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    call {:si_unique_call 1227} ExFreePoolWithTag(0, 0);
    goto L115;

  L115:
    call {:si_unique_call 1228} sdv_hash_946681144(diffAreaFilter);
    goto L113;

  L113:
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    goto anon72_Then, anon72_Else;

  anon72_Else:
    call {:si_unique_call 1229} ExFreePoolWithTag(0, 0);
    goto L121;

  L121:
    call {:si_unique_call 1230} sdv_hash_946681144(filter_13);
    goto L47;

  anon72_Then:
    goto L121;

  anon73_Then:
    goto L115;

  anon71_Then:
    assume {:partition} diffAreaFilter == 0;
    goto L113;

  anon82_Then:
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    goto L134;

  L134:
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    havoc Tmp_637;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    goto L103;

  L103:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} diffAreaFilter != 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    havoc v;
    w := limit - 12;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    goto anon84_Then, anon84_Else;

  anon84_Else:
    goto L148;

  L148:
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    havoc Tmp_633;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    goto L97;

  L97:
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} extension_6 != 0;
    assume {:nonnull} extension_6 != 0;
    assume extension_6 > 0;
    goto L152;

  L152:
    call {:si_unique_call 1231} sdv_444 := IoAllocateErrorLogEntry(0, 152);
    errorLogPacket := sdv_444;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} errorLogPacket != 0;
    assume {:nonnull} context_12 != 0;
    assume context_12 > 0;
    assume {:nonnull} errorLogPacket != 0;
    assume errorLogPacket > 0;
    havoc Tmp_622;
    assume {:nonnull} errorLogPacket != 0;
    assume errorLogPacket > 0;
    assume {:nonnull} context_12 != 0;
    assume context_12 > 0;
    assume {:nonnull} errorLogPacket != 0;
    assume errorLogPacket > 0;
    assume {:nonnull} context_12 != 0;
    assume context_12 > 0;
    assume {:nonnull} errorLogPacket != 0;
    assume errorLogPacket > 0;
    assume {:nonnull} errorLogPacket != 0;
    assume errorLogPacket > 0;
    assume {:nonnull} errorLogPacket != 0;
    assume errorLogPacket > 0;
    assume {:nonnull} errorLogPacket != 0;
    assume errorLogPacket > 0;
    assume {:nonnull} errorLogPacket != 0;
    assume errorLogPacket > 0;
    p_5 := errorLogPacket;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    havoc Tmp_636;
    assume {:nonnull} p_5 != 0;
    assume p_5 > 0;
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} diffAreaFilter != 0;
    assume {:nonnull} errorLogPacket != 0;
    assume errorLogPacket > 0;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    havoc v;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} v < 152;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    p_5 := errorLogPacket;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    havoc Tmp_640;
    assume {:nonnull} p_5 != 0;
    assume p_5 > 0;
    goto L173;

  L173:
    call {:si_unique_call 1232} IoWriteErrorLogEntry(0);
    goto L112;

  anon76_Then:
    goto L112;

  anon87_Then:
    assume {:partition} 152 <= v;
    goto L112;

  anon86_Then:
    assume {:partition} diffAreaFilter == 0;
    goto L173;

  anon85_Then:
    assume {:partition} errorLogPacket == 0;
    goto L112;

  anon67_Then:
    assume {:partition} extension_6 == 0;
    assume {:nonnull} filter_13 != 0;
    assume filter_13 > 0;
    goto L152;

  anon84_Then:
    call {:si_unique_call 1233} vslice_dummy_var_307 := __HAVOC_malloc(1);
    goto L148;

  anon75_Then:
    goto L97;

  anon69_Then:
    assume {:partition} diffAreaFilter == 0;
    goto L97;

  anon83_Then:
    call {:si_unique_call 1234} vslice_dummy_var_306 := __HAVOC_malloc(1);
    goto L134;

  anon74_Then:
    goto L112;

  anon70_Then:
    goto L112;

  anon81_Then:
    goto L103;

  anon68_Then:
    assume {:partition} diffAreaFilter == 0;
    goto L99;

  anon66_Then:
    assume {:partition} limit >= myStringLength;
    goto L97;

  anon80_Then:
    assume {:partition} allStringsLimit - systemStringLength >= limit;
    goto L95;

  anon79_Then:
    assume {:partition} extension_6 == 0;
    systemStringLength := systemStringLength + 2;
    goto L92;

  anon65_Then:
    assume {:partition} 0 > status_19;
    assume {:nonnull} buf != 0;
    assume buf > 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    assume {:nonnull} diffAreaFilterDosName != 0;
    assume diffAreaFilterDosName > 0;
    goto L79;

  anon78_Then:
    assume {:partition} diffAreaFilter == 0;
    goto L72;

  anon64_Then:
    assume {:partition} 0 > status_19;
    assume {:nonnull} buf != 0;
    assume buf > 0;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    assume {:nonnull} filterDosName != 0;
    assume filterDosName > 0;
    goto L70;

  anon60_Then:
    assume {:partition} diffAreaFilter == 0;
    goto L35;

  anon77_Then:
    assume {:partition} extension_6 == 0;
    filter_13 := diffAreaFilter;
    diffAreaFilter := 0;
    goto L28;
}



procedure {:origName "VolSnapPnp"} VolSnapPnp(actual_DeviceObject_12: int, actual_Irp_17: int) returns (Tmp_641: int);
  modifies alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.CurrentStackLocation_unnamed_tag_6, ref, Mem_T.Type_unnamed_tag_26, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "VolSnapPnp"} VolSnapPnp(actual_DeviceObject_12: int, actual_Irp_17: int) returns (Tmp_641: int)
{
  var {:pointer} deviceRelations_1: int;
  var {:pointer} capabilities: int;
  var {:pointer} Tmp_643: int;
  var {:pointer} irpSp_8: int;
  var {:pointer} Tmp_645: int;
  var {:pointer} filter_14: int;
  var {:pointer} sdv_474: int;
  var {:pointer} Tmp_648: int;
  var {:scalar} critResource: int;
  var {:scalar} status_20: int;
  var {:pointer} extension_7: int;
  var {:scalar} deletePdo: int;
  var {:scalar} event_5: int;
  var {:pointer} Tmp_649: int;
  var {:pointer} DeviceObject_12: int;
  var {:pointer} Irp_17: int;
  var vslice_dummy_var_308: int;
  var vslice_dummy_var_309: int;
  var vslice_dummy_var_310: int;
  var vslice_dummy_var_311: int;
  var vslice_dummy_var_312: int;
  var vslice_dummy_var_313: int;
  var vslice_dummy_var_314: int;
  var vslice_dummy_var_315: int;
  var vslice_dummy_var_1275: int;
  var vslice_dummy_var_1276: int;
  var vslice_dummy_var_1277: int;
  var vslice_dummy_var_1278: int;
  var vslice_dummy_var_1279: int;
  var vslice_dummy_var_1280: int;
  var vslice_dummy_var_1281: int;
  var vslice_dummy_var_1282: int;
  var vslice_dummy_var_1283: int;
  var vslice_dummy_var_1284: int;
  var vslice_dummy_var_1285: int;

  anon0:
    call {:si_unique_call 1235} critResource := __HAVOC_malloc(28);
    call {:si_unique_call 1236} event_5 := __HAVOC_malloc(124);
    DeviceObject_12 := actual_DeviceObject_12;
    Irp_17 := actual_Irp_17;
    call {:si_unique_call 1237} Tmp_648 := __HAVOC_malloc(4);
    status_20 := 0;
    assume {:nonnull} DeviceObject_12 != 0;
    assume DeviceObject_12 > 0;
    havoc filter_14;
    call {:si_unique_call 1238} irpSp_8 := IoGetCurrentIrpStackLocation(Irp_17);
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    havoc Tmp_645;
    assume {:nonnull} Tmp_645 != 0;
    assume Tmp_645 > 0;
    goto anon148_Then, anon148_Else;

  anon148_Else:
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon149_Then, anon149_Else;

  anon149_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 0;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon125_Then, anon125_Else;

  anon125_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 1;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon124_Then, anon124_Else;

  anon124_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 2;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 3;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon122_Then, anon122_Else;

  anon122_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 4;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon121_Then, anon121_Else;

  anon121_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 5;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon120_Then, anon120_Else;

  anon120_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 6;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon119_Then, anon119_Else;

  anon119_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 23;
    goto L36;

  L36:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))] := 0;
    goto L33;

  L33:
    call {:si_unique_call 1239} IoSkipCurrentIrpStackLocation(Irp_17);
    call {:si_unique_call 1240} Tmp_641 := IofCallDriver(0, Irp_17);
    goto L1;

  L1:
    return;

  anon119_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 23;
    goto L33;

  anon120_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 6;
    goto L36;

  anon121_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 5;
    goto L36;

  anon122_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 4;
    goto L36;

  anon123_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 3;
    goto L36;

  anon124_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 2;
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    havoc vslice_dummy_var_1275;
    call {:si_unique_call 1241} sdv_hash_613687309(vslice_dummy_var_1275);
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    goto anon107_Then, anon107_Else;

  anon107_Else:
    goto L44;

  L44:
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    havoc vslice_dummy_var_1276;
    call {:si_unique_call 1242} sdv_hash_986004649(vslice_dummy_var_1276);
    call {:si_unique_call 1243} IoDetachDevice(0);
    call {:si_unique_call 1244} IoDeleteDevice(0);
    goto L36;

  anon107_Then:
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    call {:si_unique_call 1245} vslice_dummy_var_308 := RemoveEntryList(ListEntry_FILTER_EXTENSION(filter_14));
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    goto L44;

  anon125_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 1;
    goto L36;

  anon149_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 0;
    goto L36;

  anon148_Then:
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 0;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon134_Then, anon134_Else;

  anon134_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 1;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon133_Then, anon133_Else;

  anon133_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 2;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon132_Then, anon132_Else;

  anon132_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 3;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon131_Then, anon131_Else;

  anon131_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 4;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon130_Then, anon130_Else;

  anon130_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 5;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon129_Then, anon129_Else;

  anon129_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 6;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon128_Then, anon128_Else;

  anon128_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 7;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon127_Then, anon127_Else;

  anon127_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 22;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon126_Then, anon126_Else;

  anon126_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 23;
    goto L63;

  L63:
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon150_Then, anon150_Else;

  anon150_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 2;
    call {:si_unique_call 1246} sdv_hash_24220996(filter_14);
    call {:si_unique_call 1247} IoDetachDevice(0);
    call {:si_unique_call 1248} IoDeleteDevice(0);
    goto L138;

  L138:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))] := 0;
    call {:si_unique_call 1249} IoSkipCurrentIrpStackLocation(Irp_17);
    call {:si_unique_call 1250} Tmp_641 := IofCallDriver(0, Irp_17);
    goto L1;

  anon150_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 2;
    call {:si_unique_call 1251} sdv_hash_177085617(critResource, filter_14);
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    havoc vslice_dummy_var_1277;
    call {:si_unique_call 1252} sdv_hash_613687309(vslice_dummy_var_1277);
    call {:si_unique_call 1253} sdv_hash_375749048(filter_14);
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    havoc vslice_dummy_var_1278;
    call {:si_unique_call 1254} sdv_hash_986004649(vslice_dummy_var_1278);
    call {:si_unique_call 1255} sdv_hash_17066757#1(filter_14, 0, 0, 1, 0);
    call {:si_unique_call 1256} sdv_hash_774522858(critResource, filter_14);
    goto L138;

  anon126_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 23;
    goto L59;

  L59:
    call {:si_unique_call 1257} IoSkipCurrentIrpStackLocation(Irp_17);
    call {:si_unique_call 1258} Tmp_641 := IofCallDriver(0, Irp_17);
    goto L1;

  anon127_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 22;
    call {:si_unique_call 1259} vslice_dummy_var_309 := IoForwardIrpSynchronously(0, Irp_17);
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    status_20 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))];
    goto anon151_Then, anon151_Else;

  anon151_Else:
    assume {:partition} status_20 < 0;
    goto L84;

  L84:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))] := status_20;
    call {:si_unique_call 1260} IofCompleteRequest(0, 0);
    Tmp_641 := status_20;
    goto L1;

  anon151_Then:
    assume {:partition} 0 <= status_20;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon109_Then, anon109_Else;

  anon109_Else:
    goto L84;

  anon109_Then:
    call {:si_unique_call 1261} sdv_hash_177085617(critResource, filter_14);
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon110_Then, anon110_Else;

  anon110_Else:
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    goto anon152_Then, anon152_Else;

  anon152_Else:
    assume {:nonnull} DeviceObject_12 != 0;
    assume DeviceObject_12 > 0;
    goto L79;

  L79:
    call {:si_unique_call 1262} sdv_hash_774522858(critResource, filter_14);
    goto L84;

  anon152_Then:
    goto L79;

  anon110_Then:
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    goto anon153_Then, anon153_Else;

  anon153_Else:
    assume {:nonnull} DeviceObject_12 != 0;
    assume DeviceObject_12 > 0;
    goto L79;

  anon153_Then:
    goto L79;

  anon128_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 7;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] == 0;
    call {:si_unique_call 1263} KeInitializeEvent(event_5, 0, 0);
    call {:si_unique_call 1264} IoCopyCurrentIrpStackLocationToNext(Irp_17);
    call {:si_unique_call 1265} IoSetCompletionRoutine(Irp_17, li2bplFunctionConstant853, event_5, 1, 1, 1);
    call {:si_unique_call 1266} vslice_dummy_var_310 := IofCallDriver(0, Irp_17);
    call {:si_unique_call 1267} vslice_dummy_var_311 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    havoc vslice_dummy_var_1279;
    call {:si_unique_call 1268} sdv_hash_613687309(vslice_dummy_var_1279);
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon111_Then, anon111_Else;

  anon111_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] == 0;
    call {:si_unique_call 1269} status_20 := sdv_hash_1035268778(filter_14, Irp_17);
    goto L112;

  L112:
    assume {:nonnull} filter_14 != 0;
    assume filter_14 > 0;
    havoc vslice_dummy_var_1280;
    call {:si_unique_call 1270} sdv_hash_986004649(vslice_dummy_var_1280);
    goto L84;

  anon111_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] != 0;
    goto L112;

  anon108_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] != 0;
    call {:si_unique_call 1271} IoSkipCurrentIrpStackLocation(Irp_17);
    call {:si_unique_call 1272} Tmp_641 := IofCallDriver(0, Irp_17);
    goto L1;

  anon129_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 6;
    goto L62;

  L62:
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))] := 0;
    goto L59;

  anon130_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 5;
    goto L62;

  anon131_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 4;
    goto L62;

  anon132_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 3;
    goto L62;

  anon133_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 2;
    goto L63;

  anon134_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 1;
    goto L62;

  anon106_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 0;
    goto L62;

  anon105_Then:
    extension_7 := filter_14;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon154_Then, anon154_Else;

  anon154_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 0;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon147_Then, anon147_Else;

  anon147_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 1;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon146_Then, anon146_Else;

  anon146_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 2;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon145_Then, anon145_Else;

  anon145_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 3;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon144_Then, anon144_Else;

  anon144_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 5;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon143_Then, anon143_Else;

  anon143_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 6;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon142_Then, anon142_Else;

  anon142_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 7;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon141_Then, anon141_Else;

  anon141_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 9;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon140_Then, anon140_Else;

  anon140_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 10;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon139_Then, anon139_Else;

  anon139_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 11;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon138_Then, anon138_Else;

  anon138_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 19;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon137_Then, anon137_Else;

  anon137_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 20;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon136_Then, anon136_Else;

  anon136_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 22;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon135_Then, anon135_Else;

  anon135_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 23;
    goto L223;

  L223:
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    havoc vslice_dummy_var_1281;
    call {:si_unique_call 1273} sdv_hash_613687309(vslice_dummy_var_1281);
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    goto anon114_Then, anon114_Else;

  anon114_Else:
    call {:si_unique_call 1274} vslice_dummy_var_313 := IoSetDeviceInterfaceState(0, 0);
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    call {:si_unique_call 1275} ExFreePoolWithTag(0, 0);
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    goto L227;

  L227:
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    havoc vslice_dummy_var_1282;
    call {:si_unique_call 1276} sdv_hash_986004649(vslice_dummy_var_1282);
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon115_Then, anon115_Else;

  anon115_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 2;
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    goto anon117_Then, anon117_Else;

  anon117_Else:
    deletePdo := 1;
    goto L246;

  L246:
    goto anon118_Then, anon118_Else;

  anon118_Else:
    assume {:partition} deletePdo != 0;
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    havoc vslice_dummy_var_1283;
    call {:si_unique_call 1277} sdv_hash_613687309(vslice_dummy_var_1283);
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    Tmp_649 := DEVICE_EXTENSION_VOLUME_EXTENSION(extension_7);
    assume {:nonnull} Tmp_649 != 0;
    assume Tmp_649 > 0;
    call {:si_unique_call 1278} vslice_dummy_var_315 := corral_nondet();
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    havoc vslice_dummy_var_1284;
    call {:si_unique_call 1279} sdv_hash_986004649(vslice_dummy_var_1284);
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    havoc vslice_dummy_var_1285;
    call {:si_unique_call 1280} sdv_hash_826125959(vslice_dummy_var_1285);
    call {:si_unique_call 1281} vslice_dummy_var_314 := IoDeleteSymbolicLink(0);
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    call {:si_unique_call 1282} ExFreePoolWithTag(0, 0);
    call {:si_unique_call 1283} IoDeleteDevice(0);
    goto L247;

  L247:
    status_20 := 0;
    goto L185;

  L185:
    goto anon113_Then, anon113_Else;

  anon113_Else:
    assume {:partition} status_20 == -1073741637;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    status_20 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))];
    goto L188;

  L188:
    call {:si_unique_call 1284} IofCompleteRequest(0, 0);
    Tmp_641 := status_20;
    goto L1;

  anon113_Then:
    assume {:partition} status_20 != -1073741637;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))] := status_20;
    goto L188;

  anon118_Then:
    assume {:partition} deletePdo == 0;
    goto L247;

  anon117_Then:
    goto L240;

  L240:
    deletePdo := 0;
    goto L246;

  anon116_Then:
    goto L240;

  anon115_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 2;
    deletePdo := 0;
    goto L246;

  anon114_Then:
    goto L227;

  anon135_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] != 23;
    status_20 := -1073741637;
    goto L185;

  anon136_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 22;
    status_20 := -1073741808;
    goto L185;

  anon137_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 20;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))] := 2;
    status_20 := 0;
    goto L185;

  anon138_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 19;
    call {:si_unique_call 1285} status_20 := sdv_hash_881177106(extension_7, Irp_17);
    goto L185;

  anon139_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 11;
    goto L176;

  L176:
    status_20 := 0;
    goto L185;

  anon140_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 10;
    goto L176;

  anon141_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 9;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    havoc capabilities;
    assume {:nonnull} capabilities != 0;
    assume capabilities > 0;
    assume {:nonnull} capabilities != 0;
    assume capabilities > 0;
    assume {:nonnull} capabilities != 0;
    assume capabilities > 0;
    assume {:nonnull} capabilities != 0;
    assume capabilities > 0;
    assume {:nonnull} capabilities != 0;
    assume capabilities > 0;
    status_20 := 0;
    goto L185;

  anon142_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 7;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon112_Then, anon112_Else;

  anon112_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] != 4;
    status_20 := -1073741637;
    goto L185;

  anon112_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_26[Type_unnamed_tag_26(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] == 4;
    call {:si_unique_call 1286} sdv_474 := ExAllocatePoolWithTag(1, 8, -229413034);
    deviceRelations_1 := sdv_474;
    goto anon156_Then, anon156_Else;

  anon156_Else:
    assume {:partition} deviceRelations_1 != 0;
    call {:si_unique_call 1287} vslice_dummy_var_312 := ObfReferenceObject(0);
    assume {:nonnull} deviceRelations_1 != 0;
    assume deviceRelations_1 > 0;
    assume {:nonnull} deviceRelations_1 != 0;
    assume deviceRelations_1 > 0;
    havoc Tmp_648;
    assume {:nonnull} Tmp_648 != 0;
    assume Tmp_648 > 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))] := deviceRelations_1;
    status_20 := 0;
    goto L185;

  anon156_Then:
    assume {:partition} deviceRelations_1 == 0;
    status_20 := -1073741670;
    goto L185;

  anon143_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 6;
    goto L176;

  anon144_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 5;
    status_20 := -1073741823;
    goto L185;

  anon145_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 3;
    status_20 := 0;
    goto L185;

  anon146_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 2;
    goto L223;

  anon147_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 1;
    assume {:nonnull} extension_7 != 0;
    assume extension_7 > 0;
    havoc Tmp_643;
    assume {:nonnull} Tmp_643 != 0;
    assume Tmp_643 > 0;
    goto anon155_Then, anon155_Else;

  anon155_Else:
    status_20 := -1073741808;
    goto L185;

  anon155_Then:
    status_20 := 0;
    goto L185;

  anon154_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_8)] == 0;
    call {:si_unique_call 1288} status_20 := sdv_hash_69582830(extension_7);
    goto L185;
}



procedure {:origName "VolSnapAddDevice"} VolSnapAddDevice(actual_DriverObject_8: int, actual_PhysicalDeviceObject_1: int) returns (Tmp_650: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26;
  free ensures Tmp_650 == 0 || Tmp_650 == -1073741810 || Tmp_650 == -1073741824 || Tmp_650 == -1073741771 || Tmp_650 == -1073741670 || Tmp_650 == -1073741823;



implementation {:origName "VolSnapAddDevice"} VolSnapAddDevice(actual_DriverObject_8: int, actual_PhysicalDeviceObject_1: int) returns (Tmp_650: int)
{
  var {:pointer} Tmp_651: int;
  var {:pointer} Tmp_652: int;
  var {:pointer} s_p_e_c_i_a_l_6: int;
  var {:pointer} deviceObject_1: int;
  var {:pointer} Tmp_653: int;
  var {:pointer} Tmp_655: int;
  var {:scalar} Tmp_657: int;
  var {:scalar} rundownSize: int;
  var {:scalar} sdv_480: int;
  var {:scalar} sdv_481: int;
  var {:pointer} Tmp_658: int;
  var {:pointer} filter_15: int;
  var {:pointer} Tmp_659: int;
  var {:pointer} rootExtension_1: int;
  var {:scalar} increment: int;
  var {:pointer} sdv_485: int;
  var {:scalar} ioWorkItemSize: int;
  var {:pointer} Tmp_661: int;
  var {:scalar} status_21: int;
  var {:scalar} t: int;
  var {:pointer} Tmp_663: int;
  var {:pointer} Tmp_664: int;
  var {:pointer} PhysicalDeviceObject_1: int;
  var boogieTmp: int;
  var vslice_dummy_var_316: int;
  var vslice_dummy_var_1286: int;
  var vslice_dummy_var_1287: int;

  anon0:
    call {:si_unique_call 1289} deviceObject_1 := __HAVOC_malloc(4);
    call {:si_unique_call 1290} t := __HAVOC_malloc(20);
    PhysicalDeviceObject_1 := actual_PhysicalDeviceObject_1;
    call {:si_unique_call 1291} rundownSize := corral_nondet();
    call {:si_unique_call 1292} ioWorkItemSize := corral_nondet();
    Tmp_657 := 2160 + rundownSize + ioWorkItemSize;
    call {:si_unique_call 1293} status_21 := IoCreateDevice(0, Tmp_657, 0, 34, 0, 0, deviceObject_1);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} status_21 >= 0;
    call {:si_unique_call 1294} sdv_485 := IoGetDriverObjectExtension(0, 0);
    rootExtension_1 := sdv_485;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} rootExtension_1 != 0;
    assume {:nonnull} deviceObject_1 != 0;
    assume deviceObject_1 > 0;
    havoc filter_15;
    assume {:nonnull} deviceObject_1 != 0;
    assume deviceObject_1 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1295} KeInitializeSpinLock(SpinLock_DEVICE_EXTENSION(DEVICE_EXTENSION_FILTER_EXTENSION(filter_15)));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1296} boogieTmp := IoAttachDeviceToDeviceStack(0, PhysicalDeviceObject_1);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1297} KeInitializeSemaphore(0, 1, 1);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1298} InitializeListHead(SnapshotLookupTableEntries_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1299} InitializeListHead(DiffAreaLookupTableEntries_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1300} KeInitializeEvent(ControlBlockFileHandleReady_FILTER_EXTENSION(filter_15), 0, 1);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1301} InitializeListHead(HoldQueue_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1302} InitializeListHead(NotifyFlushIrps_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1303} KeInitializeEvent(ZeroRefEvent_FILTER_EXTENSION(filter_15), 0, 1);
    call {:si_unique_call 1304} KeInitializeSemaphore(0, 1, 1);
    call {:si_unique_call 1305} KeInitializeTimer(0);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1306} KeInitializeDpc(HoldWritesTimerDpc_FILTER_EXTENSION(filter_15), li2bplFunctionConstant1286, 0);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1307} KeInitializeEvent(EndCommitProcessCompleted_FILTER_EXTENSION(filter_15), 0, 1);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1308} InitializeListHead(VolumeList_FILTER_EXTENSION(filter_15));
    call {:si_unique_call 1309} KeInitializeSemaphore(0, 1, 1);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1310} InitializeListHead(DeadVolumeList_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1311} InitializeListHead(DiffAreaFilesOnThisFilter_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1312} InitializeListHead(CopyOnWriteList_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1313} IoInitializeWorkItem(0, 0);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1314} InitializeListHead(IrpList__VSP_LOVELACE_DPC_CONTEXT(LovelaceContext_FILTER_EXTENSION(filter_15)));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1315} KeInitializeTimer(0);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1316} KeInitializeDpc(EndCommitTimerDpc_FILTER_EXTENSION(filter_15), li2bplFunctionConstant977, 0);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1317} InitializeListHead(NonPagedResourceList_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1318} InitializeListHead(PagedResourceList_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1319} vslice_dummy_var_316 := ExUuidCreate(0);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1320} InitializeListHead(CancelIrpList_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1321} KeInitializeEvent(DeviceRefCountZero_FILTER_EXTENSION(filter_15), 0, 0);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1322} InitializeListHead(BandwidthContractFileObjects_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1323} InitializeListHead(BandwidthRequestQueue_FILTER_EXTENSION(filter_15));
    Tmp_653 := KeTickCount;
    assume {:nonnull} Tmp_653 != 0;
    assume Tmp_653 > 0;
    havoc s_p_e_c_i_a_l_6;
    goto L149;

  L149:
    call {:si_unique_call 1324} VolSnapAddDevice_loop_L149(s_p_e_c_i_a_l_6, t);
    goto L149_last;

  L149_last:
    assume {:nonnull} s_p_e_c_i_a_l_6 != 0;
    assume s_p_e_c_i_a_l_6 > 0;
    assume {:nonnull} t != 0;
    assume t > 0;
    assume {:nonnull} s_p_e_c_i_a_l_6 != 0;
    assume s_p_e_c_i_a_l_6 > 0;
    assume {:nonnull} t != 0;
    assume t > 0;
    assume {:nonnull} s_p_e_c_i_a_l_6 != 0;
    assume s_p_e_c_i_a_l_6 > 0;
    assume {:nonnull} t != 0;
    assume t > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} t != 0;
    assume t > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    havoc Tmp_663;
    assume {:nonnull} Tmp_663 != 0;
    assume Tmp_663 > 0;
    assume {:nonnull} deviceObject_1 != 0;
    assume deviceObject_1 > 0;
    assume {:nonnull} deviceObject_1 != 0;
    assume deviceObject_1 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    havoc Tmp_651;
    assume {:nonnull} Tmp_651 != 0;
    assume Tmp_651 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:nonnull} deviceObject_1 != 0;
    assume deviceObject_1 > 0;
    goto L163;

  L163:
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    havoc Tmp_661;
    assume {:nonnull} Tmp_661 != 0;
    assume Tmp_661 > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:nonnull} deviceObject_1 != 0;
    assume deviceObject_1 > 0;
    goto L165;

  L165:
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    havoc Tmp_664;
    assume {:nonnull} Tmp_664 != 0;
    assume Tmp_664 > 0;
    assume {:nonnull} deviceObject_1 != 0;
    assume deviceObject_1 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1325} KeInitializeSpinLock(SpinLock_VSP_IO_WINDOW(IoWindow_FILTER_EXTENSION(filter_15)));
    call {:si_unique_call 1326} sdv_481 := corral_nondet();
    increment := sdv_481;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1327} sdv_480 := corral_nondet();
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    havoc vslice_dummy_var_1286;
    call {:si_unique_call 1328} sdv_hash_613687309(vslice_dummy_var_1286);
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    havoc Tmp_658;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    havoc Tmp_655;
    assume {:nonnull} Tmp_655 != 0;
    assume Tmp_655 > 0;
    assume {:nonnull} Tmp_658 != 0;
    assume Tmp_658 > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    goto L184;

  L184:
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    Tmp_652 := DEVICE_EXTENSION_FILTER_EXTENSION(filter_15);
    assume {:nonnull} Tmp_652 != 0;
    assume Tmp_652 > 0;
    havoc Tmp_659;
    assume {:nonnull} Tmp_659 != 0;
    assume Tmp_659 > 0;
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    call {:si_unique_call 1329} InsertTailList(FilterList__DO_EXTENSION(Tmp_659), ListEntry_FILTER_EXTENSION(filter_15));
    assume {:nonnull} filter_15 != 0;
    assume filter_15 > 0;
    havoc vslice_dummy_var_1287;
    call {:si_unique_call 1330} sdv_hash_986004649(vslice_dummy_var_1287);
    assume {:nonnull} deviceObject_1 != 0;
    assume deviceObject_1 > 0;
    Tmp_650 := 0;
    goto L1;

  L1:
    return;

  anon21_Then:
    goto L184;

  anon20_Then:
    goto L165;

  anon19_Then:
    goto L163;

  anon18_Then:
    goto anon18_Then_dummy;

  anon18_Then_dummy:
    assume false;
    return;

  anon16_Then:
    call {:si_unique_call 1331} IoDeleteDevice(0);
    Tmp_650 := -1073741810;
    goto L1;

  anon17_Then:
    assume {:partition} rootExtension_1 == 0;
    call {:si_unique_call 1332} IoDeleteDevice(0);
    Tmp_650 := -1073741810;
    goto L1;

  anon15_Then:
    assume {:partition} 0 > status_21;
    Tmp_650 := status_21;
    goto L1;
}



procedure {:origName "sdv_hash_172139115"} sdv_hash_172139115(actual_Extension_13: int, actual_ListOfDiffAreaFilesToClose_2: int, actual_KeepOnDisk_2: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, ref, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:origName "sdv_hash_172139115"} sdv_hash_172139115(actual_Extension_13: int, actual_ListOfDiffAreaFilesToClose_2: int, actual_KeepOnDisk_2: int)
{
  var {:pointer} diffAreaFile_3: int;
  var {:pointer} w2: int;
  var {:pointer} lookupEntry_3: int;
  var {:pointer} m2: int;
  var {:scalar} sdv_498: int;
  var {:pointer} filter_16: int;
  var {:pointer} w1: int;
  var {:scalar} sdv_503: int;
  var {:pointer} ll: int;
  var {:pointer} l_14: int;
  var {:scalar} q_4: int;
  var {:scalar} sdv_505: int;
  var {:pointer} oldHeapEntry: int;
  var {:scalar} sdv_506: int;
  var {:pointer} m1: int;
  var {:scalar} irql_24: int;
  var {:pointer} Extension_13: int;
  var {:pointer} ListOfDiffAreaFilesToClose_2: int;
  var {:scalar} KeepOnDisk_2: int;
  var vslice_dummy_var_317: int;
  var vslice_dummy_var_318: int;
  var vslice_dummy_var_319: int;
  var vslice_dummy_var_320: int;
  var vslice_dummy_var_321: int;
  var vslice_dummy_var_322: int;
  var vslice_dummy_var_323: int;
  var vslice_dummy_var_324: int;
  var vslice_dummy_var_325: int;
  var vslice_dummy_var_326: int;
  var vslice_dummy_var_1288: int;
  var vslice_dummy_var_1289: int;
  var vslice_dummy_var_1290: int;
  var vslice_dummy_var_1291: int;
  var vslice_dummy_var_1292: int;
  var vslice_dummy_var_1293: int;
  var vslice_dummy_var_1294: int;
  var vslice_dummy_var_1295: int;

  anon0:
    call {:si_unique_call 1333} vslice_dummy_var_317 := __HAVOC_malloc(4);
    call {:si_unique_call 1334} q_4 := __HAVOC_malloc(8);
    Extension_13 := actual_Extension_13;
    ListOfDiffAreaFilesToClose_2 := actual_ListOfDiffAreaFilesToClose_2;
    KeepOnDisk_2 := actual_KeepOnDisk_2;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc filter_16;
    call {:si_unique_call 1335} sdv_hash_1047753544(Extension_13, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    call {:si_unique_call 1336} vslice_dummy_var_318 := ZwUnmapViewOfSection(0, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto L28;

  L28:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    call {:si_unique_call 1337} vslice_dummy_var_319 := ZwUnmapViewOfSection(0, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto L34;

  L34:
    call {:si_unique_call 1338} sdv_498, l_14, oldHeapEntry, vslice_dummy_var_326 := sdv_hash_172139115_loop_L34(sdv_498, l_14, oldHeapEntry, Extension_13, vslice_dummy_var_326);
    goto L34_last;

  L34_last:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    call {:si_unique_call 1394} sdv_498 := IsListEmpty(OldHeaps_VOLUME_EXTENSION(Extension_13));
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} sdv_498 != 0;
    call {:si_unique_call 1339} sdv_hash_853253100(Extension_13);
    call {:si_unique_call 1340} sdv_hash_805325738(Extension_13, 0, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc w1;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc m1;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc w2;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc m2;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    call {:si_unique_call 1341} sdv_503 := IsListEmpty(OldWriteHeaps_VOLUME_EXTENSION(Extension_13));
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} sdv_503 != 0;
    call {:si_unique_call 1342} InitializeListHead(q_4);
    goto L66;

  L66:
    call {:si_unique_call 1343} sdv_hash_692646834(Extension_13);
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} w1 != 0;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} m1 != 0;
    call {:si_unique_call 1344} MmUnlockPages(0);
    call {:si_unique_call 1345} IoFreeMdl(0);
    goto L72;

  L72:
    call {:si_unique_call 1346} vslice_dummy_var_320 := ZwUnmapViewOfSection(0, 0);
    goto L70;

  L70:
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} w2 != 0;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} m2 != 0;
    call {:si_unique_call 1347} MmUnlockPages(0);
    call {:si_unique_call 1348} IoFreeMdl(0);
    goto L86;

  L86:
    call {:si_unique_call 1349} vslice_dummy_var_321 := ZwUnmapViewOfSection(0, 0);
    goto L82;

  L82:
    call {:si_unique_call 1350} l_14, oldHeapEntry, sdv_506, vslice_dummy_var_325 := sdv_hash_172139115_loop_L82(l_14, q_4, oldHeapEntry, sdv_506, vslice_dummy_var_325);
    goto L82_last;

  L82_last:
    call {:si_unique_call 1393} sdv_506 := IsListEmpty(q_4);
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} sdv_506 != 0;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} KeepOnDisk_2 == 0;
    call {:si_unique_call 1351} vslice_dummy_var_322 := sdv_hash_301435450(Extension_13);
    goto L101;

  L101:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc diffAreaFile_3;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    call {:si_unique_call 1352} irql_24 := KfAcquireSpinLock(0);
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    call {:si_unique_call 1353} vslice_dummy_var_323 := RemoveEntryList(FilterListEntry__VSP_DIFF_AREA_FILE(diffAreaFile_3));
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    goto L116;

  L116:
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    call {:si_unique_call 1354} KfReleaseSpinLock(0, irql_24);
    call {:si_unique_call 1355} irql_24 := KfAcquireSpinLock(0);
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    assume {:nonnull} filter_16 != 0;
    assume filter_16 > 0;
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    assume {:nonnull} filter_16 != 0;
    assume filter_16 > 0;
    call {:si_unique_call 1356} KfReleaseSpinLock(0, irql_24);
    goto L132;

  L132:
    call {:si_unique_call 1357} ll, sdv_505 := sdv_hash_172139115_loop_L132(diffAreaFile_3, ll, sdv_505);
    goto L132_last;

  L132_last:
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    call {:si_unique_call 1392} sdv_505 := IsListEmpty(UnusedAllocationList__VSP_DIFF_AREA_FILE(diffAreaFile_3));
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} sdv_505 != 0;
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    havoc vslice_dummy_var_1288;
    call {:si_unique_call 1358} VspFreeIrp(vslice_dummy_var_1288, 1);
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    goto L140;

  L140:
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    havoc vslice_dummy_var_1289;
    call {:si_unique_call 1359} VspFreeIrp(vslice_dummy_var_1289, 1);
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    goto L145;

  L145:
    goto anon77_Then, anon77_Else;

  anon77_Else:
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} KeepOnDisk_2 != 0;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc vslice_dummy_var_1290;
    call {:si_unique_call 1360} lookupEntry_3 := sdv_hash_414123790(vslice_dummy_var_1290, SnapshotGuid_VOLUME_EXTENSION(Extension_13), filter_16);
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} lookupEntry_3 != 0;
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    assume {:nonnull} lookupEntry_3 != 0;
    assume lookupEntry_3 > 0;
    call {:si_unique_call 1361} ExFreePoolWithTag(0, 0);
    goto L106;

  L106:
    call {:si_unique_call 1362} irql_24 := KfAcquireSpinLock(0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc vslice_dummy_var_1291;
    call {:si_unique_call 1363} VspFreeBitMap(vslice_dummy_var_1291);
    call {:si_unique_call 1364} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto L185;

  L185:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc vslice_dummy_var_1292;
    call {:si_unique_call 1365} VspFreeBitMap(vslice_dummy_var_1292);
    call {:si_unique_call 1366} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto L193;

  L193:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc vslice_dummy_var_1293;
    call {:si_unique_call 1367} VspFreeBitMap(vslice_dummy_var_1293);
    call {:si_unique_call 1368} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto L201;

  L201:
    call {:si_unique_call 1369} KfReleaseSpinLock(0, irql_24);
    call {:si_unique_call 1370} sdv_hash_1047753544(Extension_13, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    call {:si_unique_call 1371} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto L215;

  L215:
    call {:si_unique_call 1372} sdv_hash_853253100(Extension_13);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    havoc vslice_dummy_var_1294;
    call {:si_unique_call 1373} VspFreeIrp(vslice_dummy_var_1294, 1);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto L224;

  L224:
    assume {:nonnull} filter_16 != 0;
    assume filter_16 > 0;
    havoc vslice_dummy_var_1295;
    call {:si_unique_call 1374} vslice_dummy_var_324 := sdv_hash_899948027(vslice_dummy_var_1295);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto L232;

  L232:
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto anon89_Then, anon89_Else;

  anon89_Else:
    call {:si_unique_call 1375} ExFreePoolWithTag(0, 0);
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    goto L1;

  L1:
    return;

  anon89_Then:
    goto L1;

  anon88_Then:
    goto L232;

  anon87_Then:
    goto L224;

  anon86_Then:
    goto L215;

  anon85_Then:
    goto L201;

  anon84_Then:
    goto L193;

  anon83_Then:
    goto L185;

  anon81_Then:
    assume {:partition} lookupEntry_3 == 0;
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    call {:si_unique_call 1376} InsertTailList(ListOfDiffAreaFilesToClose_2, ListEntry__VSP_DIFF_AREA_FILE(diffAreaFile_3));
    goto L106;

  anon82_Then:
    call {:si_unique_call 1377} ExFreePoolWithTag(0, 0);
    goto L106;

  anon80_Then:
    goto L154;

  L154:
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    call {:si_unique_call 1378} InsertTailList(ListOfDiffAreaFilesToClose_2, ListEntry__VSP_DIFF_AREA_FILE(diffAreaFile_3));
    goto L106;

  anon79_Then:
    call {:si_unique_call 1379} ExFreePoolWithTag(0, 0);
    goto L106;

  anon78_Then:
    assume {:partition} KeepOnDisk_2 == 0;
    goto L154;

  anon77_Then:
    call {:si_unique_call 1380} ExFreePoolWithTag(0, 0);
    goto L106;

  anon76_Then:
    goto L145;

  anon75_Then:
    goto L140;

  anon74_Then:
    assume {:partition} sdv_505 == 0;
    assume {:nonnull} diffAreaFile_3 != 0;
    assume diffAreaFile_3 > 0;
    call {:si_unique_call 1381} ll := RemoveHeadList(UnusedAllocationList__VSP_DIFF_AREA_FILE(diffAreaFile_3));
    call {:si_unique_call 1382} ExFreePoolWithTag(0, 0);
    goto anon74_Then_dummy;

  anon74_Then_dummy:
    assume false;
    return;

  anon73_Then:
    goto L116;

  anon71_Then:
    goto L106;

  anon72_Then:
    assume {:partition} KeepOnDisk_2 != 0;
    goto L101;

  anon70_Then:
    goto L101;

  anon69_Then:
    assume {:partition} sdv_506 == 0;
    call {:si_unique_call 1383} l_14 := RemoveHeadList(q_4);
    oldHeapEntry := l_14;
    assume {:nonnull} oldHeapEntry != 0;
    assume oldHeapEntry > 0;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    call {:si_unique_call 1384} MmUnlockPages(0);
    call {:si_unique_call 1385} IoFreeMdl(0);
    goto L244;

  L244:
    call {:si_unique_call 1386} vslice_dummy_var_325 := ZwUnmapViewOfSection(0, 0);
    call {:si_unique_call 1387} ExFreePoolWithTag(0, 0);
    goto L244_dummy;

  L244_dummy:
    assume false;
    return;

  anon90_Then:
    goto L244;

  anon68_Then:
    assume {:partition} m2 == 0;
    goto L86;

  anon66_Then:
    assume {:partition} w2 == 0;
    goto L82;

  anon67_Then:
    assume {:partition} m1 == 0;
    goto L72;

  anon65_Then:
    assume {:partition} w1 == 0;
    goto L70;

  anon64_Then:
    assume {:partition} sdv_503 == 0;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    assume {:nonnull} q_4 != 0;
    assume q_4 > 0;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    assume {:nonnull} q_4 != 0;
    assume q_4 > 0;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    call {:si_unique_call 1388} InitializeListHead(OldWriteHeaps_VOLUME_EXTENSION(Extension_13));
    assume {:nonnull} q_4 != 0;
    assume q_4 > 0;
    assume {:nonnull} q_4 != 0;
    assume q_4 > 0;
    goto L66;

  anon63_Then:
    assume {:partition} sdv_498 == 0;
    assume {:nonnull} Extension_13 != 0;
    assume Extension_13 > 0;
    call {:si_unique_call 1389} l_14 := RemoveHeadList(OldHeaps_VOLUME_EXTENSION(Extension_13));
    oldHeapEntry := l_14;
    call {:si_unique_call 1390} vslice_dummy_var_326 := ZwUnmapViewOfSection(0, 0);
    call {:si_unique_call 1391} ExFreePoolWithTag(0, 0);
    goto anon63_Then_dummy;

  anon63_Then_dummy:
    assume false;
    return;

  anon62_Then:
    goto L34;

  anon61_Then:
    goto L28;
}



procedure {:origName "sdv_hash_77318239"} sdv_hash_77318239(actual_RootExtension_10: int) returns (Tmp_669: int);
  modifies alloc;



implementation {:origName "sdv_hash_77318239"} sdv_hash_77318239(actual_RootExtension_10: int) returns (Tmp_669: int)
{
  var {:pointer} sdv_509: int;
  var {:pointer} writeContext: int;
  var {:pointer} RootExtension_10: int;

  anon0:
    RootExtension_10 := actual_RootExtension_10;
    writeContext := 0;
    assume {:nonnull} RootExtension_10 != 0;
    assume RootExtension_10 > 0;
    call {:si_unique_call 1395} sdv_509 := ExAllocateFromNPagedLookasideList(WriteContextLookasideList__DO_EXTENSION(RootExtension_10));
    writeContext := sdv_509;
    Tmp_669 := writeContext;
    return;
}



procedure {:origName "sdv_hash_141061226"} sdv_hash_141061226(actual_Extension_14: int);
  modifies alloc;



implementation {:origName "sdv_hash_141061226"} sdv_hash_141061226(actual_Extension_14: int)
{
  var {:pointer} diffAreaFile_5: int;
  var {:pointer} filter_17: int;
  var {:scalar} sdv_544: int;
  var {:pointer} ll_1: int;
  var {:scalar} irql_26: int;
  var {:pointer} Extension_14: int;
  var vslice_dummy_var_327: int;
  var vslice_dummy_var_328: int;
  var vslice_dummy_var_329: int;
  var vslice_dummy_var_1296: int;
  var vslice_dummy_var_1297: int;

  anon0:
    call {:si_unique_call 1396} vslice_dummy_var_327 := __HAVOC_malloc(4);
    Extension_14 := actual_Extension_14;
    assume {:nonnull} Extension_14 != 0;
    assume Extension_14 > 0;
    havoc filter_17;
    assume {:nonnull} Extension_14 != 0;
    assume Extension_14 > 0;
    havoc diffAreaFile_5;
    assume {:nonnull} Extension_14 != 0;
    assume Extension_14 > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} diffAreaFile_5 != 0;
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    call {:si_unique_call 1397} vslice_dummy_var_328 := ZwClose(0);
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    goto L18;

  L18:
    call {:si_unique_call 1398} irql_26 := KfAcquireSpinLock(0);
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    assume {:nonnull} filter_17 != 0;
    assume filter_17 > 0;
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    assume {:nonnull} filter_17 != 0;
    assume filter_17 > 0;
    call {:si_unique_call 1399} KfReleaseSpinLock(0, irql_26);
    goto L31;

  L31:
    call {:si_unique_call 1400} sdv_544, ll_1 := sdv_hash_141061226_loop_L31(diffAreaFile_5, sdv_544, ll_1);
    goto L31_last;

  L31_last:
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    call {:si_unique_call 1409} sdv_544 := IsListEmpty(UnusedAllocationList__VSP_DIFF_AREA_FILE(diffAreaFile_5));
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} sdv_544 != 0;
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    call {:si_unique_call 1401} irql_26 := KfAcquireSpinLock(0);
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    call {:si_unique_call 1402} vslice_dummy_var_329 := RemoveEntryList(FilterListEntry__VSP_DIFF_AREA_FILE(diffAreaFile_5));
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    goto L43;

  L43:
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    call {:si_unique_call 1403} KfReleaseSpinLock(0, irql_26);
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    havoc vslice_dummy_var_1296;
    call {:si_unique_call 1404} VspFreeIrp(vslice_dummy_var_1296, 1);
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    goto L51;

  L51:
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    havoc vslice_dummy_var_1297;
    call {:si_unique_call 1405} VspFreeIrp(vslice_dummy_var_1297, 1);
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    goto L56;

  L56:
    call {:si_unique_call 1406} ExFreePoolWithTag(0, 0);
    diffAreaFile_5 := 0;
    goto L1;

  L1:
    return;

  anon17_Then:
    goto L56;

  anon16_Then:
    goto L51;

  anon15_Then:
    goto L43;

  anon14_Then:
    assume {:partition} sdv_544 == 0;
    assume {:nonnull} diffAreaFile_5 != 0;
    assume diffAreaFile_5 > 0;
    call {:si_unique_call 1407} ll_1 := RemoveHeadList(UnusedAllocationList__VSP_DIFF_AREA_FILE(diffAreaFile_5));
    call {:si_unique_call 1408} ExFreePoolWithTag(0, 0);
    goto anon14_Then_dummy;

  anon14_Then_dummy:
    assume false;
    return;

  anon13_Then:
    goto L18;

  anon18_Then:
    assume {:partition} diffAreaFile_5 == 0;
    goto L1;
}



procedure {:dopa "Mem_T.INT4"} dummy_for_pa();



procedure corralExplainErrorInit();



procedure corralExtraInit();
  free ensures alloc >= old(alloc);



implementation corralExtraInit()
{

  anon0:
    assume 0 < alloc_init;
    assume alloc_init < alloc;
    return;
}



function {:inline true} {:fieldmap "Mem_T.ActivateStarted_FILTER_EXTENSION"} {:fieldname "ActivateStarted"} ActivateStarted_FILTER_EXTENSION(x: int) : int
{
  x + 3904
}

function {:inline true} {:fieldmap "Mem_T.ActualMediumPriorityWorkItem__DO_EXTENSION"} {:fieldname "ActualMediumPriorityWorkItem"} ActualMediumPriorityWorkItem__DO_EXTENSION(x: int) : int
{
  x + 1880
}

function {:inline true} {:fieldmap "Mem_T.AddDevice__DRIVER_EXTENSION"} {:fieldname "AddDevice"} AddDevice__DRIVER_EXTENSION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Address__DEVICE_CAPABILITIES"} {:fieldname "Address"} Address__DEVICE_CAPABILITIES(x: int) : int
{
  x + 88
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "AdjustBitmapQueue"} AdjustBitmapQueue__DO_EXTENSION(x: int) : int
{
  x + 2440
}

function {:inline true} {:fieldmap "Mem_T.AliveToPnp_VOLUME_EXTENSION"} {:fieldname "AliveToPnp"} AliveToPnp_VOLUME_EXTENSION(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.AllocateMisses__GENERAL_LOOKASIDE"} {:fieldname "AllocateMisses"} AllocateMisses__GENERAL_LOOKASIDE(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Allocate__GENERAL_LOOKASIDE"} {:fieldname "Allocate"} Allocate__GENERAL_LOOKASIDE(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T.AllocatedFileSize__VSP_DIFF_AREA_FILE"} {:fieldname "AllocatedFileSize"} AllocatedFileSize__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.AllocatedVolumeSpace_FILTER_EXTENSION"} {:fieldname "AllocatedVolumeSpace"} AllocatedVolumeSpace_FILTER_EXTENSION(x: int) : int
{
  x + 1288
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "AnotherListEntry"} AnotherListEntry_VOLUME_EXTENSION(x: int) : int
{
  x + 1080
}

function {:inline true} {:fieldmap "Mem_T.ApplicationFlags_FILTER_EXTENSION"} {:fieldname "ApplicationFlags"} ApplicationFlags_FILTER_EXTENSION(x: int) : int
{
  x + 4048
}

function {:inline true} {:fieldmap "Mem_T.ApplicationFlags__VSP_BLOCK_START"} {:fieldname "ApplicationFlags"} ApplicationFlags__VSP_BLOCK_START(x: int) : int
{
  x + 160
}

function {:inline true} {:fieldmap "Mem_T.ApplicationInformationSize_VOLUME_EXTENSION"} {:fieldname "ApplicationInformationSize"} ApplicationInformationSize_VOLUME_EXTENSION(x: int) : int
{
  x + 988
}

function {:inline true} {:fieldmap "Mem_T.ApplicationInformation_VOLUME_EXTENSION"} {:fieldname "ApplicationInformation"} ApplicationInformation_VOLUME_EXTENSION(x: int) : int
{
  x + 992
}

function {:inline true} {:fieldmap "Mem_T.ArrayOfBitMaps__VSP_BITMAP"} {:fieldname "ArrayOfBitMaps"} ArrayOfBitMaps__VSP_BITMAP(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Attributes__OBJECT_ATTRIBUTES"} {:fieldname "Attributes"} Attributes__OBJECT_ATTRIBUTES(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "BandwidthContractFileObjects"} BandwidthContractFileObjects_FILTER_EXTENSION(x: int) : int
{
  x + 4184
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "BandwidthRequestQueue"} BandwidthRequestQueue_FILTER_EXTENSION(x: int) : int
{
  x + 4192
}

function {:inline true} {:fieldmap "Mem_T.Blink__LIST_ENTRY"} {:fieldname "Blink"} Blink__LIST_ENTRY(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.BlockType__VSP_BLOCK_HEADER"} {:fieldname "BlockType"} BlockType__VSP_BLOCK_HEADER(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.Buffer__RTL_BITMAP"} {:fieldname "Buffer"} Buffer__RTL_BITMAP(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Buffer__UNICODE_STRING"} {:fieldname "Buffer"} Buffer__UNICODE_STRING(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.ByteOffset_unnamed_tag_10"} {:fieldname "ByteOffset"} ByteOffset_unnamed_tag_10(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "CancelIrpList"} CancelIrpList_FILTER_EXTENSION(x: int) : int
{
  x + 4040
}

function {:inline true} {:fieldmap "Mem_T.CancelIrql__IRP"} {:fieldname "CancelIrql"} CancelIrql__IRP(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T.CancelRoutine__IRP"} {:fieldname "CancelRoutine"} CancelRoutine__IRP(x: int) : int
{
  x + 120
}

function {:inline true} {:fieldmap "Mem_T.Cancel__IRP"} {:fieldname "Cancel"} Cancel__IRP(x: int) : int
{
  x + 64
}

function {:inline true} {:fieldmap "Mem_T.Capabilities_unnamed_tag_28"} {:fieldname "Capabilities"} Capabilities_unnamed_tag_28(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Channel__EVENT_DESCRIPTOR"} {:fieldname "Channel"} Channel__EVENT_DESCRIPTOR(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Characteristics__DEVICE_OBJECT"} {:fieldname "Characteristics"} Characteristics__DEVICE_OBJECT(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.CleanupWorkerThread_VOLUME_EXTENSION"} {:fieldname "CleanupWorkerThread"} CleanupWorkerThread_VOLUME_EXTENSION(x: int) : int
{
  x + 76
}

function {:inline true} {:fieldmap "Mem_T.CloseHandles__VSP_CONTEXT"} {:fieldname "CloseHandles"} CloseHandles__VSP_CONTEXT(x: int) : int
{
  x + 468
}

function {:inline true} {:fieldmap "Mem_T.CompletionRoutine__IO_STACK_LOCATION"} {:fieldname "CompletionRoutine"} CompletionRoutine__IO_STACK_LOCATION(x: int) : int
{
  x + 496
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "ContextFreeCount"} ContextFreeCount_VSP_DEBUG_INFO(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.ContextFrees_VSP_DEBUG_INFO"} {:fieldname "ContextFrees"} ContextFrees_VSP_DEBUG_INFO(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T._NPAGED_LOOKASIDE_LIST"} {:fieldname "ContextLookasideList"} ContextLookasideList__DO_EXTENSION(x: int) : int
{
  x + 2020
}

function {:inline true} {:fieldmap "Mem_T.Context__IO_STACK_LOCATION"} {:fieldname "Context"} Context__IO_STACK_LOCATION(x: int) : int
{
  x + 500
}

function {:inline true} {:fieldmap "Mem_T._KEVENT"} {:fieldname "ControlBlockFileHandleReady"} ControlBlockFileHandleReady_FILTER_EXTENSION(x: int) : int
{
  x + 368
}

function {:inline true} {:fieldmap "Mem_T.ControlBlockFileHandle_FILTER_EXTENSION"} {:fieldname "ControlBlockFileHandle"} ControlBlockFileHandle_FILTER_EXTENSION(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T.ControlBlockFileObject_FILTER_EXTENSION"} {:fieldname "ControlBlockFileObject"} ControlBlockFileObject_FILTER_EXTENSION(x: int) : int
{
  x + 72
}

function {:inline true} {:fieldmap "Mem_T.ControlItemType__VSP_CONTROL_ITEM_SNAPSHOT"} {:fieldname "ControlItemType"} ControlItemType__VSP_CONTROL_ITEM_SNAPSHOT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Control__IO_STACK_LOCATION"} {:fieldname "Control"} Control__IO_STACK_LOCATION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "CopyOnWriteList"} CopyOnWriteList_FILTER_EXTENSION(x: int) : int
{
  x + 3908
}

function {:inline true} {:fieldmap "Mem_T.Count__DEVICE_RELATIONS"} {:fieldname "Count"} Count__DEVICE_RELATIONS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.CriticalOwningThread_FILTER_EXTENSION"} {:fieldname "CriticalOwningThread"} CriticalOwningThread_FILTER_EXTENSION(x: int) : int
{
  x + 1260
}

function {:inline true} {:fieldmap "Mem_T.Critical_sdv_hash_575348796"} {:fieldname "Critical"} Critical_sdv_hash_575348796(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.CurrentLocation__IRP"} {:fieldname "CurrentLocation"} CurrentLocation__IRP(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.CurrentStackLocation_unnamed_tag_6"} {:fieldname "CurrentStackLocation"} CurrentStackLocation_unnamed_tag_6(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.CurrentWritePointerOut_FILTER_EXTENSION"} {:fieldname "CurrentWritePointerOut"} CurrentWritePointerOut_FILTER_EXTENSION(x: int) : int
{
  x + 4236
}

function {:inline true} {:fieldmap "Mem_T.DEVICE_EXTENSION"} {:fieldname "DEVICE_EXTENSION"} DEVICE_EXTENSION_FILTER_EXTENSION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.DEVICE_EXTENSION"} {:fieldname "DEVICE_EXTENSION"} DEVICE_EXTENSION_VOLUME_EXTENSION(x: int) : int
{
  x + 4
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

function {:inline true} {:fieldmap "Mem_T.DaysToLookBackForHotBlocks_FILTER_EXTENSION"} {:fieldname "DaysToLookBackForHotBlocks"} DaysToLookBackForHotBlocks_FILTER_EXTENSION(x: int) : int
{
  x + 4224
}

function {:inline true} {:fieldmap "Mem_T.DaysToLookBackForHotBlocks__VSP_BLOCK_START"} {:fieldname "DaysToLookBackForHotBlocks"} DaysToLookBackForHotBlocks__VSP_BLOCK_START(x: int) : int
{
  x + 172
}

function {:inline true} {:fieldmap "Mem_T.Dbg__DO_EXTENSION"} {:fieldname "Dbg"} Dbg__DO_EXTENSION(x: int) : int
{
  x + 2940
}

function {:inline true} {:fieldmap "Mem_T.DeadToPnp_VOLUME_EXTENSION"} {:fieldname "DeadToPnp"} DeadToPnp_VOLUME_EXTENSION(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "DeadVolumeList"} DeadVolumeList_FILTER_EXTENSION(x: int) : int
{
  x + 1264
}

function {:inline true} {:fieldmap "Mem_T.DefaultData__RTL_QUERY_REGISTRY_TABLE"} {:fieldname "DefaultData"} DefaultData__RTL_QUERY_REGISTRY_TABLE(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.DefaultLength__RTL_QUERY_REGISTRY_TABLE"} {:fieldname "DefaultLength"} DefaultLength__RTL_QUERY_REGISTRY_TABLE(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.DefaultType__RTL_QUERY_REGISTRY_TABLE"} {:fieldname "DefaultType"} DefaultType__RTL_QUERY_REGISTRY_TABLE(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.DeferredRoutine__KDPC"} {:fieldname "DeferredRoutine"} DeferredRoutine__KDPC(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.DeleteFile__FILE_DISPOSITION_INFORMATION"} {:fieldname "DeleteFile"} DeleteFile__FILE_DISPOSITION_INFORMATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DeleteTimer_FILTER_EXTENSION"} {:fieldname "DeleteTimer"} DeleteTimer_FILTER_EXTENSION(x: int) : int
{
  x + 3928
}

function {:inline true} {:fieldmap "Mem_T.Depth__GENERAL_LOOKASIDE"} {:fieldname "Depth"} Depth__GENERAL_LOOKASIDE(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Depth__SLIST_HEADER"} {:fieldname "Depth"} Depth__SLIST_HEADER(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DestroyContext_FILTER_EXTENSION"} {:fieldname "DestroyContext"} DestroyContext_FILTER_EXTENSION(x: int) : int
{
  x + 1508
}

function {:inline true} {:fieldmap "Mem_T.DeviceCapabilities_unnamed_tag_8"} {:fieldname "DeviceCapabilities"} DeviceCapabilities_unnamed_tag_8(x: int) : int
{
  x + 312
}

function {:inline true} {:fieldmap "Mem_T.DeviceDeleted_FILTER_EXTENSION"} {:fieldname "DeviceDeleted"} DeviceDeleted_FILTER_EXTENSION(x: int) : int
{
  x + 4052
}

function {:inline true} {:fieldmap "Mem_T.DeviceDeleted_VOLUME_EXTENSION"} {:fieldname "DeviceDeleted"} DeviceDeleted_VOLUME_EXTENSION(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.DeviceExtensionType_DEVICE_EXTENSION"} {:fieldname "DeviceExtensionType"} DeviceExtensionType_DEVICE_EXTENSION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DeviceExtension__DEVICE_OBJECT"} {:fieldname "DeviceExtension"} DeviceExtension__DEVICE_OBJECT(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"} {:fieldname "DeviceObjectName"} DeviceObjectName_VOLUME_EXTENSION(x: int) : int
{
  x + 472
}

function {:inline true} {:fieldmap "Mem_T.DeviceObject_DEVICE_EXTENSION"} {:fieldname "DeviceObject"} DeviceObject_DEVICE_EXTENSION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DeviceObject__IO_STACK_LOCATION"} {:fieldname "DeviceObject"} DeviceObject__IO_STACK_LOCATION(x: int) : int
{
  x + 488
}

function {:inline true} {:fieldmap "Mem_T._KEVENT"} {:fieldname "DeviceRefCountZero"} DeviceRefCountZero_FILTER_EXTENSION(x: int) : int
{
  x + 4060
}

function {:inline true} {:fieldmap "Mem_T.DeviceRefCount_FILTER_EXTENSION"} {:fieldname "DeviceRefCount"} DeviceRefCount_FILTER_EXTENSION(x: int) : int
{
  x + 4056
}

function {:inline true} {:fieldmap "Mem_T.DeviceType__DEVICE_OBJECT"} {:fieldname "DeviceType"} DeviceType__DEVICE_OBJECT(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.Device__VSP_RESOURCE"} {:fieldname "Device"} Device__VSP_RESOURCE(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.DiagPrefix_FILTER_EXTENSION"} {:fieldname "DiagPrefix"} DiagPrefix_FILTER_EXTENSION(x: int) : int
{
  x + 4204
}

function {:inline true} {:fieldmap "Mem_T.DiagTraceHandle__DO_EXTENSION"} {:fieldname "DiagTraceHandle"} DiagTraceHandle__DO_EXTENSION(x: int) : int
{
  x + 2924
}

function {:inline true} {:fieldmap "Mem_T.DiffAreaFileMapMdl__OLD_HEAP_ENTRY"} {:fieldname "DiffAreaFileMapMdl"} DiffAreaFileMapMdl__OLD_HEAP_ENTRY(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.DiffAreaFileMap_VOLUME_EXTENSION"} {:fieldname "DiffAreaFileMap"} DiffAreaFileMap_VOLUME_EXTENSION(x: int) : int
{
  x + 904
}

function {:inline true} {:fieldmap "Mem_T.DiffAreaFile_VOLUME_EXTENSION"} {:fieldname "DiffAreaFile"} DiffAreaFile_VOLUME_EXTENSION(x: int) : int
{
  x + 900
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "DiffAreaFilesOnThisFilter"} DiffAreaFilesOnThisFilter_FILTER_EXTENSION(x: int) : int
{
  x + 1272
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "DiffAreaFilterListEntry"} DiffAreaFilterListEntry__VSP_LOOKUP_TABLE_ENTRY(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.DiffAreaFilter__VSP_LOOKUP_TABLE_ENTRY"} {:fieldname "DiffAreaFilter"} DiffAreaFilter__VSP_LOOKUP_TABLE_ENTRY(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.DiffAreaFilter_sdv_hash_514641693"} {:fieldname "DiffAreaFilter"} DiffAreaFilter_sdv_hash_514641693(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.DiffAreaHandle__VSP_LOOKUP_TABLE_ENTRY"} {:fieldname "DiffAreaHandle"} DiffAreaHandle__VSP_LOOKUP_TABLE_ENTRY(x: int) : int
{
  x + 156
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "DiffAreaLookupTableEntries"} DiffAreaLookupTableEntries_FILTER_EXTENSION(x: int) : int
{
  x + 360
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "DiffAreaTimers"} DiffAreaTimers__DO_EXTENSION(x: int) : int
{
  x + 2880
}

function {:inline true} {:fieldmap "Mem_T.DiffAreaVolumeGuid_FILTER_EXTENSION"} {:fieldname "DiffAreaVolumeGuid"} DiffAreaVolumeGuid_FILTER_EXTENSION(x: int) : int
{
  x + 3980
}

function {:inline true} {:fieldmap "Mem_T.DiffAreaVolumeGuid__VSP_BLOCK_START"} {:fieldname "DiffAreaVolumeGuid"} DiffAreaVolumeGuid__VSP_BLOCK_START(x: int) : int
{
  x + 116
}

function {:inline true} {:fieldmap "Mem_T.DiffAreaVolume_FILTER_EXTENSION"} {:fieldname "DiffAreaVolume"} DiffAreaVolume_FILTER_EXTENSION(x: int) : int
{
  x + 1280
}

function {:inline true} {:fieldmap "Mem_T.DriverExtension__DRIVER_OBJECT"} {:fieldname "DriverExtension"} DriverExtension__DRIVER_OBJECT(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.DriverFlags__VSP_BLOCK_START"} {:fieldname "DriverFlags"} DriverFlags__VSP_BLOCK_START(x: int) : int
{
  x + 176
}

function {:inline true} {:fieldmap "Mem_T.DriverObject__DO_EXTENSION"} {:fieldname "DriverObject"} DriverObject__DO_EXTENSION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DriverUnload__DRIVER_OBJECT"} {:fieldname "DriverUnload"} DriverUnload__DRIVER_OBJECT(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.DumpDataSize__IO_ERROR_LOG_PACKET"} {:fieldname "DumpDataSize"} DumpDataSize__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "ESpinLock"} ESpinLock__DO_EXTENSION(x: int) : int
{
  x + 2152
}

function {:inline true} {:fieldmap "Mem_T.EmergencyContextInUse__DO_EXTENSION"} {:fieldname "EmergencyContextInUse"} EmergencyContextInUse__DO_EXTENSION(x: int) : int
{
  x + 2136
}

function {:inline true} {:fieldmap "Mem_T.EmergencyContext__DO_EXTENSION"} {:fieldname "EmergencyContext"} EmergencyContext__DO_EXTENSION(x: int) : int
{
  x + 2132
}

function {:inline true} {:fieldmap "Mem_T.EmergencyCopyIrp_VOLUME_EXTENSION"} {:fieldname "EmergencyCopyIrp"} EmergencyCopyIrp_VOLUME_EXTENSION(x: int) : int
{
  x + 1000
}

function {:inline true} {:fieldmap "Mem_T.EmergencyTableEntryInUse__DO_EXTENSION"} {:fieldname "EmergencyTableEntryInUse"} EmergencyTableEntryInUse__DO_EXTENSION(x: int) : int
{
  x + 2404
}

function {:inline true} {:fieldmap "Mem_T.EmergencyTableEntry__DO_EXTENSION"} {:fieldname "EmergencyTableEntry"} EmergencyTableEntry__DO_EXTENSION(x: int) : int
{
  x + 2400
}

function {:inline true} {:fieldmap "Mem_T.EmergencyWriteContext__DO_EXTENSION"} {:fieldname "EmergencyWriteContext"} EmergencyWriteContext__DO_EXTENSION(x: int) : int
{
  x + 2268
}

function {:inline true} {:fieldmap "Mem_T._KEVENT"} {:fieldname "EndCommitProcessCompleted"} EndCommitProcessCompleted_FILTER_EXTENSION(x: int) : int
{
  x + 980
}

function {:inline true} {:fieldmap "Mem_T._KDPC"} {:fieldname "EndCommitTimerDpc"} EndCommitTimerDpc_FILTER_EXTENSION(x: int) : int
{
  x + 1460
}

function {:inline true} {:fieldmap "Mem_T.EntryContext__RTL_QUERY_REGISTRY_TABLE"} {:fieldname "EntryContext"} EntryContext__RTL_QUERY_REGISTRY_TABLE(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.EpicNumber_FILTER_EXTENSION"} {:fieldname "EpicNumber"} EpicNumber_FILTER_EXTENSION(x: int) : int
{
  x + 3932
}

function {:inline true} {:fieldmap "Mem_T.ErrorCode__IO_ERROR_LOG_PACKET"} {:fieldname "ErrorCode"} ErrorCode__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.ErrorLog__VSP_CONTEXT"} {:fieldname "ErrorLog"} ErrorLog__VSP_CONTEXT(x: int) : int
{
  x + 388
}

function {:inline true} {:fieldmap "Mem_T.Event__VSP_CONTEXT"} {:fieldname "Event"} Event__VSP_CONTEXT(x: int) : int
{
  x + 264
}

function {:inline true} {:fieldmap "Mem_T._KEVENT"} {:fieldname "Event"} Event_sdv_hash_70411571(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Extension__VSP_CONTEXT"} {:fieldname "Extension"} Extension__VSP_CONTEXT(x: int) : int
{
  x + 76
}

function {:inline true} {:fieldmap "Mem_T.Extension__VSP_DIFF_AREA_FILE"} {:fieldname "Extension"} Extension__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Extension_sdv_hash_514641693"} {:fieldname "Extension"} Extension_sdv_hash_514641693(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Extension_sdv_hash_966868263"} {:fieldname "Extension"} Extension_sdv_hash_966868263(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.ExternalWaiter_FILTER_EXTENSION"} {:fieldname "ExternalWaiter"} ExternalWaiter_FILTER_EXTENSION(x: int) : int
{
  x + 508
}

function {:inline true} {:fieldmap "Mem_T.FileHandle__VSP_DIFF_AREA_FILE"} {:fieldname "FileHandle"} FileHandle__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.FilterListEntryBeingUsed__VSP_DIFF_AREA_FILE"} {:fieldname "FilterListEntryBeingUsed"} FilterListEntryBeingUsed__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "FilterListEntry"} FilterListEntry__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "FilterList"} FilterList__DO_EXTENSION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Filter_VOLUME_EXTENSION"} {:fieldname "Filter"} Filter_VOLUME_EXTENSION(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Filter__VSP_CONTEXT"} {:fieldname "Filter"} Filter__VSP_CONTEXT(x: int) : int
{
  x + 84
}

function {:inline true} {:fieldmap "Mem_T.Filter__VSP_DIFF_AREA_FILE"} {:fieldname "Filter"} Filter__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.Filter_sdv_hash_1062388345"} {:fieldname "Filter"} Filter_sdv_hash_1062388345(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Filter_sdv_hash_118015372"} {:fieldname "Filter"} Filter_sdv_hash_118015372(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Filter_sdv_hash_838340289"} {:fieldname "Filter"} Filter_sdv_hash_838340289(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.FinalStatus__IO_ERROR_LOG_PACKET"} {:fieldname "FinalStatus"} FinalStatus__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.FinalStatus_sdv_hash_514641693"} {:fieldname "FinalStatus"} FinalStatus_sdv_hash_514641693(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.FirstControlBlockVolumeOffset_FILTER_EXTENSION"} {:fieldname "FirstControlBlockVolumeOffset"} FirstControlBlockVolumeOffset_FILTER_EXTENSION(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.FirstControlBlockVolumeOffset__VSP_BLOCK_START"} {:fieldname "FirstControlBlockVolumeOffset"} FirstControlBlockVolumeOffset__VSP_BLOCK_START(x: int) : int
{
  x + 64
}

function {:inline true} {:fieldmap "Mem_T.FirstWriteProcessed_FILTER_EXTENSION"} {:fieldname "FirstWriteProcessed"} FirstWriteProcessed_FILTER_EXTENSION(x: int) : int
{
  x + 3900
}

function {:inline true} {:fieldmap "Mem_T.Flags__DEVICE_OBJECT"} {:fieldname "Flags"} Flags__DEVICE_OBJECT(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Flags__IO_STACK_LOCATION"} {:fieldname "Flags"} Flags__IO_STACK_LOCATION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Flags__RTL_QUERY_REGISTRY_TABLE"} {:fieldname "Flags"} Flags__RTL_QUERY_REGISTRY_TABLE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Flink__LIST_ENTRY"} {:fieldname "Flink"} Flink__LIST_ENTRY(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.FlushAndHoldIrp_FILTER_EXTENSION"} {:fieldname "FlushAndHoldIrp"} FlushAndHoldIrp_FILTER_EXTENSION(x: int) : int
{
  x + 968
}

function {:inline true} {:fieldmap "Mem_T.FreeMisses__GENERAL_LOOKASIDE"} {:fieldname "FreeMisses"} FreeMisses__GENERAL_LOOKASIDE(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.Free__GENERAL_LOOKASIDE"} {:fieldname "Free"} Free__GENERAL_LOOKASIDE(x: int) : int
{
  x + 76
}

function {:inline true} {:fieldmap "Mem_T.Handle1_sdv_hash_838340289"} {:fieldname "Handle1"} Handle1_sdv_hash_838340289(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Handle2_sdv_hash_838340289"} {:fieldname "Handle2"} Handle2_sdv_hash_838340289(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.HasEndCommit_VOLUME_EXTENSION"} {:fieldname "HasEndCommit"} HasEndCommit_VOLUME_EXTENSION(x: int) : int
{
  x + 212
}

function {:inline true} {:fieldmap "Mem_T.HaveOriginalSnapshotGuid__VSP_LOOKUP_TABLE_ENTRY"} {:fieldname "HaveOriginalSnapshotGuid"} HaveOriginalSnapshotGuid__VSP_LOOKUP_TABLE_ENTRY(x: int) : int
{
  x + 160
}

function {:inline true} {:fieldmap "Mem_T.Header__KEVENT"} {:fieldname "Header"} Header__KEVENT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Header__VSP_BLOCK_CONTROL"} {:fieldname "Header"} Header__VSP_BLOCK_CONTROL(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.High1Time__KSYSTEM_TIME"} {:fieldname "High1Time"} High1Time__KSYSTEM_TIME(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.High2Time__KSYSTEM_TIME"} {:fieldname "High2Time"} High2Time__KSYSTEM_TIME(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.HighPart__LUID"} {:fieldname "HighPart"} HighPart__LUID(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.HoldIncomingWrites_FILTER_EXTENSION"} {:fieldname "HoldIncomingWrites"} HoldIncomingWrites_FILTER_EXTENSION(x: int) : int
{
  x + 496
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "HoldIrps"} HoldIrps__DO_EXTENSION(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "HoldQueue"} HoldQueue_FILTER_EXTENSION(x: int) : int
{
  x + 500
}

function {:inline true} {:fieldmap "Mem_T._KDPC"} {:fieldname "HoldTimerDpc"} HoldTimerDpc__DO_EXTENSION(x: int) : int
{
  x + 236
}

function {:inline true} {:fieldmap "Mem_T.HoldWritesCount__VSP_LOVELACE_DPC_CONTEXT"} {:fieldname "HoldWritesCount"} HoldWritesCount__VSP_LOVELACE_DPC_CONTEXT(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T._KDPC"} {:fieldname "HoldWritesTimerDpc"} HoldWritesTimerDpc_FILTER_EXTENSION(x: int) : int
{
  x + 924
}

function {:inline true} {:fieldmap "Mem_T.IdType_unnamed_tag_32"} {:fieldname "IdType"} IdType_unnamed_tag_32(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Id__EVENT_DESCRIPTOR"} {:fieldname "Id"} Id__EVENT_DESCRIPTOR(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.IgnorableProduct_VOLUME_EXTENSION"} {:fieldname "IgnorableProduct"} IgnorableProduct_VOLUME_EXTENSION(x: int) : int
{
  x + 984
}

function {:inline true} {:fieldmap "Mem_T.IgnoreCopyDataReference_VOLUME_EXTENSION"} {:fieldname "IgnoreCopyDataReference"} IgnoreCopyDataReference_VOLUME_EXTENSION(x: int) : int
{
  x + 248
}

function {:inline true} {:fieldmap "Mem_T.InPath_unnamed_tag_34"} {:fieldname "InPath"} InPath_unnamed_tag_34(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.InSnapshotProtectionMode_FILTER_EXTENSION"} {:fieldname "InSnapshotProtectionMode"} InSnapshotProtectionMode_FILTER_EXTENSION(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.InUse__VSP_LOVELACE_DPC_CONTEXT"} {:fieldname "InUse"} InUse__VSP_LOVELACE_DPC_CONTEXT(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.Information__IO_STATUS_BLOCK"} {:fieldname "Information"} Information__IO_STATUS_BLOCK(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.IoStatus__IRP"} {:fieldname "IoStatus"} IoStatus__IRP(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.IoTimes__VOLSNAP_PERFORMANCE_COUNTERS"} {:fieldname "IoTimes"} IoTimes__VOLSNAP_PERFORMANCE_COUNTERS(x: int) : int
{
  x + 228
}

function {:inline true} {:fieldmap "Mem_T.IoWindow_FILTER_EXTENSION"} {:fieldname "IoWindow"} IoWindow_FILTER_EXTENSION(x: int) : int
{
  x + 4900
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "IrpList"} IrpList__VSP_LOVELACE_DPC_CONTEXT(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.IrpWaitingListNeedsChecking__DO_EXTENSION"} {:fieldname "IrpWaitingListNeedsChecking"} IrpWaitingListNeedsChecking__DO_EXTENSION(x: int) : int
{
  x + 2148
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "IrpWaitingList"} IrpWaitingList__DO_EXTENSION(x: int) : int
{
  x + 2140
}

function {:inline true} {:fieldmap "Mem_T.Irp_sdv_hash_966868263"} {:fieldname "Irp"} Irp_sdv_hash_966868263(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.IsDead_VOLUME_EXTENSION"} {:fieldname "IsDead"} IsDead_VOLUME_EXTENSION(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.IsDeleted_VOLUME_EXTENSION"} {:fieldname "IsDeleted"} IsDeleted_VOLUME_EXTENSION(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.IsInstalled_VOLUME_EXTENSION"} {:fieldname "IsInstalled"} IsInstalled_VOLUME_EXTENSION(x: int) : int
{
  x + 216
}

function {:inline true} {:fieldmap "Mem_T.IsOnline_FILTER_EXTENSION"} {:fieldname "IsOnline"} IsOnline_FILTER_EXTENSION(x: int) : int
{
  x + 3864
}

function {:inline true} {:fieldmap "Mem_T.IsPersistent_VOLUME_EXTENSION"} {:fieldname "IsPersistent"} IsPersistent_VOLUME_EXTENSION(x: int) : int
{
  x + 220
}

function {:inline true} {:fieldmap "Mem_T.IsPreExposure_VOLUME_EXTENSION"} {:fieldname "IsPreExposure"} IsPreExposure_VOLUME_EXTENSION(x: int) : int
{
  x + 244
}

function {:inline true} {:fieldmap "Mem_T.IsRemoved_FILTER_EXTENSION"} {:fieldname "IsRemoved"} IsRemoved_FILTER_EXTENSION(x: int) : int
{
  x + 3868
}

function {:inline true} {:fieldmap "Mem_T.IsSetup__DO_EXTENSION"} {:fieldname "IsSetup"} IsSetup__DO_EXTENSION(x: int) : int
{
  x + 2792
}

function {:inline true} {:fieldmap "Mem_T.IsSqmInitialized__DO_EXTENSION"} {:fieldname "IsSqmInitialized"} IsSqmInitialized__DO_EXTENSION(x: int) : int
{
  x + 2932
}

function {:inline true} {:fieldmap "Mem_T.IsTempMaximumVolumeSpace_FILTER_EXTENSION"} {:fieldname "IsTempMaximumVolumeSpace"} IsTempMaximumVolumeSpace_FILTER_EXTENSION(x: int) : int
{
  x + 1296
}

function {:inline true} {:fieldmap "Mem_T.IsVisible_VOLUME_EXTENSION"} {:fieldname "IsVisible"} IsVisible_VOLUME_EXTENSION(x: int) : int
{
  x + 236
}

function {:inline true} {:fieldmap "Mem_T.IsVolumeOfflineForSnapshotProtection_FILTER_EXTENSION"} {:fieldname "IsVolumeOfflineForSnapshotProtection"} IsVolumeOfflineForSnapshotProtection_FILTER_EXTENSION(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.Key_unnamed_tag_10"} {:fieldname "Key"} Key_unnamed_tag_10(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Keyword__EVENT_DESCRIPTOR"} {:fieldname "Keyword"} Keyword__EVENT_DESCRIPTOR(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.L__NPAGED_LOOKASIDE_LIST"} {:fieldname "L"} L__NPAGED_LOOKASIDE_LIST(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.LastBucketBytesSkipped_FILTER_EXTENSION"} {:fieldname "LastBucketBytesSkipped"} LastBucketBytesSkipped_FILTER_EXTENSION(x: int) : int
{
  x + 4880
}

function {:inline true} {:fieldmap "Mem_T.LastBucketCowBytesRead_FILTER_EXTENSION"} {:fieldname "LastBucketCowBytesRead"} LastBucketCowBytesRead_FILTER_EXTENSION(x: int) : int
{
  x + 4876
}

function {:inline true} {:fieldmap "Mem_T.LastBucketIoTimes_FILTER_EXTENSION"} {:fieldname "LastBucketIoTimes"} LastBucketIoTimes_FILTER_EXTENSION(x: int) : int
{
  x + 4776
}

function {:inline true} {:fieldmap "Mem_T.LastBucketTickCount_FILTER_EXTENSION"} {:fieldname "LastBucketTickCount"} LastBucketTickCount_FILTER_EXTENSION(x: int) : int
{
  x + 4240
}

function {:inline true} {:fieldmap "Mem_T._LARGE_INTEGER"} {:fieldname "LastCheckTickCount"} LastCheckTickCount__DO_EXTENSION(x: int) : int
{
  x + 2904
}

function {:inline true} {:fieldmap "Mem_T.LastEndTickCount_FILTER_EXTENSION"} {:fieldname "LastEndTickCount"} LastEndTickCount_FILTER_EXTENSION(x: int) : int
{
  x + 4244
}

function {:inline true} {:fieldmap "Mem_T.LastSuccessfullyComparedRead_VOLUME_EXTENSION"} {:fieldname "LastSuccessfullyComparedRead"} LastSuccessfullyComparedRead_VOLUME_EXTENSION(x: int) : int
{
  x + 1132
}

function {:inline true} {:fieldmap "Mem_T.Length__GET_LENGTH_INFORMATION"} {:fieldname "Length"} Length__GET_LENGTH_INFORMATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Length_unnamed_tag_16"} {:fieldname "Length"} Length_unnamed_tag_16(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Level__EVENT_DESCRIPTOR"} {:fieldname "Level"} Level__EVENT_DESCRIPTOR(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "LinkedTableEntries"} LinkedTableEntries__TEMP_TRANSLATION_TABLE_ENTRY(x: int) : int
{
  x + 80
}

function {:inline true} {:fieldmap "Mem_T.ListEntryInUse_sdv_hash_118015372"} {:fieldname "ListEntryInUse"} ListEntryInUse_sdv_hash_118015372(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "ListEntry"} ListEntry_FILTER_EXTENSION(x: int) : int
{
  x + 1108
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "ListEntry"} ListEntry_VOLUME_EXTENSION(x: int) : int
{
  x + 408
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "ListEntry"} ListEntry__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "ListEntry"} ListEntry_sdv_hash_118015372(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "ListEntry"} ListEntry_unnamed_tag_6(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T._SLIST_HEADER"} {:fieldname "ListHead"} ListHead__GENERAL_LOOKASIDE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "List"} List__WORK_QUEUE_ITEM(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Locked_sdv_hash_1016204693"} {:fieldname "Locked"} Locked_sdv_hash_1016204693(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.LovelaceContext_FILTER_EXTENSION"} {:fieldname "LovelaceContext"} LovelaceContext_FILTER_EXTENSION(x: int) : int
{
  x + 4976
}

function {:inline true} {:fieldmap "Mem_T.LowMemoryCondition__DO_EXTENSION"} {:fieldname "LowMemoryCondition"} LowMemoryCondition__DO_EXTENSION(x: int) : int
{
  x + 2892
}

function {:inline true} {:fieldmap "Mem_T.LowPart__KSYSTEM_TIME"} {:fieldname "LowPart"} LowPart__KSYSTEM_TIME(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.LowPart__LUID"} {:fieldname "LowPart"} LowPart__LUID(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "LowPriorityQueue"} LowPriorityQueue__DO_EXTENSION(x: int) : int
{
  x + 1820
}

function {:inline true} {:fieldmap "Mem_T.MajorFunction__DRIVER_OBJECT"} {:fieldname "MajorFunction"} MajorFunction__DRIVER_OBJECT(x: int) : int
{
  x + 64
}

function {:inline true} {:fieldmap "Mem_T.MajorFunction__IO_STACK_LOCATION"} {:fieldname "MajorFunction"} MajorFunction__IO_STACK_LOCATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.MaximumDiffAreaSpace__VSP_BLOCK_START"} {:fieldname "MaximumDiffAreaSpace"} MaximumDiffAreaSpace__VSP_BLOCK_START(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T.MaximumLength__UNICODE_STRING"} {:fieldname "MaximumLength"} MaximumLength__UNICODE_STRING(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.MaximumVolumeSpace_FILTER_EXTENSION"} {:fieldname "MaximumVolumeSpace"} MaximumVolumeSpace_FILTER_EXTENSION(x: int) : int
{
  x + 1292
}

function {:inline true} {:fieldmap "Mem_T.MdlAddress__IRP"} {:fieldname "MdlAddress"} MdlAddress__IRP(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "MediumPriorityQueue"} MediumPriorityQueue__DO_EXTENSION(x: int) : int
{
  x + 1852
}

function {:inline true} {:fieldmap "Mem_T.MediumPriorityWorkItem__DO_EXTENSION"} {:fieldname "MediumPriorityWorkItem"} MediumPriorityWorkItem__DO_EXTENSION(x: int) : int
{
  x + 1864
}

function {:inline true} {:fieldmap "Mem_T.MediumWorkerItemInUse__DO_EXTENSION"} {:fieldname "MediumWorkerItemInUse"} MediumWorkerItemInUse__DO_EXTENSION(x: int) : int
{
  x + 1860
}

function {:inline true} {:fieldmap "Mem_T.MetaDataUpdateIrp__VSP_DIFF_AREA_FILE"} {:fieldname "MetaDataUpdateIrp"} MetaDataUpdateIrp__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.MilliSecondsPerTick_VSP_IO_WINDOW"} {:fieldname "MilliSecondsPerTick"} MilliSecondsPerTick_VSP_IO_WINDOW(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.MinorFunction__IO_STACK_LOCATION"} {:fieldname "MinorFunction"} MinorFunction__IO_STACK_LOCATION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"} {:fieldname "MountedDeviceInterfaceName"} MountedDeviceInterfaceName_VOLUME_EXTENSION(x: int) : int
{
  x + 1032
}

function {:inline true} {:fieldmap "Mem_T.Name__RTL_QUERY_REGISTRY_TABLE"} {:fieldname "Name"} Name__RTL_QUERY_REGISTRY_TABLE(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.NestingDepth_FILTER_EXTENSION"} {:fieldname "NestingDepth"} NestingDepth_FILTER_EXTENSION(x: int) : int
{
  x + 4972
}

function {:inline true} {:fieldmap "Mem_T.NextAvailable__VSP_DIFF_AREA_FILE"} {:fieldname "NextAvailable"} NextAvailable__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.NextDiffAreaFileMap_VOLUME_EXTENSION"} {:fieldname "NextDiffAreaFileMap"} NextDiffAreaFileMap_VOLUME_EXTENSION(x: int) : int
{
  x + 920
}

function {:inline true} {:fieldmap "Mem_T.NextVolumeOffset__VSP_BLOCK_HEADER"} {:fieldname "NextVolumeOffset"} NextVolumeOffset__VSP_BLOCK_HEADER(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.NextWriteAreaFileMapMdl_VOLUME_EXTENSION"} {:fieldname "NextWriteAreaFileMapMdl"} NextWriteAreaFileMapMdl_VOLUME_EXTENSION(x: int) : int
{
  x + 964
}

function {:inline true} {:fieldmap "Mem_T.NextWriteAreaFileMap_VOLUME_EXTENSION"} {:fieldname "NextWriteAreaFileMap"} NextWriteAreaFileMap_VOLUME_EXTENSION(x: int) : int
{
  x + 960
}

function {:inline true} {:fieldmap "Mem_T.NonPagedResourceInUse_FILTER_EXTENSION"} {:fieldname "NonPagedResourceInUse"} NonPagedResourceInUse_FILTER_EXTENSION(x: int) : int
{
  x + 3832
}

function {:inline true} {:fieldmap "Mem_T.NonPagedResourceKillRelease_FILTER_EXTENSION"} {:fieldname "NonPagedResourceKillRelease"} NonPagedResourceKillRelease_FILTER_EXTENSION(x: int) : int
{
  x + 3836
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "NonPagedResourceList"} NonPagedResourceList_FILTER_EXTENSION(x: int) : int
{
  x + 3824
}

function {:inline true} {:fieldmap "Mem_T.NotInFilterList_FILTER_EXTENSION"} {:fieldname "NotInFilterList"} NotInFilterList_FILTER_EXTENSION(x: int) : int
{
  x + 1116
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "NotifyFlushIrps"} NotifyFlushIrps_FILTER_EXTENSION(x: int) : int
{
  x + 972
}

function {:inline true} {:fieldmap "Mem_T.NumberOfBitMaps__VSP_BITMAP"} {:fieldname "NumberOfBitMaps"} NumberOfBitMaps__VSP_BITMAP(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.NumberOfBytes__VOLSNAP_PERF_POINT"} {:fieldname "NumberOfBytes"} NumberOfBytes__VOLSNAP_PERF_POINT(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.NumberOfRequests__VOLSNAP_PERF_POINT"} {:fieldname "NumberOfRequests"} NumberOfRequests__VOLSNAP_PERF_POINT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.NumberOfStrings__IO_ERROR_LOG_PACKET"} {:fieldname "NumberOfStrings"} NumberOfStrings__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.NumberOfWriteStreamsOut__VOLSNAP_PERFORMANCE_COUNTERS"} {:fieldname "NumberOfWriteStreamsOut"} NumberOfWriteStreamsOut__VOLSNAP_PERFORMANCE_COUNTERS(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.ObjectName__OBJECT_ATTRIBUTES"} {:fieldname "ObjectName"} ObjectName__OBJECT_ATTRIBUTES(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Objects__DEVICE_RELATIONS"} {:fieldname "Objects"} Objects__DEVICE_RELATIONS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "OldHeaps"} OldHeaps_VOLUME_EXTENSION(x: int) : int
{
  x + 932
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "OldWriteHeaps"} OldWriteHeaps_VOLUME_EXTENSION(x: int) : int
{
  x + 968
}

function {:inline true} {:fieldmap "Mem_T.OnDiskNotCommitted_VOLUME_EXTENSION"} {:fieldname "OnDiskNotCommitted"} OnDiskNotCommitted_VOLUME_EXTENSION(x: int) : int
{
  x + 232
}

function {:inline true} {:fieldmap "Mem_T.Opcode__EVENT_DESCRIPTOR"} {:fieldname "Opcode"} Opcode__EVENT_DESCRIPTOR(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.OriginalFileObject_unnamed_tag_6"} {:fieldname "OriginalFileObject"} OriginalFileObject_unnamed_tag_6(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T._GUID"} {:fieldname "OriginalSnapshotGuid"} OriginalSnapshotGuid__VSP_LOOKUP_TABLE_ENTRY(x: int) : int
{
  x + 164
}

function {:inline true} {:fieldmap "Mem_T.Overlay_unnamed_tag_5"} {:fieldname "Overlay"} Overlay_unnamed_tag_5(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.OwningThread__DO_EXTENSION"} {:fieldname "OwningThread"} OwningThread__DO_EXTENSION(x: int) : int
{
  x + 404
}

function {:inline true} {:fieldmap "Mem_T.PagedResourceInUse_FILTER_EXTENSION"} {:fieldname "PagedResourceInUse"} PagedResourceInUse_FILTER_EXTENSION(x: int) : int
{
  x + 3848
}

function {:inline true} {:fieldmap "Mem_T.PagedResourceKillRelease_FILTER_EXTENSION"} {:fieldname "PagedResourceKillRelease"} PagedResourceKillRelease_FILTER_EXTENSION(x: int) : int
{
  x + 3852
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "PagedResourceList"} PagedResourceList_FILTER_EXTENSION(x: int) : int
{
  x + 3840
}

function {:inline true} {:fieldmap "Mem_T.PagedResourceRunningOnWorker_FILTER_EXTENSION"} {:fieldname "PagedResourceRunningOnWorker"} PagedResourceRunningOnWorker_FILTER_EXTENSION(x: int) : int
{
  x + 3856
}

function {:inline true} {:fieldmap "Mem_T.Parameter__WORK_QUEUE_ITEM"} {:fieldname "Parameter"} Parameter__WORK_QUEUE_ITEM(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Parameters__IO_STACK_LOCATION"} {:fieldname "Parameters"} Parameters__IO_STACK_LOCATION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T._KEVENT"} {:fieldname "PastBootReinit"} PastBootReinit__DO_EXTENSION(x: int) : int
{
  x + 2456
}

function {:inline true} {:fieldmap "Mem_T.PastReinit__DO_EXTENSION"} {:fieldname "PastReinit"} PastReinit__DO_EXTENSION(x: int) : int
{
  x + 2452
}

function {:inline true} {:fieldmap "Mem_T.Pdo_FILTER_EXTENSION"} {:fieldname "Pdo"} Pdo_FILTER_EXTENSION(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.PendingReturned__IRP"} {:fieldname "PendingReturned"} PendingReturned__IRP(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.PerfBuckets__VOLSNAP_PERFORMANCE_COUNTERS"} {:fieldname "PerfBuckets"} PerfBuckets__VOLSNAP_PERFORMANCE_COUNTERS(x: int) : int
{
  x + 328
}

function {:inline true} {:fieldmap "Mem_T.PerfPoints__VOLSNAP_PERFORMANCE_COUNTERS"} {:fieldname "PerfPoints"} PerfPoints__VOLSNAP_PERFORMANCE_COUNTERS(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.PerformanceCountersEnabled_FILTER_EXTENSION"} {:fieldname "PerformanceCountersEnabled"} PerformanceCountersEnabled_FILTER_EXTENSION(x: int) : int
{
  x + 4228
}

function {:inline true} {:fieldmap "Mem_T.PerformanceCounters_FILTER_EXTENSION"} {:fieldname "PerformanceCounters"} PerformanceCounters_FILTER_EXTENSION(x: int) : int
{
  x + 4248
}

function {:inline true} {:fieldmap "Mem_T.PnpWaitTimerContext_FILTER_EXTENSION"} {:fieldname "PnpWaitTimerContext"} PnpWaitTimerContext_FILTER_EXTENSION(x: int) : int
{
  x + 3916
}

function {:inline true} {:fieldmap "Mem_T.sdv_hash_118015372"} {:fieldname "PnpWaitTimer"} PnpWaitTimer__VSP_CONTEXT(x: int) : int
{
  x + 488
}

function {:inline true} {:fieldmap "Mem_T.Power_unnamed_tag_8"} {:fieldname "Power"} Power_unnamed_tag_8(x: int) : int
{
  x + 380
}

function {:inline true} {:fieldmap "Mem_T.PreCopyAmountForFreeSpace_FILTER_EXTENSION"} {:fieldname "PreCopyAmountForFreeSpace"} PreCopyAmountForFreeSpace_FILTER_EXTENSION(x: int) : int
{
  x + 4216
}

function {:inline true} {:fieldmap "Mem_T.PreCopyAmountForFreeSpace__VSP_BLOCK_START"} {:fieldname "PreCopyAmountForFreeSpace"} PreCopyAmountForFreeSpace__VSP_BLOCK_START(x: int) : int
{
  x + 164
}

function {:inline true} {:fieldmap "Mem_T.PreCopyAmountForHotBlocks_FILTER_EXTENSION"} {:fieldname "PreCopyAmountForHotBlocks"} PreCopyAmountForHotBlocks_FILTER_EXTENSION(x: int) : int
{
  x + 4220
}

function {:inline true} {:fieldmap "Mem_T.PreCopyAmountForHotBlocks__VSP_BLOCK_START"} {:fieldname "PreCopyAmountForHotBlocks"} PreCopyAmountForHotBlocks__VSP_BLOCK_START(x: int) : int
{
  x + 168
}

function {:inline true} {:fieldmap "Mem_T.PreCopyOnWriteBitmap_VOLUME_EXTENSION"} {:fieldname "PreCopyOnWriteBitmap"} PreCopyOnWriteBitmap_VOLUME_EXTENSION(x: int) : int
{
  x + 980
}

function {:inline true} {:fieldmap "Mem_T._KEVENT"} {:fieldname "PreExposureEvent"} PreExposureEvent_VOLUME_EXTENSION(x: int) : int
{
  x + 260
}

function {:inline true} {:fieldmap "Mem_T.PreparedSnapshot_FILTER_EXTENSION"} {:fieldname "PreparedSnapshot"} PreparedSnapshot_FILTER_EXTENSION(x: int) : int
{
  x + 1128
}

function {:inline true} {:fieldmap "Mem_T.QuadPart__LARGE_INTEGER"} {:fieldname "QuadPart"} QuadPart__LARGE_INTEGER(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.QueryDeviceRelations_unnamed_tag_8"} {:fieldname "QueryDeviceRelations"} QueryDeviceRelations_unnamed_tag_8(x: int) : int
{
  x + 288
}

function {:inline true} {:fieldmap "Mem_T.QueryId_unnamed_tag_8"} {:fieldname "QueryId"} QueryId_unnamed_tag_8(x: int) : int
{
  x + 340
}

function {:inline true} {:fieldmap "Mem_T.RawDeviceOK__DEVICE_CAPABILITIES"} {:fieldname "RawDeviceOK"} RawDeviceOK__DEVICE_CAPABILITIES(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.Read_unnamed_tag_8"} {:fieldname "Read"} Read_unnamed_tag_8(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.ReasonForBeingOfflineStatus_FILTER_EXTENSION"} {:fieldname "ReasonForBeingOfflineStatus"} ReasonForBeingOfflineStatus_FILTER_EXTENSION(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.ReasonForBeingOffline_FILTER_EXTENSION"} {:fieldname "ReasonForBeingOffline"} ReasonForBeingOffline_FILTER_EXTENSION(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T._UNICODE_STRING"} {:fieldname "RegistryPath"} RegistryPath__DO_EXTENSION(x: int) : int
{
  x + 2428
}

function {:inline true} {:fieldmap "Mem_T.RetryCount__IO_ERROR_LOG_PACKET"} {:fieldname "RetryCount"} RetryCount__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.RevertVolume_FILTER_EXTENSION"} {:fieldname "RevertVolume"} RevertVolume_FILTER_EXTENSION(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.RootDirectory__OBJECT_ATTRIBUTES"} {:fieldname "RootDirectory"} RootDirectory__OBJECT_ATTRIBUTES(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Root_DEVICE_EXTENSION"} {:fieldname "Root"} Root_DEVICE_EXTENSION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.RundownRef_FILTER_EXTENSION"} {:fieldname "RundownRef"} RundownRef_FILTER_EXTENSION(x: int) : int
{
  x + 492
}

function {:inline true} {:fieldmap "Mem_T.SecurityDescriptor__OBJECT_ATTRIBUTES"} {:fieldname "SecurityDescriptor"} SecurityDescriptor__OBJECT_ATTRIBUTES(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.SecurityQualityOfService__OBJECT_ATTRIBUTES"} {:fieldname "SecurityQualityOfService"} SecurityQualityOfService__OBJECT_ATTRIBUTES(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.SequenceNumber__IO_ERROR_LOG_PACKET"} {:fieldname "SequenceNumber"} SequenceNumber__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.SignalState__DISPATCHER_HEADER"} {:fieldname "SignalState"} SignalState__DISPATCHER_HEADER(x: int) : int
{
  x + 112
}

function {:inline true} {:fieldmap "Mem_T.Signalling__DISPATCHER_HEADER"} {:fieldname "Signalling"} Signalling__DISPATCHER_HEADER(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.Signature__VSP_BLOCK_HEADER"} {:fieldname "Signature"} Signature__VSP_BLOCK_HEADER(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.SilentInstall__DEVICE_CAPABILITIES"} {:fieldname "SilentInstall"} SilentInstall__DEVICE_CAPABILITIES(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.Size__DISPATCHER_HEADER"} {:fieldname "Size"} Size__DISPATCHER_HEADER(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.SnapshotDiscoveryPending_FILTER_EXTENSION"} {:fieldname "SnapshotDiscoveryPending"} SnapshotDiscoveryPending_FILTER_EXTENSION(x: int) : int
{
  x + 3860
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "SnapshotFilterListEntry"} SnapshotFilterListEntry__VSP_LOOKUP_TABLE_ENTRY(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.SnapshotFilter__VSP_LOOKUP_TABLE_ENTRY"} {:fieldname "SnapshotFilter"} SnapshotFilter__VSP_LOOKUP_TABLE_ENTRY(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T._GUID"} {:fieldname "SnapshotGuid"} SnapshotGuid_VOLUME_EXTENSION(x: int) : int
{
  x + 428
}

function {:inline true} {:fieldmap "Mem_T._GUID"} {:fieldname "SnapshotGuid"} SnapshotGuid__VSP_CONTROL_ITEM_SNAPSHOT(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.SnapshotGuid__VSP_LOOKUP_TABLE_ENTRY"} {:fieldname "SnapshotGuid"} SnapshotGuid__VSP_LOOKUP_TABLE_ENTRY(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "SnapshotLookupTableEntries"} SnapshotLookupTableEntries_FILTER_EXTENSION(x: int) : int
{
  x + 352
}

function {:inline true} {:fieldmap "Mem_T.SnapshotOnDiskIrp_FILTER_EXTENSION"} {:fieldname "SnapshotOnDiskIrp"} SnapshotOnDiskIrp_FILTER_EXTENSION(x: int) : int
{
  x + 348
}

function {:inline true} {:fieldmap "Mem_T.SpecificIoStatus_sdv_hash_514641693"} {:fieldname "SpecificIoStatus"} SpecificIoStatus_sdv_hash_514641693(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "SpinLock"} SpinLock_DEVICE_EXTENSION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "SpinLock"} SpinLock_VSP_IO_WINDOW(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T.SpinLock__DO_EXTENSION"} {:fieldname "SpinLock"} SpinLock__DO_EXTENSION(x: int) : int
{
  x + 1760
}

function {:inline true} {:fieldmap "Mem_T.StackSize__DEVICE_OBJECT"} {:fieldname "StackSize"} StackSize__DEVICE_OBJECT(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.StackSize__DO_EXTENSION"} {:fieldname "StackSize"} StackSize__DO_EXTENSION(x: int) : int
{
  x + 2420
}

function {:inline true} {:fieldmap "Mem_T.StartVa__MDL"} {:fieldname "StartVa"} StartVa__MDL(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Status__IO_STATUS_BLOCK"} {:fieldname "Status"} Status__IO_STATUS_BLOCK(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.StringOffset__IO_ERROR_LOG_PACKET"} {:fieldname "StringOffset"} StringOffset__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.SurpriseRemovalOK__DEVICE_CAPABILITIES"} {:fieldname "SurpriseRemovalOK"} SurpriseRemovalOK__DEVICE_CAPABILITIES(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.TableUpdateIrp__VSP_DIFF_AREA_FILE"} {:fieldname "TableUpdateIrp"} TableUpdateIrp__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.TablesAreInitialized_VOLUME_EXTENSION"} {:fieldname "TablesAreInitialized"} TablesAreInitialized_VOLUME_EXTENSION(x: int) : int
{
  x + 488
}

function {:inline true} {:fieldmap "Mem_T.Tail__IRP"} {:fieldname "Tail"} Tail__IRP(x: int) : int
{
  x + 128
}

function {:inline true} {:fieldmap "Mem_T.TargetObject_FILTER_EXTENSION"} {:fieldname "TargetObject"} TargetObject_FILTER_EXTENSION(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Task__EVENT_DESCRIPTOR"} {:fieldname "Task"} Task__EVENT_DESCRIPTOR(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T._NPAGED_LOOKASIDE_LIST"} {:fieldname "TempTableEntryLookasideList"} TempTableEntryLookasideList__DO_EXTENSION(x: int) : int
{
  x + 2288
}

function {:inline true} {:fieldmap "Mem_T.ThisFileOffset__VSP_BLOCK_HEADER"} {:fieldname "ThisFileOffset"} ThisFileOffset__VSP_BLOCK_HEADER(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.ThisVolumeGuid_FILTER_EXTENSION"} {:fieldname "ThisVolumeGuid"} ThisVolumeGuid_FILTER_EXTENSION(x: int) : int
{
  x + 3936
}

function {:inline true} {:fieldmap "Mem_T.ThisVolumeGuid__VSP_BLOCK_START"} {:fieldname "ThisVolumeGuid"} ThisVolumeGuid__VSP_BLOCK_START(x: int) : int
{
  x + 72
}

function {:inline true} {:fieldmap "Mem_T.ThisVolumeOffset__VSP_BLOCK_HEADER"} {:fieldname "ThisVolumeOffset"} ThisVolumeOffset__VSP_BLOCK_HEADER(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.Thread_unnamed_tag_6"} {:fieldname "Thread"} Thread_unnamed_tag_6(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.ThreadsRefCount__DO_EXTENSION"} {:fieldname "ThreadsRefCount"} ThreadsRefCount__DO_EXTENSION(x: int) : int
{
  x + 1884
}

function {:inline true} {:fieldmap "Mem_T.TickCountsBetweenChecks__DO_EXTENSION"} {:fieldname "TickCountsBetweenChecks"} TickCountsBetweenChecks__DO_EXTENSION(x: int) : int
{
  x + 2900
}

function {:inline true} {:fieldmap "Mem_T.TicksPer256MilliSeconds_VSP_IO_WINDOW"} {:fieldname "TicksPer256MilliSeconds"} TicksPer256MilliSeconds_VSP_IO_WINDOW(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.TicksPerMilliSecond_VSP_IO_WINDOW"} {:fieldname "TicksPerMilliSecond"} TicksPerMilliSecond_VSP_IO_WINDOW(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.TotalAllocates__GENERAL_LOOKASIDE"} {:fieldname "TotalAllocates"} TotalAllocates__GENERAL_LOOKASIDE(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.TotalFrees__GENERAL_LOOKASIDE"} {:fieldname "TotalFrees"} TotalFrees__GENERAL_LOOKASIDE(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_26"} {:fieldname "Type"} Type_unnamed_tag_26(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_34"} {:fieldname "Type"} Type_unnamed_tag_34(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_37"} {:fieldname "Type"} Type_unnamed_tag_37(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.UniqueErrorValue__IO_ERROR_LOG_PACKET"} {:fieldname "UniqueErrorValue"} UniqueErrorValue__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.UniqueErrorValue_sdv_hash_514641693"} {:fieldname "UniqueErrorValue"} UniqueErrorValue_sdv_hash_514641693(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.UniqueID__DEVICE_CAPABILITIES"} {:fieldname "UniqueID"} UniqueID__DEVICE_CAPABILITIES(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.UniqueIdForBeingOffline_FILTER_EXTENSION"} {:fieldname "UniqueIdForBeingOffline"} UniqueIdForBeingOffline_FILTER_EXTENSION(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "UnusedAllocationList"} UnusedAllocationList__VSP_DIFF_AREA_FILE(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.UsageNotification_unnamed_tag_8"} {:fieldname "UsageNotification"} UsageNotification_unnamed_tag_8(x: int) : int
{
  x + 352
}

function {:inline true} {:fieldmap "Mem_T.UsedForPaging_FILTER_EXTENSION"} {:fieldname "UsedForPaging"} UsedForPaging_FILTER_EXTENSION(x: int) : int
{
  x + 3872
}

function {:inline true} {:fieldmap "Mem_T.UsedVolumeSpace_FILTER_EXTENSION"} {:fieldname "UsedVolumeSpace"} UsedVolumeSpace_FILTER_EXTENSION(x: int) : int
{
  x + 1284
}

function {:inline true} {:fieldmap "Mem_T.Value__SID_IDENTIFIER_AUTHORITY"} {:fieldname "Value"} Value__SID_IDENTIFIER_AUTHORITY(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Version__EVENT_DESCRIPTOR"} {:fieldname "Version"} Version__EVENT_DESCRIPTOR(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Version__VSP_BLOCK_HEADER"} {:fieldname "Version"} Version__VSP_BLOCK_HEADER(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.VolumeBlockBitmap_VOLUME_EXTENSION"} {:fieldname "VolumeBlockBitmap"} VolumeBlockBitmap_VOLUME_EXTENSION(x: int) : int
{
  x + 976
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "VolumeList"} VolumeList_FILTER_EXTENSION(x: int) : int
{
  x + 1120
}

function {:inline true} {:fieldmap "Mem_T.VolumeNumber_VOLUME_EXTENSION"} {:fieldname "VolumeNumber"} VolumeNumber_VOLUME_EXTENSION(x: int) : int
{
  x + 416
}

function {:inline true} {:fieldmap "Mem_T.WaitForWorkerThreadsToExitWorkItemInUse__DO_EXTENSION"} {:fieldname "WaitForWorkerThreadsToExitWorkItemInUse"} WaitForWorkerThreadsToExitWorkItemInUse__DO_EXTENSION(x: int) : int
{
  x + 1800
}

function {:inline true} {:fieldmap "Mem_T.WaitForWorkerThreadsToExitWorkItem__DO_EXTENSION"} {:fieldname "WaitForWorkerThreadsToExitWorkItem"} WaitForWorkerThreadsToExitWorkItem__DO_EXTENSION(x: int) : int
{
  x + 1804
}

function {:inline true} {:fieldmap "Mem_T.WorkItemWaitingListNeedsChecking__DO_EXTENSION"} {:fieldname "WorkItemWaitingListNeedsChecking"} WorkItemWaitingListNeedsChecking__DO_EXTENSION(x: int) : int
{
  x + 2416
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "WorkItemWaitingList"} WorkItemWaitingList__DO_EXTENSION(x: int) : int
{
  x + 2408
}

function {:inline true} {:fieldmap "Mem_T._WORK_QUEUE_ITEM"} {:fieldname "WorkItem"} WorkItem__VSP_CONTEXT(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.WorkItem__VSP_LOVELACE_DPC_CONTEXT"} {:fieldname "WorkItem"} WorkItem__VSP_LOVELACE_DPC_CONTEXT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.WorkerQueue__DO_EXTENSION"} {:fieldname "WorkerQueue"} WorkerQueue__DO_EXTENSION(x: int) : int
{
  x + 536
}

function {:inline true} {:fieldmap "Mem_T.WorkerRoutine__WORK_QUEUE_ITEM"} {:fieldname "WorkerRoutine"} WorkerRoutine__WORK_QUEUE_ITEM(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.WorkerSemaphore__DO_EXTENSION"} {:fieldname "WorkerSemaphore"} WorkerSemaphore__DO_EXTENSION(x: int) : int
{
  x + 608
}

function {:inline true} {:fieldmap "Mem_T.WriteAreaFileMapMdl_VOLUME_EXTENSION"} {:fieldname "WriteAreaFileMapMdl"} WriteAreaFileMapMdl_VOLUME_EXTENSION(x: int) : int
{
  x + 952
}

function {:inline true} {:fieldmap "Mem_T.WriteAreaFileMap_VOLUME_EXTENSION"} {:fieldname "WriteAreaFileMap"} WriteAreaFileMap_VOLUME_EXTENSION(x: int) : int
{
  x + 948
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "WriteContextIrpWaitingList"} WriteContextIrpWaitingList__DO_EXTENSION(x: int) : int
{
  x + 2276
}

function {:inline true} {:fieldmap "Mem_T._NPAGED_LOOKASIDE_LIST"} {:fieldname "WriteContextLookasideList"} WriteContextLookasideList__DO_EXTENSION(x: int) : int
{
  x + 2156
}

function {:inline true} {:fieldmap "Mem_T.WriteTriggerContext_FILTER_EXTENSION"} {:fieldname "WriteTriggerContext"} WriteTriggerContext_FILTER_EXTENSION(x: int) : int
{
  x + 3920
}

function {:inline true} {:fieldmap "Mem_T._VSP_WRITE_VOLUME"} {:fieldname "WriteVolume"} WriteVolume__VSP_CONTEXT(x: int) : int
{
  x + 412
}

function {:inline true} {:fieldmap "Mem_T._KEVENT"} {:fieldname "ZeroRefEvent"} ZeroRefEvent_FILTER_EXTENSION(x: int) : int
{
  x + 512
}

function {:inline true} {:fieldmap "Mem_T._KEVENT"} {:fieldname "ZeroRefEvent"} ZeroRefEvent_VOLUME_EXTENSION(x: int) : int
{
  x + 88
}

function {:inline true} {:fieldmap "Mem_T.u__VSP_RESOURCE"} {:fieldname "u"} u__VSP_RESOURCE(x: int) : int
{
  x + 4
}

const {:string ""} unique strConst__li2bpl0: int;

const {:string "HarddiskVolumeSnapshot%d"} unique strConst__li2bpl10: int;

const {:string "PrepareForSnapshot (Enter)"} unique strConst__li2bpl8: int;

const {:string "STORAGE\\VolumeSnapshot"} unique strConst__li2bpl9: int;

const {:string "SystemSetupInProgress"} unique strConst__li2bpl6: int;

const {:string "The driver has not called ObReferenceObject on the PDO that its returning."} unique strConst__li2bpl1: int;

const {:string "\\Device\\HarddiskVolumeShadowCopy%d"} unique strConst__li2bpl11: int;

const {:string "\\GLOBAL??\\HarddiskVolumeShadowCopy%d"} unique strConst__li2bpl3: int;

const {:string "\\KernelObjects\\LowMemoryCondition"} unique strConst__li2bpl4: int;

const {:string "\\Registry\\Machine\\SYSTEM\\CurrentControlSet\\Services\\setupdd"} unique strConst__li2bpl5: int;

const {:string "\\Registry\\Machine\\SYSTEM\\Setup"} unique strConst__li2bpl7: int;

const {:string "caller"} unique strConst__li2bpl2: int;

const {:allocated} li2bplFunctionConstant1035: int;

axiom li2bplFunctionConstant1035 == 1035;

const {:allocated} li2bplFunctionConstant1048: int;

axiom li2bplFunctionConstant1048 == 1048;

const {:allocated} li2bplFunctionConstant1097: int;

axiom li2bplFunctionConstant1097 == 1097;

const {:allocated} li2bplFunctionConstant1194: int;

axiom li2bplFunctionConstant1194 == 1194;

const {:allocated} li2bplFunctionConstant1200: int;

axiom li2bplFunctionConstant1200 == 1200;

const {:allocated} li2bplFunctionConstant1201: int;

axiom li2bplFunctionConstant1201 == 1201;

const {:allocated} li2bplFunctionConstant1209: int;

axiom li2bplFunctionConstant1209 == 1209;

const {:allocated} li2bplFunctionConstant1210: int;

axiom li2bplFunctionConstant1210 == 1210;

const {:allocated} li2bplFunctionConstant1216: int;

axiom li2bplFunctionConstant1216 == 1216;

const {:allocated} li2bplFunctionConstant1247: int;

axiom li2bplFunctionConstant1247 == 1247;

const {:allocated} li2bplFunctionConstant1262: int;

axiom li2bplFunctionConstant1262 == 1262;

const {:allocated} li2bplFunctionConstant1269: int;

axiom li2bplFunctionConstant1269 == 1269;

const {:allocated} li2bplFunctionConstant1273: int;

axiom li2bplFunctionConstant1273 == 1273;

const {:allocated} li2bplFunctionConstant1274: int;

axiom li2bplFunctionConstant1274 == 1274;

const {:allocated} li2bplFunctionConstant1278: int;

axiom li2bplFunctionConstant1278 == 1278;

const {:allocated} li2bplFunctionConstant1279: int;

axiom li2bplFunctionConstant1279 == 1279;

const {:allocated} li2bplFunctionConstant1280: int;

axiom li2bplFunctionConstant1280 == 1280;

const {:allocated} li2bplFunctionConstant1283: int;

axiom li2bplFunctionConstant1283 == 1283;

const {:allocated} li2bplFunctionConstant1286: int;

axiom li2bplFunctionConstant1286 == 1286;

const {:allocated} li2bplFunctionConstant1287: int;

axiom li2bplFunctionConstant1287 == 1287;

const {:allocated} li2bplFunctionConstant1389: int;

axiom li2bplFunctionConstant1389 == 1389;

const {:allocated} li2bplFunctionConstant1391: int;

axiom li2bplFunctionConstant1391 == 1391;

const {:allocated} li2bplFunctionConstant1394: int;

axiom li2bplFunctionConstant1394 == 1394;

const {:allocated} li2bplFunctionConstant827: int;

axiom li2bplFunctionConstant827 == 827;

const {:allocated} li2bplFunctionConstant829: int;

axiom li2bplFunctionConstant829 == 829;

const {:allocated} li2bplFunctionConstant836: int;

axiom li2bplFunctionConstant836 == 836;

const {:allocated} li2bplFunctionConstant838: int;

axiom li2bplFunctionConstant838 == 838;

const {:allocated} li2bplFunctionConstant840: int;

axiom li2bplFunctionConstant840 == 840;

const {:allocated} li2bplFunctionConstant841: int;

axiom li2bplFunctionConstant841 == 841;

const {:allocated} li2bplFunctionConstant853: int;

axiom li2bplFunctionConstant853 == 853;

const {:allocated} li2bplFunctionConstant876: int;

axiom li2bplFunctionConstant876 == 876;

const {:allocated} li2bplFunctionConstant889: int;

axiom li2bplFunctionConstant889 == 889;

const {:allocated} li2bplFunctionConstant907: int;

axiom li2bplFunctionConstant907 == 907;

const {:allocated} li2bplFunctionConstant969: int;

axiom li2bplFunctionConstant969 == 969;

const {:allocated} li2bplFunctionConstant977: int;

axiom li2bplFunctionConstant977 == 977;

const {:allocated} li2bplFunctionConstant999: int;

axiom li2bplFunctionConstant999 == 999;

implementation {:origName "sdv_hash_17066757"} sdv_hash_17066757#0(actual_Filter_27: int, actual_IsOffline: int, actual_IsFinalRemove_2: int, actual_NeedLock_3: int, actual_IsClusterUnexpectedOffline: int)
{
  var {:scalar} sdv_510: int;
  var {:scalar} sdv_513: int;
  var {:scalar} sdv_515: int;
  var {:scalar} listOfDiffAreaFilesToCloseKeep: int;
  var {:pointer} f: int;
  var {:pointer} diffAreaFile_4: int;
  var {:pointer} context_13: int;
  var {:scalar} listOfDiffAreaFilesToClose: int;
  var {:pointer} bitmap: int;
  var {:scalar} b: int;
  var {:scalar} dispInfo_1: int;
  var {:pointer} Tmp_671: int;
  var {:scalar} sdv_524: int;
  var {:scalar} sdv_525: int;
  var {:scalar} last: int;
  var {:scalar} sdv_529: int;
  var {:scalar} sdv_531: int;
  var {:pointer} Tmp_673: int;
  var {:pointer} irp_6: int;
  var {:pointer} l_15: int;
  var {:scalar} q_5: int;
  var {:scalar} sdv_533: int;
  var {:pointer} hh_1: int;
  var {:scalar} listOfDeviceObjectsToDelete: int;
  var {:scalar} status_23: int;
  var {:scalar} protectMode: int;
  var {:scalar} irql_25: int;
  var {:pointer} Tmp_674: int;
  var {:pointer} extension_8: int;
  var {:scalar} sdv_539: int;
  var {:pointer} h_3: int;
  var {:pointer} Filter_27: int;
  var {:scalar} IsOffline: int;
  var {:scalar} IsFinalRemove_2: int;
  var {:scalar} NeedLock_3: int;
  var {:scalar} IsClusterUnexpectedOffline: int;
  var vslice_dummy_var_330: int;
  var vslice_dummy_var_331: int;
  var vslice_dummy_var_332: int;
  var vslice_dummy_var_333: int;
  var vslice_dummy_var_334: int;
  var vslice_dummy_var_335: int;
  var vslice_dummy_var_336: int;
  var vslice_dummy_var_337: int;
  var vslice_dummy_var_338: int;
  var vslice_dummy_var_339: int;
  var vslice_dummy_var_340: int;
  var vslice_dummy_var_341: int;
  var vslice_dummy_var_342: int;
  var vslice_dummy_var_343: int;
  var vslice_dummy_var_1298: int;
  var vslice_dummy_var_1299: int;
  var vslice_dummy_var_1300: int;
  var vslice_dummy_var_1301: int;
  var vslice_dummy_var_1302: int;
  var vslice_dummy_var_1303: int;
  var vslice_dummy_var_1304: int;
  var vslice_dummy_var_1305: int;
  var vslice_dummy_var_1306: int;
  var vslice_dummy_var_1307: int;

  anon0:
    call {:si_unique_call 1410} listOfDiffAreaFilesToCloseKeep := __HAVOC_malloc(8);
    call {:si_unique_call 1411} listOfDiffAreaFilesToClose := __HAVOC_malloc(8);
    call {:si_unique_call 1412} dispInfo_1 := __HAVOC_malloc(4);
    call {:si_unique_call 1413} vslice_dummy_var_330 := __HAVOC_malloc(4);
    call {:si_unique_call 1414} q_5 := __HAVOC_malloc(8);
    call {:si_unique_call 1415} listOfDeviceObjectsToDelete := __HAVOC_malloc(8);
    call {:si_unique_call 1416} vslice_dummy_var_331 := __HAVOC_malloc(12);
    Filter_27 := actual_Filter_27;
    IsOffline := actual_IsOffline;
    IsFinalRemove_2 := actual_IsFinalRemove_2;
    NeedLock_3 := actual_NeedLock_3;
    IsClusterUnexpectedOffline := actual_IsClusterUnexpectedOffline;
    call {:si_unique_call 1417} irql_25 := KfAcquireSpinLock(0);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc context_13;
    goto anon98_Then, anon98_Else;

  anon98_Else:
    assume {:partition} context_13 != 0;
    call {:si_unique_call 1418} sdv_525 := KeCancelTimer(0);
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} sdv_525 != 0;
    call {:si_unique_call 1419} KfReleaseSpinLock(0, irql_25);
    call {:si_unique_call 1420} sdv_hash_997443178(0, context_13, 0, 0);
    goto L43;

  L43:
    call {:si_unique_call 1421} irql_25 := KfAcquireSpinLock(0);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc context_13;
    goto anon99_Then, anon99_Else;

  anon99_Else:
    assume {:partition} context_13 != 0;
    call {:si_unique_call 1422} sdv_529 := KeCancelTimer(0);
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} sdv_529 != 0;
    call {:si_unique_call 1423} KfReleaseSpinLock(0, irql_25);
    call {:si_unique_call 1424} sdv_hash_601969222(0, context_13, 0, 0);
    goto L62;

  L62:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1425} Tmp_674 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_674 != 0;
    assume Tmp_674 > 0;
    call {:si_unique_call 1426} IoAcquireCancelSpinLock(Tmp_674);
    assume {:nonnull} Tmp_674 != 0;
    assume Tmp_674 > 0;
    havoc irql_25;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc irp_6;
    goto anon100_Then, anon100_Else;

  anon100_Else:
    assume {:partition} irp_6 != 0;
    assume {:nonnull} irp_6 != 0;
    assume irp_6 > 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1298;
    call {:si_unique_call 1427} VspCancelRoutine(vslice_dummy_var_1298, irp_6);
    goto L79;

  L79:
    call {:si_unique_call 1428} sdv_hash_890975460(Filter_27);
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} NeedLock_3 == 0;
    goto L89;

  L89:
    call {:si_unique_call 1429} irql_25 := KfAcquireSpinLock(0);
    bitmap := sdv_524;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume {:partition} bitmap != 0;
    call {:si_unique_call 1430} VspFreeBitMap(bitmap);
    call {:si_unique_call 1431} ExFreePoolWithTag(0, 0);
    goto L99;

  L99:
    call {:si_unique_call 1432} IoUninitializeWorkItem(0);
    call {:si_unique_call 1433} KfReleaseSpinLock(0, irql_25);
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} NeedLock_3 != 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1299;
    call {:si_unique_call 1434} sdv_hash_986004649(vslice_dummy_var_1299);
    goto L112;

  L112:
    call {:si_unique_call 1435} vslice_dummy_var_332 := sdv_hash_1038281869(Filter_27, NeedLock_3, IsFinalRemove_2, 0);
    call {:si_unique_call 1436} InitializeListHead(listOfDiffAreaFilesToClose);
    call {:si_unique_call 1437} InitializeListHead(listOfDiffAreaFilesToCloseKeep);
    call {:si_unique_call 1438} InitializeListHead(listOfDeviceObjectsToDelete);
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} NeedLock_3 != 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1300;
    call {:si_unique_call 1439} sdv_hash_613687309(vslice_dummy_var_1300);
    goto L128;

  L128:
    b := 0;
    goto L132;

  L132:
    call {:si_unique_call 1440} b, sdv_539, vslice_dummy_var_333 := sdv_hash_17066757#0_loop_L132(listOfDiffAreaFilesToCloseKeep, b, listOfDeviceObjectsToDelete, sdv_539, Filter_27, vslice_dummy_var_333);
    goto L132_last;

  L132_last:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1479} sdv_539 := IsListEmpty(VolumeList_FILTER_EXTENSION(Filter_27));
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} sdv_539 != 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} b != 0;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} IsFinalRemove_2 == 0;
    call {:si_unique_call 1441} IoInvalidateDeviceRelations(0, 0);
    goto L140;

  L140:
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} IsOffline != 0;
    goto L146;

  L146:
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} IsOffline != 0;
    goto L148;

  L148:
    call {:si_unique_call 1442} sdv_510, sdv_513, f, diffAreaFile_4, b, Tmp_671, last, l_15, status_23, protectMode, extension_8, vslice_dummy_var_337, vslice_dummy_var_338, vslice_dummy_var_339, vslice_dummy_var_340 := sdv_hash_17066757#0_loop_L148(sdv_510, sdv_513, listOfDiffAreaFilesToCloseKeep, f, diffAreaFile_4, listOfDiffAreaFilesToClose, b, Tmp_671, last, l_15, listOfDeviceObjectsToDelete, status_23, protectMode, extension_8, Filter_27, IsOffline, IsClusterUnexpectedOffline, vslice_dummy_var_337, vslice_dummy_var_338, vslice_dummy_var_339, vslice_dummy_var_340);
    goto L148_last;

  L148_last:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1478} sdv_513 := IsListEmpty(DiffAreaFilesOnThisFilter_FILTER_EXTENSION(Filter_27));
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:partition} sdv_513 != 0;
    h_3 := sdv_515;
    call {:si_unique_call 1443} sdv_hash_805325738(Filter_27, 0, 0);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume {:partition} IsOffline != 0;
    goto L164;

  L164:
    call {:si_unique_call 1444} sdv_hash_811354472(Filter_27);
    call {:si_unique_call 1445} sdv_hash_692646834(Filter_27);
    hh_1 := sdv_531;
    goto anon103_Then, anon103_Else;

  anon103_Else:
    assume {:partition} IsOffline != 0;
    goto L179;

  L179:
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} NeedLock_3 != 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1301;
    call {:si_unique_call 1446} sdv_hash_986004649(vslice_dummy_var_1301);
    goto L180;

  L180:
    call {:si_unique_call 1447} InitializeListHead(q_5);
    call {:si_unique_call 1448} sdv_hash_742206354(listOfDiffAreaFilesToCloseKeep, q_5, 1);
    call {:si_unique_call 1449} sdv_hash_742206354(listOfDiffAreaFilesToClose, listOfDeviceObjectsToDelete, 0);
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} h_3 != 0;
    assume {:nonnull} dispInfo_1 != 0;
    assume dispInfo_1 > 0;
    call {:si_unique_call 1450} vslice_dummy_var_342 := ZwSetInformationFile(0, 0, 0, 1, 13);
    call {:si_unique_call 1451} vslice_dummy_var_334 := ZwClose(0);
    goto L193;

  L193:
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} hh_1 != 0;
    call {:si_unique_call 1452} vslice_dummy_var_335 := ZwClose(0);
    goto L1;

  L1:
    return;

  anon88_Then:
    assume {:partition} hh_1 == 0;
    goto L1;

  anon87_Then:
    assume {:partition} h_3 == 0;
    goto L193;

  anon86_Then:
    assume {:partition} NeedLock_3 == 0;
    goto L180;

  anon103_Then:
    assume {:partition} IsOffline == 0;
    goto L176;

  L176:
    call {:si_unique_call 1453} l_15, sdv_533, extension_8 := sdv_hash_17066757#0_loop_L176(l_15, sdv_533, extension_8, Filter_27);
    goto L176_last;

  L176_last:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1476} sdv_533 := IsListEmpty(DeadVolumeList_FILTER_EXTENSION(Filter_27));
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} sdv_533 == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1454} l_15 := RemoveHeadList(DeadVolumeList_FILTER_EXTENSION(Filter_27));
    extension_8 := l_15;
    goto anon89_Else_dummy;

  anon89_Else_dummy:
    assume false;
    return;

  anon89_Then:
    assume {:partition} sdv_533 != 0;
    goto L179;

  anon102_Then:
    assume {:partition} IsOffline == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    call {:si_unique_call 1455} vslice_dummy_var_336 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1302;
    call {:si_unique_call 1456} VspFreeIrp(vslice_dummy_var_1302, 1);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1457} vslice_dummy_var_343 := KeReleaseMutex(0, 0);
    goto L164;

  anon85_Then:
    goto L164;

  anon84_Then:
    assume {:partition} sdv_513 == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc l_15;
    diffAreaFile_4 := l_15;
    assume {:nonnull} diffAreaFile_4 != 0;
    assume diffAreaFile_4 > 0;
    havoc Tmp_671;
    assume {:nonnull} Tmp_671 != 0;
    assume Tmp_671 > 0;
    havoc f;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume {:partition} IsClusterUnexpectedOffline != 0;
    call {:si_unique_call 1458} vslice_dummy_var_337 := sdv_hash_1038281869(f, 0, 0, 0);
    call {:si_unique_call 1459} status_23 := sdv_hash_208558080(f, 0);
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} status_23 >= 0;
    call {:si_unique_call 1460} status_23 := sdv_hash_206641207(f, 0);
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} status_23 >= 0;
    assume {:nonnull} f != 0;
    assume f > 0;
    assume false;
    return;

  anon92_Then:
    assume {:partition} 0 > status_23;
    goto L226;

  L226:
    assume {:nonnull} f != 0;
    assume f > 0;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    call {:si_unique_call 1461} protectMode := sdv_hash_185580169(f, 14, 0, 1703937);
    goto L250;

  L250:
    call {:si_unique_call 1462} vslice_dummy_var_338 := sdv_hash_1038281869(f, 0, 0, 0);
    b := 0;
    goto L254;

  L254:
    call {:si_unique_call 1463} sdv_510, b, last, extension_8, vslice_dummy_var_339, vslice_dummy_var_340 := sdv_hash_17066757#0_loop_L254(sdv_510, listOfDiffAreaFilesToCloseKeep, f, diffAreaFile_4, listOfDiffAreaFilesToClose, b, last, listOfDeviceObjectsToDelete, protectMode, extension_8, vslice_dummy_var_339, vslice_dummy_var_340);
    goto L254_last;

  L254_last:
    assume {:nonnull} f != 0;
    assume f > 0;
    call {:si_unique_call 1477} sdv_510 := IsListEmpty(VolumeList_FILTER_EXTENSION(f));
    goto anon94_Then, anon94_Else;

  anon94_Else:
    assume {:partition} sdv_510 != 0;
    goto L259;

  L259:
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} b != 0;
    call {:si_unique_call 1464} IoInvalidateDeviceRelations(0, 0);
    goto anon95_Else_dummy;

  anon95_Else_dummy:
    assume false;
    return;

  anon95_Then:
    assume {:partition} b == 0;
    goto anon95_Then_dummy;

  anon95_Then_dummy:
    assume false;
    return;

  anon94_Then:
    assume {:partition} sdv_510 == 0;
    assume {:nonnull} f != 0;
    assume f > 0;
    havoc extension_8;
    assume {:nonnull} diffAreaFile_4 != 0;
    assume diffAreaFile_4 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    last := 1;
    goto L266;

  L266:
    assume {:nonnull} f != 0;
    assume f > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    goto L268;

  L268:
    call {:si_unique_call 1465} vslice_dummy_var_339 := sdv_hash_210112601(f, listOfDiffAreaFilesToCloseKeep, listOfDeviceObjectsToDelete, 1, 1, 0);
    goto L271;

  L271:
    b := 1;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:partition} last != 0;
    goto L259;

  anon106_Then:
    assume {:partition} last == 0;
    goto anon106_Then_dummy;

  anon106_Then_dummy:
    assume false;
    return;

  anon96_Then:
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} protectMode == 0;
    call {:si_unique_call 1466} vslice_dummy_var_340 := sdv_hash_210112601(f, listOfDiffAreaFilesToClose, listOfDeviceObjectsToDelete, 0, 1, 0);
    goto L271;

  anon97_Then:
    assume {:partition} protectMode != 0;
    goto L268;

  anon105_Then:
    last := 0;
    goto L266;

  anon90_Then:
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} IsOffline != 0;
    assume {:nonnull} diffAreaFile_4 != 0;
    assume diffAreaFile_4 > 0;
    havoc vslice_dummy_var_1303;
    havoc vslice_dummy_var_1304;
    call {:si_unique_call 1467} sdv_hash_570003108(vslice_dummy_var_1303, vslice_dummy_var_1304, -1073348548, 0, 0, 1);
    goto L283;

  L283:
    protectMode := 0;
    goto L250;

  anon93_Then:
    assume {:partition} IsOffline == 0;
    assume {:nonnull} diffAreaFile_4 != 0;
    assume diffAreaFile_4 > 0;
    havoc vslice_dummy_var_1305;
    havoc vslice_dummy_var_1306;
    call {:si_unique_call 1468} sdv_hash_570003108(vslice_dummy_var_1305, vslice_dummy_var_1306, -1073348592, 0, 3, 1);
    goto L283;

  anon91_Then:
    assume {:partition} 0 > status_23;
    goto L226;

  anon104_Then:
    assume {:partition} IsClusterUnexpectedOffline == 0;
    goto L226;

  anon83_Then:
    assume {:partition} IsOffline == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc Tmp_673;
    assume {:nonnull} Tmp_673 != 0;
    assume Tmp_673 > 0;
    havoc l_15;
    goto L285;

  L285:
    call {:si_unique_call 1469} f, l_15 := sdv_hash_17066757#0_loop_L285(f, l_15, Filter_27);
    goto L285_last;

  L285_last:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto anon107_Then, anon107_Else;

  anon107_Else:
    f := l_15;
    assume {:nonnull} f != 0;
    assume f > 0;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:nonnull} f != 0;
    assume f > 0;
    goto L288;

  L288:
    assume {:nonnull} l_15 != 0;
    assume l_15 > 0;
    havoc l_15;
    goto L288_dummy;

  L288_dummy:
    assume false;
    return;

  anon108_Then:
    goto L288;

  anon107_Then:
    goto L148;

  anon80_Then:
    assume {:partition} IsOffline == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1470} vslice_dummy_var_341 := RemoveEntryList(ListEntry_FILTER_EXTENSION(Filter_27));
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto L146;

  anon82_Then:
    goto L146;

  anon81_Then:
    assume {:partition} IsFinalRemove_2 != 0;
    goto L140;

  anon79_Then:
    assume {:partition} b == 0;
    goto L140;

  anon78_Then:
    assume {:partition} sdv_539 == 0;
    call {:si_unique_call 1471} vslice_dummy_var_333 := sdv_hash_210112601(Filter_27, listOfDiffAreaFilesToCloseKeep, listOfDeviceObjectsToDelete, 1, 1, 0);
    b := 1;
    goto anon78_Then_dummy;

  anon78_Then_dummy:
    assume false;
    return;

  anon77_Then:
    assume {:partition} NeedLock_3 == 0;
    goto L128;

  anon76_Then:
    assume {:partition} NeedLock_3 == 0;
    goto L112;

  anon101_Then:
    assume {:partition} bitmap == 0;
    goto L99;

  anon75_Then:
    assume {:partition} NeedLock_3 != 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1307;
    call {:si_unique_call 1472} sdv_hash_613687309(vslice_dummy_var_1307);
    goto L89;

  anon100_Then:
    assume {:partition} irp_6 == 0;
    call {:si_unique_call 1473} IoReleaseCancelSpinLock(irql_25);
    goto L79;

  anon74_Then:
    assume {:partition} sdv_529 == 0;
    goto L49;

  L49:
    call {:si_unique_call 1474} KfReleaseSpinLock(0, irql_25);
    goto L62;

  anon99_Then:
    assume {:partition} context_13 == 0;
    goto L49;

  anon73_Then:
    assume {:partition} sdv_525 == 0;
    goto L30;

  L30:
    call {:si_unique_call 1475} KfReleaseSpinLock(0, irql_25);
    goto L43;

  anon98_Then:
    assume {:partition} context_13 == 0;
    goto L30;
}



procedure {:origName "sdv_hash_17066757"} sdv_hash_17066757#0(actual_Filter_27: int, actual_IsOffline: int, actual_IsFinalRemove_2: int, actual_NeedLock_3: int, actual_IsClusterUnexpectedOffline: int);
  modifies alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK, ref, Mem_T.Type_unnamed_tag_26, Mem_T.CurrentStackLocation_unnamed_tag_6;



implementation {:origName "sdv_hash_17066757"} sdv_hash_17066757#1(actual_Filter_27: int, actual_IsOffline: int, actual_IsFinalRemove_2: int, actual_NeedLock_3: int, actual_IsClusterUnexpectedOffline: int)
{
  var {:scalar} sdv_510: int;
  var {:scalar} sdv_513: int;
  var {:scalar} sdv_515: int;
  var {:scalar} listOfDiffAreaFilesToCloseKeep: int;
  var {:pointer} f: int;
  var {:pointer} diffAreaFile_4: int;
  var {:pointer} context_13: int;
  var {:scalar} listOfDiffAreaFilesToClose: int;
  var {:pointer} bitmap: int;
  var {:scalar} b: int;
  var {:scalar} dispInfo_1: int;
  var {:pointer} Tmp_671: int;
  var {:scalar} sdv_524: int;
  var {:scalar} sdv_525: int;
  var {:scalar} last: int;
  var {:scalar} sdv_529: int;
  var {:scalar} sdv_531: int;
  var {:pointer} Tmp_673: int;
  var {:pointer} irp_6: int;
  var {:pointer} l_15: int;
  var {:scalar} q_5: int;
  var {:scalar} sdv_533: int;
  var {:pointer} hh_1: int;
  var {:scalar} listOfDeviceObjectsToDelete: int;
  var {:scalar} status_23: int;
  var {:scalar} protectMode: int;
  var {:scalar} irql_25: int;
  var {:pointer} Tmp_674: int;
  var {:pointer} extension_8: int;
  var {:scalar} sdv_539: int;
  var {:pointer} h_3: int;
  var {:pointer} Filter_27: int;
  var {:scalar} IsOffline: int;
  var {:scalar} IsFinalRemove_2: int;
  var {:scalar} NeedLock_3: int;
  var {:scalar} IsClusterUnexpectedOffline: int;
  var vslice_dummy_var_344: int;
  var vslice_dummy_var_345: int;
  var vslice_dummy_var_346: int;
  var vslice_dummy_var_347: int;
  var vslice_dummy_var_348: int;
  var vslice_dummy_var_349: int;
  var vslice_dummy_var_350: int;
  var vslice_dummy_var_351: int;
  var vslice_dummy_var_352: int;
  var vslice_dummy_var_353: int;
  var vslice_dummy_var_354: int;
  var vslice_dummy_var_355: int;
  var vslice_dummy_var_356: int;
  var vslice_dummy_var_357: int;
  var vslice_dummy_var_1308: int;
  var vslice_dummy_var_1309: int;
  var vslice_dummy_var_1310: int;
  var vslice_dummy_var_1311: int;
  var vslice_dummy_var_1312: int;
  var vslice_dummy_var_1313: int;
  var vslice_dummy_var_1314: int;
  var vslice_dummy_var_1315: int;
  var vslice_dummy_var_1316: int;
  var vslice_dummy_var_1317: int;

  anon0:
    call {:si_unique_call 1480} listOfDiffAreaFilesToCloseKeep := __HAVOC_malloc(8);
    call {:si_unique_call 1481} listOfDiffAreaFilesToClose := __HAVOC_malloc(8);
    call {:si_unique_call 1482} dispInfo_1 := __HAVOC_malloc(4);
    call {:si_unique_call 1483} vslice_dummy_var_344 := __HAVOC_malloc(4);
    call {:si_unique_call 1484} q_5 := __HAVOC_malloc(8);
    call {:si_unique_call 1485} listOfDeviceObjectsToDelete := __HAVOC_malloc(8);
    call {:si_unique_call 1486} vslice_dummy_var_345 := __HAVOC_malloc(12);
    Filter_27 := actual_Filter_27;
    IsOffline := actual_IsOffline;
    IsFinalRemove_2 := actual_IsFinalRemove_2;
    NeedLock_3 := actual_NeedLock_3;
    IsClusterUnexpectedOffline := actual_IsClusterUnexpectedOffline;
    call {:si_unique_call 1487} irql_25 := KfAcquireSpinLock(0);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc context_13;
    goto anon98_Then, anon98_Else;

  anon98_Else:
    assume {:partition} context_13 != 0;
    call {:si_unique_call 1488} sdv_525 := KeCancelTimer(0);
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} sdv_525 != 0;
    call {:si_unique_call 1489} KfReleaseSpinLock(0, irql_25);
    call {:si_unique_call 1490} sdv_hash_997443178(0, context_13, 0, 0);
    goto L43;

  L43:
    call {:si_unique_call 1491} irql_25 := KfAcquireSpinLock(0);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc context_13;
    goto anon99_Then, anon99_Else;

  anon99_Else:
    assume {:partition} context_13 != 0;
    call {:si_unique_call 1492} sdv_529 := KeCancelTimer(0);
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} sdv_529 != 0;
    call {:si_unique_call 1493} KfReleaseSpinLock(0, irql_25);
    call {:si_unique_call 1494} sdv_hash_601969222(0, context_13, 0, 0);
    goto L62;

  L62:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1495} Tmp_674 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_674 != 0;
    assume Tmp_674 > 0;
    call {:si_unique_call 1496} IoAcquireCancelSpinLock(Tmp_674);
    assume {:nonnull} Tmp_674 != 0;
    assume Tmp_674 > 0;
    havoc irql_25;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc irp_6;
    goto anon100_Then, anon100_Else;

  anon100_Else:
    assume {:partition} irp_6 != 0;
    assume {:nonnull} irp_6 != 0;
    assume irp_6 > 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1308;
    call {:si_unique_call 1497} VspCancelRoutine(vslice_dummy_var_1308, irp_6);
    goto L79;

  L79:
    call {:si_unique_call 1498} sdv_hash_890975460(Filter_27);
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} NeedLock_3 == 0;
    goto L89;

  L89:
    call {:si_unique_call 1499} irql_25 := KfAcquireSpinLock(0);
    bitmap := sdv_524;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume {:partition} bitmap != 0;
    call {:si_unique_call 1500} VspFreeBitMap(bitmap);
    call {:si_unique_call 1501} ExFreePoolWithTag(0, 0);
    goto L99;

  L99:
    call {:si_unique_call 1502} IoUninitializeWorkItem(0);
    call {:si_unique_call 1503} KfReleaseSpinLock(0, irql_25);
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} NeedLock_3 != 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1309;
    call {:si_unique_call 1504} sdv_hash_986004649(vslice_dummy_var_1309);
    goto L112;

  L112:
    call {:si_unique_call 1505} vslice_dummy_var_346 := sdv_hash_1038281869(Filter_27, NeedLock_3, IsFinalRemove_2, 0);
    call {:si_unique_call 1506} InitializeListHead(listOfDiffAreaFilesToClose);
    call {:si_unique_call 1507} InitializeListHead(listOfDiffAreaFilesToCloseKeep);
    call {:si_unique_call 1508} InitializeListHead(listOfDeviceObjectsToDelete);
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} NeedLock_3 != 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1310;
    call {:si_unique_call 1509} sdv_hash_613687309(vslice_dummy_var_1310);
    goto L128;

  L128:
    b := 0;
    goto L132;

  L132:
    call {:si_unique_call 1510} b, sdv_539, vslice_dummy_var_347 := sdv_hash_17066757#1_loop_L132(listOfDiffAreaFilesToCloseKeep, b, listOfDeviceObjectsToDelete, sdv_539, Filter_27, vslice_dummy_var_347);
    goto L132_last;

  L132_last:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1550} sdv_539 := IsListEmpty(VolumeList_FILTER_EXTENSION(Filter_27));
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} sdv_539 != 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} b != 0;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} IsFinalRemove_2 == 0;
    call {:si_unique_call 1511} IoInvalidateDeviceRelations(0, 0);
    goto L140;

  L140:
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} IsOffline != 0;
    goto L146;

  L146:
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} IsOffline != 0;
    goto L148;

  L148:
    call {:si_unique_call 1512} sdv_510, sdv_513, f, diffAreaFile_4, b, Tmp_671, last, l_15, status_23, protectMode, extension_8, vslice_dummy_var_351, vslice_dummy_var_352, vslice_dummy_var_353, vslice_dummy_var_354 := sdv_hash_17066757#1_loop_L148(sdv_510, sdv_513, listOfDiffAreaFilesToCloseKeep, f, diffAreaFile_4, listOfDiffAreaFilesToClose, b, Tmp_671, last, l_15, listOfDeviceObjectsToDelete, status_23, protectMode, extension_8, Filter_27, IsOffline, IsClusterUnexpectedOffline, vslice_dummy_var_351, vslice_dummy_var_352, vslice_dummy_var_353, vslice_dummy_var_354);
    goto L148_last;

  L148_last:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1549} sdv_513 := IsListEmpty(DiffAreaFilesOnThisFilter_FILTER_EXTENSION(Filter_27));
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:partition} sdv_513 != 0;
    h_3 := sdv_515;
    call {:si_unique_call 1513} sdv_hash_805325738(Filter_27, 0, 0);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume {:partition} IsOffline != 0;
    goto L164;

  L164:
    call {:si_unique_call 1514} sdv_hash_811354472(Filter_27);
    call {:si_unique_call 1515} sdv_hash_692646834(Filter_27);
    hh_1 := sdv_531;
    goto anon103_Then, anon103_Else;

  anon103_Else:
    assume {:partition} IsOffline != 0;
    goto L179;

  L179:
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} NeedLock_3 != 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1311;
    call {:si_unique_call 1516} sdv_hash_986004649(vslice_dummy_var_1311);
    goto L180;

  L180:
    call {:si_unique_call 1517} InitializeListHead(q_5);
    call {:si_unique_call 1518} sdv_hash_742206354(listOfDiffAreaFilesToCloseKeep, q_5, 1);
    call {:si_unique_call 1519} sdv_hash_742206354(listOfDiffAreaFilesToClose, listOfDeviceObjectsToDelete, 0);
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} h_3 != 0;
    assume {:nonnull} dispInfo_1 != 0;
    assume dispInfo_1 > 0;
    call {:si_unique_call 1520} vslice_dummy_var_356 := ZwSetInformationFile(0, 0, 0, 1, 13);
    call {:si_unique_call 1521} vslice_dummy_var_348 := ZwClose(0);
    goto L193;

  L193:
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} hh_1 != 0;
    call {:si_unique_call 1522} vslice_dummy_var_349 := ZwClose(0);
    goto L1;

  L1:
    return;

  anon88_Then:
    assume {:partition} hh_1 == 0;
    goto L1;

  anon87_Then:
    assume {:partition} h_3 == 0;
    goto L193;

  anon86_Then:
    assume {:partition} NeedLock_3 == 0;
    goto L180;

  anon103_Then:
    assume {:partition} IsOffline == 0;
    goto L176;

  L176:
    call {:si_unique_call 1523} l_15, sdv_533, extension_8 := sdv_hash_17066757#1_loop_L176(l_15, sdv_533, extension_8, Filter_27);
    goto L176_last;

  L176_last:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1547} sdv_533 := IsListEmpty(DeadVolumeList_FILTER_EXTENSION(Filter_27));
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} sdv_533 == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1524} l_15 := RemoveHeadList(DeadVolumeList_FILTER_EXTENSION(Filter_27));
    extension_8 := l_15;
    goto anon89_Else_dummy;

  anon89_Else_dummy:
    assume false;
    return;

  anon89_Then:
    assume {:partition} sdv_533 != 0;
    goto L179;

  anon102_Then:
    assume {:partition} IsOffline == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    call {:si_unique_call 1525} vslice_dummy_var_350 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1312;
    call {:si_unique_call 1526} VspFreeIrp(vslice_dummy_var_1312, 1);
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1527} vslice_dummy_var_357 := KeReleaseMutex(0, 0);
    goto L164;

  anon85_Then:
    goto L164;

  anon84_Then:
    assume {:partition} sdv_513 == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc l_15;
    diffAreaFile_4 := l_15;
    assume {:nonnull} diffAreaFile_4 != 0;
    assume diffAreaFile_4 > 0;
    havoc Tmp_671;
    assume {:nonnull} Tmp_671 != 0;
    assume Tmp_671 > 0;
    havoc f;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume {:partition} IsClusterUnexpectedOffline != 0;
    call {:si_unique_call 1528} vslice_dummy_var_351 := sdv_hash_1038281869(f, 0, 0, 0);
    call {:si_unique_call 1529} status_23 := sdv_hash_208558080(f, 0);
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} status_23 >= 0;
    call {:si_unique_call 1530} status_23 := sdv_hash_206641207(f, 0);
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} status_23 >= 0;
    assume {:nonnull} f != 0;
    assume f > 0;
    call {:si_unique_call 1531} sdv_hash_17066757#0(f, 1, 0, 0, 1);
    goto anon92_Else_dummy;

  anon92_Else_dummy:
    assume false;
    return;

  anon92_Then:
    assume {:partition} 0 > status_23;
    goto L226;

  L226:
    assume {:nonnull} f != 0;
    assume f > 0;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    call {:si_unique_call 1532} protectMode := sdv_hash_185580169(f, 14, 0, 1703937);
    goto L250;

  L250:
    call {:si_unique_call 1533} vslice_dummy_var_352 := sdv_hash_1038281869(f, 0, 0, 0);
    b := 0;
    goto L254;

  L254:
    call {:si_unique_call 1534} sdv_510, b, last, extension_8, vslice_dummy_var_353, vslice_dummy_var_354 := sdv_hash_17066757#1_loop_L254(sdv_510, listOfDiffAreaFilesToCloseKeep, f, diffAreaFile_4, listOfDiffAreaFilesToClose, b, last, listOfDeviceObjectsToDelete, protectMode, extension_8, vslice_dummy_var_353, vslice_dummy_var_354);
    goto L254_last;

  L254_last:
    assume {:nonnull} f != 0;
    assume f > 0;
    call {:si_unique_call 1548} sdv_510 := IsListEmpty(VolumeList_FILTER_EXTENSION(f));
    goto anon94_Then, anon94_Else;

  anon94_Else:
    assume {:partition} sdv_510 != 0;
    goto L259;

  L259:
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} b != 0;
    call {:si_unique_call 1535} IoInvalidateDeviceRelations(0, 0);
    goto anon95_Else_dummy;

  anon95_Else_dummy:
    assume false;
    return;

  anon95_Then:
    assume {:partition} b == 0;
    goto anon95_Then_dummy;

  anon95_Then_dummy:
    assume false;
    return;

  anon94_Then:
    assume {:partition} sdv_510 == 0;
    assume {:nonnull} f != 0;
    assume f > 0;
    havoc extension_8;
    assume {:nonnull} diffAreaFile_4 != 0;
    assume diffAreaFile_4 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    last := 1;
    goto L266;

  L266:
    assume {:nonnull} f != 0;
    assume f > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    goto L268;

  L268:
    call {:si_unique_call 1536} vslice_dummy_var_353 := sdv_hash_210112601(f, listOfDiffAreaFilesToCloseKeep, listOfDeviceObjectsToDelete, 1, 1, 0);
    goto L271;

  L271:
    b := 1;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:partition} last != 0;
    goto L259;

  anon106_Then:
    assume {:partition} last == 0;
    goto anon106_Then_dummy;

  anon106_Then_dummy:
    assume false;
    return;

  anon96_Then:
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} protectMode == 0;
    call {:si_unique_call 1537} vslice_dummy_var_354 := sdv_hash_210112601(f, listOfDiffAreaFilesToClose, listOfDeviceObjectsToDelete, 0, 1, 0);
    goto L271;

  anon97_Then:
    assume {:partition} protectMode != 0;
    goto L268;

  anon105_Then:
    last := 0;
    goto L266;

  anon90_Then:
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} IsOffline != 0;
    assume {:nonnull} diffAreaFile_4 != 0;
    assume diffAreaFile_4 > 0;
    havoc vslice_dummy_var_1313;
    havoc vslice_dummy_var_1314;
    call {:si_unique_call 1538} sdv_hash_570003108(vslice_dummy_var_1313, vslice_dummy_var_1314, -1073348548, 0, 0, 1);
    goto L283;

  L283:
    protectMode := 0;
    goto L250;

  anon93_Then:
    assume {:partition} IsOffline == 0;
    assume {:nonnull} diffAreaFile_4 != 0;
    assume diffAreaFile_4 > 0;
    havoc vslice_dummy_var_1315;
    havoc vslice_dummy_var_1316;
    call {:si_unique_call 1539} sdv_hash_570003108(vslice_dummy_var_1315, vslice_dummy_var_1316, -1073348592, 0, 3, 1);
    goto L283;

  anon91_Then:
    assume {:partition} 0 > status_23;
    goto L226;

  anon104_Then:
    assume {:partition} IsClusterUnexpectedOffline == 0;
    goto L226;

  anon83_Then:
    assume {:partition} IsOffline == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc Tmp_673;
    assume {:nonnull} Tmp_673 != 0;
    assume Tmp_673 > 0;
    havoc l_15;
    goto L285;

  L285:
    call {:si_unique_call 1540} f, l_15 := sdv_hash_17066757#1_loop_L285(f, l_15, Filter_27);
    goto L285_last;

  L285_last:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto anon107_Then, anon107_Else;

  anon107_Else:
    f := l_15;
    assume {:nonnull} f != 0;
    assume f > 0;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:nonnull} f != 0;
    assume f > 0;
    goto L288;

  L288:
    assume {:nonnull} l_15 != 0;
    assume l_15 > 0;
    havoc l_15;
    goto L288_dummy;

  L288_dummy:
    assume false;
    return;

  anon108_Then:
    goto L288;

  anon107_Then:
    goto L148;

  anon80_Then:
    assume {:partition} IsOffline == 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    call {:si_unique_call 1541} vslice_dummy_var_355 := RemoveEntryList(ListEntry_FILTER_EXTENSION(Filter_27));
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    goto L146;

  anon82_Then:
    goto L146;

  anon81_Then:
    assume {:partition} IsFinalRemove_2 != 0;
    goto L140;

  anon79_Then:
    assume {:partition} b == 0;
    goto L140;

  anon78_Then:
    assume {:partition} sdv_539 == 0;
    call {:si_unique_call 1542} vslice_dummy_var_347 := sdv_hash_210112601(Filter_27, listOfDiffAreaFilesToCloseKeep, listOfDeviceObjectsToDelete, 1, 1, 0);
    b := 1;
    goto anon78_Then_dummy;

  anon78_Then_dummy:
    assume false;
    return;

  anon77_Then:
    assume {:partition} NeedLock_3 == 0;
    goto L128;

  anon76_Then:
    assume {:partition} NeedLock_3 == 0;
    goto L112;

  anon101_Then:
    assume {:partition} bitmap == 0;
    goto L99;

  anon75_Then:
    assume {:partition} NeedLock_3 != 0;
    assume {:nonnull} Filter_27 != 0;
    assume Filter_27 > 0;
    havoc vslice_dummy_var_1317;
    call {:si_unique_call 1543} sdv_hash_613687309(vslice_dummy_var_1317);
    goto L89;

  anon100_Then:
    assume {:partition} irp_6 == 0;
    call {:si_unique_call 1544} IoReleaseCancelSpinLock(irql_25);
    goto L79;

  anon74_Then:
    assume {:partition} sdv_529 == 0;
    goto L49;

  L49:
    call {:si_unique_call 1545} KfReleaseSpinLock(0, irql_25);
    goto L62;

  anon99_Then:
    assume {:partition} context_13 == 0;
    goto L49;

  anon73_Then:
    assume {:partition} sdv_525 == 0;
    goto L30;

  L30:
    call {:si_unique_call 1546} KfReleaseSpinLock(0, irql_25);
    goto L43;

  anon98_Then:
    assume {:partition} context_13 == 0;
    goto L30;
}



procedure {:origName "sdv_hash_17066757"} sdv_hash_17066757#1(actual_Filter_27: int, actual_IsOffline: int, actual_IsFinalRemove_2: int, actual_NeedLock_3: int, actual_IsClusterUnexpectedOffline: int);
  modifies alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK, ref, Mem_T.Type_unnamed_tag_26, Mem_T.CurrentStackLocation_unnamed_tag_6;



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

implementation VspFreeBitMap_loop_L9(in_i: int, in_Tmp_2: int, in_Tmp_4: int, in_Tmp_5: int, in_Tmp_6: int, in_Tmp_7: int, in_Tmp_9: int, in_BitMap: int) returns (out_i: int, out_Tmp_2: int, out_Tmp_4: int, out_Tmp_5: int, out_Tmp_6: int, out_Tmp_7: int, out_Tmp_9: int)
{

  entry:
    out_i, out_Tmp_2, out_Tmp_4, out_Tmp_5, out_Tmp_6, out_Tmp_7, out_Tmp_9 := in_i, in_Tmp_2, in_Tmp_4, in_Tmp_5, in_Tmp_6, in_Tmp_7, in_Tmp_9;
    goto L9, exit;

  exit:
    return;

  L9:
    assume {:nonnull} in_BitMap != 0;
    assume in_BitMap > 0;
    goto anon10_Else;

  anon10_Else:
    out_Tmp_2 := out_i;
    assume {:nonnull} in_BitMap != 0;
    assume in_BitMap > 0;
    havoc out_Tmp_7;
    assume {:nonnull} out_Tmp_7 != 0;
    assume out_Tmp_7 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    out_Tmp_9 := out_i;
    assume {:nonnull} in_BitMap != 0;
    assume in_BitMap > 0;
    havoc out_Tmp_4;
    assume {:nonnull} out_Tmp_4 != 0;
    assume out_Tmp_4 > 0;
    call {:si_unique_call 1551} ExFreePoolWithTag(0, 0);
    out_Tmp_6 := out_i;
    assume {:nonnull} in_BitMap != 0;
    assume in_BitMap > 0;
    havoc out_Tmp_5;
    assume {:nonnull} out_Tmp_5 != 0;
    assume out_Tmp_5 > 0;
    goto L14;

  L14:
    out_i := out_i + 1;
    goto L14_dummy;

  L14_dummy:
    call {:si_unique_call 1552} {:si_old_unique_call 1} out_i, out_Tmp_2, out_Tmp_4, out_Tmp_5, out_Tmp_6, out_Tmp_7, out_Tmp_9 := VspFreeBitMap_loop_L9(out_i, out_Tmp_2, out_Tmp_4, out_Tmp_5, out_Tmp_6, out_Tmp_7, out_Tmp_9, in_BitMap);
    return;

  anon12_Then:
    goto L14;
}



procedure {:LoopProcedure} VspFreeBitMap_loop_L9(in_i: int, in_Tmp_2: int, in_Tmp_4: int, in_Tmp_5: int, in_Tmp_6: int, in_Tmp_7: int, in_Tmp_9: int, in_BitMap: int) returns (out_i: int, out_Tmp_2: int, out_Tmp_4: int, out_Tmp_5: int, out_Tmp_6: int, out_Tmp_7: int, out_Tmp_9: int);
  modifies alloc;



implementation sdv_hash_890975460_loop_L75(in_majorFunction: int, in_Tmp_244: int, in_irpSp: int, in_irp: int, in_l: int, in_Tmp_248: int, in_driver: int, in_tmp: int, in_vslice_dummy_var_50: int, in_vslice_dummy_var_51: int, in_vslice_dummy_var_52: int, in_vslice_dummy_var_53: int, in_vslice_dummy_var_54: int, in_vslice_dummy_var_55: int, in_vslice_dummy_var_56: int, in_vslice_dummy_var_57: int, in_vslice_dummy_var_58: int, in_vslice_dummy_var_59: int, in_vslice_dummy_var_60: int, in_vslice_dummy_var_61: int, in_vslice_dummy_var_62: int, in_vslice_dummy_var_63: int, in_vslice_dummy_var_64: int, in_vslice_dummy_var_65: int, in_vslice_dummy_var_66: int, in_vslice_dummy_var_67: int, in_vslice_dummy_var_68: int, in_vslice_dummy_var_69: int, in_vslice_dummy_var_70: int, in_vslice_dummy_var_71: int, in_vslice_dummy_var_72: int) returns (out_majorFunction: int, out_Tmp_244: int, out_irpSp: int, out_irp: int, out_l: int, out_Tmp_248: int, out_tmp: int, out_vslice_dummy_var_50: int, out_vslice_dummy_var_51: int, out_vslice_dummy_var_52: int, out_vslice_dummy_var_53: int, out_vslice_dummy_var_54: int, out_vslice_dummy_var_55: int, out_vslice_dummy_var_56: int, out_vslice_dummy_var_57: int, out_vslice_dummy_var_58: int, out_vslice_dummy_var_59: int, out_vslice_dummy_var_60: int, out_vslice_dummy_var_61: int, out_vslice_dummy_var_62: int, out_vslice_dummy_var_63: int, out_vslice_dummy_var_64: int, out_vslice_dummy_var_65: int, out_vslice_dummy_var_66: int, out_vslice_dummy_var_67: int, out_vslice_dummy_var_68: int, out_vslice_dummy_var_69: int, out_vslice_dummy_var_70: int, out_vslice_dummy_var_71: int, out_vslice_dummy_var_72: int)
{
  var vslice_dummy_var_1318: int;
  var vslice_dummy_var_1319: int;
  var vslice_dummy_var_1320: int;
  var vslice_dummy_var_1321: int;
  var vslice_dummy_var_1322: int;
  var vslice_dummy_var_1323: int;
  var vslice_dummy_var_1324: int;
  var vslice_dummy_var_1325: int;
  var vslice_dummy_var_1326: int;
  var vslice_dummy_var_1327: int;
  var vslice_dummy_var_1328: int;
  var vslice_dummy_var_1329: int;
  var vslice_dummy_var_1330: int;
  var vslice_dummy_var_1331: int;
  var vslice_dummy_var_1332: int;
  var vslice_dummy_var_1333: int;
  var vslice_dummy_var_1334: int;
  var vslice_dummy_var_1335: int;
  var vslice_dummy_var_1336: int;
  var vslice_dummy_var_1337: int;
  var vslice_dummy_var_1338: int;
  var vslice_dummy_var_1339: int;

  entry:
    out_majorFunction, out_Tmp_244, out_irpSp, out_irp, out_l, out_Tmp_248, out_tmp, out_vslice_dummy_var_50, out_vslice_dummy_var_51, out_vslice_dummy_var_52, out_vslice_dummy_var_53, out_vslice_dummy_var_54, out_vslice_dummy_var_55, out_vslice_dummy_var_56, out_vslice_dummy_var_57, out_vslice_dummy_var_58, out_vslice_dummy_var_59, out_vslice_dummy_var_60, out_vslice_dummy_var_61, out_vslice_dummy_var_62, out_vslice_dummy_var_63, out_vslice_dummy_var_64, out_vslice_dummy_var_65, out_vslice_dummy_var_66, out_vslice_dummy_var_67, out_vslice_dummy_var_68, out_vslice_dummy_var_69, out_vslice_dummy_var_70, out_vslice_dummy_var_71, out_vslice_dummy_var_72 := in_majorFunction, in_Tmp_244, in_irpSp, in_irp, in_l, in_Tmp_248, in_tmp, in_vslice_dummy_var_50, in_vslice_dummy_var_51, in_vslice_dummy_var_52, in_vslice_dummy_var_53, in_vslice_dummy_var_54, in_vslice_dummy_var_55, in_vslice_dummy_var_56, in_vslice_dummy_var_57, in_vslice_dummy_var_58, in_vslice_dummy_var_59, in_vslice_dummy_var_60, in_vslice_dummy_var_61, in_vslice_dummy_var_62, in_vslice_dummy_var_63, in_vslice_dummy_var_64, in_vslice_dummy_var_65, in_vslice_dummy_var_66, in_vslice_dummy_var_67, in_vslice_dummy_var_68, in_vslice_dummy_var_69, in_vslice_dummy_var_70, in_vslice_dummy_var_71, in_vslice_dummy_var_72;
    goto L75, exit;

  exit:
    return;

  L75:
    goto anon87_Else;

  anon87_Else:
    out_irp := out_l;
    call {:si_unique_call 1575} out_irpSp := IoGetCurrentIrpStackLocation(out_irp);
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc out_majorFunction;
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} out_majorFunction == 4;
    goto L87;

  L87:
    assume {:nonnull} out_l != 0;
    assume out_l > 0;
    havoc out_tmp;
    call {:si_unique_call 1576} out_vslice_dummy_var_50 := RemoveEntryList(out_l);
    out_l := out_tmp;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc out_Tmp_244;
    assume {:nonnull} in_driver != 0;
    assume in_driver > 0;
    havoc out_Tmp_248;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    assume out_Tmp_244 != 27;
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume out_Tmp_244 != 26;
    goto anon98_Then, anon98_Else;

  anon98_Else:
    assume out_Tmp_244 != 25;
    goto anon99_Then, anon99_Else;

  anon99_Else:
    assume out_Tmp_244 != 24;
    goto anon100_Then, anon100_Else;

  anon100_Else:
    assume out_Tmp_244 != 23;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume out_Tmp_244 != 22;
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume out_Tmp_244 != 21;
    goto anon103_Then, anon103_Else;

  anon103_Else:
    assume out_Tmp_244 != 20;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume out_Tmp_244 != 19;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    assume out_Tmp_244 != 18;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume out_Tmp_244 != 17;
    goto anon107_Then, anon107_Else;

  anon107_Else:
    assume out_Tmp_244 != 16;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume out_Tmp_244 != 15;
    goto anon109_Then, anon109_Else;

  anon109_Else:
    assume out_Tmp_244 != 14;
    goto anon110_Then, anon110_Else;

  anon110_Else:
    assume out_Tmp_244 != 13;
    goto anon111_Then, anon111_Else;

  anon111_Else:
    assume out_Tmp_244 != 12;
    goto anon112_Then, anon112_Else;

  anon112_Else:
    assume out_Tmp_244 != 11;
    goto anon113_Then, anon113_Else;

  anon113_Else:
    assume out_Tmp_244 != 10;
    goto anon114_Then, anon114_Else;

  anon114_Else:
    assume out_Tmp_244 != 9;
    goto anon115_Then, anon115_Else;

  anon115_Else:
    assume out_Tmp_244 != 8;
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume out_Tmp_244 != 7;
    goto anon117_Then, anon117_Else;

  anon117_Else:
    assume out_Tmp_244 != 6;
    goto anon118_Then, anon118_Else;

  anon118_Else:
    assume out_Tmp_244 != 5;
    goto anon119_Then, anon119_Else;

  anon119_Else:
    assume out_Tmp_244 != 4;
    goto anon120_Then, anon120_Else;

  anon120_Else:
    assume out_Tmp_244 != 3;
    goto anon121_Then, anon121_Else;

  anon121_Else:
    assume out_Tmp_244 != 2;
    goto anon122_Then, anon122_Else;

  anon122_Else:
    assume out_Tmp_244 != 1;
    goto anon123_Then;

  anon123_Then:
    assume out_Tmp_244 == 0;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1318;
    call {:si_unique_call 1553} out_vslice_dummy_var_72 := VolSnapDefaultDispatch(vslice_dummy_var_1318, out_irp);
    goto L95;

  L95:
    assume {:nonnull} out_l != 0;
    assume out_l > 0;
    havoc out_l;
    goto L95_dummy;

  L95_dummy:
    call {:si_unique_call 1577} {:si_old_unique_call 1} out_majorFunction, out_Tmp_244, out_irpSp, out_irp, out_l, out_Tmp_248, out_tmp, out_vslice_dummy_var_50, out_vslice_dummy_var_51, out_vslice_dummy_var_52, out_vslice_dummy_var_53, out_vslice_dummy_var_54, out_vslice_dummy_var_55, out_vslice_dummy_var_56, out_vslice_dummy_var_57, out_vslice_dummy_var_58, out_vslice_dummy_var_59, out_vslice_dummy_var_60, out_vslice_dummy_var_61, out_vslice_dummy_var_62, out_vslice_dummy_var_63, out_vslice_dummy_var_64, out_vslice_dummy_var_65, out_vslice_dummy_var_66, out_vslice_dummy_var_67, out_vslice_dummy_var_68, out_vslice_dummy_var_69, out_vslice_dummy_var_70, out_vslice_dummy_var_71, out_vslice_dummy_var_72 := sdv_hash_890975460_loop_L75(out_majorFunction, out_Tmp_244, out_irpSp, out_irp, out_l, out_Tmp_248, in_driver, out_tmp, out_vslice_dummy_var_50, out_vslice_dummy_var_51, out_vslice_dummy_var_52, out_vslice_dummy_var_53, out_vslice_dummy_var_54, out_vslice_dummy_var_55, out_vslice_dummy_var_56, out_vslice_dummy_var_57, out_vslice_dummy_var_58, out_vslice_dummy_var_59, out_vslice_dummy_var_60, out_vslice_dummy_var_61, out_vslice_dummy_var_62, out_vslice_dummy_var_63, out_vslice_dummy_var_64, out_vslice_dummy_var_65, out_vslice_dummy_var_66, out_vslice_dummy_var_67, out_vslice_dummy_var_68, out_vslice_dummy_var_69, out_vslice_dummy_var_70, out_vslice_dummy_var_71, out_vslice_dummy_var_72);
    return;

  anon122_Then:
    assume out_Tmp_244 == 1;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1319;
    call {:si_unique_call 1554} out_vslice_dummy_var_71 := VolSnapDefaultDispatch(vslice_dummy_var_1319, out_irp);
    goto L95;

  anon121_Then:
    assume out_Tmp_244 == 2;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1320;
    call {:si_unique_call 1555} out_vslice_dummy_var_70 := VolSnapDefaultDispatch(vslice_dummy_var_1320, out_irp);
    goto L95;

  anon120_Then:
    assume out_Tmp_244 == 3;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    goto L95;

  anon119_Then:
    assume out_Tmp_244 == 4;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    goto L95;

  anon118_Then:
    assume out_Tmp_244 == 5;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1321;
    call {:si_unique_call 1556} out_vslice_dummy_var_69 := VolSnapDefaultDispatch(vslice_dummy_var_1321, out_irp);
    goto L95;

  anon117_Then:
    assume out_Tmp_244 == 6;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1322;
    call {:si_unique_call 1557} out_vslice_dummy_var_68 := VolSnapDefaultDispatch(vslice_dummy_var_1322, out_irp);
    goto L95;

  anon116_Then:
    assume out_Tmp_244 == 7;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1323;
    call {:si_unique_call 1558} out_vslice_dummy_var_67 := VolSnapDefaultDispatch(vslice_dummy_var_1323, out_irp);
    goto L95;

  anon115_Then:
    assume out_Tmp_244 == 8;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1324;
    call {:si_unique_call 1559} out_vslice_dummy_var_66 := VolSnapDefaultDispatch(vslice_dummy_var_1324, out_irp);
    goto L95;

  anon114_Then:
    assume out_Tmp_244 == 9;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1325;
    call {:si_unique_call 1560} out_vslice_dummy_var_65 := VolSnapDefaultDispatch(vslice_dummy_var_1325, out_irp);
    goto L95;

  anon113_Then:
    assume out_Tmp_244 == 10;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1326;
    call {:si_unique_call 1561} out_vslice_dummy_var_64 := VolSnapDefaultDispatch(vslice_dummy_var_1326, out_irp);
    goto L95;

  anon112_Then:
    assume out_Tmp_244 == 11;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1327;
    call {:si_unique_call 1562} out_vslice_dummy_var_63 := VolSnapDefaultDispatch(vslice_dummy_var_1327, out_irp);
    goto L95;

  anon111_Then:
    assume out_Tmp_244 == 12;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1328;
    call {:si_unique_call 1563} out_vslice_dummy_var_62 := VolSnapDefaultDispatch(vslice_dummy_var_1328, out_irp);
    goto L95;

  anon110_Then:
    assume out_Tmp_244 == 13;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1329;
    call {:si_unique_call 1564} out_vslice_dummy_var_61 := VolSnapDefaultDispatch(vslice_dummy_var_1329, out_irp);
    goto L95;

  anon109_Then:
    assume out_Tmp_244 == 14;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    goto L95;

  anon108_Then:
    assume out_Tmp_244 == 15;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1330;
    call {:si_unique_call 1565} out_vslice_dummy_var_60 := VolSnapDefaultDispatch(vslice_dummy_var_1330, out_irp);
    goto L95;

  anon107_Then:
    assume out_Tmp_244 == 16;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1331;
    call {:si_unique_call 1566} out_vslice_dummy_var_59 := VolSnapDefaultDispatch(vslice_dummy_var_1331, out_irp);
    goto L95;

  anon106_Then:
    assume out_Tmp_244 == 17;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1332;
    call {:si_unique_call 1567} out_vslice_dummy_var_58 := VolSnapDefaultDispatch(vslice_dummy_var_1332, out_irp);
    goto L95;

  anon105_Then:
    assume out_Tmp_244 == 18;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    goto L95;

  anon104_Then:
    assume out_Tmp_244 == 19;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1333;
    call {:si_unique_call 1568} out_vslice_dummy_var_57 := VolSnapDefaultDispatch(vslice_dummy_var_1333, out_irp);
    goto L95;

  anon103_Then:
    assume out_Tmp_244 == 20;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1334;
    call {:si_unique_call 1569} out_vslice_dummy_var_56 := VolSnapDefaultDispatch(vslice_dummy_var_1334, out_irp);
    goto L95;

  anon102_Then:
    assume out_Tmp_244 == 21;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1335;
    call {:si_unique_call 1570} out_vslice_dummy_var_55 := VolSnapDefaultDispatch(vslice_dummy_var_1335, out_irp);
    goto L95;

  anon101_Then:
    assume out_Tmp_244 == 22;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    goto L95;

  anon100_Then:
    assume out_Tmp_244 == 23;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1336;
    call {:si_unique_call 1571} out_vslice_dummy_var_54 := VolSnapDefaultDispatch(vslice_dummy_var_1336, out_irp);
    goto L95;

  anon99_Then:
    assume out_Tmp_244 == 24;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1337;
    call {:si_unique_call 1572} out_vslice_dummy_var_53 := VolSnapDefaultDispatch(vslice_dummy_var_1337, out_irp);
    goto L95;

  anon98_Then:
    assume out_Tmp_244 == 25;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1338;
    call {:si_unique_call 1573} out_vslice_dummy_var_52 := VolSnapDefaultDispatch(vslice_dummy_var_1338, out_irp);
    goto L95;

  anon97_Then:
    assume out_Tmp_244 == 26;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    assume {:nonnull} out_irpSp != 0;
    assume out_irpSp > 0;
    havoc vslice_dummy_var_1339;
    call {:si_unique_call 1574} out_vslice_dummy_var_51 := VolSnapDefaultDispatch(vslice_dummy_var_1339, out_irp);
    goto L95;

  anon96_Then:
    assume out_Tmp_244 == 27;
    assume {:nonnull} out_Tmp_248 != 0;
    assume out_Tmp_248 > 0;
    goto L95;

  anon95_Then:
    assume {:partition} out_majorFunction != 4;
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} out_majorFunction != 3;
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} out_majorFunction != 22;
    goto L95;

  anon89_Then:
    assume {:partition} out_majorFunction == 22;
    goto L87;

  anon88_Then:
    assume {:partition} out_majorFunction == 3;
    goto L87;
}



procedure {:LoopProcedure} sdv_hash_890975460_loop_L75(in_majorFunction: int, in_Tmp_244: int, in_irpSp: int, in_irp: int, in_l: int, in_Tmp_248: int, in_driver: int, in_tmp: int, in_vslice_dummy_var_50: int, in_vslice_dummy_var_51: int, in_vslice_dummy_var_52: int, in_vslice_dummy_var_53: int, in_vslice_dummy_var_54: int, in_vslice_dummy_var_55: int, in_vslice_dummy_var_56: int, in_vslice_dummy_var_57: int, in_vslice_dummy_var_58: int, in_vslice_dummy_var_59: int, in_vslice_dummy_var_60: int, in_vslice_dummy_var_61: int, in_vslice_dummy_var_62: int, in_vslice_dummy_var_63: int, in_vslice_dummy_var_64: int, in_vslice_dummy_var_65: int, in_vslice_dummy_var_66: int, in_vslice_dummy_var_67: int, in_vslice_dummy_var_68: int, in_vslice_dummy_var_69: int, in_vslice_dummy_var_70: int, in_vslice_dummy_var_71: int, in_vslice_dummy_var_72: int) returns (out_majorFunction: int, out_Tmp_244: int, out_irpSp: int, out_irp: int, out_l: int, out_Tmp_248: int, out_tmp: int, out_vslice_dummy_var_50: int, out_vslice_dummy_var_51: int, out_vslice_dummy_var_52: int, out_vslice_dummy_var_53: int, out_vslice_dummy_var_54: int, out_vslice_dummy_var_55: int, out_vslice_dummy_var_56: int, out_vslice_dummy_var_57: int, out_vslice_dummy_var_58: int, out_vslice_dummy_var_59: int, out_vslice_dummy_var_60: int, out_vslice_dummy_var_61: int, out_vslice_dummy_var_62: int, out_vslice_dummy_var_63: int, out_vslice_dummy_var_64: int, out_vslice_dummy_var_65: int, out_vslice_dummy_var_66: int, out_vslice_dummy_var_67: int, out_vslice_dummy_var_68: int, out_vslice_dummy_var_69: int, out_vslice_dummy_var_70: int, out_vslice_dummy_var_71: int, out_vslice_dummy_var_72: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation DriverEntry_loop_L263(in_s_p_e_c_i_a_l_1: int, in_Tmp_282: int, in_rootExtension: int) returns (out_Tmp_282: int)
{

  entry:
    out_Tmp_282 := in_Tmp_282;
    goto L263, exit;

  exit:
    return;

  L263:
    assume {:nonnull} in_rootExtension != 0;
    assume in_rootExtension > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_1 != 0;
    assume in_s_p_e_c_i_a_l_1 > 0;
    assume {:nonnull} in_rootExtension != 0;
    assume in_rootExtension > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_1 != 0;
    assume in_s_p_e_c_i_a_l_1 > 0;
    assume {:nonnull} in_rootExtension != 0;
    assume in_rootExtension > 0;
    out_Tmp_282 := LastCheckTickCount__DO_EXTENSION(in_rootExtension);
    assume {:nonnull} out_Tmp_282 != 0;
    assume out_Tmp_282 > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_1 != 0;
    assume in_s_p_e_c_i_a_l_1 > 0;
    goto anon75_Then;

  anon75_Then:
    goto anon75_Then_dummy;

  anon75_Then_dummy:
    call {:si_unique_call 1578} {:si_old_unique_call 1} out_Tmp_282 := DriverEntry_loop_L263(in_s_p_e_c_i_a_l_1, out_Tmp_282, in_rootExtension);
    return;
}



procedure {:LoopProcedure} DriverEntry_loop_L263(in_s_p_e_c_i_a_l_1: int, in_Tmp_282: int, in_rootExtension: int) returns (out_Tmp_282: int);
  free ensures out_Tmp_282 == in_Tmp_282 || out_Tmp_282 == LastCheckTickCount__DO_EXTENSION(in_rootExtension);



implementation {:SIextraRecBound 9} DriverEntry_loop_L69(in_i_1: int, in_Tmp_272: int, in_Tmp_274: int, in_Tmp_275: int, in_Tmp_278: int, in_rootExtension: int, in_Tmp_285: int, in_Tmp_286: int, in_Tmp_294: int, in_Tmp_295: int) returns (out_i_1: int, out_Tmp_272: int, out_Tmp_274: int, out_Tmp_275: int, out_Tmp_278: int, out_Tmp_285: int, out_Tmp_286: int, out_Tmp_294: int, out_Tmp_295: int)
{

  entry:
    out_i_1, out_Tmp_272, out_Tmp_274, out_Tmp_275, out_Tmp_278, out_Tmp_285, out_Tmp_286, out_Tmp_294, out_Tmp_295 := in_i_1, in_Tmp_272, in_Tmp_274, in_Tmp_275, in_Tmp_278, in_Tmp_285, in_Tmp_286, in_Tmp_294, in_Tmp_295;
    goto L69, exit;

  exit:
    return;

  L69:
    assume {:CounterLoop 9} {:Counter "i_1"} true;
    goto anon53_Else;

  anon53_Else:
    assume {:partition} 9 > out_i_1;
    out_Tmp_272 := out_i_1;
    assume {:nonnull} in_rootExtension != 0;
    assume in_rootExtension > 0;
    havoc out_Tmp_278;
    out_Tmp_294 := out_Tmp_278 + out_Tmp_272 * 8;
    call {:si_unique_call 1579} InitializeListHead(out_Tmp_294);
    out_Tmp_295 := out_i_1;
    assume {:nonnull} in_rootExtension != 0;
    assume in_rootExtension > 0;
    havoc out_Tmp_275;
    call {:si_unique_call 1580} KeInitializeSemaphore(0, 0, -1);
    out_Tmp_286 := out_i_1;
    assume {:nonnull} in_rootExtension != 0;
    assume in_rootExtension > 0;
    havoc out_Tmp_274;
    out_Tmp_285 := out_Tmp_274 + out_Tmp_286 * 4;
    call {:si_unique_call 1581} KeInitializeSpinLock(out_Tmp_285);
    out_i_1 := out_i_1 + 1;
    goto anon53_Else_dummy;

  anon53_Else_dummy:
    call {:si_unique_call 1582} {:si_old_unique_call 1} out_i_1, out_Tmp_272, out_Tmp_274, out_Tmp_275, out_Tmp_278, out_Tmp_285, out_Tmp_286, out_Tmp_294, out_Tmp_295 := DriverEntry_loop_L69(out_i_1, out_Tmp_272, out_Tmp_274, out_Tmp_275, out_Tmp_278, in_rootExtension, out_Tmp_285, out_Tmp_286, out_Tmp_294, out_Tmp_295);
    return;
}



procedure {:LoopProcedure} DriverEntry_loop_L69(in_i_1: int, in_Tmp_272: int, in_Tmp_274: int, in_Tmp_275: int, in_Tmp_278: int, in_rootExtension: int, in_Tmp_285: int, in_Tmp_286: int, in_Tmp_294: int, in_Tmp_295: int) returns (out_i_1: int, out_Tmp_272: int, out_Tmp_274: int, out_Tmp_275: int, out_Tmp_278: int, out_Tmp_285: int, out_Tmp_286: int, out_Tmp_294: int, out_Tmp_295: int);
  modifies alloc;



implementation DriverEntry_loop_L27(in_i_1: int, in_Tmp_273: int, in_Tmp_296: int, in_DriverObject_5: int) returns (out_i_1: int, out_Tmp_273: int, out_Tmp_296: int)
{

  entry:
    out_i_1, out_Tmp_273, out_Tmp_296 := in_i_1, in_Tmp_273, in_Tmp_296;
    goto L27, exit;

  exit:
    return;

  L27:
    assume {:CounterLoop 27} {:Counter "i_1"} true;
    goto anon51_Else;

  anon51_Else:
    assume {:partition} 27 >= out_i_1;
    out_Tmp_296 := out_i_1;
    assume {:nonnull} in_DriverObject_5 != 0;
    assume in_DriverObject_5 > 0;
    havoc out_Tmp_273;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume out_Tmp_296 <= 2;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume out_Tmp_296 != 2;
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume out_Tmp_296 != 1;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume out_Tmp_296 != 0;
    goto L298;

  L298:
    out_i_1 := out_i_1 + 1;
    goto L298_dummy;

  L298_dummy:
    havoc out_i_1;
    return;

  anon73_Then:
    assume out_Tmp_296 == 0;
    out_Tmp_296 := 0;
    assume {:nonnull} out_Tmp_273 != 0;
    assume out_Tmp_273 > 0;
    goto L298;

  anon72_Then:
    assume out_Tmp_296 == 1;
    out_Tmp_296 := 1;
    assume {:nonnull} out_Tmp_273 != 0;
    assume out_Tmp_273 > 0;
    goto L298;

  anon71_Then:
    assume out_Tmp_296 == 2;
    out_Tmp_296 := 2;
    assume {:nonnull} out_Tmp_273 != 0;
    assume out_Tmp_273 > 0;
    goto L298;

  anon70_Then:
    assume out_Tmp_296 > 2;
    assume {:nonnull} out_Tmp_273 != 0;
    assume out_Tmp_273 > 0;
    goto L298;
}



procedure {:LoopProcedure} DriverEntry_loop_L27(in_i_1: int, in_Tmp_273: int, in_Tmp_296: int, in_DriverObject_5: int) returns (out_i_1: int, out_Tmp_273: int, out_Tmp_296: int);
  free ensures out_Tmp_296 == 0 || out_Tmp_296 == 1 || out_Tmp_296 == 2 || out_Tmp_296 == in_i_1 || out_Tmp_296 == in_Tmp_296;



implementation sdv_hash_1035268778_loop_L60(in_sdv_227: int, in_l_2: int, in_extension_1: int, in_Filter_6: int) returns (out_sdv_227: int, out_l_2: int, out_extension_1: int)
{

  entry:
    out_sdv_227, out_l_2, out_extension_1 := in_sdv_227, in_l_2, in_extension_1;
    goto L60, exit;

  exit:
    return;

  L60:
    assume {:nonnull} in_Filter_6 != 0;
    assume in_Filter_6 > 0;
    call {:si_unique_call 1583} out_sdv_227 := IsListEmpty(DeadVolumeList_FILTER_EXTENSION(in_Filter_6));
    goto anon58_Then;

  anon58_Then:
    assume {:partition} out_sdv_227 == 0;
    assume {:nonnull} in_Filter_6 != 0;
    assume in_Filter_6 > 0;
    call {:si_unique_call 1584} out_l_2 := RemoveHeadList(DeadVolumeList_FILTER_EXTENSION(in_Filter_6));
    out_extension_1 := out_l_2;
    goto anon58_Then_dummy;

  anon58_Then_dummy:
    call {:si_unique_call 1585} {:si_old_unique_call 1} out_sdv_227, out_l_2, out_extension_1 := sdv_hash_1035268778_loop_L60(out_sdv_227, out_l_2, out_extension_1, in_Filter_6);
    return;
}



procedure {:LoopProcedure} sdv_hash_1035268778_loop_L60(in_sdv_227: int, in_l_2: int, in_extension_1: int, in_Filter_6: int) returns (out_sdv_227: int, out_l_2: int, out_extension_1: int);



implementation sdv_hash_1035268778_loop_L42(in_i_2: int, in_Tmp_367: int, in_Tmp_372: int, in_newRelations: int, in_numVolumes: int, in_l_2: int, in_extension_1: int, in_Tmp_381: int, in_vslice_dummy_var_163: int) returns (out_Tmp_367: int, out_Tmp_372: int, out_numVolumes: int, out_l_2: int, out_extension_1: int, out_Tmp_381: int, out_vslice_dummy_var_163: int)
{

  entry:
    out_Tmp_367, out_Tmp_372, out_numVolumes, out_l_2, out_extension_1, out_Tmp_381, out_vslice_dummy_var_163 := in_Tmp_367, in_Tmp_372, in_numVolumes, in_l_2, in_extension_1, in_Tmp_381, in_vslice_dummy_var_163;
    goto L42, exit;

  exit:
    return;

  L42:
    goto anon54_Else;

  anon54_Else:
    out_extension_1 := out_l_2;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:nonnull} out_extension_1 != 0;
    assume out_extension_1 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:nonnull} out_extension_1 != 0;
    assume out_extension_1 > 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    goto L50;

  L50:
    assume {:nonnull} out_l_2 != 0;
    assume out_l_2 > 0;
    havoc out_l_2;
    goto L50_dummy;

  L50_dummy:
    call {:si_unique_call 1587} {:si_old_unique_call 1} out_Tmp_367, out_Tmp_372, out_numVolumes, out_l_2, out_extension_1, out_Tmp_381, out_vslice_dummy_var_163 := sdv_hash_1035268778_loop_L42(in_i_2, out_Tmp_367, out_Tmp_372, in_newRelations, out_numVolumes, out_l_2, out_extension_1, out_Tmp_381, out_vslice_dummy_var_163);
    return;

  anon57_Then:
    goto L46;

  L46:
    out_Tmp_372 := out_numVolumes;
    out_numVolumes := out_numVolumes + 1;
    out_Tmp_367 := in_i_2 + out_Tmp_372;
    assume {:nonnull} in_newRelations != 0;
    assume in_newRelations > 0;
    havoc out_Tmp_381;
    assume {:nonnull} out_Tmp_381 != 0;
    assume out_Tmp_381 > 0;
    assume {:nonnull} out_extension_1 != 0;
    assume out_extension_1 > 0;
    assume {:nonnull} out_extension_1 != 0;
    assume out_extension_1 > 0;
    call {:si_unique_call 1586} out_vslice_dummy_var_163 := ObfReferenceObject(0);
    goto L50;

  anon56_Then:
    goto L46;

  anon67_Then:
    goto L46;
}



procedure {:LoopProcedure} sdv_hash_1035268778_loop_L42(in_i_2: int, in_Tmp_367: int, in_Tmp_372: int, in_newRelations: int, in_numVolumes: int, in_l_2: int, in_extension_1: int, in_Tmp_381: int, in_vslice_dummy_var_163: int) returns (out_Tmp_367: int, out_Tmp_372: int, out_numVolumes: int, out_l_2: int, out_extension_1: int, out_Tmp_381: int, out_vslice_dummy_var_163: int);
  modifies ref;



implementation sdv_hash_1035268778_loop_L77(in_i_2: int, in_deviceRelations: int, in_Tmp_376: int, in_Tmp_379: int, in_vslice_dummy_var_162: int) returns (out_i_2: int, out_Tmp_376: int, out_Tmp_379: int, out_vslice_dummy_var_162: int)
{

  entry:
    out_i_2, out_Tmp_376, out_Tmp_379, out_vslice_dummy_var_162 := in_i_2, in_Tmp_376, in_Tmp_379, in_vslice_dummy_var_162;
    goto L77, exit;

  exit:
    return;

  L77:
    assume {:nonnull} in_deviceRelations != 0;
    assume in_deviceRelations > 0;
    goto anon59_Else;

  anon59_Else:
    out_Tmp_376 := out_i_2;
    assume {:nonnull} in_deviceRelations != 0;
    assume in_deviceRelations > 0;
    havoc out_Tmp_379;
    assume {:nonnull} out_Tmp_379 != 0;
    assume out_Tmp_379 > 0;
    call {:si_unique_call 1588} out_vslice_dummy_var_162 := ObfDereferenceObject(0);
    out_i_2 := out_i_2 + 1;
    goto anon59_Else_dummy;

  anon59_Else_dummy:
    havoc out_i_2;
    return;
}



procedure {:LoopProcedure} sdv_hash_1035268778_loop_L77(in_i_2: int, in_deviceRelations: int, in_Tmp_376: int, in_Tmp_379: int, in_vslice_dummy_var_162: int) returns (out_i_2: int, out_Tmp_376: int, out_Tmp_379: int, out_vslice_dummy_var_162: int);
  free ensures out_Tmp_376 == in_i_2 || out_Tmp_376 == in_Tmp_376;



implementation sdv_hash_1035268778_loop_L108(in_sdv_218: int, in_l_2: int, in_extension_1: int, in_Filter_6: int) returns (out_sdv_218: int, out_l_2: int, out_extension_1: int)
{

  entry:
    out_sdv_218, out_l_2, out_extension_1 := in_sdv_218, in_l_2, in_extension_1;
    goto L108, exit;

  exit:
    return;

  L108:
    assume {:nonnull} in_Filter_6 != 0;
    assume in_Filter_6 > 0;
    call {:si_unique_call 1589} out_sdv_218 := IsListEmpty(DeadVolumeList_FILTER_EXTENSION(in_Filter_6));
    goto anon60_Then;

  anon60_Then:
    assume {:partition} out_sdv_218 == 0;
    assume {:nonnull} in_Filter_6 != 0;
    assume in_Filter_6 > 0;
    call {:si_unique_call 1590} out_l_2 := RemoveHeadList(DeadVolumeList_FILTER_EXTENSION(in_Filter_6));
    out_extension_1 := out_l_2;
    goto anon60_Then_dummy;

  anon60_Then_dummy:
    call {:si_unique_call 1591} {:si_old_unique_call 1} out_sdv_218, out_l_2, out_extension_1 := sdv_hash_1035268778_loop_L108(out_sdv_218, out_l_2, out_extension_1, in_Filter_6);
    return;
}



procedure {:LoopProcedure} sdv_hash_1035268778_loop_L108(in_sdv_218: int, in_l_2: int, in_extension_1: int, in_Filter_6: int) returns (out_sdv_218: int, out_l_2: int, out_extension_1: int);



implementation sdv_hash_1035268778_loop_L122(in_numVolumes: int, in_l_2: int, in_extension_1: int) returns (out_numVolumes: int, out_l_2: int, out_extension_1: int)
{

  entry:
    out_numVolumes, out_l_2, out_extension_1 := in_numVolumes, in_l_2, in_extension_1;
    goto L122, exit;

  exit:
    return;

  L122:
    goto anon61_Else;

  anon61_Else:
    out_extension_1 := out_l_2;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    goto L133;

  L133:
    out_numVolumes := out_numVolumes + 1;
    goto L132;

  L132:
    assume {:nonnull} out_l_2 != 0;
    assume out_l_2 > 0;
    havoc out_l_2;
    goto L132_dummy;

  L132_dummy:
    call {:si_unique_call 1592} {:si_old_unique_call 1} out_numVolumes, out_l_2, out_extension_1 := sdv_hash_1035268778_loop_L122(out_numVolumes, out_l_2, out_extension_1);
    return;

  anon71_Then:
    assume {:nonnull} out_extension_1 != 0;
    assume out_extension_1 > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    goto L133;

  anon63_Then:
    assume {:nonnull} out_extension_1 != 0;
    assume out_extension_1 > 0;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    goto L133;

  anon64_Then:
    goto L132;
}



procedure {:LoopProcedure} sdv_hash_1035268778_loop_L122(in_numVolumes: int, in_l_2: int, in_extension_1: int) returns (out_numVolumes: int, out_l_2: int, out_extension_1: int);



implementation sdv_hash_601969222_loop_L47(in_filter_5: int, in_sdv_241: int, in_l_3: int) returns (out_sdv_241: int, out_l_3: int)
{

  entry:
    out_sdv_241, out_l_3 := in_sdv_241, in_l_3;
    goto L47, exit;

  exit:
    return;

  L47:
    assume {:nonnull} in_filter_5 != 0;
    assume in_filter_5 > 0;
    call {:si_unique_call 1593} out_sdv_241 := IsListEmpty(CopyOnWriteList_FILTER_EXTENSION(in_filter_5));
    goto anon9_Then;

  anon9_Then:
    assume {:partition} out_sdv_241 == 0;
    assume {:nonnull} in_filter_5 != 0;
    assume in_filter_5 > 0;
    call {:si_unique_call 1594} out_l_3 := RemoveHeadList(CopyOnWriteList_FILTER_EXTENSION(in_filter_5));
    call {:si_unique_call 1595} ExFreePoolWithTag(0, 0);
    call {:si_unique_call 1596} ExFreePoolWithTag(0, 0);
    goto anon9_Then_dummy;

  anon9_Then_dummy:
    call {:si_unique_call 1597} {:si_old_unique_call 1} out_sdv_241, out_l_3 := sdv_hash_601969222_loop_L47(in_filter_5, out_sdv_241, out_l_3);
    return;
}



procedure {:LoopProcedure} sdv_hash_601969222_loop_L47(in_filter_5: int, in_sdv_241: int, in_l_3: int) returns (out_sdv_241: int, out_l_3: int);
  modifies alloc;



implementation sdv_hash_403736888_loop_L48(in_i_3: int, in_Tmp_442: int, in_Tmp_454: int, in_Tmp_455: int, in_Tmp_463: int, in_Filter_10: int) returns (out_i_3: int, out_Tmp_442: int, out_Tmp_454: int, out_Tmp_455: int, out_Tmp_463: int)
{

  entry:
    out_i_3, out_Tmp_442, out_Tmp_454, out_Tmp_455, out_Tmp_463 := in_i_3, in_Tmp_442, in_Tmp_454, in_Tmp_455, in_Tmp_463;
    goto L48, exit;

  exit:
    return;

  L48:
    assume {:CounterLoop 25} {:Counter "i_3"} true;
    goto anon52_Else;

  anon52_Else:
    assume {:partition} 25 > out_i_3;
    out_Tmp_442 := out_i_3;
    assume {:nonnull} in_Filter_10 != 0;
    assume in_Filter_10 > 0;
    havoc out_Tmp_454;
    out_Tmp_463 := out_i_3;
    assume {:nonnull} in_Filter_10 != 0;
    assume in_Filter_10 > 0;
    havoc out_Tmp_455;
    assume {:nonnull} out_Tmp_454 != 0;
    assume out_Tmp_454 > 0;
    assume {:nonnull} out_Tmp_455 != 0;
    assume out_Tmp_455 > 0;
    out_i_3 := out_i_3 + 1;
    goto anon52_Else_dummy;

  anon52_Else_dummy:
    havoc out_i_3;
    return;
}



procedure {:LoopProcedure} sdv_hash_403736888_loop_L48(in_i_3: int, in_Tmp_442: int, in_Tmp_454: int, in_Tmp_455: int, in_Tmp_463: int, in_Filter_10: int) returns (out_i_3: int, out_Tmp_442: int, out_Tmp_454: int, out_Tmp_455: int, out_Tmp_463: int);
  free ensures out_Tmp_442 == in_i_3 || out_Tmp_442 == in_Tmp_442;
  free ensures out_Tmp_463 == in_i_3 || out_Tmp_463 == in_Tmp_463;



implementation sdv_hash_403736888_loop_L26(in_tick: int, in_s_p_e_c_i_a_l_2: int)
{

  entry:
    goto L26, exit;

  exit:
    return;

  L26:
    assume {:nonnull} in_s_p_e_c_i_a_l_2 != 0;
    assume in_s_p_e_c_i_a_l_2 > 0;
    assume {:nonnull} in_tick != 0;
    assume in_tick > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_2 != 0;
    assume in_s_p_e_c_i_a_l_2 > 0;
    assume {:nonnull} in_tick != 0;
    assume in_tick > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_2 != 0;
    assume in_s_p_e_c_i_a_l_2 > 0;
    assume {:nonnull} in_tick != 0;
    assume in_tick > 0;
    goto anon65_Then;

  anon65_Then:
    goto anon65_Then_dummy;

  anon65_Then_dummy:
    call {:si_unique_call 1598} {:si_old_unique_call 1} sdv_hash_403736888_loop_L26(in_tick, in_s_p_e_c_i_a_l_2);
    return;
}



procedure {:LoopProcedure} sdv_hash_403736888_loop_L26(in_tick: int, in_s_p_e_c_i_a_l_2: int);



implementation sdv_hash_853253100_loop_L47(in_workItem: int, in_context_4: int, in_sdv_263: int, in_l_4: int, in_q_1: int, in_e: int) returns (out_workItem: int, out_context_4: int, out_sdv_263: int, out_l_4: int, out_e: int)
{

  entry:
    out_workItem, out_context_4, out_sdv_263, out_l_4, out_e := in_workItem, in_context_4, in_sdv_263, in_l_4, in_e;
    goto L47, exit;

  exit:
    return;

  L47:
    call {:si_unique_call 1599} out_l_4 := RemoveHeadList(in_q_1);
    out_workItem := out_l_4;
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    havoc out_context_4;
    assume {:nonnull} out_context_4 != 0;
    assume out_context_4 > 0;
    havoc out_e;
    assume {:nonnull} out_e != 0;
    assume out_e > 0;
    goto anon43_Then;

  anon43_Then:
    goto L58;

  L58:
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    call {:si_unique_call 1600} out_sdv_263 := IsListEmpty(in_q_1);
    goto anon34_Then;

  anon34_Then:
    assume {:partition} out_sdv_263 == 0;
    goto anon34_Then_dummy;

  anon34_Then_dummy:
    call {:si_unique_call 1601} {:si_old_unique_call 1} out_workItem, out_context_4, out_sdv_263, out_l_4, out_e := sdv_hash_853253100_loop_L47(out_workItem, out_context_4, out_sdv_263, out_l_4, in_q_1, out_e);
    return;

  anon42_Then:
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    goto anon38_Then;

  anon38_Then:
    goto L58;

  anon33_Then:
    goto L58;
}



procedure {:LoopProcedure} sdv_hash_853253100_loop_L47(in_workItem: int, in_context_4: int, in_sdv_263: int, in_l_4: int, in_q_1: int, in_e: int) returns (out_workItem: int, out_context_4: int, out_sdv_263: int, out_l_4: int, out_e: int);



implementation sdv_hash_853253100_loop_L17(in_workItem: int, in_context_4: int, in_sdv_261: int, in_filter_6: int, in_sdv_263: int, in_l_4: int, in_q_1: int, in_irql_11: int, in_e: int) returns (out_workItem: int, out_context_4: int, out_sdv_261: int, out_sdv_263: int, out_l_4: int, out_irql_11: int, out_e: int)
{

  entry:
    out_workItem, out_context_4, out_sdv_261, out_sdv_263, out_l_4, out_irql_11, out_e := in_workItem, in_context_4, in_sdv_261, in_sdv_263, in_l_4, in_irql_11, in_e;
    goto L17, exit;

  exit:
    return;

  L17:
    call {:si_unique_call 1602} out_irql_11 := KfAcquireSpinLock(0);
    assume {:nonnull} in_filter_6 != 0;
    assume in_filter_6 > 0;
    call {:si_unique_call 1603} out_sdv_261 := IsListEmpty(PagedResourceList_FILTER_EXTENSION(in_filter_6));
    goto anon31_Then;

  anon31_Then:
    assume {:partition} out_sdv_261 == 0;
    assume {:nonnull} in_filter_6 != 0;
    assume in_filter_6 > 0;
    goto anon32_Else;

  anon32_Else:
    assume {:nonnull} in_filter_6 != 0;
    assume in_filter_6 > 0;
    assume {:nonnull} in_q_1 != 0;
    assume in_q_1 > 0;
    assume {:nonnull} in_filter_6 != 0;
    assume in_filter_6 > 0;
    assume {:nonnull} in_q_1 != 0;
    assume in_q_1 > 0;
    assume {:nonnull} in_filter_6 != 0;
    assume in_filter_6 > 0;
    call {:si_unique_call 1606} InitializeListHead(PagedResourceList_FILTER_EXTENSION(in_filter_6));
    call {:si_unique_call 1607} KfReleaseSpinLock(0, out_irql_11);
    assume {:nonnull} in_q_1 != 0;
    assume in_q_1 > 0;
    assume {:nonnull} in_q_1 != 0;
    assume in_q_1 > 0;
    assume {:nonnull} in_filter_6 != 0;
    assume in_filter_6 > 0;
    goto L47;

  L47:
    call {:si_unique_call 1604} out_workItem, out_context_4, out_sdv_263, out_l_4, out_e := sdv_hash_853253100_loop_L47(out_workItem, out_context_4, out_sdv_263, out_l_4, in_q_1, out_e);
    goto L47_last;

  L47_last:
    call {:si_unique_call 1605} out_l_4 := RemoveHeadList(in_q_1);
    out_workItem := out_l_4;
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    havoc out_context_4;
    assume {:nonnull} out_context_4 != 0;
    assume out_context_4 > 0;
    havoc out_e;
    assume {:nonnull} out_e != 0;
    assume out_e > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    goto L67;

  L67:
    assume {:nonnull} in_filter_6 != 0;
    assume in_filter_6 > 0;
    goto anon44_Then;

  anon44_Then:
    assume {:partition} out_workItem == 0;
    goto anon44_Then_dummy;

  anon44_Then_dummy:
    call {:si_unique_call 1609} {:si_old_unique_call 1} out_workItem, out_context_4, out_sdv_261, out_sdv_263, out_l_4, out_irql_11, out_e := sdv_hash_853253100_loop_L17(out_workItem, out_context_4, out_sdv_261, in_filter_6, out_sdv_263, out_l_4, in_q_1, out_irql_11, out_e);
    return;

  anon43_Then:
    goto L58;

  L58:
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    call {:si_unique_call 1608} out_sdv_263 := IsListEmpty(in_q_1);
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} out_sdv_263 != 0;
    out_workItem := 0;
    goto L67;

  anon34_Then:
    assume {:partition} out_sdv_263 == 0;
    assume false;
    return;

  anon42_Then:
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:nonnull} out_workItem != 0;
    assume out_workItem > 0;
    goto anon38_Then, anon38_Else;

  anon38_Else:
    goto L67;

  anon38_Then:
    goto L58;

  anon33_Then:
    goto L58;
}



procedure {:LoopProcedure} sdv_hash_853253100_loop_L17(in_workItem: int, in_context_4: int, in_sdv_261: int, in_filter_6: int, in_sdv_263: int, in_l_4: int, in_q_1: int, in_irql_11: int, in_e: int) returns (out_workItem: int, out_context_4: int, out_sdv_261: int, out_sdv_263: int, out_l_4: int, out_irql_11: int, out_e: int);
  modifies alloc;



implementation sdv_hash_1005562481_loop_L39(in_controlItem: int, in_controlBlock: int, in_needWrite: int, in_sdv_288: int, in_itemsLeft: int, in_offset: int, in_Filter_13: int, in_SnapshotGuid: int) returns (out_controlItem: int, out_needWrite: int, out_sdv_288: int, out_itemsLeft: int, out_offset: int)
{

  entry:
    out_controlItem, out_needWrite, out_sdv_288, out_itemsLeft, out_offset := in_controlItem, in_needWrite, in_sdv_288, in_itemsLeft, in_offset;
    goto L39, exit;

  exit:
    return;

  L39:
    goto anon61_Else;

  anon61_Else:
    assume {:partition} 16384 > out_offset;
    out_controlItem := in_controlBlock;
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    goto anon80_Else;

  anon80_Else:
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} in_SnapshotGuid != 0;
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    call {:si_unique_call 1612} out_sdv_288 := IsEqualGUID(SnapshotGuid__VSP_CONTROL_ITEM_SNAPSHOT(out_controlItem), in_SnapshotGuid);
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} out_sdv_288 != 0;
    call {:si_unique_call 1610} sdv_hash_194037626(in_Filter_13, out_controlItem);
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    out_needWrite := 1;
    goto L45;

  L45:
    out_offset := out_offset + 128;
    goto L45_dummy;

  L45_dummy:
    call {:si_unique_call 1613} {:si_old_unique_call 1} out_controlItem, out_needWrite, out_sdv_288, out_itemsLeft, out_offset := sdv_hash_1005562481_loop_L39(out_controlItem, in_controlBlock, out_needWrite, out_sdv_288, out_itemsLeft, out_offset, in_Filter_13, in_SnapshotGuid);
    return;

  anon66_Then:
    assume {:partition} out_sdv_288 == 0;
    out_itemsLeft := 1;
    goto L45;

  anon64_Then:
    assume {:partition} in_SnapshotGuid == 0;
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    call {:si_unique_call 1611} sdv_hash_194037626(in_Filter_13, out_controlItem);
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    out_needWrite := 1;
    goto L45;

  anon65_Then:
    out_itemsLeft := 1;
    goto L45;

  anon63_Then:
    goto L45;
}



procedure {:LoopProcedure} sdv_hash_1005562481_loop_L39(in_controlItem: int, in_controlBlock: int, in_needWrite: int, in_sdv_288: int, in_itemsLeft: int, in_offset: int, in_Filter_13: int, in_SnapshotGuid: int) returns (out_controlItem: int, out_needWrite: int, out_sdv_288: int, out_itemsLeft: int, out_offset: int);
  modifies alloc;
  free ensures out_controlItem == in_controlItem || out_controlItem == in_controlBlock;
  free ensures out_needWrite == 1 || out_needWrite == in_needWrite;
  free ensures out_sdv_288 == 0 || out_sdv_288 == 1 || out_sdv_288 == in_sdv_288;
  free ensures out_itemsLeft == 1 || out_itemsLeft == in_itemsLeft;



implementation sdv_hash_1005562481_loop_L28(in_controlItem: int, in_sdv_281: int, in_controlBlock: int, in_needWrite: int, in_sdv_283: int, in_byteOffset: int, in_sdv_288: int, in_status_15: int, in_itemsLeft: int, in_offset: int, in_Filter_13: int, in_SnapshotGuid: int) returns (out_controlItem: int, out_sdv_281: int, out_needWrite: int, out_sdv_283: int, out_byteOffset: int, out_sdv_288: int, out_status_15: int, out_itemsLeft: int, out_offset: int)
{
  var vslice_dummy_var_1340: int;
  var vslice_dummy_var_1341: int;

  entry:
    out_controlItem, out_sdv_281, out_needWrite, out_sdv_283, out_byteOffset, out_sdv_288, out_status_15, out_itemsLeft, out_offset := in_controlItem, in_sdv_281, in_needWrite, in_sdv_283, in_byteOffset, in_sdv_288, in_status_15, in_itemsLeft, in_offset;
    goto L28, exit;

  exit:
    return;

  L28:
    call {:si_unique_call 1614} out_sdv_281 := sdv_hash_317697039(in_Filter_13);
    assume {:nonnull} in_Filter_13 != 0;
    assume in_Filter_13 > 0;
    havoc vslice_dummy_var_1340;
    call {:si_unique_call 1615} out_status_15 := sdv_hash_984605889(in_Filter_13, vslice_dummy_var_1340, out_byteOffset, -699198463, out_sdv_281);
    goto anon59_Else;

  anon59_Else:
    assume {:partition} out_status_15 >= 0;
    out_needWrite := 0;
    out_offset := 128;
    goto L39;

  L39:
    call {:si_unique_call 1616} out_controlItem, out_needWrite, out_sdv_288, out_itemsLeft, out_offset := sdv_hash_1005562481_loop_L39(out_controlItem, in_controlBlock, out_needWrite, out_sdv_288, out_itemsLeft, out_offset, in_Filter_13, in_SnapshotGuid);
    goto L39_last;

  L39_last:
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} 16384 > out_offset;
    out_controlItem := in_controlBlock;
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} in_SnapshotGuid != 0;
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    call {:si_unique_call 1619} out_sdv_288 := IsEqualGUID(SnapshotGuid__VSP_CONTROL_ITEM_SNAPSHOT(out_controlItem), in_SnapshotGuid);
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} out_sdv_288 != 0;
    call {:si_unique_call 1617} sdv_hash_194037626(in_Filter_13, out_controlItem);
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    out_needWrite := 1;
    goto L45;

  L45:
    out_offset := out_offset + 128;
    assume false;
    return;

  anon66_Then:
    assume {:partition} out_sdv_288 == 0;
    out_itemsLeft := 1;
    goto L45;

  anon64_Then:
    assume {:partition} in_SnapshotGuid == 0;
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    call {:si_unique_call 1618} sdv_hash_194037626(in_Filter_13, out_controlItem);
    assume {:nonnull} out_controlItem != 0;
    assume out_controlItem > 0;
    out_needWrite := 1;
    goto L45;

  anon65_Then:
    out_itemsLeft := 1;
    goto L45;

  anon63_Then:
    goto L45;

  anon80_Then:
    goto L40;

  L40:
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} out_needWrite != 0;
    call {:si_unique_call 1620} out_sdv_283 := sdv_hash_317697039(in_Filter_13);
    assume {:nonnull} in_Filter_13 != 0;
    assume in_Filter_13 > 0;
    havoc vslice_dummy_var_1341;
    call {:si_unique_call 1621} out_status_15 := sdv_hash_916928578(in_Filter_13, vslice_dummy_var_1341, out_byteOffset, -699198462, out_sdv_283);
    goto anon68_Then;

  anon68_Then:
    assume {:partition} 0 <= out_status_15;
    goto L70;

  L70:
    assume {:nonnull} in_controlBlock != 0;
    assume in_controlBlock > 0;
    goto anon67_Then;

  anon67_Then:
    assume {:nonnull} in_controlBlock != 0;
    assume in_controlBlock > 0;
    havoc out_byteOffset;
    goto anon67_Then_dummy;

  anon67_Then_dummy:
    call {:si_unique_call 1622} {:si_old_unique_call 1} out_controlItem, out_sdv_281, out_needWrite, out_sdv_283, out_byteOffset, out_sdv_288, out_status_15, out_itemsLeft, out_offset := sdv_hash_1005562481_loop_L28(out_controlItem, out_sdv_281, in_controlBlock, out_needWrite, out_sdv_283, out_byteOffset, out_sdv_288, out_status_15, out_itemsLeft, out_offset, in_Filter_13, in_SnapshotGuid);
    return;

  anon62_Then:
    assume {:partition} out_needWrite == 0;
    goto L70;

  anon61_Then:
    assume {:partition} out_offset >= 16384;
    goto L40;
}



procedure {:LoopProcedure} sdv_hash_1005562481_loop_L28(in_controlItem: int, in_sdv_281: int, in_controlBlock: int, in_needWrite: int, in_sdv_283: int, in_byteOffset: int, in_sdv_288: int, in_status_15: int, in_itemsLeft: int, in_offset: int, in_Filter_13: int, in_SnapshotGuid: int) returns (out_controlItem: int, out_sdv_281: int, out_needWrite: int, out_sdv_283: int, out_byteOffset: int, out_sdv_288: int, out_status_15: int, out_itemsLeft: int, out_offset: int);
  modifies alloc, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK;
  free ensures out_controlItem == in_controlItem || out_controlItem == in_controlBlock;
  free ensures out_needWrite == 1 || out_needWrite == 0 || out_needWrite == in_needWrite;
  free ensures out_sdv_288 == 0 || out_sdv_288 == 1 || out_sdv_288 == in_sdv_288;
  free ensures out_itemsLeft == 1 || out_itemsLeft == in_itemsLeft;



implementation sdv_hash_899948027_loop_L17(in_i_4: int, in_Tmp_488: int, in_Tmp_490: int, in_RootExtension_6: int, in_vslice_dummy_var_203: int) returns (out_i_4: int, out_Tmp_488: int, out_Tmp_490: int, out_vslice_dummy_var_203: int)
{

  entry:
    out_i_4, out_Tmp_488, out_Tmp_490, out_vslice_dummy_var_203 := in_i_4, in_Tmp_488, in_Tmp_490, in_vslice_dummy_var_203;
    goto L17, exit;

  exit:
    return;

  L17:
    assume {:CounterLoop 9} {:Counter "i_4"} true;
    goto anon7_Else;

  anon7_Else:
    assume {:partition} 9 > out_i_4;
    out_Tmp_490 := out_i_4;
    assume {:nonnull} in_RootExtension_6 != 0;
    assume in_RootExtension_6 > 0;
    havoc out_Tmp_488;
    call {:si_unique_call 1623} out_vslice_dummy_var_203 := KeReleaseSemaphore(0, 0, 1, 0);
    out_i_4 := out_i_4 + 1;
    goto anon7_Else_dummy;

  anon7_Else_dummy:
    havoc out_i_4;
    return;
}



procedure {:LoopProcedure} sdv_hash_899948027_loop_L17(in_i_4: int, in_Tmp_488: int, in_Tmp_490: int, in_RootExtension_6: int, in_vslice_dummy_var_203: int) returns (out_i_4: int, out_Tmp_488: int, out_Tmp_490: int, out_vslice_dummy_var_203: int);
  free ensures out_Tmp_490 == in_i_4 || out_Tmp_490 == in_Tmp_490;



implementation sdv_hash_588722555_loop_L6(in_irpSp_3: int, in_Tmp_495: int, in_sdv_305: int, in_irp_4: int, in_l_5: int, in_Tmp_498: int, in_DriverObject_7: int, in_IrpQueue: int, in_vslice_dummy_var_205: int, in_vslice_dummy_var_206: int, in_vslice_dummy_var_207: int, in_vslice_dummy_var_208: int, in_vslice_dummy_var_209: int, in_vslice_dummy_var_210: int, in_vslice_dummy_var_211: int, in_vslice_dummy_var_212: int, in_vslice_dummy_var_213: int, in_vslice_dummy_var_214: int, in_vslice_dummy_var_215: int, in_vslice_dummy_var_216: int, in_vslice_dummy_var_217: int, in_vslice_dummy_var_218: int, in_vslice_dummy_var_219: int, in_vslice_dummy_var_220: int, in_vslice_dummy_var_221: int, in_vslice_dummy_var_222: int, in_vslice_dummy_var_223: int, in_vslice_dummy_var_224: int, in_vslice_dummy_var_225: int, in_vslice_dummy_var_226: int) returns (out_irpSp_3: int, out_Tmp_495: int, out_sdv_305: int, out_irp_4: int, out_l_5: int, out_Tmp_498: int, out_vslice_dummy_var_205: int, out_vslice_dummy_var_206: int, out_vslice_dummy_var_207: int, out_vslice_dummy_var_208: int, out_vslice_dummy_var_209: int, out_vslice_dummy_var_210: int, out_vslice_dummy_var_211: int, out_vslice_dummy_var_212: int, out_vslice_dummy_var_213: int, out_vslice_dummy_var_214: int, out_vslice_dummy_var_215: int, out_vslice_dummy_var_216: int, out_vslice_dummy_var_217: int, out_vslice_dummy_var_218: int, out_vslice_dummy_var_219: int, out_vslice_dummy_var_220: int, out_vslice_dummy_var_221: int, out_vslice_dummy_var_222: int, out_vslice_dummy_var_223: int, out_vslice_dummy_var_224: int, out_vslice_dummy_var_225: int, out_vslice_dummy_var_226: int)
{
  var vslice_dummy_var_1342: int;
  var vslice_dummy_var_1343: int;
  var vslice_dummy_var_1344: int;
  var vslice_dummy_var_1345: int;
  var vslice_dummy_var_1346: int;
  var vslice_dummy_var_1347: int;
  var vslice_dummy_var_1348: int;
  var vslice_dummy_var_1349: int;
  var vslice_dummy_var_1350: int;
  var vslice_dummy_var_1351: int;
  var vslice_dummy_var_1352: int;
  var vslice_dummy_var_1353: int;
  var vslice_dummy_var_1354: int;
  var vslice_dummy_var_1355: int;
  var vslice_dummy_var_1356: int;
  var vslice_dummy_var_1357: int;
  var vslice_dummy_var_1358: int;
  var vslice_dummy_var_1359: int;
  var vslice_dummy_var_1360: int;
  var vslice_dummy_var_1361: int;
  var vslice_dummy_var_1362: int;
  var vslice_dummy_var_1363: int;

  entry:
    out_irpSp_3, out_Tmp_495, out_sdv_305, out_irp_4, out_l_5, out_Tmp_498, out_vslice_dummy_var_205, out_vslice_dummy_var_206, out_vslice_dummy_var_207, out_vslice_dummy_var_208, out_vslice_dummy_var_209, out_vslice_dummy_var_210, out_vslice_dummy_var_211, out_vslice_dummy_var_212, out_vslice_dummy_var_213, out_vslice_dummy_var_214, out_vslice_dummy_var_215, out_vslice_dummy_var_216, out_vslice_dummy_var_217, out_vslice_dummy_var_218, out_vslice_dummy_var_219, out_vslice_dummy_var_220, out_vslice_dummy_var_221, out_vslice_dummy_var_222, out_vslice_dummy_var_223, out_vslice_dummy_var_224, out_vslice_dummy_var_225, out_vslice_dummy_var_226 := in_irpSp_3, in_Tmp_495, in_sdv_305, in_irp_4, in_l_5, in_Tmp_498, in_vslice_dummy_var_205, in_vslice_dummy_var_206, in_vslice_dummy_var_207, in_vslice_dummy_var_208, in_vslice_dummy_var_209, in_vslice_dummy_var_210, in_vslice_dummy_var_211, in_vslice_dummy_var_212, in_vslice_dummy_var_213, in_vslice_dummy_var_214, in_vslice_dummy_var_215, in_vslice_dummy_var_216, in_vslice_dummy_var_217, in_vslice_dummy_var_218, in_vslice_dummy_var_219, in_vslice_dummy_var_220, in_vslice_dummy_var_221, in_vslice_dummy_var_222, in_vslice_dummy_var_223, in_vslice_dummy_var_224, in_vslice_dummy_var_225, in_vslice_dummy_var_226;
    goto L6, exit;

  exit:
    return;

  L6:
    call {:si_unique_call 1624} out_sdv_305 := IsListEmpty(in_IrpQueue);
    goto anon59_Else;

  anon59_Else:
    assume {:partition} out_sdv_305 == 0;
    call {:si_unique_call 1626} out_l_5 := RemoveHeadList(in_IrpQueue);
    out_irp_4 := out_l_5;
    call {:si_unique_call 1627} out_irpSp_3 := IoGetCurrentIrpStackLocation(out_irp_4);
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc out_Tmp_495;
    assume {:nonnull} in_DriverObject_7 != 0;
    assume in_DriverObject_7 > 0;
    havoc out_Tmp_498;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume out_Tmp_495 != 27;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume out_Tmp_495 != 26;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume out_Tmp_495 != 25;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume out_Tmp_495 != 24;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume out_Tmp_495 != 23;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume out_Tmp_495 != 22;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume out_Tmp_495 != 21;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume out_Tmp_495 != 20;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume out_Tmp_495 != 19;
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume out_Tmp_495 != 18;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume out_Tmp_495 != 17;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume out_Tmp_495 != 16;
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume out_Tmp_495 != 15;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume out_Tmp_495 != 14;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume out_Tmp_495 != 13;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume out_Tmp_495 != 12;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume out_Tmp_495 != 11;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume out_Tmp_495 != 10;
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume out_Tmp_495 != 9;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume out_Tmp_495 != 8;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume out_Tmp_495 != 7;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume out_Tmp_495 != 6;
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume out_Tmp_495 != 5;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume out_Tmp_495 != 4;
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume out_Tmp_495 != 3;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume out_Tmp_495 != 2;
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume out_Tmp_495 != 1;
    goto anon87_Then;

  anon87_Then:
    assume out_Tmp_495 == 0;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1342;
    call {:si_unique_call 1625} out_vslice_dummy_var_226 := VolSnapDefaultDispatch(vslice_dummy_var_1342, out_irp_4);
    goto anon87_Then_dummy;

  anon87_Then_dummy:
    goto L_BAF_0;

  L_BAF_0:
    call {:si_unique_call 1649} {:si_old_unique_call 1} out_irpSp_3, out_Tmp_495, out_sdv_305, out_irp_4, out_l_5, out_Tmp_498, out_vslice_dummy_var_205, out_vslice_dummy_var_206, out_vslice_dummy_var_207, out_vslice_dummy_var_208, out_vslice_dummy_var_209, out_vslice_dummy_var_210, out_vslice_dummy_var_211, out_vslice_dummy_var_212, out_vslice_dummy_var_213, out_vslice_dummy_var_214, out_vslice_dummy_var_215, out_vslice_dummy_var_216, out_vslice_dummy_var_217, out_vslice_dummy_var_218, out_vslice_dummy_var_219, out_vslice_dummy_var_220, out_vslice_dummy_var_221, out_vslice_dummy_var_222, out_vslice_dummy_var_223, out_vslice_dummy_var_224, out_vslice_dummy_var_225, out_vslice_dummy_var_226 := sdv_hash_588722555_loop_L6(out_irpSp_3, out_Tmp_495, out_sdv_305, out_irp_4, out_l_5, out_Tmp_498, in_DriverObject_7, in_IrpQueue, out_vslice_dummy_var_205, out_vslice_dummy_var_206, out_vslice_dummy_var_207, out_vslice_dummy_var_208, out_vslice_dummy_var_209, out_vslice_dummy_var_210, out_vslice_dummy_var_211, out_vslice_dummy_var_212, out_vslice_dummy_var_213, out_vslice_dummy_var_214, out_vslice_dummy_var_215, out_vslice_dummy_var_216, out_vslice_dummy_var_217, out_vslice_dummy_var_218, out_vslice_dummy_var_219, out_vslice_dummy_var_220, out_vslice_dummy_var_221, out_vslice_dummy_var_222, out_vslice_dummy_var_223, out_vslice_dummy_var_224, out_vslice_dummy_var_225, out_vslice_dummy_var_226);
    return;

  anon86_Then:
    assume out_Tmp_495 == 1;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1343;
    call {:si_unique_call 1628} out_vslice_dummy_var_225 := VolSnapDefaultDispatch(vslice_dummy_var_1343, out_irp_4);
    goto anon86_Then_dummy;

  anon86_Then_dummy:
    goto L_BAF_0;

  anon85_Then:
    assume out_Tmp_495 == 2;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1344;
    call {:si_unique_call 1629} out_vslice_dummy_var_224 := VolSnapDefaultDispatch(vslice_dummy_var_1344, out_irp_4);
    goto anon85_Then_dummy;

  anon85_Then_dummy:
    goto L_BAF_0;

  anon84_Then:
    assume out_Tmp_495 == 3;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    goto anon84_Then_dummy;

  anon84_Then_dummy:
    goto L_BAF_0;

  anon83_Then:
    assume out_Tmp_495 == 4;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    goto anon83_Then_dummy;

  anon83_Then_dummy:
    goto L_BAF_0;

  anon82_Then:
    assume out_Tmp_495 == 5;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1345;
    call {:si_unique_call 1630} out_vslice_dummy_var_223 := VolSnapDefaultDispatch(vslice_dummy_var_1345, out_irp_4);
    goto anon82_Then_dummy;

  anon82_Then_dummy:
    goto L_BAF_0;

  anon81_Then:
    assume out_Tmp_495 == 6;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1346;
    call {:si_unique_call 1631} out_vslice_dummy_var_222 := VolSnapDefaultDispatch(vslice_dummy_var_1346, out_irp_4);
    goto anon81_Then_dummy;

  anon81_Then_dummy:
    goto L_BAF_0;

  anon80_Then:
    assume out_Tmp_495 == 7;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1347;
    call {:si_unique_call 1632} out_vslice_dummy_var_221 := VolSnapDefaultDispatch(vslice_dummy_var_1347, out_irp_4);
    goto anon80_Then_dummy;

  anon80_Then_dummy:
    goto L_BAF_0;

  anon79_Then:
    assume out_Tmp_495 == 8;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1348;
    call {:si_unique_call 1633} out_vslice_dummy_var_220 := VolSnapDefaultDispatch(vslice_dummy_var_1348, out_irp_4);
    goto anon79_Then_dummy;

  anon79_Then_dummy:
    goto L_BAF_0;

  anon78_Then:
    assume out_Tmp_495 == 9;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1349;
    call {:si_unique_call 1634} out_vslice_dummy_var_219 := VolSnapDefaultDispatch(vslice_dummy_var_1349, out_irp_4);
    goto anon78_Then_dummy;

  anon78_Then_dummy:
    goto L_BAF_0;

  anon77_Then:
    assume out_Tmp_495 == 10;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1350;
    call {:si_unique_call 1635} out_vslice_dummy_var_218 := VolSnapDefaultDispatch(vslice_dummy_var_1350, out_irp_4);
    goto anon77_Then_dummy;

  anon77_Then_dummy:
    goto L_BAF_0;

  anon76_Then:
    assume out_Tmp_495 == 11;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1351;
    call {:si_unique_call 1636} out_vslice_dummy_var_217 := VolSnapDefaultDispatch(vslice_dummy_var_1351, out_irp_4);
    goto anon76_Then_dummy;

  anon76_Then_dummy:
    goto L_BAF_0;

  anon75_Then:
    assume out_Tmp_495 == 12;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1352;
    call {:si_unique_call 1637} out_vslice_dummy_var_216 := VolSnapDefaultDispatch(vslice_dummy_var_1352, out_irp_4);
    goto anon75_Then_dummy;

  anon75_Then_dummy:
    goto L_BAF_0;

  anon74_Then:
    assume out_Tmp_495 == 13;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1353;
    call {:si_unique_call 1638} out_vslice_dummy_var_215 := VolSnapDefaultDispatch(vslice_dummy_var_1353, out_irp_4);
    goto anon74_Then_dummy;

  anon74_Then_dummy:
    goto L_BAF_0;

  anon73_Then:
    assume out_Tmp_495 == 14;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    goto anon73_Then_dummy;

  anon73_Then_dummy:
    goto L_BAF_0;

  anon72_Then:
    assume out_Tmp_495 == 15;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1354;
    call {:si_unique_call 1639} out_vslice_dummy_var_214 := VolSnapDefaultDispatch(vslice_dummy_var_1354, out_irp_4);
    goto anon72_Then_dummy;

  anon72_Then_dummy:
    goto L_BAF_0;

  anon71_Then:
    assume out_Tmp_495 == 16;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1355;
    call {:si_unique_call 1640} out_vslice_dummy_var_213 := VolSnapDefaultDispatch(vslice_dummy_var_1355, out_irp_4);
    goto anon71_Then_dummy;

  anon71_Then_dummy:
    goto L_BAF_0;

  anon70_Then:
    assume out_Tmp_495 == 17;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1356;
    call {:si_unique_call 1641} out_vslice_dummy_var_212 := VolSnapDefaultDispatch(vslice_dummy_var_1356, out_irp_4);
    goto anon70_Then_dummy;

  anon70_Then_dummy:
    goto L_BAF_0;

  anon69_Then:
    assume out_Tmp_495 == 18;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    goto anon69_Then_dummy;

  anon69_Then_dummy:
    goto L_BAF_0;

  anon68_Then:
    assume out_Tmp_495 == 19;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1357;
    call {:si_unique_call 1642} out_vslice_dummy_var_211 := VolSnapDefaultDispatch(vslice_dummy_var_1357, out_irp_4);
    goto anon68_Then_dummy;

  anon68_Then_dummy:
    goto L_BAF_0;

  anon67_Then:
    assume out_Tmp_495 == 20;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1358;
    call {:si_unique_call 1643} out_vslice_dummy_var_210 := VolSnapDefaultDispatch(vslice_dummy_var_1358, out_irp_4);
    goto anon67_Then_dummy;

  anon67_Then_dummy:
    goto L_BAF_0;

  anon66_Then:
    assume out_Tmp_495 == 21;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1359;
    call {:si_unique_call 1644} out_vslice_dummy_var_209 := VolSnapDefaultDispatch(vslice_dummy_var_1359, out_irp_4);
    goto anon66_Then_dummy;

  anon66_Then_dummy:
    goto L_BAF_0;

  anon65_Then:
    assume out_Tmp_495 == 22;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    goto anon65_Then_dummy;

  anon65_Then_dummy:
    goto L_BAF_0;

  anon64_Then:
    assume out_Tmp_495 == 23;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1360;
    call {:si_unique_call 1645} out_vslice_dummy_var_208 := VolSnapDefaultDispatch(vslice_dummy_var_1360, out_irp_4);
    goto anon64_Then_dummy;

  anon64_Then_dummy:
    goto L_BAF_0;

  anon63_Then:
    assume out_Tmp_495 == 24;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1361;
    call {:si_unique_call 1646} out_vslice_dummy_var_207 := VolSnapDefaultDispatch(vslice_dummy_var_1361, out_irp_4);
    goto anon63_Then_dummy;

  anon63_Then_dummy:
    goto L_BAF_0;

  anon62_Then:
    assume out_Tmp_495 == 25;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1362;
    call {:si_unique_call 1647} out_vslice_dummy_var_206 := VolSnapDefaultDispatch(vslice_dummy_var_1362, out_irp_4);
    goto anon62_Then_dummy;

  anon62_Then_dummy:
    goto L_BAF_0;

  anon61_Then:
    assume out_Tmp_495 == 26;
    assume {:IndirectCall} true;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    assume {:nonnull} out_irpSp_3 != 0;
    assume out_irpSp_3 > 0;
    havoc vslice_dummy_var_1363;
    call {:si_unique_call 1648} out_vslice_dummy_var_205 := VolSnapDefaultDispatch(vslice_dummy_var_1363, out_irp_4);
    goto anon61_Then_dummy;

  anon61_Then_dummy:
    goto L_BAF_0;

  anon60_Then:
    assume out_Tmp_495 == 27;
    assume {:nonnull} out_Tmp_498 != 0;
    assume out_Tmp_498 > 0;
    goto anon60_Then_dummy;

  anon60_Then_dummy:
    goto L_BAF_0;
}



procedure {:LoopProcedure} sdv_hash_588722555_loop_L6(in_irpSp_3: int, in_Tmp_495: int, in_sdv_305: int, in_irp_4: int, in_l_5: int, in_Tmp_498: int, in_DriverObject_7: int, in_IrpQueue: int, in_vslice_dummy_var_205: int, in_vslice_dummy_var_206: int, in_vslice_dummy_var_207: int, in_vslice_dummy_var_208: int, in_vslice_dummy_var_209: int, in_vslice_dummy_var_210: int, in_vslice_dummy_var_211: int, in_vslice_dummy_var_212: int, in_vslice_dummy_var_213: int, in_vslice_dummy_var_214: int, in_vslice_dummy_var_215: int, in_vslice_dummy_var_216: int, in_vslice_dummy_var_217: int, in_vslice_dummy_var_218: int, in_vslice_dummy_var_219: int, in_vslice_dummy_var_220: int, in_vslice_dummy_var_221: int, in_vslice_dummy_var_222: int, in_vslice_dummy_var_223: int, in_vslice_dummy_var_224: int, in_vslice_dummy_var_225: int, in_vslice_dummy_var_226: int) returns (out_irpSp_3: int, out_Tmp_495: int, out_sdv_305: int, out_irp_4: int, out_l_5: int, out_Tmp_498: int, out_vslice_dummy_var_205: int, out_vslice_dummy_var_206: int, out_vslice_dummy_var_207: int, out_vslice_dummy_var_208: int, out_vslice_dummy_var_209: int, out_vslice_dummy_var_210: int, out_vslice_dummy_var_211: int, out_vslice_dummy_var_212: int, out_vslice_dummy_var_213: int, out_vslice_dummy_var_214: int, out_vslice_dummy_var_215: int, out_vslice_dummy_var_216: int, out_vslice_dummy_var_217: int, out_vslice_dummy_var_218: int, out_vslice_dummy_var_219: int, out_vslice_dummy_var_220: int, out_vslice_dummy_var_221: int, out_vslice_dummy_var_222: int, out_vslice_dummy_var_223: int, out_vslice_dummy_var_224: int, out_vslice_dummy_var_225: int, out_vslice_dummy_var_226: int);
  modifies alloc, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;



implementation sdv_hash_692646834_loop_L38(in_Tmp_507: int, in_workItem_1: int, in_sdv_315: int, in_Tmp_509: int, in_l_6: int, in_q_3: int) returns (out_Tmp_507: int, out_workItem_1: int, out_sdv_315: int, out_Tmp_509: int, out_l_6: int)
{

  entry:
    out_Tmp_507, out_workItem_1, out_sdv_315, out_Tmp_509, out_l_6 := in_Tmp_507, in_workItem_1, in_sdv_315, in_Tmp_509, in_l_6;
    goto L38, exit;

  exit:
    return;

  L38:
    call {:si_unique_call 1650} out_l_6 := RemoveHeadList(in_q_3);
    out_workItem_1 := out_l_6;
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    goto anon25_Then;

  anon25_Then:
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    havoc out_Tmp_509;
    assume {:nonnull} out_Tmp_509 != 0;
    assume out_Tmp_509 > 0;
    havoc out_Tmp_507;
    assume {:nonnull} out_Tmp_507 != 0;
    assume out_Tmp_507 > 0;
    goto anon30_Then;

  anon30_Then:
    goto L44;

  L44:
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    call {:si_unique_call 1651} out_sdv_315 := IsListEmpty(in_q_3);
    goto anon27_Then;

  anon27_Then:
    assume {:partition} out_sdv_315 == 0;
    goto anon27_Then_dummy;

  anon27_Then_dummy:
    call {:si_unique_call 1652} {:si_old_unique_call 1} out_Tmp_507, out_workItem_1, out_sdv_315, out_Tmp_509, out_l_6 := sdv_hash_692646834_loop_L38(out_Tmp_507, out_workItem_1, out_sdv_315, out_Tmp_509, out_l_6, in_q_3);
    return;

  anon24_Then:
    goto L44;

  anon28_Then:
    goto L44;
}



procedure {:LoopProcedure} sdv_hash_692646834_loop_L38(in_Tmp_507: int, in_workItem_1: int, in_sdv_315: int, in_Tmp_509: int, in_l_6: int, in_q_3: int) returns (out_Tmp_507: int, out_workItem_1: int, out_sdv_315: int, out_Tmp_509: int, out_l_6: int);



implementation sdv_hash_692646834_loop_L13(in_Tmp_507: int, in_workItem_1: int, in_sdv_315: int, in_sdv_316: int, in_filter_7: int, in_Tmp_509: int, in_l_6: int, in_q_3: int, in_irql_15: int) returns (out_Tmp_507: int, out_workItem_1: int, out_sdv_315: int, out_sdv_316: int, out_Tmp_509: int, out_l_6: int, out_irql_15: int)
{

  entry:
    out_Tmp_507, out_workItem_1, out_sdv_315, out_sdv_316, out_Tmp_509, out_l_6, out_irql_15 := in_Tmp_507, in_workItem_1, in_sdv_315, in_sdv_316, in_Tmp_509, in_l_6, in_irql_15;
    goto L13, exit;

  exit:
    return;

  L13:
    call {:si_unique_call 1653} out_irql_15 := KfAcquireSpinLock(0);
    assume {:nonnull} in_filter_7 != 0;
    assume in_filter_7 > 0;
    call {:si_unique_call 1654} out_sdv_316 := IsListEmpty(NonPagedResourceList_FILTER_EXTENSION(in_filter_7));
    goto anon23_Then;

  anon23_Then:
    assume {:partition} out_sdv_316 == 0;
    assume {:nonnull} in_filter_7 != 0;
    assume in_filter_7 > 0;
    assume {:nonnull} in_q_3 != 0;
    assume in_q_3 > 0;
    assume {:nonnull} in_filter_7 != 0;
    assume in_filter_7 > 0;
    assume {:nonnull} in_q_3 != 0;
    assume in_q_3 > 0;
    assume {:nonnull} in_filter_7 != 0;
    assume in_filter_7 > 0;
    call {:si_unique_call 1658} InitializeListHead(NonPagedResourceList_FILTER_EXTENSION(in_filter_7));
    call {:si_unique_call 1659} KfReleaseSpinLock(0, out_irql_15);
    assume {:nonnull} in_q_3 != 0;
    assume in_q_3 > 0;
    assume {:nonnull} in_q_3 != 0;
    assume in_q_3 > 0;
    assume {:nonnull} in_filter_7 != 0;
    assume in_filter_7 > 0;
    goto L38;

  L38:
    call {:si_unique_call 1656} out_Tmp_507, out_workItem_1, out_sdv_315, out_Tmp_509, out_l_6 := sdv_hash_692646834_loop_L38(out_Tmp_507, out_workItem_1, out_sdv_315, out_Tmp_509, out_l_6, in_q_3);
    goto L38_last;

  L38_last:
    call {:si_unique_call 1657} out_l_6 := RemoveHeadList(in_q_3);
    out_workItem_1 := out_l_6;
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    goto L51;

  L51:
    assume {:nonnull} in_filter_7 != 0;
    assume in_filter_7 > 0;
    goto anon29_Then;

  anon29_Then:
    assume {:partition} out_workItem_1 == 0;
    goto anon29_Then_dummy;

  anon29_Then_dummy:
    call {:si_unique_call 1660} {:si_old_unique_call 1} out_Tmp_507, out_workItem_1, out_sdv_315, out_sdv_316, out_Tmp_509, out_l_6, out_irql_15 := sdv_hash_692646834_loop_L13(out_Tmp_507, out_workItem_1, out_sdv_315, out_sdv_316, in_filter_7, out_Tmp_509, out_l_6, in_q_3, out_irql_15);
    return;

  anon25_Then:
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    havoc out_Tmp_509;
    assume {:nonnull} out_Tmp_509 != 0;
    assume out_Tmp_509 > 0;
    havoc out_Tmp_507;
    assume {:nonnull} out_Tmp_507 != 0;
    assume out_Tmp_507 > 0;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    goto L51;

  anon30_Then:
    goto L44;

  L44:
    assume {:nonnull} out_workItem_1 != 0;
    assume out_workItem_1 > 0;
    call {:si_unique_call 1655} out_sdv_315 := IsListEmpty(in_q_3);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} out_sdv_315 != 0;
    out_workItem_1 := 0;
    goto L51;

  anon27_Then:
    assume {:partition} out_sdv_315 == 0;
    assume false;
    return;

  anon24_Then:
    goto L44;

  anon28_Then:
    goto L44;
}



procedure {:LoopProcedure} sdv_hash_692646834_loop_L13(in_Tmp_507: int, in_workItem_1: int, in_sdv_315: int, in_sdv_316: int, in_filter_7: int, in_Tmp_509: int, in_l_6: int, in_q_3: int, in_irql_15: int) returns (out_Tmp_507: int, out_workItem_1: int, out_sdv_315: int, out_sdv_316: int, out_Tmp_509: int, out_l_6: int, out_irql_15: int);
  modifies alloc;



implementation VspSynchronousIo_loop_L43(in_tick_1: int, in_s_p_e_c_i_a_l_3: int)
{

  entry:
    goto L43, exit;

  exit:
    return;

  L43:
    assume {:nonnull} in_s_p_e_c_i_a_l_3 != 0;
    assume in_s_p_e_c_i_a_l_3 > 0;
    assume {:nonnull} in_tick_1 != 0;
    assume in_tick_1 > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_3 != 0;
    assume in_s_p_e_c_i_a_l_3 > 0;
    assume {:nonnull} in_tick_1 != 0;
    assume in_tick_1 > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_3 != 0;
    assume in_s_p_e_c_i_a_l_3 > 0;
    assume {:nonnull} in_tick_1 != 0;
    assume in_tick_1 > 0;
    goto anon29_Then;

  anon29_Then:
    goto anon29_Then_dummy;

  anon29_Then_dummy:
    call {:si_unique_call 1661} {:si_old_unique_call 1} VspSynchronousIo_loop_L43(in_tick_1, in_s_p_e_c_i_a_l_3);
    return;
}



procedure {:LoopProcedure} VspSynchronousIo_loop_L43(in_tick_1: int, in_s_p_e_c_i_a_l_3: int);



implementation VspSynchronousIo_loop_L15(in_nextSp: int, in_tick_1: int, in_s_p_e_c_i_a_l_3: int, in_Tmp_522: int, in_restartCount: int, in_event_3: int, in_Irp_13: int, in_TargetObject_2: int, in_MajorFunction_3: int, in_Offset_3: int, in_Length_3: int, in_Key_2: int, in_FileObject_2: int, in_Thread: int, in_boogieTmp: int, in_vslice_dummy_var_234: int, in_vslice_dummy_var_235: int) returns (out_nextSp: int, out_s_p_e_c_i_a_l_3: int, out_Tmp_522: int, out_restartCount: int, out_boogieTmp: int, out_vslice_dummy_var_234: int, out_vslice_dummy_var_235: int)
{

  entry:
    out_nextSp, out_s_p_e_c_i_a_l_3, out_Tmp_522, out_restartCount, out_boogieTmp, out_vslice_dummy_var_234, out_vslice_dummy_var_235 := in_nextSp, in_s_p_e_c_i_a_l_3, in_Tmp_522, in_restartCount, in_boogieTmp, in_vslice_dummy_var_234, in_vslice_dummy_var_235;
    goto L15, exit;

  exit:
    return;

  L15:
    assume {:nonnull} in_Irp_13 != 0;
    assume in_Irp_13 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} in_FileObject_2 != 1;
    assume {:nonnull} in_Irp_13 != 0;
    assume in_Irp_13 > 0;
    goto L17;

  L17:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} in_Thread != 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} in_Thread != 1;
    assume {:nonnull} in_Irp_13 != 0;
    assume in_Irp_13 > 0;
    goto L23;

  L23:
    call {:si_unique_call 1665} out_nextSp := IoGetNextIrpStackLocation(in_Irp_13);
    assume {:nonnull} out_nextSp != 0;
    assume out_nextSp > 0;
    assume {:nonnull} out_nextSp != 0;
    assume out_nextSp > 0;
    assume {:nonnull} out_nextSp != 0;
    assume out_nextSp > 0;
    assume {:nonnull} out_nextSp != 0;
    assume out_nextSp > 0;
    assume {:nonnull} out_nextSp != 0;
    assume out_nextSp > 0;
    assume {:nonnull} out_nextSp != 0;
    assume out_nextSp > 0;
    call {:si_unique_call 1666} KeInitializeEvent(in_event_3, 0, 0);
    call {:si_unique_call 1667} IoSetCompletionRoutine(in_Irp_13, li2bplFunctionConstant853, in_event_3, 1, 1, 1);
    out_Tmp_522 := KeTickCount;
    assume {:nonnull} out_Tmp_522 != 0;
    assume out_Tmp_522 > 0;
    havoc out_s_p_e_c_i_a_l_3;
    goto L43;

  L43:
    call {:si_unique_call 1664} VspSynchronousIo_loop_L43(in_tick_1, out_s_p_e_c_i_a_l_3);
    goto L43_last;

  L43_last:
    assume {:nonnull} out_s_p_e_c_i_a_l_3 != 0;
    assume out_s_p_e_c_i_a_l_3 > 0;
    assume {:nonnull} in_tick_1 != 0;
    assume in_tick_1 > 0;
    assume {:nonnull} out_s_p_e_c_i_a_l_3 != 0;
    assume out_s_p_e_c_i_a_l_3 > 0;
    assume {:nonnull} in_tick_1 != 0;
    assume in_tick_1 > 0;
    assume {:nonnull} out_s_p_e_c_i_a_l_3 != 0;
    assume out_s_p_e_c_i_a_l_3 > 0;
    assume {:nonnull} in_tick_1 != 0;
    assume in_tick_1 > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    call {:si_unique_call 1662} out_vslice_dummy_var_234 := IofCallDriver(0, in_Irp_13);
    call {:si_unique_call 1663} out_vslice_dummy_var_235 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} in_Irp_13 != 0;
    assume in_Irp_13 > 0;
    goto anon24_Else;

  anon24_Else:
    assume {:partition} Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(in_Irp_13))] == -1073741536;
    out_restartCount := out_restartCount + 1;
    goto anon30_Then;

  anon30_Then:
    assume {:partition} out_restartCount <= 10;
    goto anon30_Then_dummy;

  anon30_Then_dummy:
    call {:si_unique_call 1669} {:si_old_unique_call 1} out_nextSp, out_s_p_e_c_i_a_l_3, out_Tmp_522, out_restartCount, out_boogieTmp, out_vslice_dummy_var_234, out_vslice_dummy_var_235 := VspSynchronousIo_loop_L15(out_nextSp, in_tick_1, out_s_p_e_c_i_a_l_3, out_Tmp_522, out_restartCount, in_event_3, in_Irp_13, in_TargetObject_2, in_MajorFunction_3, in_Offset_3, in_Length_3, in_Key_2, in_FileObject_2, in_Thread, out_boogieTmp, out_vslice_dummy_var_234, out_vslice_dummy_var_235);
    return;

  anon29_Then:
    assume false;
    return;

  anon23_Then:
    assume {:partition} in_Thread == 1;
    goto L23;

  anon22_Then:
    assume {:partition} in_Thread == 0;
    assume {:nonnull} in_Irp_13 != 0;
    assume in_Irp_13 > 0;
    call {:si_unique_call 1668} out_boogieTmp := PsGetCurrentThread();
    goto L23;

  anon28_Then:
    assume {:partition} in_FileObject_2 == 1;
    goto L17;
}



procedure {:LoopProcedure} VspSynchronousIo_loop_L15(in_nextSp: int, in_tick_1: int, in_s_p_e_c_i_a_l_3: int, in_Tmp_522: int, in_restartCount: int, in_event_3: int, in_Irp_13: int, in_TargetObject_2: int, in_MajorFunction_3: int, in_Offset_3: int, in_Length_3: int, in_Key_2: int, in_FileObject_2: int, in_Thread: int, in_boogieTmp: int, in_vslice_dummy_var_234: int, in_vslice_dummy_var_235: int) returns (out_nextSp: int, out_s_p_e_c_i_a_l_3: int, out_Tmp_522: int, out_restartCount: int, out_boogieTmp: int, out_vslice_dummy_var_234: int, out_vslice_dummy_var_235: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK, alloc, Mem_T.Type_unnamed_tag_26;
  free ensures out_vslice_dummy_var_234 == 259 || out_vslice_dummy_var_234 == in_vslice_dummy_var_234;
  free ensures out_vslice_dummy_var_235 == 258 || out_vslice_dummy_var_235 == 0 || out_vslice_dummy_var_235 == in_vslice_dummy_var_235;



implementation sdv_hash_307580759_loop_L109(in_tick_2: int, in_s_p_e_c_i_a_l_5: int)
{

  entry:
    goto L109, exit;

  exit:
    return;

  L109:
    assume {:nonnull} in_s_p_e_c_i_a_l_5 != 0;
    assume in_s_p_e_c_i_a_l_5 > 0;
    assume {:nonnull} in_tick_2 != 0;
    assume in_tick_2 > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_5 != 0;
    assume in_s_p_e_c_i_a_l_5 > 0;
    assume {:nonnull} in_tick_2 != 0;
    assume in_tick_2 > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_5 != 0;
    assume in_s_p_e_c_i_a_l_5 > 0;
    assume {:nonnull} in_tick_2 != 0;
    assume in_tick_2 > 0;
    goto anon48_Then;

  anon48_Then:
    goto anon48_Then_dummy;

  anon48_Then_dummy:
    call {:si_unique_call 1670} {:si_old_unique_call 1} sdv_hash_307580759_loop_L109(in_tick_2, in_s_p_e_c_i_a_l_5);
    return;
}



procedure {:LoopProcedure} sdv_hash_307580759_loop_L109(in_tick_2: int, in_s_p_e_c_i_a_l_5: int);



implementation sdv_hash_307580759_loop_L41(in_tick_2: int, in_s_p_e_c_i_a_l_4: int)
{

  entry:
    goto L41, exit;

  exit:
    return;

  L41:
    assume {:nonnull} in_s_p_e_c_i_a_l_4 != 0;
    assume in_s_p_e_c_i_a_l_4 > 0;
    assume {:nonnull} in_tick_2 != 0;
    assume in_tick_2 > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_4 != 0;
    assume in_s_p_e_c_i_a_l_4 > 0;
    assume {:nonnull} in_tick_2 != 0;
    assume in_tick_2 > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_4 != 0;
    assume in_s_p_e_c_i_a_l_4 > 0;
    assume {:nonnull} in_tick_2 != 0;
    assume in_tick_2 > 0;
    goto anon44_Then;

  anon44_Then:
    goto anon44_Then_dummy;

  anon44_Then_dummy:
    call {:si_unique_call 1671} {:si_old_unique_call 1} sdv_hash_307580759_loop_L41(in_tick_2, in_s_p_e_c_i_a_l_4);
    return;
}



procedure {:LoopProcedure} sdv_hash_307580759_loop_L41(in_tick_2: int, in_s_p_e_c_i_a_l_4: int);



implementation sdv_hash_414123790_loop_L38(in_lookupEntry: int, in_l_7: int, in_sdv_348: int, in_SnapshotGuid_1: int) returns (out_lookupEntry: int, out_l_7: int, out_sdv_348: int)
{

  entry:
    out_lookupEntry, out_l_7, out_sdv_348 := in_lookupEntry, in_l_7, in_sdv_348;
    goto L38, exit;

  exit:
    return;

  L38:
    goto anon26_Else;

  anon26_Else:
    out_lookupEntry := out_l_7;
    assume {:nonnull} out_lookupEntry != 0;
    assume out_lookupEntry > 0;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:nonnull} out_lookupEntry != 0;
    assume out_lookupEntry > 0;
    call {:si_unique_call 1672} out_sdv_348 := IsEqualGUID(OriginalSnapshotGuid__VSP_LOOKUP_TABLE_ENTRY(out_lookupEntry), in_SnapshotGuid_1);
    goto anon27_Then;

  anon27_Then:
    assume {:partition} out_sdv_348 == 0;
    goto L44;

  L44:
    assume {:nonnull} out_l_7 != 0;
    assume out_l_7 > 0;
    havoc out_l_7;
    goto L44_dummy;

  L44_dummy:
    havoc out_l_7;
    return;

  anon30_Then:
    goto L44;
}



procedure {:LoopProcedure} sdv_hash_414123790_loop_L38(in_lookupEntry: int, in_l_7: int, in_sdv_348: int, in_SnapshotGuid_1: int) returns (out_lookupEntry: int, out_l_7: int, out_sdv_348: int);
  free ensures out_lookupEntry == in_l_7 || out_lookupEntry == in_lookupEntry;
  free ensures out_sdv_348 == 0 || out_sdv_348 == 1 || out_sdv_348 == in_sdv_348;



implementation sdv_hash_414123790_loop_L25(in_lookupEntry: int, in_sdv_346: int, in_l_7: int, in_SnapshotGuid_1: int) returns (out_lookupEntry: int, out_sdv_346: int, out_l_7: int)
{

  entry:
    out_lookupEntry, out_sdv_346, out_l_7 := in_lookupEntry, in_sdv_346, in_l_7;
    goto L25, exit;

  exit:
    return;

  L25:
    goto anon24_Else;

  anon24_Else:
    out_lookupEntry := out_l_7;
    assume {:nonnull} out_lookupEntry != 0;
    assume out_lookupEntry > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:nonnull} out_lookupEntry != 0;
    assume out_lookupEntry > 0;
    call {:si_unique_call 1673} out_sdv_346 := IsEqualGUID(OriginalSnapshotGuid__VSP_LOOKUP_TABLE_ENTRY(out_lookupEntry), in_SnapshotGuid_1);
    goto anon25_Then;

  anon25_Then:
    assume {:partition} out_sdv_346 == 0;
    goto L29;

  L29:
    assume {:nonnull} out_l_7 != 0;
    assume out_l_7 > 0;
    havoc out_l_7;
    goto L29_dummy;

  L29_dummy:
    call {:si_unique_call 1674} {:si_old_unique_call 1} out_lookupEntry, out_sdv_346, out_l_7 := sdv_hash_414123790_loop_L25(out_lookupEntry, out_sdv_346, out_l_7, in_SnapshotGuid_1);
    return;

  anon29_Then:
    goto L29;
}



procedure {:LoopProcedure} sdv_hash_414123790_loop_L25(in_lookupEntry: int, in_sdv_346: int, in_l_7: int, in_SnapshotGuid_1: int) returns (out_lookupEntry: int, out_sdv_346: int, out_l_7: int);
  free ensures out_sdv_346 == 0 || out_sdv_346 == 1 || out_sdv_346 == in_sdv_346;



implementation sdv_hash_208558080_loop_L14(in_diffAreaFile_1: int, in_l_9: int, in_Tmp_572: int, in_extension_4: int, in_Filter_23: int) returns (out_diffAreaFile_1: int, out_l_9: int, out_Tmp_572: int, out_extension_4: int)
{

  entry:
    out_diffAreaFile_1, out_l_9, out_Tmp_572, out_extension_4 := in_diffAreaFile_1, in_l_9, in_Tmp_572, in_extension_4;
    goto L14, exit;

  exit:
    return;

  L14:
    goto anon14_Else;

  anon14_Else:
    out_diffAreaFile_1 := out_l_9;
    assume {:nonnull} out_diffAreaFile_1 != 0;
    assume out_diffAreaFile_1 > 0;
    havoc out_extension_4;
    assume {:nonnull} out_extension_4 != 0;
    assume out_extension_4 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:nonnull} out_extension_4 != 0;
    assume out_extension_4 > 0;
    havoc out_Tmp_572;
    assume {:nonnull} out_Tmp_572 != 0;
    assume out_Tmp_572 > 0;
    goto anon18_Then;

  anon18_Then:
    goto L19;

  L19:
    assume {:nonnull} out_l_9 != 0;
    assume out_l_9 > 0;
    havoc out_l_9;
    goto L19_dummy;

  L19_dummy:
    havoc out_l_9;
    return;

  anon17_Then:
    goto L19;
}



procedure {:LoopProcedure} sdv_hash_208558080_loop_L14(in_diffAreaFile_1: int, in_l_9: int, in_Tmp_572: int, in_extension_4: int, in_Filter_23: int) returns (out_diffAreaFile_1: int, out_l_9: int, out_Tmp_572: int, out_extension_4: int);
  free ensures out_diffAreaFile_1 == in_l_9 || out_diffAreaFile_1 == in_diffAreaFile_1;



implementation sdv_hash_997443178_loop_L49(in_sdv_391: int, in_filter_12: int, in_l_10: int) returns (out_sdv_391: int, out_l_10: int)
{

  entry:
    out_sdv_391, out_l_10 := in_sdv_391, in_l_10;
    goto L49, exit;

  exit:
    return;

  L49:
    assume {:nonnull} in_filter_12 != 0;
    assume in_filter_12 > 0;
    call {:si_unique_call 1675} out_sdv_391 := IsListEmpty(CopyOnWriteList_FILTER_EXTENSION(in_filter_12));
    goto anon18_Then;

  anon18_Then:
    assume {:partition} out_sdv_391 == 0;
    assume {:nonnull} in_filter_12 != 0;
    assume in_filter_12 > 0;
    call {:si_unique_call 1676} out_l_10 := RemoveHeadList(CopyOnWriteList_FILTER_EXTENSION(in_filter_12));
    call {:si_unique_call 1677} ExFreePoolWithTag(0, 0);
    call {:si_unique_call 1678} ExFreePoolWithTag(0, 0);
    goto anon18_Then_dummy;

  anon18_Then_dummy:
    call {:si_unique_call 1679} {:si_old_unique_call 1} out_sdv_391, out_l_10 := sdv_hash_997443178_loop_L49(out_sdv_391, in_filter_12, out_l_10);
    return;
}



procedure {:LoopProcedure} sdv_hash_997443178_loop_L49(in_sdv_391: int, in_filter_12: int, in_l_10: int) returns (out_sdv_391: int, out_l_10: int);
  modifies alloc;



implementation _InterlockedIncrement64_loop_L4(in_sdv_407: int, in_Old: int, in_Addend: int) returns (out_Old: int)
{

  entry:
    out_Old := in_Old;
    goto L4, exit;

  exit:
    return;

  L4:
    assume {:nonnull} in_Addend != 0;
    assume in_Addend > 0;
    havoc out_Old;
    goto anon3_Then;

  anon3_Then:
    assume {:partition} in_sdv_407 != out_Old;
    goto anon3_Then_dummy;

  anon3_Then_dummy:
    call {:si_unique_call 1680} {:si_old_unique_call 1} out_Old := _InterlockedIncrement64_loop_L4(in_sdv_407, out_Old, in_Addend);
    return;
}



procedure {:LoopProcedure} _InterlockedIncrement64_loop_L4(in_sdv_407: int, in_Old: int, in_Addend: int) returns (out_Old: int);



implementation sdv_hash_811354472_loop_L18(in_lookupEntry_1: int, in_sdv_417: int, in_Tmp_596: int, in_l_12: int, in_Filter_24: int, in_vslice_dummy_var_273: int, in_vslice_dummy_var_276: int) returns (out_lookupEntry_1: int, out_sdv_417: int, out_Tmp_596: int, out_l_12: int, out_vslice_dummy_var_273: int, out_vslice_dummy_var_276: int)
{

  entry:
    out_lookupEntry_1, out_sdv_417, out_Tmp_596, out_l_12, out_vslice_dummy_var_273, out_vslice_dummy_var_276 := in_lookupEntry_1, in_sdv_417, in_Tmp_596, in_l_12, in_vslice_dummy_var_273, in_vslice_dummy_var_276;
    goto L18, exit;

  exit:
    return;

  L18:
    assume {:nonnull} in_Filter_24 != 0;
    assume in_Filter_24 > 0;
    call {:si_unique_call 1681} out_sdv_417 := IsListEmpty(DiffAreaLookupTableEntries_FILTER_EXTENSION(in_Filter_24));
    goto anon12_Then;

  anon12_Then:
    assume {:partition} out_sdv_417 == 0;
    assume {:nonnull} in_Filter_24 != 0;
    assume in_Filter_24 > 0;
    call {:si_unique_call 1684} out_l_12 := RemoveHeadList(DiffAreaLookupTableEntries_FILTER_EXTENSION(in_Filter_24));
    out_lookupEntry_1 := out_l_12;
    assume {:nonnull} out_lookupEntry_1 != 0;
    assume out_lookupEntry_1 > 0;
    assume {:nonnull} out_lookupEntry_1 != 0;
    assume out_lookupEntry_1 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    call {:si_unique_call 1683} out_vslice_dummy_var_273 := ZwClose(0);
    assume {:nonnull} out_lookupEntry_1 != 0;
    assume out_lookupEntry_1 > 0;
    goto L32;

  L32:
    assume {:nonnull} out_lookupEntry_1 != 0;
    assume out_lookupEntry_1 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:nonnull} in_Filter_24 != 0;
    assume in_Filter_24 > 0;
    out_Tmp_596 := DEVICE_EXTENSION_FILTER_EXTENSION(in_Filter_24);
    assume {:nonnull} out_Tmp_596 != 0;
    assume out_Tmp_596 > 0;
    call {:si_unique_call 1682} out_vslice_dummy_var_276 := corral_nondet();
    goto anon13_Else_dummy;

  anon13_Else_dummy:
    goto L_BAF_1;

  L_BAF_1:
    call {:si_unique_call 1685} {:si_old_unique_call 1} out_lookupEntry_1, out_sdv_417, out_Tmp_596, out_l_12, out_vslice_dummy_var_273, out_vslice_dummy_var_276 := sdv_hash_811354472_loop_L18(out_lookupEntry_1, out_sdv_417, out_Tmp_596, out_l_12, in_Filter_24, out_vslice_dummy_var_273, out_vslice_dummy_var_276);
    return;

  anon13_Then:
    goto anon13_Then_dummy;

  anon13_Then_dummy:
    goto L_BAF_1;

  anon14_Then:
    goto L32;
}



procedure {:LoopProcedure} sdv_hash_811354472_loop_L18(in_lookupEntry_1: int, in_sdv_417: int, in_Tmp_596: int, in_l_12: int, in_Filter_24: int, in_vslice_dummy_var_273: int, in_vslice_dummy_var_276: int) returns (out_lookupEntry_1: int, out_sdv_417: int, out_Tmp_596: int, out_l_12: int, out_vslice_dummy_var_273: int, out_vslice_dummy_var_276: int);
  free ensures out_Tmp_596 == in_Tmp_596 || out_Tmp_596 == DEVICE_EXTENSION_FILTER_EXTENSION(in_Filter_24);
  free ensures out_vslice_dummy_var_273 == 0 || out_vslice_dummy_var_273 == in_vslice_dummy_var_273;



implementation sdv_hash_811354472_loop_L11(in_Tmp_591: int, in_lookupEntry_1: int, in_sdv_414: int, in_l_12: int, in_Filter_24: int, in_vslice_dummy_var_277: int) returns (out_Tmp_591: int, out_lookupEntry_1: int, out_sdv_414: int, out_l_12: int, out_vslice_dummy_var_277: int)
{

  entry:
    out_Tmp_591, out_lookupEntry_1, out_sdv_414, out_l_12, out_vslice_dummy_var_277 := in_Tmp_591, in_lookupEntry_1, in_sdv_414, in_l_12, in_vslice_dummy_var_277;
    goto L11, exit;

  exit:
    return;

  L11:
    assume {:nonnull} in_Filter_24 != 0;
    assume in_Filter_24 > 0;
    call {:si_unique_call 1686} out_sdv_414 := IsListEmpty(SnapshotLookupTableEntries_FILTER_EXTENSION(in_Filter_24));
    goto anon11_Then;

  anon11_Then:
    assume {:partition} out_sdv_414 == 0;
    assume {:nonnull} in_Filter_24 != 0;
    assume in_Filter_24 > 0;
    call {:si_unique_call 1688} out_l_12 := RemoveHeadList(SnapshotLookupTableEntries_FILTER_EXTENSION(in_Filter_24));
    out_lookupEntry_1 := out_l_12;
    assume {:nonnull} out_lookupEntry_1 != 0;
    assume out_lookupEntry_1 > 0;
    assume {:nonnull} out_lookupEntry_1 != 0;
    assume out_lookupEntry_1 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:nonnull} in_Filter_24 != 0;
    assume in_Filter_24 > 0;
    out_Tmp_591 := DEVICE_EXTENSION_FILTER_EXTENSION(in_Filter_24);
    assume {:nonnull} out_Tmp_591 != 0;
    assume out_Tmp_591 > 0;
    call {:si_unique_call 1687} out_vslice_dummy_var_277 := corral_nondet();
    goto anon15_Else_dummy;

  anon15_Else_dummy:
    goto L_BAF_2;

  L_BAF_2:
    call {:si_unique_call 1689} {:si_old_unique_call 1} out_Tmp_591, out_lookupEntry_1, out_sdv_414, out_l_12, out_vslice_dummy_var_277 := sdv_hash_811354472_loop_L11(out_Tmp_591, out_lookupEntry_1, out_sdv_414, out_l_12, in_Filter_24, out_vslice_dummy_var_277);
    return;

  anon15_Then:
    goto anon15_Then_dummy;

  anon15_Then_dummy:
    goto L_BAF_2;
}



procedure {:LoopProcedure} sdv_hash_811354472_loop_L11(in_Tmp_591: int, in_lookupEntry_1: int, in_sdv_414: int, in_l_12: int, in_Filter_24: int, in_vslice_dummy_var_277: int) returns (out_Tmp_591: int, out_lookupEntry_1: int, out_sdv_414: int, out_l_12: int, out_vslice_dummy_var_277: int);
  free ensures out_Tmp_591 == in_Tmp_591 || out_Tmp_591 == DEVICE_EXTENSION_FILTER_EXTENSION(in_Filter_24);



implementation sdv_hash_742206354_loop_L18(in_sdv_431: int, in_l_13: int, in_extension_5: int, in_ListOfDeviceObjectsToDelete: int, in_vslice_dummy_var_288: int) returns (out_sdv_431: int, out_l_13: int, out_extension_5: int, out_vslice_dummy_var_288: int)
{

  entry:
    out_sdv_431, out_l_13, out_extension_5, out_vslice_dummy_var_288 := in_sdv_431, in_l_13, in_extension_5, in_vslice_dummy_var_288;
    goto L18, exit;

  exit:
    return;

  L18:
    call {:si_unique_call 1690} out_sdv_431 := IsListEmpty(in_ListOfDeviceObjectsToDelete);
    goto anon8_Else;

  anon8_Else:
    assume {:partition} out_sdv_431 == 0;
    call {:si_unique_call 1691} out_l_13 := RemoveHeadList(in_ListOfDeviceObjectsToDelete);
    out_extension_5 := out_l_13;
    assume {:nonnull} out_extension_5 != 0;
    assume out_extension_5 > 0;
    call {:si_unique_call 1692} out_vslice_dummy_var_288 := ObfDereferenceObject(0);
    goto anon8_Else_dummy;

  anon8_Else_dummy:
    call {:si_unique_call 1693} {:si_old_unique_call 1} out_sdv_431, out_l_13, out_extension_5, out_vslice_dummy_var_288 := sdv_hash_742206354_loop_L18(out_sdv_431, out_l_13, out_extension_5, in_ListOfDeviceObjectsToDelete, out_vslice_dummy_var_288);
    return;
}



procedure {:LoopProcedure} sdv_hash_742206354_loop_L18(in_sdv_431: int, in_l_13: int, in_extension_5: int, in_ListOfDeviceObjectsToDelete: int, in_vslice_dummy_var_288: int) returns (out_sdv_431: int, out_l_13: int, out_extension_5: int, out_vslice_dummy_var_288: int);



implementation sdv_hash_742206354_loop_L11(in_sdv_428: int, in_dispInfo: int, in_l_13: int, in_ListOfDiffAreaFilesToClose_1: int, in_KeepOnDisk_1: int, in_vslice_dummy_var_287: int, in_vslice_dummy_var_289: int) returns (out_sdv_428: int, out_l_13: int, out_vslice_dummy_var_287: int, out_vslice_dummy_var_289: int)
{

  entry:
    out_sdv_428, out_l_13, out_vslice_dummy_var_287, out_vslice_dummy_var_289 := in_sdv_428, in_l_13, in_vslice_dummy_var_287, in_vslice_dummy_var_289;
    goto L11, exit;

  exit:
    return;

  L11:
    call {:si_unique_call 1694} out_sdv_428 := IsListEmpty(in_ListOfDiffAreaFilesToClose_1);
    goto anon7_Then;

  anon7_Then:
    assume {:partition} out_sdv_428 == 0;
    call {:si_unique_call 1698} out_l_13 := RemoveHeadList(in_ListOfDiffAreaFilesToClose_1);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} in_KeepOnDisk_1 != 0;
    assume {:nonnull} in_dispInfo != 0;
    assume in_dispInfo > 0;
    call {:si_unique_call 1697} out_vslice_dummy_var_289 := ZwSetInformationFile(0, 0, 0, 1, 13);
    goto L33;

  L33:
    call {:si_unique_call 1695} out_vslice_dummy_var_287 := ZwClose(0);
    call {:si_unique_call 1696} ExFreePoolWithTag(0, 0);
    goto L33_dummy;

  L33_dummy:
    call {:si_unique_call 1699} {:si_old_unique_call 1} out_sdv_428, out_l_13, out_vslice_dummy_var_287, out_vslice_dummy_var_289 := sdv_hash_742206354_loop_L11(out_sdv_428, in_dispInfo, out_l_13, in_ListOfDiffAreaFilesToClose_1, in_KeepOnDisk_1, out_vslice_dummy_var_287, out_vslice_dummy_var_289);
    return;

  anon9_Then:
    assume {:partition} in_KeepOnDisk_1 == 0;
    goto L33;
}



procedure {:LoopProcedure} sdv_hash_742206354_loop_L11(in_sdv_428: int, in_dispInfo: int, in_l_13: int, in_ListOfDiffAreaFilesToClose_1: int, in_KeepOnDisk_1: int, in_vslice_dummy_var_287: int, in_vslice_dummy_var_289: int) returns (out_sdv_428: int, out_l_13: int, out_vslice_dummy_var_287: int, out_vslice_dummy_var_289: int);
  modifies alloc;
  free ensures out_vslice_dummy_var_287 == 0 || out_vslice_dummy_var_287 == in_vslice_dummy_var_287;
  free ensures out_vslice_dummy_var_289 == 0 || out_vslice_dummy_var_289 == -1073741823 || out_vslice_dummy_var_289 == in_vslice_dummy_var_289;



implementation VolSnapAddDevice_loop_L149(in_s_p_e_c_i_a_l_6: int, in_t: int)
{

  entry:
    goto L149, exit;

  exit:
    return;

  L149:
    assume {:nonnull} in_s_p_e_c_i_a_l_6 != 0;
    assume in_s_p_e_c_i_a_l_6 > 0;
    assume {:nonnull} in_t != 0;
    assume in_t > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_6 != 0;
    assume in_s_p_e_c_i_a_l_6 > 0;
    assume {:nonnull} in_t != 0;
    assume in_t > 0;
    assume {:nonnull} in_s_p_e_c_i_a_l_6 != 0;
    assume in_s_p_e_c_i_a_l_6 > 0;
    assume {:nonnull} in_t != 0;
    assume in_t > 0;
    goto anon18_Then;

  anon18_Then:
    goto anon18_Then_dummy;

  anon18_Then_dummy:
    call {:si_unique_call 1700} {:si_old_unique_call 1} VolSnapAddDevice_loop_L149(in_s_p_e_c_i_a_l_6, in_t);
    return;
}



procedure {:LoopProcedure} VolSnapAddDevice_loop_L149(in_s_p_e_c_i_a_l_6: int, in_t: int);



implementation sdv_hash_172139115_loop_L132(in_diffAreaFile_3: int, in_ll: int, in_sdv_505: int) returns (out_ll: int, out_sdv_505: int)
{

  entry:
    out_ll, out_sdv_505 := in_ll, in_sdv_505;
    goto L132, exit;

  exit:
    return;

  L132:
    assume {:nonnull} in_diffAreaFile_3 != 0;
    assume in_diffAreaFile_3 > 0;
    call {:si_unique_call 1701} out_sdv_505 := IsListEmpty(UnusedAllocationList__VSP_DIFF_AREA_FILE(in_diffAreaFile_3));
    goto anon74_Then;

  anon74_Then:
    assume {:partition} out_sdv_505 == 0;
    assume {:nonnull} in_diffAreaFile_3 != 0;
    assume in_diffAreaFile_3 > 0;
    call {:si_unique_call 1702} out_ll := RemoveHeadList(UnusedAllocationList__VSP_DIFF_AREA_FILE(in_diffAreaFile_3));
    call {:si_unique_call 1703} ExFreePoolWithTag(0, 0);
    goto anon74_Then_dummy;

  anon74_Then_dummy:
    call {:si_unique_call 1704} {:si_old_unique_call 1} out_ll, out_sdv_505 := sdv_hash_172139115_loop_L132(in_diffAreaFile_3, out_ll, out_sdv_505);
    return;
}



procedure {:LoopProcedure} sdv_hash_172139115_loop_L132(in_diffAreaFile_3: int, in_ll: int, in_sdv_505: int) returns (out_ll: int, out_sdv_505: int);
  modifies alloc;



implementation sdv_hash_172139115_loop_L82(in_l_14: int, in_q_4: int, in_oldHeapEntry: int, in_sdv_506: int, in_vslice_dummy_var_325: int) returns (out_l_14: int, out_oldHeapEntry: int, out_sdv_506: int, out_vslice_dummy_var_325: int)
{

  entry:
    out_l_14, out_oldHeapEntry, out_sdv_506, out_vslice_dummy_var_325 := in_l_14, in_oldHeapEntry, in_sdv_506, in_vslice_dummy_var_325;
    goto L82, exit;

  exit:
    return;

  L82:
    call {:si_unique_call 1705} out_sdv_506 := IsListEmpty(in_q_4);
    goto anon69_Then;

  anon69_Then:
    assume {:partition} out_sdv_506 == 0;
    call {:si_unique_call 1710} out_l_14 := RemoveHeadList(in_q_4);
    out_oldHeapEntry := out_l_14;
    assume {:nonnull} out_oldHeapEntry != 0;
    assume out_oldHeapEntry > 0;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    call {:si_unique_call 1708} MmUnlockPages(0);
    call {:si_unique_call 1709} IoFreeMdl(0);
    goto L244;

  L244:
    call {:si_unique_call 1706} out_vslice_dummy_var_325 := ZwUnmapViewOfSection(0, 0);
    call {:si_unique_call 1707} ExFreePoolWithTag(0, 0);
    goto L244_dummy;

  L244_dummy:
    call {:si_unique_call 1711} {:si_old_unique_call 1} out_l_14, out_oldHeapEntry, out_sdv_506, out_vslice_dummy_var_325 := sdv_hash_172139115_loop_L82(out_l_14, in_q_4, out_oldHeapEntry, out_sdv_506, out_vslice_dummy_var_325);
    return;

  anon90_Then:
    goto L244;
}



procedure {:LoopProcedure} sdv_hash_172139115_loop_L82(in_l_14: int, in_q_4: int, in_oldHeapEntry: int, in_sdv_506: int, in_vslice_dummy_var_325: int) returns (out_l_14: int, out_oldHeapEntry: int, out_sdv_506: int, out_vslice_dummy_var_325: int);
  modifies alloc;
  free ensures out_vslice_dummy_var_325 == -1073741823 || out_vslice_dummy_var_325 == -1073741811 || out_vslice_dummy_var_325 == 0 || out_vslice_dummy_var_325 == in_vslice_dummy_var_325;



implementation sdv_hash_172139115_loop_L34(in_sdv_498: int, in_l_14: int, in_oldHeapEntry: int, in_Extension_13: int, in_vslice_dummy_var_326: int) returns (out_sdv_498: int, out_l_14: int, out_oldHeapEntry: int, out_vslice_dummy_var_326: int)
{

  entry:
    out_sdv_498, out_l_14, out_oldHeapEntry, out_vslice_dummy_var_326 := in_sdv_498, in_l_14, in_oldHeapEntry, in_vslice_dummy_var_326;
    goto L34, exit;

  exit:
    return;

  L34:
    assume {:nonnull} in_Extension_13 != 0;
    assume in_Extension_13 > 0;
    call {:si_unique_call 1712} out_sdv_498 := IsListEmpty(OldHeaps_VOLUME_EXTENSION(in_Extension_13));
    goto anon63_Then;

  anon63_Then:
    assume {:partition} out_sdv_498 == 0;
    assume {:nonnull} in_Extension_13 != 0;
    assume in_Extension_13 > 0;
    call {:si_unique_call 1713} out_l_14 := RemoveHeadList(OldHeaps_VOLUME_EXTENSION(in_Extension_13));
    out_oldHeapEntry := out_l_14;
    call {:si_unique_call 1714} out_vslice_dummy_var_326 := ZwUnmapViewOfSection(0, 0);
    call {:si_unique_call 1715} ExFreePoolWithTag(0, 0);
    goto anon63_Then_dummy;

  anon63_Then_dummy:
    call {:si_unique_call 1716} {:si_old_unique_call 1} out_sdv_498, out_l_14, out_oldHeapEntry, out_vslice_dummy_var_326 := sdv_hash_172139115_loop_L34(out_sdv_498, out_l_14, out_oldHeapEntry, in_Extension_13, out_vslice_dummy_var_326);
    return;
}



procedure {:LoopProcedure} sdv_hash_172139115_loop_L34(in_sdv_498: int, in_l_14: int, in_oldHeapEntry: int, in_Extension_13: int, in_vslice_dummy_var_326: int) returns (out_sdv_498: int, out_l_14: int, out_oldHeapEntry: int, out_vslice_dummy_var_326: int);
  modifies alloc;
  free ensures out_vslice_dummy_var_326 == -1073741823 || out_vslice_dummy_var_326 == -1073741811 || out_vslice_dummy_var_326 == 0 || out_vslice_dummy_var_326 == in_vslice_dummy_var_326;



implementation sdv_hash_141061226_loop_L31(in_diffAreaFile_5: int, in_sdv_544: int, in_ll_1: int) returns (out_sdv_544: int, out_ll_1: int)
{

  entry:
    out_sdv_544, out_ll_1 := in_sdv_544, in_ll_1;
    goto L31, exit;

  exit:
    return;

  L31:
    assume {:nonnull} in_diffAreaFile_5 != 0;
    assume in_diffAreaFile_5 > 0;
    call {:si_unique_call 1717} out_sdv_544 := IsListEmpty(UnusedAllocationList__VSP_DIFF_AREA_FILE(in_diffAreaFile_5));
    goto anon14_Then;

  anon14_Then:
    assume {:partition} out_sdv_544 == 0;
    assume {:nonnull} in_diffAreaFile_5 != 0;
    assume in_diffAreaFile_5 > 0;
    call {:si_unique_call 1718} out_ll_1 := RemoveHeadList(UnusedAllocationList__VSP_DIFF_AREA_FILE(in_diffAreaFile_5));
    call {:si_unique_call 1719} ExFreePoolWithTag(0, 0);
    goto anon14_Then_dummy;

  anon14_Then_dummy:
    call {:si_unique_call 1720} {:si_old_unique_call 1} out_sdv_544, out_ll_1 := sdv_hash_141061226_loop_L31(in_diffAreaFile_5, out_sdv_544, out_ll_1);
    return;
}



procedure {:LoopProcedure} sdv_hash_141061226_loop_L31(in_diffAreaFile_5: int, in_sdv_544: int, in_ll_1: int) returns (out_sdv_544: int, out_ll_1: int);
  modifies alloc;



implementation sdv_hash_17066757#0_loop_L176(in_l_15: int, in_sdv_533: int, in_extension_8: int, in_Filter_27: int) returns (out_l_15: int, out_sdv_533: int, out_extension_8: int)
{

  entry:
    out_l_15, out_sdv_533, out_extension_8 := in_l_15, in_sdv_533, in_extension_8;
    goto L176, exit;

  exit:
    return;

  L176:
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    call {:si_unique_call 1721} out_sdv_533 := IsListEmpty(DeadVolumeList_FILTER_EXTENSION(in_Filter_27));
    goto anon89_Else;

  anon89_Else:
    assume {:partition} out_sdv_533 == 0;
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    call {:si_unique_call 1722} out_l_15 := RemoveHeadList(DeadVolumeList_FILTER_EXTENSION(in_Filter_27));
    out_extension_8 := out_l_15;
    goto anon89_Else_dummy;

  anon89_Else_dummy:
    call {:si_unique_call 1723} {:si_old_unique_call 1} out_l_15, out_sdv_533, out_extension_8 := sdv_hash_17066757#0_loop_L176(out_l_15, out_sdv_533, out_extension_8, in_Filter_27);
    return;
}



procedure {:LoopProcedure} sdv_hash_17066757#0_loop_L176(in_l_15: int, in_sdv_533: int, in_extension_8: int, in_Filter_27: int) returns (out_l_15: int, out_sdv_533: int, out_extension_8: int);



implementation sdv_hash_17066757#0_loop_L254(in_sdv_510: int, in_listOfDiffAreaFilesToCloseKeep: int, in_f: int, in_diffAreaFile_4: int, in_listOfDiffAreaFilesToClose: int, in_b: int, in_last: int, in_listOfDeviceObjectsToDelete: int, in_protectMode: int, in_extension_8: int, in_vslice_dummy_var_339: int, in_vslice_dummy_var_340: int) returns (out_sdv_510: int, out_b: int, out_last: int, out_extension_8: int, out_vslice_dummy_var_339: int, out_vslice_dummy_var_340: int)
{

  entry:
    out_sdv_510, out_b, out_last, out_extension_8, out_vslice_dummy_var_339, out_vslice_dummy_var_340 := in_sdv_510, in_b, in_last, in_extension_8, in_vslice_dummy_var_339, in_vslice_dummy_var_340;
    goto L254, exit;

  exit:
    return;

  L254:
    assume {:nonnull} in_f != 0;
    assume in_f > 0;
    call {:si_unique_call 1724} out_sdv_510 := IsListEmpty(VolumeList_FILTER_EXTENSION(in_f));
    goto anon94_Then;

  anon94_Then:
    assume {:partition} out_sdv_510 == 0;
    assume {:nonnull} in_f != 0;
    assume in_f > 0;
    havoc out_extension_8;
    assume {:nonnull} in_diffAreaFile_4 != 0;
    assume in_diffAreaFile_4 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    out_last := 1;
    goto L266;

  L266:
    assume {:nonnull} in_f != 0;
    assume in_f > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    goto L268;

  L268:
    call {:si_unique_call 1725} out_vslice_dummy_var_339 := sdv_hash_210112601(in_f, in_listOfDiffAreaFilesToCloseKeep, in_listOfDeviceObjectsToDelete, 1, 1, 0);
    goto L271;

  L271:
    out_b := 1;
    goto anon106_Then;

  anon106_Then:
    assume {:partition} out_last == 0;
    goto anon106_Then_dummy;

  anon106_Then_dummy:
    call {:si_unique_call 1727} {:si_old_unique_call 1} out_sdv_510, out_b, out_last, out_extension_8, out_vslice_dummy_var_339, out_vslice_dummy_var_340 := sdv_hash_17066757#0_loop_L254(out_sdv_510, in_listOfDiffAreaFilesToCloseKeep, in_f, in_diffAreaFile_4, in_listOfDiffAreaFilesToClose, out_b, out_last, in_listOfDeviceObjectsToDelete, in_protectMode, out_extension_8, out_vslice_dummy_var_339, out_vslice_dummy_var_340);
    return;

  anon96_Then:
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} in_protectMode == 0;
    call {:si_unique_call 1726} out_vslice_dummy_var_340 := sdv_hash_210112601(in_f, in_listOfDiffAreaFilesToClose, in_listOfDeviceObjectsToDelete, 0, 1, 0);
    goto L271;

  anon97_Then:
    assume {:partition} in_protectMode != 0;
    goto L268;

  anon105_Then:
    out_last := 0;
    goto L266;
}



procedure {:LoopProcedure} sdv_hash_17066757#0_loop_L254(in_sdv_510: int, in_listOfDiffAreaFilesToCloseKeep: int, in_f: int, in_diffAreaFile_4: int, in_listOfDiffAreaFilesToClose: int, in_b: int, in_last: int, in_listOfDeviceObjectsToDelete: int, in_protectMode: int, in_extension_8: int, in_vslice_dummy_var_339: int, in_vslice_dummy_var_340: int) returns (out_sdv_510: int, out_b: int, out_last: int, out_extension_8: int, out_vslice_dummy_var_339: int, out_vslice_dummy_var_340: int);
  modifies alloc, ref, Mem_T.Type_unnamed_tag_26, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures out_b == 1 || out_b == in_b;
  free ensures out_last == 1 || out_last == 0 || out_last == in_last;
  free ensures out_vslice_dummy_var_339 == -1073741811 || out_vslice_dummy_var_339 == 0 || out_vslice_dummy_var_339 == in_vslice_dummy_var_339;
  free ensures out_vslice_dummy_var_340 == -1073741811 || out_vslice_dummy_var_340 == 0 || out_vslice_dummy_var_340 == in_vslice_dummy_var_340;



implementation sdv_hash_17066757#0_loop_L148(in_sdv_510: int, in_sdv_513: int, in_listOfDiffAreaFilesToCloseKeep: int, in_f: int, in_diffAreaFile_4: int, in_listOfDiffAreaFilesToClose: int, in_b: int, in_Tmp_671: int, in_last: int, in_l_15: int, in_listOfDeviceObjectsToDelete: int, in_status_23: int, in_protectMode: int, in_extension_8: int, in_Filter_27: int, in_IsOffline: int, in_IsClusterUnexpectedOffline: int, in_vslice_dummy_var_337: int, in_vslice_dummy_var_338: int, in_vslice_dummy_var_339: int, in_vslice_dummy_var_340: int) returns (out_sdv_510: int, out_sdv_513: int, out_f: int, out_diffAreaFile_4: int, out_b: int, out_Tmp_671: int, out_last: int, out_l_15: int, out_status_23: int, out_protectMode: int, out_extension_8: int, out_vslice_dummy_var_337: int, out_vslice_dummy_var_338: int, out_vslice_dummy_var_339: int, out_vslice_dummy_var_340: int)
{
  var vslice_dummy_var_1364: int;
  var vslice_dummy_var_1365: int;
  var vslice_dummy_var_1366: int;
  var vslice_dummy_var_1367: int;

  entry:
    out_sdv_510, out_sdv_513, out_f, out_diffAreaFile_4, out_b, out_Tmp_671, out_last, out_l_15, out_status_23, out_protectMode, out_extension_8, out_vslice_dummy_var_337, out_vslice_dummy_var_338, out_vslice_dummy_var_339, out_vslice_dummy_var_340 := in_sdv_510, in_sdv_513, in_f, in_diffAreaFile_4, in_b, in_Tmp_671, in_last, in_l_15, in_status_23, in_protectMode, in_extension_8, in_vslice_dummy_var_337, in_vslice_dummy_var_338, in_vslice_dummy_var_339, in_vslice_dummy_var_340;
    goto L148, exit;

  exit:
    return;

  L148:
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    call {:si_unique_call 1728} out_sdv_513 := IsListEmpty(DiffAreaFilesOnThisFilter_FILTER_EXTENSION(in_Filter_27));
    goto anon84_Then;

  anon84_Then:
    assume {:partition} out_sdv_513 == 0;
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    havoc out_l_15;
    out_diffAreaFile_4 := out_l_15;
    assume {:nonnull} out_diffAreaFile_4 != 0;
    assume out_diffAreaFile_4 > 0;
    havoc out_Tmp_671;
    assume {:nonnull} out_Tmp_671 != 0;
    assume out_Tmp_671 > 0;
    havoc out_f;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume {:partition} in_IsClusterUnexpectedOffline != 0;
    call {:si_unique_call 1738} out_vslice_dummy_var_337 := sdv_hash_1038281869(out_f, 0, 0, 0);
    call {:si_unique_call 1739} out_status_23 := sdv_hash_208558080(out_f, 0);
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} out_status_23 >= 0;
    call {:si_unique_call 1740} out_status_23 := sdv_hash_206641207(out_f, 0);
    goto anon92_Then;

  anon92_Then:
    assume {:partition} 0 > out_status_23;
    goto L226;

  L226:
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    call {:si_unique_call 1735} out_protectMode := sdv_hash_185580169(out_f, 14, 0, 1703937);
    goto L250;

  L250:
    call {:si_unique_call 1734} out_vslice_dummy_var_338 := sdv_hash_1038281869(out_f, 0, 0, 0);
    out_b := 0;
    goto L254;

  L254:
    call {:si_unique_call 1732} out_sdv_510, out_b, out_last, out_extension_8, out_vslice_dummy_var_339, out_vslice_dummy_var_340 := sdv_hash_17066757#0_loop_L254(out_sdv_510, in_listOfDiffAreaFilesToCloseKeep, out_f, out_diffAreaFile_4, in_listOfDiffAreaFilesToClose, out_b, out_last, in_listOfDeviceObjectsToDelete, out_protectMode, out_extension_8, out_vslice_dummy_var_339, out_vslice_dummy_var_340);
    goto L254_last;

  L254_last:
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    call {:si_unique_call 1733} out_sdv_510 := IsListEmpty(VolumeList_FILTER_EXTENSION(out_f));
    goto anon94_Then, anon94_Else;

  anon94_Else:
    assume {:partition} out_sdv_510 != 0;
    goto L259;

  L259:
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} out_b != 0;
    call {:si_unique_call 1729} IoInvalidateDeviceRelations(0, 0);
    goto anon95_Else_dummy;

  anon95_Else_dummy:
    goto L_BAF_3;

  L_BAF_3:
    call {:si_unique_call 1741} {:si_old_unique_call 1} out_sdv_510, out_sdv_513, out_f, out_diffAreaFile_4, out_b, out_Tmp_671, out_last, out_l_15, out_status_23, out_protectMode, out_extension_8, out_vslice_dummy_var_337, out_vslice_dummy_var_338, out_vslice_dummy_var_339, out_vslice_dummy_var_340 := sdv_hash_17066757#0_loop_L148(out_sdv_510, out_sdv_513, in_listOfDiffAreaFilesToCloseKeep, out_f, out_diffAreaFile_4, in_listOfDiffAreaFilesToClose, out_b, out_Tmp_671, out_last, out_l_15, in_listOfDeviceObjectsToDelete, out_status_23, out_protectMode, out_extension_8, in_Filter_27, in_IsOffline, in_IsClusterUnexpectedOffline, out_vslice_dummy_var_337, out_vslice_dummy_var_338, out_vslice_dummy_var_339, out_vslice_dummy_var_340);
    return;

  anon95_Then:
    assume {:partition} out_b == 0;
    goto anon95_Then_dummy;

  anon95_Then_dummy:
    goto L_BAF_3;

  anon94_Then:
    assume {:partition} out_sdv_510 == 0;
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    havoc out_extension_8;
    assume {:nonnull} out_diffAreaFile_4 != 0;
    assume out_diffAreaFile_4 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    out_last := 1;
    goto L266;

  L266:
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    goto L268;

  L268:
    call {:si_unique_call 1730} out_vslice_dummy_var_339 := sdv_hash_210112601(out_f, in_listOfDiffAreaFilesToCloseKeep, in_listOfDeviceObjectsToDelete, 1, 1, 0);
    goto L271;

  L271:
    out_b := 1;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:partition} out_last != 0;
    goto L259;

  anon106_Then:
    assume {:partition} out_last == 0;
    assume false;
    return;

  anon96_Then:
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} out_protectMode == 0;
    call {:si_unique_call 1731} out_vslice_dummy_var_340 := sdv_hash_210112601(out_f, in_listOfDiffAreaFilesToClose, in_listOfDeviceObjectsToDelete, 0, 1, 0);
    goto L271;

  anon97_Then:
    assume {:partition} out_protectMode != 0;
    goto L268;

  anon105_Then:
    out_last := 0;
    goto L266;

  anon90_Then:
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} in_IsOffline != 0;
    assume {:nonnull} out_diffAreaFile_4 != 0;
    assume out_diffAreaFile_4 > 0;
    havoc vslice_dummy_var_1364;
    havoc vslice_dummy_var_1365;
    call {:si_unique_call 1736} sdv_hash_570003108(vslice_dummy_var_1364, vslice_dummy_var_1365, -1073348548, 0, 0, 1);
    goto L283;

  L283:
    out_protectMode := 0;
    goto L250;

  anon93_Then:
    assume {:partition} in_IsOffline == 0;
    assume {:nonnull} out_diffAreaFile_4 != 0;
    assume out_diffAreaFile_4 > 0;
    havoc vslice_dummy_var_1366;
    havoc vslice_dummy_var_1367;
    call {:si_unique_call 1737} sdv_hash_570003108(vslice_dummy_var_1366, vslice_dummy_var_1367, -1073348592, 0, 3, 1);
    goto L283;

  anon91_Then:
    assume {:partition} 0 > out_status_23;
    goto L226;

  anon104_Then:
    assume {:partition} in_IsClusterUnexpectedOffline == 0;
    goto L226;
}



procedure {:LoopProcedure} sdv_hash_17066757#0_loop_L148(in_sdv_510: int, in_sdv_513: int, in_listOfDiffAreaFilesToCloseKeep: int, in_f: int, in_diffAreaFile_4: int, in_listOfDiffAreaFilesToClose: int, in_b: int, in_Tmp_671: int, in_last: int, in_l_15: int, in_listOfDeviceObjectsToDelete: int, in_status_23: int, in_protectMode: int, in_extension_8: int, in_Filter_27: int, in_IsOffline: int, in_IsClusterUnexpectedOffline: int, in_vslice_dummy_var_337: int, in_vslice_dummy_var_338: int, in_vslice_dummy_var_339: int, in_vslice_dummy_var_340: int) returns (out_sdv_510: int, out_sdv_513: int, out_f: int, out_diffAreaFile_4: int, out_b: int, out_Tmp_671: int, out_last: int, out_l_15: int, out_status_23: int, out_protectMode: int, out_extension_8: int, out_vslice_dummy_var_337: int, out_vslice_dummy_var_338: int, out_vslice_dummy_var_339: int, out_vslice_dummy_var_340: int);
  modifies alloc, ref, Mem_T.Type_unnamed_tag_26, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures out_b == 1 || out_b == 0 || out_b == in_b;
  free ensures out_last == 1 || out_last == 0 || out_last == in_last;
  free ensures out_protectMode == 1 || out_protectMode == 0 || out_protectMode == in_protectMode;
  free ensures out_vslice_dummy_var_337 == 0 || out_vslice_dummy_var_337 == -1073741811 || out_vslice_dummy_var_337 == in_vslice_dummy_var_337;
  free ensures out_vslice_dummy_var_338 == 0 || out_vslice_dummy_var_338 == -1073741811 || out_vslice_dummy_var_338 == in_vslice_dummy_var_338;
  free ensures out_vslice_dummy_var_339 == -1073741811 || out_vslice_dummy_var_339 == 0 || out_vslice_dummy_var_339 == in_vslice_dummy_var_339;
  free ensures out_vslice_dummy_var_340 == -1073741811 || out_vslice_dummy_var_340 == 0 || out_vslice_dummy_var_340 == in_vslice_dummy_var_340;



implementation sdv_hash_17066757#0_loop_L285(in_f: int, in_l_15: int, in_Filter_27: int) returns (out_f: int, out_l_15: int)
{

  entry:
    out_f, out_l_15 := in_f, in_l_15;
    goto L285, exit;

  exit:
    return;

  L285:
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    goto anon107_Else;

  anon107_Else:
    out_f := out_l_15;
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    goto L288;

  L288:
    assume {:nonnull} out_l_15 != 0;
    assume out_l_15 > 0;
    havoc out_l_15;
    goto L288_dummy;

  L288_dummy:
    call {:si_unique_call 1742} {:si_old_unique_call 1} out_f, out_l_15 := sdv_hash_17066757#0_loop_L285(out_f, out_l_15, in_Filter_27);
    return;

  anon108_Then:
    goto L288;
}



procedure {:LoopProcedure} sdv_hash_17066757#0_loop_L285(in_f: int, in_l_15: int, in_Filter_27: int) returns (out_f: int, out_l_15: int);



implementation sdv_hash_17066757#0_loop_L132(in_listOfDiffAreaFilesToCloseKeep: int, in_b: int, in_listOfDeviceObjectsToDelete: int, in_sdv_539: int, in_Filter_27: int, in_vslice_dummy_var_333: int) returns (out_b: int, out_sdv_539: int, out_vslice_dummy_var_333: int)
{

  entry:
    out_b, out_sdv_539, out_vslice_dummy_var_333 := in_b, in_sdv_539, in_vslice_dummy_var_333;
    goto L132, exit;

  exit:
    return;

  L132:
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    call {:si_unique_call 1743} out_sdv_539 := IsListEmpty(VolumeList_FILTER_EXTENSION(in_Filter_27));
    goto anon78_Then;

  anon78_Then:
    assume {:partition} out_sdv_539 == 0;
    call {:si_unique_call 1744} out_vslice_dummy_var_333 := sdv_hash_210112601(in_Filter_27, in_listOfDiffAreaFilesToCloseKeep, in_listOfDeviceObjectsToDelete, 1, 1, 0);
    out_b := 1;
    goto anon78_Then_dummy;

  anon78_Then_dummy:
    call {:si_unique_call 1745} {:si_old_unique_call 1} out_b, out_sdv_539, out_vslice_dummy_var_333 := sdv_hash_17066757#0_loop_L132(in_listOfDiffAreaFilesToCloseKeep, out_b, in_listOfDeviceObjectsToDelete, out_sdv_539, in_Filter_27, out_vslice_dummy_var_333);
    return;
}



procedure {:LoopProcedure} sdv_hash_17066757#0_loop_L132(in_listOfDiffAreaFilesToCloseKeep: int, in_b: int, in_listOfDeviceObjectsToDelete: int, in_sdv_539: int, in_Filter_27: int, in_vslice_dummy_var_333: int) returns (out_b: int, out_sdv_539: int, out_vslice_dummy_var_333: int);
  modifies alloc, ref, Mem_T.Type_unnamed_tag_26, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures out_b == 1 || out_b == in_b;
  free ensures out_vslice_dummy_var_333 == -1073741811 || out_vslice_dummy_var_333 == 0 || out_vslice_dummy_var_333 == in_vslice_dummy_var_333;



implementation sdv_hash_17066757#1_loop_L176(in_l_15: int, in_sdv_533: int, in_extension_8: int, in_Filter_27: int) returns (out_l_15: int, out_sdv_533: int, out_extension_8: int)
{

  entry:
    out_l_15, out_sdv_533, out_extension_8 := in_l_15, in_sdv_533, in_extension_8;
    goto L176, exit;

  exit:
    return;

  L176:
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    call {:si_unique_call 1746} out_sdv_533 := IsListEmpty(DeadVolumeList_FILTER_EXTENSION(in_Filter_27));
    goto anon89_Else;

  anon89_Else:
    assume {:partition} out_sdv_533 == 0;
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    call {:si_unique_call 1747} out_l_15 := RemoveHeadList(DeadVolumeList_FILTER_EXTENSION(in_Filter_27));
    out_extension_8 := out_l_15;
    goto anon89_Else_dummy;

  anon89_Else_dummy:
    call {:si_unique_call 1748} {:si_old_unique_call 1} out_l_15, out_sdv_533, out_extension_8 := sdv_hash_17066757#1_loop_L176(out_l_15, out_sdv_533, out_extension_8, in_Filter_27);
    return;
}



procedure {:LoopProcedure} sdv_hash_17066757#1_loop_L176(in_l_15: int, in_sdv_533: int, in_extension_8: int, in_Filter_27: int) returns (out_l_15: int, out_sdv_533: int, out_extension_8: int);



implementation sdv_hash_17066757#1_loop_L254(in_sdv_510: int, in_listOfDiffAreaFilesToCloseKeep: int, in_f: int, in_diffAreaFile_4: int, in_listOfDiffAreaFilesToClose: int, in_b: int, in_last: int, in_listOfDeviceObjectsToDelete: int, in_protectMode: int, in_extension_8: int, in_vslice_dummy_var_353: int, in_vslice_dummy_var_354: int) returns (out_sdv_510: int, out_b: int, out_last: int, out_extension_8: int, out_vslice_dummy_var_353: int, out_vslice_dummy_var_354: int)
{

  entry:
    out_sdv_510, out_b, out_last, out_extension_8, out_vslice_dummy_var_353, out_vslice_dummy_var_354 := in_sdv_510, in_b, in_last, in_extension_8, in_vslice_dummy_var_353, in_vslice_dummy_var_354;
    goto L254, exit;

  exit:
    return;

  L254:
    assume {:nonnull} in_f != 0;
    assume in_f > 0;
    call {:si_unique_call 1749} out_sdv_510 := IsListEmpty(VolumeList_FILTER_EXTENSION(in_f));
    goto anon94_Then;

  anon94_Then:
    assume {:partition} out_sdv_510 == 0;
    assume {:nonnull} in_f != 0;
    assume in_f > 0;
    havoc out_extension_8;
    assume {:nonnull} in_diffAreaFile_4 != 0;
    assume in_diffAreaFile_4 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    out_last := 1;
    goto L266;

  L266:
    assume {:nonnull} in_f != 0;
    assume in_f > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    goto L268;

  L268:
    call {:si_unique_call 1750} out_vslice_dummy_var_353 := sdv_hash_210112601(in_f, in_listOfDiffAreaFilesToCloseKeep, in_listOfDeviceObjectsToDelete, 1, 1, 0);
    goto L271;

  L271:
    out_b := 1;
    goto anon106_Then;

  anon106_Then:
    assume {:partition} out_last == 0;
    goto anon106_Then_dummy;

  anon106_Then_dummy:
    call {:si_unique_call 1752} {:si_old_unique_call 1} out_sdv_510, out_b, out_last, out_extension_8, out_vslice_dummy_var_353, out_vslice_dummy_var_354 := sdv_hash_17066757#1_loop_L254(out_sdv_510, in_listOfDiffAreaFilesToCloseKeep, in_f, in_diffAreaFile_4, in_listOfDiffAreaFilesToClose, out_b, out_last, in_listOfDeviceObjectsToDelete, in_protectMode, out_extension_8, out_vslice_dummy_var_353, out_vslice_dummy_var_354);
    return;

  anon96_Then:
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} in_protectMode == 0;
    call {:si_unique_call 1751} out_vslice_dummy_var_354 := sdv_hash_210112601(in_f, in_listOfDiffAreaFilesToClose, in_listOfDeviceObjectsToDelete, 0, 1, 0);
    goto L271;

  anon97_Then:
    assume {:partition} in_protectMode != 0;
    goto L268;

  anon105_Then:
    out_last := 0;
    goto L266;
}



procedure {:LoopProcedure} sdv_hash_17066757#1_loop_L254(in_sdv_510: int, in_listOfDiffAreaFilesToCloseKeep: int, in_f: int, in_diffAreaFile_4: int, in_listOfDiffAreaFilesToClose: int, in_b: int, in_last: int, in_listOfDeviceObjectsToDelete: int, in_protectMode: int, in_extension_8: int, in_vslice_dummy_var_353: int, in_vslice_dummy_var_354: int) returns (out_sdv_510: int, out_b: int, out_last: int, out_extension_8: int, out_vslice_dummy_var_353: int, out_vslice_dummy_var_354: int);
  modifies alloc, ref, Mem_T.Type_unnamed_tag_26, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures out_b == 1 || out_b == in_b;
  free ensures out_last == 1 || out_last == 0 || out_last == in_last;
  free ensures out_vslice_dummy_var_353 == -1073741811 || out_vslice_dummy_var_353 == 0 || out_vslice_dummy_var_353 == in_vslice_dummy_var_353;
  free ensures out_vslice_dummy_var_354 == -1073741811 || out_vslice_dummy_var_354 == 0 || out_vslice_dummy_var_354 == in_vslice_dummy_var_354;



implementation sdv_hash_17066757#1_loop_L148(in_sdv_510: int, in_sdv_513: int, in_listOfDiffAreaFilesToCloseKeep: int, in_f: int, in_diffAreaFile_4: int, in_listOfDiffAreaFilesToClose: int, in_b: int, in_Tmp_671: int, in_last: int, in_l_15: int, in_listOfDeviceObjectsToDelete: int, in_status_23: int, in_protectMode: int, in_extension_8: int, in_Filter_27: int, in_IsOffline: int, in_IsClusterUnexpectedOffline: int, in_vslice_dummy_var_351: int, in_vslice_dummy_var_352: int, in_vslice_dummy_var_353: int, in_vslice_dummy_var_354: int) returns (out_sdv_510: int, out_sdv_513: int, out_f: int, out_diffAreaFile_4: int, out_b: int, out_Tmp_671: int, out_last: int, out_l_15: int, out_status_23: int, out_protectMode: int, out_extension_8: int, out_vslice_dummy_var_351: int, out_vslice_dummy_var_352: int, out_vslice_dummy_var_353: int, out_vslice_dummy_var_354: int)
{
  var vslice_dummy_var_1368: int;
  var vslice_dummy_var_1369: int;
  var vslice_dummy_var_1370: int;
  var vslice_dummy_var_1371: int;

  entry:
    out_sdv_510, out_sdv_513, out_f, out_diffAreaFile_4, out_b, out_Tmp_671, out_last, out_l_15, out_status_23, out_protectMode, out_extension_8, out_vslice_dummy_var_351, out_vslice_dummy_var_352, out_vslice_dummy_var_353, out_vslice_dummy_var_354 := in_sdv_510, in_sdv_513, in_f, in_diffAreaFile_4, in_b, in_Tmp_671, in_last, in_l_15, in_status_23, in_protectMode, in_extension_8, in_vslice_dummy_var_351, in_vslice_dummy_var_352, in_vslice_dummy_var_353, in_vslice_dummy_var_354;
    goto L148, exit;

  exit:
    return;

  L148:
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    call {:si_unique_call 1753} out_sdv_513 := IsListEmpty(DiffAreaFilesOnThisFilter_FILTER_EXTENSION(in_Filter_27));
    goto anon84_Then;

  anon84_Then:
    assume {:partition} out_sdv_513 == 0;
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    havoc out_l_15;
    out_diffAreaFile_4 := out_l_15;
    assume {:nonnull} out_diffAreaFile_4 != 0;
    assume out_diffAreaFile_4 > 0;
    havoc out_Tmp_671;
    assume {:nonnull} out_Tmp_671 != 0;
    assume out_Tmp_671 > 0;
    havoc out_f;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume {:partition} in_IsClusterUnexpectedOffline != 0;
    call {:si_unique_call 1756} out_vslice_dummy_var_351 := sdv_hash_1038281869(out_f, 0, 0, 0);
    call {:si_unique_call 1757} out_status_23 := sdv_hash_208558080(out_f, 0);
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} out_status_23 >= 0;
    call {:si_unique_call 1755} out_status_23 := sdv_hash_206641207(out_f, 0);
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} out_status_23 >= 0;
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    call {:si_unique_call 1754} sdv_hash_17066757#0(out_f, 1, 0, 0, 1);
    goto anon92_Else_dummy;

  anon92_Else_dummy:
    goto L_BAF_4;

  L_BAF_4:
    call {:si_unique_call 1767} {:si_old_unique_call 1} out_sdv_510, out_sdv_513, out_f, out_diffAreaFile_4, out_b, out_Tmp_671, out_last, out_l_15, out_status_23, out_protectMode, out_extension_8, out_vslice_dummy_var_351, out_vslice_dummy_var_352, out_vslice_dummy_var_353, out_vslice_dummy_var_354 := sdv_hash_17066757#1_loop_L148(out_sdv_510, out_sdv_513, in_listOfDiffAreaFilesToCloseKeep, out_f, out_diffAreaFile_4, in_listOfDiffAreaFilesToClose, out_b, out_Tmp_671, out_last, out_l_15, in_listOfDeviceObjectsToDelete, out_status_23, out_protectMode, out_extension_8, in_Filter_27, in_IsOffline, in_IsClusterUnexpectedOffline, out_vslice_dummy_var_351, out_vslice_dummy_var_352, out_vslice_dummy_var_353, out_vslice_dummy_var_354);
    return;

  anon92_Then:
    assume {:partition} 0 > out_status_23;
    goto L226;

  L226:
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    call {:si_unique_call 1764} out_protectMode := sdv_hash_185580169(out_f, 14, 0, 1703937);
    goto L250;

  L250:
    call {:si_unique_call 1763} out_vslice_dummy_var_352 := sdv_hash_1038281869(out_f, 0, 0, 0);
    out_b := 0;
    goto L254;

  L254:
    call {:si_unique_call 1761} out_sdv_510, out_b, out_last, out_extension_8, out_vslice_dummy_var_353, out_vslice_dummy_var_354 := sdv_hash_17066757#1_loop_L254(out_sdv_510, in_listOfDiffAreaFilesToCloseKeep, out_f, out_diffAreaFile_4, in_listOfDiffAreaFilesToClose, out_b, out_last, in_listOfDeviceObjectsToDelete, out_protectMode, out_extension_8, out_vslice_dummy_var_353, out_vslice_dummy_var_354);
    goto L254_last;

  L254_last:
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    call {:si_unique_call 1762} out_sdv_510 := IsListEmpty(VolumeList_FILTER_EXTENSION(out_f));
    goto anon94_Then, anon94_Else;

  anon94_Else:
    assume {:partition} out_sdv_510 != 0;
    goto L259;

  L259:
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} out_b != 0;
    call {:si_unique_call 1758} IoInvalidateDeviceRelations(0, 0);
    goto anon95_Else_dummy;

  anon95_Else_dummy:
    goto L_BAF_4;

  anon95_Then:
    assume {:partition} out_b == 0;
    goto anon95_Then_dummy;

  anon95_Then_dummy:
    goto L_BAF_4;

  anon94_Then:
    assume {:partition} out_sdv_510 == 0;
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    havoc out_extension_8;
    assume {:nonnull} out_diffAreaFile_4 != 0;
    assume out_diffAreaFile_4 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    out_last := 1;
    goto L266;

  L266:
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    goto L268;

  L268:
    call {:si_unique_call 1759} out_vslice_dummy_var_353 := sdv_hash_210112601(out_f, in_listOfDiffAreaFilesToCloseKeep, in_listOfDeviceObjectsToDelete, 1, 1, 0);
    goto L271;

  L271:
    out_b := 1;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:partition} out_last != 0;
    goto L259;

  anon106_Then:
    assume {:partition} out_last == 0;
    assume false;
    return;

  anon96_Then:
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} out_protectMode == 0;
    call {:si_unique_call 1760} out_vslice_dummy_var_354 := sdv_hash_210112601(out_f, in_listOfDiffAreaFilesToClose, in_listOfDeviceObjectsToDelete, 0, 1, 0);
    goto L271;

  anon97_Then:
    assume {:partition} out_protectMode != 0;
    goto L268;

  anon105_Then:
    out_last := 0;
    goto L266;

  anon90_Then:
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} in_IsOffline != 0;
    assume {:nonnull} out_diffAreaFile_4 != 0;
    assume out_diffAreaFile_4 > 0;
    havoc vslice_dummy_var_1368;
    havoc vslice_dummy_var_1369;
    call {:si_unique_call 1765} sdv_hash_570003108(vslice_dummy_var_1368, vslice_dummy_var_1369, -1073348548, 0, 0, 1);
    goto L283;

  L283:
    out_protectMode := 0;
    goto L250;

  anon93_Then:
    assume {:partition} in_IsOffline == 0;
    assume {:nonnull} out_diffAreaFile_4 != 0;
    assume out_diffAreaFile_4 > 0;
    havoc vslice_dummy_var_1370;
    havoc vslice_dummy_var_1371;
    call {:si_unique_call 1766} sdv_hash_570003108(vslice_dummy_var_1370, vslice_dummy_var_1371, -1073348592, 0, 3, 1);
    goto L283;

  anon91_Then:
    assume {:partition} 0 > out_status_23;
    goto L226;

  anon104_Then:
    assume {:partition} in_IsClusterUnexpectedOffline == 0;
    goto L226;
}



procedure {:LoopProcedure} sdv_hash_17066757#1_loop_L148(in_sdv_510: int, in_sdv_513: int, in_listOfDiffAreaFilesToCloseKeep: int, in_f: int, in_diffAreaFile_4: int, in_listOfDiffAreaFilesToClose: int, in_b: int, in_Tmp_671: int, in_last: int, in_l_15: int, in_listOfDeviceObjectsToDelete: int, in_status_23: int, in_protectMode: int, in_extension_8: int, in_Filter_27: int, in_IsOffline: int, in_IsClusterUnexpectedOffline: int, in_vslice_dummy_var_351: int, in_vslice_dummy_var_352: int, in_vslice_dummy_var_353: int, in_vslice_dummy_var_354: int) returns (out_sdv_510: int, out_sdv_513: int, out_f: int, out_diffAreaFile_4: int, out_b: int, out_Tmp_671: int, out_last: int, out_l_15: int, out_status_23: int, out_protectMode: int, out_extension_8: int, out_vslice_dummy_var_351: int, out_vslice_dummy_var_352: int, out_vslice_dummy_var_353: int, out_vslice_dummy_var_354: int);
  modifies alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK, ref, Mem_T.Type_unnamed_tag_26, Mem_T.CurrentStackLocation_unnamed_tag_6;
  free ensures out_b == 1 || out_b == 0 || out_b == in_b;
  free ensures out_last == 1 || out_last == 0 || out_last == in_last;
  free ensures out_protectMode == 1 || out_protectMode == 0 || out_protectMode == in_protectMode;
  free ensures out_vslice_dummy_var_351 == 0 || out_vslice_dummy_var_351 == -1073741811 || out_vslice_dummy_var_351 == in_vslice_dummy_var_351;
  free ensures out_vslice_dummy_var_352 == 0 || out_vslice_dummy_var_352 == -1073741811 || out_vslice_dummy_var_352 == in_vslice_dummy_var_352;
  free ensures out_vslice_dummy_var_353 == -1073741811 || out_vslice_dummy_var_353 == 0 || out_vslice_dummy_var_353 == in_vslice_dummy_var_353;
  free ensures out_vslice_dummy_var_354 == -1073741811 || out_vslice_dummy_var_354 == 0 || out_vslice_dummy_var_354 == in_vslice_dummy_var_354;



implementation sdv_hash_17066757#1_loop_L285(in_f: int, in_l_15: int, in_Filter_27: int) returns (out_f: int, out_l_15: int)
{

  entry:
    out_f, out_l_15 := in_f, in_l_15;
    goto L285, exit;

  exit:
    return;

  L285:
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    goto anon107_Else;

  anon107_Else:
    out_f := out_l_15;
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:nonnull} out_f != 0;
    assume out_f > 0;
    goto L288;

  L288:
    assume {:nonnull} out_l_15 != 0;
    assume out_l_15 > 0;
    havoc out_l_15;
    goto L288_dummy;

  L288_dummy:
    call {:si_unique_call 1768} {:si_old_unique_call 1} out_f, out_l_15 := sdv_hash_17066757#1_loop_L285(out_f, out_l_15, in_Filter_27);
    return;

  anon108_Then:
    goto L288;
}



procedure {:LoopProcedure} sdv_hash_17066757#1_loop_L285(in_f: int, in_l_15: int, in_Filter_27: int) returns (out_f: int, out_l_15: int);



implementation sdv_hash_17066757#1_loop_L132(in_listOfDiffAreaFilesToCloseKeep: int, in_b: int, in_listOfDeviceObjectsToDelete: int, in_sdv_539: int, in_Filter_27: int, in_vslice_dummy_var_347: int) returns (out_b: int, out_sdv_539: int, out_vslice_dummy_var_347: int)
{

  entry:
    out_b, out_sdv_539, out_vslice_dummy_var_347 := in_b, in_sdv_539, in_vslice_dummy_var_347;
    goto L132, exit;

  exit:
    return;

  L132:
    assume {:nonnull} in_Filter_27 != 0;
    assume in_Filter_27 > 0;
    call {:si_unique_call 1769} out_sdv_539 := IsListEmpty(VolumeList_FILTER_EXTENSION(in_Filter_27));
    goto anon78_Then;

  anon78_Then:
    assume {:partition} out_sdv_539 == 0;
    call {:si_unique_call 1770} out_vslice_dummy_var_347 := sdv_hash_210112601(in_Filter_27, in_listOfDiffAreaFilesToCloseKeep, in_listOfDeviceObjectsToDelete, 1, 1, 0);
    out_b := 1;
    goto anon78_Then_dummy;

  anon78_Then_dummy:
    call {:si_unique_call 1771} {:si_old_unique_call 1} out_b, out_sdv_539, out_vslice_dummy_var_347 := sdv_hash_17066757#1_loop_L132(in_listOfDiffAreaFilesToCloseKeep, out_b, in_listOfDeviceObjectsToDelete, out_sdv_539, in_Filter_27, out_vslice_dummy_var_347);
    return;
}



procedure {:LoopProcedure} sdv_hash_17066757#1_loop_L132(in_listOfDiffAreaFilesToCloseKeep: int, in_b: int, in_listOfDeviceObjectsToDelete: int, in_sdv_539: int, in_Filter_27: int, in_vslice_dummy_var_347: int) returns (out_b: int, out_sdv_539: int, out_vslice_dummy_var_347: int);
  modifies alloc, ref, Mem_T.Type_unnamed_tag_26, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK;
  free ensures out_b == 1 || out_b == in_b;
  free ensures out_vslice_dummy_var_347 == -1073741811 || out_vslice_dummy_var_347 == 0 || out_vslice_dummy_var_347 == in_vslice_dummy_var_347;



procedure fakeMain() returns (Tmp_136: int, dup_assertVar: bool);
  modifies alloc, SLAM_guard_S_0, in_pnp, passed_on, ref, yogi_error, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Type_unnamed_tag_26, sdv_start_info, sdv_end_info, Mem_T.Information__IO_STATUS_BLOCK;



implementation {:entrypoint} fakeMain() returns (Tmp_136: int, dup_assertVar: bool)
{

  start:
    call Tmp_136, dup_assertVar := main();
    assume {:OldAssert} !dup_assertVar;
    return;
}


