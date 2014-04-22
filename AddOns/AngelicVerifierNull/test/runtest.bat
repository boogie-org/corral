@echo off
setlocal

set BGEXE=..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe

for %%f in (t1.bpl t2_err.bpl t3_err.bpl t5.bpl t7.bpl t8.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %* %%f 
)

