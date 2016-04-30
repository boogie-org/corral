#!/bin/bash

HEXE="../AvHarnessInstrumentation/bin/Debug/AvHarnessInstrumentation.exe"
BGEXE="../AngelicVerifierNull/bin/Debug/AngelicVerifierNull.exe"
OPTS="/traceSlicing"

for f in t1.bpl t2_err.bpl t3_err.bpl t4.bpl t5.bpl t6.bpl t7.bpl t8.bpl t9.bpl pruned.bpl empty_forall.bpl null.bpl generalize.bpl rec.bpl eeSlice3.bpl eeSlice4.bpl eeSlice5.bpl eeSlice6.bpl eeSlice61.bpl
do 
  FILENAME=${f%.bpl}
  HFILENAME=$FILENAME"_hinst.bpl"
  echo
  echo -------------------- $f --------------------
  mono $HEXE $f $HFILENAME $OPTS "$@" | grep AV_OUTPUT
  if [ -f $HFILENAME ]
    then
      mono $BGEXE $HFILENAME $OPTS "$@" | grep AV_OUTPUT
  fi
done
