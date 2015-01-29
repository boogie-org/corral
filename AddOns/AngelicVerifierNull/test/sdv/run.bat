@echo off
rem Usage: run.bat
rem Flags I use: /noAA

set "flags=/noAA"
IF not "%*"=="" set flags=%*
echo Flags: %flags%
call runtest.bat %* > Output.txt
fc /W Golden_Output.txt Output.txt > nul
fc /W Golden_Output.txt Output.txt > nul
if not errorlevel 1 goto passTest
echo FAILED
goto errorEnd

:passTest
echo Succeeded
goto end

:end
exit /b 0

:errorEnd
exit /b 1
