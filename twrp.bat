@echo off
if %1==boot goto boot
if %1==flash goto flash

echo "You have to type twrp.bat flash or boot"
goto exit

:boot
bin\fastboot.exe boot img\twrp.img
goto exit

:flash
bin\fastboot.exe flash recovery img\twrp.img
goto exit

:exit