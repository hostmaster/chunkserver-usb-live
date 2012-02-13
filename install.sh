#!/bin/sh

USBROOT=/USBROOT
SRC=/usr/src

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

# change root password
# add admin1 user 
# set admin1 password
# install admin1 homedir skel
