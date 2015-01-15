#!/bin/bash

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
