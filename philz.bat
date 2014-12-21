@echo off
if %1==boot goto fai_boot
if %1==flash goto fai_flash

echo "You have to type philz.bat flash or boot"
goto esci

:fai_boot
bin\fastboot.exe boot img\philz.img
goto esci

:fai_flash
bin\fastboot.exe flash recovery img\philz.img

:esci