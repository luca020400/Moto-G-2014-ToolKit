@echo off
if %1==boot goto fai_boot
if %1==flash goto fai_flash

echo "You have to type twrp.bat flash or boot"
goto esci

:fai_boot
bin\fastboot.exe boot img\twrp.img
goto esci

:fai_flash
bin\fastboot.exe flash recovery img\twrp.img

:esci