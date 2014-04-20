@echo off
setlocal

set BGEXE=..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe

for %%f in (t1.bpl t2.bpl t3.bpl t5.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %* %%f 
)

