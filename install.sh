#!/bin/sh

if [ -z "${USBROOT}" -o -z "${SRC}" ]; then
	echo "ERROR: USBROOT or SRC is not defined. Exiting"
	exit 1
fi

make -C $SRC DESTDIR=$USBROOT installkernel
make -C $SRC DESTDIR=$USBROOT installworld

make -C $SRC/etc DESTDIR=$USBROOT distrib-dirs
make -C $SRC/etc DESTDIR=$USBROOT distribution


# generate ssh server key
# install client public keys
# /etc/rc.conf links

# install rc.conf
# install rc.d/home
# install /boot/loader.conf
# install screen
# install bash
# install vim
# install moose-chunk-server
