#!/bin/bash
SIEXE="../../../SmackInst/SmackInst/bin/Debug/SmackInst.exe"
HEXE="../../AvHarnessInstrumentation/bin/Debug/AvHarnessInstrumentation.exe"
BGEXE="../../AngelicVerifierNull/bin/Debug/AngelicVerifierNull.exe"
HOPTS="/noAA /unknownProc:malloc"
BGOPTS="/nodup /traceSlicing /copt:recursionBound:5 /copt:k:1 /copt:tryCTrace"

for f in t0.bpl t1.bpl t2.bpl t3.bpl t4.bpl t5.bpl t6.bpl t8.bpl t9.bpl t10.bpl t11.bpl t13.bpl t15.bpl t16.bpl \
         extern_mem_fail.bpl link-list-test.bpl test_list.bpl
#extern_mem_fail.c  malloc.c       t0.c   t11.c  t13.c  t15.c  t1.c  t3.c  t5.c  t7.c  t9.c
#list_sample.c      malloc-null.c  t10.c  t12.c  t14.c  t16.c  t2.c  t4.c  t6.c  t8.c  tailq_ex.c
do 
  FILENAME=${f%.bpl}
  SIFILENAME="$FILENAME.inst.bpl"
  HFILENAME="$FILENAME.harness.bpl"
  echo -------------------- $FILENAME --------------------
  mono $SIEXE $f $SIFILENAME
  mono $HEXE $SIFILENAME $HFILENAME $HOPTS
  mono $BGEXE $HFILENAME $BGOPTS | grep AV_OUTPUT
done

