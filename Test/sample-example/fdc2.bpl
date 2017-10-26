var {:scalar} alloc: int;

var {:scalar} sdv_irql_previous_5: int;

var {:pointer} sdv_kdpc3: int;

var {:scalar} sdv_irql_previous_2: int;

var {:pointer} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock: int;

var {:scalar} sdv_irql_current: int;

var {:scalar} sdv_dpc_ke_registered: int;

var {:scalar} sdv_irql_previous: int;

var {:scalar} sdv_isr_routine: int;

var {:scalar} sdv_irql_previous_4: int;

var {:scalar} sdv_remove_irp_already_issued: int;

var {:scalar} sdv_io_dpc: int;

var {:pointer} sdv_pDpcContext: int;

var {:scalar} sdv_dpc_io_registered: int;

var {:scalar} sdv_io_create_device_called: int;

var {:scalar} sdv_irql_previous_3: int;

var {:scalar} sdv_start_info: int;

var {:scalar} yogi_error: int;

var {:pointer} CommandTable: int;

var {:scalar} FdcInSetupMode: int;

var {:scalar} FdcDefaultControllerNumber: int;

var {:scalar} ProbeFloppyDevices: int;

var {:scalar} PagingReferenceCount: int;

var {:scalar} Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.AcpiBios__FDC_INFO: [int]int;

var {:scalar} Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.AdapterObject__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.Address__CONTROLLER: [int]int;

var {:scalar} Mem_T.AffinityPolicy_unnamed_tag_59: [int]int;

var {:scalar} Mem_T.Affinity_unnamed_tag_45: [int]int;

var {:scalar} Mem_T.Alignment40_unnamed_tag_64: [int]int;

var {:scalar} Mem_T.Alignment48_unnamed_tag_65: [int]int;

var {:scalar} Mem_T.Alignment64_unnamed_tag_66: [int]int;

var {:scalar} Mem_T.Alignment_unnamed_tag_58: [int]int;

var {:scalar} Mem_T.AllocatedResourcesTranslated_unnamed_tag_40: [int]int;

var {:scalar} Mem_T.AllocatedResources_unnamed_tag_40: [int]int;

var {:scalar} Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST: [int]int;

var {:scalar} Mem_T.AlwaysImplemented__COMMAND_TABLE: [int]int;

var {:scalar} Mem_T.Argument__ACPI_EVAL_INPUT_BUFFER_COMPLEX: [int]int;

var {:scalar} Mem_T.Argument__ACPI_EVAL_OUTPUT_BUFFER: [int]int;

var {:scalar} Mem_T.Blink__LIST_ENTRY: [int]int;

var {:scalar} Mem_T.BufferAddress__FDC_INFO: [int]int;

var {:scalar} Mem_T.BufferCount__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.BufferCount__FDC_INFO: [int]int;

var {:scalar} Mem_T.BufferSize__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.BufferSize__FDC_INFO: [int]int;

var {:scalar} Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.BuffersRequested__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.BusNumber__CM_FULL_RESOURCE_DESCRIPTOR: [int]int;

var {:scalar} Mem_T.BusNumber__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST: [int]int;

var {:scalar} Mem_T.BusType__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT: [int]int;

var {:scalar} Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT: [int]int;

var {:scalar} Mem_T.CancelRoutine__IRP: [int]int;

var {:scalar} Mem_T.Capabilities_unnamed_tag_30: [int]int;

var {:scalar} Mem_T.Channel_unnamed_tag_48: [int]int;

var {:scalar} Mem_T.Channel_unnamed_tag_61: [int]int;

var {:scalar} Mem_T.Class_unnamed_tag_56: [int]int;

var {:scalar} Mem_T.Clock48MHz__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.ClockRatesSupported__FDC_INFORMATION: [int]int;

var {:scalar} Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.CompletionRoutine__IO_STACK_LOCATION: [int]int;

var {:scalar} Mem_T.ControllerInUse__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.ControllerIrql__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.ControllerNumber__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.ControllerVector__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.Count__ACPI_EVAL_OUTPUT_BUFFER: [int]int;

var {:scalar} Mem_T.Count__CM_PARTIAL_RESOURCE_LIST: [int]int;

var {:scalar} Mem_T.Count__DEVICE_RELATIONS: [int]int;

var {:scalar} Mem_T.Count__IO_RESOURCE_LIST: [int]int;

var {:scalar} Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.CurrentIrp__DEVICE_OBJECT: [int]int;

var {:scalar} Mem_T.CurrentPowerState__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.CurrentStackLocation_unnamed_tag_6: [int]int;

var {:scalar} Mem_T.DataLength__ACPI_METHOD_ARGUMENT: [int]int;

var {:scalar} Mem_T.DataRate_unnamed_tag_69: [int]int;

var {:scalar} Mem_T.DataTransferLength__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.DataTransfer__COMMAND_TABLE: [int]int;

var {:scalar} Mem_T.Data__ACPI_METHOD_ARGUMENT: [int]int;

var {:scalar} Mem_T.Data_unnamed_tag_50: [int]int;

var {:scalar} Mem_T.DeferredRoutine__KDPC: [int]int;

var {:scalar} Mem_T.Descriptors__IO_RESOURCE_LIST: [int]int;

var {:scalar} Mem_T.DeviceExtension__DEVICE_OBJECT: [int]int;

var {:scalar} Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT: [int]int;

var {:scalar} Mem_T.DeviceState__POWER_STATE: [int]int;

var {:scalar} Mem_T.DeviceType__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.DeviceType__FDC_PDO_EXTENSION: [int]int;

var {:scalar} Mem_T.DriveControlImage__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.DriveControl__CONTROLLER: [int]int;

var {:scalar} Mem_T.DriveNumber__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.DriveOnValue__FDC_ENABLE_PARMS: [int]int;

var {:scalar} Mem_T.DrivePresent__ACPI_FDE_ENUM_TABLE: [int]int;

var {:scalar} Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS: [int]int;

var {:scalar} Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.FdcEnablerFileObject__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.FdcSpeeds__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.FdcType__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.FifoBuffer__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.FifoInBuffer__ISSUE_FDC_COMMAND_PARMS: [int]int;

var {:scalar} Mem_T.FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS: [int]int;

var {:scalar} Mem_T.Fifo__CONTROLLER: [int]int;

var {:scalar} Mem_T.FirstResultByte__COMMAND_TABLE: [int]int;

var {:scalar} Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR: [int]int;

var {:scalar} Mem_T.Flags__DEVICE_OBJECT: [int]int;

var {:scalar} Mem_T.Flags__IO_RESOURCE_DESCRIPTOR: [int]int;

var {:scalar} Mem_T.Flink__LIST_ENTRY: [int]int;

var {:scalar} Mem_T.FloppyControllerType__FDC_INFORMATION: [int]int;

var {:scalar} Mem_T.FormatFillCharacter__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.FormatGapLength__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS: [int]int;

var {:scalar} Mem_T.HardwareFailed__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.HeadLoadTime__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.HeadSettleTime__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.HighPart__LUID: [int]int;

var {:scalar} Mem_T.INT4: [int]int;

var {:scalar} Mem_T.IdHighPart_unnamed_tag_56: [int]int;

var {:scalar} Mem_T.IdLowPart_unnamed_tag_56: [int]int;

var {:scalar} Mem_T.IdType_unnamed_tag_34: [int]int;

var {:scalar} Mem_T.Information__IO_STATUS_BLOCK: [int]int;

var {:scalar} Mem_T.InterfaceType__CM_FULL_RESOURCE_DESCRIPTOR: [int]int;

var {:scalar} Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST: [int]int;

var {:scalar} Mem_T.InterruptExpected__COMMAND_TABLE: [int]int;

var {:scalar} Mem_T.InterruptMode__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.IoControlCode_unnamed_tag_22: [int]int;

var {:scalar} Mem_T.IoHandle__ISSUE_FDC_COMMAND_PARMS: [int]int;

var {:scalar} Mem_T.IoOffset__ISSUE_FDC_COMMAND_PARMS: [int]int;

var {:scalar} Mem_T.IoResourceRequirementList_unnamed_tag_31: [int]int;

var {:scalar} Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT: [int]int;

var {:scalar} Mem_T.IsFDO__FDC_EXTENSION_HEADER: [int]int;

var {:scalar} Mem_T.IsrReentered__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.LastDeviceObject__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.Length40_unnamed_tag_64: [int]int;

var {:scalar} Mem_T.Length48_unnamed_tag_65: [int]int;

var {:scalar} Mem_T.Length64_unnamed_tag_66: [int]int;

var {:scalar} Mem_T.Length_unnamed_tag_18: [int]int;

var {:scalar} Mem_T.Length_unnamed_tag_44: [int]int;

var {:scalar} Mem_T.Level_unnamed_tag_45: [int]int;

var {:scalar} Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST: [int]int;

var {:scalar} Mem_T.List__CM_RESOURCE_LIST: [int]int;

var {:scalar} Mem_T.List__IO_RESOURCE_REQUIREMENTS_LIST: [int]int;

var {:scalar} Mem_T.LowPart__LUID: [int]int;

var {:scalar} Mem_T.MajorFunction__IO_STACK_LOCATION: [int]int;

var {:scalar} Mem_T.Map__IO_PORT_INFO: [int]int;

var {:scalar} Mem_T.MaxBusNumber_unnamed_tag_62: [int]int;

var {:scalar} Mem_T.MaxCylinderNumber__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.MaxHeadNumber__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.MaxSectorNumber__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.MaximumChannel_unnamed_tag_60: [int]int;

var {:scalar} Mem_T.MaximumLength__DEVICE_DESCRIPTION: [int]int;

var {:scalar} Mem_T.MaximumVector_unnamed_tag_59: [int]int;

var {:scalar} Mem_T.MinBusNumber_unnamed_tag_62: [int]int;

var {:scalar} Mem_T.MinimumChannel_unnamed_tag_60: [int]int;

var {:scalar} Mem_T.MinimumVector_unnamed_tag_59: [int]int;

var {:scalar} Mem_T.MinorFunction__IO_STACK_LOCATION: [int]int;

var {:scalar} Mem_T.MotorOffTime__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.MotorSettleTime__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.NumPDOs__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.NumberOfMapRegisters__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.NumberOfParameters__COMMAND_TABLE: [int]int;

var {:scalar} Mem_T.NumberOfResultBytes__COMMAND_TABLE: [int]int;

var {:scalar} Mem_T.OpCode__COMMAND_TABLE: [int]int;

var {:scalar} Mem_T.Option__IO_RESOURCE_DESCRIPTOR: [int]int;

var {:scalar} Mem_T.OutstandingRequests__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.PINT4: [int]int;

var {:scalar} Mem_T.PP_DEVICE_OBJECT: [int]int;

var {:scalar} Mem_T.PVOID: [int]int;

var {:scalar} Mem_T.P_ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.P_DEVICE_OBJECT: [int]int;

var {:scalar} Mem_T.ParentFdo__FDC_PDO_EXTENSION: [int]int;

var {:scalar} Mem_T.PartialDescriptors__CM_PARTIAL_RESOURCE_LIST: [int]int;

var {:scalar} Mem_T.Paused__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.PeripheralNumber__FDC_PDO_EXTENSION: [int]int;

var {:scalar} Mem_T.PriorityPolicy_unnamed_tag_59: [int]int;

var {:scalar} Mem_T.Priority_unnamed_tag_63: [int]int;

var {:scalar} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.ProcessorMask__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.QuadPart__LARGE_INTEGER: [int]int;

var {:scalar} Mem_T.ReadWriteGapLength__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.Removed__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.Removed__FDC_PDO_EXTENSION: [int]int;

var {:scalar} Mem_T.ReportedMissing__FDC_PDO_EXTENSION: [int]int;

var {:scalar} Mem_T.RequestLine_unnamed_tag_61: [int]int;

var {:scalar} Mem_T.Reserved1_unnamed_tag_56: [int]int;

var {:scalar} Mem_T.Reserved1_unnamed_tag_63: [int]int;

var {:scalar} Mem_T.Reserved2_unnamed_tag_56: [int]int;

var {:scalar} Mem_T.Reserved2_unnamed_tag_63: [int]int;

var {:scalar} Mem_T.Reserved__IO_RESOURCE_REQUIREMENTS_LIST: [int]int;

var {:scalar} Mem_T.Reserved_unnamed_tag_61: [int]int;

var {:scalar} Mem_T.Reserved_unnamed_tag_62: [int]int;

var {:scalar} Mem_T.Revision__IO_RESOURCE_LIST: [int]int;

var {:scalar} Mem_T.SaveFloatState__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.SectorLengthCode__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.SectorPerTrack__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.Self__FDC_EXTENSION_HEADER: [int]int;

var {:scalar} Mem_T.SharableVector__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR: [int]int;

var {:scalar} Mem_T.SignalState__DISPATCHER_HEADER: [int]int;

var {:scalar} Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR: [int]int;

var {:scalar} Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST: [int]int;

var {:scalar} Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR: [int]int;

var {:scalar} Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR: [int]int;

var {:scalar} Mem_T.SpeedsAvailable__FDC_INFORMATION: [int]int;

var {:scalar} Mem_T.StackSize__DEVICE_OBJECT: [int]int;

var {:scalar} Mem_T.Start_unnamed_tag_44: [int]int;

var {:scalar} Mem_T.Status__CONTROLLER: [int]int;

var {:scalar} Mem_T.Status__IO_STATUS_BLOCK: [int]int;

var {:scalar} Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA: [int]int;

var {:scalar} Mem_T.SystemState__POWER_STATE: [int]int;

var {:scalar} Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.TapeVendorId__FDC_PDO_EXTENSION: [int]int;

var {:scalar} Mem_T.TargetObject__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.TargetObject__FDC_PDO_EXTENSION: [int]int;

var {:scalar} Mem_T.TargetedProcessors_unnamed_tag_59: [int]int;

var {:scalar} Mem_T.TimeOut__ISSUE_FDC_COMMAND_PARMS: [int]int;

var {:scalar} Mem_T.TimeToWait__FDC_ENABLE_PARMS: [int]int;

var {:scalar} Mem_T.TransferBuffers__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.TransferBytes__ISSUE_FDC_ADAPTER_BUFFER_PARMS: [int]int;

var {:scalar} Mem_T.TransferBytes__ISSUE_FDC_COMMAND_PARMS: [int]int;

var {:scalar} Mem_T.TransferWidth_unnamed_tag_61: [int]int;

var {:scalar} Mem_T.Type3InputBuffer_unnamed_tag_22: [int]int;

var {:scalar} Mem_T.Type__IO_RESOURCE_DESCRIPTOR: [int]int;

var {:scalar} Mem_T.Type_unnamed_tag_28: [int]int;

var {:scalar} Mem_T.Type_unnamed_tag_39: [int]int;

var {:scalar} Mem_T.Type_unnamed_tag_56: [int]int;

var {:scalar} Mem_T.UserBuffer__IRP: [int]int;

var {:scalar} Mem_T.Vector_unnamed_tag_45: [int]int;

var {:scalar} Mem_T.Version__IO_RESOURCE_LIST: [int]int;

var {:scalar} Mem_T.Virtual__TRANSFER_BUFFER: [int]int;

var {:scalar} Mem_T.WakeUp__FDC_FDO_EXTENSION: [int]int;

var {:scalar} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT: [int]int;

var {:template} {:includeFormalIn} {:match "in_oldIrql*"} templ_irql: int;

var {:template} {:includeFormalIn} {:match "in_OldIrql*"} templ_irql2: int;

var {:template} {:includeFormalIn} {:match "in_cancelIrql*"} templ_irql3: int;

var {:template} {:includeFormalIn} {:match "in_CancelIrql*"} templ_irql4: int;

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

const sdv_IoBuildSynchronousFsdRequest_irp: int;

const sdv_harnessStackLocation_next: int;

const sdv_other_irp: int;

const sdv_IoBuildDeviceIoControlRequest_irp: int;

const sdv_harnessDeviceExtension_two: int;

const sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock: int;

const sdv_pv1: int;

const sdv_pv3: int;

const sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX: int;

const p_sdv_fx_dev_object: int;

const sdv_IoBuildAsynchronousFsdRequest_harnessIrp: int;

const sdv_p_devobj_pdo: int;

const sdv_kinterrupt: int;

const sdv_start_irp_already_issued: int;

const sdv_kdpc: int;

const sdv_IoGetDeviceToVerify_DEVICE_OBJECT: int;

const sdv_p_devobj_child_pdo: int;

const sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next: int;

const sdv_IoBuildAsynchronousFsdRequest_irp: int;

const sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock: int;

const sdv_ControllerIrp: int;

const sdv_devobj_pdo: int;

const sdv_Io_Removelock_release_wait_returned: int;

const sdv_IoGetDmaAdapter_DMA_ADAPTER: int;

const sdv_IoInitializeIrp_harnessIrp: int;

const sdv_ke_dpc: int;

const sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT: int;

const sdv_irp: int;

const sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next: int;

const sdv_IoCreateSynchronizationEvent_KEVENT: int;

const sdv_ControllerPirp: int;

const sdv_harnessStackLocation: int;

const sdv_other_harnessStackLocation_next: int;

const sdv_IoCreateController_CONTROLLER_OBJECT: int;

const sdv_devobj_top: int;

const sdv_pv2: int;

const sdv_kdpc_val3: int;

const sdv_IoBuildSynchronousFsdRequest_harnessIrp: int;

const sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT: int;

const sdv_MapRegisterBase_val: int;

const sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING: int;

const sdv_IoMakeAssociatedIrp_harnessIrp: int;

const sdv_power_irp: int;

const sdv_devobj_child_pdo: int;

const sdv_harnessIrp: int;

const sdv_pIoDpcContext: int;

const sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next: int;

const sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock: int;

const sdv_kinterrupt_val: int;

const sdv_StartIopirp: int;

const sdv_fx_dev_object: int;

const sdv_devobj_fdo: int;

const sdv_harnessDeviceExtension: int;

const sdv_DpcContext: int;

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

const sdv_inside_init_entrypoint: int;

const sdv_IoCreateNotificationEvent_KEVENT: int;

const sdv_other_harnessStackLocation: int;

const sdv_maskedEflags: int;

const sdv_MmMapIoSpace_int: int;

const sdv_cancelFptr: int;

const BufferSize: int;

const PagingMutex: int;

const NotConfigurable: int;

const Model30: int;

const NumberOfBuffers: int;

procedure {:origName "_sdv_init2"} _sdv_init2();
  modifies alloc;



implementation {:origName "_sdv_init2"} _sdv_init2()
{
  var vslice_dummy_var_0: int;

  anon0:
    call vslice_dummy_var_0 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "DeviceQueryACPI_SyncExecMethodForPackage"} DeviceQueryACPI_SyncExecMethodForPackage(actual_DeviceObject: int, actual_ControlMethodName: int, actual_ArgumentCount: int, actual_ArgumentTypeArray: int, actual_ArgumentSizeArray: int, actual_ArgumentArray: int, actual_ExpectedElementCount: int, actual_ReturnBufferExpectedSize: int, actual_ExpectedTypeArray: int, actual_ExpectedSizeArray: int, actual_ReturnBuffer: int) returns (Tmp_3: int);
  modifies alloc, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.Type_unnamed_tag_28, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CompletionRoutine__IO_STACK_LOCATION, yogi_error;



implementation {:origName "DeviceQueryACPI_SyncExecMethodForPackage"} DeviceQueryACPI_SyncExecMethodForPackage(actual_DeviceObject: int, actual_ControlMethodName: int, actual_ArgumentCount: int, actual_ArgumentTypeArray: int, actual_ArgumentSizeArray: int, actual_ArgumentArray: int, actual_ExpectedElementCount: int, actual_ReturnBufferExpectedSize: int, actual_ExpectedTypeArray: int, actual_ExpectedSizeArray: int, actual_ReturnBuffer: int) returns (Tmp_3: int)
{
  var {:scalar} i: int;
  var {:scalar} Tmp_4: int;
  var {:scalar} Tmp_5: int;
  var {:scalar} argumentSize: int;
  var {:scalar} context: int;
  var {:scalar} totalSize: int;
  var {:pointer} argument: int;
  var {:scalar} Tmp_7: int;
  var {:scalar} status: int;
  var {:scalar} Tmp_10: int;
  var {:pointer} DeviceObject: int;
  var {:scalar} ControlMethodName: int;
  var {:scalar} ArgumentCount: int;
  var {:pointer} ArgumentTypeArray: int;
  var {:pointer} ArgumentSizeArray: int;
  var {:pointer} ArgumentArray: int;
  var {:scalar} ExpectedElementCount: int;
  var {:scalar} ReturnBufferExpectedSize: int;
  var {:pointer} ExpectedTypeArray: int;
  var {:pointer} ExpectedSizeArray: int;
  var {:pointer} ReturnBuffer: int;
  var boogieTmp: int;
  var vslice_dummy_var_1: int;

  anon0:
    call context := __HAVOC_malloc(164);
    DeviceObject := actual_DeviceObject;
    ControlMethodName := actual_ControlMethodName;
    ArgumentCount := actual_ArgumentCount;
    ArgumentTypeArray := actual_ArgumentTypeArray;
    ArgumentSizeArray := actual_ArgumentSizeArray;
    ArgumentArray := actual_ArgumentArray;
    ExpectedElementCount := actual_ExpectedElementCount;
    ReturnBufferExpectedSize := actual_ReturnBufferExpectedSize;
    ExpectedTypeArray := actual_ExpectedTypeArray;
    ExpectedSizeArray := actual_ExpectedSizeArray;
    ReturnBuffer := actual_ReturnBuffer;
    assume {:nonnull} context != 0;
    assume context > 0;
    Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT[IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] := 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] := 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)))] := 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(context))))] := 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(context))))] := 0;
    call sdv_do_paged_code_check();
    assume {:nonnull} ReturnBuffer != 0;
    assume ReturnBuffer > 0;
    Mem_T.PVOID[ReturnBuffer] := 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] := 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    call KeInitializeEvent(Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(context), 0, 0);
    Tmp_4 := ReturnBufferExpectedSize + ExpectedElementCount * 8 - 4;
    call status := DeviceQueryACPI_AsyncExecMethod(DeviceObject, ControlMethodName, ArgumentCount, ArgumentTypeArray, ArgumentSizeArray, ArgumentArray, Tmp_4, li2bplFunctionConstant247, context);
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} status == 259;
    call vslice_dummy_var_1 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} yogi_error != 1;
    goto L32;

  L32:
    assume {:nonnull} context != 0;
    assume context > 0;
    status := Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT[IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)];
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} status < 0;
    goto L39;

  L39:
    assume {:nonnull} context != 0;
    assume context > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] != 0;
    call sdv_ExFreePool(0);
    goto L40;

  L40:
    Tmp_3 := status;
    goto LM2;

  LM2:
    return;

  anon37_Then:
    assume {:partition} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] == 0;
    goto L40;

  anon49_Then:
    assume {:partition} 0 <= status;
    assume {:nonnull} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] != 0;
    assume Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} Mem_T.Count__ACPI_EVAL_OUTPUT_BUFFER[Count__ACPI_EVAL_OUTPUT_BUFFER(Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)])] != ExpectedElementCount;
    status := -1073741823;
    goto L39;

  anon36_Then:
    assume {:partition} Mem_T.Count__ACPI_EVAL_OUTPUT_BUFFER[Count__ACPI_EVAL_OUTPUT_BUFFER(Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)])] == ExpectedElementCount;
    assume {:nonnull} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] != 0;
    assume Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    argument := Mem_T.Argument__ACPI_EVAL_OUTPUT_BUFFER[Argument__ACPI_EVAL_OUTPUT_BUFFER(Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)])];
    totalSize := 0;
    i := 0;
    goto L46;

  L46:
    call i, Tmp_5, argumentSize, totalSize, Tmp_10 := DeviceQueryACPI_SyncExecMethodForPackage_loop_L46(i, Tmp_5, argumentSize, totalSize, argument, Tmp_10, ExpectedElementCount, ExpectedTypeArray, ExpectedSizeArray);
    goto L46_last;

  anon38_Else:
    assume {:partition} ExpectedElementCount > i;
    Tmp_10 := i;
    assume {:nonnull} ExpectedTypeArray != 0;
    assume ExpectedTypeArray > 0;
    assume {:nonnull} argument != 0;
    assume argument > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] != Mem_T.INT4[ExpectedTypeArray + Tmp_10 * 4];
    status := -1073741823;
    goto L39;

  anon50_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] == Mem_T.INT4[ExpectedTypeArray + Tmp_10 * 4];
    assume {:nonnull} argument != 0;
    assume argument > 0;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] != 0;
    assume {:nonnull} argument != 0;
    assume argument > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] != 1;
    assume {:nonnull} argument != 0;
    assume argument > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] == 2;
    goto L54;

  L54:
    assume {:nonnull} argument != 0;
    assume argument > 0;
    argumentSize := Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(argument)];
    goto L56;

  L56:
    Tmp_5 := i;
    assume {:nonnull} ExpectedSizeArray != 0;
    assume ExpectedSizeArray > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} argumentSize != Mem_T.INT4[ExpectedSizeArray + Tmp_5 * 4];
    status := -1073741823;
    goto L39;

  anon51_Then:
    assume {:partition} argumentSize == Mem_T.INT4[ExpectedSizeArray + Tmp_5 * 4];
    totalSize := totalSize + argumentSize;
    i := i + 1;
    goto anon51_Then_dummy;

  anon44_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] != 2;
    status := -1073741823;
    goto L39;

  anon45_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] == 1;
    goto L54;

  anon40_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] == 0;
    argumentSize := 4;
    goto L56;

  anon38_Then:
    assume {:partition} i >= ExpectedElementCount;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} totalSize != ReturnBufferExpectedSize;
    status := -1073741823;
    goto L39;

  anon39_Then:
    assume {:partition} totalSize == ReturnBufferExpectedSize;
    assume {:nonnull} ReturnBuffer != 0;
    assume ReturnBuffer > 0;
    call boogieTmp := ExAllocatePool(5, totalSize);
    Mem_T.PVOID[ReturnBuffer] := boogieTmp;
    assume {:nonnull} ReturnBuffer != 0;
    assume ReturnBuffer > 0;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} Mem_T.PVOID[ReturnBuffer] != 0;
    assume {:nonnull} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] != 0;
    assume Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] > 0;
    assume {:nonnull} context != 0;
    assume context > 0;
    argument := Mem_T.Argument__ACPI_EVAL_OUTPUT_BUFFER[Argument__ACPI_EVAL_OUTPUT_BUFFER(Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)])];
    totalSize := 0;
    i := 0;
    goto L78;

  L78:
    call i, totalSize, Tmp_7 := DeviceQueryACPI_SyncExecMethodForPackage_loop_L78(i, totalSize, argument, Tmp_7, ExpectedElementCount, ReturnBuffer);
    goto L78_last;

  anon42_Else:
    assume {:partition} ExpectedElementCount > i;
    assume {:nonnull} argument != 0;
    assume argument > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] != 0;
    assume {:nonnull} argument != 0;
    assume argument > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] != 1;
    assume {:nonnull} argument != 0;
    assume argument > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] == 2;
    goto L82;

  L82:
    assume {:nonnull} argument != 0;
    assume argument > 0;
    Tmp_7 := Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(argument)];
    assume {:nonnull} ReturnBuffer != 0;
    assume ReturnBuffer > 0;
    call sdv_RtlCopyMemory(0, 0, Tmp_7);
    assume {:nonnull} argument != 0;
    assume argument > 0;
    totalSize := totalSize + Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(argument)];
    goto L92;

  L92:
    i := i + 1;
    goto L92_dummy;

  anon46_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] != 2;
    status := -1073741823;
    goto L39;

  anon47_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] == 1;
    goto L82;

  anon43_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument)] == 0;
    assume {:nonnull} ReturnBuffer != 0;
    assume ReturnBuffer > 0;
    call sdv_RtlCopyMemory(0, 0, 4);
    totalSize := totalSize + 4;
    goto L92;

  anon42_Then:
    assume {:partition} i >= ExpectedElementCount;
    goto L39;

  anon41_Then:
    assume {:partition} Mem_T.PVOID[ReturnBuffer] == 0;
    status := -1073741801;
    goto L39;

  anon48_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon35_Then:
    assume {:partition} status != 259;
    assume {:nonnull} context != 0;
    assume context > 0;
    Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT[IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT(context)] := status;
    goto L32;

  L92_dummy:
    assume false;
    return;

  L78_last:
    goto anon42_Then, anon42_Else;

  anon51_Then_dummy:
    assume false;
    return;

  L46_last:
    goto anon38_Then, anon38_Else;
}



procedure {:origName "DeviceQueryACPI_AsyncExecMethod"} DeviceQueryACPI_AsyncExecMethod(actual_DeviceObject_1: int, actual_ControlMethodName_1: int, actual_ArgumentCount_1: int, actual_ArgumentTypeArray_1: int, actual_ArgumentSizeArray_1: int, actual_ArgumentArray_1: int, actual_ReturnBufferMaxSize: int, actual_CallerCompletionRoutine: int, actual_CallerContext: int) returns (Tmp_11: int);
  modifies Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.Type_unnamed_tag_28, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, alloc, Mem_T.CompletionRoutine__IO_STACK_LOCATION;



implementation {:origName "DeviceQueryACPI_AsyncExecMethod"} DeviceQueryACPI_AsyncExecMethod(actual_DeviceObject_1: int, actual_ControlMethodName_1: int, actual_ArgumentCount_1: int, actual_ArgumentTypeArray_1: int, actual_ArgumentSizeArray_1: int, actual_ArgumentArray_1: int, actual_ReturnBufferMaxSize: int, actual_CallerCompletionRoutine: int, actual_CallerContext: int) returns (Tmp_11: int)
{
  var {:scalar} i_1: int;
  var {:scalar} Tmp_13: int;
  var {:scalar} Tmp_14: int;
  var {:scalar} Tmp_15: int;
  var {:scalar} Tmp_16: int;
  var {:scalar} Tmp_17: int;
  var {:pointer} irpSp: int;
  var {:scalar} Tmp_18: int;
  var {:pointer} cmInputData: int;
  var {:pointer} Tmp_19: int;
  var {:scalar} argumentSize_1: int;
  var {:pointer} targetDeviceObject: int;
  var {:pointer} sdv_5: int;
  var {:pointer} context_1: int;
  var {:scalar} cmOutputDataSize: int;
  var {:scalar} Tmp_20: int;
  var {:pointer} argument_1: int;
  var {:scalar} Tmp_21: int;
  var {:pointer} sdv_8: int;
  var {:scalar} Tmp_23: int;
  var {:pointer} irp: int;
  var {:scalar} Tmp_24: int;
  var {:scalar} Tmp_25: int;
  var {:scalar} Tmp_26: int;
  var {:scalar} cmInputDataSize: int;
  var {:scalar} status_1: int;
  var {:scalar} Tmp_27: int;
  var {:scalar} Tmp_28: int;
  var {:pointer} cmOutputData: int;
  var {:scalar} systemBufferLength: int;
  var {:scalar} Tmp_29: int;
  var {:pointer} DeviceObject_1: int;
  var {:scalar} ControlMethodName_1: int;
  var {:scalar} ArgumentCount_1: int;
  var {:pointer} ArgumentTypeArray_1: int;
  var {:pointer} ArgumentSizeArray_1: int;
  var {:pointer} ArgumentArray_1: int;
  var {:scalar} ReturnBufferMaxSize: int;
  var {:scalar} CallerCompletionRoutine: int;
  var {:pointer} CallerContext: int;
  var vslice_dummy_var_2: int;
  var vslice_dummy_var_3: int;

  anon0:
    DeviceObject_1 := actual_DeviceObject_1;
    ControlMethodName_1 := actual_ControlMethodName_1;
    ArgumentCount_1 := actual_ArgumentCount_1;
    ArgumentTypeArray_1 := actual_ArgumentTypeArray_1;
    ArgumentSizeArray_1 := actual_ArgumentSizeArray_1;
    ArgumentArray_1 := actual_ArgumentArray_1;
    ReturnBufferMaxSize := actual_ReturnBufferMaxSize;
    CallerCompletionRoutine := actual_CallerCompletionRoutine;
    CallerContext := actual_CallerContext;
    cmInputData := 0;
    irp := 0;
    targetDeviceObject := 0;
    cmOutputDataSize := 12 + ReturnBufferMaxSize;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} 20 > cmOutputDataSize;
    cmOutputDataSize := 20;
    goto L21;

  L21:
    call sdv_5 := ExAllocatePool(516, cmOutputDataSize);
    cmOutputData := sdv_5;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} cmOutputData != 0;
    cmInputDataSize := 24;
    i_1 := 0;
    goto L30;

  L30:
    call i_1, Tmp_15, Tmp_17, Tmp_18, argumentSize_1, Tmp_20, Tmp_24, cmInputDataSize, Tmp_27, Tmp_29 := DeviceQueryACPI_AsyncExecMethod_loop_L30(i_1, Tmp_15, Tmp_17, Tmp_18, argumentSize_1, Tmp_20, Tmp_24, cmInputDataSize, Tmp_27, Tmp_29, ArgumentCount_1, ArgumentTypeArray_1, ArgumentSizeArray_1);
    goto L30_last;

  anon43_Else:
    assume {:partition} ArgumentCount_1 > i_1;
    Tmp_17 := i_1;
    assume {:nonnull} ArgumentTypeArray_1 != 0;
    assume ArgumentTypeArray_1 > 0;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} Mem_T.INT4[ArgumentTypeArray_1 + Tmp_17 * 4] != 0;
    assume {:nonnull} ArgumentTypeArray_1 != 0;
    assume ArgumentTypeArray_1 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} Mem_T.INT4[ArgumentTypeArray_1 + Tmp_17 * 4] != 1;
    assume {:nonnull} ArgumentTypeArray_1 != 0;
    assume ArgumentTypeArray_1 > 0;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} Mem_T.INT4[ArgumentTypeArray_1 + Tmp_17 * 4] == 2;
    Tmp_15 := i_1;
    assume {:nonnull} ArgumentSizeArray_1 != 0;
    assume ArgumentSizeArray_1 > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} 4 > Mem_T.INT4[ArgumentSizeArray_1 + Tmp_15 * 4];
    Tmp_24 := 4;
    goto L39;

  L39:
    argumentSize_1 := 4 + Tmp_24;
    goto L41;

  L41:
    cmInputDataSize := cmInputDataSize + argumentSize_1;
    i_1 := i_1 + 1;
    goto L41_dummy;

  anon60_Then:
    assume {:partition} Mem_T.INT4[ArgumentSizeArray_1 + Tmp_15 * 4] >= 4;
    Tmp_27 := i_1;
    assume {:nonnull} ArgumentSizeArray_1 != 0;
    assume ArgumentSizeArray_1 > 0;
    Tmp_24 := Mem_T.INT4[ArgumentSizeArray_1 + Tmp_27 * 4];
    goto L39;

  anon52_Then:
    assume {:partition} Mem_T.INT4[ArgumentTypeArray_1 + Tmp_17 * 4] != 2;
    status_1 := -1073741811;
    goto L49;

  L49:
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} targetDeviceObject != 0;
    call vslice_dummy_var_2 := sdv_ObDereferenceObject(0);
    goto L50;

  L50:
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} status_1 >= 0;
    goto L55;

  L55:
    Tmp_11 := status_1;
    goto L1;

  L1:
    return;

  anon46_Then:
    assume {:partition} 0 > status_1;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} irp != 0;
    call IoFreeIrp(0);
    goto L56;

  L56:
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} cmInputData != 0;
    call sdv_ExFreePool(0);
    goto L60;

  L60:
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} cmOutputData != 0;
    call sdv_ExFreePool(0);
    goto L55;

  anon49_Then:
    assume {:partition} cmOutputData == 0;
    goto L55;

  anon48_Then:
    assume {:partition} cmInputData == 0;
    goto L60;

  anon47_Then:
    assume {:partition} irp == 0;
    goto L56;

  anon45_Then:
    assume {:partition} targetDeviceObject == 0;
    goto L50;

  anon53_Then:
    assume {:partition} Mem_T.INT4[ArgumentTypeArray_1 + Tmp_17 * 4] == 1;
    Tmp_20 := i_1;
    assume {:nonnull} ArgumentSizeArray_1 != 0;
    assume ArgumentSizeArray_1 > 0;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} 4 > Mem_T.INT4[ArgumentSizeArray_1 + Tmp_20 * 4];
    Tmp_18 := 4;
    goto L45;

  L45:
    argumentSize_1 := 4 + Tmp_18;
    goto L41;

  anon59_Then:
    assume {:partition} Mem_T.INT4[ArgumentSizeArray_1 + Tmp_20 * 4] >= 4;
    Tmp_29 := i_1;
    assume {:nonnull} ArgumentSizeArray_1 != 0;
    assume ArgumentSizeArray_1 > 0;
    Tmp_18 := Mem_T.INT4[ArgumentSizeArray_1 + Tmp_29 * 4];
    goto L45;

  anon58_Then:
    assume {:partition} Mem_T.INT4[ArgumentTypeArray_1 + Tmp_17 * 4] == 0;
    argumentSize_1 := 8;
    goto L41;

  anon43_Then:
    assume {:partition} i_1 >= ArgumentCount_1;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} cmInputDataSize > cmOutputDataSize;
    systemBufferLength := cmInputDataSize;
    goto L69;

  L69:
    systemBufferLength := BAND(systemBufferLength + 4 - 1, BNOT(BOR(1, 2)));
    Tmp_16 := systemBufferLength + 32;
    call sdv_8 := ExAllocatePool(516, Tmp_16);
    cmInputData := sdv_8;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} cmInputData != 0;
    Tmp_13 := systemBufferLength + 32;
    call sdv_RtlZeroMemory(0, Tmp_13);
    context_1 := cmInputData;
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT[CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT(context_1)] := CallerCompletionRoutine;
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT[CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT(context_1)] := CallerContext;
    assume {:nonnull} cmInputData != 0;
    assume cmInputData > 0;
    Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR[Signature__DRIVE_LAYOUT_INFORMATION_MBR(cmInputData)] := -1016502975;
    assume {:nonnull} cmInputData != 0;
    assume cmInputData > 0;
    assume {:nonnull} cmInputData != 0;
    assume cmInputData > 0;
    assume {:nonnull} cmInputData != 0;
    assume cmInputData > 0;
    assume {:nonnull} cmInputData != 0;
    assume cmInputData > 0;
    argument_1 := Mem_T.Argument__ACPI_EVAL_INPUT_BUFFER_COMPLEX[Argument__ACPI_EVAL_INPUT_BUFFER_COMPLEX(cmInputData)];
    i_1 := 0;
    goto L90;

  L90:
    call i_1, Tmp_14, Tmp_19, argumentSize_1, Tmp_21, Tmp_23, Tmp_25, Tmp_26, Tmp_28 := DeviceQueryACPI_AsyncExecMethod_loop_L90(i_1, Tmp_14, Tmp_19, argumentSize_1, argument_1, Tmp_21, Tmp_23, Tmp_25, Tmp_26, Tmp_28, ArgumentCount_1, ArgumentTypeArray_1, ArgumentSizeArray_1, ArgumentArray_1);
    goto L90_last;

  anon50_Else:
    assume {:partition} ArgumentCount_1 > i_1;
    Tmp_25 := i_1;
    assume {:nonnull} ArgumentTypeArray_1 != 0;
    assume ArgumentTypeArray_1 > 0;
    assume {:nonnull} argument_1 != 0;
    assume argument_1 > 0;
    Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_1)] := Mem_T.INT4[ArgumentTypeArray_1 + Tmp_25 * 4];
    Tmp_28 := i_1;
    assume {:nonnull} ArgumentSizeArray_1 != 0;
    assume ArgumentSizeArray_1 > 0;
    assume {:nonnull} argument_1 != 0;
    assume argument_1 > 0;
    Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(argument_1)] := Mem_T.INT4[ArgumentSizeArray_1 + Tmp_28 * 4];
    assume {:nonnull} argument_1 != 0;
    assume argument_1 > 0;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_1)] != 0;
    assume {:nonnull} argument_1 != 0;
    assume argument_1 > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_1)] != 1;
    assume {:nonnull} argument_1 != 0;
    assume argument_1 > 0;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_1)] != 2;
    goto L112;

  L112:
    i_1 := i_1 + 1;
    goto L112_dummy;

  anon54_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_1)] == 2;
    goto L99;

  L99:
    Tmp_23 := i_1;
    assume {:nonnull} ArgumentSizeArray_1 != 0;
    assume ArgumentSizeArray_1 > 0;
    argumentSize_1 := Mem_T.INT4[ArgumentSizeArray_1 + Tmp_23 * 4];
    Tmp_21 := i_1;
    assume {:nonnull} ArgumentArray_1 != 0;
    assume ArgumentArray_1 > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} Mem_T.PVOID[ArgumentArray_1 + Tmp_21 * 4] != 0;
    Tmp_26 := i_1;
    assume {:nonnull} ArgumentArray_1 != 0;
    assume ArgumentArray_1 > 0;
    call sdv_RtlCopyMemory(0, 0, argumentSize_1);
    goto L112;

  anon63_Then:
    assume {:partition} Mem_T.PVOID[ArgumentArray_1 + Tmp_21 * 4] == 0;
    call sdv_RtlZeroMemory(0, argumentSize_1);
    goto L112;

  anon55_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_1)] == 1;
    goto L99;

  anon62_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_1)] == 0;
    Tmp_14 := i_1;
    assume {:nonnull} ArgumentArray_1 != 0;
    assume ArgumentArray_1 > 0;
    Tmp_19 := Mem_T.PVOID[ArgumentArray_1 + Tmp_14 * 4];
    assume {:nonnull} Tmp_19 != 0;
    assume Tmp_19 > 0;
    assume {:nonnull} argument_1 != 0;
    assume argument_1 > 0;
    goto L112;

  anon50_Then:
    assume {:partition} i_1 >= ArgumentCount_1;
    call targetDeviceObject := IoGetAttachedDeviceReference(DeviceObject_1);
    assume {:nonnull} targetDeviceObject != 0;
    assume targetDeviceObject > 0;
    call irp := IoAllocateIrp(Mem_T.StackSize__DEVICE_OBJECT[StackSize__DEVICE_OBJECT(targetDeviceObject)], 0);
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} irp != 0;
    assume {:nonnull} irp != 0;
    assume irp > 0;
    assume {:nonnull} irp != 0;
    assume irp > 0;
    assume {:nonnull} irp != 0;
    assume irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(irp))] := -1073741637;
    call irpSp := sdv_IoGetNextIrpStackLocation(irp);
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(irpSp)] := 14;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    assume {:nonnull} irpSp != 0;
    assume irpSp > 0;
    Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp)))] := 3325952;
    assume {:nonnull} irp != 0;
    assume irp > 0;
    Mem_T.UserBuffer__IRP[UserBuffer__IRP(irp)] := cmOutputData;
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT[DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT(context_1)] := DeviceObject_1;
    assume {:nonnull} context_1 != 0;
    assume context_1 > 0;
    call sdv_IoSetCompletionRoutine(irp, li2bplFunctionConstant250, context_1, 1, 1, 1);
    call vslice_dummy_var_3 := sdv_IoCallDriver(targetDeviceObject, irp);
    Tmp_11 := 259;
    goto L1;

  anon51_Then:
    assume {:partition} irp == 0;
    status_1 := -1073741801;
    goto L49;

  anon61_Then:
    assume {:partition} cmInputData == 0;
    status_1 := -1073741801;
    goto L49;

  anon44_Then:
    assume {:partition} cmOutputDataSize >= cmInputDataSize;
    systemBufferLength := cmOutputDataSize;
    goto L69;

  anon57_Then:
    assume {:partition} cmOutputData == 0;
    status_1 := -1073741801;
    goto L49;

  anon56_Then:
    assume {:partition} cmOutputDataSize >= 20;
    goto L21;

  L112_dummy:
    assume false;
    return;

  L90_last:
    goto anon50_Then, anon50_Else;

  L41_dummy:
    assume false;
    return;

  L30_last:
    goto anon43_Then, anon43_Else;
}



procedure {:origName "DeviceQueryACPI_SyncExecMethod_CompletionRoutine"} DeviceQueryACPI_SyncExecMethod_CompletionRoutine(actual_DeviceObject_2: int, actual_Status: int, actual_cmOutputData_1: int, actual_Context: int);
  modifies alloc, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.SignalState__DISPATCHER_HEADER;



implementation {:origName "DeviceQueryACPI_SyncExecMethod_CompletionRoutine"} DeviceQueryACPI_SyncExecMethod_CompletionRoutine(actual_DeviceObject_2: int, actual_Status: int, actual_cmOutputData_1: int, actual_Context: int)
{
  var {:pointer} context_2: int;
  var {:scalar} Status: int;
  var {:pointer} cmOutputData_1: int;
  var {:pointer} Context: int;
  var vslice_dummy_var_4: int;
  var vslice_dummy_var_5: int;

  anon0:
    call vslice_dummy_var_4 := __HAVOC_malloc(4);
    Status := actual_Status;
    cmOutputData_1 := actual_cmOutputData_1;
    Context := actual_Context;
    context_2 := Context;
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_2)] := cmOutputData_1;
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT[IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_2)] := Status;
    assume {:nonnull} context_2 != 0;
    assume context_2 > 0;
    call vslice_dummy_var_5 := KeSetEvent(Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_2), 1, 0);
    return;
}



procedure {:origName "DeviceQueryACPI_AsyncExecMethod_CompletionRoutine"} DeviceQueryACPI_AsyncExecMethod_CompletionRoutine(actual_DeviceObject_3: int, actual_Irp: int, actual_Context_1: int) returns (Tmp_32: int);
  modifies alloc, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.SignalState__DISPATCHER_HEADER;



implementation {:origName "DeviceQueryACPI_AsyncExecMethod_CompletionRoutine"} DeviceQueryACPI_AsyncExecMethod_CompletionRoutine(actual_DeviceObject_3: int, actual_Irp: int, actual_Context_1: int) returns (Tmp_32: int)
{
  var {:scalar} sdv_13: int;
  var {:pointer} context_3: int;
  var {:pointer} cmOutputData_2: int;
  var {:pointer} Irp: int;
  var {:pointer} Context_1: int;
  var vslice_dummy_var_6: int;

  anon0:
    Irp := actual_Irp;
    Context_1 := actual_Context_1;
    context_3 := Context_1;
    cmOutputData_2 := 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    call sdv_13 := sdv_NT_ERROR(Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp))]);
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} sdv_13 != 0;
    call sdv_ExFreePool(0);
    goto L35;

  L35:
    assume {:IndirectCall} true;
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    assume Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT[CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT(context_3)] == li2bplFunctionConstant247;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    assume {:nonnull} context_3 != 0;
    assume context_3 > 0;
    call DeviceQueryACPI_SyncExecMethod_CompletionRoutine(Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT[DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT(context_3)], Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp))], cmOutputData_2, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT[CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT(context_3)]);
    call vslice_dummy_var_6 := sdv_ObDereferenceObject(0);
    call sdv_ExFreePool(0);
    call IoFreeIrp(0);
    Tmp_32 := -1073741802;
    return;

  anon5_Then:
    assume {:partition} sdv_13 == 0;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    call sdv_RtlCopyMemory(0, 0, Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp))]);
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    cmOutputData_2 := Mem_T.UserBuffer__IRP[UserBuffer__IRP(Irp)];
    assume {:nonnull} cmOutputData_2 != 0;
    assume cmOutputData_2 > 0;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR[Signature__DRIVE_LAYOUT_INFORMATION_MBR(cmOutputData_2)] == -1032886975;
    goto L35;

  anon6_Then:
    assume {:partition} Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR[Signature__DRIVE_LAYOUT_INFORMATION_MBR(cmOutputData_2)] != -1032886975;
    assume {:nonnull} Irp != 0;
    assume Irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp))] := -1073741823;
    goto L35;
}



procedure {:origName "DeviceQueryACPI_SyncExecMethod"} DeviceQueryACPI_SyncExecMethod(actual_DeviceObject_4: int, actual_ControlMethodName_2: int, actual_ArgumentCount_2: int, actual_ArgumentTypeArray_2: int, actual_ArgumentSizeArray_2: int, actual_ArgumentArray_2: int, actual_ExpectedReturnType: int, actual_ReturnBufferMaxSize_1: int, actual_IntegerReturn: int, actual_ReturnBufferFinalSize: int, actual_ReturnBuffer_1: int) returns (Tmp_34: int);
  modifies alloc, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.INT4, Mem_T.PVOID, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.Type_unnamed_tag_28, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CompletionRoutine__IO_STACK_LOCATION, yogi_error;



implementation {:origName "DeviceQueryACPI_SyncExecMethod"} DeviceQueryACPI_SyncExecMethod(actual_DeviceObject_4: int, actual_ControlMethodName_2: int, actual_ArgumentCount_2: int, actual_ArgumentTypeArray_2: int, actual_ArgumentSizeArray_2: int, actual_ArgumentArray_2: int, actual_ExpectedReturnType: int, actual_ReturnBufferMaxSize_1: int, actual_IntegerReturn: int, actual_ReturnBufferFinalSize: int, actual_ReturnBuffer_1: int) returns (Tmp_34: int)
{
  var {:scalar} Tmp_35: int;
  var {:scalar} context_4: int;
  var {:scalar} Tmp_36: int;
  var {:pointer} argument_2: int;
  var {:scalar} sdv_17: int;
  var {:pointer} Tmp_37: int;
  var {:scalar} status_2: int;
  var {:scalar} Tmp_39: int;
  var {:pointer} DeviceObject_4: int;
  var {:scalar} ControlMethodName_2: int;
  var {:scalar} ArgumentCount_2: int;
  var {:pointer} ArgumentTypeArray_2: int;
  var {:pointer} ArgumentSizeArray_2: int;
  var {:pointer} ArgumentArray_2: int;
  var {:scalar} ExpectedReturnType: int;
  var {:scalar} ReturnBufferMaxSize_1: int;
  var {:pointer} IntegerReturn: int;
  var {:pointer} ReturnBufferFinalSize: int;
  var {:pointer} ReturnBuffer_1: int;
  var boogieTmp: int;
  var vslice_dummy_var_7: int;

  anon0:
    call context_4 := __HAVOC_malloc(164);
    DeviceObject_4 := actual_DeviceObject_4;
    ControlMethodName_2 := actual_ControlMethodName_2;
    ArgumentCount_2 := actual_ArgumentCount_2;
    ArgumentTypeArray_2 := actual_ArgumentTypeArray_2;
    ArgumentSizeArray_2 := actual_ArgumentSizeArray_2;
    ArgumentArray_2 := actual_ArgumentArray_2;
    ExpectedReturnType := actual_ExpectedReturnType;
    ReturnBufferMaxSize_1 := actual_ReturnBufferMaxSize_1;
    IntegerReturn := actual_IntegerReturn;
    ReturnBufferFinalSize := actual_ReturnBufferFinalSize;
    ReturnBuffer_1 := actual_ReturnBuffer_1;
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT[IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] := 0;
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] := 0;
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)))] := 0;
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4))))] := 0;
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(WaitListHead__DISPATCHER_HEADER(Header__KEVENT(Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4))))] := 0;
    argument_2 := 0;
    call sdv_do_paged_code_check();
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} IntegerReturn != 0;
    assume {:nonnull} IntegerReturn != 0;
    assume IntegerReturn > 0;
    Mem_T.INT4[IntegerReturn] := -1;
    goto L16;

  L16:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} ReturnBufferFinalSize != 0;
    assume {:nonnull} ReturnBufferFinalSize != 0;
    assume ReturnBufferFinalSize > 0;
    Mem_T.INT4[ReturnBufferFinalSize] := 0;
    goto L18;

  L18:
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} ReturnBuffer_1 != 0;
    assume {:nonnull} ReturnBuffer_1 != 0;
    assume ReturnBuffer_1 > 0;
    Mem_T.PVOID[ReturnBuffer_1] := 0;
    goto L20;

  L20:
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} ExpectedReturnType != 0;
    goto L23;

  L23:
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    call KeInitializeEvent(Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4), 0, 0);
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] := 0;
    Tmp_39 := ReturnBufferMaxSize_1 + 8 - 4;
    call status_2 := DeviceQueryACPI_AsyncExecMethod(DeviceObject_4, ControlMethodName_2, ArgumentCount_2, ArgumentTypeArray_2, ArgumentSizeArray_2, ArgumentArray_2, Tmp_39, li2bplFunctionConstant247, context_4);
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} status_2 == 259;
    call vslice_dummy_var_7 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} yogi_error != 1;
    goto L37;

  L37:
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    status_2 := Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT[IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)];
    call sdv_17 := sdv_NT_ERROR(status_2);
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} sdv_17 != 0;
    goto L43;

  L43:
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} status_2 >= 0;
    assume {:nonnull} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] != 0;
    assume Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] > 0;
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} Mem_T.Count__ACPI_EVAL_OUTPUT_BUFFER[Count__ACPI_EVAL_OUTPUT_BUFFER(Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)])] != 1;
    status_2 := -1073741823;
    goto L44;

  L44:
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] != 0;
    call sdv_ExFreePool(0);
    goto L70;

  L70:
    Tmp_34 := status_2;
    goto LM2;

  LM2:
    return;

  anon46_Then:
    assume {:partition} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] == 0;
    goto L70;

  anon47_Then:
    assume {:partition} Mem_T.Count__ACPI_EVAL_OUTPUT_BUFFER[Count__ACPI_EVAL_OUTPUT_BUFFER(Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)])] == 1;
    assume {:nonnull} argument_2 != 0;
    assume argument_2 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} ExpectedReturnType != Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_2)];
    status_2 := -1073741823;
    goto L44;

  anon48_Then:
    assume {:partition} ExpectedReturnType == Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_2)];
    assume {:nonnull} argument_2 != 0;
    assume argument_2 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_2)] != 0;
    assume {:nonnull} argument_2 != 0;
    assume argument_2 > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_2)] != 1;
    assume {:nonnull} argument_2 != 0;
    assume argument_2 > 0;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_2)] == 2;
    goto L52;

  L52:
    assume {:nonnull} argument_2 != 0;
    assume argument_2 > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(argument_2)] != 0;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} ReturnBuffer_1 != 0;
    assume {:nonnull} argument_2 != 0;
    assume argument_2 > 0;
    Tmp_35 := Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(argument_2)];
    assume {:nonnull} ReturnBuffer_1 != 0;
    assume ReturnBuffer_1 > 0;
    call boogieTmp := ExAllocatePool(5, Tmp_35);
    Mem_T.PVOID[ReturnBuffer_1] := boogieTmp;
    assume {:nonnull} ReturnBuffer_1 != 0;
    assume ReturnBuffer_1 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} Mem_T.PVOID[ReturnBuffer_1] != 0;
    assume {:nonnull} argument_2 != 0;
    assume argument_2 > 0;
    Tmp_36 := Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(argument_2)];
    call sdv_RtlCopyMemory(0, 0, Tmp_36);
    goto L44;

  anon53_Then:
    assume {:partition} Mem_T.PVOID[ReturnBuffer_1] == 0;
    status_2 := -1073741801;
    goto L44;

  anon52_Then:
    assume {:partition} ReturnBuffer_1 == 0;
    goto L44;

  anon51_Then:
    assume {:partition} Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(argument_2)] == 0;
    goto L44;

  anon54_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_2)] != 2;
    status_2 := -1073741823;
    goto L44;

  anon55_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_2)] == 1;
    goto L52;

  anon49_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(argument_2)] == 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} IntegerReturn != 0;
    assume {:nonnull} argument_2 != 0;
    assume argument_2 > 0;
    Tmp_37 := Mem_T.Data__ACPI_METHOD_ARGUMENT[Data__ACPI_METHOD_ARGUMENT(argument_2)];
    assume {:nonnull} IntegerReturn != 0;
    assume IntegerReturn > 0;
    assume {:nonnull} Tmp_37 != 0;
    assume Tmp_37 > 0;
    Mem_T.INT4[IntegerReturn] := Mem_T.INT4[Tmp_37];
    goto L44;

  anon50_Then:
    assume {:partition} IntegerReturn == 0;
    goto L44;

  anon45_Then:
    assume {:partition} 0 > status_2;
    goto L44;

  anon44_Then:
    assume {:partition} sdv_17 == 0;
    assume {:nonnull} Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] != 0;
    assume Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] > 0;
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    argument_2 := Mem_T.Argument__ACPI_EVAL_OUTPUT_BUFFER[Argument__ACPI_EVAL_OUTPUT_BUFFER(Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT[cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)])];
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} ReturnBuffer_1 != 0;
    assume {:nonnull} ReturnBufferFinalSize != 0;
    assume ReturnBufferFinalSize > 0;
    assume {:nonnull} argument_2 != 0;
    assume argument_2 > 0;
    Mem_T.INT4[ReturnBufferFinalSize] := Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(argument_2)];
    goto L43;

  anon57_Then:
    assume {:partition} ReturnBuffer_1 == 0;
    goto L43;

  anon56_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon43_Then:
    assume {:partition} status_2 != 259;
    assume {:nonnull} context_4 != 0;
    assume context_4 > 0;
    Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT[IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT(context_4)] := status_2;
    goto L37;

  anon42_Then:
    assume {:partition} ExpectedReturnType == 0;
    ReturnBufferMaxSize_1 := 4;
    goto L23;

  anon41_Then:
    assume {:partition} ReturnBuffer_1 == 0;
    goto L20;

  anon40_Then:
    assume {:partition} ReturnBufferFinalSize == 0;
    goto L18;

  anon39_Then:
    assume {:partition} IntegerReturn == 0;
    goto L16;
}



procedure {:origName "sdv_IoFlushAdapterBuffers"} {:osmodel} sdv_IoFlushAdapterBuffers(actual_AdapterObject: int, actual_Mdl: int, actual_MapRegisterBase: int, actual_CurrentVa: int, actual_Length: int, actual_WriteToDevice: int) returns (Tmp_40: int);



implementation {:origName "sdv_IoFlushAdapterBuffers"} {:osmodel} sdv_IoFlushAdapterBuffers(actual_AdapterObject: int, actual_Mdl: int, actual_MapRegisterBase: int, actual_CurrentVa: int, actual_Length: int, actual_WriteToDevice: int) returns (Tmp_40: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_40 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_40 := 1;
    goto L1;
}



procedure {:origName "sdv_IoCopyCurrentIrpStackLocationToNext"} {:osmodel} sdv_IoCopyCurrentIrpStackLocationToNext(actual_pirp: int);
  modifies alloc, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION;



implementation {:origName "sdv_IoCopyCurrentIrpStackLocationToNext"} {:osmodel} sdv_IoCopyCurrentIrpStackLocationToNext(actual_pirp: int)
{
  var {:pointer} pirp: int;
  var vslice_dummy_var_8: int;

  anon0:
    call vslice_dummy_var_8 := __HAVOC_malloc(4);
    pirp := actual_pirp;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} pirp == sdv_harnessIrp;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];
    goto L4;

  L4:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} pirp == sdv_other_harnessIrp;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];
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



procedure {:origName "sdv_containing_record"} {:osmodel} sdv_containing_record(actual_Address: int, actual_FieldOffset: int) returns (Tmp_44: int);



implementation {:origName "sdv_containing_record"} {:osmodel} sdv_containing_record(actual_Address: int, actual_FieldOffset: int) returns (Tmp_44: int)
{
  var {:pointer} record: int;
  var {:pointer} Address: int;

  anon0:
    Address := actual_Address;
    record := Address;
    Tmp_44 := record;
    return;
}



procedure {:origName "IoStartNextPacket"} {:osmodel} IoStartNextPacket(actual_DeviceObject_5: int, actual_Cancelable: int);
  modifies alloc;



implementation {:origName "IoStartNextPacket"} {:osmodel} IoStartNextPacket(actual_DeviceObject_5: int, actual_Cancelable: int)
{
  var vslice_dummy_var_9: int;

  anon0:
    call vslice_dummy_var_9 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_KeAcquireSpinLock"} {:osmodel} sdv_KeAcquireSpinLock(actual_SpinLock: int, actual_p: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4;



implementation {:origName "sdv_KeAcquireSpinLock"} {:osmodel} sdv_KeAcquireSpinLock(actual_SpinLock: int, actual_p: int)
{
  var {:pointer} p: int;
  var vslice_dummy_var_10: int;

  anon0:
    call vslice_dummy_var_10 := __HAVOC_malloc(4);
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



procedure {:origName "sdv_CheckDispatchRoutines"} {:osmodel} sdv_CheckDispatchRoutines() returns (Tmp_50: int);



implementation {:origName "sdv_CheckDispatchRoutines"} {:osmodel} sdv_CheckDispatchRoutines() returns (Tmp_50: int)
{

  anon0:
    Tmp_50 := 1;
    return;
}



procedure {:origName "sdv_stub_startio_end"} {:osmodel} sdv_stub_startio_end();
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4;



implementation {:origName "sdv_stub_startio_end"} {:osmodel} sdv_stub_startio_end()
{
  var vslice_dummy_var_11: int;

  anon0:
    call vslice_dummy_var_11 := __HAVOC_malloc(4);
    sdv_irql_current := 0;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    return;
}



procedure {:origName "KeSetTimer"} {:osmodel} KeSetTimer(actual_Timer: int, actual_structPtr888DueTime: int, actual_Dpc: int) returns (Tmp_54: int);
  modifies alloc, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER;



implementation {:origName "KeSetTimer"} {:osmodel} KeSetTimer(actual_Timer: int, actual_structPtr888DueTime: int, actual_Dpc: int) returns (Tmp_54: int)
{
  var {:scalar} DueTime: int;
  var {:pointer} structPtr888DueTime: int;

  anon0:
    call DueTime := __HAVOC_malloc(20);
    structPtr888DueTime := actual_structPtr888DueTime;
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(DueTime)] := Mem_T.LowPart__LUID[LowPart__LUID(structPtr888DueTime)];
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(DueTime)] := Mem_T.HighPart__LUID[HighPart__LUID(structPtr888DueTime)];
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(DueTime))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(structPtr888DueTime))];
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(DueTime))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(structPtr888DueTime))];
    assume {:nonnull} DueTime != 0;
    assume DueTime > 0;
    assume {:nonnull} structPtr888DueTime != 0;
    assume structPtr888DueTime > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(DueTime)] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(structPtr888DueTime)];
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_54 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_54 := 0;
    goto L1;
}



procedure {:origName "sdv_IoGetNextIrpStackLocation"} {:osmodel} sdv_IoGetNextIrpStackLocation(actual_pirp_1: int) returns (Tmp_56: int);



implementation {:origName "sdv_IoGetNextIrpStackLocation"} {:osmodel} sdv_IoGetNextIrpStackLocation(actual_pirp_1: int) returns (Tmp_56: int)
{
  var {:pointer} pirp_1: int;

  anon0:
    pirp_1 := actual_pirp_1;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} pirp_1 == sdv_harnessIrp;
    Tmp_56 := sdv_harnessStackLocation_next;
    goto L1;

  L1:
    return;

  anon5_Then:
    assume {:partition} pirp_1 != sdv_harnessIrp;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} pirp_1 == sdv_other_harnessIrp;
    Tmp_56 := sdv_other_harnessStackLocation_next;
    goto L1;

  anon6_Then:
    assume {:partition} pirp_1 != sdv_other_harnessIrp;
    Tmp_56 := sdv_harnessStackLocation;
    goto L1;
}



procedure {:origName "KeInitializeDpc"} {:osmodel} KeInitializeDpc(actual_Dpc_1: int, actual_DeferredRoutine: int, actual_DeferredContext: int);
  modifies alloc, Mem_T.DeferredRoutine__KDPC;



implementation {:origName "KeInitializeDpc"} {:osmodel} KeInitializeDpc(actual_Dpc_1: int, actual_DeferredRoutine: int, actual_DeferredContext: int)
{
  var {:pointer} Dpc_1: int;
  var {:scalar} DeferredRoutine: int;
  var vslice_dummy_var_12: int;

  anon0:
    call vslice_dummy_var_12 := __HAVOC_malloc(4);
    Dpc_1 := actual_Dpc_1;
    DeferredRoutine := actual_DeferredRoutine;
    assume {:nonnull} Dpc_1 != 0;
    assume Dpc_1 > 0;
    Mem_T.DeferredRoutine__KDPC[DeferredRoutine__KDPC(Dpc_1)] := DeferredRoutine;
    return;
}



procedure {:origName "IoGetDmaAdapter"} {:osmodel} IoGetDmaAdapter(actual_PhysicalDeviceObject: int, actual_DeviceDescription: int, actual_NumberOfMapRegisters: int) returns (Tmp_60: int);



implementation {:origName "IoGetDmaAdapter"} {:osmodel} IoGetDmaAdapter(actual_PhysicalDeviceObject: int, actual_DeviceDescription: int, actual_NumberOfMapRegisters: int) returns (Tmp_60: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_60 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_60 := sdv_IoGetDmaAdapter_DMA_ADAPTER;
    goto L1;
}



procedure {:origName "IoCreateDevice"} {:osmodel} IoCreateDevice(actual_DriverObject: int, actual_DeviceExtensionSize: int, actual_DeviceName: int, actual_DeviceType: int, actual_DeviceCharacteristics: int, actual_Exclusive: int, actual_DeviceObject_6: int) returns (Tmp_62: int);
  modifies sdv_io_create_device_called, Mem_T.P_DEVICE_OBJECT, Mem_T.Flags__DEVICE_OBJECT;



implementation {:origName "IoCreateDevice"} {:osmodel} IoCreateDevice(actual_DriverObject: int, actual_DeviceExtensionSize: int, actual_DeviceName: int, actual_DeviceType: int, actual_DeviceCharacteristics: int, actual_Exclusive: int, actual_DeviceObject_6: int) returns (Tmp_62: int)
{
  var {:pointer} DeviceObject_6: int;

  anon0:
    DeviceObject_6 := actual_DeviceObject_6;
    sdv_io_create_device_called := sdv_io_create_device_called + 1;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    goto anon14_Then, anon14_Else;

  anon14_Else:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:nonnull} DeviceObject_6 != 0;
    assume DeviceObject_6 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_6] := 0;
    Tmp_62 := -1073741824;
    goto L1;

  L1:
    return;

  anon12_Then:
    assume {:nonnull} DeviceObject_6 != 0;
    assume DeviceObject_6 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_6] := 0;
    Tmp_62 := -1073741771;
    goto L1;

  anon13_Then:
    assume {:nonnull} DeviceObject_6 != 0;
    assume DeviceObject_6 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_6] := 0;
    Tmp_62 := -1073741670;
    goto L1;

  anon14_Then:
    assume {:nonnull} DeviceObject_6 != 0;
    assume DeviceObject_6 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_6] := 0;
    Tmp_62 := -1073741823;
    goto L1;

  anon15_Then:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} sdv_inside_init_entrypoint != 0;
    assume {:nonnull} sdv_p_devobj_fdo != 0;
    assume sdv_p_devobj_fdo > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(sdv_p_devobj_fdo)] := 128;
    assume {:nonnull} DeviceObject_6 != 0;
    assume DeviceObject_6 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_6] := sdv_p_devobj_fdo;
    goto L21;

  L21:
    Tmp_62 := 0;
    goto L1;

  anon11_Then:
    assume {:partition} sdv_inside_init_entrypoint == 0;
    assume {:nonnull} sdv_p_devobj_child_pdo != 0;
    assume sdv_p_devobj_child_pdo > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(sdv_p_devobj_child_pdo)] := 128;
    assume {:nonnull} DeviceObject_6 != 0;
    assume DeviceObject_6 > 0;
    Mem_T.P_DEVICE_OBJECT[DeviceObject_6] := sdv_p_devobj_child_pdo;
    goto L21;
}



procedure {:origName "IoDetachDevice"} {:osmodel} IoDetachDevice(actual_TargetDevice: int);
  modifies alloc;



implementation {:origName "IoDetachDevice"} {:osmodel} IoDetachDevice(actual_TargetDevice: int)
{
  var vslice_dummy_var_13: int;

  anon0:
    call vslice_dummy_var_13 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_CheckIrpMjPower"} {:osmodel} sdv_CheckIrpMjPower() returns (Tmp_66: int);



implementation {:origName "sdv_CheckIrpMjPower"} {:osmodel} sdv_CheckIrpMjPower() returns (Tmp_66: int)
{

  anon0:
    Tmp_66 := 1;
    return;
}



procedure {:origName "sdv_SetPowerIrpMinorFunction"} {:osmodel} sdv_SetPowerIrpMinorFunction(actual_pirp_2: int);
  modifies alloc, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.Type_unnamed_tag_39;



implementation {:origName "sdv_SetPowerIrpMinorFunction"} {:osmodel} sdv_SetPowerIrpMinorFunction(actual_pirp_2: int)
{
  var {:pointer} r: int;
  var {:pointer} pirp_2: int;
  var vslice_dummy_var_14: int;

  anon0:
    call vslice_dummy_var_14 := __HAVOC_malloc(4);
    pirp_2 := actual_pirp_2;
    assume {:nonnull} pirp_2 != 0;
    assume pirp_2 > 0;
    r := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(pirp_2)))];
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
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 1;
    goto L1;

  anon15_Then:
    assume {:nonnull} r != 0;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 0;
    goto L1;

  anon11_Then:
    assume {:nonnull} r != 0;
    assume r > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(r)] := 2;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:nonnull} r != 0;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 1;
    goto L1;

  anon14_Then:
    assume {:nonnull} r != 0;
    assume r > 0;
    Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(r)))] := 0;
    goto L1;
}



procedure {:origName "sdv_stub_dispatch_end"} {:osmodel} sdv_stub_dispatch_end(actual_s: int, actual_pirp_3: int);
  modifies alloc;



implementation {:origName "sdv_stub_dispatch_end"} {:osmodel} sdv_stub_dispatch_end(actual_s: int, actual_pirp_3: int)
{
  var vslice_dummy_var_15: int;

  anon0:
    call vslice_dummy_var_15 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_CheckCancelRoutines"} {:osmodel} sdv_CheckCancelRoutines() returns (Tmp_72: int);



implementation {:origName "sdv_CheckCancelRoutines"} {:osmodel} sdv_CheckCancelRoutines() returns (Tmp_72: int)
{

  anon0:
    Tmp_72 := 0;
    return;
}



procedure {:origName "sdv_RunISRRoutines"} {:osmodel} sdv_RunISRRoutines(actual_ki: int, actual_pv1: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.INT4, Mem_T.IsrReentered__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, sdv_kdpc3, sdv_dpc_ke_registered, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, sdv_dpc_io_registered;



implementation {:origName "sdv_RunISRRoutines"} {:osmodel} sdv_RunISRRoutines(actual_ki: int, actual_pv1: int)
{
  var {:pointer} ki: int;
  var {:pointer} pv1: int;
  var vslice_dummy_var_16: int;
  var vslice_dummy_var_17: int;

  anon0:
    call vslice_dummy_var_16 := __HAVOC_malloc(4);
    ki := actual_ki;
    pv1 := actual_pv1;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} sdv_isr_routine == li2bplFunctionConstant207;
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 4;
    call vslice_dummy_var_17 := FdcInterruptService(ki, pv1);
    sdv_irql_current := 0;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} sdv_isr_routine != li2bplFunctionConstant207;
    goto L1;
}



procedure {:origName "RtlInitAnsiString"} {:osmodel} RtlInitAnsiString(actual_DestinationString: int, actual_SourceString: int);
  modifies alloc;



implementation {:origName "RtlInitAnsiString"} {:osmodel} RtlInitAnsiString(actual_DestinationString: int, actual_SourceString: int)
{
  var vslice_dummy_var_18: int;

  anon0:
    call vslice_dummy_var_18 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_SetStatus"} {:osmodel} sdv_SetStatus(actual_pirp_4: int);
  modifies alloc, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_SetStatus"} {:osmodel} sdv_SetStatus(actual_pirp_4: int)
{
  var {:pointer} pirp_4: int;
  var vslice_dummy_var_19: int;

  anon0:
    call vslice_dummy_var_19 := __HAVOC_malloc(4);
    pirp_4 := actual_pirp_4;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} pirp_4 != 0;
    assume pirp_4 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_4))] := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:nonnull} pirp_4 != 0;
    assume pirp_4 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(pirp_4))] := -1073741637;
    goto L1;
}



procedure {:origName "KeDelayExecutionThread"} {:osmodel} KeDelayExecutionThread(actual_WaitMode: int, actual_Alertable: int, actual_Interval: int) returns (Tmp_80: int);



implementation {:origName "KeDelayExecutionThread"} {:osmodel} KeDelayExecutionThread(actual_WaitMode: int, actual_Alertable: int, actual_Interval: int) returns (Tmp_80: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_80 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_80 := -1073741823;
    goto L1;
}



procedure {:origName "ExAllocatePool"} {:osmodel} ExAllocatePool(actual_PoolType: int, actual_NumberOfBytes: int) returns (Tmp_82: int);
  modifies alloc;



implementation {:origName "ExAllocatePool"} {:osmodel} ExAllocatePool(actual_PoolType: int, actual_NumberOfBytes: int) returns (Tmp_82: int)
{
  var {:pointer} sdv_29: int;
  var {:scalar} NumberOfBytes: int;

  anon0:
    NumberOfBytes := actual_NumberOfBytes;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call sdv_29 := __HAVOC_malloc(NumberOfBytes);
    Tmp_82 := sdv_29;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_82 := 0;
    goto L1;
}



procedure {:nohoudini} {:origName "sdv_main"} {:osmodel} sdv_main();
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.INT4, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.IsrReentered__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, sdv_kdpc3, sdv_dpc_ke_registered, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, sdv_dpc_io_registered, Mem_T.CancelRoutine__IRP, sdv_start_info, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.CompletionRoutine__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, sdv_remove_irp_already_issued, Mem_T.Type_unnamed_tag_39, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, PagingReferenceCount, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.DeviceState__POWER_STATE, Mem_T.CurrentPowerState__FDC_FDO_EXTENSION, Mem_T.Type_unnamed_tag_28, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.SystemState__POWER_STATE, Mem_T.Map__IO_PORT_INFO, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.Version__IO_RESOURCE_LIST, Mem_T.Revision__IO_RESOURCE_LIST, Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR, Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR, Mem_T.MinimumVector_unnamed_tag_59, Mem_T.MaximumVector_unnamed_tag_59, Mem_T.AffinityPolicy_unnamed_tag_59, Mem_T.PriorityPolicy_unnamed_tag_59, Mem_T.TargetedProcessors_unnamed_tag_59, Mem_T.MinimumChannel_unnamed_tag_60, Mem_T.MaximumChannel_unnamed_tag_60, Mem_T.RequestLine_unnamed_tag_61, Mem_T.Reserved_unnamed_tag_61, Mem_T.Channel_unnamed_tag_61, Mem_T.TransferWidth_unnamed_tag_61, Mem_T.Data_unnamed_tag_50, Mem_T.MinBusNumber_unnamed_tag_62, Mem_T.MaxBusNumber_unnamed_tag_62, Mem_T.Reserved_unnamed_tag_62, Mem_T.Priority_unnamed_tag_63, Mem_T.Reserved1_unnamed_tag_63, Mem_T.Reserved2_unnamed_tag_63, Mem_T.Length40_unnamed_tag_64, Mem_T.Alignment40_unnamed_tag_64, Mem_T.Length48_unnamed_tag_65, Mem_T.Alignment48_unnamed_tag_65, Mem_T.Length64_unnamed_tag_66, Mem_T.Alignment64_unnamed_tag_66, Mem_T.Class_unnamed_tag_56, Mem_T.Type_unnamed_tag_56, Mem_T.Reserved1_unnamed_tag_56, Mem_T.Reserved2_unnamed_tag_56, Mem_T.IdLowPart_unnamed_tag_56, Mem_T.IdHighPart_unnamed_tag_56, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION, Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION, Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION, Mem_T.Count__DEVICE_RELATIONS, Mem_T.P_DEVICE_OBJECT, Mem_T.Paused__FDC_FDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, FdcDefaultControllerNumber, Mem_T.Removed__FDC_FDO_EXTENSION, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_isr_routine, sdv_pDpcContext, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.SpeedsAvailable__FDC_INFORMATION, Mem_T.ClockRatesSupported__FDC_INFORMATION, Mem_T.FloppyControllerType__FDC_INFORMATION, Mem_T.FdcType__FDC_FDO_EXTENSION, Mem_T.Clock48MHz__FDC_FDO_EXTENSION, Mem_T.FdcSpeeds__FDC_FDO_EXTENSION, Mem_T.MaximumLength__DEVICE_DESCRIPTION, Mem_T.AdapterObject__FDC_FDO_EXTENSION, Mem_T.PINT4, Mem_T.InterruptMode__FDC_FDO_EXTENSION, Mem_T.ControllerVector__FDC_FDO_EXTENSION, Mem_T.ProcessorMask__FDC_FDO_EXTENSION, Mem_T.ControllerIrql__FDC_FDO_EXTENSION, Mem_T.SharableVector__FDC_FDO_EXTENSION, Mem_T.SaveFloatState__FDC_FDO_EXTENSION, Mem_T.BusType__FDC_FDO_EXTENSION, Mem_T.BusNumber__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.NumPDOs__FDC_FDO_EXTENSION, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.BufferSize__FDC_INFO, Mem_T.BufferCount__FDC_INFO, Mem_T.BuffersRequested__FDC_FDO_EXTENSION, Mem_T.Virtual__TRANSFER_BUFFER, Mem_T.AcpiBios__FDC_INFO, Mem_T.DriveNumber__ACPI_FDI_DATA, Mem_T.DeviceType__ACPI_FDI_DATA, Mem_T.MaxCylinderNumber__ACPI_FDI_DATA, Mem_T.MaxSectorNumber__ACPI_FDI_DATA, Mem_T.MaxHeadNumber__ACPI_FDI_DATA, Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA, Mem_T.HeadLoadTime__ACPI_FDI_DATA, Mem_T.MotorOffTime__ACPI_FDI_DATA, Mem_T.SectorLengthCode__ACPI_FDI_DATA, Mem_T.SectorPerTrack__ACPI_FDI_DATA, Mem_T.ReadWriteGapLength__ACPI_FDI_DATA, Mem_T.DataTransferLength__ACPI_FDI_DATA, Mem_T.FormatGapLength__ACPI_FDI_DATA, Mem_T.FormatFillCharacter__ACPI_FDI_DATA, Mem_T.HeadSettleTime__ACPI_FDI_DATA, Mem_T.MotorSettleTime__ACPI_FDI_DATA, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION, Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION, sdv_io_dpc, Mem_T.DeferredRoutine__KDPC, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, yogi_error, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT, sdv_io_create_device_called;



implementation {:origName "sdv_main"} {:osmodel} sdv_main()
{
  var {:scalar} sdv_31: int;
  var {:scalar} sdv_46: int;
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

  anon0:
    call vslice_dummy_var_20 := __HAVOC_malloc(4);
    call sdv_46 := sdv_CheckDispatchRoutines();
    call sdv_31 := sdv_CheckStartIoRoutines();
    call vslice_dummy_var_21 := sdv_CheckDpcRoutines();
    call vslice_dummy_var_22 := sdv_CheckIsrRoutines();
    call vslice_dummy_var_23 := sdv_CheckCancelRoutines();
    call vslice_dummy_var_24 := sdv_CheckIoDpcRoutines();
    call vslice_dummy_var_25 := sdv_IoCompletionRoutines();
    call vslice_dummy_var_26 := sdv_CheckWorkerRoutines();
    call vslice_dummy_var_27 := sdv_CheckAddDevice();
    call vslice_dummy_var_28 := sdv_CheckIrpMjPnp();
    call vslice_dummy_var_29 := sdv_CheckIrpMjPower();
    call vslice_dummy_var_30 := sdv_CheckDriverUnload();
    goto anon173_Then, anon173_Else;

  anon173_Else:
    goto anon257_Then, anon257_Else;

  anon257_Else:
    goto anon256_Then, anon256_Else;

  anon256_Else:
    goto anon255_Then, anon255_Else;

  anon255_Else:
    goto anon254_Then, anon254_Else;

  anon254_Else:
    goto anon253_Then, anon253_Else;

  anon253_Else:
    goto anon252_Then, anon252_Else;

  anon252_Else:
    goto anon251_Then, anon251_Else;

  anon251_Else:
    goto anon250_Then, anon250_Else;

  anon250_Else:
    goto anon249_Then, anon249_Else;

  anon249_Else:
    goto anon248_Then, anon248_Else;

  anon248_Else:
    goto anon247_Then, anon247_Else;

  anon247_Else:
    goto anon246_Then, anon246_Else;

  anon246_Else:
    goto anon245_Then, anon245_Else;

  anon245_Else:
    goto anon244_Then, anon244_Else;

  anon244_Else:
    goto anon243_Then, anon243_Else;

  anon243_Else:
    goto anon242_Then, anon242_Else;

  anon242_Else:
    goto anon241_Then, anon241_Else;

  anon241_Else:
    goto anon240_Then, anon240_Else;

  anon240_Else:
    goto anon239_Then, anon239_Else;

  anon239_Else:
    goto anon238_Then, anon238_Else;

  anon238_Else:
    goto anon237_Then, anon237_Else;

  anon237_Else:
    goto anon236_Then, anon236_Else;

  anon236_Else:
    goto anon235_Then, anon235_Else;

  anon235_Else:
    goto anon234_Then, anon234_Else;

  anon234_Else:
    goto anon233_Then, anon233_Else;

  anon233_Else:
    goto anon232_Then, anon232_Else;

  anon232_Else:
    goto anon231_Then, anon231_Else;

  anon231_Else:
    goto anon230_Then, anon230_Else;

  anon230_Else:
    goto anon229_Then, anon229_Else;

  anon229_Else:
    goto anon228_Then, anon228_Else;

  anon228_Else:
    goto anon227_Then, anon227_Else;

  anon227_Else:
    goto anon226_Then, anon226_Else;

  anon226_Else:
    goto anon225_Then, anon225_Else;

  anon225_Else:
    goto anon224_Then, anon224_Else;

  anon224_Else:
    goto anon223_Then, anon223_Else;

  anon223_Else:
    goto anon222_Then, anon222_Else;

  anon222_Else:
    goto anon221_Then, anon221_Else;

  anon221_Else:
    goto anon220_Then, anon220_Else;

  anon220_Else:
    goto anon219_Then, anon219_Else;

  anon219_Else:
    goto anon218_Then, anon218_Else;

  anon218_Else:
    goto anon217_Then, anon217_Else;

  anon217_Else:
    goto anon216_Then, anon216_Else;

  anon216_Else:
    goto anon215_Then, anon215_Else;

  anon215_Else:
    goto anon214_Then, anon214_Else;

  anon214_Else:
    goto anon213_Then, anon213_Else;

  anon213_Else:
    goto anon212_Then, anon212_Else;

  anon212_Else:
    goto anon211_Then, anon211_Else;

  anon211_Else:
    goto anon210_Then, anon210_Else;

  anon210_Else:
    goto anon209_Then, anon209_Else;

  anon209_Else:
    goto anon208_Then, anon208_Else;

  anon208_Else:
    goto anon207_Then, anon207_Else;

  anon207_Else:
    goto anon206_Then, anon206_Else;

  anon206_Else:
    goto anon205_Then, anon205_Else;

  anon205_Else:
    goto anon204_Then, anon204_Else;

  anon204_Else:
    goto anon203_Then, anon203_Else;

  anon203_Else:
    goto anon202_Then, anon202_Else;

  anon202_Else:
    goto anon201_Then, anon201_Else;

  anon201_Else:
    goto anon200_Then, anon200_Else;

  anon200_Else:
    goto anon199_Then, anon199_Else;

  anon199_Else:
    goto anon198_Then, anon198_Else;

  anon198_Else:
    goto anon197_Then, anon197_Else;

  anon197_Else:
    goto anon196_Then, anon196_Else;

  anon196_Else:
    goto anon195_Then, anon195_Else;

  anon195_Else:
    goto anon194_Then, anon194_Else;

  anon194_Else:
    goto anon193_Then, anon193_Else;

  anon193_Else:
    goto anon192_Then, anon192_Else;

  anon192_Else:
    goto anon191_Then, anon191_Else;

  anon191_Else:
    goto anon190_Then, anon190_Else;

  anon190_Else:
    goto anon189_Then, anon189_Else;

  anon189_Else:
    goto anon188_Then, anon188_Else;

  anon188_Else:
    goto anon187_Then, anon187_Else;

  anon187_Else:
    goto anon186_Then, anon186_Else;

  anon186_Else:
    goto anon185_Then, anon185_Else;

  anon185_Else:
    goto anon184_Then, anon184_Else;

  anon184_Else:
    goto anon183_Then, anon183_Else;

  anon183_Else:
    goto anon182_Then, anon182_Else;

  anon182_Else:
    goto anon181_Then, anon181_Else;

  anon181_Else:
    goto anon180_Then, anon180_Else;

  anon180_Else:
    goto anon179_Then, anon179_Else;

  anon179_Else:
    goto anon178_Then, anon178_Else;

  anon178_Else:
    goto anon177_Then, anon177_Else;

  anon177_Else:
    goto anon176_Then, anon176_Else;

  anon176_Else:
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon176_Then:
    goto L1;

  anon177_Then:
    goto L1;

  anon178_Then:
    goto L1;

  anon179_Then:
    goto L1;

  anon180_Then:
    goto L1;

  anon181_Then:
    goto L1;

  anon182_Then:
    goto L1;

  anon183_Then:
    goto L1;

  anon184_Then:
    goto L1;

  anon185_Then:
    goto L1;

  anon186_Then:
    goto L1;

  anon187_Then:
    goto L1;

  anon188_Then:
    goto L1;

  anon189_Then:
    goto L1;

  anon190_Then:
    goto L1;

  anon191_Then:
    goto L1;

  anon192_Then:
    goto L1;

  anon193_Then:
    goto L1;

  anon194_Then:
    goto L1;

  anon195_Then:
    goto L1;

  anon196_Then:
    goto L1;

  anon197_Then:
    goto L1;

  anon198_Then:
    goto L1;

  anon199_Then:
    goto L1;

  anon200_Then:
    goto L1;

  anon201_Then:
    goto L1;

  anon202_Then:
    goto L1;

  anon203_Then:
    goto L1;

  anon204_Then:
    goto L1;

  anon205_Then:
    goto L1;

  anon206_Then:
    goto L1;

  anon207_Then:
    goto L1;

  anon208_Then:
    goto L1;

  anon209_Then:
    goto L1;

  anon210_Then:
    goto L1;

  anon211_Then:
    goto L1;

  anon212_Then:
    goto L1;

  anon213_Then:
    goto L1;

  anon214_Then:
    goto L1;

  anon215_Then:
    goto L1;

  anon216_Then:
    goto L1;

  anon217_Then:
    goto L1;

  anon218_Then:
    goto L1;

  anon219_Then:
    goto L1;

  anon220_Then:
    goto L1;

  anon221_Then:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call vslice_dummy_var_34 := FdcPnpComplete(sdv_p_devobj_fdo, sdv_irp, sdv_pv2);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    goto L1;

  anon222_Then:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call vslice_dummy_var_33 := DeviceQueryACPI_AsyncExecMethod_CompletionRoutine(sdv_p_devobj_fdo, sdv_irp, sdv_pv2);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    goto L1;

  anon223_Then:
    goto L1;

  anon224_Then:
    goto L1;

  anon225_Then:
    goto L1;

  anon226_Then:
    goto L1;

  anon227_Then:
    goto L1;

  anon228_Then:
    goto L1;

  anon229_Then:
    goto L1;

  anon230_Then:
    goto L1;

  anon231_Then:
    goto L1;

  anon232_Then:
    goto L1;

  anon233_Then:
    goto L1;

  anon234_Then:
    goto L1;

  anon235_Then:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call FdcDeferredProcedure(sdv_kdpc, sdv_pDpcContext, sdv_pv2, sdv_pv3);
    sdv_irql_current := 0;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    goto L1;

  anon236_Then:
    goto L1;

  anon237_Then:
    goto L1;

  anon238_Then:
    goto L1;

  anon239_Then:
    goto L1;

  anon240_Then:
    goto L1;

  anon241_Then:
    goto L1;

  anon242_Then:
    goto L1;

  anon243_Then:
    goto L1;

  anon244_Then:
    goto L1;

  anon245_Then:
    goto L1;

  anon246_Then:
    goto L1;

  anon247_Then:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 4;
    call vslice_dummy_var_32 := FdcInterruptService(sdv_kinterrupt, sdv_pv1);
    sdv_irql_current := 0;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    goto L1;

  anon248_Then:
    goto L1;

  anon249_Then:
    goto L1;

  anon250_Then:
    goto L1;

  anon251_Then:
    goto L1;

  anon252_Then:
    goto L1;

  anon253_Then:
    goto L1;

  anon254_Then:
    goto L1;

  anon255_Then:
    goto L1;

  anon256_Then:
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call FcLogErrorDpc(sdv_kdpc, sdv_pDpcContext, sdv_pv2, sdv_pv3);
    sdv_irql_current := 0;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    goto L1;

  anon257_Then:
    goto anon175_Then, anon175_Else;

  anon175_Else:
    assume {:partition} sdv_31 != 0;
    call sdv_stub_driver_init();
    call sdv_RunStartIo(sdv_p_devobj_fdo, sdv_irp);
    goto L1;

  anon175_Then:
    assume {:partition} sdv_31 == 0;
    goto L1;

  anon173_Then:
    goto anon174_Then, anon174_Else;

  anon174_Else:
    assume {:partition} sdv_46 != 0;
    call sdv_stub_driver_init();
    call vslice_dummy_var_31 := sdv_RunDispatchFunction(sdv_p_devobj_fdo, sdv_irp);
    goto anon258_Then, anon258_Else;

  anon258_Else:
    assume {:partition} yogi_error != 1;
    goto L1;

  anon258_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon174_Then:
    assume {:partition} sdv_46 == 0;
    goto L1;
}



procedure {:origName "sdv_CheckDriverUnload"} {:osmodel} sdv_CheckDriverUnload() returns (Tmp_86: int);



implementation {:origName "sdv_CheckDriverUnload"} {:osmodel} sdv_CheckDriverUnload() returns (Tmp_86: int)
{

  anon0:
    Tmp_86 := 1;
    return;
}



procedure {:origName "IoAllocateErrorLogEntry"} {:osmodel} IoAllocateErrorLogEntry(actual_IoObject: int, actual_EntrySize: int) returns (Tmp_88: int);
  modifies alloc;



implementation {:origName "IoAllocateErrorLogEntry"} {:osmodel} IoAllocateErrorLogEntry(actual_IoObject: int, actual_EntrySize: int) returns (Tmp_88: int)
{
  var {:pointer} sdv_60: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call sdv_60 := __HAVOC_malloc(1);
    Tmp_88 := sdv_60;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_88 := 0;
    goto L1;
}



procedure {:origName "sdv_MmGetMdlVirtualAddress"} {:osmodel} sdv_MmGetMdlVirtualAddress(actual_Mdl_1: int) returns (Tmp_90: int);
  modifies alloc;



implementation {:origName "sdv_MmGetMdlVirtualAddress"} {:osmodel} sdv_MmGetMdlVirtualAddress(actual_Mdl_1: int) returns (Tmp_90: int)
{
  var {:pointer} x_3: int;
  var {:pointer} sdv_61: int;

  anon0:
    call sdv_61 := __HAVOC_malloc(1);
    x_3 := sdv_61;
    Tmp_90 := x_3;
    return;
}



procedure {:origName "sdv_CheckIoDpcRoutines"} {:osmodel} sdv_CheckIoDpcRoutines() returns (Tmp_92: int);



implementation {:origName "sdv_CheckIoDpcRoutines"} {:osmodel} sdv_CheckIoDpcRoutines() returns (Tmp_92: int)
{

  anon0:
    Tmp_92 := 1;
    return;
}



procedure {:origName "sdv_CheckDpcRoutines"} {:osmodel} sdv_CheckDpcRoutines() returns (Tmp_94: int);



implementation {:origName "sdv_CheckDpcRoutines"} {:osmodel} sdv_CheckDpcRoutines() returns (Tmp_94: int)
{

  anon0:
    Tmp_94 := 1;
    return;
}



procedure {:origName "PoCallDriver"} {:osmodel} PoCallDriver(actual_DeviceObject_7: int, actual_Irp_1: int) returns (Tmp_96: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "PoCallDriver"} {:osmodel} PoCallDriver(actual_DeviceObject_7: int, actual_Irp_1: int) returns (Tmp_96: int)
{
  var {:scalar} status_3: int;
  var {:pointer} Irp_1: int;

  anon0:
    Irp_1 := actual_Irp_1;
    status_3 := 259;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    goto anon41_Then, anon41_Else;

  anon41_Else:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := 259;
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 259;
    goto L19;

  L19:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 259;
    goto L21;

  L21:
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_1;
    goto L25;

  L25:
    Tmp_96 := status_3;
    return;

  anon33_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 259;
    goto L25;

  anon32_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_1;
    goto L21;

  anon44_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_1;
    goto L19;

  anon40_Then:
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := -1073741823;
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741823;
    goto L44;

  L44:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741823;
    goto L46;

  L46:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741823;
    goto L25;

  anon39_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_1;
    goto L25;

  anon38_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_1;
    goto L46;

  anon45_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_1;
    goto L44;

  anon41_Then:
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := -1073741536;
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741536;
    goto L28;

  L28:
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741536;
    goto L30;

  L30:
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741536;
    goto L25;

  anon35_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_1;
    goto L25;

  anon34_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_1;
    goto L30;

  anon43_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_1;
    goto L28;

  anon31_Then:
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_1))] := 0;
    assume {:nonnull} Irp_1 != 0;
    assume Irp_1 > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 0;
    goto L36;

  L36:
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 0;
    goto L38;

  L38:
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_1;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 0;
    goto L25;

  anon37_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_1;
    goto L25;

  anon36_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_1;
    goto L38;

  anon42_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_1;
    goto L36;
}



procedure {:origName "sdv_KeRaiseIrql"} {:osmodel} sdv_KeRaiseIrql(actual_new: int, actual_p_1: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4;



implementation {:origName "sdv_KeRaiseIrql"} {:osmodel} sdv_KeRaiseIrql(actual_new: int, actual_p_1: int)
{
  var {:scalar} new: int;
  var {:pointer} p_1: int;
  var vslice_dummy_var_35: int;

  anon0:
    call vslice_dummy_var_35 := __HAVOC_malloc(4);
    new := actual_new;
    p_1 := actual_p_1;
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := new;
    assume {:nonnull} p_1 != 0;
    assume p_1 > 0;
    Mem_T.INT4[p_1] := sdv_irql_previous;
    return;
}



procedure {:origName "IoWriteErrorLogEntry"} {:osmodel} IoWriteErrorLogEntry(actual_ElEntry: int);
  modifies alloc;



implementation {:origName "IoWriteErrorLogEntry"} {:osmodel} IoWriteErrorLogEntry(actual_ElEntry: int)
{
  var vslice_dummy_var_36: int;

  anon0:
    call vslice_dummy_var_36 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_IoSetCompletionRoutine"} {:osmodel} sdv_IoSetCompletionRoutine(actual_pirp_5: int, actual_CompletionRoutine: int, actual_Context_2: int, actual_InvokeOnSuccess: int, actual_InvokeOnError: int, actual_InvokeOnCancel: int);
  modifies alloc, Mem_T.CompletionRoutine__IO_STACK_LOCATION;



implementation {:origName "sdv_IoSetCompletionRoutine"} {:osmodel} sdv_IoSetCompletionRoutine(actual_pirp_5: int, actual_CompletionRoutine: int, actual_Context_2: int, actual_InvokeOnSuccess: int, actual_InvokeOnError: int, actual_InvokeOnCancel: int)
{
  var {:pointer} irpSp_1: int;
  var {:pointer} pirp_5: int;
  var {:scalar} CompletionRoutine: int;
  var {:pointer} Context_2: int;
  var {:scalar} InvokeOnSuccess: int;
  var {:scalar} InvokeOnError: int;
  var {:scalar} InvokeOnCancel: int;
  var vslice_dummy_var_37: int;

  anon0:
    call vslice_dummy_var_37 := __HAVOC_malloc(4);
    pirp_5 := actual_pirp_5;
    CompletionRoutine := actual_CompletionRoutine;
    Context_2 := actual_Context_2;
    InvokeOnSuccess := actual_InvokeOnSuccess;
    InvokeOnError := actual_InvokeOnError;
    InvokeOnCancel := actual_InvokeOnCancel;
    call irpSp_1 := sdv_IoGetNextIrpStackLocation(pirp_5);
    assume {:nonnull} irpSp_1 != 0;
    assume irpSp_1 > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpSp_1)] := CompletionRoutine;
    return;
}



procedure {:origName "ExAcquireFastMutex"} {:osmodel} ExAcquireFastMutex(actual_FastMutex: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;



implementation {:origName "ExAcquireFastMutex"} {:osmodel} ExAcquireFastMutex(actual_FastMutex: int)
{
  var vslice_dummy_var_38: int;

  anon0:
    call vslice_dummy_var_38 := __HAVOC_malloc(4);
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 1;
    return;
}



procedure {:origName "sdv_RemoveEntryList"} {:osmodel} sdv_RemoveEntryList(actual_Entry: int) returns (Tmp_106: int);



implementation {:origName "sdv_RemoveEntryList"} {:osmodel} sdv_RemoveEntryList(actual_Entry: int) returns (Tmp_106: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_106 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_106 := 0;
    goto L1;
}



procedure {:origName "PoStartNextPowerIrp"} {:osmodel} PoStartNextPowerIrp(actual_Irp_2: int);
  modifies alloc;



implementation {:origName "PoStartNextPowerIrp"} {:osmodel} PoStartNextPowerIrp(actual_Irp_2: int)
{
  var vslice_dummy_var_39: int;

  anon0:
    call vslice_dummy_var_39 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KeWaitForSingleObject"} {:osmodel} KeWaitForSingleObject(actual_Object: int, actual_WaitReason: int, actual_WaitMode_1: int, actual_Alertable_1: int, actual_Timeout: int) returns (Tmp_110: int);
  modifies yogi_error;



implementation {:origName "KeWaitForSingleObject"} {:osmodel} KeWaitForSingleObject(actual_Object: int, actual_WaitReason: int, actual_WaitMode_1: int, actual_Alertable_1: int, actual_Timeout: int) returns (Tmp_110: int)
{
  var {:pointer} Timeout: int;

  anon0:
    Timeout := actual_Timeout;
    call SLIC_KeWaitForSingleObject_entry(strConst__li2bpl0, Timeout);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} yogi_error != 1;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} Timeout != 0;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    Tmp_110 := 258;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon8_Then:
    Tmp_110 := 0;
    goto L1;

  anon7_Then:
    assume {:partition} Timeout == 0;
    Tmp_110 := 0;
    goto L1;

  anon9_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "IoDeleteDevice"} {:osmodel} IoDeleteDevice(actual_DeviceObject_8: int);
  modifies alloc;



implementation {:origName "IoDeleteDevice"} {:osmodel} IoDeleteDevice(actual_DeviceObject_8: int)
{
  var vslice_dummy_var_40: int;

  anon0:
    call vslice_dummy_var_40 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "KeSetEvent"} {:osmodel} KeSetEvent(actual_Event: int, actual_Increment: int, actual_Wait: int) returns (Tmp_114: int);
  modifies Mem_T.SignalState__DISPATCHER_HEADER;



implementation {:origName "KeSetEvent"} {:osmodel} KeSetEvent(actual_Event: int, actual_Increment: int, actual_Wait: int) returns (Tmp_114: int)
{
  var {:scalar} OldState: int;
  var {:pointer} Event: int;

  anon0:
    Event := actual_Event;
    assume {:nonnull} Event != 0;
    assume Event > 0;
    OldState := Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event))];
    assume {:nonnull} Event != 0;
    assume Event > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event))] := 1;
    Tmp_114 := OldState;
    return;
}



procedure {:origName "MmPageEntireDriver"} {:osmodel} MmPageEntireDriver(actual_AddressWithinSection: int) returns (Tmp_118: int);
  modifies alloc;



implementation {:origName "MmPageEntireDriver"} {:osmodel} MmPageEntireDriver(actual_AddressWithinSection: int) returns (Tmp_118: int)
{
  var {:pointer} sdv_66: int;
  var {:pointer} p_2: int;

  anon0:
    call sdv_66 := __HAVOC_malloc(1);
    p_2 := sdv_66;
    Tmp_118 := p_2;
    return;
}



procedure {:origName "ObReferenceObjectByHandle"} {:osmodel} ObReferenceObjectByHandle(actual_Handle: int, actual_DesiredAccess: int, actual_ObjectType: int, actual_AccessMode: int, actual_Object_1: int, actual_HandleInformation: int) returns (Tmp_120: int);



implementation {:origName "ObReferenceObjectByHandle"} {:osmodel} ObReferenceObjectByHandle(actual_Handle: int, actual_DesiredAccess: int, actual_ObjectType: int, actual_AccessMode: int, actual_Object_1: int, actual_HandleInformation: int) returns (Tmp_120: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_120 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_120 := -1073741823;
    goto L1;
}



procedure {:origName "sdv_IoGetCurrentIrpStackLocation"} {:osmodel} sdv_IoGetCurrentIrpStackLocation(actual_pirp_6: int) returns (Tmp_122: int);



implementation {:origName "sdv_IoGetCurrentIrpStackLocation"} {:osmodel} sdv_IoGetCurrentIrpStackLocation(actual_pirp_6: int) returns (Tmp_122: int)
{
  var {:pointer} pirp_6: int;

  anon0:
    pirp_6 := actual_pirp_6;
    assume {:nonnull} pirp_6 != 0;
    assume pirp_6 > 0;
    Tmp_122 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(pirp_6)))];
    return;
}



procedure {:origName "_sdv_init3"} {:osmodel} _sdv_init3();
  modifies alloc, sdv_dpc_io_registered, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, sdv_io_create_device_called, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, sdv_kdpc3, sdv_remove_irp_already_issued, sdv_isr_routine, sdv_dpc_ke_registered, sdv_io_dpc, Mem_T.INT4;



implementation {:origName "_sdv_init3"} {:osmodel} _sdv_init3()
{
  var vslice_dummy_var_41: int;

  anon0:
    call vslice_dummy_var_41 := __HAVOC_malloc(4);
    sdv_dpc_io_registered := 0;
    assume sdv_apc_disabled == 0;
    assume sdv_ControllerPirp == sdv_ControllerIrp;
    assume sdv_StartIopirp == sdv_StartIoIrp;
    assume sdv_power_irp == sdv_PowerIrp;
    assume sdv_irp == sdv_harnessIrp;
    assume sdv_other_irp == sdv_other_harnessIrp;
    assume sdv_IoMakeAssociatedIrp_irp == sdv_IoMakeAssociatedIrp_harnessIrp;
    assume sdv_IoBuildDeviceIoControlRequest_irp == sdv_IoBuildDeviceIoControlRequest_harnessIrp;
    sdv_IoBuildDeviceIoControlRequest_IoStatusBlock := sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock;
    assume sdv_IoBuildSynchronousFsdRequest_irp == sdv_IoBuildSynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock == sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;
    assume sdv_IoBuildAsynchronousFsdRequest_irp == sdv_IoBuildAsynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock == sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;
    assume sdv_IoInitializeIrp_irp == sdv_IoInitializeIrp_harnessIrp;
    sdv_io_create_device_called := 0;
    sdv_irql_current := 0;
    sdv_irql_previous := 0;
    sdv_irql_previous_2 := 0;
    sdv_irql_previous_3 := 0;
    sdv_irql_previous_4 := 0;
    sdv_irql_previous_5 := 0;
    assume sdv_maskedEflags == 0;
    sdv_kdpc3 := sdv_kdpc_val3;
    assume sdv_p_devobj_fdo == sdv_devobj_fdo;
    assume sdv_inside_init_entrypoint == 0;
    assume sdv_p_devobj_pdo == sdv_devobj_pdo;
    assume sdv_p_devobj_child_pdo == sdv_devobj_child_pdo;
    assume sdv_kinterrupt == sdv_kinterrupt_val;
    assume sdv_MapRegisterBase == sdv_MapRegisterBase_val;
    assume p_sdv_fx_dev_object == sdv_fx_dev_object;
    assume sdv_start_irp_already_issued == 0;
    sdv_remove_irp_already_issued := 0;
    assume sdv_Io_Removelock_release_wait_returned == 0;
    sdv_isr_routine := li2bplFunctionConstant298;
    assume sdv_ke_dpc == li2bplFunctionConstant300;
    sdv_dpc_ke_registered := 0;
    sdv_io_dpc := li2bplFunctionConstant303;
    assume sdv_p_devobj_top == sdv_devobj_top;
    Mem_T.INT4[sdv_MmMapIoSpace_int] := 0;
    return;
}



procedure {:origName "IoStartPacket"} {:osmodel} IoStartPacket(actual_DeviceObject_9: int, actual_Irp_3: int, actual_Key: int, actual_CancelFunction: int);
  modifies alloc;



implementation {:origName "IoStartPacket"} {:osmodel} IoStartPacket(actual_DeviceObject_9: int, actual_Irp_3: int, actual_Key: int, actual_CancelFunction: int)
{
  var vslice_dummy_var_42: int;

  anon0:
    call vslice_dummy_var_42 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_IoMapTransfer"} {:osmodel} sdv_IoMapTransfer(actual_AdapterObject_1: int, actual_Mdl_2: int, actual_MapRegisterBase_1: int, actual_CurrentVa_1: int, actual_Length_1: int, actual_WriteToDevice_1: int) returns (structPtr888Tmp: int);
  modifies alloc, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID;



implementation {:origName "sdv_IoMapTransfer"} {:osmodel} sdv_IoMapTransfer(actual_AdapterObject_1: int, actual_Mdl_2: int, actual_MapRegisterBase_1: int, actual_CurrentVa_1: int, actual_Length_1: int, actual_WriteToDevice_1: int) returns (structPtr888Tmp: int)
{
  var {:scalar} sdv_68: int;
  var {:scalar} Tmp: int;
  var {:scalar} l: int;

  anon0:
    call Tmp := __HAVOC_malloc(20);
    call l := __HAVOC_malloc(20);
    assume {:nonnull} l != 0;
    assume l > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(l)] := sdv_68;
    assume {:nonnull} Tmp != 0;
    assume Tmp > 0;
    assume {:nonnull} l != 0;
    assume l > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(Tmp)] := Mem_T.LowPart__LUID[LowPart__LUID(l)];
    assume {:nonnull} Tmp != 0;
    assume Tmp > 0;
    assume {:nonnull} l != 0;
    assume l > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(Tmp)] := Mem_T.HighPart__LUID[HighPart__LUID(l)];
    assume {:nonnull} Tmp != 0;
    assume Tmp > 0;
    assume {:nonnull} l != 0;
    assume l > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(Tmp))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(l))];
    assume {:nonnull} Tmp != 0;
    assume Tmp > 0;
    assume {:nonnull} l != 0;
    assume l > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(Tmp))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(l))];
    assume {:nonnull} Tmp != 0;
    assume Tmp > 0;
    assume {:nonnull} l != 0;
    assume l > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(Tmp)] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(l)];
    structPtr888Tmp := Tmp;
    return;
}



procedure {:origName "sdv_RunKeDpcRoutines"} {:osmodel} sdv_RunKeDpcRoutines(actual_kdpc: int, actual_pDpcContext: int, actual_pv2: int, actual_pv3: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;



implementation {:origName "sdv_RunKeDpcRoutines"} {:osmodel} sdv_RunKeDpcRoutines(actual_kdpc: int, actual_pDpcContext: int, actual_pv2: int, actual_pv3: int)
{
  var {:pointer} kdpc: int;
  var {:pointer} pDpcContext: int;
  var vslice_dummy_var_43: int;

  anon0:
    call vslice_dummy_var_43 := __HAVOC_malloc(4);
    kdpc := actual_kdpc;
    pDpcContext := actual_pDpcContext;
    assume {:nonnull} kdpc != 0;
    assume kdpc > 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} Mem_T.DeferredRoutine__KDPC[DeferredRoutine__KDPC(kdpc)] == li2bplFunctionConstant210;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} sdv_dpc_ke_registered != 0;
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call FcLogErrorDpc(kdpc, pDpcContext, sdv_pv2, sdv_pv3);
    sdv_irql_current := 0;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} sdv_dpc_ke_registered == 0;
    goto L1;

  anon5_Then:
    assume {:partition} Mem_T.DeferredRoutine__KDPC[DeferredRoutine__KDPC(kdpc)] != li2bplFunctionConstant210;
    goto L1;
}



procedure {:origName "PoRequestPowerIrp"} {:osmodel} PoRequestPowerIrp(actual_DeviceObject_10: int, actual_MinorFunction: int, actual_structPtr888PowerState: int, actual_CompletionFunction: int, actual_Context_3: int, actual_Irp_4: int) returns (Tmp_131: int);
  modifies alloc, Mem_T.SystemState__POWER_STATE, Mem_T.DeviceState__POWER_STATE, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "PoRequestPowerIrp"} {:osmodel} PoRequestPowerIrp(actual_DeviceObject_10: int, actual_MinorFunction: int, actual_structPtr888PowerState: int, actual_CompletionFunction: int, actual_Context_3: int, actual_Irp_4: int) returns (Tmp_131: int)
{
  var {:scalar} PowerState: int;
  var {:scalar} MinorFunction: int;
  var {:pointer} structPtr888PowerState: int;

  anon0:
    call PowerState := __HAVOC_malloc(8);
    MinorFunction := actual_MinorFunction;
    structPtr888PowerState := actual_structPtr888PowerState;
    assume {:nonnull} PowerState != 0;
    assume PowerState > 0;
    assume {:nonnull} structPtr888PowerState != 0;
    assume structPtr888PowerState > 0;
    Mem_T.SystemState__POWER_STATE[SystemState__POWER_STATE(PowerState)] := Mem_T.SystemState__POWER_STATE[SystemState__POWER_STATE(structPtr888PowerState)];
    assume {:nonnull} PowerState != 0;
    assume PowerState > 0;
    assume {:nonnull} structPtr888PowerState != 0;
    assume structPtr888PowerState > 0;
    Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(PowerState)] := Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(structPtr888PowerState)];
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} MinorFunction != 3;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} MinorFunction != 2;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} MinorFunction != 0;
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(sdv_power_irp))] := -1073741584;
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    Tmp_131 := -1073741584;
    goto L1;

  L1:
    return;

  anon11_Then:
    assume {:partition} MinorFunction == 0;
    goto L13;

  L13:
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(sdv_power_irp))] := 259;
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    Tmp_131 := 259;
    goto L1;

  anon9_Then:
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(sdv_power_irp))] := -1073741670;
    assume {:nonnull} sdv_power_irp != 0;
    assume sdv_power_irp > 0;
    Tmp_131 := -1073741670;
    goto L1;

  anon10_Then:
    assume {:partition} MinorFunction == 2;
    goto L13;

  anon12_Then:
    assume {:partition} MinorFunction == 3;
    goto L13;
}

procedure {:nohoudini} {:origName "main"} {:osmodel} {:entrypoint} main() returns (tnew: int);
  modifies alloc, sdv_pDpcContext, CommandTable, sdv_dpc_io_registered, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, sdv_io_create_device_called, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, sdv_kdpc3, sdv_remove_irp_already_issued, sdv_isr_routine, sdv_dpc_ke_registered, sdv_io_dpc, Mem_T.INT4, Mem_T.DeviceExtension__DEVICE_OBJECT, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Status__IO_STATUS_BLOCK, yogi_error, FdcDefaultControllerNumber, PagingReferenceCount, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.IsrReentered__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CancelRoutine__IRP, sdv_start_info, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.CompletionRoutine__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Type_unnamed_tag_39, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.DeviceState__POWER_STATE, Mem_T.CurrentPowerState__FDC_FDO_EXTENSION, Mem_T.Type_unnamed_tag_28, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.SystemState__POWER_STATE, Mem_T.Map__IO_PORT_INFO, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.Version__IO_RESOURCE_LIST, Mem_T.Revision__IO_RESOURCE_LIST, Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR, Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR, Mem_T.MinimumVector_unnamed_tag_59, Mem_T.MaximumVector_unnamed_tag_59, Mem_T.AffinityPolicy_unnamed_tag_59, Mem_T.PriorityPolicy_unnamed_tag_59, Mem_T.TargetedProcessors_unnamed_tag_59, Mem_T.MinimumChannel_unnamed_tag_60, Mem_T.MaximumChannel_unnamed_tag_60, Mem_T.RequestLine_unnamed_tag_61, Mem_T.Reserved_unnamed_tag_61, Mem_T.Channel_unnamed_tag_61, Mem_T.TransferWidth_unnamed_tag_61, Mem_T.Data_unnamed_tag_50, Mem_T.MinBusNumber_unnamed_tag_62, Mem_T.MaxBusNumber_unnamed_tag_62, Mem_T.Reserved_unnamed_tag_62, Mem_T.Priority_unnamed_tag_63, Mem_T.Reserved1_unnamed_tag_63, Mem_T.Reserved2_unnamed_tag_63, Mem_T.Length40_unnamed_tag_64, Mem_T.Alignment40_unnamed_tag_64, Mem_T.Length48_unnamed_tag_65, Mem_T.Alignment48_unnamed_tag_65, Mem_T.Length64_unnamed_tag_66, Mem_T.Alignment64_unnamed_tag_66, Mem_T.Class_unnamed_tag_56, Mem_T.Type_unnamed_tag_56, Mem_T.Reserved1_unnamed_tag_56, Mem_T.Reserved2_unnamed_tag_56, Mem_T.IdLowPart_unnamed_tag_56, Mem_T.IdHighPart_unnamed_tag_56, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION, Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION, Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION, Mem_T.Count__DEVICE_RELATIONS, Mem_T.P_DEVICE_OBJECT, Mem_T.Paused__FDC_FDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, Mem_T.Removed__FDC_FDO_EXTENSION, Mem_T.Type3InputBuffer_unnamed_tag_22, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.SpeedsAvailable__FDC_INFORMATION, Mem_T.ClockRatesSupported__FDC_INFORMATION, Mem_T.FloppyControllerType__FDC_INFORMATION, Mem_T.FdcType__FDC_FDO_EXTENSION, Mem_T.Clock48MHz__FDC_FDO_EXTENSION, Mem_T.FdcSpeeds__FDC_FDO_EXTENSION, Mem_T.MaximumLength__DEVICE_DESCRIPTION, Mem_T.AdapterObject__FDC_FDO_EXTENSION, Mem_T.PINT4, Mem_T.InterruptMode__FDC_FDO_EXTENSION, Mem_T.ControllerVector__FDC_FDO_EXTENSION, Mem_T.ProcessorMask__FDC_FDO_EXTENSION, Mem_T.ControllerIrql__FDC_FDO_EXTENSION, Mem_T.SharableVector__FDC_FDO_EXTENSION, Mem_T.SaveFloatState__FDC_FDO_EXTENSION, Mem_T.BusType__FDC_FDO_EXTENSION, Mem_T.BusNumber__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.NumPDOs__FDC_FDO_EXTENSION, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.BufferSize__FDC_INFO, Mem_T.BufferCount__FDC_INFO, Mem_T.BuffersRequested__FDC_FDO_EXTENSION, Mem_T.Virtual__TRANSFER_BUFFER, Mem_T.AcpiBios__FDC_INFO, Mem_T.DriveNumber__ACPI_FDI_DATA, Mem_T.DeviceType__ACPI_FDI_DATA, Mem_T.MaxCylinderNumber__ACPI_FDI_DATA, Mem_T.MaxSectorNumber__ACPI_FDI_DATA, Mem_T.MaxHeadNumber__ACPI_FDI_DATA, Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA, Mem_T.HeadLoadTime__ACPI_FDI_DATA, Mem_T.MotorOffTime__ACPI_FDI_DATA, Mem_T.SectorLengthCode__ACPI_FDI_DATA, Mem_T.SectorPerTrack__ACPI_FDI_DATA, Mem_T.ReadWriteGapLength__ACPI_FDI_DATA, Mem_T.DataTransferLength__ACPI_FDI_DATA, Mem_T.FormatGapLength__ACPI_FDI_DATA, Mem_T.FormatFillCharacter__ACPI_FDI_DATA, Mem_T.HeadSettleTime__ACPI_FDI_DATA, Mem_T.MotorSettleTime__ACPI_FDI_DATA, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION, Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION, Mem_T.DeferredRoutine__KDPC, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT;

implementation {:origName "main"} {:osmodel} {:entrypoint} main() returns (tnew: int)
{
  call tnew:= top();
}

procedure {:nohoudini} {:origName "top"} {:osmodel} top() returns (Tmp_133: int);
  modifies alloc, sdv_pDpcContext, CommandTable, sdv_dpc_io_registered, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, sdv_io_create_device_called, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, sdv_kdpc3, sdv_remove_irp_already_issued, sdv_isr_routine, sdv_dpc_ke_registered, sdv_io_dpc, Mem_T.INT4, Mem_T.DeviceExtension__DEVICE_OBJECT, Mem_T.CurrentStackLocation_unnamed_tag_6, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Status__IO_STATUS_BLOCK, yogi_error, FdcDefaultControllerNumber, PagingReferenceCount, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.IsrReentered__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CancelRoutine__IRP, sdv_start_info, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.CompletionRoutine__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Type_unnamed_tag_39, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.DeviceState__POWER_STATE, Mem_T.CurrentPowerState__FDC_FDO_EXTENSION, Mem_T.Type_unnamed_tag_28, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.SystemState__POWER_STATE, Mem_T.Map__IO_PORT_INFO, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.Version__IO_RESOURCE_LIST, Mem_T.Revision__IO_RESOURCE_LIST, Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR, Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR, Mem_T.MinimumVector_unnamed_tag_59, Mem_T.MaximumVector_unnamed_tag_59, Mem_T.AffinityPolicy_unnamed_tag_59, Mem_T.PriorityPolicy_unnamed_tag_59, Mem_T.TargetedProcessors_unnamed_tag_59, Mem_T.MinimumChannel_unnamed_tag_60, Mem_T.MaximumChannel_unnamed_tag_60, Mem_T.RequestLine_unnamed_tag_61, Mem_T.Reserved_unnamed_tag_61, Mem_T.Channel_unnamed_tag_61, Mem_T.TransferWidth_unnamed_tag_61, Mem_T.Data_unnamed_tag_50, Mem_T.MinBusNumber_unnamed_tag_62, Mem_T.MaxBusNumber_unnamed_tag_62, Mem_T.Reserved_unnamed_tag_62, Mem_T.Priority_unnamed_tag_63, Mem_T.Reserved1_unnamed_tag_63, Mem_T.Reserved2_unnamed_tag_63, Mem_T.Length40_unnamed_tag_64, Mem_T.Alignment40_unnamed_tag_64, Mem_T.Length48_unnamed_tag_65, Mem_T.Alignment48_unnamed_tag_65, Mem_T.Length64_unnamed_tag_66, Mem_T.Alignment64_unnamed_tag_66, Mem_T.Class_unnamed_tag_56, Mem_T.Type_unnamed_tag_56, Mem_T.Reserved1_unnamed_tag_56, Mem_T.Reserved2_unnamed_tag_56, Mem_T.IdLowPart_unnamed_tag_56, Mem_T.IdHighPart_unnamed_tag_56, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION, Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION, Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION, Mem_T.Count__DEVICE_RELATIONS, Mem_T.P_DEVICE_OBJECT, Mem_T.Paused__FDC_FDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, Mem_T.Removed__FDC_FDO_EXTENSION, Mem_T.Type3InputBuffer_unnamed_tag_22, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.SpeedsAvailable__FDC_INFORMATION, Mem_T.ClockRatesSupported__FDC_INFORMATION, Mem_T.FloppyControllerType__FDC_INFORMATION, Mem_T.FdcType__FDC_FDO_EXTENSION, Mem_T.Clock48MHz__FDC_FDO_EXTENSION, Mem_T.FdcSpeeds__FDC_FDO_EXTENSION, Mem_T.MaximumLength__DEVICE_DESCRIPTION, Mem_T.AdapterObject__FDC_FDO_EXTENSION, Mem_T.PINT4, Mem_T.InterruptMode__FDC_FDO_EXTENSION, Mem_T.ControllerVector__FDC_FDO_EXTENSION, Mem_T.ProcessorMask__FDC_FDO_EXTENSION, Mem_T.ControllerIrql__FDC_FDO_EXTENSION, Mem_T.SharableVector__FDC_FDO_EXTENSION, Mem_T.SaveFloatState__FDC_FDO_EXTENSION, Mem_T.BusType__FDC_FDO_EXTENSION, Mem_T.BusNumber__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.NumPDOs__FDC_FDO_EXTENSION, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.BufferSize__FDC_INFO, Mem_T.BufferCount__FDC_INFO, Mem_T.BuffersRequested__FDC_FDO_EXTENSION, Mem_T.Virtual__TRANSFER_BUFFER, Mem_T.AcpiBios__FDC_INFO, Mem_T.DriveNumber__ACPI_FDI_DATA, Mem_T.DeviceType__ACPI_FDI_DATA, Mem_T.MaxCylinderNumber__ACPI_FDI_DATA, Mem_T.MaxSectorNumber__ACPI_FDI_DATA, Mem_T.MaxHeadNumber__ACPI_FDI_DATA, Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA, Mem_T.HeadLoadTime__ACPI_FDI_DATA, Mem_T.MotorOffTime__ACPI_FDI_DATA, Mem_T.SectorLengthCode__ACPI_FDI_DATA, Mem_T.SectorPerTrack__ACPI_FDI_DATA, Mem_T.ReadWriteGapLength__ACPI_FDI_DATA, Mem_T.DataTransferLength__ACPI_FDI_DATA, Mem_T.FormatGapLength__ACPI_FDI_DATA, Mem_T.FormatFillCharacter__ACPI_FDI_DATA, Mem_T.HeadSettleTime__ACPI_FDI_DATA, Mem_T.MotorSettleTime__ACPI_FDI_DATA, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION, Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION, Mem_T.DeferredRoutine__KDPC, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT;


implementation {:origName "top"} {:osmodel} top() returns (Tmp_133: int)
{
  var {:scalar} Tmp_134: int;
  var {:scalar} Tmp_135: int;
  var boogieTmp: int;
  var WHEA_ERROR_PACKET_SECTION_GUID__Loc: int;
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
  var sdv_DpcContext__Loc: int;
  var sdv_StartIoIrp__Loc: int;
  var sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc: int;
  var sdv_PowerIrp__Loc: int;
  var sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc: int;
  var sdv_other_harnessIrp__Loc: int;
  var sdv_IoCreateNotificationEvent_KEVENT__Loc: int;
  var sdv_other_harnessStackLocation__Loc: int;
  var sdv_MmMapIoSpace_int__Loc: int;

  anon0:
    assume alloc > 0;
    call WHEA_ERROR_PACKET_SECTION_GUID__Loc := __HAVOC_malloc_or_null(16);
    assume WHEA_ERROR_PACKET_SECTION_GUID__Loc == WHEA_ERROR_PACKET_SECTION_GUID;
    assume WHEA_ERROR_PACKET_SECTION_GUID != 0;
    call sdv_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_harnessStackLocation_next__Loc == sdv_harnessStackLocation_next;
    assume sdv_harnessStackLocation_next != 0;
    call sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc := __HAVOC_malloc_or_null(76);
    assume sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX__Loc == sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX;
    assume sdv_IoReadPartitionTableEx_DRIVE_LAYOUT_INFORMATION_EX != 0;
    call sdv_IoBuildAsynchronousFsdRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoBuildAsynchronousFsdRequest_harnessIrp__Loc == sdv_IoBuildAsynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildAsynchronousFsdRequest_harnessIrp != 0;
    call sdv_IoGetDeviceToVerify_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_IoGetDeviceToVerify_DEVICE_OBJECT__Loc == sdv_IoGetDeviceToVerify_DEVICE_OBJECT;
    assume sdv_IoGetDeviceToVerify_DEVICE_OBJECT != 0;
    call sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next__Loc == sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next;
    assume sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next != 0;
    call sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock__Loc == sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock;
    assume sdv_harness_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    call sdv_ControllerIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_ControllerIrp__Loc == sdv_ControllerIrp;
    assume sdv_ControllerIrp != 0;
    call sdv_devobj_pdo__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_pdo__Loc == sdv_devobj_pdo;
    assume sdv_devobj_pdo != 0;
    call sdv_IoGetDmaAdapter_DMA_ADAPTER__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_IoGetDmaAdapter_DMA_ADAPTER__Loc == sdv_IoGetDmaAdapter_DMA_ADAPTER;
    assume sdv_IoGetDmaAdapter_DMA_ADAPTER != 0;
    call sdv_IoInitializeIrp_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoInitializeIrp_harnessIrp__Loc == sdv_IoInitializeIrp_harnessIrp;
    assume sdv_IoInitializeIrp_harnessIrp != 0;
    call sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT__Loc == sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT;
    assume sdv_IoGetRelatedDeviceObject_DEVICE_OBJECT != 0;
    call sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next__Loc == sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next;
    assume sdv_IoBuildSynchronousFsdRequest_harnessStackLocation_next != 0;
    call sdv_IoCreateSynchronizationEvent_KEVENT__Loc := __HAVOC_malloc_or_null(156);
    assume sdv_IoCreateSynchronizationEvent_KEVENT__Loc == sdv_IoCreateSynchronizationEvent_KEVENT;
    assume sdv_IoCreateSynchronizationEvent_KEVENT != 0;
    call sdv_harnessStackLocation__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_harnessStackLocation__Loc == sdv_harnessStackLocation;
    assume sdv_harnessStackLocation != 0;
    call sdv_other_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_other_harnessStackLocation_next__Loc == sdv_other_harnessStackLocation_next;
    assume sdv_other_harnessStackLocation_next != 0;
    call sdv_IoCreateController_CONTROLLER_OBJECT__Loc := __HAVOC_malloc_or_null(60);
    assume sdv_IoCreateController_CONTROLLER_OBJECT__Loc == sdv_IoCreateController_CONTROLLER_OBJECT;
    assume sdv_IoCreateController_CONTROLLER_OBJECT != 0;
    call sdv_devobj_top__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_top__Loc == sdv_devobj_top;
    assume sdv_devobj_top != 0;
    call sdv_kdpc_val3__Loc := __HAVOC_malloc_or_null(44);
    assume sdv_kdpc_val3__Loc == sdv_kdpc_val3;
    assume sdv_kdpc_val3 != 0;
    call sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoBuildSynchronousFsdRequest_harnessIrp__Loc == sdv_IoBuildSynchronousFsdRequest_harnessIrp;
    assume sdv_IoBuildSynchronousFsdRequest_harnessIrp != 0;
    call sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT__Loc == sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT;
    assume sdv_IoGetDeviceObjectPointer_DEVICE_OBJECT != 0;
    call sdv_MapRegisterBase_val__Loc := __HAVOC_malloc_or_null(4);
    assume sdv_MapRegisterBase_val__Loc == sdv_MapRegisterBase_val;
    assume sdv_MapRegisterBase_val != 0;
    call sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING__Loc := __HAVOC_malloc_or_null(16);
    assume sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING__Loc == sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING;
    assume sdv_IoGetFileObjectGenericMapping_GENERIC_MAPPING != 0;
    call sdv_IoMakeAssociatedIrp_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoMakeAssociatedIrp_harnessIrp__Loc == sdv_IoMakeAssociatedIrp_harnessIrp;
    assume sdv_IoMakeAssociatedIrp_harnessIrp != 0;
    call sdv_devobj_child_pdo__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_child_pdo__Loc == sdv_devobj_child_pdo;
    assume sdv_devobj_child_pdo != 0;
    call sdv_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_harnessIrp__Loc == sdv_harnessIrp;
    assume sdv_harnessIrp != 0;
    call sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next__Loc == sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next;
    assume sdv_IoBuildAsynchronousFsdRequest_harnessStackLocation_next != 0;
    call sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock__Loc == sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock;
    assume sdv_harness_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    call sdv_kinterrupt_val__Loc := __HAVOC_malloc_or_null(0);
    assume sdv_kinterrupt_val__Loc == sdv_kinterrupt_val;
    assume sdv_kinterrupt_val != 0;
    call sdv_fx_dev_object__Loc := __HAVOC_malloc_or_null(40);
    assume sdv_fx_dev_object__Loc == sdv_fx_dev_object;
    assume sdv_fx_dev_object != 0;
    call sdv_devobj_fdo__Loc := __HAVOC_malloc_or_null(380);
    assume sdv_devobj_fdo__Loc == sdv_devobj_fdo;
    assume sdv_devobj_fdo != 0;
    call sdv_DpcContext__Loc := __HAVOC_malloc_or_null(4);
    assume sdv_DpcContext__Loc == sdv_DpcContext;
    assume sdv_DpcContext != 0;
    call sdv_StartIoIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_StartIoIrp__Loc == sdv_StartIoIrp;
    assume sdv_StartIoIrp != 0;
    call sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc := __HAVOC_malloc_or_null(12);
    assume sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock__Loc == sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock;
    assume sdv_harness_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    call sdv_PowerIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_PowerIrp__Loc == sdv_PowerIrp;
    assume sdv_PowerIrp != 0;
    call sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_IoBuildDeviceIoControlRequest_harnessIrp__Loc == sdv_IoBuildDeviceIoControlRequest_harnessIrp;
    assume sdv_IoBuildDeviceIoControlRequest_harnessIrp != 0;
    call sdv_other_harnessIrp__Loc := __HAVOC_malloc_or_null(240);
    assume sdv_other_harnessIrp__Loc == sdv_other_harnessIrp;
    assume sdv_other_harnessIrp != 0;
    call sdv_IoCreateNotificationEvent_KEVENT__Loc := __HAVOC_malloc_or_null(156);
    assume sdv_IoCreateNotificationEvent_KEVENT__Loc == sdv_IoCreateNotificationEvent_KEVENT;
    assume sdv_IoCreateNotificationEvent_KEVENT != 0;
    call sdv_other_harnessStackLocation__Loc := __HAVOC_malloc_or_null(536);
    assume sdv_other_harnessStackLocation__Loc == sdv_other_harnessStackLocation;
    assume sdv_other_harnessStackLocation != 0;
    call sdv_MmMapIoSpace_int__Loc := __HAVOC_malloc_or_null(4);
    assume sdv_MmMapIoSpace_int__Loc == sdv_MmMapIoSpace_int;
    assume sdv_MmMapIoSpace_int != 0;
    call boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_harnessDeviceExtension_two == boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(4);
    call boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_pv1 == boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_pv3 == boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(44);
    assume sdv_kdpc == boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_pv2 == boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_pIoDpcContext == boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(4);
    sdv_pDpcContext := boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(4);
    assume sdv_harnessDeviceExtension == boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(4);
    assume igdoe == boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(240);
    assume sicrni == boogieTmp;
    call boogieTmp := __HAVOC_malloc_or_null(28);
    CommandTable := boogieTmp;
    call CommandTable := __HAVOC_malloc(812);
    assume {:mainInitDone} true;
    call corralExtraInit();
    call corralExplainErrorInit();
    call _sdv_init5();
    call _sdv_init1();
    call _sdv_init3();
    call _sdv_init2();
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} sdv_harnessDeviceExtension == 0;
    Tmp_135 := 0;
    goto L28;

  L28:
    assume Tmp_135 != 0;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} sdv_harnessDeviceExtension_two == 0;
    Tmp_134 := 0;
    goto L32;

  L32:
    assume Tmp_134 != 0;
    Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(sdv_devobj_pdo)] := sdv_harnessDeviceExtension;
    Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(sdv_devobj_fdo)] := sdv_harnessDeviceExtension_two;
    assume {:nonnull} sdv_irp != 0;
    assume sdv_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_irp)))] := sdv_harnessStackLocation;
    assume {:nonnull} sdv_other_irp != 0;
    assume sdv_other_irp > 0;
    Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_other_irp)))] := sdv_other_harnessStackLocation;
    call sdv_main();
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} yogi_error == 1;
    goto L26;

  L26:
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume yogi_error == 1;
    assert false;
    return;

  anon11_Then:
    assume yogi_error == 0;
    goto LM2;

  LM2:
    return;

  anon12_Then:
    assume {:partition} yogi_error != 1;
    goto L26;

  anon10_Then:
    assume {:partition} sdv_harnessDeviceExtension_two != 0;
    Tmp_134 := 1;
    goto L32;

  anon9_Then:
    assume {:partition} sdv_harnessDeviceExtension != 0;
    Tmp_135 := 1;
    goto L28;
}



procedure {:origName "sdv_IoSkipCurrentIrpStackLocation"} {:osmodel} sdv_IoSkipCurrentIrpStackLocation(actual_pirp_7: int);
  modifies alloc, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION;



implementation {:origName "sdv_IoSkipCurrentIrpStackLocation"} {:osmodel} sdv_IoSkipCurrentIrpStackLocation(actual_pirp_7: int)
{
  var {:pointer} pirp_7: int;
  var vslice_dummy_var_44: int;

  anon0:
    call vslice_dummy_var_44 := __HAVOC_malloc(4);
    pirp_7 := actual_pirp_7;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} pirp_7 == sdv_harnessIrp;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_harnessStackLocation)];
    goto L4;

  L4:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} pirp_7 == sdv_other_harnessIrp;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_other_harnessStackLocation)];
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



procedure {:origName "IoInitializeTimer"} {:osmodel} IoInitializeTimer(actual_DeviceObject_11: int, actual_TimerRoutine: int, actual_Context_4: int) returns (Tmp_139: int);



implementation {:origName "IoInitializeTimer"} {:osmodel} IoInitializeTimer(actual_DeviceObject_11: int, actual_TimerRoutine: int, actual_Context_4: int) returns (Tmp_139: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_139 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_139 := -1073741823;
    goto L1;
}



procedure {:origName "sdv_ExInterlockedRemoveHeadList"} {:osmodel} sdv_ExInterlockedRemoveHeadList(actual_ListHead: int, actual_Lock: int) returns (Tmp_141: int);
  modifies alloc;



implementation {:origName "sdv_ExInterlockedRemoveHeadList"} {:osmodel} sdv_ExInterlockedRemoveHeadList(actual_ListHead: int, actual_Lock: int) returns (Tmp_141: int)
{
  var {:pointer} sdv_72: int;
  var {:pointer} p_3: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call sdv_72 := __HAVOC_malloc(1);
    p_3 := sdv_72;
    Tmp_141 := p_3;
    goto L1;

  L1:
    return;

  anon3_Then:
    p_3 := 0;
    Tmp_141 := p_3;
    goto L1;
}



procedure {:origName "sdv_InterlockedDecrement"} {:osmodel} sdv_InterlockedDecrement(actual_Addend: int) returns (Tmp_143: int);
  modifies Mem_T.INT4;



implementation {:origName "sdv_InterlockedDecrement"} {:osmodel} sdv_InterlockedDecrement(actual_Addend: int) returns (Tmp_143: int)
{
  var {:pointer} Addend: int;

  anon0:
    Addend := actual_Addend;
    assume {:nonnull} Addend != 0;
    assume Addend > 0;
    Mem_T.INT4[Addend] := Mem_T.INT4[Addend] - 1;
    assume {:nonnull} Addend != 0;
    assume Addend > 0;
    Tmp_143 := Mem_T.INT4[Addend];
    return;
}



procedure {:origName "IoAllocateMdl"} {:osmodel} IoAllocateMdl(actual_VirtualAddress: int, actual_Length_2: int, actual_SecondaryBuffer: int, actual_ChargeQuota: int, actual_Irp_5: int) returns (Tmp_145: int);
  modifies alloc;



implementation {:origName "IoAllocateMdl"} {:osmodel} IoAllocateMdl(actual_VirtualAddress: int, actual_Length_2: int, actual_SecondaryBuffer: int, actual_ChargeQuota: int, actual_Irp_5: int) returns (Tmp_145: int)
{
  var {:pointer} sdv_74: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call sdv_74 := __HAVOC_malloc(1);
    Tmp_145 := sdv_74;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_145 := 0;
    goto L1;
}



procedure {:origName "RtlInitUnicodeString"} {:osmodel} RtlInitUnicodeString(actual_DestinationString_1: int, actual_SourceString_1: int);
  modifies alloc, Mem_T.Length_unnamed_tag_18;



implementation {:origName "RtlInitUnicodeString"} {:osmodel} RtlInitUnicodeString(actual_DestinationString_1: int, actual_SourceString_1: int)
{
  var {:pointer} DestinationString_1: int;
  var {:pointer} SourceString_1: int;
  var vslice_dummy_var_45: int;

  anon0:
    call vslice_dummy_var_45 := __HAVOC_malloc(4);
    DestinationString_1 := actual_DestinationString_1;
    SourceString_1 := actual_SourceString_1;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} DestinationString_1 != 0;
    assume {:nonnull} DestinationString_1 != 0;
    assume DestinationString_1 > 0;
    assume {:nonnull} DestinationString_1 != 0;
    assume DestinationString_1 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(DestinationString_1)] := 100;
    goto L4;

  L4:
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} SourceString_1 == 0;
    assume {:nonnull} DestinationString_1 != 0;
    assume DestinationString_1 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(DestinationString_1)] := 0;
    assume {:nonnull} DestinationString_1 != 0;
    assume DestinationString_1 > 0;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} SourceString_1 != 0;
    goto L1;

  anon5_Then:
    assume {:partition} DestinationString_1 == 0;
    goto L4;
}



procedure {:origName "sdv_IoRequestDpc"} {:osmodel} sdv_IoRequestDpc(actual_DeviceObject_12: int, actual_Irp_6: int, actual_Context_5: int);
  modifies alloc, sdv_dpc_io_registered;



implementation {:origName "sdv_IoRequestDpc"} {:osmodel} sdv_IoRequestDpc(actual_DeviceObject_12: int, actual_Irp_6: int, actual_Context_5: int)
{
  var vslice_dummy_var_46: int;

  anon0:
    call vslice_dummy_var_46 := __HAVOC_malloc(4);
    sdv_dpc_io_registered := 1;
    return;
}



procedure {:origName "IoGetAttachedDeviceReference"} {:osmodel} IoGetAttachedDeviceReference(actual_DeviceObject_13: int) returns (Tmp_151: int);



implementation {:origName "IoGetAttachedDeviceReference"} {:osmodel} IoGetAttachedDeviceReference(actual_DeviceObject_13: int) returns (Tmp_151: int)
{
  var {:pointer} DeviceObject_13: int;

  anon0:
    DeviceObject_13 := actual_DeviceObject_13;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_151 := sdv_p_devobj_top;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_151 := DeviceObject_13;
    goto L1;
}



procedure {:origName "sdv_RunStartIo"} {:osmodel} sdv_RunStartIo(actual_po: int, actual_pirp_8: int);
  modifies alloc, Mem_T.CancelRoutine__IRP, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, sdv_irql_previous_5, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.INT4, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_RunStartIo"} {:osmodel} sdv_RunStartIo(actual_po: int, actual_pirp_8: int)
{
  var {:pointer} po: int;
  var {:pointer} pirp_8: int;
  var vslice_dummy_var_47: int;

  anon0:
    call vslice_dummy_var_47 := __HAVOC_malloc(4);
    po := actual_po;
    pirp_8 := actual_pirp_8;
    call sdv_stub_startio_begin();
    assume {:nonnull} pirp_8 != 0;
    assume pirp_8 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_8)] := 0;
    assume {:nonnull} pirp_8 != 0;
    assume pirp_8 > 0;
    call FdcStartIo(po, pirp_8);
    call sdv_stub_startio_end();
    return;
}



procedure {:origName "sdv_IoCompletionRoutines"} {:osmodel} sdv_IoCompletionRoutines() returns (Tmp_155: int);



implementation {:origName "sdv_IoCompletionRoutines"} {:osmodel} sdv_IoCompletionRoutines() returns (Tmp_155: int)
{

  anon0:
    Tmp_155 := 1;
    return;
}



procedure {:origName "sdv_RtlZeroMemory"} {:osmodel} sdv_RtlZeroMemory(actual_Destination: int, actual_Length_3: int);
  modifies alloc;



implementation {:origName "sdv_RtlZeroMemory"} {:osmodel} sdv_RtlZeroMemory(actual_Destination: int, actual_Length_3: int)
{
  var vslice_dummy_var_48: int;

  anon0:
    call vslice_dummy_var_48 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoFreeMdl"} {:osmodel} IoFreeMdl(actual_Mdl_3: int);
  modifies alloc;



implementation {:origName "IoFreeMdl"} {:osmodel} IoFreeMdl(actual_Mdl_3: int)
{
  var vslice_dummy_var_49: int;

  anon0:
    call vslice_dummy_var_49 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_stub_startio_begin"} {:osmodel} sdv_stub_startio_begin();
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;



implementation {:origName "sdv_stub_startio_begin"} {:osmodel} sdv_stub_startio_begin()
{
  var vslice_dummy_var_50: int;

  anon0:
    call vslice_dummy_var_50 := __HAVOC_malloc(4);
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    return;
}



procedure {:origName "sdv_do_paged_code_check"} {:osmodel} sdv_do_paged_code_check();
  modifies alloc;



implementation {:origName "sdv_do_paged_code_check"} {:osmodel} sdv_do_paged_code_check()
{
  var vslice_dummy_var_51: int;

  anon0:
    call vslice_dummy_var_51 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_KeLowerIrql"} {:osmodel} sdv_KeLowerIrql(actual_NewIrql: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4;



implementation {:origName "sdv_KeLowerIrql"} {:osmodel} sdv_KeLowerIrql(actual_NewIrql: int)
{
  var {:scalar} NewIrql: int;
  var vslice_dummy_var_52: int;

  anon0:
    call vslice_dummy_var_52 := __HAVOC_malloc(4);
    NewIrql := actual_NewIrql;
    sdv_irql_current := NewIrql;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    return;
}



procedure {:origName "IoQueryDeviceDescription"} {:osmodel} IoQueryDeviceDescription(actual_BusType: int, actual_BusNumber: int, actual_ControllerType: int, actual_ControllerNumber: int, actual_PeripheralType: int, actual_PeripheralNumber: int, actual_CalloutRoutine: int, actual_Context_6: int) returns (Tmp_167: int);



implementation {:origName "IoQueryDeviceDescription"} {:osmodel} IoQueryDeviceDescription(actual_BusType: int, actual_BusNumber: int, actual_ControllerType: int, actual_ControllerNumber: int, actual_PeripheralType: int, actual_PeripheralNumber: int, actual_CalloutRoutine: int, actual_Context_6: int) returns (Tmp_167: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_167 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_167 := -1073741823;
    goto L1;
}



procedure {:origName "sdv_IoMarkIrpPending"} {:osmodel} sdv_IoMarkIrpPending(actual_pirp_9: int);
  modifies alloc;



implementation {:origName "sdv_IoMarkIrpPending"} {:osmodel} sdv_IoMarkIrpPending(actual_pirp_9: int)
{
  var vslice_dummy_var_53: int;

  anon0:
    call vslice_dummy_var_53 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_ExInterlockedInsertTailList"} {:osmodel} sdv_ExInterlockedInsertTailList(actual_ListHead_1: int, actual_ListEntry: int, actual_Lock_1: int) returns (Tmp_171: int);
  modifies alloc;



implementation {:origName "sdv_ExInterlockedInsertTailList"} {:osmodel} sdv_ExInterlockedInsertTailList(actual_ListHead_1: int, actual_ListEntry: int, actual_Lock_1: int) returns (Tmp_171: int)
{
  var {:pointer} sdv_78: int;
  var {:pointer} p_4: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call sdv_78 := __HAVOC_malloc(1);
    p_4 := sdv_78;
    Tmp_171 := p_4;
    goto L1;

  L1:
    return;

  anon3_Then:
    p_4 := 0;
    Tmp_171 := p_4;
    goto L1;
}



procedure {:origName "sdv_RunDispatchFunction"} {:osmodel} sdv_RunDispatchFunction(actual_po_1: int, actual_pirp_10: int) returns (Tmp_173: int);
  modifies sdv_start_info, alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.CancelRoutine__IRP, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.CompletionRoutine__IO_STACK_LOCATION, sdv_dpc_io_registered, Mem_T.MajorFunction__IO_STACK_LOCATION, sdv_remove_irp_already_issued, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.Type_unnamed_tag_39, PagingReferenceCount, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.INT4, Mem_T.IsrReentered__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, sdv_kdpc3, sdv_dpc_ke_registered, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.DeviceState__POWER_STATE, Mem_T.CurrentPowerState__FDC_FDO_EXTENSION, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.SystemState__POWER_STATE, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.Map__IO_PORT_INFO, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.Version__IO_RESOURCE_LIST, Mem_T.Revision__IO_RESOURCE_LIST, Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR, Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR, Mem_T.MinimumVector_unnamed_tag_59, Mem_T.MaximumVector_unnamed_tag_59, Mem_T.AffinityPolicy_unnamed_tag_59, Mem_T.PriorityPolicy_unnamed_tag_59, Mem_T.TargetedProcessors_unnamed_tag_59, Mem_T.MinimumChannel_unnamed_tag_60, Mem_T.MaximumChannel_unnamed_tag_60, Mem_T.RequestLine_unnamed_tag_61, Mem_T.Reserved_unnamed_tag_61, Mem_T.Channel_unnamed_tag_61, Mem_T.TransferWidth_unnamed_tag_61, Mem_T.Data_unnamed_tag_50, Mem_T.MinBusNumber_unnamed_tag_62, Mem_T.MaxBusNumber_unnamed_tag_62, Mem_T.Reserved_unnamed_tag_62, Mem_T.Priority_unnamed_tag_63, Mem_T.Reserved1_unnamed_tag_63, Mem_T.Reserved2_unnamed_tag_63, Mem_T.Length40_unnamed_tag_64, Mem_T.Alignment40_unnamed_tag_64, Mem_T.Length48_unnamed_tag_65, Mem_T.Alignment48_unnamed_tag_65, Mem_T.Length64_unnamed_tag_66, Mem_T.Alignment64_unnamed_tag_66, Mem_T.Class_unnamed_tag_56, Mem_T.Type_unnamed_tag_56, Mem_T.Reserved1_unnamed_tag_56, Mem_T.Reserved2_unnamed_tag_56, Mem_T.IdLowPart_unnamed_tag_56, Mem_T.IdHighPart_unnamed_tag_56, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION, Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION, Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION, Mem_T.Count__DEVICE_RELATIONS, Mem_T.P_DEVICE_OBJECT, Mem_T.Paused__FDC_FDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, FdcDefaultControllerNumber, Mem_T.Removed__FDC_FDO_EXTENSION, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_isr_routine, sdv_pDpcContext, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.SpeedsAvailable__FDC_INFORMATION, Mem_T.ClockRatesSupported__FDC_INFORMATION, Mem_T.FloppyControllerType__FDC_INFORMATION, Mem_T.FdcType__FDC_FDO_EXTENSION, Mem_T.Clock48MHz__FDC_FDO_EXTENSION, Mem_T.FdcSpeeds__FDC_FDO_EXTENSION, Mem_T.MaximumLength__DEVICE_DESCRIPTION, Mem_T.AdapterObject__FDC_FDO_EXTENSION, Mem_T.PINT4, Mem_T.InterruptMode__FDC_FDO_EXTENSION, Mem_T.ControllerVector__FDC_FDO_EXTENSION, Mem_T.ProcessorMask__FDC_FDO_EXTENSION, Mem_T.ControllerIrql__FDC_FDO_EXTENSION, Mem_T.SharableVector__FDC_FDO_EXTENSION, Mem_T.SaveFloatState__FDC_FDO_EXTENSION, Mem_T.BusType__FDC_FDO_EXTENSION, Mem_T.BusNumber__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.NumPDOs__FDC_FDO_EXTENSION, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.BufferSize__FDC_INFO, Mem_T.BufferCount__FDC_INFO, Mem_T.BuffersRequested__FDC_FDO_EXTENSION, Mem_T.Virtual__TRANSFER_BUFFER, Mem_T.AcpiBios__FDC_INFO, Mem_T.DriveNumber__ACPI_FDI_DATA, Mem_T.DeviceType__ACPI_FDI_DATA, Mem_T.MaxCylinderNumber__ACPI_FDI_DATA, Mem_T.MaxSectorNumber__ACPI_FDI_DATA, Mem_T.MaxHeadNumber__ACPI_FDI_DATA, Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA, Mem_T.HeadLoadTime__ACPI_FDI_DATA, Mem_T.MotorOffTime__ACPI_FDI_DATA, Mem_T.SectorLengthCode__ACPI_FDI_DATA, Mem_T.SectorPerTrack__ACPI_FDI_DATA, Mem_T.ReadWriteGapLength__ACPI_FDI_DATA, Mem_T.DataTransferLength__ACPI_FDI_DATA, Mem_T.FormatGapLength__ACPI_FDI_DATA, Mem_T.FormatFillCharacter__ACPI_FDI_DATA, Mem_T.HeadSettleTime__ACPI_FDI_DATA, Mem_T.MotorSettleTime__ACPI_FDI_DATA, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION, Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION, sdv_io_dpc, Mem_T.DeferredRoutine__KDPC, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, yogi_error, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT, sdv_io_create_device_called;



implementation {:origName "sdv_RunDispatchFunction"} {:osmodel} sdv_RunDispatchFunction(actual_po_1: int, actual_pirp_10: int) returns (Tmp_173: int)
{
  var {:pointer} ps: int;
  var {:scalar} Tmp_174: int;
  var {:scalar} minor: int;
  var {:scalar} Tmp_176: int;
  var {:scalar} sdv_87: int;
  var {:scalar} status_5: int;
  var {:pointer} po_1: int;
  var {:pointer} pirp_10: int;

  anon0:
    po_1 := actual_po_1;
    pirp_10 := actual_pirp_10;
    status_5 := 0;
    minor := sdv_87;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    ps := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(pirp_10)))];
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    sdv_start_info := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(pirp_10))];
    call sdv_SetStatus(pirp_10);
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    Mem_T.CancelRoutine__IRP[CancelRoutine__IRP(pirp_10)] := 0;
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] := minor;
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(ps)] := 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation_next)] := 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_other_harnessStackLocation_next)] := 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(sdv_harnessStackLocation)] := 0;
    sdv_dpc_io_registered := 0;
    call sdv_stub_dispatch_begin();
    goto anon49_Then, anon49_Else;

  anon49_Else:
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
    goto anon59_Then, anon59_Else;

  anon59_Else:
    goto anon58_Then, anon58_Else;

  anon58_Else:
    goto anon57_Then, anon57_Else;

  anon57_Else:
    goto anon56_Then, anon56_Else;

  anon56_Else:
    goto anon55_Then, anon55_Else;

  anon55_Else:
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 27;
    assume {:nonnull} ps != 0;
    assume ps > 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] != 0;
    goto L60;

  L60:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] == 3;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} sdv_remove_irp_already_issued != 0;
    Tmp_174 := 0;
    goto L228;

  L228:
    assume Tmp_174 != 0;
    goto L61;

  L61:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] == 2;
    sdv_remove_irp_already_issued := 1;
    goto L66;

  L66:
    call status_5 := FdcPnp(po_1, pirp_10);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} yogi_error != 1;
    call sdv_RunISRRoutines(sdv_kinterrupt, sdv_pDpcContext);
    call sdv_RunKeDpcRoutines(sdv_kdpc3, sdv_pDpcContext, 0, 0);
    call sdv_RunIoDpcRoutines(sdv_kdpc, po_1, pirp_10, sdv_pIoDpcContext);
    goto L81;

  L81:
    call sdv_stub_dispatch_end(status_5, 0);
    assume {:nonnull} pirp_10 != 0;
    assume pirp_10 > 0;
    Tmp_173 := status_5;
    goto LM2;

  LM2:
    return;

  anon72_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon52_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] != 2;
    goto L66;

  anon53_Then:
    assume {:partition} sdv_remove_irp_already_issued == 0;
    Tmp_174 := 1;
    goto L228;

  anon51_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] != 3;
    goto L61;

  anon71_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(ps)] == 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} sdv_start_irp_already_issued != 0;
    Tmp_176 := 0;
    goto L234;

  L234:
    assume Tmp_176 != 0;
    goto L60;

  anon50_Then:
    assume {:partition} sdv_start_irp_already_issued == 0;
    Tmp_176 := 1;
    goto L234;

  anon54_Then:
    call status_5 := sdv_DoNothing();
    goto L81;

  anon55_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 23;
    call status_5 := FdcSystemControl(po_1, pirp_10);
    goto L81;

  anon56_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 22;
    call sdv_SetPowerIrpMinorFunction(pirp_10);
    call status_5 := FdcPower(po_1, pirp_10);
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} yogi_error != 1;
    call sdv_RunISRRoutines(sdv_kinterrupt, sdv_pDpcContext);
    call sdv_RunKeDpcRoutines(sdv_kdpc3, sdv_pDpcContext, 0, 0);
    call sdv_RunIoDpcRoutines(sdv_kdpc, po_1, pirp_10, sdv_pIoDpcContext);
    goto L81;

  anon70_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon57_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 18;
    call status_5 := sdv_DoNothing();
    goto L81;

  anon58_Then:
    call status_5 := sdv_DoNothing();
    goto L81;

  anon59_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 16;
    call status_5 := sdv_DoNothing();
    goto L81;

  anon60_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 15;
    call status_5 := FdcInternalDeviceControl(po_1, pirp_10);
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} yogi_error != 1;
    goto L81;

  anon69_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon61_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 14;
    call status_5 := FdcDeviceControl(po_1, pirp_10);
    goto L81;

  anon62_Then:
    call status_5 := sdv_DoNothing();
    goto L81;

  anon63_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 9;
    call status_5 := sdv_DoNothing();
    goto L81;

  anon64_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 6;
    call status_5 := sdv_DoNothing();
    goto L81;

  anon65_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 5;
    call status_5 := sdv_DoNothing();
    goto L81;

  anon66_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 4;
    call status_5 := sdv_DoNothing();
    goto L81;

  anon67_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 3;
    call status_5 := sdv_DoNothing();
    goto L81;

  anon68_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 2;
    call status_5 := FdcCreateClose(po_1, pirp_10);
    goto L81;

  anon49_Then:
    assume {:nonnull} ps != 0;
    assume ps > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(ps)] := 0;
    call status_5 := FdcCreateClose(po_1, pirp_10);
    goto L81;
}



procedure {:origName "sdv_CheckAddDevice"} {:osmodel} sdv_CheckAddDevice() returns (Tmp_177: int);



implementation {:origName "sdv_CheckAddDevice"} {:osmodel} sdv_CheckAddDevice() returns (Tmp_177: int)
{

  anon0:
    Tmp_177 := 1;
    return;
}



procedure {:origName "sdv_CheckWorkerRoutines"} {:osmodel} sdv_CheckWorkerRoutines() returns (Tmp_179: int);



implementation {:origName "sdv_CheckWorkerRoutines"} {:osmodel} sdv_CheckWorkerRoutines() returns (Tmp_179: int)
{

  anon0:
    Tmp_179 := 0;
    return;
}



procedure {:origName "KeResetEvent"} {:osmodel} KeResetEvent(actual_Event_1: int) returns (Tmp_181: int);
  modifies Mem_T.SignalState__DISPATCHER_HEADER;



implementation {:origName "KeResetEvent"} {:osmodel} KeResetEvent(actual_Event_1: int) returns (Tmp_181: int)
{
  var {:scalar} OldState_1: int;
  var {:pointer} Event_1: int;

  anon0:
    Event_1 := actual_Event_1;
    assume {:nonnull} Event_1 != 0;
    assume Event_1 > 0;
    OldState_1 := Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_1))];
    assume {:nonnull} Event_1 != 0;
    assume Event_1 > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_1))] := 0;
    Tmp_181 := OldState_1;
    return;
}



procedure {:origName "sdv_KeReleaseSpinLock"} {:osmodel} sdv_KeReleaseSpinLock(actual_SpinLock_1: int, actual_new_1: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4;



implementation {:origName "sdv_KeReleaseSpinLock"} {:osmodel} sdv_KeReleaseSpinLock(actual_SpinLock_1: int, actual_new_1: int)
{
  var {:scalar} new_1: int;
  var vslice_dummy_var_54: int;

  anon0:
    call vslice_dummy_var_54 := __HAVOC_malloc(4);
    new_1 := actual_new_1;
    sdv_irql_current := new_1;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    return;
}



procedure {:origName "sdv_IoCompleteRequest"} {:osmodel} sdv_IoCompleteRequest(actual_pirp_11: int, actual_PriorityBoost: int);
  modifies alloc;



implementation {:origName "sdv_IoCompleteRequest"} {:osmodel} sdv_IoCompleteRequest(actual_pirp_11: int, actual_PriorityBoost: int)
{
  var vslice_dummy_var_55: int;

  anon0:
    call vslice_dummy_var_55 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "RtlAnsiStringToUnicodeString"} {:osmodel} RtlAnsiStringToUnicodeString(actual_DestinationString_2: int, actual_SourceString_2: int, actual_AllocateDestinationString: int) returns (Tmp_187: int);



implementation {:origName "RtlAnsiStringToUnicodeString"} {:osmodel} RtlAnsiStringToUnicodeString(actual_DestinationString_2: int, actual_SourceString_2: int, actual_AllocateDestinationString: int) returns (Tmp_187: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_187 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_187 := -1073741823;
    goto L1;
}



procedure {:origName "sdv_RtlCopyMemory"} {:osmodel} sdv_RtlCopyMemory(actual_Destination_1: int, actual_Source: int, actual_Length_4: int);
  modifies alloc;



implementation {:origName "sdv_RtlCopyMemory"} {:osmodel} sdv_RtlCopyMemory(actual_Destination_1: int, actual_Source: int, actual_Length_4: int)
{
  var vslice_dummy_var_56: int;

  anon0:
    call vslice_dummy_var_56 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_RunIoDpcRoutines"} {:osmodel} sdv_RunIoDpcRoutines(actual_Dpc_2: int, actual_DeviceObject_14: int, actual_Irp_7: int, actual_Context_7: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.SignalState__DISPATCHER_HEADER;



implementation {:origName "sdv_RunIoDpcRoutines"} {:osmodel} sdv_RunIoDpcRoutines(actual_Dpc_2: int, actual_DeviceObject_14: int, actual_Irp_7: int, actual_Context_7: int)
{
  var {:pointer} Dpc_2: int;
  var {:pointer} DeviceObject_14: int;
  var {:pointer} Irp_7: int;
  var {:pointer} Context_7: int;
  var vslice_dummy_var_57: int;

  anon0:
    call vslice_dummy_var_57 := __HAVOC_malloc(4);
    Dpc_2 := actual_Dpc_2;
    DeviceObject_14 := actual_DeviceObject_14;
    Irp_7 := actual_Irp_7;
    Context_7 := actual_Context_7;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} sdv_io_dpc == li2bplFunctionConstant209;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} sdv_dpc_io_registered != 0;
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 2;
    call FdcDeferredProcedure(Dpc_2, DeviceObject_14, Irp_7, Context_7);
    sdv_irql_current := 0;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} sdv_dpc_io_registered == 0;
    goto L1;

  anon5_Then:
    assume {:partition} sdv_io_dpc != li2bplFunctionConstant209;
    goto L1;
}



procedure {:origName "MmMapIoSpace"} {:osmodel} MmMapIoSpace(actual_structPtr888PhysicalAddress: int, actual_NumberOfBytes_1: int, actual_CacheType: int) returns (Tmp_193: int);
  modifies alloc, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER;



implementation {:origName "MmMapIoSpace"} {:osmodel} MmMapIoSpace(actual_structPtr888PhysicalAddress: int, actual_NumberOfBytes_1: int, actual_CacheType: int) returns (Tmp_193: int)
{
  var {:scalar} PhysicalAddress: int;
  var {:pointer} structPtr888PhysicalAddress: int;

  anon0:
    call PhysicalAddress := __HAVOC_malloc(20);
    structPtr888PhysicalAddress := actual_structPtr888PhysicalAddress;
    assume {:nonnull} PhysicalAddress != 0;
    assume PhysicalAddress > 0;
    assume {:nonnull} structPtr888PhysicalAddress != 0;
    assume structPtr888PhysicalAddress > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(PhysicalAddress)] := Mem_T.LowPart__LUID[LowPart__LUID(structPtr888PhysicalAddress)];
    assume {:nonnull} PhysicalAddress != 0;
    assume PhysicalAddress > 0;
    assume {:nonnull} structPtr888PhysicalAddress != 0;
    assume structPtr888PhysicalAddress > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(PhysicalAddress)] := Mem_T.HighPart__LUID[HighPart__LUID(structPtr888PhysicalAddress)];
    assume {:nonnull} PhysicalAddress != 0;
    assume PhysicalAddress > 0;
    assume {:nonnull} structPtr888PhysicalAddress != 0;
    assume structPtr888PhysicalAddress > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(PhysicalAddress))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(structPtr888PhysicalAddress))];
    assume {:nonnull} PhysicalAddress != 0;
    assume PhysicalAddress > 0;
    assume {:nonnull} structPtr888PhysicalAddress != 0;
    assume structPtr888PhysicalAddress > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(PhysicalAddress))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(structPtr888PhysicalAddress))];
    assume {:nonnull} PhysicalAddress != 0;
    assume PhysicalAddress > 0;
    assume {:nonnull} structPtr888PhysicalAddress != 0;
    assume structPtr888PhysicalAddress > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(PhysicalAddress)] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(structPtr888PhysicalAddress)];
    Tmp_193 := sdv_MmMapIoSpace_int;
    return;
}



procedure {:origName "IoStopTimer"} {:osmodel} IoStopTimer(actual_DeviceObject_15: int);
  modifies alloc;



implementation {:origName "IoStopTimer"} {:osmodel} IoStopTimer(actual_DeviceObject_15: int)
{
  var vslice_dummy_var_58: int;

  anon0:
    call vslice_dummy_var_58 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_ExFreePool"} {:osmodel} sdv_ExFreePool(actual_P: int);
  modifies alloc;



implementation {:origName "sdv_ExFreePool"} {:osmodel} sdv_ExFreePool(actual_P: int)
{
  var vslice_dummy_var_59: int;

  anon0:
    call vslice_dummy_var_59 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_CheckIsrRoutines"} {:osmodel} sdv_CheckIsrRoutines() returns (Tmp_199: int);



implementation {:origName "sdv_CheckIsrRoutines"} {:osmodel} sdv_CheckIsrRoutines() returns (Tmp_199: int)
{

  anon0:
    Tmp_199 := 1;
    return;
}



procedure {:origName "MmResetDriverPaging"} {:osmodel} MmResetDriverPaging(actual_AddressWithinSection_1: int);
  modifies alloc;



implementation {:origName "MmResetDriverPaging"} {:osmodel} MmResetDriverPaging(actual_AddressWithinSection_1: int)
{
  var vslice_dummy_var_60: int;

  anon0:
    call vslice_dummy_var_60 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "IoSetHardErrorOrVerifyDevice"} {:osmodel} IoSetHardErrorOrVerifyDevice(actual_Irp_8: int, actual_DeviceObject_16: int);
  modifies alloc;



implementation {:origName "IoSetHardErrorOrVerifyDevice"} {:osmodel} IoSetHardErrorOrVerifyDevice(actual_Irp_8: int, actual_DeviceObject_16: int)
{
  var vslice_dummy_var_61: int;

  anon0:
    call vslice_dummy_var_61 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_CheckStartIoRoutines"} {:osmodel} sdv_CheckStartIoRoutines() returns (Tmp_207: int);



implementation {:origName "sdv_CheckStartIoRoutines"} {:osmodel} sdv_CheckStartIoRoutines() returns (Tmp_207: int)
{

  anon0:
    Tmp_207 := 1;
    return;
}



procedure {:origName "sdv_InterlockedIncrement"} {:osmodel} sdv_InterlockedIncrement(actual_Addend_1: int) returns (Tmp_209: int);
  modifies Mem_T.INT4;



implementation {:origName "sdv_InterlockedIncrement"} {:osmodel} sdv_InterlockedIncrement(actual_Addend_1: int) returns (Tmp_209: int)
{
  var {:pointer} Addend_1: int;

  anon0:
    Addend_1 := actual_Addend_1;
    assume {:nonnull} Addend_1 != 0;
    assume Addend_1 > 0;
    Mem_T.INT4[Addend_1] := Mem_T.INT4[Addend_1] + 1;
    assume {:nonnull} Addend_1 != 0;
    assume Addend_1 > 0;
    Tmp_209 := Mem_T.INT4[Addend_1];
    return;
}



procedure {:origName "ExReleaseFastMutex"} {:osmodel} ExReleaseFastMutex(actual_FastMutex_1: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4;



implementation {:origName "ExReleaseFastMutex"} {:osmodel} ExReleaseFastMutex(actual_FastMutex_1: int)
{
  var vslice_dummy_var_62: int;

  anon0:
    call vslice_dummy_var_62 := __HAVOC_malloc(4);
    sdv_irql_current := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_5;
    return;
}



procedure {:origName "sdv_IsListEmpty"} {:osmodel} sdv_IsListEmpty(actual_ListHead_2: int) returns (Tmp_213: int);



implementation {:origName "sdv_IsListEmpty"} {:osmodel} sdv_IsListEmpty(actual_ListHead_2: int) returns (Tmp_213: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_213 := 1;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_213 := 0;
    goto L1;
}



procedure {:origName "sdv_CheckIrpMjPnp"} {:osmodel} sdv_CheckIrpMjPnp() returns (Tmp_215: int);



implementation {:origName "sdv_CheckIrpMjPnp"} {:osmodel} sdv_CheckIrpMjPnp() returns (Tmp_215: int)
{

  anon0:
    Tmp_215 := 1;
    return;
}



procedure {:origName "IoAllocateIrp"} {:osmodel} IoAllocateIrp(actual_StackSize: int, actual_ChargeQuota_1: int) returns (Tmp_217: int);
  modifies Mem_T.CompletionRoutine__IO_STACK_LOCATION;



implementation {:origName "IoAllocateIrp"} {:osmodel} IoAllocateIrp(actual_StackSize: int, actual_ChargeQuota_1: int) returns (Tmp_217: int)
{
  var {:pointer} irpSp_2: int;

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:nonnull} sdv_other_irp != 0;
    assume sdv_other_irp > 0;
    call irpSp_2 := sdv_IoGetNextIrpStackLocation(sdv_other_irp);
    assume {:nonnull} irpSp_2 != 0;
    assume irpSp_2 > 0;
    Mem_T.CompletionRoutine__IO_STACK_LOCATION[CompletionRoutine__IO_STACK_LOCATION(irpSp_2)] := 0;
    Tmp_217 := sdv_other_irp;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_217 := 0;
    goto L1;
}



procedure {:origName "sdv_IoAllocateAdapterChannel"} {:osmodel} sdv_IoAllocateAdapterChannel(actual_AdapterObject_2: int, actual_DeviceObject_17: int, actual_NumberOfMapRegisters_1: int, actual_ExecutionRoutine: int, actual_Context_8: int) returns (Tmp_219: int);



implementation {:origName "sdv_IoAllocateAdapterChannel"} {:osmodel} sdv_IoAllocateAdapterChannel(actual_AdapterObject_2: int, actual_DeviceObject_17: int, actual_NumberOfMapRegisters_1: int, actual_ExecutionRoutine: int, actual_Context_8: int) returns (Tmp_219: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_219 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_219 := -1073741670;
    goto L1;
}



procedure {:origName "IofCallDriver"} {:osmodel} IofCallDriver(actual_DeviceObject_18: int, actual_Irp_9: int) returns (Tmp_221: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "IofCallDriver"} {:osmodel} IofCallDriver(actual_DeviceObject_18: int, actual_Irp_9: int) returns (Tmp_221: int)
{
  var {:scalar} status_6: int;
  var {:pointer} Irp_9: int;

  anon0:
    Irp_9 := actual_Irp_9;
    status_6 := 259;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_9))] := 259;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 259;
    goto L19;

  L19:
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 259;
    goto L21;

  L21:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_9;
    goto L25;

  L25:
    Tmp_221 := status_6;
    return;

  anon32_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 259;
    goto L25;

  anon31_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_9;
    goto L21;

  anon44_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_9;
    goto L19;

  anon39_Then:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_9))] := -1073741823;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741823;
    goto L44;

  L44:
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741823;
    goto L46;

  L46:
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741823;
    goto L25;

  anon38_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_9;
    goto L25;

  anon37_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_9;
    goto L46;

  anon45_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_9;
    goto L44;

  anon40_Then:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_9))] := -1073741536;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741536;
    goto L28;

  L28:
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := -1073741536;
    goto L30;

  L30:
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := -1073741536;
    goto L25;

  anon34_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_9;
    goto L25;

  anon33_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_9;
    goto L30;

  anon43_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_9;
    goto L28;

  anon41_Then:
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_9))] := 0;
    assume {:nonnull} Irp_9 != 0;
    assume Irp_9 > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 0;
    goto L36;

  L36:
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildSynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildSynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildSynchronousFsdRequest_IoStatusBlock)] := 0;
    goto L38;

  L38:
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp == Irp_9;
    assume {:nonnull} sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock != 0;
    assume sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildAsynchronousFsdRequest_IoStatusBlock)] := 0;
    goto L25;

  anon36_Then:
    assume {:partition} sdv_IoBuildAsynchronousFsdRequest_irp != Irp_9;
    goto L25;

  anon35_Then:
    assume {:partition} sdv_IoBuildSynchronousFsdRequest_irp != Irp_9;
    goto L38;

  anon42_Then:
    assume {:partition} sdv_IoBuildDeviceIoControlRequest_irp != Irp_9;
    goto L36;
}



procedure {:origName "IoDisconnectInterrupt"} {:osmodel} IoDisconnectInterrupt(actual_InterruptObject: int);
  modifies alloc, sdv_isr_routine, sdv_pDpcContext;



implementation {:origName "IoDisconnectInterrupt"} {:osmodel} IoDisconnectInterrupt(actual_InterruptObject: int)
{
  var vslice_dummy_var_63: int;

  anon0:
    call vslice_dummy_var_63 := __HAVOC_malloc(4);
    sdv_isr_routine := li2bplFunctionConstant298;
    sdv_pDpcContext := sdv_DpcContext;
    return;
}



procedure {:origName "sdv_ObReferenceObject"} {:osmodel} sdv_ObReferenceObject(actual_Object_2: int) returns (Tmp_225: int);



implementation {:origName "sdv_ObReferenceObject"} {:osmodel} sdv_ObReferenceObject(actual_Object_2: int) returns (Tmp_225: int)
{
  var {:scalar} p_6: int;

  anon0:
    Tmp_225 := p_6;
    return;
}



procedure {:origName "KeInitializeEvent"} {:osmodel} KeInitializeEvent(actual_Event_2: int, actual_Type: int, actual_State: int);
  modifies alloc, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER;



implementation {:origName "KeInitializeEvent"} {:osmodel} KeInitializeEvent(actual_Event_2: int, actual_Type: int, actual_State: int)
{
  var {:pointer} Event_2: int;
  var {:scalar} Type: int;
  var {:scalar} State: int;
  var vslice_dummy_var_64: int;

  anon0:
    call vslice_dummy_var_64 := __HAVOC_malloc(4);
    Event_2 := actual_Event_2;
    Type := actual_Type;
    State := actual_State;
    assume {:nonnull} Event_2 != 0;
    assume Event_2 > 0;
    Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(Header__KEVENT(Event_2))] := Type;
    assume {:nonnull} Event_2 != 0;
    assume Event_2 > 0;
    assume {:nonnull} Event_2 != 0;
    assume Event_2 > 0;
    assume {:nonnull} Event_2 != 0;
    assume Event_2 > 0;
    Mem_T.SignalState__DISPATCHER_HEADER[SignalState__DISPATCHER_HEADER(Header__KEVENT(Event_2))] := State;
    return;
}



procedure {:origName "sdv_IoInitializeDpcRequest"} {:osmodel} sdv_IoInitializeDpcRequest(actual_DeviceObject_19: int, actual_DpcRoutine: int);
  modifies alloc, sdv_io_dpc;



implementation {:origName "sdv_IoInitializeDpcRequest"} {:osmodel} sdv_IoInitializeDpcRequest(actual_DeviceObject_19: int, actual_DpcRoutine: int)
{
  var {:scalar} DpcRoutine: int;
  var vslice_dummy_var_65: int;

  anon0:
    call vslice_dummy_var_65 := __HAVOC_malloc(4);
    DpcRoutine := actual_DpcRoutine;
    sdv_io_dpc := DpcRoutine;
    return;
}



procedure {:origName "sdv_IoCallDriver"} {:osmodel} sdv_IoCallDriver(actual_DeviceObject_20: int, actual_Irp_10: int) returns (Tmp_231: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "sdv_IoCallDriver"} {:osmodel} sdv_IoCallDriver(actual_DeviceObject_20: int, actual_Irp_10: int) returns (Tmp_231: int)
{
  var {:pointer} Irp_10: int;

  anon0:
    Irp_10 := actual_Irp_10;
    call Tmp_231 := IofCallDriver(0, Irp_10);
    return;
}



procedure {:origName "IoBuildDeviceIoControlRequest"} {:osmodel} IoBuildDeviceIoControlRequest(actual_IoControlCode: int, actual_DeviceObject_21: int, actual_InputBuffer: int, actual_InputBufferLength: int, actual_OutputBuffer: int, actual_OutputBufferLength: int, actual_InternalDeviceIoControl: int, actual_Event_3: int, actual_IoStatusBlock: int) returns (Tmp_233: int);
  modifies Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock;



implementation {:origName "IoBuildDeviceIoControlRequest"} {:osmodel} IoBuildDeviceIoControlRequest(actual_IoControlCode: int, actual_DeviceObject_21: int, actual_InputBuffer: int, actual_InputBufferLength: int, actual_OutputBuffer: int, actual_OutputBufferLength: int, actual_InternalDeviceIoControl: int, actual_Event_3: int, actual_IoStatusBlock: int) returns (Tmp_233: int)
{
  var {:pointer} Tmp_234: int;
  var {:pointer} Tmp_236: int;
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
    Tmp_236 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_IoBuildDeviceIoControlRequest_irp)))];
    assume {:nonnull} Tmp_236 != 0;
    assume Tmp_236 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(Tmp_236)] := 15;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next)] := 15;
    goto L14;

  L14:
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_irp != 0;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := 0;
    assume {:nonnull} IoStatusBlock != 0;
    assume IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatusBlock)] := 0;
    sdv_IoBuildDeviceIoControlRequest_IoStatusBlock := IoStatusBlock;
    Tmp_233 := sdv_IoBuildDeviceIoControlRequest_irp;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} InternalDeviceIoControl == 0;
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_irp != 0;
    assume sdv_IoBuildDeviceIoControlRequest_irp > 0;
    Tmp_234 := Mem_T.CurrentStackLocation_unnamed_tag_6[CurrentStackLocation_unnamed_tag_6(Overlay_unnamed_tag_5(Tail__IRP(sdv_IoBuildDeviceIoControlRequest_irp)))];
    assume {:nonnull} Tmp_234 != 0;
    assume Tmp_234 > 0;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(Tmp_234)] := 14;
    Mem_T.MajorFunction__IO_STACK_LOCATION[MajorFunction__IO_STACK_LOCATION(sdv_IoBuildDeviceIoControlRequest_harnessStackLocation_next)] := 14;
    goto L14;

  anon5_Then:
    assume {:nonnull} sdv_IoBuildDeviceIoControlRequest_IoStatusBlock != 0;
    assume sdv_IoBuildDeviceIoControlRequest_IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(sdv_IoBuildDeviceIoControlRequest_IoStatusBlock)] := -1073741823;
    assume {:nonnull} IoStatusBlock != 0;
    assume IoStatusBlock > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatusBlock)] := -1073741823;
    sdv_IoBuildDeviceIoControlRequest_IoStatusBlock := IoStatusBlock;
    Tmp_233 := 0;
    goto L1;
}



procedure {:origName "IoFreeIrp"} {:osmodel} IoFreeIrp(actual_pirp_12: int);
  modifies alloc;



implementation {:origName "IoFreeIrp"} {:osmodel} IoFreeIrp(actual_pirp_12: int)
{
  var vslice_dummy_var_66: int;

  anon0:
    call vslice_dummy_var_66 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_NT_ERROR"} {:osmodel} sdv_NT_ERROR(actual_Status_1: int) returns (Tmp_239: int);



implementation {:origName "sdv_NT_ERROR"} {:osmodel} sdv_NT_ERROR(actual_Status_1: int) returns (Tmp_239: int)
{
  var {:scalar} choice_18: int;
  var {:scalar} Tmp_241: int;
  var {:scalar} Status_1: int;

  anon0:
    Status_1 := actual_Status_1;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} Status_1 >= 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} 536870911 >= Status_1;
    Tmp_239 := 0;
    goto L1;

  L1:
    return;

  anon9_Then:
    assume {:partition} Status_1 > 536870911;
    goto L9;

  L9:
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} choice_18 != 0;
    Tmp_241 := 1;
    goto L14;

  L14:
    Tmp_239 := Tmp_241;
    goto L1;

  anon8_Then:
    assume {:partition} choice_18 == 0;
    Tmp_241 := 0;
    goto L14;

  anon7_Then:
    assume {:partition} 0 > Status_1;
    goto L9;
}



procedure {:origName "KeInsertQueueDpc"} {:osmodel} KeInsertQueueDpc(actual_Dpc_3: int, actual_SystemArgument1: int, actual_SystemArgument2: int) returns (Tmp_242: int);
  modifies sdv_kdpc3, sdv_dpc_ke_registered;



implementation {:origName "KeInsertQueueDpc"} {:osmodel} KeInsertQueueDpc(actual_Dpc_3: int, actual_SystemArgument1: int, actual_SystemArgument2: int) returns (Tmp_242: int)
{
  var {:pointer} Dpc_3: int;

  anon0:
    Dpc_3 := actual_Dpc_3;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_242 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    sdv_kdpc3 := Dpc_3;
    sdv_dpc_ke_registered := 1;
    Tmp_242 := 1;
    goto L1;
}



procedure {:origName "ExAllocatePoolWithTag"} {:osmodel} ExAllocatePoolWithTag(actual_PoolType_1: int, actual_NumberOfBytes_2: int, actual_Tag: int) returns (Tmp_244: int);
  modifies alloc;



implementation {:origName "ExAllocatePoolWithTag"} {:osmodel} ExAllocatePoolWithTag(actual_PoolType_1: int, actual_NumberOfBytes_2: int, actual_Tag: int) returns (Tmp_244: int)
{
  var {:pointer} sdv_110: int;
  var {:scalar} NumberOfBytes_2: int;

  anon0:
    NumberOfBytes_2 := actual_NumberOfBytes_2;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    call sdv_110 := __HAVOC_malloc(NumberOfBytes_2);
    Tmp_244 := sdv_110;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_244 := 0;
    goto L1;
}



procedure {:origName "IoConnectInterrupt"} {:osmodel} IoConnectInterrupt(actual_InterruptObject_1: int, actual_ServiceRoutine: int, actual_ServiceContext: int, actual_SpinLock_2: int, actual_Vector: int, actual_Irql: int, actual_SynchronizeIrql: int, actual_InterruptMode: int, actual_ShareVector: int, actual_ProcessorEnableMask: int, actual_FloatingSave: int) returns (Tmp_246: int);
  modifies sdv_isr_routine, sdv_pDpcContext;



implementation {:origName "IoConnectInterrupt"} {:osmodel} IoConnectInterrupt(actual_InterruptObject_1: int, actual_ServiceRoutine: int, actual_ServiceContext: int, actual_SpinLock_2: int, actual_Vector: int, actual_Irql: int, actual_SynchronizeIrql: int, actual_InterruptMode: int, actual_ShareVector: int, actual_ProcessorEnableMask: int, actual_FloatingSave: int) returns (Tmp_246: int)
{
  var {:scalar} ServiceRoutine: int;
  var {:pointer} ServiceContext: int;

  anon0:
    ServiceRoutine := actual_ServiceRoutine;
    ServiceContext := actual_ServiceContext;
    sdv_isr_routine := ServiceRoutine;
    sdv_pDpcContext := ServiceContext;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    Tmp_246 := -1073741811;
    goto L1;

  L1:
    return;

  anon5_Then:
    Tmp_246 := -1073741670;
    goto L1;

  anon6_Then:
    Tmp_246 := 0;
    goto L1;
}



procedure {:origName "sdv_stub_driver_init"} {:osmodel} sdv_stub_driver_init();
  modifies alloc;



implementation {:origName "sdv_stub_driver_init"} {:osmodel} sdv_stub_driver_init()
{
  var vslice_dummy_var_67: int;

  anon0:
    call vslice_dummy_var_67 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_IoFreeAdapterChannel"} {:osmodel} sdv_IoFreeAdapterChannel(actual_AdapterObject_3: int);
  modifies alloc;



implementation {:origName "sdv_IoFreeAdapterChannel"} {:osmodel} sdv_IoFreeAdapterChannel(actual_AdapterObject_3: int)
{
  var vslice_dummy_var_68: int;

  anon0:
    call vslice_dummy_var_68 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_stub_dispatch_begin"} {:osmodel} sdv_stub_dispatch_begin();
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;



implementation {:origName "sdv_stub_dispatch_begin"} {:osmodel} sdv_stub_dispatch_begin()
{
  var vslice_dummy_var_69: int;

  anon0:
    call vslice_dummy_var_69 := __HAVOC_malloc(4);
    sdv_irql_previous_5 := sdv_irql_previous_4;
    sdv_irql_previous_4 := sdv_irql_previous_3;
    sdv_irql_previous_3 := sdv_irql_previous_2;
    sdv_irql_previous_2 := sdv_irql_previous;
    sdv_irql_previous := sdv_irql_current;
    sdv_irql_current := 0;
    return;
}



procedure {:origName "IoStartTimer"} {:osmodel} IoStartTimer(actual_DeviceObject_22: int);
  modifies alloc;



implementation {:origName "IoStartTimer"} {:osmodel} IoStartTimer(actual_DeviceObject_22: int)
{
  var vslice_dummy_var_70: int;

  anon0:
    call vslice_dummy_var_70 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "sdv_ObDereferenceObject"} {:osmodel} sdv_ObDereferenceObject(actual_Object_3: int) returns (Tmp_256: int);



implementation {:origName "sdv_ObDereferenceObject"} {:osmodel} sdv_ObDereferenceObject(actual_Object_3: int) returns (Tmp_256: int)
{
  var {:scalar} p_7: int;

  anon0:
    Tmp_256 := p_7;
    return;
}



procedure {:origName "ZwClose"} {:osmodel} ZwClose(actual_Handle_1: int) returns (Tmp_258: int);



implementation {:origName "ZwClose"} {:osmodel} ZwClose(actual_Handle_1: int) returns (Tmp_258: int)
{

  anon0:
    Tmp_258 := 0;
    return;
}



procedure {:origName "sdv_DoNothing"} {:osmodel} sdv_DoNothing() returns (Tmp_260: int);



implementation {:origName "sdv_DoNothing"} {:osmodel} sdv_DoNothing() returns (Tmp_260: int)
{

  anon0:
    Tmp_260 := -1073741823;
    return;
}



procedure {:origName "sdv_IoIsErrorUserInduced"} {:osmodel} sdv_IoIsErrorUserInduced(actual_Status_2: int) returns (Tmp_262: int);



implementation {:origName "sdv_IoIsErrorUserInduced"} {:osmodel} sdv_IoIsErrorUserInduced(actual_Status_2: int) returns (Tmp_262: int)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Else:
    Tmp_262 := 0;
    goto L1;

  L1:
    return;

  anon3_Then:
    Tmp_262 := 1;
    goto L1;
}



procedure {:origName "_sdv_init5"} _sdv_init5();
  modifies yogi_error;



implementation {:origName "_sdv_init5"} _sdv_init5()
{

  anon0:
    yogi_error := 0;
    assume sdv_cancelFptr == 0;
    return;
}



procedure {:origName "SLIC_KeWaitForSingleObject_entry"} {:osmodel} SLIC_KeWaitForSingleObject_entry(actual_caller_2: int, actual_KeWaitForSingleObject_1: int);
  modifies yogi_error;



implementation {:origName "SLIC_KeWaitForSingleObject_entry"} {:osmodel} SLIC_KeWaitForSingleObject_entry(actual_caller_2: int, actual_KeWaitForSingleObject_1: int)
{
  var {:pointer} caller_2: int;
  var {:pointer} KeWaitForSingleObject_1: int;

  anon0:
    caller_2 := actual_caller_2;
    KeWaitForSingleObject_1 := actual_KeWaitForSingleObject_1;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} sdv_irql_current != 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} sdv_irql_current != 1;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} sdv_irql_current == 2;
    goto L10;

  L10:
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} sdv_irql_current == 2;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} KeWaitForSingleObject_1 != 0;
    assume {:nonnull} KeWaitForSingleObject_1 != 0;
    assume KeWaitForSingleObject_1 > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(KeWaitForSingleObject_1)] != 0;
    goto L8;

  L8:
    call SLIC_ABORT_1_1(caller_2, KeWaitForSingleObject_1);
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} yogi_error != 1;
    goto L2;

  L2:
    goto LM2;

  LM2:
    return;

  anon24_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon21_Then:
    assume {:partition} Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(KeWaitForSingleObject_1)] == 0;
    goto L2;

  anon17_Then:
    assume {:partition} KeWaitForSingleObject_1 == 0;
    goto L8;

  anon18_Then:
    assume {:partition} sdv_irql_current != 2;
    goto L2;

  anon20_Then:
    assume {:partition} sdv_irql_current != 2;
    call SLIC_ABORT_1_0(caller_2, KeWaitForSingleObject_1);
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} yogi_error != 1;
    goto L2;

  anon23_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon22_Then:
    assume {:partition} sdv_irql_current == 1;
    goto L10;

  anon19_Then:
    assume {:partition} sdv_irql_current == 0;
    goto L10;
}



procedure {:origName "SLIC_ABORT_1_0"} SLIC_ABORT_1_0(actual_caller_3: int, actual_KeWaitForSingleObject_2: int);
  modifies yogi_error;



implementation {:origName "SLIC_ABORT_1_0"} SLIC_ABORT_1_0(actual_caller_3: int, actual_KeWaitForSingleObject_2: int)
{
  var {:pointer} caller_3: int;
  var {:pointer} KeWaitForSingleObject_2: int;

  anon0:
    caller_3 := actual_caller_3;
    KeWaitForSingleObject_2 := actual_KeWaitForSingleObject_2;
    call SLIC_ERROR_ROUTINE(strConst__li2bpl2);
    return;
}



procedure {:origName "SLIC_ERROR_ROUTINE"} SLIC_ERROR_ROUTINE(actual_msg: int);
  modifies yogi_error;



implementation {:origName "SLIC_ERROR_ROUTINE"} SLIC_ERROR_ROUTINE(actual_msg: int)
{

  anon0:
    yogi_error := 1;
    return;
}



procedure {:origName "SLIC_ABORT_1_1"} SLIC_ABORT_1_1(actual_caller_4: int, actual_KeWaitForSingleObject_3: int);
  modifies yogi_error;



implementation {:origName "SLIC_ABORT_1_1"} SLIC_ABORT_1_1(actual_caller_4: int, actual_KeWaitForSingleObject_3: int)
{
  var {:pointer} caller_4: int;
  var {:pointer} KeWaitForSingleObject_3: int;

  anon0:
    caller_4 := actual_caller_4;
    KeWaitForSingleObject_3 := actual_KeWaitForSingleObject_3;
    call SLIC_ERROR_ROUTINE(strConst__li2bpl3);
    return;
}



procedure {:origName "sdv_InsertTailList"} sdv_InsertTailList(actual_sdv_127: int, actual_sdv_128: int) returns (Tmp_272: int);
  modifies alloc, Mem_T.INT4;



implementation {:origName "sdv_InsertTailList"} sdv_InsertTailList(actual_sdv_127: int, actual_sdv_128: int) returns (Tmp_272: int)
{
  var {:scalar} sdv_129: int;

  anon0:
    call Tmp_272 := __HAVOC_malloc(4);
    call sdv_129 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_272 != 0;
    assume Tmp_272 > 0;
    assume {:nonnull} sdv_129 != 0;
    assume sdv_129 > 0;
    Mem_T.INT4[Tmp_272] := Mem_T.INT4[sdv_129];
    return;
}



procedure {:origName "FatalListEntryError"} FatalListEntryError(actual_p1: int, actual_p2: int, actual_p3: int);
  modifies alloc;



implementation {:origName "FatalListEntryError"} FatalListEntryError(actual_p1: int, actual_p2: int, actual_p3: int)
{
  var vslice_dummy_var_71: int;

  anon0:
    call vslice_dummy_var_71 := __HAVOC_malloc(4);
    call RtlFailFast(3);
    return;
}



procedure {:origName "FcFinishReset"} FcFinishReset(actual_FdoExtension: int) returns (Tmp_280: int);
  modifies alloc, Mem_T.INT4, Mem_T.HardwareFailed__FDC_FDO_EXTENSION;



implementation {:origName "FcFinishReset"} FcFinishReset(actual_FdoExtension: int) returns (Tmp_280: int)
{
  var {:scalar} ntStatus: int;
  var {:scalar} Tmp_282: int;
  var {:dopa} {:scalar} cylinder: int;
  var {:scalar} driveNumber: int;
  var {:dopa} {:scalar} statusRegister0: int;
  var {:pointer} FdoExtension: int;

  anon0:
    call cylinder := __HAVOC_malloc(4);
    call statusRegister0 := __HAVOC_malloc(4);
    FdoExtension := actual_FdoExtension;
    ntStatus := 0;
    driveNumber := 0;
    goto L9;

  L9:
    call ntStatus, Tmp_282, driveNumber := FcFinishReset_loop_L9(ntStatus, Tmp_282, cylinder, driveNumber, statusRegister0, FdoExtension);
    goto L9_last;

  anon11_Else:
    assume {:partition} 4 > driveNumber;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} ntStatus >= 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} driveNumber != 0;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    Tmp_282 := Mem_T.OpCode__COMMAND_TABLE[OpCode__COMMAND_TABLE(CommandTable + 12 * 28)];
    call ntStatus := FcSendByte(Tmp_282, FdoExtension, 1);
    goto L13;

  L13:
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} ntStatus >= 0;
    call ntStatus := FcGetByte(statusRegister0, FdoExtension, 1);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} ntStatus >= 0;
    call ntStatus := FcGetByte(cylinder, FdoExtension, 1);
    goto L19;

  L19:
    driveNumber := driveNumber + 1;
    goto L19_dummy;

  anon15_Then:
    assume {:partition} 0 > ntStatus;
    goto L19;

  anon14_Then:
    assume {:partition} 0 > ntStatus;
    goto L19;

  anon13_Then:
    assume {:partition} driveNumber == 0;
    goto L13;

  anon12_Then:
    assume {:partition} 0 > ntStatus;
    goto L10;

  L10:
    Tmp_280 := ntStatus;
    return;

  anon11_Then:
    assume {:partition} driveNumber >= 4;
    goto L10;

  L19_dummy:
    assume false;
    return;

  L9_last:
    assume {:CounterLoop 4} {:Counter "driveNumber"} true;
    goto anon11_Then, anon11_Else;
}



procedure {:origName "FdcPnp"} FdcPnp(actual_DeviceObject_23: int, actual_Irp_11: int) returns (Tmp_283: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.INT4, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.Type_unnamed_tag_28, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.CompletionRoutine__IO_STACK_LOCATION, Mem_T.Map__IO_PORT_INFO, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.Version__IO_RESOURCE_LIST, Mem_T.Revision__IO_RESOURCE_LIST, Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR, Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR, Mem_T.MinimumVector_unnamed_tag_59, Mem_T.MaximumVector_unnamed_tag_59, Mem_T.AffinityPolicy_unnamed_tag_59, Mem_T.PriorityPolicy_unnamed_tag_59, Mem_T.TargetedProcessors_unnamed_tag_59, Mem_T.MinimumChannel_unnamed_tag_60, Mem_T.MaximumChannel_unnamed_tag_60, Mem_T.RequestLine_unnamed_tag_61, Mem_T.Reserved_unnamed_tag_61, Mem_T.Channel_unnamed_tag_61, Mem_T.TransferWidth_unnamed_tag_61, Mem_T.Data_unnamed_tag_50, Mem_T.MinBusNumber_unnamed_tag_62, Mem_T.MaxBusNumber_unnamed_tag_62, Mem_T.Reserved_unnamed_tag_62, Mem_T.Priority_unnamed_tag_63, Mem_T.Reserved1_unnamed_tag_63, Mem_T.Reserved2_unnamed_tag_63, Mem_T.Length40_unnamed_tag_64, Mem_T.Alignment40_unnamed_tag_64, Mem_T.Length48_unnamed_tag_65, Mem_T.Alignment48_unnamed_tag_65, Mem_T.Length64_unnamed_tag_66, Mem_T.Alignment64_unnamed_tag_66, Mem_T.Class_unnamed_tag_56, Mem_T.Type_unnamed_tag_56, Mem_T.Reserved1_unnamed_tag_56, Mem_T.Reserved2_unnamed_tag_56, Mem_T.IdLowPart_unnamed_tag_56, Mem_T.IdHighPart_unnamed_tag_56, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION, Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION, Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION, Mem_T.Count__DEVICE_RELATIONS, Mem_T.P_DEVICE_OBJECT, Mem_T.Paused__FDC_FDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, FdcDefaultControllerNumber, Mem_T.Removed__FDC_FDO_EXTENSION, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_isr_routine, sdv_pDpcContext, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.SpeedsAvailable__FDC_INFORMATION, Mem_T.ClockRatesSupported__FDC_INFORMATION, Mem_T.FloppyControllerType__FDC_INFORMATION, Mem_T.FdcType__FDC_FDO_EXTENSION, Mem_T.Clock48MHz__FDC_FDO_EXTENSION, Mem_T.FdcSpeeds__FDC_FDO_EXTENSION, Mem_T.MaximumLength__DEVICE_DESCRIPTION, Mem_T.AdapterObject__FDC_FDO_EXTENSION, Mem_T.PINT4, Mem_T.InterruptMode__FDC_FDO_EXTENSION, Mem_T.ControllerVector__FDC_FDO_EXTENSION, Mem_T.ProcessorMask__FDC_FDO_EXTENSION, Mem_T.ControllerIrql__FDC_FDO_EXTENSION, Mem_T.SharableVector__FDC_FDO_EXTENSION, Mem_T.SaveFloatState__FDC_FDO_EXTENSION, Mem_T.BusType__FDC_FDO_EXTENSION, Mem_T.BusNumber__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.NumPDOs__FDC_FDO_EXTENSION, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION, Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION, sdv_io_dpc, Mem_T.DeferredRoutine__KDPC, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, yogi_error, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT, sdv_io_create_device_called;



implementation {:origName "FdcPnp"} FdcPnp(actual_DeviceObject_23: int, actual_Irp_11: int) returns (Tmp_283: int)
{
  var {:scalar} ntStatus_1: int;
  var {:pointer} extensionHeader: int;
  var {:pointer} DeviceObject_23: int;
  var {:pointer} Irp_11: int;
  var vslice_dummy_var_72: int;
  var vslice_dummy_var_73: int;

  anon0:
    DeviceObject_23 := actual_DeviceObject_23;
    Irp_11 := actual_Irp_11;
    ntStatus_1 := 0;
    call vslice_dummy_var_73 := sdv_IoGetCurrentIrpStackLocation(Irp_11);
    assume {:nonnull} DeviceObject_23 != 0;
    assume DeviceObject_23 > 0;
    extensionHeader := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_23)];
    call ExAcquireFastMutex(0);
    PagingReferenceCount := PagingReferenceCount + 1;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} PagingReferenceCount == 1;
    call MmResetDriverPaging(0);
    goto L17;

  L17:
    call ExReleaseFastMutex(0);
    assume {:nonnull} extensionHeader != 0;
    assume extensionHeader > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(extensionHeader)] != 0;
    call ntStatus_1 := FdcFdoPnp(DeviceObject_23, Irp_11);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} yogi_error != 1;
    goto L31;

  L31:
    call ExAcquireFastMutex(0);
    PagingReferenceCount := PagingReferenceCount - 1;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} PagingReferenceCount != 0;
    goto L38;

  L38:
    call ExReleaseFastMutex(0);
    Tmp_283 := ntStatus_1;
    goto LM2;

  LM2:
    return;

  anon12_Then:
    assume {:partition} PagingReferenceCount == 0;
    call vslice_dummy_var_72 := MmPageEntireDriver(0);
    goto L38;

  anon11_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon9_Then:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(extensionHeader)] == 0;
    call ntStatus_1 := FdcPdoPnp(DeviceObject_23, Irp_11);
    goto L31;

  anon10_Then:
    assume {:partition} PagingReferenceCount != 1;
    goto L17;
}



procedure {:origName "FdcQueryDeviceRelations"} FdcQueryDeviceRelations(actual_DeviceObject_24: int, actual_Irp_12: int) returns (Tmp_285: int);
  modifies alloc, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.INT4, Mem_T.PVOID, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.Type_unnamed_tag_28, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION, Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION, Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION, Mem_T.Count__DEVICE_RELATIONS, Mem_T.P_DEVICE_OBJECT, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.CompletionRoutine__IO_STACK_LOCATION, Mem_T.BusNumber__FDC_FDO_EXTENSION, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT, Mem_T.NumPDOs__FDC_FDO_EXTENSION, Mem_T.Length_unnamed_tag_18, sdv_io_create_device_called, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, sdv_isr_routine, sdv_pDpcContext, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, yogi_error;



implementation {:origName "FdcQueryDeviceRelations"} FdcQueryDeviceRelations(actual_DeviceObject_24: int, actual_Irp_12: int) returns (Tmp_285: int)
{
  var {:pointer} Tmp_287: int;
  var {:pointer} pdoExtension: int;
  var {:pointer} relations: int;
  var {:pointer} Tmp_288: int;
  var {:pointer} irpSp_4: int;
  var {:pointer} Tmp_290: int;
  var {:scalar} relationLength: int;
  var {:dopa} {:scalar} returnSize: int;
  var {:pointer} sdv_143: int;
  var {:scalar} Tmp_291: int;
  var {:scalar} ntStatus_2: int;
  var {:scalar} InterfaceType: int;
  var {:scalar} Tmp_292: int;
  var {:pointer} fdoExtension: int;
  var {:pointer} sdv_149: int;
  var {:scalar} Tmp_293: int;
  var {:pointer} returnBuffer: int;
  var {:scalar} relationCount: int;
  var {:pointer} entry: int;
  var {:scalar} Tmp_294: int;
  var {:pointer} DeviceObject_24: int;
  var {:pointer} Irp_12: int;
  var vslice_dummy_var_74: int;

  anon0:
    call returnSize := __HAVOC_malloc(4);
    call returnBuffer := __HAVOC_malloc(4);
    DeviceObject_24 := actual_DeviceObject_24;
    Irp_12 := actual_Irp_12;
    call Tmp_290 := __HAVOC_malloc(4);
    assume {:nonnull} DeviceObject_24 != 0;
    assume DeviceObject_24 > 0;
    fdoExtension := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_24)];
    call irpSp_4 := sdv_IoGetCurrentIrpStackLocation(Irp_12);
    ntStatus_2 := 0;
    assume {:nonnull} irpSp_4 != 0;
    assume irpSp_4 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_4)))] != 0;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_12);
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    call ntStatus_2 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension)], Irp_12);
    Tmp_285 := ntStatus_2;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon56_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_4)))] == 0;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] != 0;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    Tmp_287 := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))];
    assume {:nonnull} Tmp_287 != 0;
    assume Tmp_287 > 0;
    Tmp_293 := Mem_T.Count__DEVICE_RELATIONS[Count__DEVICE_RELATIONS(Tmp_287)];
    goto L31;

  L31:
    relationCount := Tmp_293;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    call ntStatus_2 := DeviceQueryACPI_SyncExecMethod(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension)], -985381281, 0, 0, 0, 0, 2, 20, 0, returnSize, returnBuffer);
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension)] := 0;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} ntStatus_2 >= 0;
    assume {:nonnull} returnSize != 0;
    assume returnSize > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} Mem_T.INT4[returnSize] == 20;
    assume {:nonnull} returnSize != 0;
    assume returnSize > 0;
    call sdv_RtlCopyMemory(0, 0, Mem_T.INT4[returnSize]);
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION[ACPI_BIOS__FDC_FDO_EXTENSION(fdoExtension)] := 1;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension)] := 0;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension)] := 1;
    goto L40;

  L40:
    call sdv_ExFreePool(0);
    goto L49;

  L49:
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION[ACPI_BIOS__FDC_FDO_EXTENSION(fdoExtension)] == 0;
    goto L122;

  L122:
    InterfaceType := 0;
    goto L123;

  L123:
    call ntStatus_2, InterfaceType := FdcQueryDeviceRelations_loop_L123(ntStatus_2, InterfaceType);
    goto L123_last;

  anon53_Else:
    assume {:partition} 18 > InterfaceType;
    call ntStatus_2 := IoQueryDeviceDescription(0, 0, 0, 0, 0, 0, li2bplFunctionConstant217, 0);
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} ntStatus_2 >= 0;
    goto L134;

  L134:
    InterfaceType := InterfaceType + 1;
    goto L134_dummy;

  anon54_Then:
    assume {:partition} 0 > ntStatus_2;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} ntStatus_2 != -1073741772;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := ntStatus_2;
    call sdv_IoCompleteRequest(0, 0);
    Tmp_285 := ntStatus_2;
    goto L1;

  anon55_Then:
    assume {:partition} ntStatus_2 == -1073741772;
    goto L134;

  anon53_Then:
    assume {:partition} InterfaceType >= 18;
    goto L59;

  L59:
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension)] := 0;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} Mem_T.NumPDOs__FDC_FDO_EXTENSION[NumPDOs__FDC_FDO_EXTENSION(fdoExtension)] != 0;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    relationLength := 8 + (relationCount + Mem_T.NumPDOs__FDC_FDO_EXTENSION[NumPDOs__FDC_FDO_EXTENSION(fdoExtension)]) * 4;
    call sdv_149 := ExAllocatePoolWithTag(512, relationLength, -261133242);
    relations := sdv_149;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} relations != 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} relationCount != 0;
    Tmp_294 := relationCount * 4;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    Tmp_288 := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))];
    assume {:nonnull} Tmp_288 != 0;
    assume Tmp_288 > 0;
    call sdv_RtlCopyMemory(0, 0, Tmp_294);
    assume {:nonnull} relations != 0;
    assume relations > 0;
    Mem_T.Count__DEVICE_RELATIONS[Count__DEVICE_RELATIONS(relations)] := relationCount;
    goto L79;

  L79:
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    entry := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(PDOs__FDC_FDO_EXTENSION(fdoExtension))];
    goto L80;

  L80:
    call pdoExtension, Tmp_290, sdv_143, Tmp_291, Tmp_292, relationCount, entry, vslice_dummy_var_74 := FdcQueryDeviceRelations_loop_L80(pdoExtension, relations, Tmp_290, sdv_143, Tmp_291, Tmp_292, relationCount, entry, vslice_dummy_var_74);
    goto L80_last;

  anon52_Else:
    call sdv_143 := sdv_containing_record(entry, 20);
    pdoExtension := sdv_143;
    assume {:nonnull} pdoExtension != 0;
    assume pdoExtension > 0;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(pdoExtension)] != 0;
    goto L88;

  L88:
    assume {:nonnull} entry != 0;
    assume entry > 0;
    entry := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(entry)];
    goto L88_dummy;

  anon62_Then:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(pdoExtension)] == 0;
    Tmp_292 := relationCount;
    relationCount := relationCount + 1;
    Tmp_291 := Tmp_292;
    assume {:nonnull} relations != 0;
    assume relations > 0;
    Tmp_290 := Mem_T.PP_DEVICE_OBJECT[Objects__DEVICE_RELATIONS(relations)];
    assume {:nonnull} Tmp_290 != 0;
    assume Tmp_290 > 0;
    assume {:nonnull} pdoExtension != 0;
    assume pdoExtension > 0;
    Mem_T.P_DEVICE_OBJECT[Tmp_290 + Tmp_291 * 4] := Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(pdoExtension)];
    call vslice_dummy_var_74 := sdv_ObReferenceObject(0);
    goto L88;

  anon52_Then:
    assume {:nonnull} relations != 0;
    assume relations > 0;
    Mem_T.Count__DEVICE_RELATIONS[Count__DEVICE_RELATIONS(relations)] := relationCount;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := 0;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] != 0;
    call sdv_ExFreePool(0);
    goto L94;

  L94:
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := relations;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_12);
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    call ntStatus_2 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension)], Irp_12);
    Tmp_285 := ntStatus_2;
    goto L1;

  anon63_Then:
    assume {:partition} Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] == 0;
    goto L94;

  anon51_Then:
    assume {:partition} relationCount == 0;
    assume {:nonnull} relations != 0;
    assume relations > 0;
    Mem_T.Count__DEVICE_RELATIONS[Count__DEVICE_RELATIONS(relations)] := 0;
    goto L79;

  anon61_Then:
    assume {:partition} relations == 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} relationCount != 0;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_12);
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    call Tmp_285 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension)], Irp_12);
    goto L1;

  anon50_Then:
    assume {:partition} relationCount == 0;
    assume {:nonnull} Irp_12 != 0;
    assume Irp_12 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] := -1073741670;
    call sdv_IoCompleteRequest(0, 0);
    Tmp_285 := -1073741670;
    goto L1;

  anon60_Then:
    assume {:partition} Mem_T.NumPDOs__FDC_FDO_EXTENSION[NumPDOs__FDC_FDO_EXTENSION(fdoExtension)] == 0;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_12);
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    call Tmp_285 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension)], Irp_12);
    goto L1;

  anon46_Then:
    assume {:partition} Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION[ACPI_BIOS__FDC_FDO_EXTENSION(fdoExtension)] != 0;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension)] != 0;
    goto L53;

  L53:
    call ntStatus_2 := FdcEnumerateAcpiBios(DeviceObject_24);
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} yogi_error != 1;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} ntStatus_2 >= 0;
    goto L59;

  anon49_Then:
    assume {:partition} 0 > ntStatus_2;
    Tmp_285 := ntStatus_2;
    goto L1;

  anon59_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon47_Then:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension)] == 0;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension)] == 0;
    goto L122;

  anon48_Then:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension)] != 0;
    goto L53;

  anon45_Then:
    assume {:partition} Mem_T.INT4[returnSize] != 20;
    goto L40;

  anon58_Then:
    assume {:partition} 0 > ntStatus_2;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} ntStatus_2 == -1073741772;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION[ACPI_BIOS__FDC_FDO_EXTENSION(fdoExtension)] := 1;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension)] := 0;
    goto L49;

  anon44_Then:
    assume {:partition} ntStatus_2 != -1073741772;
    assume {:nonnull} fdoExtension != 0;
    assume fdoExtension > 0;
    Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION[ACPI_BIOS__FDC_FDO_EXTENSION(fdoExtension)] := 0;
    goto L49;

  anon57_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon43_Then:
    assume {:partition} Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_12))] == 0;
    Tmp_293 := 0;
    goto L31;

  L134_dummy:
    assume false;
    return;

  L123_last:
    assume {:CounterLoop 18} {:Counter "InterfaceType"} true;
    goto anon53_Then, anon53_Else;

  L88_dummy:
    assume false;
    return;

  L80_last:
    goto anon52_Then, anon52_Else;
}



procedure {:origName "FcGetFdcInformation"} FcGetFdcInformation(actual_FdoExtension_1: int) returns (Tmp_295: int);
  modifies alloc, Mem_T.SpeedsAvailable__FDC_INFORMATION, Mem_T.ClockRatesSupported__FDC_INFORMATION, Mem_T.FloppyControllerType__FDC_INFORMATION, Mem_T.FdcType__FDC_FDO_EXTENSION, Mem_T.Clock48MHz__FDC_FDO_EXTENSION, Mem_T.FdcSpeeds__FDC_FDO_EXTENSION, Mem_T.INT4, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, yogi_error;



implementation {:origName "FcGetFdcInformation"} FcGetFdcInformation(actual_FdoExtension_1: int) returns (Tmp_295: int)
{
  var {:pointer} Tmp_296: int;
  var {:pointer} Tmp_298: int;
  var {:scalar} Tmp_299: int;
  var {:pointer} Tmp_300: int;
  var {:pointer} Tmp_301: int;
  var {:pointer} Tmp_302: int;
  var {:scalar} ntStatus_3: int;
  var {:pointer} Tmp_303: int;
  var {:scalar} Tmp_304: int;
  var {:scalar} fdcInfo: int;
  var {:pointer} Tmp_305: int;
  var {:pointer} Tmp_306: int;
  var {:pointer} Tmp_307: int;
  var {:pointer} FdoExtension_1: int;

  anon0:
    call fdcInfo := __HAVOC_malloc(20);
    FdoExtension_1 := actual_FdoExtension_1;
    call Tmp_296 := __HAVOC_malloc(40);
    call Tmp_298 := __HAVOC_malloc(40);
    call Tmp_300 := __HAVOC_malloc(40);
    call Tmp_301 := __HAVOC_malloc(40);
    call Tmp_302 := __HAVOC_malloc(40);
    call Tmp_303 := __HAVOC_malloc(40);
    call Tmp_305 := __HAVOC_malloc(40);
    call Tmp_306 := __HAVOC_malloc(40);
    call Tmp_307 := __HAVOC_malloc(40);
    assume {:nonnull} fdcInfo != 0;
    assume fdcInfo > 0;
    assume {:nonnull} fdcInfo != 0;
    assume fdcInfo > 0;
    Mem_T.SpeedsAvailable__FDC_INFORMATION[SpeedsAvailable__FDC_INFORMATION(fdcInfo)] := 0;
    assume {:nonnull} fdcInfo != 0;
    assume fdcInfo > 0;
    assume {:nonnull} fdcInfo != 0;
    assume fdcInfo > 0;
    Mem_T.ClockRatesSupported__FDC_INFORMATION[ClockRatesSupported__FDC_INFORMATION(fdcInfo)] := 0;
    assume {:nonnull} fdcInfo != 0;
    assume fdcInfo > 0;
    Mem_T.FloppyControllerType__FDC_INFORMATION[FloppyControllerType__FDC_INFORMATION(fdcInfo)] := 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(FdoExtension_1)] != 0;
    assume {:nonnull} fdcInfo != 0;
    assume fdcInfo > 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    call ntStatus_3 := FcFdcEnabler(Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION[FdcEnablerDeviceObject__FDC_FDO_EXTENSION(FdoExtension_1)], 2031631, fdcInfo);
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} yogi_error != 1;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} ntStatus_3 >= 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    assume {:nonnull} fdcInfo != 0;
    assume fdcInfo > 0;
    Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] := Mem_T.FloppyControllerType__FDC_INFORMATION[FloppyControllerType__FDC_INFORMATION(fdcInfo)];
    assume {:nonnull} fdcInfo != 0;
    assume fdcInfo > 0;
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:partition} Mem_T.ClockRatesSupported__FDC_INFORMATION[ClockRatesSupported__FDC_INFORMATION(fdcInfo)] != 1;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(FdoExtension_1)] := 0;
    goto L115;

  L115:
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    assume {:nonnull} fdcInfo != 0;
    assume fdcInfo > 0;
    Mem_T.FdcSpeeds__FDC_FDO_EXTENSION[FdcSpeeds__FDC_FDO_EXTENSION(FdoExtension_1)] := Mem_T.SpeedsAvailable__FDC_INFORMATION[SpeedsAvailable__FDC_INFORMATION(fdcInfo)];
    goto L18;

  L18:
    Tmp_295 := ntStatus_3;
    goto LM2;

  LM2:
    return;

  anon84_Then:
    assume {:partition} Mem_T.ClockRatesSupported__FDC_INFORMATION[ClockRatesSupported__FDC_INFORMATION(fdcInfo)] == 1;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(FdoExtension_1)] := 1;
    goto L115;

  anon63_Then:
    assume {:partition} 0 > ntStatus_3;
    goto L18;

  anon83_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon82_Then:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(FdoExtension_1)] == 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] := 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Tmp_301 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)];
    assume {:nonnull} Tmp_301 != 0;
    assume Tmp_301 > 0;
    Mem_T.INT4[Tmp_301] := 6;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    call ntStatus_3 := FcIssueCommand(FdoExtension_1, Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)], Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)], 0, 0, 0);
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} yogi_error != 1;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} ntStatus_3 >= 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Tmp_307 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)];
    assume {:nonnull} Tmp_307 != 0;
    assume Tmp_307 > 0;
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} Mem_T.INT4[Tmp_307] == 144;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] := 3;
    goto L28;

  L28:
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 3;
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} ntStatus_3 >= 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Tmp_298 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)];
    assume {:nonnull} Tmp_298 != 0;
    assume Tmp_298 > 0;
    Mem_T.INT4[Tmp_298] := 23;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    call ntStatus_3 := FcIssueCommand(FdoExtension_1, Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)], Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)], 0, 0, 0);
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} yogi_error != 1;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} ntStatus_3 >= 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Tmp_302 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)];
    assume {:nonnull} Tmp_302 != 0;
    assume Tmp_302 > 0;
    Tmp_304 := BAND(Mem_T.INT4[Tmp_302], BOR(BOR(BOR(16, 32), 64), 128));
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} Tmp_304 == 112;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] := 8;
    goto L32;

  L32:
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 3;
    goto anon70_Then, anon70_Else;

  anon70_Else:
    assume {:partition} ntStatus_3 >= 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Tmp_306 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)];
    assume {:nonnull} Tmp_306 != 0;
    assume Tmp_306 > 0;
    Mem_T.INT4[Tmp_306] := 21;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Tmp_300 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)];
    assume {:nonnull} Tmp_300 != 0;
    assume Tmp_300 > 0;
    Mem_T.INT4[Tmp_300 + 1 * 4] := 128;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    call ntStatus_3 := FcIssueCommand(FdoExtension_1, Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)], Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)], 0, 0, 0);
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} yogi_error != 1;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} ntStatus_3 != -1073741661;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] := 4;
    goto L43;

  L43:
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 4;
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} ntStatus_3 >= 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Tmp_296 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)];
    assume {:nonnull} Tmp_296 != 0;
    assume Tmp_296 > 0;
    Mem_T.INT4[Tmp_296] := 23;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    call ntStatus_3 := FcIssueCommand(FdoExtension_1, Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)], Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)], 0, 0, 0);
    goto anon90_Then, anon90_Else;

  anon90_Else:
    assume {:partition} yogi_error != 1;
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} ntStatus_3 >= 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Tmp_303 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)];
    assume {:nonnull} Tmp_303 != 0;
    assume Tmp_303 > 0;
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} BAND(Mem_T.INT4[Tmp_303], 224) != 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Tmp_305 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_1)];
    assume {:nonnull} Tmp_305 != 0;
    assume Tmp_305 > 0;
    Tmp_299 := BAND(Mem_T.INT4[Tmp_305], BOR(BOR(32, 64), 128));
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} Tmp_299 == 64;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] := 6;
    goto L54;

  L54:
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 2;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 3;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 4;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 5;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 6;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 7;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 8;
    goto L68;

  L68:
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcSpeeds__FDC_FDO_EXTENSION[FdcSpeeds__FDC_FDO_EXTENSION(FdoExtension_1)] := 15;
    goto L18;

  anon75_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 8;
    goto L67;

  L67:
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcSpeeds__FDC_FDO_EXTENSION[FdcSpeeds__FDC_FDO_EXTENSION(FdoExtension_1)] := 7;
    goto L18;

  anon76_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 7;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcSpeeds__FDC_FDO_EXTENSION[FdcSpeeds__FDC_FDO_EXTENSION(FdoExtension_1)] := 15;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(FdoExtension_1)] != 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcSpeeds__FDC_FDO_EXTENSION[FdcSpeeds__FDC_FDO_EXTENSION(FdoExtension_1)] := BOR(Mem_T.FdcSpeeds__FDC_FDO_EXTENSION[FdcSpeeds__FDC_FDO_EXTENSION(FdoExtension_1)], 16);
    goto L18;

  anon93_Then:
    assume {:partition} Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(FdoExtension_1)] == 0;
    goto L18;

  anon77_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 6;
    goto L68;

  anon78_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 5;
    goto L68;

  anon79_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 4;
    goto L68;

  anon80_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 3;
    goto L67;

  anon81_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 2;
    goto L67;

  anon72_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] == 0;
    goto L67;

  anon92_Then:
    assume {:partition} Tmp_299 != 64;
    goto L54;

  anon91_Then:
    assume {:partition} BAND(Mem_T.INT4[Tmp_303], 224) == 0;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] := 7;
    goto L54;

  anon74_Then:
    assume {:partition} 0 > ntStatus_3;
    goto L54;

  anon90_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon73_Then:
    assume {:partition} 0 > ntStatus_3;
    goto L54;

  anon69_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 4;
    goto L54;

  anon71_Then:
    assume {:partition} ntStatus_3 == -1073741661;
    ntStatus_3 := 0;
    goto L43;

  anon89_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon70_Then:
    assume {:partition} 0 > ntStatus_3;
    goto L43;

  anon66_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 3;
    goto L43;

  anon88_Then:
    assume {:partition} Tmp_304 != 112;
    goto L32;

  anon68_Then:
    assume {:partition} 0 > ntStatus_3;
    goto L32;

  anon87_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon67_Then:
    assume {:partition} 0 > ntStatus_3;
    goto L32;

  anon65_Then:
    assume {:partition} Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] != 3;
    goto L32;

  anon86_Then:
    assume {:partition} Mem_T.INT4[Tmp_307] != 144;
    assume {:nonnull} FdoExtension_1 != 0;
    assume FdoExtension_1 > 0;
    Mem_T.FdcType__FDC_FDO_EXTENSION[FdcType__FDC_FDO_EXTENSION(FdoExtension_1)] := 2;
    goto L28;

  anon64_Then:
    assume {:partition} 0 > ntStatus_3;
    goto L28;

  anon85_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "FcGetByte"} FcGetByte(actual_ByteToGet: int, actual_FdoExtension_2: int, actual_AllowLongDelay: int) returns (Tmp_308: int);
  modifies Mem_T.INT4, Mem_T.HardwareFailed__FDC_FDO_EXTENSION;



implementation {:origName "FcGetByte"} FcGetByte(actual_ByteToGet: int, actual_FdoExtension_2: int, actual_AllowLongDelay: int) returns (Tmp_308: int)
{
  var {:scalar} i_2: int;
  var {:scalar} Tmp_310: int;
  var {:scalar} byteRead: int;
  var {:scalar} sdv_158: int;
  var {:scalar} Tmp_311: int;
  var {:scalar} sdv_161: int;
  var {:pointer} ByteToGet: int;
  var {:pointer} FdoExtension_2: int;
  var {:scalar} AllowLongDelay: int;
  var boogieTmp: int;
  var vslice_dummy_var_75: int;

  anon0:
    ByteToGet := actual_ByteToGet;
    FdoExtension_2 := actual_FdoExtension_2;
    AllowLongDelay := actual_AllowLongDelay;
    i_2 := 0;
    byteRead := 0;
    goto L7;

  L7:
    call i_2, Tmp_310, byteRead, sdv_158, boogieTmp := FcGetByte_loop_L7(i_2, Tmp_310, byteRead, sdv_158, ByteToGet, boogieTmp);
    goto L7_last;

  anon22_Else:
    assume {:partition} Tmp_310 != 192;
    goto L20;

  L20:
    i_2 := i_2 + 1;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} byteRead != 0;
    goto L23;

  L23:
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} AllowLongDelay != 0;
    i_2 := 0;
    goto L26;

  L26:
    call i_2, byteRead, Tmp_311, sdv_161, boogieTmp, vslice_dummy_var_75 := FcGetByte_loop_L26(i_2, byteRead, Tmp_311, sdv_161, ByteToGet, boogieTmp, vslice_dummy_var_75);
    goto L26_last;

  anon20_Else:
    assume {:partition} byteRead == 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} 5 > i_2;
    call vslice_dummy_var_75 := KeDelayExecutionThread(0, 0, 0);
    i_2 := i_2 + 1;
    call sdv_161 := corral_nondet();
    Tmp_311 := BAND(sdv_161, BOR(64, 128));
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} Tmp_311 == 192;
    assume {:nonnull} ByteToGet != 0;
    assume ByteToGet > 0;
    call boogieTmp := corral_nondet();
    Mem_T.INT4[ByteToGet] := boogieTmp;
    byteRead := 1;
    goto anon24_Else_dummy;

  anon24_Then:
    assume {:partition} Tmp_311 != 192;
    goto anon24_Then_dummy;

  anon21_Then:
    assume {:partition} i_2 >= 5;
    goto L24;

  L24:
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} byteRead != 0;
    Tmp_308 := 0;
    goto L1;

  L1:
    return;

  anon19_Then:
    assume {:partition} byteRead == 0;
    assume {:nonnull} FdoExtension_2 != 0;
    assume FdoExtension_2 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_2)] := 1;
    Tmp_308 := -1073741661;
    goto L1;

  anon20_Then:
    assume {:partition} byteRead != 0;
    goto L24;

  anon18_Then:
    assume {:partition} AllowLongDelay == 0;
    goto L24;

  anon23_Then:
    assume {:partition} byteRead == 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} 500 <= i_2;
    goto L23;

  anon17_Then:
    assume {:partition} i_2 < 500;
    goto anon17_Then_dummy;

  anon22_Then:
    assume {:partition} Tmp_310 == 192;
    assume {:nonnull} ByteToGet != 0;
    assume ByteToGet > 0;
    call boogieTmp := corral_nondet();
    Mem_T.INT4[ByteToGet] := boogieTmp;
    byteRead := 1;
    goto L20;

  anon24_Else_dummy:
    assume false;
    return;

  anon24_Then_dummy:
    assume false;
    return;

  L26_last:
    goto anon20_Then, anon20_Else;

  anon17_Then_dummy:
    assume false;
    return;

  L7_last:
    call sdv_158 := corral_nondet();
    Tmp_310 := BAND(sdv_158, BOR(64, 128));
    goto anon22_Then, anon22_Else;
}



procedure {:origName "FdcPdoInternalDeviceControl"} FdcPdoInternalDeviceControl(actual_DeviceObject_25: int, actual_Irp_13: int) returns (Tmp_312: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK, alloc, Mem_T.INT4, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.BufferSize__FDC_INFO, Mem_T.BufferCount__FDC_INFO, Mem_T.BuffersRequested__FDC_FDO_EXTENSION, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.Virtual__TRANSFER_BUFFER, Mem_T.AcpiBios__FDC_INFO, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.DriveNumber__ACPI_FDI_DATA, Mem_T.DeviceType__ACPI_FDI_DATA, Mem_T.MaxCylinderNumber__ACPI_FDI_DATA, Mem_T.MaxSectorNumber__ACPI_FDI_DATA, Mem_T.MaxHeadNumber__ACPI_FDI_DATA, Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA, Mem_T.HeadLoadTime__ACPI_FDI_DATA, Mem_T.MotorOffTime__ACPI_FDI_DATA, Mem_T.SectorLengthCode__ACPI_FDI_DATA, Mem_T.SectorPerTrack__ACPI_FDI_DATA, Mem_T.ReadWriteGapLength__ACPI_FDI_DATA, Mem_T.DataTransferLength__ACPI_FDI_DATA, Mem_T.FormatGapLength__ACPI_FDI_DATA, Mem_T.FormatFillCharacter__ACPI_FDI_DATA, Mem_T.HeadSettleTime__ACPI_FDI_DATA, Mem_T.MotorSettleTime__ACPI_FDI_DATA, Mem_T.Type_unnamed_tag_28, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CompletionRoutine__IO_STACK_LOCATION, yogi_error;



implementation {:origName "FdcPdoInternalDeviceControl"} FdcPdoInternalDeviceControl(actual_DeviceObject_25: int, actual_Irp_13: int) returns (Tmp_312: int)
{
  var {:pointer} pdoExtension_1: int;
  var {:pointer} irpSp_5: int;
  var {:pointer} Tmp_313: int;
  var {:scalar} ntStatus_4: int;
  var {:pointer} fdoExtension_1: int;
  var {:pointer} Tmp_315: int;
  var {:pointer} Tmp_316: int;
  var {:pointer} DeviceObject_25: int;
  var {:pointer} Irp_13: int;

  anon0:
    DeviceObject_25 := actual_DeviceObject_25;
    Irp_13 := actual_Irp_13;
    assume {:nonnull} DeviceObject_25 != 0;
    assume DeviceObject_25 > 0;
    pdoExtension_1 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_25)];
    assume {:nonnull} pdoExtension_1 != 0;
    assume pdoExtension_1 > 0;
    Tmp_315 := Mem_T.ParentFdo__FDC_PDO_EXTENSION[ParentFdo__FDC_PDO_EXTENSION(pdoExtension_1)];
    assume {:nonnull} Tmp_315 != 0;
    assume Tmp_315 > 0;
    fdoExtension_1 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(Tmp_315)];
    assume {:nonnull} pdoExtension_1 != 0;
    assume pdoExtension_1 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} Mem_T.Removed__FDC_PDO_EXTENSION[Removed__FDC_PDO_EXTENSION(pdoExtension_1)] != 0;
    ntStatus_4 := -1073741738;
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))] := ntStatus_4;
    call sdv_IoCompleteRequest(0, 1);
    Tmp_312 := ntStatus_4;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon14_Then:
    assume {:partition} Mem_T.Removed__FDC_PDO_EXTENSION[Removed__FDC_PDO_EXTENSION(pdoExtension_1)] == 0;
    call irpSp_5 := sdv_IoGetCurrentIrpStackLocation(Irp_13);
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_5)))] != 461835;
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_5)))] == 461891;
    assume {:nonnull} pdoExtension_1 != 0;
    assume pdoExtension_1 > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_1)] != 0;
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    Tmp_313 := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_5)))];
    assume {:nonnull} Tmp_313 != 0;
    assume Tmp_313 > 0;
    Mem_T.INT4[Tmp_313] := 0;
    goto L33;

  L33:
    ntStatus_4 := 0;
    goto L35;

  L35:
    assume {:nonnull} Irp_13 != 0;
    assume Irp_13 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_13))] := ntStatus_4;
    call sdv_IoCompleteRequest(0, 1);
    Tmp_312 := ntStatus_4;
    goto L1;

  anon12_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_1)] == 0;
    assume {:nonnull} irpSp_5 != 0;
    assume irpSp_5 > 0;
    Tmp_316 := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_5)))];
    assume {:nonnull} Tmp_316 != 0;
    assume Tmp_316 > 0;
    Mem_T.INT4[Tmp_316] := 1;
    goto L33;

  anon13_Then:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_5)))] != 461891;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_13);
    assume {:nonnull} pdoExtension_1 != 0;
    assume pdoExtension_1 > 0;
    call Tmp_312 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_PDO_EXTENSION[TargetObject__FDC_PDO_EXTENSION(pdoExtension_1)], Irp_13);
    goto L1;

  anon11_Then:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_5)))] == 461835;
    call FcReportFdcInformation(pdoExtension_1, fdoExtension_1, irpSp_5);
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} yogi_error != 1;
    ntStatus_4 := 0;
    goto L35;

  anon15_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "FcFinishCommand"} FcFinishCommand(actual_FdoExtension_3: int, actual_FifoInBuffer: int, actual_FifoOutBuffer: int, actual_IoHandle: int, actual_IoOffset: int, actual_TransferBytes: int, actual_AllowLongDelay_1: int) returns (Tmp_317: int);
  modifies alloc, Mem_T.INT4, Mem_T.HardwareFailed__FDC_FDO_EXTENSION;



implementation {:origName "FcFinishCommand"} FcFinishCommand(actual_FdoExtension_3: int, actual_FifoInBuffer: int, actual_FifoOutBuffer: int, actual_IoHandle: int, actual_IoOffset: int, actual_TransferBytes: int, actual_AllowLongDelay_1: int) returns (Tmp_317: int)
{
  var {:scalar} i_3: int;
  var {:scalar} Tmp_318: int;
  var {:scalar} Tmp_319: int;
  var {:scalar} Tmp_321: int;
  var {:scalar} Tmp_322: int;
  var {:pointer} Tmp_323: int;
  var {:scalar} Tmp_324: int;
  var {:scalar} Tmp_325: int;
  var {:pointer} sdv_166: int;
  var {:scalar} ntStatus_5: int;
  var {:scalar} Tmp_326: int;
  var {:scalar} Tmp_327: int;
  var {:pointer} sdv_169: int;
  var {:scalar} Command: int;
  var {:scalar} Tmp_328: int;
  var {:pointer} Tmp_329: int;
  var {:scalar} Tmp_330: int;
  var {:scalar} Tmp_333: int;
  var {:pointer} FdoExtension_3: int;
  var {:pointer} FifoInBuffer: int;
  var {:pointer} FifoOutBuffer: int;
  var {:scalar} IoOffset: int;
  var {:scalar} TransferBytes: int;
  var {:scalar} AllowLongDelay_1: int;
  var vslice_dummy_var_76: int;
  var vslice_dummy_var_77: int;

  anon0:
    FdoExtension_3 := actual_FdoExtension_3;
    FifoInBuffer := actual_FifoInBuffer;
    FifoOutBuffer := actual_FifoOutBuffer;
    IoOffset := actual_IoOffset;
    TransferBytes := actual_TransferBytes;
    AllowLongDelay_1 := actual_AllowLongDelay_1;
    call Tmp_329 := __HAVOC_malloc(40);
    ntStatus_5 := 0;
    assume {:nonnull} FifoInBuffer != 0;
    assume FifoInBuffer > 0;
    Command := Mem_T.INT4[FifoInBuffer];
    Tmp_325 := BAND(Command, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_333 := Tmp_325;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} Mem_T.FirstResultByte__COMMAND_TABLE[FirstResultByte__COMMAND_TABLE(CommandTable + Tmp_333 * 28)] > 0;
    assume {:nonnull} FdoExtension_3 != 0;
    assume FdoExtension_3 > 0;
    Tmp_329 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_3)];
    assume {:nonnull} FifoOutBuffer != 0;
    assume FifoOutBuffer > 0;
    assume {:nonnull} Tmp_329 != 0;
    assume Tmp_329 > 0;
    Mem_T.INT4[FifoOutBuffer] := Mem_T.INT4[Tmp_329];
    goto L11;

  L11:
    Tmp_328 := BAND(Command, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_330 := Tmp_328;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    i_3 := Mem_T.FirstResultByte__COMMAND_TABLE[FirstResultByte__COMMAND_TABLE(CommandTable + Tmp_330 * 28)];
    goto L14;

  L14:
    call i_3, Tmp_319, Tmp_321, Tmp_323, ntStatus_5, Tmp_327 := FcFinishCommand_loop_L14(i_3, Tmp_319, Tmp_321, Tmp_323, ntStatus_5, Tmp_327, Command, FdoExtension_3, FifoOutBuffer, AllowLongDelay_1);
    goto L14_last;

  anon13_Else:
    assume {:partition} Mem_T.NumberOfResultBytes__COMMAND_TABLE[NumberOfResultBytes__COMMAND_TABLE(CommandTable + Tmp_327 * 28)] > i_3;
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} ntStatus_5 >= 0;
    Tmp_319 := i_3;
    Tmp_323 := FifoOutBuffer + Tmp_319 * 4;
    call ntStatus_5 := FcGetByte(Tmp_323, FdoExtension_3, AllowLongDelay_1);
    i_3 := i_3 + 1;
    goto anon11_Else_dummy;

  anon11_Then:
    assume {:partition} 0 > ntStatus_5;
    goto L16;

  L16:
    Tmp_326 := BAND(Command, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_324 := Tmp_326;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_324 * 28)] == 1;
    call sdv_166 := sdv_MmGetMdlVirtualAddress(0);
    call vslice_dummy_var_76 := sdv_IoFlushAdapterBuffers(0, 0, 0, 0, TransferBytes, 0);
    goto L33;

  L33:
    Tmp_317 := ntStatus_5;
    return;

  anon14_Then:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_324 * 28)] != 1;
    Tmp_322 := BAND(Command, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_318 := Tmp_322;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_318 * 28)] == 2;
    call sdv_169 := sdv_MmGetMdlVirtualAddress(0);
    call vslice_dummy_var_77 := sdv_IoFlushAdapterBuffers(0, 0, 0, 0, TransferBytes, 1);
    goto L33;

  anon15_Then:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_318 * 28)] != 2;
    goto L33;

  anon13_Then:
    assume {:partition} i_3 >= Mem_T.NumberOfResultBytes__COMMAND_TABLE[NumberOfResultBytes__COMMAND_TABLE(CommandTable + Tmp_327 * 28)];
    goto L16;

  anon12_Then:
    assume {:partition} 0 >= Mem_T.FirstResultByte__COMMAND_TABLE[FirstResultByte__COMMAND_TABLE(CommandTable + Tmp_333 * 28)];
    goto L11;

  anon11_Else_dummy:
    assume false;
    return;

  L14_last:
    Tmp_321 := BAND(Command, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_327 := Tmp_321;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon13_Then, anon13_Else;
}



procedure {:origName "FcSendByte"} FcSendByte(actual_ByteToSend: int, actual_FdoExtension_4: int, actual_AllowLongDelay_2: int) returns (Tmp_334: int);
  modifies Mem_T.HardwareFailed__FDC_FDO_EXTENSION;



implementation {:origName "FcSendByte"} FcSendByte(actual_ByteToSend: int, actual_FdoExtension_4: int, actual_AllowLongDelay_2: int) returns (Tmp_334: int)
{
  var {:scalar} i_4: int;
  var {:scalar} sdv_170: int;
  var {:scalar} Tmp_335: int;
  var {:scalar} Tmp_336: int;
  var {:scalar} sdv_172: int;
  var {:scalar} byteWritten: int;
  var {:pointer} FdoExtension_4: int;
  var {:scalar} AllowLongDelay_2: int;
  var vslice_dummy_var_78: int;

  anon0:
    FdoExtension_4 := actual_FdoExtension_4;
    AllowLongDelay_2 := actual_AllowLongDelay_2;
    i_4 := 0;
    byteWritten := 0;
    assume {:nonnull} FdoExtension_4 != 0;
    assume FdoExtension_4 > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_4)] != 0;
    Tmp_334 := -1073741661;
    goto L1;

  L1:
    return;

  anon24_Then:
    assume {:partition} Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_4)] == 0;
    goto L8;

  L8:
    call i_4, sdv_170, Tmp_336, byteWritten := FcSendByte_loop_L8(i_4, sdv_170, Tmp_336, byteWritten);
    goto L8_last;

  anon25_Else:
    assume {:partition} Tmp_336 != 128;
    goto L21;

  L21:
    i_4 := i_4 + 1;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} byteWritten != 0;
    goto L24;

  L24:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} AllowLongDelay_2 != 0;
    i_4 := 0;
    goto L27;

  L27:
    call i_4, Tmp_335, sdv_172, byteWritten, vslice_dummy_var_78 := FcSendByte_loop_L27(i_4, Tmp_335, sdv_172, byteWritten, vslice_dummy_var_78);
    goto L27_last;

  anon22_Else:
    assume {:partition} byteWritten == 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} 5 > i_4;
    call vslice_dummy_var_78 := KeDelayExecutionThread(0, 0, 0);
    i_4 := i_4 + 1;
    call sdv_172 := corral_nondet();
    Tmp_335 := BAND(sdv_172, BOR(64, 128));
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} Tmp_335 == 128;
    byteWritten := 1;
    goto anon27_Else_dummy;

  anon27_Then:
    assume {:partition} Tmp_335 != 128;
    goto anon27_Then_dummy;

  anon23_Then:
    assume {:partition} i_4 >= 5;
    goto L25;

  L25:
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} byteWritten != 0;
    Tmp_334 := 0;
    goto L1;

  anon21_Then:
    assume {:partition} byteWritten == 0;
    assume {:nonnull} FdoExtension_4 != 0;
    assume FdoExtension_4 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_4)] := 1;
    Tmp_334 := -1073741661;
    goto L1;

  anon22_Then:
    assume {:partition} byteWritten != 0;
    goto L25;

  anon20_Then:
    assume {:partition} AllowLongDelay_2 == 0;
    goto L25;

  anon26_Then:
    assume {:partition} byteWritten == 0;
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} 500 <= i_4;
    goto L24;

  anon19_Then:
    assume {:partition} i_4 < 500;
    goto anon19_Then_dummy;

  anon25_Then:
    assume {:partition} Tmp_336 == 128;
    byteWritten := 1;
    goto L21;

  anon27_Else_dummy:
    assume false;
    return;

  anon27_Then_dummy:
    assume false;
    return;

  L27_last:
    goto anon22_Then, anon22_Else;

  anon19_Then_dummy:
    assume false;
    return;

  L8_last:
    call sdv_170 := corral_nondet();
    Tmp_336 := BAND(sdv_170, BOR(64, 128));
    goto anon25_Then, anon25_Else;
}



procedure {:origName "FdcFilterResourceRequirements"} FdcFilterResourceRequirements(actual_DeviceObject_26: int, actual_Irp_14: int) returns (Tmp_338: int);
  modifies alloc, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.CompletionRoutine__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Map__IO_PORT_INFO, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.INT4, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.Version__IO_RESOURCE_LIST, Mem_T.Revision__IO_RESOURCE_LIST, Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR, Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR, Mem_T.MinimumVector_unnamed_tag_59, Mem_T.MaximumVector_unnamed_tag_59, Mem_T.AffinityPolicy_unnamed_tag_59, Mem_T.PriorityPolicy_unnamed_tag_59, Mem_T.TargetedProcessors_unnamed_tag_59, Mem_T.MinimumChannel_unnamed_tag_60, Mem_T.MaximumChannel_unnamed_tag_60, Mem_T.RequestLine_unnamed_tag_61, Mem_T.Reserved_unnamed_tag_61, Mem_T.Channel_unnamed_tag_61, Mem_T.TransferWidth_unnamed_tag_61, Mem_T.Data_unnamed_tag_50, Mem_T.MinBusNumber_unnamed_tag_62, Mem_T.MaxBusNumber_unnamed_tag_62, Mem_T.Reserved_unnamed_tag_62, Mem_T.Priority_unnamed_tag_63, Mem_T.Reserved1_unnamed_tag_63, Mem_T.Reserved2_unnamed_tag_63, Mem_T.Length40_unnamed_tag_64, Mem_T.Alignment40_unnamed_tag_64, Mem_T.Length48_unnamed_tag_65, Mem_T.Alignment48_unnamed_tag_65, Mem_T.Length64_unnamed_tag_66, Mem_T.Alignment64_unnamed_tag_66, Mem_T.Class_unnamed_tag_56, Mem_T.Type_unnamed_tag_56, Mem_T.Reserved1_unnamed_tag_56, Mem_T.Reserved2_unnamed_tag_56, Mem_T.IdLowPart_unnamed_tag_56, Mem_T.IdHighPart_unnamed_tag_56, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.Blink__LIST_ENTRY, Mem_T.Flink__LIST_ENTRY, yogi_error;



implementation {:origName "FdcFilterResourceRequirements"} FdcFilterResourceRequirements(actual_DeviceObject_26: int, actual_Irp_14: int) returns (Tmp_338: int)
{
  var {:scalar} i_5: int;
  var {:scalar} requestTapeModeRegister: int;
  var {:scalar} Tmp_339: int;
  var {:pointer} Tmp_340: int;
  var {:scalar} newPortMask: int;
  var {:scalar} Tmp_341: int;
  var {:pointer} Tmp_342: int;
  var {:scalar} Tmp_343: int;
  var {:pointer} resourceRequirementsIn: int;
  var {:scalar} Tmp_344: int;
  var {:pointer} ioResourceDescriptorIn: int;
  var {:pointer} sdv_174: int;
  var {:pointer} ioResourceListOut: int;
  var {:scalar} in: int;
  var {:scalar} dmaResource: int;
  var {:pointer} irpSp_6: int;
  var {:scalar} interruptResource: int;
  var {:scalar} foundBase: int;
  var {:scalar} j: int;
  var {:pointer} Tmp_345: int;
  var {:scalar} Tmp_346: int;
  var {:pointer} Tmp_348: int;
  var {:scalar} sdv_176: int;
  var {:scalar} doneEvent: int;
  var {:pointer} ioResourceListIn: int;
  var {:scalar} sdv_177: int;
  var {:pointer} sdv_178: int;
  var {:scalar} ntStatus_6: int;
  var {:pointer} sdv_180: int;
  var {:pointer} Tmp_349: int;
  var {:scalar} Tmp_350: int;
  var {:pointer} Tmp_351: int;
  var {:pointer} fdoExtension_2: int;
  var {:pointer} Tmp_352: int;
  var {:pointer} links: int;
  var {:pointer} sdv_182: int;
  var {:pointer} sdv_183: int;
  var {:scalar} listSize: int;
  var {:pointer} resourceRequirementsOut: int;
  var {:scalar} ioPortList: int;
  var {:pointer} sdv_185: int;
  var {:scalar} Tmp_353: int;
  var {:pointer} ioPortInfo: int;
  var {:scalar} out: int;
  var {:scalar} sdv_186: int;
  var {:scalar} newDescriptors: int;
  var {:pointer} Tmp_355: int;
  var {:scalar} Tmp_356: int;
  var {:pointer} ioResourceDescriptorOut: int;
  var {:pointer} Tmp_357: int;
  var {:pointer} Tmp_358: int;
  var {:pointer} sdv_187: int;
  var {:pointer} DeviceObject_26: int;
  var {:pointer} Irp_14: int;
  var boogieTmp: int;
  var vslice_dummy_var_79: int;
  var vslice_dummy_var_80: int;

  anon0:
    call doneEvent := __HAVOC_malloc(156);
    call ioPortList := __HAVOC_malloc(8);
    DeviceObject_26 := actual_DeviceObject_26;
    Irp_14 := actual_Irp_14;
    call Tmp_340 := __HAVOC_malloc(12);
    call Tmp_342 := __HAVOC_malloc(420);
    call Tmp_345 := __HAVOC_malloc(12);
    call Tmp_348 := __HAVOC_malloc(12);
    call Tmp_349 := __HAVOC_malloc(12);
    call Tmp_351 := __HAVOC_malloc(420);
    call Tmp_352 := __HAVOC_malloc(12);
    call Tmp_355 := __HAVOC_malloc(420);
    call Tmp_357 := __HAVOC_malloc(12);
    call Tmp_358 := __HAVOC_malloc(420);
    interruptResource := 0;
    dmaResource := 0;
    requestTapeModeRegister := 0;
    assume {:nonnull} DeviceObject_26 != 0;
    assume DeviceObject_26 > 0;
    fdoExtension_2 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_26)];
    call irpSp_6 := sdv_IoGetCurrentIrpStackLocation(Irp_14);
    ntStatus_6 := 0;
    call InitializeListHead(ioPortList);
    call KeInitializeEvent(doneEvent, 0, 0);
    call sdv_IoCopyCurrentIrpStackLocationToNext(Irp_14);
    call sdv_IoSetCompletionRoutine(Irp_14, li2bplFunctionConstant201, doneEvent, 1, 1, 1);
    assume {:nonnull} fdoExtension_2 != 0;
    assume fdoExtension_2 > 0;
    call ntStatus_6 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_2)], Irp_14);
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} ntStatus_6 == 259;
    call vslice_dummy_var_79 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume {:partition} yogi_error != 1;
    goto L53;

  L53:
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_14))] != 0;
    goto L58;

  L58:
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    resourceRequirementsIn := Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_14))];
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    ioResourceListIn := Mem_T.List__IO_RESOURCE_REQUIREMENTS_LIST[List__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    ioResourceDescriptorIn := Mem_T.Descriptors__IO_RESOURCE_LIST[Descriptors__IO_RESOURCE_LIST(ioResourceListIn)];
    ntStatus_6 := 0;
    i_5 := 0;
    goto L63;

  L63:
    call i_5, Tmp_341, dmaResource, interruptResource, foundBase, j, ntStatus_6, links, sdv_182, sdv_183, ioPortInfo, boogieTmp, vslice_dummy_var_80 := FdcFilterResourceRequirements_loop_L63(i_5, Tmp_341, ioResourceDescriptorIn, dmaResource, interruptResource, foundBase, j, ioResourceListIn, ntStatus_6, links, sdv_182, sdv_183, ioPortList, ioPortInfo, boogieTmp, vslice_dummy_var_80);
    goto L63_last;

  anon77_Else:
    assume {:partition} Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListIn)] > i_5;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} ntStatus_6 >= 0;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)] != 1;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)] != 2;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    goto anon100_Then, anon100_Else;

  anon100_Else:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)] != 4;
    goto L72;

  L72:
    i_5 := i_5 + 1;
    goto L72_dummy;

  anon100_Then:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)] == 4;
    dmaResource := 1;
    goto L72;

  anon101_Then:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)] == 2;
    interruptResource := 1;
    goto L72;

  anon80_Then:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)] == 1;
    foundBase := 0;
    assume {:nonnull} ioPortList != 0;
    assume ioPortList > 0;
    links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(ioPortList)];
    goto L76;

  L76:
    call Tmp_341, links, sdv_183, ioPortInfo := FdcFilterResourceRequirements_loop_L76(Tmp_341, ioResourceDescriptorIn, links, sdv_183, ioPortInfo);
    goto L76_last;

  anon81_Else:
    call sdv_183 := sdv_containing_record(links, 12);
    ioPortInfo := sdv_183;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    Tmp_341 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn))))], BNOT(BOR(BOR(1, 2), 4)));
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    goto anon103_Then, anon103_Else;

  anon103_Else:
    assume {:partition} Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(ioPortInfo))] == Tmp_341;
    foundBase := 1;
    j := 0;
    goto L87;

  L87:
    call j, boogieTmp := FdcFilterResourceRequirements_loop_L87(ioResourceDescriptorIn, j, ioPortInfo, boogieTmp);
    goto L87_last;

  anon83_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)))] > j;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    call boogieTmp := corral_nondet();
    Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(ioPortInfo)] := boogieTmp;
    j := j + 1;
    goto anon83_Else_dummy;

  anon83_Then:
    assume {:partition} j >= Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)))];
    goto L77;

  L77:
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:partition} foundBase == 0;
    call sdv_182 := ExAllocatePoolWithTag(257, 24, -261133242);
    ioPortInfo := sdv_182;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume {:partition} ioPortInfo != 0;
    call sdv_RtlZeroMemory(0, 24);
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(ioPortInfo))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn))))];
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(BaseAddress__IO_PORT_INFO(ioPortInfo))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn))))];
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(BaseAddress__IO_PORT_INFO(ioPortInfo)))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)))))];
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(BaseAddress__IO_PORT_INFO(ioPortInfo)))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)))))];
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(BaseAddress__IO_PORT_INFO(ioPortInfo))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn))))];
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(ioPortInfo))] := BAND(Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(ioPortInfo))], BNOT(BOR(BOR(1, 2), 4)));
    j := 0;
    goto L105;

  L105:
    call j, boogieTmp := FdcFilterResourceRequirements_loop_L105(ioResourceDescriptorIn, j, ioPortInfo, boogieTmp);
    goto L105_last;

  anon84_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)))] > j;
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    call boogieTmp := corral_nondet();
    Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(ioPortInfo)] := boogieTmp;
    j := j + 1;
    goto anon84_Else_dummy;

  anon84_Then:
    assume {:partition} j >= Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorIn)))];
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    call vslice_dummy_var_80 := sdv_InsertTailList(ioPortList, ListEntry__IO_PORT_INFO(ioPortInfo));
    goto L72;

  anon104_Then:
    assume {:partition} ioPortInfo == 0;
    ntStatus_6 := -1073741670;
    goto L72;

  anon82_Then:
    assume {:partition} foundBase != 0;
    goto L72;

  anon103_Then:
    assume {:partition} Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(ioPortInfo))] != Tmp_341;
    assume {:nonnull} links != 0;
    assume links > 0;
    links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(links)];
    goto anon103_Then_dummy;

  anon81_Then:
    goto L77;

  anon79_Then:
    assume {:partition} 0 > ntStatus_6;
    goto L64;

  L64:
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} ntStatus_6 >= 0;
    call sdv_186 := sdv_IsListEmpty(0);
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} sdv_186 == 0;
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} interruptResource != 0;
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} dmaResource != 0;
    newDescriptors := 0;
    assume {:nonnull} ioPortList != 0;
    assume ioPortList > 0;
    links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(ioPortList)];
    goto L123;

  L123:
    call requestTapeModeRegister, newPortMask, sdv_178, links, ioPortInfo, newDescriptors := FdcFilterResourceRequirements_loop_L123(requestTapeModeRegister, newPortMask, sdv_178, links, ioPortInfo, newDescriptors);
    goto L123_last;

  anon88_Else:
    call sdv_178 := sdv_containing_record(links, 12);
    ioPortInfo := sdv_178;
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    newPortMask := BAND(BNOT(Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(ioPortInfo)]), BOR(BOR(BOR(BOR(4, 8), 16), 32), 128));
    goto anon105_Then, anon105_Else;

  anon105_Else:
    assume {:partition} BAND(newPortMask, 8) != 0;
    requestTapeModeRegister := 1;
    goto L131;

  L131:
    call newPortMask, newDescriptors := FdcFilterResourceRequirements_loop_L131(newPortMask, newDescriptors);
    goto L131_last;

  anon90_Else:
    assume {:partition} newPortMask > 0;
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} BAND(newPortMask, 1) != 0;
    newDescriptors := newDescriptors + 1;
    goto L135;

  L135:
    call newPortMask := corral_nondet();
    goto L135_dummy;

  anon91_Then:
    assume {:partition} BAND(newPortMask, 1) == 0;
    goto L135;

  anon90_Then:
    assume {:partition} 0 >= newPortMask;
    assume {:nonnull} links != 0;
    assume links > 0;
    links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(links)];
    goto anon90_Then_dummy;

  anon105_Then:
    assume {:partition} BAND(newPortMask, 8) == 0;
    goto L131;

  anon88_Then:
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} newDescriptors > 0;
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    listSize := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)] + Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)] + newDescriptors * 32;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:partition} requestTapeModeRegister != 0;
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    listSize := listSize + Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)] + newDescriptors * 32;
    goto L142;

  L142:
    call sdv_187 := ExAllocatePoolWithTag(512, listSize, -261133242);
    resourceRequirementsOut := sdv_187;
    goto anon107_Then, anon107_Else;

  anon107_Else:
    assume {:partition} resourceRequirementsOut != 0;
    call sdv_RtlZeroMemory(0, listSize);
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := 32;
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST[InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST[InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST[BusNumber__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST[BusNumber__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST[SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST[SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Tmp_348 := Mem_T.Reserved__IO_RESOURCE_REQUIREMENTS_LIST[Reserved__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)];
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    Tmp_352 := Mem_T.Reserved__IO_RESOURCE_REQUIREMENTS_LIST[Reserved__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} Tmp_348 != 0;
    assume Tmp_348 > 0;
    assume {:nonnull} Tmp_352 != 0;
    assume Tmp_352 > 0;
    Mem_T.INT4[Tmp_348] := Mem_T.INT4[Tmp_352];
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Tmp_345 := Mem_T.Reserved__IO_RESOURCE_REQUIREMENTS_LIST[Reserved__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)];
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    Tmp_357 := Mem_T.Reserved__IO_RESOURCE_REQUIREMENTS_LIST[Reserved__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} Tmp_345 != 0;
    assume Tmp_345 > 0;
    assume {:nonnull} Tmp_357 != 0;
    assume Tmp_357 > 0;
    Mem_T.INT4[Tmp_345 + 1 * 4] := Mem_T.INT4[Tmp_357 + 1 * 4];
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Tmp_340 := Mem_T.Reserved__IO_RESOURCE_REQUIREMENTS_LIST[Reserved__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)];
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    Tmp_349 := Mem_T.Reserved__IO_RESOURCE_REQUIREMENTS_LIST[Reserved__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} Tmp_340 != 0;
    assume Tmp_340 > 0;
    assume {:nonnull} Tmp_349 != 0;
    assume Tmp_349 > 0;
    Mem_T.INT4[Tmp_340 + 2 * 4] := Mem_T.INT4[Tmp_349 + 2 * 4];
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST[AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST[AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)] + 1;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:partition} requestTapeModeRegister != 0;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST[AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST[AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] + 1;
    goto L161;

  L161:
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    ioResourceListIn := Mem_T.List__IO_RESOURCE_REQUIREMENTS_LIST[List__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    ioResourceListOut := Mem_T.List__IO_RESOURCE_REQUIREMENTS_LIST[List__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)];
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    listSize := 40 + (Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListIn)] - 1) * 32;
    call sdv_RtlCopyMemory(0, 0, listSize);
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] + listSize;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    ioResourceDescriptorOut := resourceRequirementsOut + Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)];
    assume {:nonnull} ioPortList != 0;
    assume ioPortList > 0;
    links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(ioPortList)];
    goto L171;

  L171:
    call i_5, newPortMask, sdv_180, links, ioPortInfo := FdcFilterResourceRequirements_loop_L171(i_5, newPortMask, ioResourceListOut, sdv_180, links, resourceRequirementsOut, ioPortInfo, ioResourceDescriptorOut);
    goto L171_last;

  anon92_Else:
    call sdv_180 := sdv_containing_record(links, 12);
    ioPortInfo := sdv_180;
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    newPortMask := BAND(BNOT(Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(ioPortInfo)]), BOR(BOR(BOR(BOR(4, 8), 16), 32), 128));
    i_5 := 0;
    goto L179;

  L179:
    call i_5, newPortMask := FdcFilterResourceRequirements_loop_L179(i_5, newPortMask, ioResourceListOut, resourceRequirementsOut, ioPortInfo, ioResourceDescriptorOut);
    goto L179_last;

  anon94_Else:
    assume {:partition} newPortMask != 0;
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} BAND(newPortMask, 1) != 0;
    assume {:nonnull} ioResourceDescriptorOut != 0;
    assume ioResourceDescriptorOut > 0;
    Mem_T.Option__IO_RESOURCE_DESCRIPTOR[Option__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorOut)] := 1;
    assume {:nonnull} ioResourceDescriptorOut != 0;
    assume ioResourceDescriptorOut > 0;
    Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorOut)] := 1;
    assume {:nonnull} ioResourceDescriptorOut != 0;
    assume ioResourceDescriptorOut > 0;
    Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR[ShareDisposition__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorOut)] := 1;
    assume {:nonnull} ioResourceDescriptorOut != 0;
    assume ioResourceDescriptorOut > 0;
    Mem_T.Flags__IO_RESOURCE_DESCRIPTOR[Flags__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorOut)] := 1;
    assume {:nonnull} ioResourceDescriptorOut != 0;
    assume ioResourceDescriptorOut > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorOut)))] := 1;
    assume {:nonnull} ioResourceDescriptorOut != 0;
    assume ioResourceDescriptorOut > 0;
    Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorOut)))] := 1;
    assume {:nonnull} ioPortInfo != 0;
    assume ioPortInfo > 0;
    assume {:nonnull} ioResourceDescriptorOut != 0;
    assume ioResourceDescriptorOut > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorOut))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(BaseAddress__IO_PORT_INFO(ioPortInfo))] + i_5;
    assume {:nonnull} ioResourceDescriptorOut != 0;
    assume ioResourceDescriptorOut > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorOut))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(ioResourceDescriptorOut))))];
    assume {:nonnull} ioResourceListOut != 0;
    assume ioResourceListOut > 0;
    Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListOut)] := Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListOut)] + 1;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] + 32;
    goto L182;

  L182:
    call newPortMask := corral_nondet();
    i_5 := i_5 + 1;
    goto L182_dummy;

  anon95_Then:
    assume {:partition} BAND(newPortMask, 1) == 0;
    goto L182;

  anon94_Then:
    assume {:partition} newPortMask == 0;
    assume {:nonnull} links != 0;
    assume links > 0;
    links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(links)];
    goto anon94_Then_dummy;

  anon92_Then:
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} requestTapeModeRegister != 0;
    ioResourceListIn := ioResourceListOut;
    ioResourceListOut := ioResourceDescriptorOut;
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    assume {:nonnull} ioResourceListOut != 0;
    assume ioResourceListOut > 0;
    Mem_T.Version__IO_RESOURCE_LIST[Version__IO_RESOURCE_LIST(ioResourceListOut)] := Mem_T.Version__IO_RESOURCE_LIST[Version__IO_RESOURCE_LIST(ioResourceListIn)];
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    assume {:nonnull} ioResourceListOut != 0;
    assume ioResourceListOut > 0;
    Mem_T.Revision__IO_RESOURCE_LIST[Revision__IO_RESOURCE_LIST(ioResourceListOut)] := Mem_T.Revision__IO_RESOURCE_LIST[Revision__IO_RESOURCE_LIST(ioResourceListIn)];
    assume {:nonnull} ioResourceListOut != 0;
    assume ioResourceListOut > 0;
    Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListOut)] := 0;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] + 8;
    out := 0;
    in := out;
    goto L204;

  L204:
    call Tmp_339, Tmp_342, Tmp_343, Tmp_344, in, Tmp_346, Tmp_350, Tmp_351, Tmp_353, out, Tmp_355, Tmp_356, Tmp_358 := FdcFilterResourceRequirements_loop_L204(Tmp_339, Tmp_342, Tmp_343, Tmp_344, ioResourceListOut, in, Tmp_346, ioResourceListIn, Tmp_350, Tmp_351, resourceRequirementsOut, Tmp_353, out, Tmp_355, Tmp_356, Tmp_358);
    goto L204_last;

  anon109_Else:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(Tmp_355 + Tmp_350 * 420)] != 1;
    goto L206;

  L206:
    Tmp_343 := out;
    out := out + 1;
    Tmp_339 := Tmp_343;
    assume {:nonnull} ioResourceListOut != 0;
    assume ioResourceListOut > 0;
    Tmp_351 := Mem_T.Descriptors__IO_RESOURCE_LIST[Descriptors__IO_RESOURCE_LIST(ioResourceListOut)];
    Tmp_344 := in;
    in := in + 1;
    Tmp_346 := Tmp_344;
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    Tmp_358 := Mem_T.Descriptors__IO_RESOURCE_LIST[Descriptors__IO_RESOURCE_LIST(ioResourceListIn)];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Option__IO_RESOURCE_DESCRIPTOR[Option__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)] := Mem_T.Option__IO_RESOURCE_DESCRIPTOR[Option__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)] := Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR[ShareDisposition__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)] := Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR[ShareDisposition__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR[Spare1__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)] := Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR[Spare1__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Flags__IO_RESOURCE_DESCRIPTOR[Flags__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)] := Mem_T.Flags__IO_RESOURCE_DESCRIPTOR[Flags__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR[Spare2__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)] := Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR[Spare2__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.MinimumVector_unnamed_tag_59[MinimumVector_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.MinimumVector_unnamed_tag_59[MinimumVector_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.MaximumVector_unnamed_tag_59[MaximumVector_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.MaximumVector_unnamed_tag_59[MaximumVector_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.AffinityPolicy_unnamed_tag_59[AffinityPolicy_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.AffinityPolicy_unnamed_tag_59[AffinityPolicy_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.PriorityPolicy_unnamed_tag_59[PriorityPolicy_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.PriorityPolicy_unnamed_tag_59[PriorityPolicy_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.TargetedProcessors_unnamed_tag_59[TargetedProcessors_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.TargetedProcessors_unnamed_tag_59[TargetedProcessors_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.MinimumChannel_unnamed_tag_60[MinimumChannel_unnamed_tag_60(Dma_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.MinimumChannel_unnamed_tag_60[MinimumChannel_unnamed_tag_60(Dma_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.MaximumChannel_unnamed_tag_60[MaximumChannel_unnamed_tag_60(Dma_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.MaximumChannel_unnamed_tag_60[MaximumChannel_unnamed_tag_60(Dma_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.RequestLine_unnamed_tag_61[RequestLine_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.RequestLine_unnamed_tag_61[RequestLine_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Reserved_unnamed_tag_61[Reserved_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Reserved_unnamed_tag_61[Reserved_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Channel_unnamed_tag_61[Channel_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Channel_unnamed_tag_61[Channel_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.TransferWidth_unnamed_tag_61[TransferWidth_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.TransferWidth_unnamed_tag_61[TransferWidth_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Data_unnamed_tag_50[Data_unnamed_tag_50(DevicePrivate_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Data_unnamed_tag_50[Data_unnamed_tag_50(DevicePrivate_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.MinBusNumber_unnamed_tag_62[MinBusNumber_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.MinBusNumber_unnamed_tag_62[MinBusNumber_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.MaxBusNumber_unnamed_tag_62[MaxBusNumber_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.MaxBusNumber_unnamed_tag_62[MaxBusNumber_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Reserved_unnamed_tag_62[Reserved_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Reserved_unnamed_tag_62[Reserved_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Priority_unnamed_tag_63[Priority_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Priority_unnamed_tag_63[Priority_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Reserved1_unnamed_tag_63[Reserved1_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Reserved1_unnamed_tag_63[Reserved1_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Reserved2_unnamed_tag_63[Reserved2_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Reserved2_unnamed_tag_63[Reserved2_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Length40_unnamed_tag_64[Length40_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Length40_unnamed_tag_64[Length40_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Alignment40_unnamed_tag_64[Alignment40_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Alignment40_unnamed_tag_64[Alignment40_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Length48_unnamed_tag_65[Length48_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Length48_unnamed_tag_65[Length48_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Alignment48_unnamed_tag_65[Alignment48_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Alignment48_unnamed_tag_65[Alignment48_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Length64_unnamed_tag_66[Length64_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Length64_unnamed_tag_66[Length64_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Alignment64_unnamed_tag_66[Alignment64_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Alignment64_unnamed_tag_66[Alignment64_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420))))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Class_unnamed_tag_56[Class_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Class_unnamed_tag_56[Class_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Type_unnamed_tag_56[Type_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Type_unnamed_tag_56[Type_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Reserved1_unnamed_tag_56[Reserved1_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Reserved1_unnamed_tag_56[Reserved1_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.Reserved2_unnamed_tag_56[Reserved2_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.Reserved2_unnamed_tag_56[Reserved2_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.IdLowPart_unnamed_tag_56[IdLowPart_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.IdLowPart_unnamed_tag_56[IdLowPart_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} Tmp_351 != 0;
    assume Tmp_351 > 0;
    assume {:nonnull} Tmp_358 != 0;
    assume Tmp_358 > 0;
    Mem_T.IdHighPart_unnamed_tag_56[IdHighPart_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_351 + Tmp_339 * 420)))] := Mem_T.IdHighPart_unnamed_tag_56[IdHighPart_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_358 + Tmp_346 * 420)))];
    assume {:nonnull} ioResourceListOut != 0;
    assume ioResourceListOut > 0;
    Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListOut)] := Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListOut)] + 1;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] + 32;
    goto L209;

  L209:
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    assume {:partition} Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListIn)] > in;
    goto anon96_Else_dummy;

  anon96_Then:
    assume {:partition} in >= Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListIn)];
    goto L195;

  L195:
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    ioResourceListIn := Mem_T.List__IO_RESOURCE_REQUIREMENTS_LIST[List__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    ioResourceListOut := resourceRequirementsOut + Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)];
    in := 0;
    goto L214;

  L214:
    call ioResourceListOut, in, ioResourceListIn, listSize := FdcFilterResourceRequirements_loop_L214(resourceRequirementsIn, ioResourceListOut, in, ioResourceListIn, listSize, resourceRequirementsOut);
    goto L214_last;

  anon97_Else:
    assume {:partition} Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST[AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)] > in;
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    listSize := 40 + (Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListIn)] - 1) * 32;
    call sdv_RtlCopyMemory(0, 0, listSize);
    ioResourceListOut := ioResourceListOut + listSize;
    ioResourceListIn := ioResourceListIn + listSize;
    assume {:nonnull} resourceRequirementsOut != 0;
    assume resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsOut)] + listSize;
    in := in + 1;
    goto anon97_Else_dummy;

  anon97_Then:
    assume {:partition} in >= Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST[AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST(resourceRequirementsIn)];
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_14))] := resourceRequirementsOut;
    call sdv_ExFreePool(0);
    ntStatus_6 := 0;
    goto L137;

  L137:
    call sdv_174, sdv_177, links, ioPortInfo := FdcFilterResourceRequirements_loop_L137(sdv_174, sdv_177, links, ioPortList, ioPortInfo);
    goto L137_last;

  anon98_Else:
    assume {:partition} sdv_177 != 0;
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_14))] := ntStatus_6;
    call sdv_IoCompleteRequest(0, 0);
    Tmp_338 := ntStatus_6;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon98_Then:
    assume {:partition} sdv_177 == 0;
    call links := RemoveHeadList(ioPortList);
    call sdv_174 := sdv_containing_record(links, 12);
    ioPortInfo := sdv_174;
    call sdv_ExFreePool(0);
    goto anon98_Then_dummy;

  anon109_Then:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(Tmp_355 + Tmp_350 * 420)] == 1;
    Tmp_353 := in;
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    Tmp_342 := Mem_T.Descriptors__IO_RESOURCE_LIST[Descriptors__IO_RESOURCE_LIST(ioResourceListIn)];
    assume {:nonnull} Tmp_342 != 0;
    assume Tmp_342 > 0;
    Tmp_356 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(Tmp_342 + Tmp_353 * 420))))], BOR(BOR(1, 2), 4));
    goto anon110_Then, anon110_Else;

  anon110_Else:
    assume {:partition} Tmp_356 == 3;
    in := in + 1;
    goto L209;

  anon110_Then:
    assume {:partition} Tmp_356 != 3;
    goto L206;

  anon93_Then:
    assume {:partition} requestTapeModeRegister == 0;
    goto L195;

  anon108_Then:
    assume {:partition} requestTapeModeRegister == 0;
    goto L161;

  anon107_Then:
    assume {:partition} resourceRequirementsOut == 0;
    ntStatus_6 := -1073741670;
    goto L137;

  anon106_Then:
    assume {:partition} requestTapeModeRegister == 0;
    goto L142;

  anon89_Then:
    assume {:partition} 0 >= newDescriptors;
    goto L137;

  anon87_Then:
    assume {:partition} dmaResource == 0;
    goto L112;

  L112:
    call sdv_176, links, sdv_185, ioPortInfo := FdcFilterResourceRequirements_loop_L112(sdv_176, links, ioPortList, sdv_185, ioPortInfo);
    goto L112_last;

  anon99_Else:
    assume {:partition} sdv_176 != 0;
    call sdv_IoCompleteRequest(0, 0);
    Tmp_338 := ntStatus_6;
    goto L1;

  anon99_Then:
    assume {:partition} sdv_176 == 0;
    call links := RemoveHeadList(ioPortList);
    call sdv_185 := sdv_containing_record(links, 12);
    ioPortInfo := sdv_185;
    call sdv_ExFreePool(0);
    goto anon99_Then_dummy;

  anon86_Then:
    assume {:partition} interruptResource == 0;
    goto L112;

  anon85_Then:
    assume {:partition} sdv_186 != 0;
    goto L112;

  anon78_Then:
    assume {:partition} 0 > ntStatus_6;
    goto L112;

  anon77_Then:
    assume {:partition} i_5 >= Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(ioResourceListIn)];
    goto L64;

  anon76_Then:
    assume {:partition} Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_14))] == 0;
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    assume {:nonnull} irpSp_6 != 0;
    assume irpSp_6 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_14))] := Mem_T.IoResourceRequirementList_unnamed_tag_31[IoResourceRequirementList_unnamed_tag_31(FilterResourceRequirements_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_6)))];
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    goto anon111_Then, anon111_Else;

  anon111_Else:
    assume {:partition} Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_14))] == 0;
    assume {:nonnull} Irp_14 != 0;
    assume Irp_14 > 0;
    ntStatus_6 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_14))];
    call sdv_IoCompleteRequest(0, 0);
    Tmp_338 := ntStatus_6;
    goto L1;

  anon111_Then:
    assume {:partition} Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_14))] != 0;
    goto L58;

  anon102_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon75_Then:
    assume {:partition} ntStatus_6 != 259;
    goto L53;

  anon83_Else_dummy:
    assume false;
    return;

  L87_last:
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    goto anon83_Then, anon83_Else;

  anon84_Else_dummy:
    assume false;
    return;

  L105_last:
    assume {:nonnull} ioResourceDescriptorIn != 0;
    assume ioResourceDescriptorIn > 0;
    goto anon84_Then, anon84_Else;

  anon103_Then_dummy:
    assume false;
    return;

  L76_last:
    goto anon81_Then, anon81_Else;

  L135_dummy:
    assume false;
    return;

  L131_last:
    goto anon90_Then, anon90_Else;

  L182_dummy:
    assume false;
    return;

  L179_last:
    goto anon94_Then, anon94_Else;

  anon96_Else_dummy:
    assume false;
    return;

  L204_last:
    Tmp_350 := in;
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    Tmp_355 := Mem_T.Descriptors__IO_RESOURCE_LIST[Descriptors__IO_RESOURCE_LIST(ioResourceListIn)];
    assume {:nonnull} Tmp_355 != 0;
    assume Tmp_355 > 0;
    goto anon109_Then, anon109_Else;

  anon97_Else_dummy:
    assume false;
    return;

  L214_last:
    assume {:nonnull} resourceRequirementsIn != 0;
    assume resourceRequirementsIn > 0;
    goto anon97_Then, anon97_Else;

  anon94_Then_dummy:
    assume false;
    return;

  L171_last:
    goto anon92_Then, anon92_Else;

  anon98_Then_dummy:
    assume false;
    return;

  L137_last:
    call sdv_177 := sdv_IsListEmpty(0);
    goto anon98_Then, anon98_Else;

  anon90_Then_dummy:
    assume false;
    return;

  L123_last:
    goto anon88_Then, anon88_Else;

  anon99_Then_dummy:
    assume false;
    return;

  L112_last:
    call sdv_176 := sdv_IsListEmpty(0);
    goto anon99_Then, anon99_Else;

  L72_dummy:
    assume false;
    return;

  L63_last:
    assume {:nonnull} ioResourceListIn != 0;
    assume ioResourceListIn > 0;
    goto anon77_Then, anon77_Else;
}



procedure {:origName "FdcGetEnablerDevice"} FdcGetEnablerDevice(actual_FdoExtension_5: int);
  modifies alloc, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, yogi_error;



implementation {:origName "FdcGetEnablerDevice"} FdcGetEnablerDevice(actual_FdoExtension_5: int)
{
  var {:pointer} irpSp_7: int;
  var {:scalar} doneEvent_1: int;
  var {:scalar} ntStatus_7: int;
  var {:pointer} irp_1: int;
  var {:scalar} ioStatus: int;
  var {:pointer} FdoExtension_5: int;
  var vslice_dummy_var_81: int;

  anon0:
    call vslice_dummy_var_81 := __HAVOC_malloc(4);
    call doneEvent_1 := __HAVOC_malloc(156);
    call ioStatus := __HAVOC_malloc(12);
    FdoExtension_5 := actual_FdoExtension_5;
    call KeInitializeEvent(doneEvent_1, 0, 0);
    call irp_1 := IoBuildDeviceIoControlRequest(461891, 0, 0, 0, 0, 0, 1, 0, ioStatus);
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} irp_1 != 0;
    call irpSp_7 := sdv_IoGetNextIrpStackLocation(irp_1);
    assume {:nonnull} FdoExtension_5 != 0;
    assume FdoExtension_5 > 0;
    assume {:nonnull} irpSp_7 != 0;
    assume irpSp_7 > 0;
    Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_7)))] := FdcEnablerSupported__FDC_FDO_EXTENSION(FdoExtension_5);
    assume {:nonnull} FdoExtension_5 != 0;
    assume FdoExtension_5 > 0;
    call ntStatus_7 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(FdoExtension_5)], irp_1);
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} ntStatus_7 == 259;
    call ntStatus_7 := KeWaitForSingleObject(0, 0, 0, 0, 0);
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
    assume {:partition} ntStatus_7 != 259;
    goto L1;

  anon7_Then:
    assume {:partition} irp_1 == 0;
    goto L1;
}



procedure {:origName "FdcPnpComplete"} FdcPnpComplete(actual_DeviceObject_27: int, actual_Irp_15: int, actual_Context_9: int) returns (Tmp_362: int);
  modifies Mem_T.SignalState__DISPATCHER_HEADER;



implementation {:origName "FdcPnpComplete"} FdcPnpComplete(actual_DeviceObject_27: int, actual_Irp_15: int, actual_Context_9: int) returns (Tmp_362: int)
{
  var {:pointer} Context_9: int;
  var vslice_dummy_var_82: int;

  anon0:
    Context_9 := actual_Context_9;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} Context_9 != 0;
    call vslice_dummy_var_82 := KeSetEvent(Context_9, 1, 0);
    goto L4;

  L4:
    Tmp_362 := -1073741802;
    return;

  anon3_Then:
    assume {:partition} Context_9 == 0;
    goto L4;
}



procedure {:origName "FdcProbeFloppyDevice"} FdcProbeFloppyDevice(actual_DeviceObject_28: int, actual_DeviceSelect: int) returns (Tmp_364: int);
  modifies alloc, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.INT4, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, sdv_isr_routine, sdv_pDpcContext, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, yogi_error;



implementation {:origName "FdcProbeFloppyDevice"} FdcProbeFloppyDevice(actual_DeviceObject_28: int, actual_DeviceSelect: int) returns (Tmp_364: int)
{
  var {:scalar} fdcEnable: int;
  var {:pointer} Tmp_365: int;
  var {:pointer} Tmp_366: int;
  var {:pointer} Tmp_367: int;
  var {:scalar} ntStatus_8: int;
  var {:pointer} fdoExtension_3: int;
  var {:pointer} Tmp_368: int;
  var {:pointer} Tmp_369: int;
  var {:pointer} Tmp_371: int;
  var {:pointer} DeviceObject_28: int;
  var {:scalar} DeviceSelect: int;
  var boogieTmp: int;
  var vslice_dummy_var_83: int;
  var vslice_dummy_var_84: int;

  anon0:
    call fdcEnable := __HAVOC_malloc(12);
    DeviceObject_28 := actual_DeviceObject_28;
    DeviceSelect := actual_DeviceSelect;
    call Tmp_365 := __HAVOC_malloc(40);
    call Tmp_366 := __HAVOC_malloc(40);
    call Tmp_367 := __HAVOC_malloc(40);
    call Tmp_368 := __HAVOC_malloc(40);
    call Tmp_369 := __HAVOC_malloc(40);
    call Tmp_371 := __HAVOC_malloc(40);
    assume {:nonnull} DeviceObject_28 != 0;
    assume DeviceObject_28 > 0;
    fdoExtension_3 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_28)];
    call ntStatus_8 := FcAcquireFdc(fdoExtension_3, 0);
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} yogi_error != 1;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} ntStatus_8 >= 0;
    call ntStatus_8 := FcInitializeControllerHardware(fdoExtension_3, DeviceObject_28);
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} yogi_error != 1;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} ntStatus_8 >= 0;
    assume {:nonnull} fdcEnable != 0;
    assume fdcEnable > 0;
    call boogieTmp := corral_nondet();
    Mem_T.DriveOnValue__FDC_ENABLE_PARMS[DriveOnValue__FDC_ENABLE_PARMS(fdcEnable)] := boogieTmp;
    assume {:nonnull} fdcEnable != 0;
    assume fdcEnable > 0;
    Mem_T.TimeToWait__FDC_ENABLE_PARMS[TimeToWait__FDC_ENABLE_PARMS(fdcEnable)] := 1000;
    assume {:nonnull} fdcEnable != 0;
    assume fdcEnable > 0;
    call ntStatus_8 := FcTurnOnMotor(fdoExtension_3, fdcEnable);
    goto L17;

  L17:
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} ntStatus_8 >= 0;
    assume {:nonnull} fdoExtension_3 != 0;
    assume fdoExtension_3 > 0;
    Tmp_367 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)];
    assume {:nonnull} Tmp_367 != 0;
    assume Tmp_367 > 0;
    Mem_T.INT4[Tmp_367] := 11;
    assume {:nonnull} fdoExtension_3 != 0;
    assume fdoExtension_3 > 0;
    Tmp_365 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)];
    assume {:nonnull} Tmp_365 != 0;
    assume Tmp_365 > 0;
    Mem_T.INT4[Tmp_365 + 1 * 4] := DeviceSelect;
    assume {:nonnull} fdoExtension_3 != 0;
    assume fdoExtension_3 > 0;
    call ntStatus_8 := FcIssueCommand(fdoExtension_3, Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)], Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)], 0, 0, 0);
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} yogi_error != 1;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} ntStatus_8 >= 0;
    assume {:nonnull} fdoExtension_3 != 0;
    assume fdoExtension_3 > 0;
    Tmp_369 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)];
    assume {:nonnull} Tmp_369 != 0;
    assume Tmp_369 > 0;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} BAND(Mem_T.INT4[Tmp_369], 16) != 0;
    assume {:nonnull} fdoExtension_3 != 0;
    assume fdoExtension_3 > 0;
    Tmp_366 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)];
    assume {:nonnull} Tmp_366 != 0;
    assume Tmp_366 > 0;
    Mem_T.INT4[Tmp_366] := 11;
    assume {:nonnull} fdoExtension_3 != 0;
    assume fdoExtension_3 > 0;
    Tmp_368 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)];
    assume {:nonnull} Tmp_368 != 0;
    assume Tmp_368 > 0;
    Mem_T.INT4[Tmp_368 + 1 * 4] := DeviceSelect;
    assume {:nonnull} fdoExtension_3 != 0;
    assume fdoExtension_3 > 0;
    call ntStatus_8 := FcIssueCommand(fdoExtension_3, Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)], Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)], 0, 0, 0);
    goto anon34_Then, anon34_Else;

  anon34_Else:
    assume {:partition} yogi_error != 1;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} ntStatus_8 >= 0;
    assume {:nonnull} fdoExtension_3 != 0;
    assume fdoExtension_3 > 0;
    Tmp_371 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_3)];
    assume {:nonnull} Tmp_371 != 0;
    assume Tmp_371 > 0;
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} BAND(Mem_T.INT4[Tmp_371], 16) != 0;
    ntStatus_8 := -1073741810;
    goto L26;

  L26:
    call vslice_dummy_var_83 := FcTurnOffMotor(fdoExtension_3);
    call vslice_dummy_var_84 := FcReleaseFdc(fdoExtension_3);
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} yogi_error != 1;
    goto L11;

  L11:
    Tmp_364 := ntStatus_8;
    goto LM2;

  LM2:
    return;

  anon36_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon35_Then:
    assume {:partition} BAND(Mem_T.INT4[Tmp_371], 16) == 0;
    goto L26;

  anon29_Then:
    assume {:partition} 0 > ntStatus_8;
    goto L26;

  anon34_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon33_Then:
    assume {:partition} BAND(Mem_T.INT4[Tmp_369], 16) == 0;
    goto L26;

  anon28_Then:
    assume {:partition} 0 > ntStatus_8;
    goto L26;

  anon32_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon27_Then:
    assume {:partition} 0 > ntStatus_8;
    goto L26;

  anon26_Then:
    assume {:partition} 0 > ntStatus_8;
    goto L17;

  anon31_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon25_Then:
    assume {:partition} 0 > ntStatus_8;
    goto L11;

  anon30_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "FdcStartDevice"} FdcStartDevice(actual_DeviceObject_29: int, actual_Irp_16: int) returns (Tmp_372: int);
  modifies alloc, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_isr_routine, sdv_pDpcContext, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.SpeedsAvailable__FDC_INFORMATION, Mem_T.ClockRatesSupported__FDC_INFORMATION, Mem_T.FloppyControllerType__FDC_INFORMATION, Mem_T.FdcType__FDC_FDO_EXTENSION, Mem_T.Clock48MHz__FDC_FDO_EXTENSION, Mem_T.FdcSpeeds__FDC_FDO_EXTENSION, Mem_T.INT4, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.MaximumLength__DEVICE_DESCRIPTION, Mem_T.AdapterObject__FDC_FDO_EXTENSION, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.PINT4, Mem_T.InterruptMode__FDC_FDO_EXTENSION, Mem_T.ControllerVector__FDC_FDO_EXTENSION, Mem_T.ProcessorMask__FDC_FDO_EXTENSION, Mem_T.ControllerIrql__FDC_FDO_EXTENSION, Mem_T.SharableVector__FDC_FDO_EXTENSION, Mem_T.SaveFloatState__FDC_FDO_EXTENSION, Mem_T.BusType__FDC_FDO_EXTENSION, Mem_T.BusNumber__FDC_FDO_EXTENSION, Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION, Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION, sdv_io_dpc, Mem_T.DeferredRoutine__KDPC, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, yogi_error;



implementation {:origName "FdcStartDevice"} FdcStartDevice(actual_DeviceObject_29: int, actual_Irp_16: int) returns (Tmp_372: int)
{
  var {:scalar} i_6: int;
  var {:scalar} Tmp_374: int;
  var {:pointer} translatedResources: int;
  var {:pointer} Tmp_375: int;
  var {:scalar} Tmp_376: int;
  var {:pointer} Tmp_377: int;
  var {:scalar} foundDma: int;
  var {:scalar} Tmp_378: int;
  var {:pointer} irpSp_8: int;
  var {:pointer} Tmp_379: int;
  var {:scalar} Tmp_380: int;
  var {:scalar} Tmp_381: int;
  var {:pointer} Tmp_382: int;
  var {:scalar} Tmp_383: int;
  var {:scalar} deviceDesc: int;
  var {:pointer} partialList: int;
  var {:pointer} fullList: int;
  var {:pointer} sdv_202: int;
  var {:scalar} Tmp_384: int;
  var {:scalar} ntStatus_9: int;
  var {:pointer} sdv_205: int;
  var {:scalar} InterfaceType_1: int;
  var {:scalar} currentOffset: int;
  var {:scalar} Tmp_385: int;
  var {:pointer} partial: int;
  var {:pointer} fdoExtension_4: int;
  var {:scalar} currentBase: int;
  var {:pointer} Tmp_386: int;
  var {:scalar} startOffset: int;
  var {:scalar} foundInterrupt: int;
  var {:pointer} Tmp_387: int;
  var {:scalar} Tmp_388: int;
  var {:pointer} Tmp_389: int;
  var {:scalar} acquireTimeOut: int;
  var {:scalar} Tmp_390: int;
  var {:scalar} Tmp_391: int;
  var {:pointer} Tmp_392: int;
  var {:scalar} Tmp_393: int;
  var {:pointer} sdv_210: int;
  var {:pointer} Tmp_394: int;
  var {:pointer} Tmp_395: int;
  var {:pointer} DeviceObject_29: int;
  var {:pointer} Irp_16: int;
  var vslice_dummy_var_85: int;

  anon0:
    call deviceDesc := __HAVOC_malloc(96);
    call acquireTimeOut := __HAVOC_malloc(20);
    DeviceObject_29 := actual_DeviceObject_29;
    Irp_16 := actual_Irp_16;
    call Tmp_375 := __HAVOC_malloc(32);
    call Tmp_377 := __HAVOC_malloc(292);
    call Tmp_379 := __HAVOC_malloc(32);
    call Tmp_382 := __HAVOC_malloc(32);
    call Tmp_386 := __HAVOC_malloc(32);
    call Tmp_387 := __HAVOC_malloc(312);
    call Tmp_389 := __HAVOC_malloc(312);
    call Tmp_392 := __HAVOC_malloc(32);
    call Tmp_394 := __HAVOC_malloc(32);
    call Tmp_395 := __HAVOC_malloc(32);
    ntStatus_9 := 0;
    foundDma := 0;
    foundInterrupt := 0;
    currentBase := -1;
    assume {:nonnull} DeviceObject_29 != 0;
    assume DeviceObject_29 > 0;
    fdoExtension_4 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_29)];
    call irpSp_8 := sdv_IoGetCurrentIrpStackLocation(Irp_16);
    call FdcGetEnablerDevice(fdoExtension_4);
    goto anon111_Then, anon111_Else;

  anon111_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(fdoExtension_4)] != 0;
    InterfaceType_1 := 0;
    goto L37;

  L37:
    call ntStatus_9, InterfaceType_1 := FdcStartDevice_loop_L37(ntStatus_9, InterfaceType_1);
    goto L37_last;

  anon87_Else:
    assume {:partition} 18 > InterfaceType_1;
    call ntStatus_9 := IoQueryDeviceDescription(0, 0, 0, 0, 0, 0, li2bplFunctionConstant206, 0);
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} ntStatus_9 >= 0;
    goto L47;

  L47:
    InterfaceType_1 := InterfaceType_1 + 1;
    goto L47_dummy;

  anon89_Then:
    assume {:partition} 0 > ntStatus_9;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    assume {:partition} ntStatus_9 != -1073741772;
    Tmp_372 := ntStatus_9;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon90_Then:
    assume {:partition} ntStatus_9 == -1073741772;
    goto L47;

  anon87_Then:
    assume {:partition} InterfaceType_1 >= 18;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION[FdcEnablerDeviceObject__FDC_FDO_EXTENSION(fdoExtension_4)] != 0;
    ntStatus_9 := 0;
    goto L51;

  L51:
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} ntStatus_9 >= 0;
    call ntStatus_9 := FdcInitializeDeviceObject(DeviceObject_29);
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    call ntStatus_9 := IoConnectInterrupt(0, li2bplFunctionConstant207, fdoExtension_4, 0, Mem_T.ControllerVector__FDC_FDO_EXTENSION[ControllerVector__FDC_FDO_EXTENSION(fdoExtension_4)], Mem_T.ControllerIrql__FDC_FDO_EXTENSION[ControllerIrql__FDC_FDO_EXTENSION(fdoExtension_4)], Mem_T.ControllerIrql__FDC_FDO_EXTENSION[ControllerIrql__FDC_FDO_EXTENSION(fdoExtension_4)], Mem_T.InterruptMode__FDC_FDO_EXTENSION[InterruptMode__FDC_FDO_EXTENSION(fdoExtension_4)], Mem_T.SharableVector__FDC_FDO_EXTENSION[SharableVector__FDC_FDO_EXTENSION(fdoExtension_4)], Mem_T.ProcessorMask__FDC_FDO_EXTENSION[ProcessorMask__FDC_FDO_EXTENSION(fdoExtension_4)], Mem_T.SaveFloatState__FDC_FDO_EXTENSION[SaveFloatState__FDC_FDO_EXTENSION(fdoExtension_4)]);
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION[CurrentInterrupt__FDC_FDO_EXTENSION(fdoExtension_4)] := 0;
    goto anon112_Then, anon112_Else;

  anon112_Else:
    assume {:partition} ntStatus_9 >= 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION[CurrentInterrupt__FDC_FDO_EXTENSION(fdoExtension_4)] := 1;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(fdoExtension_4)] := Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION[CurrentInterrupt__FDC_FDO_EXTENSION(fdoExtension_4)];
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon113_Then, anon113_Else;

  anon113_Else:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(fdoExtension_4)] != 0;
    assume {:nonnull} acquireTimeOut != 0;
    assume acquireTimeOut > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(acquireTimeOut)] := -150000000;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    call ntStatus_9 := FcFdcEnabler(Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION[FdcEnablerDeviceObject__FDC_FDO_EXTENSION(fdoExtension_4)], 2031623, acquireTimeOut);
    goto anon114_Then, anon114_Else;

  anon114_Else:
    assume {:partition} yogi_error != 1;
    goto L67;

  L67:
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} ntStatus_9 >= 0;
    call ntStatus_9 := FcInitializeControllerHardware(fdoExtension_4, DeviceObject_29);
    goto anon115_Then, anon115_Else;

  anon115_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(fdoExtension_4)] != 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    call vslice_dummy_var_85 := FcFdcEnabler(Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION[FdcEnablerDeviceObject__FDC_FDO_EXTENSION(fdoExtension_4)], 2031627, 0);
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume {:partition} yogi_error != 1;
    goto L80;

  L80:
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION[CurrentInterrupt__FDC_FDO_EXTENSION(fdoExtension_4)] := 0;
    goto L74;

  L74:
    goto anon94_Then, anon94_Else;

  anon94_Else:
    assume {:partition} ntStatus_9 >= 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(fdoExtension_4)] := 0;
    call ntStatus_9 := FcGetFdcInformation(fdoExtension_4);
    goto anon117_Then, anon117_Else;

  anon117_Else:
    assume {:partition} yogi_error != 1;
    goto L90;

  L90:
    call IoDisconnectInterrupt(0);
    goto L63;

  L63:
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} ntStatus_9 >= 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension_4)] != 0;
    goto L98;

  L98:
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto L52;

  L52:
    assume {:nonnull} Irp_16 != 0;
    assume Irp_16 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_16))] := 0;
    Tmp_372 := ntStatus_9;
    goto L1;

  anon96_Then:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension_4)] == 0;
    call sdv_RtlZeroMemory(0, 20);
    goto L98;

  anon92_Then:
    assume {:partition} 0 > ntStatus_9;
    goto L52;

  anon117_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon94_Then:
    assume {:partition} 0 > ntStatus_9;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(fdoExtension_4)] := 1;
    goto L90;

  anon116_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon95_Then:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(fdoExtension_4)] == 0;
    goto L80;

  anon115_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon93_Then:
    assume {:partition} 0 > ntStatus_9;
    goto L74;

  anon114_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon113_Then:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(fdoExtension_4)] == 0;
    goto L67;

  anon112_Then:
    assume {:partition} 0 > ntStatus_9;
    goto L63;

  anon91_Then:
    assume {:partition} 0 > ntStatus_9;
    goto L52;

  anon88_Then:
    assume {:partition} Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION[FdcEnablerDeviceObject__FDC_FDO_EXTENSION(fdoExtension_4)] == 0;
    ntStatus_9 := -1073741772;
    goto L51;

  anon85_Then:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(fdoExtension_4)] == 0;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} Mem_T.AllocatedResources_unnamed_tag_40[AllocatedResources_unnamed_tag_40(StartDevice_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] != 0;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} Mem_T.AllocatedResourcesTranslated_unnamed_tag_40[AllocatedResourcesTranslated_unnamed_tag_40(StartDevice_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] != 0;
    assume {:nonnull} irpSp_8 != 0;
    assume irpSp_8 > 0;
    translatedResources := Mem_T.AllocatedResourcesTranslated_unnamed_tag_40[AllocatedResourcesTranslated_unnamed_tag_40(StartDevice_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))];
    assume {:nonnull} translatedResources != 0;
    assume translatedResources > 0;
    Tmp_389 := Mem_T.List__CM_RESOURCE_LIST[List__CM_RESOURCE_LIST(translatedResources)];
    fullList := Tmp_389;
    assume {:nonnull} translatedResources != 0;
    assume translatedResources > 0;
    Tmp_387 := Mem_T.List__CM_RESOURCE_LIST[List__CM_RESOURCE_LIST(translatedResources)];
    assume {:nonnull} Tmp_387 != 0;
    assume Tmp_387 > 0;
    partialList := PartialResourceList__CM_FULL_RESOURCE_DESCRIPTOR(Tmp_387);
    call sdv_RtlZeroMemory(0, 32);
    i_6 := 0;
    goto L109;

  L109:
    call i_6, Tmp_374, Tmp_375, Tmp_376, Tmp_377, foundDma, Tmp_378, Tmp_379, Tmp_380, Tmp_381, Tmp_382, Tmp_383, sdv_202, Tmp_384, ntStatus_9, sdv_205, currentOffset, Tmp_385, partial, currentBase, Tmp_386, startOffset, foundInterrupt, Tmp_388, Tmp_390, Tmp_391, Tmp_392, Tmp_393, sdv_210, Tmp_394, Tmp_395 := FdcStartDevice_loop_L109(i_6, Tmp_374, Tmp_375, Tmp_376, Tmp_377, foundDma, Tmp_378, Tmp_379, Tmp_380, Tmp_381, Tmp_382, Tmp_383, deviceDesc, partialList, fullList, sdv_202, Tmp_384, ntStatus_9, sdv_205, currentOffset, Tmp_385, partial, fdoExtension_4, currentBase, Tmp_386, startOffset, foundInterrupt, Tmp_388, Tmp_390, Tmp_391, Tmp_392, Tmp_393, sdv_210, Tmp_394, Tmp_395);
    goto L109_last;

  anon98_Else:
    assume {:partition} Mem_T.Count__CM_PARTIAL_RESOURCE_LIST[Count__CM_PARTIAL_RESOURCE_LIST(partialList)] > i_6;
    Tmp_383 := i_6;
    assume {:nonnull} partialList != 0;
    assume partialList > 0;
    Tmp_377 := Mem_T.PartialDescriptors__CM_PARTIAL_RESOURCE_LIST[PartialDescriptors__CM_PARTIAL_RESOURCE_LIST(partialList)];
    partial := Tmp_377 + Tmp_383 * 292;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    goto anon118_Then, anon118_Else;

  anon118_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(partial)] != 1;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    goto anon110_Then, anon110_Else;

  anon110_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(partial)] != 2;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    goto anon109_Then, anon109_Else;

  anon109_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(partial)] != 3;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(partial)] != 4;
    goto L157;

  L157:
    i_6 := i_6 + 1;
    goto L157_dummy;

  anon108_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(partial)] == 4;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    Mem_T.MaximumLength__DEVICE_DESCRIPTION[MaximumLength__DEVICE_DESCRIPTION(deviceDesc)] := 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    foundDma := 1;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    goto anon125_Then, anon125_Else;

  anon125_Else:
    assume {:partition} Mem_T.Channel_unnamed_tag_48[Channel_unnamed_tag_48(Dma_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))] > 3;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    goto L142;

  L142:
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    Mem_T.MaximumLength__DEVICE_DESCRIPTION[MaximumLength__DEVICE_DESCRIPTION(deviceDesc)] := 18432;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    Mem_T.MaximumLength__DEVICE_DESCRIPTION[MaximumLength__DEVICE_DESCRIPTION(deviceDesc)] := Mem_T.MaximumLength__DEVICE_DESCRIPTION[MaximumLength__DEVICE_DESCRIPTION(deviceDesc)] + 4096;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} fullList != 0;
    assume fullList > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    call sdv_202 := IoGetDmaAdapter(0, 0, 0);
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.AdapterObject__FDC_FDO_EXTENSION[AdapterObject__FDC_FDO_EXTENSION(fdoExtension_4)] := sdv_202;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon126_Then, anon126_Else;

  anon126_Else:
    assume {:partition} Mem_T.AdapterObject__FDC_FDO_EXTENSION[AdapterObject__FDC_FDO_EXTENSION(fdoExtension_4)] != 0;
    goto L157;

  anon126_Then:
    assume {:partition} Mem_T.AdapterObject__FDC_FDO_EXTENSION[AdapterObject__FDC_FDO_EXTENSION(fdoExtension_4)] == 0;
    ntStatus_9 := -1073741670;
    goto L157;

  anon125_Then:
    assume {:partition} 3 >= Mem_T.Channel_unnamed_tag_48[Channel_unnamed_tag_48(Dma_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))];
    assume {:nonnull} deviceDesc != 0;
    assume deviceDesc > 0;
    goto L142;

  anon109_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(partial)] == 3;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    Tmp_374 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume {:partition} currentBase > Tmp_374;
    call sdv_RtlZeroMemory(0, 32);
    assume {:nonnull} partial != 0;
    assume partial > 0;
    currentBase := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto L159;

  L159:
    assume {:nonnull} partial != 0;
    assume partial > 0;
    Tmp_376 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto anon124_Then, anon124_Else;

  anon124_Else:
    assume {:partition} Tmp_376 == currentBase;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    startOffset := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial))))], BOR(BOR(1, 2), 4));
    assume {:nonnull} partial != 0;
    assume partial > 0;
    call sdv_210 := MmMapIoSpace(Mem_T.Start_unnamed_tag_44[Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))], Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))], 0);
    Tmp_381 := startOffset;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Tmp_392 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))];
    assume {:nonnull} Tmp_392 != 0;
    assume Tmp_392 > 0;
    Mem_T.PINT4[Tmp_392 + Tmp_381 * 4] := sdv_210;
    currentOffset := 1;
    goto L172;

  L172:
    call Tmp_375, Tmp_378, Tmp_382, Tmp_384, currentOffset := FdcStartDevice_loop_L172(Tmp_375, Tmp_378, Tmp_382, Tmp_384, currentOffset, partial, fdoExtension_4, startOffset);
    goto L172_last;

  anon100_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))] > currentOffset;
    Tmp_384 := startOffset + currentOffset;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Tmp_375 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))];
    Tmp_378 := startOffset;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Tmp_382 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))];
    assume {:nonnull} Tmp_375 != 0;
    assume Tmp_375 > 0;
    assume {:nonnull} Tmp_382 != 0;
    assume Tmp_382 > 0;
    Mem_T.PINT4[Tmp_375 + Tmp_384 * 4] := Mem_T.PINT4[Tmp_382 + Tmp_378 * 4];
    currentOffset := currentOffset + 1;
    goto anon100_Else_dummy;

  anon100_Then:
    assume {:partition} currentOffset >= Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))];
    goto L157;

  anon124_Then:
    assume {:partition} Tmp_376 != currentBase;
    goto L157;

  anon123_Then:
    assume {:partition} Tmp_374 >= currentBase;
    goto L159;

  anon110_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(partial)] == 2;
    foundInterrupt := 1;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    goto anon122_Then, anon122_Else;

  anon122_Else:
    assume {:partition} BAND(Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR[Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)], 1) != 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.InterruptMode__FDC_FDO_EXTENSION[InterruptMode__FDC_FDO_EXTENSION(fdoExtension_4)] := 1;
    goto L178;

  L178:
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    Mem_T.ControllerVector__FDC_FDO_EXTENSION[ControllerVector__FDC_FDO_EXTENSION(fdoExtension_4)] := Mem_T.Vector_unnamed_tag_45[Vector_unnamed_tag_45(Interrupt_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))];
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    Mem_T.ProcessorMask__FDC_FDO_EXTENSION[ProcessorMask__FDC_FDO_EXTENSION(fdoExtension_4)] := Mem_T.Affinity_unnamed_tag_45[Affinity_unnamed_tag_45(Interrupt_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))];
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    Mem_T.ControllerIrql__FDC_FDO_EXTENSION[ControllerIrql__FDC_FDO_EXTENSION(fdoExtension_4)] := Mem_T.Level_unnamed_tag_45[Level_unnamed_tag_45(Interrupt_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))];
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.SharableVector__FDC_FDO_EXTENSION[SharableVector__FDC_FDO_EXTENSION(fdoExtension_4)] := 1;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.SaveFloatState__FDC_FDO_EXTENSION[SaveFloatState__FDC_FDO_EXTENSION(fdoExtension_4)] := 0;
    goto L157;

  anon122_Then:
    assume {:partition} BAND(Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR[Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)], 1) == 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.InterruptMode__FDC_FDO_EXTENSION[InterruptMode__FDC_FDO_EXTENSION(fdoExtension_4)] := 0;
    goto L178;

  anon118_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(partial)] == 1;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    Tmp_385 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto anon119_Then, anon119_Else;

  anon119_Else:
    assume {:partition} currentBase > Tmp_385;
    call sdv_RtlZeroMemory(0, 32);
    assume {:nonnull} partial != 0;
    assume partial > 0;
    currentBase := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto L185;

  L185:
    assume {:nonnull} partial != 0;
    assume partial > 0;
    Tmp_388 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto anon120_Then, anon120_Else;

  anon120_Else:
    assume {:partition} Tmp_388 == currentBase;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    startOffset := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial))))], BOR(BOR(1, 2), 4));
    assume {:nonnull} partial != 0;
    assume partial > 0;
    goto anon121_Then, anon121_Else;

  anon121_Else:
    assume {:partition} BAND(Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR[Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)], 1) != 0;
    Tmp_393 := startOffset;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Tmp_386 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))];
    assume {:nonnull} Tmp_386 != 0;
    assume Tmp_386 > 0;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    Mem_T.PINT4[Tmp_386 + Tmp_393 * 4] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial))))];
    goto L198;

  L198:
    currentOffset := 1;
    goto L199;

  L199:
    call Tmp_379, currentOffset, Tmp_390, Tmp_391, Tmp_394 := FdcStartDevice_loop_L199(Tmp_379, currentOffset, partial, fdoExtension_4, startOffset, Tmp_390, Tmp_391, Tmp_394);
    goto L199_last;

  anon101_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))] > currentOffset;
    Tmp_390 := startOffset + currentOffset;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Tmp_379 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))];
    Tmp_391 := startOffset;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Tmp_394 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))];
    assume {:nonnull} Tmp_379 != 0;
    assume Tmp_379 > 0;
    assume {:nonnull} Tmp_394 != 0;
    assume Tmp_394 > 0;
    Mem_T.PINT4[Tmp_379 + Tmp_390 * 4] := Mem_T.PINT4[Tmp_394 + Tmp_391 * 4];
    currentOffset := currentOffset + 1;
    goto anon101_Else_dummy;

  anon101_Then:
    assume {:partition} currentOffset >= Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))];
    goto L157;

  anon121_Then:
    assume {:partition} BAND(Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR[Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)], 1) == 0;
    assume {:nonnull} partial != 0;
    assume partial > 0;
    call sdv_205 := MmMapIoSpace(Mem_T.Start_unnamed_tag_44[Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))], Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(partial)))], 0);
    Tmp_380 := startOffset;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Tmp_395 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))];
    assume {:nonnull} Tmp_395 != 0;
    assume Tmp_395 > 0;
    Mem_T.PINT4[Tmp_395 + Tmp_380 * 4] := sdv_205;
    goto L198;

  anon120_Then:
    assume {:partition} Tmp_388 != currentBase;
    goto L157;

  anon119_Then:
    assume {:partition} Tmp_385 >= currentBase;
    goto L185;

  anon98_Then:
    assume {:partition} i_6 >= Mem_T.Count__CM_PARTIAL_RESOURCE_LIST[Count__CM_PARTIAL_RESOURCE_LIST(partialList)];
    goto anon99_Then, anon99_Else;

  anon99_Else:
    assume {:partition} foundDma != 0;
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume {:partition} foundInterrupt != 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon103_Then, anon103_Else;

  anon103_Else:
    assume {:partition} Mem_T.DriveControl__CONTROLLER[DriveControl__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))] != 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume {:partition} Mem_T.Status__CONTROLLER[Status__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))] != 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    assume {:partition} Mem_T.Fifo__CONTROLLER[Fifo__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))] != 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:partition} Mem_T.DataRate_unnamed_tag_69[DataRate_unnamed_tag_69(DRDC__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4)))] != 0;
    goto L209;

  L209:
    goto anon107_Then, anon107_Else;

  anon107_Else:
    assume {:partition} ntStatus_9 >= 0;
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    assume {:nonnull} fullList != 0;
    assume fullList > 0;
    Mem_T.BusType__FDC_FDO_EXTENSION[BusType__FDC_FDO_EXTENSION(fdoExtension_4)] := Mem_T.InterfaceType__CM_FULL_RESOURCE_DESCRIPTOR[InterfaceType__CM_FULL_RESOURCE_DESCRIPTOR(fullList)];
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    assume {:nonnull} fullList != 0;
    assume fullList > 0;
    Mem_T.BusNumber__FDC_FDO_EXTENSION[BusNumber__FDC_FDO_EXTENSION(fdoExtension_4)] := Mem_T.BusNumber__CM_FULL_RESOURCE_DESCRIPTOR[BusNumber__CM_FULL_RESOURCE_DESCRIPTOR(fullList)];
    assume {:nonnull} fdoExtension_4 != 0;
    assume fdoExtension_4 > 0;
    Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension_4)] := ProbeFloppyDevices;
    goto L51;

  anon107_Then:
    assume {:partition} 0 > ntStatus_9;
    goto L51;

  anon106_Then:
    assume {:partition} Mem_T.DataRate_unnamed_tag_69[DataRate_unnamed_tag_69(DRDC__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4)))] == 0;
    goto L203;

  L203:
    ntStatus_9 := -1073741670;
    goto L209;

  anon105_Then:
    assume {:partition} Mem_T.Fifo__CONTROLLER[Fifo__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))] == 0;
    goto L203;

  anon104_Then:
    assume {:partition} Mem_T.Status__CONTROLLER[Status__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))] == 0;
    goto L203;

  anon103_Then:
    assume {:partition} Mem_T.DriveControl__CONTROLLER[DriveControl__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(fdoExtension_4))] == 0;
    goto L203;

  anon102_Then:
    assume {:partition} foundInterrupt == 0;
    goto L203;

  anon99_Then:
    assume {:partition} foundDma == 0;
    goto L203;

  anon97_Then:
    assume {:partition} Mem_T.AllocatedResourcesTranslated_unnamed_tag_40[AllocatedResourcesTranslated_unnamed_tag_40(StartDevice_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] == 0;
    goto L100;

  L100:
    Tmp_372 := -1073741670;
    goto L1;

  anon86_Then:
    assume {:partition} Mem_T.AllocatedResources_unnamed_tag_40[AllocatedResources_unnamed_tag_40(StartDevice_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_8)))] == 0;
    goto L100;

  anon111_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  L47_dummy:
    assume false;
    return;

  L37_last:
    assume {:CounterLoop 18} {:Counter "InterfaceType_1"} true;
    goto anon87_Then, anon87_Else;

  anon100_Else_dummy:
    assume false;
    return;

  L172_last:
    assume {:nonnull} partial != 0;
    assume partial > 0;
    goto anon100_Then, anon100_Else;

  anon101_Else_dummy:
    assume false;
    return;

  L199_last:
    assume {:nonnull} partial != 0;
    assume partial > 0;
    goto anon101_Then, anon101_Else;

  L157_dummy:
    assume false;
    return;

  L109_last:
    assume {:nonnull} partialList != 0;
    assume partialList > 0;
    goto anon98_Then, anon98_Else;
}



procedure {:origName "FdcSystemControl"} FdcSystemControl(actual_DeviceObject_30: int, actual_Irp_17: int) returns (Tmp_396: int);
  modifies alloc, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "FdcSystemControl"} FdcSystemControl(actual_DeviceObject_30: int, actual_Irp_17: int) returns (Tmp_396: int)
{
  var {:pointer} fdoExtension_5: int;
  var {:scalar} status_7: int;
  var {:pointer} extensionHeader_1: int;
  var {:pointer} DeviceObject_30: int;
  var {:pointer} Irp_17: int;

  anon0:
    DeviceObject_30 := actual_DeviceObject_30;
    Irp_17 := actual_Irp_17;
    assume {:nonnull} DeviceObject_30 != 0;
    assume DeviceObject_30 > 0;
    extensionHeader_1 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_30)];
    assume {:nonnull} extensionHeader_1 != 0;
    assume extensionHeader_1 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(extensionHeader_1)] != 0;
    assume {:nonnull} DeviceObject_30 != 0;
    assume DeviceObject_30 > 0;
    fdoExtension_5 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_30)];
    call sdv_IoSkipCurrentIrpStackLocation(Irp_17);
    assume {:nonnull} fdoExtension_5 != 0;
    assume fdoExtension_5 > 0;
    call Tmp_396 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_5)], Irp_17);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(extensionHeader_1)] == 0;
    assume {:nonnull} Irp_17 != 0;
    assume Irp_17 > 0;
    status_7 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_17))];
    call sdv_IoCompleteRequest(0, 0);
    Tmp_396 := status_7;
    goto L1;
}



procedure {:origName "FdcInternalDeviceControl"} FdcInternalDeviceControl(actual_DeviceObject_31: int, actual_Irp_18: int) returns (Tmp_398: int);
  modifies sdv_kdpc3, sdv_dpc_ke_registered, Mem_T.Status__IO_STATUS_BLOCK, alloc, Mem_T.INT4, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.BufferSize__FDC_INFO, Mem_T.BufferCount__FDC_INFO, Mem_T.BuffersRequested__FDC_FDO_EXTENSION, Mem_T.Virtual__TRANSFER_BUFFER, Mem_T.AcpiBios__FDC_INFO, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.DriveNumber__ACPI_FDI_DATA, Mem_T.DeviceType__ACPI_FDI_DATA, Mem_T.MaxCylinderNumber__ACPI_FDI_DATA, Mem_T.MaxSectorNumber__ACPI_FDI_DATA, Mem_T.MaxHeadNumber__ACPI_FDI_DATA, Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA, Mem_T.HeadLoadTime__ACPI_FDI_DATA, Mem_T.MotorOffTime__ACPI_FDI_DATA, Mem_T.SectorLengthCode__ACPI_FDI_DATA, Mem_T.SectorPerTrack__ACPI_FDI_DATA, Mem_T.ReadWriteGapLength__ACPI_FDI_DATA, Mem_T.DataTransferLength__ACPI_FDI_DATA, Mem_T.FormatGapLength__ACPI_FDI_DATA, Mem_T.FormatFillCharacter__ACPI_FDI_DATA, Mem_T.HeadSettleTime__ACPI_FDI_DATA, Mem_T.MotorSettleTime__ACPI_FDI_DATA, Mem_T.Type_unnamed_tag_28, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, sdv_isr_routine, sdv_pDpcContext, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, yogi_error, Mem_T.CompletionRoutine__IO_STACK_LOCATION;



implementation {:origName "FdcInternalDeviceControl"} FdcInternalDeviceControl(actual_DeviceObject_31: int, actual_Irp_18: int) returns (Tmp_398: int)
{
  var {:scalar} ntStatus_10: int;
  var {:pointer} extensionHeader_2: int;
  var {:pointer} DeviceObject_31: int;
  var {:pointer} Irp_18: int;
  var vslice_dummy_var_86: int;
  var vslice_dummy_var_87: int;

  anon0:
    DeviceObject_31 := actual_DeviceObject_31;
    Irp_18 := actual_Irp_18;
    ntStatus_10 := 0;
    call vslice_dummy_var_87 := sdv_IoGetCurrentIrpStackLocation(Irp_18);
    call vslice_dummy_var_86 := KeInsertQueueDpc(0, 0, 0);
    assume {:nonnull} DeviceObject_31 != 0;
    assume DeviceObject_31 > 0;
    extensionHeader_2 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_31)];
    assume {:nonnull} extensionHeader_2 != 0;
    assume extensionHeader_2 > 0;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(extensionHeader_2)] != 0;
    call ntStatus_10 := FdcFdoInternalDeviceControl(DeviceObject_31, Irp_18);
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} yogi_error != 1;
    goto L24;

  L24:
    Tmp_398 := ntStatus_10;
    goto LM2;

  LM2:
    return;

  anon8_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon7_Then:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(extensionHeader_2)] == 0;
    call ntStatus_10 := FdcPdoInternalDeviceControl(DeviceObject_31, Irp_18);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} yogi_error != 1;
    goto L24;

  anon9_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "_sdv_init1"} _sdv_init1();
  modifies alloc, FdcDefaultControllerNumber, PagingReferenceCount;



implementation {:origName "_sdv_init1"} _sdv_init1()
{
  var vslice_dummy_var_88: int;

  anon0:
    call vslice_dummy_var_88 := __HAVOC_malloc(4);
    FdcDefaultControllerNumber := 0;
    PagingReferenceCount := 0;
    assume PagingMutex == 0;
    assume NumberOfBuffers == 0;
    assume BufferSize == 0;
    assume Model30 == 0;
    assume NotConfigurable == 0;
    return;
}



procedure {:origName "FcReportFdcInformation"} FcReportFdcInformation(actual_PdoExtension: int, actual_FdoExtension_6: int, actual_IrpSp: int);
  modifies alloc, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.BufferSize__FDC_INFO, Mem_T.BufferCount__FDC_INFO, Mem_T.BuffersRequested__FDC_FDO_EXTENSION, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.Virtual__TRANSFER_BUFFER, Mem_T.AcpiBios__FDC_INFO, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.DriveNumber__ACPI_FDI_DATA, Mem_T.DeviceType__ACPI_FDI_DATA, Mem_T.MaxCylinderNumber__ACPI_FDI_DATA, Mem_T.MaxSectorNumber__ACPI_FDI_DATA, Mem_T.MaxHeadNumber__ACPI_FDI_DATA, Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA, Mem_T.HeadLoadTime__ACPI_FDI_DATA, Mem_T.MotorOffTime__ACPI_FDI_DATA, Mem_T.SectorLengthCode__ACPI_FDI_DATA, Mem_T.SectorPerTrack__ACPI_FDI_DATA, Mem_T.ReadWriteGapLength__ACPI_FDI_DATA, Mem_T.DataTransferLength__ACPI_FDI_DATA, Mem_T.FormatGapLength__ACPI_FDI_DATA, Mem_T.FormatFillCharacter__ACPI_FDI_DATA, Mem_T.HeadSettleTime__ACPI_FDI_DATA, Mem_T.MotorSettleTime__ACPI_FDI_DATA, Mem_T.Type_unnamed_tag_28, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CompletionRoutine__IO_STACK_LOCATION, yogi_error;



implementation {:origName "FcReportFdcInformation"} FcReportFdcInformation(actual_PdoExtension: int, actual_FdoExtension_6: int, actual_IrpSp: int)
{
  var {:scalar} i_7: int;
  var {:scalar} Tmp_402: int;
  var {:scalar} Tmp_404: int;
  var {:pointer} Tmp_405: int;
  var {:pointer} argumentSize_2: int;
  var {:pointer} fdiData: int;
  var {:pointer} Tmp_406: int;
  var {:scalar} bufferCount: int;
  var {:scalar} Tmp_407: int;
  var {:scalar} Tmp_408: int;
  var {:scalar} ntStatus_11: int;
  var {:scalar} Tmp_409: int;
  var {:scalar} Tmp_410: int;
  var {:scalar} Tmp_411: int;
  var {:pointer} Tmp_412: int;
  var {:scalar} Tmp_413: int;
  var {:pointer} argumentType: int;
  var {:pointer} fdcInfo_1: int;
  var {:scalar} bufferSize: int;
  var {:pointer} Tmp_415: int;
  var {:pointer} PdoExtension: int;
  var {:pointer} FdoExtension_6: int;
  var {:pointer} IrpSp: int;
  var vslice_dummy_var_89: int;
  var vslice_dummy_var_90: int;

  anon0:
    call vslice_dummy_var_89 := __HAVOC_malloc(4);
    call fdiData := __HAVOC_malloc(4);
    PdoExtension := actual_PdoExtension;
    FdoExtension_6 := actual_FdoExtension_6;
    IrpSp := actual_IrpSp;
    call Tmp_405 := __HAVOC_malloc(4);
    call argumentSize_2 := __HAVOC_malloc(64);
    call Tmp_406 := __HAVOC_malloc(4);
    call argumentType := __HAVOC_malloc(64);
    assume {:nonnull} argumentType != 0;
    assume argumentType > 0;
    Mem_T.INT4[argumentType] := 0;
    assume {:nonnull} argumentSize_2 != 0;
    assume argumentSize_2 > 0;
    Mem_T.INT4[argumentSize_2] := 0;
    call ExAcquireFastMutex(0);
    PagingReferenceCount := PagingReferenceCount + 1;
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} PagingReferenceCount == 1;
    call MmResetDriverPaging(0);
    goto L17;

  L17:
    call ExReleaseFastMutex(0);
    assume {:nonnull} IrpSp != 0;
    assume IrpSp > 0;
    fdcInfo_1 := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(IrpSp)))];
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    bufferCount := Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo_1)];
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    bufferSize := Mem_T.BufferSize__FDC_INFO[BufferSize__FDC_INFO(fdcInfo_1)];
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    Mem_T.BufferSize__FDC_INFO[BufferSize__FDC_INFO(fdcInfo_1)] := 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo_1)] := 0;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    goto anon28_Then, anon28_Else;

  anon28_Else:
    assume {:partition} Mem_T.BufferSize__FDC_FDO_EXTENSION[BufferSize__FDC_FDO_EXTENSION(FdoExtension_6)] >= bufferSize;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    Mem_T.BufferSize__FDC_INFO[BufferSize__FDC_INFO(fdcInfo_1)] := bufferSize;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} bufferCount > Mem_T.BufferCount__FDC_FDO_EXTENSION[BufferCount__FDC_FDO_EXTENSION(FdoExtension_6)];
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    Tmp_407 := Mem_T.BufferCount__FDC_FDO_EXTENSION[BufferCount__FDC_FDO_EXTENSION(FdoExtension_6)];
    goto L41;

  L41:
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo_1)] := Tmp_407;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo_1)] > Mem_T.BuffersRequested__FDC_FDO_EXTENSION[BuffersRequested__FDC_FDO_EXTENSION(FdoExtension_6)];
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    Tmp_411 := Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo_1)];
    goto L45;

  L45:
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    Mem_T.BuffersRequested__FDC_FDO_EXTENSION[BuffersRequested__FDC_FDO_EXTENSION(FdoExtension_6)] := Tmp_411;
    goto L36;

  L36:
    i_7 := 0;
    goto L46;

  L46:
    call i_7, Tmp_402, Tmp_404, Tmp_405, Tmp_406, Tmp_410, Tmp_412, Tmp_413, Tmp_415 := FcReportFdcInformation_loop_L46(i_7, Tmp_402, Tmp_404, Tmp_405, Tmp_406, Tmp_410, Tmp_412, Tmp_413, fdcInfo_1, Tmp_415, FdoExtension_6);
    goto L46_last;

  anon23_Else:
    assume {:partition} Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo_1)] > i_7;
    Tmp_413 := i_7;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    Tmp_406 := Mem_T.BufferAddress__FDC_INFO[BufferAddress__FDC_INFO(fdcInfo_1)];
    Tmp_404 := i_7;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    Tmp_415 := Mem_T.TransferBuffers__FDC_FDO_EXTENSION[TransferBuffers__FDC_FDO_EXTENSION(FdoExtension_6)];
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    assume {:nonnull} Tmp_415 != 0;
    assume Tmp_415 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(Logical__TRANSFER_BUFFER(Tmp_406 + Tmp_413 * 24))] := Mem_T.LowPart__LUID[LowPart__LUID(Logical__TRANSFER_BUFFER(Tmp_415 + Tmp_404 * 24))];
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    assume {:nonnull} Tmp_415 != 0;
    assume Tmp_415 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(Logical__TRANSFER_BUFFER(Tmp_406 + Tmp_413 * 24))] := Mem_T.HighPart__LUID[HighPart__LUID(Logical__TRANSFER_BUFFER(Tmp_415 + Tmp_404 * 24))];
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    assume {:nonnull} Tmp_415 != 0;
    assume Tmp_415 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(Logical__TRANSFER_BUFFER(Tmp_406 + Tmp_413 * 24)))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(Logical__TRANSFER_BUFFER(Tmp_415 + Tmp_404 * 24)))];
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    assume {:nonnull} Tmp_415 != 0;
    assume Tmp_415 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(Logical__TRANSFER_BUFFER(Tmp_406 + Tmp_413 * 24)))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(Logical__TRANSFER_BUFFER(Tmp_415 + Tmp_404 * 24)))];
    assume {:nonnull} Tmp_406 != 0;
    assume Tmp_406 > 0;
    assume {:nonnull} Tmp_415 != 0;
    assume Tmp_415 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(Logical__TRANSFER_BUFFER(Tmp_406 + Tmp_413 * 24))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(Logical__TRANSFER_BUFFER(Tmp_415 + Tmp_404 * 24))];
    Tmp_402 := i_7;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    Tmp_405 := Mem_T.BufferAddress__FDC_INFO[BufferAddress__FDC_INFO(fdcInfo_1)];
    Tmp_410 := i_7;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    Tmp_412 := Mem_T.TransferBuffers__FDC_FDO_EXTENSION[TransferBuffers__FDC_FDO_EXTENSION(FdoExtension_6)];
    assume {:nonnull} Tmp_405 != 0;
    assume Tmp_405 > 0;
    assume {:nonnull} Tmp_412 != 0;
    assume Tmp_412 > 0;
    Mem_T.Virtual__TRANSFER_BUFFER[Virtual__TRANSFER_BUFFER(Tmp_405 + Tmp_402 * 24)] := Mem_T.Virtual__TRANSFER_BUFFER[Virtual__TRANSFER_BUFFER(Tmp_412 + Tmp_410 * 24)];
    i_7 := i_7 + 1;
    goto anon23_Else_dummy;

  anon23_Then:
    assume {:partition} i_7 >= Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo_1)];
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    Mem_T.AcpiBios__FDC_INFO[AcpiBios__FDC_INFO(fdcInfo_1)] := Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION[ACPI_BIOS__FDC_FDO_EXTENSION(FdoExtension_6)];
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} Mem_T.AcpiBios__FDC_INFO[AcpiBios__FDC_INFO(fdcInfo_1)] != 0;
    i_7 := 0;
    goto L56;

  L56:
    call i_7, Tmp_408, Tmp_409 := FcReportFdcInformation_loop_L56(i_7, argumentSize_2, Tmp_408, Tmp_409, argumentType);
    goto L56_last;

  anon24_Else:
    assume {:partition} 16 > i_7;
    Tmp_408 := i_7;
    assume {:nonnull} argumentType != 0;
    assume argumentType > 0;
    Mem_T.INT4[argumentType + Tmp_408 * 4] := 0;
    Tmp_409 := i_7;
    assume {:nonnull} argumentSize_2 != 0;
    assume argumentSize_2 > 0;
    Mem_T.INT4[argumentSize_2 + Tmp_409 * 4] := 4;
    i_7 := i_7 + 1;
    goto anon24_Else_dummy;

  anon24_Then:
    assume {:partition} i_7 >= 16;
    assume {:nonnull} PdoExtension != 0;
    assume PdoExtension > 0;
    call ntStatus_11 := DeviceQueryACPI_SyncExecMethodForPackage(Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(PdoExtension)], -918272417, 0, 0, 0, 0, 16, 64, argumentType, argumentSize_2, fdiData);
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} yogi_error != 1;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} ntStatus_11 >= 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.DriveNumber__ACPI_FDI_DATA[DriveNumber__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.DriveNumber__ACPI_FDI_DATA[DriveNumber__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.DeviceType__ACPI_FDI_DATA[DeviceType__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.MaxCylinderNumber__ACPI_FDI_DATA[MaxCylinderNumber__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.MaxCylinderNumber__ACPI_FDI_DATA[MaxCylinderNumber__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.MaxSectorNumber__ACPI_FDI_DATA[MaxSectorNumber__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.MaxSectorNumber__ACPI_FDI_DATA[MaxSectorNumber__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.MaxHeadNumber__ACPI_FDI_DATA[MaxHeadNumber__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.MaxHeadNumber__ACPI_FDI_DATA[MaxHeadNumber__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA[StepRateHeadUnloadTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA[StepRateHeadUnloadTime__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.HeadLoadTime__ACPI_FDI_DATA[HeadLoadTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.HeadLoadTime__ACPI_FDI_DATA[HeadLoadTime__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.MotorOffTime__ACPI_FDI_DATA[MotorOffTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.MotorOffTime__ACPI_FDI_DATA[MotorOffTime__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.SectorLengthCode__ACPI_FDI_DATA[SectorLengthCode__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.SectorLengthCode__ACPI_FDI_DATA[SectorLengthCode__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.SectorPerTrack__ACPI_FDI_DATA[SectorPerTrack__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.SectorPerTrack__ACPI_FDI_DATA[SectorPerTrack__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.ReadWriteGapLength__ACPI_FDI_DATA[ReadWriteGapLength__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.ReadWriteGapLength__ACPI_FDI_DATA[ReadWriteGapLength__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.DataTransferLength__ACPI_FDI_DATA[DataTransferLength__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.DataTransferLength__ACPI_FDI_DATA[DataTransferLength__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.FormatGapLength__ACPI_FDI_DATA[FormatGapLength__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.FormatGapLength__ACPI_FDI_DATA[FormatGapLength__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.FormatFillCharacter__ACPI_FDI_DATA[FormatFillCharacter__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.FormatFillCharacter__ACPI_FDI_DATA[FormatFillCharacter__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.HeadSettleTime__ACPI_FDI_DATA[HeadSettleTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.HeadSettleTime__ACPI_FDI_DATA[HeadSettleTime__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    assume {:nonnull} Mem_T.P_ACPI_FDI_DATA[fdiData] != 0;
    assume Mem_T.P_ACPI_FDI_DATA[fdiData] > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    assume {:nonnull} fdiData != 0;
    assume fdiData > 0;
    Mem_T.MotorSettleTime__ACPI_FDI_DATA[MotorSettleTime__ACPI_FDI_DATA(AcpiFdiData__FDC_INFO(fdcInfo_1))] := Mem_T.MotorSettleTime__ACPI_FDI_DATA[MotorSettleTime__ACPI_FDI_DATA(Mem_T.P_ACPI_FDI_DATA[fdiData])];
    call sdv_ExFreePool(0);
    goto L52;

  L52:
    call ExAcquireFastMutex(0);
    PagingReferenceCount := PagingReferenceCount - 1;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} PagingReferenceCount != 0;
    goto L78;

  L78:
    call ExReleaseFastMutex(0);
    goto LM2;

  LM2:
    return;

  anon33_Then:
    assume {:partition} PagingReferenceCount == 0;
    call vslice_dummy_var_90 := MmPageEntireDriver(0);
    goto L78;

  anon25_Then:
    assume {:partition} 0 > ntStatus_11;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} ntStatus_11 == -1073741772;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    goto L52;

  anon26_Then:
    assume {:partition} ntStatus_11 != -1073741772;
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    Mem_T.AcpiBios__FDC_INFO[AcpiBios__FDC_INFO(fdcInfo_1)] := Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION[ACPI_BIOS__FDC_FDO_EXTENSION(FdoExtension_6)];
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    goto L52;

  anon32_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon31_Then:
    assume {:partition} Mem_T.AcpiBios__FDC_INFO[AcpiBios__FDC_INFO(fdcInfo_1)] == 0;
    goto L52;

  anon30_Then:
    assume {:partition} Mem_T.BuffersRequested__FDC_FDO_EXTENSION[BuffersRequested__FDC_FDO_EXTENSION(FdoExtension_6)] >= Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(fdcInfo_1)];
    assume {:nonnull} FdoExtension_6 != 0;
    assume FdoExtension_6 > 0;
    Tmp_411 := Mem_T.BuffersRequested__FDC_FDO_EXTENSION[BuffersRequested__FDC_FDO_EXTENSION(FdoExtension_6)];
    goto L45;

  anon29_Then:
    assume {:partition} Mem_T.BufferCount__FDC_FDO_EXTENSION[BufferCount__FDC_FDO_EXTENSION(FdoExtension_6)] >= bufferCount;
    Tmp_407 := bufferCount;
    goto L41;

  anon28_Then:
    assume {:partition} bufferSize > Mem_T.BufferSize__FDC_FDO_EXTENSION[BufferSize__FDC_FDO_EXTENSION(FdoExtension_6)];
    goto L36;

  anon27_Then:
    assume {:partition} PagingReferenceCount != 1;
    goto L17;

  anon24_Else_dummy:
    assume false;
    return;

  L56_last:
    assume {:CounterLoop 16} {:Counter "i_7"} true;
    goto anon24_Then, anon24_Else;

  anon23_Else_dummy:
    assume false;
    return;

  L46_last:
    assume {:nonnull} fdcInfo_1 != 0;
    assume fdcInfo_1 > 0;
    goto anon23_Then, anon23_Else;
}



procedure {:origName "FcAllocateAdapterChannel"} FcAllocateAdapterChannel(actual_FdoExtension_7: int);
  modifies alloc, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, yogi_error;



implementation {:origName "FcAllocateAdapterChannel"} FcAllocateAdapterChannel(actual_FdoExtension_7: int)
{
  var {:scalar} oldIrql: int;
  var {:pointer} Tmp_416: int;
  var {:pointer} FdoExtension_7: int;
  var vslice_dummy_var_91: int;
  var vslice_dummy_var_92: int;
  var vslice_dummy_var_93: int;
  var vslice_dummy_var_94: int;

  anon0:
    call vslice_dummy_var_91 := __HAVOC_malloc(4);
    FdoExtension_7 := actual_FdoExtension_7;
    assume {:nonnull} FdoExtension_7 != 0;
    assume FdoExtension_7 > 0;
    Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION[AdapterChannelRefCount__FDC_FDO_EXTENSION(FdoExtension_7)] := Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION[AdapterChannelRefCount__FDC_FDO_EXTENSION(FdoExtension_7)] + 1;
    assume {:nonnull} FdoExtension_7 != 0;
    assume FdoExtension_7 > 0;
    goto anon5_Then, anon5_Else;

  anon5_Else:
    assume {:partition} Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION[AdapterChannelRefCount__FDC_FDO_EXTENSION(FdoExtension_7)] == 0;
    assume {:nonnull} FdoExtension_7 != 0;
    assume FdoExtension_7 > 0;
    call vslice_dummy_var_92 := KeResetEvent(AllocateAdapterChannelEvent__FDC_FDO_EXTENSION(FdoExtension_7));
    call Tmp_416 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_416 != 0;
    assume Tmp_416 > 0;
    Mem_T.INT4[Tmp_416] := oldIrql;
    call sdv_KeRaiseIrql(2, Tmp_416);
    assume {:nonnull} Tmp_416 != 0;
    assume Tmp_416 > 0;
    oldIrql := Mem_T.INT4[Tmp_416];
    assume {:nonnull} FdoExtension_7 != 0;
    assume FdoExtension_7 > 0;
    call vslice_dummy_var_93 := sdv_IoAllocateAdapterChannel(0, 0, Mem_T.NumberOfMapRegisters__FDC_FDO_EXTENSION[NumberOfMapRegisters__FDC_FDO_EXTENSION(FdoExtension_7)], li2bplFunctionConstant228, 0);
    call sdv_KeLowerIrql(oldIrql);
    call vslice_dummy_var_94 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} yogi_error != 1;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon6_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon5_Then:
    assume {:partition} Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION[AdapterChannelRefCount__FDC_FDO_EXTENSION(FdoExtension_7)] != 0;
    goto L1;
}



procedure {:origName "FcStartCommand"} FcStartCommand(actual_FdoExtension_8: int, actual_FifoInBuffer_1: int, actual_FifoOutBuffer_1: int, actual_IoHandle_1: int, actual_IoOffset_1: int, actual_TransferBytes_1: int, actual_AllowLongDelay_3: int) returns (Tmp_418: int);
  modifies alloc, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.INT4;



implementation {:origName "FcStartCommand"} FcStartCommand(actual_FdoExtension_8: int, actual_FifoInBuffer_1: int, actual_FifoOutBuffer_1: int, actual_IoHandle_1: int, actual_IoOffset_1: int, actual_TransferBytes_1: int, actual_AllowLongDelay_3: int) returns (Tmp_418: int)
{
  var {:pointer} SD1: int;
  var {:pointer} structPtr888sdv: int;
  var {:scalar} i_8: int;
  var {:scalar} Tmp_420: int;
  var {:scalar} Tmp_421: int;
  var {:scalar} Tmp_422: int;
  var {:scalar} Tmp_423: int;
  var {:pointer} sdv_221: int;
  var {:scalar} ntStatus2: int;
  var {:scalar} Tmp_424: int;
  var {:scalar} Tmp_425: int;
  var {:scalar} Tmp_426: int;
  var {:scalar} Tmp_427: int;
  var {:scalar} Tmp_428: int;
  var {:scalar} Tmp_429: int;
  var {:pointer} sdv_222: int;
  var {:scalar} Tmp_430: int;
  var {:scalar} Tmp_431: int;
  var {:dopa} {:scalar} status0: int;
  var {:pointer} sdv_224: int;
  var {:scalar} sdv: int;
  var {:scalar} Tmp_432: int;
  var {:scalar} ntStatus_12: int;
  var {:scalar} sdv_1: int;
  var {:scalar} Tmp_433: int;
  var {:scalar} Tmp_434: int;
  var {:scalar} Tmp_435: int;
  var {:scalar} Tmp_437: int;
  var {:scalar} Tmp_438: int;
  var {:scalar} Tmp_439: int;
  var {:scalar} Command_1: int;
  var {:scalar} Tmp_441: int;
  var {:scalar} Tmp_444: int;
  var {:pointer} sdv_229: int;
  var {:scalar} Tmp_445: int;
  var {:pointer} FdoExtension_8: int;
  var {:pointer} FifoInBuffer_1: int;
  var {:scalar} IoOffset_1: int;
  var {:scalar} TransferBytes_1: int;
  var {:scalar} AllowLongDelay_3: int;
  var vslice_dummy_var_95: int;
  var vslice_dummy_var_96: int;

  anon0:
    call status0 := __HAVOC_malloc(4);
    call sdv := __HAVOC_malloc(20);
    call sdv_1 := __HAVOC_malloc(20);
    FdoExtension_8 := actual_FdoExtension_8;
    FifoInBuffer_1 := actual_FifoInBuffer_1;
    IoOffset_1 := actual_IoOffset_1;
    TransferBytes_1 := actual_TransferBytes_1;
    AllowLongDelay_3 := actual_AllowLongDelay_3;
    i_8 := 0;
    assume {:nonnull} FifoInBuffer_1 != 0;
    assume FifoInBuffer_1 > 0;
    Command_1 := Mem_T.INT4[FifoInBuffer_1];
    Tmp_422 := BAND(Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_426 := Tmp_422;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} Mem_T.FirstResultByte__COMMAND_TABLE[FirstResultByte__COMMAND_TABLE(CommandTable + Tmp_426 * 28)] == 0;
    assume {:nonnull} FdoExtension_8 != 0;
    assume FdoExtension_8 > 0;
    Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION[CommandHasResultPhase__FDC_FDO_EXTENSION(FdoExtension_8)] := 0;
    goto L118;

  L118:
    Tmp_421 := BAND(Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_441 := Tmp_421;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_441 * 28)] == 1;
    call sdv_221 := sdv_MmGetMdlVirtualAddress(0);
    call structPtr888sdv := sdv_IoMapTransfer(0, 0, 0, 0, 0, 0);
    assume {:nonnull} sdv != 0;
    assume sdv > 0;
    assume {:nonnull} structPtr888sdv != 0;
    assume structPtr888sdv > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(sdv)] := Mem_T.LowPart__LUID[LowPart__LUID(structPtr888sdv)];
    assume {:nonnull} sdv != 0;
    assume sdv > 0;
    assume {:nonnull} structPtr888sdv != 0;
    assume structPtr888sdv > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(sdv)] := Mem_T.HighPart__LUID[HighPart__LUID(structPtr888sdv)];
    assume {:nonnull} sdv != 0;
    assume sdv > 0;
    assume {:nonnull} structPtr888sdv != 0;
    assume structPtr888sdv > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(sdv))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(structPtr888sdv))];
    assume {:nonnull} sdv != 0;
    assume sdv > 0;
    assume {:nonnull} structPtr888sdv != 0;
    assume structPtr888sdv > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(sdv))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(structPtr888sdv))];
    assume {:nonnull} sdv != 0;
    assume sdv > 0;
    assume {:nonnull} structPtr888sdv != 0;
    assume structPtr888sdv > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(sdv)] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(structPtr888sdv)];
    goto L26;

  L26:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} Command_1 == 17;
    assume {:nonnull} FdoExtension_8 != 0;
    assume FdoExtension_8 > 0;
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(FdoExtension_8)] != 0;
    Command_1 := BOR(Command_1, 128);
    goto L27;

  L27:
    Tmp_438 := BAND(Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_434 := BAND(Command_1, BNOT(BOR(BOR(BOR(BOR(1, 2), 4), 8), 16)));
    Tmp_435 := Tmp_438;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    Tmp_432 := BOR(Mem_T.OpCode__COMMAND_TABLE[OpCode__COMMAND_TABLE(CommandTable + Tmp_435 * 28)], Tmp_434);
    call ntStatus_12 := FcSendByte(Tmp_432, FdoExtension_8, AllowLongDelay_3);
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} ntStatus_12 >= 0;
    i_8 := 1;
    goto L39;

  L39:
    call i_8, Tmp_420, Tmp_424, Tmp_430, ntStatus_12, Tmp_437, Tmp_439 := FcStartCommand_loop_L39(i_8, Tmp_420, Tmp_424, Tmp_430, ntStatus_12, Tmp_437, Tmp_439, Command_1, FdoExtension_8, FifoInBuffer_1, AllowLongDelay_3);
    goto L39_last;

  anon52_Else:
    assume {:partition} Mem_T.NumberOfParameters__COMMAND_TABLE[NumberOfParameters__COMMAND_TABLE(CommandTable + Tmp_424 * 28)] >= i_8;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} ntStatus_12 >= 0;
    Tmp_420 := i_8;
    assume {:nonnull} FifoInBuffer_1 != 0;
    assume FifoInBuffer_1 > 0;
    Tmp_437 := Mem_T.INT4[FifoInBuffer_1 + Tmp_420 * 4];
    call ntStatus_12 := FcSendByte(Tmp_437, FdoExtension_8, AllowLongDelay_3);
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} Command_1 == 15;
    Tmp_430 := i_8;
    assume {:nonnull} FifoInBuffer_1 != 0;
    assume FifoInBuffer_1 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} BAND(Mem_T.INT4[FifoInBuffer_1 + Tmp_430 * 4], 128) == 0;
    goto L48;

  L48:
    i_8 := i_8 + 1;
    goto L48_dummy;

  anon53_Then:
    assume {:partition} BAND(Mem_T.INT4[FifoInBuffer_1 + Tmp_430 * 4], 128) != 0;
    goto L37;

  L37:
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} ntStatus_12 >= 0;
    goto L52;

  L52:
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} ntStatus_12 >= 0;
    goto L54;

  L54:
    Tmp_418 := ntStatus_12;
    return;

  anon46_Then:
    assume {:partition} 0 > ntStatus_12;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} ntStatus_12 == -1073741661;
    Tmp_429 := BAND(Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    goto L54;

  anon47_Then:
    assume {:partition} ntStatus_12 != -1073741661;
    goto L54;

  anon42_Then:
    assume {:partition} 0 > ntStatus_12;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} i_8 == 2;
    Tmp_423 := BAND(Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_428 := Tmp_423;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} Mem_T.AlwaysImplemented__COMMAND_TABLE[AlwaysImplemented__COMMAND_TABLE(CommandTable + Tmp_428 * 28)] == 0;
    call ntStatus2 := FcGetByte(status0, FdoExtension_8, AllowLongDelay_3);
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} ntStatus2 >= 0;
    assume {:nonnull} status0 != 0;
    assume status0 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} Mem_T.INT4[status0] != 128;
    ntStatus_12 := -1073741464;
    assume {:nonnull} FdoExtension_8 != 0;
    assume FdoExtension_8 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_8)] := 1;
    goto L57;

  L57:
    Tmp_425 := BAND(Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_427 := Tmp_425;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_427 * 28)] == 1;
    call sdv_222 := sdv_MmGetMdlVirtualAddress(0);
    call vslice_dummy_var_95 := sdv_IoFlushAdapterBuffers(0, 0, 0, 0, TransferBytes_1, 0);
    goto L52;

  anon55_Then:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_427 * 28)] != 1;
    Tmp_444 := BAND(Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_431 := Tmp_444;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_431 * 28)] == 2;
    call sdv_224 := sdv_MmGetMdlVirtualAddress(0);
    call vslice_dummy_var_96 := sdv_IoFlushAdapterBuffers(0, 0, 0, 0, TransferBytes_1, 1);
    goto L52;

  anon56_Then:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_431 * 28)] != 2;
    goto L52;

  anon49_Then:
    assume {:partition} Mem_T.INT4[status0] == 128;
    assume {:nonnull} FdoExtension_8 != 0;
    assume FdoExtension_8 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_8)] := 0;
    goto L57;

  anon48_Then:
    assume {:partition} 0 > ntStatus2;
    ntStatus_12 := ntStatus2;
    goto L57;

  anon54_Then:
    assume {:partition} Mem_T.AlwaysImplemented__COMMAND_TABLE[AlwaysImplemented__COMMAND_TABLE(CommandTable + Tmp_428 * 28)] != 0;
    goto L57;

  anon45_Then:
    assume {:partition} i_8 != 2;
    goto L57;

  anon44_Then:
    assume {:partition} Command_1 != 15;
    goto L48;

  anon43_Then:
    assume {:partition} 0 > ntStatus_12;
    goto L37;

  anon52_Then:
    assume {:partition} i_8 > Mem_T.NumberOfParameters__COMMAND_TABLE[NumberOfParameters__COMMAND_TABLE(CommandTable + Tmp_424 * 28)];
    goto L37;

  anon41_Then:
    assume {:partition} 0 > ntStatus_12;
    goto L37;

  anon40_Then:
    assume {:partition} Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(FdoExtension_8)] == 0;
    goto L27;

  anon39_Then:
    assume {:partition} Command_1 != 17;
    goto L27;

  anon51_Then:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_441 * 28)] != 1;
    Tmp_433 := BAND(Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_445 := Tmp_433;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_445 * 28)] == 2;
    call sdv_229 := sdv_MmGetMdlVirtualAddress(0);
    call SD1 := sdv_IoMapTransfer(0, 0, 0, 0, 0, 1);
    assume {:nonnull} SD1 != 0;
    assume SD1 > 0;
    assume {:nonnull} sdv_1 != 0;
    assume sdv_1 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(sdv_1)] := Mem_T.LowPart__LUID[LowPart__LUID(SD1)];
    assume {:nonnull} SD1 != 0;
    assume SD1 > 0;
    assume {:nonnull} sdv_1 != 0;
    assume sdv_1 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(sdv_1)] := Mem_T.HighPart__LUID[HighPart__LUID(SD1)];
    assume {:nonnull} SD1 != 0;
    assume SD1 > 0;
    assume {:nonnull} sdv_1 != 0;
    assume sdv_1 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(sdv_1))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(SD1))];
    assume {:nonnull} SD1 != 0;
    assume SD1 > 0;
    assume {:nonnull} sdv_1 != 0;
    assume sdv_1 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(sdv_1))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(SD1))];
    assume {:nonnull} SD1 != 0;
    assume SD1 > 0;
    assume {:nonnull} sdv_1 != 0;
    assume sdv_1 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(sdv_1)] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(SD1)];
    goto L26;

  anon57_Then:
    assume {:partition} Mem_T.DataTransfer__COMMAND_TABLE[DataTransfer__COMMAND_TABLE(CommandTable + Tmp_445 * 28)] != 2;
    goto L26;

  anon50_Then:
    assume {:partition} Mem_T.FirstResultByte__COMMAND_TABLE[FirstResultByte__COMMAND_TABLE(CommandTable + Tmp_426 * 28)] != 0;
    assume {:nonnull} FdoExtension_8 != 0;
    assume FdoExtension_8 > 0;
    Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION[CommandHasResultPhase__FDC_FDO_EXTENSION(FdoExtension_8)] := 1;
    goto L118;

  L48_dummy:
    assume false;
    return;

  L39_last:
    Tmp_439 := BAND(Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_424 := Tmp_439;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon52_Then, anon52_Else;
}



procedure {:origName "FcIssueCommand"} FcIssueCommand(actual_FdoExtension_9: int, actual_FifoInBuffer_2: int, actual_FifoOutBuffer_2: int, actual_IoHandle_2: int, actual_IoOffset_2: int, actual_TransferBytes_2: int) returns (Tmp_447: int);
  modifies Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.SignalState__DISPATCHER_HEADER, alloc, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.INT4, yogi_error;



implementation {:origName "FcIssueCommand"} FcIssueCommand(actual_FdoExtension_9: int, actual_FifoInBuffer_2: int, actual_FifoOutBuffer_2: int, actual_IoHandle_2: int, actual_IoOffset_2: int, actual_TransferBytes_2: int) returns (Tmp_447: int)
{
  var {:scalar} Tmp_448: int;
  var {:scalar} Tmp_449: int;
  var {:scalar} Tmp_451: int;
  var {:scalar} Tmp_452: int;
  var {:scalar} ntStatus_13: int;
  var {:scalar} Tmp_453: int;
  var {:scalar} Command_2: int;
  var {:scalar} Tmp_454: int;
  var {:pointer} FdoExtension_9: int;
  var {:pointer} FifoInBuffer_2: int;
  var {:pointer} FifoOutBuffer_2: int;
  var {:pointer} IoHandle_2: int;
  var {:scalar} IoOffset_2: int;
  var {:scalar} TransferBytes_2: int;
  var vslice_dummy_var_97: int;

  anon0:
    FdoExtension_9 := actual_FdoExtension_9;
    FifoInBuffer_2 := actual_FifoInBuffer_2;
    FifoOutBuffer_2 := actual_FifoOutBuffer_2;
    IoHandle_2 := actual_IoHandle_2;
    IoOffset_2 := actual_IoOffset_2;
    TransferBytes_2 := actual_TransferBytes_2;
    assume {:nonnull} FdoExtension_9 != 0;
    assume FdoExtension_9 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_9)] != 0;
    Tmp_447 := -1073741661;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon23_Then:
    assume {:partition} Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_9)] == 0;
    assume {:nonnull} FifoInBuffer_2 != 0;
    assume FifoInBuffer_2 > 0;
    Command_2 := Mem_T.INT4[FifoInBuffer_2];
    Tmp_451 := BAND(Command_2, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_448 := Tmp_451;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} Mem_T.InterruptExpected__COMMAND_TABLE[InterruptExpected__COMMAND_TABLE(CommandTable + Tmp_448 * 28)] != 0;
    assume {:nonnull} FdoExtension_9 != 0;
    assume FdoExtension_9 > 0;
    Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION[CurrentDeviceObject__FDC_FDO_EXTENSION(FdoExtension_9)] := Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(FdoExtension_9)];
    assume {:nonnull} FdoExtension_9 != 0;
    assume FdoExtension_9 > 0;
    Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(FdoExtension_9)] := 1;
    Tmp_454 := BAND(Command_2, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_449 := Tmp_454;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon25_Then, anon25_Else;

  anon25_Else:
    assume {:partition} Mem_T.FirstResultByte__COMMAND_TABLE[FirstResultByte__COMMAND_TABLE(CommandTable + Tmp_449 * 28)] == 0;
    assume {:nonnull} FdoExtension_9 != 0;
    assume FdoExtension_9 > 0;
    Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION[CommandHasResultPhase__FDC_FDO_EXTENSION(FdoExtension_9)] := 0;
    goto L62;

  L62:
    assume {:nonnull} FdoExtension_9 != 0;
    assume FdoExtension_9 > 0;
    call vslice_dummy_var_97 := KeResetEvent(InterruptEvent__FDC_FDO_EXTENSION(FdoExtension_9));
    goto L15;

  L15:
    call ntStatus_13 := FcStartCommand(FdoExtension_9, FifoInBuffer_2, FifoOutBuffer_2, IoHandle_2, IoOffset_2, TransferBytes_2, 1);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} ntStatus_13 >= 0;
    Tmp_452 := BAND(Command_2, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_453 := Tmp_452;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon26_Then, anon26_Else;

  anon26_Else:
    assume {:partition} Mem_T.InterruptExpected__COMMAND_TABLE[InterruptExpected__COMMAND_TABLE(CommandTable + Tmp_453 * 28)] != 0;
    assume {:nonnull} FdoExtension_9 != 0;
    assume FdoExtension_9 > 0;
    call ntStatus_13 := KeWaitForSingleObject(0, 0, 0, 0, InterruptDelay__FDC_FDO_EXTENSION(FdoExtension_9));
    goto anon27_Then, anon27_Else;

  anon27_Else:
    assume {:partition} yogi_error != 1;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} ntStatus_13 == 258;
    ntStatus_13 := -1073741661;
    assume {:nonnull} FdoExtension_9 != 0;
    assume FdoExtension_9 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_9)] := 1;
    goto L30;

  L30:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} ntStatus_13 >= 0;
    goto L39;

  L39:
    call ntStatus_13 := FcFinishCommand(FdoExtension_9, FifoInBuffer_2, FifoOutBuffer_2, IoHandle_2, IoOffset_2, TransferBytes_2, 1);
    goto L27;

  L27:
    Tmp_447 := ntStatus_13;
    goto L1;

  anon20_Then:
    assume {:partition} 0 > ntStatus_13;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} ntStatus_13 == -1073741661;
    goto L39;

  anon22_Then:
    assume {:partition} ntStatus_13 != -1073741661;
    goto L27;

  anon21_Then:
    assume {:partition} ntStatus_13 != 258;
    goto L30;

  anon27_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon26_Then:
    assume {:partition} Mem_T.InterruptExpected__COMMAND_TABLE[InterruptExpected__COMMAND_TABLE(CommandTable + Tmp_453 * 28)] == 0;
    goto L30;

  anon19_Then:
    assume {:partition} 0 > ntStatus_13;
    goto L27;

  anon25_Then:
    assume {:partition} Mem_T.FirstResultByte__COMMAND_TABLE[FirstResultByte__COMMAND_TABLE(CommandTable + Tmp_449 * 28)] != 0;
    assume {:nonnull} FdoExtension_9 != 0;
    assume FdoExtension_9 > 0;
    Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION[CommandHasResultPhase__FDC_FDO_EXTENSION(FdoExtension_9)] := 1;
    goto L62;

  anon24_Then:
    assume {:partition} Mem_T.InterruptExpected__COMMAND_TABLE[InterruptExpected__COMMAND_TABLE(CommandTable + Tmp_448 * 28)] == 0;
    goto L15;
}



procedure {:origName "FdcEnumerateAcpiBios"} FdcEnumerateAcpiBios(actual_DeviceObject_32: int) returns (Tmp_455: int);
  modifies alloc, Mem_T.BusNumber__FDC_FDO_EXTENSION, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.INT4, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT, Mem_T.NumPDOs__FDC_FDO_EXTENSION, Mem_T.Length_unnamed_tag_18, sdv_io_create_device_called, Mem_T.P_DEVICE_OBJECT, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, sdv_isr_routine, sdv_pDpcContext, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, yogi_error;



implementation {:origName "FdcEnumerateAcpiBios"} FdcEnumerateAcpiBios(actual_DeviceObject_32: int) returns (Tmp_455: int)
{
  var {:scalar} newlyPresent: int;
  var {:scalar} alreadyEnumerated: int;
  var {:pointer} pdoExtension_2: int;
  var {:pointer} sdv_234: int;
  var {:scalar} ntStatus_14: int;
  var {:pointer} fdoExtension_6: int;
  var {:pointer} Tmp_456: int;
  var {:scalar} newlyMissing: int;
  var {:pointer} Tmp_457: int;
  var {:scalar} Tmp_459: int;
  var {:pointer} entry_1: int;
  var {:scalar} Tmp_460: int;
  var {:scalar} peripheralNumber: int;
  var {:pointer} DeviceObject_32: int;

  anon0:
    DeviceObject_32 := actual_DeviceObject_32;
    call Tmp_456 := __HAVOC_malloc(16);
    call Tmp_457 := __HAVOC_malloc(16);
    ntStatus_14 := 0;
    assume {:nonnull} DeviceObject_32 != 0;
    assume DeviceObject_32 > 0;
    fdoExtension_6 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_32)];
    pdoExtension_2 := 0;
    assume {:nonnull} fdoExtension_6 != 0;
    assume fdoExtension_6 > 0;
    Mem_T.BusNumber__FDC_FDO_EXTENSION[BusNumber__FDC_FDO_EXTENSION(fdoExtension_6)] := 0;
    peripheralNumber := 0;
    goto L16;

  L16:
    call newlyPresent, alreadyEnumerated, pdoExtension_2, sdv_234, ntStatus_14, Tmp_456, newlyMissing, Tmp_457, Tmp_459, entry_1, Tmp_460, peripheralNumber := FdcEnumerateAcpiBios_loop_L16(newlyPresent, alreadyEnumerated, pdoExtension_2, sdv_234, ntStatus_14, fdoExtension_6, Tmp_456, newlyMissing, Tmp_457, Tmp_459, entry_1, Tmp_460, peripheralNumber, DeviceObject_32);
    goto L16_last;

  anon37_Else:
    assume {:partition} 3 >= peripheralNumber;
    alreadyEnumerated := 0;
    newlyMissing := 0;
    newlyPresent := 0;
    assume {:nonnull} fdoExtension_6 != 0;
    assume fdoExtension_6 > 0;
    entry_1 := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(PDOs__FDC_FDO_EXTENSION(fdoExtension_6))];
    goto L22;

  L22:
    call pdoExtension_2, sdv_234, entry_1 := FdcEnumerateAcpiBios_loop_L22(pdoExtension_2, sdv_234, ntStatus_14, entry_1, peripheralNumber);
    goto L22_last;

  anon38_Else:
    goto anon40_Then, anon40_Else;

  anon40_Else:
    assume {:partition} ntStatus_14 >= 0;
    call sdv_234 := sdv_containing_record(entry_1, 20);
    pdoExtension_2 := sdv_234;
    assume {:nonnull} pdoExtension_2 != 0;
    assume pdoExtension_2 > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} Mem_T.PeripheralNumber__FDC_PDO_EXTENSION[PeripheralNumber__FDC_PDO_EXTENSION(pdoExtension_2)] == peripheralNumber;
    assume {:nonnull} pdoExtension_2 != 0;
    assume pdoExtension_2 > 0;
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(pdoExtension_2)] == 0;
    alreadyEnumerated := 1;
    goto L23;

  L23:
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} alreadyEnumerated != 0;
    assume {:nonnull} fdoExtension_6 != 0;
    assume fdoExtension_6 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension_6)] != 0;
    Tmp_460 := peripheralNumber;
    assume {:nonnull} fdoExtension_6 != 0;
    assume fdoExtension_6 > 0;
    Tmp_456 := Mem_T.DrivePresent__ACPI_FDE_ENUM_TABLE[DrivePresent__ACPI_FDE_ENUM_TABLE(ACPI_FDE_Data__FDC_FDO_EXTENSION(fdoExtension_6))];
    assume {:nonnull} Tmp_456 != 0;
    assume Tmp_456 > 0;
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} Mem_T.INT4[Tmp_456 + Tmp_460 * 4] != 0;
    goto L39;

  L39:
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} newlyPresent != 0;
    call FdcCreateFloppyPdo(fdoExtension_6, peripheralNumber);
    goto L44;

  L44:
    peripheralNumber := peripheralNumber + 1;
    goto L44_dummy;

  anon45_Then:
    assume {:partition} newlyPresent == 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} newlyMissing != 0;
    assume {:nonnull} pdoExtension_2 != 0;
    assume pdoExtension_2 > 0;
    Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(pdoExtension_2)] := 1;
    goto L44;

  anon46_Then:
    assume {:partition} newlyMissing == 0;
    goto L44;

  anon51_Then:
    assume {:partition} Mem_T.INT4[Tmp_456 + Tmp_460 * 4] == 0;
    newlyMissing := 1;
    goto L39;

  anon43_Then:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension_6)] == 0;
    assume {:nonnull} fdoExtension_6 != 0;
    assume fdoExtension_6 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension_6)] != 0;
    call ntStatus_14 := FdcProbeFloppyDevice(DeviceObject_32, peripheralNumber);
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} yogi_error != 1;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} ntStatus_14 < 0;
    newlyMissing := 1;
    goto L39;

  anon47_Then:
    assume {:partition} 0 <= ntStatus_14;
    goto L39;

  anon52_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  LM2:
    return;

  anon44_Then:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension_6)] == 0;
    goto L39;

  anon39_Then:
    assume {:partition} alreadyEnumerated == 0;
    assume {:nonnull} fdoExtension_6 != 0;
    assume fdoExtension_6 > 0;
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension_6)] != 0;
    Tmp_459 := peripheralNumber;
    assume {:nonnull} fdoExtension_6 != 0;
    assume fdoExtension_6 > 0;
    Tmp_457 := Mem_T.DrivePresent__ACPI_FDE_ENUM_TABLE[DrivePresent__ACPI_FDE_ENUM_TABLE(ACPI_FDE_Data__FDC_FDO_EXTENSION(fdoExtension_6))];
    assume {:nonnull} Tmp_457 != 0;
    assume Tmp_457 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} Mem_T.INT4[Tmp_457 + Tmp_459 * 4] != 0;
    newlyPresent := 1;
    goto L39;

  anon53_Then:
    assume {:partition} Mem_T.INT4[Tmp_457 + Tmp_459 * 4] == 0;
    goto L39;

  anon42_Then:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(fdoExtension_6)] == 0;
    assume {:nonnull} fdoExtension_6 != 0;
    assume fdoExtension_6 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension_6)] != 0;
    call ntStatus_14 := FdcProbeFloppyDevice(DeviceObject_32, peripheralNumber);
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} yogi_error != 1;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} ntStatus_14 >= 0;
    newlyPresent := 1;
    goto L39;

  anon49_Then:
    assume {:partition} 0 > ntStatus_14;
    goto L39;

  anon54_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon48_Then:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(fdoExtension_6)] == 0;
    goto L39;

  anon41_Then:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(pdoExtension_2)] != 0;
    goto L30;

  L30:
    assume {:nonnull} entry_1 != 0;
    assume entry_1 > 0;
    entry_1 := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(entry_1)];
    goto L30_dummy;

  anon50_Then:
    assume {:partition} Mem_T.PeripheralNumber__FDC_PDO_EXTENSION[PeripheralNumber__FDC_PDO_EXTENSION(pdoExtension_2)] != peripheralNumber;
    goto L30;

  anon40_Then:
    assume {:partition} 0 > ntStatus_14;
    goto L23;

  anon38_Then:
    goto L23;

  anon37_Then:
    assume {:partition} peripheralNumber > 3;
    Tmp_455 := 0;
    goto LM2;

  L30_dummy:
    assume false;
    return;

  L22_last:
    goto anon38_Then, anon38_Else;

  L44_dummy:
    assume false;
    return;

  L16_last:
    assume {:CounterLoop 3} {:Counter "peripheralNumber"} true;
    goto anon37_Then, anon37_Else;
}



procedure {:origName "FdcPdoPnp"} FdcPdoPnp(actual_DeviceObject_33: int, actual_Irp_19: int) returns (Tmp_461: int);
  modifies alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.INT4, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.Length_unnamed_tag_18, Mem_T.P_DEVICE_OBJECT, Mem_T.Count__DEVICE_RELATIONS, Mem_T.Removed__FDC_PDO_EXTENSION, Mem_T.NumPDOs__FDC_FDO_EXTENSION;



implementation {:origName "FdcPdoPnp"} FdcPdoPnp(actual_DeviceObject_33: int, actual_Irp_19: int) returns (Tmp_461: int)
{
  var {:pointer} buffer: int;
  var {:pointer} Tmp_462: int;
  var {:pointer} Tmp_463: int;
  var {:pointer} devRel: int;
  var {:pointer} idString: int;
  var {:pointer} pdoExtension_3: int;
  var {:pointer} Tmp_465: int;
  var {:pointer} Tmp_466: int;
  var {:pointer} irpSp_10: int;
  var {:pointer} buffer_1: int;
  var {:pointer} Tmp_467: int;
  var {:pointer} Tmp_468: int;
  var {:scalar} length: int;
  var {:pointer} sdv_241: int;
  var {:pointer} Tmp_469: int;
  var {:pointer} Tmp_472: int;
  var {:pointer} sdv_245: int;
  var {:scalar} sdv_246: int;
  var {:scalar} ntStatus_15: int;
  var {:pointer} Tmp_473: int;
  var {:pointer} Tmp_474: int;
  var {:pointer} deviceCapabilities: int;
  var {:pointer} buffer_2: int;
  var {:pointer} Tmp_475: int;
  var {:scalar} uniId: int;
  var {:pointer} buffer_3: int;
  var {:pointer} sdv_254: int;
  var {:pointer} Tmp_478: int;
  var {:pointer} Tmp_479: int;
  var {:pointer} DeviceObject_33: int;
  var {:pointer} Irp_19: int;
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

  anon0:
    call uniId := __HAVOC_malloc(12);
    call vslice_dummy_var_98 := __HAVOC_malloc(12);
    DeviceObject_33 := actual_DeviceObject_33;
    Irp_19 := actual_Irp_19;
    call Tmp_463 := __HAVOC_malloc(64);
    call idString := __HAVOC_malloc(100);
    call Tmp_466 := __HAVOC_malloc(56);
    call Tmp_468 := __HAVOC_malloc(4);
    call vslice_dummy_var_99 := __HAVOC_malloc(16);
    call Tmp_472 := __HAVOC_malloc(36);
    call Tmp_474 := __HAVOC_malloc(108);
    call Tmp_475 := __HAVOC_malloc(64);
    call vslice_dummy_var_100 := __HAVOC_malloc(100);
    call Tmp_478 := __HAVOC_malloc(76);
    call Tmp_479 := __HAVOC_malloc(44);
    call vslice_dummy_var_101 := __HAVOC_malloc(48);
    call vslice_dummy_var_102 := __HAVOC_malloc(48);
    assume {:nonnull} DeviceObject_33 != 0;
    assume DeviceObject_33 > 0;
    pdoExtension_3 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_33)];
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon109_Then, anon109_Else;

  anon109_Else:
    assume {:partition} Mem_T.Removed__FDC_PDO_EXTENSION[Removed__FDC_PDO_EXTENSION(pdoExtension_3)] != 0;
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_19))] := -1073741738;
    call sdv_IoCompleteRequest(0, 0);
    Tmp_461 := -1073741738;
    goto L1;

  L1:
    return;

  anon109_Then:
    assume {:partition} Mem_T.Removed__FDC_PDO_EXTENSION[Removed__FDC_PDO_EXTENSION(pdoExtension_3)] == 0;
    call irpSp_10 := sdv_IoGetCurrentIrpStackLocation(Irp_19);
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    ntStatus_15 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_19))];
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon110_Then, anon110_Else;

  anon110_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 0;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon99_Then, anon99_Else;

  anon99_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 1;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon98_Then, anon98_Else;

  anon98_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 2;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 3;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 4;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 5;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon94_Then, anon94_Else;

  anon94_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 6;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 7;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 9;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] != 19;
    goto L48;

  L48:
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_19))] := ntStatus_15;
    call sdv_IoCompleteRequest(0, 0);
    Tmp_461 := ntStatus_15;
    goto L1;

  anon91_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 19;
    ntStatus_15 := 0;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon112_Then, anon112_Else;

  anon112_Else:
    assume {:partition} Mem_T.IdType_unnamed_tag_34[IdType_unnamed_tag_34(QueryId_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] != 0;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume {:partition} Mem_T.IdType_unnamed_tag_34[IdType_unnamed_tag_34(QueryId_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] != 1;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume {:partition} Mem_T.IdType_unnamed_tag_34[IdType_unnamed_tag_34(QueryId_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] != 2;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon100_Then, anon100_Else;

  anon100_Else:
    assume {:partition} Mem_T.IdType_unnamed_tag_34[IdType_unnamed_tag_34(QueryId_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] == 3;
    call sdv_245 := ExAllocatePoolWithTag(257, 4, -261133242);
    buffer_2 := sdv_245;
    goto anon117_Then, anon117_Else;

  anon117_Else:
    assume {:partition} buffer_2 != 0;
    assume {:nonnull} buffer_2 != 0;
    assume buffer_2 > 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    Mem_T.INT4[buffer_2] := 48 + Mem_T.PeripheralNumber__FDC_PDO_EXTENSION[PeripheralNumber__FDC_PDO_EXTENSION(pdoExtension_3)];
    assume {:nonnull} buffer_2 != 0;
    assume buffer_2 > 0;
    Mem_T.INT4[buffer_2 + 1 * 4] := 0;
    goto L45;

  L45:
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_19))] := buffer_2;
    goto L48;

  anon117_Then:
    assume {:partition} buffer_2 == 0;
    ntStatus_15 := -1073741670;
    goto L45;

  anon100_Then:
    assume {:partition} Mem_T.IdType_unnamed_tag_34[IdType_unnamed_tag_34(QueryId_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] != 3;
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    ntStatus_15 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_19))];
    goto L48;

  anon101_Then:
    assume {:partition} Mem_T.IdType_unnamed_tag_34[IdType_unnamed_tag_34(QueryId_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] == 2;
    buffer_3 := 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] != 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] != 1;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon107_Then, anon107_Else;

  anon107_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] == 2;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} Mem_T.TapeVendorId__FDC_PDO_EXTENSION[TapeVendorId__FDC_PDO_EXTENSION(pdoExtension_3)] != -1;
    Tmp_472 := strConst__li2bpl7;
    call buffer_3 := FdcBuildIdString(Tmp_472, 16);
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:partition} buffer_3 == 0;
    ntStatus_15 := -1073741670;
    goto L55;

  L55:
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_19))] := buffer_3;
    goto L48;

  anon82_Then:
    assume {:partition} buffer_3 != 0;
    goto L55;

  anon81_Then:
    assume {:partition} Mem_T.TapeVendorId__FDC_PDO_EXTENSION[TapeVendorId__FDC_PDO_EXTENSION(pdoExtension_3)] == -1;
    goto L55;

  anon107_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] != 2;
    goto L55;

  anon108_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] == 1;
    Tmp_463 := strConst__li2bpl6;
    call buffer_3 := FdcBuildIdString(Tmp_463, 30);
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} buffer_3 == 0;
    ntStatus_15 := -1073741670;
    goto L55;

  anon83_Then:
    assume {:partition} buffer_3 != 0;
    goto L55;

  anon116_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] == 0;
    Tmp_479 := strConst__li2bpl5;
    call buffer_3 := FdcBuildIdString(Tmp_479, 20);
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:partition} buffer_3 == 0;
    ntStatus_15 := -1073741670;
    goto L55;

  anon84_Then:
    assume {:partition} buffer_3 != 0;
    goto L55;

  anon102_Then:
    assume {:partition} Mem_T.IdType_unnamed_tag_34[IdType_unnamed_tag_34(QueryId_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] == 1;
    buffer := 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon115_Then, anon115_Else;

  anon115_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] != 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] != 1;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] == 2;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} Mem_T.TapeVendorId__FDC_PDO_EXTENSION[TapeVendorId__FDC_PDO_EXTENSION(pdoExtension_3)] == -1;
    Tmp_475 := strConst__li2bpl11;
    call buffer := FdcBuildIdString(Tmp_475, 30);
    goto L96;

  L96:
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} buffer == 0;
    ntStatus_15 := -1073741670;
    goto L81;

  L81:
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_19))] := buffer;
    goto L48;

  anon86_Then:
    assume {:partition} buffer != 0;
    goto L81;

  anon85_Then:
    assume {:partition} Mem_T.TapeVendorId__FDC_PDO_EXTENSION[TapeVendorId__FDC_PDO_EXTENSION(pdoExtension_3)] != -1;
    Tmp_466 := strConst__li2bpl10;
    call buffer := FdcBuildIdString(Tmp_466, 26);
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} buffer != 0;
    call vslice_dummy_var_108 := corral_nondet();
    goto L96;

  anon87_Then:
    assume {:partition} buffer == 0;
    goto L96;

  anon105_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] != 2;
    goto L81;

  anon106_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] == 1;
    Tmp_474 := strConst__li2bpl9;
    call buffer := FdcBuildIdString(Tmp_474, 52);
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} buffer == 0;
    ntStatus_15 := -1073741670;
    goto L81;

  anon88_Then:
    assume {:partition} buffer != 0;
    goto L81;

  anon115_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] == 0;
    Tmp_478 := strConst__li2bpl8;
    call buffer := FdcBuildIdString(Tmp_478, 36);
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} buffer == 0;
    ntStatus_15 := -1073741670;
    goto L81;

  anon89_Then:
    assume {:partition} buffer != 0;
    goto L81;

  anon112_Then:
    assume {:partition} Mem_T.IdType_unnamed_tag_34[IdType_unnamed_tag_34(QueryId_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] == 0;
    assume {:nonnull} idString != 0;
    assume idString > 0;
    Mem_T.INT4[idString] := 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon113_Then, anon113_Else;

  anon113_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] != 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] != 1;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon103_Then, anon103_Else;

  anon103_Else:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] != 2;
    goto L139;

  L139:
    length := sdv_246 * 2 + 2;
    call sdv_254 := ExAllocatePoolWithTag(257, length, -261133242);
    buffer_1 := sdv_254;
    goto anon114_Then, anon114_Else;

  anon114_Else:
    assume {:partition} buffer_1 != 0;
    call sdv_RtlZeroMemory(0, length);
    call RtlInitAnsiString(0, 0);
    assume {:nonnull} uniId != 0;
    assume uniId > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(uniId)] := 0;
    assume {:nonnull} uniId != 0;
    assume uniId > 0;
    assume {:nonnull} uniId != 0;
    assume uniId > 0;
    call vslice_dummy_var_105 := RtlAnsiStringToUnicodeString(0, 0, 0);
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_19))] := buffer_1;
    goto L48;

  anon114_Then:
    assume {:partition} buffer_1 == 0;
    ntStatus_15 := -1073741670;
    goto L48;

  anon103_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] == 2;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon90_Then, anon90_Else;

  anon90_Else:
    assume {:partition} Mem_T.TapeVendorId__FDC_PDO_EXTENSION[TapeVendorId__FDC_PDO_EXTENSION(pdoExtension_3)] == -1;
    goto L139;

  anon90_Then:
    assume {:partition} Mem_T.TapeVendorId__FDC_PDO_EXTENSION[TapeVendorId__FDC_PDO_EXTENSION(pdoExtension_3)] != -1;
    call vslice_dummy_var_107 := corral_nondet();
    goto L139;

  anon104_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] == 1;
    call vslice_dummy_var_106 := corral_nondet();
    goto L139;

  anon113_Then:
    assume {:partition} Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_3)] == 0;
    call vslice_dummy_var_104 := corral_nondet();
    goto L139;

  anon92_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 9;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    deviceCapabilities := Mem_T.Capabilities_unnamed_tag_30[Capabilities_unnamed_tag_30(DeviceCapabilities_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))];
    assume {:nonnull} deviceCapabilities != 0;
    assume deviceCapabilities > 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    assume {:nonnull} deviceCapabilities != 0;
    assume deviceCapabilities > 0;
    ntStatus_15 := 0;
    goto L48;

  anon93_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 7;
    assume {:nonnull} irpSp_10 != 0;
    assume irpSp_10 > 0;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] == 4;
    call sdv_241 := ExAllocatePoolWithTag(257, 8, -261133242);
    devRel := sdv_241;
    goto anon111_Then, anon111_Else;

  anon111_Else:
    assume {:partition} devRel != 0;
    assume {:nonnull} devRel != 0;
    assume devRel > 0;
    Tmp_468 := Mem_T.PP_DEVICE_OBJECT[Objects__DEVICE_RELATIONS(devRel)];
    assume {:nonnull} Tmp_468 != 0;
    assume Tmp_468 > 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    Mem_T.P_DEVICE_OBJECT[Tmp_468] := Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(pdoExtension_3)];
    assume {:nonnull} devRel != 0;
    assume devRel > 0;
    Mem_T.Count__DEVICE_RELATIONS[Count__DEVICE_RELATIONS(devRel)] := 1;
    assume {:nonnull} Irp_19 != 0;
    assume Irp_19 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_19))] := devRel;
    ntStatus_15 := 0;
    goto L48;

  anon111_Then:
    assume {:partition} devRel == 0;
    ntStatus_15 := -1073741670;
    goto L48;

  anon80_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(QueryDeviceRelations_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_10)))] != 4;
    goto L48;

  anon94_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 6;
    ntStatus_15 := 0;
    goto L48;

  anon95_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 5;
    ntStatus_15 := 0;
    goto L48;

  anon96_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 4;
    ntStatus_15 := 0;
    goto L48;

  anon97_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 3;
    ntStatus_15 := 0;
    goto L48;

  anon98_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 2;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(pdoExtension_3)] != 0;
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    Mem_T.Removed__FDC_PDO_EXTENSION[Removed__FDC_PDO_EXTENSION(pdoExtension_3)] := 1;
    call vslice_dummy_var_103 := sdv_RemoveEntryList(0);
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    Tmp_469 := Mem_T.ParentFdo__FDC_PDO_EXTENSION[ParentFdo__FDC_PDO_EXTENSION(pdoExtension_3)];
    assume {:nonnull} Tmp_469 != 0;
    assume Tmp_469 > 0;
    Tmp_473 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(Tmp_469)];
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    Tmp_467 := Mem_T.ParentFdo__FDC_PDO_EXTENSION[ParentFdo__FDC_PDO_EXTENSION(pdoExtension_3)];
    assume {:nonnull} Tmp_467 != 0;
    assume Tmp_467 > 0;
    Tmp_465 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(Tmp_467)];
    assume {:nonnull} pdoExtension_3 != 0;
    assume pdoExtension_3 > 0;
    Tmp_462 := Mem_T.ParentFdo__FDC_PDO_EXTENSION[ParentFdo__FDC_PDO_EXTENSION(pdoExtension_3)];
    assume {:nonnull} Tmp_462 != 0;
    assume Tmp_462 > 0;
    assume {:nonnull} Tmp_465 != 0;
    assume Tmp_465 > 0;
    assume {:nonnull} Tmp_473 != 0;
    assume Tmp_473 > 0;
    Mem_T.NumPDOs__FDC_FDO_EXTENSION[NumPDOs__FDC_FDO_EXTENSION(Tmp_473)] := Mem_T.NumPDOs__FDC_FDO_EXTENSION[NumPDOs__FDC_FDO_EXTENSION(Tmp_465)] - 1;
    call IoDeleteDevice(0);
    goto L183;

  L183:
    ntStatus_15 := 0;
    goto L48;

  anon79_Then:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(pdoExtension_3)] == 0;
    goto L183;

  anon99_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 1;
    ntStatus_15 := 0;
    goto L48;

  anon110_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_10)] == 0;
    ntStatus_15 := 0;
    goto L48;
}



procedure {:origName "FcTurnOnMotor"} FcTurnOnMotor(actual_FdoExtension_10: int, actual_FdcEnableParms: int) returns (Tmp_482: int);
  modifies alloc, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION;



implementation {:origName "FcTurnOnMotor"} FcTurnOnMotor(actual_FdoExtension_10: int, actual_FdcEnableParms: int) returns (Tmp_482: int)
{
  var {:scalar} driveStatus: int;
  var {:scalar} newStatus: int;
  var {:scalar} motorOnDelay: int;
  var {:pointer} FdoExtension_10: int;
  var {:pointer} FdcEnableParms: int;
  var vslice_dummy_var_109: int;

  anon0:
    call motorOnDelay := __HAVOC_malloc(20);
    FdoExtension_10 := actual_FdoExtension_10;
    FdcEnableParms := actual_FdcEnableParms;
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    driveStatus := Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_10)];
    assume {:nonnull} FdcEnableParms != 0;
    assume FdcEnableParms > 0;
    newStatus := BOR(BOR(Mem_T.DriveOnValue__FDC_ENABLE_PARMS[DriveOnValue__FDC_ENABLE_PARMS(FdcEnableParms)], 4), 8);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} driveStatus != newStatus;
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION[CurrentInterrupt__FDC_FDO_EXTENSION(FdoExtension_10)] != 0;
    goto L13;

  L13:
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(FdoExtension_10)] := 1;
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_10)] := newStatus;
    assume {:nonnull} FdcEnableParms != 0;
    assume FdcEnableParms > 0;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} Mem_T.TimeToWait__FDC_ENABLE_PARMS[TimeToWait__FDC_ENABLE_PARMS(FdcEnableParms)] > 0;
    assume {:nonnull} FdcEnableParms != 0;
    assume FdcEnableParms > 0;
    assume {:nonnull} motorOnDelay != 0;
    assume motorOnDelay > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(motorOnDelay)] := 10000 * Mem_T.TimeToWait__FDC_ENABLE_PARMS[TimeToWait__FDC_ENABLE_PARMS(FdcEnableParms)] * -1;
    assume {:nonnull} motorOnDelay != 0;
    assume motorOnDelay > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(motorOnDelay)] := -1;
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    assume {:nonnull} motorOnDelay != 0;
    assume motorOnDelay > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(LastMotorSettleTime__FDC_FDO_EXTENSION(FdoExtension_10))] := Mem_T.LowPart__LUID[LowPart__LUID(motorOnDelay)];
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    assume {:nonnull} motorOnDelay != 0;
    assume motorOnDelay > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(LastMotorSettleTime__FDC_FDO_EXTENSION(FdoExtension_10))] := Mem_T.HighPart__LUID[HighPart__LUID(motorOnDelay)];
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    assume {:nonnull} motorOnDelay != 0;
    assume motorOnDelay > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(LastMotorSettleTime__FDC_FDO_EXTENSION(FdoExtension_10)))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(motorOnDelay))];
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    assume {:nonnull} motorOnDelay != 0;
    assume motorOnDelay > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(LastMotorSettleTime__FDC_FDO_EXTENSION(FdoExtension_10)))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(motorOnDelay))];
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    assume {:nonnull} motorOnDelay != 0;
    assume motorOnDelay > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(LastMotorSettleTime__FDC_FDO_EXTENSION(FdoExtension_10))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(motorOnDelay)];
    call vslice_dummy_var_109 := KeDelayExecutionThread(0, 0, 0);
    goto L19;

  L19:
    assume {:nonnull} FdcEnableParms != 0;
    assume FdcEnableParms > 0;
    goto L10;

  L10:
    Tmp_482 := 0;
    return;

  anon8_Then:
    assume {:partition} 0 >= Mem_T.TimeToWait__FDC_ENABLE_PARMS[TimeToWait__FDC_ENABLE_PARMS(FdcEnableParms)];
    goto L19;

  anon7_Then:
    assume {:partition} Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION[CurrentInterrupt__FDC_FDO_EXTENSION(FdoExtension_10)] == 0;
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION[CurrentInterrupt__FDC_FDO_EXTENSION(FdoExtension_10)] := 1;
    assume {:nonnull} FdoExtension_10 != 0;
    assume FdoExtension_10 > 0;
    driveStatus := Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_10)];
    goto L13;

  anon9_Then:
    assume {:partition} driveStatus == newStatus;
    goto L10;
}



procedure {:origName "FdcStartIo"} FdcStartIo(actual_DeviceObject_34: int, actual_Irp_20: int);
  modifies alloc, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.INT4, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "FdcStartIo"} FdcStartIo(actual_DeviceObject_34: int, actual_Irp_20: int)
{
  var {:pointer} issueCommandParms: int;
  var {:scalar} Tmp_484: int;
  var {:scalar} Tmp_485: int;
  var {:pointer} irpSp_11: int;
  var {:scalar} Tmp_487: int;
  var {:scalar} Tmp_488: int;
  var {:scalar} ntStatus_16: int;
  var {:pointer} Tmp_490: int;
  var {:pointer} fdoExtension_7: int;
  var {:scalar} sdv_260: int;
  var {:scalar} Tmp_491: int;
  var {:pointer} Tmp_492: int;
  var {:pointer} DeviceObject_34: int;
  var {:pointer} Irp_20: int;
  var vslice_dummy_var_110: int;

  anon0:
    call vslice_dummy_var_110 := __HAVOC_malloc(4);
    DeviceObject_34 := actual_DeviceObject_34;
    Irp_20 := actual_Irp_20;
    assume {:nonnull} DeviceObject_34 != 0;
    assume DeviceObject_34 > 0;
    fdoExtension_7 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_34)];
    call irpSp_11 := sdv_IoGetCurrentIrpStackLocation(Irp_20);
    ntStatus_16 := 0;
    assume {:nonnull} irpSp_11 != 0;
    assume irpSp_11 > 0;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_11)))] == 461843;
    assume {:nonnull} irpSp_11 != 0;
    assume irpSp_11 > 0;
    issueCommandParms := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_11)))];
    assume {:nonnull} issueCommandParms != 0;
    assume issueCommandParms > 0;
    Tmp_490 := Mem_T.FifoInBuffer__ISSUE_FDC_COMMAND_PARMS[FifoInBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)];
    assume {:nonnull} Tmp_490 != 0;
    assume Tmp_490 > 0;
    Tmp_487 := BAND(Mem_T.INT4[Tmp_490], BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_488 := Tmp_487;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} Mem_T.InterruptExpected__COMMAND_TABLE[InterruptExpected__COMMAND_TABLE(CommandTable + Tmp_488 * 28)] != 0;
    assume {:nonnull} fdoExtension_7 != 0;
    assume fdoExtension_7 > 0;
    Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION[CurrentDeviceObject__FDC_FDO_EXTENSION(fdoExtension_7)] := DeviceObject_34;
    assume {:nonnull} fdoExtension_7 != 0;
    assume fdoExtension_7 > 0;
    Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(fdoExtension_7)] := 1;
    assume {:nonnull} fdoExtension_7 != 0;
    assume fdoExtension_7 > 0;
    Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION[CommandHasResultPhase__FDC_FDO_EXTENSION(fdoExtension_7)] := 0;
    assume {:nonnull} issueCommandParms != 0;
    assume issueCommandParms > 0;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} Mem_T.TimeOut__ISSUE_FDC_COMMAND_PARMS[TimeOut__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)] != 0;
    assume {:nonnull} issueCommandParms != 0;
    assume issueCommandParms > 0;
    Tmp_491 := Mem_T.TimeOut__ISSUE_FDC_COMMAND_PARMS[TimeOut__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)] + 1;
    goto L33;

  L33:
    assume {:nonnull} fdoExtension_7 != 0;
    assume fdoExtension_7 > 0;
    assume {:nonnull} fdoExtension_7 != 0;
    assume fdoExtension_7 > 0;
    goto L24;

  L24:
    assume {:nonnull} issueCommandParms != 0;
    assume issueCommandParms > 0;
    call ntStatus_16 := FcStartCommand(fdoExtension_7, Mem_T.FifoInBuffer__ISSUE_FDC_COMMAND_PARMS[FifoInBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], Mem_T.FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS[FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], Mem_T.IoHandle__ISSUE_FDC_COMMAND_PARMS[IoHandle__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], Mem_T.IoOffset__ISSUE_FDC_COMMAND_PARMS[IoOffset__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], Mem_T.TransferBytes__ISSUE_FDC_COMMAND_PARMS[TransferBytes__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], 0);
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} ntStatus_16 < 0;
    goto L45;

  L45:
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} ntStatus_16 != 259;
    assume {:nonnull} Irp_20 != 0;
    assume Irp_20 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_20))] := ntStatus_16;
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} ntStatus_16 >= 0;
    goto L51;

  L51:
    call IoStartNextPacket(0, 0);
    goto L1;

  L1:
    return;

  anon24_Then:
    assume {:partition} 0 > ntStatus_16;
    call sdv_260 := sdv_IoIsErrorUserInduced(ntStatus_16);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} sdv_260 != 0;
    call IoSetHardErrorOrVerifyDevice(0, 0);
    goto L51;

  anon19_Then:
    assume {:partition} sdv_260 == 0;
    goto L51;

  anon18_Then:
    assume {:partition} ntStatus_16 == 259;
    goto L1;

  anon17_Then:
    assume {:partition} 0 <= ntStatus_16;
    assume {:nonnull} issueCommandParms != 0;
    assume issueCommandParms > 0;
    Tmp_492 := Mem_T.FifoInBuffer__ISSUE_FDC_COMMAND_PARMS[FifoInBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)];
    assume {:nonnull} Tmp_492 != 0;
    assume Tmp_492 > 0;
    Tmp_485 := BAND(Mem_T.INT4[Tmp_492], BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    Tmp_484 := Tmp_485;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} Mem_T.InterruptExpected__COMMAND_TABLE[InterruptExpected__COMMAND_TABLE(CommandTable + Tmp_484 * 28)] != 0;
    ntStatus_16 := 259;
    goto L45;

  anon23_Then:
    assume {:partition} Mem_T.InterruptExpected__COMMAND_TABLE[InterruptExpected__COMMAND_TABLE(CommandTable + Tmp_484 * 28)] == 0;
    assume {:nonnull} issueCommandParms != 0;
    assume issueCommandParms > 0;
    call ntStatus_16 := FcFinishCommand(fdoExtension_7, Mem_T.FifoInBuffer__ISSUE_FDC_COMMAND_PARMS[FifoInBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], Mem_T.FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS[FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], Mem_T.IoHandle__ISSUE_FDC_COMMAND_PARMS[IoHandle__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], Mem_T.IoOffset__ISSUE_FDC_COMMAND_PARMS[IoOffset__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], Mem_T.TransferBytes__ISSUE_FDC_COMMAND_PARMS[TransferBytes__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)], 0);
    goto L45;

  anon22_Then:
    assume {:partition} Mem_T.TimeOut__ISSUE_FDC_COMMAND_PARMS[TimeOut__ISSUE_FDC_COMMAND_PARMS(issueCommandParms)] == 0;
    Tmp_491 := 9;
    goto L33;

  anon21_Then:
    assume {:partition} Mem_T.InterruptExpected__COMMAND_TABLE[InterruptExpected__COMMAND_TABLE(CommandTable + Tmp_488 * 28)] == 0;
    goto L24;

  anon20_Then:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_11)))] != 461843;
    ntStatus_16 := -1073741808;
    goto L45;
}



procedure {:origName "FdcBuildIdString"} FdcBuildIdString(actual_IdString: int, actual_Length_5: int) returns (Tmp_493: int);
  modifies alloc;



implementation {:origName "FdcBuildIdString"} FdcBuildIdString(actual_IdString: int, actual_Length_5: int) returns (Tmp_493: int)
{
  var {:scalar} Tmp_494: int;
  var {:pointer} buffer_4: int;
  var {:scalar} Tmp_496: int;
  var {:scalar} Length_5: int;

  anon0:
    Length_5 := actual_Length_5;
    Tmp_494 := Length_5;
    call buffer_4 := ExAllocatePoolWithTag(257, Tmp_494, -261133242);
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} buffer_4 != 0;
    Tmp_496 := Length_5;
    call sdv_RtlCopyMemory(0, 0, Tmp_496);
    goto L10;

  L10:
    Tmp_493 := buffer_4;
    return;

  anon3_Then:
    assume {:partition} buffer_4 == 0;
    goto L10;
}



procedure {:origName "FdcDeferredProcedure"} FdcDeferredProcedure(actual_Dpc_4: int, actual_DeferredContext_1: int, actual_SystemArgument1_1: int, actual_SystemArgument2_1: int);
  modifies alloc, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.INT4, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.SignalState__DISPATCHER_HEADER;



implementation {:origName "FdcDeferredProcedure"} FdcDeferredProcedure(actual_Dpc_4: int, actual_DeferredContext_1: int, actual_SystemArgument1_1: int, actual_SystemArgument2_1: int)
{
  var {:pointer} issueCommandParms_1: int;
  var {:pointer} deviceObject: int;
  var {:pointer} irpSp_12: int;
  var {:scalar} ntStatus_17: int;
  var {:pointer} fdoExtension_8: int;
  var {:scalar} sdv_266: int;
  var {:scalar} sdv_267: int;
  var {:pointer} Tmp_498: int;
  var {:pointer} irp_2: int;
  var {:pointer} DeferredContext_1: int;
  var vslice_dummy_var_111: int;
  var vslice_dummy_var_112: int;
  var vslice_dummy_var_113: int;

  anon0:
    call vslice_dummy_var_111 := __HAVOC_malloc(4);
    DeferredContext_1 := actual_DeferredContext_1;
    irpSp_12 := 0;
    call ExAcquireFastMutex(0);
    deviceObject := DeferredContext_1;
    assume {:nonnull} deviceObject != 0;
    assume deviceObject > 0;
    fdoExtension_8 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(deviceObject)];
    assume {:nonnull} deviceObject != 0;
    assume deviceObject > 0;
    irp_2 := Mem_T.CurrentIrp__DEVICE_OBJECT[CurrentIrp__DEVICE_OBJECT(deviceObject)];
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} irp_2 != 0;
    call irpSp_12 := sdv_IoGetCurrentIrpStackLocation(irp_2);
    goto L18;

  L18:
    goto anon13_Then, anon13_Else;

  anon13_Else:
    assume {:partition} irp_2 != 0;
    assume {:nonnull} irpSp_12 != 0;
    assume irpSp_12 > 0;
    goto anon14_Then, anon14_Else;

  anon14_Else:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_12)))] == 461843;
    assume {:nonnull} irpSp_12 != 0;
    assume irpSp_12 > 0;
    issueCommandParms_1 := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_12)))];
    assume {:nonnull} issueCommandParms_1 != 0;
    assume issueCommandParms_1 > 0;
    call ntStatus_17 := FcFinishCommand(fdoExtension_8, Mem_T.FifoInBuffer__ISSUE_FDC_COMMAND_PARMS[FifoInBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_1)], Mem_T.FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS[FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_1)], Mem_T.IoHandle__ISSUE_FDC_COMMAND_PARMS[IoHandle__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_1)], Mem_T.IoOffset__ISSUE_FDC_COMMAND_PARMS[IoOffset__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_1)], Mem_T.TransferBytes__ISSUE_FDC_COMMAND_PARMS[TransferBytes__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_1)], 0);
    assume {:nonnull} irp_2 != 0;
    assume irp_2 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(irp_2))] := ntStatus_17;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} ntStatus_17 >= 0;
    goto L37;

  L37:
    call Tmp_498 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} fdoExtension_8 != 0;
    assume fdoExtension_8 > 0;
    Mem_T.INT4[Tmp_498] := Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_8)];
    call sdv_266 := sdv_InterlockedDecrement(Tmp_498);
    assume {:nonnull} Tmp_498 != 0;
    assume Tmp_498 > 0;
    assume {:nonnull} fdoExtension_8 != 0;
    assume fdoExtension_8 > 0;
    Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_8)] := Mem_T.INT4[Tmp_498];
    goto anon15_Then, anon15_Else;

  anon15_Else:
    assume {:partition} sdv_266 != 0;
    goto L44;

  L44:
    call sdv_IoCompleteRequest(0, 0);
    call IoStartNextPacket(0, 0);
    goto L1;

  L1:
    return;

  anon15_Then:
    assume {:partition} sdv_266 == 0;
    assume {:nonnull} fdoExtension_8 != 0;
    assume fdoExtension_8 > 0;
    call vslice_dummy_var_113 := KeSetEvent(RemoveEvent__FDC_FDO_EXTENSION(fdoExtension_8), 0, 0);
    goto L44;

  anon18_Then:
    assume {:partition} 0 > ntStatus_17;
    call sdv_267 := sdv_IoIsErrorUserInduced(ntStatus_17);
    goto anon16_Then, anon16_Else;

  anon16_Else:
    assume {:partition} sdv_267 != 0;
    call IoSetHardErrorOrVerifyDevice(0, 0);
    goto L37;

  anon16_Then:
    assume {:partition} sdv_267 == 0;
    goto L37;

  anon14_Then:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_12)))] != 461843;
    goto L23;

  L23:
    assume {:nonnull} fdoExtension_8 != 0;
    assume fdoExtension_8 > 0;
    call vslice_dummy_var_112 := KeSetEvent(InterruptEvent__FDC_FDO_EXTENSION(fdoExtension_8), 0, 0);
    goto L1;

  anon13_Then:
    assume {:partition} irp_2 == 0;
    goto L23;

  anon17_Then:
    assume {:partition} irp_2 == 0;
    goto L18;
}



procedure {:origName "InitializeListHead"} InitializeListHead(actual_ListHead_3: int);
  modifies alloc, Mem_T.Blink__LIST_ENTRY, Mem_T.Flink__LIST_ENTRY;



implementation {:origName "InitializeListHead"} InitializeListHead(actual_ListHead_3: int)
{
  var {:pointer} ListHead_3: int;
  var vslice_dummy_var_114: int;

  anon0:
    call vslice_dummy_var_114 := __HAVOC_malloc(4);
    ListHead_3 := actual_ListHead_3;
    assume {:nonnull} ListHead_3 != 0;
    assume ListHead_3 > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(ListHead_3)] := ListHead_3;
    assume {:nonnull} ListHead_3 != 0;
    assume ListHead_3 > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(ListHead_3)] := Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(ListHead_3)];
    return;
}



procedure {:origName "FdcPower"} FdcPower(actual_DeviceObject_35: int, actual_Irp_21: int) returns (Tmp_501: int);
  modifies alloc, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.Status__IO_STATUS_BLOCK, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.DeviceState__POWER_STATE, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.CurrentPowerState__FDC_FDO_EXTENSION, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.CompletionRoutine__IO_STACK_LOCATION, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.SystemState__POWER_STATE, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.INT4, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.Type3InputBuffer_unnamed_tag_22, yogi_error, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, sdv_isr_routine, sdv_pDpcContext, Mem_T.ControllerInUse__FDC_FDO_EXTENSION;



implementation {:origName "FdcPower"} FdcPower(actual_DeviceObject_35: int, actual_Irp_21: int) returns (Tmp_501: int)
{
  var {:scalar} Tmp_503: int;
  var {:pointer} irpSp_13: int;
  var {:scalar} doneEvent_2: int;
  var {:scalar} Tmp_504: int;
  var {:scalar} newState: int;
  var {:scalar} ntStatus_18: int;
  var {:pointer} fdoExtension_9: int;
  var {:pointer} DeviceObject_35: int;
  var {:pointer} Irp_21: int;
  var vslice_dummy_var_115: int;
  var vslice_dummy_var_116: int;
  var vslice_dummy_var_117: int;
  var vslice_dummy_var_118: int;
  var vslice_dummy_var_119: int;
  var vslice_dummy_var_120: int;
  var vslice_dummy_var_121: int;
  var vslice_dummy_var_122: int;

  anon0:
    call doneEvent_2 := __HAVOC_malloc(156);
    call newState := __HAVOC_malloc(8);
    DeviceObject_35 := actual_DeviceObject_35;
    Irp_21 := actual_Irp_21;
    ntStatus_18 := 0;
    assume {:nonnull} DeviceObject_35 != 0;
    assume DeviceObject_35 > 0;
    fdoExtension_9 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_35)];
    call irpSp_13 := sdv_IoGetCurrentIrpStackLocation(Irp_21);
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    goto anon43_Then, anon43_Else;

  anon43_Else:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(fdoExtension_9)] != 0;
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} Mem_T.Removed__FDC_FDO_EXTENSION[Removed__FDC_FDO_EXTENSION(fdoExtension_9)] != 0;
    ntStatus_18 := -1073741738;
    call PoStartNextPowerIrp(0);
    assume {:nonnull} Irp_21 != 0;
    assume Irp_21 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_21))] := 0;
    assume {:nonnull} Irp_21 != 0;
    assume Irp_21 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_21))] := ntStatus_18;
    call sdv_IoCompleteRequest(0, 0);
    goto L28;

  L28:
    Tmp_501 := ntStatus_18;
    goto LM2;

  LM2:
    return;

  anon45_Then:
    assume {:partition} Mem_T.Removed__FDC_FDO_EXTENSION[Removed__FDC_FDO_EXTENSION(fdoExtension_9)] == 0;
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon46_Then, anon46_Else;

  anon46_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] != 0;
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] != 1;
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon54_Then, anon54_Else;

  anon54_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] == 2;
    call ExAcquireFastMutex(0);
    PagingReferenceCount := PagingReferenceCount + 1;
    goto anon59_Then, anon59_Else;

  anon59_Else:
    assume {:partition} PagingReferenceCount == 1;
    call MmResetDriverPaging(0);
    goto L36;

  L36:
    call ExReleaseFastMutex(0);
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_13)))] != 0;
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon49_Then, anon49_Else;

  anon49_Else:
    assume {:partition} Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(State_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_13))))] == 1;
    Tmp_504 := 1;
    goto L47;

  L47:
    assume {:nonnull} newState != 0;
    assume newState > 0;
    Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)] := Tmp_504;
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    assume {:nonnull} newState != 0;
    assume newState > 0;
    goto anon60_Then, anon60_Else;

  anon60_Else:
    assume {:partition} Mem_T.CurrentPowerState__FDC_FDO_EXTENSION[CurrentPowerState__FDC_FDO_EXTENSION(fdoExtension_9)] == Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)];
    call sdv_IoMarkIrpPending(0);
    call PoStartNextPowerIrp(0);
    call sdv_IoSkipCurrentIrpStackLocation(Irp_21);
    call vslice_dummy_var_115 := PoCallDriver(0, Irp_21);
    ntStatus_18 := 259;
    goto L28;

  anon60_Then:
    assume {:partition} Mem_T.CurrentPowerState__FDC_FDO_EXTENSION[CurrentPowerState__FDC_FDO_EXTENSION(fdoExtension_9)] != Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)];
    assume {:nonnull} newState != 0;
    assume newState > 0;
    goto anon50_Then, anon50_Else;

  anon50_Else:
    assume {:partition} Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)] == 4;
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    assume {:nonnull} newState != 0;
    assume newState > 0;
    Mem_T.CurrentPowerState__FDC_FDO_EXTENSION[CurrentPowerState__FDC_FDO_EXTENSION(fdoExtension_9)] := Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)];
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    call sdv_IoMarkIrpPending(0);
    call PoStartNextPowerIrp(0);
    call sdv_IoSkipCurrentIrpStackLocation(Irp_21);
    call vslice_dummy_var_116 := PoCallDriver(0, Irp_21);
    ntStatus_18 := 259;
    goto L28;

  anon50_Then:
    assume {:partition} Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)] != 4;
    call KeInitializeEvent(doneEvent_2, 0, 0);
    call sdv_IoCopyCurrentIrpStackLocationToNext(Irp_21);
    call sdv_IoSetCompletionRoutine(Irp_21, li2bplFunctionConstant201, doneEvent_2, 1, 1, 1);
    call ntStatus_18 := PoCallDriver(0, Irp_21);
    goto anon51_Then, anon51_Else;

  anon51_Else:
    assume {:partition} ntStatus_18 == 259;
    call vslice_dummy_var_117 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} Irp_21 != 0;
    assume Irp_21 > 0;
    ntStatus_18 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_21))];
    goto L96;

  L96:
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    goto anon52_Then, anon52_Else;

  anon52_Else:
    assume {:partition} BAND(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(fdoExtension_9)], 240) != 0;
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    goto anon53_Then, anon53_Else;

  anon53_Else:
    assume {:partition} Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(LastMotorSettleTime__FDC_FDO_EXTENSION(fdoExtension_9))] > 0;
    call vslice_dummy_var_118 := KeDelayExecutionThread(0, 0, 0);
    goto L101;

  L101:
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    assume {:nonnull} newState != 0;
    assume newState > 0;
    Mem_T.CurrentPowerState__FDC_FDO_EXTENSION[CurrentPowerState__FDC_FDO_EXTENSION(fdoExtension_9)] := Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)];
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    Mem_T.WakeUp__FDC_FDO_EXTENSION[WakeUp__FDC_FDO_EXTENSION(fdoExtension_9)] := 1;
    call PoStartNextPowerIrp(0);
    call sdv_IoCompleteRequest(0, 0);
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    call vslice_dummy_var_119 := FdcFdoInternalDeviceControl(Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(fdoExtension_9)], 0);
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} yogi_error != 1;
    goto L28;

  anon62_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon53_Then:
    assume {:partition} 0 >= Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(LastMotorSettleTime__FDC_FDO_EXTENSION(fdoExtension_9))];
    goto L101;

  anon52_Then:
    assume {:partition} BAND(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(fdoExtension_9)], 240) == 0;
    goto L101;

  anon61_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon51_Then:
    assume {:partition} ntStatus_18 != 259;
    goto L96;

  anon49_Then:
    assume {:partition} Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(State_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_13))))] != 1;
    Tmp_504 := 4;
    goto L47;

  anon47_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_39[Type_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_13)))] == 0;
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon48_Then, anon48_Else;

  anon48_Else:
    assume {:partition} Mem_T.SystemState__POWER_STATE[SystemState__POWER_STATE(State_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_13))))] == 1;
    Tmp_503 := 1;
    goto L121;

  L121:
    assume {:nonnull} newState != 0;
    assume newState > 0;
    Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)] := Tmp_503;
    assume {:nonnull} fdoExtension_9 != 0;
    assume fdoExtension_9 > 0;
    assume {:nonnull} newState != 0;
    assume newState > 0;
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} Mem_T.CurrentPowerState__FDC_FDO_EXTENSION[CurrentPowerState__FDC_FDO_EXTENSION(fdoExtension_9)] == Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)];
    call sdv_IoMarkIrpPending(0);
    call PoStartNextPowerIrp(0);
    call sdv_IoSkipCurrentIrpStackLocation(Irp_21);
    call vslice_dummy_var_120 := PoCallDriver(0, Irp_21);
    ntStatus_18 := 259;
    goto L28;

  anon63_Then:
    assume {:partition} Mem_T.CurrentPowerState__FDC_FDO_EXTENSION[CurrentPowerState__FDC_FDO_EXTENSION(fdoExtension_9)] != Mem_T.DeviceState__POWER_STATE[DeviceState__POWER_STATE(newState)];
    call sdv_IoMarkIrpPending(0);
    call vslice_dummy_var_121 := PoRequestPowerIrp(0, 2, newState, li2bplFunctionConstant204, 0, 0);
    ntStatus_18 := 259;
    goto L28;

  anon48_Then:
    assume {:partition} Mem_T.SystemState__POWER_STATE[SystemState__POWER_STATE(State_unnamed_tag_39(Power_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_13))))] != 1;
    Tmp_503 := 4;
    goto L121;

  anon59_Then:
    assume {:partition} PagingReferenceCount != 1;
    goto L36;

  anon54_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] != 2;
    goto L29;

  L29:
    call sdv_IoMarkIrpPending(0);
    call PoStartNextPowerIrp(0);
    call sdv_IoSkipCurrentIrpStackLocation(Irp_21);
    call vslice_dummy_var_122 := PoCallDriver(0, Irp_21);
    ntStatus_18 := 259;
    goto L28;

  anon55_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] == 1;
    goto L29;

  anon46_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] == 0;
    goto L29;

  anon43_Then:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(fdoExtension_9)] == 0;
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon44_Then, anon44_Else;

  anon44_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] != 0;
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon58_Then, anon58_Else;

  anon58_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] != 1;
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon57_Then, anon57_Else;

  anon57_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] != 2;
    assume {:nonnull} irpSp_13 != 0;
    assume irpSp_13 > 0;
    goto anon56_Then, anon56_Else;

  anon56_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] != 3;
    goto L157;

  L157:
    call PoStartNextPowerIrp(0);
    assume {:nonnull} Irp_21 != 0;
    assume Irp_21 > 0;
    ntStatus_18 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_21))];
    call sdv_IoCompleteRequest(0, 0);
    goto L28;

  anon56_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] == 3;
    goto L155;

  L155:
    assume {:nonnull} Irp_21 != 0;
    assume Irp_21 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_21))] := 0;
    goto L157;

  anon57_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] == 2;
    goto L155;

  anon58_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] == 1;
    goto L157;

  anon44_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_13)] == 0;
    goto L157;
}



procedure {:origName "FdcCreateClose"} FdcCreateClose(actual_DeviceObject_36: int, actual_Irp_22: int) returns (Tmp_506: int);
  modifies Mem_T.Status__IO_STATUS_BLOCK, Mem_T.Information__IO_STATUS_BLOCK, alloc;



implementation {:origName "FdcCreateClose"} FdcCreateClose(actual_DeviceObject_36: int, actual_Irp_22: int) returns (Tmp_506: int)
{
  var {:pointer} Irp_22: int;

  anon0:
    Irp_22 := actual_Irp_22;
    assume {:nonnull} Irp_22 != 0;
    assume Irp_22 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_22))] := 0;
    assume {:nonnull} Irp_22 != 0;
    assume Irp_22 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_22))] := 1;
    call sdv_IoCompleteRequest(0, 0);
    Tmp_506 := 0;
    return;
}



procedure {:origName "FdcFdoPnp"} FdcFdoPnp(actual_DeviceObject_37: int, actual_Irp_23: int) returns (Tmp_508: int);
  modifies alloc, Mem_T.INT4, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.Information__IO_STATUS_BLOCK, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.Type_unnamed_tag_28, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.CompletionRoutine__IO_STACK_LOCATION, Mem_T.Map__IO_PORT_INFO, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST, Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.Version__IO_RESOURCE_LIST, Mem_T.Revision__IO_RESOURCE_LIST, Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR, Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR, Mem_T.MinimumVector_unnamed_tag_59, Mem_T.MaximumVector_unnamed_tag_59, Mem_T.AffinityPolicy_unnamed_tag_59, Mem_T.PriorityPolicy_unnamed_tag_59, Mem_T.TargetedProcessors_unnamed_tag_59, Mem_T.MinimumChannel_unnamed_tag_60, Mem_T.MaximumChannel_unnamed_tag_60, Mem_T.RequestLine_unnamed_tag_61, Mem_T.Reserved_unnamed_tag_61, Mem_T.Channel_unnamed_tag_61, Mem_T.TransferWidth_unnamed_tag_61, Mem_T.Data_unnamed_tag_50, Mem_T.MinBusNumber_unnamed_tag_62, Mem_T.MaxBusNumber_unnamed_tag_62, Mem_T.Reserved_unnamed_tag_62, Mem_T.Priority_unnamed_tag_63, Mem_T.Reserved1_unnamed_tag_63, Mem_T.Reserved2_unnamed_tag_63, Mem_T.Length40_unnamed_tag_64, Mem_T.Alignment40_unnamed_tag_64, Mem_T.Length48_unnamed_tag_65, Mem_T.Alignment48_unnamed_tag_65, Mem_T.Length64_unnamed_tag_66, Mem_T.Alignment64_unnamed_tag_66, Mem_T.Class_unnamed_tag_56, Mem_T.Type_unnamed_tag_56, Mem_T.Reserved1_unnamed_tag_56, Mem_T.Reserved2_unnamed_tag_56, Mem_T.IdLowPart_unnamed_tag_56, Mem_T.IdHighPart_unnamed_tag_56, Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY, Mem_T.PVOID, Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR, Mem_T.DataLength__ACPI_METHOD_ARGUMENT, Mem_T.IoControlCode_unnamed_tag_22, Mem_T.UserBuffer__IRP, Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT, Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION, Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION, Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION, Mem_T.Count__DEVICE_RELATIONS, Mem_T.P_DEVICE_OBJECT, Mem_T.Paused__FDC_FDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, FdcDefaultControllerNumber, Mem_T.Removed__FDC_FDO_EXTENSION, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_isr_routine, sdv_pDpcContext, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.SpeedsAvailable__FDC_INFORMATION, Mem_T.ClockRatesSupported__FDC_INFORMATION, Mem_T.FloppyControllerType__FDC_INFORMATION, Mem_T.FdcType__FDC_FDO_EXTENSION, Mem_T.Clock48MHz__FDC_FDO_EXTENSION, Mem_T.FdcSpeeds__FDC_FDO_EXTENSION, Mem_T.MaximumLength__DEVICE_DESCRIPTION, Mem_T.AdapterObject__FDC_FDO_EXTENSION, Mem_T.PINT4, Mem_T.InterruptMode__FDC_FDO_EXTENSION, Mem_T.ControllerVector__FDC_FDO_EXTENSION, Mem_T.ProcessorMask__FDC_FDO_EXTENSION, Mem_T.ControllerIrql__FDC_FDO_EXTENSION, Mem_T.SharableVector__FDC_FDO_EXTENSION, Mem_T.SaveFloatState__FDC_FDO_EXTENSION, Mem_T.BusType__FDC_FDO_EXTENSION, Mem_T.BusNumber__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION, Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION, sdv_io_dpc, Mem_T.DeferredRoutine__KDPC, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, yogi_error, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT, Mem_T.NumPDOs__FDC_FDO_EXTENSION, sdv_io_create_device_called, PagingReferenceCount;



implementation {:origName "FdcFdoPnp"} FdcFdoPnp(actual_DeviceObject_37: int, actual_Irp_23: int) returns (Tmp_508: int)
{
  var {:pointer} pdoExtension_4: int;
  var {:pointer} irpSp_14: int;
  var {:pointer} sdv_284: int;
  var {:scalar} doneEvent_3: int;
  var {:pointer} Tmp_509: int;
  var {:scalar} ntStatus_19: int;
  var {:scalar} oldIrql_1: int;
  var {:scalar} sdv_292: int;
  var {:pointer} fdoExtension_10: int;
  var {:scalar} sdv_297: int;
  var {:pointer} entry_2: int;
  var {:pointer} DeviceObject_37: int;
  var {:pointer} Irp_23: int;
  var vslice_dummy_var_123: int;
  var vslice_dummy_var_124: int;
  var vslice_dummy_var_125: int;
  var vslice_dummy_var_126: int;
  var vslice_dummy_var_127: int;
  var vslice_dummy_var_128: int;
  var vslice_dummy_var_129: int;
  var vslice_dummy_var_130: int;

  anon0:
    call doneEvent_3 := __HAVOC_malloc(156);
    DeviceObject_37 := actual_DeviceObject_37;
    Irp_23 := actual_Irp_23;
    assume {:nonnull} DeviceObject_37 != 0;
    assume DeviceObject_37 > 0;
    fdoExtension_10 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_37)];
    call irpSp_14 := sdv_IoGetCurrentIrpStackLocation(Irp_23);
    ntStatus_19 := 0;
    call Tmp_509 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_509 != 0;
    assume Tmp_509 > 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.INT4[Tmp_509] := Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_10)];
    call vslice_dummy_var_130 := sdv_InterlockedIncrement(Tmp_509);
    assume {:nonnull} Tmp_509 != 0;
    assume Tmp_509 > 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_10)] := Mem_T.INT4[Tmp_509];
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    goto anon61_Then, anon61_Else;

  anon61_Else:
    assume {:partition} Mem_T.Removed__FDC_FDO_EXTENSION[Removed__FDC_FDO_EXTENSION(fdoExtension_10)] != 0;
    oldIrql_1 := 0;
    call Tmp_509 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_509 != 0;
    assume Tmp_509 > 0;
    Mem_T.INT4[Tmp_509] := oldIrql_1;
    call sdv_KeAcquireSpinLock(0, Tmp_509);
    assume {:nonnull} Tmp_509 != 0;
    assume Tmp_509 > 0;
    oldIrql_1 := Mem_T.INT4[Tmp_509];
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Information__IO_STATUS_BLOCK[Information__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := 0;
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := -1073741738;
    call sdv_IoCompleteRequest(0, 0);
    call Tmp_509 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_509 != 0;
    assume Tmp_509 > 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.INT4[Tmp_509] := Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_10)];
    call sdv_292 := sdv_InterlockedDecrement(Tmp_509);
    assume {:nonnull} Tmp_509 != 0;
    assume Tmp_509 > 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_10)] := Mem_T.INT4[Tmp_509];
    goto anon63_Then, anon63_Else;

  anon63_Else:
    assume {:partition} sdv_292 != 0;
    goto L35;

  L35:
    Tmp_508 := -1073741738;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon63_Then:
    assume {:partition} sdv_292 == 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call vslice_dummy_var_123 := KeSetEvent(RemoveEvent__FDC_FDO_EXTENSION(fdoExtension_10), 0, 1);
    goto L35;

  anon61_Then:
    assume {:partition} Mem_T.Removed__FDC_FDO_EXTENSION[Removed__FDC_FDO_EXTENSION(fdoExtension_10)] == 0;
    assume {:nonnull} irpSp_14 != 0;
    assume irpSp_14 > 0;
    goto anon62_Then, anon62_Else;

  anon62_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] != 0;
    assume {:nonnull} irpSp_14 != 0;
    assume irpSp_14 > 0;
    goto anon82_Then, anon82_Else;

  anon82_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] != 1;
    assume {:nonnull} irpSp_14 != 0;
    assume irpSp_14 > 0;
    goto anon81_Then, anon81_Else;

  anon81_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] != 2;
    assume {:nonnull} irpSp_14 != 0;
    assume irpSp_14 > 0;
    goto anon80_Then, anon80_Else;

  anon80_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] != 3;
    assume {:nonnull} irpSp_14 != 0;
    assume irpSp_14 > 0;
    goto anon79_Then, anon79_Else;

  anon79_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] != 4;
    assume {:nonnull} irpSp_14 != 0;
    assume irpSp_14 > 0;
    goto anon78_Then, anon78_Else;

  anon78_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] != 5;
    assume {:nonnull} irpSp_14 != 0;
    assume irpSp_14 > 0;
    goto anon77_Then, anon77_Else;

  anon77_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] != 6;
    assume {:nonnull} irpSp_14 != 0;
    assume irpSp_14 > 0;
    goto anon76_Then, anon76_Else;

  anon76_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] != 7;
    assume {:nonnull} irpSp_14 != 0;
    assume irpSp_14 > 0;
    goto anon75_Then, anon75_Else;

  anon75_Else:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] == 13;
    call ntStatus_19 := FdcFilterResourceRequirements(DeviceObject_37, Irp_23);
    goto anon90_Then, anon90_Else;

  anon90_Else:
    assume {:partition} yogi_error != 1;
    goto L56;

  L56:
    call Tmp_509 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_509 != 0;
    assume Tmp_509 > 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.INT4[Tmp_509] := Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_10)];
    call sdv_297 := sdv_InterlockedDecrement(Tmp_509);
    assume {:nonnull} Tmp_509 != 0;
    assume Tmp_509 > 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_10)] := Mem_T.INT4[Tmp_509];
    goto anon67_Then, anon67_Else;

  anon67_Else:
    assume {:partition} sdv_297 != 0;
    goto L63;

  L63:
    Tmp_508 := ntStatus_19;
    goto L1;

  anon67_Then:
    assume {:partition} sdv_297 == 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call vslice_dummy_var_124 := KeSetEvent(RemoveEvent__FDC_FDO_EXTENSION(fdoExtension_10), 0, 0);
    goto L63;

  anon90_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon75_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] != 13;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_23);
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call ntStatus_19 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_10)], Irp_23);
    goto L56;

  anon76_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] == 7;
    call ntStatus_19 := FdcQueryDeviceRelations(DeviceObject_37, Irp_23);
    goto anon89_Then, anon89_Else;

  anon89_Else:
    assume {:partition} yogi_error != 1;
    goto L56;

  anon89_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon77_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] == 6;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.Paused__FDC_FDO_EXTENSION[Paused__FDC_FDO_EXTENSION(fdoExtension_10)] := 0;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_23);
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call ntStatus_19 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_10)], Irp_23);
    call vslice_dummy_var_125 := FdcFdoInternalDeviceControl(DeviceObject_37, 0);
    goto anon88_Then, anon88_Else;

  anon88_Else:
    assume {:partition} yogi_error != 1;
    goto L56;

  anon88_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon78_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] == 5;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    goto anon66_Then, anon66_Else;

  anon66_Else:
    assume {:partition} Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(fdoExtension_10)] != 0;
    goto L79;

  L79:
    ntStatus_19 := 17;
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := ntStatus_19;
    call sdv_IoCompleteRequest(0, 0);
    goto L56;

  anon66_Then:
    assume {:partition} Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(fdoExtension_10)] == 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    goto anon68_Then, anon68_Else;

  anon68_Else:
    assume {:partition} Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION[TapeEnumerationPending__FDC_FDO_EXTENSION(fdoExtension_10)] == 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.Paused__FDC_FDO_EXTENSION[Paused__FDC_FDO_EXTENSION(fdoExtension_10)] := 1;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_23);
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call ntStatus_19 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_10)], Irp_23);
    goto L56;

  anon68_Then:
    assume {:partition} Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION[TapeEnumerationPending__FDC_FDO_EXTENSION(fdoExtension_10)] != 0;
    goto L79;

  anon79_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] == 4;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_23);
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call ntStatus_19 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_10)], Irp_23);
    goto L56;

  anon80_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] == 3;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.Paused__FDC_FDO_EXTENSION[Paused__FDC_FDO_EXTENSION(fdoExtension_10)] := 0;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_23);
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call ntStatus_19 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_10)], Irp_23);
    call vslice_dummy_var_126 := FdcFdoInternalDeviceControl(DeviceObject_37, 0);
    goto anon87_Then, anon87_Else;

  anon87_Else:
    assume {:partition} yogi_error != 1;
    goto L56;

  anon87_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon81_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] == 2;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    goto anon65_Then, anon65_Else;

  anon65_Else:
    assume {:partition} Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION[BufferThreadHandle__FDC_FDO_EXTENSION(fdoExtension_10)] != 0;
    call vslice_dummy_var_127 := FdcTerminateBufferThread(fdoExtension_10);
    goto anon86_Then, anon86_Else;

  anon86_Else:
    assume {:partition} yogi_error != 1;
    goto L112;

  L112:
    call sdv_IoSkipCurrentIrpStackLocation(Irp_23);
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call ntStatus_19 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_10)], Irp_23);
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    goto anon69_Then, anon69_Else;

  anon69_Else:
    assume {:partition} Mem_T.FdcEnablerFileObject__FDC_FDO_EXTENSION[FdcEnablerFileObject__FDC_FDO_EXTENSION(fdoExtension_10)] == 0;
    goto L129;

  L129:
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    entry_2 := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(PDOs__FDC_FDO_EXTENSION(fdoExtension_10))];
    goto L130;

  L130:
    call pdoExtension_4, sdv_284, entry_2 := FdcFdoPnp_loop_L130(pdoExtension_4, sdv_284, entry_2);
    goto L130_last;

  anon70_Else:
    call sdv_284 := sdv_containing_record(entry_2, 20);
    pdoExtension_4 := sdv_284;
    assume {:nonnull} entry_2 != 0;
    assume entry_2 > 0;
    entry_2 := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(entry_2)];
    assume {:nonnull} pdoExtension_4 != 0;
    assume pdoExtension_4 > 0;
    Mem_T.Removed__FDC_PDO_EXTENSION[Removed__FDC_PDO_EXTENSION(pdoExtension_4)] := 1;
    call IoDeleteDevice(0);
    goto anon70_Else_dummy;

  anon70_Then:
    call IoDetachDevice(0);
    FdcDefaultControllerNumber := FdcDefaultControllerNumber - 1;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.Removed__FDC_FDO_EXTENSION[Removed__FDC_FDO_EXTENSION(fdoExtension_10)] := 1;
    call IoDeleteDevice(0);
    goto L56;

  anon69_Then:
    assume {:partition} Mem_T.FdcEnablerFileObject__FDC_FDO_EXTENSION[FdcEnablerFileObject__FDC_FDO_EXTENSION(fdoExtension_10)] != 0;
    call vslice_dummy_var_128 := sdv_ObDereferenceObject(0);
    goto L129;

  anon86_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon65_Then:
    assume {:partition} Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION[BufferThreadHandle__FDC_FDO_EXTENSION(fdoExtension_10)] == 0;
    goto L112;

  anon82_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] == 1;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    goto anon64_Then, anon64_Else;

  anon64_Else:
    assume {:partition} Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(fdoExtension_10)] != 0;
    goto L151;

  L151:
    ntStatus_19 := 17;
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := ntStatus_19;
    call sdv_IoCompleteRequest(0, 0);
    goto L56;

  anon64_Then:
    assume {:partition} Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(fdoExtension_10)] == 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    goto anon71_Then, anon71_Else;

  anon71_Else:
    assume {:partition} Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION[TapeEnumerationPending__FDC_FDO_EXTENSION(fdoExtension_10)] == 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.Paused__FDC_FDO_EXTENSION[Paused__FDC_FDO_EXTENSION(fdoExtension_10)] := 1;
    call sdv_IoSkipCurrentIrpStackLocation(Irp_23);
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call ntStatus_19 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_10)], Irp_23);
    goto L56;

  anon71_Then:
    assume {:partition} Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION[TapeEnumerationPending__FDC_FDO_EXTENSION(fdoExtension_10)] != 0;
    goto L151;

  anon62_Then:
    assume {:partition} Mem_T.MinorFunction__IO_STACK_LOCATION[MinorFunction__IO_STACK_LOCATION(irpSp_14)] == 0;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.Paused__FDC_FDO_EXTENSION[Paused__FDC_FDO_EXTENSION(fdoExtension_10)] := 0;
    call KeInitializeEvent(doneEvent_3, 0, 0);
    call sdv_IoCopyCurrentIrpStackLocationToNext(Irp_23);
    call sdv_IoSetCompletionRoutine(Irp_23, li2bplFunctionConstant201, doneEvent_3, 1, 1, 1);
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    call ntStatus_19 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_10)], Irp_23);
    goto anon72_Then, anon72_Else;

  anon72_Else:
    assume {:partition} ntStatus_19 == 259;
    call ntStatus_19 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto anon83_Then, anon83_Else;

  anon83_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    ntStatus_19 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))];
    goto L180;

  L180:
    goto anon73_Then, anon73_Else;

  anon73_Else:
    assume {:partition} ntStatus_19 >= 0;
    call ntStatus_19 := FdcStartDevice(DeviceObject_37, Irp_23);
    goto anon84_Then, anon84_Else;

  anon84_Else:
    assume {:partition} yogi_error != 1;
    goto L186;

  L186:
    goto anon74_Then, anon74_Else;

  anon74_Else:
    assume {:partition} ntStatus_19 >= 0;
    goto L192;

  L192:
    assume {:nonnull} Irp_23 != 0;
    assume Irp_23 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_23))] := ntStatus_19;
    call sdv_IoCompleteRequest(0, 0);
    call vslice_dummy_var_129 := FdcFdoInternalDeviceControl(DeviceObject_37, 0);
    goto anon85_Then, anon85_Else;

  anon85_Else:
    assume {:partition} yogi_error != 1;
    goto L56;

  anon85_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon74_Then:
    assume {:partition} 0 > ntStatus_19;
    assume {:nonnull} fdoExtension_10 != 0;
    assume fdoExtension_10 > 0;
    Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION[TapeEnumerationPending__FDC_FDO_EXTENSION(fdoExtension_10)] := 0;
    goto L192;

  anon84_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon73_Then:
    assume {:partition} 0 > ntStatus_19;
    goto L186;

  anon83_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon72_Then:
    assume {:partition} ntStatus_19 != 259;
    goto L180;

  anon70_Else_dummy:
    assume false;
    return;

  L130_last:
    goto anon70_Then, anon70_Else;
}



procedure {:origName "RemoveHeadList"} RemoveHeadList(actual_ListHead_4: int) returns (Tmp_510: int);
  modifies alloc, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY;



implementation {:origName "RemoveHeadList"} RemoveHeadList(actual_ListHead_4: int) returns (Tmp_510: int)
{
  var {:pointer} NextEntry: int;
  var {:pointer} Entry_1: int;
  var {:pointer} ListHead_4: int;

  anon0:
    ListHead_4 := actual_ListHead_4;
    assume {:nonnull} ListHead_4 != 0;
    assume ListHead_4 > 0;
    Entry_1 := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(ListHead_4)];
    assume {:nonnull} Entry_1 != 0;
    assume Entry_1 > 0;
    NextEntry := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(Entry_1)];
    goto anon6_Then, anon6_Else;

  anon6_Else:
    goto L9;

  L9:
    call FatalListEntryError(ListHead_4, Entry_1, NextEntry);
    goto L12;

  L12:
    assume {:nonnull} ListHead_4 != 0;
    assume ListHead_4 > 0;
    Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(ListHead_4)] := NextEntry;
    assume {:nonnull} NextEntry != 0;
    assume NextEntry > 0;
    Mem_T.Blink__LIST_ENTRY[Blink__LIST_ENTRY(NextEntry)] := ListHead_4;
    Tmp_510 := Entry_1;
    return;

  anon6_Then:
    goto anon5_Then, anon5_Else;

  anon5_Else:
    goto L12;

  anon5_Then:
    goto L9;
}



procedure {:origName "FcFreeAdapterChannel"} FcFreeAdapterChannel(actual_FdoExtension_11: int);
  modifies alloc, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current;



implementation {:origName "FcFreeAdapterChannel"} FcFreeAdapterChannel(actual_FdoExtension_11: int)
{
  var {:scalar} oldIrql_2: int;
  var {:pointer} Tmp_513: int;
  var {:pointer} FdoExtension_11: int;
  var vslice_dummy_var_131: int;

  anon0:
    call vslice_dummy_var_131 := __HAVOC_malloc(4);
    FdoExtension_11 := actual_FdoExtension_11;
    assume {:nonnull} FdoExtension_11 != 0;
    assume FdoExtension_11 > 0;
    Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION[AdapterChannelRefCount__FDC_FDO_EXTENSION(FdoExtension_11)] := Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION[AdapterChannelRefCount__FDC_FDO_EXTENSION(FdoExtension_11)] - 1;
    assume {:nonnull} FdoExtension_11 != 0;
    assume FdoExtension_11 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION[AdapterChannelRefCount__FDC_FDO_EXTENSION(FdoExtension_11)] == 0;
    call Tmp_513 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_513 != 0;
    assume Tmp_513 > 0;
    Mem_T.INT4[Tmp_513] := oldIrql_2;
    call sdv_KeRaiseIrql(2, Tmp_513);
    assume {:nonnull} Tmp_513 != 0;
    assume Tmp_513 > 0;
    oldIrql_2 := Mem_T.INT4[Tmp_513];
    call sdv_IoFreeAdapterChannel(0);
    call sdv_KeLowerIrql(oldIrql_2);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION[AdapterChannelRefCount__FDC_FDO_EXTENSION(FdoExtension_11)] != 0;
    goto L1;
}



procedure {:origName "RtlFailFast"} RtlFailFast(actual_Code: int);
  modifies alloc;



implementation {:origName "RtlFailFast"} RtlFailFast(actual_Code: int)
{
  var vslice_dummy_var_132: int;

  anon0:
    call vslice_dummy_var_132 := __HAVOC_malloc(4);
    return;
}



procedure {:origName "FdcTerminateBufferThread"} FdcTerminateBufferThread(actual_FdoExtension_12: int) returns (Tmp_516: int);
  modifies alloc, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION, yogi_error;



implementation {:origName "FdcTerminateBufferThread"} FdcTerminateBufferThread(actual_FdoExtension_12: int) returns (Tmp_516: int)
{
  var {:scalar} timeout: int;
  var {:pointer} Tmp_517: int;
  var {:scalar} oldIrql_3: int;
  var {:scalar} status_8: int;
  var {:pointer} FdoExtension_12: int;
  var vslice_dummy_var_133: int;
  var vslice_dummy_var_134: int;
  var vslice_dummy_var_135: int;

  anon0:
    call timeout := __HAVOC_malloc(20);
    FdoExtension_12 := actual_FdoExtension_12;
    call status_8 := ObReferenceObjectByHandle(0, 1048576, 0, 0, 0, 0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} status_8 >= 0;
    assume {:nonnull} timeout != 0;
    assume timeout > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(timeout)] := 0;
    call status_8 := KeWaitForSingleObject(0, 0, 0, 0, timeout);
    goto anon11_Then, anon11_Else;

  anon11_Else:
    assume {:partition} yogi_error != 1;
    goto anon10_Then, anon10_Else;

  anon10_Else:
    assume {:partition} status_8 == 258;
    call Tmp_517 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_517 != 0;
    assume Tmp_517 > 0;
    Mem_T.INT4[Tmp_517] := oldIrql_3;
    call sdv_KeAcquireSpinLock(0, Tmp_517);
    assume {:nonnull} Tmp_517 != 0;
    assume Tmp_517 > 0;
    oldIrql_3 := Mem_T.INT4[Tmp_517];
    assume {:nonnull} FdoExtension_12 != 0;
    assume FdoExtension_12 > 0;
    assume {:nonnull} timeout != 0;
    assume timeout > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(timeout)] := 0;
    call vslice_dummy_var_135 := KeSetTimer(0, timeout, 0);
    call sdv_KeReleaseSpinLock(0, oldIrql_3);
    call status_8 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto anon12_Then, anon12_Else;

  anon12_Else:
    assume {:partition} yogi_error != 1;
    goto L18;

  L18:
    call vslice_dummy_var_133 := sdv_ObDereferenceObject(0);
    call vslice_dummy_var_134 := ZwClose(0);
    assume {:nonnull} FdoExtension_12 != 0;
    assume FdoExtension_12 > 0;
    Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION[BufferThreadHandle__FDC_FDO_EXTENSION(FdoExtension_12)] := 0;
    assume {:nonnull} FdoExtension_12 != 0;
    assume FdoExtension_12 > 0;
    Tmp_516 := status_8;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon12_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon10_Then:
    assume {:partition} status_8 != 258;
    goto L18;

  anon11_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon9_Then:
    assume {:partition} 0 > status_8;
    Tmp_516 := status_8;
    goto L1;
}



procedure {:origName "FcTurnOffMotor"} FcTurnOffMotor(actual_FdoExtension_13: int) returns (Tmp_518: int);
  modifies Mem_T.DriveControlImage__FDC_FDO_EXTENSION;



implementation {:origName "FcTurnOffMotor"} FcTurnOffMotor(actual_FdoExtension_13: int) returns (Tmp_518: int)
{
  var {:pointer} FdoExtension_13: int;

  anon0:
    FdoExtension_13 := actual_FdoExtension_13;
    assume {:nonnull} FdoExtension_13 != 0;
    assume FdoExtension_13 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_13)] := 12;
    Tmp_518 := 0;
    return;
}



procedure {:origName "FdcFdoInternalDeviceControl"} FdcFdoInternalDeviceControl(actual_DeviceObject_38: int, actual_Irp_24: int) returns (Tmp_520: int);
  modifies alloc, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.INT4, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.Type3InputBuffer_unnamed_tag_22, Mem_T.Type_unnamed_tag_28, Mem_T.MajorFunction__IO_STACK_LOCATION, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, sdv_isr_routine, sdv_pDpcContext, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, yogi_error;



implementation {:origName "FdcFdoInternalDeviceControl"} FdcFdoInternalDeviceControl(actual_DeviceObject_38: int, actual_Irp_24: int) returns (Tmp_520: int)
{
  var {:pointer} issueCommandParms_2: int;
  var {:pointer} sdv_308: int;
  var {:pointer} Tmp_521: int;
  var {:scalar} powerQueueClear: int;
  var {:pointer} irpSp_15: int;
  var {:pointer} Tmp_522: int;
  var {:pointer} Tmp_523: int;
  var {:scalar} currentTime: int;
  var {:pointer} deferredRequest: int;
  var {:pointer} fdcDiskChangeParms: int;
  var {:pointer} Tmp_524: int;
  var {:pointer} sdv_313: int;
  var {:pointer} adapterBufferParms: int;
  var {:scalar} Tmp_525: int;
  var {:scalar} sdv_315: int;
  var {:scalar} ntStatus_20: int;
  var {:pointer} fdoExtension_11: int;
  var {:scalar} sdv_319: int;
  var {:pointer} currentIrp: int;
  var {:scalar} ioControlCode: int;
  var {:scalar} tapeMode: int;
  var {:scalar} fdcModeSelect: int;
  var {:pointer} DeviceObject_38: int;
  var {:pointer} Irp_24: int;
  var boogieTmp: int;
  var vslice_dummy_var_136: int;
  var vslice_dummy_var_137: int;
  var vslice_dummy_var_138: int;
  var vslice_dummy_var_139: int;

  anon0:
    call currentTime := __HAVOC_malloc(20);
    call fdcModeSelect := __HAVOC_malloc(20);
    DeviceObject_38 := actual_DeviceObject_38;
    Irp_24 := actual_Irp_24;
    powerQueueClear := 0;
    assume {:nonnull} DeviceObject_38 != 0;
    assume DeviceObject_38 > 0;
    fdoExtension_11 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_38)];
    goto anon125_Then, anon125_Else;

  anon125_Else:
    assume {:partition} FdcInSetupMode != 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(fdoExtension_11)] := 0;
    goto L21;

  L21:
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    goto anon91_Then, anon91_Else;

  anon91_Else:
    assume {:partition} Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(fdoExtension_11)] != 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    goto anon93_Then, anon93_Else;

  anon93_Else:
    assume {:partition} Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(FdcFailedTime__FDC_FDO_EXTENSION(fdoExtension_11))] != 0;
    assume {:nonnull} currentTime != 0;
    assume currentTime > 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    goto anon94_Then, anon94_Else;

  anon94_Else:
    assume {:partition} Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(currentTime)] > Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(FdcFailedTime__FDC_FDO_EXTENSION(fdoExtension_11))] + 600000;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(fdoExtension_11)] := 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(FdcFailedTime__FDC_FDO_EXTENSION(fdoExtension_11))] := 0;
    goto L23;

  L23:
    goto anon92_Then, anon92_Else;

  anon92_Else:
    assume {:partition} Irp_24 != 0;
    call Tmp_522 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_522 != 0;
    assume Tmp_522 > 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.INT4[Tmp_522] := Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_11)];
    call vslice_dummy_var_139 := sdv_InterlockedIncrement(Tmp_522);
    assume {:nonnull} Tmp_522 != 0;
    assume Tmp_522 > 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_11)] := Mem_T.INT4[Tmp_522];
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    goto anon95_Then, anon95_Else;

  anon95_Else:
    assume {:partition} Mem_T.Removed__FDC_FDO_EXTENSION[Removed__FDC_FDO_EXTENSION(fdoExtension_11)] != 0;
    call Tmp_522 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_522 != 0;
    assume Tmp_522 > 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.INT4[Tmp_522] := Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_11)];
    call sdv_319 := sdv_InterlockedDecrement(Tmp_522);
    assume {:nonnull} Tmp_522 != 0;
    assume Tmp_522 > 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_11)] := Mem_T.INT4[Tmp_522];
    goto anon97_Then, anon97_Else;

  anon97_Else:
    assume {:partition} sdv_319 != 0;
    goto L48;

  L48:
    ntStatus_20 := -1073741738;
    assume {:nonnull} Irp_24 != 0;
    assume Irp_24 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_24))] := ntStatus_20;
    call sdv_IoCompleteRequest(0, 0);
    Tmp_520 := ntStatus_20;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon97_Then:
    assume {:partition} sdv_319 == 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    call vslice_dummy_var_136 := KeSetEvent(RemoveEvent__FDC_FDO_EXTENSION(fdoExtension_11), 0, 0);
    goto L48;

  anon95_Then:
    assume {:partition} Mem_T.Removed__FDC_FDO_EXTENSION[Removed__FDC_FDO_EXTENSION(fdoExtension_11)] == 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    goto anon96_Then, anon96_Else;

  anon96_Else:
    assume {:partition} Mem_T.Paused__FDC_FDO_EXTENSION[Paused__FDC_FDO_EXTENSION(fdoExtension_11)] != 0;
    goto L55;

  L55:
    call vslice_dummy_var_137 := sdv_ExInterlockedInsertTailList(0, 0, 0);
    call sdv_IoMarkIrpPending(0);
    ntStatus_20 := 259;
    Tmp_520 := ntStatus_20;
    goto L1;

  anon96_Then:
    assume {:partition} Mem_T.Paused__FDC_FDO_EXTENSION[Paused__FDC_FDO_EXTENSION(fdoExtension_11)] == 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    goto anon98_Then, anon98_Else;

  anon98_Else:
    assume {:partition} Mem_T.CurrentPowerState__FDC_FDO_EXTENSION[CurrentPowerState__FDC_FDO_EXTENSION(fdoExtension_11)] == 4;
    goto L55;

  anon98_Then:
    assume {:partition} Mem_T.CurrentPowerState__FDC_FDO_EXTENSION[CurrentPowerState__FDC_FDO_EXTENSION(fdoExtension_11)] != 4;
    goto L33;

  L33:
    call issueCommandParms_2, sdv_308, Tmp_521, powerQueueClear, irpSp_15, Tmp_522, Tmp_523, deferredRequest, fdcDiskChangeParms, Tmp_524, sdv_313, adapterBufferParms, Tmp_525, sdv_315, ntStatus_20, currentIrp, ioControlCode, tapeMode, boogieTmp, vslice_dummy_var_138 := FdcFdoInternalDeviceControl_loop_L33(issueCommandParms_2, sdv_308, Tmp_521, powerQueueClear, irpSp_15, Tmp_522, Tmp_523, deferredRequest, fdcDiskChangeParms, Tmp_524, sdv_313, adapterBufferParms, Tmp_525, sdv_315, ntStatus_20, fdoExtension_11, currentIrp, ioControlCode, tapeMode, fdcModeSelect, DeviceObject_38, Irp_24, boogieTmp, vslice_dummy_var_138);
    goto L33_last;

  anon99_Else:
    call sdv_313 := sdv_containing_record(deferredRequest, 88);
    currentIrp := sdv_313;
    goto L70;

  L70:
    call irpSp_15 := sdv_IoGetCurrentIrpStackLocation(currentIrp);
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    ioControlCode := Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))];
    goto anon126_Then, anon126_Else;

  anon126_Else:
    assume {:partition} ioControlCode == 461891;
    goto L77;

  L77:
    ntStatus_20 := -1073741808;
    goto L78;

  L78:
    goto anon102_Then, anon102_Else;

  anon102_Else:
    assume {:partition} ntStatus_20 != 259;
    call Tmp_522 := __HAVOC_malloc(4);
    assume {:nonnull} Tmp_522 != 0;
    assume Tmp_522 > 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.INT4[Tmp_522] := Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_11)];
    call sdv_315 := sdv_InterlockedDecrement(Tmp_522);
    assume {:nonnull} Tmp_522 != 0;
    assume Tmp_522 > 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(fdoExtension_11)] := Mem_T.INT4[Tmp_522];
    goto anon104_Then, anon104_Else;

  anon104_Else:
    assume {:partition} sdv_315 != 0;
    goto L87;

  L87:
    assume {:nonnull} currentIrp != 0;
    assume currentIrp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(currentIrp))] := ntStatus_20;
    call sdv_IoCompleteRequest(0, 1);
    goto L79;

  L79:
    goto anon103_Then, anon103_Else;

  anon103_Else:
    assume {:partition} powerQueueClear != 0;
    goto L91;

  L91:
    Tmp_520 := ntStatus_20;
    goto L1;

  anon103_Then:
    assume {:partition} powerQueueClear == 0;
    goto anon103_Then_dummy;

  anon104_Then:
    assume {:partition} sdv_315 == 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    call vslice_dummy_var_138 := KeSetEvent(RemoveEvent__FDC_FDO_EXTENSION(fdoExtension_11), 0, 0);
    goto L87;

  anon102_Then:
    assume {:partition} ntStatus_20 == 259;
    goto L79;

  anon126_Then:
    assume {:partition} ioControlCode != 461891;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume {:partition} ioControlCode != 461835;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    goto anon105_Then, anon105_Else;

  anon105_Else:
    assume {:partition} Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(fdoExtension_11)] != 0;
    goto L94;

  L94:
    goto anon107_Then, anon107_Else;

  anon107_Else:
    assume {:partition} ioControlCode != 461827;
    goto anon124_Then, anon124_Else;

  anon124_Else:
    assume {:partition} ioControlCode != 461831;
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume {:partition} ioControlCode != 461839;
    goto anon122_Then, anon122_Else;

  anon122_Else:
    assume {:partition} ioControlCode != 461843;
    goto anon121_Then, anon121_Else;

  anon121_Else:
    assume {:partition} ioControlCode != 461847;
    goto anon120_Then, anon120_Else;

  anon120_Else:
    assume {:partition} ioControlCode != 461851;
    goto anon119_Then, anon119_Else;

  anon119_Else:
    assume {:partition} ioControlCode != 461855;
    goto anon118_Then, anon118_Else;

  anon118_Else:
    assume {:partition} ioControlCode != 461859;
    goto anon117_Then, anon117_Else;

  anon117_Else:
    assume {:partition} ioControlCode != 461863;
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume {:partition} ioControlCode != 461867;
    goto anon115_Then, anon115_Else;

  anon115_Else:
    assume {:partition} ioControlCode != 461871;
    goto anon114_Then, anon114_Else;

  anon114_Else:
    assume {:partition} ioControlCode != 461875;
    goto anon113_Then, anon113_Else;

  anon113_Else:
    assume {:partition} ioControlCode != 461879;
    goto anon112_Then, anon112_Else;

  anon112_Else:
    assume {:partition} ioControlCode != 461883;
    goto anon111_Then, anon111_Else;

  anon111_Else:
    assume {:partition} ioControlCode == 461887;
    goto L123;

  L123:
    ntStatus_20 := 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    goto anon133_Then, anon133_Else;

  anon133_Else:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(fdoExtension_11)] != 0;
    assume {:nonnull} fdcModeSelect != 0;
    assume fdcModeSelect > 0;
    assume {:nonnull} fdcModeSelect != 0;
    assume fdcModeSelect > 0;
    assume {:nonnull} fdcModeSelect != 0;
    assume fdcModeSelect > 0;
    assume {:nonnull} fdcModeSelect != 0;
    assume fdcModeSelect > 0;
    assume {:nonnull} fdcModeSelect != 0;
    assume fdcModeSelect > 0;
    assume {:nonnull} fdcModeSelect != 0;
    assume fdcModeSelect > 0;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    goto anon134_Then, anon134_Else;

  anon134_Else:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))] == 461883;
    assume {:nonnull} fdcModeSelect != 0;
    assume fdcModeSelect > 0;
    goto L136;

  L136:
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    call ntStatus_20 := FcFdcEnabler(Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION[FdcEnablerDeviceObject__FDC_FDO_EXTENSION(fdoExtension_11)], 2031635, fdcModeSelect);
    goto anon135_Then, anon135_Else;

  anon135_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon135_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon134_Then:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))] != 461883;
    assume {:nonnull} fdcModeSelect != 0;
    assume fdcModeSelect > 0;
    goto L136;

  anon133_Then:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(fdoExtension_11)] == 0;
    goto L78;

  anon111_Then:
    assume {:partition} ioControlCode != 461887;
    ntStatus_20 := -1073741808;
    goto L78;

  anon112_Then:
    assume {:partition} ioControlCode == 461883;
    goto L123;

  anon113_Then:
    assume {:partition} ioControlCode == 461879;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    adapterBufferParms := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))];
    assume {:nonnull} adapterBufferParms != 0;
    assume adapterBufferParms > 0;
    goto anon132_Then, anon132_Else;

  anon132_Else:
    assume {:partition} Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(adapterBufferParms)] != 0;
    call IoFreeMdl(0);
    goto L141;

  L141:
    ntStatus_20 := 0;
    goto L78;

  anon132_Then:
    assume {:partition} Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(adapterBufferParms)] == 0;
    goto L141;

  anon114_Then:
    assume {:partition} ioControlCode == 461875;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    adapterBufferParms := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))];
    assume {:nonnull} adapterBufferParms != 0;
    assume adapterBufferParms > 0;
    Tmp_525 := Mem_T.TransferBytes__ISSUE_FDC_ADAPTER_BUFFER_PARMS[TransferBytes__ISSUE_FDC_ADAPTER_BUFFER_PARMS(adapterBufferParms)];
    call sdv_308 := IoAllocateMdl(0, Tmp_525, 0, 0, 0);
    assume {:nonnull} adapterBufferParms != 0;
    assume adapterBufferParms > 0;
    Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(adapterBufferParms)] := sdv_308;
    assume {:nonnull} adapterBufferParms != 0;
    assume adapterBufferParms > 0;
    goto anon131_Then, anon131_Else;

  anon131_Else:
    assume {:partition} Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(adapterBufferParms)] != 0;
    ntStatus_20 := 0;
    goto L78;

  anon131_Then:
    assume {:partition} Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(adapterBufferParms)] == 0;
    ntStatus_20 := -1073741670;
    goto L78;

  anon115_Then:
    assume {:partition} ioControlCode == 461871;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    ntStatus_20 := 0;
    goto L78;

  anon116_Then:
    assume {:partition} ioControlCode == 461867;
    call tapeMode := corral_nondet();
    tapeMode := BAND(tapeMode, BOR(BOR(BOR(BOR(BOR(4, 8), 16), 32), 64), 128));
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    Tmp_523 := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))];
    assume {:nonnull} Tmp_523 != 0;
    assume Tmp_523 > 0;
    tapeMode := BOR(tapeMode, Mem_T.INT4[Tmp_523]);
    ntStatus_20 := 0;
    goto L78;

  anon117_Then:
    assume {:partition} ioControlCode == 461863;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    ntStatus_20 := 0;
    goto L78;

  anon118_Then:
    assume {:partition} ioControlCode == 461859;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    fdcDiskChangeParms := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))];
    assume {:nonnull} fdcDiskChangeParms != 0;
    assume fdcDiskChangeParms > 0;
    call boogieTmp := corral_nondet();
    Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS[DriveStatus__FDC_DISK_CHANGE_PARMS(fdcDiskChangeParms)] := boogieTmp;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    goto anon108_Then, anon108_Else;

  anon108_Else:
    assume {:partition} Mem_T.WakeUp__FDC_FDO_EXTENSION[WakeUp__FDC_FDO_EXTENSION(fdoExtension_11)] != 0;
    assume {:nonnull} fdcDiskChangeParms != 0;
    assume fdcDiskChangeParms > 0;
    Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS[DriveStatus__FDC_DISK_CHANGE_PARMS(fdcDiskChangeParms)] := BOR(Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS[DriveStatus__FDC_DISK_CHANGE_PARMS(fdcDiskChangeParms)], 128);
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.WakeUp__FDC_FDO_EXTENSION[WakeUp__FDC_FDO_EXTENSION(fdoExtension_11)] := 0;
    goto L181;

  L181:
    ntStatus_20 := 0;
    goto L78;

  anon108_Then:
    assume {:partition} Mem_T.WakeUp__FDC_FDO_EXTENSION[WakeUp__FDC_FDO_EXTENSION(fdoExtension_11)] == 0;
    goto L181;

  anon119_Then:
    assume {:partition} ioControlCode == 461855;
    call ntStatus_20 := FcTurnOffMotor(fdoExtension_11);
    goto L78;

  anon120_Then:
    assume {:partition} ioControlCode == 461851;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    Tmp_521 := DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15));
    assume {:nonnull} Tmp_521 != 0;
    assume Tmp_521 > 0;
    call ntStatus_20 := FcTurnOnMotor(fdoExtension_11, Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(Tmp_521)]);
    goto L78;

  anon121_Then:
    assume {:partition} ioControlCode == 461847;
    call ntStatus_20 := FcInitializeControllerHardware(fdoExtension_11, DeviceObject_38);
    goto anon130_Then, anon130_Else;

  anon130_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon130_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon122_Then:
    assume {:partition} ioControlCode == 461843;
    call sdv_IoMarkIrpPending(0);
    call IoStartPacket(0, 0, 0, 0);
    ntStatus_20 := 259;
    goto L78;

  anon123_Then:
    assume {:partition} ioControlCode == 461839;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    issueCommandParms_2 := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))];
    assume {:nonnull} issueCommandParms_2 != 0;
    assume issueCommandParms_2 > 0;
    call ntStatus_20 := FcIssueCommand(fdoExtension_11, Mem_T.FifoInBuffer__ISSUE_FDC_COMMAND_PARMS[FifoInBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_2)], Mem_T.FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS[FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_2)], Mem_T.IoHandle__ISSUE_FDC_COMMAND_PARMS[IoHandle__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_2)], Mem_T.IoOffset__ISSUE_FDC_COMMAND_PARMS[IoOffset__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_2)], Mem_T.TransferBytes__ISSUE_FDC_COMMAND_PARMS[TransferBytes__ISSUE_FDC_COMMAND_PARMS(issueCommandParms_2)]);
    goto anon129_Then, anon129_Else;

  anon129_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon129_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon124_Then:
    assume {:partition} ioControlCode == 461831;
    call ntStatus_20 := FcReleaseFdc(fdoExtension_11);
    goto anon128_Then, anon128_Else;

  anon128_Else:
    assume {:partition} yogi_error != 1;
    goto anon109_Then, anon109_Else;

  anon109_Else:
    assume {:partition} ntStatus_20 >= 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    Mem_T.LastDeviceObject__FDC_FDO_EXTENSION[LastDeviceObject__FDC_FDO_EXTENSION(fdoExtension_11)] := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))];
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION[TapeEnumerationPending__FDC_FDO_EXTENSION(fdoExtension_11)] := 0;
    goto L78;

  anon109_Then:
    assume {:partition} 0 > ntStatus_20;
    goto L78;

  anon128_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon107_Then:
    assume {:partition} ioControlCode == 461827;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    Tmp_524 := DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15));
    assume {:nonnull} Tmp_524 != 0;
    assume Tmp_524 > 0;
    call ntStatus_20 := FcAcquireFdc(fdoExtension_11, Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(Tmp_524)]);
    goto anon127_Then, anon127_Else;

  anon127_Else:
    assume {:partition} yogi_error != 1;
    goto anon110_Then, anon110_Else;

  anon110_Else:
    assume {:partition} ntStatus_20 >= 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    assume {:nonnull} irpSp_15 != 0;
    assume irpSp_15 > 0;
    Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpSp_15)))] := Mem_T.LastDeviceObject__FDC_FDO_EXTENSION[LastDeviceObject__FDC_FDO_EXTENSION(fdoExtension_11)];
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION[TapeEnumerationPending__FDC_FDO_EXTENSION(fdoExtension_11)] := 1;
    goto L78;

  anon110_Then:
    assume {:partition} 0 > ntStatus_20;
    goto L78;

  anon127_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon105_Then:
    assume {:partition} Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(fdoExtension_11)] == 0;
    goto anon106_Then, anon106_Else;

  anon106_Else:
    assume {:partition} ioControlCode != 461827;
    ntStatus_20 := -1073741808;
    goto L78;

  anon106_Then:
    assume {:partition} ioControlCode == 461827;
    goto L94;

  anon101_Then:
    assume {:partition} ioControlCode == 461835;
    goto L77;

  anon99_Then:
    goto anon100_Then, anon100_Else;

  anon100_Else:
    assume {:partition} Irp_24 != 0;
    currentIrp := Irp_24;
    powerQueueClear := 1;
    goto L70;

  anon100_Then:
    assume {:partition} Irp_24 == 0;
    ntStatus_20 := 0;
    goto L91;

  anon92_Then:
    assume {:partition} Irp_24 == 0;
    goto L33;

  anon94_Then:
    assume {:partition} Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(FdcFailedTime__FDC_FDO_EXTENSION(fdoExtension_11))] + 600000 >= Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(currentTime)];
    goto L23;

  anon93_Then:
    assume {:partition} Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(FdcFailedTime__FDC_FDO_EXTENSION(fdoExtension_11))] == 0;
    assume {:nonnull} currentTime != 0;
    assume currentTime > 0;
    assume {:nonnull} fdoExtension_11 != 0;
    assume fdoExtension_11 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(FdcFailedTime__FDC_FDO_EXTENSION(fdoExtension_11))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(currentTime)];
    goto L23;

  anon91_Then:
    assume {:partition} Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(fdoExtension_11)] == 0;
    goto L23;

  anon125_Then:
    assume {:partition} FdcInSetupMode == 0;
    goto L21;

  anon103_Then_dummy:
    assume false;
    return;

  L33_last:
    call deferredRequest := sdv_ExInterlockedRemoveHeadList(0, 0);
    goto anon99_Then, anon99_Else;
}



procedure {:origName "FcFdcEnabler"} FcFdcEnabler(actual_DeviceObject_39: int, actual_Ioctl: int, actual_Data: int) returns (Tmp_526: int);
  modifies alloc, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, yogi_error;



implementation {:origName "FcFdcEnabler"} FcFdcEnabler(actual_DeviceObject_39: int, actual_Ioctl: int, actual_Data: int) returns (Tmp_526: int)
{
  var {:pointer} irpStack: int;
  var {:scalar} doneEvent_4: int;
  var {:scalar} ntStatus_21: int;
  var {:pointer} irp_3: int;
  var {:scalar} ioStatus_1: int;
  var {:pointer} DeviceObject_39: int;
  var {:scalar} Ioctl: int;
  var {:pointer} Data: int;
  var vslice_dummy_var_140: int;

  anon0:
    call doneEvent_4 := __HAVOC_malloc(156);
    call ioStatus_1 := __HAVOC_malloc(12);
    DeviceObject_39 := actual_DeviceObject_39;
    Ioctl := actual_Ioctl;
    Data := actual_Data;
    call KeInitializeEvent(doneEvent_4, 0, 0);
    call irp_3 := IoBuildDeviceIoControlRequest(Ioctl, 0, 0, 0, 0, 0, 1, 0, ioStatus_1);
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} irp_3 != 0;
    call irpStack := sdv_IoGetNextIrpStackLocation(irp_3);
    assume {:nonnull} irpStack != 0;
    assume irpStack > 0;
    Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(irpStack)))] := Data;
    call ntStatus_21 := sdv_IoCallDriver(DeviceObject_39, irp_3);
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} ntStatus_21 == 259;
    call vslice_dummy_var_140 := KeWaitForSingleObject(0, 0, 0, 0, 0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} yogi_error != 1;
    assume {:nonnull} ioStatus_1 != 0;
    assume ioStatus_1 > 0;
    ntStatus_21 := Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(ioStatus_1)];
    goto L27;

  L27:
    Tmp_526 := ntStatus_21;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon9_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon8_Then:
    assume {:partition} ntStatus_21 != 259;
    goto L27;

  anon7_Then:
    assume {:partition} irp_3 == 0;
    Tmp_526 := -1073741670;
    goto L1;
}



procedure {:origName "FdcInterruptService"} FdcInterruptService(actual_Interrupt: int, actual_Context_10: int) returns (Tmp_528: int);
  modifies alloc, sdv_irql_current, sdv_irql_previous, sdv_irql_previous_2, sdv_irql_previous_3, sdv_irql_previous_4, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.INT4, Mem_T.IsrReentered__FDC_FDO_EXTENSION, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, sdv_kdpc3, sdv_dpc_ke_registered, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, sdv_dpc_io_registered;



implementation {:origName "FdcInterruptService"} FdcInterruptService(actual_Interrupt: int, actual_Context_10: int) returns (Tmp_528: int)
{
  var {:scalar} i_9: int;
  var {:scalar} Tmp_530: int;
  var {:scalar} sdv_331: int;
  var {:pointer} Tmp_531: int;
  var {:scalar} sdv_334: int;
  var {:pointer} fdoExtension_12: int;
  var {:pointer} currentDeviceObject: int;
  var {:scalar} Tmp_532: int;
  var {:scalar} Tmp_533: int;
  var {:scalar} controllerStateError: int;
  var {:scalar} statusByte: int;
  var {:pointer} Context_10: int;
  var vslice_dummy_var_141: int;
  var vslice_dummy_var_142: int;
  var vslice_dummy_var_143: int;

  anon0:
    Context_10 := actual_Context_10;
    call Tmp_531 := __HAVOC_malloc(40);
    call sdv_KeLowerIrql(1);
    fdoExtension_12 := Context_10;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    goto anon37_Then, anon37_Else;

  anon37_Else:
    assume {:partition} Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(fdoExtension_12)] != 0;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    currentDeviceObject := Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION[CurrentDeviceObject__FDC_FDO_EXTENSION(fdoExtension_12)];
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION[CurrentDeviceObject__FDC_FDO_EXTENSION(fdoExtension_12)] := 0;
    controllerStateError := 0;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    goto anon29_Then, anon29_Else;

  anon29_Else:
    assume {:partition} Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION[CommandHasResultPhase__FDC_FDO_EXTENSION(fdoExtension_12)] != 0;
    call sdv_331 := corral_nondet();
    Tmp_530 := BAND(sdv_331, BOR(64, 128));
    goto anon38_Then, anon38_Else;

  anon38_Else:
    assume {:partition} Tmp_530 == 192;
    call sdv_334 := corral_nondet();
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Tmp_531 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(fdoExtension_12)];
    assume {:nonnull} Tmp_531 != 0;
    assume Tmp_531 > 0;
    Mem_T.INT4[Tmp_531] := sdv_334;
    goto L40;

  L40:
    call statusByte := corral_nondet();
    goto anon30_Then, anon30_Else;

  anon30_Else:
    assume {:partition} currentDeviceObject != 0;
    goto anon31_Then, anon31_Else;

  anon31_Else:
    assume {:partition} controllerStateError != 0;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION[CurrentDeviceObject__FDC_FDO_EXTENSION(fdoExtension_12)] := currentDeviceObject;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    goto anon39_Then, anon39_Else;

  anon39_Else:
    assume {:partition} Mem_T.IsrReentered__FDC_FDO_EXTENSION[IsrReentered__FDC_FDO_EXTENSION(fdoExtension_12)] > 20;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Mem_T.IsrReentered__FDC_FDO_EXTENSION[IsrReentered__FDC_FDO_EXTENSION(fdoExtension_12)] := 0;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(fdoExtension_12)] := BOR(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(fdoExtension_12)], 8);
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(fdoExtension_12)] := BAND(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(fdoExtension_12)], BNOT(4));
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(fdoExtension_12)] := BOR(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(fdoExtension_12)], 4);
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    call vslice_dummy_var_141 := KeInsertQueueDpc(LogErrorDpc__FDC_FDO_EXTENSION(fdoExtension_12), 0, 0);
    goto L79;

  L79:
    Tmp_528 := 1;
    goto L1;

  L1:
    return;

  anon39_Then:
    assume {:partition} 20 >= Mem_T.IsrReentered__FDC_FDO_EXTENSION[IsrReentered__FDC_FDO_EXTENSION(fdoExtension_12)];
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Mem_T.IsrReentered__FDC_FDO_EXTENSION[IsrReentered__FDC_FDO_EXTENSION(fdoExtension_12)] := Mem_T.IsrReentered__FDC_FDO_EXTENSION[IsrReentered__FDC_FDO_EXTENSION(fdoExtension_12)] + 1;
    goto L79;

  anon31_Then:
    assume {:partition} controllerStateError == 0;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Mem_T.IsrReentered__FDC_FDO_EXTENSION[IsrReentered__FDC_FDO_EXTENSION(fdoExtension_12)] := 0;
    assume {:nonnull} fdoExtension_12 != 0;
    assume fdoExtension_12 > 0;
    Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(fdoExtension_12)] := 0;
    call sdv_IoRequestDpc(0, 0, 0);
    goto L79;

  anon30_Then:
    assume {:partition} currentDeviceObject == 0;
    Tmp_528 := 0;
    goto L1;

  anon38_Then:
    assume {:partition} Tmp_530 != 192;
    controllerStateError := 1;
    goto L40;

  anon29_Then:
    assume {:partition} Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION[CommandHasResultPhase__FDC_FDO_EXTENSION(fdoExtension_12)] == 0;
    i_9 := 0;
    goto L138;

  L138:
    call i_9, Tmp_532, statusByte := FdcInterruptService_loop_L138(i_9, Tmp_532, statusByte);
    goto L138_last;

  anon40_Else:
    assume {:partition} 25 > i_9;
    goto anon33_Then, anon33_Else;

  anon33_Else:
    assume {:partition} BAND(statusByte, 16) != 0;
    goto anon33_Else_dummy;

  anon33_Then:
    assume {:partition} BAND(statusByte, 16) == 0;
    Tmp_532 := BAND(statusByte, BOR(64, 128));
    goto anon41_Then, anon41_Else;

  anon41_Else:
    assume {:partition} Tmp_532 != 128;
    goto anon41_Else_dummy;

  anon41_Then:
    assume {:partition} Tmp_532 == 128;
    goto L93;

  L93:
    goto anon32_Then, anon32_Else;

  anon32_Else:
    assume {:partition} BAND(statusByte, 16) != 0;
    goto L98;

  L98:
    controllerStateError := 1;
    goto L40;

  anon32_Then:
    assume {:partition} BAND(statusByte, 16) == 0;
    Tmp_533 := BAND(statusByte, BOR(64, 128));
    goto anon42_Then, anon42_Else;

  anon42_Else:
    assume {:partition} Tmp_533 == 128;
    i_9 := 50;
    goto L104;

  L104:
    call i_9, statusByte := FdcInterruptService_loop_L104(i_9, statusByte);
    goto L104_last;

  anon34_Else:
    assume {:partition} i_9 != 0;
    call statusByte := corral_nondet();
    goto anon36_Then, anon36_Else;

  anon36_Else:
    assume {:partition} BAND(statusByte, 16) == 0;
    i_9 := i_9 - 1;
    goto anon36_Else_dummy;

  anon36_Then:
    assume {:partition} BAND(statusByte, 16) != 0;
    goto L105;

  L105:
    goto anon35_Then, anon35_Else;

  anon35_Else:
    assume {:partition} currentDeviceObject == 0;
    call vslice_dummy_var_142 := corral_nondet();
    call vslice_dummy_var_143 := corral_nondet();
    goto L40;

  anon35_Then:
    assume {:partition} currentDeviceObject != 0;
    goto L40;

  anon34_Then:
    assume {:partition} i_9 == 0;
    goto L105;

  anon42_Then:
    assume {:partition} Tmp_533 != 128;
    goto L98;

  anon40_Then:
    assume {:partition} i_9 >= 25;
    goto L93;

  anon37_Then:
    assume {:partition} Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(fdoExtension_12)] == 0;
    Tmp_528 := 0;
    goto L1;

  anon36_Else_dummy:
    assume false;
    return;

  L104_last:
    assume {:CounterLoop 50} {:Counter "i_9"} true;
    goto anon34_Then, anon34_Else;

  anon33_Else_dummy:
    assume false;
    return;

  anon41_Else_dummy:
    assume false;
    return;

  L138_last:
    call statusByte := corral_nondet();
    i_9 := i_9 + 1;
    goto anon40_Then, anon40_Else;
}



procedure {:origName "FcAcquireFdc"} FcAcquireFdc(actual_FdoExtension_14: int, actual_TimeOut: int) returns (Tmp_534: int);
  modifies alloc, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, Mem_T.INT4, sdv_isr_routine, sdv_pDpcContext, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, yogi_error;



implementation {:origName "FcAcquireFdc"} FcAcquireFdc(actual_FdoExtension_14: int, actual_TimeOut: int) returns (Tmp_534: int)
{
  var {:scalar} ntStatus_22: int;
  var {:pointer} FdoExtension_14: int;
  var {:pointer} TimeOut: int;

  anon0:
    FdoExtension_14 := actual_FdoExtension_14;
    TimeOut := actual_TimeOut;
    assume {:nonnull} FdoExtension_14 != 0;
    assume FdoExtension_14 > 0;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(FdoExtension_14)] != 0;
    assume {:nonnull} FdoExtension_14 != 0;
    assume FdoExtension_14 > 0;
    call ntStatus_22 := FcFdcEnabler(Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION[FdcEnablerDeviceObject__FDC_FDO_EXTENSION(FdoExtension_14)], 2031623, TimeOut);
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} yogi_error != 1;
    goto L12;

  L12:
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} ntStatus_22 >= 0;
    call ExAcquireFastMutex(0);
    PagingReferenceCount := PagingReferenceCount + 1;
    goto anon22_Then, anon22_Else;

  anon22_Else:
    assume {:partition} PagingReferenceCount == 1;
    call MmResetDriverPaging(0);
    goto L18;

  L18:
    call ExReleaseFastMutex(0);
    call FcAllocateAdapterChannel(FdoExtension_14);
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} yogi_error != 1;
    call IoStartTimer(0);
    assume {:nonnull} FdoExtension_14 != 0;
    assume FdoExtension_14 > 0;
    call ntStatus_22 := IoConnectInterrupt(0, li2bplFunctionConstant207, FdoExtension_14, 0, Mem_T.ControllerVector__FDC_FDO_EXTENSION[ControllerVector__FDC_FDO_EXTENSION(FdoExtension_14)], Mem_T.ControllerIrql__FDC_FDO_EXTENSION[ControllerIrql__FDC_FDO_EXTENSION(FdoExtension_14)], Mem_T.ControllerIrql__FDC_FDO_EXTENSION[ControllerIrql__FDC_FDO_EXTENSION(FdoExtension_14)], Mem_T.InterruptMode__FDC_FDO_EXTENSION[InterruptMode__FDC_FDO_EXTENSION(FdoExtension_14)], Mem_T.SharableVector__FDC_FDO_EXTENSION[SharableVector__FDC_FDO_EXTENSION(FdoExtension_14)], Mem_T.ProcessorMask__FDC_FDO_EXTENSION[ProcessorMask__FDC_FDO_EXTENSION(FdoExtension_14)], Mem_T.SaveFloatState__FDC_FDO_EXTENSION[SaveFloatState__FDC_FDO_EXTENSION(FdoExtension_14)]);
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} ntStatus_22 >= 0;
    assume {:nonnull} FdoExtension_14 != 0;
    assume FdoExtension_14 > 0;
    Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(FdoExtension_14)] := 1;
    goto L39;

  L39:
    Tmp_534 := ntStatus_22;
    goto LM2;

  LM2:
    return;

  anon19_Then:
    assume {:partition} 0 > ntStatus_22;
    call FcFreeAdapterChannel(FdoExtension_14);
    call IoStopTimer(0);
    goto L39;

  anon23_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon22_Then:
    assume {:partition} PagingReferenceCount != 1;
    goto L18;

  anon18_Then:
    assume {:partition} 0 > ntStatus_22;
    ntStatus_22 := 17;
    goto L39;

  anon21_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon17_Then:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(FdoExtension_14)] == 0;
    call ntStatus_22 := KeWaitForSingleObject(0, 0, 0, 0, TimeOut);
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} yogi_error != 1;
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} ntStatus_22 == 258;
    ntStatus_22 := 17;
    goto L12;

  anon20_Then:
    assume {:partition} ntStatus_22 != 258;
    goto L12;

  anon24_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;
}



procedure {:origName "FcReleaseFdc"} FcReleaseFdc(actual_FdoExtension_15: int) returns (Tmp_536: int);
  modifies alloc, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, Mem_T.INT4, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, sdv_isr_routine, sdv_pDpcContext, PagingReferenceCount, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, yogi_error;



implementation {:origName "FcReleaseFdc"} FcReleaseFdc(actual_FdoExtension_15: int) returns (Tmp_536: int)
{
  var {:pointer} FdoExtension_15: int;
  var vslice_dummy_var_144: int;
  var vslice_dummy_var_145: int;
  var vslice_dummy_var_146: int;

  anon0:
    FdoExtension_15 := actual_FdoExtension_15;
    call FcFreeAdapterChannel(FdoExtension_15);
    assume {:nonnull} FdoExtension_15 != 0;
    assume FdoExtension_15 > 0;
    Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(FdoExtension_15)] := 0;
    assume {:nonnull} FdoExtension_15 != 0;
    assume FdoExtension_15 > 0;
    Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(FdoExtension_15)] := 0;
    call IoDisconnectInterrupt(0);
    call IoStopTimer(0);
    call ExAcquireFastMutex(0);
    PagingReferenceCount := PagingReferenceCount - 1;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} PagingReferenceCount != 0;
    goto L21;

  L21:
    call ExReleaseFastMutex(0);
    assume {:nonnull} FdoExtension_15 != 0;
    assume FdoExtension_15 > 0;
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(FdoExtension_15)] != 0;
    assume {:nonnull} FdoExtension_15 != 0;
    assume FdoExtension_15 > 0;
    call vslice_dummy_var_146 := FcFdcEnabler(Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION[FdcEnablerDeviceObject__FDC_FDO_EXTENSION(FdoExtension_15)], 2031627, 0);
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} yogi_error != 1;
    goto L31;

  L31:
    Tmp_536 := 0;
    goto LM2;

  LM2:
    return;

  anon9_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon7_Then:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(FdoExtension_15)] == 0;
    assume {:nonnull} FdoExtension_15 != 0;
    assume FdoExtension_15 > 0;
    call vslice_dummy_var_145 := KeSetEvent(AcquireEvent__FDC_FDO_EXTENSION(FdoExtension_15), 0, 0);
    goto L31;

  anon8_Then:
    assume {:partition} PagingReferenceCount == 0;
    call vslice_dummy_var_144 := MmPageEntireDriver(0);
    goto L21;
}



procedure {:origName "FdcDeviceControl"} FdcDeviceControl(actual_DeviceObject_40: int, actual_Irp_25: int) returns (Tmp_538: int);
  modifies alloc, Mem_T.MinorFunction__IO_STACK_LOCATION, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK;



implementation {:origName "FdcDeviceControl"} FdcDeviceControl(actual_DeviceObject_40: int, actual_Irp_25: int) returns (Tmp_538: int)
{
  var {:pointer} fdoExtension_13: int;
  var {:pointer} extensionHeader_3: int;
  var {:pointer} DeviceObject_40: int;
  var {:pointer} Irp_25: int;

  anon0:
    DeviceObject_40 := actual_DeviceObject_40;
    Irp_25 := actual_Irp_25;
    assume {:nonnull} DeviceObject_40 != 0;
    assume DeviceObject_40 > 0;
    extensionHeader_3 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_40)];
    assume {:nonnull} extensionHeader_3 != 0;
    assume extensionHeader_3 > 0;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(extensionHeader_3)] != 0;
    assume {:nonnull} DeviceObject_40 != 0;
    assume DeviceObject_40 > 0;
    fdoExtension_13 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_40)];
    call sdv_IoSkipCurrentIrpStackLocation(Irp_25);
    assume {:nonnull} fdoExtension_13 != 0;
    assume fdoExtension_13 > 0;
    call Tmp_538 := sdv_IoCallDriver(Mem_T.TargetObject__FDC_FDO_EXTENSION[TargetObject__FDC_FDO_EXTENSION(fdoExtension_13)], Irp_25);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(extensionHeader_3)] == 0;
    assume {:nonnull} Irp_25 != 0;
    assume Irp_25 > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(Irp_25))] := -1073741808;
    call sdv_IoCompleteRequest(0, 0);
    Tmp_538 := -1073741808;
    goto L1;
}



procedure {:origName "FdcCreateFloppyPdo"} FdcCreateFloppyPdo(actual_FdoExtension_16: int, actual_PeripheralNumber_1: int);
  modifies alloc, Mem_T.INT4, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT, Mem_T.NumPDOs__FDC_FDO_EXTENSION, Mem_T.Length_unnamed_tag_18, sdv_io_create_device_called, Mem_T.P_DEVICE_OBJECT;



implementation {:origName "FdcCreateFloppyPdo"} FdcCreateFloppyPdo(actual_FdoExtension_16: int, actual_PeripheralNumber_1: int)
{
  var {:pointer} pdoExtension_5: int;
  var {:scalar} Tmp_540: int;
  var {:scalar} ntStatus_23: int;
  var {:scalar} nameIndex: int;
  var {:pointer} Tmp_543: int;
  var {:pointer} pdoNameBuffer: int;
  var {:scalar} pdoName: int;
  var {:pointer} newPdo: int;
  var {:pointer} FdoExtension_16: int;
  var {:scalar} PeripheralNumber_1: int;
  var vslice_dummy_var_147: int;
  var vslice_dummy_var_148: int;
  var vslice_dummy_var_149: int;
  var vslice_dummy_var_150: int;

  anon0:
    call vslice_dummy_var_147 := __HAVOC_malloc(4);
    call pdoName := __HAVOC_malloc(12);
    call newPdo := __HAVOC_malloc(4);
    FdoExtension_16 := actual_FdoExtension_16;
    PeripheralNumber_1 := actual_PeripheralNumber_1;
    call pdoNameBuffer := __HAVOC_malloc(256);
    call vslice_dummy_var_148 := __HAVOC_malloc(80);
    assume {:nonnull} pdoNameBuffer != 0;
    assume pdoNameBuffer > 0;
    Mem_T.INT4[pdoNameBuffer] := 0;
    nameIndex := 0;
    goto L11;

  L11:
    call Tmp_540, ntStatus_23, nameIndex, vslice_dummy_var_149 := FdcCreateFloppyPdo_loop_L11(Tmp_540, ntStatus_23, nameIndex, pdoNameBuffer, pdoName, newPdo, FdoExtension_16, vslice_dummy_var_149);
    goto L11_last;

  anon5_Else:
    assume {:partition} ntStatus_23 != -1073741771;
    goto anon6_Then, anon6_Else;

  anon6_Else:
    assume {:partition} ntStatus_23 >= 0;
    assume {:nonnull} Mem_T.P_DEVICE_OBJECT[newPdo] != 0;
    assume Mem_T.P_DEVICE_OBJECT[newPdo] > 0;
    assume {:nonnull} newPdo != 0;
    assume newPdo > 0;
    pdoExtension_5 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[newPdo])];
    assume {:nonnull} FdoExtension_16 != 0;
    assume FdoExtension_16 > 0;
    assume {:nonnull} pdoExtension_5 != 0;
    assume pdoExtension_5 > 0;
    Mem_T.TargetObject__FDC_PDO_EXTENSION[TargetObject__FDC_PDO_EXTENSION(pdoExtension_5)] := Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(FdoExtension_16)];
    assume {:nonnull} pdoExtension_5 != 0;
    assume pdoExtension_5 > 0;
    Mem_T.IsFDO__FDC_EXTENSION_HEADER[IsFDO__FDC_EXTENSION_HEADER(pdoExtension_5)] := 0;
    assume {:nonnull} newPdo != 0;
    assume newPdo > 0;
    assume {:nonnull} pdoExtension_5 != 0;
    assume pdoExtension_5 > 0;
    Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(pdoExtension_5)] := Mem_T.P_DEVICE_OBJECT[newPdo];
    assume {:nonnull} pdoExtension_5 != 0;
    assume pdoExtension_5 > 0;
    Mem_T.DeviceType__FDC_PDO_EXTENSION[DeviceType__FDC_PDO_EXTENSION(pdoExtension_5)] := 1;
    assume {:nonnull} FdoExtension_16 != 0;
    assume FdoExtension_16 > 0;
    assume {:nonnull} pdoExtension_5 != 0;
    assume pdoExtension_5 > 0;
    Mem_T.ParentFdo__FDC_PDO_EXTENSION[ParentFdo__FDC_PDO_EXTENSION(pdoExtension_5)] := Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(FdoExtension_16)];
    assume {:nonnull} pdoExtension_5 != 0;
    assume pdoExtension_5 > 0;
    Mem_T.Removed__FDC_PDO_EXTENSION[Removed__FDC_PDO_EXTENSION(pdoExtension_5)] := 0;
    assume {:nonnull} pdoExtension_5 != 0;
    assume pdoExtension_5 > 0;
    Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(pdoExtension_5)] := 0;
    assume {:nonnull} pdoExtension_5 != 0;
    assume pdoExtension_5 > 0;
    Mem_T.PeripheralNumber__FDC_PDO_EXTENSION[PeripheralNumber__FDC_PDO_EXTENSION(pdoExtension_5)] := PeripheralNumber_1;
    assume {:nonnull} Mem_T.P_DEVICE_OBJECT[newPdo] != 0;
    assume Mem_T.P_DEVICE_OBJECT[newPdo] > 0;
    assume {:nonnull} newPdo != 0;
    assume newPdo > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[newPdo])] := BOR(Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[newPdo])], 16);
    assume {:nonnull} Mem_T.P_DEVICE_OBJECT[newPdo] != 0;
    assume Mem_T.P_DEVICE_OBJECT[newPdo] > 0;
    assume {:nonnull} newPdo != 0;
    assume newPdo > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[newPdo])] := BOR(Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[newPdo])], 8192);
    assume {:nonnull} FdoExtension_16 != 0;
    assume FdoExtension_16 > 0;
    Tmp_543 := Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(FdoExtension_16)];
    assume {:nonnull} Mem_T.P_DEVICE_OBJECT[newPdo] != 0;
    assume Mem_T.P_DEVICE_OBJECT[newPdo] > 0;
    assume {:nonnull} Tmp_543 != 0;
    assume Tmp_543 > 0;
    assume {:nonnull} newPdo != 0;
    assume newPdo > 0;
    Mem_T.StackSize__DEVICE_OBJECT[StackSize__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[newPdo])] := Mem_T.StackSize__DEVICE_OBJECT[StackSize__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[newPdo])] + Mem_T.StackSize__DEVICE_OBJECT[StackSize__DEVICE_OBJECT(Tmp_543)];
    assume {:nonnull} Mem_T.P_DEVICE_OBJECT[newPdo] != 0;
    assume Mem_T.P_DEVICE_OBJECT[newPdo] > 0;
    assume {:nonnull} newPdo != 0;
    assume newPdo > 0;
    Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[newPdo])] := BAND(Mem_T.Flags__DEVICE_OBJECT[Flags__DEVICE_OBJECT(Mem_T.P_DEVICE_OBJECT[newPdo])], BNOT(128));
    assume {:nonnull} FdoExtension_16 != 0;
    assume FdoExtension_16 > 0;
    assume {:nonnull} pdoExtension_5 != 0;
    assume pdoExtension_5 > 0;
    call vslice_dummy_var_150 := sdv_InsertTailList(PDOs__FDC_FDO_EXTENSION(FdoExtension_16), PdoLink__FDC_PDO_EXTENSION(pdoExtension_5));
    assume {:nonnull} FdoExtension_16 != 0;
    assume FdoExtension_16 > 0;
    Mem_T.NumPDOs__FDC_FDO_EXTENSION[NumPDOs__FDC_FDO_EXTENSION(FdoExtension_16)] := Mem_T.NumPDOs__FDC_FDO_EXTENSION[NumPDOs__FDC_FDO_EXTENSION(FdoExtension_16)] + 1;
    goto L1;

  L1:
    return;

  anon6_Then:
    assume {:partition} 0 > ntStatus_23;
    goto L1;

  anon5_Then:
    assume {:partition} ntStatus_23 == -1073741771;
    goto anon5_Then_dummy;

  anon5_Then_dummy:
    assume false;
    return;

  L11_last:
    Tmp_540 := nameIndex;
    nameIndex := nameIndex + 1;
    call vslice_dummy_var_149 := corral_nondet();
    call RtlInitUnicodeString(pdoName, pdoNameBuffer);
    assume {:nonnull} FdoExtension_16 != 0;
    assume FdoExtension_16 > 0;
    call ntStatus_23 := IoCreateDevice(0, 40, 0, 45, 256, 0, newPdo);
    goto anon5_Then, anon5_Else;
}



procedure {:origName "FcLogErrorDpc"} FcLogErrorDpc(actual_Dpc_5: int, actual_DeferredContext_2: int, actual_SystemContext1: int, actual_SystemContext2: int);
  modifies alloc;



implementation {:origName "FcLogErrorDpc"} FcLogErrorDpc(actual_Dpc_5: int, actual_DeferredContext_2: int, actual_SystemContext1: int, actual_SystemContext2: int)
{
  var {:pointer} sdv_348: int;
  var {:pointer} errorLogEntry: int;
  var {:pointer} DeferredContext_2: int;
  var vslice_dummy_var_151: int;

  anon0:
    call vslice_dummy_var_151 := __HAVOC_malloc(4);
    DeferredContext_2 := actual_DeferredContext_2;
    call sdv_348 := IoAllocateErrorLogEntry(0, 48);
    errorLogEntry := sdv_348;
    goto anon3_Then, anon3_Else;

  anon3_Else:
    assume {:partition} errorLogEntry != 0;
    assume {:nonnull} errorLogEntry != 0;
    assume errorLogEntry > 0;
    assume {:nonnull} errorLogEntry != 0;
    assume errorLogEntry > 0;
    assume {:nonnull} errorLogEntry != 0;
    assume errorLogEntry > 0;
    assume {:nonnull} errorLogEntry != 0;
    assume errorLogEntry > 0;
    assume {:nonnull} errorLogEntry != 0;
    assume errorLogEntry > 0;
    assume {:nonnull} errorLogEntry != 0;
    assume errorLogEntry > 0;
    assume {:nonnull} errorLogEntry != 0;
    assume errorLogEntry > 0;
    call IoWriteErrorLogEntry(0);
    goto L1;

  L1:
    return;

  anon3_Then:
    assume {:partition} errorLogEntry == 0;
    goto L1;
}



procedure {:origName "FdcInitializeDeviceObject"} FdcInitializeDeviceObject(actual_DeviceObject_41: int) returns (Tmp_549: int);
  modifies Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, alloc, sdv_io_dpc, Mem_T.DeferredRoutine__KDPC, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION;



implementation {:origName "FdcInitializeDeviceObject"} FdcInitializeDeviceObject(actual_DeviceObject_41: int) returns (Tmp_549: int)
{
  var {:scalar} Tmp_551: int;
  var {:scalar} Tmp_552: int;
  var {:scalar} ntStatus_24: int;
  var {:pointer} fdoExtension_15: int;
  var {:pointer} DeviceObject_41: int;
  var vslice_dummy_var_152: int;

  anon0:
    DeviceObject_41 := actual_DeviceObject_41;
    ntStatus_24 := 0;
    assume {:nonnull} DeviceObject_41 != 0;
    assume DeviceObject_41 > 0;
    fdoExtension_15 := Mem_T.DeviceExtension__DEVICE_OBJECT[DeviceExtension__DEVICE_OBJECT(DeviceObject_41)];
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    goto anon8_Then, anon8_Else;

  anon8_Else:
    assume {:partition} Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION[DeviceObjectInitialized__FDC_FDO_EXTENSION(fdoExtension_15)] != 0;
    goto L10;

  L10:
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION[DeviceObjectInitialized__FDC_FDO_EXTENSION(fdoExtension_15)] := 1;
    Tmp_549 := ntStatus_24;
    return;

  anon8_Then:
    assume {:partition} Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION[DeviceObjectInitialized__FDC_FDO_EXTENSION(fdoExtension_15)] == 0;
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(InterruptDelay__FDC_FDO_EXTENSION(fdoExtension_15))] := -40000000;
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(Minimum10msDelay__FDC_FDO_EXTENSION(fdoExtension_15))] := -100000;
    call sdv_IoInitializeDpcRequest(0, li2bplFunctionConstant209);
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    call KeInitializeDpc(LogErrorDpc__FDC_FDO_EXTENSION(fdoExtension_15), li2bplFunctionConstant210, 0);
    goto anon7_Then, anon7_Else;

  anon7_Else:
    assume {:partition} NotConfigurable != 0;
    Tmp_552 := 0;
    goto L22;

  L22:
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    goto anon9_Then, anon9_Else;

  anon9_Else:
    assume {:partition} Model30 != 0;
    Tmp_551 := 1;
    goto L26;

  L26:
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(fdoExtension_15)] := 1;
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION[CurrentInterrupt__FDC_FDO_EXTENSION(fdoExtension_15)] := 1;
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(fdoExtension_15)] := 0;
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    call vslice_dummy_var_152 := IoInitializeTimer(0, li2bplFunctionConstant211, 0);
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    call KeInitializeEvent(InterruptEvent__FDC_FDO_EXTENSION(fdoExtension_15), 1, 0);
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    call KeInitializeEvent(AllocateAdapterChannelEvent__FDC_FDO_EXTENSION(fdoExtension_15), 0, 0);
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION[AdapterChannelRefCount__FDC_FDO_EXTENSION(fdoExtension_15)] := 0;
    assume {:nonnull} fdoExtension_15 != 0;
    assume fdoExtension_15 > 0;
    call KeInitializeEvent(AcquireEvent__FDC_FDO_EXTENSION(fdoExtension_15), 1, 1);
    goto L10;

  anon9_Then:
    assume {:partition} Model30 == 0;
    Tmp_551 := 0;
    goto L26;

  anon7_Then:
    assume {:partition} NotConfigurable == 0;
    Tmp_552 := 1;
    goto L22;
}



procedure {:origName "FcInitializeControllerHardware"} FcInitializeControllerHardware(actual_FdoExtension_17: int, actual_DeviceObject_42: int) returns (Tmp_553: int);
  modifies alloc, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.INT4, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, yogi_error;



implementation {:origName "FcInitializeControllerHardware"} FcInitializeControllerHardware(actual_FdoExtension_17: int, actual_DeviceObject_42: int) returns (Tmp_553: int)
{
  var {:pointer} Tmp_554: int;
  var {:pointer} Tmp_555: int;
  var {:pointer} Tmp_556: int;
  var {:scalar} retrycnt: int;
  var {:pointer} Tmp_557: int;
  var {:scalar} ntStatus_25: int;
  var {:pointer} Tmp_558: int;
  var {:pointer} Tmp_559: int;
  var {:pointer} FdoExtension_17: int;
  var {:pointer} DeviceObject_42: int;
  var vslice_dummy_var_153: int;

  anon0:
    FdoExtension_17 := actual_FdoExtension_17;
    DeviceObject_42 := actual_DeviceObject_42;
    call Tmp_554 := __HAVOC_malloc(40);
    call Tmp_555 := __HAVOC_malloc(40);
    call Tmp_556 := __HAVOC_malloc(40);
    call Tmp_557 := __HAVOC_malloc(40);
    call Tmp_558 := __HAVOC_malloc(40);
    call Tmp_559 := __HAVOC_malloc(40);
    ntStatus_25 := 0;
    retrycnt := 0;
    goto L11;

  L11:
    call Tmp_554, Tmp_555, Tmp_556, retrycnt, Tmp_557, ntStatus_25, Tmp_558, Tmp_559, vslice_dummy_var_153 := FcInitializeControllerHardware_loop_L11(Tmp_554, Tmp_555, Tmp_556, retrycnt, Tmp_557, ntStatus_25, Tmp_558, Tmp_559, FdoExtension_17, DeviceObject_42, vslice_dummy_var_153);
    goto L11_last;

  anon22_Else:
    assume {:partition} yogi_error != 1;
    goto anon17_Then, anon17_Else;

  anon17_Else:
    assume {:partition} ntStatus_25 != 258;
    goto L38;

  L38:
    goto anon19_Then, anon19_Else;

  anon19_Else:
    assume {:partition} ntStatus_25 == 258;
    ntStatus_25 := -1073741643;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Mem_T.HardwareFailed__FDC_FDO_EXTENSION[HardwareFailed__FDC_FDO_EXTENSION(FdoExtension_17)] := 1;
    goto L39;

  L39:
    goto anon20_Then, anon20_Else;

  anon20_Else:
    assume {:partition} ntStatus_25 >= 0;
    call ntStatus_25 := FcFinishReset(FdoExtension_17);
    Tmp_553 := ntStatus_25;
    goto L1;

  L1:
    goto LM2;

  LM2:
    return;

  anon20_Then:
    assume {:partition} 0 > ntStatus_25;
    Tmp_553 := ntStatus_25;
    goto L1;

  anon19_Then:
    assume {:partition} ntStatus_25 != 258;
    goto L39;

  anon17_Then:
    assume {:partition} ntStatus_25 == 258;
    goto anon18_Then, anon18_Else;

  anon18_Else:
    assume {:partition} retrycnt >= 1;
    goto L38;

  anon18_Then:
    assume {:partition} 1 > retrycnt;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Tmp_557 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_17)];
    assume {:nonnull} Tmp_557 != 0;
    assume Tmp_557 > 0;
    Mem_T.INT4[Tmp_557] := 17;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    goto anon23_Then, anon23_Else;

  anon23_Else:
    assume {:partition} Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(FdoExtension_17)] != 0;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Tmp_558 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_17)];
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Tmp_559 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_17)];
    assume {:nonnull} Tmp_558 != 0;
    assume Tmp_558 > 0;
    assume {:nonnull} Tmp_559 != 0;
    assume Tmp_559 > 0;
    Mem_T.INT4[Tmp_558] := BOR(Mem_T.INT4[Tmp_559], 128);
    goto L49;

  L49:
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Tmp_554 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_17)];
    assume {:nonnull} Tmp_554 != 0;
    assume Tmp_554 > 0;
    Mem_T.INT4[Tmp_554 + 1 * 4] := 0;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Tmp_556 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_17)];
    assume {:nonnull} Tmp_556 != 0;
    assume Tmp_556 > 0;
    Mem_T.INT4[Tmp_556 + 2 * 4] := 15;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Tmp_555 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_17)];
    assume {:nonnull} Tmp_555 != 0;
    assume Tmp_555 > 0;
    Mem_T.INT4[Tmp_555 + 3 * 4] := 0;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    call ntStatus_25 := FcIssueCommand(FdoExtension_17, Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_17)], Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(FdoExtension_17)], 0, 0, 0);
    goto anon24_Then, anon24_Else;

  anon24_Else:
    assume {:partition} yogi_error != 1;
    goto anon21_Then, anon21_Else;

  anon21_Else:
    assume {:partition} ntStatus_25 >= 0;
    retrycnt := retrycnt + 1;
    goto anon21_Else_dummy;

  anon21_Then:
    assume {:partition} 0 > ntStatus_25;
    ntStatus_25 := 258;
    goto L38;

  anon24_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon23_Then:
    assume {:partition} Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(FdoExtension_17)] == 0;
    goto L49;

  anon22_Then:
    assume {:partition} yogi_error == 1;
    goto LM2;

  anon21_Else_dummy:
    assume false;
    return;

  L11_last:
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_17)] := BOR(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_17)], 8);
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_17)] := BAND(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_17)], BNOT(4));
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION[CurrentDeviceObject__FDC_FDO_EXTENSION(FdoExtension_17)] := DeviceObject_42;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(FdoExtension_17)] := 1;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION[CommandHasResultPhase__FDC_FDO_EXTENSION(FdoExtension_17)] := 0;
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    call vslice_dummy_var_153 := KeResetEvent(InterruptEvent__FDC_FDO_EXTENSION(FdoExtension_17));
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_17)] := BOR(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(FdoExtension_17)], 4);
    assume {:nonnull} FdoExtension_17 != 0;
    assume FdoExtension_17 > 0;
    call ntStatus_25 := KeWaitForSingleObject(0, 0, 0, 0, InterruptDelay__FDC_FDO_EXTENSION(FdoExtension_17));
    goto anon22_Then, anon22_Else;
}



procedure {:dopa "Mem_T.INT4"} dummy_for_pa();



procedure corralExplainErrorInit();



procedure corralExtraInit();



implementation corralExtraInit()
{

  anon0:
    assume 0 < alloc_init;
    assume alloc_init < alloc;
    assume (forall x: int :: { Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT[x] } Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT[x] <= 0 || Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT[x] > 303);
    assume (forall x: int :: { Mem_T.CancelRoutine__IRP[x] } Mem_T.CancelRoutine__IRP[x] <= 0 || Mem_T.CancelRoutine__IRP[x] > 303);
    assume (forall x: int :: { Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] } Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] <= 0 || Mem_T.CompletionRoutine__IO_STACK_LOCATION[x] > 303);
    assume (forall x: int :: { Mem_T.DeferredRoutine__KDPC[x] } Mem_T.DeferredRoutine__KDPC[x] <= 0 || Mem_T.DeferredRoutine__KDPC[x] > 303);
    return;
}



function {:inline true} {:fieldmap "Mem_T.ACPI_BIOS__FDC_FDO_EXTENSION"} {:fieldname "ACPI_BIOS"} ACPI_BIOS__FDC_FDO_EXTENSION(x: int) : int
{
  x + 100
}

function {:inline true} {:fieldmap "Mem_T.ACPI_FDE_Data__FDC_FDO_EXTENSION"} {:fieldname "ACPI_FDE_Data"} ACPI_FDE_Data__FDC_FDO_EXTENSION(x: int) : int
{
  x + 108
}

function {:inline true} {:fieldmap "Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION"} {:fieldname "ACPI_FDE_Valid"} ACPI_FDE_Valid__FDC_FDO_EXTENSION(x: int) : int
{
  x + 104
}

function {:inline true} {:fieldmap "Mem_T.ACPI_Tape__ACPI_FDE_ENUM_TABLE"} {:fieldname "ACPI_Tape"} ACPI_Tape__ACPI_FDE_ENUM_TABLE(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.AcpiBios__FDC_INFO"} {:fieldname "AcpiBios"} AcpiBios__FDC_INFO(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.AcpiFdiData__FDC_INFO"} {:fieldname "AcpiFdiData"} AcpiFdiData__FDC_INFO(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.AcpiFdiSupported__FDC_INFO"} {:fieldname "AcpiFdiSupported"} AcpiFdiSupported__FDC_INFO(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.VOID"} {:fieldname "AcquireEvent"} AcquireEvent__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1064
}

function {:inline true} {:fieldmap "Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION"} {:fieldname "AdapterChannelRefCount"} AdapterChannelRefCount__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1060
}

function {:inline true} {:fieldmap "Mem_T.AdapterObject__FDC_FDO_EXTENSION"} {:fieldname "AdapterObject"} AdapterObject__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1520
}

function {:inline true} {:fieldmap "Mem_T.Address__CONTROLLER"} {:fieldname "Address"} Address__CONTROLLER(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.Address__DEVICE_CAPABILITIES"} {:fieldname "Address"} Address__DEVICE_CAPABILITIES(x: int) : int
{
  x + 92
}

function {:inline true} {:fieldmap "Mem_T.AffinityPolicy_unnamed_tag_59"} {:fieldname "AffinityPolicy"} AffinityPolicy_unnamed_tag_59(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Affinity_unnamed_tag_45"} {:fieldname "Affinity"} Affinity_unnamed_tag_45(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Alignment40_unnamed_tag_64"} {:fieldname "Alignment40"} Alignment40_unnamed_tag_64(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Alignment48_unnamed_tag_65"} {:fieldname "Alignment48"} Alignment48_unnamed_tag_65(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Alignment64_unnamed_tag_66"} {:fieldname "Alignment64"} Alignment64_unnamed_tag_66(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Alignment_unnamed_tag_58"} {:fieldname "Alignment"} Alignment_unnamed_tag_58(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.VOID"} {:fieldname "AllocateAdapterChannelEvent"} AllocateAdapterChannelEvent__FDC_FDO_EXTENSION(x: int) : int
{
  x + 904
}

function {:inline true} {:fieldmap "Mem_T.AllocatedResourcesTranslated_unnamed_tag_40"} {:fieldname "AllocatedResourcesTranslated"} AllocatedResourcesTranslated_unnamed_tag_40(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.AllocatedResources_unnamed_tag_40"} {:fieldname "AllocatedResources"} AllocatedResources_unnamed_tag_40(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION"} {:fieldname "AllowInterruptProcessing"} AllowInterruptProcessing__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1684
}

function {:inline true} {:fieldmap "Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST"} {:fieldname "AlternativeLists"} AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.AlwaysImplemented__COMMAND_TABLE"} {:fieldname "AlwaysImplemented"} AlwaysImplemented__COMMAND_TABLE(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.ArgumentCount__ACPI_EVAL_INPUT_BUFFER_COMPLEX"} {:fieldname "ArgumentCount"} ArgumentCount__ACPI_EVAL_INPUT_BUFFER_COMPLEX(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.Argument__ACPI_EVAL_INPUT_BUFFER_COMPLEX"} {:fieldname "Argument"} Argument__ACPI_EVAL_INPUT_BUFFER_COMPLEX(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Argument__ACPI_EVAL_OUTPUT_BUFFER"} {:fieldname "Argument"} Argument__ACPI_EVAL_OUTPUT_BUFFER(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Argument__ACPI_METHOD_ARGUMENT"} {:fieldname "Argument"} Argument__ACPI_METHOD_ARGUMENT(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.AssociatedIrp__IRP"} {:fieldname "AssociatedIrp"} AssociatedIrp__IRP(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.AutoInitialize__DEVICE_DESCRIPTION"} {:fieldname "AutoInitialize"} AutoInitialize__DEVICE_DESCRIPTION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.BaseAddress__IO_PORT_INFO"} {:fieldname "BaseAddress"} BaseAddress__IO_PORT_INFO(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Blink__LIST_ENTRY"} {:fieldname "Blink"} Blink__LIST_ENTRY(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.BufferAddress__FDC_INFO"} {:fieldname "BufferAddress"} BufferAddress__FDC_INFO(x: int) : int
{
  x + 116
}

function {:inline true} {:fieldmap "Mem_T.BufferCount__FDC_FDO_EXTENSION"} {:fieldname "BufferCount"} BufferCount__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1612
}

function {:inline true} {:fieldmap "Mem_T.BufferCount__FDC_INFO"} {:fieldname "BufferCount"} BufferCount__FDC_INFO(x: int) : int
{
  x + 108
}

function {:inline true} {:fieldmap "Mem_T.BufferSize__FDC_FDO_EXTENSION"} {:fieldname "BufferSize"} BufferSize__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1616
}

function {:inline true} {:fieldmap "Mem_T.BufferSize__FDC_INFO"} {:fieldname "BufferSize"} BufferSize__FDC_INFO(x: int) : int
{
  x + 112
}

function {:inline true} {:fieldmap "Mem_T.BufferThreadHandle__FDC_FDO_EXTENSION"} {:fieldname "BufferThreadHandle"} BufferThreadHandle__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1264
}

function {:inline true} {:fieldmap "Mem_T.Buffer__STRING"} {:fieldname "Buffer"} Buffer__STRING(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.BuffersRequested__FDC_FDO_EXTENSION"} {:fieldname "BuffersRequested"} BuffersRequested__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1608
}

function {:inline true} {:fieldmap "Mem_T.BusNumber__CM_FULL_RESOURCE_DESCRIPTOR"} {:fieldname "BusNumber"} BusNumber__CM_FULL_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.BusNumber__DEVICE_DESCRIPTION"} {:fieldname "BusNumber"} BusNumber__DEVICE_DESCRIPTION(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.BusNumber__FDC_FDO_EXTENSION"} {:fieldname "BusNumber"} BusNumber__FDC_FDO_EXTENSION(x: int) : int
{
  x + 688
}

function {:inline true} {:fieldmap "Mem_T.BusNumber__FDC_INFO"} {:fieldname "BusNumber"} BusNumber__FDC_INFO(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.BusNumber__IO_RESOURCE_REQUIREMENTS_LIST"} {:fieldname "BusNumber"} BusNumber__IO_RESOURCE_REQUIREMENTS_LIST(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.BusNumber_unnamed_tag_57"} {:fieldname "BusNumber"} BusNumber_unnamed_tag_57(x: int) : int
{
  x + 200
}

function {:inline true} {:fieldmap "Mem_T.BusType__FDC_FDO_EXTENSION"} {:fieldname "BusType"} BusType__FDC_FDO_EXTENSION(x: int) : int
{
  x + 684
}

function {:inline true} {:fieldmap "Mem_T.BusType__FDC_INFO"} {:fieldname "BusType"} BusType__FDC_INFO(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT"} {:fieldname "CallerCompletionRoutine"} CallerCompletionRoutine__ASYNC_ACPI_EXEC_METHOD_CONTEXT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT"} {:fieldname "CallerContext"} CallerContext__ASYNC_ACPI_EXEC_METHOD_CONTEXT(x: int) : int
{
  x + 4
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

function {:inline true} {:fieldmap "Mem_T.Channel_unnamed_tag_48"} {:fieldname "Channel"} Channel_unnamed_tag_48(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Channel_unnamed_tag_61"} {:fieldname "Channel"} Channel_unnamed_tag_61(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Class_unnamed_tag_56"} {:fieldname "Class"} Class_unnamed_tag_56(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Clock48MHz__FDC_FDO_EXTENSION"} {:fieldname "Clock48MHz"} Clock48MHz__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1760
}

function {:inline true} {:fieldmap "Mem_T.ClockRate__FDC_MODE_SELECT"} {:fieldname "ClockRate"} ClockRate__FDC_MODE_SELECT(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.ClockRatesSupported__FDC_INFORMATION"} {:fieldname "ClockRatesSupported"} ClockRatesSupported__FDC_INFORMATION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION"} {:fieldname "CommandHasResultPhase"} CommandHasResultPhase__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1700
}

function {:inline true} {:fieldmap "Mem_T.CompletionRoutine__IO_STACK_LOCATION"} {:fieldname "CompletionRoutine"} CompletionRoutine__IO_STACK_LOCATION(x: int) : int
{
  x + 536
}

function {:inline true} {:fieldmap "Mem_T.ConfigData_unnamed_tag_57"} {:fieldname "ConfigData"} ConfigData_unnamed_tag_57(x: int) : int
{
  x + 216
}

function {:inline true} {:fieldmap "Mem_T.Connection_unnamed_tag_57"} {:fieldname "Connection"} Connection_unnamed_tag_57(x: int) : int
{
  x + 372
}

function {:inline true} {:fieldmap "Mem_T.ControllerAddress__FDC_FDO_EXTENSION"} {:fieldname "ControllerAddress"} ControllerAddress__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1532
}

function {:inline true} {:fieldmap "Mem_T.ControllerConfigurable__FDC_FDO_EXTENSION"} {:fieldname "ControllerConfigurable"} ControllerConfigurable__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1704
}

function {:inline true} {:fieldmap "Mem_T.ControllerInUse__FDC_FDO_EXTENSION"} {:fieldname "ControllerInUse"} ControllerInUse__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1736
}

function {:inline true} {:fieldmap "Mem_T.ControllerIrql__FDC_FDO_EXTENSION"} {:fieldname "ControllerIrql"} ControllerIrql__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1632
}

function {:inline true} {:fieldmap "Mem_T.ControllerNumber__FDC_FDO_EXTENSION"} {:fieldname "ControllerNumber"} ControllerNumber__FDC_FDO_EXTENSION(x: int) : int
{
  x + 692
}

function {:inline true} {:fieldmap "Mem_T.ControllerNumber__FDC_INFO"} {:fieldname "ControllerNumber"} ControllerNumber__FDC_INFO(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.ControllerVector__FDC_FDO_EXTENSION"} {:fieldname "ControllerVector"} ControllerVector__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1628
}

function {:inline true} {:fieldmap "Mem_T.Count__ACPI_EVAL_OUTPUT_BUFFER"} {:fieldname "Count"} Count__ACPI_EVAL_OUTPUT_BUFFER(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Count__CM_PARTIAL_RESOURCE_LIST"} {:fieldname "Count"} Count__CM_PARTIAL_RESOURCE_LIST(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Count__DEVICE_RELATIONS"} {:fieldname "Count"} Count__DEVICE_RELATIONS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Count__IO_RESOURCE_LIST"} {:fieldname "Count"} Count__IO_RESOURCE_LIST(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION"} {:fieldname "CurrentDeviceObject"} CurrentDeviceObject__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1524
}

function {:inline true} {:fieldmap "Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION"} {:fieldname "CurrentInterrupt"} CurrentInterrupt__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1712
}

function {:inline true} {:fieldmap "Mem_T.CurrentIrp__DEVICE_OBJECT"} {:fieldname "CurrentIrp"} CurrentIrp__DEVICE_OBJECT(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.CurrentIrp__FDC_FDO_EXTENSION"} {:fieldname "CurrentIrp"} CurrentIrp__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1748
}

function {:inline true} {:fieldmap "Mem_T.CurrentPowerState__FDC_FDO_EXTENSION"} {:fieldname "CurrentPowerState"} CurrentPowerState__FDC_FDO_EXTENSION(x: int) : int
{
  x + 652
}

function {:inline true} {:fieldmap "Mem_T.CurrentStackLocation_unnamed_tag_6"} {:fieldname "CurrentStackLocation"} CurrentStackLocation_unnamed_tag_6(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.DRDC__CONTROLLER"} {:fieldname "DRDC"} DRDC__CONTROLLER(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.DataLength__ACPI_METHOD_ARGUMENT"} {:fieldname "DataLength"} DataLength__ACPI_METHOD_ARGUMENT(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.DataRate_unnamed_tag_69"} {:fieldname "DataRate"} DataRate_unnamed_tag_69(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DataTransferLength__ACPI_FDI_DATA"} {:fieldname "DataTransferLength"} DataTransferLength__ACPI_FDI_DATA(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.DataTransfer__COMMAND_TABLE"} {:fieldname "DataTransfer"} DataTransfer__COMMAND_TABLE(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.Data__ACPI_METHOD_ARGUMENT"} {:fieldname "Data"} Data__ACPI_METHOD_ARGUMENT(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Data_unnamed_tag_50"} {:fieldname "Data"} Data_unnamed_tag_50(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DeferredRoutine__KDPC"} {:fieldname "DeferredRoutine"} DeferredRoutine__KDPC(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.DemandMode__DEVICE_DESCRIPTION"} {:fieldname "DemandMode"} DemandMode__DEVICE_DESCRIPTION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Descriptors__IO_RESOURCE_LIST"} {:fieldname "Descriptors"} Descriptors__IO_RESOURCE_LIST(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.DeviceCapabilities_unnamed_tag_8"} {:fieldname "DeviceCapabilities"} DeviceCapabilities_unnamed_tag_8(x: int) : int
{
  x + 352
}

function {:inline true} {:fieldmap "Mem_T.DeviceExtension__DEVICE_OBJECT"} {:fieldname "DeviceExtension"} DeviceExtension__DEVICE_OBJECT(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.unnamed_tag_22"} {:fieldname "DeviceIoControl"} DeviceIoControl_unnamed_tag_8(x: int) : int
{
  x + 256
}

function {:inline true} {:fieldmap "Mem_T.DeviceObjectInitialized__FDC_FDO_EXTENSION"} {:fieldname "DeviceObjectInitialized"} DeviceObjectInitialized__FDC_FDO_EXTENSION(x: int) : int
{
  x + 696
}

function {:inline true} {:fieldmap "Mem_T.DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT"} {:fieldname "DeviceObject"} DeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT(x: int) : int
{
  x + 308
}

function {:inline true} {:fieldmap "Mem_T.DevicePrivate_unnamed_tag_57"} {:fieldname "DevicePrivate"} DevicePrivate_unnamed_tag_57(x: int) : int
{
  x + 188
}

function {:inline true} {:fieldmap "Mem_T.DeviceState__POWER_STATE"} {:fieldname "DeviceState"} DeviceState__POWER_STATE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.DeviceType__ACPI_FDI_DATA"} {:fieldname "DeviceType"} DeviceType__ACPI_FDI_DATA(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.DeviceType__FDC_PDO_EXTENSION"} {:fieldname "DeviceType"} DeviceType__FDC_PDO_EXTENSION(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Dma32BitAddresses__DEVICE_DESCRIPTION"} {:fieldname "Dma32BitAddresses"} Dma32BitAddresses__DEVICE_DESCRIPTION(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Dma64BitAddresses__DEVICE_DESCRIPTION"} {:fieldname "Dma64BitAddresses"} Dma64BitAddresses__DEVICE_DESCRIPTION(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.DmaAddressWidth__DEVICE_DESCRIPTION"} {:fieldname "DmaAddressWidth"} DmaAddressWidth__DEVICE_DESCRIPTION(x: int) : int
{
  x + 64
}

function {:inline true} {:fieldmap "Mem_T.DmaChannel__DEVICE_DESCRIPTION"} {:fieldname "DmaChannel"} DmaChannel__DEVICE_DESCRIPTION(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.DmaControllerInstance__DEVICE_DESCRIPTION"} {:fieldname "DmaControllerInstance"} DmaControllerInstance__DEVICE_DESCRIPTION(x: int) : int
{
  x + 68
}

function {:inline true} {:fieldmap "Mem_T.DmaDirection__FDC_MODE_SELECT"} {:fieldname "DmaDirection"} DmaDirection__FDC_MODE_SELECT(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.DmaPort__DEVICE_DESCRIPTION"} {:fieldname "DmaPort"} DmaPort__DEVICE_DESCRIPTION(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.DmaRequestLine__DEVICE_DESCRIPTION"} {:fieldname "DmaRequestLine"} DmaRequestLine__DEVICE_DESCRIPTION(x: int) : int
{
  x + 72
}

function {:inline true} {:fieldmap "Mem_T.DmaSpeed__DEVICE_DESCRIPTION"} {:fieldname "DmaSpeed"} DmaSpeed__DEVICE_DESCRIPTION(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.DmaV3_unnamed_tag_57"} {:fieldname "DmaV3"} DmaV3_unnamed_tag_57(x: int) : int
{
  x + 124
}

function {:inline true} {:fieldmap "Mem_T.DmaWidth__DEVICE_DESCRIPTION"} {:fieldname "DmaWidth"} DmaWidth__DEVICE_DESCRIPTION(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.DmaWidth__FDC_MODE_SELECT"} {:fieldname "DmaWidth"} DmaWidth__FDC_MODE_SELECT(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DmaWidthsSupported__FDC_INFORMATION"} {:fieldname "DmaWidthsSupported"} DmaWidthsSupported__FDC_INFORMATION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Dma_unnamed_tag_43"} {:fieldname "Dma"} Dma_unnamed_tag_43(x: int) : int
{
  x + 112
}

function {:inline true} {:fieldmap "Mem_T.Dma_unnamed_tag_57"} {:fieldname "Dma"} Dma_unnamed_tag_57(x: int) : int
{
  x + 116
}

function {:inline true} {:fieldmap "Mem_T.DriveControlImage__FDC_FDO_EXTENSION"} {:fieldname "DriveControlImage"} DriveControlImage__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1728
}

function {:inline true} {:fieldmap "Mem_T.DriveControl__CONTROLLER"} {:fieldname "DriveControl"} DriveControl__CONTROLLER(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.DriveNumber__ACPI_FDI_DATA"} {:fieldname "DriveNumber"} DriveNumber__ACPI_FDI_DATA(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DriveOnValue__FDC_ENABLE_PARMS"} {:fieldname "DriveOnValue"} DriveOnValue__FDC_ENABLE_PARMS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DrivePresent__ACPI_FDE_ENUM_TABLE"} {:fieldname "DrivePresent"} DrivePresent__ACPI_FDE_ENUM_TABLE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS"} {:fieldname "DriveStatus"} DriveStatus__FDC_DISK_CHANGE_PARMS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.DumpDataSize__IO_ERROR_LOG_PACKET"} {:fieldname "DumpDataSize"} DumpDataSize__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.ErrorCode__IO_ERROR_LOG_PACKET"} {:fieldname "ErrorCode"} ErrorCode__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.VOID"} {:fieldname "Event"} Event__SYNC_ACPI_EXEC_METHOD_CONTEXT(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION"} {:fieldname "FdcEnablerDeviceObject"} FdcEnablerDeviceObject__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1768
}

function {:inline true} {:fieldmap "Mem_T.FdcEnablerFileObject__FDC_FDO_EXTENSION"} {:fieldname "FdcEnablerFileObject"} FdcEnablerFileObject__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1772
}

function {:inline true} {:fieldmap "Mem_T.INT4"} {:fieldname "FdcEnablerSupported"} FdcEnablerSupported__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1764
}

function {:inline true} {:fieldmap "Mem_T.FdcFailedTime__FDC_FDO_EXTENSION"} {:fieldname "FdcFailedTime"} FdcFailedTime__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1776
}

function {:inline true} {:fieldmap "Mem_T.FdcSpeeds__FDC_FDO_EXTENSION"} {:fieldname "FdcSpeeds"} FdcSpeeds__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1744
}

function {:inline true} {:fieldmap "Mem_T.FdcType__FDC_FDO_EXTENSION"} {:fieldname "FdcType"} FdcType__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1740
}

function {:inline true} {:fieldmap "Mem_T.FifoBuffer__FDC_FDO_EXTENSION"} {:fieldname "FifoBuffer"} FifoBuffer__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1644
}

function {:inline true} {:fieldmap "Mem_T.FifoInBuffer__ISSUE_FDC_COMMAND_PARMS"} {:fieldname "FifoInBuffer"} FifoInBuffer__ISSUE_FDC_COMMAND_PARMS(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS"} {:fieldname "FifoOutBuffer"} FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Fifo__CONTROLLER"} {:fieldname "Fifo"} Fifo__CONTROLLER(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.FilterResourceRequirements_unnamed_tag_8"} {:fieldname "FilterResourceRequirements"} FilterResourceRequirements_unnamed_tag_8(x: int) : int
{
  x + 356
}

function {:inline true} {:fieldmap "Mem_T.FinalStatus__IO_ERROR_LOG_PACKET"} {:fieldname "FinalStatus"} FinalStatus__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.FirstResultByte__COMMAND_TABLE"} {:fieldname "FirstResultByte"} FirstResultByte__COMMAND_TABLE(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR"} {:fieldname "Flags"} Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Flags__DEVICE_OBJECT"} {:fieldname "Flags"} Flags__DEVICE_OBJECT(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Flags__IO_RESOURCE_DESCRIPTOR"} {:fieldname "Flags"} Flags__IO_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.Flags__IRP"} {:fieldname "Flags"} Flags__IRP(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Flink__LIST_ENTRY"} {:fieldname "Flink"} Flink__LIST_ENTRY(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.FloppyControllerType__FDC_INFO"} {:fieldname "FloppyControllerType"} FloppyControllerType__FDC_INFO(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.FloppyControllerType__FDC_INFORMATION"} {:fieldname "FloppyControllerType"} FloppyControllerType__FDC_INFORMATION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.FormatFillCharacter__ACPI_FDI_DATA"} {:fieldname "FormatFillCharacter"} FormatFillCharacter__ACPI_FDI_DATA(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.FormatGapLength__ACPI_FDI_DATA"} {:fieldname "FormatGapLength"} FormatGapLength__ACPI_FDI_DATA(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.Generic_unnamed_tag_57"} {:fieldname "Generic"} Generic_unnamed_tag_57(x: int) : int
{
  x + 140
}

function {:inline true} {:fieldmap "Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS"} {:fieldname "Handle"} Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.HardwareFailed__FDC_FDO_EXTENSION"} {:fieldname "HardwareFailed"} HardwareFailed__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1696
}

function {:inline true} {:fieldmap "Mem_T.HeadLoadTime__ACPI_FDI_DATA"} {:fieldname "HeadLoadTime"} HeadLoadTime__ACPI_FDI_DATA(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.HeadSettleTime__ACPI_FDI_DATA"} {:fieldname "HeadSettleTime"} HeadSettleTime__ACPI_FDI_DATA(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.Header__KEVENT"} {:fieldname "Header"} Header__KEVENT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.HighPart__LUID"} {:fieldname "HighPart"} HighPart__LUID(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.IdHighPart_unnamed_tag_56"} {:fieldname "IdHighPart"} IdHighPart_unnamed_tag_56(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.IdLowPart_unnamed_tag_56"} {:fieldname "IdLowPart"} IdLowPart_unnamed_tag_56(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.IdType_unnamed_tag_34"} {:fieldname "IdType"} IdType_unnamed_tag_34(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.IgnoreCount__DEVICE_DESCRIPTION"} {:fieldname "IgnoreCount"} IgnoreCount__DEVICE_DESCRIPTION(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.Information__IO_STATUS_BLOCK"} {:fieldname "Information"} Information__IO_STATUS_BLOCK(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.InputBufferLength_unnamed_tag_22"} {:fieldname "InputBufferLength"} InputBufferLength_unnamed_tag_22(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.InterfaceType__CM_FULL_RESOURCE_DESCRIPTOR"} {:fieldname "InterfaceType"} InterfaceType__CM_FULL_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.InterfaceType__DEVICE_DESCRIPTION"} {:fieldname "InterfaceType"} InterfaceType__DEVICE_DESCRIPTION(x: int) : int
{
  x + 44
}

function {:inline true} {:fieldmap "Mem_T.InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST"} {:fieldname "InterfaceType"} InterfaceType__IO_RESOURCE_REQUIREMENTS_LIST(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T._LARGE_INTEGER"} {:fieldname "InterruptDelay"} InterruptDelay__FDC_FDO_EXTENSION(x: int) : int
{
  x + 700
}

function {:inline true} {:fieldmap "Mem_T.VOID"} {:fieldname "InterruptEvent"} InterruptEvent__FDC_FDO_EXTENSION(x: int) : int
{
  x + 740
}

function {:inline true} {:fieldmap "Mem_T.InterruptExpected__COMMAND_TABLE"} {:fieldname "InterruptExpected"} InterruptExpected__COMMAND_TABLE(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.InterruptMode__FDC_FDO_EXTENSION"} {:fieldname "InterruptMode"} InterruptMode__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1636
}

function {:inline true} {:fieldmap "Mem_T.InterruptTimer__FDC_FDO_EXTENSION"} {:fieldname "InterruptTimer"} InterruptTimer__FDC_FDO_EXTENSION(x: int) : int
{
  x + 896
}

function {:inline true} {:fieldmap "Mem_T.Interrupt_unnamed_tag_43"} {:fieldname "Interrupt"} Interrupt_unnamed_tag_43(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.Interrupt_unnamed_tag_57"} {:fieldname "Interrupt"} Interrupt_unnamed_tag_57(x: int) : int
{
  x + 96
}

function {:inline true} {:fieldmap "Mem_T.IoControlCode_unnamed_tag_22"} {:fieldname "IoControlCode"} IoControlCode_unnamed_tag_22(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.IoHandle__ISSUE_FDC_COMMAND_PARMS"} {:fieldname "IoHandle"} IoHandle__ISSUE_FDC_COMMAND_PARMS(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.IoOffset__ISSUE_FDC_COMMAND_PARMS"} {:fieldname "IoOffset"} IoOffset__ISSUE_FDC_COMMAND_PARMS(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.IoResourceRequirementList_unnamed_tag_31"} {:fieldname "IoResourceRequirementList"} IoResourceRequirementList_unnamed_tag_31(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.IoStatus__IRP"} {:fieldname "IoStatus"} IoStatus__IRP(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT"} {:fieldname "IrpStatus"} IrpStatus__SYNC_ACPI_EXEC_METHOD_CONTEXT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.IsFDO__FDC_EXTENSION_HEADER"} {:fieldname "IsFDO"} IsFDO__FDC_EXTENSION_HEADER(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.IsrReentered__FDC_FDO_EXTENSION"} {:fieldname "IsrReentered"} IsrReentered__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1624
}

function {:inline true} {:fieldmap "Mem_T.LastDeviceObject__FDC_FDO_EXTENSION"} {:fieldname "LastDeviceObject"} LastDeviceObject__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1756
}

function {:inline true} {:fieldmap "Mem_T.LastMotorSettleTime__FDC_FDO_EXTENSION"} {:fieldname "LastMotorSettleTime"} LastMotorSettleTime__FDC_FDO_EXTENSION(x: int) : int
{
  x + 656
}

function {:inline true} {:fieldmap "Mem_T.Length40_unnamed_tag_64"} {:fieldname "Length40"} Length40_unnamed_tag_64(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Length48_unnamed_tag_65"} {:fieldname "Length48"} Length48_unnamed_tag_65(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Length64_unnamed_tag_66"} {:fieldname "Length64"} Length64_unnamed_tag_66(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Length_unnamed_tag_18"} {:fieldname "Length"} Length_unnamed_tag_18(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Length_unnamed_tag_44"} {:fieldname "Length"} Length_unnamed_tag_44(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Level_unnamed_tag_45"} {:fieldname "Level"} Level_unnamed_tag_45(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "ListEntry"} ListEntry__IO_PORT_INFO(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST"} {:fieldname "ListSize"} ListSize__IO_RESOURCE_REQUIREMENTS_LIST(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.List__CM_RESOURCE_LIST"} {:fieldname "List"} List__CM_RESOURCE_LIST(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.List__IO_RESOURCE_REQUIREMENTS_LIST"} {:fieldname "List"} List__IO_RESOURCE_REQUIREMENTS_LIST(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T._KDPC"} {:fieldname "LogErrorDpc"} LogErrorDpc__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1220
}

function {:inline true} {:fieldmap "Mem_T.Logical__TRANSFER_BUFFER"} {:fieldname "Logical"} Logical__TRANSFER_BUFFER(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.LowPart__LUID"} {:fieldname "LowPart"} LowPart__LUID(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.MajorFunctionCode__IO_ERROR_LOG_PACKET"} {:fieldname "MajorFunctionCode"} MajorFunctionCode__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.MajorFunction__IO_STACK_LOCATION"} {:fieldname "MajorFunction"} MajorFunction__IO_STACK_LOCATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Map__IO_PORT_INFO"} {:fieldname "Map"} Map__IO_PORT_INFO(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Master__DEVICE_DESCRIPTION"} {:fieldname "Master"} Master__DEVICE_DESCRIPTION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.MaxBusNumber_unnamed_tag_62"} {:fieldname "MaxBusNumber"} MaxBusNumber_unnamed_tag_62(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.MaxCylinderNumber__ACPI_FDI_DATA"} {:fieldname "MaxCylinderNumber"} MaxCylinderNumber__ACPI_FDI_DATA(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.MaxHeadNumber__ACPI_FDI_DATA"} {:fieldname "MaxHeadNumber"} MaxHeadNumber__ACPI_FDI_DATA(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.MaxSectorNumber__ACPI_FDI_DATA"} {:fieldname "MaxSectorNumber"} MaxSectorNumber__ACPI_FDI_DATA(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.MaxTransferSize__FDC_INFO"} {:fieldname "MaxTransferSize"} MaxTransferSize__FDC_INFO(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.MaximumAddress_unnamed_tag_58"} {:fieldname "MaximumAddress"} MaximumAddress_unnamed_tag_58(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.MaximumAddress_unnamed_tag_64"} {:fieldname "MaximumAddress"} MaximumAddress_unnamed_tag_64(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.MaximumAddress_unnamed_tag_65"} {:fieldname "MaximumAddress"} MaximumAddress_unnamed_tag_65(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.MaximumAddress_unnamed_tag_66"} {:fieldname "MaximumAddress"} MaximumAddress_unnamed_tag_66(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.MaximumChannel_unnamed_tag_60"} {:fieldname "MaximumChannel"} MaximumChannel_unnamed_tag_60(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.MaximumLength__DEVICE_DESCRIPTION"} {:fieldname "MaximumLength"} MaximumLength__DEVICE_DESCRIPTION(x: int) : int
{
  x + 56
}

function {:inline true} {:fieldmap "Mem_T.MaximumLength__STRING"} {:fieldname "MaximumLength"} MaximumLength__STRING(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.MaximumVector_unnamed_tag_59"} {:fieldname "MaximumVector"} MaximumVector_unnamed_tag_59(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Memory40_unnamed_tag_57"} {:fieldname "Memory40"} Memory40_unnamed_tag_57(x: int) : int
{
  x + 228
}

function {:inline true} {:fieldmap "Mem_T.Memory48_unnamed_tag_57"} {:fieldname "Memory48"} Memory48_unnamed_tag_57(x: int) : int
{
  x + 276
}

function {:inline true} {:fieldmap "Mem_T.Memory64_unnamed_tag_57"} {:fieldname "Memory64"} Memory64_unnamed_tag_57(x: int) : int
{
  x + 324
}

function {:inline true} {:fieldmap "Mem_T.Memory_unnamed_tag_43"} {:fieldname "Memory"} Memory_unnamed_tag_43(x: int) : int
{
  x + 88
}

function {:inline true} {:fieldmap "Mem_T.Memory_unnamed_tag_57"} {:fieldname "Memory"} Memory_unnamed_tag_57(x: int) : int
{
  x + 48
}

function {:inline true} {:fieldmap "Mem_T.MethodNameAsUlong__ACPI_EVAL_INPUT_BUFFER_COMPLEX"} {:fieldname "MethodNameAsUlong"} MethodNameAsUlong__ACPI_EVAL_INPUT_BUFFER_COMPLEX(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.MinBusNumber_unnamed_tag_62"} {:fieldname "MinBusNumber"} MinBusNumber_unnamed_tag_62(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Minimum10msDelay__FDC_FDO_EXTENSION"} {:fieldname "Minimum10msDelay"} Minimum10msDelay__FDC_FDO_EXTENSION(x: int) : int
{
  x + 720
}

function {:inline true} {:fieldmap "Mem_T.MinimumAddress_unnamed_tag_58"} {:fieldname "MinimumAddress"} MinimumAddress_unnamed_tag_58(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.MinimumAddress_unnamed_tag_64"} {:fieldname "MinimumAddress"} MinimumAddress_unnamed_tag_64(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.MinimumAddress_unnamed_tag_65"} {:fieldname "MinimumAddress"} MinimumAddress_unnamed_tag_65(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.MinimumAddress_unnamed_tag_66"} {:fieldname "MinimumAddress"} MinimumAddress_unnamed_tag_66(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.MinimumChannel_unnamed_tag_60"} {:fieldname "MinimumChannel"} MinimumChannel_unnamed_tag_60(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.MinimumVector_unnamed_tag_59"} {:fieldname "MinimumVector"} MinimumVector_unnamed_tag_59(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.MinorFunction__IO_STACK_LOCATION"} {:fieldname "MinorFunction"} MinorFunction__IO_STACK_LOCATION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Model30__FDC_FDO_EXTENSION"} {:fieldname "Model30"} Model30__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1716
}

function {:inline true} {:fieldmap "Mem_T.MotorOffTime__ACPI_FDI_DATA"} {:fieldname "MotorOffTime"} MotorOffTime__ACPI_FDI_DATA(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.MotorSettleTime__ACPI_FDI_DATA"} {:fieldname "MotorSettleTime"} MotorSettleTime__ACPI_FDI_DATA(x: int) : int
{
  x + 60
}

function {:inline true} {:fieldmap "Mem_T.MotorStarted__FDC_ENABLE_PARMS"} {:fieldname "MotorStarted"} MotorStarted__FDC_ENABLE_PARMS(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.NumPDOs__FDC_FDO_EXTENSION"} {:fieldname "NumPDOs"} NumPDOs__FDC_FDO_EXTENSION(x: int) : int
{
  x + 156
}

function {:inline true} {:fieldmap "Mem_T.NumberOfMapRegisters__FDC_FDO_EXTENSION"} {:fieldname "NumberOfMapRegisters"} NumberOfMapRegisters__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1604
}

function {:inline true} {:fieldmap "Mem_T.NumberOfParameters__COMMAND_TABLE"} {:fieldname "NumberOfParameters"} NumberOfParameters__COMMAND_TABLE(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.NumberOfResultBytes__COMMAND_TABLE"} {:fieldname "NumberOfResultBytes"} NumberOfResultBytes__COMMAND_TABLE(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.PP_DEVICE_OBJECT"} {:fieldname "Objects"} Objects__DEVICE_RELATIONS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.OpCode__COMMAND_TABLE"} {:fieldname "OpCode"} OpCode__COMMAND_TABLE(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Option__IO_RESOURCE_DESCRIPTOR"} {:fieldname "Option"} Option__IO_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.OutputBufferLength_unnamed_tag_22"} {:fieldname "OutputBufferLength"} OutputBufferLength_unnamed_tag_22(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.OutstandingRequests__FDC_FDO_EXTENSION"} {:fieldname "OutstandingRequests"} OutstandingRequests__FDC_FDO_EXTENSION(x: int) : int
{
  x + 164
}

function {:inline true} {:fieldmap "Mem_T.Overlay_unnamed_tag_5"} {:fieldname "Overlay"} Overlay_unnamed_tag_5(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "PDOs"} PDOs__FDC_FDO_EXTENSION(x: int) : int
{
  x + 148
}

function {:inline true} {:fieldmap "Mem_T.Parameters__IO_STACK_LOCATION"} {:fieldname "Parameters"} Parameters__IO_STACK_LOCATION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.ParentFdo__FDC_PDO_EXTENSION"} {:fieldname "ParentFdo"} ParentFdo__FDC_PDO_EXTENSION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.PartialDescriptors__CM_PARTIAL_RESOURCE_LIST"} {:fieldname "PartialDescriptors"} PartialDescriptors__CM_PARTIAL_RESOURCE_LIST(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T._CM_PARTIAL_RESOURCE_LIST"} {:fieldname "PartialResourceList"} PartialResourceList__CM_FULL_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Paused__FDC_FDO_EXTENSION"} {:fieldname "Paused"} Paused__FDC_FDO_EXTENSION(x: int) : int
{
  x + 680
}

function {:inline true} {:fieldmap "Mem_T._LIST_ENTRY"} {:fieldname "PdoLink"} PdoLink__FDC_PDO_EXTENSION(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.PendingReturned__IRP"} {:fieldname "PendingReturned"} PendingReturned__IRP(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.PeripheralNumber__FDC_INFO"} {:fieldname "PeripheralNumber"} PeripheralNumber__FDC_INFO(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.PeripheralNumber__FDC_PDO_EXTENSION"} {:fieldname "PeripheralNumber"} PeripheralNumber__FDC_PDO_EXTENSION(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Port_unnamed_tag_43"} {:fieldname "Port"} Port_unnamed_tag_43(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.Port_unnamed_tag_57"} {:fieldname "Port"} Port_unnamed_tag_57(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Power_unnamed_tag_8"} {:fieldname "Power"} Power_unnamed_tag_8(x: int) : int
{
  x + 420
}

function {:inline true} {:fieldmap "Mem_T.PriorityPolicy_unnamed_tag_59"} {:fieldname "PriorityPolicy"} PriorityPolicy_unnamed_tag_59(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Priority_unnamed_tag_63"} {:fieldname "Priority"} Priority_unnamed_tag_63(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION"} {:fieldname "ProbeFloppyDevices"} ProbeFloppyDevices__FDC_FDO_EXTENSION(x: int) : int
{
  x + 128
}

function {:inline true} {:fieldmap "Mem_T.ProcessorMask__FDC_FDO_EXTENSION"} {:fieldname "ProcessorMask"} ProcessorMask__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1640
}

function {:inline true} {:fieldmap "Mem_T.QuadPart__LARGE_INTEGER"} {:fieldname "QuadPart"} QuadPart__LARGE_INTEGER(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.QueryDeviceRelations_unnamed_tag_8"} {:fieldname "QueryDeviceRelations"} QueryDeviceRelations_unnamed_tag_8(x: int) : int
{
  x + 328
}

function {:inline true} {:fieldmap "Mem_T.QueryId_unnamed_tag_8"} {:fieldname "QueryId"} QueryId_unnamed_tag_8(x: int) : int
{
  x + 380
}

function {:inline true} {:fieldmap "Mem_T.ReadWriteGapLength__ACPI_FDI_DATA"} {:fieldname "ReadWriteGapLength"} ReadWriteGapLength__ACPI_FDI_DATA(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.VOID"} {:fieldname "RemoveEvent"} RemoveEvent__FDC_FDO_EXTENSION(x: int) : int
{
  x + 168
}

function {:inline true} {:fieldmap "Mem_T.Removed__FDC_FDO_EXTENSION"} {:fieldname "Removed"} Removed__FDC_FDO_EXTENSION(x: int) : int
{
  x + 160
}

function {:inline true} {:fieldmap "Mem_T.Removed__FDC_PDO_EXTENSION"} {:fieldname "Removed"} Removed__FDC_PDO_EXTENSION(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.ReportedMissing__FDC_PDO_EXTENSION"} {:fieldname "ReportedMissing"} ReportedMissing__FDC_PDO_EXTENSION(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.RequestLine_unnamed_tag_61"} {:fieldname "RequestLine"} RequestLine_unnamed_tag_61(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Reserved1__DEVICE_DESCRIPTION"} {:fieldname "Reserved1"} Reserved1__DEVICE_DESCRIPTION(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.Reserved1_unnamed_tag_56"} {:fieldname "Reserved1"} Reserved1_unnamed_tag_56(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Reserved1_unnamed_tag_63"} {:fieldname "Reserved1"} Reserved1_unnamed_tag_63(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Reserved2_unnamed_tag_56"} {:fieldname "Reserved2"} Reserved2_unnamed_tag_56(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Reserved2_unnamed_tag_63"} {:fieldname "Reserved2"} Reserved2_unnamed_tag_63(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.Reserved__IO_RESOURCE_REQUIREMENTS_LIST"} {:fieldname "Reserved"} Reserved__IO_RESOURCE_REQUIREMENTS_LIST(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.Reserved_unnamed_tag_61"} {:fieldname "Reserved"} Reserved_unnamed_tag_61(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Reserved_unnamed_tag_62"} {:fieldname "Reserved"} Reserved_unnamed_tag_62(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.RetryCount__IO_ERROR_LOG_PACKET"} {:fieldname "RetryCount"} RetryCount__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Revision__IO_RESOURCE_LIST"} {:fieldname "Revision"} Revision__IO_RESOURCE_LIST(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.SaveFloatState__FDC_FDO_EXTENSION"} {:fieldname "SaveFloatState"} SaveFloatState__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1692
}

function {:inline true} {:fieldmap "Mem_T.ScatterGather__DEVICE_DESCRIPTION"} {:fieldname "ScatterGather"} ScatterGather__DEVICE_DESCRIPTION(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.SectorLengthCode__ACPI_FDI_DATA"} {:fieldname "SectorLengthCode"} SectorLengthCode__ACPI_FDI_DATA(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.SectorPerTrack__ACPI_FDI_DATA"} {:fieldname "SectorPerTrack"} SectorPerTrack__ACPI_FDI_DATA(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.Self__FDC_EXTENSION_HEADER"} {:fieldname "Self"} Self__FDC_EXTENSION_HEADER(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.SequenceNumber__IO_ERROR_LOG_PACKET"} {:fieldname "SequenceNumber"} SequenceNumber__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.SharableVector__FDC_FDO_EXTENSION"} {:fieldname "SharableVector"} SharableVector__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1688
}

function {:inline true} {:fieldmap "Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR"} {:fieldname "ShareDisposition"} ShareDisposition__IO_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 8
}

function {:inline true} {:fieldmap "Mem_T.SignalState__DISPATCHER_HEADER"} {:fieldname "SignalState"} SignalState__DISPATCHER_HEADER(x: int) : int
{
  x + 144
}

function {:inline true} {:fieldmap "Mem_T.Signalling__DISPATCHER_HEADER"} {:fieldname "Signalling"} Signalling__DISPATCHER_HEADER(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.Signature__DRIVE_LAYOUT_INFORMATION_MBR"} {:fieldname "Signature"} Signature__DRIVE_LAYOUT_INFORMATION_MBR(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Size__ACPI_EVAL_INPUT_BUFFER_COMPLEX"} {:fieldname "Size"} Size__ACPI_EVAL_INPUT_BUFFER_COMPLEX(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.Size__DISPATCHER_HEADER"} {:fieldname "Size"} Size__DISPATCHER_HEADER(x: int) : int
{
  x + 100
}

function {:inline true} {:fieldmap "Mem_T.SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST"} {:fieldname "SlotNumber"} SlotNumber__IO_RESOURCE_REQUIREMENTS_LIST(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR"} {:fieldname "Spare1"} Spare1__IO_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR"} {:fieldname "Spare2"} Spare2__IO_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.Speed__FDC_MODE_SELECT"} {:fieldname "Speed"} Speed__FDC_MODE_SELECT(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.SpeedsAvailable__FDC_INFO"} {:fieldname "SpeedsAvailable"} SpeedsAvailable__FDC_INFO(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.SpeedsAvailable__FDC_INFORMATION"} {:fieldname "SpeedsAvailable"} SpeedsAvailable__FDC_INFORMATION(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.StackSize__DEVICE_OBJECT"} {:fieldname "StackSize"} StackSize__DEVICE_OBJECT(x: int) : int
{
  x + 52
}

function {:inline true} {:fieldmap "Mem_T.StartDevice_unnamed_tag_8"} {:fieldname "StartDevice"} StartDevice_unnamed_tag_8(x: int) : int
{
  x + 472
}

function {:inline true} {:fieldmap "Mem_T.Start_unnamed_tag_44"} {:fieldname "Start"} Start_unnamed_tag_44(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.State_unnamed_tag_39"} {:fieldname "State"} State_unnamed_tag_39(x: int) : int
{
  x + 40
}

function {:inline true} {:fieldmap "Mem_T.Status__CONTROLLER"} {:fieldname "Status"} Status__CONTROLLER(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.Status__IO_STATUS_BLOCK"} {:fieldname "Status"} Status__IO_STATUS_BLOCK(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.StepRateHeadUnloadTime__ACPI_FDI_DATA"} {:fieldname "StepRateHeadUnloadTime"} StepRateHeadUnloadTime__ACPI_FDI_DATA(x: int) : int
{
  x + 20
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

function {:inline true} {:fieldmap "Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION"} {:fieldname "TapeEnumerationPending"} TapeEnumerationPending__FDC_FDO_EXTENSION(x: int) : int
{
  x + 324
}

function {:inline true} {:fieldmap "Mem_T.TapeVendorId__FDC_PDO_EXTENSION"} {:fieldname "TapeVendorId"} TapeVendorId__FDC_PDO_EXTENSION(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.TargetDeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT"} {:fieldname "TargetDeviceObject"} TargetDeviceObject__ASYNC_ACPI_EXEC_METHOD_CONTEXT(x: int) : int
{
  x + 312
}

function {:inline true} {:fieldmap "Mem_T.TargetObject__FDC_FDO_EXTENSION"} {:fieldname "TargetObject"} TargetObject__FDC_FDO_EXTENSION(x: int) : int
{
  x + 96
}

function {:inline true} {:fieldmap "Mem_T.TargetObject__FDC_PDO_EXTENSION"} {:fieldname "TargetObject"} TargetObject__FDC_PDO_EXTENSION(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.TargetedProcessors_unnamed_tag_59"} {:fieldname "TargetedProcessors"} TargetedProcessors_unnamed_tag_59(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.TerminateBufferThread__FDC_FDO_EXTENSION"} {:fieldname "TerminateBufferThread"} TerminateBufferThread__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1272
}

function {:inline true} {:fieldmap "Mem_T.TimeOut__ISSUE_FDC_COMMAND_PARMS"} {:fieldname "TimeOut"} TimeOut__ISSUE_FDC_COMMAND_PARMS(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.TimeToWait__FDC_ENABLE_PARMS"} {:fieldname "TimeToWait"} TimeToWait__FDC_ENABLE_PARMS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.TransferBuffers__FDC_FDO_EXTENSION"} {:fieldname "TransferBuffers"} TransferBuffers__FDC_FDO_EXTENSION(x: int) : int
{
  x + 1620
}

function {:inline true} {:fieldmap "Mem_T.TransferBytes__ISSUE_FDC_ADAPTER_BUFFER_PARMS"} {:fieldname "TransferBytes"} TransferBytes__ISSUE_FDC_ADAPTER_BUFFER_PARMS(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.TransferBytes__ISSUE_FDC_COMMAND_PARMS"} {:fieldname "TransferBytes"} TransferBytes__ISSUE_FDC_COMMAND_PARMS(x: int) : int
{
  x + 16
}

function {:inline true} {:fieldmap "Mem_T.TransferWidth_unnamed_tag_61"} {:fieldname "TransferWidth"} TransferWidth_unnamed_tag_61(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Type3InputBuffer_unnamed_tag_22"} {:fieldname "Type3InputBuffer"} Type3InputBuffer_unnamed_tag_22(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.Type__IO_RESOURCE_DESCRIPTOR"} {:fieldname "Type"} Type__IO_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_28"} {:fieldname "Type"} Type_unnamed_tag_28(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_39"} {:fieldname "Type"} Type_unnamed_tag_39(x: int) : int
{
  x + 36
}

function {:inline true} {:fieldmap "Mem_T.Type_unnamed_tag_56"} {:fieldname "Type"} Type_unnamed_tag_56(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.UniqueErrorValue__IO_ERROR_LOG_PACKET"} {:fieldname "UniqueErrorValue"} UniqueErrorValue__IO_ERROR_LOG_PACKET(x: int) : int
{
  x + 28
}

function {:inline true} {:fieldmap "Mem_T.UniqueID__DEVICE_CAPABILITIES"} {:fieldname "UniqueID"} UniqueID__DEVICE_CAPABILITIES(x: int) : int
{
  x + 32
}

function {:inline true} {:fieldmap "Mem_T.UserBuffer__IRP"} {:fieldname "UserBuffer"} UserBuffer__IRP(x: int) : int
{
  x + 124
}

function {:inline true} {:fieldmap "Mem_T.Vector_unnamed_tag_45"} {:fieldname "Vector"} Vector_unnamed_tag_45(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.Version__DEVICE_DESCRIPTION"} {:fieldname "Version"} Version__DEVICE_DESCRIPTION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Version__IO_RESOURCE_LIST"} {:fieldname "Version"} Version__IO_RESOURCE_LIST(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.Virtual__TRANSFER_BUFFER"} {:fieldname "Virtual"} Virtual__TRANSFER_BUFFER(x: int) : int
{
  x + 20
}

function {:inline true} {:fieldmap "Mem_T.WaitListHead__DISPATCHER_HEADER"} {:fieldname "WaitListHead"} WaitListHead__DISPATCHER_HEADER(x: int) : int
{
  x + 148
}

function {:inline true} {:fieldmap "Mem_T.WakeUp__FDC_FDO_EXTENSION"} {:fieldname "WakeUp"} WakeUp__FDC_FDO_EXTENSION(x: int) : int
{
  x + 676
}

function {:inline true} {:fieldmap "Mem_T.cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT"} {:fieldname "cmOutputData"} cmOutputData__SYNC_ACPI_EXEC_METHOD_CONTEXT(x: int) : int
{
  x + 4
}

function {:inline true} {:fieldmap "Mem_T.structSize__FDC_INFORMATION"} {:fieldname "structSize"} structSize__FDC_INFORMATION(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.structSize__FDC_MODE_SELECT"} {:fieldname "structSize"} structSize__FDC_MODE_SELECT(x: int) : int
{
  x + 0
}

function {:inline true} {:fieldmap "Mem_T.u__CM_PARTIAL_RESOURCE_DESCRIPTOR"} {:fieldname "u"} u__CM_PARTIAL_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 12
}

function {:inline true} {:fieldmap "Mem_T.u__IO_RESOURCE_DESCRIPTOR"} {:fieldname "u"} u__IO_RESOURCE_DESCRIPTOR(x: int) : int
{
  x + 24
}

function {:inline true} {:fieldmap "Mem_T.u__LARGE_INTEGER"} {:fieldname "u"} u__LARGE_INTEGER(x: int) : int
{
  x + 8
}

const {:string "%4X"} unique strConst__li2bpl14: int;

const {:string "*PNP0700"} unique strConst__li2bpl5: int;

const {:string "Callers of KeWaitForSingleObject must be running at IRQL <= APC_LEVEL when called with a non-zero timeout interval."} unique strConst__li2bpl3: int;

const {:string "Callers of KeWaitForSingleObject must be running at IRQL <= DISPATCH_LEVEL."} unique strConst__li2bpl2: int;

const {:string "Callers of sdv_KeWaitForMutexObject must be running at IRQL <= APC_LEVEL when called with a non-zero timeout interval."} unique strConst__li2bpl1: int;

const {:string "Callers of sdv_KeWaitForMutexObject must be running at IRQL <= DISPATCH_LEVEL."} unique strConst__li2bpl4: int;

const {:string "FDC\\ENABLER"} unique strConst__li2bpl12: int;

const {:string "FDC\\GENERIC_FLOPPY_DRIVE"} unique strConst__li2bpl9: int;

const {:string "FDC\\QIC%04X"} unique strConst__li2bpl13: int;

const {:string "FDC\\QIC0000"} unique strConst__li2bpl10: int;

const {:string "FDC\\QICLEGACY"} unique strConst__li2bpl11: int;

const {:string "GenFloppyDisk"} unique strConst__li2bpl6: int;

const {:string "PNP0700"} unique strConst__li2bpl8: int;

const {:string "QICPNP"} unique strConst__li2bpl7: int;

const {:string "\\Device\\FloppyPDO%x"} unique strConst__li2bpl15: int;

const {:string "callee"} unique strConst__li2bpl0: int;

const {:allocated} li2bplFunctionConstant190: int;

axiom li2bplFunctionConstant190 == 190;

const {:allocated} li2bplFunctionConstant201: int;

axiom li2bplFunctionConstant201 == 201;

const {:allocated} li2bplFunctionConstant204: int;

axiom li2bplFunctionConstant204 == 204;

const {:allocated} li2bplFunctionConstant206: int;

axiom li2bplFunctionConstant206 == 206;

const {:allocated} li2bplFunctionConstant207: int;

axiom li2bplFunctionConstant207 == 207;

const {:allocated} li2bplFunctionConstant209: int;

axiom li2bplFunctionConstant209 == 209;

const {:allocated} li2bplFunctionConstant210: int;

axiom li2bplFunctionConstant210 == 210;

const {:allocated} li2bplFunctionConstant211: int;

axiom li2bplFunctionConstant211 == 211;

const {:allocated} li2bplFunctionConstant217: int;

axiom li2bplFunctionConstant217 == 217;

const {:allocated} li2bplFunctionConstant228: int;

axiom li2bplFunctionConstant228 == 228;

const {:allocated} li2bplFunctionConstant247: int;

axiom li2bplFunctionConstant247 == 247;

const {:allocated} li2bplFunctionConstant250: int;

axiom li2bplFunctionConstant250 == 250;

const {:allocated} li2bplFunctionConstant298: int;

axiom li2bplFunctionConstant298 == 298;

const {:allocated} li2bplFunctionConstant300: int;

axiom li2bplFunctionConstant300 == 300;

const {:allocated} li2bplFunctionConstant303: int;

axiom li2bplFunctionConstant303 == 303;

procedure {:template} summarytemplate();
  free requires yogi_error == 0;
  free requires {:drop} sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  free ensures alloc >= old(alloc);
  ensures {:mustmod "yogi_error"} {:name "yogi_error"} yogi_error == 0;
  ensures {:mustmod "sdv_irql_current"} {:name "sdv_irql_current"} old(sdv_irql_current) == sdv_irql_current;
  ensures {:mustmod "sdv_irql_previous"} old(sdv_irql_previous) == sdv_irql_previous;
  ensures {:mustmod "yogi_error"} {:dep "yogi_error"} old(sdv_irql_current) == 0 ==> yogi_error == 0;
  ensures {:mustmod "yogi_error"} {:dep "yogi_error"} old(sdv_irql_current) == 1 ==> yogi_error == 0;
  ensures {:mustmod "yogi_error"} {:dep "yogi_error"} old(sdv_irql_current) == 2 ==> yogi_error == 0;
  ensures {:mustmod "sdv_irql_current"} {:dep "sdv_irql_current"} old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> sdv_irql_current <= 2 && sdv_irql_previous <= 2 && sdv_irql_previous_2 <= 2 && sdv_irql_previous_3 <= 2 && sdv_irql_current >= 0 && sdv_irql_previous >= 0 && sdv_irql_previous_2 >= 0 && sdv_irql_previous_3 >= 0;
  ensures {:mustmod "yogi_error"} {:dep "yogi_error"} old(sdv_irql_current) <= 2 && old(sdv_irql_previous) <= 2 && old(sdv_irql_previous_2) <= 2 && old(sdv_irql_previous_3) <= 2 ==> yogi_error == 0;
  ensures {:mustmod "Mem_T.INT4"} old(Mem_T.INT4)[templ_irql] == Mem_T.INT4[templ_irql];
  ensures {:mustmod "Mem_T.INT4"} old(Mem_T.INT4)[templ_irql2] == Mem_T.INT4[templ_irql2];
  ensures {:mustmod "Mem_T.INT4"} old(Mem_T.INT4)[templ_irql3] == Mem_T.INT4[templ_irql3];
  ensures {:mustmod "Mem_T.INT4"} old(Mem_T.INT4)[templ_irql4] == Mem_T.INT4[templ_irql4];



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

implementation DeviceQueryACPI_SyncExecMethodForPackage_loop_L78(in_i: int, in_totalSize: int, in_argument: int, in_Tmp_7: int, in_ExpectedElementCount: int, in_ReturnBuffer: int) returns (out_i: int, out_totalSize: int, out_Tmp_7: int)
{

  entry:
    out_i, out_totalSize, out_Tmp_7 := in_i, in_totalSize, in_Tmp_7;
    goto L78, exit;

  L78:
    goto anon42_Else;

  L92:
    out_i := out_i + 1;
    goto L92_dummy;

  L82:
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    out_Tmp_7 := Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(in_argument)];
    assume {:nonnull} in_ReturnBuffer != 0;
    assume in_ReturnBuffer > 0;
    call sdv_RtlCopyMemory(0, 0, out_Tmp_7);
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    out_totalSize := out_totalSize + Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(in_argument)];
    goto L92;

  anon43_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] == 0;
    assume {:nonnull} in_ReturnBuffer != 0;
    assume in_ReturnBuffer > 0;
    call sdv_RtlCopyMemory(0, 0, 4);
    out_totalSize := out_totalSize + 4;
    goto L92;

  anon42_Else:
    assume {:partition} in_ExpectedElementCount > out_i;
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    goto anon43_Then, anon43_Else;

  anon46_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] == 2;
    goto L82;

  anon47_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] == 1;
    goto L82;

  anon43_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] != 0;
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    goto anon47_Then, anon47_Else;

  anon47_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] != 1;
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    goto anon46_Else;

  L92_dummy:
    call {:si_unique_call 1} out_i, out_totalSize, out_Tmp_7 := DeviceQueryACPI_SyncExecMethodForPackage_loop_L78(out_i, out_totalSize, in_argument, out_Tmp_7, in_ExpectedElementCount, in_ReturnBuffer);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} DeviceQueryACPI_SyncExecMethodForPackage_loop_L78(in_i: int, in_totalSize: int, in_argument: int, in_Tmp_7: int, in_ExpectedElementCount: int, in_ReturnBuffer: int) returns (out_i: int, out_totalSize: int, out_Tmp_7: int);
  modifies alloc;



implementation DeviceQueryACPI_SyncExecMethodForPackage_loop_L46(in_i: int, in_Tmp_5: int, in_argumentSize: int, in_totalSize: int, in_argument: int, in_Tmp_10: int, in_ExpectedElementCount: int, in_ExpectedTypeArray: int, in_ExpectedSizeArray: int) returns (out_i: int, out_Tmp_5: int, out_argumentSize: int, out_totalSize: int, out_Tmp_10: int)
{

  entry:
    out_i, out_Tmp_5, out_argumentSize, out_totalSize, out_Tmp_10 := in_i, in_Tmp_5, in_argumentSize, in_totalSize, in_Tmp_10;
    goto L46, exit;

  L46:
    goto anon38_Else;

  anon51_Then:
    assume {:partition} out_argumentSize == Mem_T.INT4[in_ExpectedSizeArray + out_Tmp_5 * 4];
    out_totalSize := out_totalSize + out_argumentSize;
    out_i := out_i + 1;
    goto anon51_Then_dummy;

  L56:
    out_Tmp_5 := out_i;
    assume {:nonnull} in_ExpectedSizeArray != 0;
    assume in_ExpectedSizeArray > 0;
    goto anon51_Then;

  L54:
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    out_argumentSize := Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(in_argument)];
    goto L56;

  anon40_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] == 0;
    out_argumentSize := 4;
    goto L56;

  anon50_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] == Mem_T.INT4[in_ExpectedTypeArray + out_Tmp_10 * 4];
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    goto anon40_Then, anon40_Else;

  anon38_Else:
    assume {:partition} in_ExpectedElementCount > out_i;
    out_Tmp_10 := out_i;
    assume {:nonnull} in_ExpectedTypeArray != 0;
    assume in_ExpectedTypeArray > 0;
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    goto anon50_Then;

  anon44_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] == 2;
    goto L54;

  anon45_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] == 1;
    goto L54;

  anon40_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] != 0;
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    goto anon45_Then, anon45_Else;

  anon45_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument)] != 1;
    assume {:nonnull} in_argument != 0;
    assume in_argument > 0;
    goto anon44_Else;

  anon51_Then_dummy:
    call {:si_unique_call 1} out_i, out_Tmp_5, out_argumentSize, out_totalSize, out_Tmp_10 := DeviceQueryACPI_SyncExecMethodForPackage_loop_L46(out_i, out_Tmp_5, out_argumentSize, out_totalSize, in_argument, out_Tmp_10, in_ExpectedElementCount, in_ExpectedTypeArray, in_ExpectedSizeArray);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} DeviceQueryACPI_SyncExecMethodForPackage_loop_L46(in_i: int, in_Tmp_5: int, in_argumentSize: int, in_totalSize: int, in_argument: int, in_Tmp_10: int, in_ExpectedElementCount: int, in_ExpectedTypeArray: int, in_ExpectedSizeArray: int) returns (out_i: int, out_Tmp_5: int, out_argumentSize: int, out_totalSize: int, out_Tmp_10: int);



implementation DeviceQueryACPI_AsyncExecMethod_loop_L90(in_i_1: int, in_Tmp_14: int, in_Tmp_19: int, in_argumentSize_1: int, in_argument_1: int, in_Tmp_21: int, in_Tmp_23: int, in_Tmp_25: int, in_Tmp_26: int, in_Tmp_28: int, in_ArgumentCount_1: int, in_ArgumentTypeArray_1: int, in_ArgumentSizeArray_1: int, in_ArgumentArray_1: int) returns (out_i_1: int, out_Tmp_14: int, out_Tmp_19: int, out_argumentSize_1: int, out_Tmp_21: int, out_Tmp_23: int, out_Tmp_25: int, out_Tmp_26: int, out_Tmp_28: int)
{

  entry:
    out_i_1, out_Tmp_14, out_Tmp_19, out_argumentSize_1, out_Tmp_21, out_Tmp_23, out_Tmp_25, out_Tmp_26, out_Tmp_28 := in_i_1, in_Tmp_14, in_Tmp_19, in_argumentSize_1, in_Tmp_21, in_Tmp_23, in_Tmp_25, in_Tmp_26, in_Tmp_28;
    goto L90, exit;

  L90:
    goto anon50_Else;

  L112:
    out_i_1 := out_i_1 + 1;
    goto L112_dummy;

  anon54_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument_1)] != 2;
    goto L112;

  anon63_Else:
    assume {:partition} Mem_T.PVOID[in_ArgumentArray_1 + out_Tmp_21 * 4] != 0;
    out_Tmp_26 := out_i_1;
    assume {:nonnull} in_ArgumentArray_1 != 0;
    assume in_ArgumentArray_1 > 0;
    call sdv_RtlCopyMemory(0, 0, out_argumentSize_1);
    goto L112;

  anon63_Then:
    assume {:partition} Mem_T.PVOID[in_ArgumentArray_1 + out_Tmp_21 * 4] == 0;
    call sdv_RtlZeroMemory(0, out_argumentSize_1);
    goto L112;

  anon62_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument_1)] == 0;
    out_Tmp_14 := out_i_1;
    assume {:nonnull} in_ArgumentArray_1 != 0;
    assume in_ArgumentArray_1 > 0;
    out_Tmp_19 := Mem_T.PVOID[in_ArgumentArray_1 + out_Tmp_14 * 4];
    assume {:nonnull} out_Tmp_19 != 0;
    assume out_Tmp_19 > 0;
    assume {:nonnull} in_argument_1 != 0;
    assume in_argument_1 > 0;
    goto L112;

  anon50_Else:
    assume {:partition} in_ArgumentCount_1 > out_i_1;
    out_Tmp_25 := out_i_1;
    assume {:nonnull} in_ArgumentTypeArray_1 != 0;
    assume in_ArgumentTypeArray_1 > 0;
    assume {:nonnull} in_argument_1 != 0;
    assume in_argument_1 > 0;
    Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument_1)] := Mem_T.INT4[in_ArgumentTypeArray_1 + out_Tmp_25 * 4];
    out_Tmp_28 := out_i_1;
    assume {:nonnull} in_ArgumentSizeArray_1 != 0;
    assume in_ArgumentSizeArray_1 > 0;
    assume {:nonnull} in_argument_1 != 0;
    assume in_argument_1 > 0;
    Mem_T.DataLength__ACPI_METHOD_ARGUMENT[DataLength__ACPI_METHOD_ARGUMENT(in_argument_1)] := Mem_T.INT4[in_ArgumentSizeArray_1 + out_Tmp_28 * 4];
    assume {:nonnull} in_argument_1 != 0;
    assume in_argument_1 > 0;
    goto anon62_Then, anon62_Else;

  L99:
    out_Tmp_23 := out_i_1;
    assume {:nonnull} in_ArgumentSizeArray_1 != 0;
    assume in_ArgumentSizeArray_1 > 0;
    out_argumentSize_1 := Mem_T.INT4[in_ArgumentSizeArray_1 + out_Tmp_23 * 4];
    out_Tmp_21 := out_i_1;
    assume {:nonnull} in_ArgumentArray_1 != 0;
    assume in_ArgumentArray_1 > 0;
    goto anon63_Then, anon63_Else;

  anon54_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument_1)] == 2;
    goto L99;

  anon55_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument_1)] == 1;
    goto L99;

  anon62_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument_1)] != 0;
    assume {:nonnull} in_argument_1 != 0;
    assume in_argument_1 > 0;
    goto anon55_Then, anon55_Else;

  anon55_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(in_argument_1)] != 1;
    assume {:nonnull} in_argument_1 != 0;
    assume in_argument_1 > 0;
    goto anon54_Then, anon54_Else;

  L112_dummy:
    call {:si_unique_call 1} out_i_1, out_Tmp_14, out_Tmp_19, out_argumentSize_1, out_Tmp_21, out_Tmp_23, out_Tmp_25, out_Tmp_26, out_Tmp_28 := DeviceQueryACPI_AsyncExecMethod_loop_L90(out_i_1, out_Tmp_14, out_Tmp_19, out_argumentSize_1, in_argument_1, out_Tmp_21, out_Tmp_23, out_Tmp_25, out_Tmp_26, out_Tmp_28, in_ArgumentCount_1, in_ArgumentTypeArray_1, in_ArgumentSizeArray_1, in_ArgumentArray_1);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} DeviceQueryACPI_AsyncExecMethod_loop_L90(in_i_1: int, in_Tmp_14: int, in_Tmp_19: int, in_argumentSize_1: int, in_argument_1: int, in_Tmp_21: int, in_Tmp_23: int, in_Tmp_25: int, in_Tmp_26: int, in_Tmp_28: int, in_ArgumentCount_1: int, in_ArgumentTypeArray_1: int, in_ArgumentSizeArray_1: int, in_ArgumentArray_1: int) returns (out_i_1: int, out_Tmp_14: int, out_Tmp_19: int, out_argumentSize_1: int, out_Tmp_21: int, out_Tmp_23: int, out_Tmp_25: int, out_Tmp_26: int, out_Tmp_28: int);
  modifies alloc, Mem_T.Type_unnamed_tag_28, Mem_T.DataLength__ACPI_METHOD_ARGUMENT;



implementation DeviceQueryACPI_AsyncExecMethod_loop_L30(in_i_1: int, in_Tmp_15: int, in_Tmp_17: int, in_Tmp_18: int, in_argumentSize_1: int, in_Tmp_20: int, in_Tmp_24: int, in_cmInputDataSize: int, in_Tmp_27: int, in_Tmp_29: int, in_ArgumentCount_1: int, in_ArgumentTypeArray_1: int, in_ArgumentSizeArray_1: int) returns (out_i_1: int, out_Tmp_15: int, out_Tmp_17: int, out_Tmp_18: int, out_argumentSize_1: int, out_Tmp_20: int, out_Tmp_24: int, out_cmInputDataSize: int, out_Tmp_27: int, out_Tmp_29: int)
{

  entry:
    out_i_1, out_Tmp_15, out_Tmp_17, out_Tmp_18, out_argumentSize_1, out_Tmp_20, out_Tmp_24, out_cmInputDataSize, out_Tmp_27, out_Tmp_29 := in_i_1, in_Tmp_15, in_Tmp_17, in_Tmp_18, in_argumentSize_1, in_Tmp_20, in_Tmp_24, in_cmInputDataSize, in_Tmp_27, in_Tmp_29;
    goto L30, exit;

  L30:
    goto anon43_Else;

  L41:
    out_cmInputDataSize := out_cmInputDataSize + out_argumentSize_1;
    out_i_1 := out_i_1 + 1;
    goto L41_dummy;

  L39:
    out_argumentSize_1 := 4 + out_Tmp_24;
    goto L41;

  L45:
    out_argumentSize_1 := 4 + out_Tmp_18;
    goto L41;

  anon58_Then:
    assume {:partition} Mem_T.INT4[in_ArgumentTypeArray_1 + out_Tmp_17 * 4] == 0;
    out_argumentSize_1 := 8;
    goto L41;

  anon43_Else:
    assume {:partition} in_ArgumentCount_1 > out_i_1;
    out_Tmp_17 := out_i_1;
    assume {:nonnull} in_ArgumentTypeArray_1 != 0;
    assume in_ArgumentTypeArray_1 > 0;
    goto anon58_Then, anon58_Else;

  anon59_Else:
    assume {:partition} 4 > Mem_T.INT4[in_ArgumentSizeArray_1 + out_Tmp_20 * 4];
    out_Tmp_18 := 4;
    goto L45;

  anon59_Then:
    assume {:partition} Mem_T.INT4[in_ArgumentSizeArray_1 + out_Tmp_20 * 4] >= 4;
    out_Tmp_29 := out_i_1;
    assume {:nonnull} in_ArgumentSizeArray_1 != 0;
    assume in_ArgumentSizeArray_1 > 0;
    out_Tmp_18 := Mem_T.INT4[in_ArgumentSizeArray_1 + out_Tmp_29 * 4];
    goto L45;

  anon53_Then:
    assume {:partition} Mem_T.INT4[in_ArgumentTypeArray_1 + out_Tmp_17 * 4] == 1;
    out_Tmp_20 := out_i_1;
    assume {:nonnull} in_ArgumentSizeArray_1 != 0;
    assume in_ArgumentSizeArray_1 > 0;
    goto anon59_Then, anon59_Else;

  anon58_Else:
    assume {:partition} Mem_T.INT4[in_ArgumentTypeArray_1 + out_Tmp_17 * 4] != 0;
    assume {:nonnull} in_ArgumentTypeArray_1 != 0;
    assume in_ArgumentTypeArray_1 > 0;
    goto anon53_Then, anon53_Else;

  anon60_Else:
    assume {:partition} 4 > Mem_T.INT4[in_ArgumentSizeArray_1 + out_Tmp_15 * 4];
    out_Tmp_24 := 4;
    goto L39;

  anon60_Then:
    assume {:partition} Mem_T.INT4[in_ArgumentSizeArray_1 + out_Tmp_15 * 4] >= 4;
    out_Tmp_27 := out_i_1;
    assume {:nonnull} in_ArgumentSizeArray_1 != 0;
    assume in_ArgumentSizeArray_1 > 0;
    out_Tmp_24 := Mem_T.INT4[in_ArgumentSizeArray_1 + out_Tmp_27 * 4];
    goto L39;

  anon52_Else:
    assume {:partition} Mem_T.INT4[in_ArgumentTypeArray_1 + out_Tmp_17 * 4] == 2;
    out_Tmp_15 := out_i_1;
    assume {:nonnull} in_ArgumentSizeArray_1 != 0;
    assume in_ArgumentSizeArray_1 > 0;
    goto anon60_Then, anon60_Else;

  anon53_Else:
    assume {:partition} Mem_T.INT4[in_ArgumentTypeArray_1 + out_Tmp_17 * 4] != 1;
    assume {:nonnull} in_ArgumentTypeArray_1 != 0;
    assume in_ArgumentTypeArray_1 > 0;
    goto anon52_Else;

  L41_dummy:
    call {:si_unique_call 1} out_i_1, out_Tmp_15, out_Tmp_17, out_Tmp_18, out_argumentSize_1, out_Tmp_20, out_Tmp_24, out_cmInputDataSize, out_Tmp_27, out_Tmp_29 := DeviceQueryACPI_AsyncExecMethod_loop_L30(out_i_1, out_Tmp_15, out_Tmp_17, out_Tmp_18, out_argumentSize_1, out_Tmp_20, out_Tmp_24, out_cmInputDataSize, out_Tmp_27, out_Tmp_29, in_ArgumentCount_1, in_ArgumentTypeArray_1, in_ArgumentSizeArray_1);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} DeviceQueryACPI_AsyncExecMethod_loop_L30(in_i_1: int, in_Tmp_15: int, in_Tmp_17: int, in_Tmp_18: int, in_argumentSize_1: int, in_Tmp_20: int, in_Tmp_24: int, in_cmInputDataSize: int, in_Tmp_27: int, in_Tmp_29: int, in_ArgumentCount_1: int, in_ArgumentTypeArray_1: int, in_ArgumentSizeArray_1: int) returns (out_i_1: int, out_Tmp_15: int, out_Tmp_17: int, out_Tmp_18: int, out_argumentSize_1: int, out_Tmp_20: int, out_Tmp_24: int, out_cmInputDataSize: int, out_Tmp_27: int, out_Tmp_29: int);



implementation FcFinishReset_loop_L9(in_ntStatus: int, in_Tmp_282: int, in_cylinder: int, in_driveNumber: int, in_statusRegister0: int, in_FdoExtension: int) returns (out_ntStatus: int, out_Tmp_282: int, out_driveNumber: int)
{

  entry:
    out_ntStatus, out_Tmp_282, out_driveNumber := in_ntStatus, in_Tmp_282, in_driveNumber;
    goto L9, exit;

  L9:
    assume {:CounterLoop 4} {:Counter "driveNumber"} true;
    goto anon11_Else;

  L19:
    out_driveNumber := out_driveNumber + 1;
    goto L19_dummy;

  anon15_Else:
    assume {:partition} out_ntStatus >= 0;
    call out_ntStatus := FcGetByte(in_cylinder, in_FdoExtension, 1);
    goto L19;

  anon15_Then:
    assume {:partition} 0 > out_ntStatus;
    goto L19;

  anon14_Then:
    assume {:partition} 0 > out_ntStatus;
    goto L19;

  L13:
    goto anon14_Then, anon14_Else;

  anon13_Else:
    assume {:partition} out_driveNumber != 0;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    out_Tmp_282 := Mem_T.OpCode__COMMAND_TABLE[OpCode__COMMAND_TABLE(CommandTable + 12 * 28)];
    call out_ntStatus := FcSendByte(out_Tmp_282, in_FdoExtension, 1);
    goto L13;

  anon13_Then:
    assume {:partition} out_driveNumber == 0;
    goto L13;

  anon12_Else:
    assume {:partition} out_ntStatus >= 0;
    goto anon13_Then, anon13_Else;

  anon11_Else:
    assume {:partition} 4 > out_driveNumber;
    goto anon12_Else;

  anon14_Else:
    assume {:partition} out_ntStatus >= 0;
    call out_ntStatus := FcGetByte(in_statusRegister0, in_FdoExtension, 1);
    goto anon15_Then, anon15_Else;

  L19_dummy:
    call {:si_unique_call 1} out_ntStatus, out_Tmp_282, out_driveNumber := FcFinishReset_loop_L9(out_ntStatus, out_Tmp_282, in_cylinder, out_driveNumber, in_statusRegister0, in_FdoExtension);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FcFinishReset_loop_L9(in_ntStatus: int, in_Tmp_282: int, in_cylinder: int, in_driveNumber: int, in_statusRegister0: int, in_FdoExtension: int) returns (out_ntStatus: int, out_Tmp_282: int, out_driveNumber: int);
  modifies Mem_T.INT4, Mem_T.HardwareFailed__FDC_FDO_EXTENSION;



implementation FdcQueryDeviceRelations_loop_L123(in_ntStatus_2: int, in_InterfaceType: int) returns (out_ntStatus_2: int, out_InterfaceType: int)
{

  entry:
    out_ntStatus_2, out_InterfaceType := in_ntStatus_2, in_InterfaceType;
    goto L123, exit;

  L123:
    assume {:CounterLoop 18} {:Counter "InterfaceType"} true;
    goto anon53_Else;

  L134:
    out_InterfaceType := out_InterfaceType + 1;
    goto L134_dummy;

  anon54_Else:
    assume {:partition} out_ntStatus_2 >= 0;
    goto L134;

  anon55_Then:
    assume {:partition} out_ntStatus_2 == -1073741772;
    goto L134;

  anon54_Then:
    assume {:partition} 0 > out_ntStatus_2;
    goto anon55_Then;

  anon53_Else:
    assume {:partition} 18 > out_InterfaceType;
    call out_ntStatus_2 := IoQueryDeviceDescription(0, 0, 0, 0, 0, 0, li2bplFunctionConstant217, 0);
    goto anon54_Then, anon54_Else;

  L134_dummy:
    havoc out_InterfaceType;
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcQueryDeviceRelations_loop_L123(in_ntStatus_2: int, in_InterfaceType: int) returns (out_ntStatus_2: int, out_InterfaceType: int);



implementation FdcQueryDeviceRelations_loop_L80(in_pdoExtension: int, in_relations: int, in_Tmp_290: int, in_sdv_143: int, in_Tmp_291: int, in_Tmp_292: int, in_relationCount: int, in_entry: int, in_vslice_dummy_var_74: int) returns (out_pdoExtension: int, out_Tmp_290: int, out_sdv_143: int, out_Tmp_291: int, out_Tmp_292: int, out_relationCount: int, out_entry: int, out_vslice_dummy_var_74: int)
{

  entry:
    out_pdoExtension, out_Tmp_290, out_sdv_143, out_Tmp_291, out_Tmp_292, out_relationCount, out_entry, out_vslice_dummy_var_74 := in_pdoExtension, in_Tmp_290, in_sdv_143, in_Tmp_291, in_Tmp_292, in_relationCount, in_entry, in_vslice_dummy_var_74;
    goto L80, exit;

  L80:
    goto anon52_Else;

  L88:
    assume {:nonnull} out_entry != 0;
    assume out_entry > 0;
    out_entry := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(out_entry)];
    goto L88_dummy;

  anon62_Else:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(out_pdoExtension)] != 0;
    goto L88;

  anon62_Then:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(out_pdoExtension)] == 0;
    out_Tmp_292 := out_relationCount;
    out_relationCount := out_relationCount + 1;
    out_Tmp_291 := out_Tmp_292;
    assume {:nonnull} in_relations != 0;
    assume in_relations > 0;
    out_Tmp_290 := Mem_T.PP_DEVICE_OBJECT[Objects__DEVICE_RELATIONS(in_relations)];
    assume {:nonnull} out_Tmp_290 != 0;
    assume out_Tmp_290 > 0;
    assume {:nonnull} out_pdoExtension != 0;
    assume out_pdoExtension > 0;
    Mem_T.P_DEVICE_OBJECT[out_Tmp_290 + out_Tmp_291 * 4] := Mem_T.Self__FDC_EXTENSION_HEADER[Self__FDC_EXTENSION_HEADER(out_pdoExtension)];
    call out_vslice_dummy_var_74 := sdv_ObReferenceObject(0);
    goto L88;

  anon52_Else:
    call out_sdv_143 := sdv_containing_record(out_entry, 20);
    out_pdoExtension := out_sdv_143;
    assume {:nonnull} out_pdoExtension != 0;
    assume out_pdoExtension > 0;
    goto anon62_Then, anon62_Else;

  L88_dummy:
    call {:si_unique_call 1} out_pdoExtension, out_Tmp_290, out_sdv_143, out_Tmp_291, out_Tmp_292, out_relationCount, out_entry, out_vslice_dummy_var_74 := FdcQueryDeviceRelations_loop_L80(out_pdoExtension, in_relations, out_Tmp_290, out_sdv_143, out_Tmp_291, out_Tmp_292, out_relationCount, out_entry, out_vslice_dummy_var_74);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcQueryDeviceRelations_loop_L80(in_pdoExtension: int, in_relations: int, in_Tmp_290: int, in_sdv_143: int, in_Tmp_291: int, in_Tmp_292: int, in_relationCount: int, in_entry: int, in_vslice_dummy_var_74: int) returns (out_pdoExtension: int, out_Tmp_290: int, out_sdv_143: int, out_Tmp_291: int, out_Tmp_292: int, out_relationCount: int, out_entry: int, out_vslice_dummy_var_74: int);
  modifies Mem_T.P_DEVICE_OBJECT;



implementation FcGetByte_loop_L26(in_i_2: int, in_byteRead: int, in_Tmp_311: int, in_sdv_161: int, in_ByteToGet: int, in_boogieTmp: int, in_vslice_dummy_var_75: int) returns (out_i_2: int, out_byteRead: int, out_Tmp_311: int, out_sdv_161: int, out_boogieTmp: int, out_vslice_dummy_var_75: int)
{

  entry:
    out_i_2, out_byteRead, out_Tmp_311, out_sdv_161, out_boogieTmp, out_vslice_dummy_var_75 := in_i_2, in_byteRead, in_Tmp_311, in_sdv_161, in_boogieTmp, in_vslice_dummy_var_75;
    goto L26, exit;

  L26:
    goto anon20_Else;

  anon24_Else:
    assume {:partition} out_Tmp_311 == 192;
    assume {:nonnull} in_ByteToGet != 0;
    assume in_ByteToGet > 0;
    call out_boogieTmp := corral_nondet();
    Mem_T.INT4[in_ByteToGet] := out_boogieTmp;
    out_byteRead := 1;
    goto anon24_Else_dummy;

  anon21_Else:
    assume {:partition} 5 > out_i_2;
    call out_vslice_dummy_var_75 := KeDelayExecutionThread(0, 0, 0);
    out_i_2 := out_i_2 + 1;
    call out_sdv_161 := corral_nondet();
    out_Tmp_311 := BAND(out_sdv_161, BOR(64, 128));
    goto anon24_Then, anon24_Else;

  anon20_Else:
    assume {:partition} out_byteRead == 0;
    goto anon21_Else;

  anon24_Else_dummy:
    goto L_BAF_0;

  anon24_Then:
    assume {:partition} out_Tmp_311 != 192;
    goto anon24_Then_dummy;

  anon24_Then_dummy:
    goto L_BAF_0;

  exit:
    return;

  L_BAF_0:
    havoc out_i_2;
    return;
}



procedure {:LoopProcedure} FcGetByte_loop_L26(in_i_2: int, in_byteRead: int, in_Tmp_311: int, in_sdv_161: int, in_ByteToGet: int, in_boogieTmp: int, in_vslice_dummy_var_75: int) returns (out_i_2: int, out_byteRead: int, out_Tmp_311: int, out_sdv_161: int, out_boogieTmp: int, out_vslice_dummy_var_75: int);
  modifies Mem_T.INT4;



implementation FcGetByte_loop_L7(in_i_2: int, in_Tmp_310: int, in_byteRead: int, in_sdv_158: int, in_ByteToGet: int, in_boogieTmp: int) returns (out_i_2: int, out_Tmp_310: int, out_byteRead: int, out_sdv_158: int, out_boogieTmp: int)
{

  entry:
    out_i_2, out_Tmp_310, out_byteRead, out_sdv_158, out_boogieTmp := in_i_2, in_Tmp_310, in_byteRead, in_sdv_158, in_boogieTmp;
    goto L7, exit;

  L7:
    call out_sdv_158 := corral_nondet();
    out_Tmp_310 := BAND(out_sdv_158, BOR(64, 128));
    goto anon22_Then, anon22_Else;

  anon17_Then:
    assume {:partition} out_i_2 < 500;
    goto anon17_Then_dummy;

  anon23_Then:
    assume {:partition} out_byteRead == 0;
    goto anon17_Then;

  L20:
    out_i_2 := out_i_2 + 1;
    goto anon23_Then;

  anon22_Else:
    assume {:partition} out_Tmp_310 != 192;
    goto L20;

  anon22_Then:
    assume {:partition} out_Tmp_310 == 192;
    assume {:nonnull} in_ByteToGet != 0;
    assume in_ByteToGet > 0;
    call out_boogieTmp := corral_nondet();
    Mem_T.INT4[in_ByteToGet] := out_boogieTmp;
    out_byteRead := 1;
    goto L20;

  anon17_Then_dummy:
    havoc out_i_2;
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FcGetByte_loop_L7(in_i_2: int, in_Tmp_310: int, in_byteRead: int, in_sdv_158: int, in_ByteToGet: int, in_boogieTmp: int) returns (out_i_2: int, out_Tmp_310: int, out_byteRead: int, out_sdv_158: int, out_boogieTmp: int);
  modifies Mem_T.INT4;



implementation FcFinishCommand_loop_L14(in_i_3: int, in_Tmp_319: int, in_Tmp_321: int, in_Tmp_323: int, in_ntStatus_5: int, in_Tmp_327: int, in_Command: int, in_FdoExtension_3: int, in_FifoOutBuffer: int, in_AllowLongDelay_1: int) returns (out_i_3: int, out_Tmp_319: int, out_Tmp_321: int, out_Tmp_323: int, out_ntStatus_5: int, out_Tmp_327: int)
{

  entry:
    out_i_3, out_Tmp_319, out_Tmp_321, out_Tmp_323, out_ntStatus_5, out_Tmp_327 := in_i_3, in_Tmp_319, in_Tmp_321, in_Tmp_323, in_ntStatus_5, in_Tmp_327;
    goto L14, exit;

  L14:
    out_Tmp_321 := BAND(in_Command, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    out_Tmp_327 := out_Tmp_321;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon13_Else;

  anon11_Else:
    assume {:partition} out_ntStatus_5 >= 0;
    out_Tmp_319 := out_i_3;
    out_Tmp_323 := in_FifoOutBuffer + out_Tmp_319 * 4;
    call out_ntStatus_5 := FcGetByte(out_Tmp_323, in_FdoExtension_3, in_AllowLongDelay_1);
    out_i_3 := out_i_3 + 1;
    goto anon11_Else_dummy;

  anon13_Else:
    assume {:partition} Mem_T.NumberOfResultBytes__COMMAND_TABLE[NumberOfResultBytes__COMMAND_TABLE(CommandTable + out_Tmp_327 * 28)] > out_i_3;
    goto anon11_Else;

  anon11_Else_dummy:
    call {:si_unique_call 1} out_i_3, out_Tmp_319, out_Tmp_321, out_Tmp_323, out_ntStatus_5, out_Tmp_327 := FcFinishCommand_loop_L14(out_i_3, out_Tmp_319, out_Tmp_321, out_Tmp_323, out_ntStatus_5, out_Tmp_327, in_Command, in_FdoExtension_3, in_FifoOutBuffer, in_AllowLongDelay_1);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FcFinishCommand_loop_L14(in_i_3: int, in_Tmp_319: int, in_Tmp_321: int, in_Tmp_323: int, in_ntStatus_5: int, in_Tmp_327: int, in_Command: int, in_FdoExtension_3: int, in_FifoOutBuffer: int, in_AllowLongDelay_1: int) returns (out_i_3: int, out_Tmp_319: int, out_Tmp_321: int, out_Tmp_323: int, out_ntStatus_5: int, out_Tmp_327: int);
  modifies Mem_T.INT4, Mem_T.HardwareFailed__FDC_FDO_EXTENSION;



implementation FcSendByte_loop_L27(in_i_4: int, in_Tmp_335: int, in_sdv_172: int, in_byteWritten: int, in_vslice_dummy_var_78: int) returns (out_i_4: int, out_Tmp_335: int, out_sdv_172: int, out_byteWritten: int, out_vslice_dummy_var_78: int)
{

  entry:
    out_i_4, out_Tmp_335, out_sdv_172, out_byteWritten, out_vslice_dummy_var_78 := in_i_4, in_Tmp_335, in_sdv_172, in_byteWritten, in_vslice_dummy_var_78;
    goto L27, exit;

  L27:
    goto anon22_Else;

  anon27_Else:
    assume {:partition} out_Tmp_335 == 128;
    out_byteWritten := 1;
    goto anon27_Else_dummy;

  anon23_Else:
    assume {:partition} 5 > out_i_4;
    call out_vslice_dummy_var_78 := KeDelayExecutionThread(0, 0, 0);
    out_i_4 := out_i_4 + 1;
    call out_sdv_172 := corral_nondet();
    out_Tmp_335 := BAND(out_sdv_172, BOR(64, 128));
    goto anon27_Then, anon27_Else;

  anon22_Else:
    assume {:partition} out_byteWritten == 0;
    goto anon23_Else;

  anon27_Else_dummy:
    goto L_BAF_1;

  anon27_Then:
    assume {:partition} out_Tmp_335 != 128;
    goto anon27_Then_dummy;

  anon27_Then_dummy:
    goto L_BAF_1;

  exit:
    return;

  L_BAF_1:
    havoc out_i_4;
    return;
}



procedure {:LoopProcedure} FcSendByte_loop_L27(in_i_4: int, in_Tmp_335: int, in_sdv_172: int, in_byteWritten: int, in_vslice_dummy_var_78: int) returns (out_i_4: int, out_Tmp_335: int, out_sdv_172: int, out_byteWritten: int, out_vslice_dummy_var_78: int);



implementation FcSendByte_loop_L8(in_i_4: int, in_sdv_170: int, in_Tmp_336: int, in_byteWritten: int) returns (out_i_4: int, out_sdv_170: int, out_Tmp_336: int, out_byteWritten: int)
{

  entry:
    out_i_4, out_sdv_170, out_Tmp_336, out_byteWritten := in_i_4, in_sdv_170, in_Tmp_336, in_byteWritten;
    goto L8, exit;

  L8:
    call out_sdv_170 := corral_nondet();
    out_Tmp_336 := BAND(out_sdv_170, BOR(64, 128));
    goto anon25_Then, anon25_Else;

  anon19_Then:
    assume {:partition} out_i_4 < 500;
    goto anon19_Then_dummy;

  anon26_Then:
    assume {:partition} out_byteWritten == 0;
    goto anon19_Then;

  L21:
    out_i_4 := out_i_4 + 1;
    goto anon26_Then;

  anon25_Else:
    assume {:partition} out_Tmp_336 != 128;
    goto L21;

  anon25_Then:
    assume {:partition} out_Tmp_336 == 128;
    out_byteWritten := 1;
    goto L21;

  anon19_Then_dummy:
    havoc out_i_4;
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FcSendByte_loop_L8(in_i_4: int, in_sdv_170: int, in_Tmp_336: int, in_byteWritten: int) returns (out_i_4: int, out_sdv_170: int, out_Tmp_336: int, out_byteWritten: int);



implementation FdcFilterResourceRequirements_loop_L87(in_ioResourceDescriptorIn: int, in_j: int, in_ioPortInfo: int, in_boogieTmp: int) returns (out_j: int, out_boogieTmp: int)
{

  entry:
    out_j, out_boogieTmp := in_j, in_boogieTmp;
    goto L87, exit;

  L87:
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    goto anon83_Else;

  anon83_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)))] > out_j;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    assume {:nonnull} in_ioPortInfo != 0;
    assume in_ioPortInfo > 0;
    call out_boogieTmp := corral_nondet();
    Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(in_ioPortInfo)] := out_boogieTmp;
    out_j := out_j + 1;
    goto anon83_Else_dummy;

  anon83_Else_dummy:
    havoc out_j;
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L87(in_ioResourceDescriptorIn: int, in_j: int, in_ioPortInfo: int, in_boogieTmp: int) returns (out_j: int, out_boogieTmp: int);
  modifies Mem_T.Map__IO_PORT_INFO;



implementation FdcFilterResourceRequirements_loop_L105(in_ioResourceDescriptorIn: int, in_j: int, in_ioPortInfo: int, in_boogieTmp: int) returns (out_j: int, out_boogieTmp: int)
{

  entry:
    out_j, out_boogieTmp := in_j, in_boogieTmp;
    goto L105, exit;

  L105:
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    goto anon84_Else;

  anon84_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)))] > out_j;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    assume {:nonnull} in_ioPortInfo != 0;
    assume in_ioPortInfo > 0;
    call out_boogieTmp := corral_nondet();
    Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(in_ioPortInfo)] := out_boogieTmp;
    out_j := out_j + 1;
    goto anon84_Else_dummy;

  anon84_Else_dummy:
    havoc out_j;
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L105(in_ioResourceDescriptorIn: int, in_j: int, in_ioPortInfo: int, in_boogieTmp: int) returns (out_j: int, out_boogieTmp: int);
  modifies Mem_T.Map__IO_PORT_INFO;



implementation FdcFilterResourceRequirements_loop_L76(in_Tmp_341: int, in_ioResourceDescriptorIn: int, in_links: int, in_sdv_183: int, in_ioPortInfo: int) returns (out_Tmp_341: int, out_links: int, out_sdv_183: int, out_ioPortInfo: int)
{

  entry:
    out_Tmp_341, out_links, out_sdv_183, out_ioPortInfo := in_Tmp_341, in_links, in_sdv_183, in_ioPortInfo;
    goto L76, exit;

  L76:
    goto anon81_Else;

  anon103_Then:
    assume {:partition} Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(out_ioPortInfo))] != out_Tmp_341;
    assume {:nonnull} out_links != 0;
    assume out_links > 0;
    out_links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(out_links)];
    goto anon103_Then_dummy;

  anon81_Else:
    call out_sdv_183 := sdv_containing_record(out_links, 12);
    out_ioPortInfo := out_sdv_183;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    out_Tmp_341 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn))))], BNOT(BOR(BOR(1, 2), 4)));
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    goto anon103_Then;

  anon103_Then_dummy:
    call {:si_unique_call 1} out_Tmp_341, out_links, out_sdv_183, out_ioPortInfo := FdcFilterResourceRequirements_loop_L76(out_Tmp_341, in_ioResourceDescriptorIn, out_links, out_sdv_183, out_ioPortInfo);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L76(in_Tmp_341: int, in_ioResourceDescriptorIn: int, in_links: int, in_sdv_183: int, in_ioPortInfo: int) returns (out_Tmp_341: int, out_links: int, out_sdv_183: int, out_ioPortInfo: int);



implementation FdcFilterResourceRequirements_loop_L131(in_newPortMask: int, in_newDescriptors: int) returns (out_newPortMask: int, out_newDescriptors: int)
{

  entry:
    out_newPortMask, out_newDescriptors := in_newPortMask, in_newDescriptors;
    goto L131, exit;

  L131:
    goto anon90_Else;

  L135:
    call out_newPortMask := corral_nondet();
    goto L135_dummy;

  anon91_Else:
    assume {:partition} BAND(out_newPortMask, 1) != 0;
    out_newDescriptors := out_newDescriptors + 1;
    goto L135;

  anon91_Then:
    assume {:partition} BAND(out_newPortMask, 1) == 0;
    goto L135;

  anon90_Else:
    assume {:partition} out_newPortMask > 0;
    goto anon91_Then, anon91_Else;

  L135_dummy:
    havoc out_newDescriptors;
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L131(in_newPortMask: int, in_newDescriptors: int) returns (out_newPortMask: int, out_newDescriptors: int);



implementation FdcFilterResourceRequirements_loop_L179(in_i_5: int, in_newPortMask: int, in_ioResourceListOut: int, in_resourceRequirementsOut: int, in_ioPortInfo: int, in_ioResourceDescriptorOut: int) returns (out_i_5: int, out_newPortMask: int)
{

  entry:
    out_i_5, out_newPortMask := in_i_5, in_newPortMask;
    goto L179, exit;

  L179:
    goto anon94_Else;

  L182:
    call out_newPortMask := corral_nondet();
    out_i_5 := out_i_5 + 1;
    goto L182_dummy;

  anon95_Else:
    assume {:partition} BAND(out_newPortMask, 1) != 0;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Option__IO_RESOURCE_DESCRIPTOR[Option__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR[ShareDisposition__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Flags__IO_RESOURCE_DESCRIPTOR[Flags__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)))] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)))] := 1;
    assume {:nonnull} in_ioPortInfo != 0;
    assume in_ioPortInfo > 0;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(BaseAddress__IO_PORT_INFO(in_ioPortInfo))] + out_i_5;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut))))];
    assume {:nonnull} in_ioResourceListOut != 0;
    assume in_ioResourceListOut > 0;
    Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(in_ioResourceListOut)] := Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(in_ioResourceListOut)] + 1;
    assume {:nonnull} in_resourceRequirementsOut != 0;
    assume in_resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(in_resourceRequirementsOut)] := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(in_resourceRequirementsOut)] + 32;
    goto L182;

  anon95_Then:
    assume {:partition} BAND(out_newPortMask, 1) == 0;
    goto L182;

  anon94_Else:
    assume {:partition} out_newPortMask != 0;
    goto anon95_Then, anon95_Else;

  L182_dummy:
    call {:si_unique_call 1} out_i_5, out_newPortMask := FdcFilterResourceRequirements_loop_L179(out_i_5, out_newPortMask, in_ioResourceListOut, in_resourceRequirementsOut, in_ioPortInfo, in_ioResourceDescriptorOut);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L179(in_i_5: int, in_newPortMask: int, in_ioResourceListOut: int, in_resourceRequirementsOut: int, in_ioPortInfo: int, in_ioResourceDescriptorOut: int) returns (out_i_5: int, out_newPortMask: int);
  modifies Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST;



implementation FdcFilterResourceRequirements_loop_L204(in_Tmp_339: int, in_Tmp_342: int, in_Tmp_343: int, in_Tmp_344: int, in_ioResourceListOut: int, in_in: int, in_Tmp_346: int, in_ioResourceListIn: int, in_Tmp_350: int, in_Tmp_351: int, in_resourceRequirementsOut: int, in_Tmp_353: int, in_out: int, in_Tmp_355: int, in_Tmp_356: int, in_Tmp_358: int) returns (out_Tmp_339: int, out_Tmp_342: int, out_Tmp_343: int, out_Tmp_344: int, out_in: int, out_Tmp_346: int, out_Tmp_350: int, out_Tmp_351: int, out_Tmp_353: int, out_out: int, out_Tmp_355: int, out_Tmp_356: int, out_Tmp_358: int)
{

  entry:
    out_Tmp_339, out_Tmp_342, out_Tmp_343, out_Tmp_344, out_in, out_Tmp_346, out_Tmp_350, out_Tmp_351, out_Tmp_353, out_out, out_Tmp_355, out_Tmp_356, out_Tmp_358 := in_Tmp_339, in_Tmp_342, in_Tmp_343, in_Tmp_344, in_in, in_Tmp_346, in_Tmp_350, in_Tmp_351, in_Tmp_353, in_out, in_Tmp_355, in_Tmp_356, in_Tmp_358;
    goto L204, exit;

  L204:
    out_Tmp_350 := out_in;
    assume {:nonnull} in_ioResourceListIn != 0;
    assume in_ioResourceListIn > 0;
    out_Tmp_355 := Mem_T.Descriptors__IO_RESOURCE_LIST[Descriptors__IO_RESOURCE_LIST(in_ioResourceListIn)];
    assume {:nonnull} out_Tmp_355 != 0;
    assume out_Tmp_355 > 0;
    goto anon109_Then, anon109_Else;

  anon96_Else:
    assume {:partition} Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(in_ioResourceListIn)] > out_in;
    goto anon96_Else_dummy;

  L209:
    assume {:nonnull} in_ioResourceListIn != 0;
    assume in_ioResourceListIn > 0;
    goto anon96_Else;

  L206:
    out_Tmp_343 := out_out;
    out_out := out_out + 1;
    out_Tmp_339 := out_Tmp_343;
    assume {:nonnull} in_ioResourceListOut != 0;
    assume in_ioResourceListOut > 0;
    out_Tmp_351 := Mem_T.Descriptors__IO_RESOURCE_LIST[Descriptors__IO_RESOURCE_LIST(in_ioResourceListOut)];
    out_Tmp_344 := out_in;
    out_in := out_in + 1;
    out_Tmp_346 := out_Tmp_344;
    assume {:nonnull} in_ioResourceListIn != 0;
    assume in_ioResourceListIn > 0;
    out_Tmp_358 := Mem_T.Descriptors__IO_RESOURCE_LIST[Descriptors__IO_RESOURCE_LIST(in_ioResourceListIn)];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Option__IO_RESOURCE_DESCRIPTOR[Option__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)] := Mem_T.Option__IO_RESOURCE_DESCRIPTOR[Option__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)] := Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR[ShareDisposition__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)] := Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR[ShareDisposition__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR[Spare1__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)] := Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR[Spare1__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Flags__IO_RESOURCE_DESCRIPTOR[Flags__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)] := Mem_T.Flags__IO_RESOURCE_DESCRIPTOR[Flags__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR[Spare2__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)] := Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR[Spare2__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Memory_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.MinimumVector_unnamed_tag_59[MinimumVector_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.MinimumVector_unnamed_tag_59[MinimumVector_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.MaximumVector_unnamed_tag_59[MaximumVector_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.MaximumVector_unnamed_tag_59[MaximumVector_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.AffinityPolicy_unnamed_tag_59[AffinityPolicy_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.AffinityPolicy_unnamed_tag_59[AffinityPolicy_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.PriorityPolicy_unnamed_tag_59[PriorityPolicy_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.PriorityPolicy_unnamed_tag_59[PriorityPolicy_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.TargetedProcessors_unnamed_tag_59[TargetedProcessors_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.TargetedProcessors_unnamed_tag_59[TargetedProcessors_unnamed_tag_59(Interrupt_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.MinimumChannel_unnamed_tag_60[MinimumChannel_unnamed_tag_60(Dma_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.MinimumChannel_unnamed_tag_60[MinimumChannel_unnamed_tag_60(Dma_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.MaximumChannel_unnamed_tag_60[MaximumChannel_unnamed_tag_60(Dma_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.MaximumChannel_unnamed_tag_60[MaximumChannel_unnamed_tag_60(Dma_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.RequestLine_unnamed_tag_61[RequestLine_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.RequestLine_unnamed_tag_61[RequestLine_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Reserved_unnamed_tag_61[Reserved_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Reserved_unnamed_tag_61[Reserved_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Channel_unnamed_tag_61[Channel_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Channel_unnamed_tag_61[Channel_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.TransferWidth_unnamed_tag_61[TransferWidth_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.TransferWidth_unnamed_tag_61[TransferWidth_unnamed_tag_61(DmaV3_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Generic_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Data_unnamed_tag_50[Data_unnamed_tag_50(DevicePrivate_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Data_unnamed_tag_50[Data_unnamed_tag_50(DevicePrivate_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.MinBusNumber_unnamed_tag_62[MinBusNumber_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.MinBusNumber_unnamed_tag_62[MinBusNumber_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.MaxBusNumber_unnamed_tag_62[MaxBusNumber_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.MaxBusNumber_unnamed_tag_62[MaxBusNumber_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Reserved_unnamed_tag_62[Reserved_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Reserved_unnamed_tag_62[Reserved_unnamed_tag_62(BusNumber_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Priority_unnamed_tag_63[Priority_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Priority_unnamed_tag_63[Priority_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Reserved1_unnamed_tag_63[Reserved1_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Reserved1_unnamed_tag_63[Reserved1_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Reserved2_unnamed_tag_63[Reserved2_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Reserved2_unnamed_tag_63[Reserved2_unnamed_tag_63(ConfigData_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Length40_unnamed_tag_64[Length40_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Length40_unnamed_tag_64[Length40_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Alignment40_unnamed_tag_64[Alignment40_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Alignment40_unnamed_tag_64[Alignment40_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_64(Memory40_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Length48_unnamed_tag_65[Length48_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Length48_unnamed_tag_65[Length48_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Alignment48_unnamed_tag_65[Alignment48_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Alignment48_unnamed_tag_65[Alignment48_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_65(Memory48_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Length64_unnamed_tag_66[Length64_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Length64_unnamed_tag_66[Length64_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Alignment64_unnamed_tag_66[Alignment64_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Alignment64_unnamed_tag_66[Alignment64_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.LowPart__LUID[LowPart__LUID(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.HighPart__LUID[HighPart__LUID(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_66(Memory64_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420))))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Class_unnamed_tag_56[Class_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Class_unnamed_tag_56[Class_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Type_unnamed_tag_56[Type_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Type_unnamed_tag_56[Type_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Reserved1_unnamed_tag_56[Reserved1_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Reserved1_unnamed_tag_56[Reserved1_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.Reserved2_unnamed_tag_56[Reserved2_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.Reserved2_unnamed_tag_56[Reserved2_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.IdLowPart_unnamed_tag_56[IdLowPart_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.IdLowPart_unnamed_tag_56[IdLowPart_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} out_Tmp_351 != 0;
    assume out_Tmp_351 > 0;
    assume {:nonnull} out_Tmp_358 != 0;
    assume out_Tmp_358 > 0;
    Mem_T.IdHighPart_unnamed_tag_56[IdHighPart_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_351 + out_Tmp_339 * 420)))] := Mem_T.IdHighPart_unnamed_tag_56[IdHighPart_unnamed_tag_56(Connection_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_358 + out_Tmp_346 * 420)))];
    assume {:nonnull} in_ioResourceListOut != 0;
    assume in_ioResourceListOut > 0;
    Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(in_ioResourceListOut)] := Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(in_ioResourceListOut)] + 1;
    assume {:nonnull} in_resourceRequirementsOut != 0;
    assume in_resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(in_resourceRequirementsOut)] := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(in_resourceRequirementsOut)] + 32;
    goto L209;

  anon110_Else:
    assume {:partition} out_Tmp_356 == 3;
    out_in := out_in + 1;
    goto L209;

  anon109_Then:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(out_Tmp_355 + out_Tmp_350 * 420)] == 1;
    out_Tmp_353 := out_in;
    assume {:nonnull} in_ioResourceListIn != 0;
    assume in_ioResourceListIn > 0;
    out_Tmp_342 := Mem_T.Descriptors__IO_RESOURCE_LIST[Descriptors__IO_RESOURCE_LIST(in_ioResourceListIn)];
    assume {:nonnull} out_Tmp_342 != 0;
    assume out_Tmp_342 > 0;
    out_Tmp_356 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(out_Tmp_342 + out_Tmp_353 * 420))))], BOR(BOR(1, 2), 4));
    goto anon110_Then, anon110_Else;

  anon109_Else:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(out_Tmp_355 + out_Tmp_350 * 420)] != 1;
    goto L206;

  anon110_Then:
    assume {:partition} out_Tmp_356 != 3;
    goto L206;

  anon96_Else_dummy:
    call {:si_unique_call 1} out_Tmp_339, out_Tmp_342, out_Tmp_343, out_Tmp_344, out_in, out_Tmp_346, out_Tmp_350, out_Tmp_351, out_Tmp_353, out_out, out_Tmp_355, out_Tmp_356, out_Tmp_358 := FdcFilterResourceRequirements_loop_L204(out_Tmp_339, out_Tmp_342, out_Tmp_343, out_Tmp_344, in_ioResourceListOut, out_in, out_Tmp_346, in_ioResourceListIn, out_Tmp_350, out_Tmp_351, in_resourceRequirementsOut, out_Tmp_353, out_out, out_Tmp_355, out_Tmp_356, out_Tmp_358);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L204(in_Tmp_339: int, in_Tmp_342: int, in_Tmp_343: int, in_Tmp_344: int, in_ioResourceListOut: int, in_in: int, in_Tmp_346: int, in_ioResourceListIn: int, in_Tmp_350: int, in_Tmp_351: int, in_resourceRequirementsOut: int, in_Tmp_353: int, in_out: int, in_Tmp_355: int, in_Tmp_356: int, in_Tmp_358: int) returns (out_Tmp_339: int, out_Tmp_342: int, out_Tmp_343: int, out_Tmp_344: int, out_in: int, out_Tmp_346: int, out_Tmp_350: int, out_Tmp_351: int, out_Tmp_353: int, out_out: int, out_Tmp_355: int, out_Tmp_356: int, out_Tmp_358: int);
  modifies Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Spare1__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Spare2__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.MinimumVector_unnamed_tag_59, Mem_T.MaximumVector_unnamed_tag_59, Mem_T.AffinityPolicy_unnamed_tag_59, Mem_T.PriorityPolicy_unnamed_tag_59, Mem_T.TargetedProcessors_unnamed_tag_59, Mem_T.MinimumChannel_unnamed_tag_60, Mem_T.MaximumChannel_unnamed_tag_60, Mem_T.RequestLine_unnamed_tag_61, Mem_T.Reserved_unnamed_tag_61, Mem_T.Channel_unnamed_tag_61, Mem_T.TransferWidth_unnamed_tag_61, Mem_T.Data_unnamed_tag_50, Mem_T.MinBusNumber_unnamed_tag_62, Mem_T.MaxBusNumber_unnamed_tag_62, Mem_T.Reserved_unnamed_tag_62, Mem_T.Priority_unnamed_tag_63, Mem_T.Reserved1_unnamed_tag_63, Mem_T.Reserved2_unnamed_tag_63, Mem_T.Length40_unnamed_tag_64, Mem_T.Alignment40_unnamed_tag_64, Mem_T.Length48_unnamed_tag_65, Mem_T.Alignment48_unnamed_tag_65, Mem_T.Length64_unnamed_tag_66, Mem_T.Alignment64_unnamed_tag_66, Mem_T.Class_unnamed_tag_56, Mem_T.Type_unnamed_tag_56, Mem_T.Reserved1_unnamed_tag_56, Mem_T.Reserved2_unnamed_tag_56, Mem_T.IdLowPart_unnamed_tag_56, Mem_T.IdHighPart_unnamed_tag_56, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST;



implementation FdcFilterResourceRequirements_loop_L214(in_resourceRequirementsIn: int, in_ioResourceListOut: int, in_in: int, in_ioResourceListIn: int, in_listSize: int, in_resourceRequirementsOut: int) returns (out_ioResourceListOut: int, out_in: int, out_ioResourceListIn: int, out_listSize: int)
{

  entry:
    out_ioResourceListOut, out_in, out_ioResourceListIn, out_listSize := in_ioResourceListOut, in_in, in_ioResourceListIn, in_listSize;
    goto L214, exit;

  L214:
    assume {:nonnull} in_resourceRequirementsIn != 0;
    assume in_resourceRequirementsIn > 0;
    goto anon97_Else;

  anon97_Else:
    assume {:partition} Mem_T.AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST[AlternativeLists__IO_RESOURCE_REQUIREMENTS_LIST(in_resourceRequirementsIn)] > out_in;
    assume {:nonnull} out_ioResourceListIn != 0;
    assume out_ioResourceListIn > 0;
    out_listSize := 40 + (Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(out_ioResourceListIn)] - 1) * 32;
    call sdv_RtlCopyMemory(0, 0, out_listSize);
    out_ioResourceListOut := out_ioResourceListOut + out_listSize;
    out_ioResourceListIn := out_ioResourceListIn + out_listSize;
    assume {:nonnull} in_resourceRequirementsOut != 0;
    assume in_resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(in_resourceRequirementsOut)] := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(in_resourceRequirementsOut)] + out_listSize;
    out_in := out_in + 1;
    goto anon97_Else_dummy;

  anon97_Else_dummy:
    call {:si_unique_call 1} out_ioResourceListOut, out_in, out_ioResourceListIn, out_listSize := FdcFilterResourceRequirements_loop_L214(in_resourceRequirementsIn, out_ioResourceListOut, out_in, out_ioResourceListIn, out_listSize, in_resourceRequirementsOut);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L214(in_resourceRequirementsIn: int, in_ioResourceListOut: int, in_in: int, in_ioResourceListIn: int, in_listSize: int, in_resourceRequirementsOut: int) returns (out_ioResourceListOut: int, out_in: int, out_ioResourceListIn: int, out_listSize: int);
  modifies alloc, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST;



implementation FdcFilterResourceRequirements_loop_L171(in_i_5: int, in_newPortMask: int, in_ioResourceListOut: int, in_sdv_180: int, in_links: int, in_resourceRequirementsOut: int, in_ioPortInfo: int, in_ioResourceDescriptorOut: int) returns (out_i_5: int, out_newPortMask: int, out_sdv_180: int, out_links: int, out_ioPortInfo: int)
{

  entry:
    out_i_5, out_newPortMask, out_sdv_180, out_links, out_ioPortInfo := in_i_5, in_newPortMask, in_sdv_180, in_links, in_ioPortInfo;
    goto L171, exit;

  L171:
    goto anon92_Else;

  anon94_Then:
    assume {:partition} out_newPortMask == 0;
    assume {:nonnull} out_links != 0;
    assume out_links > 0;
    out_links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(out_links)];
    goto anon94_Then_dummy;

  L179:
    call out_i_5, out_newPortMask := FdcFilterResourceRequirements_loop_L179(out_i_5, out_newPortMask, in_ioResourceListOut, in_resourceRequirementsOut, out_ioPortInfo, in_ioResourceDescriptorOut);
    goto L179_last;

  L179_last:
    goto anon94_Then, anon94_Else;

  anon92_Else:
    call out_sdv_180 := sdv_containing_record(out_links, 12);
    out_ioPortInfo := out_sdv_180;
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    out_newPortMask := BAND(BNOT(Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(out_ioPortInfo)]), BOR(BOR(BOR(BOR(4, 8), 16), 32), 128));
    out_i_5 := 0;
    goto L179;

  L182:
    call out_newPortMask := corral_nondet();
    out_i_5 := out_i_5 + 1;
    assume false;
    return;

  anon95_Else:
    assume {:partition} BAND(out_newPortMask, 1) != 0;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Option__IO_RESOURCE_DESCRIPTOR[Option__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR[ShareDisposition__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Flags__IO_RESOURCE_DESCRIPTOR[Flags__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)))] := 1;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.Alignment_unnamed_tag_58[Alignment_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut)))] := 1;
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(BaseAddress__IO_PORT_INFO(out_ioPortInfo))] + out_i_5;
    assume {:nonnull} in_ioResourceDescriptorOut != 0;
    assume in_ioResourceDescriptorOut > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut))))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MaximumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorOut))))];
    assume {:nonnull} in_ioResourceListOut != 0;
    assume in_ioResourceListOut > 0;
    Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(in_ioResourceListOut)] := Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(in_ioResourceListOut)] + 1;
    assume {:nonnull} in_resourceRequirementsOut != 0;
    assume in_resourceRequirementsOut > 0;
    Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(in_resourceRequirementsOut)] := Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST[ListSize__IO_RESOURCE_REQUIREMENTS_LIST(in_resourceRequirementsOut)] + 32;
    goto L182;

  anon95_Then:
    assume {:partition} BAND(out_newPortMask, 1) == 0;
    goto L182;

  anon94_Else:
    assume {:partition} out_newPortMask != 0;
    goto anon95_Then, anon95_Else;

  anon94_Then_dummy:
    call {:si_unique_call 1} out_i_5, out_newPortMask, out_sdv_180, out_links, out_ioPortInfo := FdcFilterResourceRequirements_loop_L171(out_i_5, out_newPortMask, in_ioResourceListOut, out_sdv_180, out_links, in_resourceRequirementsOut, out_ioPortInfo, in_ioResourceDescriptorOut);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L171(in_i_5: int, in_newPortMask: int, in_ioResourceListOut: int, in_sdv_180: int, in_links: int, in_resourceRequirementsOut: int, in_ioPortInfo: int, in_ioResourceDescriptorOut: int) returns (out_i_5: int, out_newPortMask: int, out_sdv_180: int, out_links: int, out_ioPortInfo: int);
  modifies Mem_T.Option__IO_RESOURCE_DESCRIPTOR, Mem_T.Type__IO_RESOURCE_DESCRIPTOR, Mem_T.ShareDisposition__IO_RESOURCE_DESCRIPTOR, Mem_T.Flags__IO_RESOURCE_DESCRIPTOR, Mem_T.Length_unnamed_tag_18, Mem_T.Alignment_unnamed_tag_58, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.Count__IO_RESOURCE_LIST, Mem_T.ListSize__IO_RESOURCE_REQUIREMENTS_LIST;



implementation FdcFilterResourceRequirements_loop_L137(in_sdv_174: int, in_sdv_177: int, in_links: int, in_ioPortList: int, in_ioPortInfo: int) returns (out_sdv_174: int, out_sdv_177: int, out_links: int, out_ioPortInfo: int)
{

  entry:
    out_sdv_174, out_sdv_177, out_links, out_ioPortInfo := in_sdv_174, in_sdv_177, in_links, in_ioPortInfo;
    goto L137, exit;

  L137:
    call out_sdv_177 := sdv_IsListEmpty(0);
    goto anon98_Then;

  anon98_Then:
    assume {:partition} out_sdv_177 == 0;
    call out_links := RemoveHeadList(in_ioPortList);
    call out_sdv_174 := sdv_containing_record(out_links, 12);
    out_ioPortInfo := out_sdv_174;
    call sdv_ExFreePool(0);
    goto anon98_Then_dummy;

  anon98_Then_dummy:
    call {:si_unique_call 1} out_sdv_174, out_sdv_177, out_links, out_ioPortInfo := FdcFilterResourceRequirements_loop_L137(out_sdv_174, out_sdv_177, out_links, in_ioPortList, out_ioPortInfo);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L137(in_sdv_174: int, in_sdv_177: int, in_links: int, in_ioPortList: int, in_ioPortInfo: int) returns (out_sdv_174: int, out_sdv_177: int, out_links: int, out_ioPortInfo: int);
  modifies alloc, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY;



implementation FdcFilterResourceRequirements_loop_L123(in_requestTapeModeRegister: int, in_newPortMask: int, in_sdv_178: int, in_links: int, in_ioPortInfo: int, in_newDescriptors: int) returns (out_requestTapeModeRegister: int, out_newPortMask: int, out_sdv_178: int, out_links: int, out_ioPortInfo: int, out_newDescriptors: int)
{

  entry:
    out_requestTapeModeRegister, out_newPortMask, out_sdv_178, out_links, out_ioPortInfo, out_newDescriptors := in_requestTapeModeRegister, in_newPortMask, in_sdv_178, in_links, in_ioPortInfo, in_newDescriptors;
    goto L123, exit;

  L123:
    goto anon88_Else;

  anon90_Then:
    assume {:partition} 0 >= out_newPortMask;
    assume {:nonnull} out_links != 0;
    assume out_links > 0;
    out_links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(out_links)];
    goto anon90_Then_dummy;

  L131:
    call out_newPortMask, out_newDescriptors := FdcFilterResourceRequirements_loop_L131(out_newPortMask, out_newDescriptors);
    goto L131_last;

  L131_last:
    goto anon90_Then, anon90_Else;

  anon105_Else:
    assume {:partition} BAND(out_newPortMask, 8) != 0;
    out_requestTapeModeRegister := 1;
    goto L131;

  L135:
    call out_newPortMask := corral_nondet();
    assume false;
    return;

  anon105_Then:
    assume {:partition} BAND(out_newPortMask, 8) == 0;
    goto L131;

  anon88_Else:
    call out_sdv_178 := sdv_containing_record(out_links, 12);
    out_ioPortInfo := out_sdv_178;
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    out_newPortMask := BAND(BNOT(Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(out_ioPortInfo)]), BOR(BOR(BOR(BOR(4, 8), 16), 32), 128));
    goto anon105_Then, anon105_Else;

  anon91_Else:
    assume {:partition} BAND(out_newPortMask, 1) != 0;
    out_newDescriptors := out_newDescriptors + 1;
    goto L135;

  anon91_Then:
    assume {:partition} BAND(out_newPortMask, 1) == 0;
    goto L135;

  anon90_Else:
    assume {:partition} out_newPortMask > 0;
    goto anon91_Then, anon91_Else;

  anon90_Then_dummy:
    call {:si_unique_call 1} out_requestTapeModeRegister, out_newPortMask, out_sdv_178, out_links, out_ioPortInfo, out_newDescriptors := FdcFilterResourceRequirements_loop_L123(out_requestTapeModeRegister, out_newPortMask, out_sdv_178, out_links, out_ioPortInfo, out_newDescriptors);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L123(in_requestTapeModeRegister: int, in_newPortMask: int, in_sdv_178: int, in_links: int, in_ioPortInfo: int, in_newDescriptors: int) returns (out_requestTapeModeRegister: int, out_newPortMask: int, out_sdv_178: int, out_links: int, out_ioPortInfo: int, out_newDescriptors: int);



implementation FdcFilterResourceRequirements_loop_L112(in_sdv_176: int, in_links: int, in_ioPortList: int, in_sdv_185: int, in_ioPortInfo: int) returns (out_sdv_176: int, out_links: int, out_sdv_185: int, out_ioPortInfo: int)
{

  entry:
    out_sdv_176, out_links, out_sdv_185, out_ioPortInfo := in_sdv_176, in_links, in_sdv_185, in_ioPortInfo;
    goto L112, exit;

  L112:
    call out_sdv_176 := sdv_IsListEmpty(0);
    goto anon99_Then;

  anon99_Then:
    assume {:partition} out_sdv_176 == 0;
    call out_links := RemoveHeadList(in_ioPortList);
    call out_sdv_185 := sdv_containing_record(out_links, 12);
    out_ioPortInfo := out_sdv_185;
    call sdv_ExFreePool(0);
    goto anon99_Then_dummy;

  anon99_Then_dummy:
    call {:si_unique_call 1} out_sdv_176, out_links, out_sdv_185, out_ioPortInfo := FdcFilterResourceRequirements_loop_L112(out_sdv_176, out_links, in_ioPortList, out_sdv_185, out_ioPortInfo);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L112(in_sdv_176: int, in_links: int, in_ioPortList: int, in_sdv_185: int, in_ioPortInfo: int) returns (out_sdv_176: int, out_links: int, out_sdv_185: int, out_ioPortInfo: int);
  modifies alloc, Mem_T.Flink__LIST_ENTRY, Mem_T.Blink__LIST_ENTRY;



implementation FdcFilterResourceRequirements_loop_L63(in_i_5: int, in_Tmp_341: int, in_ioResourceDescriptorIn: int, in_dmaResource: int, in_interruptResource: int, in_foundBase: int, in_j: int, in_ioResourceListIn: int, in_ntStatus_6: int, in_links: int, in_sdv_182: int, in_sdv_183: int, in_ioPortList: int, in_ioPortInfo: int, in_boogieTmp: int, in_vslice_dummy_var_80: int) returns (out_i_5: int, out_Tmp_341: int, out_dmaResource: int, out_interruptResource: int, out_foundBase: int, out_j: int, out_ntStatus_6: int, out_links: int, out_sdv_182: int, out_sdv_183: int, out_ioPortInfo: int, out_boogieTmp: int, out_vslice_dummy_var_80: int)
{

  entry:
    out_i_5, out_Tmp_341, out_dmaResource, out_interruptResource, out_foundBase, out_j, out_ntStatus_6, out_links, out_sdv_182, out_sdv_183, out_ioPortInfo, out_boogieTmp, out_vslice_dummy_var_80 := in_i_5, in_Tmp_341, in_dmaResource, in_interruptResource, in_foundBase, in_j, in_ntStatus_6, in_links, in_sdv_182, in_sdv_183, in_ioPortInfo, in_boogieTmp, in_vslice_dummy_var_80;
    goto L63, exit;

  L63:
    assume {:nonnull} in_ioResourceListIn != 0;
    assume in_ioResourceListIn > 0;
    goto anon77_Else;

  L72:
    out_i_5 := out_i_5 + 1;
    goto L72_dummy;

  anon100_Else:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)] != 4;
    goto L72;

  anon100_Then:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)] == 4;
    out_dmaResource := 1;
    goto L72;

  anon101_Then:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)] == 2;
    out_interruptResource := 1;
    goto L72;

  anon84_Then:
    assume {:partition} out_j >= Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)))];
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    call out_vslice_dummy_var_80 := sdv_InsertTailList(in_ioPortList, ListEntry__IO_PORT_INFO(out_ioPortInfo));
    goto L72;

  anon104_Then:
    assume {:partition} out_ioPortInfo == 0;
    out_ntStatus_6 := -1073741670;
    goto L72;

  anon82_Then:
    assume {:partition} out_foundBase != 0;
    goto L72;

  L77:
    goto anon82_Then, anon82_Else;

  anon83_Then:
    assume {:partition} out_j >= Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)))];
    goto L77;

  anon81_Then:
    goto L77;

  L76:
    call out_Tmp_341, out_links, out_sdv_183, out_ioPortInfo := FdcFilterResourceRequirements_loop_L76(out_Tmp_341, in_ioResourceDescriptorIn, out_links, out_sdv_183, out_ioPortInfo);
    goto L76_last;

  L76_last:
    goto anon81_Then, anon81_Else;

  anon80_Then:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)] == 1;
    out_foundBase := 0;
    assume {:nonnull} in_ioPortList != 0;
    assume in_ioPortList > 0;
    out_links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(in_ioPortList)];
    goto L76;

  anon103_Then:
    assume {:partition} Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(out_ioPortInfo))] != out_Tmp_341;
    assume {:nonnull} out_links != 0;
    assume out_links > 0;
    out_links := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(out_links)];
    assume false;
    return;

  anon81_Else:
    call out_sdv_183 := sdv_containing_record(out_links, 12);
    out_ioPortInfo := out_sdv_183;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    out_Tmp_341 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn))))], BNOT(BOR(BOR(1, 2), 4)));
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    goto anon103_Then, anon103_Else;

  anon79_Else:
    assume {:partition} out_ntStatus_6 >= 0;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    goto anon80_Then, anon80_Else;

  anon77_Else:
    assume {:partition} Mem_T.Count__IO_RESOURCE_LIST[Count__IO_RESOURCE_LIST(in_ioResourceListIn)] > out_i_5;
    goto anon79_Else;

  L87:
    call out_j, out_boogieTmp := FdcFilterResourceRequirements_loop_L87(in_ioResourceDescriptorIn, out_j, out_ioPortInfo, out_boogieTmp);
    goto L87_last;

  L87_last:
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    goto anon83_Then, anon83_Else;

  anon103_Else:
    assume {:partition} Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(out_ioPortInfo))] == out_Tmp_341;
    out_foundBase := 1;
    out_j := 0;
    goto L87;

  anon83_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)))] > out_j;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    call out_boogieTmp := corral_nondet();
    Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(out_ioPortInfo)] := out_boogieTmp;
    out_j := out_j + 1;
    assume false;
    return;

  anon82_Else:
    assume {:partition} out_foundBase == 0;
    call out_sdv_182 := ExAllocatePoolWithTag(257, 24, -261133242);
    out_ioPortInfo := out_sdv_182;
    goto anon104_Then, anon104_Else;

  L105:
    call out_j, out_boogieTmp := FdcFilterResourceRequirements_loop_L105(in_ioResourceDescriptorIn, out_j, out_ioPortInfo, out_boogieTmp);
    goto L105_last;

  L105_last:
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    goto anon84_Then, anon84_Else;

  anon104_Else:
    assume {:partition} out_ioPortInfo != 0;
    call sdv_RtlZeroMemory(0, 24);
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(out_ioPortInfo))] := Mem_T.LowPart__LUID[LowPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn))))];
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(BaseAddress__IO_PORT_INFO(out_ioPortInfo))] := Mem_T.HighPart__LUID[HighPart__LUID(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn))))];
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(BaseAddress__IO_PORT_INFO(out_ioPortInfo)))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)))))];
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(BaseAddress__IO_PORT_INFO(out_ioPortInfo)))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)))))];
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(BaseAddress__IO_PORT_INFO(out_ioPortInfo))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(MinimumAddress_unnamed_tag_58(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn))))];
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(out_ioPortInfo))] := BAND(Mem_T.LowPart__LUID[LowPart__LUID(BaseAddress__IO_PORT_INFO(out_ioPortInfo))], BNOT(BOR(BOR(1, 2), 4)));
    out_j := 0;
    goto L105;

  anon84_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_18[Length_unnamed_tag_18(Port_unnamed_tag_57(u__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)))] > out_j;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    assume {:nonnull} out_ioPortInfo != 0;
    assume out_ioPortInfo > 0;
    call out_boogieTmp := corral_nondet();
    Mem_T.Map__IO_PORT_INFO[Map__IO_PORT_INFO(out_ioPortInfo)] := out_boogieTmp;
    out_j := out_j + 1;
    assume false;
    return;

  anon80_Else:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)] != 1;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    goto anon101_Then, anon101_Else;

  anon101_Else:
    assume {:partition} Mem_T.Type__IO_RESOURCE_DESCRIPTOR[Type__IO_RESOURCE_DESCRIPTOR(in_ioResourceDescriptorIn)] != 2;
    assume {:nonnull} in_ioResourceDescriptorIn != 0;
    assume in_ioResourceDescriptorIn > 0;
    goto anon100_Then, anon100_Else;

  L72_dummy:
    call {:si_unique_call 1} out_i_5, out_Tmp_341, out_dmaResource, out_interruptResource, out_foundBase, out_j, out_ntStatus_6, out_links, out_sdv_182, out_sdv_183, out_ioPortInfo, out_boogieTmp, out_vslice_dummy_var_80 := FdcFilterResourceRequirements_loop_L63(out_i_5, out_Tmp_341, in_ioResourceDescriptorIn, out_dmaResource, out_interruptResource, out_foundBase, out_j, in_ioResourceListIn, out_ntStatus_6, out_links, out_sdv_182, out_sdv_183, in_ioPortList, out_ioPortInfo, out_boogieTmp, out_vslice_dummy_var_80);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFilterResourceRequirements_loop_L63(in_i_5: int, in_Tmp_341: int, in_ioResourceDescriptorIn: int, in_dmaResource: int, in_interruptResource: int, in_foundBase: int, in_j: int, in_ioResourceListIn: int, in_ntStatus_6: int, in_links: int, in_sdv_182: int, in_sdv_183: int, in_ioPortList: int, in_ioPortInfo: int, in_boogieTmp: int, in_vslice_dummy_var_80: int) returns (out_i_5: int, out_Tmp_341: int, out_dmaResource: int, out_interruptResource: int, out_foundBase: int, out_j: int, out_ntStatus_6: int, out_links: int, out_sdv_182: int, out_sdv_183: int, out_ioPortInfo: int, out_boogieTmp: int, out_vslice_dummy_var_80: int);
  modifies alloc, Mem_T.INT4, Mem_T.Map__IO_PORT_INFO, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER;



implementation FdcStartDevice_loop_L37(in_ntStatus_9: int, in_InterfaceType_1: int) returns (out_ntStatus_9: int, out_InterfaceType_1: int)
{

  entry:
    out_ntStatus_9, out_InterfaceType_1 := in_ntStatus_9, in_InterfaceType_1;
    goto L37, exit;

  L37:
    assume {:CounterLoop 18} {:Counter "InterfaceType_1"} true;
    goto anon87_Else;

  L47:
    out_InterfaceType_1 := out_InterfaceType_1 + 1;
    goto L47_dummy;

  anon89_Else:
    assume {:partition} out_ntStatus_9 >= 0;
    goto L47;

  anon90_Then:
    assume {:partition} out_ntStatus_9 == -1073741772;
    goto L47;

  anon89_Then:
    assume {:partition} 0 > out_ntStatus_9;
    goto anon90_Then;

  anon87_Else:
    assume {:partition} 18 > out_InterfaceType_1;
    call out_ntStatus_9 := IoQueryDeviceDescription(0, 0, 0, 0, 0, 0, li2bplFunctionConstant206, 0);
    goto anon89_Then, anon89_Else;

  L47_dummy:
    havoc out_InterfaceType_1;
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcStartDevice_loop_L37(in_ntStatus_9: int, in_InterfaceType_1: int) returns (out_ntStatus_9: int, out_InterfaceType_1: int);



implementation FdcStartDevice_loop_L172(in_Tmp_375: int, in_Tmp_378: int, in_Tmp_382: int, in_Tmp_384: int, in_currentOffset: int, in_partial: int, in_fdoExtension_4: int, in_startOffset: int) returns (out_Tmp_375: int, out_Tmp_378: int, out_Tmp_382: int, out_Tmp_384: int, out_currentOffset: int)
{

  entry:
    out_Tmp_375, out_Tmp_378, out_Tmp_382, out_Tmp_384, out_currentOffset := in_Tmp_375, in_Tmp_378, in_Tmp_382, in_Tmp_384, in_currentOffset;
    goto L172, exit;

  L172:
    assume {:nonnull} in_partial != 0;
    assume in_partial > 0;
    goto anon100_Else;

  anon100_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(in_partial)))] > out_currentOffset;
    out_Tmp_384 := in_startOffset + out_currentOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_375 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    out_Tmp_378 := in_startOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_382 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    assume {:nonnull} out_Tmp_375 != 0;
    assume out_Tmp_375 > 0;
    assume {:nonnull} out_Tmp_382 != 0;
    assume out_Tmp_382 > 0;
    Mem_T.PINT4[out_Tmp_375 + out_Tmp_384 * 4] := Mem_T.PINT4[out_Tmp_382 + out_Tmp_378 * 4];
    out_currentOffset := out_currentOffset + 1;
    goto anon100_Else_dummy;

  anon100_Else_dummy:
    call {:si_unique_call 1} out_Tmp_375, out_Tmp_378, out_Tmp_382, out_Tmp_384, out_currentOffset := FdcStartDevice_loop_L172(out_Tmp_375, out_Tmp_378, out_Tmp_382, out_Tmp_384, out_currentOffset, in_partial, in_fdoExtension_4, in_startOffset);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcStartDevice_loop_L172(in_Tmp_375: int, in_Tmp_378: int, in_Tmp_382: int, in_Tmp_384: int, in_currentOffset: int, in_partial: int, in_fdoExtension_4: int, in_startOffset: int) returns (out_Tmp_375: int, out_Tmp_378: int, out_Tmp_382: int, out_Tmp_384: int, out_currentOffset: int);
  modifies Mem_T.PINT4;



implementation FdcStartDevice_loop_L199(in_Tmp_379: int, in_currentOffset: int, in_partial: int, in_fdoExtension_4: int, in_startOffset: int, in_Tmp_390: int, in_Tmp_391: int, in_Tmp_394: int) returns (out_Tmp_379: int, out_currentOffset: int, out_Tmp_390: int, out_Tmp_391: int, out_Tmp_394: int)
{

  entry:
    out_Tmp_379, out_currentOffset, out_Tmp_390, out_Tmp_391, out_Tmp_394 := in_Tmp_379, in_currentOffset, in_Tmp_390, in_Tmp_391, in_Tmp_394;
    goto L199, exit;

  L199:
    assume {:nonnull} in_partial != 0;
    assume in_partial > 0;
    goto anon101_Else;

  anon101_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(in_partial)))] > out_currentOffset;
    out_Tmp_390 := in_startOffset + out_currentOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_379 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    out_Tmp_391 := in_startOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_394 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    assume {:nonnull} out_Tmp_379 != 0;
    assume out_Tmp_379 > 0;
    assume {:nonnull} out_Tmp_394 != 0;
    assume out_Tmp_394 > 0;
    Mem_T.PINT4[out_Tmp_379 + out_Tmp_390 * 4] := Mem_T.PINT4[out_Tmp_394 + out_Tmp_391 * 4];
    out_currentOffset := out_currentOffset + 1;
    goto anon101_Else_dummy;

  anon101_Else_dummy:
    call {:si_unique_call 1} out_Tmp_379, out_currentOffset, out_Tmp_390, out_Tmp_391, out_Tmp_394 := FdcStartDevice_loop_L199(out_Tmp_379, out_currentOffset, in_partial, in_fdoExtension_4, in_startOffset, out_Tmp_390, out_Tmp_391, out_Tmp_394);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcStartDevice_loop_L199(in_Tmp_379: int, in_currentOffset: int, in_partial: int, in_fdoExtension_4: int, in_startOffset: int, in_Tmp_390: int, in_Tmp_391: int, in_Tmp_394: int) returns (out_Tmp_379: int, out_currentOffset: int, out_Tmp_390: int, out_Tmp_391: int, out_Tmp_394: int);
  modifies Mem_T.PINT4;



implementation FdcStartDevice_loop_L109(in_i_6: int, in_Tmp_374: int, in_Tmp_375: int, in_Tmp_376: int, in_Tmp_377: int, in_foundDma: int, in_Tmp_378: int, in_Tmp_379: int, in_Tmp_380: int, in_Tmp_381: int, in_Tmp_382: int, in_Tmp_383: int, in_deviceDesc: int, in_partialList: int, in_fullList: int, in_sdv_202: int, in_Tmp_384: int, in_ntStatus_9: int, in_sdv_205: int, in_currentOffset: int, in_Tmp_385: int, in_partial: int, in_fdoExtension_4: int, in_currentBase: int, in_Tmp_386: int, in_startOffset: int, in_foundInterrupt: int, in_Tmp_388: int, in_Tmp_390: int, in_Tmp_391: int, in_Tmp_392: int, in_Tmp_393: int, in_sdv_210: int, in_Tmp_394: int, in_Tmp_395: int) returns (out_i_6: int, out_Tmp_374: int, out_Tmp_375: int, out_Tmp_376: int, out_Tmp_377: int, out_foundDma: int, out_Tmp_378: int, out_Tmp_379: int, out_Tmp_380: int, out_Tmp_381: int, out_Tmp_382: int, out_Tmp_383: int, out_sdv_202: int, out_Tmp_384: int, out_ntStatus_9: int, out_sdv_205: int, out_currentOffset: int, out_Tmp_385: int, out_partial: int, out_currentBase: int, out_Tmp_386: int, out_startOffset: int, out_foundInterrupt: int, out_Tmp_388: int, out_Tmp_390: int, out_Tmp_391: int, out_Tmp_392: int, out_Tmp_393: int, out_sdv_210: int, out_Tmp_394: int, out_Tmp_395: int)
{

  entry:
    out_i_6, out_Tmp_374, out_Tmp_375, out_Tmp_376, out_Tmp_377, out_foundDma, out_Tmp_378, out_Tmp_379, out_Tmp_380, out_Tmp_381, out_Tmp_382, out_Tmp_383, out_sdv_202, out_Tmp_384, out_ntStatus_9, out_sdv_205, out_currentOffset, out_Tmp_385, out_partial, out_currentBase, out_Tmp_386, out_startOffset, out_foundInterrupt, out_Tmp_388, out_Tmp_390, out_Tmp_391, out_Tmp_392, out_Tmp_393, out_sdv_210, out_Tmp_394, out_Tmp_395 := in_i_6, in_Tmp_374, in_Tmp_375, in_Tmp_376, in_Tmp_377, in_foundDma, in_Tmp_378, in_Tmp_379, in_Tmp_380, in_Tmp_381, in_Tmp_382, in_Tmp_383, in_sdv_202, in_Tmp_384, in_ntStatus_9, in_sdv_205, in_currentOffset, in_Tmp_385, in_partial, in_currentBase, in_Tmp_386, in_startOffset, in_foundInterrupt, in_Tmp_388, in_Tmp_390, in_Tmp_391, in_Tmp_392, in_Tmp_393, in_sdv_210, in_Tmp_394, in_Tmp_395;
    goto L109, exit;

  L109:
    assume {:nonnull} in_partialList != 0;
    assume in_partialList > 0;
    goto anon98_Else;

  L157:
    out_i_6 := out_i_6 + 1;
    goto L157_dummy;

  anon108_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(out_partial)] != 4;
    goto L157;

  anon126_Else:
    assume {:partition} Mem_T.AdapterObject__FDC_FDO_EXTENSION[AdapterObject__FDC_FDO_EXTENSION(in_fdoExtension_4)] != 0;
    goto L157;

  anon126_Then:
    assume {:partition} Mem_T.AdapterObject__FDC_FDO_EXTENSION[AdapterObject__FDC_FDO_EXTENSION(in_fdoExtension_4)] == 0;
    out_ntStatus_9 := -1073741670;
    goto L157;

  anon100_Then:
    assume {:partition} out_currentOffset >= Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))];
    goto L157;

  anon124_Then:
    assume {:partition} out_Tmp_376 != out_currentBase;
    goto L157;

  L178:
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    Mem_T.ControllerVector__FDC_FDO_EXTENSION[ControllerVector__FDC_FDO_EXTENSION(in_fdoExtension_4)] := Mem_T.Vector_unnamed_tag_45[Vector_unnamed_tag_45(Interrupt_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))];
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    Mem_T.ProcessorMask__FDC_FDO_EXTENSION[ProcessorMask__FDC_FDO_EXTENSION(in_fdoExtension_4)] := Mem_T.Affinity_unnamed_tag_45[Affinity_unnamed_tag_45(Interrupt_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))];
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    Mem_T.ControllerIrql__FDC_FDO_EXTENSION[ControllerIrql__FDC_FDO_EXTENSION(in_fdoExtension_4)] := Mem_T.Level_unnamed_tag_45[Level_unnamed_tag_45(Interrupt_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))];
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    Mem_T.SharableVector__FDC_FDO_EXTENSION[SharableVector__FDC_FDO_EXTENSION(in_fdoExtension_4)] := 1;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    Mem_T.SaveFloatState__FDC_FDO_EXTENSION[SaveFloatState__FDC_FDO_EXTENSION(in_fdoExtension_4)] := 0;
    goto L157;

  anon101_Then:
    assume {:partition} out_currentOffset >= Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))];
    goto L157;

  anon120_Then:
    assume {:partition} out_Tmp_388 != out_currentBase;
    goto L157;

  L185:
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    out_Tmp_388 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto anon120_Then, anon120_Else;

  anon119_Else:
    assume {:partition} out_currentBase > out_Tmp_385;
    call sdv_RtlZeroMemory(0, 32);
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    out_currentBase := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto L185;

  anon119_Then:
    assume {:partition} out_Tmp_385 >= out_currentBase;
    goto L185;

  anon118_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(out_partial)] == 1;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    out_Tmp_385 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto anon119_Then, anon119_Else;

  anon98_Else:
    assume {:partition} Mem_T.Count__CM_PARTIAL_RESOURCE_LIST[Count__CM_PARTIAL_RESOURCE_LIST(in_partialList)] > out_i_6;
    out_Tmp_383 := out_i_6;
    assume {:nonnull} in_partialList != 0;
    assume in_partialList > 0;
    out_Tmp_377 := Mem_T.PartialDescriptors__CM_PARTIAL_RESOURCE_LIST[PartialDescriptors__CM_PARTIAL_RESOURCE_LIST(in_partialList)];
    out_partial := out_Tmp_377 + out_Tmp_383 * 292;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    goto anon118_Then, anon118_Else;

  L199:
    call out_Tmp_379, out_currentOffset, out_Tmp_390, out_Tmp_391, out_Tmp_394 := FdcStartDevice_loop_L199(out_Tmp_379, out_currentOffset, out_partial, in_fdoExtension_4, out_startOffset, out_Tmp_390, out_Tmp_391, out_Tmp_394);
    goto L199_last;

  L199_last:
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    goto anon101_Then, anon101_Else;

  L198:
    out_currentOffset := 1;
    goto L199;

  anon101_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))] > out_currentOffset;
    out_Tmp_390 := out_startOffset + out_currentOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_379 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    out_Tmp_391 := out_startOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_394 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    assume {:nonnull} out_Tmp_379 != 0;
    assume out_Tmp_379 > 0;
    assume {:nonnull} out_Tmp_394 != 0;
    assume out_Tmp_394 > 0;
    Mem_T.PINT4[out_Tmp_379 + out_Tmp_390 * 4] := Mem_T.PINT4[out_Tmp_394 + out_Tmp_391 * 4];
    out_currentOffset := out_currentOffset + 1;
    assume false;
    return;

  anon121_Else:
    assume {:partition} BAND(Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR[Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)], 1) != 0;
    out_Tmp_393 := out_startOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_386 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    assume {:nonnull} out_Tmp_386 != 0;
    assume out_Tmp_386 > 0;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    Mem_T.PINT4[out_Tmp_386 + out_Tmp_393 * 4] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial))))];
    goto L198;

  anon121_Then:
    assume {:partition} BAND(Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR[Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)], 1) == 0;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    call out_sdv_205 := MmMapIoSpace(Mem_T.Start_unnamed_tag_44[Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))], Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))], 0);
    out_Tmp_380 := out_startOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_395 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    assume {:nonnull} out_Tmp_395 != 0;
    assume out_Tmp_395 > 0;
    Mem_T.PINT4[out_Tmp_395 + out_Tmp_380 * 4] := out_sdv_205;
    goto L198;

  anon120_Else:
    assume {:partition} out_Tmp_388 == out_currentBase;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    out_startOffset := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Port_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial))))], BOR(BOR(1, 2), 4));
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    goto anon121_Then, anon121_Else;

  anon122_Else:
    assume {:partition} BAND(Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR[Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)], 1) != 0;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    Mem_T.InterruptMode__FDC_FDO_EXTENSION[InterruptMode__FDC_FDO_EXTENSION(in_fdoExtension_4)] := 1;
    goto L178;

  anon122_Then:
    assume {:partition} BAND(Mem_T.Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR[Flags__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)], 1) == 0;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    Mem_T.InterruptMode__FDC_FDO_EXTENSION[InterruptMode__FDC_FDO_EXTENSION(in_fdoExtension_4)] := 0;
    goto L178;

  anon110_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(out_partial)] == 2;
    out_foundInterrupt := 1;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    goto anon122_Then, anon122_Else;

  anon118_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(out_partial)] != 1;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    goto anon110_Then, anon110_Else;

  L159:
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    out_Tmp_376 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto anon124_Then, anon124_Else;

  anon123_Else:
    assume {:partition} out_currentBase > out_Tmp_374;
    call sdv_RtlZeroMemory(0, 32);
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    out_currentBase := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto L159;

  anon123_Then:
    assume {:partition} out_Tmp_374 >= out_currentBase;
    goto L159;

  anon109_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(out_partial)] == 3;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    out_Tmp_374 := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial))))], BNOT(BOR(BOR(1, 2), 4)));
    goto anon123_Then, anon123_Else;

  anon110_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(out_partial)] != 2;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    goto anon109_Then, anon109_Else;

  L172:
    call out_Tmp_375, out_Tmp_378, out_Tmp_382, out_Tmp_384, out_currentOffset := FdcStartDevice_loop_L172(out_Tmp_375, out_Tmp_378, out_Tmp_382, out_Tmp_384, out_currentOffset, out_partial, in_fdoExtension_4, out_startOffset);
    goto L172_last;

  L172_last:
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    goto anon100_Then, anon100_Else;

  anon124_Else:
    assume {:partition} out_Tmp_376 == out_currentBase;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    out_startOffset := BAND(Mem_T.LowPart__LUID[LowPart__LUID(Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial))))], BOR(BOR(1, 2), 4));
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    call out_sdv_210 := MmMapIoSpace(Mem_T.Start_unnamed_tag_44[Start_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))], Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))], 0);
    out_Tmp_381 := out_startOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_392 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    assume {:nonnull} out_Tmp_392 != 0;
    assume out_Tmp_392 > 0;
    Mem_T.PINT4[out_Tmp_392 + out_Tmp_381 * 4] := out_sdv_210;
    out_currentOffset := 1;
    goto L172;

  anon100_Else:
    assume {:partition} Mem_T.Length_unnamed_tag_44[Length_unnamed_tag_44(Memory_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))] > out_currentOffset;
    out_Tmp_384 := out_startOffset + out_currentOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_375 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    out_Tmp_378 := out_startOffset;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    out_Tmp_382 := Mem_T.Address__CONTROLLER[Address__CONTROLLER(ControllerAddress__FDC_FDO_EXTENSION(in_fdoExtension_4))];
    assume {:nonnull} out_Tmp_375 != 0;
    assume out_Tmp_375 > 0;
    assume {:nonnull} out_Tmp_382 != 0;
    assume out_Tmp_382 > 0;
    Mem_T.PINT4[out_Tmp_375 + out_Tmp_384 * 4] := Mem_T.PINT4[out_Tmp_382 + out_Tmp_378 * 4];
    out_currentOffset := out_currentOffset + 1;
    assume false;
    return;

  L142:
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    Mem_T.MaximumLength__DEVICE_DESCRIPTION[MaximumLength__DEVICE_DESCRIPTION(in_deviceDesc)] := 18432;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    Mem_T.MaximumLength__DEVICE_DESCRIPTION[MaximumLength__DEVICE_DESCRIPTION(in_deviceDesc)] := Mem_T.MaximumLength__DEVICE_DESCRIPTION[MaximumLength__DEVICE_DESCRIPTION(in_deviceDesc)] + 4096;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_fullList != 0;
    assume in_fullList > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    call out_sdv_202 := IoGetDmaAdapter(0, 0, 0);
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    Mem_T.AdapterObject__FDC_FDO_EXTENSION[AdapterObject__FDC_FDO_EXTENSION(in_fdoExtension_4)] := out_sdv_202;
    assume {:nonnull} in_fdoExtension_4 != 0;
    assume in_fdoExtension_4 > 0;
    goto anon126_Then, anon126_Else;

  anon125_Else:
    assume {:partition} Mem_T.Channel_unnamed_tag_48[Channel_unnamed_tag_48(Dma_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))] > 3;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    goto L142;

  anon125_Then:
    assume {:partition} 3 >= Mem_T.Channel_unnamed_tag_48[Channel_unnamed_tag_48(Dma_unnamed_tag_43(u__CM_PARTIAL_RESOURCE_DESCRIPTOR(out_partial)))];
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    goto L142;

  anon108_Then:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(out_partial)] == 4;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    Mem_T.MaximumLength__DEVICE_DESCRIPTION[MaximumLength__DEVICE_DESCRIPTION(in_deviceDesc)] := 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    out_foundDma := 1;
    assume {:nonnull} in_deviceDesc != 0;
    assume in_deviceDesc > 0;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    goto anon125_Then, anon125_Else;

  anon109_Else:
    assume {:partition} Mem_T.Type_unnamed_tag_28[Type_unnamed_tag_28(out_partial)] != 3;
    assume {:nonnull} out_partial != 0;
    assume out_partial > 0;
    goto anon108_Then, anon108_Else;

  L157_dummy:
    call {:si_unique_call 1} out_i_6, out_Tmp_374, out_Tmp_375, out_Tmp_376, out_Tmp_377, out_foundDma, out_Tmp_378, out_Tmp_379, out_Tmp_380, out_Tmp_381, out_Tmp_382, out_Tmp_383, out_sdv_202, out_Tmp_384, out_ntStatus_9, out_sdv_205, out_currentOffset, out_Tmp_385, out_partial, out_currentBase, out_Tmp_386, out_startOffset, out_foundInterrupt, out_Tmp_388, out_Tmp_390, out_Tmp_391, out_Tmp_392, out_Tmp_393, out_sdv_210, out_Tmp_394, out_Tmp_395 := FdcStartDevice_loop_L109(out_i_6, out_Tmp_374, out_Tmp_375, out_Tmp_376, out_Tmp_377, out_foundDma, out_Tmp_378, out_Tmp_379, out_Tmp_380, out_Tmp_381, out_Tmp_382, out_Tmp_383, in_deviceDesc, in_partialList, in_fullList, out_sdv_202, out_Tmp_384, out_ntStatus_9, out_sdv_205, out_currentOffset, out_Tmp_385, out_partial, in_fdoExtension_4, out_currentBase, out_Tmp_386, out_startOffset, out_foundInterrupt, out_Tmp_388, out_Tmp_390, out_Tmp_391, out_Tmp_392, out_Tmp_393, out_sdv_210, out_Tmp_394, out_Tmp_395);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcStartDevice_loop_L109(in_i_6: int, in_Tmp_374: int, in_Tmp_375: int, in_Tmp_376: int, in_Tmp_377: int, in_foundDma: int, in_Tmp_378: int, in_Tmp_379: int, in_Tmp_380: int, in_Tmp_381: int, in_Tmp_382: int, in_Tmp_383: int, in_deviceDesc: int, in_partialList: int, in_fullList: int, in_sdv_202: int, in_Tmp_384: int, in_ntStatus_9: int, in_sdv_205: int, in_currentOffset: int, in_Tmp_385: int, in_partial: int, in_fdoExtension_4: int, in_currentBase: int, in_Tmp_386: int, in_startOffset: int, in_foundInterrupt: int, in_Tmp_388: int, in_Tmp_390: int, in_Tmp_391: int, in_Tmp_392: int, in_Tmp_393: int, in_sdv_210: int, in_Tmp_394: int, in_Tmp_395: int) returns (out_i_6: int, out_Tmp_374: int, out_Tmp_375: int, out_Tmp_376: int, out_Tmp_377: int, out_foundDma: int, out_Tmp_378: int, out_Tmp_379: int, out_Tmp_380: int, out_Tmp_381: int, out_Tmp_382: int, out_Tmp_383: int, out_sdv_202: int, out_Tmp_384: int, out_ntStatus_9: int, out_sdv_205: int, out_currentOffset: int, out_Tmp_385: int, out_partial: int, out_currentBase: int, out_Tmp_386: int, out_startOffset: int, out_foundInterrupt: int, out_Tmp_388: int, out_Tmp_390: int, out_Tmp_391: int, out_Tmp_392: int, out_Tmp_393: int, out_sdv_210: int, out_Tmp_394: int, out_Tmp_395: int);
  modifies Mem_T.ControllerVector__FDC_FDO_EXTENSION, Mem_T.ProcessorMask__FDC_FDO_EXTENSION, Mem_T.ControllerIrql__FDC_FDO_EXTENSION, Mem_T.SharableVector__FDC_FDO_EXTENSION, Mem_T.SaveFloatState__FDC_FDO_EXTENSION, alloc, Mem_T.PINT4, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.InterruptMode__FDC_FDO_EXTENSION, Mem_T.MaximumLength__DEVICE_DESCRIPTION, Mem_T.AdapterObject__FDC_FDO_EXTENSION;



implementation FcReportFdcInformation_loop_L56(in_i_7: int, in_argumentSize_2: int, in_Tmp_408: int, in_Tmp_409: int, in_argumentType: int) returns (out_i_7: int, out_Tmp_408: int, out_Tmp_409: int)
{

  entry:
    out_i_7, out_Tmp_408, out_Tmp_409 := in_i_7, in_Tmp_408, in_Tmp_409;
    goto L56, exit;

  L56:
    assume {:CounterLoop 16} {:Counter "i_7"} true;
    goto anon24_Else;

  anon24_Else:
    assume {:partition} 16 > out_i_7;
    out_Tmp_408 := out_i_7;
    assume {:nonnull} in_argumentType != 0;
    assume in_argumentType > 0;
    Mem_T.INT4[in_argumentType + out_Tmp_408 * 4] := 0;
    out_Tmp_409 := out_i_7;
    assume {:nonnull} in_argumentSize_2 != 0;
    assume in_argumentSize_2 > 0;
    Mem_T.INT4[in_argumentSize_2 + out_Tmp_409 * 4] := 4;
    out_i_7 := out_i_7 + 1;
    goto anon24_Else_dummy;

  anon24_Else_dummy:
    havoc out_i_7;
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FcReportFdcInformation_loop_L56(in_i_7: int, in_argumentSize_2: int, in_Tmp_408: int, in_Tmp_409: int, in_argumentType: int) returns (out_i_7: int, out_Tmp_408: int, out_Tmp_409: int);
  modifies Mem_T.INT4;



implementation FcReportFdcInformation_loop_L46(in_i_7: int, in_Tmp_402: int, in_Tmp_404: int, in_Tmp_405: int, in_Tmp_406: int, in_Tmp_410: int, in_Tmp_412: int, in_Tmp_413: int, in_fdcInfo_1: int, in_Tmp_415: int, in_FdoExtension_6: int) returns (out_i_7: int, out_Tmp_402: int, out_Tmp_404: int, out_Tmp_405: int, out_Tmp_406: int, out_Tmp_410: int, out_Tmp_412: int, out_Tmp_413: int, out_Tmp_415: int)
{

  entry:
    out_i_7, out_Tmp_402, out_Tmp_404, out_Tmp_405, out_Tmp_406, out_Tmp_410, out_Tmp_412, out_Tmp_413, out_Tmp_415 := in_i_7, in_Tmp_402, in_Tmp_404, in_Tmp_405, in_Tmp_406, in_Tmp_410, in_Tmp_412, in_Tmp_413, in_Tmp_415;
    goto L46, exit;

  L46:
    assume {:nonnull} in_fdcInfo_1 != 0;
    assume in_fdcInfo_1 > 0;
    goto anon23_Else;

  anon23_Else:
    assume {:partition} Mem_T.BufferCount__FDC_INFO[BufferCount__FDC_INFO(in_fdcInfo_1)] > out_i_7;
    out_Tmp_413 := out_i_7;
    assume {:nonnull} in_fdcInfo_1 != 0;
    assume in_fdcInfo_1 > 0;
    out_Tmp_406 := Mem_T.BufferAddress__FDC_INFO[BufferAddress__FDC_INFO(in_fdcInfo_1)];
    out_Tmp_404 := out_i_7;
    assume {:nonnull} in_FdoExtension_6 != 0;
    assume in_FdoExtension_6 > 0;
    out_Tmp_415 := Mem_T.TransferBuffers__FDC_FDO_EXTENSION[TransferBuffers__FDC_FDO_EXTENSION(in_FdoExtension_6)];
    assume {:nonnull} out_Tmp_406 != 0;
    assume out_Tmp_406 > 0;
    assume {:nonnull} out_Tmp_415 != 0;
    assume out_Tmp_415 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(Logical__TRANSFER_BUFFER(out_Tmp_406 + out_Tmp_413 * 24))] := Mem_T.LowPart__LUID[LowPart__LUID(Logical__TRANSFER_BUFFER(out_Tmp_415 + out_Tmp_404 * 24))];
    assume {:nonnull} out_Tmp_406 != 0;
    assume out_Tmp_406 > 0;
    assume {:nonnull} out_Tmp_415 != 0;
    assume out_Tmp_415 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(Logical__TRANSFER_BUFFER(out_Tmp_406 + out_Tmp_413 * 24))] := Mem_T.HighPart__LUID[HighPart__LUID(Logical__TRANSFER_BUFFER(out_Tmp_415 + out_Tmp_404 * 24))];
    assume {:nonnull} out_Tmp_406 != 0;
    assume out_Tmp_406 > 0;
    assume {:nonnull} out_Tmp_415 != 0;
    assume out_Tmp_415 > 0;
    Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(Logical__TRANSFER_BUFFER(out_Tmp_406 + out_Tmp_413 * 24)))] := Mem_T.LowPart__LUID[LowPart__LUID(u__LARGE_INTEGER(Logical__TRANSFER_BUFFER(out_Tmp_415 + out_Tmp_404 * 24)))];
    assume {:nonnull} out_Tmp_406 != 0;
    assume out_Tmp_406 > 0;
    assume {:nonnull} out_Tmp_415 != 0;
    assume out_Tmp_415 > 0;
    Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(Logical__TRANSFER_BUFFER(out_Tmp_406 + out_Tmp_413 * 24)))] := Mem_T.HighPart__LUID[HighPart__LUID(u__LARGE_INTEGER(Logical__TRANSFER_BUFFER(out_Tmp_415 + out_Tmp_404 * 24)))];
    assume {:nonnull} out_Tmp_406 != 0;
    assume out_Tmp_406 > 0;
    assume {:nonnull} out_Tmp_415 != 0;
    assume out_Tmp_415 > 0;
    Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(Logical__TRANSFER_BUFFER(out_Tmp_406 + out_Tmp_413 * 24))] := Mem_T.QuadPart__LARGE_INTEGER[QuadPart__LARGE_INTEGER(Logical__TRANSFER_BUFFER(out_Tmp_415 + out_Tmp_404 * 24))];
    out_Tmp_402 := out_i_7;
    assume {:nonnull} in_fdcInfo_1 != 0;
    assume in_fdcInfo_1 > 0;
    out_Tmp_405 := Mem_T.BufferAddress__FDC_INFO[BufferAddress__FDC_INFO(in_fdcInfo_1)];
    out_Tmp_410 := out_i_7;
    assume {:nonnull} in_FdoExtension_6 != 0;
    assume in_FdoExtension_6 > 0;
    out_Tmp_412 := Mem_T.TransferBuffers__FDC_FDO_EXTENSION[TransferBuffers__FDC_FDO_EXTENSION(in_FdoExtension_6)];
    assume {:nonnull} out_Tmp_405 != 0;
    assume out_Tmp_405 > 0;
    assume {:nonnull} out_Tmp_412 != 0;
    assume out_Tmp_412 > 0;
    Mem_T.Virtual__TRANSFER_BUFFER[Virtual__TRANSFER_BUFFER(out_Tmp_405 + out_Tmp_402 * 24)] := Mem_T.Virtual__TRANSFER_BUFFER[Virtual__TRANSFER_BUFFER(out_Tmp_412 + out_Tmp_410 * 24)];
    out_i_7 := out_i_7 + 1;
    goto anon23_Else_dummy;

  anon23_Else_dummy:
    call {:si_unique_call 1} out_i_7, out_Tmp_402, out_Tmp_404, out_Tmp_405, out_Tmp_406, out_Tmp_410, out_Tmp_412, out_Tmp_413, out_Tmp_415 := FcReportFdcInformation_loop_L46(out_i_7, out_Tmp_402, out_Tmp_404, out_Tmp_405, out_Tmp_406, out_Tmp_410, out_Tmp_412, out_Tmp_413, in_fdcInfo_1, out_Tmp_415, in_FdoExtension_6);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FcReportFdcInformation_loop_L46(in_i_7: int, in_Tmp_402: int, in_Tmp_404: int, in_Tmp_405: int, in_Tmp_406: int, in_Tmp_410: int, in_Tmp_412: int, in_Tmp_413: int, in_fdcInfo_1: int, in_Tmp_415: int, in_FdoExtension_6: int) returns (out_i_7: int, out_Tmp_402: int, out_Tmp_404: int, out_Tmp_405: int, out_Tmp_406: int, out_Tmp_410: int, out_Tmp_412: int, out_Tmp_413: int, out_Tmp_415: int);
  modifies Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.Virtual__TRANSFER_BUFFER;



implementation FcStartCommand_loop_L39(in_i_8: int, in_Tmp_420: int, in_Tmp_424: int, in_Tmp_430: int, in_ntStatus_12: int, in_Tmp_437: int, in_Tmp_439: int, in_Command_1: int, in_FdoExtension_8: int, in_FifoInBuffer_1: int, in_AllowLongDelay_3: int) returns (out_i_8: int, out_Tmp_420: int, out_Tmp_424: int, out_Tmp_430: int, out_ntStatus_12: int, out_Tmp_437: int, out_Tmp_439: int)
{

  entry:
    out_i_8, out_Tmp_420, out_Tmp_424, out_Tmp_430, out_ntStatus_12, out_Tmp_437, out_Tmp_439 := in_i_8, in_Tmp_420, in_Tmp_424, in_Tmp_430, in_ntStatus_12, in_Tmp_437, in_Tmp_439;
    goto L39, exit;

  L39:
    out_Tmp_439 := BAND(in_Command_1, BOR(BOR(BOR(BOR(1, 2), 4), 8), 16));
    out_Tmp_424 := out_Tmp_439;
    assume {:nonnull} CommandTable != 0;
    assume CommandTable > 0;
    goto anon52_Else;

  L48:
    out_i_8 := out_i_8 + 1;
    goto L48_dummy;

  anon53_Else:
    assume {:partition} BAND(Mem_T.INT4[in_FifoInBuffer_1 + out_Tmp_430 * 4], 128) == 0;
    goto L48;

  anon44_Then:
    assume {:partition} in_Command_1 != 15;
    goto L48;

  anon43_Else:
    assume {:partition} out_ntStatus_12 >= 0;
    out_Tmp_420 := out_i_8;
    assume {:nonnull} in_FifoInBuffer_1 != 0;
    assume in_FifoInBuffer_1 > 0;
    out_Tmp_437 := Mem_T.INT4[in_FifoInBuffer_1 + out_Tmp_420 * 4];
    call out_ntStatus_12 := FcSendByte(out_Tmp_437, in_FdoExtension_8, in_AllowLongDelay_3);
    goto anon44_Then, anon44_Else;

  anon52_Else:
    assume {:partition} Mem_T.NumberOfParameters__COMMAND_TABLE[NumberOfParameters__COMMAND_TABLE(CommandTable + out_Tmp_424 * 28)] >= out_i_8;
    goto anon43_Else;

  anon44_Else:
    assume {:partition} in_Command_1 == 15;
    out_Tmp_430 := out_i_8;
    assume {:nonnull} in_FifoInBuffer_1 != 0;
    assume in_FifoInBuffer_1 > 0;
    goto anon53_Else;

  L48_dummy:
    call {:si_unique_call 1} out_i_8, out_Tmp_420, out_Tmp_424, out_Tmp_430, out_ntStatus_12, out_Tmp_437, out_Tmp_439 := FcStartCommand_loop_L39(out_i_8, out_Tmp_420, out_Tmp_424, out_Tmp_430, out_ntStatus_12, out_Tmp_437, out_Tmp_439, in_Command_1, in_FdoExtension_8, in_FifoInBuffer_1, in_AllowLongDelay_3);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FcStartCommand_loop_L39(in_i_8: int, in_Tmp_420: int, in_Tmp_424: int, in_Tmp_430: int, in_ntStatus_12: int, in_Tmp_437: int, in_Tmp_439: int, in_Command_1: int, in_FdoExtension_8: int, in_FifoInBuffer_1: int, in_AllowLongDelay_3: int) returns (out_i_8: int, out_Tmp_420: int, out_Tmp_424: int, out_Tmp_430: int, out_ntStatus_12: int, out_Tmp_437: int, out_Tmp_439: int);
  modifies Mem_T.HardwareFailed__FDC_FDO_EXTENSION;



implementation FdcEnumerateAcpiBios_loop_L22(in_pdoExtension_2: int, in_sdv_234: int, in_ntStatus_14: int, in_entry_1: int, in_peripheralNumber: int) returns (out_pdoExtension_2: int, out_sdv_234: int, out_entry_1: int)
{

  entry:
    out_pdoExtension_2, out_sdv_234, out_entry_1 := in_pdoExtension_2, in_sdv_234, in_entry_1;
    goto L22, exit;

  L22:
    goto anon38_Else;

  L30:
    assume {:nonnull} out_entry_1 != 0;
    assume out_entry_1 > 0;
    out_entry_1 := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(out_entry_1)];
    goto L30_dummy;

  anon41_Then:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(out_pdoExtension_2)] != 0;
    goto L30;

  anon50_Then:
    assume {:partition} Mem_T.PeripheralNumber__FDC_PDO_EXTENSION[PeripheralNumber__FDC_PDO_EXTENSION(out_pdoExtension_2)] != in_peripheralNumber;
    goto L30;

  anon40_Else:
    assume {:partition} in_ntStatus_14 >= 0;
    call out_sdv_234 := sdv_containing_record(out_entry_1, 20);
    out_pdoExtension_2 := out_sdv_234;
    assume {:nonnull} out_pdoExtension_2 != 0;
    assume out_pdoExtension_2 > 0;
    goto anon50_Then, anon50_Else;

  anon38_Else:
    goto anon40_Else;

  anon50_Else:
    assume {:partition} Mem_T.PeripheralNumber__FDC_PDO_EXTENSION[PeripheralNumber__FDC_PDO_EXTENSION(out_pdoExtension_2)] == in_peripheralNumber;
    assume {:nonnull} out_pdoExtension_2 != 0;
    assume out_pdoExtension_2 > 0;
    goto anon41_Then;

  L30_dummy:
    call {:si_unique_call 1} out_pdoExtension_2, out_sdv_234, out_entry_1 := FdcEnumerateAcpiBios_loop_L22(out_pdoExtension_2, out_sdv_234, in_ntStatus_14, out_entry_1, in_peripheralNumber);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcEnumerateAcpiBios_loop_L22(in_pdoExtension_2: int, in_sdv_234: int, in_ntStatus_14: int, in_entry_1: int, in_peripheralNumber: int) returns (out_pdoExtension_2: int, out_sdv_234: int, out_entry_1: int);



implementation FdcEnumerateAcpiBios_loop_L16(in_newlyPresent: int, in_alreadyEnumerated: int, in_pdoExtension_2: int, in_sdv_234: int, in_ntStatus_14: int, in_fdoExtension_6: int, in_Tmp_456: int, in_newlyMissing: int, in_Tmp_457: int, in_Tmp_459: int, in_entry_1: int, in_Tmp_460: int, in_peripheralNumber: int, in_DeviceObject_32: int) returns (out_newlyPresent: int, out_alreadyEnumerated: int, out_pdoExtension_2: int, out_sdv_234: int, out_ntStatus_14: int, out_Tmp_456: int, out_newlyMissing: int, out_Tmp_457: int, out_Tmp_459: int, out_entry_1: int, out_Tmp_460: int, out_peripheralNumber: int)
{

  entry:
    out_newlyPresent, out_alreadyEnumerated, out_pdoExtension_2, out_sdv_234, out_ntStatus_14, out_Tmp_456, out_newlyMissing, out_Tmp_457, out_Tmp_459, out_entry_1, out_Tmp_460, out_peripheralNumber := in_newlyPresent, in_alreadyEnumerated, in_pdoExtension_2, in_sdv_234, in_ntStatus_14, in_Tmp_456, in_newlyMissing, in_Tmp_457, in_Tmp_459, in_entry_1, in_Tmp_460, in_peripheralNumber;
    goto L16, exit;

  L16:
    assume {:CounterLoop 3} {:Counter "peripheralNumber"} true;
    goto anon37_Else;

  L44:
    out_peripheralNumber := out_peripheralNumber + 1;
    goto L44_dummy;

  anon45_Else:
    assume {:partition} out_newlyPresent != 0;
    call FdcCreateFloppyPdo(in_fdoExtension_6, out_peripheralNumber);
    goto L44;

  anon46_Else:
    assume {:partition} out_newlyMissing != 0;
    assume {:nonnull} out_pdoExtension_2 != 0;
    assume out_pdoExtension_2 > 0;
    Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(out_pdoExtension_2)] := 1;
    goto L44;

  anon46_Then:
    assume {:partition} out_newlyMissing == 0;
    goto L44;

  anon45_Then:
    assume {:partition} out_newlyPresent == 0;
    goto anon46_Then, anon46_Else;

  L39:
    goto anon45_Then, anon45_Else;

  anon51_Else:
    assume {:partition} Mem_T.INT4[out_Tmp_456 + out_Tmp_460 * 4] != 0;
    goto L39;

  anon51_Then:
    assume {:partition} Mem_T.INT4[out_Tmp_456 + out_Tmp_460 * 4] == 0;
    out_newlyMissing := 1;
    goto L39;

  anon47_Else:
    assume {:partition} out_ntStatus_14 < 0;
    out_newlyMissing := 1;
    goto L39;

  anon47_Then:
    assume {:partition} 0 <= out_ntStatus_14;
    goto L39;

  anon44_Then:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(in_fdoExtension_6)] == 0;
    goto L39;

  anon53_Else:
    assume {:partition} Mem_T.INT4[out_Tmp_457 + out_Tmp_459 * 4] != 0;
    out_newlyPresent := 1;
    goto L39;

  anon53_Then:
    assume {:partition} Mem_T.INT4[out_Tmp_457 + out_Tmp_459 * 4] == 0;
    goto L39;

  anon49_Else:
    assume {:partition} out_ntStatus_14 >= 0;
    out_newlyPresent := 1;
    goto L39;

  anon49_Then:
    assume {:partition} 0 > out_ntStatus_14;
    goto L39;

  anon48_Then:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(in_fdoExtension_6)] == 0;
    goto L39;

  anon42_Then:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(in_fdoExtension_6)] == 0;
    assume {:nonnull} in_fdoExtension_6 != 0;
    assume in_fdoExtension_6 > 0;
    goto anon48_Then, anon48_Else;

  anon39_Then:
    assume {:partition} out_alreadyEnumerated == 0;
    assume {:nonnull} in_fdoExtension_6 != 0;
    assume in_fdoExtension_6 > 0;
    goto anon42_Then, anon42_Else;

  L23:
    goto anon39_Then, anon39_Else;

  anon41_Else:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(out_pdoExtension_2)] == 0;
    out_alreadyEnumerated := 1;
    goto L23;

  anon40_Then:
    assume {:partition} 0 > out_ntStatus_14;
    goto L23;

  anon38_Then:
    goto L23;

  L22:
    call out_pdoExtension_2, out_sdv_234, out_entry_1 := FdcEnumerateAcpiBios_loop_L22(out_pdoExtension_2, out_sdv_234, out_ntStatus_14, out_entry_1, out_peripheralNumber);
    goto L22_last;

  L22_last:
    goto anon38_Then, anon38_Else;

  anon37_Else:
    assume {:partition} 3 >= out_peripheralNumber;
    out_alreadyEnumerated := 0;
    out_newlyMissing := 0;
    out_newlyPresent := 0;
    assume {:nonnull} in_fdoExtension_6 != 0;
    assume in_fdoExtension_6 > 0;
    out_entry_1 := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(PDOs__FDC_FDO_EXTENSION(in_fdoExtension_6))];
    goto L22;

  L30:
    assume {:nonnull} out_entry_1 != 0;
    assume out_entry_1 > 0;
    out_entry_1 := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(out_entry_1)];
    assume false;
    return;

  anon41_Then:
    assume {:partition} Mem_T.ReportedMissing__FDC_PDO_EXTENSION[ReportedMissing__FDC_PDO_EXTENSION(out_pdoExtension_2)] != 0;
    goto L30;

  anon50_Then:
    assume {:partition} Mem_T.PeripheralNumber__FDC_PDO_EXTENSION[PeripheralNumber__FDC_PDO_EXTENSION(out_pdoExtension_2)] != out_peripheralNumber;
    goto L30;

  anon40_Else:
    assume {:partition} out_ntStatus_14 >= 0;
    call out_sdv_234 := sdv_containing_record(out_entry_1, 20);
    out_pdoExtension_2 := out_sdv_234;
    assume {:nonnull} out_pdoExtension_2 != 0;
    assume out_pdoExtension_2 > 0;
    goto anon50_Then, anon50_Else;

  anon38_Else:
    goto anon40_Then, anon40_Else;

  anon50_Else:
    assume {:partition} Mem_T.PeripheralNumber__FDC_PDO_EXTENSION[PeripheralNumber__FDC_PDO_EXTENSION(out_pdoExtension_2)] == out_peripheralNumber;
    assume {:nonnull} out_pdoExtension_2 != 0;
    assume out_pdoExtension_2 > 0;
    goto anon41_Then, anon41_Else;

  anon54_Else:
    assume {:partition} yogi_error != 1;
    goto anon49_Then, anon49_Else;

  anon48_Else:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(in_fdoExtension_6)] != 0;
    call out_ntStatus_14 := FdcProbeFloppyDevice(in_DeviceObject_32, out_peripheralNumber);
    goto anon54_Else;

  anon42_Else:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(in_fdoExtension_6)] != 0;
    out_Tmp_459 := out_peripheralNumber;
    assume {:nonnull} in_fdoExtension_6 != 0;
    assume in_fdoExtension_6 > 0;
    out_Tmp_457 := Mem_T.DrivePresent__ACPI_FDE_ENUM_TABLE[DrivePresent__ACPI_FDE_ENUM_TABLE(ACPI_FDE_Data__FDC_FDO_EXTENSION(in_fdoExtension_6))];
    assume {:nonnull} out_Tmp_457 != 0;
    assume out_Tmp_457 > 0;
    goto anon53_Then, anon53_Else;

  anon43_Then:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(in_fdoExtension_6)] == 0;
    assume {:nonnull} in_fdoExtension_6 != 0;
    assume in_fdoExtension_6 > 0;
    goto anon44_Then, anon44_Else;

  anon39_Else:
    assume {:partition} out_alreadyEnumerated != 0;
    assume {:nonnull} in_fdoExtension_6 != 0;
    assume in_fdoExtension_6 > 0;
    goto anon43_Then, anon43_Else;

  anon52_Else:
    assume {:partition} yogi_error != 1;
    goto anon47_Then, anon47_Else;

  anon44_Else:
    assume {:partition} Mem_T.ProbeFloppyDevices__FDC_FDO_EXTENSION[ProbeFloppyDevices__FDC_FDO_EXTENSION(in_fdoExtension_6)] != 0;
    call out_ntStatus_14 := FdcProbeFloppyDevice(in_DeviceObject_32, out_peripheralNumber);
    goto anon52_Else;

  anon43_Else:
    assume {:partition} Mem_T.ACPI_FDE_Valid__FDC_FDO_EXTENSION[ACPI_FDE_Valid__FDC_FDO_EXTENSION(in_fdoExtension_6)] != 0;
    out_Tmp_460 := out_peripheralNumber;
    assume {:nonnull} in_fdoExtension_6 != 0;
    assume in_fdoExtension_6 > 0;
    out_Tmp_456 := Mem_T.DrivePresent__ACPI_FDE_ENUM_TABLE[DrivePresent__ACPI_FDE_ENUM_TABLE(ACPI_FDE_Data__FDC_FDO_EXTENSION(in_fdoExtension_6))];
    assume {:nonnull} out_Tmp_456 != 0;
    assume out_Tmp_456 > 0;
    goto anon51_Then, anon51_Else;

  L44_dummy:
    call {:si_unique_call 1} out_newlyPresent, out_alreadyEnumerated, out_pdoExtension_2, out_sdv_234, out_ntStatus_14, out_Tmp_456, out_newlyMissing, out_Tmp_457, out_Tmp_459, out_entry_1, out_Tmp_460, out_peripheralNumber := FdcEnumerateAcpiBios_loop_L16(out_newlyPresent, out_alreadyEnumerated, out_pdoExtension_2, out_sdv_234, out_ntStatus_14, in_fdoExtension_6, out_Tmp_456, out_newlyMissing, out_Tmp_457, out_Tmp_459, out_entry_1, out_Tmp_460, out_peripheralNumber, in_DeviceObject_32);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcEnumerateAcpiBios_loop_L16(in_newlyPresent: int, in_alreadyEnumerated: int, in_pdoExtension_2: int, in_sdv_234: int, in_ntStatus_14: int, in_fdoExtension_6: int, in_Tmp_456: int, in_newlyMissing: int, in_Tmp_457: int, in_Tmp_459: int, in_entry_1: int, in_Tmp_460: int, in_peripheralNumber: int, in_DeviceObject_32: int) returns (out_newlyPresent: int, out_alreadyEnumerated: int, out_pdoExtension_2: int, out_sdv_234: int, out_ntStatus_14: int, out_Tmp_456: int, out_newlyMissing: int, out_Tmp_457: int, out_Tmp_459: int, out_entry_1: int, out_Tmp_460: int, out_peripheralNumber: int);
  modifies alloc, Mem_T.INT4, Mem_T.TargetObject__FDC_PDO_EXTENSION, Mem_T.IsFDO__FDC_EXTENSION_HEADER, Mem_T.Self__FDC_EXTENSION_HEADER, Mem_T.DeviceType__FDC_PDO_EXTENSION, Mem_T.ParentFdo__FDC_PDO_EXTENSION, Mem_T.Removed__FDC_PDO_EXTENSION, Mem_T.ReportedMissing__FDC_PDO_EXTENSION, Mem_T.PeripheralNumber__FDC_PDO_EXTENSION, Mem_T.Flags__DEVICE_OBJECT, Mem_T.StackSize__DEVICE_OBJECT, Mem_T.NumPDOs__FDC_FDO_EXTENSION, Mem_T.Length_unnamed_tag_18, sdv_io_create_device_called, Mem_T.P_DEVICE_OBJECT, Mem_T.DriveOnValue__FDC_ENABLE_PARMS, Mem_T.TimeToWait__FDC_ENABLE_PARMS, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, Mem_T.Status__IO_STATUS_BLOCK, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, Mem_T.Type3InputBuffer_unnamed_tag_22, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, sdv_isr_routine, sdv_pDpcContext, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, yogi_error;



implementation FdcFdoPnp_loop_L130(in_pdoExtension_4: int, in_sdv_284: int, in_entry_2: int) returns (out_pdoExtension_4: int, out_sdv_284: int, out_entry_2: int)
{

  entry:
    out_pdoExtension_4, out_sdv_284, out_entry_2 := in_pdoExtension_4, in_sdv_284, in_entry_2;
    goto L130, exit;

  L130:
    goto anon70_Else;

  anon70_Else:
    call out_sdv_284 := sdv_containing_record(out_entry_2, 20);
    out_pdoExtension_4 := out_sdv_284;
    assume {:nonnull} out_entry_2 != 0;
    assume out_entry_2 > 0;
    out_entry_2 := Mem_T.Flink__LIST_ENTRY[Flink__LIST_ENTRY(out_entry_2)];
    assume {:nonnull} out_pdoExtension_4 != 0;
    assume out_pdoExtension_4 > 0;
    Mem_T.Removed__FDC_PDO_EXTENSION[Removed__FDC_PDO_EXTENSION(out_pdoExtension_4)] := 1;
    call IoDeleteDevice(0);
    goto anon70_Else_dummy;

  anon70_Else_dummy:
    call {:si_unique_call 1} out_pdoExtension_4, out_sdv_284, out_entry_2 := FdcFdoPnp_loop_L130(out_pdoExtension_4, out_sdv_284, out_entry_2);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFdoPnp_loop_L130(in_pdoExtension_4: int, in_sdv_284: int, in_entry_2: int) returns (out_pdoExtension_4: int, out_sdv_284: int, out_entry_2: int);
  modifies Mem_T.Removed__FDC_PDO_EXTENSION, alloc;



implementation FdcFdoInternalDeviceControl_loop_L33(in_issueCommandParms_2: int, in_sdv_308: int, in_Tmp_521: int, in_powerQueueClear: int, in_irpSp_15: int, in_Tmp_522: int, in_Tmp_523: int, in_deferredRequest: int, in_fdcDiskChangeParms: int, in_Tmp_524: int, in_sdv_313: int, in_adapterBufferParms: int, in_Tmp_525: int, in_sdv_315: int, in_ntStatus_20: int, in_fdoExtension_11: int, in_currentIrp: int, in_ioControlCode: int, in_tapeMode: int, in_fdcModeSelect: int, in_DeviceObject_38: int, in_Irp_24: int, in_boogieTmp: int, in_vslice_dummy_var_138: int) returns (out_issueCommandParms_2: int, out_sdv_308: int, out_Tmp_521: int, out_powerQueueClear: int, out_irpSp_15: int, out_Tmp_522: int, out_Tmp_523: int, out_deferredRequest: int, out_fdcDiskChangeParms: int, out_Tmp_524: int, out_sdv_313: int, out_adapterBufferParms: int, out_Tmp_525: int, out_sdv_315: int, out_ntStatus_20: int, out_currentIrp: int, out_ioControlCode: int, out_tapeMode: int, out_boogieTmp: int, out_vslice_dummy_var_138: int)
{

  entry:
    out_issueCommandParms_2, out_sdv_308, out_Tmp_521, out_powerQueueClear, out_irpSp_15, out_Tmp_522, out_Tmp_523, out_deferredRequest, out_fdcDiskChangeParms, out_Tmp_524, out_sdv_313, out_adapterBufferParms, out_Tmp_525, out_sdv_315, out_ntStatus_20, out_currentIrp, out_ioControlCode, out_tapeMode, out_boogieTmp, out_vslice_dummy_var_138 := in_issueCommandParms_2, in_sdv_308, in_Tmp_521, in_powerQueueClear, in_irpSp_15, in_Tmp_522, in_Tmp_523, in_deferredRequest, in_fdcDiskChangeParms, in_Tmp_524, in_sdv_313, in_adapterBufferParms, in_Tmp_525, in_sdv_315, in_ntStatus_20, in_currentIrp, in_ioControlCode, in_tapeMode, in_boogieTmp, in_vslice_dummy_var_138;
    goto L33, exit;

  L33:
    call out_deferredRequest := sdv_ExInterlockedRemoveHeadList(0, 0);
    goto anon99_Then, anon99_Else;

  anon103_Then:
    assume {:partition} out_powerQueueClear == 0;
    goto anon103_Then_dummy;

  L79:
    goto anon103_Then;

  L87:
    assume {:nonnull} out_currentIrp != 0;
    assume out_currentIrp > 0;
    Mem_T.Status__IO_STATUS_BLOCK[Status__IO_STATUS_BLOCK(IoStatus__IRP(out_currentIrp))] := out_ntStatus_20;
    call sdv_IoCompleteRequest(0, 1);
    goto L79;

  anon102_Then:
    assume {:partition} out_ntStatus_20 == 259;
    goto L79;

  L78:
    goto anon102_Then, anon102_Else;

  L77:
    out_ntStatus_20 := -1073741808;
    goto L78;

  anon135_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon133_Then:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(in_fdoExtension_11)] == 0;
    goto L78;

  anon111_Then:
    assume {:partition} out_ioControlCode != 461887;
    out_ntStatus_20 := -1073741808;
    goto L78;

  L141:
    out_ntStatus_20 := 0;
    goto L78;

  anon131_Else:
    assume {:partition} Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(out_adapterBufferParms)] != 0;
    out_ntStatus_20 := 0;
    goto L78;

  anon131_Then:
    assume {:partition} Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(out_adapterBufferParms)] == 0;
    out_ntStatus_20 := -1073741670;
    goto L78;

  anon115_Then:
    assume {:partition} out_ioControlCode == 461871;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_ntStatus_20 := 0;
    goto L78;

  anon116_Then:
    assume {:partition} out_ioControlCode == 461867;
    call out_tapeMode := corral_nondet();
    out_tapeMode := BAND(out_tapeMode, BOR(BOR(BOR(BOR(BOR(4, 8), 16), 32), 64), 128));
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_Tmp_523 := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))];
    assume {:nonnull} out_Tmp_523 != 0;
    assume out_Tmp_523 > 0;
    out_tapeMode := BOR(out_tapeMode, Mem_T.INT4[out_Tmp_523]);
    out_ntStatus_20 := 0;
    goto L78;

  anon117_Then:
    assume {:partition} out_ioControlCode == 461863;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_ntStatus_20 := 0;
    goto L78;

  L181:
    out_ntStatus_20 := 0;
    goto L78;

  anon119_Then:
    assume {:partition} out_ioControlCode == 461855;
    call out_ntStatus_20 := FcTurnOffMotor(in_fdoExtension_11);
    goto L78;

  anon120_Then:
    assume {:partition} out_ioControlCode == 461851;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_Tmp_521 := DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15));
    assume {:nonnull} out_Tmp_521 != 0;
    assume out_Tmp_521 > 0;
    call out_ntStatus_20 := FcTurnOnMotor(in_fdoExtension_11, Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(out_Tmp_521)]);
    goto L78;

  anon130_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon122_Then:
    assume {:partition} out_ioControlCode == 461843;
    call sdv_IoMarkIrpPending(0);
    call IoStartPacket(0, 0, 0, 0);
    out_ntStatus_20 := 259;
    goto L78;

  anon129_Else:
    assume {:partition} yogi_error != 1;
    goto L78;

  anon109_Else:
    assume {:partition} out_ntStatus_20 >= 0;
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    Mem_T.LastDeviceObject__FDC_FDO_EXTENSION[LastDeviceObject__FDC_FDO_EXTENSION(in_fdoExtension_11)] := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))];
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION[TapeEnumerationPending__FDC_FDO_EXTENSION(in_fdoExtension_11)] := 0;
    goto L78;

  anon109_Then:
    assume {:partition} 0 > out_ntStatus_20;
    goto L78;

  anon110_Else:
    assume {:partition} out_ntStatus_20 >= 0;
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))] := Mem_T.LastDeviceObject__FDC_FDO_EXTENSION[LastDeviceObject__FDC_FDO_EXTENSION(in_fdoExtension_11)];
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION[TapeEnumerationPending__FDC_FDO_EXTENSION(in_fdoExtension_11)] := 1;
    goto L78;

  anon110_Then:
    assume {:partition} 0 > out_ntStatus_20;
    goto L78;

  anon106_Else:
    assume {:partition} out_ioControlCode != 461827;
    out_ntStatus_20 := -1073741808;
    goto L78;

  anon105_Then:
    assume {:partition} Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(in_fdoExtension_11)] == 0;
    goto anon106_Then, anon106_Else;

  anon101_Else:
    assume {:partition} out_ioControlCode != 461835;
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    goto anon105_Then, anon105_Else;

  anon126_Then:
    assume {:partition} out_ioControlCode != 461891;
    goto anon101_Then, anon101_Else;

  L70:
    call out_irpSp_15 := sdv_IoGetCurrentIrpStackLocation(out_currentIrp);
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_ioControlCode := Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))];
    goto anon126_Then, anon126_Else;

  anon99_Else:
    call out_sdv_313 := sdv_containing_record(out_deferredRequest, 88);
    out_currentIrp := out_sdv_313;
    goto L70;

  anon100_Else:
    assume {:partition} in_Irp_24 != 0;
    out_currentIrp := in_Irp_24;
    out_powerQueueClear := 1;
    goto L70;

  anon99_Then:
    goto anon100_Else;

  anon127_Else:
    assume {:partition} yogi_error != 1;
    goto anon110_Then, anon110_Else;

  anon107_Then:
    assume {:partition} out_ioControlCode == 461827;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_Tmp_524 := DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15));
    assume {:nonnull} out_Tmp_524 != 0;
    assume out_Tmp_524 > 0;
    call out_ntStatus_20 := FcAcquireFdc(in_fdoExtension_11, Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(out_Tmp_524)]);
    goto anon127_Else;

  L94:
    goto anon107_Then, anon107_Else;

  anon105_Else:
    assume {:partition} Mem_T.ControllerInUse__FDC_FDO_EXTENSION[ControllerInUse__FDC_FDO_EXTENSION(in_fdoExtension_11)] != 0;
    goto L94;

  anon106_Then:
    assume {:partition} out_ioControlCode == 461827;
    goto L94;

  anon128_Else:
    assume {:partition} yogi_error != 1;
    goto anon109_Then, anon109_Else;

  anon124_Then:
    assume {:partition} out_ioControlCode == 461831;
    call out_ntStatus_20 := FcReleaseFdc(in_fdoExtension_11);
    goto anon128_Else;

  anon107_Else:
    assume {:partition} out_ioControlCode != 461827;
    goto anon124_Then, anon124_Else;

  anon123_Then:
    assume {:partition} out_ioControlCode == 461839;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_issueCommandParms_2 := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))];
    assume {:nonnull} out_issueCommandParms_2 != 0;
    assume out_issueCommandParms_2 > 0;
    call out_ntStatus_20 := FcIssueCommand(in_fdoExtension_11, Mem_T.FifoInBuffer__ISSUE_FDC_COMMAND_PARMS[FifoInBuffer__ISSUE_FDC_COMMAND_PARMS(out_issueCommandParms_2)], Mem_T.FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS[FifoOutBuffer__ISSUE_FDC_COMMAND_PARMS(out_issueCommandParms_2)], Mem_T.IoHandle__ISSUE_FDC_COMMAND_PARMS[IoHandle__ISSUE_FDC_COMMAND_PARMS(out_issueCommandParms_2)], Mem_T.IoOffset__ISSUE_FDC_COMMAND_PARMS[IoOffset__ISSUE_FDC_COMMAND_PARMS(out_issueCommandParms_2)], Mem_T.TransferBytes__ISSUE_FDC_COMMAND_PARMS[TransferBytes__ISSUE_FDC_COMMAND_PARMS(out_issueCommandParms_2)]);
    goto anon129_Else;

  anon124_Else:
    assume {:partition} out_ioControlCode != 461831;
    goto anon123_Then, anon123_Else;

  anon123_Else:
    assume {:partition} out_ioControlCode != 461839;
    goto anon122_Then, anon122_Else;

  anon121_Then:
    assume {:partition} out_ioControlCode == 461847;
    call out_ntStatus_20 := FcInitializeControllerHardware(in_fdoExtension_11, in_DeviceObject_38);
    goto anon130_Else;

  anon122_Else:
    assume {:partition} out_ioControlCode != 461843;
    goto anon121_Then, anon121_Else;

  anon121_Else:
    assume {:partition} out_ioControlCode != 461847;
    goto anon120_Then, anon120_Else;

  anon120_Else:
    assume {:partition} out_ioControlCode != 461851;
    goto anon119_Then, anon119_Else;

  anon108_Else:
    assume {:partition} Mem_T.WakeUp__FDC_FDO_EXTENSION[WakeUp__FDC_FDO_EXTENSION(in_fdoExtension_11)] != 0;
    assume {:nonnull} out_fdcDiskChangeParms != 0;
    assume out_fdcDiskChangeParms > 0;
    Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS[DriveStatus__FDC_DISK_CHANGE_PARMS(out_fdcDiskChangeParms)] := BOR(Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS[DriveStatus__FDC_DISK_CHANGE_PARMS(out_fdcDiskChangeParms)], 128);
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    Mem_T.WakeUp__FDC_FDO_EXTENSION[WakeUp__FDC_FDO_EXTENSION(in_fdoExtension_11)] := 0;
    goto L181;

  anon108_Then:
    assume {:partition} Mem_T.WakeUp__FDC_FDO_EXTENSION[WakeUp__FDC_FDO_EXTENSION(in_fdoExtension_11)] == 0;
    goto L181;

  anon118_Then:
    assume {:partition} out_ioControlCode == 461859;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_fdcDiskChangeParms := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))];
    assume {:nonnull} out_fdcDiskChangeParms != 0;
    assume out_fdcDiskChangeParms > 0;
    call out_boogieTmp := corral_nondet();
    Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS[DriveStatus__FDC_DISK_CHANGE_PARMS(out_fdcDiskChangeParms)] := out_boogieTmp;
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    goto anon108_Then, anon108_Else;

  anon119_Else:
    assume {:partition} out_ioControlCode != 461855;
    goto anon118_Then, anon118_Else;

  anon118_Else:
    assume {:partition} out_ioControlCode != 461859;
    goto anon117_Then, anon117_Else;

  anon117_Else:
    assume {:partition} out_ioControlCode != 461863;
    goto anon116_Then, anon116_Else;

  anon116_Else:
    assume {:partition} out_ioControlCode != 461867;
    goto anon115_Then, anon115_Else;

  anon114_Then:
    assume {:partition} out_ioControlCode == 461875;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_adapterBufferParms := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))];
    assume {:nonnull} out_adapterBufferParms != 0;
    assume out_adapterBufferParms > 0;
    out_Tmp_525 := Mem_T.TransferBytes__ISSUE_FDC_ADAPTER_BUFFER_PARMS[TransferBytes__ISSUE_FDC_ADAPTER_BUFFER_PARMS(out_adapterBufferParms)];
    call out_sdv_308 := IoAllocateMdl(0, out_Tmp_525, 0, 0, 0);
    assume {:nonnull} out_adapterBufferParms != 0;
    assume out_adapterBufferParms > 0;
    Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(out_adapterBufferParms)] := out_sdv_308;
    assume {:nonnull} out_adapterBufferParms != 0;
    assume out_adapterBufferParms > 0;
    goto anon131_Then, anon131_Else;

  anon115_Else:
    assume {:partition} out_ioControlCode != 461871;
    goto anon114_Then, anon114_Else;

  anon132_Else:
    assume {:partition} Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(out_adapterBufferParms)] != 0;
    call IoFreeMdl(0);
    goto L141;

  anon132_Then:
    assume {:partition} Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS[Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS(out_adapterBufferParms)] == 0;
    goto L141;

  anon113_Then:
    assume {:partition} out_ioControlCode == 461879;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    out_adapterBufferParms := Mem_T.Type3InputBuffer_unnamed_tag_22[Type3InputBuffer_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))];
    assume {:nonnull} out_adapterBufferParms != 0;
    assume out_adapterBufferParms > 0;
    goto anon132_Then, anon132_Else;

  anon114_Else:
    assume {:partition} out_ioControlCode != 461875;
    goto anon113_Then, anon113_Else;

  anon112_Else:
    assume {:partition} out_ioControlCode != 461883;
    goto anon111_Then, anon111_Else;

  anon113_Else:
    assume {:partition} out_ioControlCode != 461879;
    goto anon112_Then, anon112_Else;

  L123:
    out_ntStatus_20 := 0;
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    goto anon133_Then, anon133_Else;

  anon111_Else:
    assume {:partition} out_ioControlCode == 461887;
    goto L123;

  anon112_Then:
    assume {:partition} out_ioControlCode == 461883;
    goto L123;

  L136:
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    call out_ntStatus_20 := FcFdcEnabler(Mem_T.FdcEnablerDeviceObject__FDC_FDO_EXTENSION[FdcEnablerDeviceObject__FDC_FDO_EXTENSION(in_fdoExtension_11)], 2031635, in_fdcModeSelect);
    goto anon135_Else;

  anon134_Else:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))] == 461883;
    assume {:nonnull} in_fdcModeSelect != 0;
    assume in_fdcModeSelect > 0;
    goto L136;

  anon134_Then:
    assume {:partition} Mem_T.IoControlCode_unnamed_tag_22[IoControlCode_unnamed_tag_22(DeviceIoControl_unnamed_tag_8(Parameters__IO_STACK_LOCATION(out_irpSp_15)))] != 461883;
    assume {:nonnull} in_fdcModeSelect != 0;
    assume in_fdcModeSelect > 0;
    goto L136;

  anon133_Else:
    assume {:partition} Mem_T.INT4[FdcEnablerSupported__FDC_FDO_EXTENSION(in_fdoExtension_11)] != 0;
    assume {:nonnull} in_fdcModeSelect != 0;
    assume in_fdcModeSelect > 0;
    assume {:nonnull} in_fdcModeSelect != 0;
    assume in_fdcModeSelect > 0;
    assume {:nonnull} in_fdcModeSelect != 0;
    assume in_fdcModeSelect > 0;
    assume {:nonnull} in_fdcModeSelect != 0;
    assume in_fdcModeSelect > 0;
    assume {:nonnull} in_fdcModeSelect != 0;
    assume in_fdcModeSelect > 0;
    assume {:nonnull} in_fdcModeSelect != 0;
    assume in_fdcModeSelect > 0;
    assume {:nonnull} out_irpSp_15 != 0;
    assume out_irpSp_15 > 0;
    goto anon134_Then, anon134_Else;

  anon126_Else:
    assume {:partition} out_ioControlCode == 461891;
    goto L77;

  anon101_Then:
    assume {:partition} out_ioControlCode == 461835;
    goto L77;

  anon104_Else:
    assume {:partition} out_sdv_315 != 0;
    goto L87;

  anon104_Then:
    assume {:partition} out_sdv_315 == 0;
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    call out_vslice_dummy_var_138 := KeSetEvent(RemoveEvent__FDC_FDO_EXTENSION(in_fdoExtension_11), 0, 0);
    goto L87;

  anon102_Else:
    assume {:partition} out_ntStatus_20 != 259;
    call out_Tmp_522 := __HAVOC_malloc(4);
    assume {:nonnull} out_Tmp_522 != 0;
    assume out_Tmp_522 > 0;
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    Mem_T.INT4[out_Tmp_522] := Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(in_fdoExtension_11)];
    call out_sdv_315 := sdv_InterlockedDecrement(out_Tmp_522);
    assume {:nonnull} out_Tmp_522 != 0;
    assume out_Tmp_522 > 0;
    assume {:nonnull} in_fdoExtension_11 != 0;
    assume in_fdoExtension_11 > 0;
    Mem_T.OutstandingRequests__FDC_FDO_EXTENSION[OutstandingRequests__FDC_FDO_EXTENSION(in_fdoExtension_11)] := Mem_T.INT4[out_Tmp_522];
    goto anon104_Then, anon104_Else;

  anon103_Then_dummy:
    call {:si_unique_call 1} out_issueCommandParms_2, out_sdv_308, out_Tmp_521, out_powerQueueClear, out_irpSp_15, out_Tmp_522, out_Tmp_523, out_deferredRequest, out_fdcDiskChangeParms, out_Tmp_524, out_sdv_313, out_adapterBufferParms, out_Tmp_525, out_sdv_315, out_ntStatus_20, out_currentIrp, out_ioControlCode, out_tapeMode, out_boogieTmp, out_vslice_dummy_var_138 := FdcFdoInternalDeviceControl_loop_L33(out_issueCommandParms_2, out_sdv_308, out_Tmp_521, out_powerQueueClear, out_irpSp_15, out_Tmp_522, out_Tmp_523, out_deferredRequest, out_fdcDiskChangeParms, out_Tmp_524, out_sdv_313, out_adapterBufferParms, out_Tmp_525, out_sdv_315, out_ntStatus_20, in_fdoExtension_11, out_currentIrp, out_ioControlCode, out_tapeMode, in_fdcModeSelect, in_DeviceObject_38, in_Irp_24, out_boogieTmp, out_vslice_dummy_var_138);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcFdoInternalDeviceControl_loop_L33(in_issueCommandParms_2: int, in_sdv_308: int, in_Tmp_521: int, in_powerQueueClear: int, in_irpSp_15: int, in_Tmp_522: int, in_Tmp_523: int, in_deferredRequest: int, in_fdcDiskChangeParms: int, in_Tmp_524: int, in_sdv_313: int, in_adapterBufferParms: int, in_Tmp_525: int, in_sdv_315: int, in_ntStatus_20: int, in_fdoExtension_11: int, in_currentIrp: int, in_ioControlCode: int, in_tapeMode: int, in_fdcModeSelect: int, in_DeviceObject_38: int, in_Irp_24: int, in_boogieTmp: int, in_vslice_dummy_var_138: int) returns (out_issueCommandParms_2: int, out_sdv_308: int, out_Tmp_521: int, out_powerQueueClear: int, out_irpSp_15: int, out_Tmp_522: int, out_Tmp_523: int, out_deferredRequest: int, out_fdcDiskChangeParms: int, out_Tmp_524: int, out_sdv_313: int, out_adapterBufferParms: int, out_Tmp_525: int, out_sdv_315: int, out_ntStatus_20: int, out_currentIrp: int, out_ioControlCode: int, out_tapeMode: int, out_boogieTmp: int, out_vslice_dummy_var_138: int);
  modifies alloc, Mem_T.Status__IO_STATUS_BLOCK, Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.CurrentInterrupt__FDC_FDO_EXTENSION, Mem_T.LastDeviceObject__FDC_FDO_EXTENSION, Mem_T.TapeEnumerationPending__FDC_FDO_EXTENSION, Mem_T.Type3InputBuffer_unnamed_tag_22, Mem_T.Type_unnamed_tag_28, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.MajorFunction__IO_STACK_LOCATION, sdv_IoBuildDeviceIoControlRequest_IoStatusBlock, sdv_irql_previous_5, sdv_irql_previous_4, sdv_irql_previous_3, sdv_irql_previous_2, sdv_irql_previous, sdv_irql_current, PagingReferenceCount, Mem_T.AdapterChannelRefCount__FDC_FDO_EXTENSION, Mem_T.INT4, sdv_isr_routine, sdv_pDpcContext, Mem_T.ControllerInUse__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, Mem_T.DriveStatus__FDC_DISK_CHANGE_PARMS, Mem_T.WakeUp__FDC_FDO_EXTENSION, Mem_T.Handle__ISSUE_FDC_ADAPTER_BUFFER_PARMS, Mem_T.OutstandingRequests__FDC_FDO_EXTENSION, yogi_error;



implementation FdcInterruptService_loop_L104(in_i_9: int, in_statusByte: int) returns (out_i_9: int, out_statusByte: int)
{

  entry:
    out_i_9, out_statusByte := in_i_9, in_statusByte;
    goto L104, exit;

  L104:
    assume {:CounterLoop 50} {:Counter "i_9"} true;
    goto anon34_Else;

  anon36_Else:
    assume {:partition} BAND(out_statusByte, 16) == 0;
    out_i_9 := out_i_9 - 1;
    goto anon36_Else_dummy;

  anon34_Else:
    assume {:partition} out_i_9 != 0;
    call out_statusByte := corral_nondet();
    goto anon36_Else;

  anon36_Else_dummy:
    havoc out_i_9;
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcInterruptService_loop_L104(in_i_9: int, in_statusByte: int) returns (out_i_9: int, out_statusByte: int);



implementation FdcInterruptService_loop_L138(in_i_9: int, in_Tmp_532: int, in_statusByte: int) returns (out_i_9: int, out_Tmp_532: int, out_statusByte: int)
{

  entry:
    out_i_9, out_Tmp_532, out_statusByte := in_i_9, in_Tmp_532, in_statusByte;
    goto L138, exit;

  L138:
    call out_statusByte := corral_nondet();
    out_i_9 := out_i_9 + 1;
    goto anon40_Else;

  anon33_Else:
    assume {:partition} BAND(out_statusByte, 16) != 0;
    goto anon33_Else_dummy;

  anon40_Else:
    assume {:partition} 25 > out_i_9;
    goto anon33_Then, anon33_Else;

  anon33_Else_dummy:
    goto L_BAF_2;

  anon41_Else:
    assume {:partition} out_Tmp_532 != 128;
    goto anon41_Else_dummy;

  anon33_Then:
    assume {:partition} BAND(out_statusByte, 16) == 0;
    out_Tmp_532 := BAND(out_statusByte, BOR(64, 128));
    goto anon41_Else;

  anon41_Else_dummy:
    goto L_BAF_2;

  exit:
    return;

  L_BAF_2:
    havoc out_i_9;
    return;
}



procedure {:LoopProcedure} FdcInterruptService_loop_L138(in_i_9: int, in_Tmp_532: int, in_statusByte: int) returns (out_i_9: int, out_Tmp_532: int, out_statusByte: int);



implementation FdcCreateFloppyPdo_loop_L11(in_Tmp_540: int, in_ntStatus_23: int, in_nameIndex: int, in_pdoNameBuffer: int, in_pdoName: int, in_newPdo: int, in_FdoExtension_16: int, in_vslice_dummy_var_149: int) returns (out_Tmp_540: int, out_ntStatus_23: int, out_nameIndex: int, out_vslice_dummy_var_149: int)
{

  entry:
    out_Tmp_540, out_ntStatus_23, out_nameIndex, out_vslice_dummy_var_149 := in_Tmp_540, in_ntStatus_23, in_nameIndex, in_vslice_dummy_var_149;
    goto L11, exit;

  L11:
    out_Tmp_540 := out_nameIndex;
    out_nameIndex := out_nameIndex + 1;
    call out_vslice_dummy_var_149 := corral_nondet();
    call RtlInitUnicodeString(in_pdoName, in_pdoNameBuffer);
    assume {:nonnull} in_FdoExtension_16 != 0;
    assume in_FdoExtension_16 > 0;
    call out_ntStatus_23 := IoCreateDevice(0, 40, 0, 45, 256, 0, in_newPdo);
    goto anon5_Then;

  anon5_Then:
    assume {:partition} out_ntStatus_23 == -1073741771;
    goto anon5_Then_dummy;

  anon5_Then_dummy:
    call {:si_unique_call 1} out_Tmp_540, out_ntStatus_23, out_nameIndex, out_vslice_dummy_var_149 := FdcCreateFloppyPdo_loop_L11(out_Tmp_540, out_ntStatus_23, out_nameIndex, in_pdoNameBuffer, in_pdoName, in_newPdo, in_FdoExtension_16, out_vslice_dummy_var_149);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FdcCreateFloppyPdo_loop_L11(in_Tmp_540: int, in_ntStatus_23: int, in_nameIndex: int, in_pdoNameBuffer: int, in_pdoName: int, in_newPdo: int, in_FdoExtension_16: int, in_vslice_dummy_var_149: int) returns (out_Tmp_540: int, out_ntStatus_23: int, out_nameIndex: int, out_vslice_dummy_var_149: int);
  modifies alloc, Mem_T.Length_unnamed_tag_18, sdv_io_create_device_called, Mem_T.P_DEVICE_OBJECT, Mem_T.Flags__DEVICE_OBJECT;



implementation FcInitializeControllerHardware_loop_L11(in_Tmp_554: int, in_Tmp_555: int, in_Tmp_556: int, in_retrycnt: int, in_Tmp_557: int, in_ntStatus_25: int, in_Tmp_558: int, in_Tmp_559: int, in_FdoExtension_17: int, in_DeviceObject_42: int, in_vslice_dummy_var_153: int) returns (out_Tmp_554: int, out_Tmp_555: int, out_Tmp_556: int, out_retrycnt: int, out_Tmp_557: int, out_ntStatus_25: int, out_Tmp_558: int, out_Tmp_559: int, out_vslice_dummy_var_153: int)
{

  entry:
    out_Tmp_554, out_Tmp_555, out_Tmp_556, out_retrycnt, out_Tmp_557, out_ntStatus_25, out_Tmp_558, out_Tmp_559, out_vslice_dummy_var_153 := in_Tmp_554, in_Tmp_555, in_Tmp_556, in_retrycnt, in_Tmp_557, in_ntStatus_25, in_Tmp_558, in_Tmp_559, in_vslice_dummy_var_153;
    goto L11, exit;

  L11:
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(in_FdoExtension_17)] := BOR(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(in_FdoExtension_17)], 8);
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(in_FdoExtension_17)] := BAND(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(in_FdoExtension_17)], BNOT(4));
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION[CurrentDeviceObject__FDC_FDO_EXTENSION(in_FdoExtension_17)] := in_DeviceObject_42;
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION[AllowInterruptProcessing__FDC_FDO_EXTENSION(in_FdoExtension_17)] := 1;
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION[CommandHasResultPhase__FDC_FDO_EXTENSION(in_FdoExtension_17)] := 0;
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    call out_vslice_dummy_var_153 := KeResetEvent(InterruptEvent__FDC_FDO_EXTENSION(in_FdoExtension_17));
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(in_FdoExtension_17)] := BOR(Mem_T.DriveControlImage__FDC_FDO_EXTENSION[DriveControlImage__FDC_FDO_EXTENSION(in_FdoExtension_17)], 4);
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    call out_ntStatus_25 := KeWaitForSingleObject(0, 0, 0, 0, InterruptDelay__FDC_FDO_EXTENSION(in_FdoExtension_17));
    goto anon22_Else;

  anon21_Else:
    assume {:partition} out_ntStatus_25 >= 0;
    out_retrycnt := out_retrycnt + 1;
    goto anon21_Else_dummy;

  anon24_Else:
    assume {:partition} yogi_error != 1;
    goto anon21_Else;

  L49:
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    out_Tmp_554 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(in_FdoExtension_17)];
    assume {:nonnull} out_Tmp_554 != 0;
    assume out_Tmp_554 > 0;
    Mem_T.INT4[out_Tmp_554 + 1 * 4] := 0;
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    out_Tmp_556 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(in_FdoExtension_17)];
    assume {:nonnull} out_Tmp_556 != 0;
    assume out_Tmp_556 > 0;
    Mem_T.INT4[out_Tmp_556 + 2 * 4] := 15;
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    out_Tmp_555 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(in_FdoExtension_17)];
    assume {:nonnull} out_Tmp_555 != 0;
    assume out_Tmp_555 > 0;
    Mem_T.INT4[out_Tmp_555 + 3 * 4] := 0;
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    call out_ntStatus_25 := FcIssueCommand(in_FdoExtension_17, Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(in_FdoExtension_17)], Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(in_FdoExtension_17)], 0, 0, 0);
    goto anon24_Else;

  anon23_Else:
    assume {:partition} Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(in_FdoExtension_17)] != 0;
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    out_Tmp_558 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(in_FdoExtension_17)];
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    out_Tmp_559 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(in_FdoExtension_17)];
    assume {:nonnull} out_Tmp_558 != 0;
    assume out_Tmp_558 > 0;
    assume {:nonnull} out_Tmp_559 != 0;
    assume out_Tmp_559 > 0;
    Mem_T.INT4[out_Tmp_558] := BOR(Mem_T.INT4[out_Tmp_559], 128);
    goto L49;

  anon23_Then:
    assume {:partition} Mem_T.Clock48MHz__FDC_FDO_EXTENSION[Clock48MHz__FDC_FDO_EXTENSION(in_FdoExtension_17)] == 0;
    goto L49;

  anon18_Then:
    assume {:partition} 1 > out_retrycnt;
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    out_Tmp_557 := Mem_T.FifoBuffer__FDC_FDO_EXTENSION[FifoBuffer__FDC_FDO_EXTENSION(in_FdoExtension_17)];
    assume {:nonnull} out_Tmp_557 != 0;
    assume out_Tmp_557 > 0;
    Mem_T.INT4[out_Tmp_557] := 17;
    assume {:nonnull} in_FdoExtension_17 != 0;
    assume in_FdoExtension_17 > 0;
    goto anon23_Then, anon23_Else;

  anon17_Then:
    assume {:partition} out_ntStatus_25 == 258;
    goto anon18_Then;

  anon22_Else:
    assume {:partition} yogi_error != 1;
    goto anon17_Then;

  anon21_Else_dummy:
    call {:si_unique_call 1} out_Tmp_554, out_Tmp_555, out_Tmp_556, out_retrycnt, out_Tmp_557, out_ntStatus_25, out_Tmp_558, out_Tmp_559, out_vslice_dummy_var_153 := FcInitializeControllerHardware_loop_L11(out_Tmp_554, out_Tmp_555, out_Tmp_556, out_retrycnt, out_Tmp_557, out_ntStatus_25, out_Tmp_558, out_Tmp_559, in_FdoExtension_17, in_DeviceObject_42, out_vslice_dummy_var_153);
    return;

  exit:
    return;
}



procedure {:LoopProcedure} FcInitializeControllerHardware_loop_L11(in_Tmp_554: int, in_Tmp_555: int, in_Tmp_556: int, in_retrycnt: int, in_Tmp_557: int, in_ntStatus_25: int, in_Tmp_558: int, in_Tmp_559: int, in_FdoExtension_17: int, in_DeviceObject_42: int, in_vslice_dummy_var_153: int) returns (out_Tmp_554: int, out_Tmp_555: int, out_Tmp_556: int, out_retrycnt: int, out_Tmp_557: int, out_ntStatus_25: int, out_Tmp_558: int, out_Tmp_559: int, out_vslice_dummy_var_153: int);
  modifies Mem_T.DriveControlImage__FDC_FDO_EXTENSION, Mem_T.CurrentDeviceObject__FDC_FDO_EXTENSION, Mem_T.AllowInterruptProcessing__FDC_FDO_EXTENSION, Mem_T.CommandHasResultPhase__FDC_FDO_EXTENSION, Mem_T.SignalState__DISPATCHER_HEADER, Mem_T.INT4, alloc, Mem_T.QuadPart__LARGE_INTEGER, Mem_T.LowPart__LUID, Mem_T.HighPart__LUID, Mem_T.HardwareFailed__FDC_FDO_EXTENSION, yogi_error;


