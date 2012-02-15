#!/bin/sh

if [ -z "${USBROOT}" -o -z "${SRC}" ]; then
	echo "ERROR: USBROOT or SRC is not defined. Exiting"
	exit 1
fi

mkdir -p /usr/ports/distfiles

OPTIONS="WITHOUT_IPV6=yes WITHOUT_NLS=yes WITHOUT_LDAP=yes BATCH=yes DESTDIR=${USBROOT}"

# install sudo
make -C /usr/ports/security/sudo ${OPTIONS} install

# install screen
make -C /usr/ports/sysutils/screen ${OPTIONS} install

# install bash
make -C /usr/ports/shells/bash ${OPTIONS} install 

# install vim
make -C /usr/ports/editors/vim-lite ${OPTIONS} install

# install moose-chunk-server
make -C /usr/ports/sysutils/moosefs-chunkserver ${OPTIONS} install 

# install modified /usr/local/etc/rc.d/mfschunkserver
install -o root -g wheel -o 755 usr/local/etc/rc.d/mfschunkserver ${USBROOT}/usr/local/etc/rc.d/mfschunkserver
install -o root -g wheel -o 644 usr/local/etc/mfschunkserver.cfg ${USBROOT}/usr/local/etc/
