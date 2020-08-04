@echo off
setlocal

set BGEXE=..\..\..\bin\debug\concurrenthoudini.exe

for %%f in (foo.bpl bar.bpl one.bpl parallel1.bpl parallel3.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %* %%f
)

for %%f in (linear-set.bpl linear-set2.bpl FlanaganQadeer.bpl DeviceCacheSimplified.bpl parallel2.bpl parallel4.bpl parallel5.bpl parallel6.bpl parallel7.bpl akash.bpl t1.bpl new1.bpl perm.bpl async.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %* %%f
)

