#!/bin/sh

if [ -z "${USBROOT}" -o -z "${SRC}" ]; then
	echo "ERROR: USBROOT or SRC is not defined. Exiting"
	exit 1
fi

make -C $SRC DESTDIR=$USBROOT installkernel
make -C $SRC DESTDIR=$USBROOT installworld

make -C $SRC/etc DESTDIR=$USBROOT distrib-dirs
make -C $SRC/etc DESTDIR=$USBROOT distribution


# generate ssh server key

/usr/bin/ssh-keygen -t rsa1 -b 1024 -f ${USBROOT}/etc/ssh/ssh_host_key -N ''
/usr/bin/ssh-keygen -t dsa          -f ${USBROOT}/etc/ssh/ssh_host_dsa_key -N ''
/usr/bin/ssh-keygen -t rsa          -f ${USBROOT}/etc/ssh/ssh_host_rsa_key -N ''
/usr/bin/ssh-keygen -t ecdsa        -f ${USBROOT}/etc/ssh/ssh_host_ecdsa_key -N ''

#
# install client public keys
#

# /etc/resolv.conf links
ln -s /tmp/resolv.conf ${USBROOT}/etc/resolv.conf
echo touch /tmp/resolv.conf ${USBROOT}/etc/rc

# install rc.conf
install -o root -g wheel -m 644 etc/rc.conf etc/crontab ${USBROOT}/etc 
install -o root -g wheel -m 755 etc/rc.d/home ${USBROOT}/etc/rc.d
install -o root -g wheel -m 644 boot/loader.conf ${USBROOT}/boot
mkdir -p ${USBROOT}/usr/local/etc
install -o root -g wheel -m 440 usr/local/etc/sudoers ${USBROOT}/usr/local/etc

# lock-unlock
install -o root -g wheel -m 756 bin/unlock-server bin/lock-server  ${USBROOT}/bin

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
