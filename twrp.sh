#!/bin/bash

if [ `uname -s` == "Darwin" ]; then
        fastboot=bin/fastboot-mac
elif [ `uname -s` == "Linux" ]; then
        fastboot=bin/fastboot-linux
else
        echo "Unsupported OS"
fi

twrp=img/twrp.img

case "$1" in
        boot)
            $fastboot boot $twrp
            ;;

        flash)
            $fastboot flash recovery $twrp
            ;;
        *)
            echo "You have to type ./twrp.sh flash or boot"
esac
