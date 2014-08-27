@echo off
setlocal EnableDelayedExpansion
title FastAVN Regression Test

rem run FastAVN regression tests
rem make a regression directory
rem set R=REGRESS.%date:~-4%.%date:~-10,2%.%date:~-7,2%-%time:~0,2%.%time:~3,2%.%time:~6,2%
set "B=REGRESS.%date:~-4%.%date:~-10,2%.%date:~-7,2%-%time:~0,2%"
rem set "B=REGRESS.2014.09.03-09"

if not exist %B% (mkdir !B!)

pushd %B%

rem copy latest AVN binary from Yi's machine
if not exist fast-avn-bin (
	mkdir fast-avn-bin
	xcopy /D \\tsclient\C\Users\t-liyi\Documents\repo\corral\AddOns\FastAvn\FastAVN\bin\Debug fast-avn-bin
)
if not exist avn-bin (
	mkdir avn-bin
	xcopy /D \\tsclient\C\Users\t-liyi\Documents\repo\corral\AddOns\AngelicVerifierNull\AngelicVerifierNull\bin\Debug avn-bin
)

..\brunch.py --bench ..\drivers --threads 1 --format 'Status:Base:Cpu:#EntryPoints:#Bugs:fastavn(s):impl.count' -- fast-avn-bin\FastAVN.exe {f} /numThreads:16 /avnPath:%CD%\avn-bin\AngelicVerifierNull.exe /aopt:deadCodeDetection

echo Finished!
popd