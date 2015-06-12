@echo off
setlocal

set BCTEXE=..\..\..\..\..\bct\Binaries\BytecodeTranslator.exe
set BCTOPTS= /e:1 /whole /heap:SplitFields /typeinfo:1

echo.
echo -------------------- %*.cs --------------------
csc /t:library %*.cs
%BCTEXE% %BCTOPTS% %*.dll
copy %*.bpl %*.orig.bpl


