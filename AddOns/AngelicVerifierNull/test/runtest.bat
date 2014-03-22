@echo off
setlocal

set BGEXE=..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe

for %%f in (f1.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %* %%f 
)

