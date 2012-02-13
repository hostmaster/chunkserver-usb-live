#!/bin/sh

USBROOT=/USBROOT
SRC=/usr/src

#rm -rf ${USBROOT}

make -C $SRC -j 2 buildkernel
make -C $SRC -j 2 buildworld
