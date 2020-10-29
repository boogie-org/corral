@echo off
setlocal enabledelayedexpansion

REM t1.bpl t2_err.bpl t3_err.bpl t4.bpl t5.bpl t6.bpl t7.bpl t8.bpl t9.bpl pruned.bpl empty_forall.bpl null.bpl generalize.bpl rec.bpl eeSlice3.bpl eeSlice4.bpl eeSlice5.bpl eeSlice6.bpl eeSlice61.bpl type_alias.bpl

set HEXE=..\..\source\AvHarnessInstrumentation\bin\Debug\netcoreapp3.1\AvHarnessInstrumentation.exe
set BGEXE=..\..\source\AngelicVerifier\bin\debug\netcoreapp3.1\AngelicVerifier.exe
set OPTS= /traceSlicing
set c=0
set bpl=
set opts=
set inst_opts=


call:add t1.bpl "/traceSlicing" ""
call:add t2_err.bpl "/traceSlicing" ""
call:add t3_err.bpl "/traceSlicing" ""
call:add t4.bpl "/traceSlicing" ""
call:add t5.bpl "/traceSlicing" ""
call:add t6.bpl "/traceSlicing" ""
call:add t7.bpl "/traceSlicing" ""
call:add t8.bpl "/traceSlicing" ""
call:add t9.bpl "/traceSlicing" ""
call:add pruned.bpl "/traceSlicing" ""
call:add empty_forall.bpl "/traceSlicing" ""
call:add null.bpl "/traceSlicing" ""
call:add generalize.bpl "/traceSlicing" ""
call:add rec.bpl "/traceSlicing" ""
call:add eeSlice3.bpl "/traceSlicing" ""
call:add eeSlice4.bpl "/traceSlicing" ""
call:add eeSlice5.bpl "/traceSlicing" ""
call:add eeSlice6.bpl "/traceSlicing" ""
call:add eeSlice61.bpl "/traceSlicing" ""
call:add eeSlice2.bpl "/traceSlicing /repeatEEWithControlFlow" ""
call:add type_alias.bpl "/traceSlicing" ""
call:add delayed_initialization.bpl "/traceSlicing" "/unknownType:Ref /delayInitialization"


set i=0
:loop
if %i% equ %c% goto :eof
  echo.
  set bpl=!bpls[%i%]!
  set opt=!opts[%i%]!
  set inst_opt=!inst_opts[%i%]!
  echo -------------------- %bpl% --------------------
  for %%f in (%bpl%) do (
    del /Q %%~nf_hinst.bpl 2> delout
    %HEXE% %%f  %%~nf_hinst.bpl %OPTS% %inst_opt% %* | findstr AV_OUTPUT
    if exist %%~nf_hinst.bpl %BGEXE% %%~nf_hinst.bpl %opt% %*| findstr AV_OUTPUT
  )

set /a i=%i%+1
goto loop

:add
set bpls[%c%]=%~1
set opts[%c%]=%~2
set inst_opts[%c%]=%~3
set /a c=%c%+1
