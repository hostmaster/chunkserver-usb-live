#!/bin/sh
#

export USBROOT=/USBROOT 
export SRC=/usr/src 


files=`find -E ./build.d -type f  -not -regex '.*(#|~|.bck)$' | sort -n`
for stage in ${files}
do
	${stage}
	if [ $? -ne 0 ]; then
		exit 1
	fi
done
