#!/bin/bash

echo "Usage: run.sh [clean]"

if [[ $# == 1 ]];
then
    rm -f *_hinst.bpl
    rm -f *_hinst_inst.bpl
    exit
fi

diff --unified=3 --strip-trailing-cr --ignore-all-space \
 <(./runtest.sh "$@") <(cat Answer)

if [[ $? == 0 ]];
then
    echo Succeeded
    exit 0
else
    echo Failed
    exit 1
fi

