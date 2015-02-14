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
  nowarning)
    $fastboot flash logo mods/logo-nowarning.bin
    ;;
  warning)
    $fastboot flash logo mods/logo-warning.bin
    ;;
  *)
    echo "You have to type ./logo.sh warnin or nowarning"
esac
