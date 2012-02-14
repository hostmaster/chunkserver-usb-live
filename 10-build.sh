#!/bin/sh
#

if [ -z "${USBROOT}" -o -z "${SRC}" ]; then
	echo "ERROR: USBROOT or SRC is not defined. Exiting"
	exit 1
fi

make -C $SRC -j 2 buildkernel
make -C $SRC -j 2 buildworld
