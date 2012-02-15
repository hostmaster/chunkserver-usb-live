#!/bin/sh

PORTS="sysutils/screen shells/bash editors/vim-lite sysutils/moosefs-chunkserver"

if [ -z "${USBROOT}" -o -z "${SRC}" ]; then
	echo "ERROR: USBROOT or SRC is not defined. Exiting"
	exit 1
fi

# install/generate options files
for file in ports/sudo/options ports/libiconv/options ports/screen/options ports/m4/options
do
	mkdir -p ${USBROOT}/var/db/`dirname ${file}`
	install -o root -g wheel -m 644 ${file} ${USBROOT}/var/db/${file}
done

OPTIONS="WITHOUT_IPV6=yes WITHOUT_AUDIT=yes WITHOUT_NLS=yes WITHOUT_LDAP=yes BATCH=yes DESTDIR=${USBROOT}"

# install 3-th side software 
for port in ${PORTS}
do

	make -C /usr/ports/${port} fetch-recursive
	make -C /usr/ports/${port} ${OPTIONS} install clean

	if [ $? -ne 0 ]; then
		echo "Build FAILED"
		exit 1
	fi
done

# install modified /usr/local/etc/rc.d/mfschunkserver
install -o root -g wheel -o 755 usr/local/etc/rc.d/mfschunkserver ${USBROOT}/usr/local/etc/rc.d/mfschunkserver
install -o root -g wheel -o 644 usr/local/etc/mfschunkserver.cfg ${USBROOT}/usr/local/etc/
