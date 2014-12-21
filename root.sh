#!/bin/bash
if [ `uname -s` == "Darwin" ]; then
        fastboot=bin/fastboot-mac
elif [ `uname -s` == "Linux" ]; then
        fastboot=bin/fastboot-linux
else
        echo "Unsupported OS"
fi
case "$1" in
        titan_retaildsds)
            $fastboot boot autoroot/titan_retaildsds.img
            ;;
        titan_retde)
            $fastboot boot autoroot/titan_retde.img
            ;;
        titan_retuglb)
            $fastboot boot autoroot/titan_retuglb.img
            ;;
	titan_*)
	    echo "Unsupported Device"
	    ;;
        *)
            echo "You have to type ./root.sh device ( titan_ret*** )"
esac
