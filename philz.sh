#!/bin/bash
if [ `uname -s` == "Darwin" ]; then
	fastboot=bin/fastboot-mac
else
	fastboot=bin/fastboot-linux
fi
case "$1" in
        boot)
            $fastboot boot img/philz.img
            ;;

        flash)
            $fastboot flash recovery img/philz.img
            ;;
        *)
            echo "You have to type ./philz.sh flash or boot"
esac
