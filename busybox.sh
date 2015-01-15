#!/bin/bash

if [ `uname -s` == "Darwin" ]; then
	adb=bin/adb-linux
        fastboot=bin/fastboot-mac
elif [ `uname -s` == "Linux" ]; then
	adb=bin/adb-linux
        fastboot=bin/fastboot-linux
else
        echo "Unsupported OS"
fi

$fastboot boot img/twrp.img
sleep 20
$adb push mods/busybox.zip /tmp/.
$adb shell twrp install /tmp/busybox.zip
$adb reboot-bootloader
