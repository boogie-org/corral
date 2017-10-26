@echo off

setlocal enabledelayedexpansion

if not defined SDXROOT SET SDXROOT=c:\MSR-Research\new-corral\fdc_fail

cd /d %SDXROOT%

del %~dp0\result.log

for /f "tokens=*" %%a in (flags.txt) do (
       echo Verifying %%a >> %~dp0\result.log 2>&1
       call ..\bin\Debug\corral.exe %%a /newStratifiedInlining:split /di /doNotUseLabels /v:3 >> %~dp0\result.log 2>&1 
       del /q temp*
       del /q tg*
       ::timeout /t 10
       ::taskkill /im ..\..\..\bin\Debug\corral.exe /f
)
@echo on


