@echo off
setlocal enabledelayedexpansion

set HEXE=..\..\source\AvHarnessInstrumentation\bin\Debug\netcoreapp3.1\AvHarnessInstrumentation.exe
set BGEXE=..\..\source\AngelicVerifier\bin\debug\netcoreapp3.1\AngelicVerifier.exe
set PROPEXE=..\..\source\PropInst\bin\Debug\netcoreapp3.1\PropInst.exe
set OPTS= /traceSlicing
set c=0
set bpl=
set propfile=

call:add uaf0.bpl ..\..\source\PropInst\ExampleProperties\useafterfree-razzle.avp
call:add uaf1.bpl ..\..\source\PropInst\ExampleProperties\useafterfree-razzle.avp
call:add df0.bpl ..\..\source\PropInst\ExampleProperties\useafterfree-razzle.avp
call:add uaf2.bpl ..\..\source\PropInst\ExampleProperties\useafterfree-razzle.avp
call:add uaf3.bpl ..\..\source\PropInst\ExampleProperties\useafterfree-razzle.avp
call:add irql0.bpl ..\..\source\PropInst\ExampleProperties\checkIrql-razzle.avp
call:add irql1.bpl ..\..\source\PropInst\ExampleProperties\checkIrql-razzle.avp
call:add irql2.bpl ..\..\source\PropInst\ExampleProperties\checkIrql-razzle.avp
call:add null0.bpl ..\..\source\PropInst\ExampleProperties\nullcheck-razzle.avp
call:add rodrigo_refnull.bpl ..\..\source\PropInst\ExampleProperties\nullcheck-csharp.avp
call:add probe0.bpl ..\..\source\PropInst\ExampleProperties\probeBeforeUse-onlyProbed.avp

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
