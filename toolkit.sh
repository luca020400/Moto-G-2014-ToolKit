#!/bin/bash

if command -v fastboot >/dev/null 2>&1 && command -v adb >/dev/null 2>&1; then
    fastboot=fastboot
    adb=adb
elif [ `uname -s` == "Darwin" ]; then
    fastboot=`pwd`/bin/fastboot-mac
    adb=`pwd`/bin/adb-mac
elif [ `uname -s` == "Linux" ]; then
    fastboot=`pwd`/bin/fastboot-linux
    adb=`pwd`/bin/adb-linux
else
    echo "Unsupported OS"
fi

readonly version="2.0"

toolkit () {
echo "*********************************"
echo "* Universal Moto G 2014 Toolkit *"
echo "*         by luca020400         *"
echo "*                               *"
echo "*    Press Enter to continue    *"
echo "*     Press CTRL+c to abort     *"
echo "*********************************"
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

adb () {
echo "You have to enable USB Debugging in Developer Settimgs"
echo "When done Press Enter"; read
$adb devices > /dev/null 2>&1
echo "Click 'Always allow from this computer'"
echo "And then OK"
}

menu () {
echo "Ultimate Moto G 2014 $version Menu:"
echo "[bl] Reboot to bootloader"
echo "[1] TWRP Flash"
echo "[2] TWRP Boot"
echo "[3] Philz Flash"
echo "[4] Philz Boot"
echo "[5] Root"
echo "[6] Logo Without Waring"
echo "[7] Logo With Waring"
echo "[8] Busybox"
echo "[9] Bootloader Unlock"
echo "[10] Bootloader Relock"
echo "[q] Exit"
echo
echo -n "> "
read choose
echo
case $choose in
    1 ) twrp flash;;
    2 ) twrp boot;;
    3 ) philz boot;;
    4 ) philz flash;;
    5 ) root;;
    6 ) logo nowarning;;
    7 ) logo warning;;
    8 ) busybox;;
    9 ) bootloader unlock;;
    10 ) bootloader relock;;
    q ) echo "Exiting" && sleep 1;;
    * ) echo "Error unkown Command";;
esac
}


bootloader () {
case "$1" in
    unlock)
        echo "Are you sure ?? Do you know the risks ?? Are you willing to do this ??"
        echo "If so Press Enter"; read
        echo "Go to http://bit.ly/UpVtsa and read the risks"
        sleep 2
        echo "When done press Enter"; read
        echo "Follow the guide inside the site and then"
        echo "Enter this code"
        $fastboot oem get_unlock_data
        echo "As shown in the example"
        echo "Enter the key emailed to you here :"
        read code
        $fastboot oem unlock $code
        ;;
    relock)
        $fastboot lock begin
        echo "Now you have to flash the stock image"
        echo "This is an example http://forum.xda-developers.com/moto-g-2014/general/restore-to-stock-t2873657"
        echo "When done press Enter"; read
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
supersu=UPDATE-SuperSU-v2.46.zip

$fastboot boot img/twrp.img
sleep 20
$adb push mods/$supersu /tmp/.
$adb shell twrp install /tmp/$supersu
$adb reboot-bootloader
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
adb
echo
menu
