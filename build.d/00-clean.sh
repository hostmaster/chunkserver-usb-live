#!/bin/sh
#

if [ -z "${USBROOT}" ]; then
	echo "ERROR: USBROOT is not defined. Exiting"
	exit 1
fi

if mount | grep -q "\\${USBROOT}\/"; then
	echo "Unmount filesystems first"
	mount | awk "/\\${USBROOT}\// { print \$3 }" | xargs umount
fi

chflags -R noschg "${USBROOT}"
rm -rf "${USBROOT}"
mkdir -p "${USBROOT}"
if [ $? -ne 0 ]; then
	echo "Unable to mkdir ${USBROOT}"
	exit 1
fi