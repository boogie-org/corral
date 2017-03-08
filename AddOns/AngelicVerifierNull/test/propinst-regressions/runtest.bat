@echo off
setlocal enabledelayedexpansion

set HEXE=..\..\AvHarnessInstrumentation\bin\Debug\AvHarnessInstrumentation.exe
set BGEXE=..\..\AngelicVerifierNull\bin\debug\AngelicVerifierNull.exe
set PROPEXE=..\..\..\PropInst\PropInst\bin\Debug\PropInst.exe
set OPTS= /traceSlicing
set len=3
set bpl=
set propfile=

set bpls[0]=uaf0.bpl
set bpls[1]=uaf1.bpl
set bpls[2]=df0.bpl
set propfiles[0]=useafterfree-windows.avp
set propfiles[1]=useafterfree-windows.avp
set propfiles[2]=useafterfree-windows.avp

REM for %%f in (eeSlice3.bpl) do (
set i=0
:loop
if %i% equ %len% goto :eof
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
