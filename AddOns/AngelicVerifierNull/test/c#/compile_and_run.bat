@echo off

set BCTEXE=..\..\..\..\..\..\bct\Binaries\BytecodeTranslator.exe
set BCTCLEANUPEXE=..\..\..\..\..\bin\Debug\BctCleanup.exe
set AVNEXE=..\..\..\AngelicVerifierNull\bin\Debug\AngelicVerifierNull.exe
set AVNOPTS=/nodup /traceSlicing /copt:recursionBound:5 /copt:k:1 /copt:tryCTrace /EE:noFilters
REM Run BCT

cd %1 

copy ..\Poirot.dll . > NUL
copy ..\Stubs.dll . > NUL
copy ..\poirot_stubs.bpl . > NUL

:csc
echo Running csc ...
if exist test.exe del test.exe 
if exist test.pdb del test.pdb
call csc.exe /r:Poirot.dll /debug /D:DEBUG /out:test.exe *.cs > Output
if not exist test.exe goto cscerror
if exist test.exe goto bct

:cscerror
echo Error running csc
type Output
goto end

:bct
if exist test.bpl del test.bpl
if exist testClean.bpl del testClean.bpl

echo Running BCT ...
call %BCTEXE% /e:1 /whole /heap:splitFields /typeinfo:1 test.exe Stubs.dll > Output
if not exist test.bpl goto bcterror
copy test.bpl testClean.bpl > NUL
if "%2"=="/nocleanup" goto rest

echo Running BCT Cleanup ...
call %BCTCLEANUPEXE% test.bpl testClean.bpl /include:poirot_stubs.bpl /recursionBound:5 /k:1 2> Output
if not exist testClean.bpl goto bctcleanuperror
if exist testClean.bpl goto rest

:bcterror
echo Error running BCT
type Output
goto end

:bctcleanuperror
echo Error running BCT Cleanup
goto end

:bctrewriteerror
echo Error running BCT Rewrite
goto end

:rest

echo Running AVN ...
%AVNEXE% testClean.bpl %AVNOPTS% > Output
findstr AV_OUTPUT Output

:end
if not exist TestProgram.bpl goto finish

:existing
echo Running AVN on TestProgram.bpl ...
%AVNEXE% TestProgram.bpl %AVNOPTS% > Output
findstr AV_OUTPUT Output

:finish
cd ..