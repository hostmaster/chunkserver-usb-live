#!/bin/sh
#
TIMESTAMP=`date +%Y%m%d`
IMAGE=bsd-${TIMESTAMP}.img
ZIP=fbsd-${TIMESTAMP}.zip
IMAGE_SIZE="800m"

if [ -z "${USBROOT}" ]; then
		echo "ERROR: USBROOT is not defined. Exiting"
		exit 1
fi

if [ -e ${IMAGE} ]; then
		echo "won't overwrite ${IMAGE}"
		exit 1
fi

if mount | grep -q "\\${USBROOT}\/tmp\/mountpoint\."; then
	echo "Unmount these filesystems first"
	mount | awk "/\\${USBROOT}\/tmp\/mountpoint\./ { print $3}"
	exit 1
fi

echo '/dev/ufs/FreeBSD / ufs ro,noatime 1 1' > ${USBROOT}/etc/fstab
if [ $? -ne 0 ]; then
	echo "Unable to create ${USBROOT}/etc/fstab"
	exit 1
fi

makefs -B little -s ${IMAGE_SIZE} -o label=FreeBSD ${IMAGE} ${USBROOT}
	echo "makefs failed"
	exit 1
fi

### rm ${1}/etc/fstab

unit=`mdconfig -a -t vnode -f ${IMAGE}`
if [ $? -ne 0 ]; then
	echo "mdconfig failed"
	exit 1
fi

# create labels install boot loader
gpart create -s BSD ${unit}
gpart bootcode -b ${USBROOT}/boot/boot ${unit}
gpart add -t freebsd-ufs ${unit}

# delete md device 
mdconfig -d -u ${unit}


#./make-memstick.sh ${USBROOT} bsd-`date +%F`.img

# make compressed archive
zip -9uv ${ZIP} ${IMAGE}