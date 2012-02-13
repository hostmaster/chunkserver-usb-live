#!/bin/sh
#

if [ -z "${USBROOT}" -o -z ]; then
	echo "ERROR: USBROOT is not defined. Exiting"
	exit 1
fi

#rm -rf ${USBROOT}
# mkdir-p  ${USBROOT}
