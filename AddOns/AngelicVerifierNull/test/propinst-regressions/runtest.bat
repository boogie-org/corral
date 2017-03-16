@echo off
setlocal enabledelayedexpansion

set HEXE=..\..\AvHarnessInstrumentation\bin\Debug\AvHarnessInstrumentation.exe
set BGEXE=..\..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe
set PROPEXE=..\..\..\PropInst\PropInst\bin\Debug\PropInst.exe
set OPTS= /traceSlicing
set c=0
set bpl=
set propfile=

call:add uaf0.bpl ..\..\..\PropInst\ExampleProperties\useafterfree-windows.avp
call:add uaf1.bpl ..\..\..\PropInst\ExampleProperties\useafterfree-windows.avp
call:add df0.bpl ..\..\..\PropInst\ExampleProperties\useafterfree-windows.avp
call:add uaf2.bpl ..\..\..\PropInst\ExampleProperties\useafterfree-windows-alias.avp
call:add uaf3.bpl ..\..\..\PropInst\ExampleProperties\useafterfree-windows-alias.avp

REM for %%f in (eeSlice3.bpl) do (
set i=0
:loop
if %i% equ %c% goto :eof
  echo.
  set bpl=!bpls[%i%]!
  set propfile=!propfiles[%i%]!
  echo -------------------- %bpl% --------------------
  for %%f in (%bpl%) do (
    del /Q %%~nf_pinst.bpl 2> delout
    %PROPEXE% %propfile% %%f %%~nf_pinst.bpl | findstr AV_OUTPUT
    %HEXE% %%~nf_pinst.bpl %%~nf_pinst_hinst.bpl %OPTS% %* | findstr AV_OUTPUT
    if exist %%~nf_pinst_hinst.bpl %BGEXE% %%~nf_pinst_hinst.bpl %OPTS% %* | findstr AV_OUTPUT
  )
set /a i=%i%+1
goto loop

:add
set bpls[%c%]=%~1
set propfiles[%c%]=%~2
set /a c=%c%+1
