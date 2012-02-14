#!/bin/sh
#

if [ -z "${USBROOT}" ]; then
	echo "ERROR: USBROOT is not defined. Exiting"
	exit 1
fi

# root
echo "passwd" | pw usermod  root -V ${USBROOT}/etc -h 0

# add admin user
echo "adminpass" | pw -V ${USBROOT}/etc useradd admin1 \
	-d /home/admin1 -m \
	-G wheel \
	-c "Admin user"\
	-s /usr/local/bin/bash \
	-h 0 

# install admin's homedir skelet
mkdir -p ${USBROOT}/usr/users/admin1

for file in dot.cshrc dot.login dot.login_conf dot.mail_aliases dot.mailrc dot.profile dot.rhosts dot.shrc
do
	`echo $file | sed s/dot//` 
	install -o admin1  -g admin1 -m 644  usr/users/admin1/$file ${USBROOT}/usr/users/admin1/`echo $file | sed s/dot//`
done

chroot ${USBROOT} chown admin1:admin1 /usr/users/admin1
