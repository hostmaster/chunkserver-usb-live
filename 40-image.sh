#!/bin/sh

USBROOT=/USBROOT
SRC=/usr/src

rm -rf ${USBROOT}/tmp/mountpoint.*

./make-memstick.sh ${USBROOT} bsd-`date +%F`.img
zip -9 fbsd-`date +%Y%m%d`.zip bsd-`date +%F`.img
