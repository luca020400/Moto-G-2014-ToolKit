#!/bin/bash

hasAndroidInstalled() {
  command -v adb >/dev/null 2>&1 && command -v fastboot >/dev/null 
}

if hasAndroidInstalled; then
  adb=adb
  fastboot=fastboot
elif [ `uname -s` == "Darwin" ]; then
  adb=bin/adb-mac
  fastboot=bin/fastboot-mac
elif [ `uname -s` == "Linux" ]; then
  adb=bin/adb-linux
  fastboot=bin/fastboot-linux
else
  echo "Unsupported OS"
fi

supersu=UPDATE-SuperSU-v2.46.zip

$fastboot boot img/twrp.img
sleep 20
$adb push mods/$supersu /tmp/.
$adb shell twrp install /tmp/$supersu
$adb reboot-bootloader
