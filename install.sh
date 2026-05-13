#!/bin/bash

# Detect architecture and set appropriate .NET RID
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        RID="linux-x64"
        ;;
    aarch64)
        RID="linux-arm64"
        ;;
    armv7l)
        RID="linux-arm"
        ;;
    *)
        echo "Warning: Unknown architecture $ARCH, defaulting to linux-x64"
        RID="linux-x64"
        ;;
esac

echo "Detected architecture: $ARCH -> Using RID: $RID"

apt install git git-lfs wget

git clone https://github.com/2SharkyStudios/SPT-Linux-Build.git
mkdir /home/container/SPT-Linux-Build/build/
cd /home/container/SPT-Linux-Build/SPTarkov.Server/

dotnet restore
dotnet publish -c Release -r $RID --self-contained true -p:SptVersion=$VSPT

echo "install complete"