#!/bin/sh

_OSNAME="UniverseOS"
_ARCH="amd64"

_BASEPATH=`dirname "$0"`
# this is optional - to get absolute
_BASEPATH=`sh -c "cd \"$_BASEPATH\" && pwd"`

_KERNSRCPATH="/usr/src"
_ROOTFS="$_BASEPATH/$_OSNAME"
_KERNCONF="$_BASEPATH/$_ARCH/conf/$_OSNAME"
_SRCCONF="$_BASEPATH/src.conf"

set -e
cd $_KERNSRCPATH

echo "Making dirs..."
mkdir -p $_ROOTFS
make distrib-dirs DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
echo "Making dirs finished"

echo "Building system..."
make buildworld   DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
make buildkernel  DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
echo "Building system finished"

echo "Installing system..."
meke installworld   DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
make installkernel  DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
echo "Installing system finished"