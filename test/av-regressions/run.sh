#!/bin/bash
rm -f Output
./runtest.sh $1 >> Output
diff Output Answer > /dev/null 2>&1
error=$?
if [ $error -eq 0 ]
then
  echo "Succeeded"
  exit 0
else
  echo "FAILED"
  exit 1
fi