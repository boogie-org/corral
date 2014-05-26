@echo off
setlocal

set BGEXE=..\AliasAnalysis\bin\debug\AliasAnalysis.exe

for %%f in (f1.bpl f2.bpl f3.bpl f4.bpl f5.bpl f6.bpl f7.bpl fail_driver4_completerequest.bpl fail_driver5_SignalEventIncCompletion2.bpl fail_driver5_spinlock.bpl flpydisk_fail_wmiforward.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %* %%f 
)

