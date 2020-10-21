# Corral

[![License][license-badge]](LICENSE.txt)
[![NuGet package][nuget-badge]][nuget]
[![Travis build status][travis-badge]][travis]


Corral is a solver for the reachability modulo theories problem. Learn more
here: http://research.microsoft.com/en-us/projects/verifierq

## Building and Running Corral

Corral is built using [.NET Core](https://dotnet.microsoft.com) and use
GitVersion to attach version numbers to the assemblies and package(s) generated
by builds.

```console
# Build the solution
$ dotnet build source/Corral.sln

# Run the generated executable
$ source/Corral/bin/Debug/netcoreapp3.1/corral ...
```

> :warning: There is currently a know build problem with .NET Core and
> GitVersionTask. The workaround is to set the environment variable
> `MSBUILDSINGLELOADCONTEXT=1` and run `dotnet build-server shutdown`.

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

## Versioning and Release Automation

The [Bump workflow](.github/workflows/main.yml) will create and push a new tag
each time commits are pushed to the master branch (including PR merges). By
default, the created tag increments the patch version number from the previous
tag. For example, if the last tagged commit were `v2.4.3`, then pushing to
master would tag the latest commit with `v2.4.4`. If incrementing minor or major
number is desired instead of patch, simply add `#minor` or `#major` anywhere in
the commit message. For instance:

> Adding the next greatest feature. #minor

If the last tagged commit were `v2.4.3`, then pushing this commit would generate
the tag `v2.5.0`.

For pull-request merges, if minor or major version increments are desired, the
first line of the merge commit message can be changed to include `#minor` or
`#major`.

Note that on each push to `master`, the following will happen:
* A travis build for `master` is triggered.
* The GitHub workflow is also triggered.
* Once the workflow pushes a new tag `vX.Y.Z`, another travis build for `vX.Y.Z`
  is triggered.
* The travis build for `vX.Y.Z` in Release configuration publishes releases to
  GitHub and [NuGet.org][nuget].

[license-badge]: https://img.shields.io/github/license/boogie-org/corral?color=blue
[nuget]:         https://www.nuget.org/packages/Corral
[nuget-badge]:   https://img.shields.io/nuget/v/Corral
[travis]:        https://travis-ci.com/boogie-org/corral
[travis-badge]:  https://travis-ci.com/boogie-org/corral.svg?branch=master
