
make $1.bpl
mono ../../../SmackInst/SmackInst/bin/Debug/SmackInst.exe $1.bpl $1.inst.bpl
mono ../../AvHarnessInstrumentation/bin/Debug/AvHarnessInstrumentation.exe $1.inst.bpl $1.harness.bpl /noAA /unknownProc:$malloc
echo -----------------------------------------------
mono ../../AngelicVerifierNull/bin/Debug/AngelicVerifierNull.exe $1.harness.bpl /nodup /traceSlicing /copt:recursionBound:5 /copt:k:1 /copt:tryCTrace > $1.avn.log
grep AV_OUTPUT $1.avn.log 