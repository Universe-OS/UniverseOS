#!/bin/sh

_OSNAME="UniverseOS"
_ARCH="amd64"
_JOBS="4"

_BASEPATH=`dirname "$0"`
# this is optional - to get absolute
_BASEPATH=`sh -c "cd \"$_BASEPATH\" && pwd"`

_KERNSRCPATH="/usr/src"
_ROOTFS="/$_BASEPATH/$_OSNAME/build/rootfs"

_KERNSRCCONF="/$_BASEPATH/$_ARCH/conf/$_OSNAME"
_KERNDESTCONF="/$_KERNSRCPATH/sys/$_ARCH/conf/$_OSNAME"
_SRCCONF="/$_BASEPATH/src.conf"

set -e
cd $_KERNSRCPATH
ln -si $_KERNDESTCONF $_KERNSRCCONF

echo "Making dirs..."
mkdir -p $_ROOTFS
make distrib-dirs -j$_JOBS DESTDIR=$_ROOTFS KERNCONF=$_KERNDESTCONF SRCCONF=$_SRCCONF
echo "Making dirs finished"

echo "Building system..."
make buildworld   -j$_JOBS DESTDIR=$_ROOTFS KERNCONF=$_KERNDESTCONF SRCCONF=$_SRCCONF
make buildkernel  -j$_JOBS DESTDIR=$_ROOTFS KERNCONF=$_KERNDESTCONF SRCCONF=$_SRCCONF
echo "Building system finished"

echo "Installing system..."
make installworld   -j$_JOBS DESTDIR=$_ROOTFS KERNCONF=$_KERNDESTCONF SRCCONF=$_SRCCONF
make installkernel  -j$_JOBS DESTDIR=$_ROOTFS KERNCONF=$_KERNDESTCONF SRCCONF=$_SRCCONF
echo "Installing system finished"

rm -f $_KERNDESTCONF
