@echo off
rem Usage: run.bat

echo Flags: %*
call runtest.bat %* > Output
fc /W Answer Output > nul
fc /W Answer Output > nul
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
