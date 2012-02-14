#!/bin/sh
#

if [ -z "${USBROOT}" ]; then
	echo "ERROR: USBROOT is not defined. Exiting"
	exit 1
fi

chflags -R noschg "${USBROOT}"
rm -rf "${USBROOT}"
mkdir -p "${USBROOT}"
