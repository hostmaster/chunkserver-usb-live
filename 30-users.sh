#!/bin/sh
#

if [ -z "${USBROOT}" ]; then
	echo "ERROR: USBROOT is not defined. Exiting"
	exit 1
fi

# root
echo "passwd" | pw usermod  -V ${USBROOT}/etc -h 0 root

# add admin user
ADMIN="admin1"
pw \
	-V ${USBROOT}/etc useradd ${ADMIN} \
	-d /home/${ADMIN} -m \
	-G wheel \
	-c "Admin user"\
	-s /usr/bin/bash \
	-h 0 \
echo "adminpass" | pw usermod  -V ${USBROOT}/etc -h 0 ${ADMIN}

# install admin's homedir skelet