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

## Building and running Corral on Windows

Here is how you set up Corral. 

1. Build <Corral>\cba.sln. This solution includes the necessary Boogie projects; there is no longer a separate step to build Boogie.
2. Running Corral requires z3. We have tested Corral against z3 version 4.1; download and copy z3.exe in <Corral>\bin\debug folder. 
3. Corral takes a Boogie program as input. There are regressions provided in <Corral>\test\regressions folder. Go to this folder and run "perl check.pl" to run all the regressions. You can run an individual test, for instance, as follows: go to <Corral>\test\regressions and do: "..\..\bin\debug\corral.exe 001\001.bpl /flags:001\config". The flag "/flags:filename" instructs corral to read its flags from the file "filename".

## Building and Running Corral on Linux using Mono

The following worked for Matt McCutchen on Fedora 23. You may need to change the `TargetFrameworkVersion` to match what your Mono version provides.
```
cd ${CORRAL_DIR} 
xbuild /p:TargetFrameworkVersion=v4.5 /p:Configuration=Debug cba.sln
ln -s ${Z3_DIR}/install/bin/z3 ${CORRAL_DIR}/bin/Debug/z3.exe
mono bin/Debug/corral.exe ...
``` 
