@echo off

setlocal enabledelayedexpansion

if not defined SDXROOT SET SDXROOT=f:\work\os\src

SET /a ite=1

cd /d %SDXROOT%

del %~dp0\run-smv.log

for /f "tokens=*" %%a in (%~dp0\modules-smv.txt) do call :processline %%a

goto :eof

:processline
	echo Executing SMV for module %ite% in %* >> %~dp0\run-smv.log 2>&1
	cd /d %*
	call f:\work\os\src\tools\smv.cmd /irqlcheck:bcp /debug >> %~dp0\run-smv.log 2>&1
	SET /a ite=%ite%+1
	cd /d %SDXROOT%
	goto :eof

:eof