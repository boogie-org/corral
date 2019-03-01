var {:scalar} alloc: int;

var {:scalar} yogi_error: int;

var {:scalar} wait_required: int;

var {:pointer} SLAM_guard_S_0: int;

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

const BUS1394_CLASS_GUID: int;

const GUID_1394DIAG: int;

const GUID_1394VDEV: int;

const sdv_cancelFptr: int;

const SLAM_guard_S_0_init: int;

const GUID_POWERBUTTON_ACTION: int;

const GUID_LIDOPEN_POWERSTATE: int;

const GUID_PROCESSOR_PARKING_CORE_OVERRIDE: int;

const GUID_PROCESSOR_PERF_CORE_PARKING_HISTORY: int;

const GUID_PCIEXPRESS_SETTINGS_SUBGROUP: int;

const GUID_PROCESSOR_PERF_INCREASE_TIME: int;

const GUID_DISK_COALESCING_POWERDOWN_TIMEOUT: int;

const GUID_AUDIO_PLAYBACK: int;

const GUID_USERINTERFACEBUTTON_ACTION: int;

const GUID_PROCESSOR_THROTTLE_POLICY: int;

const GUID_PCIEXPRESS_ASPM_POLICY: int;

const GUID_BATTERY_PERCENTAGE_REMAINING: int;

const GUID_NON_ADAPTIVE_INPUT_TIMEOUT: int;

const GUID_ALLOW_RTC_WAKE: int;

const GUID_GLOBAL_USER_PRESENCE: int;

const GUID_BATTERY_DISCHARGE_ACTION_2: int;

const GUID_BATTERY_DISCHARGE_LEVEL_2: int;

const GUID_APPLAUNCH_BUTTON: int;

const GUID_BATTERY_DISCHARGE_FLAGS_1: int;

const GUID_PROCESSOR_ALLOW_THROTTLING: int;

const GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD: int;

const GUID_MONITOR_POWER_ON: int;

const GUID_IDLE_RESILIENCY_PERIOD: int;

const GUID_PROCESSOR_DISTRIBUTE_UTILITY: int;

const GUID_PROCESSOR_PERF_INCREASE_HISTORY: int;

const GUID_INTSTEER_SUBGROUP: int;

const GUID_DISK_BURST_IGNORE_THRESHOLD: int;

const GUID_SLEEPBUTTON_ACTION: int;

const GUID_PROCESSOR_PERF_LATENCY_HINT_PERF: int;

const GUID_PROCESSOR_IDLE_DISABLE: int;

const GUID_DISK_POWERDOWN_TIMEOUT: int;

const GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD: int;

const GUID_DISK_IDLE_TIMEOUT: int;

const GUID_CONSOLE_DISPLAY_STATE: int;

const GUID_ADAPTIVE_POWER_BEHAVIOR_SUBGROUP: int;

const GUID_BATTERY_DISCHARGE_FLAGS_0: int;

const GUID_PROCESSOR_PARKING_HEADROOM_THRESHOLD: int;

const GUID_ACDC_POWER_SOURCE: int;

const GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS: int;

const GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD: int;

const GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME: int;

const GUID_PROCESSOR_THROTTLE_MINIMUM: int;

const GUID_ALLOW_AWAYMODE: int;

const NO_SUBGROUP_GUID: int;

const GUID_DISK_ADAPTIVE_POWERDOWN: int;

const GUID_VIDEO_FULLSCREEN_PLAYBACK: int;

const GUID_SYSTEM_BUTTON_SUBGROUP: int;

const GUID_INTSTEER_TIME_UNPARK_TRIGGER: int;

const GUID_SYSTEM_COOLING_POLICY: int;

const GUID_PROCESSOR_PERF_BOOST_MODE: int;

const ALL_POWERSCHEMES_GUID: int;

const GUID_LIDSWITCH_STATE_CHANGE: int;

const GUID_BATTERY_DISCHARGE_LEVEL_3: int;

const GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY: int;

const GUID_ALLOW_SYSTEM_REQUIRED: int;

const GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS: int;

const GUID_PROCESSOR_IDLE_ALLOW_SCALING: int;

const GUID_LOCK_CONSOLE_ON_WAKE: int;

const GUID_VIDEO_POWERDOWN_TIMEOUT: int;

const GUID_SESSION_DISPLAY_STATUS: int;

const GUID_PROCESSOR_IDLESTATE_POLICY: int;

const GUID_PROCESSOR_IDLE_TIME_CHECK: int;

const GUID_ALLOW_DISPLAY_REQUIRED: int;

const GUID_UNATTEND_SLEEP_TIMEOUT: int;

const GUID_INTSTEER_MODE: int;

const GUID_IDLE_RESILIENCY_PLATFORM_STATE: int;

const GUID_CRITICAL_POWER_TRANSITION: int;

const GUID_PROCESSOR_PERF_INCREASE_THRESHOLD: int;

const GUID_BACKGROUND_TASK_NOTIFICATION: int;

const GUID_SLEEP_IDLE_THRESHOLD: int;

const GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY: int;

const GUID_PROCESSOR_PERF_HISTORY: int;

const GUID_PROCESSOR_IDLE_STATE_MAXIMUM: int;

const GUID_VIDEO_ANNOYANCE_TIMEOUT: int;

const GUID_BATTERY_DISCHARGE_FLAGS_3: int;

const GUID_PROCESSOR_THROTTLE_MAXIMUM: int;

const GUID_PROCESSOR_CORE_PARKING_MAX_CORES: int;

const GUID_PROCESSOR_PARKING_PERF_STATE: int;

const GUID_PROCESSOR_PERF_DECREASE_POLICY: int;

const GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE: int;

const GUID_VIDEO_ADAPTIVE_POWERDOWN: int;

const GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD: int;

const GUID_MIN_POWER_SAVINGS: int;

const GUID_VIDEO_CONSOLE_LOCK_TIMEOUT: int;

const GUID_ALLOW_STANDBY_STATES: int;

const GUID_PROCESSOR_PERF_LATENCY_HINT: int;

const GUID_STANDBY_TIMEOUT: int;

const GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD: int;

const GUID_DEVICE_IDLE_POLICY: int;

const GUID_PROCESSOR_PERFSTATE_POLICY: int;

const GUID_PROCESSOR_PERF_BOOST_POLICY: int;

const GUID_SESSION_USER_PRESENCE: int;

const GUID_LIDCLOSE_ACTION: int;

const GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS: int;

const GUID_EXECUTION_REQUIRED_REQUEST_TIMEOUT: int;

const GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD: int;

const GUID_SLEEP_SUBGROUP: int;

const GUID_BATTERY_DISCHARGE_ACTION_1: int;

const GUID_PROCESSOR_PERF_INCREASE_POLICY: int;

const GUID_VIDEO_SUBGROUP: int;

const GUID_PROCESSOR_PERF_DECREASE_TIME: int;

const GUID_MAX_POWER_SAVINGS: int;

const GUID_TYPICAL_POWER_SAVINGS: int;

const GUID_HIBERNATE_FASTS4_POLICY: int;

const GUID_BATTERY_SUBGROUP: int;

const GUID_PROCESSOR_PERF_DECREASE_HISTORY: int;

const GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR: int;

const GUID_PROCESSOR_SETTINGS_SUBGROUP: int;

const GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS: int;

const GUID_IDLE_BACKGROUND_TASK: int;

const GUID_BATTERY_DISCHARGE_FLAGS_2: int;

const GUID_DISK_SUBGROUP: int;

const GUID_HIBERNATE_TIMEOUT: int;

const GUID_POWERSCHEME_PERSONALITY: int;

const GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME: int;

const GUID_BATTERY_DISCHARGE_LEVEL_1: int;

const GUID_BATTERY_DISCHARGE_ACTION_0: int;

const GUID_IDLE_RESILIENCY_SUBGROUP: int;

const GUID_ENABLE_SWITCH_FORCED_SHUTDOWN: int;

const GUID_BATTERY_DISCHARGE_ACTION_3: int;

const GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING: int;

const GUID_INTSTEER_LOAD_PER_PROC_TRIGGER: int;

const GUID_PROCESSOR_PERF_DECREASE_THRESHOLD: int;

const GUID_BATTERY_DISCHARGE_LEVEL_0: int;

const GUID_PROCESSOR_CORE_PARKING_MIN_CORES: int;

const GUID_PROCESSOR_PARKING_CONCURRENCY_THRESHOLD: int;

const GUID_VIDEO_DIM_TIMEOUT: int;

const GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD: int;

const GUID_ACTIVE_POWERSCHEME: int;

const GUID_SYSTEM_AWAYMODE: int;

const GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR: int;

const GUID_PROCESSOR_PERF_TIME_CHECK: int;

const GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING: int;

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

const sdv_start_irp_already_issued: int;

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

const sdv_isr_routine: int;

const sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT: int;

const sdv_irp: int;

const sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next: int;

const sdv_IoCreateSynchronizationEvent_KEVENT: int;

const sdv_ControllerPirp: int;

const sdv_other_harnessStackLocation_next: int;

const sdv_harnessStackLocation: int;

const sdv_IoCreateController_CONTROLLER_OBJECT: int;

const sdv_devobj_top: int;

const sdv_kdpc_val3: int;

const sdv_IoBuildSynchronousFsdRequest_harnessIrp: int;

const sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT: int;

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

const sdv_io_create_device_called: int;

const sdv_IoMakeAssociatedIrp_irp: int;

const sdv_other_harnessIrp: int;

const sdv_IoBuildSynchronousFsdRequest_IoStatusBlock: int;

const sdv_IoInitializeIrp_irp: int;

const sdv_inside_init_entrypoint: int;

const sdv_IoCreateNotificationEvent_KEVENT: int;

const sdv_other_harnessStackLocation: int;

const sdv_maskedEflags: int;

const sdv_MmMapIoSpace_int: int;

procedure {:origName "_sdv_init2"} _sdv_init2();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "_sdv_init2"} _sdv_init2()
{
  var vslice_dummy_var_0: int;

  anon0:
    call {:si_unique_call 0} vslice_dummy_var_0 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "t1394VDev_IoControl"} t1394VDev_IoControl(actual_DeviceObject: int, actual_Irp: int) returns (Tmp_3: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_IoControl"} t1394VDev_IoControl(actual_DeviceObject: int, actual_Irp: int) returns (Tmp_3: int)
{
  var {:scalar} i: int;
  var {:pointer} IsochAllocateChannel: int;
  var {:pointer} Get1394Address: int;
  var {:scalar} Tmp_4: int;
  var {:pointer} Tmp_5: int;
  var {:scalar} Tmp_6: int;
  var {:pointer} Tmp_7: int;
  var {:pointer} Tmp_8: int;
  var {:pointer} GetLocalHostInformation: int;
  var {:pointer} MaxSpeedBetweenDevices: int;
  var {:scalar} Tmp_9: int;
  var {:pointer} Tmp_10: int;
  var {:pointer} Tmp_11: int;
  var {:scalar} inputBufferLength: int;
  var {:pointer} Tmp_12: int;
  var {:pointer} IsochStop: int;
  var {:pointer} Tmp_13: int;
  var {:scalar} Tmp_14: int;
  var {:pointer} IsochAllocateResources: int;
  var {:pointer} sdv_17: int;
  var {:pointer} IsochAllocateBandwidth: int;
  var {:pointer} Tmp_15: int;
  var {:pointer} Tmp_16: int;
  var {:pointer} IsochAttachBuffers: int;
  var {:pointer} IrpSp: int;
  var {:pointer} AsyncStream: int;
  var {:pointer} Version: int;
  var {:pointer} Tmp_17: int;
  var {:scalar} sdv_21: int;
  var {:pointer} AsyncWrite: int;
  var {:pointer} AsyncRead: int;
  var {:scalar} ntStatus: int;
  var {:pointer} Tmp_18: int;
  var {:scalar} outputBufferLength: int;
  var {:scalar} Tmp_19: int;
  var {:pointer} SetAddressData: int;
  var {:scalar} ioControlCode: int;
  var {:pointer} BusResetIrp: int;
  var {:pointer} AllocateAddressRange: int;
  var {:pointer} DeviceXmitProperties: int;
  var {:pointer} IsochModifyStreamProperties: int;
  var {:scalar} Irql: int;
  var {:pointer} IsochDetachBuffers: int;
  var {:pointer} IsochListen: int;
  var {:pointer} IsochTalk: int;
  var {:pointer} Tmp_20: int;
  var {:pointer} Tmp_21: int;
  var {:pointer} pTempR3Desc: int;
  var {:pointer} deviceExtension: int;
  var {:scalar} ulBuffSize: int;
  var {:pointer} IsochQueryResources: int;
  var {:pointer} IsochSetChannelBandwidth: int;
  var {:pointer} GetAddressData: int;
  var {:pointer} AsyncLock: int;
  var {:pointer} ioBuffer: int;
  var {:pointer} SetLocalHostInformation: int;
  var {:pointer} Tmp_22: int;
  var {:pointer} DeviceObject: int;
  var {:pointer} Irp: int;
  var vslice_dummy_var_1: int;
  var vslice_dummy_var_2: int;
  var vslice_dummy_var_0: int;
  var vslice_dummy_var_3: int;
  var vslice_dummy_var_4: int;
  var vslice_dummy_var_5: int;
  var vslice_dummy_var_6: int;
  var vslice_dummy_var_7: int;
  var vslice_dummy_var_8: int;
  var vslice_dummy_var_9: int;
  var vslice_dummy_var_10: int;
  var vslice_dummy_var_11: int;
  var vslice_dummy_var_12: int;
  var vslice_dummy_var_13: int;
  var vslice_dummy_var_14: int;
  var vslice_dummy_var_15: int;
  var vslice_dummy_var_16: int;
  var vslice_dummy_var_17: int;
  var vslice_dummy_var_18: int;
  var vslice_dummy_var_19: int;
  var vslice_dummy_var_20: int;
  var vslice_dummy_var_21: int;
  var vslice_dummy_var_22: int;
  var vslice_dummy_var_23: int;
  var vslice_dummy_var_24: int;
  var vslice_dummy_var_25: int;
  var vslice_dummy_var_26: int;
  var vslice_dummy_var_27: int;
  var vslice_dummy_var_28: int;
  var vslice_dummy_var_29: int;
  var vslice_dummy_var_30: int;
  var vslice_dummy_var_31: int;
  var vslice_dummy_var_32: int;
  var vslice_dummy_var_33: int;
  var vslice_dummy_var_34: int;
  var vslice_dummy_var_35: int;
  var vslice_dummy_var_36: int;
  var vslice_dummy_var_37: int;
  var vslice_dummy_var_38: int;
  var vslice_dummy_var_39: int;
  var vslice_dummy_var_40: int;
  var vslice_dummy_var_41: int;
  var vslice_dummy_var_42: int;
  var vslice_dummy_var_43: int;
  var vslice_dummy_var_44: int;
  var vslice_dummy_var_45: int;
  var vslice_dummy_var_46: int;
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
  var vslice_dummy_var_73: int;
  var vslice_dummy_var_74: int;
  var vslice_dummy_var_75: int;
  var vslice_dummy_var_76: int;
  var vslice_dummy_var_77: int;
  var vslice_dummy_var_78: int;
  var vslice_dummy_var_79: int;
  var vslice_dummy_var_80: int;

  anon0:
    call {:si_unique_call 1} Tmp_6 := __HAVOC_malloc(32);
    DeviceObject := actual_DeviceObject;
    Irp := actual_Irp;
    call {:si_unique_call 2} Tmp_18 := __HAVOC_malloc(44);
    call {:si_unique_call 3} Tmp_21 := __HAVOC_malloc(256);
    ntStatus := 0;
    call {:si_unique_call 4} IrpSp := sdv_IoGetCurrentIrpStackLocation(Irp);
    assume {:nonnull} DeviceObject != 0;
    assume DeviceObject > 0;
    havoc deviceExtension;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    havoc ioBuffer;
    assume {:nonnull} IrpSp != 0;
    assume IrpSp > 0;
    havoc inputBufferLength;
    assume {:nonnull} IrpSp != 0;
    assume IrpSp > 0;
    havoc outputBufferLength;
    assume {:nonnull} deviceExtension != 0;
    assume deviceExtension > 0;
    goto anon413_Then, anon413_Else;

  anon413_Else:
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto anon414_Then, anon414_Else;

  anon414_Else:
    assume Irp == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 5} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon415_Then, anon415_Else;

  anon415_Else:
    assume {:partition} yogi_error != 1;
    goto L554;

  L554:
    call {:si_unique_call 6} sdv_IoCompleteRequest(0, 0);
    ntStatus := -1073741810;
    Tmp_3 := ntStatus;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon415_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon414_Then:
    assume !(Irp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L554;

  anon413_Then:
    assume {:nonnull} IrpSp != 0;
    assume IrpSp > 0;
    goto anon307_Then, anon307_Else;

  anon307_Else:
    assume {:nonnull} IrpSp != 0;
    assume IrpSp > 0;
    havoc ioControlCode;
    goto anon416_Then, anon416_Else;

  anon416_Else:
    assume {:partition} ioControlCode != 2236416;
    goto anon412_Then, anon412_Else;

  anon412_Else:
    assume {:partition} ioControlCode != 2236420;
    goto anon411_Then, anon411_Else;

  anon411_Else:
    assume {:partition} ioControlCode != 2236424;
    goto anon410_Then, anon410_Else;

  anon410_Else:
    assume {:partition} ioControlCode != 2236428;
    goto anon409_Then, anon409_Else;

  anon409_Else:
    assume {:partition} ioControlCode != 2236432;
    goto anon408_Then, anon408_Else;

  anon408_Else:
    assume {:partition} ioControlCode != 2236436;
    goto anon407_Then, anon407_Else;

  anon407_Else:
    assume {:partition} ioControlCode != 2236440;
    goto anon406_Then, anon406_Else;

  anon406_Else:
    assume {:partition} ioControlCode != 2236444;
    goto anon405_Then, anon405_Else;

  anon405_Else:
    assume {:partition} ioControlCode != 2236448;
    goto anon404_Then, anon404_Else;

  anon404_Else:
    assume {:partition} ioControlCode != 2236452;
    goto anon403_Then, anon403_Else;

  anon403_Else:
    assume {:partition} ioControlCode != 2236456;
    goto anon402_Then, anon402_Else;

  anon402_Else:
    assume {:partition} ioControlCode != 2236460;
    goto anon401_Then, anon401_Else;

  anon401_Else:
    assume {:partition} ioControlCode != 2236464;
    goto anon400_Then, anon400_Else;

  anon400_Else:
    assume {:partition} ioControlCode != 2236468;
    goto anon399_Then, anon399_Else;

  anon399_Else:
    assume {:partition} ioControlCode != 2236472;
    goto anon398_Then, anon398_Else;

  anon398_Else:
    assume {:partition} ioControlCode != 2236476;
    goto anon397_Then, anon397_Else;

  anon397_Else:
    assume {:partition} ioControlCode != 2236480;
    goto anon396_Then, anon396_Else;

  anon396_Else:
    assume {:partition} ioControlCode != 2236484;
    goto anon395_Then, anon395_Else;

  anon395_Else:
    assume {:partition} ioControlCode != 2236488;
    goto anon394_Then, anon394_Else;

  anon394_Else:
    assume {:partition} ioControlCode != 2236492;
    goto anon393_Then, anon393_Else;

  anon393_Else:
    assume {:partition} ioControlCode != 2236496;
    goto anon392_Then, anon392_Else;

  anon392_Else:
    assume {:partition} ioControlCode != 2236500;
    goto anon391_Then, anon391_Else;

  anon391_Else:
    assume {:partition} ioControlCode != 2236504;
    goto anon390_Then, anon390_Else;

  anon390_Else:
    assume {:partition} ioControlCode != 2236508;
    goto anon389_Then, anon389_Else;

  anon389_Else:
    assume {:partition} ioControlCode != 2236512;
    goto anon388_Then, anon388_Else;

  anon388_Else:
    assume {:partition} ioControlCode != 2236516;
    goto anon387_Then, anon387_Else;

  anon387_Else:
    assume {:partition} ioControlCode != 2236520;
    goto anon386_Then, anon386_Else;

  anon386_Else:
    assume {:partition} ioControlCode != 2236524;
    goto anon385_Then, anon385_Else;

  anon385_Else:
    assume {:partition} ioControlCode != 2236528;
    goto anon384_Then, anon384_Else;

  anon384_Else:
    assume {:partition} ioControlCode != 2236532;
    goto anon383_Then, anon383_Else;

  anon383_Else:
    assume {:partition} ioControlCode != 2236536;
    goto anon382_Then, anon382_Else;

  anon382_Else:
    assume {:partition} ioControlCode != 2236576;
    goto anon381_Then, anon381_Else;

  anon381_Else:
    assume {:partition} ioControlCode != 2236580;
    goto anon380_Then, anon380_Else;

  anon380_Else:
    assume {:partition} ioControlCode != 2236616;
    goto anon379_Then, anon379_Else;

  anon379_Else:
    assume {:partition} ioControlCode != 2236620;
    goto anon378_Then, anon378_Else;

  anon378_Else:
    assume {:partition} ioControlCode == 2236624;
    goto anon317_Then, anon317_Else;

  anon317_Else:
    assume {:partition} 24 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  L78:
    goto anon318_Then, anon318_Else;

  anon318_Else:
    assume {:partition} ntStatus != -1073741810;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto anon417_Then, anon417_Else;

  anon417_Else:
    assume Irp == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 7} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon418_Then, anon418_Else;

  anon418_Else:
    assume {:partition} yogi_error != 1;
    goto L557;

  L557:
    call {:si_unique_call 8} sdv_IoCompleteRequest(0, 0);
    goto L79;

  L79:
    Tmp_3 := ntStatus;
    goto L1;

  anon418_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon417_Then:
    assume !(Irp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L557;

  anon318_Then:
    assume {:partition} ntStatus == -1073741810;
    goto L79;

  anon317_Then:
    assume {:partition} inputBufferLength >= 24;
    IsochModifyStreamProperties := ioBuffer;
    assume {:nonnull} IsochModifyStreamProperties != 0;
    assume IsochModifyStreamProperties > 0;
    havoc vslice_dummy_var_0;
    havoc vslice_dummy_var_3;
    havoc vslice_dummy_var_4;
    call {:si_unique_call 9} ntStatus := t1394_IsochModifyStreamProperties(DeviceObject, Irp, vslice_dummy_var_0, vslice_dummy_var_3, vslice_dummy_var_4);
    goto anon458_Then, anon458_Else;

  anon458_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon458_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon378_Then:
    assume {:partition} ioControlCode != 2236624;
    ntStatus := -1073741811;
    goto L78;

  anon379_Then:
    assume {:partition} ioControlCode == 2236620;
    goto anon319_Then, anon319_Else;

  anon319_Else:
    assume {:partition} 8 > inputBufferLength;
    goto anon320_Then, anon320_Else;

  anon320_Else:
    assume {:partition} 8 > outputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon320_Then:
    assume {:partition} outputBufferLength >= 8;
    goto L89;

  L89:
    Version := ioBuffer;
    assume {:nonnull} Version != 0;
    assume Version > 0;
    assume {:nonnull} Version != 0;
    assume Version > 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon319_Then:
    assume {:partition} inputBufferLength >= 8;
    goto L89;

  anon380_Then:
    assume {:partition} ioControlCode == 2236616;
    call {:si_unique_call 10} sdv_17 := ExAllocatePoolWithTag(512, 12, -164023503);
    BusResetIrp := sdv_17;
    goto anon457_Then, anon457_Else;

  anon457_Else:
    assume {:partition} BusResetIrp != 0;
    ntStatus := 259;
    assume {:nonnull} BusResetIrp != 0;
    assume BusResetIrp > 0;
    call {:si_unique_call 11} Tmp_13 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_13 != 0;
    assume Tmp_13 > 0;
    call {:si_unique_call 12} sdv_KeAcquireSpinLock(0, Tmp_13);
    assume {:nonnull} Tmp_13 != 0;
    assume Tmp_13 > 0;
    havoc Irql;
    assume {:nonnull} BusResetIrp != 0;
    assume BusResetIrp > 0;
    assume {:nonnull} deviceExtension != 0;
    assume deviceExtension > 0;
    call {:si_unique_call 13} InsertHeadList(BusResetIrps__DEVICE_EXTENSION(deviceExtension), BusResetIrpList__BUS_RESET_IRP(BusResetIrp));
    call {:si_unique_call 14} vslice_dummy_var_1 := sdv_IoSetCancelRoutine(Irp, li2bplFunctionConstant226);
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto anon321_Then, anon321_Else;

  anon321_Else:
    call {:si_unique_call 15} sdv_21 := sdv_IoSetCancelRoutine(Irp, 0);
    goto anon322_Then, anon322_Else;

  anon322_Else:
    assume {:partition} sdv_21 != 0;
    call {:si_unique_call 16} vslice_dummy_var_2 := sdv_RemoveEntryList(0);
    ntStatus := -1073741536;
    goto L115;

  L115:
    call {:si_unique_call 17} sdv_KeReleaseSpinLock(0, Irql);
    goto anon323_Then, anon323_Else;

  anon323_Else:
    assume {:partition} ntStatus == 259;
    call {:si_unique_call 18} sdv_IoMarkIrpPending(0);
    goto L79;

  anon323_Then:
    assume {:partition} ntStatus != 259;
    goto L78;

  anon322_Then:
    assume {:partition} sdv_21 == 0;
    goto L115;

  anon321_Then:
    goto L115;

  anon457_Then:
    assume {:partition} BusResetIrp == 0;
    ntStatus := -1073741670;
    goto L78;

  anon381_Then:
    assume {:partition} ioControlCode == 2236580;
    goto anon324_Then, anon324_Else;

  anon324_Else:
    assume {:partition} 16 > inputBufferLength;
    goto L134;

  L134:
    ntStatus := -1073741789;
    goto L78;

  anon324_Then:
    assume {:partition} inputBufferLength >= 16;
    goto anon325_Then, anon325_Else;

  anon325_Else:
    assume {:partition} 16 <= outputBufferLength;
    GetAddressData := ioBuffer;
    assume {:nonnull} GetAddressData != 0;
    assume GetAddressData > 0;
    goto anon456_Then, anon456_Else;

  anon456_Else:
    goto L139;

  L139:
    ntStatus := -1073741789;
    goto L78;

  anon456_Then:
    assume {:nonnull} GetAddressData != 0;
    assume GetAddressData > 0;
    goto anon326_Then, anon326_Else;

  anon326_Else:
    assume {:nonnull} GetAddressData != 0;
    assume GetAddressData > 0;
    havoc vslice_dummy_var_5;
    havoc vslice_dummy_var_6;
    havoc vslice_dummy_var_7;
    call {:si_unique_call 19} ntStatus := t1394_GetAddressData(DeviceObject, Irp, vslice_dummy_var_5, vslice_dummy_var_6, vslice_dummy_var_7, Data__SET_ADDRESS_DATA(GetAddressData));
    goto anon327_Then, anon327_Else;

  anon327_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon327_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon326_Then:
    goto L139;

  anon325_Then:
    assume {:partition} outputBufferLength < 16;
    goto L134;

  anon382_Then:
    assume {:partition} ioControlCode == 2236576;
    goto anon328_Then, anon328_Else;

  anon328_Else:
    assume {:partition} 16 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon328_Then:
    assume {:partition} inputBufferLength >= 16;
    SetAddressData := ioBuffer;
    assume {:nonnull} SetAddressData != 0;
    assume SetAddressData > 0;
    goto anon455_Then, anon455_Else;

  anon455_Else:
    ntStatus := -1073741789;
    goto L78;

  anon455_Then:
    assume {:nonnull} SetAddressData != 0;
    assume SetAddressData > 0;
    havoc vslice_dummy_var_8;
    havoc vslice_dummy_var_9;
    havoc vslice_dummy_var_10;
    call {:si_unique_call 20} ntStatus := t1394_SetAddressData(DeviceObject, Irp, vslice_dummy_var_8, vslice_dummy_var_9, vslice_dummy_var_10, Data__SET_ADDRESS_DATA(SetAddressData));
    goto L78;

  anon383_Then:
    assume {:partition} ioControlCode == 2236536;
    goto anon329_Then, anon329_Else;

  anon329_Else:
    assume {:partition} 12 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon329_Then:
    assume {:partition} inputBufferLength >= 12;
    SetLocalHostInformation := ioBuffer;
    assume {:nonnull} SetLocalHostInformation != 0;
    assume SetLocalHostInformation > 0;
    goto anon453_Then, anon453_Else;

  anon453_Else:
    ntStatus := -1073741789;
    goto L78;

  anon453_Then:
    assume {:nonnull} SetLocalHostInformation != 0;
    assume SetLocalHostInformation > 0;
    havoc vslice_dummy_var_11;
    call {:si_unique_call 21} ntStatus := t1394_SetLocalHostProperties(DeviceObject, Irp, vslice_dummy_var_11, Information__SET_LOCAL_HOST_INFORMATION(SetLocalHostInformation));
    goto anon454_Then, anon454_Else;

  anon454_Else:
    assume {:partition} yogi_error != 1;
    goto anon330_Then, anon330_Else;

  anon330_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon330_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon454_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon384_Then:
    assume {:partition} ioControlCode == 2236532;
    goto anon331_Then, anon331_Else;

  anon331_Else:
    assume {:partition} 28 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon331_Then:
    assume {:partition} inputBufferLength >= 28;
    AsyncStream := ioBuffer;
    assume {:nonnull} AsyncStream != 0;
    assume AsyncStream > 0;
    goto anon451_Then, anon451_Else;

  anon451_Else:
    ntStatus := -1073741789;
    goto L78;

  anon451_Then:
    assume {:nonnull} AsyncStream != 0;
    assume AsyncStream > 0;
    havoc Tmp_4;
    assume {:nonnull} AsyncStream != 0;
    assume AsyncStream > 0;
    havoc vslice_dummy_var_12;
    havoc vslice_dummy_var_13;
    havoc vslice_dummy_var_14;
    havoc vslice_dummy_var_15;
    havoc vslice_dummy_var_16;
    call {:si_unique_call 22} ntStatus := t1394_AsyncStream(DeviceObject, Irp, vslice_dummy_var_12, vslice_dummy_var_13, vslice_dummy_var_14, vslice_dummy_var_15, vslice_dummy_var_16, Tmp_4, Data__ASYNC_STREAM(AsyncStream));
    goto anon452_Then, anon452_Else;

  anon452_Else:
    assume {:partition} yogi_error != 1;
    goto anon332_Then, anon332_Else;

  anon332_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon332_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon452_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon385_Then:
    assume {:partition} ioControlCode == 2236528;
    goto anon316_Then, anon316_Else;

  anon316_Else:
    assume {:partition} 4 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon316_Then:
    assume {:partition} inputBufferLength >= 4;
    Tmp_10 := ioBuffer;
    assume {:nonnull} Tmp_10 != 0;
    assume Tmp_10 > 0;
    havoc Tmp_14;
    call {:si_unique_call 23} ntStatus := t1394_BusResetNotification(DeviceObject, Irp, Tmp_14);
    goto anon450_Then, anon450_Else;

  anon450_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon450_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon386_Then:
    assume {:partition} ioControlCode == 2236524;
    goto anon315_Then, anon315_Else;

  anon315_Else:
    assume {:partition} 8 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon315_Then:
    assume {:partition} inputBufferLength >= 8;
    Tmp_8 := ioBuffer;
    assume {:nonnull} Tmp_6 != 0;
    assume Tmp_6 > 0;
    assume {:nonnull} Tmp_8 != 0;
    assume Tmp_8 > 0;
    assume {:nonnull} Tmp_6 != 0;
    assume Tmp_6 > 0;
    assume {:nonnull} Tmp_8 != 0;
    assume Tmp_8 > 0;
    assume {:nonnull} Tmp_6 != 0;
    assume Tmp_6 > 0;
    assume {:nonnull} Tmp_8 != 0;
    assume Tmp_8 > 0;
    assume {:nonnull} Tmp_6 != 0;
    assume Tmp_6 > 0;
    assume {:nonnull} Tmp_8 != 0;
    assume Tmp_8 > 0;
    assume {:nonnull} Tmp_6 != 0;
    assume Tmp_6 > 0;
    assume {:nonnull} Tmp_8 != 0;
    assume Tmp_8 > 0;
    assume {:nonnull} Tmp_6 != 0;
    assume Tmp_6 > 0;
    assume {:nonnull} Tmp_8 != 0;
    assume Tmp_8 > 0;
    assume {:nonnull} Tmp_6 != 0;
    assume Tmp_6 > 0;
    assume {:nonnull} Tmp_8 != 0;
    assume Tmp_8 > 0;
    assume {:nonnull} Tmp_6 != 0;
    assume Tmp_6 > 0;
    assume {:nonnull} Tmp_8 != 0;
    assume Tmp_8 > 0;
    call {:si_unique_call 24} ntStatus := t1394_SendPhyConfigurationPacket(DeviceObject, Irp, Tmp_6);
    goto anon449_Then, anon449_Else;

  anon449_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon449_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon387_Then:
    assume {:partition} ioControlCode == 2236520;
    goto anon314_Then, anon314_Else;

  anon314_Else:
    assume {:partition} 4 > outputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon314_Then:
    assume {:partition} outputBufferLength >= 4;
    call {:si_unique_call 25} ntStatus := t1394_GetGenerationCount(DeviceObject, Irp, ioBuffer);
    goto anon448_Then, anon448_Else;

  anon448_Else:
    assume {:partition} yogi_error != 1;
    goto anon333_Then, anon333_Else;

  anon333_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon333_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon448_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon388_Then:
    assume {:partition} ioControlCode == 2236516;
    goto anon313_Then, anon313_Else;

  anon313_Else:
    assume {:partition} 4 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon313_Then:
    assume {:partition} inputBufferLength >= 4;
    Tmp_15 := ioBuffer;
    assume {:nonnull} Tmp_15 != 0;
    assume Tmp_15 > 0;
    havoc Tmp_9;
    call {:si_unique_call 26} ntStatus := t1394_BusReset(DeviceObject, Irp, Tmp_9);
    goto anon447_Then, anon447_Else;

  anon447_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon447_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon389_Then:
    assume {:partition} ioControlCode == 2236512;
    call {:si_unique_call 27} ntStatus := t1394_GetConfigurationInformation(DeviceObject, Irp);
    goto L78;

  anon390_Then:
    assume {:partition} ioControlCode == 2236508;
    goto anon334_Then, anon334_Else;

  anon334_Else:
    assume {:partition} 8 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon334_Then:
    assume {:partition} inputBufferLength >= 8;
    DeviceXmitProperties := ioBuffer;
    assume {:nonnull} DeviceXmitProperties != 0;
    assume DeviceXmitProperties > 0;
    havoc vslice_dummy_var_17;
    havoc vslice_dummy_var_18;
    call {:si_unique_call 28} ntStatus := t1394_SetDeviceXmitProperties(DeviceObject, Irp, vslice_dummy_var_17, vslice_dummy_var_18);
    goto anon446_Then, anon446_Else;

  anon446_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon446_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon391_Then:
    assume {:partition} ioControlCode == 2236504;
    goto anon335_Then, anon335_Else;

  anon335_Else:
    assume {:partition} 268 > inputBufferLength;
    goto L222;

  L222:
    ntStatus := -1073741789;
    goto L78;

  anon335_Then:
    assume {:partition} inputBufferLength >= 268;
    goto anon336_Then, anon336_Else;

  anon336_Else:
    assume {:partition} 268 <= outputBufferLength;
    MaxSpeedBetweenDevices := ioBuffer;
    assume {:nonnull} MaxSpeedBetweenDevices != 0;
    assume MaxSpeedBetweenDevices > 0;
    havoc Tmp_21;
    Tmp_20 := Tmp_21;
    assume {:nonnull} MaxSpeedBetweenDevices != 0;
    assume MaxSpeedBetweenDevices > 0;
    havoc vslice_dummy_var_19;
    havoc vslice_dummy_var_20;
    call {:si_unique_call 29} ntStatus := t1394_GetMaxSpeedBetweenDevices(DeviceObject, Irp, vslice_dummy_var_19, vslice_dummy_var_20, Tmp_20, fulSpeed__GET_MAX_SPEED_BETWEEN_DEVICES(MaxSpeedBetweenDevices));
    goto anon445_Then, anon445_Else;

  anon445_Else:
    assume {:partition} yogi_error != 1;
    goto anon337_Then, anon337_Else;

  anon337_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon337_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon445_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon336_Then:
    assume {:partition} outputBufferLength < 268;
    goto L222;

  anon392_Then:
    assume {:partition} ioControlCode == 2236500;
    call {:si_unique_call 30} ntStatus := t1394_Control(DeviceObject, Irp);
    goto L78;

  anon393_Then:
    assume {:partition} ioControlCode == 2236496;
    goto anon338_Then, anon338_Else;

  anon338_Else:
    assume {:partition} 8 > inputBufferLength;
    goto L236;

  L236:
    ntStatus := -1073741789;
    goto L78;

  anon338_Then:
    assume {:partition} inputBufferLength >= 8;
    goto anon339_Then, anon339_Else;

  anon339_Else:
    assume {:partition} 8 <= outputBufferLength;
    Get1394Address := ioBuffer;
    assume {:nonnull} Get1394Address != 0;
    assume Get1394Address > 0;
    havoc vslice_dummy_var_21;
    call {:si_unique_call 31} ntStatus := t1394_Get1394AddressFromDeviceObject(DeviceObject, Irp, vslice_dummy_var_21, NodeAddress__GET_1394_ADDRESS(Get1394Address));
    goto anon444_Then, anon444_Else;

  anon444_Else:
    assume {:partition} yogi_error != 1;
    goto anon340_Then, anon340_Else;

  anon340_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon340_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon444_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon339_Then:
    assume {:partition} outputBufferLength < 8;
    goto L236;

  anon394_Then:
    assume {:partition} ioControlCode == 2236492;
    goto anon341_Then, anon341_Else;

  anon341_Else:
    assume {:partition} 16 > inputBufferLength;
    goto L247;

  L247:
    ntStatus := -1073741789;
    goto L78;

  anon341_Then:
    assume {:partition} inputBufferLength >= 16;
    goto anon342_Then, anon342_Else;

  anon342_Else:
    assume {:partition} 16 <= outputBufferLength;
    GetLocalHostInformation := ioBuffer;
    assume {:nonnull} GetLocalHostInformation != 0;
    assume GetLocalHostInformation > 0;
    havoc vslice_dummy_var_22;
    call {:si_unique_call 32} ntStatus := t1394_GetLocalHostInformation(DeviceObject, Irp, vslice_dummy_var_22, Status__GET_LOCAL_HOST_INFORMATION(GetLocalHostInformation), Information__GET_LOCAL_HOST_INFORMATION(GetLocalHostInformation));
    goto anon443_Then, anon443_Else;

  anon443_Else:
    assume {:partition} yogi_error != 1;
    goto anon343_Then, anon343_Else;

  anon343_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon343_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon443_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon342_Then:
    assume {:partition} outputBufferLength < 16;
    goto L247;

  anon395_Then:
    assume {:partition} ioControlCode == 2236488;
    goto anon344_Then, anon344_Else;

  anon344_Else:
    assume {:partition} 12 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon344_Then:
    assume {:partition} inputBufferLength >= 12;
    IsochTalk := ioBuffer;
    assume {:nonnull} IsochTalk != 0;
    assume IsochTalk > 0;
    havoc vslice_dummy_var_23;
    havoc vslice_dummy_var_24;
    havoc vslice_dummy_var_25;
    call {:si_unique_call 33} ntStatus := t1394_IsochTalk(DeviceObject, Irp, vslice_dummy_var_23, vslice_dummy_var_24, vslice_dummy_var_25);
    goto anon442_Then, anon442_Else;

  anon442_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon442_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon396_Then:
    assume {:partition} ioControlCode == 2236484;
    goto anon345_Then, anon345_Else;

  anon345_Else:
    assume {:partition} 8 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon345_Then:
    assume {:partition} inputBufferLength >= 8;
    IsochStop := ioBuffer;
    assume {:nonnull} IsochStop != 0;
    assume IsochStop > 0;
    havoc vslice_dummy_var_26;
    havoc vslice_dummy_var_27;
    call {:si_unique_call 34} ntStatus := t1394_IsochStop(DeviceObject, Irp, vslice_dummy_var_26, vslice_dummy_var_27);
    goto anon441_Then, anon441_Else;

  anon441_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon441_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon397_Then:
    assume {:partition} ioControlCode == 2236480;
    goto anon346_Then, anon346_Else;

  anon346_Else:
    assume {:partition} 8 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon346_Then:
    assume {:partition} inputBufferLength >= 8;
    IsochSetChannelBandwidth := ioBuffer;
    assume {:nonnull} IsochSetChannelBandwidth != 0;
    assume IsochSetChannelBandwidth > 0;
    havoc vslice_dummy_var_28;
    havoc vslice_dummy_var_29;
    call {:si_unique_call 35} ntStatus := t1394_IsochSetChannelBandwidth(DeviceObject, Irp, vslice_dummy_var_28, vslice_dummy_var_29);
    goto anon440_Then, anon440_Else;

  anon440_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon440_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon398_Then:
    assume {:partition} ioControlCode == 2236476;
    goto anon347_Then, anon347_Else;

  anon347_Else:
    assume {:partition} 16 > inputBufferLength;
    goto L282;

  L282:
    ntStatus := -1073741789;
    goto L78;

  anon347_Then:
    assume {:partition} inputBufferLength >= 16;
    goto anon348_Then, anon348_Else;

  anon348_Else:
    assume {:partition} 16 <= outputBufferLength;
    IsochQueryResources := ioBuffer;
    assume {:nonnull} IsochQueryResources != 0;
    assume IsochQueryResources > 0;
    havoc vslice_dummy_var_30;
    call {:si_unique_call 36} ntStatus := t1394_IsochQueryResources(DeviceObject, Irp, vslice_dummy_var_30, BytesPerFrameAvailable__IRB_REQ_ISOCH_QUERY_RESOURCES(IsochQueryResources), ChannelsAvailable__IRB_REQ_ISOCH_QUERY_RESOURCES(IsochQueryResources));
    goto anon439_Then, anon439_Else;

  anon439_Else:
    assume {:partition} yogi_error != 1;
    goto anon349_Then, anon349_Else;

  anon349_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon349_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon439_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon348_Then:
    assume {:partition} outputBufferLength < 16;
    goto L282;

  anon399_Then:
    assume {:partition} ioControlCode == 2236472;
    goto anon312_Then, anon312_Else;

  anon312_Else:
    assume {:partition} 4 > outputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon312_Then:
    assume {:partition} outputBufferLength >= 4;
    call {:si_unique_call 37} ntStatus := t1394_IsochQueryCurrentCycleTime(DeviceObject, Irp, ioBuffer);
    goto anon438_Then, anon438_Else;

  anon438_Else:
    assume {:partition} yogi_error != 1;
    goto anon350_Then, anon350_Else;

  anon350_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon350_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon438_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon400_Then:
    assume {:partition} ioControlCode == 2236468;
    goto anon351_Then, anon351_Else;

  anon351_Else:
    assume {:partition} 12 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon351_Then:
    assume {:partition} inputBufferLength >= 12;
    IsochListen := ioBuffer;
    assume {:nonnull} IsochListen != 0;
    assume IsochListen > 0;
    havoc vslice_dummy_var_31;
    havoc vslice_dummy_var_32;
    havoc vslice_dummy_var_33;
    call {:si_unique_call 38} ntStatus := t1394_IsochListen(DeviceObject, Irp, vslice_dummy_var_31, vslice_dummy_var_32, vslice_dummy_var_33);
    goto anon437_Then, anon437_Else;

  anon437_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon437_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon401_Then:
    assume {:partition} ioControlCode == 2236464;
    goto anon311_Then, anon311_Else;

  anon311_Else:
    assume {:partition} 4 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon311_Then:
    assume {:partition} inputBufferLength >= 4;
    Tmp_5 := ioBuffer;
    assume {:nonnull} Tmp_5 != 0;
    assume Tmp_5 > 0;
    havoc Tmp_17;
    call {:si_unique_call 39} ntStatus := t1394_IsochFreeResources(DeviceObject, Irp, Tmp_17);
    goto anon436_Then, anon436_Else;

  anon436_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon436_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon402_Then:
    assume {:partition} ioControlCode == 2236460;
    goto anon310_Then, anon310_Else;

  anon310_Else:
    assume {:partition} 4 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon310_Then:
    assume {:partition} inputBufferLength >= 4;
    Tmp_12 := ioBuffer;
    assume {:nonnull} Tmp_12 != 0;
    assume Tmp_12 > 0;
    havoc Tmp_19;
    call {:si_unique_call 40} ntStatus := t1394_IsochFreeChannel(DeviceObject, Irp, Tmp_19);
    goto anon435_Then, anon435_Else;

  anon435_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon435_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon403_Then:
    assume {:partition} ioControlCode == 2236456;
    goto anon309_Then, anon309_Else;

  anon309_Else:
    assume {:partition} 4 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon309_Then:
    assume {:partition} inputBufferLength >= 4;
    Tmp_16 := ioBuffer;
    assume {:nonnull} Tmp_16 != 0;
    assume Tmp_16 > 0;
    havoc Tmp_11;
    call {:si_unique_call 41} ntStatus := t1394_IsochFreeBandwidth(DeviceObject, Irp, Tmp_11);
    goto anon434_Then, anon434_Else;

  anon434_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon434_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon404_Then:
    assume {:partition} ioControlCode == 2236452;
    goto anon352_Then, anon352_Else;

  anon352_Else:
    assume {:partition} 12 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon352_Then:
    assume {:partition} inputBufferLength >= 12;
    IsochDetachBuffers := ioBuffer;
    assume {:nonnull} IsochDetachBuffers != 0;
    assume IsochDetachBuffers > 0;
    havoc vslice_dummy_var_34;
    havoc vslice_dummy_var_35;
    havoc vslice_dummy_var_36;
    call {:si_unique_call 42} ntStatus := t1394_IsochDetachBuffers(DeviceObject, Irp, vslice_dummy_var_34, vslice_dummy_var_35, vslice_dummy_var_36);
    goto anon433_Then, anon433_Else;

  anon433_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon433_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon405_Then:
    assume {:partition} ioControlCode == 2236448;
    IsochAttachBuffers := 0;
    pTempR3Desc := 0;
    ulBuffSize := 0;
    i := 0;
    goto anon429_Then, anon429_Else;

  anon429_Else:
    assume {:partition} 52 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon429_Then:
    assume {:partition} inputBufferLength >= 52;
    IsochAttachBuffers := ioBuffer;
    assume {:nonnull} IsochAttachBuffers != 0;
    assume IsochAttachBuffers > 0;
    havoc Tmp_18;
    pTempR3Desc := Tmp_18;
    ulBuffSize := 16;
    i := 0;
    goto L350;

  L350:
    call {:si_unique_call 43} i, pTempR3Desc, ulBuffSize := t1394VDev_IoControl_loop_L350(i, inputBufferLength, IsochAttachBuffers, pTempR3Desc, ulBuffSize);
    goto L350_last;

  L350_last:
    assume {:nonnull} IsochAttachBuffers != 0;
    assume IsochAttachBuffers > 0;
    goto anon353_Then, anon353_Else;

  anon353_Else:
    goto anon355_Then, anon355_Else;

  anon355_Else:
    assume {:partition} BAND(pTempR3Desc, 3) != 0;
    ntStatus := -1073741811;
    goto L351;

  L351:
    goto anon354_Then, anon354_Else;

  anon354_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} IsochAttachBuffers != 0;
    assume IsochAttachBuffers > 0;
    havoc vslice_dummy_var_37;
    havoc vslice_dummy_var_38;
    havoc vslice_dummy_var_39;
    call {:si_unique_call 44} ntStatus := t1394_IsochAttachBuffers(DeviceObject, Irp, outputBufferLength, vslice_dummy_var_37, vslice_dummy_var_38, vslice_dummy_var_39, R3_IsochDescriptor__ISOCH_ATTACH_BUFFERS(IsochAttachBuffers));
    goto anon430_Then, anon430_Else;

  anon430_Else:
    assume {:partition} yogi_error != 1;
    goto anon358_Then, anon358_Else;

  anon358_Else:
    assume {:partition} 259 == ntStatus;
    goto L79;

  anon358_Then:
    assume {:partition} 259 != ntStatus;
    goto L78;

  anon430_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon354_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon355_Then:
    assume {:partition} BAND(pTempR3Desc, 3) == 0;
    goto anon356_Then, anon356_Else;

  anon356_Else:
    assume {:partition} ulBuffSize > ulBuffSize + 36;
    ntStatus := -1073741811;
    goto L351;

  anon356_Then:
    assume {:partition} ulBuffSize + 36 >= ulBuffSize;
    ulBuffSize := ulBuffSize + 36;
    goto anon431_Then, anon431_Else;

  anon431_Else:
    assume {:partition} ulBuffSize > inputBufferLength;
    ntStatus := -1073741789;
    goto L351;

  anon431_Then:
    assume {:partition} inputBufferLength >= ulBuffSize;
    assume {:nonnull} pTempR3Desc != 0;
    assume pTempR3Desc > 0;
    goto anon357_Then, anon357_Else;

  anon357_Else:
    ntStatus := -1073741811;
    goto L351;

  anon357_Then:
    assume {:nonnull} pTempR3Desc != 0;
    assume pTempR3Desc > 0;
    havoc ulBuffSize;
    goto anon432_Then, anon432_Else;

  anon432_Else:
    assume {:partition} ulBuffSize > inputBufferLength;
    ntStatus := -1073741789;
    goto L351;

  anon432_Then:
    assume {:partition} inputBufferLength >= ulBuffSize;
    assume {:nonnull} pTempR3Desc != 0;
    assume pTempR3Desc > 0;
    havoc pTempR3Desc;
    i := i + 1;
    goto anon432_Then_dummy;

  anon432_Then_dummy:
    assume false;
    return;

  anon353_Then:
    goto L351;

  anon406_Then:
    assume {:partition} ioControlCode == 2236444;
    goto anon359_Then, anon359_Else;

  anon359_Else:
    assume {:partition} 32 > inputBufferLength;
    goto L379;

  L379:
    ntStatus := -1073741789;
    goto L78;

  anon359_Then:
    assume {:partition} inputBufferLength >= 32;
    goto anon360_Then, anon360_Else;

  anon360_Else:
    assume {:partition} 32 <= outputBufferLength;
    IsochAllocateResources := ioBuffer;
    assume {:nonnull} IsochAllocateResources != 0;
    assume IsochAllocateResources > 0;
    havoc vslice_dummy_var_40;
    havoc vslice_dummy_var_41;
    havoc vslice_dummy_var_42;
    havoc vslice_dummy_var_43;
    havoc vslice_dummy_var_44;
    havoc vslice_dummy_var_45;
    havoc vslice_dummy_var_46;
    call {:si_unique_call 45} ntStatus := t1394_IsochAllocateResources(DeviceObject, Irp, vslice_dummy_var_40, vslice_dummy_var_41, vslice_dummy_var_42, vslice_dummy_var_43, vslice_dummy_var_44, vslice_dummy_var_45, vslice_dummy_var_46, hResource__ISOCH_ALLOCATE_RESOURCES(IsochAllocateResources));
    goto anon428_Then, anon428_Else;

  anon428_Else:
    assume {:partition} yogi_error != 1;
    goto anon361_Then, anon361_Else;

  anon361_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon361_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon428_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon360_Then:
    assume {:partition} outputBufferLength < 32;
    goto L379;

  anon407_Then:
    assume {:partition} ioControlCode == 2236440;
    goto anon362_Then, anon362_Else;

  anon362_Else:
    assume {:partition} 16 > inputBufferLength;
    goto L390;

  L390:
    ntStatus := -1073741789;
    goto L78;

  anon362_Then:
    assume {:partition} inputBufferLength >= 16;
    goto anon363_Then, anon363_Else;

  anon363_Else:
    assume {:partition} 16 <= outputBufferLength;
    IsochAllocateChannel := ioBuffer;
    assume {:nonnull} IsochAllocateChannel != 0;
    assume IsochAllocateChannel > 0;
    havoc vslice_dummy_var_47;
    call {:si_unique_call 46} ntStatus := t1394_IsochAllocateChannel(DeviceObject, Irp, vslice_dummy_var_47, Channel__IRB_REQ_ISOCH_ALLOCATE_CHANNEL(IsochAllocateChannel), ChannelsAvailable__IRB_REQ_ISOCH_ALLOCATE_CHANNEL(IsochAllocateChannel));
    goto anon427_Then, anon427_Else;

  anon427_Else:
    assume {:partition} yogi_error != 1;
    goto anon364_Then, anon364_Else;

  anon364_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon364_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon427_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon363_Then:
    assume {:partition} outputBufferLength < 16;
    goto L390;

  anon408_Then:
    assume {:partition} ioControlCode == 2236436;
    goto anon365_Then, anon365_Else;

  anon365_Else:
    assume {:partition} 20 > inputBufferLength;
    goto L401;

  L401:
    ntStatus := -1073741789;
    goto L78;

  anon365_Then:
    assume {:partition} inputBufferLength >= 20;
    goto anon366_Then, anon366_Else;

  anon366_Else:
    assume {:partition} 20 <= outputBufferLength;
    IsochAllocateBandwidth := ioBuffer;
    assume {:nonnull} IsochAllocateBandwidth != 0;
    assume IsochAllocateBandwidth > 0;
    havoc vslice_dummy_var_48;
    havoc vslice_dummy_var_49;
    call {:si_unique_call 47} ntStatus := t1394_IsochAllocateBandwidth(DeviceObject, Irp, vslice_dummy_var_48, vslice_dummy_var_49, hBandwidth__ISOCH_ALLOCATE_BANDWIDTH(IsochAllocateBandwidth), BytesPerFrameAvailable__ISOCH_ALLOCATE_BANDWIDTH(IsochAllocateBandwidth), SpeedSelected__ISOCH_ALLOCATE_BANDWIDTH(IsochAllocateBandwidth));
    goto anon426_Then, anon426_Else;

  anon426_Else:
    assume {:partition} yogi_error != 1;
    goto anon367_Then, anon367_Else;

  anon367_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon367_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon426_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon366_Then:
    assume {:partition} outputBufferLength < 20;
    goto L401;

  anon409_Then:
    assume {:partition} ioControlCode == 2236432;
    goto anon368_Then, anon368_Else;

  anon368_Else:
    assume {:partition} 64 > inputBufferLength;
    goto L412;

  L412:
    ntStatus := -1073741789;
    goto L78;

  anon368_Then:
    assume {:partition} inputBufferLength >= 64;
    goto anon369_Then, anon369_Else;

  anon369_Else:
    assume {:partition} 64 <= outputBufferLength;
    AsyncLock := ioBuffer;
    assume {:nonnull} AsyncLock != 0;
    assume AsyncLock > 0;
    havoc vslice_dummy_var_50;
    havoc vslice_dummy_var_51;
    havoc vslice_dummy_var_52;
    havoc vslice_dummy_var_53;
    havoc vslice_dummy_var_54;
    havoc vslice_dummy_var_55;
    havoc vslice_dummy_var_56;
    havoc vslice_dummy_var_57;
    havoc vslice_dummy_var_58;
    havoc vslice_dummy_var_59;
    call {:si_unique_call 48} ntStatus := t1394_AsyncLock(DeviceObject, Irp, vslice_dummy_var_50, vslice_dummy_var_51, vslice_dummy_var_52, vslice_dummy_var_53, vslice_dummy_var_54, vslice_dummy_var_55, vslice_dummy_var_56, vslice_dummy_var_57, vslice_dummy_var_58, vslice_dummy_var_59, Buffer__ASYNC_LOCK(AsyncLock));
    goto anon425_Then, anon425_Else;

  anon425_Else:
    assume {:partition} yogi_error != 1;
    goto anon370_Then, anon370_Else;

  anon370_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon370_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon425_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon369_Then:
    assume {:partition} outputBufferLength < 64;
    goto L412;

  anon410_Then:
    assume {:partition} ioControlCode == 2236428;
    goto anon371_Then, anon371_Else;

  anon371_Else:
    assume {:partition} 40 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon371_Then:
    assume {:partition} inputBufferLength >= 40;
    AsyncWrite := ioBuffer;
    assume {:nonnull} AsyncWrite != 0;
    assume AsyncWrite > 0;
    goto anon423_Then, anon423_Else;

  anon423_Else:
    ntStatus := -1073741789;
    goto L78;

  anon423_Then:
    assume {:nonnull} AsyncWrite != 0;
    assume AsyncWrite > 0;
    havoc vslice_dummy_var_60;
    havoc vslice_dummy_var_61;
    havoc vslice_dummy_var_62;
    havoc vslice_dummy_var_63;
    havoc vslice_dummy_var_64;
    havoc vslice_dummy_var_65;
    havoc vslice_dummy_var_66;
    call {:si_unique_call 49} ntStatus := t1394_AsyncWrite(DeviceObject, Irp, vslice_dummy_var_60, vslice_dummy_var_61, vslice_dummy_var_62, vslice_dummy_var_63, vslice_dummy_var_64, vslice_dummy_var_65, vslice_dummy_var_66, Data__ASYNC_WRITE(AsyncWrite));
    goto anon424_Then, anon424_Else;

  anon424_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon424_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon411_Then:
    assume {:partition} ioControlCode == 2236424;
    goto anon372_Then, anon372_Else;

  anon372_Else:
    assume {:partition} 40 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon372_Then:
    assume {:partition} inputBufferLength >= 40;
    AsyncRead := ioBuffer;
    goto anon421_Then, anon421_Else;

  anon421_Else:
    assume {:partition} 40 > outputBufferLength;
    goto L437;

  L437:
    ntStatus := -1073741789;
    goto L78;

  anon421_Then:
    assume {:partition} outputBufferLength >= 40;
    assume {:nonnull} AsyncRead != 0;
    assume AsyncRead > 0;
    goto anon373_Then, anon373_Else;

  anon373_Else:
    assume {:nonnull} AsyncRead != 0;
    assume AsyncRead > 0;
    havoc vslice_dummy_var_67;
    havoc vslice_dummy_var_68;
    havoc vslice_dummy_var_69;
    havoc vslice_dummy_var_70;
    havoc vslice_dummy_var_71;
    havoc vslice_dummy_var_72;
    havoc vslice_dummy_var_73;
    call {:si_unique_call 50} ntStatus := t1394_AsyncRead(DeviceObject, Irp, vslice_dummy_var_67, vslice_dummy_var_68, vslice_dummy_var_69, vslice_dummy_var_70, vslice_dummy_var_71, vslice_dummy_var_72, vslice_dummy_var_73, Data__ASYNC_READ(AsyncRead));
    goto anon422_Then, anon422_Else;

  anon422_Else:
    assume {:partition} yogi_error != 1;
    goto anon374_Then, anon374_Else;

  anon374_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon374_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon422_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon373_Then:
    goto L437;

  anon412_Then:
    assume {:partition} ioControlCode == 2236420;
    goto anon308_Then, anon308_Else;

  anon308_Else:
    assume {:partition} 4 > inputBufferLength;
    ntStatus := -1073741789;
    goto L78;

  anon308_Then:
    assume {:partition} inputBufferLength >= 4;
    Tmp_22 := ioBuffer;
    assume {:nonnull} Tmp_22 != 0;
    assume Tmp_22 > 0;
    havoc Tmp_7;
    call {:si_unique_call 51} ntStatus := t1394_FreeAddressRange(DeviceObject, Irp, Tmp_7);
    goto anon420_Then, anon420_Else;

  anon420_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon420_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon416_Then:
    assume {:partition} ioControlCode == 2236416;
    goto anon375_Then, anon375_Else;

  anon375_Else:
    assume {:partition} 40 > inputBufferLength;
    goto L453;

  L453:
    ntStatus := -1073741789;
    goto L78;

  anon375_Then:
    assume {:partition} inputBufferLength >= 40;
    goto anon376_Then, anon376_Else;

  anon376_Else:
    assume {:partition} 40 <= outputBufferLength;
    AllocateAddressRange := ioBuffer;
    assume {:nonnull} AllocateAddressRange != 0;
    assume AllocateAddressRange > 0;
    havoc vslice_dummy_var_74;
    havoc vslice_dummy_var_75;
    havoc vslice_dummy_var_76;
    havoc vslice_dummy_var_77;
    havoc vslice_dummy_var_78;
    havoc vslice_dummy_var_79;
    call {:si_unique_call 52} ntStatus := t1394_AllocateAddressRange(DeviceObject, Irp, vslice_dummy_var_74, vslice_dummy_var_75, vslice_dummy_var_76, vslice_dummy_var_77, vslice_dummy_var_78, vslice_dummy_var_79, Required1394Offset__ALLOCATE_ADDRESS_RANGE(AllocateAddressRange), hAddressRange__ALLOCATE_ADDRESS_RANGE(AllocateAddressRange), Data__ALLOCATE_ADDRESS_RANGE(AllocateAddressRange));
    goto anon419_Then, anon419_Else;

  anon419_Else:
    assume {:partition} yogi_error != 1;
    goto anon377_Then, anon377_Else;

  anon377_Else:
    assume {:partition} ntStatus >= 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    goto L78;

  anon377_Then:
    assume {:partition} 0 > ntStatus;
    goto L78;

  anon419_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon376_Then:
    assume {:partition} outputBufferLength < 40;
    goto L453;

  anon307_Then:
    assume {:nonnull} deviceExtension != 0;
    assume deviceExtension > 0;
    havoc vslice_dummy_var_80;
    call {:si_unique_call 53} ntStatus := t1394_SubmitIrpAsync(vslice_dummy_var_80, Irp, 0);
    goto anon459_Then, anon459_Else;

  anon459_Else:
    assume {:partition} yogi_error != 1;
    Tmp_3 := ntStatus;
    goto L1;

  anon459_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "_sdv_init7"} {:osmodel} _sdv_init7();
  modifies SLAM_guard_S_0, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> wait_required != 1;
  free ensures old(wait_required) == 1 ==> wait_required != 1;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures yogi_error == 0;
  free ensures wait_required == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "_sdv_init7"} {:osmodel} _sdv_init7()
{

  anon0:
    SLAM_guard_S_0 := SLAM_guard_S_0_init;
    wait_required := 0;
    yogi_error := 0;
    assume sdv_cancelFptr == 0;
    return;
}



procedure {:origName "SLIC_sdv_IoCompleteRequest_entry"} {:osmodel} SLIC_sdv_IoCompleteRequest_entry(actual_caller_1: int);
  modifies yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(wait_required) == 0 ==> yogi_error == 1;
  free ensures old(wait_required) == 1 ==> yogi_error == 1;
  free ensures yogi_error == 1;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "SLIC_sdv_IoCompleteRequest_entry"} {:osmodel} SLIC_sdv_IoCompleteRequest_entry(actual_caller_1: int)
{
  var {:pointer} caller_1: int;

  anon0:
    caller_1 := actual_caller_1;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} wait_required != 1;
    call {:si_unique_call 54} SLIC_EXIT_ROUTINE(strConst__li2bpl1);
    goto L2;

  L2:
    goto LM2;

  LM2:
    return;

  anon5_Then:
    assume {:partition} wait_required == 1;
    call {:si_unique_call 55} SLIC_ABORT_4_0(caller_1);
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} yogi_error != 1;
    goto L2;

  anon6_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "SLIC_PoCallDriver_exit"} {:osmodel} SLIC_PoCallDriver_exit(actual_caller_2: int, actual_PoCallDriver_1: int);
  modifies wait_required;
  free ensures old(wait_required) == 1 ==> wait_required != 0;
  free ensures wait_required == 1 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "SLIC_PoCallDriver_exit"} {:osmodel} SLIC_PoCallDriver_exit(actual_caller_2: int, actual_PoCallDriver_1: int)
{
  var {:scalar} PoCallDriver_1: int;

  anon0:
    PoCallDriver_1 := actual_PoCallDriver_1;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} PoCallDriver_1 == 259;
    wait_required := 1;
    goto L2;

  L2:
    return;

  anon3_Then:
    assume {:partition} PoCallDriver_1 != 259;
    goto L2;
}



procedure {:origName "SLIC_sdv_IoCallDriver_exit"} {:osmodel} SLIC_sdv_IoCallDriver_exit(actual_caller_3: int, actual_sdv_41: int);
  modifies wait_required;
  free ensures old(wait_required) == 1 ==> wait_required != 0;
  free ensures wait_required == 1 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "SLIC_sdv_IoCallDriver_exit"} {:osmodel} SLIC_sdv_IoCallDriver_exit(actual_caller_3: int, actual_sdv_41: int)
{
  var {:scalar} sdv_41: int;

  anon0:
    sdv_41 := actual_sdv_41;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} sdv_41 == 259;
    wait_required := 1;
    goto L2;

  L2:
    return;

  anon3_Then:
    assume {:partition} sdv_41 != 259;
    goto L2;
}



procedure {:origName "SLIC_KeWaitForSingleObject_entry"} {:osmodel} SLIC_KeWaitForSingleObject_entry(actual_caller_4: int);
  modifies wait_required;
  free ensures old(wait_required) == 0 ==> wait_required != 1;
  free ensures old(wait_required) == 1 ==> wait_required != 1;
  free ensures wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "SLIC_KeWaitForSingleObject_entry"} {:osmodel} SLIC_KeWaitForSingleObject_entry(actual_caller_4: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} wait_required == 1;
    wait_required := 0;
    goto L2;

  L2:
    return;

  anon3_Then:
    assume {:partition} wait_required != 1;
    goto L2;
}



procedure {:origName "SLIC_RemoveHeadList_entry"} SLIC_RemoveHeadList_entry(actual_caller_5: int);
  free ensures false;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "SLIC_RemoveHeadList_entry"} SLIC_RemoveHeadList_entry(actual_caller_5: int)
{

  anon0:
    call {:si_unique_call 56} SLIC_EXIT_ROUTINE(strConst__li2bpl1);
    return;
}



procedure {:origName "SLIC_ERROR_ROUTINE"} SLIC_ERROR_ROUTINE(actual_msg: int);
  modifies yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 1;
  free ensures old(wait_required) == 1 ==> yogi_error == 1;
  free ensures yogi_error == 1;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "SLIC_ERROR_ROUTINE"} SLIC_ERROR_ROUTINE(actual_msg: int)
{

  anon0:
    yogi_error := 1;
    return;
}



procedure {:origName "SLIC_EXIT_ROUTINE"} SLIC_EXIT_ROUTINE(actual_msg_1: int);
  free ensures false;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "SLIC_EXIT_ROUTINE"} SLIC_EXIT_ROUTINE(actual_msg_1: int)
{

  anon0:
    assume false;
    return;
}



procedure {:origName "SLIC_ABORT_4_0"} SLIC_ABORT_4_0(actual_caller_6: int);
  modifies yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 1;
  free ensures old(wait_required) == 1 ==> yogi_error == 1;
  free ensures yogi_error == 1;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "SLIC_ABORT_4_0"} SLIC_ABORT_4_0(actual_caller_6: int)
{
  var {:pointer} caller_6: int;

  anon0:
    caller_6 := actual_caller_6;
    call {:si_unique_call 57} SLIC_ERROR_ROUTINE(strConst__li2bpl2);
    return;
}



procedure {:origName "t1394VDev_PnpStartDevice"} t1394VDev_PnpStartDevice(actual_DeviceObject_1: int, actual_Irp_1: int) returns (Tmp_25: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 0 || wait_required == 1 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_PnpStartDevice"} t1394VDev_PnpStartDevice(actual_DeviceObject_1: int, actual_Irp_1: int) returns (Tmp_25: int)
{
  var {:scalar} ntStatus_1: int;
  var {:pointer} deviceExtension_1: int;
  var {:pointer} DeviceObject_1: int;
  var {:pointer} Irp_1: int;

  anon0:
    DeviceObject_1 := actual_DeviceObject_1;
    Irp_1 := actual_Irp_1;
    ntStatus_1 := 0;
    assume {:nonnull} DeviceObject_1 != 0;
    assume DeviceObject_1 > 0;
    havoc deviceExtension_1;
    assume {:nonnull} deviceExtension_1 != 0;
    assume deviceExtension_1 > 0;
    call {:si_unique_call 58} ntStatus_1 := t1394_BusResetNotification(DeviceObject_1, Irp_1, 1);
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 59} t1394_UpdateGenerationCount(DeviceObject_1, 0);
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 60} ntStatus_1 := IoSetDeviceInterfaceState(0, 1);
    Tmp_25 := ntStatus_1;
    goto LM2;

  LM2:
    return;

  anon6_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon5_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "t1394VDev_PnpRemoveDevice"} t1394VDev_PnpRemoveDevice(actual_DeviceObject_2: int, actual_Irp_2: int) returns (Tmp_27: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_PnpRemoveDevice"} t1394VDev_PnpRemoveDevice(actual_DeviceObject_2: int, actual_Irp_2: int) returns (Tmp_27: int)
{
  var {:pointer} IsochResourceData: int;
  var {:pointer} sdv_46: int;
  var {:pointer} Tmp_28: int;
  var {:pointer} ResourceIrp: int;
  var {:scalar} sdv_48: int;
  var {:pointer} Tmp_29: int;
  var {:pointer} sdv_50: int;
  var {:pointer} CromData: int;
  var {:pointer} sdv_51: int;
  var {:scalar} sdv_52: int;
  var {:scalar} StackSize: int;
  var {:scalar} ntStatus_2: int;
  var {:pointer} sdv_54: int;
  var {:pointer} IsochDetachData: int;
  var {:scalar} sdv_55: int;
  var {:scalar} sdv_56: int;
  var {:scalar} sdv_57: int;
  var {:pointer} Tmp_30: int;
  var {:pointer} sdv_58: int;
  var {:pointer} AsyncAddressData: int;
  var {:pointer} BusResetIrp_1: int;
  var {:scalar} Irql_1: int;
  var {:pointer} sdv_61: int;
  var {:pointer} deviceExtension_2: int;
  var {:pointer} pIrb: int;
  var {:pointer} DeviceObject_2: int;
  var {:pointer} Irp_2: int;
  var vslice_dummy_var_3: int;
  var vslice_dummy_var_4: int;
  var vslice_dummy_var_81: int;
  var vslice_dummy_var_82: int;

  anon0:
    DeviceObject_2 := actual_DeviceObject_2;
    Irp_2 := actual_Irp_2;
    ntStatus_2 := 0;
    assume {:nonnull} DeviceObject_2 != 0;
    assume DeviceObject_2 > 0;
    havoc deviceExtension_2;
    assume {:nonnull} deviceExtension_2 != 0;
    assume deviceExtension_2 > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    goto L12;

  L12:
    call {:si_unique_call 61} ntStatus_2 := IoSetDeviceInterfaceState(0, 0);
    call {:si_unique_call 62} Tmp_30 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    call {:si_unique_call 63} sdv_KeAcquireSpinLock(0, Tmp_30);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    havoc Irql_1;
    goto L20;

  L20:
    call {:si_unique_call 64} sdv_46, CromData, sdv_55 := t1394VDev_PnpRemoveDevice_loop_L20(sdv_46, CromData, sdv_55, deviceExtension_2);
    goto L20_last;

  L20_last:
    call {:si_unique_call 115} sdv_55 := sdv_IsListEmpty(0);
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} sdv_55 == 0;
    assume {:nonnull} deviceExtension_2 != 0;
    assume deviceExtension_2 > 0;
    call {:si_unique_call 65} sdv_46 := RemoveHeadList(CromData__DEVICE_EXTENSION(deviceExtension_2));
    CromData := sdv_46;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} CromData != 0;
    assume {:nonnull} CromData != 0;
    assume CromData > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    call {:si_unique_call 66} sdv_ExFreePool(0);
    goto L181;

  L181:
    assume {:nonnull} CromData != 0;
    assume CromData > 0;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    call {:si_unique_call 67} IoFreeMdl(0);
    goto L185;

  L185:
    call {:si_unique_call 68} sdv_ExFreePool(0);
    goto L185_dummy;

  L185_dummy:
    assume false;
    return;

  anon54_Then:
    goto L185;

  anon53_Then:
    goto L181;

  anon62_Then:
    assume {:partition} CromData == 0;
    goto anon62_Then_dummy;

  anon62_Then_dummy:
    assume false;
    return;

  anon43_Then:
    assume {:partition} sdv_55 != 0;
    call {:si_unique_call 69} sdv_KeReleaseSpinLock(0, Irql_1);
    call {:si_unique_call 70} Tmp_30 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    call {:si_unique_call 71} sdv_KeAcquireSpinLock(0, Tmp_30);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    havoc Irql_1;
    goto L31;

  L31:
    call {:si_unique_call 72} sdv_56, AsyncAddressData, sdv_61 := t1394VDev_PnpRemoveDevice_loop_L31(sdv_56, AsyncAddressData, sdv_61, deviceExtension_2);
    goto L31_last;

  L31_last:
    call {:si_unique_call 114} sdv_56 := sdv_IsListEmpty(0);
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} sdv_56 == 0;
    assume {:nonnull} deviceExtension_2 != 0;
    assume deviceExtension_2 > 0;
    call {:si_unique_call 73} sdv_61 := RemoveHeadList(AsyncAddressData__DEVICE_EXTENSION(deviceExtension_2));
    AsyncAddressData := sdv_61;
    assume {:nonnull} AsyncAddressData != 0;
    assume AsyncAddressData > 0;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    call {:si_unique_call 74} IoFreeMdl(0);
    goto L160;

  L160:
    assume {:nonnull} AsyncAddressData != 0;
    assume AsyncAddressData > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    call {:si_unique_call 75} sdv_ExFreePool(0);
    goto L164;

  L164:
    assume {:nonnull} AsyncAddressData != 0;
    assume AsyncAddressData > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    call {:si_unique_call 76} sdv_ExFreePool(0);
    goto L168;

  L168:
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} AsyncAddressData != 0;
    call {:si_unique_call 77} sdv_ExFreePool(0);
    goto anon52_Else_dummy;

  anon52_Else_dummy:
    assume false;
    return;

  anon52_Then:
    assume {:partition} AsyncAddressData == 0;
    goto anon52_Then_dummy;

  anon52_Then_dummy:
    assume false;
    return;

  anon51_Then:
    goto L168;

  anon50_Then:
    goto L164;

  anon61_Then:
    goto L160;

  anon44_Then:
    assume {:partition} sdv_56 != 0;
    call {:si_unique_call 78} sdv_KeReleaseSpinLock(0, Irql_1);
    goto L41;

  L41:
    call {:si_unique_call 79} sdv_50, IsochDetachData, sdv_57, Tmp_30, Irql_1, vslice_dummy_var_4 := t1394VDev_PnpRemoveDevice_loop_L41(sdv_50, IsochDetachData, sdv_57, Tmp_30, Irql_1, deviceExtension_2, vslice_dummy_var_4);
    goto L41_last;

  L41_last:
    call {:si_unique_call 111} Tmp_30 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    call {:si_unique_call 112} sdv_KeAcquireSpinLock(0, Tmp_30);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    havoc Irql_1;
    call {:si_unique_call 113} sdv_57 := sdv_IsListEmpty(0);
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} sdv_57 == 0;
    assume {:nonnull} deviceExtension_2 != 0;
    assume deviceExtension_2 > 0;
    call {:si_unique_call 80} sdv_50 := RemoveHeadList(IsochDetachData__DEVICE_EXTENSION(deviceExtension_2));
    IsochDetachData := sdv_50;
    call {:si_unique_call 81} vslice_dummy_var_4 := KeCancelTimer(0);
    call {:si_unique_call 82} sdv_KeReleaseSpinLock(0, Irql_1);
    assume {:nonnull} IsochDetachData != 0;
    assume IsochDetachData > 0;
    assume {:nonnull} IsochDetachData != 0;
    assume IsochDetachData > 0;
    call {:si_unique_call 83} t1394_IsochCleanup(IsochDetachData);
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} yogi_error != 1;
    goto anon60_Else_dummy;

  anon60_Else_dummy:
    assume false;
    return;

  anon60_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  LM2:
    return;

  anon45_Then:
    assume {:partition} sdv_57 != 0;
    call {:si_unique_call 84} sdv_KeReleaseSpinLock(0, Irql_1);
    goto L72;

  L72:
    call {:si_unique_call 85} IsochResourceData, Tmp_28, ResourceIrp, sdv_51, sdv_52, StackSize, ntStatus_2, sdv_54, Tmp_30, Irql_1, pIrb := t1394VDev_PnpRemoveDevice_loop_L72(IsochResourceData, Tmp_28, ResourceIrp, sdv_51, sdv_52, StackSize, ntStatus_2, sdv_54, Tmp_30, Irql_1, deviceExtension_2, pIrb);
    goto L72_last;

  L72_last:
    call {:si_unique_call 108} Tmp_30 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    call {:si_unique_call 109} sdv_KeAcquireSpinLock(0, Tmp_30);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    havoc Irql_1;
    call {:si_unique_call 110} sdv_52 := sdv_IsListEmpty(0);
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} sdv_52 == 0;
    assume {:nonnull} deviceExtension_2 != 0;
    assume deviceExtension_2 > 0;
    call {:si_unique_call 86} sdv_51 := RemoveHeadList(IsochResourceData__DEVICE_EXTENSION(deviceExtension_2));
    IsochResourceData := sdv_51;
    call {:si_unique_call 87} sdv_KeReleaseSpinLock(0, Irql_1);
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} IsochResourceData != 0;
    assume {:nonnull} deviceExtension_2 != 0;
    assume deviceExtension_2 > 0;
    havoc Tmp_28;
    assume {:nonnull} Tmp_28 != 0;
    assume Tmp_28 > 0;
    havoc StackSize;
    call {:si_unique_call 88} ResourceIrp := IoAllocateIrp(StackSize, 0);
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} ResourceIrp != 0;
    call {:si_unique_call 89} sdv_54 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb := sdv_54;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} pIrb != 0;
    call {:si_unique_call 90} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb != 0;
    assume pIrb > 0;
    assume {:nonnull} pIrb != 0;
    assume pIrb > 0;
    assume {:nonnull} IsochResourceData != 0;
    assume IsochResourceData > 0;
    assume {:nonnull} pIrb != 0;
    assume pIrb > 0;
    assume {:nonnull} deviceExtension_2 != 0;
    assume deviceExtension_2 > 0;
    havoc vslice_dummy_var_81;
    call {:si_unique_call 91} ntStatus_2 := t1394_SubmitIrpSynch(vslice_dummy_var_81, ResourceIrp, pIrb);
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 92} sdv_ExFreePool(0);
    call {:si_unique_call 93} IoFreeIrp(0);
    goto anon59_Else_dummy;

  anon59_Else_dummy:
    assume false;
    return;

  anon59_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon58_Then:
    assume {:partition} pIrb == 0;
    call {:si_unique_call 94} IoFreeIrp(0);
    goto anon58_Then_dummy;

  anon58_Then_dummy:
    assume false;
    return;

  anon48_Then:
    assume {:partition} ResourceIrp == 0;
    goto anon48_Then_dummy;

  anon48_Then_dummy:
    assume false;
    return;

  anon47_Then:
    assume {:partition} IsochResourceData == 0;
    goto anon47_Then_dummy;

  anon47_Then_dummy:
    assume false;
    return;

  anon46_Then:
    assume {:partition} sdv_52 != 0;
    call {:si_unique_call 95} sdv_KeReleaseSpinLock(0, Irql_1);
    call {:si_unique_call 96} Tmp_30 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    call {:si_unique_call 97} sdv_KeAcquireSpinLock(0, Tmp_30);
    assume {:nonnull} Tmp_30 != 0;
    assume Tmp_30 > 0;
    havoc Irql_1;
    goto L126;

  L126:
    call {:si_unique_call 98} sdv_48, Tmp_29, sdv_58, BusResetIrp_1, vslice_dummy_var_3 := t1394VDev_PnpRemoveDevice_loop_L126(sdv_48, Tmp_29, sdv_58, BusResetIrp_1, deviceExtension_2, vslice_dummy_var_3);
    goto L126_last;

  L126_last:
    call {:si_unique_call 107} sdv_48 := sdv_IsListEmpty(0);
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} sdv_48 == 0;
    assume {:nonnull} deviceExtension_2 != 0;
    assume deviceExtension_2 > 0;
    call {:si_unique_call 99} sdv_58 := RemoveHeadList(BusResetIrps__DEVICE_EXTENSION(deviceExtension_2));
    BusResetIrp_1 := sdv_58;
    assume {:nonnull} BusResetIrp_1 != 0;
    assume BusResetIrp_1 > 0;
    havoc vslice_dummy_var_82;
    call {:si_unique_call 100} vslice_dummy_var_3 := sdv_IoSetCancelRoutine(vslice_dummy_var_82, 0);
    assume {:nonnull} BusResetIrp_1 != 0;
    assume BusResetIrp_1 > 0;
    havoc Tmp_29;
    assume {:nonnull} Tmp_29 != 0;
    assume Tmp_29 > 0;
    assume {:nonnull} BusResetIrp_1 != 0;
    assume BusResetIrp_1 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 101} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} yogi_error != 1;
    goto L213;

  L213:
    call {:si_unique_call 102} sdv_IoCompleteRequest(0, 0);
    call {:si_unique_call 103} sdv_ExFreePool(0);
    goto L213_dummy;

  L213_dummy:
    assume false;
    return;

  anon57_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon56_Then:
    goto L213;

  anon49_Then:
    assume {:partition} sdv_48 != 0;
    call {:si_unique_call 104} sdv_KeReleaseSpinLock(0, Irql_1);
    call {:si_unique_call 105} RtlFreeUnicodeString(0);
    Tmp_27 := ntStatus_2;
    goto LM2;

  anon55_Then:
    call {:si_unique_call 106} ntStatus_2 := t1394VDev_PnpStopDevice(DeviceObject_2, Irp_2);
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} yogi_error != 1;
    goto L12;

  anon63_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "t1394VDev_Pnp"} t1394VDev_Pnp(actual_DeviceObject_3: int, actual_Irp_3: int) returns (Tmp_31: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_Pnp"} t1394VDev_Pnp(actual_DeviceObject_3: int, actual_Irp_3: int) returns (Tmp_31: int)
{
  var {:pointer} IrpSp_1: int;
  var {:pointer} DeviceCapabilities: int;
  var {:scalar} ntStatus_3: int;
  var {:pointer} deviceExtension_3: int;
  var {:pointer} DeviceObject_3: int;
  var {:pointer} Irp_3: int;
  var vslice_dummy_var_83: int;
  var vslice_dummy_var_84: int;
  var vslice_dummy_var_85: int;
  var vslice_dummy_var_86: int;
  var vslice_dummy_var_87: int;
  var vslice_dummy_var_88: int;
  var vslice_dummy_var_89: int;
  var vslice_dummy_var_90: int;
  var vslice_dummy_var_91: int;
  var vslice_dummy_var_92: int;

  anon0:
    DeviceObject_3 := actual_DeviceObject_3;
    Irp_3 := actual_Irp_3;
    ntStatus_3 := 0;
    assume {:nonnull} DeviceObject_3 != 0;
    assume DeviceObject_3 > 0;
    havoc deviceExtension_3;
    call {:si_unique_call 116} IrpSp_1 := sdv_IoGetCurrentIrpStackLocation(Irp_3);
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_83;
    call {:si_unique_call 117} ntStatus_3 := t1394_SubmitIrpAsync(vslice_dummy_var_83, Irp_3, 0);
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} yogi_error != 1;
    goto L43;

  L43:
    Tmp_31 := ntStatus_3;
    goto LM2;

  LM2:
    return;

  anon74_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon53_Then:
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_84;
    call {:si_unique_call 118} ntStatus_3 := t1394_SubmitIrpAsync(vslice_dummy_var_84, Irp_3, 0);
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} yogi_error != 1;
    goto L43;

  anon75_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon54_Then:
    assume {:nonnull} IrpSp_1 != 0;
    assume IrpSp_1 > 0;
    havoc DeviceCapabilities;
    assume {:nonnull} DeviceCapabilities != 0;
    assume DeviceCapabilities > 0;
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_85;
    call {:si_unique_call 119} ntStatus_3 := t1394_SubmitIrpAsync(vslice_dummy_var_85, Irp_3, 0);
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} yogi_error != 1;
    goto L43;

  anon73_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon55_Then:
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_86;
    call {:si_unique_call 120} ntStatus_3 := t1394_SubmitIrpAsync(vslice_dummy_var_86, Irp_3, 0);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} yogi_error != 1;
    goto L43;

  anon72_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon56_Then:
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_87;
    call {:si_unique_call 121} ntStatus_3 := t1394_SubmitIrpAsync(vslice_dummy_var_87, Irp_3, 0);
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} yogi_error != 1;
    goto L43;

  anon71_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon57_Then:
    call {:si_unique_call 122} ntStatus_3 := t1394VDev_PnpStopDevice(DeviceObject_3, Irp_3);
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_88;
    call {:si_unique_call 123} ntStatus_3 := t1394_SubmitIrpAsync(vslice_dummy_var_88, Irp_3, 0);
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} yogi_error != 1;
    goto L43;

  anon70_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon69_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon58_Then:
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_89;
    call {:si_unique_call 124} ntStatus_3 := t1394_SubmitIrpAsync(vslice_dummy_var_89, Irp_3, 0);
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} yogi_error != 1;
    goto L43;

  anon68_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon59_Then:
    call {:si_unique_call 125} ntStatus_3 := t1394VDev_PnpRemoveDevice(DeviceObject_3, Irp_3);
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_90;
    call {:si_unique_call 126} ntStatus_3 := t1394_SubmitIrpAsync(vslice_dummy_var_90, Irp_3, 0);
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 127} IoDetachDevice(0);
    call {:si_unique_call 128} IoDeleteDevice(0);
    goto L43;

  anon67_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon66_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon60_Then:
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_91;
    call {:si_unique_call 129} ntStatus_3 := t1394_SubmitIrpAsync(vslice_dummy_var_91, Irp_3, 0);
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} yogi_error != 1;
    goto L43;

  anon65_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon51_Then:
    assume {:nonnull} deviceExtension_3 != 0;
    assume deviceExtension_3 > 0;
    havoc vslice_dummy_var_92;
    call {:si_unique_call 130} ntStatus_3 := t1394_SubmitIrpSynch(vslice_dummy_var_92, Irp_3, 0);
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} yogi_error != 1;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} ntStatus_3 >= 0;
    call {:si_unique_call 131} ntStatus_3 := t1394VDev_PnpStartDevice(DeviceObject_3, Irp_3);
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} yogi_error != 1;
    goto L83;

  L83:
    assume {:nonnull} Irp_3 != 0;
    assume Irp_3 > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume Irp_3 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 132} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} yogi_error != 1;
    goto L105;

  L105:
    call {:si_unique_call 133} sdv_IoCompleteRequest(0, 0);
    goto L43;

  anon64_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon63_Then:
    assume !(Irp_3 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L105;

  anon62_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon52_Then:
    assume {:partition} 0 > ntStatus_3;
    goto L83;

  anon61_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "_sdv_init3"} _sdv_init3();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "_sdv_init3"} _sdv_init3()
{
  var vslice_dummy_var_5: int;

  anon0:
    call {:si_unique_call 134} vslice_dummy_var_5 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "t1394VDev_PnpStopDevice"} t1394VDev_PnpStopDevice(actual_DeviceObject_4: int, actual_Irp_4: int) returns (Tmp_35: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_PnpStopDevice"} t1394VDev_PnpStopDevice(actual_DeviceObject_4: int, actual_Irp_4: int) returns (Tmp_35: int)
{
  var {:scalar} ntStatus_4: int;
  var {:pointer} deviceExtension_4: int;
  var {:pointer} DeviceObject_4: int;
  var {:pointer} Irp_4: int;

  anon0:
    DeviceObject_4 := actual_DeviceObject_4;
    Irp_4 := actual_Irp_4;
    ntStatus_4 := 0;
    assume {:nonnull} DeviceObject_4 != 0;
    assume DeviceObject_4 > 0;
    havoc deviceExtension_4;
    assume {:nonnull} deviceExtension_4 != 0;
    assume deviceExtension_4 > 0;
    call {:si_unique_call 135} ntStatus_4 := t1394_BusResetNotification(DeviceObject_4, Irp_4, 2);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} yogi_error != 1;
    Tmp_35 := ntStatus_4;
    goto LM2;

  LM2:
    return;

  anon3_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "IoFreeWorkItem"} {:osmodel} IoFreeWorkItem(actual_IoWorkItem: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoFreeWorkItem"} {:osmodel} IoFreeWorkItem(actual_IoWorkItem: int)
{
  var vslice_dummy_var_6: int;

  anon0:
    call {:si_unique_call 136} vslice_dummy_var_6 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_IoCopyCurrentIrpStackLocationToNext"} {:osmodel} sdv_IoCopyCurrentIrpStackLocationToNext(actual_pirp: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IoCopyCurrentIrpStackLocationToNext"} {:osmodel} sdv_IoCopyCurrentIrpStackLocationToNext(actual_pirp: int)
{
  var {:pointer} pirp: int;
  var vslice_dummy_var_7: int;

  anon0:
    call {:si_unique_call 137} vslice_dummy_var_7 := __HAVOC_malloc(4);
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



procedure {:origName "sdv_KeAcquireSpinLock"} {:osmodel} sdv_KeAcquireSpinLock(actual_SpinLock: int, actual_p: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_KeAcquireSpinLock"} {:osmodel} sdv_KeAcquireSpinLock(actual_SpinLock: int, actual_p: int)
{
  var {:pointer} p: int;
  var vslice_dummy_var_8: int;

  anon0:
    call {:si_unique_call 138} vslice_dummy_var_8 := __HAVOC_malloc(4);
    p := actual_p;
    assume {:nonnull} p != 0;
    assume p > 0;
    return;
}



procedure {:origName "KeSetTimer"} {:osmodel} KeSetTimer(actual_Timer: int, actual_structPtr888DueTime: int, actual_Dpc: int) returns (Tmp_43: int);
  modifies alloc;
  free ensures Tmp_43 == 1 || Tmp_43 == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "KeSetTimer"} {:osmodel} KeSetTimer(actual_Timer: int, actual_structPtr888DueTime: int, actual_Dpc: int) returns (Tmp_43: int)
{
  var {:scalar} DueTime: int;
  var {:pointer} structPtr888DueTime: int;

  anon0:
    call {:si_unique_call 139} DueTime := __HAVOC_malloc(20);
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
    Tmp_43 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_43 := 0;
    goto L1;
}



procedure {:origName "sdv_MmGetMdlByteCount"} {:osmodel} sdv_MmGetMdlByteCount(actual_Mdl: int) returns (Tmp_45: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_MmGetMdlByteCount"} {:osmodel} sdv_MmGetMdlByteCount(actual_Mdl: int) returns (Tmp_45: int)
{
  var {:scalar} x: int;
  var {:pointer} sdv_79: int;

  anon0:
    call {:si_unique_call 140} sdv_79 := __HAVOC_malloc(1);
    x := sdv_79;
    Tmp_45 := x;
    return;
}



procedure {:origName "sdv_IoGetNextIrpStackLocation"} {:osmodel} sdv_IoGetNextIrpStackLocation(actual_pirp_1: int) returns (Tmp_47: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IoGetNextIrpStackLocation"} {:osmodel} sdv_IoGetNextIrpStackLocation(actual_pirp_1: int) returns (Tmp_47: int)
{
  var {:pointer} pirp_1: int;

  anon0:
    pirp_1 := actual_pirp_1;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} pirp_1 == sdv_harnessIrp;
    Tmp_47 := sdv_harnessStackLocation_next;
    goto L1;

  L1:
    return;

  anon5_Then:
    assume {:partition} pirp_1 != sdv_harnessIrp;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} pirp_1 == sdv_other_harnessIrp;
    Tmp_47 := sdv_other_harnessStackLocation_next;
    goto L1;

  anon6_Then:
    assume {:partition} pirp_1 != sdv_other_harnessIrp;
    Tmp_47 := sdv_harnessStackLocation;
    goto L1;
}



procedure {:origName "KeInitializeDpc"} {:osmodel} KeInitializeDpc(actual_Dpc_1: int, actual_DeferredRoutine: int, actual_DeferredContext: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "KeInitializeDpc"} {:osmodel} KeInitializeDpc(actual_Dpc_1: int, actual_DeferredRoutine: int, actual_DeferredContext: int)
{
  var {:pointer} Dpc_1: int;
  var {:scalar} DeferredRoutine: int;
  var vslice_dummy_var_9: int;

  anon0:
    call {:si_unique_call 141} vslice_dummy_var_9 := __HAVOC_malloc(4);
    Dpc_1 := actual_Dpc_1;
    DeferredRoutine := actual_DeferredRoutine;
    assume {:nonnull} Dpc_1 != 0;
    assume Dpc_1 > 0;
    return;
}



procedure {:origName "IoQueueWorkItem"} {:osmodel} IoQueueWorkItem(actual_IoWorkItem_1: int, actual_WorkerRoutine: int, actual_QueueType: int, actual_Context: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoQueueWorkItem"} {:osmodel} IoQueueWorkItem(actual_IoWorkItem_1: int, actual_WorkerRoutine: int, actual_QueueType: int, actual_Context: int)
{
  var vslice_dummy_var_10: int;

  anon0:
    call {:si_unique_call 142} vslice_dummy_var_10 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoDetachDevice"} {:osmodel} IoDetachDevice(actual_TargetDevice: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoDetachDevice"} {:osmodel} IoDetachDevice(actual_TargetDevice: int)
{
  var vslice_dummy_var_11: int;

  anon0:
    call {:si_unique_call 143} vslice_dummy_var_11 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_IoSetCancelRoutine"} {:osmodel} sdv_IoSetCancelRoutine(actual_pirp_2: int, actual_CancelRoutine: int) returns (Tmp_55: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IoSetCancelRoutine"} {:osmodel} sdv_IoSetCancelRoutine(actual_pirp_2: int, actual_CancelRoutine: int) returns (Tmp_55: int)
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
    Tmp_55 := r;
    return;
}



procedure {:origName "sdv_SetPowerIrpMinorFunction"} {:osmodel} sdv_SetPowerIrpMinorFunction(actual_pirp_3: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_SetPowerIrpMinorFunction"} {:osmodel} sdv_SetPowerIrpMinorFunction(actual_pirp_3: int)
{
  var {:pointer} r_1: int;
  var {:pointer} pirp_3: int;
  var vslice_dummy_var_12: int;

  anon0:
    call {:si_unique_call 144} vslice_dummy_var_12 := __HAVOC_malloc(4);
    pirp_3 := actual_pirp_3;
    assume {:nonnull} pirp_3 != 0;
    assume pirp_3 > 0;
    havoc r_1;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    goto L1;

  L1:
    return;

  anon12_Then:
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    goto L1;

  anon13_Then:
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    goto L1;

  anon15_Then:
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    goto L1;

  anon11_Then:
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    goto L1;

  anon14_Then:
    assume {:nonnull} r_1 != 0;
    assume r_1 > 0;
    goto L1;
}



procedure {:origName "sdv_stub_dispatch_end"} {:osmodel} sdv_stub_dispatch_end(actual_s: int, actual_pirp_4: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_stub_dispatch_end"} {:osmodel} sdv_stub_dispatch_end(actual_s: int, actual_pirp_4: int)
{
  var vslice_dummy_var_13: int;

  anon0:
    call {:si_unique_call 145} vslice_dummy_var_13 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_SetStatus"} {:osmodel} sdv_SetStatus(actual_pirp_5: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_SetStatus"} {:osmodel} sdv_SetStatus(actual_pirp_5: int)
{
  var {:pointer} pirp_5: int;
  var vslice_dummy_var_14: int;

  anon0:
    call {:si_unique_call 146} vslice_dummy_var_14 := __HAVOC_malloc(4);
    pirp_5 := actual_pirp_5;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} pirp_5 != 0;
    assume pirp_5 > 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} pirp_5 != 0;
    assume pirp_5 > 0;
    goto L1;
}



procedure {:nohoudini} {:origName "sdv_main"} {:osmodel} sdv_main();
  modifies alloc, SLAM_guard_S_0, wait_required, yogi_error;
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_main"} {:osmodel} sdv_main()
{
  var vslice_dummy_var_15: int;
  var vslice_dummy_var_16: int;

  anon0:
    call {:si_unique_call 147} vslice_dummy_var_15 := __HAVOC_malloc(4);
    SLAM_guard_S_0 := sdv_irp;
    assume SLAM_guard_S_0 != 0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 148} sdv_stub_driver_init();
    call {:si_unique_call 149} vslice_dummy_var_16 := sdv_RunDispatchFunction(sdv_p_devobj_fdo, sdv_irp);
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



procedure {:origName "PoCallDriver"} {:osmodel} PoCallDriver(actual_DeviceObject_5: int, actual_Irp_5: int) returns (Tmp_65: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "PoCallDriver"} {:osmodel} PoCallDriver(actual_DeviceObject_5: int, actual_Irp_5: int) returns (Tmp_65: int)
{
  var {:dopa} {:scalar} completion: int;
  var {:scalar} status: int;
  var {:pointer} Irp_5: int;
  var vslice_dummy_var_17: int;
  var vslice_dummy_var_18: int;
  var vslice_dummy_var_19: int;
  var vslice_dummy_var_20: int;
  var vslice_dummy_var_93: int;
  var vslice_dummy_var_94: int;
  var vslice_dummy_var_95: int;
  var vslice_dummy_var_96: int;

  anon0:
    call {:si_unique_call 150} completion := __HAVOC_malloc(4);
    Irp_5 := actual_Irp_5;
    assume {:nonnull} completion != 0;
    assume completion > 0;
    status := 259;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    goto anon70_Then, anon70_Else;

  anon70_Else:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_5;
    goto L19;

  L19:
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_5;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L21;

  L21:
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_5;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L23;

  L23:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    goto L29;

  L29:
    Tmp_65 := status;
    goto LM2;

  LM2:
    return;

  anon56_Then:
    havoc vslice_dummy_var_93;
    call {:si_unique_call 151} vslice_dummy_var_17 := sdv_RunIoCompletionRoutines(sdv_p_devobj_fdo, Irp_5, vslice_dummy_var_93, completion);
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon76_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon55_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_5;
    goto L23;

  anon54_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_5;
    goto L21;

  anon75_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_5;
    goto L19;

  anon69_Then:
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_5;
    goto L58;

  L58:
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_5;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L60;

  L60:
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_5;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L62;

  L62:
    goto anon67_Then, anon67_Else;

  anon67_Else:
    goto anon68_Then, anon68_Else;

  anon68_Else:
    havoc vslice_dummy_var_94;
    call {:si_unique_call 152} vslice_dummy_var_20 := sdv_RunIoCompletionRoutines(sdv_p_devobj_fdo, Irp_5, vslice_dummy_var_94, completion);
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon78_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon68_Then:
    goto L29;

  anon67_Then:
    goto L29;

  anon66_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_5;
    goto L62;

  anon65_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_5;
    goto L60;

  anon77_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_5;
    goto L58;

  anon70_Then:
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_5;
    goto L32;

  L32:
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_5;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L34;

  L34:
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_5;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L36;

  L36:
    goto anon59_Then, anon59_Else;

  anon59_Else:
    goto anon60_Then, anon60_Else;

  anon60_Else:
    havoc vslice_dummy_var_95;
    call {:si_unique_call 153} vslice_dummy_var_18 := sdv_RunIoCompletionRoutines(sdv_p_devobj_fdo, Irp_5, vslice_dummy_var_95, completion);
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon74_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon60_Then:
    goto L29;

  anon59_Then:
    goto L29;

  anon58_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_5;
    goto L36;

  anon57_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_5;
    goto L34;

  anon73_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_5;
    goto L32;

  anon53_Then:
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    assume {:nonnull} Irp_5 != 0;
    assume Irp_5 > 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_5;
    goto L45;

  L45:
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_5;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L47;

  L47:
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_5;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L49;

  L49:
    goto anon63_Then, anon63_Else;

  anon63_Else:
    goto anon64_Then, anon64_Else;

  anon64_Else:
    havoc vslice_dummy_var_96;
    call {:si_unique_call 154} vslice_dummy_var_19 := sdv_RunIoCompletionRoutines(sdv_p_devobj_fdo, Irp_5, vslice_dummy_var_96, completion);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon72_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon64_Then:
    goto L29;

  anon63_Then:
    goto L29;

  anon62_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_5;
    goto L49;

  anon61_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_5;
    goto L47;

  anon71_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_5;
    goto L45;
}



procedure {:origName "PoSetPowerState"} {:osmodel} PoSetPowerState(actual_DeviceObject_6: int, actual_Type: int, actual_structPtr888State: int) returns (structPtr888Tmp: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "PoSetPowerState"} {:osmodel} PoSetPowerState(actual_DeviceObject_6: int, actual_Type: int, actual_structPtr888State: int) returns (structPtr888Tmp: int)
{
  var {:scalar} State: int;
  var {:scalar} r_2: int;
  var {:scalar} Tmp: int;
  var {:pointer} structPtr888State: int;

  anon0:
    call {:si_unique_call 155} State := __HAVOC_malloc(8);
    call {:si_unique_call 156} r_2 := __HAVOC_malloc(8);
    call {:si_unique_call 157} Tmp := __HAVOC_malloc(8);
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
    assume {:nonnull} r_2 != 0;
    assume r_2 > 0;
    assume {:nonnull} Tmp != 0;
    assume Tmp > 0;
    assume {:nonnull} r_2 != 0;
    assume r_2 > 0;
    structPtr888Tmp := Tmp;
    return;
}



procedure {:origName "KeCancelTimer"} {:osmodel} KeCancelTimer(actual_Timer_1: int) returns (Tmp_68: int);
  free ensures Tmp_68 == 1 || Tmp_68 == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "KeCancelTimer"} {:osmodel} KeCancelTimer(actual_Timer_1: int) returns (Tmp_68: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_68 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_68 := 0;
    goto L1;
}



procedure {:origName "sdv_IoSetCompletionRoutine"} {:osmodel} sdv_IoSetCompletionRoutine(actual_pirp_6: int, actual_CompletionRoutine: int, actual_Context_1: int, actual_InvokeOnSuccess: int, actual_InvokeOnError: int, actual_InvokeOnCancel: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IoSetCompletionRoutine"} {:osmodel} sdv_IoSetCompletionRoutine(actual_pirp_6: int, actual_CompletionRoutine: int, actual_Context_1: int, actual_InvokeOnSuccess: int, actual_InvokeOnError: int, actual_InvokeOnCancel: int)
{
  var {:pointer} irpSp: int;
  var {:pointer} pirp_6: int;
  var {:scalar} CompletionRoutine: int;
  var {:pointer} Context_1: int;
  var {:scalar} InvokeOnSuccess: int;
  var {:scalar} InvokeOnError: int;
  var {:scalar} InvokeOnCancel: int;
  var vslice_dummy_var_21: int;

  anon0:
    call {:si_unique_call 158} vslice_dummy_var_21 := __HAVOC_malloc(4);
    pirp_6 := actual_pirp_6;
    CompletionRoutine := actual_CompletionRoutine;
    Context_1 := actual_Context_1;
    InvokeOnSuccess := actual_InvokeOnSuccess;
    InvokeOnError := actual_InvokeOnError;
    InvokeOnCancel := actual_InvokeOnCancel;
    call {:si_unique_call 159} irpSp := sdv_IoGetNextIrpStackLocation(pirp_6);
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    return;
}



procedure {:origName "sdv_RemoveEntryList"} {:osmodel} sdv_RemoveEntryList(actual_Entry: int) returns (Tmp_72: int);
  free ensures Tmp_72 == 1 || Tmp_72 == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_RemoveEntryList"} {:osmodel} sdv_RemoveEntryList(actual_Entry: int) returns (Tmp_72: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_72 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_72 := 0;
    goto L1;
}



procedure {:origName "PoStartNextPowerIrp"} {:osmodel} PoStartNextPowerIrp(actual_Irp_6: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "PoStartNextPowerIrp"} {:osmodel} PoStartNextPowerIrp(actual_Irp_6: int)
{
  var vslice_dummy_var_22: int;

  anon0:
    call {:si_unique_call 160} vslice_dummy_var_22 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KeWaitForSingleObject"} {:osmodel} KeWaitForSingleObject(actual_Object: int, actual_WaitReason: int, actual_WaitMode: int, actual_Alertable: int, actual_Timeout: int) returns (Tmp_76: int);
  modifies wait_required;
  free ensures old(wait_required) == 0 ==> wait_required != 1;
  free ensures old(wait_required) == 1 ==> wait_required != 1;
  free ensures wait_required == 0 || wait_required == old(wait_required);
  free ensures Tmp_76 == 258 || Tmp_76 == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "KeWaitForSingleObject"} {:osmodel} KeWaitForSingleObject(actual_Object: int, actual_WaitReason: int, actual_WaitMode: int, actual_Alertable: int, actual_Timeout: int) returns (Tmp_76: int)
{
  var {:pointer} Timeout: int;

  anon0:
    Timeout := actual_Timeout;
    call {:si_unique_call 161} SLIC_KeWaitForSingleObject_entry(0);
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} Timeout != 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    Tmp_76 := 258;
    goto L1;

  L1:
    return;

  anon6_Then:
    Tmp_76 := 0;
    goto L1;

  anon5_Then:
    assume {:partition} Timeout == 0;
    Tmp_76 := 0;
    goto L1;
}



procedure {:origName "IoDeleteDevice"} {:osmodel} IoDeleteDevice(actual_DeviceObject_7: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoDeleteDevice"} {:osmodel} IoDeleteDevice(actual_DeviceObject_7: int)
{
  var vslice_dummy_var_23: int;

  anon0:
    call {:si_unique_call 162} vslice_dummy_var_23 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KeSetEvent"} {:osmodel} KeSetEvent(actual_Event: int, actual_Increment: int, actual_Wait: int) returns (Tmp_80: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "KeSetEvent"} {:osmodel} KeSetEvent(actual_Event: int, actual_Increment: int, actual_Wait: int) returns (Tmp_80: int)
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
    Tmp_80 := OldState;
    return;
}



procedure {:origName "sdv_IoGetCurrentIrpStackLocation"} {:osmodel} sdv_IoGetCurrentIrpStackLocation(actual_pirp_7: int) returns (Tmp_84: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IoGetCurrentIrpStackLocation"} {:osmodel} sdv_IoGetCurrentIrpStackLocation(actual_pirp_7: int) returns (Tmp_84: int)
{
  var {:pointer} pirp_7: int;

  anon0:
    pirp_7 := actual_pirp_7;
    assume {:nonnull} pirp_7 != 0;
    assume pirp_7 > 0;
    havoc Tmp_84;
    return;
}



procedure {:origName "sdv_stub_power_completion_begin"} {:osmodel} sdv_stub_power_completion_begin();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_stub_power_completion_begin"} {:osmodel} sdv_stub_power_completion_begin()
{
  var vslice_dummy_var_24: int;

  anon0:
    call {:si_unique_call 163} vslice_dummy_var_24 := __HAVOC_malloc(4);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    goto L1;

  L1:
    return;

  anon3_Then:
    goto L1;
}



procedure {:origName "sdv_KeGetCurrentIrql"} {:osmodel} sdv_KeGetCurrentIrql() returns (Tmp_88: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_KeGetCurrentIrql"} {:osmodel} sdv_KeGetCurrentIrql() returns (Tmp_88: int)
{

  anon0:
    havoc Tmp_88;
    return;
}



procedure {:origName "PoRequestPowerIrp"} {:osmodel} PoRequestPowerIrp(actual_DeviceObject_8: int, actual_MinorFunction: int, actual_SD1: int, actual_CompletionFunction: int, actual_Context_2: int, actual_Irp_7: int) returns (Tmp_90: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "PoRequestPowerIrp"} {:osmodel} PoRequestPowerIrp(actual_DeviceObject_8: int, actual_MinorFunction: int, actual_SD1: int, actual_CompletionFunction: int, actual_Context_2: int, actual_Irp_7: int) returns (Tmp_90: int)
{
  var {:scalar} PowerState_1: int;
  var {:pointer} DeviceObject_8: int;
  var {:scalar} MinorFunction: int;
  var {:pointer} SD1: int;
  var {:scalar} CompletionFunction: int;
  var {:pointer} Context_2: int;
  var vslice_dummy_var_25: int;

  anon0:
    call {:si_unique_call 164} PowerState_1 := __HAVOC_malloc(8);
    DeviceObject_8 := actual_DeviceObject_8;
    MinorFunction := actual_MinorFunction;
    SD1 := actual_SD1;
    CompletionFunction := actual_CompletionFunction;
    Context_2 := actual_Context_2;
    assume {:nonnull} PowerState_1 != 0;
    assume PowerState_1 > 0;
    assume {:nonnull} SD1 != 0;
    assume SD1 > 0;
    assume {:nonnull} PowerState_1 != 0;
    assume PowerState_1 > 0;
    assume {:nonnull} SD1 != 0;
    assume SD1 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} MinorFunction != 3;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} MinorFunction != 2;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} MinorFunction != 0;
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    Tmp_90 := -1073741584;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon13_Then:
    assume {:partition} MinorFunction == 0;
    goto L13;

  L13:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    call {:si_unique_call 165} vslice_dummy_var_25 := sdv_RunPowerCompletionRoutines(DeviceObject_8, MinorFunction, PowerState_1, Context_2, IoStatus__IRP(sdv_power_irp), CompletionFunction);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} yogi_error != 1;
    Tmp_90 := 259;
    goto L1;

  anon15_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon11_Then:
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    Tmp_90 := -1073741670;
    goto L1;

  anon12_Then:
    assume {:partition} MinorFunction == 2;
    goto L13;

  anon14_Then:
    assume {:partition} MinorFunction == 3;
    goto L13;
}



procedure {:nohoudini} {:origName "main"} {:osmodel} {:entrypoint} main() returns (Tmp_92: int, dup_assertVar: bool);
  modifies alloc, SLAM_guard_S_0, wait_required, yogi_error;
  free ensures yogi_error == 1 || yogi_error == 0;
  free ensures wait_required == 1 || wait_required == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "main"} {:osmodel} main() returns (Tmp_92: int, dup_assertVar: bool)
{
  var {:scalar} Tmp_94: int;
  var {:scalar} Tmp_95: int;
  var boogieTmp: int;
  var BUS1394_CLASS_GUID__Loc: int;
  var GUID_1394DIAG__Loc: int;
  var GUID_1394VDEV__Loc: int;
  var SLAM_guard_S_0_init__Loc: int;
  var GUID_POWERBUTTON_ACTION__Loc: int;
  var GUID_LIDOPEN_POWERSTATE__Loc: int;
  var GUID_PROCESSOR_PARKING_CORE_OVERRIDE__Loc: int;
  var GUID_PROCESSOR_PERF_CORE_PARKING_HISTORY__Loc: int;
  var GUID_PCIEXPRESS_SETTINGS_SUBGROUP__Loc: int;
  var GUID_PROCESSOR_PERF_INCREASE_TIME__Loc: int;
  var GUID_DISK_COALESCING_POWERDOWN_TIMEOUT__Loc: int;
  var GUID_AUDIO_PLAYBACK__Loc: int;
  var GUID_USERINTERFACEBUTTON_ACTION__Loc: int;
  var GUID_PROCESSOR_THROTTLE_POLICY__Loc: int;
  var GUID_PCIEXPRESS_ASPM_POLICY__Loc: int;
  var GUID_BATTERY_PERCENTAGE_REMAINING__Loc: int;
  var GUID_NON_ADAPTIVE_INPUT_TIMEOUT__Loc: int;
  var GUID_ALLOW_RTC_WAKE__Loc: int;
  var GUID_GLOBAL_USER_PRESENCE__Loc: int;
  var GUID_BATTERY_DISCHARGE_ACTION_2__Loc: int;
  var GUID_BATTERY_DISCHARGE_LEVEL_2__Loc: int;
  var GUID_APPLAUNCH_BUTTON__Loc: int;
  var GUID_BATTERY_DISCHARGE_FLAGS_1__Loc: int;
  var GUID_PROCESSOR_ALLOW_THROTTLING__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD__Loc: int;
  var GUID_MONITOR_POWER_ON__Loc: int;
  var GUID_IDLE_RESILIENCY_PERIOD__Loc: int;
  var GUID_PROCESSOR_DISTRIBUTE_UTILITY__Loc: int;
  var GUID_PROCESSOR_PERF_INCREASE_HISTORY__Loc: int;
  var GUID_INTSTEER_SUBGROUP__Loc: int;
  var GUID_DISK_BURST_IGNORE_THRESHOLD__Loc: int;
  var GUID_SLEEPBUTTON_ACTION__Loc: int;
  var GUID_PROCESSOR_PERF_LATENCY_HINT_PERF__Loc: int;
  var GUID_PROCESSOR_IDLE_DISABLE__Loc: int;
  var GUID_DISK_POWERDOWN_TIMEOUT__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD__Loc: int;
  var GUID_DISK_IDLE_TIMEOUT__Loc: int;
  var GUID_CONSOLE_DISPLAY_STATE__Loc: int;
  var GUID_ADAPTIVE_POWER_BEHAVIOR_SUBGROUP__Loc: int;
  var GUID_BATTERY_DISCHARGE_FLAGS_0__Loc: int;
  var GUID_PROCESSOR_PARKING_HEADROOM_THRESHOLD__Loc: int;
  var GUID_ACDC_POWER_SOURCE__Loc: int;
  var GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS__Loc: int;
  var GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME__Loc: int;
  var GUID_PROCESSOR_THROTTLE_MINIMUM__Loc: int;
  var GUID_ALLOW_AWAYMODE__Loc: int;
  var NO_SUBGROUP_GUID__Loc: int;
  var GUID_DISK_ADAPTIVE_POWERDOWN__Loc: int;
  var GUID_VIDEO_FULLSCREEN_PLAYBACK__Loc: int;
  var GUID_SYSTEM_BUTTON_SUBGROUP__Loc: int;
  var GUID_INTSTEER_TIME_UNPARK_TRIGGER__Loc: int;
  var GUID_SYSTEM_COOLING_POLICY__Loc: int;
  var GUID_PROCESSOR_PERF_BOOST_MODE__Loc: int;
  var ALL_POWERSCHEMES_GUID__Loc: int;
  var GUID_LIDSWITCH_STATE_CHANGE__Loc: int;
  var GUID_BATTERY_DISCHARGE_LEVEL_3__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY__Loc: int;
  var GUID_ALLOW_SYSTEM_REQUIRED__Loc: int;
  var GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS__Loc: int;
  var GUID_PROCESSOR_IDLE_ALLOW_SCALING__Loc: int;
  var GUID_LOCK_CONSOLE_ON_WAKE__Loc: int;
  var GUID_VIDEO_POWERDOWN_TIMEOUT__Loc: int;
  var GUID_SESSION_DISPLAY_STATUS__Loc: int;
  var GUID_PROCESSOR_IDLESTATE_POLICY__Loc: int;
  var GUID_PROCESSOR_IDLE_TIME_CHECK__Loc: int;
  var GUID_ALLOW_DISPLAY_REQUIRED__Loc: int;
  var GUID_UNATTEND_SLEEP_TIMEOUT__Loc: int;
  var GUID_INTSTEER_MODE__Loc: int;
  var GUID_IDLE_RESILIENCY_PLATFORM_STATE__Loc: int;
  var GUID_CRITICAL_POWER_TRANSITION__Loc: int;
  var GUID_PROCESSOR_PERF_INCREASE_THRESHOLD__Loc: int;
  var GUID_BACKGROUND_TASK_NOTIFICATION__Loc: int;
  var GUID_SLEEP_IDLE_THRESHOLD__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY__Loc: int;
  var GUID_PROCESSOR_PERF_HISTORY__Loc: int;
  var GUID_PROCESSOR_IDLE_STATE_MAXIMUM__Loc: int;
  var GUID_VIDEO_ANNOYANCE_TIMEOUT__Loc: int;
  var GUID_BATTERY_DISCHARGE_FLAGS_3__Loc: int;
  var GUID_PROCESSOR_THROTTLE_MAXIMUM__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_MAX_CORES__Loc: int;
  var GUID_PROCESSOR_PARKING_PERF_STATE__Loc: int;
  var GUID_PROCESSOR_PERF_DECREASE_POLICY__Loc: int;
  var GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE__Loc: int;
  var GUID_VIDEO_ADAPTIVE_POWERDOWN__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD__Loc: int;
  var GUID_MIN_POWER_SAVINGS__Loc: int;
  var GUID_VIDEO_CONSOLE_LOCK_TIMEOUT__Loc: int;
  var GUID_ALLOW_STANDBY_STATES__Loc: int;
  var GUID_PROCESSOR_PERF_LATENCY_HINT__Loc: int;
  var GUID_STANDBY_TIMEOUT__Loc: int;
  var GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD__Loc: int;
  var GUID_DEVICE_IDLE_POLICY__Loc: int;
  var GUID_PROCESSOR_PERFSTATE_POLICY__Loc: int;
  var GUID_PROCESSOR_PERF_BOOST_POLICY__Loc: int;
  var GUID_SESSION_USER_PRESENCE__Loc: int;
  var GUID_LIDCLOSE_ACTION__Loc: int;
  var GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS__Loc: int;
  var GUID_EXECUTION_REQUIRED_REQUEST_TIMEOUT__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD__Loc: int;
  var GUID_SLEEP_SUBGROUP__Loc: int;
  var GUID_BATTERY_DISCHARGE_ACTION_1__Loc: int;
  var GUID_PROCESSOR_PERF_INCREASE_POLICY__Loc: int;
  var GUID_VIDEO_SUBGROUP__Loc: int;
  var GUID_PROCESSOR_PERF_DECREASE_TIME__Loc: int;
  var GUID_MAX_POWER_SAVINGS__Loc: int;
  var GUID_TYPICAL_POWER_SAVINGS__Loc: int;
  var GUID_HIBERNATE_FASTS4_POLICY__Loc: int;
  var GUID_BATTERY_SUBGROUP__Loc: int;
  var GUID_PROCESSOR_PERF_DECREASE_HISTORY__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR__Loc: int;
  var GUID_PROCESSOR_SETTINGS_SUBGROUP__Loc: int;
  var GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__Loc: int;
  var GUID_IDLE_BACKGROUND_TASK__Loc: int;
  var GUID_BATTERY_DISCHARGE_FLAGS_2__Loc: int;
  var GUID_DISK_SUBGROUP__Loc: int;
  var GUID_HIBERNATE_TIMEOUT__Loc: int;
  var GUID_POWERSCHEME_PERSONALITY__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME__Loc: int;
  var GUID_BATTERY_DISCHARGE_LEVEL_1__Loc: int;
  var GUID_BATTERY_DISCHARGE_ACTION_0__Loc: int;
  var GUID_IDLE_RESILIENCY_SUBGROUP__Loc: int;
  var GUID_ENABLE_SWITCH_FORCED_SHUTDOWN__Loc: int;
  var GUID_BATTERY_DISCHARGE_ACTION_3__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING__Loc: int;
  var GUID_INTSTEER_LOAD_PER_PROC_TRIGGER__Loc: int;
  var GUID_PROCESSOR_PERF_DECREASE_THRESHOLD__Loc: int;
  var GUID_BATTERY_DISCHARGE_LEVEL_0__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_MIN_CORES__Loc: int;
  var GUID_PROCESSOR_PARKING_CONCURRENCY_THRESHOLD__Loc: int;
  var GUID_VIDEO_DIM_TIMEOUT__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD__Loc: int;
  var GUID_ACTIVE_POWERSCHEME__Loc: int;
  var GUID_SYSTEM_AWAYMODE__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR__Loc: int;
  var GUID_PROCESSOR_PERF_TIME_CHECK__Loc: int;
  var GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING__Loc: int;
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
  var sdv_other_harnessStackLocation_next__Loc: int;
  var sdv_harnessStackLocation__Loc: int;
  var sdv_IoCreateController_CONTROLLER_OBJECT__Loc: int;
  var sdv_devobj_top__Loc: int;
  var sdv_kdpc_val3__Loc: int;
  var sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc: int;
  var sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc: int;
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

  anon0:
    dup_assertVar := true;
    assume alloc > 0;
    call {:si_unique_call 166} BUS1394_CLASS_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume BUS1394_CLASS_GUID__Loc == BUS1394_CLASS_GUID;
    assume BUS1394_CLASS_GUID != 0;
    call {:si_unique_call 167} GUID_1394DIAG__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_1394DIAG__Loc == GUID_1394DIAG;
    assume GUID_1394DIAG != 0;
    call {:si_unique_call 168} GUID_1394VDEV__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_1394VDEV__Loc == GUID_1394VDEV;
    assume GUID_1394VDEV != 0;
    call {:si_unique_call 169} SLAM_guard_S_0_init__Loc := __HAVOC_malloc_or_null(240);
    assume SLAM_guard_S_0_init__Loc == SLAM_guard_S_0_init;
    assume SLAM_guard_S_0_init != 0;
    call {:si_unique_call 170} GUID_POWERBUTTON_ACTION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWERBUTTON_ACTION__Loc == GUID_POWERBUTTON_ACTION;
    assume GUID_POWERBUTTON_ACTION != 0;
    call {:si_unique_call 171} GUID_LIDOPEN_POWERSTATE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LIDOPEN_POWERSTATE__Loc == GUID_LIDOPEN_POWERSTATE;
    assume GUID_LIDOPEN_POWERSTATE != 0;
    call {:si_unique_call 172} GUID_PROCESSOR_PARKING_CORE_OVERRIDE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PARKING_CORE_OVERRIDE__Loc == GUID_PROCESSOR_PARKING_CORE_OVERRIDE;
    assume GUID_PROCESSOR_PARKING_CORE_OVERRIDE != 0;
    call {:si_unique_call 173} GUID_PROCESSOR_PERF_CORE_PARKING_HISTORY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_CORE_PARKING_HISTORY__Loc == GUID_PROCESSOR_PERF_CORE_PARKING_HISTORY;
    assume GUID_PROCESSOR_PERF_CORE_PARKING_HISTORY != 0;
    call {:si_unique_call 174} GUID_PCIEXPRESS_SETTINGS_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCIEXPRESS_SETTINGS_SUBGROUP__Loc == GUID_PCIEXPRESS_SETTINGS_SUBGROUP;
    assume GUID_PCIEXPRESS_SETTINGS_SUBGROUP != 0;
    call {:si_unique_call 175} GUID_PROCESSOR_PERF_INCREASE_TIME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_INCREASE_TIME__Loc == GUID_PROCESSOR_PERF_INCREASE_TIME;
    assume GUID_PROCESSOR_PERF_INCREASE_TIME != 0;
    call {:si_unique_call 176} GUID_DISK_COALESCING_POWERDOWN_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_COALESCING_POWERDOWN_TIMEOUT__Loc == GUID_DISK_COALESCING_POWERDOWN_TIMEOUT;
    assume GUID_DISK_COALESCING_POWERDOWN_TIMEOUT != 0;
    call {:si_unique_call 177} GUID_AUDIO_PLAYBACK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_AUDIO_PLAYBACK__Loc == GUID_AUDIO_PLAYBACK;
    assume GUID_AUDIO_PLAYBACK != 0;
    call {:si_unique_call 178} GUID_USERINTERFACEBUTTON_ACTION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_USERINTERFACEBUTTON_ACTION__Loc == GUID_USERINTERFACEBUTTON_ACTION;
    assume GUID_USERINTERFACEBUTTON_ACTION != 0;
    call {:si_unique_call 179} GUID_PROCESSOR_THROTTLE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_THROTTLE_POLICY__Loc == GUID_PROCESSOR_THROTTLE_POLICY;
    assume GUID_PROCESSOR_THROTTLE_POLICY != 0;
    call {:si_unique_call 180} GUID_PCIEXPRESS_ASPM_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PCIEXPRESS_ASPM_POLICY__Loc == GUID_PCIEXPRESS_ASPM_POLICY;
    assume GUID_PCIEXPRESS_ASPM_POLICY != 0;
    call {:si_unique_call 181} GUID_BATTERY_PERCENTAGE_REMAINING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_PERCENTAGE_REMAINING__Loc == GUID_BATTERY_PERCENTAGE_REMAINING;
    assume GUID_BATTERY_PERCENTAGE_REMAINING != 0;
    call {:si_unique_call 182} GUID_NON_ADAPTIVE_INPUT_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_NON_ADAPTIVE_INPUT_TIMEOUT__Loc == GUID_NON_ADAPTIVE_INPUT_TIMEOUT;
    assume GUID_NON_ADAPTIVE_INPUT_TIMEOUT != 0;
    call {:si_unique_call 183} GUID_ALLOW_RTC_WAKE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_RTC_WAKE__Loc == GUID_ALLOW_RTC_WAKE;
    assume GUID_ALLOW_RTC_WAKE != 0;
    call {:si_unique_call 184} GUID_GLOBAL_USER_PRESENCE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_GLOBAL_USER_PRESENCE__Loc == GUID_GLOBAL_USER_PRESENCE;
    assume GUID_GLOBAL_USER_PRESENCE != 0;
    call {:si_unique_call 185} GUID_BATTERY_DISCHARGE_ACTION_2__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_ACTION_2__Loc == GUID_BATTERY_DISCHARGE_ACTION_2;
    assume GUID_BATTERY_DISCHARGE_ACTION_2 != 0;
    call {:si_unique_call 186} GUID_BATTERY_DISCHARGE_LEVEL_2__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_LEVEL_2__Loc == GUID_BATTERY_DISCHARGE_LEVEL_2;
    assume GUID_BATTERY_DISCHARGE_LEVEL_2 != 0;
    call {:si_unique_call 187} GUID_APPLAUNCH_BUTTON__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_APPLAUNCH_BUTTON__Loc == GUID_APPLAUNCH_BUTTON;
    assume GUID_APPLAUNCH_BUTTON != 0;
    call {:si_unique_call 188} GUID_BATTERY_DISCHARGE_FLAGS_1__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_FLAGS_1__Loc == GUID_BATTERY_DISCHARGE_FLAGS_1;
    assume GUID_BATTERY_DISCHARGE_FLAGS_1 != 0;
    call {:si_unique_call 189} GUID_PROCESSOR_ALLOW_THROTTLING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_ALLOW_THROTTLING__Loc == GUID_PROCESSOR_ALLOW_THROTTLING;
    assume GUID_PROCESSOR_ALLOW_THROTTLING != 0;
    call {:si_unique_call 190} GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_THRESHOLD != 0;
    call {:si_unique_call 191} GUID_MONITOR_POWER_ON__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MONITOR_POWER_ON__Loc == GUID_MONITOR_POWER_ON;
    assume GUID_MONITOR_POWER_ON != 0;
    call {:si_unique_call 192} GUID_IDLE_RESILIENCY_PERIOD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IDLE_RESILIENCY_PERIOD__Loc == GUID_IDLE_RESILIENCY_PERIOD;
    assume GUID_IDLE_RESILIENCY_PERIOD != 0;
    call {:si_unique_call 193} GUID_PROCESSOR_DISTRIBUTE_UTILITY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_DISTRIBUTE_UTILITY__Loc == GUID_PROCESSOR_DISTRIBUTE_UTILITY;
    assume GUID_PROCESSOR_DISTRIBUTE_UTILITY != 0;
    call {:si_unique_call 194} GUID_PROCESSOR_PERF_INCREASE_HISTORY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_INCREASE_HISTORY__Loc == GUID_PROCESSOR_PERF_INCREASE_HISTORY;
    assume GUID_PROCESSOR_PERF_INCREASE_HISTORY != 0;
    call {:si_unique_call 195} GUID_INTSTEER_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_INTSTEER_SUBGROUP__Loc == GUID_INTSTEER_SUBGROUP;
    assume GUID_INTSTEER_SUBGROUP != 0;
    call {:si_unique_call 196} GUID_DISK_BURST_IGNORE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_BURST_IGNORE_THRESHOLD__Loc == GUID_DISK_BURST_IGNORE_THRESHOLD;
    assume GUID_DISK_BURST_IGNORE_THRESHOLD != 0;
    call {:si_unique_call 197} GUID_SLEEPBUTTON_ACTION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SLEEPBUTTON_ACTION__Loc == GUID_SLEEPBUTTON_ACTION;
    assume GUID_SLEEPBUTTON_ACTION != 0;
    call {:si_unique_call 198} GUID_PROCESSOR_PERF_LATENCY_HINT_PERF__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_LATENCY_HINT_PERF__Loc == GUID_PROCESSOR_PERF_LATENCY_HINT_PERF;
    assume GUID_PROCESSOR_PERF_LATENCY_HINT_PERF != 0;
    call {:si_unique_call 199} GUID_PROCESSOR_IDLE_DISABLE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_DISABLE__Loc == GUID_PROCESSOR_IDLE_DISABLE;
    assume GUID_PROCESSOR_IDLE_DISABLE != 0;
    call {:si_unique_call 200} GUID_DISK_POWERDOWN_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_POWERDOWN_TIMEOUT__Loc == GUID_DISK_POWERDOWN_TIMEOUT;
    assume GUID_DISK_POWERDOWN_TIMEOUT != 0;
    call {:si_unique_call 201} GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_THRESHOLD != 0;
    call {:si_unique_call 202} GUID_DISK_IDLE_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_IDLE_TIMEOUT__Loc == GUID_DISK_IDLE_TIMEOUT;
    assume GUID_DISK_IDLE_TIMEOUT != 0;
    call {:si_unique_call 203} GUID_CONSOLE_DISPLAY_STATE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_CONSOLE_DISPLAY_STATE__Loc == GUID_CONSOLE_DISPLAY_STATE;
    assume GUID_CONSOLE_DISPLAY_STATE != 0;
    call {:si_unique_call 204} GUID_ADAPTIVE_POWER_BEHAVIOR_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ADAPTIVE_POWER_BEHAVIOR_SUBGROUP__Loc == GUID_ADAPTIVE_POWER_BEHAVIOR_SUBGROUP;
    assume GUID_ADAPTIVE_POWER_BEHAVIOR_SUBGROUP != 0;
    call {:si_unique_call 205} GUID_BATTERY_DISCHARGE_FLAGS_0__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_FLAGS_0__Loc == GUID_BATTERY_DISCHARGE_FLAGS_0;
    assume GUID_BATTERY_DISCHARGE_FLAGS_0 != 0;
    call {:si_unique_call 206} GUID_PROCESSOR_PARKING_HEADROOM_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PARKING_HEADROOM_THRESHOLD__Loc == GUID_PROCESSOR_PARKING_HEADROOM_THRESHOLD;
    assume GUID_PROCESSOR_PARKING_HEADROOM_THRESHOLD != 0;
    call {:si_unique_call 207} GUID_ACDC_POWER_SOURCE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACDC_POWER_SOURCE__Loc == GUID_ACDC_POWER_SOURCE;
    assume GUID_ACDC_POWER_SOURCE != 0;
    call {:si_unique_call 208} GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS__Loc == GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS;
    assume GUID_DEVICE_POWER_POLICY_VIDEO_DIM_BRIGHTNESS != 0;
    call {:si_unique_call 209} GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD__Loc == GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD;
    assume GUID_PROCESSOR_IDLE_PROMOTE_THRESHOLD != 0;
    call {:si_unique_call 210} GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME__Loc == GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME;
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_TIME != 0;
    call {:si_unique_call 211} GUID_PROCESSOR_THROTTLE_MINIMUM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_THROTTLE_MINIMUM__Loc == GUID_PROCESSOR_THROTTLE_MINIMUM;
    assume GUID_PROCESSOR_THROTTLE_MINIMUM != 0;
    call {:si_unique_call 212} GUID_ALLOW_AWAYMODE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_AWAYMODE__Loc == GUID_ALLOW_AWAYMODE;
    assume GUID_ALLOW_AWAYMODE != 0;
    call {:si_unique_call 213} NO_SUBGROUP_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume NO_SUBGROUP_GUID__Loc == NO_SUBGROUP_GUID;
    assume NO_SUBGROUP_GUID != 0;
    call {:si_unique_call 214} GUID_DISK_ADAPTIVE_POWERDOWN__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_ADAPTIVE_POWERDOWN__Loc == GUID_DISK_ADAPTIVE_POWERDOWN;
    assume GUID_DISK_ADAPTIVE_POWERDOWN != 0;
    call {:si_unique_call 215} GUID_VIDEO_FULLSCREEN_PLAYBACK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_FULLSCREEN_PLAYBACK__Loc == GUID_VIDEO_FULLSCREEN_PLAYBACK;
    assume GUID_VIDEO_FULLSCREEN_PLAYBACK != 0;
    call {:si_unique_call 216} GUID_SYSTEM_BUTTON_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SYSTEM_BUTTON_SUBGROUP__Loc == GUID_SYSTEM_BUTTON_SUBGROUP;
    assume GUID_SYSTEM_BUTTON_SUBGROUP != 0;
    call {:si_unique_call 217} GUID_INTSTEER_TIME_UNPARK_TRIGGER__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_INTSTEER_TIME_UNPARK_TRIGGER__Loc == GUID_INTSTEER_TIME_UNPARK_TRIGGER;
    assume GUID_INTSTEER_TIME_UNPARK_TRIGGER != 0;
    call {:si_unique_call 218} GUID_SYSTEM_COOLING_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SYSTEM_COOLING_POLICY__Loc == GUID_SYSTEM_COOLING_POLICY;
    assume GUID_SYSTEM_COOLING_POLICY != 0;
    call {:si_unique_call 219} GUID_PROCESSOR_PERF_BOOST_MODE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_BOOST_MODE__Loc == GUID_PROCESSOR_PERF_BOOST_MODE;
    assume GUID_PROCESSOR_PERF_BOOST_MODE != 0;
    call {:si_unique_call 220} ALL_POWERSCHEMES_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume ALL_POWERSCHEMES_GUID__Loc == ALL_POWERSCHEMES_GUID;
    assume ALL_POWERSCHEMES_GUID != 0;
    call {:si_unique_call 221} GUID_LIDSWITCH_STATE_CHANGE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LIDSWITCH_STATE_CHANGE__Loc == GUID_LIDSWITCH_STATE_CHANGE;
    assume GUID_LIDSWITCH_STATE_CHANGE != 0;
    call {:si_unique_call 222} GUID_BATTERY_DISCHARGE_LEVEL_3__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_LEVEL_3__Loc == GUID_BATTERY_DISCHARGE_LEVEL_3;
    assume GUID_BATTERY_DISCHARGE_LEVEL_3 != 0;
    call {:si_unique_call 223} GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY__Loc == GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY;
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_POLICY != 0;
    call {:si_unique_call 224} GUID_ALLOW_SYSTEM_REQUIRED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_SYSTEM_REQUIRED__Loc == GUID_ALLOW_SYSTEM_REQUIRED;
    assume GUID_ALLOW_SYSTEM_REQUIRED != 0;
    call {:si_unique_call 225} GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS__Loc == GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS;
    assume GUID_VIDEO_ADAPTIVE_DISPLAY_BRIGHTNESS != 0;
    call {:si_unique_call 226} GUID_PROCESSOR_IDLE_ALLOW_SCALING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_ALLOW_SCALING__Loc == GUID_PROCESSOR_IDLE_ALLOW_SCALING;
    assume GUID_PROCESSOR_IDLE_ALLOW_SCALING != 0;
    call {:si_unique_call 227} GUID_LOCK_CONSOLE_ON_WAKE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LOCK_CONSOLE_ON_WAKE__Loc == GUID_LOCK_CONSOLE_ON_WAKE;
    assume GUID_LOCK_CONSOLE_ON_WAKE != 0;
    call {:si_unique_call 228} GUID_VIDEO_POWERDOWN_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_POWERDOWN_TIMEOUT__Loc == GUID_VIDEO_POWERDOWN_TIMEOUT;
    assume GUID_VIDEO_POWERDOWN_TIMEOUT != 0;
    call {:si_unique_call 229} GUID_SESSION_DISPLAY_STATUS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SESSION_DISPLAY_STATUS__Loc == GUID_SESSION_DISPLAY_STATUS;
    assume GUID_SESSION_DISPLAY_STATUS != 0;
    call {:si_unique_call 230} GUID_PROCESSOR_IDLESTATE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLESTATE_POLICY__Loc == GUID_PROCESSOR_IDLESTATE_POLICY;
    assume GUID_PROCESSOR_IDLESTATE_POLICY != 0;
    call {:si_unique_call 231} GUID_PROCESSOR_IDLE_TIME_CHECK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_TIME_CHECK__Loc == GUID_PROCESSOR_IDLE_TIME_CHECK;
    assume GUID_PROCESSOR_IDLE_TIME_CHECK != 0;
    call {:si_unique_call 232} GUID_ALLOW_DISPLAY_REQUIRED__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_DISPLAY_REQUIRED__Loc == GUID_ALLOW_DISPLAY_REQUIRED;
    assume GUID_ALLOW_DISPLAY_REQUIRED != 0;
    call {:si_unique_call 233} GUID_UNATTEND_SLEEP_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_UNATTEND_SLEEP_TIMEOUT__Loc == GUID_UNATTEND_SLEEP_TIMEOUT;
    assume GUID_UNATTEND_SLEEP_TIMEOUT != 0;
    call {:si_unique_call 234} GUID_INTSTEER_MODE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_INTSTEER_MODE__Loc == GUID_INTSTEER_MODE;
    assume GUID_INTSTEER_MODE != 0;
    call {:si_unique_call 235} GUID_IDLE_RESILIENCY_PLATFORM_STATE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IDLE_RESILIENCY_PLATFORM_STATE__Loc == GUID_IDLE_RESILIENCY_PLATFORM_STATE;
    assume GUID_IDLE_RESILIENCY_PLATFORM_STATE != 0;
    call {:si_unique_call 236} GUID_CRITICAL_POWER_TRANSITION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_CRITICAL_POWER_TRANSITION__Loc == GUID_CRITICAL_POWER_TRANSITION;
    assume GUID_CRITICAL_POWER_TRANSITION != 0;
    call {:si_unique_call 237} GUID_PROCESSOR_PERF_INCREASE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_INCREASE_THRESHOLD__Loc == GUID_PROCESSOR_PERF_INCREASE_THRESHOLD;
    assume GUID_PROCESSOR_PERF_INCREASE_THRESHOLD != 0;
    call {:si_unique_call 238} GUID_BACKGROUND_TASK_NOTIFICATION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BACKGROUND_TASK_NOTIFICATION__Loc == GUID_BACKGROUND_TASK_NOTIFICATION;
    assume GUID_BACKGROUND_TASK_NOTIFICATION != 0;
    call {:si_unique_call 239} GUID_SLEEP_IDLE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SLEEP_IDLE_THRESHOLD__Loc == GUID_SLEEP_IDLE_THRESHOLD;
    assume GUID_SLEEP_IDLE_THRESHOLD != 0;
    call {:si_unique_call 240} GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY__Loc == GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY;
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_POLICY != 0;
    call {:si_unique_call 241} GUID_PROCESSOR_PERF_HISTORY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_HISTORY__Loc == GUID_PROCESSOR_PERF_HISTORY;
    assume GUID_PROCESSOR_PERF_HISTORY != 0;
    call {:si_unique_call 242} GUID_PROCESSOR_IDLE_STATE_MAXIMUM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_STATE_MAXIMUM__Loc == GUID_PROCESSOR_IDLE_STATE_MAXIMUM;
    assume GUID_PROCESSOR_IDLE_STATE_MAXIMUM != 0;
    call {:si_unique_call 243} GUID_VIDEO_ANNOYANCE_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_ANNOYANCE_TIMEOUT__Loc == GUID_VIDEO_ANNOYANCE_TIMEOUT;
    assume GUID_VIDEO_ANNOYANCE_TIMEOUT != 0;
    call {:si_unique_call 244} GUID_BATTERY_DISCHARGE_FLAGS_3__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_FLAGS_3__Loc == GUID_BATTERY_DISCHARGE_FLAGS_3;
    assume GUID_BATTERY_DISCHARGE_FLAGS_3 != 0;
    call {:si_unique_call 245} GUID_PROCESSOR_THROTTLE_MAXIMUM__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_THROTTLE_MAXIMUM__Loc == GUID_PROCESSOR_THROTTLE_MAXIMUM;
    assume GUID_PROCESSOR_THROTTLE_MAXIMUM != 0;
    call {:si_unique_call 246} GUID_PROCESSOR_CORE_PARKING_MAX_CORES__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_MAX_CORES__Loc == GUID_PROCESSOR_CORE_PARKING_MAX_CORES;
    assume GUID_PROCESSOR_CORE_PARKING_MAX_CORES != 0;
    call {:si_unique_call 247} GUID_PROCESSOR_PARKING_PERF_STATE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PARKING_PERF_STATE__Loc == GUID_PROCESSOR_PARKING_PERF_STATE;
    assume GUID_PROCESSOR_PARKING_PERF_STATE != 0;
    call {:si_unique_call 248} GUID_PROCESSOR_PERF_DECREASE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_DECREASE_POLICY__Loc == GUID_PROCESSOR_PERF_DECREASE_POLICY;
    assume GUID_PROCESSOR_PERF_DECREASE_POLICY != 0;
    call {:si_unique_call 249} GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE__Loc == GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE;
    assume GUID_VIDEO_ADAPTIVE_PERCENT_INCREASE != 0;
    call {:si_unique_call 250} GUID_VIDEO_ADAPTIVE_POWERDOWN__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_ADAPTIVE_POWERDOWN__Loc == GUID_VIDEO_ADAPTIVE_POWERDOWN;
    assume GUID_VIDEO_ADAPTIVE_POWERDOWN != 0;
    call {:si_unique_call 251} GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_THRESHOLD != 0;
    call {:si_unique_call 252} GUID_MIN_POWER_SAVINGS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MIN_POWER_SAVINGS__Loc == GUID_MIN_POWER_SAVINGS;
    assume GUID_MIN_POWER_SAVINGS != 0;
    call {:si_unique_call 253} GUID_VIDEO_CONSOLE_LOCK_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_CONSOLE_LOCK_TIMEOUT__Loc == GUID_VIDEO_CONSOLE_LOCK_TIMEOUT;
    assume GUID_VIDEO_CONSOLE_LOCK_TIMEOUT != 0;
    call {:si_unique_call 254} GUID_ALLOW_STANDBY_STATES__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ALLOW_STANDBY_STATES__Loc == GUID_ALLOW_STANDBY_STATES;
    assume GUID_ALLOW_STANDBY_STATES != 0;
    call {:si_unique_call 255} GUID_PROCESSOR_PERF_LATENCY_HINT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_LATENCY_HINT__Loc == GUID_PROCESSOR_PERF_LATENCY_HINT;
    assume GUID_PROCESSOR_PERF_LATENCY_HINT != 0;
    call {:si_unique_call 256} GUID_STANDBY_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_STANDBY_TIMEOUT__Loc == GUID_STANDBY_TIMEOUT;
    assume GUID_STANDBY_TIMEOUT != 0;
    call {:si_unique_call 257} GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD__Loc == GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD;
    assume GUID_PROCESSOR_IDLE_DEMOTE_THRESHOLD != 0;
    call {:si_unique_call 258} GUID_DEVICE_IDLE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_IDLE_POLICY__Loc == GUID_DEVICE_IDLE_POLICY;
    assume GUID_DEVICE_IDLE_POLICY != 0;
    call {:si_unique_call 259} GUID_PROCESSOR_PERFSTATE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERFSTATE_POLICY__Loc == GUID_PROCESSOR_PERFSTATE_POLICY;
    assume GUID_PROCESSOR_PERFSTATE_POLICY != 0;
    call {:si_unique_call 260} GUID_PROCESSOR_PERF_BOOST_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_BOOST_POLICY__Loc == GUID_PROCESSOR_PERF_BOOST_POLICY;
    assume GUID_PROCESSOR_PERF_BOOST_POLICY != 0;
    call {:si_unique_call 261} GUID_SESSION_USER_PRESENCE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SESSION_USER_PRESENCE__Loc == GUID_SESSION_USER_PRESENCE;
    assume GUID_SESSION_USER_PRESENCE != 0;
    call {:si_unique_call 262} GUID_LIDCLOSE_ACTION__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_LIDCLOSE_ACTION__Loc == GUID_LIDCLOSE_ACTION;
    assume GUID_LIDCLOSE_ACTION != 0;
    call {:si_unique_call 263} GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS__Loc == GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS;
    assume GUID_VIDEO_CURRENT_MONITOR_BRIGHTNESS != 0;
    call {:si_unique_call 264} GUID_EXECUTION_REQUIRED_REQUEST_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_EXECUTION_REQUIRED_REQUEST_TIMEOUT__Loc == GUID_EXECUTION_REQUIRED_REQUEST_TIMEOUT;
    assume GUID_EXECUTION_REQUIRED_REQUEST_TIMEOUT != 0;
    call {:si_unique_call 265} GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_THRESHOLD != 0;
    call {:si_unique_call 266} GUID_SLEEP_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SLEEP_SUBGROUP__Loc == GUID_SLEEP_SUBGROUP;
    assume GUID_SLEEP_SUBGROUP != 0;
    call {:si_unique_call 267} GUID_BATTERY_DISCHARGE_ACTION_1__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_ACTION_1__Loc == GUID_BATTERY_DISCHARGE_ACTION_1;
    assume GUID_BATTERY_DISCHARGE_ACTION_1 != 0;
    call {:si_unique_call 268} GUID_PROCESSOR_PERF_INCREASE_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_INCREASE_POLICY__Loc == GUID_PROCESSOR_PERF_INCREASE_POLICY;
    assume GUID_PROCESSOR_PERF_INCREASE_POLICY != 0;
    call {:si_unique_call 269} GUID_VIDEO_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_SUBGROUP__Loc == GUID_VIDEO_SUBGROUP;
    assume GUID_VIDEO_SUBGROUP != 0;
    call {:si_unique_call 270} GUID_PROCESSOR_PERF_DECREASE_TIME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_DECREASE_TIME__Loc == GUID_PROCESSOR_PERF_DECREASE_TIME;
    assume GUID_PROCESSOR_PERF_DECREASE_TIME != 0;
    call {:si_unique_call 271} GUID_MAX_POWER_SAVINGS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_MAX_POWER_SAVINGS__Loc == GUID_MAX_POWER_SAVINGS;
    assume GUID_MAX_POWER_SAVINGS != 0;
    call {:si_unique_call 272} GUID_TYPICAL_POWER_SAVINGS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_TYPICAL_POWER_SAVINGS__Loc == GUID_TYPICAL_POWER_SAVINGS;
    assume GUID_TYPICAL_POWER_SAVINGS != 0;
    call {:si_unique_call 273} GUID_HIBERNATE_FASTS4_POLICY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HIBERNATE_FASTS4_POLICY__Loc == GUID_HIBERNATE_FASTS4_POLICY;
    assume GUID_HIBERNATE_FASTS4_POLICY != 0;
    call {:si_unique_call 274} GUID_BATTERY_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_SUBGROUP__Loc == GUID_BATTERY_SUBGROUP;
    assume GUID_BATTERY_SUBGROUP != 0;
    call {:si_unique_call 275} GUID_PROCESSOR_PERF_DECREASE_HISTORY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_DECREASE_HISTORY__Loc == GUID_PROCESSOR_PERF_DECREASE_HISTORY;
    assume GUID_PROCESSOR_PERF_DECREASE_HISTORY != 0;
    call {:si_unique_call 276} GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR__Loc == GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR;
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_HISTORY_DECREASE_FACTOR != 0;
    call {:si_unique_call 277} GUID_PROCESSOR_SETTINGS_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_SETTINGS_SUBGROUP__Loc == GUID_PROCESSOR_SETTINGS_SUBGROUP;
    assume GUID_PROCESSOR_SETTINGS_SUBGROUP != 0;
    call {:si_unique_call 278} GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS__Loc == GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS;
    assume GUID_DEVICE_POWER_POLICY_VIDEO_BRIGHTNESS != 0;
    call {:si_unique_call 279} GUID_IDLE_BACKGROUND_TASK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IDLE_BACKGROUND_TASK__Loc == GUID_IDLE_BACKGROUND_TASK;
    assume GUID_IDLE_BACKGROUND_TASK != 0;
    call {:si_unique_call 280} GUID_BATTERY_DISCHARGE_FLAGS_2__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_FLAGS_2__Loc == GUID_BATTERY_DISCHARGE_FLAGS_2;
    assume GUID_BATTERY_DISCHARGE_FLAGS_2 != 0;
    call {:si_unique_call 281} GUID_DISK_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_DISK_SUBGROUP__Loc == GUID_DISK_SUBGROUP;
    assume GUID_DISK_SUBGROUP != 0;
    call {:si_unique_call 282} GUID_HIBERNATE_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_HIBERNATE_TIMEOUT__Loc == GUID_HIBERNATE_TIMEOUT;
    assume GUID_HIBERNATE_TIMEOUT != 0;
    call {:si_unique_call 283} GUID_POWERSCHEME_PERSONALITY__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_POWERSCHEME_PERSONALITY__Loc == GUID_POWERSCHEME_PERSONALITY;
    assume GUID_POWERSCHEME_PERSONALITY != 0;
    call {:si_unique_call 284} GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME__Loc == GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME;
    assume GUID_PROCESSOR_CORE_PARKING_INCREASE_TIME != 0;
    call {:si_unique_call 285} GUID_BATTERY_DISCHARGE_LEVEL_1__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_LEVEL_1__Loc == GUID_BATTERY_DISCHARGE_LEVEL_1;
    assume GUID_BATTERY_DISCHARGE_LEVEL_1 != 0;
    call {:si_unique_call 286} GUID_BATTERY_DISCHARGE_ACTION_0__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_ACTION_0__Loc == GUID_BATTERY_DISCHARGE_ACTION_0;
    assume GUID_BATTERY_DISCHARGE_ACTION_0 != 0;
    call {:si_unique_call 287} GUID_IDLE_RESILIENCY_SUBGROUP__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_IDLE_RESILIENCY_SUBGROUP__Loc == GUID_IDLE_RESILIENCY_SUBGROUP;
    assume GUID_IDLE_RESILIENCY_SUBGROUP != 0;
    call {:si_unique_call 288} GUID_ENABLE_SWITCH_FORCED_SHUTDOWN__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ENABLE_SWITCH_FORCED_SHUTDOWN__Loc == GUID_ENABLE_SWITCH_FORCED_SHUTDOWN;
    assume GUID_ENABLE_SWITCH_FORCED_SHUTDOWN != 0;
    call {:si_unique_call 289} GUID_BATTERY_DISCHARGE_ACTION_3__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_ACTION_3__Loc == GUID_BATTERY_DISCHARGE_ACTION_3;
    assume GUID_BATTERY_DISCHARGE_ACTION_3 != 0;
    call {:si_unique_call 290} GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING__Loc == GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING;
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_WEIGHTING != 0;
    call {:si_unique_call 291} GUID_INTSTEER_LOAD_PER_PROC_TRIGGER__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_INTSTEER_LOAD_PER_PROC_TRIGGER__Loc == GUID_INTSTEER_LOAD_PER_PROC_TRIGGER;
    assume GUID_INTSTEER_LOAD_PER_PROC_TRIGGER != 0;
    call {:si_unique_call 292} GUID_PROCESSOR_PERF_DECREASE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_DECREASE_THRESHOLD__Loc == GUID_PROCESSOR_PERF_DECREASE_THRESHOLD;
    assume GUID_PROCESSOR_PERF_DECREASE_THRESHOLD != 0;
    call {:si_unique_call 293} GUID_BATTERY_DISCHARGE_LEVEL_0__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_BATTERY_DISCHARGE_LEVEL_0__Loc == GUID_BATTERY_DISCHARGE_LEVEL_0;
    assume GUID_BATTERY_DISCHARGE_LEVEL_0 != 0;
    call {:si_unique_call 294} GUID_PROCESSOR_CORE_PARKING_MIN_CORES__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_MIN_CORES__Loc == GUID_PROCESSOR_CORE_PARKING_MIN_CORES;
    assume GUID_PROCESSOR_CORE_PARKING_MIN_CORES != 0;
    call {:si_unique_call 295} GUID_PROCESSOR_PARKING_CONCURRENCY_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PARKING_CONCURRENCY_THRESHOLD__Loc == GUID_PROCESSOR_PARKING_CONCURRENCY_THRESHOLD;
    assume GUID_PROCESSOR_PARKING_CONCURRENCY_THRESHOLD != 0;
    call {:si_unique_call 296} GUID_VIDEO_DIM_TIMEOUT__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_VIDEO_DIM_TIMEOUT__Loc == GUID_VIDEO_DIM_TIMEOUT;
    assume GUID_VIDEO_DIM_TIMEOUT != 0;
    call {:si_unique_call 297} GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD__Loc == GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD;
    assume GUID_PROCESSOR_CORE_PARKING_DECREASE_THRESHOLD != 0;
    call {:si_unique_call 298} GUID_ACTIVE_POWERSCHEME__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_ACTIVE_POWERSCHEME__Loc == GUID_ACTIVE_POWERSCHEME;
    assume GUID_ACTIVE_POWERSCHEME != 0;
    call {:si_unique_call 299} GUID_SYSTEM_AWAYMODE__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_SYSTEM_AWAYMODE__Loc == GUID_SYSTEM_AWAYMODE;
    assume GUID_SYSTEM_AWAYMODE != 0;
    call {:si_unique_call 300} GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR__Loc == GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR;
    assume GUID_PROCESSOR_CORE_PARKING_OVER_UTILIZATION_HISTORY_DECREASE_FACTOR != 0;
    call {:si_unique_call 301} GUID_PROCESSOR_PERF_TIME_CHECK__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_PERF_TIME_CHECK__Loc == GUID_PROCESSOR_PERF_TIME_CHECK;
    assume GUID_PROCESSOR_PERF_TIME_CHECK != 0;
    call {:si_unique_call 302} GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING__Loc := __HAVOC_malloc_or_null(16);
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING__Loc == GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING;
    assume GUID_PROCESSOR_CORE_PARKING_AFFINITY_WEIGHTING != 0;
    call {:si_unique_call 303} sdv_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_harnessStackLocation_next__Loc == sdv_harnessStackLocation_next;
    assume sdv_harnessStackLocation_next != 0;
    call {:si_unique_call 304} sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc := __HAVOC_malloc_or_null(76);
    assume sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc == sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX;
    assume sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX != 0;
    call {:si_unique_call 305} WHEA_ERROR_PACKET_SECTION_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume WHEA_ERROR_PACKET_SECTION_GUID__Loc == WHEA_ERROR_PACKET_SECTION_GUID;
    assume WHEA_ERROR_PACKET_SECTION_GUID != 0;
    call {:si_unique_call 306} sdv_IoBuildAsynchronousFsdRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoBuildAsynchronousFsdRequest_harnessIrp__Loc == sdv_IoBuildAsynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildAsynchronousFsdRequest_harnessIrp != 0;
    call {:si_unique_call 307} sdv_IoGetDeviceToVerify_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_IoGetDeviceToVerify_DEVICE_OBJECT__Loc == sdv_IoGetDeviceToVerify_DEVICE_OBJECT;
    assume sdv_IoGetDeviceToVerify_DEVICE_OBJECT != 0;
    call {:si_unique_call 308} sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next__Loc == sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next;
    assume sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next != 0;
    call {:si_unique_call 309} sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock__Loc == sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;
    assume sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    call {:si_unique_call 310} sdv_ControllerIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_ControllerIrp__Loc == sdv_ControllerIrp;
    assume sdv_ControllerIrp != 0;
    call {:si_unique_call 311} sdv_devobj_pdo__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_pdo__Loc == sdv_devobj_pdo;
    assume sdv_devobj_pdo != 0;
    call {:si_unique_call 312} sdv_IoGetDmaAdapter_DMA_ADAPTER__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_IoGetDmaAdapter_DMA_ADAPTER__Loc == sdv_IoGetDmaAdapter_DMA_ADAPTER;
    assume sdv_IoGetDmaAdapter_DMA_ADAPTER != 0;
    call {:si_unique_call 313} sdv_IoInitializeIrp_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoInitializeIrp_harnessIrp__Loc == sdv_IoInitializeIrp_harnessIrp;
    assume sdv_IoInitializeIrp_harnessIrp != 0;
    call {:si_unique_call 314} sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT__Loc == sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT;
    assume sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT != 0;
    call {:si_unique_call 315} sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next__Loc == sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next;
    assume sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next != 0;
    call {:si_unique_call 316} sdv_IoCreateSynchronizationEvent_KEVENT__Loc := __HAVOC_malloc_or_null(156);
    assume sdv_IoCreateSynchronizationEvent_KEVENT__Loc == sdv_IoCreateSynchronizationEvent_KEVENT;
    assume sdv_IoCreateSynchronizationEvent_KEVENT != 0;
    call {:si_unique_call 317} sdv_other_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_other_harnessStackLocation_next__Loc == sdv_other_harnessStackLocation_next;
    assume sdv_other_harnessStackLocation_next != 0;
    call {:si_unique_call 318} sdv_harnessStackLocation__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_harnessStackLocation__Loc == sdv_harnessStackLocation;
    assume sdv_harnessStackLocation != 0;
    call {:si_unique_call 319} sdv_IoCreateController_CONTROLLER_OBJECT__Loc := __HAVOC_malloc_or_null(60);
    assume sdv_IoCreateController_CONTROLLER_OBJECT__Loc == sdv_IoCreateController_CONTROLLER_OBJECT;
    assume sdv_IoCreateController_CONTROLLER_OBJECT != 0;
    call {:si_unique_call 320} sdv_devobj_top__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_top__Loc == sdv_devobj_top;
    assume sdv_devobj_top != 0;
    call {:si_unique_call 321} sdv_kdpc_val3__Loc := __HAVOC_malloc_or_null(44);
    assume sdv_kdpc_val3__Loc == sdv_kdpc_val3;
    assume sdv_kdpc_val3 != 0;
    call {:si_unique_call 322} sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc == sdv_IoBuildSynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildSynchronousFsdRequest_harnessIrp != 0;
    call {:si_unique_call 323} sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc == sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT;
    assume sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT != 0;
    call {:si_unique_call 324} sdv_MapRegisterBase_val__Loc := __HAVOC_malloc_or_null(4);
    assume sdv_MapRegisterBase_val__Loc == sdv_MapRegisterBase_val;
    assume sdv_MapRegisterBase_val != 0;
    call {:si_unique_call 325} sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING__Loc := __HAVOC_malloc_or_null(16);
    assume sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING__Loc == sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING;
    assume sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING != 0;
    call {:si_unique_call 326} sdv_IoMakeAssociatedIrp_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoMakeAssociatedIrp_harnessIrp__Loc == sdv_IoMakeAssociatedIrp_harnessIrp;
    assume sdv_IoMakeAssociatedIrp_harnessIrp != 0;
    call {:si_unique_call 327} sdv_devobj_child_pdo__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_child_pdo__Loc == sdv_devobj_child_pdo;
    assume sdv_devobj_child_pdo != 0;
    call {:si_unique_call 328} sdv_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_harnessIrp__Loc == sdv_harnessIrp;
    assume sdv_harnessIrp != 0;
    call {:si_unique_call 329} sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next__Loc == sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next;
    assume sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next != 0;
    call {:si_unique_call 330} sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock__Loc == sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock;
    assume sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    call {:si_unique_call 331} sdv_kinterrupt_val__Loc := __HAVOC_malloc_or_null(0);
    assume sdv_kinterrupt_val__Loc == sdv_kinterrupt_val;
    assume sdv_kinterrupt_val != 0;
    call {:si_unique_call 332} sdv_fx_dev_object__Loc := __HAVOC_malloc_or_null(40);
    assume sdv_fx_dev_object__Loc == sdv_fx_dev_object;
    assume sdv_fx_dev_object != 0;
    call {:si_unique_call 333} sdv_devobj_fdo__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_fdo__Loc == sdv_devobj_fdo;
    assume sdv_devobj_fdo != 0;
    call {:si_unique_call 334} sdv_StartIoIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_StartIoIrp__Loc == sdv_StartIoIrp;
    assume sdv_StartIoIrp != 0;
    call {:si_unique_call 335} sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc == sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;
    assume sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    call {:si_unique_call 336} sdv_PowerIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_PowerIrp__Loc == sdv_PowerIrp;
    assume sdv_PowerIrp != 0;
    call {:si_unique_call 337} sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc == sdv_IoBuildDeviceIoControlRequest_harnessIrp;
    assume sdv_IoBuildDeviceIoControlRequest_harnessIrp != 0;
    call {:si_unique_call 338} sdv_other_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_other_harnessIrp__Loc == sdv_other_harnessIrp;
    assume sdv_other_harnessIrp != 0;
    call {:si_unique_call 339} sdv_IoCreateNotificationEvent_KEVENT__Loc := __HAVOC_malloc_or_null(156);
    assume sdv_IoCreateNotificationEvent_KEVENT__Loc == sdv_IoCreateNotificationEvent_KEVENT;
    assume sdv_IoCreateNotificationEvent_KEVENT != 0;
    call {:si_unique_call 340} sdv_other_harnessStackLocation__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_other_harnessStackLocation__Loc == sdv_other_harnessStackLocation;
    assume sdv_other_harnessStackLocation != 0;
    call {:si_unique_call 341} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_harnessDeviceExtension_two == boogieTmp;
    call {:si_unique_call 342} boogieTmp := __HAVOC_malloc_or_null(4);
    call {:si_unique_call 343} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_pDpcContext == boogieTmp;
    call {:si_unique_call 344} boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_harnessDeviceExtension == boogieTmp;
    call {:si_unique_call 345} boogieTmp := __HAVOC_malloc_or_null(4);
    assume igdoe == boogieTmp;
    call {:si_unique_call 346} boogieTmp := __HAVOC_malloc_or_null(240);
    assume sicrni == boogieTmp;
    assume {:mainInitDone} true;
    call {:si_unique_call 347} corralExtraInit();
    call {:si_unique_call 348} corralExplainErrorInit();
    call {:si_unique_call 349} _sdv_init7();
    call {:si_unique_call 350} _sdv_init1();
    call {:si_unique_call 351} _sdv_init4();
    call {:si_unique_call 352} _sdv_init5();
    call {:si_unique_call 353} _sdv_init3();
    call {:si_unique_call 354} _sdv_init2();
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} sdv_harnessDeviceExtension == 0;
    Tmp_95 := 0;
    goto L30;

  L30:
    assume Tmp_95 != 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} sdv_harnessDeviceExtension_two == 0;
    Tmp_94 := 0;
    goto L34;

  L34:
    assume Tmp_94 != 0;
    assume {:nonnull} sdv_irp != 0;
    assume sdv_irp > 0;
    assume {:nonnull} sdv_other_irp != 0;
    assume sdv_other_irp > 0;
    call {:si_unique_call 355} sdv_main();
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
    Tmp_94 := 1;
    goto L34;

  anon9_Then:
    assume {:partition} sdv_harnessDeviceExtension != 0;
    Tmp_95 := 1;
    goto L30;
}



procedure {:origName "sdv_IoSkipCurrentIrpStackLocation"} {:osmodel} sdv_IoSkipCurrentIrpStackLocation(actual_pirp_8: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IoSkipCurrentIrpStackLocation"} {:osmodel} sdv_IoSkipCurrentIrpStackLocation(actual_pirp_8: int)
{
  var {:pointer} pirp_8: int;
  var vslice_dummy_var_26: int;

  anon0:
    call {:si_unique_call 356} vslice_dummy_var_26 := __HAVOC_malloc(4);
    pirp_8 := actual_pirp_8;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} pirp_8 == sdv_harnessIrp;
    goto L4;

  L4:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} pirp_8 == sdv_other_harnessIrp;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} pirp_8 != sdv_other_harnessIrp;
    goto L1;

  anon5_Then:
    assume {:partition} pirp_8 != sdv_harnessIrp;
    goto L4;
}



procedure {:origName "sdv_RunPowerCompletionRoutines"} {:osmodel} sdv_RunPowerCompletionRoutines(actual_DeviceObject_9: int, actual_MinorFunction_1: int, actual_structPtr888PowerState: int, actual_Context_3: int, actual_IoStatus: int, actual_CompletionFunction_1: int) returns (Tmp_98: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_RunPowerCompletionRoutines"} {:osmodel} sdv_RunPowerCompletionRoutines(actual_DeviceObject_9: int, actual_MinorFunction_1: int, actual_structPtr888PowerState: int, actual_Context_3: int, actual_IoStatus: int, actual_CompletionFunction_1: int) returns (Tmp_98: int)
{
  var {:scalar} PowerState: int;
  var {:scalar} CompletionFunction_2: int;
  var {:pointer} DeviceObject_9: int;
  var {:scalar} MinorFunction_1: int;
  var {:pointer} structPtr888PowerState: int;
  var {:pointer} Context_3: int;
  var {:pointer} IoStatus: int;
  var {:scalar} CompletionFunction_1: int;

  anon0:
    call {:si_unique_call 357} PowerState := __HAVOC_malloc(8);
    DeviceObject_9 := actual_DeviceObject_9;
    MinorFunction_1 := actual_MinorFunction_1;
    structPtr888PowerState := actual_structPtr888PowerState;
    Context_3 := actual_Context_3;
    IoStatus := actual_IoStatus;
    CompletionFunction_1 := actual_CompletionFunction_1;
    assume {:nonnull} PowerState != 0;
    assume PowerState > 0;
    assume {:nonnull} structPtr888PowerState != 0;
    assume structPtr888PowerState > 0;
    assume {:nonnull} PowerState != 0;
    assume PowerState > 0;
    assume {:nonnull} structPtr888PowerState != 0;
    assume structPtr888PowerState > 0;
    CompletionFunction_2 := 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} CompletionFunction_1 == li2bplFunctionConstant388;
    call {:si_unique_call 358} sdv_stub_power_completion_begin();
    call {:si_unique_call 359} t1394VDev_DeviceSetPowerIrpCompletion(DeviceObject_9, MinorFunction_1, PowerState, Context_3, IoStatus);
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} yogi_error != 1;
    CompletionFunction_2 := 1;
    goto L6;

  L6:
    Tmp_98 := CompletionFunction_2;
    goto LM2;

  LM2:
    return;

  anon6_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon5_Then:
    assume {:partition} CompletionFunction_1 != li2bplFunctionConstant388;
    goto L6;
}



procedure {:origName "IoAllocateMdl"} {:osmodel} IoAllocateMdl(actual_VirtualAddress: int, actual_Length: int, actual_SecondaryBuffer: int, actual_ChargeQuota: int, actual_Irp_8: int) returns (Tmp_100: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoAllocateMdl"} {:osmodel} IoAllocateMdl(actual_VirtualAddress: int, actual_Length: int, actual_SecondaryBuffer: int, actual_ChargeQuota: int, actual_Irp_8: int) returns (Tmp_100: int)
{
  var {:pointer} sdv_97: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 360} sdv_97 := __HAVOC_malloc(1);
    Tmp_100 := sdv_97;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_100 := 0;
    goto L1;
}



procedure {:origName "sdv_RtlZeroMemory"} {:osmodel} sdv_RtlZeroMemory(actual_Destination: int, actual_Length_1: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_RtlZeroMemory"} {:osmodel} sdv_RtlZeroMemory(actual_Destination: int, actual_Length_1: int)
{
  var vslice_dummy_var_27: int;

  anon0:
    call {:si_unique_call 361} vslice_dummy_var_27 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoFreeMdl"} {:osmodel} IoFreeMdl(actual_Mdl_1: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoFreeMdl"} {:osmodel} IoFreeMdl(actual_Mdl_1: int)
{
  var vslice_dummy_var_28: int;

  anon0:
    call {:si_unique_call 362} vslice_dummy_var_28 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_IoMarkIrpPending"} {:osmodel} sdv_IoMarkIrpPending(actual_pirp_9: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IoMarkIrpPending"} {:osmodel} sdv_IoMarkIrpPending(actual_pirp_9: int)
{
  var vslice_dummy_var_29: int;

  anon0:
    call {:si_unique_call 363} vslice_dummy_var_29 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_RunDispatchFunction"} {:osmodel} sdv_RunDispatchFunction(actual_po: int, actual_pirp_10: int) returns (Tmp_108: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_RunDispatchFunction"} {:osmodel} sdv_RunDispatchFunction(actual_po: int, actual_pirp_10: int) returns (Tmp_108: int)
{
  var {:pointer} ps: int;
  var {:scalar} minor: int;
  var {:scalar} Tmp_109: int;
  var {:scalar} sdv_106: int;
  var {:scalar} Tmp_111: int;
  var {:scalar} status_2: int;
  var {:pointer} po: int;
  var {:pointer} pirp_10: int;

  anon0:
    po := actual_po;
    pirp_10 := actual_pirp_10;
    status_2 := 0;
    minor := sdv_106;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    havoc ps;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    call {:si_unique_call 364} sdv_SetStatus(pirp_10);
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    assume {:nonnull} ps != 0;
    assume ps > 0;
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 365} sdv_stub_dispatch_begin();
    goto anon55_Then, anon55_Else;

  anon55_Else:
    goto anon74_Then, anon74_Else;

  anon74_Else:
    goto anon73_Then, anon73_Else;

  anon73_Else:
    goto anon72_Then, anon72_Else;

  anon72_Else:
    goto anon71_Then, anon71_Else;

  anon71_Else:
    goto anon70_Then, anon70_Else;

  anon70_Else:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    goto anon68_Then, anon68_Else;

  anon68_Else:
    goto anon67_Then, anon67_Else;

  anon67_Else:
    goto anon66_Then, anon66_Else;

  anon66_Else:
    goto anon65_Then, anon65_Else;

  anon65_Else:
    goto anon64_Then, anon64_Else;

  anon64_Else:
    goto anon63_Then, anon63_Else;

  anon63_Else:
    goto anon62_Then, anon62_Else;

  anon62_Else:
    goto anon61_Then, anon61_Else;

  anon61_Else:
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    assume {:nonnull} ps != 0;
    assume ps > 0;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    goto L60;

  L60:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    goto anon59_Then, anon59_Else;

  anon59_Else:
    Tmp_111 := 0;
    goto L213;

  L213:
    assume Tmp_111 != 0;
    goto L61;

  L61:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    goto L66;

  L66:
    call {:si_unique_call 366} status_2 := t1394VDev_Pnp(po, pirp_10);
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} yogi_error != 1;
    goto L72;

  L72:
    call {:si_unique_call 367} sdv_stub_dispatch_end(status_2, 0);
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    Tmp_108 := status_2;
    goto LM2;

  LM2:
    return;

  anon81_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon58_Then:
    goto L66;

  anon59_Then:
    Tmp_111 := 1;
    goto L213;

  anon57_Then:
    goto L61;

  anon80_Then:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} sdv_start_irp_already_issued != 0;
    Tmp_109 := 0;
    goto L219;

  L219:
    assume Tmp_109 != 0;
    goto L60;

  anon56_Then:
    assume {:partition} sdv_start_irp_already_issued == 0;
    Tmp_109 := 1;
    goto L219;

  anon60_Then:
    call {:si_unique_call 368} status_2 := sdv_DoNothing();
    goto L72;

  anon61_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 369} status_2 := t1394VDev_IoControl(po, pirp_10);
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} yogi_error != 1;
    goto L72;

  anon79_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon62_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 370} sdv_SetPowerIrpMinorFunction(pirp_10);
    call {:si_unique_call 371} status_2 := t1394VDev_Power(po, pirp_10);
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} yogi_error != 1;
    goto L72;

  anon78_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon63_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 372} status_2 := sdv_DoNothing();
    goto L72;

  anon64_Then:
    call {:si_unique_call 373} status_2 := sdv_DoNothing();
    goto L72;

  anon65_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 374} status_2 := sdv_DoNothing();
    goto L72;

  anon66_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 375} status_2 := sdv_DoNothing();
    goto L72;

  anon67_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 376} status_2 := t1394VDev_IoControl(po, pirp_10);
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} yogi_error != 1;
    goto L72;

  anon77_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon68_Then:
    call {:si_unique_call 377} status_2 := sdv_DoNothing();
    goto L72;

  anon69_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 378} status_2 := sdv_DoNothing();
    goto L72;

  anon70_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 379} status_2 := sdv_DoNothing();
    goto L72;

  anon71_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 380} status_2 := sdv_DoNothing();
    goto L72;

  anon72_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 381} status_2 := sdv_DoNothing();
    goto L72;

  anon73_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 382} status_2 := sdv_DoNothing();
    goto L72;

  anon74_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 383} status_2 := t1394VDev_Close(po, pirp_10);
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} yogi_error != 1;
    goto L72;

  anon76_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon55_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    call {:si_unique_call 384} status_2 := t1394VDev_Create(po, pirp_10);
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} yogi_error != 1;
    goto L72;

  anon75_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "RtlFreeUnicodeString"} {:osmodel} RtlFreeUnicodeString(actual_UnicodeString: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "RtlFreeUnicodeString"} {:osmodel} RtlFreeUnicodeString(actual_UnicodeString: int)
{
  var vslice_dummy_var_30: int;

  anon0:
    call {:si_unique_call 385} vslice_dummy_var_30 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_KeReleaseSpinLock"} {:osmodel} sdv_KeReleaseSpinLock(actual_SpinLock_1: int, actual_new: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_KeReleaseSpinLock"} {:osmodel} sdv_KeReleaseSpinLock(actual_SpinLock_1: int, actual_new: int)
{
  var {:scalar} new: int;
  var vslice_dummy_var_31: int;

  anon0:
    call {:si_unique_call 386} vslice_dummy_var_31 := __HAVOC_malloc(4);
    new := actual_new;
    return;
}



procedure {:origName "sdv_IoCompleteRequest"} {:osmodel} sdv_IoCompleteRequest(actual_pirp_11: int, actual_PriorityBoost: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IoCompleteRequest"} {:osmodel} sdv_IoCompleteRequest(actual_pirp_11: int, actual_PriorityBoost: int)
{
  var vslice_dummy_var_32: int;

  anon0:
    call {:si_unique_call 387} vslice_dummy_var_32 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_RtlCopyMemory"} {:osmodel} sdv_RtlCopyMemory(actual_Destination_1: int, actual_Source: int, actual_Length_2: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_RtlCopyMemory"} {:osmodel} sdv_RtlCopyMemory(actual_Destination_1: int, actual_Source: int, actual_Length_2: int)
{
  var vslice_dummy_var_33: int;

  anon0:
    call {:si_unique_call 388} vslice_dummy_var_33 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_ExFreePool"} {:osmodel} sdv_ExFreePool(actual_P: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_ExFreePool"} {:osmodel} sdv_ExFreePool(actual_P: int)
{
  var vslice_dummy_var_34: int;

  anon0:
    call {:si_unique_call 389} vslice_dummy_var_34 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "_sdv_init5"} {:osmodel} _sdv_init5();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "_sdv_init5"} {:osmodel} _sdv_init5()
{
  var vslice_dummy_var_35: int;

  anon0:
    call {:si_unique_call 390} vslice_dummy_var_35 := __HAVOC_malloc(4);
    assume sdv_apc_disabled == 0;
    assume sdv_ControllerPirp == sdv_ControllerIrp;
    assume sdv_StartIopirp == sdv_StartIoIrp;
    assume sdv_power_irp == sdv_PowerIrp;
    assume sdv_irp == sdv_harnessIrp;
    assume sdv_other_irp == sdv_other_harnessIrp;
    assume sdv_IoMakeAssociatedIrp_irp == sdv_IoMakeAssociatedIrp_harnessIrp;
    assume sdv_IoBuildDeviceIoControlRequest_irp == sdv_IoBuildDeviceIoControlRequest_harnessIrp;
    assume sdv_IoBuildSynchronousFsdRequest_irp == sdv_IoBuildSynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock == sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;
    assume sdv_IoBuildAsynchronousFsdRequest_irp == sdv_IoBuildAsynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock == sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;
    assume sdv_IoInitializeIrp_irp == sdv_IoInitializeIrp_harnessIrp;
    assume sdv_io_create_device_called == 0;
    assume sdv_maskedEflags == 0;
    assume sdv_kdpc3 == sdv_kdpc_val3;
    assume sdv_p_devobj_fdo == sdv_devobj_fdo;
    assume sdv_inside_init_entrypoint == 0;
    assume sdv_p_devobj_pdo == sdv_devobj_pdo;
    assume sdv_p_devobj_child_pdo == sdv_devobj_child_pdo;
    assume sdv_kinterrupt == sdv_kinterrupt_val;
    assume sdv_MapRegisterBase == sdv_MapRegisterBase_val;
    assume p_sdv_fx_dev_object == sdv_fx_dev_object;
    assume sdv_start_irp_already_issued == 0;
    assume sdv_Io_Removelock_release_wait_returned == 0;
    assume sdv_isr_routine == li2bplFunctionConstant457;
    assume sdv_ke_dpc == li2bplFunctionConstant459;
    assume sdv_dpc_ke_registered == 0;
    assume sdv_io_dpc == li2bplFunctionConstant462;
    assume sdv_p_devobj_top == sdv_devobj_top;
    assume sdv_MmMapIoSpace_int == 0;
    return;
}



procedure {:origName "sdv_IsListEmpty"} {:osmodel} sdv_IsListEmpty(actual_ListHead: int) returns (Tmp_126: int);
  free ensures Tmp_126 == 1 || Tmp_126 == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IsListEmpty"} {:osmodel} sdv_IsListEmpty(actual_ListHead: int) returns (Tmp_126: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_126 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_126 := 0;
    goto L1;
}



procedure {:origName "IoAllocateIrp"} {:osmodel} IoAllocateIrp(actual_StackSize_1: int, actual_ChargeQuota_1: int) returns (Tmp_128: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoAllocateIrp"} {:osmodel} IoAllocateIrp(actual_StackSize_1: int, actual_ChargeQuota_1: int) returns (Tmp_128: int)
{
  var {:pointer} irpSp_1: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} sdv_other_irp != 0;
    assume sdv_other_irp > 0;
    call {:si_unique_call 391} irpSp_1 := sdv_IoGetNextIrpStackLocation(sdv_other_irp);
    assume {:nonnull} irpSp_1 != 0;
    assume irpSp_1 > 0;
    Tmp_128 := sdv_other_irp;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_128 := 0;
    goto L1;
}



procedure {:origName "IofCallDriver"} {:osmodel} IofCallDriver(actual_DeviceObject_10: int, actual_Irp_9: int) returns (Tmp_130: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IofCallDriver"} {:osmodel} IofCallDriver(actual_DeviceObject_10: int, actual_Irp_9: int) returns (Tmp_130: int)
{
  var {:dopa} {:scalar} completion_1: int;
  var {:scalar} status_3: int;
  var {:pointer} Irp_9: int;
  var vslice_dummy_var_36: int;
  var vslice_dummy_var_37: int;
  var vslice_dummy_var_38: int;
  var vslice_dummy_var_39: int;
  var vslice_dummy_var_97: int;
  var vslice_dummy_var_98: int;
  var vslice_dummy_var_99: int;
  var vslice_dummy_var_100: int;

  anon0:
    call {:si_unique_call 392} completion_1 := __HAVOC_malloc(4);
    Irp_9 := actual_Irp_9;
    assume {:nonnull} completion_1 != 0;
    assume completion_1 > 0;
    status_3 := 259;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    goto anon69_Then, anon69_Else;

  anon69_Else:
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_9;
    goto L19;

  L19:
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L21;

  L21:
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L23;

  L23:
    goto anon55_Then, anon55_Else;

  anon55_Else:
    goto L29;

  L29:
    Tmp_130 := status_3;
    goto LM2;

  LM2:
    return;

  anon55_Then:
    havoc vslice_dummy_var_97;
    call {:si_unique_call 393} vslice_dummy_var_36 := sdv_RunIoCompletionRoutines(sdv_p_devobj_fdo, Irp_9, vslice_dummy_var_97, completion_1);
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} yogi_error != 1;
    goto L29;

  anon76_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon54_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_9;
    goto L23;

  anon53_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_9;
    goto L21;

  anon75_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_9;
    goto L19;

  anon68_Then:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_9;
    goto L58;

  L58:
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L60;

  L60:
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L62;

  L62:
    goto anon66_Then, anon66_Else;

  anon66_Else:
    goto anon67_Then, anon67_Else;

  anon67_Else:
    havoc vslice_dummy_var_98;
    call {:si_unique_call 394} vslice_dummy_var_39 := sdv_RunIoCompletionRoutines(sdv_p_devobj_fdo, Irp_9, vslice_dummy_var_98, completion_1);
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
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_9;
    goto L62;

  anon64_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_9;
    goto L60;

  anon77_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_9;
    goto L58;

  anon69_Then:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_9;
    goto L32;

  L32:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L34;

  L34:
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L36;

  L36:
    goto anon58_Then, anon58_Else;

  anon58_Else:
    goto anon59_Then, anon59_Else;

  anon59_Else:
    havoc vslice_dummy_var_99;
    call {:si_unique_call 395} vslice_dummy_var_37 := sdv_RunIoCompletionRoutines(sdv_p_devobj_fdo, Irp_9, vslice_dummy_var_99, completion_1);
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
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_9;
    goto L36;

  anon56_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_9;
    goto L34;

  anon73_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_9;
    goto L32;

  anon70_Then:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_9;
    goto L45;

  L45:
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    goto L47;

  L47:
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    goto L49;

  L49:
    goto anon62_Then, anon62_Else;

  anon62_Else:
    goto anon63_Then, anon63_Else;

  anon63_Else:
    havoc vslice_dummy_var_100;
    call {:si_unique_call 396} vslice_dummy_var_38 := sdv_RunIoCompletionRoutines(sdv_p_devobj_fdo, Irp_9, vslice_dummy_var_100, completion_1);
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
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_9;
    goto L49;

  anon60_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_9;
    goto L47;

  anon71_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_9;
    goto L45;
}



procedure {:origName "sdv_RunIoCompletionRoutines"} {:osmodel} sdv_RunIoCompletionRoutines(actual_DeviceObject_11: int, actual_Irp_10: int, actual_Context_4: int, actual_Completion: int) returns (Tmp_132: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_RunIoCompletionRoutines"} {:osmodel} sdv_RunIoCompletionRoutines(actual_DeviceObject_11: int, actual_Irp_10: int, actual_Context_4: int, actual_Completion: int) returns (Tmp_132: int)
{
  var {:scalar} Status: int;
  var {:pointer} irpsp: int;
  var {:pointer} DeviceObject_11: int;
  var {:pointer} Irp_10: int;
  var {:pointer} Context_4: int;
  var {:pointer} Completion: int;

  anon0:
    DeviceObject_11 := actual_DeviceObject_11;
    Irp_10 := actual_Irp_10;
    Context_4 := actual_Context_4;
    Completion := actual_Completion;
    call {:si_unique_call 397} irpsp := sdv_IoGetNextIrpStackLocation(Irp_10);
    Status := 0;
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    call {:si_unique_call 398} Status := t1394VDev_SystemSetPowerIrpCompletion(DeviceObject_11, Irp_10, Context_4);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    goto L11;

  L11:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    call {:si_unique_call 399} Status := t1394_IsochAttachCompletionRoutine(DeviceObject_11, Irp_10, Context_4);
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    goto L28;

  L28:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    call {:si_unique_call 400} Status := t1394_IsochDetachCompletionRoutine(DeviceObject_11, Irp_10, Context_4);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    goto L45;

  L45:
    assume {:nonnull} irpsp != 0;
    assume irpsp > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    call {:si_unique_call 401} Status := t1394_SynchCompletionRoutine(DeviceObject_11, Irp_10, Context_4);
    assume {:nonnull} Completion != 0;
    assume Completion > 0;
    goto L62;

  L62:
    Tmp_132 := Status;
    goto LM2;

  LM2:
    return;

  anon17_Then:
    goto L62;

  anon21_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon16_Then:
    goto L45;

  anon20_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon15_Then:
    goto L28;

  anon19_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon18_Then:
    goto L11;
}



procedure {:origName "KeInitializeEvent"} {:osmodel} KeInitializeEvent(actual_Event_1: int, actual_Type_1: int, actual_State_1: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "KeInitializeEvent"} {:osmodel} KeInitializeEvent(actual_Event_1: int, actual_Type_1: int, actual_State_1: int)
{
  var {:pointer} Event_1: int;
  var {:scalar} Type_1: int;
  var {:scalar} State_1: int;
  var vslice_dummy_var_40: int;

  anon0:
    call {:si_unique_call 402} vslice_dummy_var_40 := __HAVOC_malloc(4);
    Event_1 := actual_Event_1;
    Type_1 := actual_Type_1;
    State_1 := actual_State_1;
    assume {:nonnull} Event_1 != 0;
    assume Event_1 > 0;
    assume {:nonnull} Event_1 != 0;
    assume Event_1 > 0;
    assume {:nonnull} Event_1 != 0;
    assume Event_1 > 0;
    assume {:nonnull} Event_1 != 0;
    assume Event_1 > 0;
    return;
}



procedure {:origName "KeInitializeTimer"} {:osmodel} KeInitializeTimer(actual_Timer_2: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "KeInitializeTimer"} {:osmodel} KeInitializeTimer(actual_Timer_2: int)
{
  var vslice_dummy_var_41: int;

  anon0:
    call {:si_unique_call 403} vslice_dummy_var_41 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_IoCallDriver"} {:osmodel} sdv_IoCallDriver(actual_DeviceObject_12: int, actual_Irp_11: int) returns (Tmp_138: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_IoCallDriver"} {:osmodel} sdv_IoCallDriver(actual_DeviceObject_12: int, actual_Irp_11: int) returns (Tmp_138: int)
{
  var {:pointer} Irp_11: int;

  anon0:
    Irp_11 := actual_Irp_11;
    call {:si_unique_call 404} Tmp_138 := IofCallDriver(0, Irp_11);
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



procedure {:origName "IoBuildDeviceIoControlRequest"} {:osmodel} IoBuildDeviceIoControlRequest(actual_IoControlCode: int, actual_DeviceObject_13: int, actual_InputBuffer: int, actual_InputBufferLength: int, actual_OutputBuffer: int, actual_OutputBufferLength: int, actual_InternalDeviceIoControl: int, actual_Event_2: int, actual_IoStatusBlock: int) returns (Tmp_140: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoBuildDeviceIoControlRequest"} {:osmodel} IoBuildDeviceIoControlRequest(actual_IoControlCode: int, actual_DeviceObject_13: int, actual_InputBuffer: int, actual_InputBufferLength: int, actual_OutputBuffer: int, actual_OutputBufferLength: int, actual_InternalDeviceIoControl: int, actual_Event_2: int, actual_IoStatusBlock: int) returns (Tmp_140: int)
{
  var {:pointer} Tmp_141: int;
  var {:pointer} Tmp_143: int;
  var {:scalar} InternalDeviceIoControl: int;
  var {:pointer} IoStatusBlock: int;

  anon0:
    InternalDeviceIoControl := actual_InternalDeviceIoControl;
    IoStatusBlock := actual_IoStatusBlock;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} InternalDeviceIoControl != 0;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_irp != 0;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    havoc Tmp_141;
    assume {:nonnull} Tmp_141 != 0;
    assume Tmp_141 > 0;
    goto L14;

  L14:
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_irp != 0;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    assume {:nonnull} IoStatusBlock != 0;
    assume IoStatusBlock > 0;
    Tmp_140 := sdv_IoBuildDeviceIoControlRequest_irp;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} InternalDeviceIoControl == 0;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_irp != 0;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    havoc Tmp_143;
    assume {:nonnull} Tmp_143 != 0;
    assume Tmp_143 > 0;
    goto L14;

  anon5_Then:
    assume {:nonnull} IoStatusBlock != 0;
    assume IoStatusBlock > 0;
    Tmp_140 := 0;
    goto L1;
}



procedure {:origName "IoFreeIrp"} {:osmodel} IoFreeIrp(actual_pirp_12: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoFreeIrp"} {:osmodel} IoFreeIrp(actual_pirp_12: int)
{
  var vslice_dummy_var_42: int;

  anon0:
    call {:si_unique_call 405} vslice_dummy_var_42 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "ExAllocatePoolWithTag"} {:osmodel} ExAllocatePoolWithTag(actual_PoolType: int, actual_NumberOfBytes: int, actual_Tag: int) returns (Tmp_146: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "ExAllocatePoolWithTag"} {:osmodel} ExAllocatePoolWithTag(actual_PoolType: int, actual_NumberOfBytes: int, actual_Tag: int) returns (Tmp_146: int)
{
  var {:pointer} sdv_133: int;
  var {:scalar} NumberOfBytes: int;

  anon0:
    NumberOfBytes := actual_NumberOfBytes;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call {:si_unique_call 406} sdv_133 := __HAVOC_malloc(NumberOfBytes);
    Tmp_146 := sdv_133;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_146 := 0;
    goto L1;
}



procedure {:origName "IoAllocateWorkItem"} {:osmodel} IoAllocateWorkItem(actual_DeviceObject_14: int) returns (Tmp_148: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoAllocateWorkItem"} {:osmodel} IoAllocateWorkItem(actual_DeviceObject_14: int) returns (Tmp_148: int)
{
  var {:pointer} ioWorkItem: int;
  var {:scalar} Tmp_149: int;
  var {:pointer} sdv_135: int;

  anon0:
    call {:si_unique_call 407} sdv_135 := __HAVOC_malloc(1);
    ioWorkItem := sdv_135;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} ioWorkItem == 0;
    Tmp_149 := 0;
    goto L27;

  L27:
    assume Tmp_149 != 0;
    assume {:nonnull} ioWorkItem != 0;
    assume ioWorkItem > 0;
    Tmp_148 := ioWorkItem;
    goto L1;

  L1:
    return;

  anon5_Then:
    assume {:partition} ioWorkItem != 0;
    Tmp_149 := 1;
    goto L27;

  anon6_Then:
    Tmp_148 := 0;
    goto L1;
}



procedure {:origName "IoSetDeviceInterfaceState"} {:osmodel} IoSetDeviceInterfaceState(actual_SymbolicLinkName: int, actual_Enable: int) returns (Tmp_151: int);
  free ensures Tmp_151 == -1073741772 || Tmp_151 == -1073741824 || Tmp_151 == -1073741789 || Tmp_151 == -1073741670 || Tmp_151 == -1073741808 || Tmp_151 == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "IoSetDeviceInterfaceState"} {:osmodel} IoSetDeviceInterfaceState(actual_SymbolicLinkName: int, actual_Enable: int) returns (Tmp_151: int)
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
    Tmp_151 := -1073741772;
    goto L1;

  L1:
    return;

  anon12_Then:
    Tmp_151 := -1073741824;
    goto L1;

  anon13_Then:
    Tmp_151 := -1073741789;
    goto L1;

  anon14_Then:
    Tmp_151 := -1073741670;
    goto L1;

  anon15_Then:
    Tmp_151 := -1073741808;
    goto L1;

  anon11_Then:
    Tmp_151 := 0;
    goto L1;
}



procedure {:origName "sdv_stub_driver_init"} {:osmodel} sdv_stub_driver_init();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_stub_driver_init"} {:osmodel} sdv_stub_driver_init()
{
  var vslice_dummy_var_43: int;

  anon0:
    call {:si_unique_call 408} vslice_dummy_var_43 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_stub_dispatch_begin"} {:osmodel} sdv_stub_dispatch_begin();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_stub_dispatch_begin"} {:osmodel} sdv_stub_dispatch_begin()
{
  var vslice_dummy_var_44: int;

  anon0:
    call {:si_unique_call 409} vslice_dummy_var_44 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_DoNothing"} {:osmodel} sdv_DoNothing() returns (Tmp_157: int);
  free ensures Tmp_157 == -1073741823;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "sdv_DoNothing"} {:osmodel} sdv_DoNothing() returns (Tmp_157: int)
{

  anon0:
    Tmp_157 := -1073741823;
    return;
}



procedure {:origName "t1394VDev_SystemSetPowerIrpCompletion"} t1394VDev_SystemSetPowerIrpCompletion(actual_DeviceObject_15: int, actual_Irp_12: int, actual_NotUsed: int) returns (Tmp_159: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_SystemSetPowerIrpCompletion"} t1394VDev_SystemSetPowerIrpCompletion(actual_DeviceObject_15: int, actual_Irp_12: int, actual_NotUsed: int) returns (Tmp_159: int)
{
  var {:pointer} powerContext: int;
  var {:pointer} sdv_138: int;
  var {:scalar} ntStatus_5: int;
  var {:pointer} deviceExtension_5: int;
  var {:pointer} stack: int;
  var {:scalar} state_1: int;
  var {:pointer} DeviceObject_15: int;
  var {:pointer} Irp_12: int;
  var vslice_dummy_var_101: int;

  anon0:
    call {:si_unique_call 410} state_1 := __HAVOC_malloc(8);
    DeviceObject_15 := actual_DeviceObject_15;
    Irp_12 := actual_Irp_12;
    assume {:nonnull} DeviceObject_15 != 0;
    assume DeviceObject_15 > 0;
    havoc deviceExtension_5;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    havoc ntStatus_5;
    call {:si_unique_call 411} stack := sdv_IoGetCurrentIrpStackLocation(Irp_12);
    assume {:nonnull} stack != 0;
    assume stack > 0;
    assume {:nonnull} state_1 != 0;
    assume state_1 > 0;
    assume {:nonnull} stack != 0;
    assume stack > 0;
    assume {:nonnull} state_1 != 0;
    assume state_1 > 0;
    powerContext := 0;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    call {:si_unique_call 412} sdv_IoMarkIrpPending(0);
    goto L17;

  L17:
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} ntStatus_5 >= 0;
    call {:si_unique_call 413} sdv_138 := ExAllocatePoolWithTag(512, 8, -164023503);
    powerContext := sdv_138;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} powerContext != 0;
    assume {:nonnull} state_1 != 0;
    assume state_1 > 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:nonnull} state_1 != 0;
    assume state_1 > 0;
    goto L33;

  L33:
    assume {:nonnull} powerContext != 0;
    assume powerContext > 0;
    assume {:nonnull} powerContext != 0;
    assume powerContext > 0;
    assume {:nonnull} deviceExtension_5 != 0;
    assume deviceExtension_5 > 0;
    havoc vslice_dummy_var_101;
    call {:si_unique_call 414} ntStatus_5 := PoRequestPowerIrp(vslice_dummy_var_101, 2, state_1, li2bplFunctionConstant388, powerContext, 0);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} yogi_error != 1;
    goto L39;

  L39:
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} ntStatus_5 >= 0;
    ntStatus_5 := -1073741802;
    goto L42;

  L42:
    Tmp_159 := ntStatus_5;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon17_Then:
    assume {:partition} 0 > ntStatus_5;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} powerContext != 0;
    call {:si_unique_call 415} sdv_ExFreePool(0);
    goto L43;

  L43:
    call {:si_unique_call 416} PoStartNextPowerIrp(0);
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    goto L42;

  anon18_Then:
    assume {:partition} powerContext == 0;
    goto L43;

  anon21_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon16_Then:
    assume {:nonnull} state_1 != 0;
    assume state_1 > 0;
    goto L33;

  anon20_Then:
    assume {:partition} powerContext == 0;
    ntStatus_5 := -1073741670;
    goto L39;

  anon15_Then:
    assume {:partition} 0 > ntStatus_5;
    call {:si_unique_call 417} PoStartNextPowerIrp(0);
    Tmp_159 := 0;
    goto L1;

  anon19_Then:
    goto L17;
}



procedure {:origName "t1394VDev_DeviceSetPowerIrpCompletion"} t1394VDev_DeviceSetPowerIrpCompletion(actual_DeviceObject_16: int, actual_MinorFunction_2: int, actual_structPtr888state: int, actual_PowerContext: int, actual_IoStatus_1: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_DeviceSetPowerIrpCompletion"} t1394VDev_DeviceSetPowerIrpCompletion(actual_DeviceObject_16: int, actual_MinorFunction_2: int, actual_structPtr888state: int, actual_PowerContext: int, actual_IoStatus_1: int)
{
  var {:pointer} structPtr888sdv: int;
  var {:scalar} state: int;
  var {:pointer} sIrp: int;
  var {:pointer} ioWorkItem_1: int;
  var {:scalar} sdv: int;
  var {:scalar} ntStatus_6: int;
  var {:pointer} Tmp_163: int;
  var {:pointer} deviceExtension_6: int;
  var {:pointer} structPtr888state: int;
  var {:pointer} PowerContext: int;
  var {:pointer} IoStatus_1: int;
  var vslice_dummy_var_45: int;

  anon0:
    call {:si_unique_call 418} state := __HAVOC_malloc(8);
    call {:si_unique_call 419} vslice_dummy_var_45 := __HAVOC_malloc(4);
    call {:si_unique_call 420} sdv := __HAVOC_malloc(8);
    structPtr888state := actual_structPtr888state;
    PowerContext := actual_PowerContext;
    IoStatus_1 := actual_IoStatus_1;
    assume {:nonnull} state != 0;
    assume state > 0;
    assume {:nonnull} structPtr888state != 0;
    assume structPtr888state > 0;
    assume {:nonnull} state != 0;
    assume state > 0;
    assume {:nonnull} structPtr888state != 0;
    assume structPtr888state > 0;
    assume {:nonnull} PowerContext != 0;
    assume PowerContext > 0;
    havoc Tmp_163;
    assume {:nonnull} Tmp_163 != 0;
    assume Tmp_163 > 0;
    havoc deviceExtension_6;
    assume {:nonnull} PowerContext != 0;
    assume PowerContext > 0;
    havoc sIrp;
    assume {:nonnull} IoStatus_1 != 0;
    assume IoStatus_1 > 0;
    havoc ntStatus_6;
    ioWorkItem_1 := 0;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} ntStatus_6 < 0;
    goto L33;

  L33:
    assume {:nonnull} IoStatus_1 != 0;
    assume IoStatus_1 > 0;
    assume {:nonnull} sIrp != 0;
    assume sIrp > 0;
    call {:si_unique_call 421} PoStartNextPowerIrp(0);
    assume {:nonnull} sIrp != 0;
    assume sIrp > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume sIrp == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 422} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} yogi_error != 1;
    goto L48;

  L48:
    call {:si_unique_call 423} sdv_IoCompleteRequest(0, 0);
    call {:si_unique_call 424} sdv_ExFreePool(0);
    goto LM2;

  LM2:
    return;

  anon18_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon17_Then:
    assume !(sIrp == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L48;

  anon16_Then:
    assume {:partition} 0 <= ntStatus_6;
    call {:si_unique_call 425} structPtr888sdv := PoSetPowerState(0, 1, state);
    assume {:nonnull} sdv != 0;
    assume sdv > 0;
    assume {:nonnull} structPtr888sdv != 0;
    assume structPtr888sdv > 0;
    assume {:nonnull} sdv != 0;
    assume sdv > 0;
    assume {:nonnull} structPtr888sdv != 0;
    assume structPtr888sdv > 0;
    assume {:nonnull} deviceExtension_6 != 0;
    assume deviceExtension_6 > 0;
    assume {:nonnull} state != 0;
    assume state > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:nonnull} state != 0;
    assume state > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} deviceExtension_6 != 0;
    assume deviceExtension_6 > 0;
    call {:si_unique_call 426} ioWorkItem_1 := IoAllocateWorkItem(0);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} ioWorkItem_1 == 0;
    goto L33;

  anon15_Then:
    assume {:partition} ioWorkItem_1 != 0;
    call {:si_unique_call 427} IoQueueWorkItem(0, li2bplFunctionConstant178, 1, 0);
    goto L22;

  L22:
    assume {:nonnull} deviceExtension_6 != 0;
    assume deviceExtension_6 > 0;
    assume {:nonnull} state != 0;
    assume state > 0;
    goto L33;

  anon14_Then:
    goto L22;

  anon13_Then:
    assume {:nonnull} deviceExtension_6 != 0;
    assume deviceExtension_6 > 0;
    goto L22;
}



procedure {:origName "t1394VDev_Power"} t1394VDev_Power(actual_DeviceObject_17: int, actual_Irp_13: int) returns (Tmp_164: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 1 ==> wait_required != 0;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> wait_required == old(wait_required);
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_Power"} t1394VDev_Power(actual_DeviceObject_17: int, actual_Irp_13: int) returns (Tmp_164: int)
{
  var {:scalar} State_2: int;
  var {:pointer} IrpSp_2: int;
  var {:scalar} ntStatus_7: int;
  var {:scalar} sdv_144: int;
  var {:pointer} DeviceObject_17: int;
  var {:pointer} Irp_13: int;

  anon0:
    call {:si_unique_call 428} State_2 := __HAVOC_malloc(8);
    DeviceObject_17 := actual_DeviceObject_17;
    Irp_13 := actual_Irp_13;
    ntStatus_7 := 0;
    assume {:nonnull} DeviceObject_17 != 0;
    assume DeviceObject_17 > 0;
    call {:si_unique_call 429} IrpSp_2 := sdv_IoGetCurrentIrpStackLocation(Irp_13);
    assume {:nonnull} IrpSp_2 != 0;
    assume IrpSp_2 > 0;
    assume {:nonnull} State_2 != 0;
    assume State_2 > 0;
    assume {:nonnull} IrpSp_2 != 0;
    assume IrpSp_2 > 0;
    assume {:nonnull} State_2 != 0;
    assume State_2 > 0;
    assume {:nonnull} IrpSp_2 != 0;
    assume IrpSp_2 > 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:nonnull} IrpSp_2 != 0;
    assume IrpSp_2 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    call {:si_unique_call 430} PoStartNextPowerIrp(0);
    call {:si_unique_call 431} sdv_IoSkipCurrentIrpStackLocation(Irp_13);
    call {:si_unique_call 432} ntStatus_7 := PoCallDriver(0, Irp_13);
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} yogi_error != 1;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume Irp_13 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 433} SLIC_PoCallDriver_exit(0, ntStatus_7);
    goto L31;

  L31:
    Tmp_164 := ntStatus_7;
    goto LM2;

  LM2:
    return;

  anon30_Then:
    assume !(Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L31;

  anon35_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon26_Then:
    call {:si_unique_call 434} PoStartNextPowerIrp(0);
    call {:si_unique_call 435} sdv_IoSkipCurrentIrpStackLocation(Irp_13);
    call {:si_unique_call 436} ntStatus_7 := PoCallDriver(0, Irp_13);
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} yogi_error != 1;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume Irp_13 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 437} SLIC_PoCallDriver_exit(0, ntStatus_7);
    goto L31;

  anon31_Then:
    assume !(Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L31;

  anon36_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon32_Then:
    assume {:nonnull} IrpSp_2 != 0;
    assume IrpSp_2 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:nonnull} IrpSp_2 != 0;
    assume IrpSp_2 > 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    call {:si_unique_call 438} PoStartNextPowerIrp(0);
    call {:si_unique_call 439} sdv_IoCopyCurrentIrpStackLocationToNext(Irp_13);
    call {:si_unique_call 440} ntStatus_7 := PoCallDriver(0, Irp_13);
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} yogi_error != 1;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume Irp_13 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 441} SLIC_PoCallDriver_exit(0, ntStatus_7);
    goto L31;

  anon29_Then:
    assume !(Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L31;

  anon34_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon27_Then:
    goto L31;

  anon25_Then:
    call {:si_unique_call 442} sdv_IoMarkIrpPending(0);
    call {:si_unique_call 443} sdv_IoCopyCurrentIrpStackLocationToNext(Irp_13);
    call {:si_unique_call 444} sdv_IoSetCompletionRoutine(Irp_13, li2bplFunctionConstant387, 0, 1, 1, 1);
    call {:si_unique_call 445} sdv_144 := PoCallDriver(0, Irp_13);
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} yogi_error != 1;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume Irp_13 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 446} SLIC_PoCallDriver_exit(0, sdv_144);
    goto L57;

  L57:
    ntStatus_7 := 259;
    goto L31;

  anon28_Then:
    assume !(Irp_13 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L57;

  anon33_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "_sdv_init4"} _sdv_init4();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "_sdv_init4"} _sdv_init4()
{
  var vslice_dummy_var_46: int;

  anon0:
    call {:si_unique_call 447} vslice_dummy_var_46 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "FatalListEntryError"} FatalListEntryError(actual_p1: int, actual_p2: int, actual_p3: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "FatalListEntryError"} FatalListEntryError(actual_p1: int, actual_p2: int, actual_p3: int)
{
  var vslice_dummy_var_47: int;

  anon0:
    call {:si_unique_call 448} vslice_dummy_var_47 := __HAVOC_malloc(4);
    call {:si_unique_call 449} RtlFailFast(3);
    return;
}



procedure {:origName "t1394_IsochQueryResources"} t1394_IsochQueryResources(actual_DeviceObject_18: int, actual_Irp_14: int, actual_fulSpeed: int, actual_pBytesPerFrameAvailable: int, actual_pChannelsAvailable: int) returns (Tmp_170: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochQueryResources"} t1394_IsochQueryResources(actual_DeviceObject_18: int, actual_Irp_14: int, actual_fulSpeed: int, actual_pBytesPerFrameAvailable: int, actual_pChannelsAvailable: int) returns (Tmp_170: int)
{
  var {:pointer} sdv_146: int;
  var {:pointer} newIrp: int;
  var {:scalar} allocNewIrp: int;
  var {:scalar} Event_3: int;
  var {:scalar} ntStatus_8: int;
  var {:scalar} ioStatus: int;
  var {:pointer} deviceExtension_8: int;
  var {:pointer} pIrb_1: int;
  var {:pointer} DeviceObject_18: int;
  var {:pointer} Irp_14: int;
  var {:scalar} fulSpeed: int;
  var {:pointer} pBytesPerFrameAvailable: int;
  var {:pointer} pChannelsAvailable: int;
  var vslice_dummy_var_48: int;
  var vslice_dummy_var_102: int;
  var vslice_dummy_var_103: int;

  anon0:
    call {:si_unique_call 450} Event_3 := __HAVOC_malloc(156);
    call {:si_unique_call 451} ioStatus := __HAVOC_malloc(12);
    DeviceObject_18 := actual_DeviceObject_18;
    Irp_14 := actual_Irp_14;
    fulSpeed := actual_fulSpeed;
    pBytesPerFrameAvailable := actual_pBytesPerFrameAvailable;
    pChannelsAvailable := actual_pChannelsAvailable;
    ntStatus_8 := 0;
    assume {:nonnull} DeviceObject_18 != 0;
    assume DeviceObject_18 > 0;
    havoc deviceExtension_8;
    pIrb_1 := 0;
    newIrp := 0;
    allocNewIrp := 0;
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    call {:si_unique_call 452} newIrp := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} newIrp != 0;
    allocNewIrp := 1;
    goto L16;

  L16:
    call {:si_unique_call 453} sdv_146 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_1 := sdv_146;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} pIrb_1 != 0;
    call {:si_unique_call 454} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_1 != 0;
    assume pIrb_1 > 0;
    assume {:nonnull} pIrb_1 != 0;
    assume pIrb_1 > 0;
    assume {:nonnull} pIrb_1 != 0;
    assume pIrb_1 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} allocNewIrp != 0;
    call {:si_unique_call 455} KeInitializeEvent(Event_3, 0, 0);
    assume {:nonnull} deviceExtension_8 != 0;
    assume deviceExtension_8 > 0;
    havoc vslice_dummy_var_102;
    call {:si_unique_call 456} ntStatus_8 := t1394_SubmitIrpAsync(vslice_dummy_var_102, newIrp, pIrb_1);
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} yogi_error != 1;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} ntStatus_8 == 259;
    call {:si_unique_call 457} vslice_dummy_var_48 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus != 0;
    assume ioStatus > 0;
    havoc ntStatus_8;
    goto L55;

  L55:
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} ntStatus_8 >= 0;
    assume {:nonnull} pBytesPerFrameAvailable != 0;
    assume pBytesPerFrameAvailable > 0;
    assume {:nonnull} pIrb_1 != 0;
    assume pIrb_1 > 0;
    assume {:nonnull} pChannelsAvailable != 0;
    assume pChannelsAvailable > 0;
    assume {:nonnull} pIrb_1 != 0;
    assume pIrb_1 > 0;
    assume {:nonnull} pChannelsAvailable != 0;
    assume pChannelsAvailable > 0;
    assume {:nonnull} pIrb_1 != 0;
    assume pIrb_1 > 0;
    assume {:nonnull} pChannelsAvailable != 0;
    assume pChannelsAvailable > 0;
    assume {:nonnull} pIrb_1 != 0;
    assume pIrb_1 > 0;
    assume {:nonnull} pChannelsAvailable != 0;
    assume pChannelsAvailable > 0;
    assume {:nonnull} pIrb_1 != 0;
    assume pIrb_1 > 0;
    assume {:nonnull} pChannelsAvailable != 0;
    assume pChannelsAvailable > 0;
    assume {:nonnull} pIrb_1 != 0;
    assume pIrb_1 > 0;
    goto L27;

  L27:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} pIrb_1 != 0;
    call {:si_unique_call 458} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} allocNewIrp != 0;
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    assume {:nonnull} ioStatus != 0;
    assume ioStatus > 0;
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    assume {:nonnull} ioStatus != 0;
    assume ioStatus > 0;
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    assume {:nonnull} ioStatus != 0;
    assume ioStatus > 0;
    goto L32;

  L32:
    Tmp_170 := ntStatus_8;
    goto LM2;

  LM2:
    return;

  anon23_Then:
    assume {:partition} allocNewIrp == 0;
    goto L32;

  anon22_Then:
    assume {:partition} pIrb_1 == 0;
    goto L28;

  anon25_Then:
    assume {:partition} 0 > ntStatus_8;
    goto L27;

  anon24_Then:
    assume {:partition} ntStatus_8 != 259;
    goto L55;

  anon29_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon28_Then:
    assume {:partition} allocNewIrp == 0;
    assume {:nonnull} deviceExtension_8 != 0;
    assume deviceExtension_8 > 0;
    havoc vslice_dummy_var_103;
    call {:si_unique_call 459} ntStatus_8 := t1394_SubmitIrpSynch(vslice_dummy_var_103, Irp_14, pIrb_1);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto L55;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon27_Then:
    assume {:partition} pIrb_1 == 0;
    ntStatus_8 := -1073741670;
    goto L27;

  anon21_Then:
    assume {:partition} newIrp == 0;
    ntStatus_8 := -1073741670;
    goto L27;

  anon26_Then:
    goto L16;
}



procedure {:origName "t1394_UpdateGenerationCount"} t1394_UpdateGenerationCount(actual_DeviceObject_19: int, actual_Context_5: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 0 || wait_required == 1 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_UpdateGenerationCount"} t1394_UpdateGenerationCount(actual_DeviceObject_19: int, actual_Context_5: int)
{
  var {:pointer} Irp_15: int;
  var {:pointer} Irb: int;
  var {:pointer} ioWorkItem_2: int;
  var {:pointer} sdv_152: int;
  var {:scalar} ntStatus_9: int;
  var {:pointer} Tmp_174: int;
  var {:pointer} deviceExtension_9: int;
  var {:pointer} DeviceObject_19: int;
  var {:pointer} Context_5: int;
  var vslice_dummy_var_49: int;
  var vslice_dummy_var_104: int;
  var vslice_dummy_var_105: int;

  anon0:
    call {:si_unique_call 460} vslice_dummy_var_49 := __HAVOC_malloc(4);
    DeviceObject_19 := actual_DeviceObject_19;
    Context_5 := actual_Context_5;
    assume {:nonnull} DeviceObject_19 != 0;
    assume DeviceObject_19 > 0;
    havoc deviceExtension_9;
    ioWorkItem_2 := Context_5;
    ntStatus_9 := 0;
    Irb := 0;
    Irp_15 := 0;
    assume {:nonnull} deviceExtension_9 != 0;
    assume deviceExtension_9 > 0;
    havoc Tmp_174;
    assume {:nonnull} Tmp_174 != 0;
    assume Tmp_174 > 0;
    havoc vslice_dummy_var_104;
    call {:si_unique_call 461} Irp_15 := IoAllocateIrp(vslice_dummy_var_104, 0);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} Irp_15 != 0;
    call {:si_unique_call 462} sdv_152 := ExAllocatePoolWithTag(512, 344, -164023503);
    Irb := sdv_152;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} Irb != 0;
    call {:si_unique_call 463} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} Irb != 0;
    assume Irb > 0;
    assume {:nonnull} Irb != 0;
    assume Irb > 0;
    assume {:nonnull} deviceExtension_9 != 0;
    assume deviceExtension_9 > 0;
    havoc vslice_dummy_var_105;
    call {:si_unique_call 464} ntStatus_9 := t1394_SubmitIrpSynch(vslice_dummy_var_105, Irp_15, Irb);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} yogi_error != 1;
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} ntStatus_9 >= 0;
    assume {:nonnull} Irb != 0;
    assume Irb > 0;
    assume {:nonnull} deviceExtension_9 != 0;
    assume deviceExtension_9 > 0;
    goto L35;

  L35:
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} Irp_15 != 0;
    call {:si_unique_call 465} IoFreeIrp(0);
    goto L37;

  L37:
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} Irb != 0;
    call {:si_unique_call 466} sdv_ExFreePool(0);
    goto L41;

  L41:
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} ioWorkItem_2 != 0;
    call {:si_unique_call 467} IoFreeWorkItem(0);
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon19_Then:
    assume {:partition} ioWorkItem_2 == 0;
    goto L1;

  anon18_Then:
    assume {:partition} Irb == 0;
    goto L41;

  anon17_Then:
    assume {:partition} Irp_15 == 0;
    goto L37;

  anon16_Then:
    assume {:partition} 0 > ntStatus_9;
    goto L35;

  anon21_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon20_Then:
    assume {:partition} Irb == 0;
    ntStatus_9 := -1073741670;
    goto L35;

  anon15_Then:
    assume {:partition} Irp_15 == 0;
    ntStatus_9 := -1073741670;
    goto L35;
}



procedure {:origName "t1394_SetLocalHostProperties"} t1394_SetLocalHostProperties(actual_DeviceObject_20: int, actual_Irp_16: int, actual_nLevel: int, actual_Information: int) returns (Tmp_175: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_SetLocalHostProperties"} t1394_SetLocalHostProperties(actual_DeviceObject_20: int, actual_Irp_16: int, actual_nLevel: int, actual_Information: int) returns (Tmp_175: int)
{
  var {:pointer} sdv_154: int;
  var {:pointer} newIrp_1: int;
  var {:pointer} CromData_1: int;
  var {:scalar} allocNewIrp_1: int;
  var {:scalar} Event_4: int;
  var {:pointer} sdv_157: int;
  var {:scalar} ntStatus_10: int;
  var {:pointer} SetLocalHostProps3: int;
  var {:pointer} sdv_162: int;
  var {:scalar} Irql_2: int;
  var {:scalar} ioStatus_1: int;
  var {:pointer} R0: int;
  var {:pointer} deviceExtension_10: int;
  var {:pointer} pIrb_2: int;
  var {:pointer} Tmp_176: int;
  var {:pointer} SetLocalHostProps3_1: int;
  var {:pointer} DeviceObject_20: int;
  var {:pointer} Irp_16: int;
  var {:scalar} nLevel: int;
  var {:pointer} Information: int;
  var boogieTmp: int;
  var vslice_dummy_var_50: int;
  var vslice_dummy_var_51: int;
  var vslice_dummy_var_106: int;
  var vslice_dummy_var_107: int;
  var vslice_dummy_var_108: int;
  var vslice_dummy_var_109: int;
  var vslice_dummy_var_110: int;

  anon0:
    call {:si_unique_call 468} Event_4 := __HAVOC_malloc(156);
    call {:si_unique_call 469} ioStatus_1 := __HAVOC_malloc(12);
    DeviceObject_20 := actual_DeviceObject_20;
    Irp_16 := actual_Irp_16;
    nLevel := actual_nLevel;
    Information := actual_Information;
    ntStatus_10 := 0;
    assume {:nonnull} DeviceObject_20 != 0;
    assume DeviceObject_20 > 0;
    havoc deviceExtension_10;
    pIrb_2 := 0;
    R0 := 0;
    CromData_1 := 0;
    newIrp_1 := 0;
    allocNewIrp_1 := 0;
    call {:si_unique_call 470} sdv_154 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_2 := sdv_154;
    goto anon111_Then, anon111_Else;

  anon111_Else:
    assume {:partition} pIrb_2 != 0;
    assume {:nonnull} Irp_16 != 0;
    assume Irp_16 > 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    call {:si_unique_call 471} newIrp_1 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_1);
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} newIrp_1 != 0;
    allocNewIrp_1 := 1;
    goto L26;

  L26:
    call {:si_unique_call 472} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_2 != 0;
    assume pIrb_2 > 0;
    assume {:nonnull} pIrb_2 != 0;
    assume pIrb_2 > 0;
    assume {:nonnull} pIrb_2 != 0;
    assume pIrb_2 > 0;
    goto anon112_Then, anon112_Else;

  anon112_Else:
    assume {:partition} nLevel == 2;
    assume {:nonnull} pIrb_2 != 0;
    assume pIrb_2 > 0;
    goto L52;

  L52:
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:partition} allocNewIrp_1 != 0;
    call {:si_unique_call 473} KeInitializeEvent(Event_4, 0, 0);
    assume {:nonnull} deviceExtension_10 != 0;
    assume deviceExtension_10 > 0;
    havoc vslice_dummy_var_106;
    call {:si_unique_call 474} ntStatus_10 := t1394_SubmitIrpAsync(vslice_dummy_var_106, newIrp_1, pIrb_2);
    goto anon113_Then, anon113_Else;

  anon113_Else:
    assume {:partition} yogi_error != 1;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} ntStatus_10 == 259;
    call {:si_unique_call 475} vslice_dummy_var_50 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_1 != 0;
    assume ioStatus_1 > 0;
    havoc ntStatus_10;
    goto L64;

  L64:
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} ntStatus_10 >= 0;
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} nLevel == 3;
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    goto anon89_Then, anon89_Else;

  anon89_Else:
    SetLocalHostProps3_1 := Information;
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    assume {:nonnull} SetLocalHostProps3_1 != 0;
    assume SetLocalHostProps3_1 > 0;
    goto anon114_Then, anon114_Else;

  anon114_Else:
    assume {:partition} CromData_1 != 0;
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    assume {:nonnull} SetLocalHostProps3_1 != 0;
    assume SetLocalHostProps3_1 > 0;
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    call {:si_unique_call 476} Tmp_176 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_176 != 0;
    assume Tmp_176 > 0;
    call {:si_unique_call 477} sdv_KeAcquireSpinLock(0, Tmp_176);
    assume {:nonnull} Tmp_176 != 0;
    assume Tmp_176 > 0;
    havoc Irql_2;
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    assume {:nonnull} deviceExtension_10 != 0;
    assume deviceExtension_10 > 0;
    call {:si_unique_call 478} InsertHeadList(CromData__DEVICE_EXTENSION(deviceExtension_10), CromList__CROM_DATA(CromData_1));
    call {:si_unique_call 479} sdv_KeReleaseSpinLock(0, Irql_2);
    goto L78;

  L78:
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} R0 != 0;
    call {:si_unique_call 480} sdv_ExFreePool(0);
    goto L37;

  L37:
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} pIrb_2 != 0;
    call {:si_unique_call 481} sdv_ExFreePool(0);
    goto L38;

  L38:
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:partition} allocNewIrp_1 != 0;
    assume {:nonnull} Irp_16 != 0;
    assume Irp_16 > 0;
    assume {:nonnull} ioStatus_1 != 0;
    assume ioStatus_1 > 0;
    assume {:nonnull} Irp_16 != 0;
    assume Irp_16 > 0;
    assume {:nonnull} ioStatus_1 != 0;
    assume ioStatus_1 > 0;
    assume {:nonnull} Irp_16 != 0;
    assume Irp_16 > 0;
    assume {:nonnull} ioStatus_1 != 0;
    assume ioStatus_1 > 0;
    goto L42;

  L42:
    Tmp_175 := ntStatus_10;
    goto LM2;

  LM2:
    return;

  anon82_Then:
    assume {:partition} allocNewIrp_1 == 0;
    goto L42;

  anon81_Then:
    assume {:partition} pIrb_2 == 0;
    goto L38;

  anon91_Then:
    assume {:partition} R0 == 0;
    goto L37;

  anon114_Then:
    assume {:partition} CromData_1 == 0;
    goto L78;

  anon89_Then:
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    call {:si_unique_call 482} Tmp_176 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_176 != 0;
    assume Tmp_176 > 0;
    call {:si_unique_call 483} sdv_KeAcquireSpinLock(0, Tmp_176);
    assume {:nonnull} Tmp_176 != 0;
    assume Tmp_176 > 0;
    havoc Irql_2;
    assume {:nonnull} deviceExtension_10 != 0;
    assume deviceExtension_10 > 0;
    havoc CromData_1;
    goto L97;

  L97:
    call {:si_unique_call 484} CromData_1 := t1394_SetLocalHostProperties_loop_L97(CromData_1, R0);
    goto L97_last;

  L97_last:
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} CromData_1 != 0;
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    goto anon93_Then, anon93_Else;

  anon93_Else:
    call {:si_unique_call 485} vslice_dummy_var_51 := sdv_RemoveEntryList(0);
    goto L98;

  L98:
    call {:si_unique_call 486} sdv_KeReleaseSpinLock(0, Irql_2);
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} CromData_1 != 0;
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    call {:si_unique_call 487} sdv_ExFreePool(0);
    goto L112;

  L112:
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    goto anon97_Then, anon97_Else;

  anon97_Else:
    call {:si_unique_call 488} sdv_ExFreePool(0);
    goto L116;

  L116:
    call {:si_unique_call 489} sdv_ExFreePool(0);
    goto L78;

  anon97_Then:
    goto L116;

  anon96_Then:
    goto L112;

  anon95_Then:
    assume {:partition} CromData_1 == 0;
    goto L78;

  anon93_Then:
    goto anon94_Then, anon94_Else;

  anon94_Else:
    CromData_1 := 0;
    goto L98;

  anon94_Then:
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    havoc CromData_1;
    goto anon94_Then_dummy;

  anon94_Then_dummy:
    assume false;
    return;

  anon92_Then:
    assume {:partition} CromData_1 == 0;
    goto L98;

  anon90_Then:
    goto L78;

  anon88_Then:
    assume {:partition} nLevel != 3;
    goto L37;

  anon86_Then:
    assume {:partition} 0 > ntStatus_10;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} nLevel == 3;
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    goto anon98_Then, anon98_Else;

  anon98_Else:
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    goto anon100_Then, anon100_Else;

  anon100_Else:
    call {:si_unique_call 490} sdv_ExFreePool(0);
    goto L125;

  L125:
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    call {:si_unique_call 491} sdv_ExFreePool(0);
    goto L129;

  L129:
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume {:partition} CromData_1 != 0;
    call {:si_unique_call 492} sdv_ExFreePool(0);
    goto L123;

  L123:
    goto anon99_Then, anon99_Else;

  anon99_Else:
    assume {:partition} R0 != 0;
    call {:si_unique_call 493} sdv_ExFreePool(0);
    goto L37;

  anon99_Then:
    assume {:partition} R0 == 0;
    goto L37;

  anon102_Then:
    assume {:partition} CromData_1 == 0;
    goto L123;

  anon101_Then:
    goto L129;

  anon100_Then:
    goto L125;

  anon98_Then:
    goto L123;

  anon87_Then:
    assume {:partition} nLevel != 3;
    goto L37;

  anon85_Then:
    assume {:partition} ntStatus_10 != 259;
    goto L64;

  anon113_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon84_Then:
    assume {:partition} allocNewIrp_1 == 0;
    assume {:nonnull} deviceExtension_10 != 0;
    assume deviceExtension_10 > 0;
    havoc vslice_dummy_var_107;
    call {:si_unique_call 494} ntStatus_10 := t1394_SubmitIrpSynch(vslice_dummy_var_107, Irp_16, pIrb_2);
    goto anon115_Then, anon115_Else;

  anon115_Else:
    assume {:partition} yogi_error != 1;
    goto L64;

  anon115_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon112_Then:
    assume {:partition} nLevel != 2;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} nLevel == 3;
    SetLocalHostProps3 := Information;
    call {:si_unique_call 495} sdv_162 := ExAllocatePoolWithTag(512, 16, -164023503);
    R0 := sdv_162;
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume {:partition} R0 != 0;
    call {:si_unique_call 496} sdv_RtlCopyMemory(0, 0, 16);
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    goto L175;

  L175:
    assume {:nonnull} pIrb_2 != 0;
    assume pIrb_2 > 0;
    goto L52;

  anon104_Then:
    call {:si_unique_call 497} sdv_157 := ExAllocatePoolWithTag(512, 20, -164023503);
    CromData_1 := sdv_157;
    goto anon117_Then, anon117_Else;

  anon117_Else:
    assume {:partition} CromData_1 != 0;
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    havoc vslice_dummy_var_108;
    call {:si_unique_call 498} boogieTmp := ExAllocatePoolWithTag(512, vslice_dummy_var_108, -164023503);
    assume {:nonnull} CromData_1 != 0;
    assume CromData_1 > 0;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:nonnull} SetLocalHostProps3 != 0;
    assume SetLocalHostProps3 > 0;
    havoc vslice_dummy_var_109;
    call {:si_unique_call 499} sdv_RtlCopyMemory(0, 0, vslice_dummy_var_109);
    assume {:nonnull} R0 != 0;
    assume R0 > 0;
    havoc vslice_dummy_var_110;
    call {:si_unique_call 500} boogieTmp := IoAllocateMdl(0, vslice_dummy_var_110, 0, 0, 0);
    goto L175;

  anon106_Then:
    goto anon107_Then, anon107_Else;

  anon107_Else:
    assume {:partition} pIrb_2 != 0;
    call {:si_unique_call 501} sdv_ExFreePool(0);
    goto L176;

  L176:
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:partition} R0 != 0;
    call {:si_unique_call 502} sdv_ExFreePool(0);
    goto L180;

  L180:
    goto anon109_Then, anon109_Else;

  anon109_Else:
    assume {:partition} CromData_1 != 0;
    call {:si_unique_call 503} sdv_ExFreePool(0);
    goto L184;

  L184:
    ntStatus_10 := -1073741670;
    goto L37;

  anon109_Then:
    assume {:partition} CromData_1 == 0;
    goto L184;

  anon108_Then:
    assume {:partition} R0 == 0;
    goto L180;

  anon107_Then:
    assume {:partition} pIrb_2 == 0;
    goto L176;

  anon117_Then:
    assume {:partition} CromData_1 == 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    assume {:partition} pIrb_2 != 0;
    call {:si_unique_call 504} sdv_ExFreePool(0);
    goto L189;

  L189:
    goto anon110_Then, anon110_Else;

  anon110_Else:
    assume {:partition} R0 != 0;
    call {:si_unique_call 505} sdv_ExFreePool(0);
    goto L193;

  L193:
    ntStatus_10 := -1073741670;
    goto L37;

  anon110_Then:
    assume {:partition} R0 == 0;
    goto L193;

  anon105_Then:
    assume {:partition} pIrb_2 == 0;
    goto L189;

  anon116_Then:
    assume {:partition} R0 == 0;
    goto anon103_Then, anon103_Else;

  anon103_Else:
    assume {:partition} pIrb_2 != 0;
    call {:si_unique_call 506} sdv_ExFreePool(0);
    goto L198;

  L198:
    ntStatus_10 := -1073741670;
    goto L37;

  anon103_Then:
    assume {:partition} pIrb_2 == 0;
    goto L198;

  anon83_Then:
    assume {:partition} nLevel != 3;
    goto L52;

  anon80_Then:
    assume {:partition} newIrp_1 == 0;
    ntStatus_10 := -1073741670;
    goto L37;

  anon79_Then:
    goto L26;

  anon111_Then:
    assume {:partition} pIrb_2 == 0;
    ntStatus_10 := -1073741670;
    goto L37;
}



procedure {:origName "t1394_Control"} t1394_Control(actual_DeviceObject_21: int, actual_Irp_17: int) returns (Tmp_177: int);
  free ensures Tmp_177 == -1073741822;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_Control"} t1394_Control(actual_DeviceObject_21: int, actual_Irp_17: int) returns (Tmp_177: int)
{
  var {:scalar} ntStatus_11: int;
  var {:pointer} DeviceObject_21: int;

  anon0:
    DeviceObject_21 := actual_DeviceObject_21;
    ntStatus_11 := 0;
    assume {:nonnull} DeviceObject_21 != 0;
    assume DeviceObject_21 > 0;
    ntStatus_11 := -1073741822;
    Tmp_177 := ntStatus_11;
    return;
}



procedure {:origName "t1394VDev_Close"} t1394VDev_Close(actual_DriverObject: int, actual_Irp_18: int) returns (Tmp_179: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_Close"} t1394VDev_Close(actual_DriverObject: int, actual_Irp_18: int) returns (Tmp_179: int)
{
  var {:scalar} ntStatus_12: int;
  var {:pointer} Irp_18: int;

  anon0:
    Irp_18 := actual_Irp_18;
    ntStatus_12 := 0;
    assume {:nonnull} Irp_18 != 0;
    assume Irp_18 > 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume Irp_18 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 507} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} yogi_error != 1;
    goto L11;

  L11:
    call {:si_unique_call 508} sdv_IoCompleteRequest(0, 0);
    Tmp_179 := ntStatus_12;
    goto LM2;

  LM2:
    return;

  anon6_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon5_Then:
    assume !(Irp_18 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L11;
}



procedure {:origName "t1394_IsochAllocateChannel"} t1394_IsochAllocateChannel(actual_DeviceObject_22: int, actual_Irp_19: int, actual_nRequestedChannel: int, actual_pChannel: int, actual_pChannelsAvailable_1: int) returns (Tmp_181: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochAllocateChannel"} t1394_IsochAllocateChannel(actual_DeviceObject_22: int, actual_Irp_19: int, actual_nRequestedChannel: int, actual_pChannel: int, actual_pChannelsAvailable_1: int) returns (Tmp_181: int)
{
  var {:pointer} sdv_164: int;
  var {:pointer} newIrp_2: int;
  var {:scalar} allocNewIrp_2: int;
  var {:scalar} Event_5: int;
  var {:scalar} ntStatus_13: int;
  var {:scalar} ioStatus_2: int;
  var {:pointer} deviceExtension_12: int;
  var {:pointer} pIrb_3: int;
  var {:pointer} DeviceObject_22: int;
  var {:pointer} Irp_19: int;
  var {:scalar} nRequestedChannel: int;
  var {:pointer} pChannel: int;
  var {:pointer} pChannelsAvailable_1: int;
  var vslice_dummy_var_52: int;
  var vslice_dummy_var_111: int;
  var vslice_dummy_var_112: int;

  anon0:
    call {:si_unique_call 509} Event_5 := __HAVOC_malloc(156);
    call {:si_unique_call 510} ioStatus_2 := __HAVOC_malloc(12);
    DeviceObject_22 := actual_DeviceObject_22;
    Irp_19 := actual_Irp_19;
    nRequestedChannel := actual_nRequestedChannel;
    pChannel := actual_pChannel;
    pChannelsAvailable_1 := actual_pChannelsAvailable_1;
    ntStatus_13 := 0;
    assume {:nonnull} DeviceObject_22 != 0;
    assume DeviceObject_22 > 0;
    havoc deviceExtension_12;
    pIrb_3 := 0;
    newIrp_2 := 0;
    allocNewIrp_2 := 0;
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    call {:si_unique_call 511} newIrp_2 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_2);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} newIrp_2 != 0;
    allocNewIrp_2 := 1;
    goto L16;

  L16:
    call {:si_unique_call 512} sdv_164 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_3 := sdv_164;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} pIrb_3 != 0;
    call {:si_unique_call 513} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_3 != 0;
    assume pIrb_3 > 0;
    assume {:nonnull} pIrb_3 != 0;
    assume pIrb_3 > 0;
    assume {:nonnull} pIrb_3 != 0;
    assume pIrb_3 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} allocNewIrp_2 != 0;
    call {:si_unique_call 514} KeInitializeEvent(Event_5, 0, 0);
    assume {:nonnull} deviceExtension_12 != 0;
    assume deviceExtension_12 > 0;
    havoc vslice_dummy_var_111;
    call {:si_unique_call 515} ntStatus_13 := t1394_SubmitIrpAsync(vslice_dummy_var_111, newIrp_2, pIrb_3);
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} yogi_error != 1;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} ntStatus_13 == 259;
    call {:si_unique_call 516} vslice_dummy_var_52 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_2 != 0;
    assume ioStatus_2 > 0;
    havoc ntStatus_13;
    goto L55;

  L55:
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} ntStatus_13 >= 0;
    assume {:nonnull} pChannel != 0;
    assume pChannel > 0;
    assume {:nonnull} pIrb_3 != 0;
    assume pIrb_3 > 0;
    assume {:nonnull} pChannelsAvailable_1 != 0;
    assume pChannelsAvailable_1 > 0;
    assume {:nonnull} pIrb_3 != 0;
    assume pIrb_3 > 0;
    assume {:nonnull} pChannelsAvailable_1 != 0;
    assume pChannelsAvailable_1 > 0;
    assume {:nonnull} pIrb_3 != 0;
    assume pIrb_3 > 0;
    assume {:nonnull} pChannelsAvailable_1 != 0;
    assume pChannelsAvailable_1 > 0;
    assume {:nonnull} pIrb_3 != 0;
    assume pIrb_3 > 0;
    assume {:nonnull} pChannelsAvailable_1 != 0;
    assume pChannelsAvailable_1 > 0;
    assume {:nonnull} pIrb_3 != 0;
    assume pIrb_3 > 0;
    assume {:nonnull} pChannelsAvailable_1 != 0;
    assume pChannelsAvailable_1 > 0;
    assume {:nonnull} pIrb_3 != 0;
    assume pIrb_3 > 0;
    goto L27;

  L27:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} pIrb_3 != 0;
    call {:si_unique_call 517} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} allocNewIrp_2 != 0;
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    assume {:nonnull} ioStatus_2 != 0;
    assume ioStatus_2 > 0;
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    assume {:nonnull} ioStatus_2 != 0;
    assume ioStatus_2 > 0;
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    assume {:nonnull} ioStatus_2 != 0;
    assume ioStatus_2 > 0;
    goto L32;

  L32:
    Tmp_181 := ntStatus_13;
    goto LM2;

  LM2:
    return;

  anon23_Then:
    assume {:partition} allocNewIrp_2 == 0;
    goto L32;

  anon22_Then:
    assume {:partition} pIrb_3 == 0;
    goto L28;

  anon25_Then:
    assume {:partition} 0 > ntStatus_13;
    goto L27;

  anon24_Then:
    assume {:partition} ntStatus_13 != 259;
    goto L55;

  anon29_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon28_Then:
    assume {:partition} allocNewIrp_2 == 0;
    assume {:nonnull} deviceExtension_12 != 0;
    assume deviceExtension_12 > 0;
    havoc vslice_dummy_var_112;
    call {:si_unique_call 518} ntStatus_13 := t1394_SubmitIrpSynch(vslice_dummy_var_112, Irp_19, pIrb_3);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto L55;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon27_Then:
    assume {:partition} pIrb_3 == 0;
    ntStatus_13 := -1073741670;
    goto L27;

  anon21_Then:
    assume {:partition} newIrp_2 == 0;
    ntStatus_13 := -1073741670;
    goto L27;

  anon26_Then:
    goto L16;
}



procedure {:origName "t1394_BusResetNotification"} t1394_BusResetNotification(actual_DeviceObject_23: int, actual_Irp_20: int, actual_fulFlags: int) returns (Tmp_183: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_BusResetNotification"} t1394_BusResetNotification(actual_DeviceObject_23: int, actual_Irp_20: int, actual_fulFlags: int) returns (Tmp_183: int)
{
  var {:pointer} sdv_169: int;
  var {:pointer} newIrp_3: int;
  var {:scalar} allocNewIrp_3: int;
  var {:scalar} Event_6: int;
  var {:scalar} ntStatus_14: int;
  var {:scalar} ioStatus_3: int;
  var {:pointer} deviceExtension_13: int;
  var {:pointer} pIrb_4: int;
  var {:pointer} DeviceObject_23: int;
  var {:pointer} Irp_20: int;
  var {:scalar} fulFlags: int;
  var vslice_dummy_var_53: int;
  var vslice_dummy_var_113: int;
  var vslice_dummy_var_114: int;

  anon0:
    call {:si_unique_call 519} Event_6 := __HAVOC_malloc(156);
    call {:si_unique_call 520} ioStatus_3 := __HAVOC_malloc(12);
    DeviceObject_23 := actual_DeviceObject_23;
    Irp_20 := actual_Irp_20;
    fulFlags := actual_fulFlags;
    ntStatus_14 := 0;
    assume {:nonnull} DeviceObject_23 != 0;
    assume DeviceObject_23 > 0;
    havoc deviceExtension_13;
    pIrb_4 := 0;
    newIrp_3 := 0;
    allocNewIrp_3 := 0;
    call {:si_unique_call 521} sdv_169 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_4 := sdv_169;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_4 != 0;
    assume {:nonnull} Irp_20 != 0;
    assume Irp_20 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    call {:si_unique_call 522} newIrp_3 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_3);
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} newIrp_3 != 0;
    allocNewIrp_3 := 1;
    goto L22;

  L22:
    call {:si_unique_call 523} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_4 != 0;
    assume pIrb_4 > 0;
    assume {:nonnull} pIrb_4 != 0;
    assume pIrb_4 > 0;
    assume {:nonnull} pIrb_4 != 0;
    assume pIrb_4 > 0;
    assume {:nonnull} pIrb_4 != 0;
    assume pIrb_4 > 0;
    assume {:nonnull} pIrb_4 != 0;
    assume pIrb_4 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_3 != 0;
    call {:si_unique_call 524} KeInitializeEvent(Event_6, 0, 0);
    assume {:nonnull} deviceExtension_13 != 0;
    assume deviceExtension_13 > 0;
    havoc vslice_dummy_var_113;
    call {:si_unique_call 525} ntStatus_14 := t1394_SubmitIrpAsync(vslice_dummy_var_113, newIrp_3, pIrb_4);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} ntStatus_14 == 259;
    call {:si_unique_call 526} vslice_dummy_var_53 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_3 != 0;
    assume ioStatus_3 > 0;
    havoc ntStatus_14;
    goto L33;

  L33:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} pIrb_4 != 0;
    call {:si_unique_call 527} sdv_ExFreePool(0);
    goto L34;

  L34:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} allocNewIrp_3 != 0;
    assume {:nonnull} Irp_20 != 0;
    assume Irp_20 > 0;
    assume {:nonnull} ioStatus_3 != 0;
    assume ioStatus_3 > 0;
    assume {:nonnull} Irp_20 != 0;
    assume Irp_20 > 0;
    assume {:nonnull} ioStatus_3 != 0;
    assume ioStatus_3 > 0;
    assume {:nonnull} Irp_20 != 0;
    assume Irp_20 > 0;
    assume {:nonnull} ioStatus_3 != 0;
    assume ioStatus_3 > 0;
    goto L38;

  L38:
    Tmp_183 := ntStatus_14;
    goto LM2;

  LM2:
    return;

  anon22_Then:
    assume {:partition} allocNewIrp_3 == 0;
    goto L38;

  anon21_Then:
    assume {:partition} pIrb_4 == 0;
    goto L34;

  anon23_Then:
    assume {:partition} ntStatus_14 != 259;
    goto L33;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_3 == 0;
    assume {:nonnull} deviceExtension_13 != 0;
    assume deviceExtension_13 > 0;
    havoc vslice_dummy_var_114;
    call {:si_unique_call 528} ntStatus_14 := t1394_SubmitIrpSynch(vslice_dummy_var_114, Irp_20, pIrb_4);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L33;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon20_Then:
    assume {:partition} newIrp_3 == 0;
    ntStatus_14 := -1073741670;
    goto L33;

  anon19_Then:
    goto L22;

  anon24_Then:
    assume {:partition} pIrb_4 == 0;
    ntStatus_14 := -1073741670;
    goto L33;
}



procedure {:origName "t1394_BusReset"} t1394_BusReset(actual_DeviceObject_24: int, actual_Irp_21: int, actual_fulFlags_1: int) returns (Tmp_185: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_BusReset"} t1394_BusReset(actual_DeviceObject_24: int, actual_Irp_21: int, actual_fulFlags_1: int) returns (Tmp_185: int)
{
  var {:pointer} sdv_174: int;
  var {:pointer} newIrp_4: int;
  var {:scalar} allocNewIrp_4: int;
  var {:scalar} Event_7: int;
  var {:scalar} ntStatus_15: int;
  var {:scalar} ioStatus_4: int;
  var {:pointer} deviceExtension_14: int;
  var {:pointer} pIrb_5: int;
  var {:pointer} DeviceObject_24: int;
  var {:pointer} Irp_21: int;
  var {:scalar} fulFlags_1: int;
  var vslice_dummy_var_54: int;
  var vslice_dummy_var_115: int;
  var vslice_dummy_var_116: int;

  anon0:
    call {:si_unique_call 529} Event_7 := __HAVOC_malloc(156);
    call {:si_unique_call 530} ioStatus_4 := __HAVOC_malloc(12);
    DeviceObject_24 := actual_DeviceObject_24;
    Irp_21 := actual_Irp_21;
    fulFlags_1 := actual_fulFlags_1;
    ntStatus_15 := 0;
    assume {:nonnull} DeviceObject_24 != 0;
    assume DeviceObject_24 > 0;
    havoc deviceExtension_14;
    pIrb_5 := 0;
    newIrp_4 := 0;
    allocNewIrp_4 := 0;
    call {:si_unique_call 531} sdv_174 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_5 := sdv_174;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_5 != 0;
    assume {:nonnull} Irp_21 != 0;
    assume Irp_21 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    call {:si_unique_call 532} newIrp_4 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_4);
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} newIrp_4 != 0;
    allocNewIrp_4 := 1;
    goto L22;

  L22:
    call {:si_unique_call 533} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_5 != 0;
    assume pIrb_5 > 0;
    assume {:nonnull} pIrb_5 != 0;
    assume pIrb_5 > 0;
    assume {:nonnull} pIrb_5 != 0;
    assume pIrb_5 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_4 != 0;
    call {:si_unique_call 534} KeInitializeEvent(Event_7, 0, 0);
    assume {:nonnull} deviceExtension_14 != 0;
    assume deviceExtension_14 > 0;
    havoc vslice_dummy_var_115;
    call {:si_unique_call 535} ntStatus_15 := t1394_SubmitIrpAsync(vslice_dummy_var_115, newIrp_4, pIrb_5);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} ntStatus_15 == 259;
    call {:si_unique_call 536} vslice_dummy_var_54 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_4 != 0;
    assume ioStatus_4 > 0;
    havoc ntStatus_15;
    goto L33;

  L33:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} pIrb_5 != 0;
    call {:si_unique_call 537} sdv_ExFreePool(0);
    goto L34;

  L34:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} allocNewIrp_4 != 0;
    assume {:nonnull} Irp_21 != 0;
    assume Irp_21 > 0;
    assume {:nonnull} ioStatus_4 != 0;
    assume ioStatus_4 > 0;
    assume {:nonnull} Irp_21 != 0;
    assume Irp_21 > 0;
    assume {:nonnull} ioStatus_4 != 0;
    assume ioStatus_4 > 0;
    assume {:nonnull} Irp_21 != 0;
    assume Irp_21 > 0;
    assume {:nonnull} ioStatus_4 != 0;
    assume ioStatus_4 > 0;
    goto L38;

  L38:
    Tmp_185 := ntStatus_15;
    goto LM2;

  LM2:
    return;

  anon22_Then:
    assume {:partition} allocNewIrp_4 == 0;
    goto L38;

  anon21_Then:
    assume {:partition} pIrb_5 == 0;
    goto L34;

  anon23_Then:
    assume {:partition} ntStatus_15 != 259;
    goto L33;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_4 == 0;
    assume {:nonnull} deviceExtension_14 != 0;
    assume deviceExtension_14 > 0;
    havoc vslice_dummy_var_116;
    call {:si_unique_call 538} ntStatus_15 := t1394_SubmitIrpSynch(vslice_dummy_var_116, Irp_21, pIrb_5);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L33;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon20_Then:
    assume {:partition} newIrp_4 == 0;
    ntStatus_15 := -1073741670;
    goto L33;

  anon19_Then:
    goto L22;

  anon24_Then:
    assume {:partition} pIrb_5 == 0;
    ntStatus_15 := -1073741670;
    goto L33;
}



procedure {:origName "t1394_IsochTalk"} t1394_IsochTalk(actual_DeviceObject_25: int, actual_Irp_22: int, actual_hResource: int, actual_fulFlags_2: int, actual_SD1_1: int) returns (Tmp_187: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochTalk"} t1394_IsochTalk(actual_DeviceObject_25: int, actual_Irp_22: int, actual_hResource: int, actual_fulFlags_2: int, actual_SD1_1: int) returns (Tmp_187: int)
{
  var {:scalar} StartTime_1: int;
  var {:pointer} sdv_179: int;
  var {:pointer} newIrp_5: int;
  var {:scalar} allocNewIrp_5: int;
  var {:scalar} Event_8: int;
  var {:scalar} ntStatus_16: int;
  var {:scalar} ioStatus_5: int;
  var {:pointer} deviceExtension_15: int;
  var {:pointer} pIrb_6: int;
  var {:pointer} DeviceObject_25: int;
  var {:pointer} Irp_22: int;
  var {:pointer} hResource: int;
  var {:scalar} fulFlags_2: int;
  var {:pointer} SD1_1: int;
  var vslice_dummy_var_55: int;
  var vslice_dummy_var_117: int;
  var vslice_dummy_var_118: int;

  anon0:
    call {:si_unique_call 539} StartTime_1 := __HAVOC_malloc(12);
    call {:si_unique_call 540} Event_8 := __HAVOC_malloc(156);
    call {:si_unique_call 541} ioStatus_5 := __HAVOC_malloc(12);
    DeviceObject_25 := actual_DeviceObject_25;
    Irp_22 := actual_Irp_22;
    hResource := actual_hResource;
    fulFlags_2 := actual_fulFlags_2;
    SD1_1 := actual_SD1_1;
    assume {:nonnull} SD1_1 != 0;
    assume SD1_1 > 0;
    assume {:nonnull} StartTime_1 != 0;
    assume StartTime_1 > 0;
    assume {:nonnull} SD1_1 != 0;
    assume SD1_1 > 0;
    assume {:nonnull} StartTime_1 != 0;
    assume StartTime_1 > 0;
    assume {:nonnull} SD1_1 != 0;
    assume SD1_1 > 0;
    assume {:nonnull} StartTime_1 != 0;
    assume StartTime_1 > 0;
    ntStatus_16 := 0;
    assume {:nonnull} DeviceObject_25 != 0;
    assume DeviceObject_25 > 0;
    havoc deviceExtension_15;
    pIrb_6 := 0;
    newIrp_5 := 0;
    allocNewIrp_5 := 0;
    assume {:nonnull} Irp_22 != 0;
    assume Irp_22 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    call {:si_unique_call 542} newIrp_5 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_5);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} newIrp_5 != 0;
    allocNewIrp_5 := 1;
    goto L16;

  L16:
    call {:si_unique_call 543} sdv_179 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_6 := sdv_179;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_6 != 0;
    call {:si_unique_call 544} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_6 != 0;
    assume pIrb_6 > 0;
    assume {:nonnull} pIrb_6 != 0;
    assume pIrb_6 > 0;
    assume {:nonnull} pIrb_6 != 0;
    assume pIrb_6 > 0;
    assume {:nonnull} pIrb_6 != 0;
    assume pIrb_6 > 0;
    assume {:nonnull} StartTime_1 != 0;
    assume StartTime_1 > 0;
    assume {:nonnull} pIrb_6 != 0;
    assume pIrb_6 > 0;
    assume {:nonnull} StartTime_1 != 0;
    assume StartTime_1 > 0;
    assume {:nonnull} pIrb_6 != 0;
    assume pIrb_6 > 0;
    assume {:nonnull} StartTime_1 != 0;
    assume StartTime_1 > 0;
    assume {:nonnull} pIrb_6 != 0;
    assume pIrb_6 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_5 != 0;
    call {:si_unique_call 545} KeInitializeEvent(Event_8, 0, 0);
    assume {:nonnull} deviceExtension_15 != 0;
    assume deviceExtension_15 > 0;
    havoc vslice_dummy_var_117;
    call {:si_unique_call 546} ntStatus_16 := t1394_SubmitIrpAsync(vslice_dummy_var_117, newIrp_5, pIrb_6);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} ntStatus_16 == 259;
    call {:si_unique_call 547} vslice_dummy_var_55 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_5 != 0;
    assume ioStatus_5 > 0;
    havoc ntStatus_16;
    goto L27;

  L27:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} pIrb_6 != 0;
    call {:si_unique_call 548} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} allocNewIrp_5 != 0;
    assume {:nonnull} Irp_22 != 0;
    assume Irp_22 > 0;
    assume {:nonnull} ioStatus_5 != 0;
    assume ioStatus_5 > 0;
    assume {:nonnull} Irp_22 != 0;
    assume Irp_22 > 0;
    assume {:nonnull} ioStatus_5 != 0;
    assume ioStatus_5 > 0;
    assume {:nonnull} Irp_22 != 0;
    assume Irp_22 > 0;
    assume {:nonnull} ioStatus_5 != 0;
    assume ioStatus_5 > 0;
    goto L32;

  L32:
    Tmp_187 := ntStatus_16;
    goto LM2;

  LM2:
    return;

  anon21_Then:
    assume {:partition} allocNewIrp_5 == 0;
    goto L32;

  anon20_Then:
    assume {:partition} pIrb_6 == 0;
    goto L28;

  anon22_Then:
    assume {:partition} ntStatus_16 != 259;
    goto L27;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_5 == 0;
    assume {:nonnull} deviceExtension_15 != 0;
    assume deviceExtension_15 > 0;
    havoc vslice_dummy_var_118;
    call {:si_unique_call 549} ntStatus_16 := t1394_SubmitIrpSynch(vslice_dummy_var_118, Irp_22, pIrb_6);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L27;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon24_Then:
    assume {:partition} pIrb_6 == 0;
    ntStatus_16 := -1073741670;
    goto L27;

  anon19_Then:
    assume {:partition} newIrp_5 == 0;
    ntStatus_16 := -1073741670;
    goto L27;

  anon23_Then:
    goto L16;
}



procedure {:origName "t1394_IsochAttachCompletionRoutine"} t1394_IsochAttachCompletionRoutine(actual_DeviceObject_26: int, actual_Irp_23: int, actual_IsochDetachData_1: int) returns (Tmp_189: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochAttachCompletionRoutine"} t1394_IsochAttachCompletionRoutine(actual_DeviceObject_26: int, actual_Irp_23: int, actual_IsochDetachData_1: int) returns (Tmp_189: int)
{
  var {:scalar} i_1: int;
  var {:pointer} Tmp_190: int;
  var {:pointer} Tmp_191: int;
  var {:pointer} Tmp_192: int;
  var {:scalar} sdv_184: int;
  var {:pointer} DeviceExtension: int;
  var {:pointer} Tmp_193: int;
  var {:scalar} Tmp_194: int;
  var {:scalar} Irql_3: int;
  var {:scalar} Tmp_196: int;
  var {:pointer} Irp_23: int;
  var {:pointer} IsochDetachData_1: int;
  var vslice_dummy_var_56: int;
  var vslice_dummy_var_57: int;

  anon0:
    Irp_23 := actual_Irp_23;
    IsochDetachData_1 := actual_IsochDetachData_1;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} IsochDetachData_1 != 0;
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    goto L14;

  L14:
    Tmp_189 := -1073741802;
    goto LM2;

  LM2:
    return;

  anon19_Then:
    assume {:nonnull} IsochDetachData_1 != 0;
    assume IsochDetachData_1 > 0;
    havoc DeviceExtension;
    call {:si_unique_call 550} Tmp_193 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_193 != 0;
    assume Tmp_193 > 0;
    call {:si_unique_call 551} sdv_KeAcquireSpinLock(0, Tmp_193);
    assume {:nonnull} Tmp_193 != 0;
    assume Tmp_193 > 0;
    havoc Irql_3;
    assume {:nonnull} DeviceExtension != 0;
    assume DeviceExtension > 0;
    assume {:nonnull} IsochDetachData_1 != 0;
    assume IsochDetachData_1 > 0;
    call {:si_unique_call 552} sdv_184 := t1394_IsOnList(IsochDetachList__ISOCH_DETACH_DATA(IsochDetachData_1), IsochDetachData__DEVICE_EXTENSION(DeviceExtension));
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} sdv_184 != 0;
    call {:si_unique_call 553} vslice_dummy_var_56 := sdv_RemoveEntryList(0);
    call {:si_unique_call 554} vslice_dummy_var_57 := KeCancelTimer(0);
    call {:si_unique_call 555} sdv_KeReleaseSpinLock(0, Irql_3);
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} IsochDetachData_1 != 0;
    assume {:nonnull} IsochDetachData_1 != 0;
    assume IsochDetachData_1 > 0;
    havoc DeviceExtension;
    assume {:nonnull} IsochDetachData_1 != 0;
    assume IsochDetachData_1 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    call {:si_unique_call 556} sdv_ExFreePool(0);
    goto L39;

  L39:
    i_1 := 0;
    goto L43;

  L43:
    call {:si_unique_call 557} i_1, Tmp_191, Tmp_192, Tmp_194, Tmp_196 := t1394_IsochAttachCompletionRoutine_loop_L43(i_1, Tmp_191, Tmp_192, Tmp_194, Tmp_196, IsochDetachData_1);
    goto L43_last;

  L43_last:
    assume {:nonnull} IsochDetachData_1 != 0;
    assume IsochDetachData_1 > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    Tmp_194 := i_1;
    assume {:nonnull} IsochDetachData_1 != 0;
    assume IsochDetachData_1 > 0;
    havoc Tmp_192;
    assume {:nonnull} Tmp_192 != 0;
    assume Tmp_192 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    Tmp_196 := i_1;
    assume {:nonnull} IsochDetachData_1 != 0;
    assume IsochDetachData_1 > 0;
    havoc Tmp_191;
    assume {:nonnull} Tmp_191 != 0;
    assume Tmp_191 > 0;
    call {:si_unique_call 558} IoFreeMdl(0);
    goto L48;

  L48:
    i_1 := i_1 + 1;
    goto L48_dummy;

  L48_dummy:
    assume false;
    return;

  anon25_Then:
    goto L48;

  anon21_Then:
    call {:si_unique_call 559} sdv_ExFreePool(0);
    assume {:nonnull} IsochDetachData_1 != 0;
    assume IsochDetachData_1 > 0;
    havoc Tmp_190;
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    assume {:nonnull} Tmp_190 != 0;
    assume Tmp_190 > 0;
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    assume {:nonnull} Tmp_190 != 0;
    assume Tmp_190 > 0;
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    assume {:nonnull} Tmp_190 != 0;
    assume Tmp_190 > 0;
    assume {:nonnull} IsochDetachData_1 != 0;
    assume IsochDetachData_1 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 560} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L72;

  L72:
    call {:si_unique_call 561} sdv_IoCompleteRequest(0, 0);
    call {:si_unique_call 562} IoFreeIrp(0);
    call {:si_unique_call 563} sdv_ExFreePool(0);
    goto L14;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon26_Then:
    goto L72;

  anon24_Then:
    goto L39;

  anon23_Then:
    assume {:partition} IsochDetachData_1 == 0;
    goto L14;

  anon20_Then:
    assume {:partition} sdv_184 == 0;
    call {:si_unique_call 564} sdv_KeReleaseSpinLock(0, Irql_3);
    goto L14;

  anon22_Then:
    assume {:partition} IsochDetachData_1 == 0;
    call {:si_unique_call 565} IoFreeIrp(0);
    goto L14;
}



procedure {:origName "t1394_AsyncStream"} t1394_AsyncStream(actual_DeviceObject_27: int, actual_Irp_24: int, actual_nNumberOfBytesToStream: int, actual_fulFlags_3: int, actual_ulTag: int, actual_nChannel: int, actual_ulSynch: int, actual_nSpeed: int, actual_Data: int) returns (Tmp_197: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_AsyncStream"} t1394_AsyncStream(actual_DeviceObject_27: int, actual_Irp_24: int, actual_nNumberOfBytesToStream: int, actual_fulFlags_3: int, actual_ulTag: int, actual_nChannel: int, actual_ulSynch: int, actual_nSpeed: int, actual_Data: int) returns (Tmp_197: int)
{
  var {:pointer} sdv_187: int;
  var {:pointer} newIrp_6: int;
  var {:scalar} allocNewIrp_6: int;
  var {:scalar} Event_9: int;
  var {:scalar} ntStatus_18: int;
  var {:scalar} ioStatus_6: int;
  var {:pointer} deviceExtension_16: int;
  var {:pointer} pIrb_7: int;
  var {:pointer} pMdl: int;
  var {:pointer} DeviceObject_27: int;
  var {:pointer} Irp_24: int;
  var {:scalar} nNumberOfBytesToStream: int;
  var {:scalar} fulFlags_3: int;
  var {:scalar} ulTag: int;
  var {:scalar} nChannel: int;
  var {:scalar} ulSynch: int;
  var {:scalar} nSpeed: int;
  var vslice_dummy_var_58: int;
  var vslice_dummy_var_119: int;
  var vslice_dummy_var_120: int;

  anon0:
    call {:si_unique_call 566} Event_9 := __HAVOC_malloc(156);
    call {:si_unique_call 567} ioStatus_6 := __HAVOC_malloc(12);
    DeviceObject_27 := actual_DeviceObject_27;
    Irp_24 := actual_Irp_24;
    nNumberOfBytesToStream := actual_nNumberOfBytesToStream;
    fulFlags_3 := actual_fulFlags_3;
    ulTag := actual_ulTag;
    nChannel := actual_nChannel;
    ulSynch := actual_ulSynch;
    nSpeed := actual_nSpeed;
    ntStatus_18 := 0;
    assume {:nonnull} DeviceObject_27 != 0;
    assume DeviceObject_27 > 0;
    havoc deviceExtension_16;
    pIrb_7 := 0;
    pMdl := 0;
    newIrp_6 := 0;
    allocNewIrp_6 := 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} nNumberOfBytesToStream != 0;
    assume {:nonnull} Irp_24 != 0;
    assume Irp_24 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    call {:si_unique_call 568} newIrp_6 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_6);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} newIrp_6 != 0;
    allocNewIrp_6 := 1;
    goto L20;

  L20:
    call {:si_unique_call 569} sdv_187 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_7 := sdv_187;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} pIrb_7 != 0;
    call {:si_unique_call 570} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_7 != 0;
    assume pIrb_7 > 0;
    assume {:nonnull} pIrb_7 != 0;
    assume pIrb_7 > 0;
    assume {:nonnull} pIrb_7 != 0;
    assume pIrb_7 > 0;
    assume {:nonnull} pIrb_7 != 0;
    assume pIrb_7 > 0;
    assume {:nonnull} pIrb_7 != 0;
    assume pIrb_7 > 0;
    assume {:nonnull} pIrb_7 != 0;
    assume pIrb_7 > 0;
    assume {:nonnull} pIrb_7 != 0;
    assume pIrb_7 > 0;
    assume {:nonnull} pIrb_7 != 0;
    assume pIrb_7 > 0;
    call {:si_unique_call 571} pMdl := IoAllocateMdl(0, nNumberOfBytesToStream, 0, 0, 0);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} pMdl != 0;
    assume {:nonnull} pIrb_7 != 0;
    assume pIrb_7 > 0;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} allocNewIrp_6 != 0;
    call {:si_unique_call 572} KeInitializeEvent(Event_9, 0, 0);
    assume {:nonnull} deviceExtension_16 != 0;
    assume deviceExtension_16 > 0;
    havoc vslice_dummy_var_119;
    call {:si_unique_call 573} ntStatus_18 := t1394_SubmitIrpAsync(vslice_dummy_var_119, newIrp_6, pIrb_7);
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} yogi_error != 1;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} ntStatus_18 == 259;
    call {:si_unique_call 574} vslice_dummy_var_58 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_6 != 0;
    assume ioStatus_6 > 0;
    havoc ntStatus_18;
    goto L31;

  L31:
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} pMdl != 0;
    call {:si_unique_call 575} IoFreeMdl(0);
    goto L32;

  L32:
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} pIrb_7 != 0;
    call {:si_unique_call 576} sdv_ExFreePool(0);
    goto L36;

  L36:
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} allocNewIrp_6 != 0;
    assume {:nonnull} Irp_24 != 0;
    assume Irp_24 > 0;
    assume {:nonnull} ioStatus_6 != 0;
    assume ioStatus_6 > 0;
    assume {:nonnull} Irp_24 != 0;
    assume Irp_24 > 0;
    assume {:nonnull} ioStatus_6 != 0;
    assume ioStatus_6 > 0;
    assume {:nonnull} Irp_24 != 0;
    assume Irp_24 > 0;
    assume {:nonnull} ioStatus_6 != 0;
    assume ioStatus_6 > 0;
    goto L40;

  L40:
    Tmp_197 := ntStatus_18;
    goto LM2;

  LM2:
    return;

  anon29_Then:
    assume {:partition} allocNewIrp_6 == 0;
    goto L40;

  anon28_Then:
    assume {:partition} pIrb_7 == 0;
    goto L36;

  anon27_Then:
    assume {:partition} pMdl == 0;
    goto L32;

  anon31_Then:
    assume {:partition} ntStatus_18 != 259;
    goto L31;

  anon35_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon34_Then:
    assume {:partition} allocNewIrp_6 == 0;
    assume {:nonnull} deviceExtension_16 != 0;
    assume deviceExtension_16 > 0;
    havoc vslice_dummy_var_120;
    call {:si_unique_call 577} ntStatus_18 := t1394_SubmitIrpSynch(vslice_dummy_var_120, Irp_24, pIrb_7);
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} yogi_error != 1;
    goto L31;

  anon36_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon30_Then:
    assume {:partition} pMdl == 0;
    ntStatus_18 := -1073741670;
    goto L31;

  anon33_Then:
    assume {:partition} pIrb_7 == 0;
    ntStatus_18 := -1073741670;
    goto L31;

  anon26_Then:
    assume {:partition} newIrp_6 == 0;
    ntStatus_18 := -1073741670;
    goto L31;

  anon25_Then:
    goto L20;

  anon32_Then:
    assume {:partition} nNumberOfBytesToStream == 0;
    ntStatus_18 := -1073741811;
    goto L31;
}



procedure {:origName "t1394_GetAddressData"} t1394_GetAddressData(actual_DeviceObject_28: int, actual_Irp_25: int, actual_hAddressRange: int, actual_nLength: int, actual_ulOffset: int, actual_Data_1: int) returns (Tmp_199: int);
  modifies alloc;
  free ensures Tmp_199 == 0 || Tmp_199 == -1073741811;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_GetAddressData"} t1394_GetAddressData(actual_DeviceObject_28: int, actual_Irp_25: int, actual_hAddressRange: int, actual_nLength: int, actual_ulOffset: int, actual_Data_1: int) returns (Tmp_199: int)
{
  var {:pointer} Tmp_200: int;
  var {:scalar} ntStatus_19: int;
  var {:pointer} AsyncAddressData_1: int;
  var {:scalar} Irql_4: int;
  var {:pointer} deviceExtension_17: int;
  var {:pointer} DeviceObject_28: int;
  var {:pointer} hAddressRange: int;
  var {:scalar} nLength: int;
  var {:scalar} ulOffset: int;

  anon0:
    DeviceObject_28 := actual_DeviceObject_28;
    hAddressRange := actual_hAddressRange;
    nLength := actual_nLength;
    ulOffset := actual_ulOffset;
    ntStatus_19 := 0;
    assume {:nonnull} DeviceObject_28 != 0;
    assume DeviceObject_28 > 0;
    havoc deviceExtension_17;
    call {:si_unique_call 578} Tmp_200 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_200 != 0;
    assume Tmp_200 > 0;
    call {:si_unique_call 579} sdv_KeAcquireSpinLock(0, Tmp_200);
    assume {:nonnull} Tmp_200 != 0;
    assume Tmp_200 > 0;
    havoc Irql_4;
    assume {:nonnull} deviceExtension_17 != 0;
    assume deviceExtension_17 > 0;
    havoc AsyncAddressData_1;
    goto L13;

  L13:
    call {:si_unique_call 580} AsyncAddressData_1 := t1394_GetAddressData_loop_L13(AsyncAddressData_1, hAddressRange);
    goto L13_last;

  L13_last:
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} AsyncAddressData_1 != 0;
    assume {:nonnull} AsyncAddressData_1 != 0;
    assume AsyncAddressData_1 > 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:nonnull} AsyncAddressData_1 != 0;
    assume AsyncAddressData_1 > 0;
    call {:si_unique_call 581} sdv_RtlCopyMemory(0, 0, nLength);
    goto L14;

  L14:
    call {:si_unique_call 582} sdv_KeReleaseSpinLock(0, Irql_4);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} AsyncAddressData_1 != 0;
    goto L31;

  L31:
    Tmp_199 := ntStatus_19;
    return;

  anon12_Then:
    assume {:partition} AsyncAddressData_1 == 0;
    ntStatus_19 := -1073741811;
    goto L31;

  anon10_Then:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    AsyncAddressData_1 := 0;
    goto L14;

  anon11_Then:
    assume {:nonnull} AsyncAddressData_1 != 0;
    assume AsyncAddressData_1 > 0;
    havoc AsyncAddressData_1;
    goto anon11_Then_dummy;

  anon11_Then_dummy:
    assume false;
    return;

  anon9_Then:
    assume {:partition} AsyncAddressData_1 == 0;
    goto L14;
}



procedure {:origName "t1394_IsochFreeBandwidth"} t1394_IsochFreeBandwidth(actual_DeviceObject_29: int, actual_Irp_26: int, actual_hBandwidth: int) returns (Tmp_201: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochFreeBandwidth"} t1394_IsochFreeBandwidth(actual_DeviceObject_29: int, actual_Irp_26: int, actual_hBandwidth: int) returns (Tmp_201: int)
{
  var {:pointer} sdv_193: int;
  var {:pointer} newIrp_7: int;
  var {:scalar} allocNewIrp_7: int;
  var {:scalar} Event_10: int;
  var {:scalar} ntStatus_20: int;
  var {:scalar} ioStatus_7: int;
  var {:pointer} deviceExtension_18: int;
  var {:pointer} pIrb_8: int;
  var {:pointer} DeviceObject_29: int;
  var {:pointer} Irp_26: int;
  var {:pointer} hBandwidth: int;
  var vslice_dummy_var_59: int;
  var vslice_dummy_var_121: int;
  var vslice_dummy_var_122: int;

  anon0:
    call {:si_unique_call 583} Event_10 := __HAVOC_malloc(156);
    call {:si_unique_call 584} ioStatus_7 := __HAVOC_malloc(12);
    DeviceObject_29 := actual_DeviceObject_29;
    Irp_26 := actual_Irp_26;
    hBandwidth := actual_hBandwidth;
    ntStatus_20 := 0;
    assume {:nonnull} DeviceObject_29 != 0;
    assume DeviceObject_29 > 0;
    havoc deviceExtension_18;
    pIrb_8 := 0;
    newIrp_7 := 0;
    allocNewIrp_7 := 0;
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    call {:si_unique_call 585} newIrp_7 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_7);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} newIrp_7 != 0;
    allocNewIrp_7 := 1;
    goto L16;

  L16:
    call {:si_unique_call 586} sdv_193 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_8 := sdv_193;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_8 != 0;
    call {:si_unique_call 587} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_8 != 0;
    assume pIrb_8 > 0;
    assume {:nonnull} pIrb_8 != 0;
    assume pIrb_8 > 0;
    assume {:nonnull} pIrb_8 != 0;
    assume pIrb_8 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_7 != 0;
    call {:si_unique_call 588} KeInitializeEvent(Event_10, 0, 0);
    assume {:nonnull} deviceExtension_18 != 0;
    assume deviceExtension_18 > 0;
    havoc vslice_dummy_var_121;
    call {:si_unique_call 589} ntStatus_20 := t1394_SubmitIrpAsync(vslice_dummy_var_121, newIrp_7, pIrb_8);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} ntStatus_20 == 259;
    call {:si_unique_call 590} vslice_dummy_var_59 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_7 != 0;
    assume ioStatus_7 > 0;
    havoc ntStatus_20;
    goto L27;

  L27:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} pIrb_8 != 0;
    call {:si_unique_call 591} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} allocNewIrp_7 != 0;
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    assume {:nonnull} ioStatus_7 != 0;
    assume ioStatus_7 > 0;
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    assume {:nonnull} ioStatus_7 != 0;
    assume ioStatus_7 > 0;
    assume {:nonnull} Irp_26 != 0;
    assume Irp_26 > 0;
    assume {:nonnull} ioStatus_7 != 0;
    assume ioStatus_7 > 0;
    goto L32;

  L32:
    Tmp_201 := ntStatus_20;
    goto LM2;

  LM2:
    return;

  anon21_Then:
    assume {:partition} allocNewIrp_7 == 0;
    goto L32;

  anon20_Then:
    assume {:partition} pIrb_8 == 0;
    goto L28;

  anon22_Then:
    assume {:partition} ntStatus_20 != 259;
    goto L27;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_7 == 0;
    assume {:nonnull} deviceExtension_18 != 0;
    assume deviceExtension_18 > 0;
    havoc vslice_dummy_var_122;
    call {:si_unique_call 592} ntStatus_20 := t1394_SubmitIrpSynch(vslice_dummy_var_122, Irp_26, pIrb_8);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L27;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon24_Then:
    assume {:partition} pIrb_8 == 0;
    ntStatus_20 := -1073741670;
    goto L27;

  anon19_Then:
    assume {:partition} newIrp_7 == 0;
    ntStatus_20 := -1073741670;
    goto L27;

  anon23_Then:
    goto L16;
}



procedure {:origName "t1394_AsyncRead"} t1394_AsyncRead(actual_DeviceObject_30: int, actual_Irp_27: int, actual_bRawMode: int, actual_bGetGeneration: int, actual_SD2: int, actual_nNumberOfBytesToRead: int, actual_nBlockSize: int, actual_fulFlags_4: int, actual_ulGeneration: int, actual_Data_2: int) returns (Tmp_203: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_AsyncRead"} t1394_AsyncRead(actual_DeviceObject_30: int, actual_Irp_27: int, actual_bRawMode: int, actual_bGetGeneration: int, actual_SD2: int, actual_nNumberOfBytesToRead: int, actual_nBlockSize: int, actual_fulFlags_4: int, actual_ulGeneration: int, actual_Data_2: int) returns (Tmp_203: int)
{
  var {:scalar} DestinationAddress_2: int;
  var {:pointer} NextDeviceObject: int;
  var {:pointer} sdv_198: int;
  var {:pointer} newIrp_8: int;
  var {:scalar} allocNewIrp_8: int;
  var {:scalar} Event_11: int;
  var {:scalar} ntStatus_21: int;
  var {:scalar} ioStatus_8: int;
  var {:pointer} deviceExtension_19: int;
  var {:pointer} pIrb_9: int;
  var {:pointer} pMdl_1: int;
  var {:pointer} DeviceObject_30: int;
  var {:pointer} Irp_27: int;
  var {:scalar} bRawMode: int;
  var {:scalar} bGetGeneration: int;
  var {:pointer} SD2: int;
  var {:scalar} nNumberOfBytesToRead: int;
  var {:scalar} nBlockSize: int;
  var {:scalar} fulFlags_4: int;
  var {:scalar} ulGeneration: int;
  var vslice_dummy_var_60: int;

  anon0:
    call {:si_unique_call 593} DestinationAddress_2 := __HAVOC_malloc(16);
    call {:si_unique_call 594} Event_11 := __HAVOC_malloc(156);
    call {:si_unique_call 595} ioStatus_8 := __HAVOC_malloc(12);
    DeviceObject_30 := actual_DeviceObject_30;
    Irp_27 := actual_Irp_27;
    bRawMode := actual_bRawMode;
    bGetGeneration := actual_bGetGeneration;
    SD2 := actual_SD2;
    nNumberOfBytesToRead := actual_nNumberOfBytesToRead;
    nBlockSize := actual_nBlockSize;
    fulFlags_4 := actual_fulFlags_4;
    ulGeneration := actual_ulGeneration;
    assume {:nonnull} DestinationAddress_2 != 0;
    assume DestinationAddress_2 > 0;
    assume {:nonnull} SD2 != 0;
    assume SD2 > 0;
    assume {:nonnull} DestinationAddress_2 != 0;
    assume DestinationAddress_2 > 0;
    assume {:nonnull} SD2 != 0;
    assume SD2 > 0;
    assume {:nonnull} DestinationAddress_2 != 0;
    assume DestinationAddress_2 > 0;
    assume {:nonnull} SD2 != 0;
    assume SD2 > 0;
    assume {:nonnull} DestinationAddress_2 != 0;
    assume DestinationAddress_2 > 0;
    assume {:nonnull} SD2 != 0;
    assume SD2 > 0;
    ntStatus_21 := 0;
    assume {:nonnull} DeviceObject_30 != 0;
    assume DeviceObject_30 > 0;
    havoc deviceExtension_19;
    pIrb_9 := 0;
    pMdl_1 := 0;
    NextDeviceObject := 0;
    newIrp_8 := 0;
    allocNewIrp_8 := 0;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} nNumberOfBytesToRead != 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} bRawMode != 0;
    assume {:nonnull} deviceExtension_19 != 0;
    assume deviceExtension_19 > 0;
    havoc NextDeviceObject;
    goto L24;

  L24:
    assume {:nonnull} Irp_27 != 0;
    assume Irp_27 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    call {:si_unique_call 596} newIrp_8 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_8);
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} newIrp_8 != 0;
    allocNewIrp_8 := 1;
    goto L25;

  L25:
    call {:si_unique_call 597} sdv_198 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_9 := sdv_198;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} pIrb_9 != 0;
    call {:si_unique_call 598} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    assume {:nonnull} DestinationAddress_2 != 0;
    assume DestinationAddress_2 > 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    assume {:nonnull} DestinationAddress_2 != 0;
    assume DestinationAddress_2 > 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    assume {:nonnull} DestinationAddress_2 != 0;
    assume DestinationAddress_2 > 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    assume {:nonnull} DestinationAddress_2 != 0;
    assume DestinationAddress_2 > 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} bGetGeneration != 0;
    assume {:nonnull} deviceExtension_19 != 0;
    assume deviceExtension_19 > 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    goto L62;

  L62:
    call {:si_unique_call 599} pMdl_1 := IoAllocateMdl(0, nNumberOfBytesToRead, 0, 0, 0);
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} allocNewIrp_8 != 0;
    call {:si_unique_call 600} KeInitializeEvent(Event_11, 0, 0);
    call {:si_unique_call 601} ntStatus_21 := t1394_SubmitIrpAsync(NextDeviceObject, newIrp_8, pIrb_9);
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} yogi_error != 1;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} ntStatus_21 == 259;
    call {:si_unique_call 602} vslice_dummy_var_60 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_8 != 0;
    assume ioStatus_8 > 0;
    havoc ntStatus_21;
    goto L82;

  L82:
    goto L36;

  L36:
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} pMdl_1 != 0;
    call {:si_unique_call 603} IoFreeMdl(0);
    goto L37;

  L37:
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} pIrb_9 != 0;
    call {:si_unique_call 604} sdv_ExFreePool(0);
    goto L41;

  L41:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} allocNewIrp_8 != 0;
    assume {:nonnull} Irp_27 != 0;
    assume Irp_27 > 0;
    assume {:nonnull} ioStatus_8 != 0;
    assume ioStatus_8 > 0;
    assume {:nonnull} Irp_27 != 0;
    assume Irp_27 > 0;
    assume {:nonnull} ioStatus_8 != 0;
    assume ioStatus_8 > 0;
    assume {:nonnull} Irp_27 != 0;
    assume Irp_27 > 0;
    assume {:nonnull} ioStatus_8 != 0;
    assume ioStatus_8 > 0;
    goto L45;

  L45:
    Tmp_203 := ntStatus_21;
    goto LM2;

  LM2:
    return;

  anon32_Then:
    assume {:partition} allocNewIrp_8 == 0;
    goto L45;

  anon31_Then:
    assume {:partition} pIrb_9 == 0;
    goto L41;

  anon30_Then:
    assume {:partition} pMdl_1 == 0;
    goto L37;

  anon33_Then:
    assume {:partition} ntStatus_21 != 259;
    goto L82;

  anon38_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon37_Then:
    assume {:partition} allocNewIrp_8 == 0;
    call {:si_unique_call 605} ntStatus_21 := t1394_SubmitIrpSynch(NextDeviceObject, Irp_27, pIrb_9);
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} yogi_error != 1;
    goto L36;

  anon39_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon36_Then:
    assume {:partition} bGetGeneration == 0;
    assume {:nonnull} pIrb_9 != 0;
    assume pIrb_9 > 0;
    goto L62;

  anon35_Then:
    assume {:partition} pIrb_9 == 0;
    ntStatus_21 := -1073741670;
    goto L36;

  anon29_Then:
    assume {:partition} newIrp_8 == 0;
    ntStatus_21 := -1073741670;
    goto L36;

  anon28_Then:
    goto L25;

  anon27_Then:
    assume {:partition} bRawMode == 0;
    assume {:nonnull} deviceExtension_19 != 0;
    assume deviceExtension_19 > 0;
    havoc NextDeviceObject;
    goto L24;

  anon34_Then:
    assume {:partition} nNumberOfBytesToRead == 0;
    ntStatus_21 := -1073741811;
    goto L36;
}



procedure {:origName "t1394_SubmitIrpAsync"} t1394_SubmitIrpAsync(actual_DeviceObject_31: int, actual_Irp_28: int, actual_Irb_1: int) returns (Tmp_205: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 1 ==> wait_required != 0;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> wait_required == old(wait_required);
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_SubmitIrpAsync"} t1394_SubmitIrpAsync(actual_DeviceObject_31: int, actual_Irp_28: int, actual_Irb_1: int) returns (Tmp_205: int)
{
  var {:scalar} ntStatus_22: int;
  var {:pointer} NextIrpStack: int;
  var {:pointer} DeviceObject_31: int;
  var {:pointer} Irp_28: int;
  var {:pointer} Irb_1: int;

  anon0:
    DeviceObject_31 := actual_DeviceObject_31;
    Irp_28 := actual_Irp_28;
    Irb_1 := actual_Irb_1;
    ntStatus_22 := 0;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} Irb_1 != 0;
    call {:si_unique_call 606} NextIrpStack := sdv_IoGetNextIrpStackLocation(Irp_28);
    assume {:nonnull} NextIrpStack != 0;
    assume NextIrpStack > 0;
    goto L15;

  L15:
    call {:si_unique_call 607} ntStatus_22 := sdv_IoCallDriver(DeviceObject_31, Irp_28);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} yogi_error != 1;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume Irp_28 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 608} SLIC_sdv_IoCallDriver_exit(0, ntStatus_22);
    goto L19;

  L19:
    Tmp_205 := ntStatus_22;
    goto LM2;

  LM2:
    return;

  anon7_Then:
    assume !(Irp_28 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L19;

  anon9_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon8_Then:
    assume {:partition} Irb_1 == 0;
    call {:si_unique_call 609} sdv_IoCopyCurrentIrpStackLocationToNext(Irp_28);
    goto L15;
}



procedure {:origName "t1394_IsochDetachCompletionRoutine"} t1394_IsochDetachCompletionRoutine(actual_DeviceObject_32: int, actual_Irp_29: int, actual_IsochDetachData_2: int) returns (Tmp_207: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochDetachCompletionRoutine"} t1394_IsochDetachCompletionRoutine(actual_DeviceObject_32: int, actual_Irp_29: int, actual_IsochDetachData_2: int) returns (Tmp_207: int)
{
  var {:scalar} i_2: int;
  var {:pointer} Tmp_208: int;
  var {:scalar} Tmp_209: int;
  var {:pointer} Tmp_210: int;
  var {:pointer} Tmp_211: int;
  var {:scalar} Tmp_212: int;
  var {:pointer} Tmp_215: int;
  var {:pointer} IsochDetachData_2: int;

  anon0:
    IsochDetachData_2 := actual_IsochDetachData_2;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} IsochDetachData_2 == 0;
    goto L38;

  L38:
    Tmp_207 := -1073741802;
    goto LM2;

  LM2:
    return;

  anon27_Then:
    assume {:partition} IsochDetachData_2 != 0;
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    call {:si_unique_call 610} sdv_ExFreePool(0);
    goto L9;

  L9:
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    call {:si_unique_call 611} sdv_ExFreePool(0);
    goto L13;

  L13:
    i_2 := 0;
    goto L17;

  L17:
    call {:si_unique_call 612} i_2, Tmp_209, Tmp_211, Tmp_212, Tmp_215 := t1394_IsochDetachCompletionRoutine_loop_L17(i_2, Tmp_209, Tmp_211, Tmp_212, Tmp_215, IsochDetachData_2);
    goto L17_last;

  L17_last:
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    Tmp_212 := i_2;
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    havoc Tmp_211;
    assume {:nonnull} Tmp_211 != 0;
    assume Tmp_211 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    Tmp_209 := i_2;
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    havoc Tmp_215;
    assume {:nonnull} Tmp_215 != 0;
    assume Tmp_215 > 0;
    call {:si_unique_call 613} IoFreeMdl(0);
    goto L20;

  L20:
    i_2 := i_2 + 1;
    goto L20_dummy;

  L20_dummy:
    assume false;
    return;

  anon28_Then:
    goto L20;

  anon23_Then:
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    call {:si_unique_call 614} sdv_ExFreePool(0);
    goto L25;

  L25:
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    havoc Tmp_208;
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    assume {:nonnull} Tmp_208 != 0;
    assume Tmp_208 > 0;
    goto L29;

  L29:
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    havoc Tmp_210;
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    assume {:nonnull} Tmp_210 != 0;
    assume Tmp_210 > 0;
    assume {:nonnull} IsochDetachData_2 != 0;
    assume IsochDetachData_2 > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 615} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto L50;

  L50:
    call {:si_unique_call 616} sdv_IoCompleteRequest(0, 0);
    call {:si_unique_call 617} IoFreeIrp(0);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} IsochDetachData_2 != 0;
    call {:si_unique_call 618} sdv_ExFreePool(0);
    goto L38;

  anon26_Then:
    assume {:partition} IsochDetachData_2 == 0;
    goto L38;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon29_Then:
    goto L50;

  anon25_Then:
    goto L29;

  anon24_Then:
    goto L25;

  anon22_Then:
    goto L13;

  anon21_Then:
    goto L9;
}



procedure {:origName "t1394_IsochModifyStreamProperties"} t1394_IsochModifyStreamProperties(actual_DeviceObject_33: int, actual_Irp_30: int, actual_hResource_1: int, actual_structPtr888ChannelMask: int, actual_fulSpeed_1: int) returns (Tmp_216: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochModifyStreamProperties"} t1394_IsochModifyStreamProperties(actual_DeviceObject_33: int, actual_Irp_30: int, actual_hResource_1: int, actual_structPtr888ChannelMask: int, actual_fulSpeed_1: int) returns (Tmp_216: int)
{
  var {:scalar} ChannelMask: int;
  var {:pointer} sdv_206: int;
  var {:pointer} newIrp_9: int;
  var {:scalar} allocNewIrp_9: int;
  var {:scalar} Event_12: int;
  var {:scalar} ntStatus_24: int;
  var {:scalar} ioStatus_9: int;
  var {:pointer} deviceExtension_20: int;
  var {:pointer} pIrb_10: int;
  var {:pointer} DeviceObject_33: int;
  var {:pointer} Irp_30: int;
  var {:pointer} hResource_1: int;
  var {:pointer} structPtr888ChannelMask: int;
  var {:scalar} fulSpeed_1: int;
  var vslice_dummy_var_61: int;
  var vslice_dummy_var_123: int;
  var vslice_dummy_var_124: int;

  anon0:
    call {:si_unique_call 619} ChannelMask := __HAVOC_malloc(20);
    call {:si_unique_call 620} Event_12 := __HAVOC_malloc(156);
    call {:si_unique_call 621} ioStatus_9 := __HAVOC_malloc(12);
    DeviceObject_33 := actual_DeviceObject_33;
    Irp_30 := actual_Irp_30;
    hResource_1 := actual_hResource_1;
    structPtr888ChannelMask := actual_structPtr888ChannelMask;
    fulSpeed_1 := actual_fulSpeed_1;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} structPtr888ChannelMask != 0;
    assume structPtr888ChannelMask > 0;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} structPtr888ChannelMask != 0;
    assume structPtr888ChannelMask > 0;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} structPtr888ChannelMask != 0;
    assume structPtr888ChannelMask > 0;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} structPtr888ChannelMask != 0;
    assume structPtr888ChannelMask > 0;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} structPtr888ChannelMask != 0;
    assume structPtr888ChannelMask > 0;
    ntStatus_24 := 0;
    assume {:nonnull} DeviceObject_33 != 0;
    assume DeviceObject_33 > 0;
    havoc deviceExtension_20;
    pIrb_10 := 0;
    newIrp_9 := 0;
    allocNewIrp_9 := 0;
    assume {:nonnull} Irp_30 != 0;
    assume Irp_30 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    call {:si_unique_call 622} newIrp_9 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_9);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} newIrp_9 != 0;
    allocNewIrp_9 := 1;
    goto L16;

  L16:
    call {:si_unique_call 623} sdv_206 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_10 := sdv_206;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_10 != 0;
    call {:si_unique_call 624} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_10 != 0;
    assume pIrb_10 > 0;
    assume {:nonnull} pIrb_10 != 0;
    assume pIrb_10 > 0;
    assume {:nonnull} pIrb_10 != 0;
    assume pIrb_10 > 0;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} pIrb_10 != 0;
    assume pIrb_10 > 0;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} pIrb_10 != 0;
    assume pIrb_10 > 0;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} pIrb_10 != 0;
    assume pIrb_10 > 0;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} pIrb_10 != 0;
    assume pIrb_10 > 0;
    assume {:nonnull} ChannelMask != 0;
    assume ChannelMask > 0;
    assume {:nonnull} pIrb_10 != 0;
    assume pIrb_10 > 0;
    assume {:nonnull} pIrb_10 != 0;
    assume pIrb_10 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_9 != 0;
    call {:si_unique_call 625} KeInitializeEvent(Event_12, 0, 0);
    assume {:nonnull} deviceExtension_20 != 0;
    assume deviceExtension_20 > 0;
    havoc vslice_dummy_var_123;
    call {:si_unique_call 626} ntStatus_24 := t1394_SubmitIrpAsync(vslice_dummy_var_123, newIrp_9, pIrb_10);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} ntStatus_24 == 259;
    call {:si_unique_call 627} vslice_dummy_var_61 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_9 != 0;
    assume ioStatus_9 > 0;
    havoc ntStatus_24;
    goto L27;

  L27:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} pIrb_10 != 0;
    call {:si_unique_call 628} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} allocNewIrp_9 != 0;
    assume {:nonnull} Irp_30 != 0;
    assume Irp_30 > 0;
    assume {:nonnull} ioStatus_9 != 0;
    assume ioStatus_9 > 0;
    assume {:nonnull} Irp_30 != 0;
    assume Irp_30 > 0;
    assume {:nonnull} ioStatus_9 != 0;
    assume ioStatus_9 > 0;
    assume {:nonnull} Irp_30 != 0;
    assume Irp_30 > 0;
    assume {:nonnull} ioStatus_9 != 0;
    assume ioStatus_9 > 0;
    goto L32;

  L32:
    Tmp_216 := ntStatus_24;
    goto LM2;

  LM2:
    return;

  anon21_Then:
    assume {:partition} allocNewIrp_9 == 0;
    goto L32;

  anon20_Then:
    assume {:partition} pIrb_10 == 0;
    goto L28;

  anon22_Then:
    assume {:partition} ntStatus_24 != 259;
    goto L27;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_9 == 0;
    assume {:nonnull} deviceExtension_20 != 0;
    assume deviceExtension_20 > 0;
    havoc vslice_dummy_var_124;
    call {:si_unique_call 629} ntStatus_24 := t1394_SubmitIrpSynch(vslice_dummy_var_124, Irp_30, pIrb_10);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L27;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon24_Then:
    assume {:partition} pIrb_10 == 0;
    ntStatus_24 := -1073741670;
    goto L27;

  anon19_Then:
    assume {:partition} newIrp_9 == 0;
    ntStatus_24 := -1073741670;
    goto L27;

  anon23_Then:
    goto L16;
}



procedure {:origName "_sdv_init1"} _sdv_init1();
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "_sdv_init1"} _sdv_init1()
{
  var vslice_dummy_var_62: int;

  anon0:
    call {:si_unique_call 630} vslice_dummy_var_62 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "t1394_IsochAllocateBandwidth"} t1394_IsochAllocateBandwidth(actual_DeviceObject_34: int, actual_Irp_31: int, actual_nMaxBytesPerFrameRequested: int, actual_fulSpeed_2: int, actual_phBandwidth: int, actual_pBytesPerFrameAvailable_1: int, actual_pSpeedSelected: int) returns (Tmp_220: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochAllocateBandwidth"} t1394_IsochAllocateBandwidth(actual_DeviceObject_34: int, actual_Irp_31: int, actual_nMaxBytesPerFrameRequested: int, actual_fulSpeed_2: int, actual_phBandwidth: int, actual_pBytesPerFrameAvailable_1: int, actual_pSpeedSelected: int) returns (Tmp_220: int)
{
  var {:pointer} sdv_211: int;
  var {:pointer} newIrp_10: int;
  var {:scalar} allocNewIrp_10: int;
  var {:scalar} Event_13: int;
  var {:scalar} ntStatus_25: int;
  var {:scalar} ioStatus_10: int;
  var {:pointer} deviceExtension_21: int;
  var {:pointer} pIrb_11: int;
  var {:pointer} DeviceObject_34: int;
  var {:pointer} Irp_31: int;
  var {:scalar} nMaxBytesPerFrameRequested: int;
  var {:scalar} fulSpeed_2: int;
  var {:pointer} phBandwidth: int;
  var {:pointer} pBytesPerFrameAvailable_1: int;
  var {:pointer} pSpeedSelected: int;
  var vslice_dummy_var_63: int;
  var vslice_dummy_var_125: int;
  var vslice_dummy_var_126: int;

  anon0:
    call {:si_unique_call 631} Event_13 := __HAVOC_malloc(156);
    call {:si_unique_call 632} ioStatus_10 := __HAVOC_malloc(12);
    DeviceObject_34 := actual_DeviceObject_34;
    Irp_31 := actual_Irp_31;
    nMaxBytesPerFrameRequested := actual_nMaxBytesPerFrameRequested;
    fulSpeed_2 := actual_fulSpeed_2;
    phBandwidth := actual_phBandwidth;
    pBytesPerFrameAvailable_1 := actual_pBytesPerFrameAvailable_1;
    pSpeedSelected := actual_pSpeedSelected;
    ntStatus_25 := 0;
    assume {:nonnull} DeviceObject_34 != 0;
    assume DeviceObject_34 > 0;
    havoc deviceExtension_21;
    pIrb_11 := 0;
    newIrp_10 := 0;
    allocNewIrp_10 := 0;
    assume {:nonnull} Irp_31 != 0;
    assume Irp_31 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    call {:si_unique_call 633} newIrp_10 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_10);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} newIrp_10 != 0;
    allocNewIrp_10 := 1;
    goto L16;

  L16:
    call {:si_unique_call 634} sdv_211 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_11 := sdv_211;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} pIrb_11 != 0;
    call {:si_unique_call 635} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_11 != 0;
    assume pIrb_11 > 0;
    assume {:nonnull} pIrb_11 != 0;
    assume pIrb_11 > 0;
    assume {:nonnull} pIrb_11 != 0;
    assume pIrb_11 > 0;
    assume {:nonnull} pIrb_11 != 0;
    assume pIrb_11 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} allocNewIrp_10 != 0;
    call {:si_unique_call 636} KeInitializeEvent(Event_13, 0, 0);
    assume {:nonnull} deviceExtension_21 != 0;
    assume deviceExtension_21 > 0;
    havoc vslice_dummy_var_125;
    call {:si_unique_call 637} ntStatus_25 := t1394_SubmitIrpAsync(vslice_dummy_var_125, newIrp_10, pIrb_11);
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} yogi_error != 1;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} ntStatus_25 == 259;
    call {:si_unique_call 638} vslice_dummy_var_63 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_10 != 0;
    assume ioStatus_10 > 0;
    havoc ntStatus_25;
    goto L56;

  L56:
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} ntStatus_25 >= 0;
    assume {:nonnull} pIrb_11 != 0;
    assume pIrb_11 > 0;
    assume {:nonnull} phBandwidth != 0;
    assume phBandwidth > 0;
    assume {:nonnull} pBytesPerFrameAvailable_1 != 0;
    assume pBytesPerFrameAvailable_1 > 0;
    assume {:nonnull} pIrb_11 != 0;
    assume pIrb_11 > 0;
    assume {:nonnull} pIrb_11 != 0;
    assume pIrb_11 > 0;
    assume {:nonnull} pSpeedSelected != 0;
    assume pSpeedSelected > 0;
    goto L27;

  L27:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} pIrb_11 != 0;
    call {:si_unique_call 639} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} allocNewIrp_10 != 0;
    assume {:nonnull} Irp_31 != 0;
    assume Irp_31 > 0;
    assume {:nonnull} ioStatus_10 != 0;
    assume ioStatus_10 > 0;
    assume {:nonnull} Irp_31 != 0;
    assume Irp_31 > 0;
    assume {:nonnull} ioStatus_10 != 0;
    assume ioStatus_10 > 0;
    assume {:nonnull} Irp_31 != 0;
    assume Irp_31 > 0;
    assume {:nonnull} ioStatus_10 != 0;
    assume ioStatus_10 > 0;
    goto L32;

  L32:
    Tmp_220 := ntStatus_25;
    goto LM2;

  LM2:
    return;

  anon23_Then:
    assume {:partition} allocNewIrp_10 == 0;
    goto L32;

  anon22_Then:
    assume {:partition} pIrb_11 == 0;
    goto L28;

  anon25_Then:
    assume {:partition} 0 > ntStatus_25;
    goto L27;

  anon24_Then:
    assume {:partition} ntStatus_25 != 259;
    goto L56;

  anon29_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon28_Then:
    assume {:partition} allocNewIrp_10 == 0;
    assume {:nonnull} deviceExtension_21 != 0;
    assume deviceExtension_21 > 0;
    havoc vslice_dummy_var_126;
    call {:si_unique_call 640} ntStatus_25 := t1394_SubmitIrpSynch(vslice_dummy_var_126, Irp_31, pIrb_11);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto L56;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon27_Then:
    assume {:partition} pIrb_11 == 0;
    ntStatus_25 := -1073741670;
    goto L27;

  anon21_Then:
    assume {:partition} newIrp_10 == 0;
    ntStatus_25 := -1073741670;
    goto L27;

  anon26_Then:
    goto L16;
}



procedure {:origName "t1394_IsochQueryCurrentCycleTime"} t1394_IsochQueryCurrentCycleTime(actual_DeviceObject_35: int, actual_Irp_32: int, actual_pCurrentCycleTime: int) returns (Tmp_222: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochQueryCurrentCycleTime"} t1394_IsochQueryCurrentCycleTime(actual_DeviceObject_35: int, actual_Irp_32: int, actual_pCurrentCycleTime: int) returns (Tmp_222: int)
{
  var {:pointer} sdv_216: int;
  var {:pointer} newIrp_11: int;
  var {:scalar} allocNewIrp_11: int;
  var {:scalar} Event_14: int;
  var {:scalar} ntStatus_26: int;
  var {:scalar} ioStatus_11: int;
  var {:pointer} deviceExtension_22: int;
  var {:pointer} pIrb_12: int;
  var {:pointer} DeviceObject_35: int;
  var {:pointer} Irp_32: int;
  var {:pointer} pCurrentCycleTime: int;
  var vslice_dummy_var_64: int;
  var vslice_dummy_var_127: int;
  var vslice_dummy_var_128: int;

  anon0:
    call {:si_unique_call 641} Event_14 := __HAVOC_malloc(156);
    call {:si_unique_call 642} ioStatus_11 := __HAVOC_malloc(12);
    DeviceObject_35 := actual_DeviceObject_35;
    Irp_32 := actual_Irp_32;
    pCurrentCycleTime := actual_pCurrentCycleTime;
    ntStatus_26 := 0;
    assume {:nonnull} DeviceObject_35 != 0;
    assume DeviceObject_35 > 0;
    havoc deviceExtension_22;
    pIrb_12 := 0;
    newIrp_11 := 0;
    allocNewIrp_11 := 0;
    assume {:nonnull} Irp_32 != 0;
    assume Irp_32 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    call {:si_unique_call 643} newIrp_11 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_11);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} newIrp_11 != 0;
    allocNewIrp_11 := 1;
    goto L16;

  L16:
    call {:si_unique_call 644} sdv_216 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_12 := sdv_216;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} pIrb_12 != 0;
    call {:si_unique_call 645} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_12 != 0;
    assume pIrb_12 > 0;
    assume {:nonnull} pIrb_12 != 0;
    assume pIrb_12 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} allocNewIrp_11 != 0;
    call {:si_unique_call 646} KeInitializeEvent(Event_14, 0, 0);
    assume {:nonnull} deviceExtension_22 != 0;
    assume deviceExtension_22 > 0;
    havoc vslice_dummy_var_127;
    call {:si_unique_call 647} ntStatus_26 := t1394_SubmitIrpAsync(vslice_dummy_var_127, newIrp_11, pIrb_12);
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} yogi_error != 1;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} ntStatus_26 == 259;
    call {:si_unique_call 648} vslice_dummy_var_64 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_11 != 0;
    assume ioStatus_11 > 0;
    havoc ntStatus_26;
    goto L54;

  L54:
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} ntStatus_26 >= 0;
    assume {:nonnull} pCurrentCycleTime != 0;
    assume pCurrentCycleTime > 0;
    assume {:nonnull} pIrb_12 != 0;
    assume pIrb_12 > 0;
    assume {:nonnull} pCurrentCycleTime != 0;
    assume pCurrentCycleTime > 0;
    assume {:nonnull} pIrb_12 != 0;
    assume pIrb_12 > 0;
    assume {:nonnull} pCurrentCycleTime != 0;
    assume pCurrentCycleTime > 0;
    assume {:nonnull} pIrb_12 != 0;
    assume pIrb_12 > 0;
    goto L27;

  L27:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} pIrb_12 != 0;
    call {:si_unique_call 649} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} allocNewIrp_11 != 0;
    assume {:nonnull} Irp_32 != 0;
    assume Irp_32 > 0;
    assume {:nonnull} ioStatus_11 != 0;
    assume ioStatus_11 > 0;
    assume {:nonnull} Irp_32 != 0;
    assume Irp_32 > 0;
    assume {:nonnull} ioStatus_11 != 0;
    assume ioStatus_11 > 0;
    assume {:nonnull} Irp_32 != 0;
    assume Irp_32 > 0;
    assume {:nonnull} ioStatus_11 != 0;
    assume ioStatus_11 > 0;
    goto L32;

  L32:
    Tmp_222 := ntStatus_26;
    goto LM2;

  LM2:
    return;

  anon23_Then:
    assume {:partition} allocNewIrp_11 == 0;
    goto L32;

  anon22_Then:
    assume {:partition} pIrb_12 == 0;
    goto L28;

  anon25_Then:
    assume {:partition} 0 > ntStatus_26;
    goto L27;

  anon24_Then:
    assume {:partition} ntStatus_26 != 259;
    goto L54;

  anon29_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon28_Then:
    assume {:partition} allocNewIrp_11 == 0;
    assume {:nonnull} deviceExtension_22 != 0;
    assume deviceExtension_22 > 0;
    havoc vslice_dummy_var_128;
    call {:si_unique_call 650} ntStatus_26 := t1394_SubmitIrpSynch(vslice_dummy_var_128, Irp_32, pIrb_12);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto L54;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon27_Then:
    assume {:partition} pIrb_12 == 0;
    ntStatus_26 := -1073741670;
    goto L27;

  anon21_Then:
    assume {:partition} newIrp_11 == 0;
    ntStatus_26 := -1073741670;
    goto L27;

  anon26_Then:
    goto L16;
}



procedure {:origName "t1394_IsochAttachBuffers"} t1394_IsochAttachBuffers(actual_DeviceObject_36: int, actual_Irp_33: int, actual_outputBufferLength_1: int, actual_hResource_2: int, actual_nNumberOfDescriptors: int, actual_pIsochDescriptor: int, actual_R3: int) returns (Tmp_224: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochAttachBuffers"} t1394_IsochAttachBuffers(actual_DeviceObject_36: int, actual_Irp_33: int, actual_outputBufferLength_1: int, actual_hResource_2: int, actual_nNumberOfDescriptors: int, actual_pIsochDescriptor: int, actual_R3: int) returns (Tmp_224: int)
{
  var {:scalar} i_3: int;
  var {:scalar} Tmp_226: int;
  var {:pointer} pR3TempDescriptor: int;
  var {:scalar} Tmp_228: int;
  var {:scalar} Tmp_229: int;
  var {:pointer} Tmp_230: int;
  var {:scalar} Tmp_231: int;
  var {:scalar} j: int;
  var {:scalar} Tmp_232: int;
  var {:scalar} Tmp_233: int;
  var {:scalar} Tmp_234: int;
  var {:pointer} sdv_222: int;
  var {:pointer} newIrp_12: int;
  var {:scalar} Tmp_235: int;
  var {:scalar} Tmp_237: int;
  var {:scalar} Tmp_238: int;
  var {:scalar} Tmp_239: int;
  var {:scalar} Tmp_240: int;
  var {:scalar} StackSize_2: int;
  var {:pointer} Tmp_241: int;
  var {:pointer} sdv_225: int;
  var {:scalar} ntStatus_27: int;
  var {:pointer} NextIrpStack_1: int;
  var {:scalar} deltaTime: int;
  var {:pointer} sdv_226: int;
  var {:pointer} pIsochDetachData: int;
  var {:scalar} Tmp_242: int;
  var {:pointer} sdv_227: int;
  var {:scalar} sdv_228: int;
  var {:scalar} Tmp_243: int;
  var {:scalar} Tmp_244: int;
  var {:scalar} Tmp_245: int;
  var {:scalar} Tmp_246: int;
  var {:scalar} Tmp_247: int;
  var {:scalar} Irql_5: int;
  var {:scalar} Tmp_248: int;
  var {:pointer} deviceExtension_23: int;
  var {:scalar} Tmp_249: int;
  var {:pointer} pIrb_13: int;
  var {:scalar} Tmp_251: int;
  var {:scalar} Tmp_252: int;
  var {:scalar} Tmp_253: int;
  var {:pointer} DeviceObject_36: int;
  var {:pointer} Irp_33: int;
  var {:scalar} outputBufferLength_1: int;
  var {:pointer} hResource_2: int;
  var {:scalar} nNumberOfDescriptors: int;
  var {:pointer} pIsochDescriptor: int;
  var {:pointer} R3: int;
  var vslice_dummy_var_65: int;
  var vslice_dummy_var_66: int;
  var vslice_dummy_var_129: int;
  var vslice_dummy_var_130: int;

  anon0:
    call {:si_unique_call 651} deltaTime := __HAVOC_malloc(20);
    DeviceObject_36 := actual_DeviceObject_36;
    Irp_33 := actual_Irp_33;
    outputBufferLength_1 := actual_outputBufferLength_1;
    hResource_2 := actual_hResource_2;
    nNumberOfDescriptors := actual_nNumberOfDescriptors;
    pIsochDescriptor := actual_pIsochDescriptor;
    R3 := actual_R3;
    ntStatus_27 := 0;
    assume {:nonnull} DeviceObject_36 != 0;
    assume DeviceObject_36 > 0;
    havoc deviceExtension_23;
    pIsochDetachData := 0;
    pR3TempDescriptor := 0;
    NextIrpStack_1 := 0;
    newIrp_12 := 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} nNumberOfDescriptors != 0;
    assume {:nonnull} deviceExtension_23 != 0;
    assume deviceExtension_23 > 0;
    havoc Tmp_230;
    assume {:nonnull} Tmp_230 != 0;
    assume Tmp_230 > 0;
    havoc StackSize_2;
    call {:si_unique_call 652} newIrp_12 := IoAllocateIrp(StackSize_2, 0);
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} newIrp_12 != 0;
    call {:si_unique_call 653} sdv_225 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_13 := sdv_225;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} pIrb_13 != 0;
    Tmp_231 := 172 * nNumberOfDescriptors;
    call {:si_unique_call 654} sdv_226 := ExAllocatePoolWithTag(512, Tmp_231, -164023503);
    pIsochDescriptor := sdv_226;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} pIsochDescriptor != 0;
    pR3TempDescriptor := R3;
    i_3 := 0;
    goto L45;

  L45:
    call {:si_unique_call 655} i_3, Tmp_226, pR3TempDescriptor, Tmp_228, Tmp_229, Tmp_233, Tmp_234, sdv_222, Tmp_235, Tmp_237, Tmp_238, Tmp_240, Tmp_241, pIsochDetachData, sdv_227, sdv_228, Tmp_243, Tmp_244, Tmp_245, Tmp_246, Tmp_247, Irql_5, Tmp_248, Tmp_249, Tmp_251, Tmp_253, vslice_dummy_var_66 := t1394_IsochAttachBuffers_loop_L45(i_3, Tmp_226, pR3TempDescriptor, Tmp_228, Tmp_229, Tmp_233, Tmp_234, sdv_222, newIrp_12, Tmp_235, Tmp_237, Tmp_238, Tmp_240, Tmp_241, deltaTime, pIsochDetachData, sdv_227, sdv_228, Tmp_243, Tmp_244, Tmp_245, Tmp_246, Tmp_247, Irql_5, Tmp_248, deviceExtension_23, Tmp_249, pIrb_13, Tmp_251, Tmp_253, Irp_33, outputBufferLength_1, hResource_2, nNumberOfDescriptors, pIsochDescriptor, vslice_dummy_var_66);
    goto L45_last;

  L45_last:
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} nNumberOfDescriptors > i_3;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    havoc vslice_dummy_var_129;
    call {:si_unique_call 656} sdv_227 := IoAllocateMdl(0, vslice_dummy_var_129, 0, 0, 0);
    Tmp_243 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    Tmp_247 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    Tmp_248 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    Tmp_253 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    call {:si_unique_call 657} sdv_228 := sdv_MmGetMdlByteCount(0);
    Tmp_244 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    goto L64;

  L64:
    Tmp_245 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    Tmp_240 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    Tmp_246 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    Tmp_238 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    Tmp_226 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} i_3 != nNumberOfDescriptors - 1;
    Tmp_237 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    goto L76;

  L76:
    Tmp_235 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    havoc pR3TempDescriptor;
    i_3 := i_3 + 1;
    goto L76_dummy;

  L76_dummy:
    assume false;
    return;

  anon40_Then:
    assume {:partition} i_3 == nNumberOfDescriptors - 1;
    call {:si_unique_call 658} sdv_222 := ExAllocatePoolWithTag(512, 128, -164023503);
    pIsochDetachData := sdv_222;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} pIsochDetachData != 0;
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    call {:si_unique_call 659} Tmp_241 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_241 != 0;
    assume Tmp_241 > 0;
    call {:si_unique_call 660} sdv_KeAcquireSpinLock(0, Tmp_241);
    assume {:nonnull} Tmp_241 != 0;
    assume Tmp_241 > 0;
    havoc Irql_5;
    assume {:nonnull} deviceExtension_23 != 0;
    assume deviceExtension_23 > 0;
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    call {:si_unique_call 661} InsertHeadList(IsochDetachData__DEVICE_EXTENSION(deviceExtension_23), IsochDetachList__ISOCH_DETACH_DATA(pIsochDetachData));
    call {:si_unique_call 662} sdv_KeReleaseSpinLock(0, Irql_5);
    call {:si_unique_call 663} KeInitializeTimer(0);
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    call {:si_unique_call 664} KeInitializeDpc(TimerDpc__ISOCH_DETACH_DATA(pIsochDetachData), li2bplFunctionConstant203, 0);
    assume {:nonnull} deltaTime != 0;
    assume deltaTime > 0;
    assume {:nonnull} deltaTime != 0;
    assume deltaTime > 0;
    call {:si_unique_call 665} vslice_dummy_var_66 := KeSetTimer(0, deltaTime, 0);
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    assume {:nonnull} pIsochDetachData != 0;
    assume pIsochDetachData > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    Tmp_233 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    Tmp_251 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    Tmp_234 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    goto L76;

  anon48_Then:
    assume {:partition} pIsochDetachData == 0;
    j := 0;
    goto L113;

  L113:
    call {:si_unique_call 666} j, Tmp_232, Tmp_239 := t1394_IsochAttachBuffers_loop_L113(i_3, j, Tmp_232, Tmp_239, pIsochDescriptor);
    goto L113_last;

  L113_last:
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} i_3 > j;
    Tmp_239 := j;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    Tmp_232 := j;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    call {:si_unique_call 667} IoFreeMdl(0);
    goto L118;

  L118:
    j := j + 1;
    goto L118_dummy;

  L118_dummy:
    assume false;
    return;

  anon49_Then:
    goto L118;

  anon41_Then:
    assume {:partition} j >= i_3;
    call {:si_unique_call 668} sdv_ExFreePool(0);
    ntStatus_27 := -1073741670;
    goto L125;

  L125:
    Tmp_224 := ntStatus_27;
    goto LM2;

  LM2:
    return;

  anon47_Then:
    Tmp_249 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    goto L76;

  anon46_Then:
    j := 0;
    goto L126;

  L126:
    call {:si_unique_call 669} j, Tmp_242, Tmp_252 := t1394_IsochAttachBuffers_loop_L126(i_3, j, Tmp_242, Tmp_252, pIsochDescriptor);
    goto L126_last;

  L126_last:
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} i_3 > j;
    Tmp_252 := j;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    Tmp_242 := j;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    call {:si_unique_call 670} IoFreeMdl(0);
    goto L131;

  L131:
    j := j + 1;
    goto L131_dummy;

  L131_dummy:
    assume false;
    return;

  anon50_Then:
    goto L131;

  anon42_Then:
    assume {:partition} j >= i_3;
    call {:si_unique_call 671} sdv_ExFreePool(0);
    ntStatus_27 := -1073741811;
    goto L125;

  anon39_Then:
    Tmp_229 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    Tmp_228 := i_3;
    assume {:nonnull} pIsochDescriptor != 0;
    assume pIsochDescriptor > 0;
    assume {:nonnull} pR3TempDescriptor != 0;
    assume pR3TempDescriptor > 0;
    goto L64;

  anon37_Then:
    assume {:partition} i_3 >= nNumberOfDescriptors;
    assume {:nonnull} deviceExtension_23 != 0;
    assume deviceExtension_23 > 0;
    goto anon38_Then, anon38_Else;

  anon38_Else:
    ntStatus_27 := -1073741810;
    goto L125;

  anon38_Then:
    call {:si_unique_call 672} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_13 != 0;
    assume pIrb_13 > 0;
    assume {:nonnull} pIrb_13 != 0;
    assume pIrb_13 > 0;
    assume {:nonnull} pIrb_13 != 0;
    assume pIrb_13 > 0;
    assume {:nonnull} pIrb_13 != 0;
    assume pIrb_13 > 0;
    assume {:nonnull} pIrb_13 != 0;
    assume pIrb_13 > 0;
    call {:si_unique_call 673} sdv_IoMarkIrpPending(0);
    call {:si_unique_call 674} NextIrpStack_1 := sdv_IoGetNextIrpStackLocation(newIrp_12);
    assume {:nonnull} NextIrpStack_1 != 0;
    assume NextIrpStack_1 > 0;
    assume {:nonnull} NextIrpStack_1 != 0;
    assume NextIrpStack_1 > 0;
    assume {:nonnull} NextIrpStack_1 != 0;
    assume NextIrpStack_1 > 0;
    call {:si_unique_call 675} sdv_IoSetCompletionRoutine(newIrp_12, li2bplFunctionConstant205, pIsochDetachData, 1, 1, 1);
    assume {:nonnull} deviceExtension_23 != 0;
    assume deviceExtension_23 > 0;
    havoc vslice_dummy_var_130;
    call {:si_unique_call 676} vslice_dummy_var_65 := sdv_IoCallDriver(vslice_dummy_var_130, newIrp_12);
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} yogi_error != 1;
    ntStatus_27 := 259;
    goto L125;

  anon51_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon45_Then:
    assume {:partition} pIsochDescriptor == 0;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} pIrb_13 != 0;
    call {:si_unique_call 677} sdv_ExFreePool(0);
    goto L166;

  L166:
    ntStatus_27 := -1073741670;
    goto L125;

  anon36_Then:
    assume {:partition} pIrb_13 == 0;
    goto L166;

  anon44_Then:
    assume {:partition} pIrb_13 == 0;
    ntStatus_27 := -1073741670;
    goto L125;

  anon35_Then:
    assume {:partition} newIrp_12 == 0;
    ntStatus_27 := -1073741670;
    goto L125;

  anon43_Then:
    assume {:partition} nNumberOfDescriptors == 0;
    ntStatus_27 := -1073741811;
    goto L125;
}



procedure {:origName "InsertHeadList"} InsertHeadList(actual_ListHead_1: int, actual_Entry_1: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "InsertHeadList"} InsertHeadList(actual_ListHead_1: int, actual_Entry_1: int)
{
  var {:pointer} NextEntry: int;
  var {:pointer} ListHead_1: int;
  var {:pointer} Entry_1: int;
  var vslice_dummy_var_67: int;
  var vslice_dummy_var_131: int;

  anon0:
    call {:si_unique_call 678} vslice_dummy_var_67 := __HAVOC_malloc(4);
    ListHead_1 := actual_ListHead_1;
    Entry_1 := actual_Entry_1;
    assume {:nonnull} ListHead_1 != 0;
    assume ListHead_1 > 0;
    havoc NextEntry;
    assume {:nonnull} Entry_1 != 0;
    assume Entry_1 > 0;
    assume {:nonnull} Entry_1 != 0;
    assume Entry_1 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} NextEntry != 0;
    assume NextEntry > 0;
    havoc vslice_dummy_var_131;
    call {:si_unique_call 679} FatalListEntryError(ListHead_1, NextEntry, vslice_dummy_var_131);
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



procedure {:origName "t1394_IsochDetachBuffers"} t1394_IsochDetachBuffers(actual_DeviceObject_37: int, actual_Irp_34: int, actual_hResource_3: int, actual_nNumberOfDescriptors_1: int, actual_IsochDescriptor: int) returns (Tmp_256: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochDetachBuffers"} t1394_IsochDetachBuffers(actual_DeviceObject_37: int, actual_Irp_34: int, actual_hResource_3: int, actual_nNumberOfDescriptors_1: int, actual_IsochDescriptor: int) returns (Tmp_256: int)
{
  var {:scalar} i_4: int;
  var {:scalar} Tmp_257: int;
  var {:pointer} sdv_230: int;
  var {:pointer} newIrp_13: int;
  var {:scalar} Tmp_259: int;
  var {:scalar} allocNewIrp_12: int;
  var {:scalar} Event_15: int;
  var {:scalar} ntStatus_28: int;
  var {:scalar} ioStatus_12: int;
  var {:pointer} deviceExtension_24: int;
  var {:pointer} pIrb_14: int;
  var {:pointer} DeviceObject_37: int;
  var {:pointer} Irp_34: int;
  var {:pointer} hResource_3: int;
  var {:scalar} nNumberOfDescriptors_1: int;
  var {:pointer} IsochDescriptor: int;
  var vslice_dummy_var_68: int;
  var vslice_dummy_var_132: int;
  var vslice_dummy_var_133: int;

  anon0:
    call {:si_unique_call 680} Event_15 := __HAVOC_malloc(156);
    call {:si_unique_call 681} ioStatus_12 := __HAVOC_malloc(12);
    DeviceObject_37 := actual_DeviceObject_37;
    Irp_34 := actual_Irp_34;
    hResource_3 := actual_hResource_3;
    nNumberOfDescriptors_1 := actual_nNumberOfDescriptors_1;
    IsochDescriptor := actual_IsochDescriptor;
    ntStatus_28 := 0;
    assume {:nonnull} DeviceObject_37 != 0;
    assume DeviceObject_37 > 0;
    havoc deviceExtension_24;
    pIrb_14 := 0;
    newIrp_13 := 0;
    allocNewIrp_12 := 0;
    assume {:nonnull} Irp_34 != 0;
    assume Irp_34 > 0;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    call {:si_unique_call 682} newIrp_13 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_12);
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} newIrp_13 != 0;
    allocNewIrp_12 := 1;
    goto L17;

  L17:
    call {:si_unique_call 683} sdv_230 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_14 := sdv_230;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} pIrb_14 != 0;
    call {:si_unique_call 684} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_14 != 0;
    assume pIrb_14 > 0;
    assume {:nonnull} pIrb_14 != 0;
    assume pIrb_14 > 0;
    assume {:nonnull} pIrb_14 != 0;
    assume pIrb_14 > 0;
    assume {:nonnull} pIrb_14 != 0;
    assume pIrb_14 > 0;
    assume {:nonnull} pIrb_14 != 0;
    assume pIrb_14 > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} allocNewIrp_12 != 0;
    call {:si_unique_call 685} KeInitializeEvent(Event_15, 0, 0);
    assume {:nonnull} deviceExtension_24 != 0;
    assume deviceExtension_24 > 0;
    havoc vslice_dummy_var_132;
    call {:si_unique_call 686} ntStatus_28 := t1394_SubmitIrpAsync(vslice_dummy_var_132, newIrp_13, pIrb_14);
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} yogi_error != 1;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} ntStatus_28 == 259;
    call {:si_unique_call 687} vslice_dummy_var_68 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_12 != 0;
    assume ioStatus_12 > 0;
    havoc ntStatus_28;
    goto L58;

  L58:
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} ntStatus_28 >= 0;
    i_4 := 0;
    goto L64;

  L64:
    call {:si_unique_call 688} i_4, Tmp_257, Tmp_259 := t1394_IsochDetachBuffers_loop_L64(i_4, Tmp_257, Tmp_259, nNumberOfDescriptors_1, IsochDescriptor);
    goto L64_last;

  L64_last:
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} nNumberOfDescriptors_1 > i_4;
    Tmp_257 := i_4;
    assume {:nonnull} IsochDescriptor != 0;
    assume IsochDescriptor > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    Tmp_259 := i_4;
    assume {:nonnull} IsochDescriptor != 0;
    assume IsochDescriptor > 0;
    call {:si_unique_call 689} IoFreeMdl(0);
    goto L69;

  L69:
    i_4 := i_4 + 1;
    goto L69_dummy;

  L69_dummy:
    assume false;
    return;

  anon35_Then:
    goto L69;

  anon30_Then:
    assume {:partition} i_4 >= nNumberOfDescriptors_1;
    call {:si_unique_call 690} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} pIrb_14 != 0;
    call {:si_unique_call 691} sdv_ExFreePool(0);
    goto L29;

  L29:
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} allocNewIrp_12 != 0;
    assume {:nonnull} Irp_34 != 0;
    assume Irp_34 > 0;
    assume {:nonnull} ioStatus_12 != 0;
    assume ioStatus_12 > 0;
    assume {:nonnull} Irp_34 != 0;
    assume Irp_34 > 0;
    assume {:nonnull} ioStatus_12 != 0;
    assume ioStatus_12 > 0;
    assume {:nonnull} Irp_34 != 0;
    assume Irp_34 > 0;
    assume {:nonnull} ioStatus_12 != 0;
    assume ioStatus_12 > 0;
    goto L33;

  L33:
    Tmp_256 := ntStatus_28;
    goto LM2;

  LM2:
    return;

  anon27_Then:
    assume {:partition} allocNewIrp_12 == 0;
    goto L33;

  anon26_Then:
    assume {:partition} pIrb_14 == 0;
    goto L29;

  anon29_Then:
    assume {:partition} 0 > ntStatus_28;
    goto L28;

  anon28_Then:
    assume {:partition} ntStatus_28 != 259;
    goto L58;

  anon34_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon33_Then:
    assume {:partition} allocNewIrp_12 == 0;
    assume {:nonnull} deviceExtension_24 != 0;
    assume deviceExtension_24 > 0;
    havoc vslice_dummy_var_133;
    call {:si_unique_call 692} ntStatus_28 := t1394_SubmitIrpSynch(vslice_dummy_var_133, Irp_34, pIrb_14);
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} yogi_error != 1;
    goto L58;

  anon36_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon32_Then:
    assume {:partition} pIrb_14 == 0;
    ntStatus_28 := -1073741670;
    goto L28;

  anon25_Then:
    assume {:partition} newIrp_13 == 0;
    ntStatus_28 := -1073741670;
    goto L28;

  anon31_Then:
    goto L17;
}



procedure {:origName "t1394_AsyncWrite"} t1394_AsyncWrite(actual_DeviceObject_38: int, actual_Irp_35: int, actual_bRawMode_1: int, actual_bGetGeneration_1: int, actual_SD1_2: int, actual_nNumberOfBytesToWrite: int, actual_nBlockSize_1: int, actual_fulFlags_5: int, actual_ulGeneration_1: int, actual_Data_3: int) returns (Tmp_261: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_AsyncWrite"} t1394_AsyncWrite(actual_DeviceObject_38: int, actual_Irp_35: int, actual_bRawMode_1: int, actual_bGetGeneration_1: int, actual_SD1_2: int, actual_nNumberOfBytesToWrite: int, actual_nBlockSize_1: int, actual_fulFlags_5: int, actual_ulGeneration_1: int, actual_Data_3: int) returns (Tmp_261: int)
{
  var {:scalar} DestinationAddress_1: int;
  var {:pointer} NextDeviceObject_1: int;
  var {:pointer} sdv_235: int;
  var {:pointer} newIrp_14: int;
  var {:scalar} allocNewIrp_13: int;
  var {:scalar} Event_16: int;
  var {:scalar} ntStatus_29: int;
  var {:scalar} ioStatus_13: int;
  var {:pointer} deviceExtension_25: int;
  var {:pointer} pIrb_15: int;
  var {:pointer} pMdl_2: int;
  var {:pointer} DeviceObject_38: int;
  var {:pointer} Irp_35: int;
  var {:scalar} bRawMode_1: int;
  var {:scalar} bGetGeneration_1: int;
  var {:pointer} SD1_2: int;
  var {:scalar} nNumberOfBytesToWrite: int;
  var {:scalar} nBlockSize_1: int;
  var {:scalar} fulFlags_5: int;
  var {:scalar} ulGeneration_1: int;
  var vslice_dummy_var_69: int;

  anon0:
    call {:si_unique_call 693} DestinationAddress_1 := __HAVOC_malloc(16);
    call {:si_unique_call 694} Event_16 := __HAVOC_malloc(156);
    call {:si_unique_call 695} ioStatus_13 := __HAVOC_malloc(12);
    DeviceObject_38 := actual_DeviceObject_38;
    Irp_35 := actual_Irp_35;
    bRawMode_1 := actual_bRawMode_1;
    bGetGeneration_1 := actual_bGetGeneration_1;
    SD1_2 := actual_SD1_2;
    nNumberOfBytesToWrite := actual_nNumberOfBytesToWrite;
    nBlockSize_1 := actual_nBlockSize_1;
    fulFlags_5 := actual_fulFlags_5;
    ulGeneration_1 := actual_ulGeneration_1;
    assume {:nonnull} DestinationAddress_1 != 0;
    assume DestinationAddress_1 > 0;
    assume {:nonnull} SD1_2 != 0;
    assume SD1_2 > 0;
    assume {:nonnull} DestinationAddress_1 != 0;
    assume DestinationAddress_1 > 0;
    assume {:nonnull} SD1_2 != 0;
    assume SD1_2 > 0;
    assume {:nonnull} DestinationAddress_1 != 0;
    assume DestinationAddress_1 > 0;
    assume {:nonnull} SD1_2 != 0;
    assume SD1_2 > 0;
    assume {:nonnull} DestinationAddress_1 != 0;
    assume DestinationAddress_1 > 0;
    assume {:nonnull} SD1_2 != 0;
    assume SD1_2 > 0;
    ntStatus_29 := 0;
    assume {:nonnull} DeviceObject_38 != 0;
    assume DeviceObject_38 > 0;
    havoc deviceExtension_25;
    pIrb_15 := 0;
    pMdl_2 := 0;
    NextDeviceObject_1 := 0;
    newIrp_14 := 0;
    allocNewIrp_13 := 0;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} nNumberOfBytesToWrite != 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} bRawMode_1 != 0;
    assume {:nonnull} deviceExtension_25 != 0;
    assume deviceExtension_25 > 0;
    havoc NextDeviceObject_1;
    goto L24;

  L24:
    assume {:nonnull} Irp_35 != 0;
    assume Irp_35 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    call {:si_unique_call 696} newIrp_14 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_13);
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} newIrp_14 != 0;
    allocNewIrp_13 := 1;
    goto L25;

  L25:
    call {:si_unique_call 697} sdv_235 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_15 := sdv_235;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} pIrb_15 != 0;
    call {:si_unique_call 698} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    assume {:nonnull} DestinationAddress_1 != 0;
    assume DestinationAddress_1 > 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    assume {:nonnull} DestinationAddress_1 != 0;
    assume DestinationAddress_1 > 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    assume {:nonnull} DestinationAddress_1 != 0;
    assume DestinationAddress_1 > 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    assume {:nonnull} DestinationAddress_1 != 0;
    assume DestinationAddress_1 > 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} bGetGeneration_1 != 0;
    assume {:nonnull} deviceExtension_25 != 0;
    assume deviceExtension_25 > 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    goto L62;

  L62:
    call {:si_unique_call 699} pMdl_2 := IoAllocateMdl(0, nNumberOfBytesToWrite, 0, 0, 0);
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} allocNewIrp_13 != 0;
    call {:si_unique_call 700} KeInitializeEvent(Event_16, 0, 0);
    call {:si_unique_call 701} ntStatus_29 := t1394_SubmitIrpAsync(NextDeviceObject_1, newIrp_14, pIrb_15);
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} yogi_error != 1;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} ntStatus_29 == 259;
    call {:si_unique_call 702} vslice_dummy_var_69 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_13 != 0;
    assume ioStatus_13 > 0;
    havoc ntStatus_29;
    goto L82;

  L82:
    goto L36;

  L36:
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} pMdl_2 != 0;
    call {:si_unique_call 703} IoFreeMdl(0);
    goto L37;

  L37:
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} pIrb_15 != 0;
    call {:si_unique_call 704} sdv_ExFreePool(0);
    goto L41;

  L41:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} allocNewIrp_13 != 0;
    assume {:nonnull} Irp_35 != 0;
    assume Irp_35 > 0;
    assume {:nonnull} ioStatus_13 != 0;
    assume ioStatus_13 > 0;
    assume {:nonnull} Irp_35 != 0;
    assume Irp_35 > 0;
    assume {:nonnull} ioStatus_13 != 0;
    assume ioStatus_13 > 0;
    assume {:nonnull} Irp_35 != 0;
    assume Irp_35 > 0;
    assume {:nonnull} ioStatus_13 != 0;
    assume ioStatus_13 > 0;
    goto L45;

  L45:
    Tmp_261 := ntStatus_29;
    goto LM2;

  LM2:
    return;

  anon32_Then:
    assume {:partition} allocNewIrp_13 == 0;
    goto L45;

  anon31_Then:
    assume {:partition} pIrb_15 == 0;
    goto L41;

  anon30_Then:
    assume {:partition} pMdl_2 == 0;
    goto L37;

  anon33_Then:
    assume {:partition} ntStatus_29 != 259;
    goto L82;

  anon38_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon37_Then:
    assume {:partition} allocNewIrp_13 == 0;
    call {:si_unique_call 705} ntStatus_29 := t1394_SubmitIrpSynch(NextDeviceObject_1, Irp_35, pIrb_15);
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} yogi_error != 1;
    goto L36;

  anon39_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon36_Then:
    assume {:partition} bGetGeneration_1 == 0;
    assume {:nonnull} pIrb_15 != 0;
    assume pIrb_15 > 0;
    goto L62;

  anon35_Then:
    assume {:partition} pIrb_15 == 0;
    ntStatus_29 := -1073741670;
    goto L36;

  anon29_Then:
    assume {:partition} newIrp_14 == 0;
    ntStatus_29 := -1073741670;
    goto L36;

  anon28_Then:
    goto L25;

  anon27_Then:
    assume {:partition} bRawMode_1 == 0;
    assume {:nonnull} deviceExtension_25 != 0;
    assume deviceExtension_25 > 0;
    havoc NextDeviceObject_1;
    goto L24;

  anon34_Then:
    assume {:partition} nNumberOfBytesToWrite == 0;
    ntStatus_29 := -1073741811;
    goto L36;
}



procedure {:origName "t1394_GetMaxSpeedBetweenDevices"} t1394_GetMaxSpeedBetweenDevices(actual_DeviceObject_39: int, actual_Irp_36: int, actual_fulFlags_6: int, actual_ulNumberOfDestinations: int, actual_hDestinationDeviceObjects: int, actual_fulSpeed_3: int) returns (Tmp_263: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_GetMaxSpeedBetweenDevices"} t1394_GetMaxSpeedBetweenDevices(actual_DeviceObject_39: int, actual_Irp_36: int, actual_fulFlags_6: int, actual_ulNumberOfDestinations: int, actual_hDestinationDeviceObjects: int, actual_fulSpeed_3: int) returns (Tmp_263: int)
{
  var {:scalar} i_5: int;
  var {:scalar} Tmp_264: int;
  var {:pointer} sdv_241: int;
  var {:pointer} Tmp_265: int;
  var {:pointer} newIrp_15: int;
  var {:scalar} allocNewIrp_14: int;
  var {:scalar} Event_17: int;
  var {:scalar} ntStatus_30: int;
  var {:scalar} ioStatus_14: int;
  var {:scalar} Tmp_267: int;
  var {:pointer} deviceExtension_26: int;
  var {:pointer} pIrb_16: int;
  var {:pointer} DeviceObject_39: int;
  var {:pointer} Irp_36: int;
  var {:scalar} fulFlags_6: int;
  var {:scalar} ulNumberOfDestinations: int;
  var {:pointer} hDestinationDeviceObjects: int;
  var {:pointer} fulSpeed_3: int;
  var vslice_dummy_var_70: int;
  var vslice_dummy_var_134: int;
  var vslice_dummy_var_135: int;

  anon0:
    call {:si_unique_call 706} Event_17 := __HAVOC_malloc(156);
    call {:si_unique_call 707} ioStatus_14 := __HAVOC_malloc(12);
    DeviceObject_39 := actual_DeviceObject_39;
    Irp_36 := actual_Irp_36;
    fulFlags_6 := actual_fulFlags_6;
    ulNumberOfDestinations := actual_ulNumberOfDestinations;
    hDestinationDeviceObjects := actual_hDestinationDeviceObjects;
    fulSpeed_3 := actual_fulSpeed_3;
    call {:si_unique_call 708} Tmp_265 := __HAVOC_malloc(256);
    ntStatus_30 := 0;
    assume {:nonnull} DeviceObject_39 != 0;
    assume DeviceObject_39 > 0;
    havoc deviceExtension_26;
    pIrb_16 := 0;
    newIrp_15 := 0;
    allocNewIrp_14 := 0;
    i_5 := 0;
    goto L17;

  L17:
    call {:si_unique_call 709} i_5 := t1394_GetMaxSpeedBetweenDevices_loop_L17(i_5, ulNumberOfDestinations);
    goto L17_last;

  L17_last:
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} ulNumberOfDestinations > i_5;
    i_5 := i_5 + 1;
    goto anon25_Else_dummy;

  anon25_Else_dummy:
    assume false;
    return;

  anon25_Then:
    assume {:partition} i_5 >= ulNumberOfDestinations;
    call {:si_unique_call 710} sdv_241 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_16 := sdv_241;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} pIrb_16 != 0;
    assume {:nonnull} Irp_36 != 0;
    assume Irp_36 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    call {:si_unique_call 711} newIrp_15 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_14);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} newIrp_15 != 0;
    allocNewIrp_14 := 1;
    goto L26;

  L26:
    call {:si_unique_call 712} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_16 != 0;
    assume pIrb_16 > 0;
    assume {:nonnull} pIrb_16 != 0;
    assume pIrb_16 > 0;
    assume {:nonnull} pIrb_16 != 0;
    assume pIrb_16 > 0;
    assume {:nonnull} pIrb_16 != 0;
    assume pIrb_16 > 0;
    i_5 := 0;
    goto L49;

  L49:
    call {:si_unique_call 713} i_5, Tmp_264, Tmp_265, Tmp_267 := t1394_GetMaxSpeedBetweenDevices_loop_L49(i_5, Tmp_264, Tmp_265, Tmp_267, pIrb_16, ulNumberOfDestinations, hDestinationDeviceObjects);
    goto L49_last;

  L49_last:
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} ulNumberOfDestinations > i_5;
    Tmp_267 := i_5;
    assume {:nonnull} pIrb_16 != 0;
    assume pIrb_16 > 0;
    havoc Tmp_265;
    Tmp_264 := i_5;
    assume {:nonnull} Tmp_265 != 0;
    assume Tmp_265 > 0;
    assume {:nonnull} hDestinationDeviceObjects != 0;
    assume hDestinationDeviceObjects > 0;
    i_5 := i_5 + 1;
    goto anon30_Else_dummy;

  anon30_Else_dummy:
    assume false;
    return;

  anon30_Then:
    assume {:partition} i_5 >= ulNumberOfDestinations;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} allocNewIrp_14 != 0;
    call {:si_unique_call 714} KeInitializeEvent(Event_17, 0, 0);
    assume {:nonnull} deviceExtension_26 != 0;
    assume deviceExtension_26 > 0;
    havoc vslice_dummy_var_134;
    call {:si_unique_call 715} ntStatus_30 := t1394_SubmitIrpAsync(vslice_dummy_var_134, newIrp_15, pIrb_16);
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} yogi_error != 1;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} ntStatus_30 == 259;
    call {:si_unique_call 716} vslice_dummy_var_70 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_14 != 0;
    assume ioStatus_14 > 0;
    havoc ntStatus_30;
    goto L64;

  L64:
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} ntStatus_30 >= 0;
    assume {:nonnull} fulSpeed_3 != 0;
    assume fulSpeed_3 > 0;
    assume {:nonnull} pIrb_16 != 0;
    assume pIrb_16 > 0;
    goto L37;

  L37:
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} pIrb_16 != 0;
    call {:si_unique_call 717} sdv_ExFreePool(0);
    goto L38;

  L38:
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} allocNewIrp_14 != 0;
    assume {:nonnull} Irp_36 != 0;
    assume Irp_36 > 0;
    assume {:nonnull} ioStatus_14 != 0;
    assume ioStatus_14 > 0;
    assume {:nonnull} Irp_36 != 0;
    assume Irp_36 > 0;
    assume {:nonnull} ioStatus_14 != 0;
    assume ioStatus_14 > 0;
    assume {:nonnull} Irp_36 != 0;
    assume Irp_36 > 0;
    assume {:nonnull} ioStatus_14 != 0;
    assume ioStatus_14 > 0;
    goto L42;

  L42:
    Tmp_263 := ntStatus_30;
    goto LM2;

  LM2:
    return;

  anon29_Then:
    assume {:partition} allocNewIrp_14 == 0;
    goto L42;

  anon28_Then:
    assume {:partition} pIrb_16 == 0;
    goto L38;

  anon33_Then:
    assume {:partition} 0 > ntStatus_30;
    goto L37;

  anon32_Then:
    assume {:partition} ntStatus_30 != 259;
    goto L64;

  anon35_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon31_Then:
    assume {:partition} allocNewIrp_14 == 0;
    assume {:nonnull} deviceExtension_26 != 0;
    assume deviceExtension_26 > 0;
    havoc vslice_dummy_var_135;
    call {:si_unique_call 718} ntStatus_30 := t1394_SubmitIrpSynch(vslice_dummy_var_135, Irp_36, pIrb_16);
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} yogi_error != 1;
    goto L64;

  anon36_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon27_Then:
    assume {:partition} newIrp_15 == 0;
    ntStatus_30 := -1073741670;
    goto L37;

  anon26_Then:
    goto L26;

  anon34_Then:
    assume {:partition} pIrb_16 == 0;
    ntStatus_30 := -1073741670;
    goto L37;
}



procedure {:origName "t1394_SynchCompletionRoutine"} t1394_SynchCompletionRoutine(actual_DeviceObject_40: int, actual_Irp_37: int, actual_Event_18: int) returns (Tmp_268: int);
  free ensures Tmp_268 == -1073741802;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_SynchCompletionRoutine"} t1394_SynchCompletionRoutine(actual_DeviceObject_40: int, actual_Irp_37: int, actual_Event_18: int) returns (Tmp_268: int)
{
  var {:pointer} Event_18: int;
  var vslice_dummy_var_71: int;

  anon0:
    Event_18 := actual_Event_18;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} Event_18 != 0;
    call {:si_unique_call 719} vslice_dummy_var_71 := KeSetEvent(Event_18, 0, 0);
    goto L6;

  L6:
    Tmp_268 := -1073741802;
    return;

  anon3_Then:
    assume {:partition} Event_18 == 0;
    goto L6;
}



procedure {:origName "t1394_IsochCleanup"} t1394_IsochCleanup(actual_IsochDetachData_3: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochCleanup"} t1394_IsochCleanup(actual_IsochDetachData_3: int)
{
  var {:scalar} i_6: int;
  var {:scalar} Tmp_271: int;
  var {:pointer} Tmp_272: int;
  var {:pointer} sdv_247: int;
  var {:pointer} Tmp_274: int;
  var {:pointer} DeviceExtension_1: int;
  var {:pointer} NextIrpStack_2: int;
  var {:scalar} Tmp_276: int;
  var {:pointer} pIrb_17: int;
  var {:pointer} Tmp_277: int;
  var {:pointer} Tmp_278: int;
  var {:pointer} IsochDetachData_3: int;
  var vslice_dummy_var_72: int;
  var vslice_dummy_var_73: int;
  var vslice_dummy_var_136: int;
  var vslice_dummy_var_137: int;
  var vslice_dummy_var_138: int;
  var vslice_dummy_var_139: int;

  anon0:
    call {:si_unique_call 720} vslice_dummy_var_72 := __HAVOC_malloc(4);
    IsochDetachData_3 := actual_IsochDetachData_3;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    havoc DeviceExtension_1;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} IsochDetachData_3 != 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} DeviceExtension_1 != 0;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    call {:si_unique_call 721} sdv_247 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_17 := sdv_247;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} pIrb_17 != 0;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    call {:si_unique_call 722} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_17 != 0;
    assume pIrb_17 > 0;
    assume {:nonnull} pIrb_17 != 0;
    assume pIrb_17 > 0;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    assume {:nonnull} pIrb_17 != 0;
    assume pIrb_17 > 0;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    assume {:nonnull} pIrb_17 != 0;
    assume pIrb_17 > 0;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    assume {:nonnull} pIrb_17 != 0;
    assume pIrb_17 > 0;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    havoc vslice_dummy_var_136;
    call {:si_unique_call 723} NextIrpStack_2 := sdv_IoGetNextIrpStackLocation(vslice_dummy_var_136);
    assume {:nonnull} NextIrpStack_2 != 0;
    assume NextIrpStack_2 > 0;
    assume {:nonnull} NextIrpStack_2 != 0;
    assume NextIrpStack_2 > 0;
    assume {:nonnull} NextIrpStack_2 != 0;
    assume NextIrpStack_2 > 0;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    havoc vslice_dummy_var_137;
    call {:si_unique_call 724} sdv_IoSetCompletionRoutine(vslice_dummy_var_137, li2bplFunctionConstant218, IsochDetachData_3, 1, 1, 1);
    assume {:nonnull} DeviceExtension_1 != 0;
    assume DeviceExtension_1 > 0;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    havoc vslice_dummy_var_138;
    havoc vslice_dummy_var_139;
    call {:si_unique_call 725} vslice_dummy_var_73 := sdv_IoCallDriver(vslice_dummy_var_138, vslice_dummy_var_139);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon29_Then:
    assume {:partition} pIrb_17 == 0;
    goto L1;

  anon24_Then:
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    call {:si_unique_call 726} sdv_ExFreePool(0);
    goto L43;

  L43:
    i_6 := 0;
    goto L47;

  L47:
    call {:si_unique_call 727} i_6, Tmp_271, Tmp_272, Tmp_274, Tmp_276 := t1394_IsochCleanup_loop_L47(i_6, Tmp_271, Tmp_272, Tmp_274, Tmp_276, IsochDetachData_3);
    goto L47_last;

  L47_last:
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    Tmp_271 := i_6;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    havoc Tmp_274;
    assume {:nonnull} Tmp_274 != 0;
    assume Tmp_274 > 0;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    Tmp_276 := i_6;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    havoc Tmp_272;
    assume {:nonnull} Tmp_272 != 0;
    assume Tmp_272 > 0;
    call {:si_unique_call 728} IoFreeMdl(0);
    goto L52;

  L52:
    i_6 := i_6 + 1;
    goto L52_dummy;

  L52_dummy:
    assume false;
    return;

  anon31_Then:
    goto L52;

  anon26_Then:
    call {:si_unique_call 729} sdv_ExFreePool(0);
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    havoc Tmp_277;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    assume {:nonnull} Tmp_277 != 0;
    assume Tmp_277 > 0;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    havoc Tmp_278;
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    assume {:nonnull} Tmp_278 != 0;
    assume Tmp_278 > 0;
    goto L59;

  L59:
    assume {:nonnull} IsochDetachData_3 != 0;
    assume IsochDetachData_3 > 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 730} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} yogi_error != 1;
    goto L75;

  L75:
    call {:si_unique_call 731} sdv_IoCompleteRequest(0, 0);
    call {:si_unique_call 732} IoFreeIrp(0);
    call {:si_unique_call 733} sdv_ExFreePool(0);
    goto L1;

  anon33_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon27_Then:
    goto L75;

  anon32_Then:
    goto L59;

  anon25_Then:
    goto L43;

  anon23_Then:
    assume {:partition} DeviceExtension_1 == 0;
    goto L1;

  anon28_Then:
    assume {:partition} IsochDetachData_3 == 0;
    goto L1;
}



procedure {:origName "t1394_IsochListen"} t1394_IsochListen(actual_DeviceObject_41: int, actual_Irp_38: int, actual_hResource_4: int, actual_fulFlags_7: int, actual_structPtr888StartTime: int) returns (Tmp_279: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochListen"} t1394_IsochListen(actual_DeviceObject_41: int, actual_Irp_38: int, actual_hResource_4: int, actual_fulFlags_7: int, actual_structPtr888StartTime: int) returns (Tmp_279: int)
{
  var {:scalar} StartTime: int;
  var {:pointer} sdv_250: int;
  var {:pointer} newIrp_16: int;
  var {:scalar} allocNewIrp_15: int;
  var {:scalar} Event_19: int;
  var {:scalar} ntStatus_33: int;
  var {:scalar} ioStatus_15: int;
  var {:pointer} deviceExtension_27: int;
  var {:pointer} pIrb_18: int;
  var {:pointer} DeviceObject_41: int;
  var {:pointer} Irp_38: int;
  var {:pointer} hResource_4: int;
  var {:scalar} fulFlags_7: int;
  var {:pointer} structPtr888StartTime: int;
  var vslice_dummy_var_74: int;
  var vslice_dummy_var_140: int;
  var vslice_dummy_var_141: int;

  anon0:
    call {:si_unique_call 734} StartTime := __HAVOC_malloc(12);
    call {:si_unique_call 735} Event_19 := __HAVOC_malloc(156);
    call {:si_unique_call 736} ioStatus_15 := __HAVOC_malloc(12);
    DeviceObject_41 := actual_DeviceObject_41;
    Irp_38 := actual_Irp_38;
    hResource_4 := actual_hResource_4;
    fulFlags_7 := actual_fulFlags_7;
    structPtr888StartTime := actual_structPtr888StartTime;
    assume {:nonnull} StartTime != 0;
    assume StartTime > 0;
    assume {:nonnull} structPtr888StartTime != 0;
    assume structPtr888StartTime > 0;
    assume {:nonnull} StartTime != 0;
    assume StartTime > 0;
    assume {:nonnull} structPtr888StartTime != 0;
    assume structPtr888StartTime > 0;
    assume {:nonnull} StartTime != 0;
    assume StartTime > 0;
    assume {:nonnull} structPtr888StartTime != 0;
    assume structPtr888StartTime > 0;
    ntStatus_33 := 0;
    assume {:nonnull} DeviceObject_41 != 0;
    assume DeviceObject_41 > 0;
    havoc deviceExtension_27;
    pIrb_18 := 0;
    newIrp_16 := 0;
    allocNewIrp_15 := 0;
    assume {:nonnull} Irp_38 != 0;
    assume Irp_38 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    call {:si_unique_call 737} newIrp_16 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_15);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} newIrp_16 != 0;
    allocNewIrp_15 := 1;
    goto L16;

  L16:
    call {:si_unique_call 738} sdv_250 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_18 := sdv_250;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_18 != 0;
    call {:si_unique_call 739} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_18 != 0;
    assume pIrb_18 > 0;
    assume {:nonnull} pIrb_18 != 0;
    assume pIrb_18 > 0;
    assume {:nonnull} pIrb_18 != 0;
    assume pIrb_18 > 0;
    assume {:nonnull} pIrb_18 != 0;
    assume pIrb_18 > 0;
    assume {:nonnull} StartTime != 0;
    assume StartTime > 0;
    assume {:nonnull} pIrb_18 != 0;
    assume pIrb_18 > 0;
    assume {:nonnull} StartTime != 0;
    assume StartTime > 0;
    assume {:nonnull} pIrb_18 != 0;
    assume pIrb_18 > 0;
    assume {:nonnull} StartTime != 0;
    assume StartTime > 0;
    assume {:nonnull} pIrb_18 != 0;
    assume pIrb_18 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_15 != 0;
    call {:si_unique_call 740} KeInitializeEvent(Event_19, 0, 0);
    assume {:nonnull} deviceExtension_27 != 0;
    assume deviceExtension_27 > 0;
    havoc vslice_dummy_var_140;
    call {:si_unique_call 741} ntStatus_33 := t1394_SubmitIrpAsync(vslice_dummy_var_140, newIrp_16, pIrb_18);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} ntStatus_33 == 259;
    call {:si_unique_call 742} vslice_dummy_var_74 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_15 != 0;
    assume ioStatus_15 > 0;
    havoc ntStatus_33;
    goto L27;

  L27:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} pIrb_18 != 0;
    call {:si_unique_call 743} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} allocNewIrp_15 != 0;
    assume {:nonnull} Irp_38 != 0;
    assume Irp_38 > 0;
    assume {:nonnull} ioStatus_15 != 0;
    assume ioStatus_15 > 0;
    assume {:nonnull} Irp_38 != 0;
    assume Irp_38 > 0;
    assume {:nonnull} ioStatus_15 != 0;
    assume ioStatus_15 > 0;
    assume {:nonnull} Irp_38 != 0;
    assume Irp_38 > 0;
    assume {:nonnull} ioStatus_15 != 0;
    assume ioStatus_15 > 0;
    goto L32;

  L32:
    Tmp_279 := ntStatus_33;
    goto LM2;

  LM2:
    return;

  anon21_Then:
    assume {:partition} allocNewIrp_15 == 0;
    goto L32;

  anon20_Then:
    assume {:partition} pIrb_18 == 0;
    goto L28;

  anon22_Then:
    assume {:partition} ntStatus_33 != 259;
    goto L27;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_15 == 0;
    assume {:nonnull} deviceExtension_27 != 0;
    assume deviceExtension_27 > 0;
    havoc vslice_dummy_var_141;
    call {:si_unique_call 744} ntStatus_33 := t1394_SubmitIrpSynch(vslice_dummy_var_141, Irp_38, pIrb_18);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L27;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon24_Then:
    assume {:partition} pIrb_18 == 0;
    ntStatus_33 := -1073741670;
    goto L27;

  anon19_Then:
    assume {:partition} newIrp_16 == 0;
    ntStatus_33 := -1073741670;
    goto L27;

  anon23_Then:
    goto L16;
}



procedure {:origName "t1394VDev_Create"} t1394VDev_Create(actual_DriverObject_1: int, actual_Irp_39: int) returns (Tmp_281: int);
  modifies alloc, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394VDev_Create"} t1394VDev_Create(actual_DriverObject_1: int, actual_Irp_39: int) returns (Tmp_281: int)
{
  var {:scalar} ntStatus_34: int;
  var {:pointer} Irp_39: int;

  anon0:
    Irp_39 := actual_Irp_39;
    ntStatus_34 := 0;
    assume {:nonnull} Irp_39 != 0;
    assume Irp_39 > 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume Irp_39 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 745} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} yogi_error != 1;
    goto L11;

  L11:
    call {:si_unique_call 746} sdv_IoCompleteRequest(0, 0);
    Tmp_281 := ntStatus_34;
    goto LM2;

  LM2:
    return;

  anon6_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon5_Then:
    assume !(Irp_39 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L11;
}



procedure {:origName "RemoveHeadList"} RemoveHeadList(actual_ListHead_2: int) returns (Tmp_283: int);
  modifies alloc;
  free ensures false;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "RemoveHeadList"} RemoveHeadList(actual_ListHead_2: int) returns (Tmp_283: int)
{
  var {:pointer} NextEntry_1: int;
  var {:pointer} Entry_2: int;
  var {:pointer} ListHead_2: int;

  anon0:
    ListHead_2 := actual_ListHead_2;
    call {:si_unique_call 747} SLIC_RemoveHeadList_entry(strConst__li2bpl3);
    assume {:nonnull} ListHead_2 != 0;
    assume ListHead_2 > 0;
    havoc Entry_2;
    assume {:nonnull} Entry_2 != 0;
    assume Entry_2 > 0;
    havoc NextEntry_1;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    goto L9;

  L9:
    call {:si_unique_call 748} FatalListEntryError(ListHead_2, Entry_2, NextEntry_1);
    goto L12;

  L12:
    assume {:nonnull} ListHead_2 != 0;
    assume ListHead_2 > 0;
    assume {:nonnull} NextEntry_1 != 0;
    assume NextEntry_1 > 0;
    Tmp_283 := Entry_2;
    return;

  anon6_Then:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto L12;

  anon5_Then:
    goto L9;
}



procedure {:origName "t1394_IsochFreeResources"} t1394_IsochFreeResources(actual_DeviceObject_42: int, actual_Irp_40: int, actual_hResource_5: int) returns (Tmp_285: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochFreeResources"} t1394_IsochFreeResources(actual_DeviceObject_42: int, actual_Irp_40: int, actual_hResource_5: int) returns (Tmp_285: int)
{
  var {:pointer} IsochResourceData_1: int;
  var {:pointer} sdv_255: int;
  var {:pointer} newIrp_17: int;
  var {:scalar} allocNewIrp_16: int;
  var {:scalar} Event_20: int;
  var {:scalar} ntStatus_35: int;
  var {:pointer} Tmp_286: int;
  var {:scalar} Irql_6: int;
  var {:scalar} ioStatus_16: int;
  var {:pointer} deviceExtension_28: int;
  var {:pointer} pIrb_19: int;
  var {:pointer} DeviceObject_42: int;
  var {:pointer} Irp_40: int;
  var {:pointer} hResource_5: int;
  var vslice_dummy_var_75: int;
  var vslice_dummy_var_76: int;
  var vslice_dummy_var_142: int;
  var vslice_dummy_var_143: int;

  anon0:
    call {:si_unique_call 749} Event_20 := __HAVOC_malloc(156);
    call {:si_unique_call 750} ioStatus_16 := __HAVOC_malloc(12);
    DeviceObject_42 := actual_DeviceObject_42;
    Irp_40 := actual_Irp_40;
    hResource_5 := actual_hResource_5;
    ntStatus_35 := 0;
    assume {:nonnull} DeviceObject_42 != 0;
    assume DeviceObject_42 > 0;
    havoc deviceExtension_28;
    pIrb_19 := 0;
    IsochResourceData_1 := 0;
    newIrp_17 := 0;
    allocNewIrp_16 := 0;
    assume {:nonnull} Irp_40 != 0;
    assume Irp_40 > 0;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    call {:si_unique_call 751} newIrp_17 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_16);
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} newIrp_17 != 0;
    allocNewIrp_16 := 1;
    goto L19;

  L19:
    call {:si_unique_call 752} sdv_255 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_19 := sdv_255;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} pIrb_19 != 0;
    call {:si_unique_call 753} Tmp_286 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_286 != 0;
    assume Tmp_286 > 0;
    call {:si_unique_call 754} sdv_KeAcquireSpinLock(0, Tmp_286);
    assume {:nonnull} Tmp_286 != 0;
    assume Tmp_286 > 0;
    havoc Irql_6;
    assume {:nonnull} deviceExtension_28 != 0;
    assume deviceExtension_28 > 0;
    havoc IsochResourceData_1;
    goto L44;

  L44:
    call {:si_unique_call 755} IsochResourceData_1 := t1394_IsochFreeResources_loop_L44(IsochResourceData_1, hResource_5);
    goto L44_last;

  L44_last:
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} IsochResourceData_1 != 0;
    assume {:nonnull} IsochResourceData_1 != 0;
    assume IsochResourceData_1 > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    call {:si_unique_call 756} vslice_dummy_var_75 := sdv_RemoveEntryList(0);
    call {:si_unique_call 757} sdv_ExFreePool(0);
    goto L45;

  L45:
    call {:si_unique_call 758} sdv_KeReleaseSpinLock(0, Irql_6);
    call {:si_unique_call 759} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_19 != 0;
    assume pIrb_19 > 0;
    assume {:nonnull} pIrb_19 != 0;
    assume pIrb_19 > 0;
    assume {:nonnull} pIrb_19 != 0;
    assume pIrb_19 > 0;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} allocNewIrp_16 != 0;
    call {:si_unique_call 760} KeInitializeEvent(Event_20, 0, 0);
    assume {:nonnull} deviceExtension_28 != 0;
    assume deviceExtension_28 > 0;
    havoc vslice_dummy_var_142;
    call {:si_unique_call 761} ntStatus_35 := t1394_SubmitIrpAsync(vslice_dummy_var_142, newIrp_17, pIrb_19);
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} yogi_error != 1;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} ntStatus_35 == 259;
    call {:si_unique_call 762} vslice_dummy_var_76 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_16 != 0;
    assume ioStatus_16 > 0;
    havoc ntStatus_35;
    goto L30;

  L30:
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} pIrb_19 != 0;
    call {:si_unique_call 763} sdv_ExFreePool(0);
    goto L31;

  L31:
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} allocNewIrp_16 != 0;
    assume {:nonnull} Irp_40 != 0;
    assume Irp_40 > 0;
    assume {:nonnull} ioStatus_16 != 0;
    assume ioStatus_16 > 0;
    assume {:nonnull} Irp_40 != 0;
    assume Irp_40 > 0;
    assume {:nonnull} ioStatus_16 != 0;
    assume ioStatus_16 > 0;
    assume {:nonnull} Irp_40 != 0;
    assume Irp_40 > 0;
    assume {:nonnull} ioStatus_16 != 0;
    assume ioStatus_16 > 0;
    goto L35;

  L35:
    Tmp_285 := ntStatus_35;
    goto LM2;

  LM2:
    return;

  anon27_Then:
    assume {:partition} allocNewIrp_16 == 0;
    goto L35;

  anon26_Then:
    assume {:partition} pIrb_19 == 0;
    goto L31;

  anon31_Then:
    assume {:partition} ntStatus_35 != 259;
    goto L30;

  anon35_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon34_Then:
    assume {:partition} allocNewIrp_16 == 0;
    assume {:nonnull} deviceExtension_28 != 0;
    assume deviceExtension_28 > 0;
    havoc vslice_dummy_var_143;
    call {:si_unique_call 764} ntStatus_35 := t1394_SubmitIrpSynch(vslice_dummy_var_143, Irp_40, pIrb_19);
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} yogi_error != 1;
    goto L30;

  anon36_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon29_Then:
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:nonnull} IsochResourceData_1 != 0;
    assume IsochResourceData_1 > 0;
    havoc IsochResourceData_1;
    goto anon30_Else_dummy;

  anon30_Else_dummy:
    assume false;
    return;

  anon30_Then:
    goto L45;

  anon28_Then:
    assume {:partition} IsochResourceData_1 == 0;
    goto L45;

  anon33_Then:
    assume {:partition} pIrb_19 == 0;
    ntStatus_35 := -1073741670;
    goto L30;

  anon25_Then:
    assume {:partition} newIrp_17 == 0;
    ntStatus_35 := -1073741670;
    goto L30;

  anon32_Then:
    goto L19;
}



procedure {:origName "RtlFailFast"} RtlFailFast(actual_Code: int);
  modifies alloc;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "RtlFailFast"} RtlFailFast(actual_Code: int)
{
  var vslice_dummy_var_77: int;

  anon0:
    call {:si_unique_call 765} vslice_dummy_var_77 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "t1394_SetDeviceXmitProperties"} t1394_SetDeviceXmitProperties(actual_DeviceObject_43: int, actual_Irp_41: int, actual_fulSpeed_4: int, actual_fulPriority: int) returns (Tmp_289: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_SetDeviceXmitProperties"} t1394_SetDeviceXmitProperties(actual_DeviceObject_43: int, actual_Irp_41: int, actual_fulSpeed_4: int, actual_fulPriority: int) returns (Tmp_289: int)
{
  var {:pointer} sdv_261: int;
  var {:pointer} newIrp_18: int;
  var {:scalar} allocNewIrp_17: int;
  var {:scalar} Event_21: int;
  var {:scalar} ntStatus_36: int;
  var {:scalar} ioStatus_17: int;
  var {:pointer} deviceExtension_29: int;
  var {:pointer} pIrb_20: int;
  var {:pointer} DeviceObject_43: int;
  var {:pointer} Irp_41: int;
  var {:scalar} fulSpeed_4: int;
  var {:scalar} fulPriority: int;
  var vslice_dummy_var_78: int;
  var vslice_dummy_var_144: int;
  var vslice_dummy_var_145: int;

  anon0:
    call {:si_unique_call 766} Event_21 := __HAVOC_malloc(156);
    call {:si_unique_call 767} ioStatus_17 := __HAVOC_malloc(12);
    DeviceObject_43 := actual_DeviceObject_43;
    Irp_41 := actual_Irp_41;
    fulSpeed_4 := actual_fulSpeed_4;
    fulPriority := actual_fulPriority;
    ntStatus_36 := 0;
    assume {:nonnull} DeviceObject_43 != 0;
    assume DeviceObject_43 > 0;
    havoc deviceExtension_29;
    pIrb_20 := 0;
    newIrp_18 := 0;
    allocNewIrp_17 := 0;
    call {:si_unique_call 768} sdv_261 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_20 := sdv_261;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_20 != 0;
    assume {:nonnull} Irp_41 != 0;
    assume Irp_41 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    call {:si_unique_call 769} newIrp_18 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_17);
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} newIrp_18 != 0;
    allocNewIrp_17 := 1;
    goto L22;

  L22:
    call {:si_unique_call 770} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_20 != 0;
    assume pIrb_20 > 0;
    assume {:nonnull} pIrb_20 != 0;
    assume pIrb_20 > 0;
    assume {:nonnull} pIrb_20 != 0;
    assume pIrb_20 > 0;
    assume {:nonnull} pIrb_20 != 0;
    assume pIrb_20 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_17 != 0;
    call {:si_unique_call 771} KeInitializeEvent(Event_21, 0, 0);
    assume {:nonnull} deviceExtension_29 != 0;
    assume deviceExtension_29 > 0;
    havoc vslice_dummy_var_144;
    call {:si_unique_call 772} ntStatus_36 := t1394_SubmitIrpAsync(vslice_dummy_var_144, newIrp_18, pIrb_20);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} ntStatus_36 == 259;
    call {:si_unique_call 773} vslice_dummy_var_78 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_17 != 0;
    assume ioStatus_17 > 0;
    havoc ntStatus_36;
    goto L33;

  L33:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} pIrb_20 != 0;
    call {:si_unique_call 774} sdv_ExFreePool(0);
    goto L34;

  L34:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} allocNewIrp_17 != 0;
    assume {:nonnull} Irp_41 != 0;
    assume Irp_41 > 0;
    assume {:nonnull} ioStatus_17 != 0;
    assume ioStatus_17 > 0;
    assume {:nonnull} Irp_41 != 0;
    assume Irp_41 > 0;
    assume {:nonnull} ioStatus_17 != 0;
    assume ioStatus_17 > 0;
    assume {:nonnull} Irp_41 != 0;
    assume Irp_41 > 0;
    assume {:nonnull} ioStatus_17 != 0;
    assume ioStatus_17 > 0;
    goto L38;

  L38:
    Tmp_289 := ntStatus_36;
    goto LM2;

  LM2:
    return;

  anon22_Then:
    assume {:partition} allocNewIrp_17 == 0;
    goto L38;

  anon21_Then:
    assume {:partition} pIrb_20 == 0;
    goto L34;

  anon23_Then:
    assume {:partition} ntStatus_36 != 259;
    goto L33;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_17 == 0;
    assume {:nonnull} deviceExtension_29 != 0;
    assume deviceExtension_29 > 0;
    havoc vslice_dummy_var_145;
    call {:si_unique_call 775} ntStatus_36 := t1394_SubmitIrpSynch(vslice_dummy_var_145, Irp_41, pIrb_20);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L33;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon20_Then:
    assume {:partition} newIrp_18 == 0;
    ntStatus_36 := -1073741670;
    goto L33;

  anon19_Then:
    goto L22;

  anon24_Then:
    assume {:partition} pIrb_20 == 0;
    ntStatus_36 := -1073741670;
    goto L33;
}



procedure {:origName "t1394_IsochAllocateResources"} t1394_IsochAllocateResources(actual_DeviceObject_44: int, actual_Irp_42: int, actual_fulSpeed_5: int, actual_fulFlags_8: int, actual_nChannel_1: int, actual_nMaxBytesPerFrame: int, actual_nNumberOfBuffers: int, actual_nMaxBufferSize: int, actual_nQuadletsToStrip: int, actual_phResource: int) returns (Tmp_291: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochAllocateResources"} t1394_IsochAllocateResources(actual_DeviceObject_44: int, actual_Irp_42: int, actual_fulSpeed_5: int, actual_fulFlags_8: int, actual_nChannel_1: int, actual_nMaxBytesPerFrame: int, actual_nNumberOfBuffers: int, actual_nMaxBufferSize: int, actual_nQuadletsToStrip: int, actual_phResource: int) returns (Tmp_291: int)
{
  var {:pointer} IsochResourceData_2: int;
  var {:pointer} Tmp_292: int;
  var {:pointer} sdv_266: int;
  var {:pointer} newIrp_19: int;
  var {:pointer} sdv_267: int;
  var {:scalar} allocNewIrp_18: int;
  var {:scalar} Event_22: int;
  var {:scalar} ntStatus_37: int;
  var {:scalar} Irql_7: int;
  var {:scalar} ioStatus_18: int;
  var {:pointer} deviceExtension_30: int;
  var {:pointer} pIrb_21: int;
  var {:pointer} DeviceObject_44: int;
  var {:pointer} Irp_42: int;
  var {:scalar} fulSpeed_5: int;
  var {:scalar} fulFlags_8: int;
  var {:scalar} nChannel_1: int;
  var {:scalar} nMaxBytesPerFrame: int;
  var {:scalar} nNumberOfBuffers: int;
  var {:scalar} nMaxBufferSize: int;
  var {:scalar} nQuadletsToStrip: int;
  var {:pointer} phResource: int;
  var vslice_dummy_var_79: int;
  var vslice_dummy_var_146: int;
  var vslice_dummy_var_147: int;

  anon0:
    call {:si_unique_call 776} Event_22 := __HAVOC_malloc(156);
    call {:si_unique_call 777} ioStatus_18 := __HAVOC_malloc(12);
    DeviceObject_44 := actual_DeviceObject_44;
    Irp_42 := actual_Irp_42;
    fulSpeed_5 := actual_fulSpeed_5;
    fulFlags_8 := actual_fulFlags_8;
    nChannel_1 := actual_nChannel_1;
    nMaxBytesPerFrame := actual_nMaxBytesPerFrame;
    nNumberOfBuffers := actual_nNumberOfBuffers;
    nMaxBufferSize := actual_nMaxBufferSize;
    nQuadletsToStrip := actual_nQuadletsToStrip;
    phResource := actual_phResource;
    ntStatus_37 := 0;
    assume {:nonnull} DeviceObject_44 != 0;
    assume DeviceObject_44 > 0;
    havoc deviceExtension_30;
    pIrb_21 := 0;
    newIrp_19 := 0;
    allocNewIrp_18 := 0;
    assume {:nonnull} Irp_42 != 0;
    assume Irp_42 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    call {:si_unique_call 778} newIrp_19 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_18);
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} newIrp_19 != 0;
    allocNewIrp_18 := 1;
    goto L16;

  L16:
    call {:si_unique_call 779} sdv_266 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_21 := sdv_266;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} pIrb_21 != 0;
    call {:si_unique_call 780} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} allocNewIrp_18 != 0;
    call {:si_unique_call 781} KeInitializeEvent(Event_22, 0, 0);
    assume {:nonnull} deviceExtension_30 != 0;
    assume deviceExtension_30 > 0;
    havoc vslice_dummy_var_146;
    call {:si_unique_call 782} ntStatus_37 := t1394_SubmitIrpAsync(vslice_dummy_var_146, newIrp_19, pIrb_21);
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} yogi_error != 1;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} ntStatus_37 == 259;
    call {:si_unique_call 783} vslice_dummy_var_79 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_18 != 0;
    assume ioStatus_18 > 0;
    havoc ntStatus_37;
    goto L61;

  L61:
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} ntStatus_37 >= 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    assume {:nonnull} phResource != 0;
    assume phResource > 0;
    call {:si_unique_call 784} sdv_267 := ExAllocatePoolWithTag(512, 12, -164023503);
    IsochResourceData_2 := sdv_267;
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} IsochResourceData_2 != 0;
    assume {:nonnull} IsochResourceData_2 != 0;
    assume IsochResourceData_2 > 0;
    assume {:nonnull} pIrb_21 != 0;
    assume pIrb_21 > 0;
    call {:si_unique_call 785} Tmp_292 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_292 != 0;
    assume Tmp_292 > 0;
    call {:si_unique_call 786} sdv_KeAcquireSpinLock(0, Tmp_292);
    assume {:nonnull} Tmp_292 != 0;
    assume Tmp_292 > 0;
    havoc Irql_7;
    assume {:nonnull} IsochResourceData_2 != 0;
    assume IsochResourceData_2 > 0;
    assume {:nonnull} deviceExtension_30 != 0;
    assume deviceExtension_30 > 0;
    call {:si_unique_call 787} InsertHeadList(IsochResourceData__DEVICE_EXTENSION(deviceExtension_30), IsochResourceList__ISOCH_RESOURCE_DATA(IsochResourceData_2));
    call {:si_unique_call 788} sdv_KeReleaseSpinLock(0, Irql_7);
    goto L27;

  L27:
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_21 != 0;
    call {:si_unique_call 789} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_18 != 0;
    assume {:nonnull} Irp_42 != 0;
    assume Irp_42 > 0;
    assume {:nonnull} ioStatus_18 != 0;
    assume ioStatus_18 > 0;
    assume {:nonnull} Irp_42 != 0;
    assume Irp_42 > 0;
    assume {:nonnull} ioStatus_18 != 0;
    assume ioStatus_18 > 0;
    assume {:nonnull} Irp_42 != 0;
    assume Irp_42 > 0;
    assume {:nonnull} ioStatus_18 != 0;
    assume ioStatus_18 > 0;
    goto L32;

  L32:
    Tmp_291 := ntStatus_37;
    goto LM2;

  LM2:
    return;

  anon25_Then:
    assume {:partition} allocNewIrp_18 == 0;
    goto L32;

  anon24_Then:
    assume {:partition} pIrb_21 == 0;
    goto L28;

  anon32_Then:
    assume {:partition} IsochResourceData_2 == 0;
    goto L27;

  anon27_Then:
    assume {:partition} 0 > ntStatus_37;
    goto L27;

  anon26_Then:
    assume {:partition} ntStatus_37 != 259;
    goto L61;

  anon31_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon30_Then:
    assume {:partition} allocNewIrp_18 == 0;
    assume {:nonnull} deviceExtension_30 != 0;
    assume deviceExtension_30 > 0;
    havoc vslice_dummy_var_147;
    call {:si_unique_call 790} ntStatus_37 := t1394_SubmitIrpSynch(vslice_dummy_var_147, Irp_42, pIrb_21);
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} yogi_error != 1;
    goto L61;

  anon33_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon29_Then:
    assume {:partition} pIrb_21 == 0;
    ntStatus_37 := -1073741670;
    goto L27;

  anon23_Then:
    assume {:partition} newIrp_19 == 0;
    ntStatus_37 := -1073741670;
    goto L27;

  anon28_Then:
    goto L16;
}



procedure {:origName "t1394_GetLocalHostInformation"} t1394_GetLocalHostInformation(actual_DeviceObject_45: int, actual_Irp_43: int, actual_nLevel_1: int, actual_UserStatus: int, actual_Information_1: int) returns (Tmp_293: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_GetLocalHostInformation"} t1394_GetLocalHostInformation(actual_DeviceObject_45: int, actual_Irp_43: int, actual_nLevel_1: int, actual_UserStatus: int, actual_Information_1: int) returns (Tmp_293: int)
{
  var {:scalar} LocalHostInfo5: int;
  var {:pointer} Tmp_294: int;
  var {:pointer} Tmp_295: int;
  var {:pointer} Tmp_296: int;
  var {:pointer} sdv_272: int;
  var {:scalar} LocalHostInfo6: int;
  var {:pointer} newIrp_20: int;
  var {:scalar} allocNewIrp_19: int;
  var {:pointer} Tmp_298: int;
  var {:scalar} Event_23: int;
  var {:scalar} ntStatus_38: int;
  var {:pointer} Tmp_299: int;
  var {:scalar} ioStatus_19: int;
  var {:scalar} LocalHostInfo7: int;
  var {:pointer} deviceExtension_31: int;
  var {:pointer} pIrb_22: int;
  var {:pointer} DeviceObject_45: int;
  var {:pointer} Irp_43: int;
  var {:scalar} nLevel_1: int;
  var {:pointer} UserStatus: int;
  var {:pointer} Information_1: int;
  var vslice_dummy_var_80: int;
  var vslice_dummy_var_148: int;
  var vslice_dummy_var_149: int;

  anon0:
    call {:si_unique_call 791} LocalHostInfo5 := __HAVOC_malloc(8);
    call {:si_unique_call 792} LocalHostInfo6 := __HAVOC_malloc(16);
    call {:si_unique_call 793} Event_23 := __HAVOC_malloc(156);
    call {:si_unique_call 794} ioStatus_19 := __HAVOC_malloc(12);
    call {:si_unique_call 795} LocalHostInfo7 := __HAVOC_malloc(24);
    DeviceObject_45 := actual_DeviceObject_45;
    Irp_43 := actual_Irp_43;
    nLevel_1 := actual_nLevel_1;
    UserStatus := actual_UserStatus;
    Information_1 := actual_Information_1;
    ntStatus_38 := 0;
    assume {:nonnull} DeviceObject_45 != 0;
    assume DeviceObject_45 > 0;
    havoc deviceExtension_31;
    pIrb_22 := 0;
    newIrp_20 := 0;
    allocNewIrp_19 := 0;
    call {:si_unique_call 796} sdv_272 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_22 := sdv_272;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} pIrb_22 != 0;
    assume {:nonnull} Irp_43 != 0;
    assume Irp_43 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    call {:si_unique_call 797} newIrp_20 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_19);
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} newIrp_20 != 0;
    allocNewIrp_19 := 1;
    goto L25;

  L25:
    call {:si_unique_call 798} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_22 != 0;
    assume pIrb_22 > 0;
    assume {:nonnull} pIrb_22 != 0;
    assume pIrb_22 > 0;
    assume {:nonnull} pIrb_22 != 0;
    assume pIrb_22 > 0;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} nLevel_1 == 7;
    call {:si_unique_call 799} sdv_RtlCopyMemory(0, 0, 16);
    assume {:nonnull} pIrb_22 != 0;
    assume pIrb_22 > 0;
    goto L52;

  L52:
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} allocNewIrp_19 != 0;
    call {:si_unique_call 800} KeInitializeEvent(Event_23, 0, 0);
    assume {:nonnull} deviceExtension_31 != 0;
    assume deviceExtension_31 > 0;
    havoc vslice_dummy_var_148;
    call {:si_unique_call 801} ntStatus_38 := t1394_SubmitIrpAsync(vslice_dummy_var_148, newIrp_20, pIrb_22);
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} yogi_error != 1;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} ntStatus_38 == 259;
    call {:si_unique_call 802} vslice_dummy_var_80 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_19 != 0;
    assume ioStatus_19 > 0;
    havoc ntStatus_38;
    goto L64;

  L64:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} ntStatus_38 >= 0;
    assume {:nonnull} UserStatus != 0;
    assume UserStatus > 0;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} nLevel_1 == 1;
    goto L36;

  L36:
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} pIrb_22 != 0;
    call {:si_unique_call 803} sdv_ExFreePool(0);
    goto L37;

  L37:
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} allocNewIrp_19 != 0;
    assume {:nonnull} Irp_43 != 0;
    assume Irp_43 > 0;
    assume {:nonnull} ioStatus_19 != 0;
    assume ioStatus_19 > 0;
    assume {:nonnull} Irp_43 != 0;
    assume Irp_43 > 0;
    assume {:nonnull} ioStatus_19 != 0;
    assume ioStatus_19 > 0;
    assume {:nonnull} Irp_43 != 0;
    assume Irp_43 > 0;
    assume {:nonnull} ioStatus_19 != 0;
    assume ioStatus_19 > 0;
    goto L41;

  L41:
    Tmp_293 := ntStatus_38;
    goto LM2;

  LM2:
    return;

  anon52_Then:
    assume {:partition} allocNewIrp_19 == 0;
    goto L41;

  anon51_Then:
    assume {:partition} pIrb_22 == 0;
    goto L37;

  anon70_Then:
    assume {:partition} nLevel_1 != 1;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} nLevel_1 == 2;
    goto L36;

  anon58_Then:
    assume {:partition} nLevel_1 != 2;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} nLevel_1 == 3;
    goto L36;

  anon59_Then:
    assume {:partition} nLevel_1 != 3;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} nLevel_1 == 4;
    goto L36;

  anon60_Then:
    assume {:partition} nLevel_1 != 4;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} nLevel_1 == 5;
    goto L36;

  anon61_Then:
    assume {:partition} nLevel_1 != 5;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} nLevel_1 != 6;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} nLevel_1 == 7;
    call {:si_unique_call 804} sdv_RtlCopyMemory(0, 0, 16);
    goto L36;

  anon63_Then:
    assume {:partition} nLevel_1 != 7;
    goto L36;

  anon62_Then:
    assume {:partition} nLevel_1 == 6;
    goto L36;

  anon56_Then:
    assume {:partition} 0 > ntStatus_38;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} ntStatus_38 == -1073741306;
    ntStatus_38 := 0;
    assume {:nonnull} UserStatus != 0;
    assume UserStatus > 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} nLevel_1 == 5;
    call {:si_unique_call 805} sdv_RtlCopyMemory(0, 0, 8);
    goto L36;

  anon71_Then:
    assume {:partition} nLevel_1 != 5;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} nLevel_1 == 6;
    Tmp_294 := Information_1;
    assume {:nonnull} LocalHostInfo6 != 0;
    assume LocalHostInfo6 > 0;
    assume {:nonnull} Tmp_294 != 0;
    assume Tmp_294 > 0;
    goto L36;

  anon64_Then:
    assume {:partition} nLevel_1 != 6;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} nLevel_1 == 7;
    call {:si_unique_call 806} sdv_RtlCopyMemory(0, 0, 16);
    goto L36;

  anon65_Then:
    assume {:partition} nLevel_1 != 7;
    goto L36;

  anon57_Then:
    assume {:partition} ntStatus_38 != -1073741306;
    goto L36;

  anon55_Then:
    assume {:partition} ntStatus_38 != 259;
    goto L64;

  anon69_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon54_Then:
    assume {:partition} allocNewIrp_19 == 0;
    assume {:nonnull} deviceExtension_31 != 0;
    assume deviceExtension_31 > 0;
    havoc vslice_dummy_var_149;
    call {:si_unique_call 807} ntStatus_38 := t1394_SubmitIrpSynch(vslice_dummy_var_149, Irp_43, pIrb_22);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} yogi_error != 1;
    goto L64;

  anon72_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon68_Then:
    assume {:partition} nLevel_1 != 7;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} nLevel_1 == 6;
    Tmp_299 := Information_1;
    assume {:nonnull} LocalHostInfo6 != 0;
    assume LocalHostInfo6 > 0;
    assume {:nonnull} Tmp_299 != 0;
    assume Tmp_299 > 0;
    Tmp_296 := Information_1;
    assume {:nonnull} LocalHostInfo6 != 0;
    assume LocalHostInfo6 > 0;
    assume {:nonnull} Tmp_296 != 0;
    assume Tmp_296 > 0;
    Tmp_298 := Information_1;
    assume {:nonnull} LocalHostInfo6 != 0;
    assume LocalHostInfo6 > 0;
    assume {:nonnull} Tmp_298 != 0;
    assume Tmp_298 > 0;
    Tmp_295 := Information_1;
    assume {:nonnull} LocalHostInfo6 != 0;
    assume LocalHostInfo6 > 0;
    assume {:nonnull} Tmp_295 != 0;
    assume Tmp_295 > 0;
    assume {:nonnull} pIrb_22 != 0;
    assume pIrb_22 > 0;
    goto L52;

  anon53_Then:
    assume {:partition} nLevel_1 != 6;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} nLevel_1 == 5;
    call {:si_unique_call 808} sdv_RtlCopyMemory(0, 0, 8);
    assume {:nonnull} pIrb_22 != 0;
    assume pIrb_22 > 0;
    goto L52;

  anon66_Then:
    assume {:partition} nLevel_1 != 5;
    assume {:nonnull} pIrb_22 != 0;
    assume pIrb_22 > 0;
    goto L52;

  anon50_Then:
    assume {:partition} newIrp_20 == 0;
    ntStatus_38 := -1073741670;
    goto L36;

  anon49_Then:
    goto L25;

  anon67_Then:
    assume {:partition} pIrb_22 == 0;
    ntStatus_38 := -1073741670;
    goto L36;
}



procedure {:origName "t1394_FreeAddressRange"} t1394_FreeAddressRange(actual_DeviceObject_46: int, actual_Irp_44: int, actual_hAddressRange_1: int) returns (Tmp_300: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_FreeAddressRange"} t1394_FreeAddressRange(actual_DeviceObject_46: int, actual_Irp_44: int, actual_hAddressRange_1: int) returns (Tmp_300: int)
{
  var {:pointer} newIrp_21: int;
  var {:scalar} allocNewIrp_20: int;
  var {:scalar} Event_24: int;
  var {:scalar} ntStatus_39: int;
  var {:pointer} sdv_280: int;
  var {:pointer} Tmp_301: int;
  var {:pointer} AsyncAddressData_2: int;
  var {:scalar} Irql_8: int;
  var {:scalar} ioStatus_20: int;
  var {:pointer} deviceExtension_32: int;
  var {:pointer} pIrb_23: int;
  var {:pointer} DeviceObject_46: int;
  var {:pointer} Irp_44: int;
  var {:pointer} hAddressRange_1: int;
  var vslice_dummy_var_81: int;
  var vslice_dummy_var_82: int;
  var vslice_dummy_var_150: int;
  var vslice_dummy_var_151: int;

  anon0:
    call {:si_unique_call 809} Event_24 := __HAVOC_malloc(156);
    call {:si_unique_call 810} ioStatus_20 := __HAVOC_malloc(12);
    DeviceObject_46 := actual_DeviceObject_46;
    Irp_44 := actual_Irp_44;
    hAddressRange_1 := actual_hAddressRange_1;
    ntStatus_39 := 0;
    assume {:nonnull} DeviceObject_46 != 0;
    assume DeviceObject_46 > 0;
    havoc deviceExtension_32;
    pIrb_23 := 0;
    AsyncAddressData_2 := 0;
    newIrp_21 := 0;
    allocNewIrp_20 := 0;
    assume {:nonnull} Irp_44 != 0;
    assume Irp_44 > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    call {:si_unique_call 811} newIrp_21 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_20);
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} newIrp_21 != 0;
    allocNewIrp_20 := 1;
    goto L19;

  L19:
    call {:si_unique_call 812} Tmp_301 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    call {:si_unique_call 813} sdv_KeAcquireSpinLock(0, Tmp_301);
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    havoc Irql_8;
    assume {:nonnull} deviceExtension_32 != 0;
    assume deviceExtension_32 > 0;
    havoc AsyncAddressData_2;
    goto L38;

  L38:
    call {:si_unique_call 814} AsyncAddressData_2 := t1394_FreeAddressRange_loop_L38(AsyncAddressData_2, hAddressRange_1);
    goto L38_last;

  L38_last:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} AsyncAddressData_2 != 0;
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    call {:si_unique_call 815} vslice_dummy_var_81 := sdv_RemoveEntryList(0);
    goto L39;

  L39:
    call {:si_unique_call 816} sdv_KeReleaseSpinLock(0, Irql_8);
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} AsyncAddressData_2 != 0;
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    call {:si_unique_call 817} sdv_280 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_23 := sdv_280;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} pIrb_23 != 0;
    call {:si_unique_call 818} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_23 != 0;
    assume pIrb_23 > 0;
    assume {:nonnull} pIrb_23 != 0;
    assume pIrb_23 > 0;
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    assume {:nonnull} pIrb_23 != 0;
    assume pIrb_23 > 0;
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    assume {:nonnull} pIrb_23 != 0;
    assume pIrb_23 > 0;
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    assume {:nonnull} pIrb_23 != 0;
    assume pIrb_23 > 0;
    assume {:nonnull} pIrb_23 != 0;
    assume pIrb_23 > 0;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} allocNewIrp_20 != 0;
    call {:si_unique_call 819} KeInitializeEvent(Event_24, 0, 0);
    assume {:nonnull} deviceExtension_32 != 0;
    assume deviceExtension_32 > 0;
    havoc vslice_dummy_var_150;
    call {:si_unique_call 820} ntStatus_39 := t1394_SubmitIrpAsync(vslice_dummy_var_150, newIrp_21, pIrb_23);
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} yogi_error != 1;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} ntStatus_39 != 259;
    goto L89;

  L89:
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    call {:si_unique_call 821} IoFreeMdl(0);
    goto L90;

  L90:
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    call {:si_unique_call 822} sdv_ExFreePool(0);
    goto L94;

  L94:
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    call {:si_unique_call 823} sdv_ExFreePool(0);
    goto L98;

  L98:
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} AsyncAddressData_2 != 0;
    call {:si_unique_call 824} sdv_ExFreePool(0);
    goto L30;

  L30:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} pIrb_23 != 0;
    call {:si_unique_call 825} sdv_ExFreePool(0);
    goto L31;

  L31:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} allocNewIrp_20 != 0;
    assume {:nonnull} Irp_44 != 0;
    assume Irp_44 > 0;
    assume {:nonnull} ioStatus_20 != 0;
    assume ioStatus_20 > 0;
    assume {:nonnull} Irp_44 != 0;
    assume Irp_44 > 0;
    assume {:nonnull} ioStatus_20 != 0;
    assume ioStatus_20 > 0;
    assume {:nonnull} Irp_44 != 0;
    assume Irp_44 > 0;
    assume {:nonnull} ioStatus_20 != 0;
    assume ioStatus_20 > 0;
    goto L35;

  L35:
    Tmp_300 := ntStatus_39;
    goto LM2;

  LM2:
    return;

  anon39_Then:
    assume {:partition} allocNewIrp_20 == 0;
    goto L35;

  anon38_Then:
    assume {:partition} pIrb_23 == 0;
    goto L31;

  anon49_Then:
    assume {:partition} AsyncAddressData_2 == 0;
    goto L30;

  anon48_Then:
    goto L98;

  anon47_Then:
    goto L94;

  anon46_Then:
    goto L90;

  anon45_Then:
    assume {:partition} ntStatus_39 == 259;
    call {:si_unique_call 826} vslice_dummy_var_82 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_20 != 0;
    assume ioStatus_20 > 0;
    havoc ntStatus_39;
    goto L89;

  anon53_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon52_Then:
    assume {:partition} allocNewIrp_20 == 0;
    assume {:nonnull} deviceExtension_32 != 0;
    assume deviceExtension_32 > 0;
    havoc vslice_dummy_var_151;
    call {:si_unique_call 827} ntStatus_39 := t1394_SubmitIrpSynch(vslice_dummy_var_151, Irp_44, pIrb_23);
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} yogi_error != 1;
    goto L89;

  anon54_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon51_Then:
    assume {:partition} pIrb_23 == 0;
    call {:si_unique_call 828} Tmp_301 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    call {:si_unique_call 829} sdv_KeAcquireSpinLock(0, Tmp_301);
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    havoc Irql_8;
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    assume {:nonnull} deviceExtension_32 != 0;
    assume deviceExtension_32 > 0;
    call {:si_unique_call 830} InsertHeadList(AsyncAddressData__DEVICE_EXTENSION(deviceExtension_32), AsyncAddressList__ASYNC_ADDRESS_DATA(AsyncAddressData_2));
    call {:si_unique_call 831} sdv_KeReleaseSpinLock(0, Irql_8);
    ntStatus_39 := -1073741670;
    goto L30;

  anon44_Then:
    ntStatus_39 := -1073741811;
    goto L30;

  anon43_Then:
    assume {:partition} AsyncAddressData_2 == 0;
    ntStatus_39 := -1073741811;
    goto L30;

  anon41_Then:
    goto anon42_Then, anon42_Else;

  anon42_Else:
    AsyncAddressData_2 := 0;
    goto L39;

  anon42_Then:
    assume {:nonnull} AsyncAddressData_2 != 0;
    assume AsyncAddressData_2 > 0;
    havoc AsyncAddressData_2;
    goto anon42_Then_dummy;

  anon42_Then_dummy:
    assume false;
    return;

  anon40_Then:
    assume {:partition} AsyncAddressData_2 == 0;
    goto L39;

  anon37_Then:
    assume {:partition} newIrp_21 == 0;
    ntStatus_39 := -1073741670;
    goto L30;

  anon50_Then:
    goto L19;
}



procedure {:origName "t1394_SubmitIrpSynch"} t1394_SubmitIrpSynch(actual_DeviceObject_47: int, actual_Irp_45: int, actual_Irb_2: int) returns (Tmp_302: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 0 || wait_required == 1 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_SubmitIrpSynch"} t1394_SubmitIrpSynch(actual_DeviceObject_47: int, actual_Irp_45: int, actual_Irb_2: int) returns (Tmp_302: int)
{
  var {:scalar} Event_25: int;
  var {:scalar} ntStatus_40: int;
  var {:pointer} NextIrpStack_3: int;
  var {:pointer} DeviceObject_47: int;
  var {:pointer} Irp_45: int;
  var {:pointer} Irb_2: int;
  var vslice_dummy_var_83: int;

  anon0:
    call {:si_unique_call 832} Event_25 := __HAVOC_malloc(156);
    DeviceObject_47 := actual_DeviceObject_47;
    Irp_45 := actual_Irp_45;
    Irb_2 := actual_Irb_2;
    ntStatus_40 := 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} Irb_2 != 0;
    call {:si_unique_call 833} NextIrpStack_3 := sdv_IoGetNextIrpStackLocation(Irp_45);
    assume {:nonnull} NextIrpStack_3 != 0;
    assume NextIrpStack_3 > 0;
    assume {:nonnull} NextIrpStack_3 != 0;
    assume NextIrpStack_3 > 0;
    assume {:nonnull} NextIrpStack_3 != 0;
    assume NextIrpStack_3 > 0;
    goto L18;

  L18:
    call {:si_unique_call 834} KeInitializeEvent(Event_25, 1, 0);
    call {:si_unique_call 835} sdv_IoSetCompletionRoutine(Irp_45, li2bplFunctionConstant176, Event_25, 1, 1, 1);
    call {:si_unique_call 836} ntStatus_40 := sdv_IoCallDriver(DeviceObject_47, Irp_45);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} yogi_error != 1;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume Irp_45 == SLAM_guard_S_0;
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 837} SLIC_sdv_IoCallDriver_exit(0, ntStatus_40);
    goto L28;

  L28:
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} ntStatus_40 == 259;
    call {:si_unique_call 838} vslice_dummy_var_83 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto L29;

  L29:
    assume {:nonnull} Irp_45 != 0;
    assume Irp_45 > 0;
    havoc ntStatus_40;
    Tmp_302 := ntStatus_40;
    goto LM2;

  LM2:
    return;

  anon9_Then:
    assume {:partition} ntStatus_40 != 259;
    goto L29;

  anon10_Then:
    assume !(Irp_45 == SLAM_guard_S_0 && SLAM_guard_S_0 != SLAM_guard_S_0_init);
    goto L28;

  anon12_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon11_Then:
    assume {:partition} Irb_2 == 0;
    call {:si_unique_call 839} sdv_IoCopyCurrentIrpStackLocationToNext(Irp_45);
    goto L18;
}



procedure {:origName "t1394_IsochSetChannelBandwidth"} t1394_IsochSetChannelBandwidth(actual_DeviceObject_48: int, actual_Irp_46: int, actual_hBandwidth_1: int, actual_nMaxBytesPerFrame_1: int) returns (Tmp_304: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochSetChannelBandwidth"} t1394_IsochSetChannelBandwidth(actual_DeviceObject_48: int, actual_Irp_46: int, actual_hBandwidth_1: int, actual_nMaxBytesPerFrame_1: int) returns (Tmp_304: int)
{
  var {:pointer} sdv_286: int;
  var {:pointer} newIrp_22: int;
  var {:scalar} allocNewIrp_21: int;
  var {:scalar} Event_26: int;
  var {:scalar} ntStatus_41: int;
  var {:scalar} ioStatus_21: int;
  var {:pointer} deviceExtension_33: int;
  var {:pointer} pIrb_24: int;
  var {:pointer} DeviceObject_48: int;
  var {:pointer} Irp_46: int;
  var {:pointer} hBandwidth_1: int;
  var {:scalar} nMaxBytesPerFrame_1: int;
  var vslice_dummy_var_84: int;
  var vslice_dummy_var_152: int;
  var vslice_dummy_var_153: int;

  anon0:
    call {:si_unique_call 840} Event_26 := __HAVOC_malloc(156);
    call {:si_unique_call 841} ioStatus_21 := __HAVOC_malloc(12);
    DeviceObject_48 := actual_DeviceObject_48;
    Irp_46 := actual_Irp_46;
    hBandwidth_1 := actual_hBandwidth_1;
    nMaxBytesPerFrame_1 := actual_nMaxBytesPerFrame_1;
    ntStatus_41 := 0;
    assume {:nonnull} DeviceObject_48 != 0;
    assume DeviceObject_48 > 0;
    havoc deviceExtension_33;
    pIrb_24 := 0;
    newIrp_22 := 0;
    allocNewIrp_21 := 0;
    assume {:nonnull} Irp_46 != 0;
    assume Irp_46 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    call {:si_unique_call 842} newIrp_22 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_21);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} newIrp_22 != 0;
    allocNewIrp_21 := 1;
    goto L16;

  L16:
    call {:si_unique_call 843} sdv_286 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_24 := sdv_286;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_24 != 0;
    call {:si_unique_call 844} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_24 != 0;
    assume pIrb_24 > 0;
    assume {:nonnull} pIrb_24 != 0;
    assume pIrb_24 > 0;
    assume {:nonnull} pIrb_24 != 0;
    assume pIrb_24 > 0;
    assume {:nonnull} pIrb_24 != 0;
    assume pIrb_24 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_21 != 0;
    call {:si_unique_call 845} KeInitializeEvent(Event_26, 0, 0);
    assume {:nonnull} deviceExtension_33 != 0;
    assume deviceExtension_33 > 0;
    havoc vslice_dummy_var_152;
    call {:si_unique_call 846} ntStatus_41 := t1394_SubmitIrpAsync(vslice_dummy_var_152, newIrp_22, pIrb_24);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} ntStatus_41 == 259;
    call {:si_unique_call 847} vslice_dummy_var_84 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_21 != 0;
    assume ioStatus_21 > 0;
    havoc ntStatus_41;
    goto L27;

  L27:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} pIrb_24 != 0;
    call {:si_unique_call 848} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} allocNewIrp_21 != 0;
    assume {:nonnull} Irp_46 != 0;
    assume Irp_46 > 0;
    assume {:nonnull} ioStatus_21 != 0;
    assume ioStatus_21 > 0;
    assume {:nonnull} Irp_46 != 0;
    assume Irp_46 > 0;
    assume {:nonnull} ioStatus_21 != 0;
    assume ioStatus_21 > 0;
    assume {:nonnull} Irp_46 != 0;
    assume Irp_46 > 0;
    assume {:nonnull} ioStatus_21 != 0;
    assume ioStatus_21 > 0;
    goto L32;

  L32:
    Tmp_304 := ntStatus_41;
    goto LM2;

  LM2:
    return;

  anon21_Then:
    assume {:partition} allocNewIrp_21 == 0;
    goto L32;

  anon20_Then:
    assume {:partition} pIrb_24 == 0;
    goto L28;

  anon22_Then:
    assume {:partition} ntStatus_41 != 259;
    goto L27;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_21 == 0;
    assume {:nonnull} deviceExtension_33 != 0;
    assume deviceExtension_33 > 0;
    havoc vslice_dummy_var_153;
    call {:si_unique_call 849} ntStatus_41 := t1394_SubmitIrpSynch(vslice_dummy_var_153, Irp_46, pIrb_24);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L27;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon24_Then:
    assume {:partition} pIrb_24 == 0;
    ntStatus_41 := -1073741670;
    goto L27;

  anon19_Then:
    assume {:partition} newIrp_22 == 0;
    ntStatus_41 := -1073741670;
    goto L27;

  anon23_Then:
    goto L16;
}



procedure {:origName "t1394_Get1394AddressFromDeviceObject"} t1394_Get1394AddressFromDeviceObject(actual_DeviceObject_49: int, actual_Irp_47: int, actual_fulFlags_9: int, actual_pNodeAddress: int) returns (Tmp_306: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_Get1394AddressFromDeviceObject"} t1394_Get1394AddressFromDeviceObject(actual_DeviceObject_49: int, actual_Irp_47: int, actual_fulFlags_9: int, actual_pNodeAddress: int) returns (Tmp_306: int)
{
  var {:pointer} sdv_291: int;
  var {:pointer} newIrp_23: int;
  var {:scalar} allocNewIrp_22: int;
  var {:scalar} Event_27: int;
  var {:scalar} ntStatus_42: int;
  var {:scalar} ioStatus_22: int;
  var {:pointer} deviceExtension_34: int;
  var {:pointer} pIrb_25: int;
  var {:pointer} DeviceObject_49: int;
  var {:pointer} Irp_47: int;
  var {:scalar} fulFlags_9: int;
  var {:pointer} pNodeAddress: int;
  var vslice_dummy_var_85: int;
  var vslice_dummy_var_154: int;
  var vslice_dummy_var_155: int;

  anon0:
    call {:si_unique_call 850} Event_27 := __HAVOC_malloc(156);
    call {:si_unique_call 851} ioStatus_22 := __HAVOC_malloc(12);
    DeviceObject_49 := actual_DeviceObject_49;
    Irp_47 := actual_Irp_47;
    fulFlags_9 := actual_fulFlags_9;
    pNodeAddress := actual_pNodeAddress;
    ntStatus_42 := 0;
    assume {:nonnull} DeviceObject_49 != 0;
    assume DeviceObject_49 > 0;
    havoc deviceExtension_34;
    pIrb_25 := 0;
    newIrp_23 := 0;
    allocNewIrp_22 := 0;
    call {:si_unique_call 852} sdv_291 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_25 := sdv_291;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} pIrb_25 != 0;
    assume {:nonnull} Irp_47 != 0;
    assume Irp_47 > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    call {:si_unique_call 853} newIrp_23 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_22);
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} newIrp_23 != 0;
    allocNewIrp_22 := 1;
    goto L22;

  L22:
    call {:si_unique_call 854} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_25 != 0;
    assume pIrb_25 > 0;
    assume {:nonnull} pIrb_25 != 0;
    assume pIrb_25 > 0;
    assume {:nonnull} pIrb_25 != 0;
    assume pIrb_25 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} allocNewIrp_22 != 0;
    call {:si_unique_call 855} KeInitializeEvent(Event_27, 0, 0);
    assume {:nonnull} deviceExtension_34 != 0;
    assume deviceExtension_34 > 0;
    havoc vslice_dummy_var_154;
    call {:si_unique_call 856} ntStatus_42 := t1394_SubmitIrpAsync(vslice_dummy_var_154, newIrp_23, pIrb_25);
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} yogi_error != 1;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} ntStatus_42 == 259;
    call {:si_unique_call 857} vslice_dummy_var_85 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_22 != 0;
    assume ioStatus_22 > 0;
    havoc ntStatus_42;
    goto L55;

  L55:
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} ntStatus_42 >= 0;
    assume {:nonnull} pIrb_25 != 0;
    assume pIrb_25 > 0;
    assume {:nonnull} pNodeAddress != 0;
    assume pNodeAddress > 0;
    assume {:nonnull} pIrb_25 != 0;
    assume pIrb_25 > 0;
    assume {:nonnull} pNodeAddress != 0;
    assume pNodeAddress > 0;
    goto L33;

  L33:
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} pIrb_25 != 0;
    call {:si_unique_call 858} sdv_ExFreePool(0);
    goto L34;

  L34:
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} allocNewIrp_22 != 0;
    assume {:nonnull} Irp_47 != 0;
    assume Irp_47 > 0;
    assume {:nonnull} ioStatus_22 != 0;
    assume ioStatus_22 > 0;
    assume {:nonnull} Irp_47 != 0;
    assume Irp_47 > 0;
    assume {:nonnull} ioStatus_22 != 0;
    assume ioStatus_22 > 0;
    assume {:nonnull} Irp_47 != 0;
    assume Irp_47 > 0;
    assume {:nonnull} ioStatus_22 != 0;
    assume ioStatus_22 > 0;
    goto L38;

  L38:
    Tmp_306 := ntStatus_42;
    goto LM2;

  LM2:
    return;

  anon24_Then:
    assume {:partition} allocNewIrp_22 == 0;
    goto L38;

  anon23_Then:
    assume {:partition} pIrb_25 == 0;
    goto L34;

  anon26_Then:
    assume {:partition} 0 > ntStatus_42;
    goto L33;

  anon25_Then:
    assume {:partition} ntStatus_42 != 259;
    goto L55;

  anon29_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon28_Then:
    assume {:partition} allocNewIrp_22 == 0;
    assume {:nonnull} deviceExtension_34 != 0;
    assume deviceExtension_34 > 0;
    havoc vslice_dummy_var_155;
    call {:si_unique_call 859} ntStatus_42 := t1394_SubmitIrpSynch(vslice_dummy_var_155, Irp_47, pIrb_25);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto L55;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon22_Then:
    assume {:partition} newIrp_23 == 0;
    ntStatus_42 := -1073741670;
    goto L33;

  anon21_Then:
    goto L22;

  anon27_Then:
    assume {:partition} pIrb_25 == 0;
    ntStatus_42 := -1073741670;
    goto L33;
}



procedure {:origName "t1394_GetGenerationCount"} t1394_GetGenerationCount(actual_DeviceObject_50: int, actual_Irp_48: int, actual_GenerationCount: int) returns (Tmp_308: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_GetGenerationCount"} t1394_GetGenerationCount(actual_DeviceObject_50: int, actual_Irp_48: int, actual_GenerationCount: int) returns (Tmp_308: int)
{
  var {:pointer} sdv_296: int;
  var {:pointer} newIrp_24: int;
  var {:scalar} allocNewIrp_23: int;
  var {:scalar} Event_28: int;
  var {:scalar} ntStatus_43: int;
  var {:scalar} sdv_301: int;
  var {:scalar} ioStatus_23: int;
  var {:pointer} deviceExtension_35: int;
  var {:pointer} pIrb_26: int;
  var {:pointer} DeviceObject_50: int;
  var {:pointer} Irp_48: int;
  var {:pointer} GenerationCount: int;
  var vslice_dummy_var_86: int;
  var vslice_dummy_var_156: int;
  var vslice_dummy_var_157: int;

  anon0:
    call {:si_unique_call 860} Event_28 := __HAVOC_malloc(156);
    call {:si_unique_call 861} ioStatus_23 := __HAVOC_malloc(12);
    DeviceObject_50 := actual_DeviceObject_50;
    Irp_48 := actual_Irp_48;
    GenerationCount := actual_GenerationCount;
    ntStatus_43 := 0;
    assume {:nonnull} DeviceObject_50 != 0;
    assume DeviceObject_50 > 0;
    havoc deviceExtension_35;
    pIrb_26 := 0;
    newIrp_24 := 0;
    allocNewIrp_23 := 0;
    call {:si_unique_call 862} sdv_296 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_26 := sdv_296;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} pIrb_26 != 0;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} Irp_48 != 0;
    assume {:nonnull} Irp_48 != 0;
    assume Irp_48 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    goto L26;

  L26:
    call {:si_unique_call 863} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_26 != 0;
    assume pIrb_26 > 0;
    assume {:nonnull} pIrb_26 != 0;
    assume pIrb_26 > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} allocNewIrp_23 != 0;
    call {:si_unique_call 864} KeInitializeEvent(Event_28, 0, 0);
    assume {:nonnull} deviceExtension_35 != 0;
    assume deviceExtension_35 > 0;
    havoc vslice_dummy_var_156;
    call {:si_unique_call 865} ntStatus_43 := t1394_SubmitIrpAsync(vslice_dummy_var_156, newIrp_24, pIrb_26);
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} yogi_error != 1;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} ntStatus_43 == 259;
    call {:si_unique_call 866} sdv_301 := sdv_KeGetCurrentIrql();
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} 2 > sdv_301;
    call {:si_unique_call 867} vslice_dummy_var_86 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_23 != 0;
    assume ioStatus_23 > 0;
    havoc ntStatus_43;
    goto L43;

  L43:
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} ntStatus_43 >= 0;
    assume {:nonnull} GenerationCount != 0;
    assume GenerationCount > 0;
    assume {:nonnull} pIrb_26 != 0;
    assume pIrb_26 > 0;
    goto L52;

  L52:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} pIrb_26 != 0;
    call {:si_unique_call 868} sdv_ExFreePool(0);
    goto L54;

  L54:
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} Irp_48 != 0;
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} allocNewIrp_23 != 0;
    assume {:nonnull} Irp_48 != 0;
    assume Irp_48 > 0;
    assume {:nonnull} ioStatus_23 != 0;
    assume ioStatus_23 > 0;
    assume {:nonnull} Irp_48 != 0;
    assume Irp_48 > 0;
    assume {:nonnull} ioStatus_23 != 0;
    assume ioStatus_23 > 0;
    assume {:nonnull} Irp_48 != 0;
    assume Irp_48 > 0;
    assume {:nonnull} ioStatus_23 != 0;
    assume ioStatus_23 > 0;
    goto L58;

  L58:
    Tmp_308 := ntStatus_43;
    goto LM2;

  LM2:
    return;

  anon34_Then:
    assume {:partition} allocNewIrp_23 == 0;
    goto L58;

  anon33_Then:
    assume {:partition} Irp_48 == 0;
    goto L58;

  anon32_Then:
    assume {:partition} pIrb_26 == 0;
    goto L54;

  anon30_Then:
    assume {:partition} 0 > ntStatus_43;
    goto L52;

  anon31_Then:
    assume {:partition} sdv_301 >= 2;
    goto L43;

  anon29_Then:
    assume {:partition} ntStatus_43 != 259;
    goto L43;

  anon38_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon37_Then:
    assume {:partition} allocNewIrp_23 == 0;
    assume {:nonnull} deviceExtension_35 != 0;
    assume deviceExtension_35 > 0;
    havoc vslice_dummy_var_157;
    call {:si_unique_call 869} ntStatus_43 := t1394_SubmitIrpSynch(vslice_dummy_var_157, Irp_48, pIrb_26);
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} yogi_error != 1;
    goto L43;

  anon39_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon28_Then:
    goto L22;

  L22:
    call {:si_unique_call 870} newIrp_24 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_23);
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} newIrp_24 != 0;
    allocNewIrp_23 := 1;
    goto L26;

  anon35_Then:
    assume {:partition} newIrp_24 == 0;
    ntStatus_43 := -1073741670;
    goto L52;

  anon27_Then:
    assume {:partition} Irp_48 == 0;
    goto L22;

  anon36_Then:
    assume {:partition} pIrb_26 == 0;
    ntStatus_43 := -1073741670;
    goto L52;
}



procedure {:origName "t1394_IsOnList"} t1394_IsOnList(actual_Entry_3: int, actual_List: int) returns (Tmp_310: int);
  free ensures Tmp_310 == 1 || Tmp_310 == 0;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsOnList"} t1394_IsOnList(actual_Entry_3: int, actual_List: int) returns (Tmp_310: int)
{
  var {:pointer} TempEntry: int;
  var {:pointer} List: int;

  anon0:
    List := actual_List;
    assume {:nonnull} List != 0;
    assume List > 0;
    havoc TempEntry;
    goto L5;

  L5:
    call {:si_unique_call 871} TempEntry := t1394_IsOnList_loop_L5(TempEntry);
    goto L5_last;

  L5_last:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    Tmp_310 := 1;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:nonnull} TempEntry != 0;
    assume TempEntry > 0;
    havoc TempEntry;
    goto anon6_Then_dummy;

  anon6_Then_dummy:
    assume false;
    return;

  anon5_Then:
    Tmp_310 := 0;
    goto L1;
}



procedure {:origName "t1394_IsochFreeChannel"} t1394_IsochFreeChannel(actual_DeviceObject_51: int, actual_Irp_49: int, actual_nChannel_2: int) returns (Tmp_312: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochFreeChannel"} t1394_IsochFreeChannel(actual_DeviceObject_51: int, actual_Irp_49: int, actual_nChannel_2: int) returns (Tmp_312: int)
{
  var {:pointer} sdv_302: int;
  var {:pointer} newIrp_25: int;
  var {:scalar} allocNewIrp_24: int;
  var {:scalar} Event_29: int;
  var {:scalar} ntStatus_44: int;
  var {:scalar} ioStatus_24: int;
  var {:pointer} deviceExtension_36: int;
  var {:pointer} pIrb_27: int;
  var {:pointer} DeviceObject_51: int;
  var {:pointer} Irp_49: int;
  var {:scalar} nChannel_2: int;
  var vslice_dummy_var_87: int;
  var vslice_dummy_var_158: int;
  var vslice_dummy_var_159: int;

  anon0:
    call {:si_unique_call 872} Event_29 := __HAVOC_malloc(156);
    call {:si_unique_call 873} ioStatus_24 := __HAVOC_malloc(12);
    DeviceObject_51 := actual_DeviceObject_51;
    Irp_49 := actual_Irp_49;
    nChannel_2 := actual_nChannel_2;
    ntStatus_44 := 0;
    assume {:nonnull} DeviceObject_51 != 0;
    assume DeviceObject_51 > 0;
    havoc deviceExtension_36;
    pIrb_27 := 0;
    newIrp_25 := 0;
    allocNewIrp_24 := 0;
    assume {:nonnull} Irp_49 != 0;
    assume Irp_49 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    call {:si_unique_call 874} newIrp_25 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_24);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} newIrp_25 != 0;
    allocNewIrp_24 := 1;
    goto L16;

  L16:
    call {:si_unique_call 875} sdv_302 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_27 := sdv_302;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_27 != 0;
    call {:si_unique_call 876} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_27 != 0;
    assume pIrb_27 > 0;
    assume {:nonnull} pIrb_27 != 0;
    assume pIrb_27 > 0;
    assume {:nonnull} pIrb_27 != 0;
    assume pIrb_27 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_24 != 0;
    call {:si_unique_call 877} KeInitializeEvent(Event_29, 0, 0);
    assume {:nonnull} deviceExtension_36 != 0;
    assume deviceExtension_36 > 0;
    havoc vslice_dummy_var_158;
    call {:si_unique_call 878} ntStatus_44 := t1394_SubmitIrpAsync(vslice_dummy_var_158, newIrp_25, pIrb_27);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} ntStatus_44 == 259;
    call {:si_unique_call 879} vslice_dummy_var_87 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_24 != 0;
    assume ioStatus_24 > 0;
    havoc ntStatus_44;
    goto L27;

  L27:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} pIrb_27 != 0;
    call {:si_unique_call 880} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} allocNewIrp_24 != 0;
    assume {:nonnull} Irp_49 != 0;
    assume Irp_49 > 0;
    assume {:nonnull} ioStatus_24 != 0;
    assume ioStatus_24 > 0;
    assume {:nonnull} Irp_49 != 0;
    assume Irp_49 > 0;
    assume {:nonnull} ioStatus_24 != 0;
    assume ioStatus_24 > 0;
    assume {:nonnull} Irp_49 != 0;
    assume Irp_49 > 0;
    assume {:nonnull} ioStatus_24 != 0;
    assume ioStatus_24 > 0;
    goto L32;

  L32:
    Tmp_312 := ntStatus_44;
    goto LM2;

  LM2:
    return;

  anon21_Then:
    assume {:partition} allocNewIrp_24 == 0;
    goto L32;

  anon20_Then:
    assume {:partition} pIrb_27 == 0;
    goto L28;

  anon22_Then:
    assume {:partition} ntStatus_44 != 259;
    goto L27;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_24 == 0;
    assume {:nonnull} deviceExtension_36 != 0;
    assume deviceExtension_36 > 0;
    havoc vslice_dummy_var_159;
    call {:si_unique_call 881} ntStatus_44 := t1394_SubmitIrpSynch(vslice_dummy_var_159, Irp_49, pIrb_27);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L27;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon24_Then:
    assume {:partition} pIrb_27 == 0;
    ntStatus_44 := -1073741670;
    goto L27;

  anon19_Then:
    assume {:partition} newIrp_25 == 0;
    ntStatus_44 := -1073741670;
    goto L27;

  anon23_Then:
    goto L16;
}



procedure {:origName "t1394_AllocateAddressRange"} t1394_AllocateAddressRange(actual_DeviceObject_52: int, actual_Irp_50: int, actual_fulAllocateFlags: int, actual_fulFlags_10: int, actual_nLength_1: int, actual_MaxSegmentSize: int, actual_fulAccessType: int, actual_fulNotificationOptions: int, actual_Required1394Offset: int, actual_phAddressRange: int, actual_Data_4: int) returns (Tmp_314: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_AllocateAddressRange"} t1394_AllocateAddressRange(actual_DeviceObject_52: int, actual_Irp_50: int, actual_fulAllocateFlags: int, actual_fulFlags_10: int, actual_nLength_1: int, actual_MaxSegmentSize: int, actual_fulAccessType: int, actual_fulNotificationOptions: int, actual_Required1394Offset: int, actual_phAddressRange: int, actual_Data_4: int) returns (Tmp_314: int)
{
  var {:scalar} i_7: int;
  var {:pointer} Tmp_315: int;
  var {:pointer} sdv_307: int;
  var {:pointer} pAsyncAddressData: int;
  var {:scalar} nPages: int;
  var {:pointer} newIrp_26: int;
  var {:scalar} allocNewIrp_25: int;
  var {:scalar} Event_30: int;
  var {:scalar} ntStatus_45: int;
  var {:pointer} Tmp_316: int;
  var {:pointer} sdv_312: int;
  var {:pointer} sdv_314: int;
  var {:scalar} Irql_9: int;
  var {:scalar} ioStatus_25: int;
  var {:scalar} Tmp_318: int;
  var {:scalar} Tmp_319: int;
  var {:pointer} Tmp_320: int;
  var {:pointer} deviceExtension_37: int;
  var {:pointer} pIrb_28: int;
  var {:pointer} DeviceObject_52: int;
  var {:pointer} Irp_50: int;
  var {:scalar} fulFlags_10: int;
  var {:scalar} nLength_1: int;
  var {:scalar} MaxSegmentSize: int;
  var {:scalar} fulAccessType: int;
  var {:scalar} fulNotificationOptions: int;
  var {:pointer} Required1394Offset: int;
  var {:pointer} phAddressRange: int;
  var {:pointer} Data_4: int;
  var boogieTmp: int;
  var vslice_dummy_var_88: int;
  var vslice_dummy_var_160: int;
  var vslice_dummy_var_161: int;

  anon0:
    call {:si_unique_call 882} Event_30 := __HAVOC_malloc(156);
    call {:si_unique_call 883} ioStatus_25 := __HAVOC_malloc(12);
    DeviceObject_52 := actual_DeviceObject_52;
    Irp_50 := actual_Irp_50;
    fulFlags_10 := actual_fulFlags_10;
    nLength_1 := actual_nLength_1;
    MaxSegmentSize := actual_MaxSegmentSize;
    fulAccessType := actual_fulAccessType;
    fulNotificationOptions := actual_fulNotificationOptions;
    Required1394Offset := actual_Required1394Offset;
    phAddressRange := actual_phAddressRange;
    Data_4 := actual_Data_4;
    ntStatus_45 := 0;
    assume {:nonnull} DeviceObject_52 != 0;
    assume DeviceObject_52 > 0;
    havoc deviceExtension_37;
    pIrb_28 := 0;
    pAsyncAddressData := 0;
    newIrp_26 := 0;
    allocNewIrp_25 := 0;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} nLength_1 != 0;
    assume {:nonnull} Irp_50 != 0;
    assume Irp_50 > 0;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    call {:si_unique_call 884} newIrp_26 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_25);
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} newIrp_26 != 0;
    allocNewIrp_25 := 1;
    goto L22;

  L22:
    call {:si_unique_call 885} sdv_307 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_28 := sdv_307;
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:partition} pIrb_28 != 0;
    call {:si_unique_call 886} sdv_312 := ExAllocatePoolWithTag(512, 36, -164023503);
    pAsyncAddressData := sdv_312;
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} pAsyncAddressData != 0;
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    call {:si_unique_call 887} boogieTmp := ExAllocatePoolWithTag(512, nLength_1, -164023503);
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} MaxSegmentSize != 0;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} 4096 != MaxSegmentSize;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} INTMOD(nLength_1, MaxSegmentSize) != 0;
    Tmp_319 := INTDIV(nLength_1, MaxSegmentSize) + 1;
    goto L61;

  L61:
    nPages := Tmp_319;
    goto L62;

  L62:
    Tmp_318 := 8 * nPages;
    call {:si_unique_call 888} sdv_314 := ExAllocatePoolWithTag(512, Tmp_318, -164023503);
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    call {:si_unique_call 889} boogieTmp := IoAllocateMdl(0, nLength_1, 0, 0, 0);
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    goto anon69_Then, anon69_Else;

  anon69_Else:
    call {:si_unique_call 890} sdv_RtlCopyMemory(0, 0, nLength_1);
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    call {:si_unique_call 891} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} Required1394Offset != 0;
    assume Required1394Offset > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} Required1394Offset != 0;
    assume Required1394Offset > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} allocNewIrp_25 != 0;
    call {:si_unique_call 892} KeInitializeEvent(Event_30, 0, 0);
    assume {:nonnull} deviceExtension_37 != 0;
    assume deviceExtension_37 > 0;
    havoc vslice_dummy_var_160;
    call {:si_unique_call 893} ntStatus_45 := t1394_SubmitIrpAsync(vslice_dummy_var_160, newIrp_26, pIrb_28);
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} yogi_error != 1;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} ntStatus_45 == 259;
    call {:si_unique_call 894} vslice_dummy_var_88 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_25 != 0;
    assume ioStatus_25 > 0;
    havoc ntStatus_45;
    goto L113;

  L113:
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} ntStatus_45 >= 0;
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    call {:si_unique_call 895} Tmp_320 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_320 != 0;
    assume Tmp_320 > 0;
    call {:si_unique_call 896} sdv_KeAcquireSpinLock(0, Tmp_320);
    assume {:nonnull} Tmp_320 != 0;
    assume Tmp_320 > 0;
    havoc Irql_9;
    assume {:nonnull} deviceExtension_37 != 0;
    assume deviceExtension_37 > 0;
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    call {:si_unique_call 897} InsertHeadList(AsyncAddressData__DEVICE_EXTENSION(deviceExtension_37), AsyncAddressList__ASYNC_ADDRESS_DATA(pAsyncAddressData));
    call {:si_unique_call 898} sdv_KeReleaseSpinLock(0, Irql_9);
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    assume {:nonnull} phAddressRange != 0;
    assume phAddressRange > 0;
    i_7 := 0;
    goto L134;

  L134:
    call {:si_unique_call 899} i_7 := t1394_AllocateAddressRange_loop_L134(i_7, pIrb_28);
    goto L134_last;

  L134_last:
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    i_7 := i_7 + 1;
    goto anon74_Else_dummy;

  anon74_Else_dummy:
    assume false;
    return;

  anon74_Then:
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    havoc Tmp_316;
    assume {:nonnull} Required1394Offset != 0;
    assume Required1394Offset > 0;
    assume {:nonnull} Tmp_316 != 0;
    assume Tmp_316 > 0;
    assume {:nonnull} pIrb_28 != 0;
    assume pIrb_28 > 0;
    havoc Tmp_315;
    assume {:nonnull} Required1394Offset != 0;
    assume Required1394Offset > 0;
    assume {:nonnull} Tmp_315 != 0;
    assume Tmp_315 > 0;
    goto L33;

  L33:
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} allocNewIrp_25 != 0;
    assume {:nonnull} Irp_50 != 0;
    assume Irp_50 > 0;
    assume {:nonnull} ioStatus_25 != 0;
    assume ioStatus_25 > 0;
    assume {:nonnull} Irp_50 != 0;
    assume Irp_50 > 0;
    assume {:nonnull} ioStatus_25 != 0;
    assume ioStatus_25 > 0;
    assume {:nonnull} Irp_50 != 0;
    assume Irp_50 > 0;
    assume {:nonnull} ioStatus_25 != 0;
    assume ioStatus_25 > 0;
    goto L34;

  L34:
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} pIrb_28 != 0;
    call {:si_unique_call 900} sdv_ExFreePool(0);
    goto L36;

  L36:
    Tmp_314 := ntStatus_45;
    goto LM2;

  LM2:
    return;

  anon62_Then:
    assume {:partition} pIrb_28 == 0;
    goto L36;

  anon61_Then:
    assume {:partition} allocNewIrp_25 == 0;
    goto L34;

  anon72_Then:
    assume {:partition} 0 > ntStatus_45;
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    call {:si_unique_call 901} IoFreeMdl(0);
    goto L138;

  L138:
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    call {:si_unique_call 902} sdv_ExFreePool(0);
    goto L142;

  L142:
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    call {:si_unique_call 903} sdv_ExFreePool(0);
    goto L146;

  L146:
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} pAsyncAddressData != 0;
    call {:si_unique_call 904} sdv_ExFreePool(0);
    goto L33;

  anon77_Then:
    assume {:partition} pAsyncAddressData == 0;
    goto L33;

  anon76_Then:
    goto L146;

  anon75_Then:
    goto L142;

  anon73_Then:
    goto L138;

  anon71_Then:
    assume {:partition} ntStatus_45 != 259;
    goto L113;

  anon86_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon85_Then:
    assume {:partition} allocNewIrp_25 == 0;
    assume {:nonnull} deviceExtension_37 != 0;
    assume deviceExtension_37 > 0;
    havoc vslice_dummy_var_161;
    call {:si_unique_call 905} ntStatus_45 := t1394_SubmitIrpSynch(vslice_dummy_var_161, Irp_50, pIrb_28);
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} yogi_error != 1;
    goto L113;

  anon87_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon69_Then:
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    call {:si_unique_call 906} sdv_ExFreePool(0);
    goto L154;

  L154:
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    goto anon78_Then, anon78_Else;

  anon78_Else:
    call {:si_unique_call 907} sdv_ExFreePool(0);
    goto L158;

  L158:
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} pAsyncAddressData != 0;
    call {:si_unique_call 908} sdv_ExFreePool(0);
    goto L162;

  L162:
    ntStatus_45 := -1073741670;
    goto L33;

  anon79_Then:
    assume {:partition} pAsyncAddressData == 0;
    goto L162;

  anon78_Then:
    goto L158;

  anon70_Then:
    goto L154;

  anon84_Then:
    assume {:nonnull} pAsyncAddressData != 0;
    assume pAsyncAddressData > 0;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    call {:si_unique_call 909} sdv_ExFreePool(0);
    goto L167;

  L167:
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} pAsyncAddressData != 0;
    call {:si_unique_call 910} sdv_ExFreePool(0);
    goto L171;

  L171:
    ntStatus_45 := -1073741670;
    goto L33;

  anon80_Then:
    assume {:partition} pAsyncAddressData == 0;
    goto L171;

  anon68_Then:
    goto L167;

  anon67_Then:
    assume {:partition} INTMOD(nLength_1, MaxSegmentSize) == 0;
    Tmp_319 := INTDIV(nLength_1, MaxSegmentSize);
    goto L61;

  anon66_Then:
    assume {:partition} 4096 == MaxSegmentSize;
    goto L56;

  L56:
    call {:si_unique_call 911} nPages := corral_nondet();
    goto L62;

  anon65_Then:
    assume {:partition} MaxSegmentSize == 0;
    goto L56;

  anon63_Then:
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} pAsyncAddressData != 0;
    call {:si_unique_call 912} sdv_ExFreePool(0);
    goto L177;

  L177:
    ntStatus_45 := -1073741670;
    goto L33;

  anon64_Then:
    assume {:partition} pAsyncAddressData == 0;
    goto L177;

  anon83_Then:
    assume {:partition} pAsyncAddressData == 0;
    ntStatus_45 := -1073741670;
    goto L33;

  anon82_Then:
    assume {:partition} pIrb_28 == 0;
    ntStatus_45 := -1073741670;
    goto L33;

  anon60_Then:
    assume {:partition} newIrp_26 == 0;
    ntStatus_45 := -1073741670;
    goto L33;

  anon59_Then:
    goto L22;

  anon81_Then:
    assume {:partition} nLength_1 == 0;
    ntStatus_45 := -1073741811;
    goto L33;
}



procedure {:origName "t1394_GetConfigurationInformation"} t1394_GetConfigurationInformation(actual_DeviceObject_53: int, actual_Irp_51: int) returns (Tmp_321: int);
  free ensures Tmp_321 == -1073741822;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_GetConfigurationInformation"} t1394_GetConfigurationInformation(actual_DeviceObject_53: int, actual_Irp_51: int) returns (Tmp_321: int)
{
  var {:pointer} DeviceObject_53: int;

  anon0:
    DeviceObject_53 := actual_DeviceObject_53;
    assume {:nonnull} DeviceObject_53 != 0;
    assume DeviceObject_53 > 0;
    Tmp_321 := -1073741822;
    return;
}



procedure {:origName "t1394_IsochStop"} t1394_IsochStop(actual_DeviceObject_54: int, actual_Irp_52: int, actual_hResource_6: int, actual_fulFlags_11: int) returns (Tmp_323: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_IsochStop"} t1394_IsochStop(actual_DeviceObject_54: int, actual_Irp_52: int, actual_hResource_6: int, actual_fulFlags_11: int) returns (Tmp_323: int)
{
  var {:pointer} sdv_316: int;
  var {:pointer} newIrp_28: int;
  var {:scalar} allocNewIrp_27: int;
  var {:scalar} Event_31: int;
  var {:scalar} ntStatus_47: int;
  var {:scalar} ioStatus_26: int;
  var {:pointer} deviceExtension_39: int;
  var {:pointer} pIrb_30: int;
  var {:pointer} DeviceObject_54: int;
  var {:pointer} Irp_52: int;
  var {:pointer} hResource_6: int;
  var {:scalar} fulFlags_11: int;
  var vslice_dummy_var_89: int;
  var vslice_dummy_var_162: int;
  var vslice_dummy_var_163: int;

  anon0:
    call {:si_unique_call 913} Event_31 := __HAVOC_malloc(156);
    call {:si_unique_call 914} ioStatus_26 := __HAVOC_malloc(12);
    DeviceObject_54 := actual_DeviceObject_54;
    Irp_52 := actual_Irp_52;
    hResource_6 := actual_hResource_6;
    fulFlags_11 := actual_fulFlags_11;
    ntStatus_47 := 0;
    assume {:nonnull} DeviceObject_54 != 0;
    assume DeviceObject_54 > 0;
    havoc deviceExtension_39;
    pIrb_30 := 0;
    newIrp_28 := 0;
    allocNewIrp_27 := 0;
    assume {:nonnull} Irp_52 != 0;
    assume Irp_52 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    call {:si_unique_call 915} newIrp_28 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_26);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} newIrp_28 != 0;
    allocNewIrp_27 := 1;
    goto L16;

  L16:
    call {:si_unique_call 916} sdv_316 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_30 := sdv_316;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_30 != 0;
    call {:si_unique_call 917} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_30 != 0;
    assume pIrb_30 > 0;
    assume {:nonnull} pIrb_30 != 0;
    assume pIrb_30 > 0;
    assume {:nonnull} pIrb_30 != 0;
    assume pIrb_30 > 0;
    assume {:nonnull} pIrb_30 != 0;
    assume pIrb_30 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_27 != 0;
    call {:si_unique_call 918} KeInitializeEvent(Event_31, 0, 0);
    assume {:nonnull} deviceExtension_39 != 0;
    assume deviceExtension_39 > 0;
    havoc vslice_dummy_var_162;
    call {:si_unique_call 919} ntStatus_47 := t1394_SubmitIrpAsync(vslice_dummy_var_162, newIrp_28, pIrb_30);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} ntStatus_47 == 259;
    call {:si_unique_call 920} vslice_dummy_var_89 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_26 != 0;
    assume ioStatus_26 > 0;
    havoc ntStatus_47;
    goto L27;

  L27:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} pIrb_30 != 0;
    call {:si_unique_call 921} sdv_ExFreePool(0);
    goto L28;

  L28:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} allocNewIrp_27 != 0;
    assume {:nonnull} Irp_52 != 0;
    assume Irp_52 > 0;
    assume {:nonnull} ioStatus_26 != 0;
    assume ioStatus_26 > 0;
    assume {:nonnull} Irp_52 != 0;
    assume Irp_52 > 0;
    assume {:nonnull} ioStatus_26 != 0;
    assume ioStatus_26 > 0;
    assume {:nonnull} Irp_52 != 0;
    assume Irp_52 > 0;
    assume {:nonnull} ioStatus_26 != 0;
    assume ioStatus_26 > 0;
    goto L32;

  L32:
    Tmp_323 := ntStatus_47;
    goto LM2;

  LM2:
    return;

  anon21_Then:
    assume {:partition} allocNewIrp_27 == 0;
    goto L32;

  anon20_Then:
    assume {:partition} pIrb_30 == 0;
    goto L28;

  anon22_Then:
    assume {:partition} ntStatus_47 != 259;
    goto L27;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_27 == 0;
    assume {:nonnull} deviceExtension_39 != 0;
    assume deviceExtension_39 > 0;
    havoc vslice_dummy_var_163;
    call {:si_unique_call 922} ntStatus_47 := t1394_SubmitIrpSynch(vslice_dummy_var_163, Irp_52, pIrb_30);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L27;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon24_Then:
    assume {:partition} pIrb_30 == 0;
    ntStatus_47 := -1073741670;
    goto L27;

  anon19_Then:
    assume {:partition} newIrp_28 == 0;
    ntStatus_47 := -1073741670;
    goto L27;

  anon23_Then:
    goto L16;
}



procedure {:origName "t1394_SetAddressData"} t1394_SetAddressData(actual_DeviceObject_55: int, actual_Irp_53: int, actual_hAddressRange_2: int, actual_nLength_2: int, actual_ulOffset_1: int, actual_Data_5: int) returns (Tmp_325: int);
  modifies alloc;
  free ensures Tmp_325 == 0 || Tmp_325 == -1073741811;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_SetAddressData"} t1394_SetAddressData(actual_DeviceObject_55: int, actual_Irp_53: int, actual_hAddressRange_2: int, actual_nLength_2: int, actual_ulOffset_1: int, actual_Data_5: int) returns (Tmp_325: int)
{
  var {:pointer} Tmp_326: int;
  var {:scalar} ntStatus_48: int;
  var {:pointer} AsyncAddressData_3: int;
  var {:scalar} Irql_10: int;
  var {:pointer} deviceExtension_40: int;
  var {:pointer} DeviceObject_55: int;
  var {:pointer} hAddressRange_2: int;
  var {:scalar} nLength_2: int;
  var {:scalar} ulOffset_1: int;

  anon0:
    DeviceObject_55 := actual_DeviceObject_55;
    hAddressRange_2 := actual_hAddressRange_2;
    nLength_2 := actual_nLength_2;
    ulOffset_1 := actual_ulOffset_1;
    ntStatus_48 := 0;
    assume {:nonnull} DeviceObject_55 != 0;
    assume DeviceObject_55 > 0;
    havoc deviceExtension_40;
    call {:si_unique_call 923} Tmp_326 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_326 != 0;
    assume Tmp_326 > 0;
    call {:si_unique_call 924} sdv_KeAcquireSpinLock(0, Tmp_326);
    assume {:nonnull} Tmp_326 != 0;
    assume Tmp_326 > 0;
    havoc Irql_10;
    assume {:nonnull} deviceExtension_40 != 0;
    assume deviceExtension_40 > 0;
    havoc AsyncAddressData_3;
    goto L13;

  L13:
    call {:si_unique_call 925} AsyncAddressData_3 := t1394_SetAddressData_loop_L13(AsyncAddressData_3, hAddressRange_2);
    goto L13_last;

  L13_last:
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} AsyncAddressData_3 != 0;
    assume {:nonnull} AsyncAddressData_3 != 0;
    assume AsyncAddressData_3 > 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:nonnull} AsyncAddressData_3 != 0;
    assume AsyncAddressData_3 > 0;
    call {:si_unique_call 926} sdv_RtlCopyMemory(0, 0, nLength_2);
    goto L14;

  L14:
    call {:si_unique_call 927} sdv_KeReleaseSpinLock(0, Irql_10);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} AsyncAddressData_3 != 0;
    goto L30;

  L30:
    Tmp_325 := ntStatus_48;
    return;

  anon12_Then:
    assume {:partition} AsyncAddressData_3 == 0;
    ntStatus_48 := -1073741811;
    goto L30;

  anon10_Then:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    AsyncAddressData_3 := 0;
    goto L14;

  anon11_Then:
    assume {:nonnull} AsyncAddressData_3 != 0;
    assume AsyncAddressData_3 > 0;
    havoc AsyncAddressData_3;
    goto anon11_Then_dummy;

  anon11_Then_dummy:
    assume false;
    return;

  anon9_Then:
    assume {:partition} AsyncAddressData_3 == 0;
    goto L14;
}



procedure {:origName "t1394_SendPhyConfigurationPacket"} t1394_SendPhyConfigurationPacket(actual_DeviceObject_56: int, actual_Irp_54: int, actual_structPtr888PhyConfigurationPacket: int) returns (Tmp_327: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_SendPhyConfigurationPacket"} t1394_SendPhyConfigurationPacket(actual_DeviceObject_56: int, actual_Irp_54: int, actual_structPtr888PhyConfigurationPacket: int) returns (Tmp_327: int)
{
  var {:scalar} PhyConfigurationPacket: int;
  var {:pointer} sdv_321: int;
  var {:pointer} newIrp_29: int;
  var {:scalar} allocNewIrp_28: int;
  var {:scalar} Event_32: int;
  var {:scalar} ntStatus_49: int;
  var {:scalar} ioStatus_27: int;
  var {:pointer} deviceExtension_41: int;
  var {:pointer} pIrb_31: int;
  var {:pointer} DeviceObject_56: int;
  var {:pointer} Irp_54: int;
  var {:pointer} structPtr888PhyConfigurationPacket: int;
  var vslice_dummy_var_90: int;
  var vslice_dummy_var_164: int;
  var vslice_dummy_var_165: int;

  anon0:
    call {:si_unique_call 928} PhyConfigurationPacket := __HAVOC_malloc(32);
    call {:si_unique_call 929} Event_32 := __HAVOC_malloc(156);
    call {:si_unique_call 930} ioStatus_27 := __HAVOC_malloc(12);
    DeviceObject_56 := actual_DeviceObject_56;
    Irp_54 := actual_Irp_54;
    structPtr888PhyConfigurationPacket := actual_structPtr888PhyConfigurationPacket;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} structPtr888PhyConfigurationPacket != 0;
    assume structPtr888PhyConfigurationPacket > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} structPtr888PhyConfigurationPacket != 0;
    assume structPtr888PhyConfigurationPacket > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} structPtr888PhyConfigurationPacket != 0;
    assume structPtr888PhyConfigurationPacket > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} structPtr888PhyConfigurationPacket != 0;
    assume structPtr888PhyConfigurationPacket > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} structPtr888PhyConfigurationPacket != 0;
    assume structPtr888PhyConfigurationPacket > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} structPtr888PhyConfigurationPacket != 0;
    assume structPtr888PhyConfigurationPacket > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} structPtr888PhyConfigurationPacket != 0;
    assume structPtr888PhyConfigurationPacket > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} structPtr888PhyConfigurationPacket != 0;
    assume structPtr888PhyConfigurationPacket > 0;
    ntStatus_49 := 0;
    assume {:nonnull} DeviceObject_56 != 0;
    assume DeviceObject_56 > 0;
    havoc deviceExtension_41;
    pIrb_31 := 0;
    newIrp_29 := 0;
    allocNewIrp_28 := 0;
    call {:si_unique_call 931} sdv_321 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_31 := sdv_321;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} pIrb_31 != 0;
    assume {:nonnull} Irp_54 != 0;
    assume Irp_54 > 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    call {:si_unique_call 932} newIrp_29 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_27);
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} newIrp_29 != 0;
    allocNewIrp_28 := 1;
    goto L22;

  L22:
    call {:si_unique_call 933} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    assume {:nonnull} PhyConfigurationPacket != 0;
    assume PhyConfigurationPacket > 0;
    assume {:nonnull} pIrb_31 != 0;
    assume pIrb_31 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} allocNewIrp_28 != 0;
    call {:si_unique_call 934} KeInitializeEvent(Event_32, 0, 0);
    assume {:nonnull} deviceExtension_41 != 0;
    assume deviceExtension_41 > 0;
    havoc vslice_dummy_var_164;
    call {:si_unique_call 935} ntStatus_49 := t1394_SubmitIrpAsync(vslice_dummy_var_164, newIrp_29, pIrb_31);
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} yogi_error != 1;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} ntStatus_49 == 259;
    call {:si_unique_call 936} vslice_dummy_var_90 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_27 != 0;
    assume ioStatus_27 > 0;
    havoc ntStatus_49;
    goto L33;

  L33:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} pIrb_31 != 0;
    call {:si_unique_call 937} sdv_ExFreePool(0);
    goto L34;

  L34:
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} allocNewIrp_28 != 0;
    assume {:nonnull} Irp_54 != 0;
    assume Irp_54 > 0;
    assume {:nonnull} ioStatus_27 != 0;
    assume ioStatus_27 > 0;
    assume {:nonnull} Irp_54 != 0;
    assume Irp_54 > 0;
    assume {:nonnull} ioStatus_27 != 0;
    assume ioStatus_27 > 0;
    assume {:nonnull} Irp_54 != 0;
    assume Irp_54 > 0;
    assume {:nonnull} ioStatus_27 != 0;
    assume ioStatus_27 > 0;
    goto L38;

  L38:
    Tmp_327 := ntStatus_49;
    goto LM2;

  LM2:
    return;

  anon22_Then:
    assume {:partition} allocNewIrp_28 == 0;
    goto L38;

  anon21_Then:
    assume {:partition} pIrb_31 == 0;
    goto L34;

  anon23_Then:
    assume {:partition} ntStatus_49 != 259;
    goto L33;

  anon26_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} allocNewIrp_28 == 0;
    assume {:nonnull} deviceExtension_41 != 0;
    assume deviceExtension_41 > 0;
    havoc vslice_dummy_var_165;
    call {:si_unique_call 938} ntStatus_49 := t1394_SubmitIrpSynch(vslice_dummy_var_165, Irp_54, pIrb_31);
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto L33;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon20_Then:
    assume {:partition} newIrp_29 == 0;
    ntStatus_49 := -1073741670;
    goto L33;

  anon19_Then:
    goto L22;

  anon24_Then:
    assume {:partition} pIrb_31 == 0;
    ntStatus_49 := -1073741670;
    goto L33;
}



procedure {:origName "t1394_AsyncLock"} t1394_AsyncLock(actual_DeviceObject_57: int, actual_Irp_55: int, actual_bRawMode_2: int, actual_bGetGeneration_2: int, actual_structPtr888DestinationAddress: int, actual_nNumberOfArgBytes: int, actual_nNumberOfDataBytes: int, actual_fulTransactionType: int, actual_fulFlags_12: int, actual_Arguments: int, actual_DataValues: int, actual_ulGeneration_2: int, actual_Buffer: int) returns (Tmp_329: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> yogi_error == 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 1 || yogi_error == old(yogi_error);
  free ensures wait_required == 1 || wait_required == 0 || wait_required == old(wait_required);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:origName "t1394_AsyncLock"} t1394_AsyncLock(actual_DeviceObject_57: int, actual_Irp_55: int, actual_bRawMode_2: int, actual_bGetGeneration_2: int, actual_structPtr888DestinationAddress: int, actual_nNumberOfArgBytes: int, actual_nNumberOfDataBytes: int, actual_fulTransactionType: int, actual_fulFlags_12: int, actual_Arguments: int, actual_DataValues: int, actual_ulGeneration_2: int, actual_Buffer: int) returns (Tmp_329: int)
{
  var {:scalar} DestinationAddress: int;
  var {:pointer} Tmp_330: int;
  var {:pointer} NextDeviceObject_2: int;
  var {:pointer} sdv_326: int;
  var {:pointer} Tmp_331: int;
  var {:pointer} newIrp_30: int;
  var {:scalar} allocNewIrp_29: int;
  var {:scalar} Event_33: int;
  var {:scalar} ntStatus_50: int;
  var {:pointer} Tmp_333: int;
  var {:scalar} ioStatus_28: int;
  var {:pointer} deviceExtension_42: int;
  var {:pointer} pIrb_32: int;
  var {:pointer} Tmp_334: int;
  var {:pointer} DeviceObject_57: int;
  var {:pointer} Irp_55: int;
  var {:scalar} bRawMode_2: int;
  var {:scalar} bGetGeneration_2: int;
  var {:pointer} structPtr888DestinationAddress: int;
  var {:scalar} nNumberOfArgBytes: int;
  var {:scalar} nNumberOfDataBytes: int;
  var {:scalar} fulTransactionType: int;
  var {:scalar} fulFlags_12: int;
  var {:pointer} Arguments: int;
  var {:pointer} DataValues: int;
  var {:scalar} ulGeneration_2: int;
  var {:pointer} Buffer: int;
  var vslice_dummy_var_91: int;

  anon0:
    call {:si_unique_call 939} DestinationAddress := __HAVOC_malloc(16);
    call {:si_unique_call 940} Event_33 := __HAVOC_malloc(156);
    call {:si_unique_call 941} ioStatus_28 := __HAVOC_malloc(12);
    DeviceObject_57 := actual_DeviceObject_57;
    Irp_55 := actual_Irp_55;
    bRawMode_2 := actual_bRawMode_2;
    bGetGeneration_2 := actual_bGetGeneration_2;
    structPtr888DestinationAddress := actual_structPtr888DestinationAddress;
    nNumberOfArgBytes := actual_nNumberOfArgBytes;
    nNumberOfDataBytes := actual_nNumberOfDataBytes;
    fulTransactionType := actual_fulTransactionType;
    fulFlags_12 := actual_fulFlags_12;
    Arguments := actual_Arguments;
    DataValues := actual_DataValues;
    ulGeneration_2 := actual_ulGeneration_2;
    Buffer := actual_Buffer;
    assume {:nonnull} DestinationAddress != 0;
    assume DestinationAddress > 0;
    assume {:nonnull} structPtr888DestinationAddress != 0;
    assume structPtr888DestinationAddress > 0;
    assume {:nonnull} DestinationAddress != 0;
    assume DestinationAddress > 0;
    assume {:nonnull} structPtr888DestinationAddress != 0;
    assume structPtr888DestinationAddress > 0;
    assume {:nonnull} DestinationAddress != 0;
    assume DestinationAddress > 0;
    assume {:nonnull} structPtr888DestinationAddress != 0;
    assume structPtr888DestinationAddress > 0;
    assume {:nonnull} DestinationAddress != 0;
    assume DestinationAddress > 0;
    assume {:nonnull} structPtr888DestinationAddress != 0;
    assume structPtr888DestinationAddress > 0;
    call {:si_unique_call 942} Tmp_330 := __HAVOC_malloc(8);
    call {:si_unique_call 943} Tmp_331 := __HAVOC_malloc(8);
    call {:si_unique_call 944} Tmp_333 := __HAVOC_malloc(8);
    call {:si_unique_call 945} Tmp_334 := __HAVOC_malloc(8);
    ntStatus_50 := 0;
    assume {:nonnull} DeviceObject_57 != 0;
    assume DeviceObject_57 > 0;
    havoc deviceExtension_42;
    pIrb_32 := 0;
    NextDeviceObject_2 := 0;
    newIrp_30 := 0;
    allocNewIrp_29 := 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} bRawMode_2 != 0;
    assume {:nonnull} deviceExtension_42 != 0;
    assume deviceExtension_42 > 0;
    havoc NextDeviceObject_2;
    goto L20;

  L20:
    assume {:nonnull} Irp_55 != 0;
    assume Irp_55 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    call {:si_unique_call 946} newIrp_30 := IoBuildDeviceIoControlRequest(2228765, 0, 0, 0, 0, 0, 1, 0, ioStatus_28);
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} newIrp_30 != 0;
    allocNewIrp_29 := 1;
    goto L21;

  L21:
    call {:si_unique_call 947} sdv_326 := ExAllocatePoolWithTag(512, 344, -164023503);
    pIrb_32 := sdv_326;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} pIrb_32 != 0;
    call {:si_unique_call 948} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} DestinationAddress != 0;
    assume DestinationAddress > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} DestinationAddress != 0;
    assume DestinationAddress > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} DestinationAddress != 0;
    assume DestinationAddress > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} DestinationAddress != 0;
    assume DestinationAddress > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    havoc Tmp_330;
    assume {:nonnull} Arguments != 0;
    assume Arguments > 0;
    assume {:nonnull} Tmp_330 != 0;
    assume Tmp_330 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    havoc Tmp_333;
    assume {:nonnull} Arguments != 0;
    assume Arguments > 0;
    assume {:nonnull} Tmp_333 != 0;
    assume Tmp_333 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    havoc Tmp_331;
    assume {:nonnull} DataValues != 0;
    assume DataValues > 0;
    assume {:nonnull} Tmp_331 != 0;
    assume Tmp_331 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    havoc Tmp_334;
    assume {:nonnull} DataValues != 0;
    assume DataValues > 0;
    assume {:nonnull} Tmp_334 != 0;
    assume Tmp_334 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} bGetGeneration_2 != 0;
    assume {:nonnull} deviceExtension_42 != 0;
    assume deviceExtension_42 > 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    goto L60;

  L60:
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} allocNewIrp_29 != 0;
    call {:si_unique_call 949} KeInitializeEvent(Event_33, 0, 0);
    call {:si_unique_call 950} ntStatus_50 := t1394_SubmitIrpAsync(NextDeviceObject_2, newIrp_30, pIrb_32);
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} yogi_error != 1;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} ntStatus_50 == 259;
    call {:si_unique_call 951} vslice_dummy_var_91 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    assume {:nonnull} ioStatus_28 != 0;
    assume ioStatus_28 > 0;
    havoc ntStatus_50;
    goto L72;

  L72:
    goto L32;

  L32:
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} pIrb_32 != 0;
    call {:si_unique_call 952} sdv_ExFreePool(0);
    goto L33;

  L33:
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} allocNewIrp_29 != 0;
    assume {:nonnull} Irp_55 != 0;
    assume Irp_55 > 0;
    assume {:nonnull} ioStatus_28 != 0;
    assume ioStatus_28 > 0;
    assume {:nonnull} Irp_55 != 0;
    assume Irp_55 > 0;
    assume {:nonnull} ioStatus_28 != 0;
    assume ioStatus_28 > 0;
    assume {:nonnull} Irp_55 != 0;
    assume Irp_55 > 0;
    assume {:nonnull} ioStatus_28 != 0;
    assume ioStatus_28 > 0;
    goto L37;

  L37:
    Tmp_329 := ntStatus_50;
    goto LM2;

  LM2:
    return;

  anon26_Then:
    assume {:partition} allocNewIrp_29 == 0;
    goto L37;

  anon25_Then:
    assume {:partition} pIrb_32 == 0;
    goto L33;

  anon28_Then:
    assume {:partition} ntStatus_50 != 259;
    goto L72;

  anon32_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon27_Then:
    assume {:partition} allocNewIrp_29 == 0;
    call {:si_unique_call 953} ntStatus_50 := t1394_SubmitIrpSynch(NextDeviceObject_2, Irp_55, pIrb_32);
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} yogi_error != 1;
    goto L32;

  anon33_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon31_Then:
    assume {:partition} bGetGeneration_2 == 0;
    assume {:nonnull} pIrb_32 != 0;
    assume pIrb_32 > 0;
    goto L60;

  anon30_Then:
    assume {:partition} pIrb_32 == 0;
    ntStatus_50 := -1073741670;
    goto L32;

  anon24_Then:
    assume {:partition} newIrp_30 == 0;
    ntStatus_50 := -1073741670;
    goto L32;

  anon23_Then:
    goto L21;

  anon29_Then:
    assume {:partition} bRawMode_2 == 0;
    assume {:nonnull} deviceExtension_42 != 0;
    assume deviceExtension_42 > 0;
    havoc NextDeviceObject_2;
    goto L20;
}



procedure {:dopa "Mem_T.INT4"} dummy_for_pa();



procedure corralExplainErrorInit();



procedure corralExtraInit();
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation corralExtraInit()
{

  anon0:
    assume 0 < alloc_init;
    assume alloc_init < alloc;
    return;
}



function {:inline true} {:fieldmap "Mem_T.AR_Off_High__ADDRESS_RANGE"} {:fieldname "AR_Off_High"} AR_Off_High__ADDRESS_RANGE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.AR_Off_Low__ADDRESS_RANGE"} {:fieldname "AR_Off_Low"} AR_Off_Low__ADDRESS_RANGE(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.AddressRange__ASYNC_ADDRESS_DATA"} {:fieldname "AddressRange"} AddressRange__ASYNC_ADDRESS_DATA(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.AddressesReturned__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "AddressesReturned"} AddressesReturned__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.AllocateAddressRange_unnamed_tag_68"} {:fieldname "AllocateAddressRange"} AllocateAddressRange_unnamed_tag_68(x: int) : int
{
  x + 472
}

function {:inline true} {:fieldmap "Mem_T.Argument1_unnamed_tag_42"} {:fieldname "Argument1"} Argument1_unnamed_tag_42(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Arguments__ASYNC_LOCK"} {:fieldname "Arguments"} Arguments__ASYNC_LOCK(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.Arguments__IRB_REQ_ASYNC_LOCK"} {:fieldname "Arguments"} Arguments__IRB_REQ_ASYNC_LOCK(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.AssociatedIrp__IRP"} {:fieldname "AssociatedIrp"} AssociatedIrp__IRP(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "AsyncAddressData"} AsyncAddressData__DEVICE_EXTENSION(x: int) : int
{
  x + 76
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "AsyncAddressList"} AsyncAddressList__ASYNC_ADDRESS_DATA(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.AsyncLock_unnamed_tag_68"} {:fieldname "AsyncLock"} AsyncLock_unnamed_tag_68(x: int) : int
{
  x + 112
}

function {:inline true} {:fieldmap "Mem_T.AsyncRead_unnamed_tag_68"} {:fieldname "AsyncRead"} AsyncRead_unnamed_tag_68(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.AsyncStream_unnamed_tag_68"} {:fieldname "AsyncStream"} AsyncStream_unnamed_tag_68(x: int) : int
{
  x + 1072
}

function {:inline true} {:fieldmap "Mem_T.AsyncWrite_unnamed_tag_68"} {:fieldname "AsyncWrite"} AsyncWrite_unnamed_tag_68(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.AttachIrb__ISOCH_DETACH_DATA"} {:fieldname "AttachIrb"} AttachIrb__ISOCH_DETACH_DATA(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.AttachStatus__ISOCH_DETACH_DATA"} {:fieldname "AttachStatus"} AttachStatus__ISOCH_DETACH_DATA(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Blink__LIST_ENTRY"} {:fieldname "Blink"} Blink__LIST_ENTRY(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Buffer__ASYNC_ADDRESS_DATA"} {:fieldname "Buffer"} Buffer__ASYNC_ADDRESS_DATA(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Buffer"} Buffer__ASYNC_LOCK(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.Buffer__CROM_DATA"} {:fieldname "Buffer"} Buffer__CROM_DATA(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "BusResetIrpList"} BusResetIrpList__BUS_RESET_IRP(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "BusResetIrps"} BusResetIrps__DEVICE_EXTENSION(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.BusResetNotification_unnamed_tag_68"} {:fieldname "BusResetNotification"} BusResetNotification_unnamed_tag_68(x: int) : int
{
  x + 1060
}

function {:inline true} {:fieldmap "Mem_T.BusReset_unnamed_tag_68"} {:fieldname "BusReset"} BusReset_unnamed_tag_68(x: int) : int
{
  x + 972
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "BytesPerFrameAvailable"} BytesPerFrameAvailable__IRB_REQ_ISOCH_QUERY_RESOURCES(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "BytesPerFrameAvailable"} BytesPerFrameAvailable__ISOCH_ALLOCATE_BANDWIDTH(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.CL_CycleCount__CYCLE_TIME"} {:fieldname "CL_CycleCount"} CL_CycleCount__CYCLE_TIME(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.CL_CycleOffset__CYCLE_TIME"} {:fieldname "CL_CycleOffset"} CL_CycleOffset__CYCLE_TIME(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.CL_SecondCount__CYCLE_TIME"} {:fieldname "CL_SecondCount"} CL_SecondCount__CYCLE_TIME(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Callback__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "Callback"} Callback__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.Callback__ISOCH_DESCRIPTOR"} {:fieldname "Callback"} Callback__ISOCH_DESCRIPTOR(x: int) : int
{
  x + 36
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

function {:inline true} {:fieldmap "Mem_T.ChannelMask__IRB_REQ_ISOCH_MODIFY_STREAM_PROPERTIES"} {:fieldname "ChannelMask"} ChannelMask__IRB_REQ_ISOCH_MODIFY_STREAM_PROPERTIES(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "Channel"} Channel__IRB_REQ_ISOCH_ALLOCATE_CHANNEL(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T._LARGE_INTEGER"} {:fieldname "ChannelsAvailable"} ChannelsAvailable__IRB_REQ_ISOCH_ALLOCATE_CHANNEL(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T._LARGE_INTEGER"} {:fieldname "ChannelsAvailable"} ChannelsAvailable__IRB_REQ_ISOCH_QUERY_RESOURCES(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.CompletionRoutine__IO_STACK_LOCATION"} {:fieldname "CompletionRoutine"} CompletionRoutine__IO_STACK_LOCATION(x: int) : int
{
  x + 536
}

function {:inline true} {:fieldmap "Mem_T.Context1__ISOCH_DESCRIPTOR"} {:fieldname "Context1"} Context1__ISOCH_DESCRIPTOR(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.Context2__ISOCH_DESCRIPTOR"} {:fieldname "Context2"} Context2__ISOCH_DESCRIPTOR(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.Context__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "Context"} Context__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "CromData"} CromData__DEVICE_EXTENSION(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "CromList"} CromList__CROM_DATA(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.CsrBaseAddress__GET_LOCAL_HOST_INFO6"} {:fieldname "CsrBaseAddress"} CsrBaseAddress__GET_LOCAL_HOST_INFO6(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.CsrDataBuffer__GET_LOCAL_HOST_INFO6"} {:fieldname "CsrDataBuffer"} CsrDataBuffer__GET_LOCAL_HOST_INFO6(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "CsrDataLength"} CsrDataLength__GET_LOCAL_HOST_INFO6(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.CurrentDevicePowerState__DEVICE_EXTENSION"} {:fieldname "CurrentDevicePowerState"} CurrentDevicePowerState__DEVICE_EXTENSION(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.CurrentStackLocation_unnamed_tag_6"} {:fieldname "CurrentStackLocation"} CurrentStackLocation_unnamed_tag_6(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.CycleTime__IRB_REQ_ISOCH_QUERY_CURRENT_CYCLE_TIME"} {:fieldname "CycleTime"} CycleTime__IRB_REQ_ISOCH_QUERY_CURRENT_CYCLE_TIME(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.CycleTime__ISOCH_DESCRIPTOR"} {:fieldname "CycleTime"} CycleTime__ISOCH_DESCRIPTOR(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.CycleTime__RING3_ISOCH_DESCRIPTOR"} {:fieldname "CycleTime"} CycleTime__RING3_ISOCH_DESCRIPTOR(x: int) : int
{
  x + 20
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

function {:inline true} {:fieldmap "Mem_T.DataValues__ASYNC_LOCK"} {:fieldname "DataValues"} DataValues__ASYNC_LOCK(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.DataValues__IRB_REQ_ASYNC_LOCK"} {:fieldname "DataValues"} DataValues__IRB_REQ_ASYNC_LOCK(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Data"} Data__ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Data"} Data__ASYNC_READ(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Data"} Data__ASYNC_STREAM(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Data"} Data__ASYNC_WRITE(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Data"} Data__SET_ADDRESS_DATA(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.DeferredRoutine__KDPC"} {:fieldname "DeferredRoutine"} DeferredRoutine__KDPC(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.DestinationAddress__ASYNC_LOCK"} {:fieldname "DestinationAddress"} DestinationAddress__ASYNC_LOCK(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DestinationAddress__ASYNC_READ"} {:fieldname "DestinationAddress"} DestinationAddress__ASYNC_READ(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DestinationAddress__ASYNC_WRITE"} {:fieldname "DestinationAddress"} DestinationAddress__ASYNC_WRITE(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DestinationAddress__IRB_REQ_ASYNC_LOCK"} {:fieldname "DestinationAddress"} DestinationAddress__IRB_REQ_ASYNC_LOCK(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DestinationAddress__IRB_REQ_ASYNC_READ"} {:fieldname "DestinationAddress"} DestinationAddress__IRB_REQ_ASYNC_READ(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DestinationAddress__IRB_REQ_ASYNC_WRITE"} {:fieldname "DestinationAddress"} DestinationAddress__IRB_REQ_ASYNC_WRITE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DetachIrb__ISOCH_DETACH_DATA"} {:fieldname "DetachIrb"} DetachIrb__ISOCH_DETACH_DATA(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.DeviceCapabilities_unnamed_tag_8"} {:fieldname "DeviceCapabilities"} DeviceCapabilities_unnamed_tag_8(x: int) : int
{
  x + 352
}

function {:inline true} {:fieldmap "Mem_T.DeviceExtension__ASYNC_ADDRESS_DATA"} {:fieldname "DeviceExtension"} DeviceExtension__ASYNC_ADDRESS_DATA(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DeviceExtension__DEVICE_OBJECT"} {:fieldname "DeviceExtension"} DeviceExtension__DEVICE_OBJECT(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.DeviceExtension__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "DeviceExtension"} DeviceExtension__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.DeviceExtension__IRB_REQ_FREE_ADDRESS_RANGE"} {:fieldname "DeviceExtension"} DeviceExtension__IRB_REQ_FREE_ADDRESS_RANGE(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.DeviceExtension__ISOCH_DETACH_DATA"} {:fieldname "DeviceExtension"} DeviceExtension__ISOCH_DETACH_DATA(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DeviceIoControl_unnamed_tag_8"} {:fieldname "DeviceIoControl"} DeviceIoControl_unnamed_tag_8(x: int) : int
{
  x + 256
}

function {:inline true} {:fieldmap "Mem_T.DeviceObject__POWER_COMPLETION_CONTEXT"} {:fieldname "DeviceObject"} DeviceObject__POWER_COMPLETION_CONTEXT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DeviceState__POWER_STATE"} {:fieldname "DeviceState"} DeviceState__POWER_STATE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.FifoSListHead__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "FifoSListHead"} FifoSListHead__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.FifoSpinLock__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "FifoSpinLock"} FifoSpinLock__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.Flags__IRB"} {:fieldname "Flags"} Flags__IRB(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Flink__LIST_ENTRY"} {:fieldname "Flink"} Flink__LIST_ENTRY(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.FreeAddressRange_unnamed_tag_68"} {:fieldname "FreeAddressRange"} FreeAddressRange_unnamed_tag_68(x: int) : int
{
  x + 536
}

function {:inline true} {:fieldmap "Mem_T.FunctionNumber__IRB"} {:fieldname "FunctionNumber"} FunctionNumber__IRB(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.GenerationCount__DEVICE_EXTENSION"} {:fieldname "GenerationCount"} GenerationCount__DEVICE_EXTENSION(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.GenerationCount__IRB_REQ_GET_GENERATION_COUNT"} {:fieldname "GenerationCount"} GenerationCount__IRB_REQ_GET_GENERATION_COUNT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Get1394AddressFromDeviceObject_unnamed_tag_68"} {:fieldname "Get1394AddressFromDeviceObject"} Get1394AddressFromDeviceObject_unnamed_tag_68(x: int) : int
{
  x + 560
}

function {:inline true} {:fieldmap "Mem_T.GetGenerationCount_unnamed_tag_68"} {:fieldname "GetGenerationCount"} GetGenerationCount_unnamed_tag_68(x: int) : int
{
  x + 976
}

function {:inline true} {:fieldmap "Mem_T.GetLocalHostInformation_unnamed_tag_68"} {:fieldname "GetLocalHostInformation"} GetLocalHostInformation_unnamed_tag_68(x: int) : int
{
  x + 552
}

function {:inline true} {:fieldmap "Mem_T.GetMaxSpeedBetweenDevices_unnamed_tag_68"} {:fieldname "GetMaxSpeedBetweenDevices"} GetMaxSpeedBetweenDevices_unnamed_tag_68(x: int) : int
{
  x + 596
}

function {:inline true} {:fieldmap "Mem_T.Header__KEVENT"} {:fieldname "Header"} Header__KEVENT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.HighPart__LUID"} {:fieldname "HighPart"} HighPart__LUID(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.IA_Destination_ID__IO_ADDRESS"} {:fieldname "IA_Destination_ID"} IA_Destination_ID__IO_ADDRESS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.IA_Destination_Offset__IO_ADDRESS"} {:fieldname "IA_Destination_Offset"} IA_Destination_Offset__IO_ADDRESS(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Information"} Information__GET_LOCAL_HOST_INFORMATION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Information__IO_STATUS_BLOCK"} {:fieldname "Information"} Information__IO_STATUS_BLOCK(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Information__IRB_REQ_GET_LOCAL_HOST_INFORMATION"} {:fieldname "Information"} Information__IRB_REQ_GET_LOCAL_HOST_INFORMATION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.PINT4"} {:fieldname "Information"} Information__SET_LOCAL_HOST_INFORMATION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.InputBufferLength_unnamed_tag_22"} {:fieldname "InputBufferLength"} InputBufferLength_unnamed_tag_22(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.IoControlCode_unnamed_tag_22"} {:fieldname "IoControlCode"} IoControlCode_unnamed_tag_22(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T._IO_STATUS_BLOCK"} {:fieldname "IoStatus"} IoStatus__IRP(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.Irp__BUS_RESET_IRP"} {:fieldname "Irp"} Irp__BUS_RESET_IRP(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Irp__ISOCH_DETACH_DATA"} {:fieldname "Irp"} Irp__ISOCH_DETACH_DATA(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.IsochAllocateBandwidth_unnamed_tag_68"} {:fieldname "IsochAllocateBandwidth"} IsochAllocateBandwidth_unnamed_tag_68(x: int) : int
{
  x + 184
}

function {:inline true} {:fieldmap "Mem_T.IsochAllocateChannel_unnamed_tag_68"} {:fieldname "IsochAllocateChannel"} IsochAllocateChannel_unnamed_tag_68(x: int) : int
{
  x + 208
}

function {:inline true} {:fieldmap "Mem_T.IsochAllocateResources_unnamed_tag_68"} {:fieldname "IsochAllocateResources"} IsochAllocateResources_unnamed_tag_68(x: int) : int
{
  x + 236
}

function {:inline true} {:fieldmap "Mem_T.IsochAttachBuffers_unnamed_tag_68"} {:fieldname "IsochAttachBuffers"} IsochAttachBuffers_unnamed_tag_68(x: int) : int
{
  x + 288
}

function {:inline true} {:fieldmap "Mem_T.IsochDescriptor__ISOCH_DETACH_DATA"} {:fieldname "IsochDescriptor"} IsochDescriptor__ISOCH_DETACH_DATA(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.IsochDetachBuffers_unnamed_tag_68"} {:fieldname "IsochDetachBuffers"} IsochDetachBuffers_unnamed_tag_68(x: int) : int
{
  x + 300
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "IsochDetachData"} IsochDetachData__DEVICE_EXTENSION(x: int) : int
{
  x + 84
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "IsochDetachList"} IsochDetachList__ISOCH_DETACH_DATA(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.IsochFreeBandwidth_unnamed_tag_68"} {:fieldname "IsochFreeBandwidth"} IsochFreeBandwidth_unnamed_tag_68(x: int) : int
{
  x + 312
}

function {:inline true} {:fieldmap "Mem_T.IsochFreeChannel_unnamed_tag_68"} {:fieldname "IsochFreeChannel"} IsochFreeChannel_unnamed_tag_68(x: int) : int
{
  x + 336
}

function {:inline true} {:fieldmap "Mem_T.IsochFreeResources_unnamed_tag_68"} {:fieldname "IsochFreeResources"} IsochFreeResources_unnamed_tag_68(x: int) : int
{
  x + 340
}

function {:inline true} {:fieldmap "Mem_T.IsochListen_unnamed_tag_68"} {:fieldname "IsochListen"} IsochListen_unnamed_tag_68(x: int) : int
{
  x + 344
}

function {:inline true} {:fieldmap "Mem_T.IsochModifyStreamProperties_unnamed_tag_68"} {:fieldname "IsochModifyStreamProperties"} IsochModifyStreamProperties_unnamed_tag_68(x: int) : int
{
  x + 444
}

function {:inline true} {:fieldmap "Mem_T.IsochQueryCurrentCycleTime_unnamed_tag_68"} {:fieldname "IsochQueryCurrentCycleTime"} IsochQueryCurrentCycleTime_unnamed_tag_68(x: int) : int
{
  x + 364
}

function {:inline true} {:fieldmap "Mem_T.IsochQueryResources_unnamed_tag_68"} {:fieldname "IsochQueryResources"} IsochQueryResources_unnamed_tag_68(x: int) : int
{
  x + 376
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "IsochResourceData"} IsochResourceData__DEVICE_EXTENSION(x: int) : int
{
  x + 92
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "IsochResourceList"} IsochResourceList__ISOCH_RESOURCE_DATA(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.IsochSetChannelBandwidth_unnamed_tag_68"} {:fieldname "IsochSetChannelBandwidth"} IsochSetChannelBandwidth_unnamed_tag_68(x: int) : int
{
  x + 404
}

function {:inline true} {:fieldmap "Mem_T.IsochStop_unnamed_tag_68"} {:fieldname "IsochStop"} IsochStop_unnamed_tag_68(x: int) : int
{
  x + 416
}

function {:inline true} {:fieldmap "Mem_T.IsochTalk_unnamed_tag_68"} {:fieldname "IsochTalk"} IsochTalk_unnamed_tag_68(x: int) : int
{
  x + 424
}

function {:inline true} {:fieldmap "Mem_T.List__WORK_QUEUE_ITEM"} {:fieldname "List"} List__WORK_QUEUE_ITEM(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.LowPart__LUID"} {:fieldname "LowPart"} LowPart__LUID(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.MajorFunction__IO_STACK_LOCATION"} {:fieldname "MajorFunction"} MajorFunction__IO_STACK_LOCATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.MaxSegmentSize__ALLOCATE_ADDRESS_RANGE"} {:fieldname "MaxSegmentSize"} MaxSegmentSize__ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.MaxSegmentSize__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "MaxSegmentSize"} MaxSegmentSize__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Mdl__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "Mdl"} Mdl__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Mdl__IRB_REQ_ASYNC_READ"} {:fieldname "Mdl"} Mdl__IRB_REQ_ASYNC_READ(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.Mdl__IRB_REQ_ASYNC_STREAM"} {:fieldname "Mdl"} Mdl__IRB_REQ_ASYNC_STREAM(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Mdl__IRB_REQ_ASYNC_WRITE"} {:fieldname "Mdl"} Mdl__IRB_REQ_ASYNC_WRITE(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.Mdl__ISOCH_DESCRIPTOR"} {:fieldname "Mdl"} Mdl__ISOCH_DESCRIPTOR(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Mdl__SET_LOCAL_HOST_PROPS3"} {:fieldname "Mdl"} Mdl__SET_LOCAL_HOST_PROPS3(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.MinorFunction__IO_STACK_LOCATION"} {:fieldname "MinorFunction"} MinorFunction__IO_STACK_LOCATION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.NA_Bus_Number__NODE_ADDRESS"} {:fieldname "NA_Bus_Number"} NA_Bus_Number__NODE_ADDRESS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.NA_Node_Number__NODE_ADDRESS"} {:fieldname "NA_Node_Number"} NA_Node_Number__NODE_ADDRESS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._NODE_ADDRESS"} {:fieldname "NodeAddress"} NodeAddress__GET_1394_ADDRESS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Off_High__ADDRESS_OFFSET"} {:fieldname "Off_High"} Off_High__ADDRESS_OFFSET(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Off_Low__ADDRESS_OFFSET"} {:fieldname "Off_Low"} Off_Low__ADDRESS_OFFSET(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Others_unnamed_tag_8"} {:fieldname "Others"} Others_unnamed_tag_8(x: int) : int
{
  x + 496
}

function {:inline true} {:fieldmap "Mem_T.OutputBufferLength_unnamed_tag_22"} {:fieldname "OutputBufferLength"} OutputBufferLength_unnamed_tag_22(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Overlay_unnamed_tag_5"} {:fieldname "Overlay"} Overlay_unnamed_tag_5(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.PCP_Force_Root__PHY_CONFIGURATION_PACKET"} {:fieldname "PCP_Force_Root"} PCP_Force_Root__PHY_CONFIGURATION_PACKET(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.PCP_Gap_Count__PHY_CONFIGURATION_PACKET"} {:fieldname "PCP_Gap_Count"} PCP_Gap_Count__PHY_CONFIGURATION_PACKET(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.PCP_Inverse__PHY_CONFIGURATION_PACKET"} {:fieldname "PCP_Inverse"} PCP_Inverse__PHY_CONFIGURATION_PACKET(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.PCP_Packet_ID__PHY_CONFIGURATION_PACKET"} {:fieldname "PCP_Packet_ID"} PCP_Packet_ID__PHY_CONFIGURATION_PACKET(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.PCP_Phys_ID__PHY_CONFIGURATION_PACKET"} {:fieldname "PCP_Phys_ID"} PCP_Phys_ID__PHY_CONFIGURATION_PACKET(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.PCP_Reserved1__PHY_CONFIGURATION_PACKET"} {:fieldname "PCP_Reserved1"} PCP_Reserved1__PHY_CONFIGURATION_PACKET(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.PCP_Reserved2__PHY_CONFIGURATION_PACKET"} {:fieldname "PCP_Reserved2"} PCP_Reserved2__PHY_CONFIGURATION_PACKET(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.PCP_Set_Gap_Count__PHY_CONFIGURATION_PACKET"} {:fieldname "PCP_Set_Gap_Count"} PCP_Set_Gap_Count__PHY_CONFIGURATION_PACKET(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Parameters__IO_STACK_LOCATION"} {:fieldname "Parameters"} Parameters__IO_STACK_LOCATION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.PendingReturned__IRP"} {:fieldname "PendingReturned"} PendingReturned__IRP(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.PhyConfigurationPacket__IRB_REQ_SEND_PHY_CONFIGURATION_PACKET"} {:fieldname "PhyConfigurationPacket"} PhyConfigurationPacket__IRB_REQ_SEND_PHY_CONFIGURATION_PACKET(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Pointer__IO_STATUS_BLOCK"} {:fieldname "Pointer"} Pointer__IO_STATUS_BLOCK(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.PortDeviceObject__DEVICE_EXTENSION"} {:fieldname "PortDeviceObject"} PortDeviceObject__DEVICE_EXTENSION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Power_unnamed_tag_8"} {:fieldname "Power"} Power_unnamed_tag_8(x: int) : int
{
  x + 420
}

function {:inline true} {:fieldmap "Mem_T.QuadPart__LARGE_INTEGER"} {:fieldname "QuadPart"} QuadPart__LARGE_INTEGER(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.QuadPart__ULARGE_INTEGER"} {:fieldname "QuadPart"} QuadPart__ULARGE_INTEGER(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.P_RING3_ISOCH_DESCRIPTOR"} {:fieldname "R3_IsochDescriptor"} R3_IsochDescriptor__ISOCH_ATTACH_BUFFERS(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.RequestorMode__IRP"} {:fieldname "RequestorMode"} RequestorMode__IRP(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T._ADDRESS_OFFSET"} {:fieldname "Required1394Offset"} Required1394Offset__ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.Required1394Offset__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "Required1394Offset"} Required1394Offset__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.ResetContext__IRB_REQ_BUS_RESET_NOTIFICATION"} {:fieldname "ResetContext"} ResetContext__IRB_REQ_BUS_RESET_NOTIFICATION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.ResetRoutine__IRB_REQ_BUS_RESET_NOTIFICATION"} {:fieldname "ResetRoutine"} ResetRoutine__IRB_REQ_BUS_RESET_NOTIFICATION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.SIrp__POWER_COMPLETION_CONTEXT"} {:fieldname "SIrp"} SIrp__POWER_COMPLETION_CONTEXT(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.SendPhyConfigurationPacket_unnamed_tag_68"} {:fieldname "SendPhyConfigurationPacket"} SendPhyConfigurationPacket_unnamed_tag_68(x: int) : int
{
  x + 980
}

function {:inline true} {:fieldmap "Mem_T.SetDeviceXmitProperties_unnamed_tag_68"} {:fieldname "SetDeviceXmitProperties"} SetDeviceXmitProperties_unnamed_tag_68(x: int) : int
{
  x + 864
}

function {:inline true} {:fieldmap "Mem_T.SetLocalHostProperties_unnamed_tag_68"} {:fieldname "SetLocalHostProperties"} SetLocalHostProperties_unnamed_tag_68(x: int) : int
{
  x + 872
}

function {:inline true} {:fieldmap "Mem_T.SignalState__DISPATCHER_HEADER"} {:fieldname "SignalState"} SignalState__DISPATCHER_HEADER(x: int) : int
{
  x + 144
}

function {:inline true} {:fieldmap "Mem_T.Signalling__DISPATCHER_HEADER"} {:fieldname "Signalling"} Signalling__DISPATCHER_HEADER(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Size__DISPATCHER_HEADER"} {:fieldname "Size"} Size__DISPATCHER_HEADER(x: int) : int
{
  x + 100
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "SpeedSelected"} SpeedSelected__ISOCH_ALLOCATE_BANDWIDTH(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.StackDeviceObject__DEVICE_EXTENSION"} {:fieldname "StackDeviceObject"} StackDeviceObject__DEVICE_EXTENSION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.StackSize__DEVICE_OBJECT"} {:fieldname "StackSize"} StackSize__DEVICE_OBJECT(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.StartTime__IRB_REQ_ISOCH_LISTEN"} {:fieldname "StartTime"} StartTime__IRB_REQ_ISOCH_LISTEN(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.State_unnamed_tag_39"} {:fieldname "State"} State_unnamed_tag_39(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "Status"} Status__GET_LOCAL_HOST_INFORMATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Status__IO_STATUS_BLOCK"} {:fieldname "Status"} Status__IO_STATUS_BLOCK(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.SurpriseRemovalOK__DEVICE_CAPABILITIES"} {:fieldname "SurpriseRemovalOK"} SurpriseRemovalOK__DEVICE_CAPABILITIES(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.SystemBuffer_unnamed_tag_1"} {:fieldname "SystemBuffer"} SystemBuffer_unnamed_tag_1(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.SystemState__POWER_STATE"} {:fieldname "SystemState"} SystemState__POWER_STATE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Tail__IRP"} {:fieldname "Tail"} Tail__IRP(x: int) : int
{
  x + 128
}

function {:inline true} {:fieldmap "Mem_T._KDPC"} {:fieldname "TimerDpc"} TimerDpc__ISOCH_DETACH_DATA(x: int) : int
{
  x + 228
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_28"} {:fieldname "Type"} Type_unnamed_tag_28(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_39"} {:fieldname "Type"} Type_unnamed_tag_39(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.WorkItem__IO_WORKITEM"} {:fieldname "WorkItem"} WorkItem__IO_WORKITEM(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.bAutoDetach__RING3_ISOCH_DESCRIPTOR"} {:fieldname "bAutoDetach"} bAutoDetach__RING3_ISOCH_DESCRIPTOR(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.bDetach__ISOCH_DETACH_DATA"} {:fieldname "bDetach"} bDetach__ISOCH_DETACH_DATA(x: int) : int
{
  x + 284
}

function {:inline true} {:fieldmap "Mem_T.bGetGeneration__ASYNC_LOCK"} {:fieldname "bGetGeneration"} bGetGeneration__ASYNC_LOCK(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.bGetGeneration__ASYNC_READ"} {:fieldname "bGetGeneration"} bGetGeneration__ASYNC_READ(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.bGetGeneration__ASYNC_WRITE"} {:fieldname "bGetGeneration"} bGetGeneration__ASYNC_WRITE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.bRawMode__ASYNC_LOCK"} {:fieldname "bRawMode"} bRawMode__ASYNC_LOCK(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.bRawMode__ASYNC_READ"} {:fieldname "bRawMode"} bRawMode__ASYNC_READ(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.bRawMode__ASYNC_WRITE"} {:fieldname "bRawMode"} bRawMode__ASYNC_WRITE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.bShutdown__DEVICE_EXTENSION"} {:fieldname "bShutdown"} bShutdown__DEVICE_EXTENSION(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.bUseCallback__RING3_ISOCH_DESCRIPTOR"} {:fieldname "bUseCallback"} bUseCallback__RING3_ISOCH_DESCRIPTOR(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.fulAccessType__ALLOCATE_ADDRESS_RANGE"} {:fieldname "fulAccessType"} fulAccessType__ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.fulAccessType__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "fulAccessType"} fulAccessType__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.fulAllocateFlags__ALLOCATE_ADDRESS_RANGE"} {:fieldname "fulAllocateFlags"} fulAllocateFlags__ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__ALLOCATE_ADDRESS_RANGE"} {:fieldname "fulFlags"} fulFlags__ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__ASYNC_LOCK"} {:fieldname "fulFlags"} fulFlags__ASYNC_LOCK(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__ASYNC_READ"} {:fieldname "fulFlags"} fulFlags__ASYNC_READ(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__ASYNC_STREAM"} {:fieldname "fulFlags"} fulFlags__ASYNC_STREAM(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__ASYNC_WRITE"} {:fieldname "fulFlags"} fulFlags__ASYNC_WRITE(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "fulFlags"} fulFlags__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__IRB_REQ_ASYNC_LOCK"} {:fieldname "fulFlags"} fulFlags__IRB_REQ_ASYNC_LOCK(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__IRB_REQ_ASYNC_READ"} {:fieldname "fulFlags"} fulFlags__IRB_REQ_ASYNC_READ(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__IRB_REQ_ASYNC_STREAM"} {:fieldname "fulFlags"} fulFlags__IRB_REQ_ASYNC_STREAM(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__IRB_REQ_ASYNC_WRITE"} {:fieldname "fulFlags"} fulFlags__IRB_REQ_ASYNC_WRITE(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__IRB_REQ_BUS_RESET"} {:fieldname "fulFlags"} fulFlags__IRB_REQ_BUS_RESET(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__IRB_REQ_ISOCH_STOP"} {:fieldname "fulFlags"} fulFlags__IRB_REQ_ISOCH_STOP(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.fulFlags__ISOCH_ALLOCATE_RESOURCES"} {:fieldname "fulFlags"} fulFlags__ISOCH_ALLOCATE_RESOURCES(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.fulNotificationOptions__ALLOCATE_ADDRESS_RANGE"} {:fieldname "fulNotificationOptions"} fulNotificationOptions__ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.fulNotificationOptions__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "fulNotificationOptions"} fulNotificationOptions__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.fulPriority__DEVICE_XMIT_PROPERTIES"} {:fieldname "fulPriority"} fulPriority__DEVICE_XMIT_PROPERTIES(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.fulSpeed__DEVICE_XMIT_PROPERTIES"} {:fieldname "fulSpeed"} fulSpeed__DEVICE_XMIT_PROPERTIES(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "fulSpeed"} fulSpeed__GET_MAX_SPEED_BETWEEN_DEVICES(x: int) : int
{
  x + 264
}

function {:inline true} {:fieldmap "Mem_T.fulSpeed__IRB_REQ_GET_MAX_SPEED_BETWEEN_DEVICES"} {:fieldname "fulSpeed"} fulSpeed__IRB_REQ_GET_MAX_SPEED_BETWEEN_DEVICES(x: int) : int
{
  x + 264
}

function {:inline true} {:fieldmap "Mem_T.fulSpeed__IRB_REQ_ISOCH_MODIFY_STREAM_PROPERTIES"} {:fieldname "fulSpeed"} fulSpeed__IRB_REQ_ISOCH_MODIFY_STREAM_PROPERTIES(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.fulSpeed__IRB_REQ_ISOCH_QUERY_RESOURCES"} {:fieldname "fulSpeed"} fulSpeed__IRB_REQ_ISOCH_QUERY_RESOURCES(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.fulSpeed__ISOCH_ALLOCATE_BANDWIDTH"} {:fieldname "fulSpeed"} fulSpeed__ISOCH_ALLOCATE_BANDWIDTH(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.fulSpeed__ISOCH_ALLOCATE_RESOURCES"} {:fieldname "fulSpeed"} fulSpeed__ISOCH_ALLOCATE_RESOURCES(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.fulTransactionType__ASYNC_LOCK"} {:fieldname "fulTransactionType"} fulTransactionType__ASYNC_LOCK(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.fulTransactionType__IRB_REQ_ASYNC_LOCK"} {:fieldname "fulTransactionType"} fulTransactionType__IRB_REQ_ASYNC_LOCK(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.PVOID"} {:fieldname "hAddressRange"} hAddressRange__ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.PVOID"} {:fieldname "hAddressRange"} hAddressRange__ASYNC_ADDRESS_DATA(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.hAddressRange__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "hAddressRange"} hAddressRange__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.hAddressRange__SET_ADDRESS_DATA"} {:fieldname "hAddressRange"} hAddressRange__SET_ADDRESS_DATA(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.hBandwidth__IRB_REQ_ISOCH_FREE_BANDWIDTH"} {:fieldname "hBandwidth"} hBandwidth__IRB_REQ_ISOCH_FREE_BANDWIDTH(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.PVOID"} {:fieldname "hBandwidth"} hBandwidth__ISOCH_ALLOCATE_BANDWIDTH(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.hBandwidth__ISOCH_SET_CHANNEL_BANDWIDTH"} {:fieldname "hBandwidth"} hBandwidth__ISOCH_SET_CHANNEL_BANDWIDTH(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.hCromData__CROM_DATA"} {:fieldname "hCromData"} hCromData__CROM_DATA(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.hCromData__SET_LOCAL_HOST_PROPS3"} {:fieldname "hCromData"} hCromData__SET_LOCAL_HOST_PROPS3(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.hDestinationDeviceObjects__GET_MAX_SPEED_BETWEEN_DEVICES"} {:fieldname "hDestinationDeviceObjects"} hDestinationDeviceObjects__GET_MAX_SPEED_BETWEEN_DEVICES(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.hDestinationDeviceObjects__IRB_REQ_GET_MAX_SPEED_BETWEEN_DEVICES"} {:fieldname "hDestinationDeviceObjects"} hDestinationDeviceObjects__IRB_REQ_GET_MAX_SPEED_BETWEEN_DEVICES(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.hResource__IRB_REQ_ISOCH_FREE_RESOURCES"} {:fieldname "hResource"} hResource__IRB_REQ_ISOCH_FREE_RESOURCES(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.PVOID"} {:fieldname "hResource"} hResource__ISOCH_ALLOCATE_RESOURCES(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.hResource__ISOCH_DETACH_DATA"} {:fieldname "hResource"} hResource__ISOCH_DETACH_DATA(x: int) : int
{
  x + 272
}

function {:inline true} {:fieldmap "Mem_T.hResource__ISOCH_RESOURCE_DATA"} {:fieldname "hResource"} hResource__ISOCH_RESOURCE_DATA(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.nAddressesReturned__ASYNC_ADDRESS_DATA"} {:fieldname "nAddressesReturned"} nAddressesReturned__ASYNC_ADDRESS_DATA(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.nAddressesToFree__IRB_REQ_FREE_ADDRESS_RANGE"} {:fieldname "nAddressesToFree"} nAddressesToFree__IRB_REQ_FREE_ADDRESS_RANGE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.nBlockSize__ASYNC_READ"} {:fieldname "nBlockSize"} nBlockSize__ASYNC_READ(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.nBlockSize__ASYNC_WRITE"} {:fieldname "nBlockSize"} nBlockSize__ASYNC_WRITE(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.nBlockSize__IRB_REQ_ASYNC_READ"} {:fieldname "nBlockSize"} nBlockSize__IRB_REQ_ASYNC_READ(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.nBlockSize__IRB_REQ_ASYNC_WRITE"} {:fieldname "nBlockSize"} nBlockSize__IRB_REQ_ASYNC_WRITE(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.nChannel__ASYNC_STREAM"} {:fieldname "nChannel"} nChannel__ASYNC_STREAM(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.nChannel__IRB_REQ_ASYNC_STREAM"} {:fieldname "nChannel"} nChannel__IRB_REQ_ASYNC_STREAM(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.nChannel__IRB_REQ_ISOCH_FREE_CHANNEL"} {:fieldname "nChannel"} nChannel__IRB_REQ_ISOCH_FREE_CHANNEL(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.nChannel__ISOCH_ALLOCATE_RESOURCES"} {:fieldname "nChannel"} nChannel__ISOCH_ALLOCATE_RESOURCES(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.nLength__ALLOCATE_ADDRESS_RANGE"} {:fieldname "nLength"} nLength__ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.nLength__ASYNC_ADDRESS_DATA"} {:fieldname "nLength"} nLength__ASYNC_ADDRESS_DATA(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.nLength__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "nLength"} nLength__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.nLength__SET_ADDRESS_DATA"} {:fieldname "nLength"} nLength__SET_ADDRESS_DATA(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.nLength__SET_LOCAL_HOST_PROPS3"} {:fieldname "nLength"} nLength__SET_LOCAL_HOST_PROPS3(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.nLevel__GET_LOCAL_HOST_INFORMATION"} {:fieldname "nLevel"} nLevel__GET_LOCAL_HOST_INFORMATION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.nLevel__IRB_REQ_GET_LOCAL_HOST_INFORMATION"} {:fieldname "nLevel"} nLevel__IRB_REQ_GET_LOCAL_HOST_INFORMATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.nLevel__SET_LOCAL_HOST_INFORMATION"} {:fieldname "nLevel"} nLevel__SET_LOCAL_HOST_INFORMATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.nMaxBufferSize__ISOCH_ALLOCATE_RESOURCES"} {:fieldname "nMaxBufferSize"} nMaxBufferSize__ISOCH_ALLOCATE_RESOURCES(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.nMaxBytesPerFrameRequested__ISOCH_ALLOCATE_BANDWIDTH"} {:fieldname "nMaxBytesPerFrameRequested"} nMaxBytesPerFrameRequested__ISOCH_ALLOCATE_BANDWIDTH(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.nMaxBytesPerFrame__ISOCH_ALLOCATE_RESOURCES"} {:fieldname "nMaxBytesPerFrame"} nMaxBytesPerFrame__ISOCH_ALLOCATE_RESOURCES(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.nMaxBytesPerFrame__ISOCH_DESCRIPTOR"} {:fieldname "nMaxBytesPerFrame"} nMaxBytesPerFrame__ISOCH_DESCRIPTOR(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.nMaxBytesPerFrame__ISOCH_SET_CHANNEL_BANDWIDTH"} {:fieldname "nMaxBytesPerFrame"} nMaxBytesPerFrame__ISOCH_SET_CHANNEL_BANDWIDTH(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.nMaxBytesPerFrame__RING3_ISOCH_DESCRIPTOR"} {:fieldname "nMaxBytesPerFrame"} nMaxBytesPerFrame__RING3_ISOCH_DESCRIPTOR(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfArgBytes__ASYNC_LOCK"} {:fieldname "nNumberOfArgBytes"} nNumberOfArgBytes__ASYNC_LOCK(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfArgBytes__IRB_REQ_ASYNC_LOCK"} {:fieldname "nNumberOfArgBytes"} nNumberOfArgBytes__IRB_REQ_ASYNC_LOCK(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfBuffers__ISOCH_ALLOCATE_RESOURCES"} {:fieldname "nNumberOfBuffers"} nNumberOfBuffers__ISOCH_ALLOCATE_RESOURCES(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfBytesToRead__ASYNC_READ"} {:fieldname "nNumberOfBytesToRead"} nNumberOfBytesToRead__ASYNC_READ(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfBytesToRead__IRB_REQ_ASYNC_READ"} {:fieldname "nNumberOfBytesToRead"} nNumberOfBytesToRead__IRB_REQ_ASYNC_READ(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfBytesToStream__ASYNC_STREAM"} {:fieldname "nNumberOfBytesToStream"} nNumberOfBytesToStream__ASYNC_STREAM(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfBytesToStream__IRB_REQ_ASYNC_STREAM"} {:fieldname "nNumberOfBytesToStream"} nNumberOfBytesToStream__IRB_REQ_ASYNC_STREAM(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfBytesToWrite__ASYNC_WRITE"} {:fieldname "nNumberOfBytesToWrite"} nNumberOfBytesToWrite__ASYNC_WRITE(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfBytesToWrite__IRB_REQ_ASYNC_WRITE"} {:fieldname "nNumberOfBytesToWrite"} nNumberOfBytesToWrite__IRB_REQ_ASYNC_WRITE(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfDataBytes__ASYNC_LOCK"} {:fieldname "nNumberOfDataBytes"} nNumberOfDataBytes__ASYNC_LOCK(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfDataBytes__IRB_REQ_ASYNC_LOCK"} {:fieldname "nNumberOfDataBytes"} nNumberOfDataBytes__IRB_REQ_ASYNC_LOCK(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfDescriptors__IRB_REQ_ISOCH_ATTACH_BUFFERS"} {:fieldname "nNumberOfDescriptors"} nNumberOfDescriptors__IRB_REQ_ISOCH_ATTACH_BUFFERS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfDescriptors__ISOCH_ATTACH_BUFFERS"} {:fieldname "nNumberOfDescriptors"} nNumberOfDescriptors__ISOCH_ATTACH_BUFFERS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.nNumberOfDescriptors__ISOCH_DETACH_BUFFERS"} {:fieldname "nNumberOfDescriptors"} nNumberOfDescriptors__ISOCH_DETACH_BUFFERS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.nQuadletsToStrip__ISOCH_ALLOCATE_RESOURCES"} {:fieldname "nQuadletsToStrip"} nQuadletsToStrip__ISOCH_ALLOCATE_RESOURCES(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.nRequestedChannel__IRB_REQ_ISOCH_ALLOCATE_CHANNEL"} {:fieldname "nRequestedChannel"} nRequestedChannel__IRB_REQ_ISOCH_ALLOCATE_CHANNEL(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.nSpeed__ASYNC_STREAM"} {:fieldname "nSpeed"} nSpeed__ASYNC_STREAM(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.nSpeed__IRB_REQ_ASYNC_STREAM"} {:fieldname "nSpeed"} nSpeed__IRB_REQ_ASYNC_STREAM(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.newIrp__ISOCH_DETACH_DATA"} {:fieldname "newIrp"} newIrp__ISOCH_DETACH_DATA(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.numIsochDescriptors__ISOCH_DETACH_DATA"} {:fieldname "numIsochDescriptors"} numIsochDescriptors__ISOCH_DETACH_DATA(x: int) : int
{
  x + 276
}

function {:inline true} {:fieldmap "Mem_T.outputBufferLength__ISOCH_DETACH_DATA"} {:fieldname "outputBufferLength"} outputBufferLength__ISOCH_DETACH_DATA(x: int) : int
{
  x + 280
}

function {:inline true} {:fieldmap "Mem_T.p1394AddressRange__IRB_REQ_ALLOCATE_ADDRESS_RANGE"} {:fieldname "p1394AddressRange"} p1394AddressRange__IRB_REQ_ALLOCATE_ADDRESS_RANGE(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.p1394AddressRange__IRB_REQ_FREE_ADDRESS_RANGE"} {:fieldname "p1394AddressRange"} p1394AddressRange__IRB_REQ_FREE_ADDRESS_RANGE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.pAddressRange__IRB_REQ_FREE_ADDRESS_RANGE"} {:fieldname "pAddressRange"} pAddressRange__IRB_REQ_FREE_ADDRESS_RANGE(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.pBuffer__IRB_REQ_ASYNC_LOCK"} {:fieldname "pBuffer"} pBuffer__IRB_REQ_ASYNC_LOCK(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.pIsochDescriptor__IRB_REQ_ISOCH_ATTACH_BUFFERS"} {:fieldname "pIsochDescriptor"} pIsochDescriptor__IRB_REQ_ISOCH_ATTACH_BUFFERS(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.pIsochDescriptor__ISOCH_ATTACH_BUFFERS"} {:fieldname "pIsochDescriptor"} pIsochDescriptor__ISOCH_ATTACH_BUFFERS(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.pIsochDescriptor__ISOCH_DETACH_BUFFERS"} {:fieldname "pIsochDescriptor"} pIsochDescriptor__ISOCH_DETACH_BUFFERS(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.pMdl__ASYNC_ADDRESS_DATA"} {:fieldname "pMdl"} pMdl__ASYNC_ADDRESS_DATA(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.pMdl__CROM_DATA"} {:fieldname "pMdl"} pMdl__CROM_DATA(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.u__IRB"} {:fieldname "u"} u__IRB(x: int) : int
{
  x + 72
}

function {:inline true} {:fieldmap "Mem_T.u__LARGE_INTEGER"} {:fieldname "u"} u__LARGE_INTEGER(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.u__ULARGE_INTEGER"} {:fieldname "u"} u__ULARGE_INTEGER(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.ulBufferSize__SET_LOCAL_HOST_INFORMATION"} {:fieldname "ulBufferSize"} ulBufferSize__SET_LOCAL_HOST_INFORMATION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.ulGeneration__ASYNC_LOCK"} {:fieldname "ulGeneration"} ulGeneration__ASYNC_LOCK(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.ulGeneration__ASYNC_READ"} {:fieldname "ulGeneration"} ulGeneration__ASYNC_READ(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.ulGeneration__ASYNC_WRITE"} {:fieldname "ulGeneration"} ulGeneration__ASYNC_WRITE(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.ulGeneration__IRB_REQ_ASYNC_LOCK"} {:fieldname "ulGeneration"} ulGeneration__IRB_REQ_ASYNC_LOCK(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.ulGeneration__IRB_REQ_ASYNC_READ"} {:fieldname "ulGeneration"} ulGeneration__IRB_REQ_ASYNC_READ(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.ulLength__ISOCH_DESCRIPTOR"} {:fieldname "ulLength"} ulLength__ISOCH_DESCRIPTOR(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.ulLength__RING3_ISOCH_DESCRIPTOR"} {:fieldname "ulLength"} ulLength__RING3_ISOCH_DESCRIPTOR(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.ulNumberOfDestinations__GET_MAX_SPEED_BETWEEN_DEVICES"} {:fieldname "ulNumberOfDestinations"} ulNumberOfDestinations__GET_MAX_SPEED_BETWEEN_DEVICES(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.ulNumberOfDestinations__IRB_REQ_GET_MAX_SPEED_BETWEEN_DEVICES"} {:fieldname "ulNumberOfDestinations"} ulNumberOfDestinations__IRB_REQ_GET_MAX_SPEED_BETWEEN_DEVICES(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.ulOffset__SET_ADDRESS_DATA"} {:fieldname "ulOffset"} ulOffset__SET_ADDRESS_DATA(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.ulSubVersion__VERSION_DATA"} {:fieldname "ulSubVersion"} ulSubVersion__VERSION_DATA(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.ulSynch__ASYNC_STREAM"} {:fieldname "ulSynch"} ulSynch__ASYNC_STREAM(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.ulSynch__IRB_REQ_ASYNC_STREAM"} {:fieldname "ulSynch"} ulSynch__IRB_REQ_ASYNC_STREAM(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.ulSynch__ISOCH_DESCRIPTOR"} {:fieldname "ulSynch"} ulSynch__ISOCH_DESCRIPTOR(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.ulSynch__RING3_ISOCH_DESCRIPTOR"} {:fieldname "ulSynch"} ulSynch__RING3_ISOCH_DESCRIPTOR(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.ulTag__ASYNC_STREAM"} {:fieldname "ulTag"} ulTag__ASYNC_STREAM(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.ulTag__IRB_REQ_ASYNC_STREAM"} {:fieldname "ulTag"} ulTag__IRB_REQ_ASYNC_STREAM(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.ulTag__ISOCH_DESCRIPTOR"} {:fieldname "ulTag"} ulTag__ISOCH_DESCRIPTOR(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.ulTag__RING3_ISOCH_DESCRIPTOR"} {:fieldname "ulTag"} ulTag__RING3_ISOCH_DESCRIPTOR(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.ulVersion__VERSION_DATA"} {:fieldname "ulVersion"} ulVersion__VERSION_DATA(x: int) : int
{
  x + 0
}

const {:string "Wait is required as the dispatch routine could complete a pending irp."} unique strConst__li2bpl2: int;

const {:string "callee"} unique strConst__li2bpl3: int;

const {:string "caller"} unique strConst__li2bpl0: int;

const {:string "halt"} unique strConst__li2bpl1: int;

const {:allocated} li2bplFunctionConstant176: int;

axiom li2bplFunctionConstant176 == 176;

const {:allocated} li2bplFunctionConstant178: int;

axiom li2bplFunctionConstant178 == 178;

const {:allocated} li2bplFunctionConstant189: int;

axiom li2bplFunctionConstant189 == 189;

const {:allocated} li2bplFunctionConstant203: int;

axiom li2bplFunctionConstant203 == 203;

const {:allocated} li2bplFunctionConstant204: int;

axiom li2bplFunctionConstant204 == 204;

const {:allocated} li2bplFunctionConstant205: int;

axiom li2bplFunctionConstant205 == 205;

const {:allocated} li2bplFunctionConstant218: int;

axiom li2bplFunctionConstant218 == 218;

const {:allocated} li2bplFunctionConstant226: int;

axiom li2bplFunctionConstant226 == 226;

const {:allocated} li2bplFunctionConstant387: int;

axiom li2bplFunctionConstant387 == 387;

const {:allocated} li2bplFunctionConstant388: int;

axiom li2bplFunctionConstant388 == 388;

const {:allocated} li2bplFunctionConstant457: int;

axiom li2bplFunctionConstant457 == 457;

const {:allocated} li2bplFunctionConstant459: int;

axiom li2bplFunctionConstant459 == 459;

const {:allocated} li2bplFunctionConstant462: int;

axiom li2bplFunctionConstant462 == 462;

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

implementation t1394VDev_IoControl_loop_L350(in_i: int, in_inputBufferLength: int, in_IsochAttachBuffers: int, in_pTempR3Desc: int, in_ulBuffSize: int) returns (out_i: int, out_pTempR3Desc: int, out_ulBuffSize: int)
{

  entry:
    out_i, out_pTempR3Desc, out_ulBuffSize := in_i, in_pTempR3Desc, in_ulBuffSize;
    goto L350, exit;

  exit:
    return;

  L350:
    assume {:nonnull} in_IsochAttachBuffers != 0;
    assume in_IsochAttachBuffers > 0;
    goto anon353_Else;

  anon353_Else:
    goto anon355_Then;

  anon355_Then:
    assume {:partition} BAND(out_pTempR3Desc, 3) == 0;
    goto anon356_Then;

  anon356_Then:
    assume {:partition} out_ulBuffSize + 36 >= out_ulBuffSize;
    out_ulBuffSize := out_ulBuffSize + 36;
    goto anon431_Then;

  anon431_Then:
    assume {:partition} in_inputBufferLength >= out_ulBuffSize;
    assume {:nonnull} out_pTempR3Desc != 0;
    assume out_pTempR3Desc > 0;
    goto anon357_Then;

  anon357_Then:
    assume {:nonnull} out_pTempR3Desc != 0;
    assume out_pTempR3Desc > 0;
    havoc out_ulBuffSize;
    goto anon432_Then;

  anon432_Then:
    assume {:partition} in_inputBufferLength >= out_ulBuffSize;
    assume {:nonnull} out_pTempR3Desc != 0;
    assume out_pTempR3Desc > 0;
    havoc out_pTempR3Desc;
    out_i := out_i + 1;
    goto anon432_Then_dummy;

  anon432_Then_dummy:
    call {:si_unique_call 954} {:si_old_unique_call 1} out_i, out_pTempR3Desc, out_ulBuffSize := t1394VDev_IoControl_loop_L350(out_i, in_inputBufferLength, in_IsochAttachBuffers, out_pTempR3Desc, out_ulBuffSize);
    return;
}



procedure {:LoopProcedure} t1394VDev_IoControl_loop_L350(in_i: int, in_inputBufferLength: int, in_IsochAttachBuffers: int, in_pTempR3Desc: int, in_ulBuffSize: int) returns (out_i: int, out_pTempR3Desc: int, out_ulBuffSize: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394VDev_PnpRemoveDevice_loop_L126(in_sdv_48: int, in_Tmp_29: int, in_sdv_58: int, in_BusResetIrp_1: int, in_deviceExtension_2: int, in_vslice_dummy_var_3: int) returns (out_sdv_48: int, out_Tmp_29: int, out_sdv_58: int, out_BusResetIrp_1: int, out_vslice_dummy_var_3: int)
{
  var vslice_dummy_var_166: int;

  entry:
    out_sdv_48, out_Tmp_29, out_sdv_58, out_BusResetIrp_1, out_vslice_dummy_var_3 := in_sdv_48, in_Tmp_29, in_sdv_58, in_BusResetIrp_1, in_vslice_dummy_var_3;
    goto L126, exit;

  exit:
    return;

  L126:
    call {:si_unique_call 955} out_sdv_48 := sdv_IsListEmpty(0);
    goto anon49_Else;

  anon49_Else:
    assume {:partition} out_sdv_48 == 0;
    assume {:nonnull} in_deviceExtension_2 != 0;
    assume in_deviceExtension_2 > 0;
    call {:si_unique_call 958} out_sdv_58 := RemoveHeadList(BusResetIrps__DEVICE_EXTENSION(in_deviceExtension_2));
    out_BusResetIrp_1 := out_sdv_58;
    assume {:nonnull} out_BusResetIrp_1 != 0;
    assume out_BusResetIrp_1 > 0;
    havoc vslice_dummy_var_166;
    call {:si_unique_call 959} out_vslice_dummy_var_3 := sdv_IoSetCancelRoutine(vslice_dummy_var_166, 0);
    assume {:nonnull} out_BusResetIrp_1 != 0;
    assume out_BusResetIrp_1 > 0;
    havoc out_Tmp_29;
    assume {:nonnull} out_Tmp_29 != 0;
    assume out_Tmp_29 > 0;
    assume {:nonnull} out_BusResetIrp_1 != 0;
    assume out_BusResetIrp_1 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume SLAM_guard_S_0 != SLAM_guard_S_0_init;
    call {:si_unique_call 960} SLIC_sdv_IoCompleteRequest_entry(strConst__li2bpl0);
    goto anon57_Else;

  anon57_Else:
    assume {:partition} yogi_error != 1;
    goto L213;

  L213:
    call {:si_unique_call 956} sdv_IoCompleteRequest(0, 0);
    call {:si_unique_call 957} sdv_ExFreePool(0);
    goto L213_dummy;

  L213_dummy:
    call {:si_unique_call 961} {:si_old_unique_call 1} out_sdv_48, out_Tmp_29, out_sdv_58, out_BusResetIrp_1, out_vslice_dummy_var_3 := t1394VDev_PnpRemoveDevice_loop_L126(out_sdv_48, out_Tmp_29, out_sdv_58, out_BusResetIrp_1, in_deviceExtension_2, out_vslice_dummy_var_3);
    return;

  anon56_Then:
    goto L213;
}



procedure {:LoopProcedure} t1394VDev_PnpRemoveDevice_loop_L126(in_sdv_48: int, in_Tmp_29: int, in_sdv_58: int, in_BusResetIrp_1: int, in_deviceExtension_2: int, in_vslice_dummy_var_3: int) returns (out_sdv_48: int, out_Tmp_29: int, out_sdv_58: int, out_BusResetIrp_1: int, out_vslice_dummy_var_3: int);
  modifies alloc, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures alloc == old(alloc);
  free ensures yogi_error == old(yogi_error);
  free ensures out_sdv_48 == in_sdv_48;
  free ensures out_Tmp_29 == in_Tmp_29;
  free ensures out_sdv_58 == in_sdv_58;
  free ensures out_BusResetIrp_1 == in_BusResetIrp_1;
  free ensures out_vslice_dummy_var_3 == in_vslice_dummy_var_3;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394VDev_PnpRemoveDevice_loop_L72(in_IsochResourceData: int, in_Tmp_28: int, in_ResourceIrp: int, in_sdv_51: int, in_sdv_52: int, in_StackSize: int, in_ntStatus_2: int, in_sdv_54: int, in_Tmp_30: int, in_Irql_1: int, in_deviceExtension_2: int, in_pIrb: int) returns (out_IsochResourceData: int, out_Tmp_28: int, out_ResourceIrp: int, out_sdv_51: int, out_sdv_52: int, out_StackSize: int, out_ntStatus_2: int, out_sdv_54: int, out_Tmp_30: int, out_Irql_1: int, out_pIrb: int)
{
  var vslice_dummy_var_167: int;

  entry:
    out_IsochResourceData, out_Tmp_28, out_ResourceIrp, out_sdv_51, out_sdv_52, out_StackSize, out_ntStatus_2, out_sdv_54, out_Tmp_30, out_Irql_1, out_pIrb := in_IsochResourceData, in_Tmp_28, in_ResourceIrp, in_sdv_51, in_sdv_52, in_StackSize, in_ntStatus_2, in_sdv_54, in_Tmp_30, in_Irql_1, in_pIrb;
    goto L72, exit;

  exit:
    return;

  L72:
    call {:si_unique_call 962} out_Tmp_30 := __HAVOC_malloc(4);
    assume {:nonnull} out_Tmp_30 != 0;
    assume out_Tmp_30 > 0;
    call {:si_unique_call 963} sdv_KeAcquireSpinLock(0, out_Tmp_30);
    assume {:nonnull} out_Tmp_30 != 0;
    assume out_Tmp_30 > 0;
    havoc out_Irql_1;
    call {:si_unique_call 964} out_sdv_52 := sdv_IsListEmpty(0);
    goto anon46_Else;

  anon46_Else:
    assume {:partition} out_sdv_52 == 0;
    assume {:nonnull} in_deviceExtension_2 != 0;
    assume in_deviceExtension_2 > 0;
    call {:si_unique_call 971} out_sdv_51 := RemoveHeadList(IsochResourceData__DEVICE_EXTENSION(in_deviceExtension_2));
    out_IsochResourceData := out_sdv_51;
    call {:si_unique_call 972} sdv_KeReleaseSpinLock(0, out_Irql_1);
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} out_IsochResourceData != 0;
    assume {:nonnull} in_deviceExtension_2 != 0;
    assume in_deviceExtension_2 > 0;
    havoc out_Tmp_28;
    assume {:nonnull} out_Tmp_28 != 0;
    assume out_Tmp_28 > 0;
    havoc out_StackSize;
    call {:si_unique_call 970} out_ResourceIrp := IoAllocateIrp(out_StackSize, 0);
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} out_ResourceIrp != 0;
    call {:si_unique_call 969} out_sdv_54 := ExAllocatePoolWithTag(512, 344, -164023503);
    out_pIrb := out_sdv_54;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} out_pIrb != 0;
    call {:si_unique_call 967} sdv_RtlZeroMemory(0, 344);
    assume {:nonnull} out_pIrb != 0;
    assume out_pIrb > 0;
    assume {:nonnull} out_pIrb != 0;
    assume out_pIrb > 0;
    assume {:nonnull} out_IsochResourceData != 0;
    assume out_IsochResourceData > 0;
    assume {:nonnull} out_pIrb != 0;
    assume out_pIrb > 0;
    assume {:nonnull} in_deviceExtension_2 != 0;
    assume in_deviceExtension_2 > 0;
    havoc vslice_dummy_var_167;
    call {:si_unique_call 968} out_ntStatus_2 := t1394_SubmitIrpSynch(vslice_dummy_var_167, out_ResourceIrp, out_pIrb);
    goto anon59_Else;

  anon59_Else:
    assume {:partition} yogi_error != 1;
    call {:si_unique_call 965} sdv_ExFreePool(0);
    call {:si_unique_call 966} IoFreeIrp(0);
    goto anon59_Else_dummy;

  anon59_Else_dummy:
    goto L_BAF_0;

  L_BAF_0:
    call {:si_unique_call 974} {:si_old_unique_call 1} out_IsochResourceData, out_Tmp_28, out_ResourceIrp, out_sdv_51, out_sdv_52, out_StackSize, out_ntStatus_2, out_sdv_54, out_Tmp_30, out_Irql_1, out_pIrb := t1394VDev_PnpRemoveDevice_loop_L72(out_IsochResourceData, out_Tmp_28, out_ResourceIrp, out_sdv_51, out_sdv_52, out_StackSize, out_ntStatus_2, out_sdv_54, out_Tmp_30, out_Irql_1, in_deviceExtension_2, out_pIrb);
    return;

  anon58_Then:
    assume {:partition} out_pIrb == 0;
    call {:si_unique_call 973} IoFreeIrp(0);
    goto anon58_Then_dummy;

  anon58_Then_dummy:
    goto L_BAF_0;

  anon48_Then:
    assume {:partition} out_ResourceIrp == 0;
    goto anon48_Then_dummy;

  anon48_Then_dummy:
    goto L_BAF_0;

  anon47_Then:
    assume {:partition} out_IsochResourceData == 0;
    goto anon47_Then_dummy;

  anon47_Then_dummy:
    goto L_BAF_0;
}



procedure {:LoopProcedure} t1394VDev_PnpRemoveDevice_loop_L72(in_IsochResourceData: int, in_Tmp_28: int, in_ResourceIrp: int, in_sdv_51: int, in_sdv_52: int, in_StackSize: int, in_ntStatus_2: int, in_sdv_54: int, in_Tmp_30: int, in_Irql_1: int, in_deviceExtension_2: int, in_pIrb: int) returns (out_IsochResourceData: int, out_Tmp_28: int, out_ResourceIrp: int, out_sdv_51: int, out_sdv_52: int, out_StackSize: int, out_ntStatus_2: int, out_sdv_54: int, out_Tmp_30: int, out_Irql_1: int, out_pIrb: int);
  modifies alloc, wait_required, yogi_error;
  free ensures old(wait_required) == 0 ==> wait_required != 1;
  free ensures old(wait_required) == 1 ==> wait_required != 0;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> wait_required == old(wait_required);
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures alloc == old(alloc);
  free ensures yogi_error == old(yogi_error);
  free ensures wait_required == old(wait_required);
  free ensures out_IsochResourceData == in_IsochResourceData;
  free ensures out_Tmp_28 == in_Tmp_28;
  free ensures out_ResourceIrp == in_ResourceIrp;
  free ensures out_sdv_51 == in_sdv_51;
  free ensures out_sdv_52 == in_sdv_52;
  free ensures out_StackSize == in_StackSize;
  free ensures out_ntStatus_2 == in_ntStatus_2;
  free ensures out_sdv_54 == in_sdv_54;
  free ensures out_Tmp_30 == in_Tmp_30;
  free ensures out_Irql_1 == in_Irql_1;
  free ensures out_pIrb == in_pIrb;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394VDev_PnpRemoveDevice_loop_L41(in_sdv_50: int, in_IsochDetachData: int, in_sdv_57: int, in_Tmp_30: int, in_Irql_1: int, in_deviceExtension_2: int, in_vslice_dummy_var_4: int) returns (out_sdv_50: int, out_IsochDetachData: int, out_sdv_57: int, out_Tmp_30: int, out_Irql_1: int, out_vslice_dummy_var_4: int)
{

  entry:
    out_sdv_50, out_IsochDetachData, out_sdv_57, out_Tmp_30, out_Irql_1, out_vslice_dummy_var_4 := in_sdv_50, in_IsochDetachData, in_sdv_57, in_Tmp_30, in_Irql_1, in_vslice_dummy_var_4;
    goto L41, exit;

  exit:
    return;

  L41:
    call {:si_unique_call 975} out_Tmp_30 := __HAVOC_malloc(4);
    assume {:nonnull} out_Tmp_30 != 0;
    assume out_Tmp_30 > 0;
    call {:si_unique_call 976} sdv_KeAcquireSpinLock(0, out_Tmp_30);
    assume {:nonnull} out_Tmp_30 != 0;
    assume out_Tmp_30 > 0;
    havoc out_Irql_1;
    call {:si_unique_call 977} out_sdv_57 := sdv_IsListEmpty(0);
    goto anon45_Else;

  anon45_Else:
    assume {:partition} out_sdv_57 == 0;
    assume {:nonnull} in_deviceExtension_2 != 0;
    assume in_deviceExtension_2 > 0;
    call {:si_unique_call 978} out_sdv_50 := RemoveHeadList(IsochDetachData__DEVICE_EXTENSION(in_deviceExtension_2));
    out_IsochDetachData := out_sdv_50;
    call {:si_unique_call 979} out_vslice_dummy_var_4 := KeCancelTimer(0);
    call {:si_unique_call 980} sdv_KeReleaseSpinLock(0, out_Irql_1);
    assume {:nonnull} out_IsochDetachData != 0;
    assume out_IsochDetachData > 0;
    assume {:nonnull} out_IsochDetachData != 0;
    assume out_IsochDetachData > 0;
    call {:si_unique_call 981} t1394_IsochCleanup(out_IsochDetachData);
    goto anon60_Else;

  anon60_Else:
    assume {:partition} yogi_error != 1;
    goto anon60_Else_dummy;

  anon60_Else_dummy:
    call {:si_unique_call 982} {:si_old_unique_call 1} out_sdv_50, out_IsochDetachData, out_sdv_57, out_Tmp_30, out_Irql_1, out_vslice_dummy_var_4 := t1394VDev_PnpRemoveDevice_loop_L41(out_sdv_50, out_IsochDetachData, out_sdv_57, out_Tmp_30, out_Irql_1, in_deviceExtension_2, out_vslice_dummy_var_4);
    return;
}



procedure {:LoopProcedure} t1394VDev_PnpRemoveDevice_loop_L41(in_sdv_50: int, in_IsochDetachData: int, in_sdv_57: int, in_Tmp_30: int, in_Irql_1: int, in_deviceExtension_2: int, in_vslice_dummy_var_4: int) returns (out_sdv_50: int, out_IsochDetachData: int, out_sdv_57: int, out_Tmp_30: int, out_Irql_1: int, out_vslice_dummy_var_4: int);
  modifies alloc, yogi_error;
  free ensures old(SLAM_guard_S_0) == old(SLAM_guard_S_0_init) ==> yogi_error == old(yogi_error);
  free ensures yogi_error == 0;
  free ensures alloc == old(alloc);
  free ensures yogi_error == old(yogi_error);
  free ensures out_sdv_50 == in_sdv_50;
  free ensures out_IsochDetachData == in_IsochDetachData;
  free ensures out_sdv_57 == in_sdv_57;
  free ensures out_Tmp_30 == in_Tmp_30;
  free ensures out_Irql_1 == in_Irql_1;
  free ensures out_vslice_dummy_var_4 == in_vslice_dummy_var_4;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394VDev_PnpRemoveDevice_loop_L31(in_sdv_56: int, in_AsyncAddressData: int, in_sdv_61: int, in_deviceExtension_2: int) returns (out_sdv_56: int, out_AsyncAddressData: int, out_sdv_61: int)
{

  entry:
    out_sdv_56, out_AsyncAddressData, out_sdv_61 := in_sdv_56, in_AsyncAddressData, in_sdv_61;
    goto L31, exit;

  exit:
    return;

  L31:
    call {:si_unique_call 983} out_sdv_56 := sdv_IsListEmpty(0);
    goto anon44_Else;

  anon44_Else:
    assume {:partition} out_sdv_56 == 0;
    assume {:nonnull} in_deviceExtension_2 != 0;
    assume in_deviceExtension_2 > 0;
    call {:si_unique_call 988} out_sdv_61 := RemoveHeadList(AsyncAddressData__DEVICE_EXTENSION(in_deviceExtension_2));
    out_AsyncAddressData := out_sdv_61;
    assume {:nonnull} out_AsyncAddressData != 0;
    assume out_AsyncAddressData > 0;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    call {:si_unique_call 987} IoFreeMdl(0);
    goto L160;

  L160:
    assume {:nonnull} out_AsyncAddressData != 0;
    assume out_AsyncAddressData > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    call {:si_unique_call 986} sdv_ExFreePool(0);
    goto L164;

  L164:
    assume {:nonnull} out_AsyncAddressData != 0;
    assume out_AsyncAddressData > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    call {:si_unique_call 985} sdv_ExFreePool(0);
    goto L168;

  L168:
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} out_AsyncAddressData != 0;
    call {:si_unique_call 984} sdv_ExFreePool(0);
    goto anon52_Else_dummy;

  anon52_Else_dummy:
    goto L_BAF_1;

  L_BAF_1:
    call {:si_unique_call 989} {:si_old_unique_call 1} out_sdv_56, out_AsyncAddressData, out_sdv_61 := t1394VDev_PnpRemoveDevice_loop_L31(out_sdv_56, out_AsyncAddressData, out_sdv_61, in_deviceExtension_2);
    return;

  anon52_Then:
    assume {:partition} out_AsyncAddressData == 0;
    goto anon52_Then_dummy;

  anon52_Then_dummy:
    goto L_BAF_1;

  anon51_Then:
    goto L168;

  anon50_Then:
    goto L164;

  anon61_Then:
    goto L160;
}



procedure {:LoopProcedure} t1394VDev_PnpRemoveDevice_loop_L31(in_sdv_56: int, in_AsyncAddressData: int, in_sdv_61: int, in_deviceExtension_2: int) returns (out_sdv_56: int, out_AsyncAddressData: int, out_sdv_61: int);
  modifies alloc;
  free ensures alloc == old(alloc);
  free ensures out_sdv_56 == in_sdv_56;
  free ensures out_AsyncAddressData == in_AsyncAddressData;
  free ensures out_sdv_61 == in_sdv_61;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394VDev_PnpRemoveDevice_loop_L20(in_sdv_46: int, in_CromData: int, in_sdv_55: int, in_deviceExtension_2: int) returns (out_sdv_46: int, out_CromData: int, out_sdv_55: int)
{

  entry:
    out_sdv_46, out_CromData, out_sdv_55 := in_sdv_46, in_CromData, in_sdv_55;
    goto L20, exit;

  exit:
    return;

  L20:
    call {:si_unique_call 990} out_sdv_55 := sdv_IsListEmpty(0);
    goto anon43_Else;

  anon43_Else:
    assume {:partition} out_sdv_55 == 0;
    assume {:nonnull} in_deviceExtension_2 != 0;
    assume in_deviceExtension_2 > 0;
    call {:si_unique_call 994} out_sdv_46 := RemoveHeadList(CromData__DEVICE_EXTENSION(in_deviceExtension_2));
    out_CromData := out_sdv_46;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} out_CromData != 0;
    assume {:nonnull} out_CromData != 0;
    assume out_CromData > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    call {:si_unique_call 993} sdv_ExFreePool(0);
    goto L181;

  L181:
    assume {:nonnull} out_CromData != 0;
    assume out_CromData > 0;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    call {:si_unique_call 992} IoFreeMdl(0);
    goto L185;

  L185:
    call {:si_unique_call 991} sdv_ExFreePool(0);
    goto L185_dummy;

  L185_dummy:
    goto L_BAF_2;

  L_BAF_2:
    call {:si_unique_call 995} {:si_old_unique_call 1} out_sdv_46, out_CromData, out_sdv_55 := t1394VDev_PnpRemoveDevice_loop_L20(out_sdv_46, out_CromData, out_sdv_55, in_deviceExtension_2);
    return;

  anon54_Then:
    goto L185;

  anon53_Then:
    goto L181;

  anon62_Then:
    assume {:partition} out_CromData == 0;
    goto anon62_Then_dummy;

  anon62_Then_dummy:
    goto L_BAF_2;
}



procedure {:LoopProcedure} t1394VDev_PnpRemoveDevice_loop_L20(in_sdv_46: int, in_CromData: int, in_sdv_55: int, in_deviceExtension_2: int) returns (out_sdv_46: int, out_CromData: int, out_sdv_55: int);
  modifies alloc;
  free ensures alloc == old(alloc);
  free ensures out_sdv_46 == in_sdv_46;
  free ensures out_CromData == in_CromData;
  free ensures out_sdv_55 == in_sdv_55;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_SetLocalHostProperties_loop_L97(in_CromData_1: int, in_R0: int) returns (out_CromData_1: int)
{

  entry:
    out_CromData_1 := in_CromData_1;
    goto L97, exit;

  exit:
    return;

  L97:
    goto anon92_Else;

  anon92_Else:
    assume {:partition} out_CromData_1 != 0;
    assume {:nonnull} out_CromData_1 != 0;
    assume out_CromData_1 > 0;
    assume {:nonnull} in_R0 != 0;
    assume in_R0 > 0;
    goto anon93_Then;

  anon93_Then:
    goto anon94_Then;

  anon94_Then:
    assume {:nonnull} out_CromData_1 != 0;
    assume out_CromData_1 > 0;
    havoc out_CromData_1;
    goto anon94_Then_dummy;

  anon94_Then_dummy:
    havoc out_CromData_1;
    return;
}



procedure {:LoopProcedure} t1394_SetLocalHostProperties_loop_L97(in_CromData_1: int, in_R0: int) returns (out_CromData_1: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_IsochAttachCompletionRoutine_loop_L43(in_i_1: int, in_Tmp_191: int, in_Tmp_192: int, in_Tmp_194: int, in_Tmp_196: int, in_IsochDetachData_1: int) returns (out_i_1: int, out_Tmp_191: int, out_Tmp_192: int, out_Tmp_194: int, out_Tmp_196: int)
{

  entry:
    out_i_1, out_Tmp_191, out_Tmp_192, out_Tmp_194, out_Tmp_196 := in_i_1, in_Tmp_191, in_Tmp_192, in_Tmp_194, in_Tmp_196;
    goto L43, exit;

  exit:
    return;

  L43:
    assume {:nonnull} in_IsochDetachData_1 != 0;
    assume in_IsochDetachData_1 > 0;
    goto anon21_Else;

  anon21_Else:
    out_Tmp_194 := out_i_1;
    assume {:nonnull} in_IsochDetachData_1 != 0;
    assume in_IsochDetachData_1 > 0;
    havoc out_Tmp_192;
    assume {:nonnull} out_Tmp_192 != 0;
    assume out_Tmp_192 > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    out_Tmp_196 := out_i_1;
    assume {:nonnull} in_IsochDetachData_1 != 0;
    assume in_IsochDetachData_1 > 0;
    havoc out_Tmp_191;
    assume {:nonnull} out_Tmp_191 != 0;
    assume out_Tmp_191 > 0;
    call {:si_unique_call 996} IoFreeMdl(0);
    goto L48;

  L48:
    out_i_1 := out_i_1 + 1;
    goto L48_dummy;

  L48_dummy:
    havoc out_i_1;
    return;

  anon25_Then:
    goto L48;
}



procedure {:LoopProcedure} t1394_IsochAttachCompletionRoutine_loop_L43(in_i_1: int, in_Tmp_191: int, in_Tmp_192: int, in_Tmp_194: int, in_Tmp_196: int, in_IsochDetachData_1: int) returns (out_i_1: int, out_Tmp_191: int, out_Tmp_192: int, out_Tmp_194: int, out_Tmp_196: int);
  modifies alloc;
  free ensures out_Tmp_194 == in_i_1 || out_Tmp_194 == in_Tmp_194;
  free ensures out_Tmp_196 == in_i_1 || out_Tmp_196 == in_Tmp_196;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_GetAddressData_loop_L13(in_AsyncAddressData_1: int, in_hAddressRange: int) returns (out_AsyncAddressData_1: int)
{

  entry:
    out_AsyncAddressData_1 := in_AsyncAddressData_1;
    goto L13, exit;

  exit:
    return;

  L13:
    goto anon9_Else;

  anon9_Else:
    assume {:partition} out_AsyncAddressData_1 != 0;
    assume {:nonnull} out_AsyncAddressData_1 != 0;
    assume out_AsyncAddressData_1 > 0;
    goto anon10_Then;

  anon10_Then:
    goto anon11_Then;

  anon11_Then:
    assume {:nonnull} out_AsyncAddressData_1 != 0;
    assume out_AsyncAddressData_1 > 0;
    havoc out_AsyncAddressData_1;
    goto anon11_Then_dummy;

  anon11_Then_dummy:
    havoc out_AsyncAddressData_1;
    return;
}



procedure {:LoopProcedure} t1394_GetAddressData_loop_L13(in_AsyncAddressData_1: int, in_hAddressRange: int) returns (out_AsyncAddressData_1: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_IsochDetachCompletionRoutine_loop_L17(in_i_2: int, in_Tmp_209: int, in_Tmp_211: int, in_Tmp_212: int, in_Tmp_215: int, in_IsochDetachData_2: int) returns (out_i_2: int, out_Tmp_209: int, out_Tmp_211: int, out_Tmp_212: int, out_Tmp_215: int)
{

  entry:
    out_i_2, out_Tmp_209, out_Tmp_211, out_Tmp_212, out_Tmp_215 := in_i_2, in_Tmp_209, in_Tmp_211, in_Tmp_212, in_Tmp_215;
    goto L17, exit;

  exit:
    return;

  L17:
    assume {:nonnull} in_IsochDetachData_2 != 0;
    assume in_IsochDetachData_2 > 0;
    goto anon23_Else;

  anon23_Else:
    out_Tmp_212 := out_i_2;
    assume {:nonnull} in_IsochDetachData_2 != 0;
    assume in_IsochDetachData_2 > 0;
    havoc out_Tmp_211;
    assume {:nonnull} out_Tmp_211 != 0;
    assume out_Tmp_211 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    out_Tmp_209 := out_i_2;
    assume {:nonnull} in_IsochDetachData_2 != 0;
    assume in_IsochDetachData_2 > 0;
    havoc out_Tmp_215;
    assume {:nonnull} out_Tmp_215 != 0;
    assume out_Tmp_215 > 0;
    call {:si_unique_call 997} IoFreeMdl(0);
    goto L20;

  L20:
    out_i_2 := out_i_2 + 1;
    goto L20_dummy;

  L20_dummy:
    havoc out_i_2;
    return;

  anon28_Then:
    goto L20;
}



procedure {:LoopProcedure} t1394_IsochDetachCompletionRoutine_loop_L17(in_i_2: int, in_Tmp_209: int, in_Tmp_211: int, in_Tmp_212: int, in_Tmp_215: int, in_IsochDetachData_2: int) returns (out_i_2: int, out_Tmp_209: int, out_Tmp_211: int, out_Tmp_212: int, out_Tmp_215: int);
  modifies alloc;
  free ensures out_Tmp_209 == in_i_2 || out_Tmp_209 == in_Tmp_209;
  free ensures out_Tmp_212 == in_i_2 || out_Tmp_212 == in_Tmp_212;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_IsochAttachBuffers_loop_L113(in_i_3: int, in_j: int, in_Tmp_232: int, in_Tmp_239: int, in_pIsochDescriptor: int) returns (out_j: int, out_Tmp_232: int, out_Tmp_239: int)
{

  entry:
    out_j, out_Tmp_232, out_Tmp_239 := in_j, in_Tmp_232, in_Tmp_239;
    goto L113, exit;

  exit:
    return;

  L113:
    goto anon41_Else;

  anon41_Else:
    assume {:partition} in_i_3 > out_j;
    out_Tmp_239 := out_j;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    out_Tmp_232 := out_j;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    call {:si_unique_call 998} IoFreeMdl(0);
    goto L118;

  L118:
    out_j := out_j + 1;
    goto L118_dummy;

  L118_dummy:
    havoc out_j;
    return;

  anon49_Then:
    goto L118;
}



procedure {:LoopProcedure} t1394_IsochAttachBuffers_loop_L113(in_i_3: int, in_j: int, in_Tmp_232: int, in_Tmp_239: int, in_pIsochDescriptor: int) returns (out_j: int, out_Tmp_232: int, out_Tmp_239: int);
  modifies alloc;
  free ensures out_Tmp_232 == in_j || out_Tmp_232 == in_Tmp_232;
  free ensures out_Tmp_239 == in_j || out_Tmp_239 == in_Tmp_239;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_IsochAttachBuffers_loop_L126(in_i_3: int, in_j: int, in_Tmp_242: int, in_Tmp_252: int, in_pIsochDescriptor: int) returns (out_j: int, out_Tmp_242: int, out_Tmp_252: int)
{

  entry:
    out_j, out_Tmp_242, out_Tmp_252 := in_j, in_Tmp_242, in_Tmp_252;
    goto L126, exit;

  exit:
    return;

  L126:
    goto anon42_Else;

  anon42_Else:
    assume {:partition} in_i_3 > out_j;
    out_Tmp_252 := out_j;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    out_Tmp_242 := out_j;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    call {:si_unique_call 999} IoFreeMdl(0);
    goto L131;

  L131:
    out_j := out_j + 1;
    goto L131_dummy;

  L131_dummy:
    havoc out_j;
    return;

  anon50_Then:
    goto L131;
}



procedure {:LoopProcedure} t1394_IsochAttachBuffers_loop_L126(in_i_3: int, in_j: int, in_Tmp_242: int, in_Tmp_252: int, in_pIsochDescriptor: int) returns (out_j: int, out_Tmp_242: int, out_Tmp_252: int);
  modifies alloc;
  free ensures out_Tmp_242 == in_j || out_Tmp_242 == in_Tmp_242;
  free ensures out_Tmp_252 == in_j || out_Tmp_252 == in_Tmp_252;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_IsochAttachBuffers_loop_L45(in_i_3: int, in_Tmp_226: int, in_pR3TempDescriptor: int, in_Tmp_228: int, in_Tmp_229: int, in_Tmp_233: int, in_Tmp_234: int, in_sdv_222: int, in_newIrp_12: int, in_Tmp_235: int, in_Tmp_237: int, in_Tmp_238: int, in_Tmp_240: int, in_Tmp_241: int, in_deltaTime: int, in_pIsochDetachData: int, in_sdv_227: int, in_sdv_228: int, in_Tmp_243: int, in_Tmp_244: int, in_Tmp_245: int, in_Tmp_246: int, in_Tmp_247: int, in_Irql_5: int, in_Tmp_248: int, in_deviceExtension_23: int, in_Tmp_249: int, in_pIrb_13: int, in_Tmp_251: int, in_Tmp_253: int, in_Irp_33: int, in_outputBufferLength_1: int, in_hResource_2: int, in_nNumberOfDescriptors: int, in_pIsochDescriptor: int, in_vslice_dummy_var_66: int) returns (out_i_3: int, out_Tmp_226: int, out_pR3TempDescriptor: int, out_Tmp_228: int, out_Tmp_229: int, out_Tmp_233: int, out_Tmp_234: int, out_sdv_222: int, out_Tmp_235: int, out_Tmp_237: int, out_Tmp_238: int, out_Tmp_240: int, out_Tmp_241: int, out_pIsochDetachData: int, out_sdv_227: int, out_sdv_228: int, out_Tmp_243: int, out_Tmp_244: int, out_Tmp_245: int, out_Tmp_246: int, out_Tmp_247: int, out_Irql_5: int, out_Tmp_248: int, out_Tmp_249: int, out_Tmp_251: int, out_Tmp_253: int, out_vslice_dummy_var_66: int)
{
  var vslice_dummy_var_168: int;

  entry:
    out_i_3, out_Tmp_226, out_pR3TempDescriptor, out_Tmp_228, out_Tmp_229, out_Tmp_233, out_Tmp_234, out_sdv_222, out_Tmp_235, out_Tmp_237, out_Tmp_238, out_Tmp_240, out_Tmp_241, out_pIsochDetachData, out_sdv_227, out_sdv_228, out_Tmp_243, out_Tmp_244, out_Tmp_245, out_Tmp_246, out_Tmp_247, out_Irql_5, out_Tmp_248, out_Tmp_249, out_Tmp_251, out_Tmp_253, out_vslice_dummy_var_66 := in_i_3, in_Tmp_226, in_pR3TempDescriptor, in_Tmp_228, in_Tmp_229, in_Tmp_233, in_Tmp_234, in_sdv_222, in_Tmp_235, in_Tmp_237, in_Tmp_238, in_Tmp_240, in_Tmp_241, in_pIsochDetachData, in_sdv_227, in_sdv_228, in_Tmp_243, in_Tmp_244, in_Tmp_245, in_Tmp_246, in_Tmp_247, in_Irql_5, in_Tmp_248, in_Tmp_249, in_Tmp_251, in_Tmp_253, in_vslice_dummy_var_66;
    goto L45, exit;

  exit:
    return;

  L45:
    goto anon37_Else;

  anon37_Else:
    assume {:partition} in_nNumberOfDescriptors > out_i_3;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    havoc vslice_dummy_var_168;
    call {:si_unique_call 1008} out_sdv_227 := IoAllocateMdl(0, vslice_dummy_var_168, 0, 0, 0);
    out_Tmp_243 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    out_Tmp_247 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    goto anon46_Else;

  anon46_Else:
    out_Tmp_248 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    out_Tmp_253 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    call {:si_unique_call 1007} out_sdv_228 := sdv_MmGetMdlByteCount(0);
    out_Tmp_244 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    goto L64;

  L64:
    out_Tmp_245 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    out_Tmp_240 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    out_Tmp_246 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    out_Tmp_238 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    out_Tmp_226 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} out_i_3 != in_nNumberOfDescriptors - 1;
    out_Tmp_237 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    goto L76;

  L76:
    out_Tmp_235 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    havoc out_pR3TempDescriptor;
    out_i_3 := out_i_3 + 1;
    goto L76_dummy;

  L76_dummy:
    call {:si_unique_call 1010} {:si_old_unique_call 1} out_i_3, out_Tmp_226, out_pR3TempDescriptor, out_Tmp_228, out_Tmp_229, out_Tmp_233, out_Tmp_234, out_sdv_222, out_Tmp_235, out_Tmp_237, out_Tmp_238, out_Tmp_240, out_Tmp_241, out_pIsochDetachData, out_sdv_227, out_sdv_228, out_Tmp_243, out_Tmp_244, out_Tmp_245, out_Tmp_246, out_Tmp_247, out_Irql_5, out_Tmp_248, out_Tmp_249, out_Tmp_251, out_Tmp_253, out_vslice_dummy_var_66 := t1394_IsochAttachBuffers_loop_L45(out_i_3, out_Tmp_226, out_pR3TempDescriptor, out_Tmp_228, out_Tmp_229, out_Tmp_233, out_Tmp_234, out_sdv_222, in_newIrp_12, out_Tmp_235, out_Tmp_237, out_Tmp_238, out_Tmp_240, out_Tmp_241, in_deltaTime, out_pIsochDetachData, out_sdv_227, out_sdv_228, out_Tmp_243, out_Tmp_244, out_Tmp_245, out_Tmp_246, out_Tmp_247, out_Irql_5, out_Tmp_248, in_deviceExtension_23, out_Tmp_249, in_pIrb_13, out_Tmp_251, out_Tmp_253, in_Irp_33, in_outputBufferLength_1, in_hResource_2, in_nNumberOfDescriptors, in_pIsochDescriptor, out_vslice_dummy_var_66);
    return;

  anon40_Then:
    assume {:partition} out_i_3 == in_nNumberOfDescriptors - 1;
    call {:si_unique_call 1009} out_sdv_222 := ExAllocatePoolWithTag(512, 128, -164023503);
    out_pIsochDetachData := out_sdv_222;
    goto anon48_Else;

  anon48_Else:
    assume {:partition} out_pIsochDetachData != 0;
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    call {:si_unique_call 1000} out_Tmp_241 := __HAVOC_malloc(4);
    assume {:nonnull} out_Tmp_241 != 0;
    assume out_Tmp_241 > 0;
    call {:si_unique_call 1001} sdv_KeAcquireSpinLock(0, out_Tmp_241);
    assume {:nonnull} out_Tmp_241 != 0;
    assume out_Tmp_241 > 0;
    havoc out_Irql_5;
    assume {:nonnull} in_deviceExtension_23 != 0;
    assume in_deviceExtension_23 > 0;
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    call {:si_unique_call 1002} InsertHeadList(IsochDetachData__DEVICE_EXTENSION(in_deviceExtension_23), IsochDetachList__ISOCH_DETACH_DATA(out_pIsochDetachData));
    call {:si_unique_call 1003} sdv_KeReleaseSpinLock(0, out_Irql_5);
    call {:si_unique_call 1004} KeInitializeTimer(0);
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    call {:si_unique_call 1005} KeInitializeDpc(TimerDpc__ISOCH_DETACH_DATA(out_pIsochDetachData), li2bplFunctionConstant203, 0);
    assume {:nonnull} in_deltaTime != 0;
    assume in_deltaTime > 0;
    assume {:nonnull} in_deltaTime != 0;
    assume in_deltaTime > 0;
    call {:si_unique_call 1006} out_vslice_dummy_var_66 := KeSetTimer(0, in_deltaTime, 0);
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    assume {:nonnull} out_pIsochDetachData != 0;
    assume out_pIsochDetachData > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    out_Tmp_233 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    out_Tmp_251 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    out_Tmp_234 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    goto L76;

  anon47_Then:
    out_Tmp_249 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    goto L76;

  anon39_Then:
    out_Tmp_229 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    out_Tmp_228 := out_i_3;
    assume {:nonnull} in_pIsochDescriptor != 0;
    assume in_pIsochDescriptor > 0;
    assume {:nonnull} out_pR3TempDescriptor != 0;
    assume out_pR3TempDescriptor > 0;
    goto L64;
}



procedure {:LoopProcedure} t1394_IsochAttachBuffers_loop_L45(in_i_3: int, in_Tmp_226: int, in_pR3TempDescriptor: int, in_Tmp_228: int, in_Tmp_229: int, in_Tmp_233: int, in_Tmp_234: int, in_sdv_222: int, in_newIrp_12: int, in_Tmp_235: int, in_Tmp_237: int, in_Tmp_238: int, in_Tmp_240: int, in_Tmp_241: int, in_deltaTime: int, in_pIsochDetachData: int, in_sdv_227: int, in_sdv_228: int, in_Tmp_243: int, in_Tmp_244: int, in_Tmp_245: int, in_Tmp_246: int, in_Tmp_247: int, in_Irql_5: int, in_Tmp_248: int, in_deviceExtension_23: int, in_Tmp_249: int, in_pIrb_13: int, in_Tmp_251: int, in_Tmp_253: int, in_Irp_33: int, in_outputBufferLength_1: int, in_hResource_2: int, in_nNumberOfDescriptors: int, in_pIsochDescriptor: int, in_vslice_dummy_var_66: int) returns (out_i_3: int, out_Tmp_226: int, out_pR3TempDescriptor: int, out_Tmp_228: int, out_Tmp_229: int, out_Tmp_233: int, out_Tmp_234: int, out_sdv_222: int, out_Tmp_235: int, out_Tmp_237: int, out_Tmp_238: int, out_Tmp_240: int, out_Tmp_241: int, out_pIsochDetachData: int, out_sdv_227: int, out_sdv_228: int, out_Tmp_243: int, out_Tmp_244: int, out_Tmp_245: int, out_Tmp_246: int, out_Tmp_247: int, out_Irql_5: int, out_Tmp_248: int, out_Tmp_249: int, out_Tmp_251: int, out_Tmp_253: int, out_vslice_dummy_var_66: int);
  modifies alloc;
  free ensures out_vslice_dummy_var_66 == 1 || out_vslice_dummy_var_66 == 0 || out_vslice_dummy_var_66 == in_vslice_dummy_var_66;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_IsochDetachBuffers_loop_L64(in_i_4: int, in_Tmp_257: int, in_Tmp_259: int, in_nNumberOfDescriptors_1: int, in_IsochDescriptor: int) returns (out_i_4: int, out_Tmp_257: int, out_Tmp_259: int)
{

  entry:
    out_i_4, out_Tmp_257, out_Tmp_259 := in_i_4, in_Tmp_257, in_Tmp_259;
    goto L64, exit;

  exit:
    return;

  L64:
    goto anon30_Else;

  anon30_Else:
    assume {:partition} in_nNumberOfDescriptors_1 > out_i_4;
    out_Tmp_257 := out_i_4;
    assume {:nonnull} in_IsochDescriptor != 0;
    assume in_IsochDescriptor > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    out_Tmp_259 := out_i_4;
    assume {:nonnull} in_IsochDescriptor != 0;
    assume in_IsochDescriptor > 0;
    call {:si_unique_call 1011} IoFreeMdl(0);
    goto L69;

  L69:
    out_i_4 := out_i_4 + 1;
    goto L69_dummy;

  L69_dummy:
    havoc out_i_4;
    return;

  anon35_Then:
    goto L69;
}



procedure {:LoopProcedure} t1394_IsochDetachBuffers_loop_L64(in_i_4: int, in_Tmp_257: int, in_Tmp_259: int, in_nNumberOfDescriptors_1: int, in_IsochDescriptor: int) returns (out_i_4: int, out_Tmp_257: int, out_Tmp_259: int);
  modifies alloc;
  free ensures out_Tmp_257 == in_i_4 || out_Tmp_257 == in_Tmp_257;
  free ensures out_Tmp_259 == in_i_4 || out_Tmp_259 == in_Tmp_259;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_GetMaxSpeedBetweenDevices_loop_L49(in_i_5: int, in_Tmp_264: int, in_Tmp_265: int, in_Tmp_267: int, in_pIrb_16: int, in_ulNumberOfDestinations: int, in_hDestinationDeviceObjects: int) returns (out_i_5: int, out_Tmp_264: int, out_Tmp_265: int, out_Tmp_267: int)
{

  entry:
    out_i_5, out_Tmp_264, out_Tmp_265, out_Tmp_267 := in_i_5, in_Tmp_264, in_Tmp_265, in_Tmp_267;
    goto L49, exit;

  exit:
    return;

  L49:
    goto anon30_Else;

  anon30_Else:
    assume {:partition} in_ulNumberOfDestinations > out_i_5;
    out_Tmp_267 := out_i_5;
    assume {:nonnull} in_pIrb_16 != 0;
    assume in_pIrb_16 > 0;
    havoc out_Tmp_265;
    out_Tmp_264 := out_i_5;
    assume {:nonnull} out_Tmp_265 != 0;
    assume out_Tmp_265 > 0;
    assume {:nonnull} in_hDestinationDeviceObjects != 0;
    assume in_hDestinationDeviceObjects > 0;
    out_i_5 := out_i_5 + 1;
    goto anon30_Else_dummy;

  anon30_Else_dummy:
    call {:si_unique_call 1012} {:si_old_unique_call 1} out_i_5, out_Tmp_264, out_Tmp_265, out_Tmp_267 := t1394_GetMaxSpeedBetweenDevices_loop_L49(out_i_5, out_Tmp_264, out_Tmp_265, out_Tmp_267, in_pIrb_16, in_ulNumberOfDestinations, in_hDestinationDeviceObjects);
    return;
}



procedure {:LoopProcedure} t1394_GetMaxSpeedBetweenDevices_loop_L49(in_i_5: int, in_Tmp_264: int, in_Tmp_265: int, in_Tmp_267: int, in_pIrb_16: int, in_ulNumberOfDestinations: int, in_hDestinationDeviceObjects: int) returns (out_i_5: int, out_Tmp_264: int, out_Tmp_265: int, out_Tmp_267: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_GetMaxSpeedBetweenDevices_loop_L17(in_i_5: int, in_ulNumberOfDestinations: int) returns (out_i_5: int)
{

  entry:
    out_i_5 := in_i_5;
    goto L17, exit;

  exit:
    return;

  L17:
    goto anon25_Else;

  anon25_Else:
    assume {:partition} in_ulNumberOfDestinations > out_i_5;
    out_i_5 := out_i_5 + 1;
    goto anon25_Else_dummy;

  anon25_Else_dummy:
    havoc out_i_5;
    return;
}



procedure {:LoopProcedure} t1394_GetMaxSpeedBetweenDevices_loop_L17(in_i_5: int, in_ulNumberOfDestinations: int) returns (out_i_5: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_IsochCleanup_loop_L47(in_i_6: int, in_Tmp_271: int, in_Tmp_272: int, in_Tmp_274: int, in_Tmp_276: int, in_IsochDetachData_3: int) returns (out_i_6: int, out_Tmp_271: int, out_Tmp_272: int, out_Tmp_274: int, out_Tmp_276: int)
{

  entry:
    out_i_6, out_Tmp_271, out_Tmp_272, out_Tmp_274, out_Tmp_276 := in_i_6, in_Tmp_271, in_Tmp_272, in_Tmp_274, in_Tmp_276;
    goto L47, exit;

  exit:
    return;

  L47:
    assume {:nonnull} in_IsochDetachData_3 != 0;
    assume in_IsochDetachData_3 > 0;
    goto anon26_Else;

  anon26_Else:
    out_Tmp_271 := out_i_6;
    assume {:nonnull} in_IsochDetachData_3 != 0;
    assume in_IsochDetachData_3 > 0;
    havoc out_Tmp_274;
    assume {:nonnull} out_Tmp_274 != 0;
    assume out_Tmp_274 > 0;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    out_Tmp_276 := out_i_6;
    assume {:nonnull} in_IsochDetachData_3 != 0;
    assume in_IsochDetachData_3 > 0;
    havoc out_Tmp_272;
    assume {:nonnull} out_Tmp_272 != 0;
    assume out_Tmp_272 > 0;
    call {:si_unique_call 1013} IoFreeMdl(0);
    goto L52;

  L52:
    out_i_6 := out_i_6 + 1;
    goto L52_dummy;

  L52_dummy:
    havoc out_i_6;
    return;

  anon31_Then:
    goto L52;
}



procedure {:LoopProcedure} t1394_IsochCleanup_loop_L47(in_i_6: int, in_Tmp_271: int, in_Tmp_272: int, in_Tmp_274: int, in_Tmp_276: int, in_IsochDetachData_3: int) returns (out_i_6: int, out_Tmp_271: int, out_Tmp_272: int, out_Tmp_274: int, out_Tmp_276: int);
  modifies alloc;
  free ensures out_Tmp_271 == in_i_6 || out_Tmp_271 == in_Tmp_271;
  free ensures out_Tmp_276 == in_i_6 || out_Tmp_276 == in_Tmp_276;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_IsochFreeResources_loop_L44(in_IsochResourceData_1: int, in_hResource_5: int) returns (out_IsochResourceData_1: int)
{

  entry:
    out_IsochResourceData_1 := in_IsochResourceData_1;
    goto L44, exit;

  exit:
    return;

  L44:
    goto anon28_Else;

  anon28_Else:
    assume {:partition} out_IsochResourceData_1 != 0;
    assume {:nonnull} out_IsochResourceData_1 != 0;
    assume out_IsochResourceData_1 > 0;
    goto anon29_Then;

  anon29_Then:
    goto anon30_Else;

  anon30_Else:
    assume {:nonnull} out_IsochResourceData_1 != 0;
    assume out_IsochResourceData_1 > 0;
    havoc out_IsochResourceData_1;
    goto anon30_Else_dummy;

  anon30_Else_dummy:
    havoc out_IsochResourceData_1;
    return;
}



procedure {:LoopProcedure} t1394_IsochFreeResources_loop_L44(in_IsochResourceData_1: int, in_hResource_5: int) returns (out_IsochResourceData_1: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_FreeAddressRange_loop_L38(in_AsyncAddressData_2: int, in_hAddressRange_1: int) returns (out_AsyncAddressData_2: int)
{

  entry:
    out_AsyncAddressData_2 := in_AsyncAddressData_2;
    goto L38, exit;

  exit:
    return;

  L38:
    goto anon40_Else;

  anon40_Else:
    assume {:partition} out_AsyncAddressData_2 != 0;
    assume {:nonnull} out_AsyncAddressData_2 != 0;
    assume out_AsyncAddressData_2 > 0;
    goto anon41_Then;

  anon41_Then:
    goto anon42_Then;

  anon42_Then:
    assume {:nonnull} out_AsyncAddressData_2 != 0;
    assume out_AsyncAddressData_2 > 0;
    havoc out_AsyncAddressData_2;
    goto anon42_Then_dummy;

  anon42_Then_dummy:
    havoc out_AsyncAddressData_2;
    return;
}



procedure {:LoopProcedure} t1394_FreeAddressRange_loop_L38(in_AsyncAddressData_2: int, in_hAddressRange_1: int) returns (out_AsyncAddressData_2: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_IsOnList_loop_L5(in_TempEntry: int) returns (out_TempEntry: int)
{

  entry:
    out_TempEntry := in_TempEntry;
    goto L5, exit;

  exit:
    return;

  L5:
    goto anon5_Else;

  anon5_Else:
    goto anon6_Then;

  anon6_Then:
    assume {:nonnull} out_TempEntry != 0;
    assume out_TempEntry > 0;
    havoc out_TempEntry;
    goto anon6_Then_dummy;

  anon6_Then_dummy:
    havoc out_TempEntry;
    return;
}



procedure {:LoopProcedure} t1394_IsOnList_loop_L5(in_TempEntry: int) returns (out_TempEntry: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_AllocateAddressRange_loop_L134(in_i_7: int, in_pIrb_28: int) returns (out_i_7: int)
{

  entry:
    out_i_7 := in_i_7;
    goto L134, exit;

  exit:
    return;

  L134:
    assume {:nonnull} in_pIrb_28 != 0;
    assume in_pIrb_28 > 0;
    goto anon74_Else;

  anon74_Else:
    out_i_7 := out_i_7 + 1;
    goto anon74_Else_dummy;

  anon74_Else_dummy:
    havoc out_i_7;
    return;
}



procedure {:LoopProcedure} t1394_AllocateAddressRange_loop_L134(in_i_7: int, in_pIrb_28: int) returns (out_i_7: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation t1394_SetAddressData_loop_L13(in_AsyncAddressData_3: int, in_hAddressRange_2: int) returns (out_AsyncAddressData_3: int)
{

  entry:
    out_AsyncAddressData_3 := in_AsyncAddressData_3;
    goto L13, exit;

  exit:
    return;

  L13:
    goto anon9_Else;

  anon9_Else:
    assume {:partition} out_AsyncAddressData_3 != 0;
    assume {:nonnull} out_AsyncAddressData_3 != 0;
    assume out_AsyncAddressData_3 > 0;
    goto anon10_Then;

  anon10_Then:
    goto anon11_Then;

  anon11_Then:
    assume {:nonnull} out_AsyncAddressData_3 != 0;
    assume out_AsyncAddressData_3 > 0;
    havoc out_AsyncAddressData_3;
    goto anon11_Then_dummy;

  anon11_Then_dummy:
    havoc out_AsyncAddressData_3;
    return;
}



procedure {:LoopProcedure} t1394_SetAddressData_loop_L13(in_AsyncAddressData_3: int, in_hAddressRange_2: int) returns (out_AsyncAddressData_3: int);
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



procedure fakeMain() returns (Tmp_92: int, dup_assertVar: bool);
  modifies alloc, SLAM_guard_S_0, wait_required, yogi_error;
  free ensures old(yogi_error) == 0;
  free ensures false || old(wait_required) == 0 || old(wait_required) == 1;
  free ensures alloc >= old(alloc);
  free ensures false || wait_required == 0 || wait_required == 1;



implementation {:entrypoint} fakeMain() returns (Tmp_92: int, dup_assertVar: bool)
{

  start:
    call Tmp_92, dup_assertVar := main();
    assume {:OldAssert} !dup_assertVar;
    return;
}


