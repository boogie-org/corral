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
	xcopy /D \\tsclient\C\Users\t-liyi\Documents\repo\corral\AddOns\AngelicVerifierNull\AngelicVerifierNull\bin\Debug avn-bin
	rem copy \\tsclient\C\Users\t-liyi\Documents\repo\corral\AddOns\AngelicVerifierNull\AngelicVerifierNull\bin\Debug\*.dll avn-bin
	rem copy \\tsclient\C\Users\t-liyi\Documents\repo\corral\AddOns\AngelicVerifierNull\AngelicVerifierNull\bin\Debug\z3.exe avn-bin
)

rem ..\brunch.py --bench ..\drivers --threads 8 --format 'Status:Base:Cpu:#Procs:#EntryPoints:#AssertsBeforeAA:#AssertsAfterAA:InstrumentTime(ms):blocked.count:alias.analysis(s):explain.error(s):run.corral(s):run.corral.iterative(s):corral.count:bug.count' -- avn-bin\AngelicVerifierNull.exe {f} /sdv /useEntryPoints /timeout:4000 /copt:newStratifiedInlining /copt:recursionBound:1 /copt:fwdBck /copt:v:1 /dumpResults:results.csv

..\brunch.py --bench ..\drivers --threads 6 --format 'Status:Base:Result:Cpu:#Procs:#EntryPoints:#AssertsBeforeAA:#AssertsAfterAA:#AssertsAftHoudini:#ImplWithAsserts:InstrumentTime(ms):houdini(s):alias.analysis(s):explain.error(s):run.corral(s):run.corral.iterative(s):corral.count:blocked.count:bug.count' -- avn-bin\AngelicVerifierNull.exe {f} /sdv /useEntryPoints /timeoutAssertRoundRobin:30 /timeout:3600 /houdini /dumpResults:results.csv

echo Finished!
popd