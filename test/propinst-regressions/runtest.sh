configuration=$1
./runonetest.sh $configuration uaf0.bpl ../../source/PropInst/ExampleProperties/useafterfree-razzle.avp
./runonetest.sh $configuration uaf1.bpl ../../source/PropInst/ExampleProperties/useafterfree-razzle.avp
./runonetest.sh $configuration df0.bpl ../../source/PropInst/ExampleProperties/useafterfree-razzle.avp
./runonetest.sh $configuration uaf2.bpl ../../source/PropInst/ExampleProperties/useafterfree-razzle.avp
./runonetest.sh $configuration uaf3.bpl ../../source/PropInst/ExampleProperties/useafterfree-razzle.avp
./runonetest.sh $configuration irql0.bpl ../../source/PropInst/ExampleProperties/checkIrql-razzle.avp
./runonetest.sh $configuration irql1.bpl ../../source/PropInst/ExampleProperties/checkIrql-razzle.avp
./runonetest.sh $configuration irql2.bpl ../../source/PropInst/ExampleProperties/checkIrql-razzle.avp
./runonetest.sh $configuration null0.bpl ../../source/PropInst/ExampleProperties/nullcheck-razzle.avp
./runonetest.sh $configuration rodrigo_refnull.bpl ../../source/PropInst/ExampleProperties/nullcheck-csharp.avp
./runonetest.sh $configuration probe0.bpl ../../source/PropInst/ExampleProperties/probeBeforeUse-onlyProbed.avp