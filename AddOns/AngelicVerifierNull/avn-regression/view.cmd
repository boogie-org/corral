@echo off
cp %1 %~dp1%\defect.tt
pushd %~dp1
start /b sdvdefect
popd