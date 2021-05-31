@echo off
setlocal

set BGEXE=..\..\bin\debug\concurrenthoudini.exe

for %%f in (t1.bpl t2.bpl t3.bpl t5.bpl t6.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %* %%f /corral
)

for %%f in (inst1.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %* %%f /instantiate
)

