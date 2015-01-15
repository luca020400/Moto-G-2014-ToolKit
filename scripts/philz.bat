@echo off
if %1==boot goto boot
if %1==flash goto flash

echo "You have to type philz.bat flash or boot"
goto exit

:boot
bin\fastboot.exe boot img\philz.img
goto exit

:flash
bin\fastboot.exe flash recovery img\philz.img
goto exit

:exit