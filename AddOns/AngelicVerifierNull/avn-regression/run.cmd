@echo off
setlocal EnableDelayedExpansion
title AVN Regression Test

rem run AVN regression tests
rem make a regression directory
rem set R=REGRESS.%date:~-4%.%date:~-10,2%.%date:~-7,2%-%time:~0,2%.%time:~3,2%.%time:~6,2%
set "B=REGRESS.%date:~-4%.%date:~-10,2%.%date:~-7,2%-%time:~0,2%"

if not exist %B% (mkdir !B!)

pushd %B%

rem copy latest AVN binary from Yi's machine
if not exist avn-bin (
	mkdir avn-bin
	copy \\tsclient\C\Users\t-liyi\Documents\repo\corral\AddOns\AngelicVerifierNull\AngelicVerifierNull\bin\Debug avn-bin
	rem copy \\tsclient\C\Users\t-liyi\Documents\repo\corral\AddOns\AngelicVerifierNull\AngelicVerifierNull\bin\Debug\*.dll avn-bin
	rem copy \\tsclient\C\Users\t-liyi\Documents\repo\corral\AddOns\AngelicVerifierNull\AngelicVerifierNull\bin\Debug\z3.exe avn-bin
)
copy \\tsclient\C\Users\t-liyi\Documents\repo\corral\AddOns\AngelicVerifierNull\AngelicVerifierNull\bin\Debug\AngelicVerifierNull.exe avn-bin\AngelicVerifierNull.exe

..\brunch.py --bench ..\drivers --threads 16 --format 'Status:Cpu:TotalTime(ms):Base:#Procs:#EntryPoints:#AssertsBeforeAA:#AssertsAfterAA:InstrumentTime(ms):alias.analysis:run.corral:run.corral.iterative:corral.count' -- avn-bin\AngelicVerifierNull.exe {f} /sdv /useEntryPoints /timeout:2000 /timeoutRoundRobin:60 /dumpResults:results.txt
echo Finished!
popd