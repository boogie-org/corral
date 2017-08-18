@echo off

REM
REM smv.cmd
REM
REM Invokes the Static Module Verifier (SMV) frontend staticdv.exe.
REM

setlocal
if not defined SDV set SDV=%RazzleToolPath%\analysis\x86\sdv

@echo off
setlocal

REM
REM Check that SMV environment variable is set correctly
REM 

IF "%SDV%" == "" (
	ECHO.
	ECHO Error: You need to have the SDV environment variable set.
	ECHO Error: It is required for Razzle interception.
	GOTO EXIT
)

SET SMV=%SDV%\smv
SET SDVAP=%SMV%\analysisplugins\sdv
SET NULLCHECKAP=%SMV%\analysisplugins\av
SET USEAFTERFREEAP=%SMV%\analysisplugins\av

REM
REM Set our build environment prefix for configuration files
REM
SET BE=msbuild
IF NOT "%SDXROOT%"=="" (
        SET BE=razzle
)

REM
REM Set interceptor platform correctly
REM 
IF "%build.arch%"=="amd64" (
  SET platform_smv=x86_amd64;
  SET interceptorPlatform=x86_amd64;
)
IF "%build.arch%"=="x64" (
  SET platform_smv=x86_amd64;
  SET interceptorPlatform=x86_amd64;
)
IF "%build.arch%"=="win32" (
  SET platform_smv=x86;
  SET interceptorPlatform=.\;
)
IF "%build.arch%"=="x86" (
  SET platform_smv=x86;
  SET interceptorPlatform=.\;
)
IF "%build.arch%"=="arm" (
  SET platform_smv=x86_arm;
  SET interceptorPlatform=x86_arm;
)

REM
REM This script is a wrapper to call SMV for staticdv commands
REM
IF /i "%1"=="/nullcheck" GOTO NULLCHECK
IF /i "%1"=="/null:mono" GOTO NULLCHECKSINGLE
IF /i "%1"=="/null:cloud" GOTO NULLCHECK
IF /i "%1"=="/null:local" GOTO NULLCHECKLOCAL
IF /i "%1"=="/useafterfree" GOTO USEAFTERFREE
IF /i "%1"=="/uaf:local" GOTO USEAFTERFREELOCAL
IF /i "%1"=="/uaf:cloud" GOTO USEAFTERFREE
IF /i "%1"=="/irqlcheck" GOTO IRQLCHECK
IF /i "%1"=="/chakracheck" GOTO CHAKRACHECK
IF /i "%1"=="/view" GOTO VIEWDEFECT
IF /i "%1"=="/clean" GOTO CLEAN
IF /i "%1"=="" GOTO HELP
GOTO EXIT

:VIEWDEFECT
echo.
echo Available bugs:
dir /ad /s /b smv\bugs\bug*
echo.
set /p bugid="Please enter a bug number [eg. 0,1,...]:"
"%sdv%\bin\sdvdefect.exe" "smv\Bugs\bug%bugid%"
GOTO EXIT

:NULLCHECKSINGLE
if exist smv (rmdir /s /q smv)
mkdir smv
"%smv%\bin\smv" /config:"%nullcheckap%\configurations\%BE%-nullcheck.xml" /analyze %2 %3 %4
GOTO EXIT

:NULLCHECK
if exist smv (rmdir /s /q smv)
mkdir smv
"%smv%\bin\smv" /config:"%nullcheckap%\configurations\%BE%-nullcheck-sf-cloud.xml" /plugin:"%nullcheckap%\bin\fastavn.dll" /analyze /cloud %2 %3 %4
GOTO EXIT

:NULLCHECKLOCAL
if exist smv (rmdir /s /q smv)
mkdir smv
"%smv%\bin\smv" /config:"%nullcheckap%\configurations\%BE%-nullcheck-sf.xml" /plugin:"%nullcheckap%\bin\fastavn.dll" /analyze %2 %3 %4
GOTO EXIT

:USEAFTERFREE
if exist smv (rmdir /s /q smv)
mkdir smv
"%smv%\bin\smv" /config:"%useafterfreeap%\configurations\%BE%-useafterfree-sf-cloud.xml" /plugin:"%useafterfreeap%\bin\fastavn.dll" /analyze /cloud %2 %3 %4
GOTO EXIT

:USEAFTERFREELOCAL
if exist smv (rmdir /s /q smv)
mkdir smv
"%smv%\bin\smv" /config:"%useafterfreeap%\configurations\%BE%-useafterfree-sf.xml" /plugin:"%useafterfreeap%\bin\fastavn.dll" /analyze %2 %3 %4
GOTO EXIT

:CHAKRACHECK
if exist smv (rmdir /s /q smv)
mkdir smv
mkdir smv\build
xcopy /Y %2 smv\build\
mv smv\build\%2 smv\build\test.bpl
echo "Executing ChakraCheck AV"
"%smv%\bin\smv" /config:"%useafterfreeap%\configurations\chakrachecks-nobuild-sf-cloud.xml" /plugin:"%useafterfreeap%\bin\fastavn.dll" /analyze /cloud %3 %4 %5
GOTO EXIT

:CLEAN
if exist smv ( rmdir /s /q smv > nul )
GOTO EXIT

:HELP
echo.
echo "Usage: smv [/nullcheck | /useafterfree | /chakracheck <file.bpl> | /clean] [/debug]"
echo.

:EXIT

endlocal
