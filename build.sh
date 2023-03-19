#!/bin/sh

_OSNAME="UniverseOS"
_ARCH="amd64"

_ROOTFS="/${_OSNAME}"
_KERNCONF="${_ARCH}/conf/${_OSNAME}"
_SRCCONF="src.conf"

set -e

echo "Making dirs..."
mkdir -R $_ROOTFS
make distrib-dirs DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
echo "Making dirs finished"

echo "Building system..."
meke buildworld   DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
make buildkernel  DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
echo "Building system finished"

echo "Installing system..."
meke installworld   DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
make installkernel  DESTDIR=$ROOTFS KERNCONF=$_KERNCONF SRCCONF=$_SRCCONF
echo "Installing system finished"