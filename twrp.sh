#!/bin/bash
if [ `uname -s` == "Darwin" ]; then
	fastboot=bin/fastboot-mac
else
	fastboot=bin/fastboot-linux
fi
case "$1" in
        boot)
            $fastboot boot img/twrp.img
            ;;

        flash)
            $fastboot flash recovery img/twrp.img
            ;;
        *)
            echo "You have to type ./twrp.sh flash or boot"
esac
