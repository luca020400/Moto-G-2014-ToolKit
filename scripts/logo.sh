#!/bin/bash

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
