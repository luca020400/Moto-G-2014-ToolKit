#!/bin/bash

setup () {
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

log_file=".log_toolkit"
supersuver="2.46"
supersuzip="UPDATE-SuperSU-v$supersuver.zip"
twrp="openrecovery-twrp-2.8.5.0-titan.img"
version="2.1"

touch $log_file
}

toolkit () {
echo "Universal Moto G 2014 Toolkit"
echo "By luca020400"
echo "Version $version"
echo
echo "Press Enter to continue"
echo "Press CTRL+c to abort";read
}

disclaimer () {
if ! cat $log_file | grep "disclaimer=true" >/dev/null 2>&1; then
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
echo "If you agree Press Enter"; read
echo "disclaimer=true" >> $log_file
fi
}

adb_authorization () {
if ! cat $log_file | grep "adb=true" >/dev/null 2>&1; then
if ! $fastboot devices | grep "fastboot" > /dev/null 2>&1; then
echo "You have to enable USB Debugging in Developer Settings"
echo "When done Press Enter"; read
echo "Click 'Always allow from this computer'"
echo "And then OK"
echo "When done Press Enter"
$adb "wait-for-device" > /dev/null 2>&1
read
if $adb devices | grep "device" > /dev/null 2>&1; then
echo "adb=true" >> $log_file
fi
fi
fi
}

menu () {
echo "Universal Moto G 2014 Toolkit Menu:"
echo "[rb] Reboot to Bootloader from Phone"
echo "[rp] Reboot to Phone from Bootloader"
echo "[rr] Reboot to Recovery from Phone"
echo "[1] TWRP 2.8.5.0 Flash"
echo "[2] TWRP 2.8.5.0 Boot"
echo "[3] Philz Flash"
echo "[4] Philz Boot"
echo "[5] Root with SuperSU $supersuver"
echo "[6] Logo Without Warning"
echo "[7] Logo With Warning"
echo "[8] Busybox Installer"
echo "[9] Bootloader Unlock"
echo "[10] Bootloader Relock"
if [ `uname -s` == "Linux" ]; then
if ! cat $log_file | grep "udev_rules=true" >/dev/null 2>&1; then
echo "[ur] Add Android Udev Rules"
fi
fi
echo "[q] Exit"
echo
echo -n "> "
read choice
echo
case $choice in
    rb ) $adb "wait-for-device" reboot-bootloader > /dev/null 2>&1;;
    rp ) $fastboot reboot > /dev/null 2>&1;;
    rr ) $adb "wait-for-device" reboot recovery > /dev/null 2>&1;;
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
    ur ) udev_rules;;
    q ) echo "Exiting" && sleep 1 && break;;
    * ) echo "Error Unknown Command";;
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
esac
}

busybox () {
$fastboot boot img/$twrp.img
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
esac
}

root () {
$fastboot boot img/$twrp.img
sleep 20
$adb push mods/$supersuzip /tmp/.
$adb shell twrp install /tmp/$supersuzip
$adb reboot-bootloader
}


twrp () {
case "$1" in
    boot)
        $fastboot boot img/$twrp.img
        ;;
    flash)
        $fastboot flash recovery img/$twrp.img
        ;;
esac
}

udev_rules () {
echo "Fix the issue described here https://github.com/luca020400/Moto-G-2014-ToolKit/issues/1"
echo "You need sudo permission"
echo "Press Enter to continue"; read
sudo rm -rf /etc/udev/rules.d/51-android.rules
sudo curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L http://luca020400.altervista.org/stuff/51-android.rules > /dev/null 2>&1
sudo udevadm control --reload-rules
echo "Added Android Udev Rules"
echo udev_rules=true >> $log_file
}

setup
clear
toolkit
disclaimer
adb_authorization
while true; do
menu
sleep 1.5
clear
done
