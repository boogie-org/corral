
#smack $1.c -bpl $1.bpl --no-verify --verifier-options="/doModSetAnalysis"
AVHOME=/mnt/local/av/AddOns
mono $AVHOME/SmackInst/SmackInst/bin/Debug/SmackInst.exe $1.bpl $1.inst.bpl
#mono $AVHOME/AvHarnessInstrumentation/bin/Debug/AvHarnessInstrumentation.exe $1.inst.bpl $1.harness.bpl /noAA:0 /unknownProc:malloc
#echo -----------------------------------------------
#mono $AVHOME/AngelicVerifierNull/bin/Debug/AngelicVerifierNull.exe $1.harness.bpl /nodup /traceSlicing /copt:recursionBound:5 /copt:k:1 /copt:tryCTrace > $1.avn.log
#grep AV_OUTPUT $1.avn.log 

mono $AVHOME/FastAVN/FastAVN/bin/Debug/FastAVN.exe $1.inst.bpl \
/hopt:noAA /hopt:unknownProc:malloc /hopt:unknownProc:\$alloc \
/aopt:nodup /aopt:traceSlicing /aopt:copt:recursionBound:5 /aopt:copt:k:1 /aopt:sdv /aopt:dontGeneralize\
/numThreads:64 /keepFiles /killAfter:3600
