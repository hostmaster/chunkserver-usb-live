#!/bin/sh

export USBROOT=/USBROOT 
export SRC=/usr/src 


files=`find -E ./build.d -type f  -not -regex '.*(#|~|.bck)$'`
for stage in ${files}
do
	${stage}

done
