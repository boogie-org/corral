@echo off
if not defined BCTEXE goto undefined
goto begin

:undefined
echo Define BCTEXE (Executable for BytecodeTranslator)
goto finish

:begin 
if exist Output del Output
for %%d in (As As2 As3 Args ex1 ex2 listsum listsum2 foreach foreach2 doublequestion ComplexExpr Set String) do (
	echo ****************** %%d ****************** 
	call compile_and_run.bat %%d %1 %2
)

fc /W Answer Output > nul
fc /W Answer Output > nul
if not errorlevel 1 goto success

echo *********************************
echo ***** Not All Outputs Match *****
windiff Answer Output 
goto finish

:success
echo *********************************
echo * Outputs Match Expected Answer *

:finish