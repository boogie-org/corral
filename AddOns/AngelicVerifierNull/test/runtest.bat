@echo off
setlocal

set BGEXE=..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe

for %%f in (t1.bpl t2_err.bpl t3_err.bpl t4.bpl t5.bpl t6.bpl t7.bpl t8.bpl t9.bpl pruned.bpl empty_forall.bpl null.bpl generalize.bpl rec.bpl eeSlice3.bpl eeSlice4.bpl eeSlice5.bpl eeSlice6.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %%f  %* | findstr AV_OUTPUT
)

