const unique NULL:int;

var Mem_T.pSid__KS_CAMERA_STREAMING_CONSENT_INFO: [int]int;
function pSid__KS_CAMERA_STREAMING_CONSENT_INFO(int): int;

procedure {:origName "ProbeForRead"} {:osmodel} ProbeForRead({:pointer} {:ptr "Mem_T.VOID"} {:ref "Mem_T.VOID"} actual_Address_1: int, {:scalar} actual_Length_40: int, {:scalar} actual_Alignment: int);

procedure {:origName "KsUpdateCameraStreamingConsent"} KsUpdateCameraStreamingConsent({:pointer} {:ptr "Mem_T._KS_CAMERA_STREAMING_CONSENT_INFO"} x0: int) returns ({:scalar} r: int);

procedure main(x:int, y:int, z:int)
{
   var r:int; 
   call ProbeForRead(x,y,z);
   call r := KsUpdateCameraStreamingConsent(x);
}