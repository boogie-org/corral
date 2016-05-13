@echo off
setlocal

set SIEXE=..\..\..\SmackInst\SmackInst\bin\Debug\SmackInst.exe
set HEXE=..\..\AvHarnessInstrumentation\bin\Debug\AvHarnessInstrumentation.exe
set BGEXE=..\..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe 
set HOPTS= /noAA /unknownProc:malloc
set BGOPTS= /nodup /traceSlicing /copt:recursionBound:5 /copt:k:1 /copt:tryCTrace 

set f=%1
echo.
echo -------------------- %f% --------------------
del /Q %f%.harness.bpl 2> delout
%SIEXE% %f%.bpl %f%.inst.bpl
%HEXE% %f%.inst.bpl %f%.harness.bpl %HOPTS%  %* > %f%.avn.log
if exist %f%.harness.bpl %BGEXE% %f%.harness.bpl %BGOPTS%  %* >> %f%.avn.log
type %f%.avn.log | findstr AV_OUTPUT
