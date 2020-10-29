This folder contains test cases for generating preconditions that block assertion failures due to unknowns flowing into conditions.

To reproduce, run AV in the following sequence:

1. avh <filename>.inst.bpl hinst.bpl /entryPointProc:<entrypoint> /unknownProc:malloc /unknownProc:$alloc /killAfter:1000 
2. avn hinst.bpl /sdv /blockOnFreeVars /timeoutEE:200 /timeout:1000 /noEbasic /EE:ignoreAllAssumes+ /dontGeneralize /dumpResults:results.txt /EE:onlySlicAssumes+ /EE:ignoreAllAssumes- /killAfter:3600 
