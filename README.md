# Corral

Corral is a solver for the reachability modulo theories problem. Learn more here: http://research.microsoft.com/en-us/projects/verifierq

## Dependency on Boogie
Corral has a dependency on [Boogie](https://github.com/boogie-org/boogie), which is provided as a git submodule. To download the specific revision of Boogie that Corral depends on:

```
cd ${CORRAL_DIR}
git submodule init
git submodule update
cd boogie
```

Then follow the [Boogie](https://github.com/boogie-org/boogie#building) building instructions.

## Building and running Corral on Windows

Here is how you set up Corral. 

1. Build the Boogie solution; its binaries will be placed in the <Boogie>\Binaries folder. Go to the folder <Corral>\references and run "updateBoogie.bat <Boogie>\Binaries". This will copy all the Boogie DLLs to the right place for Corral. You should now be able to build Corral via <Corral>\cba.sln. The Corral binaries are placed in <Corral>\bin\debug. 
2. Running Corral requires z3. We have tested Corral against z3 version 4.1; download and copy z3.exe in <Corral>\bin\debug folder. 
3. Corral takes a Boogie program as input. There are regressions provided in <Corral>\test\regressions folder. Go to this folder and run "perl check.pl" to run all the regressions. You can run an individual test, for instance, as follows: go to <Corral>\test\regressions and do: "..\..\bin\debug\corral.exe 001\001.bpl /flags:001\config". The flag "/flags:filename" instructs corral to read its flags from the file "filename".

## Building and Running Corral on Linux using mono (thanks to Zvonimir)
 ##################################################

 # Get Corral

```
 git clone https://git01.codeplex.com/corral ${CORRAL_DIR}
```

 # Build Corral

```
 cd ${CORRAL_DIR}/references
 cp ${BOOGIE_DIR}/Binaries/AbsInt.dll .
 cp ${BOOGIE_DIR}/Binaries/Basetypes.dll .
 cp ${BOOGIE_DIR}/Binaries/CodeContractsExtender.dll .
 cp ${BOOGIE_DIR}/Binaries/Core.dll .
 cp ${BOOGIE_DIR}/Binaries/Concurrency.dll .
 cp ${BOOGIE_DIR}/Binaries/ExecutionEngine.dll .
 cp ${BOOGIE_DIR}/Binaries/Graph.dll .
 cp ${BOOGIE_DIR}/Binaries/Houdini.dll .
 cp ${BOOGIE_DIR}/Binaries/Model.dll .
 cp ${BOOGIE_DIR}/Binaries/ParserHelper.dll .
 cp ${BOOGIE_DIR}/Binaries/Provers.SMTLib.dll .
 cp ${BOOGIE_DIR}/Binaries/VCExpr.dll .
 cp ${BOOGIE_DIR}/Binaries/VCGeneration.dll .
 cp ${BOOGIE_DIR}/Binaries/Boogie.exe .
 cp ${BOOGIE_DIR}/Binaries/BVD.exe .
 cp ${BOOGIE_DIR}/Binaries/Doomed.dll .
 cp ${BOOGIE_DIR}/Binaries/Predication.dll .

 cd ${CORRAL_DIR} 
 xbuild cba.sln 
 ln -s ${Z3_DIR}/install/bin/z3 ${CORRAL_DIR}/bin/Debug/z3.exe
``` 
 ##################################################

 For debugging with MonoDevelop, you also need to copy the .mdb files into the bin directory after compiling, like this:
```
cp ${BOOGIE_DIR}/Binaries/*.mdb bin/Debug
```
