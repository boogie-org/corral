#!/bin/bash
git init
git remote add origin https://github.com/boogie-org/corral.git
git checkout -b hydra
git pull origin hydra
git submodule init
git submodule update
script_dir=$(dirname $0)
msbuild $script_dir/AddOns/DistributedService/LocalServerInCsharp/LocalServerInCsharp.sln
cp /home/prantik/hydraUtils/z3 $script_dir/AddOns/DistributedService/LocalServerInCsharp/LocalServerInCsharp/bin/Debug/.
chmod -R 700 $script_dir/AddOns/DistributedService/LocalServerInCsharp/LocalServerInCsharp/bin/Debug/ .
