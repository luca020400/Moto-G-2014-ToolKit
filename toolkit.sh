#!/bin/bash

if [ `uname -s` == "Darwin" ]; then
        export fastboot=`pwd`/bin/fastboot-mac
        export adb=`pwd`/bin/adb-mac
elif [ `uname -s` == "Linux" ]; then
        export fastboot=`pwd`/bin/fastboot-linux
        export adb=`pwd`/bin/adb-linux
else
        echo "Unsupported OS"
fi
