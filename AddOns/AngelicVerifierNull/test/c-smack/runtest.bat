@echo off
setlocal

set HEXE=..\..\AvHarnessInstrumentation\bin\Debug\AvHarnessInstrumentation.exe
set BGEXE=..\..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe 
set HOPTS= /noAA /unknownProc:malloc
set BGOPTS= /nodup /traceSlicing /copt:recursionBound:5 /copt:k:1 /copt:tryCTrace 

REM for %%f in (eeSlice3.bpl) do (
for %%f in (t1.bpl t2.bpl t3.bpl t4.bpl t5.bpl t6.bpl t8.bpl t9.bpl extern_mem_fail.bpl list_sample) do (
  echo.
  echo -------------------- %%f --------------------
  del /Q %%~nf.harness.bpl 2> delout
  %HEXE% %%~nf.inst.bpl %%~nf.harness.bpl %HOPTS%  %* | findstr AV_OUTPUT
  if exist %%~nf.harness.bpl %BGEXE% %%~nf.harness.bpl %BGOPTS%  %* | findstr AV_OUTPUT
)

