# Corral

[![License][license-badge]](LICENSE.txt)
[![NuGet package][nuget-badge]][nuget]
[![Corral CI](https://github.com/boogie-org/corral/actions/workflows/test.yml/badge.svg)](https://github.com/boogie-org/corral/actions/workflows/test.yml)


Corral is a solver for the reachability modulo theories problem. Learn more
here: http://research.microsoft.com/en-us/projects/verifierq

## Building and Running Corral

You can build Corral using [.NET Core](https://dotnet.microsoft.com):
```console
$ dotnet build source/Corral.sln
```

Then you can run the generated executable:
```console
$ source/Corral/bin/Debug/net5.0/corral ...
```

Alternatively, Corral can be installed as a [.NET Core Global Tool](https://docs.microsoft.com/en-us/dotnet/core/tools/global-tools):

```console
$ dotnet tool install --global Corral
```

### SMT Solver

Running Corral requires [Z3](https://github.com/Z3Prover/z3). We have tested
Corral against Z3 version 4.8.8.

### Regressions

Corral takes a Boogie program as input. There are regressions provided in
`test\regressions` folder. Go to this folder and run `perl check.pl` to run all
the regressions. You can run an individual test, for instance, as follows: go to
`test\regressions` and do: `${CORRAL_EXE} 001\001.bpl
/flags:001\config`. The flag `/flags:filename` instructs corral to read its
flags from the file `filename`.

## Versioning and Release

The current version of Boogie is noted in a [build property](source/Directory.Build.props).
To push a new version to nuget, perform the following steps:

- Update the version (e.g., x.y.z) and commit the change
- git tag vx.y.z
- git push --tags

The [CI workflow](.github/workflows/test.yml) will build and push the packages.


[license-badge]: https://img.shields.io/github/license/boogie-org/corral?color=blue
[nuget]:         https://www.nuget.org/packages/Corral
[nuget-badge]:   https://img.shields.io/nuget/v/Corral

