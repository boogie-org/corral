@echo off
setlocal

set BGEXE=..\..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe

for %%f in (exitwithoutrelease.bpl funcatdispatch.bpl funcatdispatch_correct.bpl lowerdriverreturn.bpl slam_guard.bpl slam_guard2.bpl startdevicewait.bpl ebasic_example.bpl ebasic_example2.bpl soft_constraint_example.bpl eedoesntblock.bpl) do (
  echo.
  echo -------------------- %%f --------------------
  %BGEXE% %%f  %* |findstr AV_OUTPUT
)

