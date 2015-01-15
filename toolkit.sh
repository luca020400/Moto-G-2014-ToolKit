#!/bin/bash

if [ `uname -s` == "Darwin" ]; then
        fastboot=`pwd`/bin/fastboot-mac
        adb=`pwd`/bin/adb-mac
elif [ `uname -s` == "Linux" ]; then
        fastboot=`pwd`/bin/fastboot-linux
        adb=`pwd`/bin/adb-linux
else
        echo "Unsupported OS"
fi

bootloader () {
case "$1" in
        unlock)
            echo "Go to http://bit.ly/UpVtsa and read the risks, click next"
            echo "Are you sure ?? Do you know the risks ?? Are you willing to do this ??"; readline
            $fastboot oem get_unlock_data
            echo "Enter this code as shown in the example:"
            echo "Enter code on the website and press enter"; read line
            echo "Enter the key emailed to you here:"
            read code
            $fastboot oem unlock $code
            ;;

        relock)
            $fastboot lock begin
            echo "Now you have to flash the stock image"
            echo "This is an example http://forum.xda-developers.com/moto-g-2014/general/restore-to-stock-t2873657"
            echo "When done press Enter"; read line
            $fastboot oem lock
            echo "Your bootloader is now locked"
            ;;
        *)
            echo "You have to type ./bootloader.sh unlock or relock"
	    ;;
esac
}

busybox () {
$fastboot boot img/twrp.img
sleep 20
$adb push mods/busybox.zip /tmp/.
$adb shell twrp install /tmp/busybox.zip
$adb reboot-bootloader
}

disclaimer () {
cat <<EOF
/*
 * Your warranty is now void. Knox 0x1.
 *
 * I am not responsible for bricked devices, dead SD cards,
 * thermonuclear war, or you getting fired because the alarm app failed.
 * Please do some research if you have any concerns about this tool !
 * YOU are choosing to make these modifications, and if
 * you point the finger at me for messing up your device, I will laugh at you. Hard. A lot.
 */
EOF
}

logo () {
case "$1" in
        nowarning)
            $fastboot flash logo mods/logo-nowarning.bin
            ;;
        warning)
            $fastboot flash logo mods/logo-warning.bin
            ;;
        *)
            echo "You have to type ./logo.sh warnin or nowarning"
esac
}

menu () {

}

philz () {
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
}

root () {
supersu=UPDATE-SuperSU-v2.40.zip

$fastboot boot img/twrp.img
sleep 20
$adb push mods/$supersu /tmp/.
$adb shell twrp install /tmp/$supersu
$adb reboot-bootloader
}

toolkit () {
echo "*********************************"
echo "* Universal Moto G 2014 Toolkit *"
echo "*         by luca020400         *"

echo "*    Press Enter to continue    *"
echo "*     Press CTRL+c to abort     *"
echo "*********************************"
}

twrp () {
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
}

toolkit
echo
disclaimer
echo
menu
