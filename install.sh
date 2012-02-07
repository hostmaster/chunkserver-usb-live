#!/bin/sh

USBROOT=/USBROOT
SRC=/usr/src

make -C $SRC DESTDIR=$USBROOT installkernel
make -C $SRC DESTDIR=$USBROOT installworld

make -C $SRC/etc DESTDIR=$USBROOT distrib-dirs
make -C $SRC/etc DESTDIR=$USBROOT distribution
