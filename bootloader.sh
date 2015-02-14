#!/bin/bash

if command -v fastboot >/dev/null 2>&1; then
  fastboot=fastboot
elif [ `uname -s` == "Darwin" ]; then
  fastboot=bin/fastboot-mac
elif [ `uname -s` == "Linux" ]; then
  fastboot=bin/fastboot-linux
else
  echo "Unsupported OS"
fi

case "$1" in
  unlock)
    echo "Go to http://bit.ly/UpVtsa and read the risks, click next"; read line
    echo "Are you sure ?? Do you know the risks ?? Are you willing to do this ??"; read line
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
esac
