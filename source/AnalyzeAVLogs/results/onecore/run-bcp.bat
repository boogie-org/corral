@echo off

setlocal enabledelayedexpansion

if not defined SDXROOT SET SDXROOT=f:\work\os\src

SET /a ite=1

cd /d %SDXROOT%

del %~dp0\run-bcp.log
del %~dp0\bcp-output.csv

for /f "tokens=*" %%a in (%~dp0\modules-bcp.txt) do call :processline %%a

goto :eof

:processline
	echo Executing BCP for module %ite% in %* >> %~dp0\run-bcp.log 2>&1
	cd /d %*
	build -parent -c >> %~dp0\run-bcp.log 2>&1
	echo %*,%errorlevel% >> %~dp0\bcp-output.csv
	SET /a ite=%ite%+1
	cd /d %SDXROOT%
	goto :eof

:eof