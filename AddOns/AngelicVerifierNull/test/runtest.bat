@echo off
setlocal

set HEXE=..\AvHarnessInstrumentation\bin\Debug\AvHarnessInstrumentation.exe
set BGEXE=..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe 
set OPTS= /traceSlicing 

REM for %%f in (eeSlice3.bpl) do (
for %%f in (t1.bpl t2_err.bpl t3_err.bpl t4.bpl t5.bpl t6.bpl t7.bpl t8.bpl t9.bpl pruned.bpl empty_forall.bpl null.bpl generalize.bpl rec.bpl eeSlice3.bpl eeSlice4.bpl eeSlice5.bpl eeSlice6.bpl eeSlice61.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  del /Q %%~nf_hinst.bpl 2> delout
  %HEXE% %%f %%~nf_hinst.bpl %OPTS%  %* | findstr AV_OUTPUT
  if exist %%~nf_hinst.bpl %BGEXE% %%~nf_hinst.bpl %OPTS%  %* | findstr AV_OUTPUT
)

