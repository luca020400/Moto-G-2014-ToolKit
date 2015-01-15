@echo off
set twrp=img\twrp.img
if %1==boot goto boot
if %1==flash goto flash

echo "You have to type twrp.bat flash or boot"
goto exit

:boot
bin\fastboot.exe boot %twrp%
goto exit

:flash
bin\fastboot.exe flash recovery %twrp%
goto exit

:exit
