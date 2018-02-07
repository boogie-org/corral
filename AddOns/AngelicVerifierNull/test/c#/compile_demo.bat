@echo off

REM Use as compile_and_run.bat DIRECTORY [/dll] [/nocleanup]
REM /dll 		Compiles files to DLLs and not EXEs
REM /nocleanup 	Does not run BCT Cleanup

if not exist %1 mkdir %1
cd %1

if not defined BCTEXE goto undefined
if not defined SDVEXE goto undefined2
goto begin

:undefined
echo Define BCTEXE (Absolute path for executable for BytecodeTranslator.exe)
goto finish

:undefined2
echo Define SDVEXE (Absolute path for executable for sdvdefect.exe)
goto finish


:begin 
copy ..\Poirot.dll . > NUL
copy ..\Stubs.dll . > NUL
copy ..\CollectionStubs.dll . > NUL
copy ..\poirot_stubs.bpl . > NUL

REM set BCTEXE=..\..\..\..\..\..\bct\Binaries\BytecodeTranslator.exe
set BCTCLEANUPEXE=..\..\..\..\..\bin\Debug\BctCleanup.exe
set AVNEXE=..\..\..\AngelicVerifierNull\bin\Debug\AngelicVerifierNull.exe
set AVNOPTS=/nodup /traceSlicing /copt:recursionBound:5 /sdv /copt:k:1 /copt:tryCTrace /EE:noFilters /EE:onlyDisplayAliasingInPre- 
set AVHARNESS=..\..\..\AvHarnessInstrumentation\bin\Debug\AvHarnessInstrumentation.exe
if "%2"=="/dll" goto dllfile
if "%3"=="/dll" goto dllfile

set CSCOUT=test.exe
set CSCOPTS=/r:Poirot.dll /debug /D:DEBUG /out:test.exe
set AVHARNESSOPTS=/useEntryPoints /noAA /unknownType:Ref
goto csc

:dllfile
set CSCOUT=test.dll
REM set CSCOPTS=/r:Poirot.dll /debug /D:DEBUG /t:library /out:test.dll
set CSCOPTS=/r:CollectionStubs.dll /debug /D:DEBUG /t:library /out:test.dll
set AVHARNESSOPTS= /noAA /unknownType:Ref /unknownType:int

:csc
echo Running csc ...
if exist test.exe del test.exe 
if exist test.pdb del test.pdb
call csc.exe %CSCOPTS% *.cs > ErrorLog
if not exist %CSCOUT% goto cscerror
if exist %CSCOUT% goto bct

:cscerror
echo Error running csc
type ErrorLog
goto end

:bct
if exist test.bpl del test.bpl
if exist testClean.bpl del testClean.bpl

echo Running BCT ...
:call %BCTEXE% /e:1 /whole /heap:splitFields /typeinfo:1 %CSCOUT% Stubs.dll > ErrorLog
:call %BCTEXE% /e:1 /whole /heap:splitFields /typeinfo:1 %CSCOUT%  > ErrorLog
call %BCTEXE% /e:1 /whole /heap:splitFields /typeinfo:1 %CSCOUT% CollectionStubs.dll > ErrorLog
if not exist test.bpl goto bcterror
copy test.bpl testClean.bpl > NUL
if "%2"=="/nocleanup" goto harness
if "%3"=="/nocleanup" goto harness

echo Running BCT Cleanup ...
call %BCTCLEANUPEXE% test.bpl testClean.bpl /include:poirot_stubs.bpl /recursionBound:5 /k:1 2> ErrorLog
if not exist testClean.bpl goto bctcleanuperror
if exist testClean.bpl goto harness

:harness
echo Running Harness Instrumentations ...
echo %AVHARNESS% testClean.bpl testInst.bpl %AVHARNESSOPTS%
call %AVHARNESS% testClean.bpl testInst.bpl %AVHARNESSOPTS%
if not exist testInst.bpl goto harnesserror
if exist testInst.bpl goto avn

:bcterror
echo Error running BCT
type ErrorLog
goto end

:bctcleanuperror
echo Error running BCT Cleanup
goto end

:harnesserror
echo Error running Harness Instrumentation
goto end

:avn
echo Running AVN ...
echo %AVNEXE% testInst.bpl %AVNOPTS% 
%AVNEXE% testInst.bpl %AVNOPTS% > AvnOut
findstr AV_OUTPUT AvnOut
echo %1 >> ..\Output
findstr AV_OUTPUT AvnOut >> ..\Output
%SDVEXE%

:end
if not exist TestProgram.bpl goto finish

:existing
echo Running AVN on TestProgram.bpl ...
%AVNEXE% TestProgram.bpl %AVNOPTS% > AvnOut
findstr AV_OUTPUT AvnOut
echo %1 >> ..\Output
findstr AV_OUTPUT AvnOut >> ..\Output
%SDVEXE%

:finish
cd ..
