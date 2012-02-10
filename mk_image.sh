#!/bin/sh

USBROOT=/USBROOT
SRC=/usr/src

install 

./make-memstick ${USBROOT} bsd-`date +%F`.img
